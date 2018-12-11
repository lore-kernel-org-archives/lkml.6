Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33C320811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nbp6ECBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33C320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKJk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:40:29 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34090 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:40:29 -0500
Received: by mail-ua1-f68.google.com with SMTP id z23so4908891uam.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FHA0e+1mmwBBktuWFq/vqc7REX2BVGHa6vEukq0Mm0=;
        b=Nbp6ECBbHJjSUni3+s7O+qCzgemHhGXKaBZMsWxkSY33nh2/O9Kn+ouEgaJ38rs/KF
         QF1lqRDQcHiWA4HmekOxBLqeLuYq1+ns/PA9nubs2NhzLveCr3OdZkxMMAdf7WrItx1f
         QN2YVg2MXa95TroEKgXbpARjM+7yLcTcsSTho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FHA0e+1mmwBBktuWFq/vqc7REX2BVGHa6vEukq0Mm0=;
        b=WZQZU9NWzM2ysTNeTTZn94TuYB3nhkvLYVu0yiIziOTHqPiLXN20KRDinbpk7/vLz6
         cg2vmblODst7zj4Zmu8JvJ+LZ47oof3i1xncg9qp55DubZE/c5VSmlXxc816PTEbAjHZ
         XKOU67dXK2TjuMkmEhAFyCNftzYzna4rMua850N6vGAsXR3texvfwtYZroBtamZFN0oV
         avltjvuaDPJFWXX9pjwInMBVDC1xwdQo9hpl1WL/mkCZM/hDlemBoSa2Y2IxSNzIADww
         TtKLcPyivr0AX3MWvNe6O6VPGn3vDOACnIsJzzwg9N2FVWbb3Vfrz4GAa+JfUyfB0F88
         1IRQ==
X-Gm-Message-State: AA+aEWaQc0doXP088/pgZXGslzNbOrbncHO0sraOdH0r8sIpCgevWA66
        it8upqRAPZbU2Y9+Kg7slPW4LMgrS9hxnlChCw7SuA==
X-Google-Smtp-Source: AFSGD/XlndIoalqz9cWTgpiYhwZIKNjzTXwpn2Nmt73mZbxEoNTD6IDz+rQwapcFXenHykeWlqrREUkDuOCsyuguwU4=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr6990361uar.39.1544521227500;
 Tue, 11 Dec 2018 01:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de> <20181210215856.2238253-4-arnd@arndb.de>
In-Reply-To: <20181210215856.2238253-4-arnd@arndb.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Dec 2018 10:39:51 +0100
Message-ID: <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        grinberg@compulab.co.il, miquel.raynal@bootlin.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 23:00, Arnd Bergmann <arnd@arndb.de> wrote:
>
> WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> The function littleton_init_lcd() references
> the function __init pxa_set_fb_info().
> This is often because littleton_init_lcd lacks a __init
> annotation or the annotation of pxa_set_fb_info is wrong.
>
> WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> The function zeus_register_ohci() references
> the function __init pxa_set_ohci_info().
> This is often because zeus_register_ohci lacks a __init
> annotation or the annotation of pxa_set_ohci_info is wrong.
>
> WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> The function cm_x300_init_u2d() references
> the function __init pxa3xx_set_u2d_info().
> This is often because cm_x300_init_u2d lacks a __init
> annotation or the annotation of pxa3xx_set_u2d_info is wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have queued a bunch of pxa changes via my mmc tree for gpio
descriptor conversions, by Linus Walleij.

Are those causing this problem? Should I queue this one via mmc tree as well?

Kind regards
Uffe

> ---
>  arch/arm/mach-pxa/cm-x300.c   | 2 +-
>  arch/arm/mach-pxa/littleton.c | 2 +-
>  arch/arm/mach-pxa/zeus.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index 109fab292f94..b76b566280fa 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -564,7 +564,7 @@ static struct pxa3xx_u2d_platform_data cm_x300_u2d_platform_data = {
>         .exit           = cm_x300_u2d_exit,
>  };
>
> -static void cm_x300_init_u2d(void)
> +static void __init cm_x300_init_u2d(void)
>  {
>         pxa3xx_set_u2d_info(&cm_x300_u2d_platform_data);
>  }
> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
> index 8e0b60a33026..39db4898dc4a 100644
> --- a/arch/arm/mach-pxa/littleton.c
> +++ b/arch/arm/mach-pxa/littleton.c
> @@ -182,7 +182,7 @@ static struct pxafb_mach_info littleton_lcd_info = {
>         .lcd_conn               = LCD_COLOR_TFT_16BPP,
>  };
>
> -static void littleton_init_lcd(void)
> +static void __init littleton_init_lcd(void)
>  {
>         pxa_set_fb_info(NULL, &littleton_lcd_info);
>  }
> diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
> index 897ef59fbe0c..c411f79d4cb5 100644
> --- a/arch/arm/mach-pxa/zeus.c
> +++ b/arch/arm/mach-pxa/zeus.c
> @@ -576,7 +576,7 @@ static struct pxaohci_platform_data zeus_ohci_platform_data = {
>         .flags          = ENABLE_PORT_ALL | POWER_SENSE_LOW,
>  };
>
> -static void zeus_register_ohci(void)
> +static void __init zeus_register_ohci(void)
>  {
>         /* Port 2 is shared between host and client interface. */
>         UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
> --
> 2.20.0
>
