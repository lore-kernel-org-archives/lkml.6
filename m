Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06860ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48CB214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48CB214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJTJR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:17:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:3360 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbeJTJR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:17:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 18:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,402,1534834800"; 
   d="scan'208";a="272868917"
Received: from kskibin-mobl.ger.corp.intel.com ([10.249.254.29])
  by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2018 18:09:15 -0700
Date:   Sat, 20 Oct 2018 04:09:13 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Tomas Winkler <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 13/21] tpm: add tpm_auto_startup() into
 tpm-interface.c
In-Reply-To: <20181019182307.17745-14-tomas.winkler@intel.com>
Message-ID: <alpine.DEB.2.21.1810200408350.9963@jsakkine-mobl1>
References: <20181019182307.17745-1-tomas.winkler@intel.com> <20181019182307.17745-14-tomas.winkler@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018, Tomas Winkler wrote:
> Add wrapper tpm_auto_startup() to tpm-interface.c
> instead of open coded decision between TPM 1.x and TPM 2.x
> in tpm-chip.c
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V3: New in the series.
> V4: Fix the commit message.
> V5-7: Resend.
>
> drivers/char/tpm/tpm-chip.c      | 11 +++--------
> drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
> drivers/char/tpm/tpm.h           |  1 +
> 3 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 46caadca916a..32db84683c40 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -451,14 +451,9 @@ int tpm_chip_register(struct tpm_chip *chip)
> {
> 	int rc;
>
> -	if (chip->ops->flags & TPM_OPS_AUTO_STARTUP) {
> -		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -			rc = tpm2_auto_startup(chip);
> -		else
> -			rc = tpm1_auto_startup(chip);
> -		if (rc)
> -			return rc;
> -	}
> +	rc = tpm_auto_startup(chip);
> +	if (rc)
> +		return rc;
>
> 	tpm_sysfs_add_device(chip);
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 54b81700561b..69e007a198ce 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -545,6 +545,21 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
> }
> EXPORT_SYMBOL_GPL(tpm_send);
>
> +int tpm_auto_startup(struct tpm_chip *chip)
> +{
> +	int rc;
> +
> +	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
> +		return 0;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		rc = tpm2_auto_startup(chip);
> +	else
> +		rc = tpm1_auto_startup(chip);
> +
> +	return rc;
> +}
> +
> /*
>  * We are about to suspend. Save the TPM state
>  * so that it can be restored.
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2eb73f6966c3..daca1d0190b1 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -541,6 +541,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
> 			 size_t min_rsp_body_length, unsigned int flags,
> 			 const char *desc);
> int tpm_get_timeouts(struct tpm_chip *);
> +int tpm_auto_startup(struct tpm_chip *chip);
>
> int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
> int tpm1_auto_startup(struct tpm_chip *chip);
> -- 
> 2.14.4
>
>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
