Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BBDC282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401FA20870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfA3JFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:05:30 -0500
Received: from mx.socionext.com ([202.248.49.38]:31179 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfA3JF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:05:29 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Jan 2019 18:05:28 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5CEBD60062;
        Wed, 30 Jan 2019 18:05:28 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Jan 2019 18:05:28 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 302BF1A04FD;
        Wed, 30 Jan 2019 18:05:28 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 1568912185F;
        Wed, 30 Jan 2019 18:05:28 +0900 (JST)
Date:   Wed, 30 Jan 2019 18:05:27 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 1/2] regulator: uniphier: Fix probe error handling
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190130071110.26050-1-axel.lin@ingics.com>
References: <20190130071110.26050-1-axel.lin@ingics.com>
Message-Id: <20190130180526.4DE9.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Wed, 30 Jan 2019 15:11:09 +0800 <axel.lin@ingics.com> wrote:

> Ensure unwind all resources if probe fails.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/uniphier-regulator.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
> index abf22acbd13e..6ba0ae405f2b 100644
> --- a/drivers/regulator/uniphier-regulator.c
> +++ b/drivers/regulator/uniphier-regulator.c
> @@ -87,8 +87,10 @@ static int uniphier_regulator_probe(struct platform_device *pdev)
>  	}
>  
>  	regmap = devm_regmap_init_mmio(dev, base, priv->data->regconf);
> -	if (IS_ERR(regmap))
> -		return PTR_ERR(regmap);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		goto out_rst_assert;
> +	}

Surely this return without asserting resets is wrong. This looks good to me.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards,
Kunihiko Hayashi


