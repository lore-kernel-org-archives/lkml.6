Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966042AbeEYKDQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:03:16 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43762 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965332AbeEYKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:03:14 -0400
X-Google-Smtp-Source: ADUXVKLm3AbElPAQNTyTfDXhvs1gZMmg3jebAZe10tk9U4308hh80vjDApIw0LbYWgKDvCWWjGVZWln+1rvm+BBsvDg=
MIME-Version: 1.0
In-Reply-To: <20180525094648.15464-2-bigeasy@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de> <20180525094648.15464-2-bigeasy@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 May 2018 12:03:13 +0200
X-Google-Sender-Auth: c36UvgrgsoDGnkBU_WvcMraaAKo
Message-ID: <CAJZ5v0j8zf36HdxH-YR_jTS02tF-BF3w7f9tLjf6UJoqCPG+mQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] PM / suspend: Prevent might sleep splats
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:46 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> timekeeping suspend/resume calls read_persistent_clock() which takes
> rtc_lock. That results in might sleep warnings because at that point
> we run with interrupts disabled.
>
> We cannot convert rtc_lock to a raw spinlock as that would trigger
> other might sleep warnings.
>
> As a workaround we disable the might sleep warnings by setting
> system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
> restoring it to SYSTEM_RUNNING afer sysdev_resume().
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: cover s2idle]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/kernel.h   | 1 +
>  kernel/power/hibernate.c | 7 +++++++
>  kernel/power/suspend.c   | 6 ++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 6a1eb0b0aad9..7aed92624531 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -542,6 +542,7 @@ extern enum system_states {
>         SYSTEM_HALT,
>         SYSTEM_POWER_OFF,
>         SYSTEM_RESTART,
> +       SYSTEM_SUSPEND,
>  } system_state;
>
>  /* This cannot be an enum because some may be used in assembly source. */
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 5454cc639a8d..9c85c7822383 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -287,6 +287,8 @@ static int create_image(int platform_mode)
>
>         local_irq_disable();
>
> +       system_state = SYSTEM_SUSPEND;
> +
>         error = syscore_suspend();
>         if (error) {
>                 pr_err("Some system devices failed to power down, aborting hibernation\n");
> @@ -317,6 +319,7 @@ static int create_image(int platform_mode)
>         syscore_resume();
>
>   Enable_irqs:
> +       system_state = SYSTEM_RUNNING;
>         local_irq_enable();
>
>   Enable_cpus:
> @@ -445,6 +448,7 @@ static int resume_target_kernel(bool platform_mode)
>                 goto Enable_cpus;
>
>         local_irq_disable();
> +       system_state = SYSTEM_SUSPEND;
>
>         error = syscore_suspend();
>         if (error)
> @@ -478,6 +482,7 @@ static int resume_target_kernel(bool platform_mode)
>         syscore_resume();
>
>   Enable_irqs:
> +       system_state = SYSTEM_RUNNING;
>         local_irq_enable();
>
>   Enable_cpus:
> @@ -563,6 +568,7 @@ int hibernation_platform_enter(void)
>                 goto Enable_cpus;
>
>         local_irq_disable();
> +       system_state = SYSTEM_SUSPEND;
>         syscore_suspend();
>         if (pm_wakeup_pending()) {
>                 error = -EAGAIN;
> @@ -575,6 +581,7 @@ int hibernation_platform_enter(void)
>
>   Power_up:
>         syscore_resume();
> +       system_state = SYSTEM_RUNNING;
>         local_irq_enable();
>
>   Enable_cpus:
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 4c10be0f4843..9108a99878bf 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -110,6 +110,7 @@ static void s2idle_loop(void)
>  {
>         pm_pr_dbg("suspend-to-idle\n");
>
> +       system_state = SYSTEM_SUSPEND;

And here's the ambiguity.

For the other sleep variants SYSTEM_SUSPEND means "all devices have
been suspended, interrupts are off and there's one CPU active".

Here, device suspend has not even completed entirely.

I guess you could set system_state to SYSTEM_SUSPEND right before
calling timekeeping_suspend() in tick_freeze() and then back to
SYSTEM_RUNNING after timekeeping_resume() has returned in
tick_unfreeze(), but talk to Thomas about that first. :-)
