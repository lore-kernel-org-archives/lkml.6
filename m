Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCMAGu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:06:50 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48638 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751333AbeCMAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:06:48 -0400
Message-ID: <1520899605.4522.67.camel@HansenPartnership.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Safford <david.safford@ge.com>
Date: Mon, 12 Mar 2018 17:06:45 -0700
In-Reply-To: <1520897400.3547.253.camel@linux.vnet.ibm.com>
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
         <1520893847.4522.62.camel@HansenPartnership.com>
         <1520897400.3547.253.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 19:30 -0400, Mimi Zohar wrote:
> On Mon, 2018-03-12 at 15:30 -0700, James Bottomley wrote:
> > 
> > On Mon, 2018-03-12 at 17:53 -0400, Mimi Zohar wrote:
> [...]
> > 
> > > 
> > > - This use case, when the TPM is not builtin and unavailable
> > > before
> > > IMA is initialized.
> > > 
> > > I would classify this use case as an IMA testing/debugging
> > > environment, when it cannot, for whatever reason, be builtin the
> > > kernel or initialized before IMA.
> > > 
> > > From Dave Safford:
> > >     For the TCG chain of trust to have any meaning, all files
> > > have to
> > >     be measured and extended into the TPM before they are
> > > accessed.
> > > If
> > >     the TPM driver is loaded after any unmeasured file, the chain
> > > is
> > >     broken, and IMA is useless for any use case or any threat
> > > model.
> > 
> > I don't think this is quite the correct characterisation.  In
> > principle the kernel could also touch the files before IMA is
> > loaded.  However, we know from the way the kernel operates that it
> > doesn't.  We basically trust that the kernel measurement tells us
> > this.  The same thing can be made to apply to the initrd.
> 
> With the builtin "tcb" policy, IMA-measurement is enabled from the
> very beginning.  Afterwards, the system can transition to a custom
> policy based on finer grain LSM labels, which aren't available on
> boot.
> 
> > 
> > The key question is not whether the component could theoretically
> > access the files but whether it actually does so.
> 
> As much as you might think you know what is included in the
> initramfs, IMA-measurement is your safety net, including everything
> accessed in the TCB.

The initrd *is* part of the Trusted Computing Base because it's part of
the boot custody chain.  That's really my point.  If I don't know
what's in my initrd, I've broken the chain there and IMA can't fix it.

James
