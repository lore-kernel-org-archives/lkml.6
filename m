Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC68C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818A2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfBRKk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:40:26 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35053 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:40:25 -0500
Received: by mail-vs1-f65.google.com with SMTP id e81so6228230vsd.2;
        Mon, 18 Feb 2019 02:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sg95qEAEiZV7zSnEbBDMhaa4KPf0tdb8zbEhyX+Hsqk=;
        b=Amk2f3v+O1DnyXr6Wpe+p+5NzcALfjDqTR07h9dEncVpbZEjVvKhcrIsACo78qexDQ
         6TEma3YpP+QyEpLrONleQkpRihi6Fuq3680yzYcmTsWqLsMgnDMaW1DjmWWiqD59g6Qv
         wdljkvCxb1vuC+xJ9q6OWLifHSJkF38RRblmzm4RFNme4e8ICW+LyUr7IsHavOXaa3KK
         hrjJ4Fh5ikbNiDjGk/MNxD3eY0pyw/xQ/oYfHr7d5mRrhb+GMo3VAfQKaVXbRkcYWDkE
         ch4vyWxHueDtKtMSglUxlYvdDHbZWP/3XSAPb1TMu9bXi4bqzlIIuXT/7z+k9dHC3zlB
         FG6w==
X-Gm-Message-State: AHQUAuaiiPN/LQHKaSuvgyYvAKhhLpZjI0j4ZlUIswtdObwna+2DTEB+
        DlmzeKQNttVvUGN+63GLUxG0IAEg/bv8060UDkc=
X-Google-Smtp-Source: AHgI3Ib/GZWZBo6DTp/AJsHCUmzUT2Yg78zWsYQKrzQ+GJz1vrLZ+P84m8x369n0r1YBE290uGGDq0Mi0deiVTVSG1Y=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr4261160vsp.166.1550486424200;
 Mon, 18 Feb 2019 02:40:24 -0800 (PST)
MIME-Version: 1.0
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1550484960-2392-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Feb 2019 11:40:12 +0100
Message-ID: <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The problem
> ===========
> Several device types (platform, amba, spi etc.) provide a driver_override
> field.  On sysfs store or during device removal, they kfree() the
> existing value.
>
> However the users are unaware of this and set the driver_override like:
>
>         pdev->driver_override = "exynos5-subcmu";
>
> which obviously leads to error.

IMHO driver_override is not meant to be set by a driver, only from userspace,
for binding the device to vfio (is there another use case?).

>   clk: samsung: exynos5: Fix kfree() of const memory on setting
>     driver_override
>   slimbus: ngd: Fix kfree() of const memory on setting driver_override

I see all users set override immediately after allocating a platform device.
Can't they just allocate a platform device using the override name instead?
What am I missing?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
