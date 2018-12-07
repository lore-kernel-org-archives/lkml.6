Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9685EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A02020892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A02020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLGHQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:16:16 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:56226 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGHQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:16:15 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990824AbeLGHPMpJmuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Fri, 7 Dec 2018 08:15:12 +0100
Date:   Fri, 7 Dec 2018 08:15:10 +0100
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     tony@atomide.com, lee.jones@linaro.org,
        sebastian.reichel@collabora.com, Christian.Hohnstaedt@wago.com,
        t-kristo@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tps65218: Use devm_regmap_add_irq_chip and clean up
 error path in probe
Message-ID: <20181207071510.GA3465@lenoch>
References: <1544143788-22606-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544143788-22606-1-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 06:19:48AM +0530, Keerthy wrote:
> Use devm_regmap_add_irq_chip and clean up error path in probe.
> Hence clean up the probe error path and the remove function.
> 
> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Cleaned up remove function as well.

v3: Remove remove function? :)

>  drivers/mfd/tps65218.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 910f569..d2d4e3a 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -235,9 +235,9 @@ static int tps65218_probe(struct i2c_client *client,
>  
>  	mutex_init(&tps->tps_lock);
>  
> -	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
> -			IRQF_ONESHOT, 0, &tps65218_irq_chip,
> -			&tps->irq_data);
> +	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
> +				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
> +				       &tps->irq_data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -253,23 +253,11 @@ static int tps65218_probe(struct i2c_client *client,
>  			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>  			      regmap_irq_get_domain(tps->irq_data));
>  
> -	if (ret < 0)
> -		goto err_irq;
> -
> -	return 0;
> -
> -err_irq:
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> -
>  	return ret;
>  }
>  
>  static int tps65218_remove(struct i2c_client *client)
>  {
> -	struct tps65218 *tps = i2c_get_clientdata(client);
> -
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> -
>  	return 0;
>  }
>  
> -- 
> 1.9.1
