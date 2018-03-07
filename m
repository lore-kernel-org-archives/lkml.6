Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeCGTVs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:21:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754039AbeCGTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:21:46 -0500
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jiandi An <anjiandi@codeaurora.org>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Mar 2018 14:21:35 -0500
In-Reply-To: <1520449719.5558.28.camel@HansenPartnership.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030719-0008-0000-0000-000004D90B7B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030719-0009-0000-0000-00001E6C2844
Message-Id: <1520450495.10396.587.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 11:08 -0800, James Bottomley wrote:
> On Wed, 2018-03-07 at 13:55 -0500, Mimi Zohar wrote:
> > On Wed, 2018-03-07 at 11:51 -0700, Jason Gunthorpe wrote:
> > > 
> > > On Tue, Mar 06, 2018 at 11:26:26PM -0600, Jiandi An wrote:
> > > > 
> > > > TPM_CRB driver is the TPM support for ARM64.  If it
> > > > is built as module, TPM chip is registered after IMA
> > > > init.  tpm_pcr_read() in IMA driver would fail and
> > > > display the following message even though eventually
> > > > there is TPM chip on the system:
> > > > 
> > > > ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> > > > 
> > > > Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
> > > > built in kernel and initializes before IMA driver.
> > > > 
> > > > Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
> > > >  security/integrity/ima/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/security/integrity/ima/Kconfig
> > > > b/security/integrity/ima/Kconfig
> > > > index 35ef693..6a8f677 100644
> > > > +++ b/security/integrity/ima/Kconfig
> > > > @@ -10,6 +10,7 @@ config IMA
> > > >  	select CRYPTO_HASH_INFO
> > > >  	select TCG_TPM if HAS_IOMEM && !UML
> > > >  	select TCG_TIS if TCG_TPM && X86
> 
> Well, this explains why IMA doesn't work on one of my X86 systems: it's
> got a non i2c infineon TPM.
> 
> > > > +	select TCG_CRB if TCG_TPM && ACPI
> > > >  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
> > > >  	help
> > > >  	  The Trusted Computing Group(TCG) runtime Integrity
> > > 
> > > This seems really weird, why are any specific TPM drivers linked to
> > > IMA config, we have lots of drivers..
> > > 
> > > I don't think I've ever seen this pattern in Kconfig before?
> > 
> > As you've seen by the current discussions, the TPM driver needs to be
> > initialized prior to IMA.  Otherwise IMA goes into TPM-bypass mode.
> >  That implies that the TPM must be builtin to the kernel, and not as
> > a kernel module.
> 
> Actually, that's not necessarily true:  If we don't begin appraisal
> until after the initrd phase, then the initrd can load TPM modules
> before IMA starts.
> 
> This would involve a bit of code rejigging to not require a TPM until
> IMA wants to write its first measurement, but it looks doable and would
> get us out of having to second guess TPM selections.

The question is about measurement, not appraisal.  Although the
initramfs might be measured, the initramfs can access files on the
real root filesystem.  Those files need to be measured, before they
are used/accessed.

Mimi
