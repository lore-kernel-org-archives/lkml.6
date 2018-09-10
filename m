Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E38C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52AA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAcVqxGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52AA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIJMIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:08:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54714 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeIJMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:08:01 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so28227403ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCIXcAsLTBKDCVFPfScy4zJ0KyDvhKc2vaw0upWlnNU=;
        b=HAcVqxGJyAmKxZbF5HptMfoP7uU4JDADqzSRVYs9L6Ln1LuJo//iSk3bOIt9m2385B
         7J5CYwbeb0Hj4PzROgakDvpKzWEQ4j95ZP91+wXD6y4A2jTMp12QrhgY5rHhEpvCue/J
         5/cH6BJIO2BA7C8kN9v5jPXpwHwssrNP0fLuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCIXcAsLTBKDCVFPfScy4zJ0KyDvhKc2vaw0upWlnNU=;
        b=AP5Ya5tZYn2xXOtGMCqmEo5LV4eqfEK+J98F9E2weuyXre+JeKiaY9FE63zSdVlRHQ
         iUm1P9NFRdHVg9DyZTulVcECBUAlVgwf8FlwVaE1pDwBin9bgfh2FbdJMfn3VXqUyTwB
         s9MadNcZywrMWZPGRVF8vKskFMPd9INql69mVnUAJbQY+vLrMfw06hxEU0apvQQGhInG
         tk03cJWMHbu0uG0R+ldpL1hB54nwOwWo01D9RJUji6H4UVxTzkFofaj7am4YErp83kr4
         0GemWik7xEGrBOUTYwtCX3n39Z0jJPk9MZxj1O3kmylMTWAZWpkhKvrXasoK7rSn5C7s
         pl2w==
X-Gm-Message-State: APzg51Cw0XeLR7cKEo+ICbbuL9YhWPq1X8Y3DeBHkIrbkUi8eNaVHr9W
        CQqcp4vxGrDJCjoeKm2+2jal4zUZKEi3QRUN4kQp0g==
X-Google-Smtp-Source: ANB0VdaPORAPf28pBAJua+hZaGhyE7bt4aAsahEhDMzTP+DcUrRK8Xi2kyuZGu9T8/WThprlc64b01+adXmnj42/Lds=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr16282926jab.113.1536563724926;
 Mon, 10 Sep 2018 00:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180717231448.14958-1-jmkrzyszt@gmail.com> <20180909225605.16463-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180909225605.16463-2-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 09:15:13 +0200
Message-ID: <CACRpkdaunjy-k+ssCxVQTHjzCqGdzn3JRHyon8uU9Q8a3d9BXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] video: fbdev: omapfb: lcd_ams_delta: use GPIO
 lookup table
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:55 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
>
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
> to the driver probe function so device initialization can be deferred
> instead of aborted if a GPIO pin is not yet available.
>
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Good work as usual:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

FWIW I think the entire drivers/video/fbdev/omap/*
could be pretty easy to migrate to DRM if you compare
the simple drivers/gpu/drm/pl111 or drivers/gpu/drm/tve200
drivers. Just inspiration! :)

Yours,
Linus Walleij
