Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C67DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233E4208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPkUhAbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233E4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeJAQOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:14:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37333 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeJAQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:14:14 -0400
Received: by mail-io1-f67.google.com with SMTP id v14-v6so8839448iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFGkcHfSSnFsq77VIiNh0Sw17nrKeRJtSpTksHNrfYA=;
        b=XPkUhAbsWjLPi4cldzhftETrgVm2nOxcmVBzU1MlVsEiqdUCHmOrfhzoPT/K33Hw5r
         E3EVfs8zHMxayfCUcdci9li0HXx2SvCMq6A25rDpoyfjm0H0d0qixHp/zNHnU8/IcHlr
         nz3gP27lyIkGlcADshu4N/DBs48yuCccnLaw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFGkcHfSSnFsq77VIiNh0Sw17nrKeRJtSpTksHNrfYA=;
        b=OiVLWnFfHtTY4fkXFhIrjKsaZEqXQ1n8UDG14DSyGgH+FwXhURkhlnMDbFfH7fgDIb
         U21damr3FoJy/uxGDVPegIgM8QDrdWYedVnRKomhobhd4Bk3ML4oZJWuYeQEqV4Na/5m
         ZDIZb9SqbFPecrK6Nd34bXSwY6Pxn1mlEqSJSogmCvTROf0RQ91iIro0hSd+voRN2lHB
         uyEQCpe9fLcdwv+LZXDw5ACTLAGVDHdGoL8n9BAJR+dt7EPNRIMDglpF9Qq0w6MgT78H
         Uh9eHWoqA6rtJqokvqXVxKgQovodq74ilpzLy8GyXlgTiWUXT9VsXwn7vLvgFcA3WUCi
         Wz2g==
X-Gm-Message-State: ABuFfogy1LljakQGXMzHobLZyb6pkq8G8AndLFl+PV5qyrKNmyg9779b
        FZdB8XoDdETvuo6rt/4p5AjzcWtbdU0MX/QANE6QPA==
X-Google-Smtp-Source: ACcGV62zAJbXfkeyfP0/UamYUjIUHNRNQ0OomM0ggvrgxxpc4j7D4JnNW0MiWUz/3S+Utv2D+niFlf5yDaETQKtV8eo=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr6232305iof.304.1538386639694;
 Mon, 01 Oct 2018 02:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180923235336.22148-2-jmkrzyszt@gmail.com> <20180929122022.6825-1-jmkrzyszt@gmail.com>
In-Reply-To: <20180929122022.6825-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 11:37:07 +0200
Message-ID: <CACRpkdbxh3uoVbc1udouxKaN+sc+q_vB7oj_B8PEa4wi=wLedg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix incorrect use of find_next_zero_bit()
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
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
        <u.kleine-koenig@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 2:19 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Commit b17566a6b08b ("gpiolib: Implement fast processing path in
> get/set array"), already fixed to some extent with commit 5d581d7e8cdc
> ("gpiolib: Fix missing updates of bitmap index"), introduced a new mode
> of processing bitmaps where bits applicable for fast bitmap processing
> path are supposed to be skipped while iterating bits which don't apply.
> Unfortunately, find_next_zero_bit() function supposed to skip over
> those fast bits is always called with a 'start' argument equal to an
> index of last zero bit found and returns that index value again an
> again, causing an infinite loop.
>
> Fix it by incrementing the index uncoditionally before
> find_next_zero_bit() is optionally called.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied with Marek's Tested-by.

Thanks to both of you for digging in and fixing this up!
Now we are in good shape for the v4.20 cycle :)

Yours,
Linus Walleij
