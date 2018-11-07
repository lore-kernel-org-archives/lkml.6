Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6721C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722C2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8722C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeKGR2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:28:52 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39952 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:28:52 -0500
Received: by mail-vk1-f194.google.com with SMTP id v70so3499234vkv.7;
        Tue, 06 Nov 2018 23:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8F/XueKnoyC/zw8ECGiy8cprJXWkaCvyVKJfxcQV1I=;
        b=FL+Yi7yXfwjHJpwZ0NXsdomsDWS1DrtVV3WzfLYRFKF6xFmi+yjrtiLV1w1mEKceJi
         YNH9nyHqnY4XoOmQNe/BlV0TrcZ/InawigIIzFS/IoN0QGoBkoyZ4PaZDtLjP2Vp6Xek
         Fm4aiFnQCjQ3I7H8fQuxUprwLQtweCcx9S4x9crW9/C3+51F2eXlT01dAtBFOYjzFbqt
         PxGRKmXC/9G6H+Yb36WIOKxkeYLaJOMaPEMQAYnqgrlVH/VEONKsOGP5WfnBkwima1Zh
         wg87dPLhx7iRruLhyhNMaxK67PT4OMBN8VEAHIjM28R6QvLy0uh59doFLvoHlrQebLZW
         U86Q==
X-Gm-Message-State: AGRZ1gJ4Av22gS0BWbLQNy2eu+AiJlC4y6JS7QB8SKmZE2Sl0XpXmYjm
        iyE9sCKdvIH7GWA2SChp3TCvD/845ixZGKhXVeskjR4N
X-Google-Smtp-Source: AJdET5exCw/7UFsRqtAogCPqKmiCq/hO1e62VyDBnoVDhjhM4wPT700bYkFNFR7GkWYGjsIHfZKPx9SqvwtC3xvK2U0=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr320779vkh.65.1541577578694;
 Tue, 06 Nov 2018 23:59:38 -0800 (PST)
MIME-Version: 1.0
References: <5f1cfb9c87f591b12efa2e7a0063f15532649634.1541563908.git.baolin.wang@linaro.org>
In-Reply-To: <5f1cfb9c87f591b12efa2e7a0063f15532649634.1541563908.git.baolin.wang@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Nov 2018 08:59:26 +0100
Message-ID: <CAMuHMdVUnH7ubtLOHAt1uLFOqqeAy60LvoWaWLiJx0gf8PWhSg@mail.gmail.com>
Subject: Re: [PATCH] leds: trigger: Fix sleeping function called from invalid context
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Wed, Nov 7, 2018 at 6:43 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> We will meet below issue due to mutex_lock() is called in interrupt context.
> The mutex lock is used to protect the pattern trigger data, but before changing
> new pattern trigger data (pattern values or repeat value) by users, we always
> cancel the timer firstly to clear previous patterns' performance. That means
> there is no race in pattern_trig_timer_function(), so we can drop the mutex
> lock in pattern_trig_timer_function() to avoid this issue.
>
> Moreover we can move the timer cancelling into mutex protection, since there
> is no deadlock risk if we remove the mutex lock in pattern_trig_timer_function().
>
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
> in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/1
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted
> 4.20.0-rc1-koelsch-00841-ga338c8181013c1a9 #171
> Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> [<c020f19c>] (unwind_backtrace) from [<c020aecc>] (show_stack+0x10/0x14)
> [<c020aecc>] (show_stack) from [<c07affb8>] (dump_stack+0x7c/0x9c)
> [<c07affb8>] (dump_stack) from [<c02417d4>] (___might_sleep+0xf4/0x158)
> [<c02417d4>] (___might_sleep) from [<c07c92c4>] (mutex_lock+0x18/0x60)
> [<c07c92c4>] (mutex_lock) from [<c067b28c>] (pattern_trig_timer_function+0x1c/0x11c)
> [<c067b28c>] (pattern_trig_timer_function) from [<c027f6fc>] (call_timer_fn+0x1c/0x90)
> [<c027f6fc>] (call_timer_fn) from [<c027f944>] (expire_timers+0x94/0xa4)
> [<c027f944>] (expire_timers) from [<c027fc98>] (run_timer_softirq+0x108/0x15c)
> [<c027fc98>] (run_timer_softirq) from [<c02021cc>] (__do_softirq+0x1d4/0x258)
> [<c02021cc>] (__do_softirq) from [<c0224d24>] (irq_exit+0x64/0xc4)
> [<c0224d24>] (irq_exit) from [<c0268dd0>] (__handle_domain_irq+0x80/0xb4)
> [<c0268dd0>] (__handle_domain_irq) from [<c045e1b0>] (gic_handle_irq+0x58/0x90)
> [<c045e1b0>] (gic_handle_irq) from [<c02019f8>] (__irq_svc+0x58/0x74)
> Exception stack(0xeb483f60 to 0xeb483fa8)
> 3f60: 00000000 00000000 eb9afaa0 c0217e80 00000000 ffffe000 00000000 c0e06408
> 3f80: 00000002 c0e0647c c0c6a5f0 00000000 c0e04900 eb483fb0 c0207ea8 c0207e98
> 3fa0: 60020013 ffffffff
> [<c02019f8>] (__irq_svc) from [<c0207e98>] (arch_cpu_idle+0x1c/0x38)
> [<c0207e98>] (arch_cpu_idle) from [<c0247ca8>] (do_idle+0x138/0x268)
> [<c0247ca8>] (do_idle) from [<c0248050>] (cpu_startup_entry+0x18/0x1c)
> [<c0248050>] (cpu_startup_entry) from [<402022ec>] (0x402022ec)
>
> Fixes: 5fd752b6b3a2 ("leds: core: Introduce LED pattern trigger")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Thanks!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
