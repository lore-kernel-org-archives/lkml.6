Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A99AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkcQ8mx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAC72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbeLJGfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:35:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36126 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:35:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so9955330wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gSDdkHAXyzh5ArSH6JnONeayiq2zjlybh5+GavDZHTU=;
        b=kkcQ8mx91ExV1BXkY/+u6SPf66uY094HQ5nLXCY9H/uYIXxo7FrI5tcgA1cZTK5zrX
         8KoZUaaoA4x410rH7PWVCY7mdY0XvABKBVy53cbFtDvEeJUTv/44lPaIeagyK23akrxt
         MkYewg6INVV1RBeoMEGef2ViUdbL2lbawtfMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gSDdkHAXyzh5ArSH6JnONeayiq2zjlybh5+GavDZHTU=;
        b=pLT+p0dhG8fm8srE5WiYjKsC1Yo2smLbRHPhmEASFS8Z85PPRCV7u6lruy2boOM02J
         aULncSUHG72tUG7K63W3pbIAkPKygQ0EPeBYcDlHWNv+KoXdED24rp8gelq+6inSvYG4
         nm0GoEYlHKD0EaShsH15p5vo1v9n7sw7xom+QEPL7bv+N2TQy8OUWc9fFJ7XkVKkOIxL
         /lzSroRoxqCl8dgXAf9iOqHdBZ+NlPJPFtvIEwWH+MCXbC/j+h96lVm79qtFuDq95UD2
         3P7OdIt/egn4qUMzr66QGpLjo7r+LkNDdI4bOwwST/Kyr6Sj+9JB7y5A9gl7AZU2ncfb
         e+TA==
X-Gm-Message-State: AA+aEWZQVsfiFA/qvHVBA8YnrIJ2MBWYYPEkJ65tlil0VrBC1ojWVbDI
        rkZZcxKCsEWVd/VSO30g2oJRCA==
X-Google-Smtp-Source: AFSGD/VkdZqUOF8e7rd0ZuVVBGUTZpcR2bENWNasbwW5IGmuvH2Je9w+QAjfn57TOrLKacIoKxzHkQ==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr9949735wms.70.1544423736933;
        Sun, 09 Dec 2018 22:35:36 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id c77sm10887296wmh.12.2018.12.09.22.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:35:36 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:35:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210063534.GS26661@dell>
References: <20181208175847.32068-1-oskari@lemmela.net>
 <20181208175847.32068-3-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181208175847.32068-3-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I'm happy to fix this, but ...

Can you explain these tags for me please?

Specifically the last one.

Why does Chen-Yu Tsai have an SoB there?

> ---
>  drivers/mfd/axp20x.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 8037b4e01ed6..f8e0fa97bb31 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -726,6 +726,20 @@ static const struct mfd_cell axp803_cells[] = {
>  		.name		= "axp221-pek",
>  		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
>  		.resources	= axp803_pek_resources,
> +	}, {
> +		.name		= "axp20x-gpio",
> +		.of_compatible	= "x-powers,axp813-gpio",
> +	}, {
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
>  	},
>  	{	.name		= "axp20x-regulator" },
>  };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
