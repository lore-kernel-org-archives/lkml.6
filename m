Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeCNRZL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:25:11 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54512 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbeCNRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:25:08 -0400
Message-ID: <1521048306.4508.56.camel@HansenPartnership.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-ima-devel@lists.sourceforge.net"
        <linux-ima-devel@lists.sourceforge.net>,
        "linux-ima-user@lists.sourceforge.net"
        <linux-ima-user@lists.sourceforge.net>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 14 Mar 2018 10:25:06 -0700
In-Reply-To: <1521047286.3547.470.camel@linux.vnet.ibm.com>
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
         <1520899605.4522.67.camel@HansenPartnership.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C002367FEF@ALPMBAPA12.e2k.ad.ge.com>
         <1521038471.4508.25.camel@HansenPartnership.com>
         <1521047286.3547.470.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 13:08 -0400, Mimi Zohar wrote:
> On Wed, 2018-03-14 at 07:41 -0700, James Bottomley wrote:
[...]
> > What about a compromise: we
> > already get the boot loader to do measurements and PCR extensions
> > using the BIOS TPM driver, there's no reason why we can't do the
> > same in the early kernel until a real TPM driver is found.
> 
> Your proposal requires changes to the existing boot loaders, not all
> of which are X86 based.

I don't believe it does, see below.

>   Grub, to the best of my knowledge, is not interested in having
> anything to do with TPM based measurements.  Many attempts have been
> made to upstream trusted boot patches, but none have been accepted. 

Just for the sake of accuracy, even though it has nothing to do with
the current proposal, grub does actually measure the booting
components.  It does this via a shim protocol trick, so when grub
passes the kernel to shim to verify the signature, shim also stores its
measurement in the TPM boot log.

>  Any support would need to piggyback on the callback hooks introduced
> for secure boot and then be carried by the distros.

Right, that's how it does actually work today.

This is more or less what made me think of the compromise: the way shim
does measurements is using the EFI TPM protocol.  Although this is
technically a boot time UEFI driver, we can make it serve us until
we're ready to load the real TPM driver, so we could write measurements
to a PCR without any kernel drivers loaded.

> As for Linux based boot loaders, the driver needs to be builtin for
> these measurements.  So this wouldn't help you.
> 
> > 
> > That way IMA would have no dependency on any built in TPM driver
> > ... is that an acceptable compromise to everyone?
> 
> Adding additional support for post IMA-initialization for TPM's built
> as kernel modules is clearly not optimal for all of the reasons
> provided to now and will be confusing, but could be supported.  This
> delayed loading of the TPM needs to be clearly indicated in both the
> audit log and in IMA's measurement list.

Why if the measurement chain isn't broken?  The way I'm thinking of
implementing it, IMA wouldn't even know.  What would happen is that a
NULL tpm chip in tpm_pcr_read/tpm_pcr_extend would trigger the usual
search for the first TPM but if none were found and we'd booted on an
EFI system, we'd just use the EFI driver to do perform the operation.

There's probably a bit of additional subtlety making the kernel and EFI
agree which TPM they're using in a multi-TPM situation.

The EFI driver isn't full featured: it only does measurement and
logging, but it looks like that's all IMA needs.

James

> In terms of attestation, if a measurement policy is enabled before
> the TPM is loaded, any records up to the delayed TPM entry in the IMA
> measurement list would need to be ignored.
> 
> In addition, your changes should not in any way change the existing
> IMA-measurement initialization.
> 
> Mimi
> 
