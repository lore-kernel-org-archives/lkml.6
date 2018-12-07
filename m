Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4737C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965EC20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeiJ5KTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965EC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLGKJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:09:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46349 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:09:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so3012199ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rKOCNsEEralVnv3+pgrH2PH46J1ohkkYhMPx2Ya9Ng=;
        b=UeiJ5KTyLGZxZ/mWK3moLQNLU2Cy9pX6FkQMhHPi44hB9WwshStTZcbERKkiOml67n
         Vk9oEDOJHRQFaR/LO5sr/FZxH+O/oUoRNJAY8+UAHbsaZz+4WWTiF5l4RIl4D3EU1Uy5
         yWt/XLJ1T592MGHLvOCulvtM9mY2SMicGD+po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rKOCNsEEralVnv3+pgrH2PH46J1ohkkYhMPx2Ya9Ng=;
        b=k0pqVo3Fr5pozp72zouAKUwOTqdbiX/H3ocr1es7q72fYlqE8NGA8wV7S1kSQduKca
         EBpIhZVSLJJuMWj35FCeumdoJFAhCVus9t3jcMLkOprJpwFnsaQs/JbFyAKz05TS9KTn
         80EozB0tHYlmelP5nU3oA2u1WF89nA/MKW9v+fqhbWMD5TniiY8I4FZ+32+1DnFbe09T
         RZWgps9x7PCl0kCeDC1MF8Tu8pb3iH9JSR9TlQgqwuIrkOmTpLF4uktT+TDoWve+p9gA
         /zl75wpM3Qlwx+z0/jQH2BrgYbpxL7mDquqshi3d7PLmXV5gLg4OX+GYKmthonTUVkTe
         EoSw==
X-Gm-Message-State: AA+aEWY5YkfsVyLdJFCzMVHzvI3JngDPJ5QJYrHYmtMfAJdwKXbqiFiw
        tw5J7f3eWztRS7jZroHZIlTVGokTy4F6YLSMIPUPeg==
X-Google-Smtp-Source: AFSGD/UdL3AMbh16kThY0+WR7FuBsM0ovtp0Tqjvu3cZuqGcNgJTKDLP2kW66i/fuMgCFPUbxZjKQYebsCewZDE2u20=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr957483ljc.66.1544177387746;
 Fri, 07 Dec 2018 02:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20181129133119.29387-1-linus.walleij@linaro.org>
In-Reply-To: <20181129133119.29387-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 11:09:35 +0100
Message-ID: <CACRpkdbKrpWQJkL=FFis39PiHxvx5zOL0gYHuYa80yYMdP8bqw@mail.gmail.com>
Subject: Re: [PATCH] irq: Request and release resources for chained IRQs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 2:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> This addresses a bug in the irqchip core that was triggered
> by new code assuming a strict semantic order of the irqchip
> calls:
>
>  .irq_request_resources()
>  .irq_enable()
>  .irq_disable()
>  .irq_release_resources()
>
> Mostly this is working fine when handled inside manage.c,
> the calls are strictly happening in the above assumed order.
>
> However on a Qualcomm platform I get the following in dmesg:
>
> WARNING: CPU: 0 PID: 1 at ../drivers/gpio/gpiolib.c:3513
>          gpiochip_irq_enable+0x18/0x44
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0
>      Not tainted 4.20.0-rc4-00002-g1b8a75b25c6e-dirty #9
> Hardware name: Generic DT based system
> [<c03124ac>] (unwind_backtrace) from [<c030d994>] (show_stack+0x10/0x14)
> [<c030d994>] (show_stack) from [<c0b48aec>] (dump_stack+0x78/0x8c)
> [<c0b48aec>] (dump_stack) from [<c03213e4>] (__warn+0xe0/0xf8)
> [<c03213e4>] (__warn) from [<c0321514>] (warn_slowpath_null+0x40/0x48)
> [<c0321514>] (warn_slowpath_null) from [<c06ad5d0>]
>              (gpiochip_irq_enable+0x18/0x44)
> [<c06ad5d0>] (gpiochip_irq_enable) from [<c0371198>] (irq_enable+0x44/0x64)
> [<c0371198>] (irq_enable) from [<c0371258>] (__irq_startup+0xa0/0xa8)
> [<c0371258>] (__irq_startup) from [<c03712ac>] (irq_startup+0x4c/0x130)
> [<c03712ac>] (irq_startup) from [<c03716d0>]
>              (irq_set_chained_handler_and_data+0x4c/0x78)
> [<c03716d0>] (irq_set_chained_handler_and_data) from [<c081c17c>]
>              (pm8xxx_probe+0x160/0x22c)
> [<c081c17c>] (pm8xxx_probe) from [<c07f439c>] (platform_drv_probe+0x48/0x98)
>
> What happens is that when the pm8xxx driver tries to register
> a chained IRQ irq_set_chained_handler_and_data() will eventually
> set the type and call irq_startup() and thus the .irq_enable()
> callback on the irqchip.
>
> This irqchip is in drivers/pinctrl/qcom/pinctrl-msm.c and known
> as TLMM.
>
> However, the irqchip core helpers in GPIO assumes that
> the .irq_request_resources() callback is always called before
> .irq_enable(), and the latter is where module refcount and
> also gpiochip_lock_as_irq() is normally called.
>
> When .irq_enable() is called without .irq_request_resources()
> having been called first, it seems like we are enabling
> an IRQ on a GPIO line that has not first been locked to be
> used as IRQ and we get the above warning. This happens since
> as of
> commit 461c1a7d4733d ("gpiolib: override irq_enable/disable")
> this is strictly assumed for all GPIO-based IRQs.
>
> As it seems reasonable to assume that .irq_request_resources()
> is always strictly called before .irq_enable(), we add the
> irq_[request|release]_resources() functions to the internal
> API and call them also when adding a chained irqchip to
> an IRQ.
>
> I am a bit uncertain about the call site for
> irq_released_resources() inside chip.c, but it appears this
> path is for uninstalling a chained handler.
>
> Cc: stable@vger.kernel.org
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Fixes: 461c1a7d4733d ("gpiolib: override irq_enable/disable")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

IRQ folks: did you have time to look at this?

It's a very real regression for me.

Yours,
Linus Walleij
