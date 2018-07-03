Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A197C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6023521A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6023521A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeGCPVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:21:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:19262 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933358AbeGCPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:21:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 08:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="213108251"
Received: from cdikicix-mobl.ger.corp.intel.com ([10.249.254.69])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2018 08:21:30 -0700
Message-ID: <4789ea0ee11f0a87afcd89ad2814ad0964dd4809.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] tpm: Implement public tpm_put_chip() to release
 reference to chip
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jejb@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org, Stefan Berger <stefanb@liux.vnet.ibm.com>
Date:   Tue, 03 Jul 2018 18:21:29 +0300
In-Reply-To: <20180626193040.2509798-2-stefanb@linux.vnet.ibm.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
         <20180626193040.2509798-2-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 15:30 -0400, Stefan Berger wrote:
> Some subsystems that got a hold of a TPM chip through tpm_default_chip()
> need a way to release the reference to the TPM chip when they shut down.
> The tpm_put_chip() function enables this.
> 
> Signed-off-by: Stefan Berger <stefanb@liux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 10 ++++++++++
>  include/linux/tpm.h         |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 46caadca916a..c744289d82e0 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -80,6 +80,16 @@ void tpm_put_ops(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
> +/**
> + * tpm_put_chip() - Releae a ref to the tpm_chip
> + * @chip: Chip to put
> + */
> +void tpm_put_chip(struct tpm_chip *chip)
> +{
> +	put_device(&chip->dev);
> +}
> +EXPORT_SYMBOL_GPL(tpm_put_chip);
> +
>  /**
>   * tpm_default_chip() - find a TPM chip and get a reference to it
>   */
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e0e51c49a0e6..889dafe739e1 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -62,6 +62,7 @@ extern int tpm_unseal_trusted(struct tpm_chip *chip,
>  			      struct trusted_key_payload *payload,
>  			      struct trusted_key_options *options);
>  extern struct tpm_chip *tpm_default_chip(void);
> +extern void tpm_put_chip(struct tpm_chip *chip);
>  #else
>  static inline int tpm_is_tpm2(struct tpm_chip *chip)
>  {
> @@ -101,5 +102,8 @@ static inline struct tpm_chip *tpm_default_chip(void)
>  {
>  	return NULL;
>  }
> +static inline void tpm_put_chip(struct tpm_chip *chip)
> +{
> +}
>  #endif
>  #endif

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
