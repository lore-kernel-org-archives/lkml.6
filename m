Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67399C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E75425C32
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E75425C32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeGBM4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:56:30 -0400
Received: from muru.com ([72.249.23.125]:49616 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeGBM41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:56:27 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DB88C8047;
        Mon,  2 Jul 2018 12:59:21 +0000 (UTC)
Date:   Mon, 2 Jul 2018 05:56:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] ARM: OMAP1: ams-delta FIQ: don't use static
 GPIO numbers
Message-ID: <20180702125623.GX112168@atomide.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-6-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-6-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180621 22:45]:
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -580,6 +580,44 @@ static struct gpiod_hog ams_delta_gpio_hogs[] = {
>  	{},
>  };
>  
> +/*
> + * Some drivers may not use GPIO lookup tables but need to be provided
> + * with GPIO numbers.  The same applies to GPIO based IRQ lines - some
> + * drivers may even not use GPIO layer but expect just IRQ numbers.
> + * We could either define GPIO lookup tables then use them on behalf
> + * of those devices, or we can use GPIO driver level methods for
> + * identification of GPIO and IRQ numbers. For the purpose of the latter,
> + * defina a helper function which identifies GPIO chips by their labels.
> + */
> +static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
> +{
> +	char *label = data;
> +
> +	return !strcmp(label, chip->label);
> +}

I left out the duplicate gpiochip_match_by_label() above as it's already
there from an earlier "ARM: OMAP1: ams-delta: assign LED GPIO numbers
from descriptors". The whole series is now pushed out to
omap-for-v4.19/omap1 and I'll merge it into my for-next soon.

Thanks,

Tony
