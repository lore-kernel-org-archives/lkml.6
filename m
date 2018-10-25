Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A662EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547362082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCbWWcjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547362082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeJYSGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:06:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYSGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:06:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so8568274wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mATkZbDGH8tn/fwT8hdNECKo6B3IconM8zxALC89/iY=;
        b=iCbWWcjUzydYbSEdgRRthpmxOQ2BlmC7UemKMVPsurMSaQMu3nSLmJnweayuUFxLDm
         DQGumdt4yrmkhVY1w5VMfEm5/dHs1Z74TTPS3+TzkthBxZ1MyNt4JfePrH0AbM54IMjS
         Uwn5zyMn41mGqOtc/hD6VRR+m452nMjfQWNF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mATkZbDGH8tn/fwT8hdNECKo6B3IconM8zxALC89/iY=;
        b=fa7ukwl4z+dZIJ4VXoXYijpWfVjT+8AzbtHXajN4+iSCJy5yxVaPLIGVjicstjq+IV
         GtiXHuNAO01nwhJHwvcreAaItwUw41kZ+ygU9EQCZ8SbijKZRsVbaa3uBgi9XuPv18wj
         nKrJedtqPfZZdcOerYoGG3YkEn3zdkA2jJJL5xa/E/UjvCRcm93H8Zil1MvMjXtC+Gm0
         uPWQQKUuJAVskbuD09TwzM5BrNknF02turqu6mfBt40ZImHLxQPRqaaDF7csayUqeDnY
         UlPoDaJEXnEpMeXykgs6+zJEMjpUn5ztzKdQhoyG8A9/YmKMsHf+Zxrt6f2snHg9bqZN
         PT/w==
X-Gm-Message-State: AGRZ1gKzViWSIe5ClpRMucb7JtM1BZ0/tpBgOAA5/w7YNKV8hR5FJgEw
        URnlmjzbNDoKhzsOxF+BywJK2Q==
X-Google-Smtp-Source: AJdET5cMSislzd0h0slrcnd6RmqXqYtyKZMkQuyMcJHuiYQCilcwV0ld07eWOGossILI+OljjNjDEA==
X-Received: by 2002:a5d:65d1:: with SMTP id e17-v6mr1054158wrw.149.1540460052703;
        Thu, 25 Oct 2018 02:34:12 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id y141-v6sm1246047wme.10.2018.10.25.02.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:34:11 -0700 (PDT)
Date:   Thu, 25 Oct 2018 10:33:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v5 1/5] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20181025093355.GN4939@dell>
References: <1540294467-25813-1-git-send-email-tony.xie@rock-chips.com>
 <1540294467-25813-2-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540294467-25813-2-git-send-email-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Tony Xie wrote:

>     The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>     and handheld devices. It contains the following components:
> 
>         - Regulators
>         - RTC
>         - Clocking
> 
>     Both RK809 and RK817 chips are using a similar register map,
>     so we can reuse the RTC and Clocking and regulators functionality.

What's with the odd tabbing at the start of every line?

> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 225 +++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/rk808.h | 172 +++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h    |   6 ++
>  4 files changed, 392 insertions(+), 17 deletions(-)

[...]

> +static struct resource rk817_rtc_resources[] = {
> +	{
> +		.start  = RK817_IRQ_RTC_ALARM,
> +		.end    = RK817_IRQ_RTC_ALARM,
> +		.flags  = IORESOURCE_IRQ,
> +	}
> +};

There are MACROs for these.  Please consider converting to them.

You don't need to do that for *this* patch though.

[...]

>  static const struct regmap_irq_chip rk818_irq_chip = {
>  	.name = "rk818",
>  	.irqs = rk818_irqs,
> @@ -376,7 +489,7 @@ static void rk805_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk805, so do nothing here\n");
> +			 "can not get the driver data of rk808!\n");

Nit: "cannot"

>  		return;
>  	}
>  
> @@ -394,7 +507,7 @@ static void rk808_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk808, so do nothing here\n");
> +			 "can not get the driver data of rk808!\n");

As above (and below).

>  		return;
>  	}
>  
> @@ -412,7 +525,7 @@ static void rk818_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk818, so do nothing here\n");
> +			 "can not get the driver data of rk808!\n");

"RK808" in all prints and comments.

>  		return;
>  	}
>  
> @@ -423,9 +536,39 @@ static void rk818_device_shutdown(void)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }
>  
> +static void rk8xx_syscore_shutdown(void)
> +{
> +	int ret;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	if (!rk808) {
> +		dev_warn(&rk808_i2c_client->dev,
> +			 "can not get the driver data of rk808!\n");
> +		return;
> +	}
> +
> +	if (system_state == SYSTEM_POWER_OFF &&
> +	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
> +		ret = regmap_update_bits(rk808->regmap,
> +					 RK817_SYS_CFG(3),
> +					 RK817_SLPPIN_FUNC_MSK,
> +					 SLPPIN_DN_FUN);
> +		if (ret) {
> +			dev_warn(&rk808_i2c_client->dev,
> +				 "the retset pin can not switch to power down function\n");

Spellcheck.

[...]

> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 4f38068..a468b81 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1047,6 +1047,12 @@ struct regmap_irq {
>  #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
>  	[_irq] = { .reg_offset = (_off), .mask = (_mask) }
>  
> +#define REGMAP_IRQ_REG_LINE(_id, _reg_bits) \
> +	[_id] = {				\
> +		.mask = BIT((_id) % (_reg_bits)),	\
> +		.reg_offset = (_id) / (_reg_bits),	\
> +	}
> +
>  /**
>   * struct regmap_irq_chip - Description of a generic regmap irq_chip.
>   *

This needs to be a separate patch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
