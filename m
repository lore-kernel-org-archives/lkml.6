Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeEOQIC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:08:02 -0400
Received: from mail1.microway.com ([50.245.10.177]:41480 "EHLO microway.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753546AbeEOQH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:07:58 -0400
Subject: [bisected] rcu_sched detected stalls - 4.15 or newer kernel with some
 Xeon skylake CPUs and extended APIC
From: Rick Warner <rick@microway.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <831e8a53-05d1-edfb-6287-fecfba22b8bd@microway.com>
Message-ID: <b346f6d2-dd4e-d19b-099e-633045e88f4b@microway.com>
Date: Tue, 15 May 2018 12:07:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <831e8a53-05d1-edfb-6287-fecfba22b8bd@microway.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Does anyone have ideas on this?  Is there any other data I can provide 
to help debug this?

Thanks,
Rick

On 05/01/2018 12:37 PM, Rick Warner wrote:
> Hi All,
>
> I've discovered that some new Supermicro skylake systems will hang/stall
> while booting the 4.15 kernel when extended APIC (x2apic) is enabled in
> the BIOS. The issue happens on specific CPUs only and follows the CPUs.
>
> We had (4) quad socket systems with Xeon 6134 CPUs; 2 out of 4 were
> exhibiting this behavior.  We replaced 2 CPUs at that time and the
> behavior was eliminated. Those systems were then shipped to our customer
> (we are an HPC system integrator).
>
> Now, we have 5 single socket systems with 5122 CPUs.  2 out of the 5 are
> hanging.  If we swap the CPUs from the hanging systems with working
> systems, the behavior follows the CPU.
>
> I've done a git bisect between 4.14 and 4.15 and found this commit is
> triggering the issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=023a611748fd58d46c8aa049cf4f22ebada983f5
>
> Some of the commits right before it also seemed to trigger this warning:
> [    5.062563] Debug warning: early ioremap leak of 1 areas detected.
>                 please boot with early_ioremap_debug and report the dmesg.
>
> I have a dmesg log of 1 commit prior to the referenced link with
> early_ioremap_debug enabled if it is desired.
>
> The latest git still has the issue.
>
> I've attached a dmesg log captured via serial console from a system
> exhibiting this problem.  Here is an excerpt from it where the problems
> start:
>
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> INFO: rcu_sched self-detected stall on CPU
>          34-....: (14997 ticks this GP) idle=b3e/140000000000001/0
> softirq=18/18 fqs=7497
> INFO: rcu_sched detected stalls on CPUs/tasks:
>
>          34-....: (14997 ticks this GP) idle=b3e/140000000000001/0
> softirq=18/18 fqs=7498
>   (t=15002 jiffies g=-294 c=-295 q=391)
>          (detected by 0, t=15002 jiffies, g=-294, c=-295, q=391)
> NMI backtrace for cpu 34
> CPU: 34 PID: 1 Comm: swapper/0 Not tainted 4.15.7-gentoo-r1-netuno-x86_64 #4
> Hardware name: Supermicro SYS-2049U-TR4/X11QPH+, BIOS 2.0c 02/23/2018
> Call Trace:
>   <IRQ>
>   dump_stack+0x5d/0x79
>   nmi_cpu_backtrace+0x94/0xae
>   ? irq_force_complete_move+0x6f/0x6f
>   nmi_trigger_cpumask_backtrace+0x56/0xd3
>   rcu_dump_cpu_stacks+0x96/0xc0
>   rcu_check_callbacks+0x285/0x697
>   update_process_times+0x28/0x4a
>   tick_handle_periodic+0x20/0x5f
>   smp_apic_timer_interrupt+0x93/0xf9
>   apic_timer_interrupt+0x7d/0x90
>   </IRQ>
> RIP: 0010:smp_call_function_many+0x1f1/0x204
> RSP: 0000:ffffc900000f3af0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff11
> RAX: 0000000000000001 RBX: ffff880c110a0488 RCX: 0000000000000001
> RDX: ffff880c10e64440 RSI: 0000000000000000 RDI: ffff880c110a0488
> RBP: ffff880c110a0480 R08: fffffffffffffffe R09: 0000000000000003
> R10: 0000000000000000 R11: ffffea00c03c1a60 R12: 0000000000000001
> R13: ffff880c110a04b8 R14: 0000000000020440 R15: ffffffff81ed5400
>   ? slub_cpu_dead+0xa0/0xa0
>   ? slub_cpu_dead+0xa0/0xa0
>   ? __mmu_notifier_mm_destroy+0x32/0x32
>   on_each_cpu_mask+0x23/0x53
>   ? slub_cpu_dead+0xa0/0xa0
>   on_each_cpu_cond+0x7c/0x8b
>   __kmem_cache_shrink+0x3c/0x237
>   ? acpi_ps_delete_parse_tree+0x2d/0x59
>   ? set_debug_rodata+0x11/0x11
>   ? acpi_os_purge_cache+0xa/0xd
>   acpi_os_purge_cache+0xa/0xd
>   acpi_purge_cached_objects+0x29/0x38
>   acpi_initialize_objects+0x46/0x4f
>   ? acpi_sleep_init+0xd6/0xd6
>   acpi_init+0xb6/0x324
>   ? scan_for_dmi_ipmi+0x15/0xec
>   ? acpi_sleep_init+0xd6/0xd6
>   do_one_initcall+0x89/0x128
>   ? set_debug_rodata+0x11/0x11
>   ? set_debug_rodata+0x11/0x11
>   kernel_init_freeable+0x112/0x18e
>   ? rest_init+0xaa/0xaa
>   kernel_init+0xa/0xf0
>   ret_from_fork+0x35/0x40
>
> The NMI dump info repeats periodically after that but never progresses
> further.
>
> If any other information is needed, please let me know.  I've reported
> this issue to Supermicro already and they believe it is an issue with
> the kernel opposed to an issue specific to their systems.  I don't have
> any other brand Xeon skylake systems with extended APIC support that I
> can try this with.
>
> Thanks,
> Rick
>
>
> Richard Warner
> Chief Technology Officer
> Microway, Inc
