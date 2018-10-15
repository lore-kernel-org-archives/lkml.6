Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A80C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B090120644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSRD+GZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B090120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJOWMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:12:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36891 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJOWMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:12:54 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so27935735ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfddvKoGgUO3/lAd4OGoNcdxRS2hnNj3Nk48LH4Xv5w=;
        b=PSRD+GZoOicTy86en3epiE390tyCkTriBsXPpyf/nt69WE+8+nw2ePa3kxZU7hsa5H
         l126ybSDgJhh8hYmTt+a/Bjby0QAH1+t0SGGB7lTr5Hvi33CxcL/U7SW0kVv7zLsABr7
         cZt8bqiNcCM8HlQQl+5fZaiyd2EHTHpGXk3G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfddvKoGgUO3/lAd4OGoNcdxRS2hnNj3Nk48LH4Xv5w=;
        b=H/25ZoVxEa7QiOidVevB74bKtdAxHSGllE2b0gBMP0YmU58e9TU1cndKIUaTiKKot9
         +b+KXj5HeLRp2XxLJHZIghxMSIcMsoNdVfjSevRi/d7obexLtzEqHLpxzPZkW6rkARs8
         2m0kYIF5THaPY2QwvGH87ZNZh1VP5ENvM11HctCQ2bUb5BYbamGMKS5XPnRZzz4S/j4L
         9H4ZGzLbBTwHT7Bb1j5EJEq2HHTiU5EZseDUepMZOSHR3zHrEfxZwNyoakhEBTQ8K35S
         YDHZGtPmLbzXwcLD2eCSav03WScV8doK1QG3aKNC7+ukDtckKGyznbLvkaslpUNYpxSP
         iz8g==
X-Gm-Message-State: ABuFfogtQah4pxcP6wmwQD8NEWGWtP1DRCyLwlqU155MJslLDK9jmikW
        CVQg428XMx6mN+OZP2hCSI+xVSnUXqLLpwEx9Ct4GQ==
X-Google-Smtp-Source: ACcGV61mJE/DvncpkuVPBaZiacpX2bCro3PGUYNmoktP+W+iBSB1z+vxWG/dz1Q3VTqKmuvNuaKisHOfv/JU8882Dl4=
X-Received: by 2002:a02:7789:: with SMTP id g131-v6mr13507174jac.66.1539613643206;
 Mon, 15 Oct 2018 07:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180925192433.1377-1-jmkrzyszt@gmail.com> <20181012190901.1243-1-jmkrzyszt@gmail.com>
In-Reply-To: <20181012190901.1243-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Oct 2018 16:27:10 +0200
Message-ID: <CACRpkdYB1Wz8VC3aDpB_4KQcdbE-_Fy48zF_idKDM0pqiOEnXg@mail.gmail.com>
Subject: Re: [RFT PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kukjin Kim <kgene@kernel.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 9:07 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The new code introduced into
> mmc_pwrseq_simple_set_gpios_value() incorrectly interpretes the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, only member 0 of the array is handled correctly.
>
> Moreover, wrong assumption is taken about the 'values' bitmap size not
> exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied with Ulf's and Marek's tags!

Yours,
Linus Walleij
