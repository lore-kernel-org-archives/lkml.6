Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60198ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB522083E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB522083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJTJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:00:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:54271 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeJTJAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:00:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 17:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,402,1534834800"; 
   d="scan'208";a="84073307"
Received: from kskibin-mobl.ger.corp.intel.com ([10.249.254.29])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2018 17:51:46 -0700
Date:   Sat, 20 Oct 2018 03:51:45 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Tomas Winkler <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 01/21] tpm: tpm_i2c_nuvoton: use correct command
 duration for TPM 2.x
In-Reply-To: <20181019182307.17745-2-tomas.winkler@intel.com>
Message-ID: <alpine.DEB.2.21.1810200350340.9963@jsakkine-mobl1>
References: <20181019182307.17745-1-tomas.winkler@intel.com> <20181019182307.17745-2-tomas.winkler@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018, Tomas Winkler wrote:
> tpm_i2c_nuvoton calculated commands duration using TPM 1.x
> values via tpm_calc_ordinal_duration() also for TPM 2.x chips.
> Call tpm2_calc_ordinal_duration() for retrieving ordinal
> duration for TPM 2.X chips.
>
> Cc: stable@vger.kernel.org
> Cc: Nayna Jain <nayna@linux.vnet.ibm.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
> Tested-by: Nayna Jain <nayna@linux.ibm.com> (For TPM 2.0)
> ---
> V7: new in the series.

Please, put change log entries only to the cover letter.

>
> drivers/char/tpm/tpm_i2c_nuvoton.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index caa86b19c76d..f74f451baf6a 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -369,6 +369,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
> 	struct device *dev = chip->dev.parent;
> 	struct i2c_client *client = to_i2c_client(dev);
> 	u32 ordinal;
> +	unsigned long duration;
> 	size_t count = 0;
> 	int burst_count, bytes2write, retries, rc = -EIO;
>
> @@ -455,10 +456,12 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
> 		return rc;
> 	}
> 	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> -	rc = i2c_nuvoton_wait_for_data_avail(chip,
> -					     tpm_calc_ordinal_duration(chip,
> -								       ordinal),
> -					     &priv->read_queue);
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		duration = tpm2_calc_ordinal_duration(chip, ordinal);
> +	else
> +		duration = tpm_calc_ordinal_duration(chip, ordinal);
> +
> +	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
> 	if (rc) {
> 		dev_err(dev, "%s() timeout command duration\n", __func__);
> 		i2c_nuvoton_ready(chip);
> -- 
> 2.14.4
>
>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
