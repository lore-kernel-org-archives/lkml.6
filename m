Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A03B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uxiizEiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A03B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLCJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:19:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44869 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:19:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so11278987wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+BnCJ5QVg9I98pcBwY5xi5gWUj5V8q8GaqKmWts3Hoo=;
        b=uxiizEiFZdN2JBo0WJit6A7VBK2FnJfOE5oSabXsIZKUBXUNX2SKJpVotcnDMXG0ix
         S9w/xvzbnt4KjB6leOMZEEQLHAJz9kRePGFkZ/f4wzVJqYWRWnwxgwtIgMWCkrNfz4rl
         OzuF4KdIHhdZO33FzOvjLhLb/6aW45+GvoiWQwZWIJ7p7twfH0O4haNljBCw6Dcv1ZyP
         897dEI7Vjw7cYPtLLc3mLTiUHdLyCzyLmOXci1nCFKccyZUnJbXCtm0F0Mep/0akKoMo
         Vcxuk0A8ST0ZRKS9namkwPZHJVSmp3GyXOCn4Bvs30kf5o6fTWGdmnYbt7Oo4FAZTAC9
         kF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+BnCJ5QVg9I98pcBwY5xi5gWUj5V8q8GaqKmWts3Hoo=;
        b=gT3ntXqTplg7xZgadSKdBX74xzVom6JTyymCHkFh6LsLBNzzldkMglM7MM0ew7OPeG
         06i0q4e5NAWmrJL1lEG8fFbjrdpkZglLfHtudhXImgJJrXO6GXk78mHxpbZbEDLc6IUe
         /fXuQcfu62Letfpozd4FEEZvM1SigYBTyAOeqGG9sHx1woDmdMNQw7RayjkB1SOE8mBu
         HUpO4JoeVbotAb+o9SSsJPc7PBRnasb/7ojh+AuAaJjcEWaIKKVr+1d1Pd50hW84LIe1
         lEFVh9H+zHrox1spZitfm4HGALhj13e53tRG8YKWdCPaVHXX5fSMwH1YJT/Uo2yRXeAV
         l6rA==
X-Gm-Message-State: AA+aEWYYVjxWNFEZQ1A/X1cvttp0nkVDOmLf4pkmSJTqEdXRtrXzD1Uu
        GFo/S35fUTxG3jBQWHDrWB4NLA==
X-Google-Smtp-Source: AFSGD/WM+fQGnzxJgnI+MLIoGQYgDRg+S+2o+SmT4aAmlqw4iRZBaAH/AgJ0/Tf1Q6z+xTNHHSpg1w==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr13665052wrt.327.1543828769309;
        Mon, 03 Dec 2018 01:19:29 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id a12sm10578258wro.18.2018.12.03.01.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 01:19:28 -0800 (PST)
Message-ID: <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Carlo Caione <carlo@caione.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2018 10:19:26 +0100
In-Reply-To: <20181203061324.36248-3-xingyu.chen@amlogic.com>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
         <20181203061324.36248-3-xingyu.chen@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 14:13 +0800, Xingyu Chen wrote:
> The Meson-G12A SoC uses the same GPIO interrupt controller IP block as the
> other Meson SoCs, A totle of 100 pins can be spied on, which is the sum of:
> 
> - 223:100 undefined (no interrupt)
> - 99:97   3 pins on bank GPIOE
> - 96:77   20 pins on bank GPIOX
> - 76:61   16 pins on bank GPIOA
> - 60:53   8 pins on bank GPIOC
> - 52:37   16 pins on bank BOOT
> - 36:28   9 pins on bank GPIOH
> - 27:12   16 pins on bank GPIOZ
> - 11:0    12 pins in the AO domain
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/irqchip/irq-meson-gpio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-
> gpio.c
> index 7b531fd075b8..971e8dea069a 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -67,12 +67,17 @@ static const struct meson_gpio_irq_params axg_params = {
>  	.nr_hwirq = 100,
>  };
>  
> +static const struct meson_gpio_irq_params g12a_params = {
> +	.nr_hwirq = 100,
> +};
> +

Same comment as on i2c, the g12 seems compatible with the axg.
Is this patchset patchset really necessary ?

>  static const struct of_device_id meson_irq_gpio_matches[] = {
>  	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
>  	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params
> },
>  	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params
> },
>  	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
>  	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
> +	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &g12a_params
> },
>  	{ }
>  };
>  


