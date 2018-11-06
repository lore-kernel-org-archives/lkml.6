Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362F820862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362F820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbeKGBXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:23:06 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39718 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388554AbeKGBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:23:06 -0500
Received: by mail-vs1-f68.google.com with SMTP id h78so7574664vsi.6;
        Tue, 06 Nov 2018 07:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3QS7ROoMxMKBtBIA2enqXYZGYdBJQq/j1ORHN/Oz2E=;
        b=K0je9P/sxH5i0mNjRQAxZklxIfsDAly5spKigoZCUb8vutilcbRQqT0SZFVT8scB5t
         DO6vGUMcu3t/JAw8wE5uvVFn9Q00GC+07kcJRFi5v+R5DD2mQUQ8QoxURNfTAOsR9QL5
         ZE29mr1yYbE4vxEqOjg6lQ+SNI46toDSzDV8o1M57GWk87+TrWis9JPfnNY15CtSOQ8N
         2GrktFJVkitzNhWDMfGfD4cLC11NhzSoMCDR5QrqfqYKwvAQpUHKeWGiKqRCeWCPD6sJ
         bYWmexNvWXd7I8gKN/B0gtQNaaWlQj4cvPNBQy3AIt1UIwrB750y8descTAJHQq1OrbU
         8iIA==
X-Gm-Message-State: AGRZ1gLYLObVdNbxiimfIxdKKRohyqdkbPTcvPUPJqozx7h7NDw9X/fE
        oxcACeVKUTLOW+hsPcUPoDojgNxrf3xWATnh0rM=
X-Google-Smtp-Source: AJdET5eoERHD+iHuVyXY1F7Mf9feGwgEhiddIjUx1BBvDYmwQcy9aXOAVSn88G4WmSYCK1NTohif1aQrkKIiTVFfkP4=
X-Received: by 2002:a67:f43:: with SMTP id 64mr2469569vsp.166.1541519833485;
 Tue, 06 Nov 2018 07:57:13 -0800 (PST)
MIME-Version: 1.0
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
In-Reply-To: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 16:57:01 +0100
Message-ID: <CAMuHMdWTnwVeO0ihTSzaoQWPGw3HO8tiy+HARpwW9cCCXMAJPQ@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Tue, Oct 2, 2018 at 6:39 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> This patch adds one new led trigger that LED device can configure
> the software or hardware pattern and trigger it.
>
> Consumers can write 'pattern' file to enable the software pattern
> which alters the brightness for the specified duration with one
> software timer.
>
> Moreover consumers can write 'hw_pattern' file to enable the hardware
> pattern for some LED controllers which can autonomously control
> brightness over time, according to some preprogrammed hardware
> patterns.
>
> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,431 @@

> +static void pattern_trig_timer_function(struct timer_list *t)
> +{
> +       struct pattern_trig_data *data = from_timer(data, t, timer);
> +
> +       mutex_lock(&data->lock);

Timer functions run in interrupt context, hence if CONFIG_DEBUG_ATOMIC_SLEEP=y:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted
4.20.0-rc1-koelsch-00841-ga338c8181013c1a9 #171
Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
[<c020f19c>] (unwind_backtrace) from [<c020aecc>] (show_stack+0x10/0x14)
[<c020aecc>] (show_stack) from [<c07affb8>] (dump_stack+0x7c/0x9c)
[<c07affb8>] (dump_stack) from [<c02417d4>] (___might_sleep+0xf4/0x158)
[<c02417d4>] (___might_sleep) from [<c07c92c4>] (mutex_lock+0x18/0x60)
[<c07c92c4>] (mutex_lock) from [<c067b28c>]
(pattern_trig_timer_function+0x1c/0x11c)
[<c067b28c>] (pattern_trig_timer_function) from [<c027f6fc>]
(call_timer_fn+0x1c/0x90)
[<c027f6fc>] (call_timer_fn) from [<c027f944>] (expire_timers+0x94/0xa4)
[<c027f944>] (expire_timers) from [<c027fc98>] (run_timer_softirq+0x108/0x15c)
[<c027fc98>] (run_timer_softirq) from [<c02021cc>] (__do_softirq+0x1d4/0x258)
[<c02021cc>] (__do_softirq) from [<c0224d24>] (irq_exit+0x64/0xc4)
[<c0224d24>] (irq_exit) from [<c0268dd0>] (__handle_domain_irq+0x80/0xb4)
[<c0268dd0>] (__handle_domain_irq) from [<c045e1b0>] (gic_handle_irq+0x58/0x90)
[<c045e1b0>] (gic_handle_irq) from [<c02019f8>] (__irq_svc+0x58/0x74)
Exception stack(0xeb483f60 to 0xeb483fa8)
3f60: 00000000 00000000 eb9afaa0 c0217e80 00000000 ffffe000 00000000 c0e06408
3f80: 00000002 c0e0647c c0c6a5f0 00000000 c0e04900 eb483fb0 c0207ea8 c0207e98
3fa0: 60020013 ffffffff
[<c02019f8>] (__irq_svc) from [<c0207e98>] (arch_cpu_idle+0x1c/0x38)
[<c0207e98>] (arch_cpu_idle) from [<c0247ca8>] (do_idle+0x138/0x268)
[<c0247ca8>] (do_idle) from [<c0248050>] (cpu_startup_entry+0x18/0x1c)
[<c0248050>] (cpu_startup_entry) from [<402022ec>] (0x402022ec)

Either this should use a spinlock instead of a mutex, or the timer
function should kick a workqueue to do the real work.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
