Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A2BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E1720659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D2Hqchkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E1720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeLDQNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:13:43 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37787 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:13:41 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so7183785ywc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ag8KJv7bMVAqppMOcWE9LI4B6h6caxZfAiz0kJLkjc=;
        b=D2Hqchkbby/4h5s1voyI9zV4YiI4W0RFcnQktD6hhW843ZVhVvItjDUhfFvCaj/N+z
         482tmUISjdPzjhMwyeF26mOpwook0YTx2D1qw/o45IODgKI1IPog0/tLRBq65L8EyXuX
         5p4DY9YqSQN8TR/6JDs/nh4HpVeT5spnsOSoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ag8KJv7bMVAqppMOcWE9LI4B6h6caxZfAiz0kJLkjc=;
        b=Xz0yagIWORxeSXl1IHhgUpWLNFBULze8q/nbxky3GikECZSlis+kGpo6qgaltcZo0W
         hq/iExf3XkzPlPmX+mLsfdqha3wTAFIG3itRvQI4fWMPiRtdK++AXSuPSE0ufQStELlc
         n2fFmYOluhnEayPU03zr8I7GlMW9UjUf0z1mS63kZgvdZR8ChtXiusX4OJr+Bfj6tuCD
         7ZvW16cS2FdPR+JzJYDZfICckWWwbz9kCz2y5Zwi5CORUCP4+fbue299YM/MNHhD0zJ3
         yEUThS11RzWLvKcyiiGCojR9S5JjBioOpkJcsBjWNXDwUFJbukfrW2QEwh32vu4SfjgO
         Tlhg==
X-Gm-Message-State: AA+aEWao/Ox94iyu/YTtIAPG2X03h3tVe8WgKGMgX5S1qCsB2sneEbr3
        tV8rwYnrgA7536cZGFjnw3kG8RWOlXg=
X-Google-Smtp-Source: AFSGD/Wn9B7v83p9uI++AduxE2JLiu1eBX/Zck1Jnqr0hiVvS58K2hxPOzZ4u+4uL2tw1mw2uAh4UA==
X-Received: by 2002:a81:85c5:: with SMTP id v188mr20518845ywf.51.1543940018557;
        Tue, 04 Dec 2018 08:13:38 -0800 (PST)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id l7sm6076384ywk.24.2018.12.04.08.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:13:37 -0800 (PST)
Received: by mail-yw1-f50.google.com with SMTP id j6so7171059ywj.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:13:36 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr21327974ywo.168.1543940016102;
 Tue, 04 Dec 2018 08:13:36 -0800 (PST)
MIME-Version: 1.0
References: <1543902228-23834-1-git-send-email-feng.tang@intel.com>
In-Reply-To: <1543902228-23834-1-git-send-email-feng.tang@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 4 Dec 2018 08:13:24 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJzWSE+LsuwyctS2b0RsYMKcoURkJ_nWXEhBTAcnji_3g@mail.gmail.com>
Message-ID: <CAGXu5jJzWSE+LsuwyctS2b0RsYMKcoURkJ_nWXEhBTAcnji_3g@mail.gmail.com>
Subject: Re: [PATCH v3] panic: Avoid the extra noise dmesg
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 9:42 PM Feng Tang <feng.tang@intel.com> wrote:
>
> When kernel panic happens, it will first print the panic call stack,
> then the ending msg like:
>
> [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> [   35.749975] ------------[ cut here ]------------
>
> The above message are very useful for debugging.
>
> But if system is configured to not reboot on panic, say the "panic_timeout"
> parameter equals 0, it will likely print out many noisy message like
> WARN() call stack for each and every CPU except the panic one, messages
> like below:
>
>         WARNING: CPU: 1 PID: 280 at kernel/sched/core.c:1198 set_task_cpu+0x183/0x190
>         Call Trace:
>         <IRQ>
>         try_to_wake_up
>         default_wake_function
>         autoremove_wake_function
>         __wake_up_common
>         __wake_up_common_lock
>         __wake_up
>         wake_up_klogd_work_func
>         irq_work_run_list
>         irq_work_tick
>         update_process_times
>         tick_sched_timer
>         __hrtimer_run_queues
>         hrtimer_interrupt
>         smp_apic_timer_interrupt
>         apic_timer_interrupt
>
> For people working in console mode, the screen will first show the panic
> call stack, but immediately overridded by these noisy extra messages, which
> makes debugging much more difficult, as the original context gets lost on
> screen.
>
> Also these noisy messages will confuse some users, as I have seen many bug
> reporters posted the noisy message into bugzilla, instead of the real panic
> call stack and context.
>
> Removing the "local_irq_enable" will avoid the noisy message.
>
> The justification for the removing is: when code runs to this point, it
> means user has chosed to not reboot, or do any special handling by using
> the panic notifier method, no much point in re-enabling the interrupt.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: stable@kernel.org

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/panic.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f6d549a..a616e55 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -295,7 +295,6 @@ void panic(const char *fmt, ...)
>         }
>  #endif
>         pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> -       local_irq_enable();
>         for (i = 0; ; i += PANIC_TIMER_STEP) {
>                 touch_softlockup_watchdog();
>                 if (i >= i_next) {
> --
> 2.7.4
>


-- 
Kees Cook
