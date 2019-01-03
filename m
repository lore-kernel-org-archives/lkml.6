Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9647C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851A12184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hbd1jrD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfACWGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:06:12 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46573 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfACWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:06:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id y14so5234951lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QANzhaPy2nInN5aENUoqLEJcdEF1QIInnXqWfKquhOc=;
        b=Hbd1jrD7A+vhILx94F/SWpVdty2SiC8QhLzF2aEBsuBUeqzp2oNXvc/PVHmpDewDC3
         SB68Nyh5j5/V+hKR7sawydxDYHMd/WQjC5uTkiQVHUlz3ghpiReKLvexEpHLg3j91Owy
         8+yLJ2xMs+JzwcJ5Z76kdmNmH4o0IV5gzrNuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QANzhaPy2nInN5aENUoqLEJcdEF1QIInnXqWfKquhOc=;
        b=FnueDTfV144hZY1Qk4NRe7TOpCsxQ2nv6utCK3bmEgaygy0uTOiGAXi2I+d6dvPF+2
         POmfRtkfQ9MLDLYJwOw6t1SkaYT+ydX8rZJPUoBrBluzGyIU2ZckDChpW3Yc4fpXHg/6
         UkT3n2QtswG0EP+i9r/73OBgTqa9qGdtyTi2x5O12BoYkS/PXRMJftBx8Jg/q6CINTOT
         CMfzWs/6YPN4c+NUxENNG7aJzE67HeICSimRrOXUbiW9EWWN3timZCxpi5cHTxRHuFUN
         wfZaHylMX65jNzqM/+QTVgKtnAe/RnmNT92XmgXD6kMwHbIVRbLj4Oi41IZkrH98V1En
         Wn+Q==
X-Gm-Message-State: AA+aEWayK0T6NyAkm8y6r/2hZIuPQGFDH2M6VPYuvr9yv+TZFegzHpw3
        aOBRj9sx44xbaDcEvMgZ48OjT5sJ+t5PkwxmX7bMIg==
X-Google-Smtp-Source: AFSGD/V6sctot3rrsm0a1rVanqephXcBXWfb5keoZcQC1sH4d3mWuWxkF+m3ZZkEo45EGjf4qFfoZ73jur3SLZ8zHC0=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr25749042lfa.32.1546553170201;
 Thu, 03 Jan 2019 14:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com> <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Jan 2019 23:05:57 +0100
Message-ID: <CACRpkda8cSt7J8+2P1xpOn13KkS_xmeO1MBRR9dXZcWXgzpQwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: don't override the CD GPIO level when
 "cd-inverted" is set
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 8:44 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Since commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") gpiolib-of parses the "cd-gpios" property and flips the polarity
> if "cd-inverted" is also set. This results in the "cd-inverted" property
> being evaluated twice, which effectively makes it a no-op:
> - first in drivers/gpio/gpiolib-of.c (of_xlate_and_get_gpiod_flags) when
>   setting up the CD GPIO
> - then again in drivers/mmc/core/slot-gpio.c (mmc_gpio_get_cd) when
>   reading the CD GPIO value at runtime
>
> On boards which are using device-tree with the "cd-inverted" property
> being set any inserted card are not detected anymore. This is due to the
> MMC core treating the CD GPIO with the wrong polarity.
>
> Disable "override_cd_active_level" for the card detection GPIO which is
> parsed using mmc_of_parse. This fixes SD card detection on the boards
> which are currently using the "cd-inverted" device-tree property (tested
> on Meson8b Odroid-C1 and Meson8b EC-100).
>
> This does not remove the CD GPIO inversion logic from the MMC core
> because there's at least one driver (sdhci-pci-core for Intel BayTrail
> based boards) which still passes "override_cd_active_level = true" to
> mmc_gpiod_request_cd(). Due to lack of hardware for testing this is left
> untouched.
> In the future the GPIO inversion logic for both, card and read-only
> detection can be removed once no driver is using it anymore.
>
> Fixes: 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

OK two steps forward, one step back, that's a good fix for now, I
can fix it properly for v4.22.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
