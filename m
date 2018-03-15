Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeCONOr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:14:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51188 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeCONOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:14:42 -0400
X-Google-Smtp-Source: AG47ELvkZPbeQpDKcZ48hOvXeriTX/ynTkbARnPyjVWlwEEtWc/uSdob9YSFE9oL9DUJVHGBgO1pdT1I2KPheGEH6bs=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXUNVBTi9n9+LQyv8o7e-z_ck-gSWsq-hi+ANgUnnTKjA@mail.gmail.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org> <CAMuHMdXUNVBTi9n9+LQyv8o7e-z_ck-gSWsq-hi+ANgUnnTKjA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Mar 2018 14:14:40 +0100
Message-ID: <CAPDyKFp7a=oLNJ7N1=NY0D9ZwNeth9Wrb3yact_OTJ6pSPOT_A@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 March 2018 at 12:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Wed, Mar 14, 2018 at 5:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> This series is a re-worked version from Lina Iyer's two series [1] that got
>> posted more than a year ago by now. I have picked up the series and done a
>> significant re-work of it and here's the result. All patches have been changed,
>> some have been dropped, some are entirely new. For this reason I decided to not
>> include a version history, as I think people need a fresh start anyway.
>
> Thanks for your series!
>
> I gave it a try on a few Renesas boards and SoCs, without adding any new DT
> descriptions.  On all of them it triggers

Thanks a lot for testing!

>
>     BUG: sleeping function called from invalid context at
> drivers/base/power/runtime.c:1057
>
> during system suspend (s2ram).
>
> On R-Car Gen2 and SH-Mobile AG5 (arm32, no PSCI):
>
> Disabling non-boot CPUs ...
> BUG: sleeping function called from invalid context at
> drivers/base/power/runtime.c:1057
> in_atomic(): 0, irqs_disabled(): 128, pid: 1725, name: s2ram
> CPU: 0 PID: 1725 Comm: s2ram Not tainted
> 4.16.0-rc5-koelsch-00475-gaa69fc46cc44c3d7 #4001
> Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> [<c020f6a0>] (unwind_backtrace) from [<c020b324>] (show_stack+0x10/0x14)
> [<c020b324>] (show_stack) from [<c07693c8>] (dump_stack+0x7c/0x9c)
> [<c07693c8>] (dump_stack) from [<c02422ec>] (___might_sleep+0x128/0x164)
> [<c02422ec>] (___might_sleep) from [<c0508efc>] (__pm_runtime_suspend+0x70/0xa8)
> [<c0508efc>] (__pm_runtime_suspend) from [<c0299144>] (cpu_pm_enter+0x78/0x9c)
> [<c0299144>] (cpu_pm_enter) from [<c0299170>] (cpu_pm_suspend+0x8/0x18)
> [<c0299170>] (cpu_pm_suspend) from [<c04ff8c4>] (syscore_suspend+0x88/0x138)
> [<c04ff8c4>] (syscore_suspend) from [<c0263010>]
> (suspend_devices_and_enter+0x21c/0x564)
> [<c0263010>] (suspend_devices_and_enter) from [<c02635a8>]
> (pm_suspend+0x250/0x2c8)
> [<c02635a8>] (pm_suspend) from [<c0262054>] (state_store+0xac/0xcc)
> [<c0262054>] (state_store) from [<c035f238>] (kernfs_fop_write+0x170/0x1b0)
> [<c035f238>] (kernfs_fop_write) from [<c02f8a5c>] (__vfs_write+0x2c/0x140)
> [<c02f8a5c>] (__vfs_write) from [<c02f8ce4>] (vfs_write+0xb8/0x144)
> [<c02f8ce4>] (vfs_write) from [<c02f8ea4>] (SyS_write+0x54/0xac)
> [<c02f8ea4>] (SyS_write) from [<c0201000>] (ret_fast_syscall+0x0/0x4c)
> Exception stack(0xeabcbfa8 to 0xeabcbff0)
> bfa0:                   00000004 000ce408 00000001 000ce408 00000004 00000000
> bfc0: 00000004 000ce408 b6e80b50 00000004 00000004 00000000 000c5758 00000000
> bfe0: 00000000 be866754 b6de3c85 b6e1ef26
>
>
> On R-Car Gen3 (arm64, PSCI):
>
> Disabling non-boot CPUs ...
> CPU1: shutdown
> psci: CPU1 killed.
> CPU2: shutdown
> psci: CPU2 killed.
> CPU3: shutdown
> psci: CPU3 killed.
> CPU4: shutdown
> psci: CPU4 killed.
> CPU5: shutdown
> psci: CPU5 killed.
> CPU6: shutdown
> psci: CPU6 killed.
> CPU7: shutdown
> psci: CPU7 killed.
> BUG: sleeping function called from invalid context at
> drivers/base/power/runtime.c:1057
> in_atomic(): 0, irqs_disabled(): 128, pid: 2592, name: s2ram
> 4 locks held by s2ram/2592:
>  #0:  (sb_writers#7){.+.+}, at: [<00000000cae1f0e5>] vfs_write+0xb0/0x164
>  #1:  (&of->mutex){+.+.}, at: [<000000003002e527>] kernfs_fop_write+0x114/0x1bc
>  #2:  (kn->count#71){.+.+}, at: [<000000008c0217e1>]
> kernfs_fop_write+0x11c/0x1bc
>  #3:  (pm_mutex){+.+.}, at: [<000000009a6c23e2>] pm_suspend+0x194/0xb10
> irq event stamp: 69308
> hardirqs last  enabled at (69307): [<00000000e9d09767>]
> _raw_spin_unlock_irq+0x2c/0x4c
> hardirqs last disabled at (69308): [<00000000619169c4>]
> arch_suspend_disable_irqs+0x10/0x18
> softirqs last  enabled at (69246): [<00000000b8a7706e>]
> hrtimers_dead_cpu+0x2b8/0x2f0
> softirqs last disabled at (69242): [<000000004dee0c40>]
> hrtimers_dead_cpu+0x48/0x2f0
> CPU: 0 PID: 2592 Comm: s2ram Not tainted
> 4.16.0-rc5-salvator-x-00470-g319cfb3643965f46 #1685
> Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
> Call trace:
>  dump_backtrace+0x0/0x140
>  show_stack+0x14/0x1c
>  dump_stack+0xb4/0xf0
>  ___might_sleep+0x1fc/0x218
>  __might_sleep+0x70/0x80
>  __pm_runtime_suspend+0x6c/0xac
>  cpu_pm_enter+0x74/0x9c
>  cpu_pm_suspend+0xc/0x1c
>  syscore_suspend+0x1b8/0x410
>  suspend_devices_and_enter+0x210/0xd9c
>  pm_suspend+0x9a4/0xb10
>  state_store+0xd4/0xf8
>  kobj_attr_store+0x18/0x28
>  sysfs_kf_write+0x50/0x5c
>  kernfs_fop_write+0x178/0x1bc
>  __vfs_write+0x38/0x140
>  vfs_write+0xc4/0x164
>  SyS_write+0x54/0xa4
>  el0_svc_naked+0x30/0x34
>
>
> I've bisected this to "[PATCH v6 09/25] kernel/cpu_pm: Manage runtime PM
> in the idle path for CPUs".

Thanks for the report, very much appreciated!

I realized that pm_runtime_irq_safe() won't be called for CPU devices
that hasn't been hooked up to a genpd - as of_genpd_attach_cpu()
hasn't been called for them.

I figure something out for the next version on how to address this
properly, until then you may test with the following change:

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 71317ff..57250ee 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -103,7 +103,7 @@ int cpu_pm_enter(void)
                 */
                cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);

-       if (!ret && dev)
+       if (!ret && dev && pm_runtime_enabled(dev))
                pm_runtime_put_sync_suspend(dev);

        return ret;
@@ -126,7 +126,7 @@ int cpu_pm_exit(void)
 {
        struct device *dev = get_cpu_device(smp_processor_id());

-       if (dev)
+       if (dev && pm_runtime_enabled(dev))
                pm_runtime_get_sync(dev);

        return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
-- 

Kind regards
Uffe
