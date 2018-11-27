Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33312C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99552086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DfAAuWGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99552086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeK1ETS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:19:18 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33445 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1ETR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:19:17 -0500
Received: by mail-yw1-f66.google.com with SMTP id q11so9477666ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z8QCA2FlD2t/8UHBFSqwBXDWKh9MjFMS4HzOPvOTODo=;
        b=DfAAuWGlx1XP14s2TMBi8/LKWYSXIuiW0IoALUb49KqwD6hwSc4LtmBJr8RtwRzCuv
         FmDnXFguRsA6DNd4LXeoj2mSTHp1uFjVpP6xMBzbLcbSHLT2vblWES03s3vrDhES1pmW
         j6x7nOqTofGepCuC/XTvnd/KWH9PFX1xG73Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z8QCA2FlD2t/8UHBFSqwBXDWKh9MjFMS4HzOPvOTODo=;
        b=htht9SV/wf5iQlkAqGQ09qAtWEM+BrCyGGJ48ORSj0rBjKJ6HFlTTjVifwBEFAwzhp
         7aU8naqkDJXpXKYcSWg2iH736a7IrqYXvOxA/BNy0Fv4fm2RhGwrzawcgY6qpIRAp4L7
         rtThtpPQ1MLe3jXGICburjzZfgpZadFUBq9ONBU3QGqLB1Gii0bR4Q/YHRJtRHmS6r1K
         B70chQ7BSEkOZNsKAURDUIJskoGzUXAQk3AZgEfOHdXjTdGYJcf0jEPnczBPU8Db/dYZ
         xA9KSxtd7ceR/RoiCbUc8lFo//CBijgCM7IHlUWF4OciN+dwaH/e7RYAHtPqRXLf5MY3
         AQNg==
X-Gm-Message-State: AGRZ1gL+OvvS007ExPsKfMZZvMehscWYQasyNGMz+PWUN/N4IvUxLfXj
        /Yexy1IikrYBo9BS+ejIRFvb5vdyYdk=
X-Google-Smtp-Source: AJdET5e4ZtZCQi7AFI+Ae+cNI3Q6qZh9Qs+NS8mFxmYHPf5S0wgyq321cy0FxBUALmgqzgBq2EVa/w==
X-Received: by 2002:a0d:ca84:: with SMTP id m126mr35351836ywd.59.1543339241159;
        Tue, 27 Nov 2018 09:20:41 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id e189sm1859652ywc.101.2018.11.27.09.20.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:20:40 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id i78-v6so9388038ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:20:39 -0800 (PST)
X-Received: by 2002:a25:a22a:: with SMTP id b39-v6mr20717722ybi.209.1543339239060;
 Tue, 27 Nov 2018 09:20:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:20:38
 -0800 (PST)
In-Reply-To: <1543302920-13044-1-git-send-email-feng.tang@intel.com>
References: <1543302920-13044-1-git-send-email-feng.tang@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 09:20:38 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJh2Sqny2-S4H02M1w3fmL_NaJoCu=tEafQJCQ1q1Vrvg@mail.gmail.com>
Message-ID: <CAGXu5jJh2Sqny2-S4H02M1w3fmL_NaJoCu=tEafQJCQ1q1Vrvg@mail.gmail.com>
Subject: Re: [PATCH v2] panic: Add options to print system info when panic happens
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:15 PM, Feng Tang <feng.tang@intel.com> wrote:
> Kernel panic issues are always painful to debug, partially
> because it's not easy to get enough information of the
> context when panic happens.
>
> And we have ramoops and kdump for that, while this commit
> tries to provide a easier way to show the system info by adding
> a cmdline parameter, referring some idea from sysrq handler.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


> ---
> Changelog:
>  v2:
>     - change text "dump/DUMP" to "print/PRINT" which
>       is more accurate, suggested by Andrew Morton
>     - add code to print ftrace buffer
>
>  Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
>  kernel/panic.c                                  | 28 +++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 19f4423..80c819a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3081,6 +3081,14 @@
>                         timeout < 0: reboot immediately
>                         Format: <timeout>
>
> +       panic_print=    Bitmask for printing system info when panic happens.
> +                       User can chose combination of the following bits:
> +                       bit 0: print all tasks info
> +                       bit 1: print system memory info
> +                       bit 2: print timer info
> +                       bit 3: print locks info if CONFIG_LOCKDEP is on
> +                       bit 4: print ftrace buffer
> +
>         panic_on_warn   panic() instead of WARN().  Useful to cause kdump
>                         on a WARN().
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f6d549a..fb6ccd1 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -45,6 +45,13 @@ int panic_on_warn __read_mostly;
>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>  EXPORT_SYMBOL_GPL(panic_timeout);
>
> +#define PANIC_PRINT_TASK_INFO          0x00000001
> +#define PANIC_PRINT_MEM_INFO           0x00000002
> +#define PANIC_PRINT_TIMER_INFO         0x00000004
> +#define PANIC_PRINT_LOCK_INFO          0x00000008
> +#define PANIC_PRINT_FTRACE_INFO                0x00000010
> +static unsigned long panic_print;
> +
>  ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
>
>  EXPORT_SYMBOL(panic_notifier_list);
> @@ -124,6 +131,24 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
>  }
>  EXPORT_SYMBOL(nmi_panic);
>
> +static void panic_print_sys_info(void)
> +{
> +       if (panic_print & PANIC_PRINT_TASK_INFO)
> +               show_state();
> +
> +       if (panic_print & PANIC_PRINT_MEM_INFO)
> +               show_mem(0, NULL);
> +
> +       if (panic_print & PANIC_PRINT_TIMER_INFO)
> +               sysrq_timer_list_show();
> +
> +       if (panic_print & PANIC_PRINT_LOCK_INFO)
> +               debug_show_all_locks();
> +
> +       if (panic_print & PANIC_PRINT_FTRACE_INFO)
> +               ftrace_dump(DUMP_ALL);
> +}
> +
>  /**
>   *     panic - halt the system
>   *     @fmt: The text string to print
> @@ -250,6 +275,8 @@ void panic(const char *fmt, ...)
>         debug_locks_off();
>         console_flush_on_panic();
>
> +       panic_print_sys_info();
> +
>         if (!panic_blink)
>                 panic_blink = no_blink;
>
> @@ -654,6 +681,7 @@ void refcount_error_report(struct pt_regs *regs, const char *err)
>  #endif
>
>  core_param(panic, panic_timeout, int, 0644);
> +core_param(panic_print, panic_print, ulong, 0644);
>  core_param(pause_on_oops, pause_on_oops, int, 0644);
>  core_param(panic_on_warn, panic_on_warn, int, 0644);
>  core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
> --
> 2.7.4
>



-- 
Kees Cook
