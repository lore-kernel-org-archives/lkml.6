Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369822133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3xk4iLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbfAKO3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33978 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbfAKO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so10955669lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a68uOIb5ZDVt/3oFh0J5AJJs418dr+JmnW1hZ4ubUw4=;
        b=f3xk4iLQIbRtksZiPsGNWVpN2YF29MeyhjoPA7WsereW42MwDsyL2g1Ytp0E3vsNKm
         hIX7/zDnYD3A6256FUcucP2sY2xhhoRmKreDCQVpoLwEyGV4niu26sDcpcdlQxsuaUUw
         pO1M7u5DUxZRPIx5f/Lsp3DJzZLVwfV5253Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a68uOIb5ZDVt/3oFh0J5AJJs418dr+JmnW1hZ4ubUw4=;
        b=kTF0RnULSaxF+nashesJDpEoKzEDB+bCzq21Kyv0a1EjjRvkkzCjS+Lk04Jc+HpFJT
         iNB8oi6MdhrLboBDvbV01cY1F+SIra+Ua3yJi9p7NilhHXFovMMEnrIEaedOpyWr/tLT
         z+pw3mHt6PKH4uKnSL5wfYTrKPdCqwhZzJhN8QafpthNcfjjTniSPRCuLx6AGfU6GxDG
         CtLOqSFMwfgIeMGFr6aHtPXD7ERdIHHrvj5wpBciRYgrK2fewiqTyaSgOG5HvO+498QH
         o3X4Aaw7FU/X4BVGHOA/VyjS8kXW9s9V8uVOz68khpV1mkwg3TD0qXMcZGt+QTQf5dd7
         pkwg==
X-Gm-Message-State: AJcUukcN4jd1K7X+OonP8XsNuKlWx64Tw1NfBMFbuQWAFwSFMxNZhvtU
        ZZhBU/65gTjg2YybpfmLaoTTwg4rK5Zj1e/a6oatTg==
X-Google-Smtp-Source: ALg8bN5hFINfVBmhOZ2HmXhdjlyAZ04TFQAsAfgHaLttPizJlepmSC215GQ61tU3bonAeZ2fHtisULHDFk9QejRZ09E=
X-Received: by 2002:a19:f813:: with SMTP id a19mr7894964lff.67.1547216935938;
 Fri, 11 Jan 2019 06:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com> <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 15:28:44 +0100
Message-ID: <CACRpkdYTQjiPbLGQ8E_mByAY0e_byN8iW=jBVPw3QRxh4_fB_A@mail.gmail.com>
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

I applied this to the GPIO fixes with the ACKs.

Ulf is on vacation but I managed to get his ACK over chat,
so I will try to get this upstream ASAP.

Yours,
Linus Walleij
