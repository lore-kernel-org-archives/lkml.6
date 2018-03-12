Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeCLWav (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:30:51 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47974 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751377AbeCLWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:30:49 -0400
Message-ID: <1520893847.4522.62.camel@HansenPartnership.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Safford <david.safford@ge.com>
Date: Mon, 12 Mar 2018 15:30:47 -0700
In-Reply-To: <1520891598.3547.190.camel@linux.vnet.ibm.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 17:53 -0400, Mimi Zohar wrote:
> On Fri, 2018-03-09 at 09:11 -0800, James Bottomley wrote:
> > 
> > On Thu, 2018-03-08 at 12:42 -0600, Jiandi An wrote:
> > [...]
> > > 
> > > I'm no expert on IMA and its driver.  James, will you be kind
> > > enough to look into overhauling the IMA driver to not measure
> > > until after initrd phase if that's the consensus on resolving
> > > this?
> > 
> > I'll add it to my todo list.
> > 
> > Since my TPM 2.0 test environment is a VM with a tpm that has a
> > network connection to an emulator on my host, it's impossible to
> > set it up so that it's built in (because you need the network
> > config before you init the TPM) so I might accelerate if I suddenly
> > need to debug IMA issues in this configuration.
> 
> There are a number of different issues being discussed.
> 
> - When IMA is enabled, unlike some other TPM device drivers, the TPM
> 2.0 is not forced to be builtin.
> 
> This is addressed by Jiandi's patch.
> 
> - Jason's comment questioning having Kconfig force the TPM to be
> builtin.
> 
> Using Kconfig to force the TPM to be builtin is not required, but
> helpful.  Users interested in IMA-measurement could configure the TPM
> as builtin themselves.  Without the TPM builtin, IMA goes into TPM-
> bypass mode.
> 
> Extending a TPM with IMA measurements, which was not builtin, but
> loaded at some unspecified point in time, changes the existing
> meaning of the IMA-measurement list.
> 
> - This use case, when the TPM is not builtin and unavailable before
> IMA is initialized.
> 
> I would classify this use case as an IMA testing/debugging
> environment, when it cannot, for whatever reason, be builtin the
> kernel or initialized before IMA.
> 
> From Dave Safford:
>     For the TCG chain of trust to have any meaning, all files have to
>     be measured and extended into the TPM before they are accessed.
> If
>     the TPM driver is loaded after any unmeasured file, the chain is
>     broken, and IMA is useless for any use case or any threat model.

I don't think this is quite the correct characterisation.  In principle
the kernel could also touch the files before IMA is loaded.  However,
we know from the way the kernel operates that it doesn't.  We basically
trust that the kernel measurement tells us this.  The same thing can be
made to apply to the initrd.

The key question is not whether the component could theoretically
access the files but whether it actually does so.

>     While the initramfs may be measured by the bootloader, there are
>     two problems:
>     1. IMA has no way of knowing if the kernel or initramfs has
>     accessed any unmeasured files before TPM driver loading and IMA
>     initialization.
>     2. Even if we can somehow guarantee that nothing outside the
>     initramfs has been accessed prior to IMA initialization, it is
>     difficult if not impossible for the attestation server to know
> what
>     a good initramfs measurement should be, as the initramfs is built
>     on the suspect device in the first place.  We can sort of trust
> the
>     initramfs measurement in the reference manifest,

If I don't trust the initrd then I also can't really make much of IMA
measurements because the chain of custody is broken.  The assertion
that the initrd has to be part of the chain of custody is really a
statement of the current position.  Therefore if the initrd is part of
that chain, then we don't have to start IMA at kernel init, we can
start it at initrd pivot_root.  (or to put it in simple terms: IMA
measurements of the root filesystem, even if they begin at kernel init,
cannot make up for a malicious initrd because the damage will already
have been done before we pivot to the real root).

In theory the build device shouldn't be suspect because it was measured and appraised before I built my initrd on it.

>  but after that,
>     the attestation server has no way to trust a reported initramfs
>     measurement.

This is more a reflection of problems in the current attestation
architecture and measurement gaps we have.  We certainly know what the
initrd measurement should be when we create it, so the expected value
can be communicated to the attestation server when the initrd is built.

Conversely, if the attestation server doesn't measure the initrd this
is a current gap in the attestation of the custody chain because any
problem with the initrd would go undetected.

James
