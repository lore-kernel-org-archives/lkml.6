Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeCGTIo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:08:44 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51268 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754333AbeCGTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:08:42 -0500
Message-ID: <1520449719.5558.28.camel@HansenPartnership.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiandi An <anjiandi@codeaurora.org>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Mar 2018 11:08:39 -0800
In-Reply-To: <1520448953.10396.565.camel@linux.vnet.ibm.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 13:55 -0500, Mimi Zohar wrote:
> On Wed, 2018-03-07 at 11:51 -0700, Jason Gunthorpe wrote:
> > 
> > On Tue, Mar 06, 2018 at 11:26:26PM -0600, Jiandi An wrote:
> > > 
> > > TPM_CRB driver is the TPM support for ARM64.  If it
> > > is built as module, TPM chip is registered after IMA
> > > init.  tpm_pcr_read() in IMA driver would fail and
> > > display the following message even though eventually
> > > there is TPM chip on the system:
> > > 
> > > ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> > > 
> > > Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
> > > built in kernel and initializes before IMA driver.
> > > 
> > > Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
> > >  security/integrity/ima/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/security/integrity/ima/Kconfig
> > > b/security/integrity/ima/Kconfig
> > > index 35ef693..6a8f677 100644
> > > +++ b/security/integrity/ima/Kconfig
> > > @@ -10,6 +10,7 @@ config IMA
> > >  	select CRYPTO_HASH_INFO
> > >  	select TCG_TPM if HAS_IOMEM && !UML
> > >  	select TCG_TIS if TCG_TPM && X86

Well, this explains why IMA doesn't work on one of my X86 systems: it's
got a non i2c infineon TPM.

> > > +	select TCG_CRB if TCG_TPM && ACPI
> > >  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
> > >  	help
> > >  	  The Trusted Computing Group(TCG) runtime Integrity
> > 
> > This seems really weird, why are any specific TPM drivers linked to
> > IMA config, we have lots of drivers..
> > 
> > I don't think I've ever seen this pattern in Kconfig before?
> 
> As you've seen by the current discussions, the TPM driver needs to be
> initialized prior to IMA.  Otherwise IMA goes into TPM-bypass mode.
>  That implies that the TPM must be builtin to the kernel, and not as
> a kernel module.

Actually, that's not necessarily true:  If we don't begin appraisal
until after the initrd phase, then the initrd can load TPM modules
before IMA starts.

This would involve a bit of code rejigging to not require a TPM until
IMA wants to write its first measurement, but it looks doable and would
get us out of having to second guess TPM selections.

James
