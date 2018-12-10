Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F62C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333922084D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyaibUWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333922084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeLJGgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:36:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33421 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:36:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so5827221wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5nW0+AXCnOmTYOaeKSoFzMPPtmMBiSViwM5H1sH2Xho=;
        b=VyaibUWaKB90VAwPBAUy0mdKYYTuSJJgZ24mZ/jC7t4F7GIIunbbFaCojRD5D9+m5b
         Z2bp1Jws2Tr3BSjnoGwcgrT0Jj2pWf2oxbg13DfRCbUZbn+MHdb0i/He3cUbiUR6T8iz
         XrtgSOo04DNrylhtF5ATSDnzYhRVv5iwrCFZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5nW0+AXCnOmTYOaeKSoFzMPPtmMBiSViwM5H1sH2Xho=;
        b=A6x8++YEJ4x0L6a0vDrEBC5Wr7+mTK86GT9PLx/iRUr75qU6dfbnOJjlDEH/omAzwk
         wTgBcK7Hkw/lVNZmQkj1E3gkU3+xeG/CjtZkPLzzh3MjrhtFIh+YvpG0+MQU7Q+jkq/r
         28hDcPttkMZqohXRi0qT8VtBmHI4CajgV01kXaUN0ExiuvOASiCDM4LkGqmwQ73g0sg2
         u6Qnd8cTHYIg0RJ4eAhDxikeTzuTFeBDGEtav7WRPFN3CWV2+q96eDrxBcbgt4df2m2o
         ShWKkIsHHTKfJskNWXuanR6A+3wB9UYy2NUFxjweKxVeZNszSNfdgAOYWb+sEPocufm0
         zesg==
X-Gm-Message-State: AA+aEWZc2hdEusCu+o4rz0XMQXSUyZPtCBsE8vdEJ3HI1eriphTkbQjN
        2E2lYhwYwx4kfSwYOUZRnY08vw==
X-Google-Smtp-Source: AFSGD/WP+I1DkulLRnjs9AB+cCxnzM1MpW8v9iAwRXPzQFynH77AmKs0rDjmKJYhPV9MqTW7erMocA==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr1048714wmp.19.1544423804177;
        Sun, 09 Dec 2018 22:36:44 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id v4sm8898612wme.6.2018.12.09.22.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:36:43 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:36:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] mfd: axp20x: Re-align mfd cell entries
Message-ID: <20181210063642.GT26661@dell>
References: <20181208175847.32068-1-oskari@lemmela.net>
 <20181208175847.32068-2-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181208175847.32068-2-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2018, Oskari Lemmela wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> In the axp20x driver, the various mfd_cell lists had varying amounts
> of indentation, sometimes even within the same list. For the axp288,
> there's no alignment at all.
> 
> Re-align the right hand side of the assignments with the least amount
> of tabs possible. Also collapse the closing bracket and the opening
> bracket of the next entry onto the same line for the axp288, to be
> consistent with all the other mfd_cell lists.
> 
> This patch is whitespace change only. No functionality is modified.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>

Why is Oskari Lemmela's SoB here?

You both authored this alignment patch?

> ---
>  drivers/mfd/axp20x.c | 107 +++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index dfc3cff1d08b..8037b4e01ed6 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -640,9 +640,9 @@ static const struct mfd_cell axp221_cells[] = {
>  
>  static const struct mfd_cell axp223_cells[] = {
>  	{
> -		.name			= "axp221-pek",
> -		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
> -		.resources		= axp22x_pek_resources,
> +		.name		= "axp221-pek",
> +		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
> +		.resources	= axp22x_pek_resources,
>  	}, {
>  		.name		= "axp22x-adc",
>  		.of_compatible	= "x-powers,axp221-adc",
> @@ -650,7 +650,7 @@ static const struct mfd_cell axp223_cells[] = {
>  		.name		= "axp20x-battery-power-supply",
>  		.of_compatible	= "x-powers,axp221-battery-power-supply",
>  	}, {
> -		.name			= "axp20x-regulator",
> +		.name		= "axp20x-regulator",
>  	}, {
>  		.name		= "axp20x-ac-power-supply",
>  		.of_compatible	= "x-powers,axp221-ac-power-supply",
> @@ -666,9 +666,9 @@ static const struct mfd_cell axp223_cells[] = {
>  
>  static const struct mfd_cell axp152_cells[] = {
>  	{
> -		.name			= "axp20x-pek",
> -		.num_resources		= ARRAY_SIZE(axp152_pek_resources),
> -		.resources		= axp152_pek_resources,
> +		.name		= "axp20x-pek",
> +		.num_resources	= ARRAY_SIZE(axp152_pek_resources),
> +		.resources	= axp152_pek_resources,
>  	},
>  };
>  
> @@ -697,84 +697,79 @@ static const struct resource axp288_charger_resources[] = {
>  
>  static const struct mfd_cell axp288_cells[] = {
>  	{
> -		.name = "axp288_adc",
> -		.num_resources = ARRAY_SIZE(axp288_adc_resources),
> -		.resources = axp288_adc_resources,
> -	},
> -	{
> -		.name = "axp288_extcon",
> -		.num_resources = ARRAY_SIZE(axp288_extcon_resources),
> -		.resources = axp288_extcon_resources,
> -	},
> -	{
> -		.name = "axp288_charger",
> -		.num_resources = ARRAY_SIZE(axp288_charger_resources),
> -		.resources = axp288_charger_resources,
> -	},
> -	{
> -		.name = "axp288_fuel_gauge",
> -		.num_resources = ARRAY_SIZE(axp288_fuel_gauge_resources),
> -		.resources = axp288_fuel_gauge_resources,
> -	},
> -	{
> -		.name = "axp221-pek",
> -		.num_resources = ARRAY_SIZE(axp288_power_button_resources),
> -		.resources = axp288_power_button_resources,
> -	},
> -	{
> -		.name = "axp288_pmic_acpi",
> +		.name		= "axp288_adc",
> +		.num_resources	= ARRAY_SIZE(axp288_adc_resources),
> +		.resources	= axp288_adc_resources,
> +	}, {
> +		.name		= "axp288_extcon",
> +		.num_resources	= ARRAY_SIZE(axp288_extcon_resources),
> +		.resources	= axp288_extcon_resources,
> +	}, {
> +		.name		= "axp288_charger",
> +		.num_resources	= ARRAY_SIZE(axp288_charger_resources),
> +		.resources	= axp288_charger_resources,
> +	}, {
> +		.name		= "axp288_fuel_gauge",
> +		.num_resources	= ARRAY_SIZE(axp288_fuel_gauge_resources),
> +		.resources	= axp288_fuel_gauge_resources,
> +	}, {
> +		.name		= "axp221-pek",
> +		.num_resources	= ARRAY_SIZE(axp288_power_button_resources),
> +		.resources	= axp288_power_button_resources,
> +	}, {
> +		.name		= "axp288_pmic_acpi",
>  	},
>  };
>  
>  static const struct mfd_cell axp803_cells[] = {
>  	{
> -		.name			= "axp221-pek",
> -		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
> -		.resources		= axp803_pek_resources,
> +		.name		= "axp221-pek",
> +		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
> +		.resources	= axp803_pek_resources,
>  	},
> -	{	.name			= "axp20x-regulator" },
> +	{	.name		= "axp20x-regulator" },
>  };
>  
>  static const struct mfd_cell axp806_self_working_cells[] = {
>  	{
> -		.name			= "axp221-pek",
> -		.num_resources		= ARRAY_SIZE(axp806_pek_resources),
> -		.resources		= axp806_pek_resources,
> +		.name		= "axp221-pek",
> +		.num_resources	= ARRAY_SIZE(axp806_pek_resources),
> +		.resources	= axp806_pek_resources,
>  	},
> -	{	.name			= "axp20x-regulator" },
> +	{	.name		= "axp20x-regulator" },
>  };
>  
>  static const struct mfd_cell axp806_cells[] = {
>  	{
> -		.id			= 2,
> -		.name			= "axp20x-regulator",
> +		.id		= 2,
> +		.name		= "axp20x-regulator",
>  	},
>  };
>  
>  static const struct mfd_cell axp809_cells[] = {
>  	{
> -		.name			= "axp221-pek",
> -		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
> -		.resources		= axp809_pek_resources,
> +		.name		= "axp221-pek",
> +		.num_resources	= ARRAY_SIZE(axp809_pek_resources),
> +		.resources	= axp809_pek_resources,
>  	}, {
> -		.id			= 1,
> -		.name			= "axp20x-regulator",
> +		.id		= 1,
> +		.name		= "axp20x-regulator",
>  	},
>  };
>  
>  static const struct mfd_cell axp813_cells[] = {
>  	{
> -		.name			= "axp221-pek",
> -		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
> -		.resources		= axp803_pek_resources,
> +		.name		= "axp221-pek",
> +		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
> +		.resources	= axp803_pek_resources,
>  	}, {
> -		.name			= "axp20x-regulator",
> +		.name		= "axp20x-regulator",
>  	}, {
> -		.name			= "axp20x-gpio",
> -		.of_compatible		= "x-powers,axp813-gpio",
> +		.name		= "axp20x-gpio",
> +		.of_compatible	= "x-powers,axp813-gpio",
>  	}, {
> -		.name			= "axp813-adc",
> -		.of_compatible		= "x-powers,axp813-adc",
> +		.name		= "axp813-adc",
> +		.of_compatible	= "x-powers,axp813-adc",
>  	}, {
>  		.name		= "axp20x-battery-power-supply",
>  		.of_compatible	= "x-powers,axp813-battery-power-supply",

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
