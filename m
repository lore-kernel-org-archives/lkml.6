Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dL5SCEWMHlv/bwAAmS7hNA
	; Mon, 11 Jun 2018 14:51:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 159B1607A4; Mon, 11 Jun 2018 14:51:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 210CF607E4;
	Mon, 11 Jun 2018 14:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 210CF607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeFKOvH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:51:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:4985 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932395AbeFKOvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:51:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 07:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400";
   d="scan'208";a="231649869"
Received: from tthayer-hp-z620-workstation.an.intel.com (HELO [10.122.105.144]) ([10.122.105.144])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2018 07:51:04 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH V2] EDAC, altera: Fix an error handling path in
 'altr_s10_sdram_probe()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, bp@alien8.de,
        mchehab@kernel.org
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180610174532.22071-1-christophe.jaillet@wanadoo.fr>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <092ce90c-1f68-1041-4385-997dcb13bc22@linux.intel.com>
Date: Mon, 11 Jun 2018 09:53:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180610174532.22071-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2018 12:45 PM, Christophe JAILLET wrote:
> IF 'regmap_write()' fails, we should release some resources as done in all
> the other error handling paths of the function.
> 
> Fixes: e9918d7fafae ("EDAC, altera: Handle SDRAM Uncorrectable Errors on Stratix10")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 -> v2: Fix subject line
> ---
>   drivers/edac/altera_edac.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index d0d5c4dbe097..5762c3c383f2 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -730,7 +730,8 @@ static int altr_s10_sdram_probe(struct platform_device *pdev)
>   			 S10_DDR0_IRQ_MASK)) {
>   		edac_printk(KERN_ERR, EDAC_MC,
>   			    "Error clearing SDRAM ECC count\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err2;
>   	}
>   
>   	if (regmap_update_bits(drvdata->mc_vbase, priv->ecc_irq_en_offset,
> Thanks.

Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
