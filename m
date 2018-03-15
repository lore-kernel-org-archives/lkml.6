Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeCORIx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:08:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38544 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751466AbeCORIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:08:50 -0400
Message-ID: <1521133728.5348.51.camel@HansenPartnership.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 15 Mar 2018 10:08:48 -0700
In-Reply-To: <1521130749.3547.608.camel@linux.vnet.ibm.com>
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
         <1521048306.4508.56.camel@HansenPartnership.com>
         <1521130749.3547.608.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 12:19 -0400, Mimi Zohar wrote:
> On Wed, 2018-03-14 at 10:25 -0700, James Bottomley wrote:
> > 
> > On Wed, 2018-03-14 at 13:08 -0400, Mimi Zohar wrote:
> [..]
> > 
> > > 
> > > Adding additional support for post IMA-initialization for TPM's
> > > built as kernel modules is clearly not optimal for all of the
> > > reasons provided to now and will be confusing, but could be
> > > supported.  This delayed loading of the TPM needs to be clearly
> > > indicated in both the audit log and in IMA's measurement list.
> > 
> > Why if the measurement chain isn't broken?  The way I'm thinking of
> > implementing it, IMA wouldn't even know.
> 
> I'm not sure this is good news.
> 
> > What would happen is that a NULL tpm chip in
> > tpm_pcr_read/tpm_pcr_extend would trigger the usual
> > search for the first TPM but if none were found and we'd booted on
> > an EFI system, we'd just use the EFI driver to do perform the
> > operation.
> 
> If EFI is extending the TPM, will the events be added to the TPM
> event log or to the IMA measurement list?

I'm not proposing any changes to the tpm_pcr_extend API.  At the moment
it does an extend without logging, so that's what it will do in the EFI
driver case as well.  That means logging is still the responsibility of
the caller.

>    Up to now the IMA boot aggregate record includes PCRs from 0 - 7.
>  With these PCRs, the boot aggregate wouldn't change when booting the
> same kernel.  Would you change the boot-aggregate to include these
> other PCRs?

This is all IMA internal stuff that's up to you.  All I would do is
make the tpm_pcr API work with an EFI driver.  That has no impact on
what the PCRs return (well, unless we start using it to log early
components of the kernel boot, which is a possibility).

> > There's probably a bit of additional subtlety making the kernel and
> > EFI agree which TPM they're using in a multi-TPM situation.
> 
> Agreed
> 
> > 
> > The EFI driver isn't full featured: it only does measurement and
> > logging, but it looks like that's all IMA needs.
> 
> What happens for non EFI systems, when you can't extend the TPM?

The same as happens today if there's no TPM available: you'd get an
error return.  Since older bios is essentially legacy, I wouldn't
propose fixing this, but the TCG does define a non-EFI BIOS interface
which could theoretically be used in the same way as the BIOS one if
someone with a legacy box were interested in implementing it.

James
