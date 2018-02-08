Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeBHRym (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:54:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38268 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbeBHRyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:54:40 -0500
Date: Thu, 8 Feb 2018 17:54:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Salter <msalter@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_pmu_acpi: Fix armpmu_alloc call from invalid
 context
Message-ID: <20180208175433.p2a3g2q7tctfpk7c@lakrids.cambridge.arm.com>
References: <20180208174504.30665-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208174504.30665-1-msalter@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Feb 08, 2018 at 12:45:04PM -0500, Mark Salter wrote:
> When booting an arm64 debug kernel with ACPI, I see:
> 
>    BUG: sleeping function called from invalid context at mm/slab.h:420
>    in_atomic(): 0, irqs_disabled(): 128, pid: 12, name: cpuhp/0
>    1 lock held by cpuhp/0/12:
>     #0:  (cpuhp_state-up){+.+.}, at: [<0000000057aa0dae>] cpuhp_thread_fun+0x13c/0x258
>    irq event stamp: 28
>    hardirqs last  enabled at (27): [<000000000b861658>] _raw_spin_unlock_irq+0x38/0x58
>    hardirqs last disabled at (28): [<000000006231cfb1>] cpuhp_thread_fun+0xd0/0x258
>    softirqs last  enabled at (0): [<0000000054d9737a>] copy_process.isra.32.part.33+0x450/0x1480
>    softirqs last disabled at (0): [<          (null)>]           (null)
>    CPU: 0 PID: 12 Comm: cpuhp/0 Not tainted 4.15.0+ #18
>    Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.25 Oct 17 2016
>    Call trace:
>     dump_backtrace+0x0/0x188
>     show_stack+0x24/0x2c
>     dump_stack+0xa4/0xe0
>     ___might_sleep+0x208/0x234
>     __might_sleep+0x58/0x8c
>     kmem_cache_alloc_trace+0x248/0x3e0
>     armpmu_alloc+0x38/0x1a8
>     arm_pmu_acpi_cpu_starting+0x11c/0x15c
>     cpuhp_invoke_callback+0x120/0x100c
>     cpuhp_thread_fun+0xe8/0x258
>     smpboot_thread_fn+0x170/0x268
>     kthread+0x110/0x13c
>     ret_from_fork+0x10/0x18

I have patches to address this:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/557838.html
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/acpi-pmu-lockdep

> With commit 7d88eb695a1f ("arm/perf: Convert to hotplug state machine"),
> arm_pmu uses the cpuhotplug framework to initialize the PMU driver when
> using ACPI. However, the arm_pmu_acpi_cpu_starting() callback comes
> before CPUHP_AP_ONLINE is reached which means it runs with interrupts
> diabled and tries to allocate memory with GFP_KERNEL alloc which may
> sleep.
> 
> Move CPUHP_AP_PERF_ARM_ACPI_STARTING to come after CPUHP_AP_ONLINE so
> that the arm_pmu initialization runs with interrupts enabled as it
> does when booting with device tree.
> 
> Fixes: 7d88eb695a1f ("arm/perf: Convert to hotplug state machine")
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  include/linux/cpuhotplug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 5172ad0..e07b2da 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -114,7 +114,6 @@ enum cpuhp_state {
>  	CPUHP_AP_ARM_VFP_STARTING,
>  	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
>  	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
> -	CPUHP_AP_PERF_ARM_ACPI_STARTING,
>  	CPUHP_AP_PERF_ARM_STARTING,
>  	CPUHP_AP_ARM_L2X0_STARTING,
>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
> @@ -146,6 +145,7 @@ enum cpuhp_state {
>  	CPUHP_AP_SMPBOOT_THREADS,
>  	CPUHP_AP_X86_VDSO_VMA_ONLINE,
>  	CPUHP_AP_IRQ_AFFINITY_ONLINE,
> +	CPUHP_AP_PERF_ARM_ACPI_STARTING,

We need CPUHP_AP_PERF_ARM_ACPI_STARTING to happen before
CPUHP_AP_PERF_ARM_STARTING, and I think this re-ordering prevents us
from correctly resetting the PMU and enabling percpu interrupts, at
least in heterogeneous configurations (e.g. big.LITTLE systems like
Juno).

I'm not sure whether we could safely move both callbacks this late.

Thanks,
Mark.
