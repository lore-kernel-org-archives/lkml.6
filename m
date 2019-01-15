Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B592C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4779D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVwYBqw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfAOAef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:34:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41170 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfAOAee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:34:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so414648pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+9KoaZlMYhiCxbCSZQDfswPbIa8LSF17AIhYYm4SB+g=;
        b=NVwYBqw+duMtFINnJBEqjWbbfaxjPaZ3sugXuoZPDeQAiDFSCkXVIKC1XEWUv4kWy8
         BEMuNtPBoiQoHA7o9V3sHquu5Q+Gttn2kOIQYeYiV8j2yjzVIUNH3bEjVTODTfnDSIh6
         hAdR1DdG/+CTj+nb2xnnoCsov6BRqqeKfKEFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+9KoaZlMYhiCxbCSZQDfswPbIa8LSF17AIhYYm4SB+g=;
        b=GlCHB/rO8wIJB9uk14meWwyw1MozFR52XkgAQHuBlaGNU/K77rHNLLH4Dq0NdYCPTP
         A/6yHGhyOFdk2MTLZ/mGfxTl/cOeoEAVgpuaLm1PATM1M99lbUKEsO2HTvHq6VZI0KdJ
         3rbnGmjuTBup0S6nqUEhH+rTDb+uhcxm0zzKTixlX9DUON0Ca9QfeXYZ5WcOpMUrgI7T
         mqWYo2JJf6iiCrC/X+TchnjeqR0wQPvw5CmOn8uEShHQIqfoacmwRDgz+Uick9Wn4b56
         Lg8Nl04rNRVocdkXGJh2o6ju41gZ82s8ESPK+3m2R9qN32bYk993o3ZXopXJnTMpKXNy
         MLKg==
X-Gm-Message-State: AJcUukc10dQBrVQOQS26YJtYUoHG+KdsqgOHHYrrB5RnL3bfcSzS4k1U
        gTUwnD6RWnakrxrI93a7yeam3A==
X-Google-Smtp-Source: ALg8bN5uQbdG8IlR1/A3M9uwMoE2k+eFYoQOLTzwau5PLtYapaxV155/f1lGfmApz6+7o1hiE/6INA==
X-Received: by 2002:a63:cd11:: with SMTP id i17mr1140425pgg.345.1547512473719;
        Mon, 14 Jan 2019 16:34:33 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s84sm3397484pfi.15.2019.01.14.16.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:34:32 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:34:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/14] pinctrl: qcom: spmi-gpio: hardcode IRQ counts
Message-ID: <20190115003428.GJ9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-4-masneyb@onstation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Jan 07:47 PST 2019, Brian Masney wrote:

> The probing of this driver calls platform_irq_count, which will
> setup all of the IRQs that are configured in device tree. In
> preparation for converting this driver to be a hierarchical IRQ
> chip, hardcode the IRQ count based on the hardware type so that all
> the IRQs are not configured immediately and are configured on an
> as-needed basis later in the boot process. This change will also
> allow for the removal of the interrupts property later in this
> patch series once the hierarchical IRQ chip support is in.
> 
> This patch also removes the generic qcom,spmi-gpio OF match since we
> don't know the number of pins. All of the existing upstream bindings
> already include the more-specific binding.
> 
> The pm8941 code was tested on a LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v3:
> - More variants are now included. I missed these since I searched for
>   qcom,spmi-gpio in the arm dts, and missed the ones in the arm64 dts.
> 
> Changes since v2:
> - Don't move pmic_gpio_of_match block. Use device_get_match_data instead
>   of of_match_device.
> - Correct build warning on arm64: warning: cast from pointer to integer
>   of different size
> 
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 28 ++++++++++--------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index 5f2977982ef1..b74c44357e8a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -951,13 +951,7 @@ static int pmic_gpio_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	npins = platform_irq_count(pdev);
> -	if (!npins)
> -		return -EINVAL;
> -	if (npins < 0)
> -		return npins;
> -
> -	BUG_ON(npins > ARRAY_SIZE(pmic_gpio_groups));
> +	npins = (u16)(uintptr_t) device_get_match_data(&pdev->dev);

Why u16, afaict npins is an int? I'm pretty sure you can leave the last
cast as implicit and as it's not actually a pointer that we're acquiring
casting it to "unsigned long" is the idiomatic way.

Apart from this the change looks good.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  
>  	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
>  	if (!state)
> @@ -1063,16 +1057,16 @@ static int pmic_gpio_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id pmic_gpio_of_match[] = {
> -	{ .compatible = "qcom,pm8005-gpio" },	/* 4 GPIO's */
> -	{ .compatible = "qcom,pm8916-gpio" },	/* 4 GPIO's */
> -	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
> -	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
> -	{ .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
> -	{ .compatible = "qcom,pm8998-gpio" },	/* 26 GPIO's */
> -	{ .compatible = "qcom,pmi8998-gpio" },	/* 14 GPIO's */
> -	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
> -	{ .compatible = "qcom,pms405-gpio" },	/* 12 GPIO's, holes on 1 9 10 */
> -	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
> +	{ .compatible = "qcom,pm8005-gpio", .data = (void *) 4 },
> +	{ .compatible = "qcom,pm8916-gpio", .data = (void *) 4 },
> +	{ .compatible = "qcom,pm8941-gpio", .data = (void *) 36 },
> +	{ .compatible = "qcom,pm8994-gpio", .data = (void *) 22 },
> +	{ .compatible = "qcom,pmi8994-gpio", .data = (void *) 10 },
> +	{ .compatible = "qcom,pm8998-gpio", .data = (void *) 26 },
> +	{ .compatible = "qcom,pmi8998-gpio", .data = (void *) 14 },
> +	{ .compatible = "qcom,pma8084-gpio", .data = (void *) 22 },
> +	/* pms405 has 12 GPIOs with holes on 1, 9, and 10 */
> +	{ .compatible = "qcom,pms405-gpio", .data = (void *) 12 },
>  	{ },
>  };
>  
> -- 
> 2.17.2
> 
