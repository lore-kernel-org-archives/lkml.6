Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B3C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E965E20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBHLuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:50:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:63568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHLuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:50:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 03:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="120938445"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.115])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2019 03:50:31 -0800
Date:   Fri, 8 Feb 2019 13:50:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
Message-ID: <20190208115031.GB11755@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
 <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
 <9cd734ad-ea9d-77f7-b657-3f0910a9d92f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cd734ad-ea9d-77f7-b657-3f0910a9d92f@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:14:54PM -0500, Stefan Berger wrote:
> +EXPORT_SYMBOL_GPL(tpm_chip_start);
> 
>  /**
>   * tpm_chip_stop() - power off the TPM
> @@ -131,7 +132,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
>      if (chip->ops->clk_enable)
>          chip->ops->clk_enable(chip, false);
>  }
> -
> +EXPORT_SYMBOL_GPL(tpm_chip_stop);

These are already fixed.

>  /**
>   * tpm_try_get_ops() - Get a ref to the tpm_chip
> @@ -474,8 +475,11 @@ static void tpm_del_char_device(struct tpm_chip *chip)
> 
>      /* Make the driver uncallable. */
>      down_write(&chip->ops_sem);
> -    if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +    if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +        tpm_chip_start(chip, 0);
>          tpm2_shutdown(chip, TPM2_SU_CLEAR);
> +        tpm_chip_stop(chip, 0);
> +    }

Thanks!

Needs to be also done in tpm_pm_suspend() but there it is also better to
take locks because in-kernel subsystem might be using TPM even user
space has been freezed (e.g. hibernate possibly in future).

mutex_lock(&chip->tpm_mutex);
if (!tpm_chip_start(chip, 0)) {
	tpm2_shutdown(chip, TPM2_SU_CLEAR);
	tpm_chip_stop(chip, 0);
}
mutex_unlock(&chip->tpm_mutex);

Fixed now.

>      chip->ops = NULL;
>      up_write(&chip->ops_sem);
>  }
> diff --git a/drivers/char/tpm/tpm-interface.c
> b/drivers/char/tpm/tpm-interface.c
> index 02e8cffd1163..fcd845ad8c3c 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -124,6 +124,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> void *buf, size_t bufsiz)
>          dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
>      } else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>          rc = -EFAULT;
> +    else
> +        rc = 0;

Why is this needed?

/Jarkko
