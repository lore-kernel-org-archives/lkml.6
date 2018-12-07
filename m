Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F7C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACED2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpyDzMaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACED2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbeLGQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:40:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46069 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:40:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id b14so4374553wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YfpuPNStR7Bbh4U1vz1z4scj5aPvsB3ueMLGaS3b+QQ=;
        b=UpyDzMaEEuLoL0duppyiruFPYMHlKdOtyexjk/qoHFkb8HYqKNlxZaj/lKk80Xlp+i
         rZliBEiTYAyMqLFhgDPx9Q/FTznRTc9xWm2U0MGej3iVFiImuL2T4/Lqb05c62VzHrqr
         lB4EIe6CaIPOrMvgPD6AcPip7Q8jH2wjii9aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YfpuPNStR7Bbh4U1vz1z4scj5aPvsB3ueMLGaS3b+QQ=;
        b=QEGxO/g2RCcwrxjJ954LaI+2dDwq5HJk8BVq/Hu9JSQ+PiR5L/BxeQYzJP5Scwn1X+
         mOFCNnCENiqB1Yn4+kJxpUAufECZJjGO9DyivX9mHf90eHbBdqlS8UI3HxPeBaw6MMPF
         erbi4ubPYlh8x+iAW9N/+4hALjAXmiDtbPaS+EQ/59XJV4s00mqQshCDn/XYY4/oGJf2
         UjyxvZegGt1fyZqlgypQD3LE+tRyNOhNAJVYQhau0iw3BHDaIbLwLzcs4LjJbjJ0wLC8
         py4XCvx0aT9ksttqleK3ifQXWPJpFP/SsvCXEbZFROLpL+IpaosjobmQFqb01EHTjmO6
         OkdA==
X-Gm-Message-State: AA+aEWYkwcWs94ppj2m10hp3r2qPz9lCFfRFVYXDIuowiAqPLFCLbf54
        mpQ/bmmFGS82U/DQSDechEPJeQ==
X-Google-Smtp-Source: AFSGD/Ua/OsGSsNSJ6wV7LEC0pLEZVCEYLnmp6b/efW4rugFl5Y/QqPn8+/FwVbOfxWqNwrcqG0b0Q==
X-Received: by 2002:adf:e891:: with SMTP id d17mr2589982wrm.140.1544200813980;
        Fri, 07 Dec 2018 08:40:13 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id x8sm10189697wmd.45.2018.12.07.08.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 08:40:13 -0800 (PST)
Date:   Fri, 7 Dec 2018 16:40:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181207164011.GI26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120175211.3913-9-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index dfc3cff1d08b..e415b967d38c 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -728,11 +728,26 @@ static const struct mfd_cell axp288_cells[] = {
>  
>  static const struct mfd_cell axp803_cells[] = {
>  	{
> +		.name		= "axp20x-gpio",
> +		.of_compatible	= "x-powers,axp813-gpio",
> +	}, {
>  		.name			= "axp221-pek",
>  		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>  		.resources		= axp803_pek_resources,
>  	},
>  	{	.name			= "axp20x-regulator" },
> +	{
> +		.name		= "axp813-adc",
> +		.of_compatible	= "x-powers,axp813-adc",
> +	}, {
> +		.name		= "axp20x-battery-power-supply",
> +		.of_compatible	= "x-powers,axp813-battery-power-supply",
> +	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp813-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	= axp20x_ac_power_supply_resources,
> +	},
>  };

My OCD-dar is going crazy.

Why haven't you used the same alignment as is already there?

If it starts to run over 80-chars then bring the others back.

Also why is there a single liner shoved in the middle of the
multi-line entries?  Please move the singles to the top or the
bottom.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
