Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7CD20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EogAe5XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7CD20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbeKGMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:52:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41838 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:52:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so10443829lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 19:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kCgTO/s0665b6qaKTlfUQY/pOagUo2u8AfR5Wyh2tWo=;
        b=EogAe5XHSWI9SeDnE80BUFFtvwR1hdAcO2b9IoTbVBPg689Cm8meT4KwYmehH5aI97
         PHT41hJwuAbE85c5G17FsYn/TnlA0MukJyPfSF3d3y+UZpPihmsU+tix3VCmtl4rF9yI
         zvyzEBsJEWvhxqO9s5uCbFdfHHznI47T5ZosA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kCgTO/s0665b6qaKTlfUQY/pOagUo2u8AfR5Wyh2tWo=;
        b=h9WtfZY2D0nbeCSBLT+aEYN59+ndxpavdJoC0R79ieuN65F+ucEs/Q98569MEBVf/i
         9jgop809IddWj8S2AQFW+U9WLpICyJzVHwXVtjiy0EkBq+edgHLvYdeILUl3VPt3SZYA
         5f0N/awsypPnGWRszbtehbJ6r3BE0ZS6TB10QdQKONUAnxSQIYoTjQAVN1fJpYGbXKkV
         tM+sqGSbUQ+82kgssX3dVuxEqWBWgwU9mTMESDXfm477Pr3SjAi0l/cqUO1KI0a9eWJg
         DJQv7yZ8CSW1E6AfA9aIyXCPdXO+AFoUZ++tWCA756wDKwdzDgPXDe/VGUg38+tAF2Ml
         e6rA==
X-Gm-Message-State: AGRZ1gLkdVdE/MCrWmUoUKb5paUI7GMCDL8dRV4YS7A7F9KotVstO7AX
        +EhDIlZ3AENbGjMIeM6YKO+HU83yRVK9fgxJtDWibw==
X-Google-Smtp-Source: AJdET5fHsXfzLc0s4X+z/AlP3p4wZ0Umo8ozkDu8zBxK4OZo44uitB5OdoD8P2uv8HCTJ1wT2toQiiY/P9NDliYcQes=
X-Received: by 2002:a19:54d7:: with SMTP id b84mr70390lfl.131.1541561032602;
 Tue, 06 Nov 2018 19:23:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:95ca:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 19:23:52 -0800 (PST)
In-Reply-To: <CAMuHMdWTnwVeO0ihTSzaoQWPGw3HO8tiy+HARpwW9cCCXMAJPQ@mail.gmail.com>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
 <CAMuHMdWTnwVeO0ihTSzaoQWPGw3HO8tiy+HARpwW9cCCXMAJPQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 7 Nov 2018 11:23:52 +0800
Message-ID: <CAMz4kuKZ5z-v_j5Fhu=QzwY-=U6SBy4uSWoT8G8U83Z2qBRLxA@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 6 November 2018 at 23:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Baolin,
>
> On Tue, Oct 2, 2018 at 6:39 PM Baolin Wang <baolin.wang@linaro.org> wrote:
>> This patch adds one new led trigger that LED device can configure
>> the software or hardware pattern and trigger it.
>>
>> Consumers can write 'pattern' file to enable the software pattern
>> which alters the brightness for the specified duration with one
>> software timer.
>>
>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>> pattern for some LED controllers which can autonomously control
>> brightness over time, according to some preprogrammed hardware
>> patterns.
>>
>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
>> --- /dev/null
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -0,0 +1,431 @@
>
>> +static void pattern_trig_timer_function(struct timer_list *t)
>> +{
>> +       struct pattern_trig_data *data = from_timer(data, t, timer);
>> +
>> +       mutex_lock(&data->lock);
>
> Timer functions run in interrupt context, hence if CONFIG_DEBUG_ATOMIC_SLEEP=y:
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
> [<c07c92c4>] (mutex_lock) from [<c067b28c>]
> (pattern_trig_timer_function+0x1c/0x11c)
> [<c067b28c>] (pattern_trig_timer_function) from [<c027f6fc>]
> (call_timer_fn+0x1c/0x90)
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
> Either this should use a spinlock instead of a mutex, or the timer
> function should kick a workqueue to do the real work.
>

Ah, sorry I missed this. Good catch.

After more thinking, the easy fix is that I think we can remove the
mutex lock in pattern_trig_timer_function(). Since the mutex lock is
used to protect the pattern trigger data, but before changing new
pattern trigger data (pattern values or repeat value) by users, we
always cancel the timer firstly to clear previous patterns'
performance. That means there is no race in
pattern_trig_timer_function(), so we can drop the mutex lock in
pattern_trig_timer_function() to avoid this issue.

I will send one patch to fix this issue. Thanks.

-- 
Baolin Wang
Best Regards
