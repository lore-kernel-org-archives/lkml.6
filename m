Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC913ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6135820C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCUzUo6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6135820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIXOMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:12:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39899 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIXOM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:12:29 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so1150812itc.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlkHYqfm/OcI9dWSaGFletmPJsWJa9K+glsS+ZMx/aM=;
        b=dCUzUo6ykF7dX3U550+ahyUNwiGOoROpCpM//E4AustwPBVT8J5SDjGmHcp9Qyk/Er
         jyrYlmuHj2ZuJlOB2rbV3nw/YMemXKNprzN24i+LbHxg5ljXmfiKLFQzmpKatjLv+nxy
         D1H8Lf+0TgJpED7C5pc78koiPxnyk/deRRYpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlkHYqfm/OcI9dWSaGFletmPJsWJa9K+glsS+ZMx/aM=;
        b=uAI+M/z4h7VARGfNGNCh6wNPGH14A4H9HguG+h9WP2fqw5DrBB3dR4WfkYXbdr4Jfw
         /Woi0c+veMTW5tHcE2Vw0YMqeI1XonSAaaKV6KNu2wpqCRLFmEYe2IOXM/8fXn9lbv+p
         ekSB1jOr0nCB+/VTYRymNps5mHfwHzzPUhA6VZcT5cznSqSTLlFaqvJVPCZyI+wSf2Ds
         5KQa2ClEO9lJ2+LiClHSRodWfJoh4E9sz8a8xCRG3AHge/j/4H8canmh99z+Gx5x03FK
         PoJb6V4FZxvJludGKAp4ybzQjJpq/9kYkI/F14Gkr/daTuNJDGEBrg8QX9OGBe91TodS
         /w3w==
X-Gm-Message-State: APzg51D5LtzUDne/0hp7bEumaCuAyWxCm7jHsFyWdJAXWhHjrZEVobRg
        5x9PTdPtin2wonnrobi+awsMDAz+tNReyYQjkKq4Yg==
X-Google-Smtp-Source: ANB0VdZgdi4zT0JqzPxuW7yyKdlorpobyaCX2A+HOYD7OSpAwsPZ3tuKYFn0IRQLE3ibxsvNXZwsU6NVmj7VaJxZW4c=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr8190725jag.112.1537776696397;
 Mon, 24 Sep 2018 01:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <2785169.v6aIfS3K2k@z50> <20180923235336.22148-1-jmkrzyszt@gmail.com>
 <20180923235336.22148-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180923235336.22148-2-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Sep 2018 10:11:23 +0200
Message-ID: <CACRpkdZ-pcy=pBKaLUPOZ5jf2bsp2X2u6QCLCWJ1H_XdNY9wtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: Fix missing updates of bitmap index
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        ext Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 1:52 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> In new code introduced by commit b17566a6b08b ("gpiolib: Implement fast
> processing path in get/set array"), bitmap index is not updated with
> next found zero bit position as it should while skipping over pins
> already processed via fast bitmap path, possibly resulting in an
> infinite loop.  Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied!

Thanks for working on getting this into shape!

Yours,
Linus Walleij
