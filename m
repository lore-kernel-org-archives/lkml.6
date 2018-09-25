Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADC1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB1020676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB1020676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbeIYUjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:39:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:26675 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbeIYUjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:39:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="75792810"
Received: from thomasvo-mobl2.ger.corp.intel.com ([10.252.53.212])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2018 07:31:08 -0700
Message-ID: <8fff0ded33cf5b012eff398161a09af013b02d41.camel@linux.intel.com>
Subject: Re: [PATCH v4 10/21] tpm: factor out tpm 1.x pm suspend flow into
 tpm1-cmd.c
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Sep 2018 17:31:07 +0300
In-Reply-To: <20180921135820.20549-11-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-11-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> Factor out TPM 1.x suspend flow from tpm-interface.c into a new function
> tpm1_pm_suspend() in tpm1-cmd.c
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2-V3: Rebase
> V4: 1. Add kdoc for tpm1_pm_suspend().
>     2. Fix commit message.
> 
>  drivers/char/tpm/tpm-interface.c | 55 ++++---------------------------------
>  drivers/char/tpm/tpm.h           |  1 +
>  drivers/char/tpm/tpm1-cmd.c      | 59
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 7239ccc16e2f..dfa972bbdd81 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -585,15 +585,6 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t
> buflen)
>  }
>  EXPORT_SYMBOL_GPL(tpm_send);
>  
> -#define TPM_ORD_SAVESTATE 152
> -#define SAVESTATE_RESULT_SIZE 10
> -
> -static const struct tpm_input_header savestate_header = {
> -	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> -	.length = cpu_to_be32(10),
> -	.ordinal = cpu_to_be32(TPM_ORD_SAVESTATE)
> -};
> -
>  /*
>   * We are about to suspend. Save the TPM state
>   * so that it can be restored.
> @@ -601,54 +592,18 @@ static const struct tpm_input_header savestate_header =
> {
>  int tpm_pm_suspend(struct device *dev)
>  {
>  	struct tpm_chip *chip = dev_get_drvdata(dev);
> -	struct tpm_cmd_t cmd;
> -	int rc, try;
> -
> -	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
> +	int rc = 0;
>  
> -	if (chip == NULL)
> +	if (!chip)
>  		return -ENODEV;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		return 0;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		tpm2_shutdown(chip, TPM2_SU_STATE);
> -		return 0;
> -	}
> -
> -	/* for buggy tpm, flush pcrs with extend to selected dummy */
> -	if (tpm_suspend_pcr)
> -		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
> -				     "extending dummy pcr before suspend");
> -
> -	/* now do the actual savestate */
> -	for (try = 0; try < TPM_RETRY; try++) {
> -		cmd.header.in = savestate_header;
> -		rc = tpm_transmit_cmd(chip, NULL, &cmd,
> SAVESTATE_RESULT_SIZE,
> -				      0, 0, NULL);
> -
> -		/*
> -		 * If the TPM indicates that it is too busy to respond to
> -		 * this command then retry before giving up.  It can take
> -		 * several seconds for this TPM to be ready.
> -		 *
> -		 * This can happen if the TPM has already been sent the
> -		 * SaveState command before the driver has loaded.  TCG 1.2
> -		 * specification states that any communication after
> SaveState
> -		 * may cause the TPM to invalidate previously saved state.
> -		 */
> -		if (rc != TPM_WARN_RETRY)
> -			break;
> -		tpm_msleep(TPM_TIMEOUT_RETRY);
> -	}
> -
> -	if (rc)
> -		dev_err(&chip->dev,
> -			"Error (%d) sending savestate before suspend\n", rc);
> -	else if (try > 0)
> -		dev_warn(&chip->dev, "TPM savestate took %dms\n",
> -			 try * TPM_TIMEOUT_RETRY);
> +	else
> +		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
>  
>  	return rc;
>  }
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index fd945fc828b6..862c9262e037 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -543,6 +543,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct
> tpm_space *space,
>  int tpm_startup(struct tpm_chip *chip);
>  int tpm_get_timeouts(struct tpm_chip *);
>  
> +int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
>  int tpm1_do_selftest(struct tpm_chip *chip);
>  int tpm1_auto_startup(struct tpm_chip *chip);
>  int tpm1_get_timeouts(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 8ecda2cd3734..d118adbcd2a7 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -667,3 +667,62 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  		rc = -ENODEV;
>  	return rc;
>  }
> +
> +#define TPM_ORD_SAVESTATE 152
> +#define SAVESTATE_RESULT_SIZE 10
> +static const struct tpm_input_header savestate_header = {
> +	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> +	.length = cpu_to_be32(10),
> +	.ordinal = cpu_to_be32(TPM_ORD_SAVESTATE)
> +};
> +
> +/**
> + * tpm1_pm_suspend() - pm suspend handler
> + *    The functions saves the TPM state to be restored on resume.
> + *
> + * @chip:    TPM chip to use.
> + * @tpm_suspend_pcr: flush pcr for buggy TPM chips.
> + *
> + * Return: 0 on success, < 0 on error.
> + */
> +int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
> +{
> +	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
> +	struct tpm_cmd_t cmd;
> +	int rc, try;
> +
> +	/* for buggy tpm, flush pcrs with extend to selected dummy */
> +	if (tpm_suspend_pcr)
> +		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
> +				     "extending dummy pcr before suspend");
> +
> +	/* now do the actual savestate */
> +	for (try = 0; try < TPM_RETRY; try++) {
> +		cmd.header.in = savestate_header;
> +		rc = tpm_transmit_cmd(chip, NULL, &cmd,
> SAVESTATE_RESULT_SIZE,
> +				      0, 0, NULL);
> +
> +		/*
> +		 * If the TPM indicates that it is too busy to respond to
> +		 * this command then retry before giving up.  It can take
> +		 * several seconds for this TPM to be ready.
> +		 *
> +		 * This can happen if the TPM has already been sent the
> +		 * SaveState command before the driver has loaded.  TCG 1.2
> +		 * specification states that any communication after
> SaveState
> +		 * may cause the TPM to invalidate previously saved state.
> +		 */
> +		if (rc != TPM_WARN_RETRY)
> +			break;
> +		tpm_msleep(TPM_TIMEOUT_RETRY);
> +	}
> +
> +	if (rc)
> +		dev_err(&chip->dev, "Error (%d) sending savestate before
> suspend\n",
> +			rc);
> +	else if (try > 0)
> +		dev_warn(&chip->dev, "TPM savestate took %dms\n",
> +			 try * TPM_TIMEOUT_RETRY);
> +
> +	return rc;
> +}

Again, looks otherwise good except for the heading comment.

/Jarkko
