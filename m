Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeCGSvl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:51:41 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44164 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbeCGSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:51:39 -0500
X-Google-Smtp-Source: AG47ELst7VfglUfaWNwSlwaj3ywS2rvY6r+pb/XbDVoHjsxc7ELUNPoOf9NeTuZ2ClLvqpppOJl2PQ==
Date: Wed, 7 Mar 2018 11:51:32 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiandi An <anjiandi@codeaurora.org>
Cc: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
Message-ID: <20180307185132.GA30102@ziepe.ca>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 11:26:26PM -0600, Jiandi An wrote:
> TPM_CRB driver is the TPM support for ARM64.  If it
> is built as module, TPM chip is registered after IMA
> init.  tpm_pcr_read() in IMA driver would fail and
> display the following message even though eventually
> there is TPM chip on the system:
> 
> ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> 
> Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
> built in kernel and initializes before IMA driver.
> 
> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
>  security/integrity/ima/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 35ef693..6a8f677 100644
> +++ b/security/integrity/ima/Kconfig
> @@ -10,6 +10,7 @@ config IMA
>  	select CRYPTO_HASH_INFO
>  	select TCG_TPM if HAS_IOMEM && !UML
>  	select TCG_TIS if TCG_TPM && X86
> +	select TCG_CRB if TCG_TPM && ACPI
>  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
>  	help
>  	  The Trusted Computing Group(TCG) runtime Integrity

This seems really weird, why are any specific TPM drivers linked to
IMA config, we have lots of drivers..

I don't think I've ever seen this pattern in Kconfig before?

Jason
