Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756189AbeEAQnq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:43:46 -0400
Received: from mail1.microway.com ([50.245.10.177]:45006 "EHLO microway.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753878AbeEAQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:43:44 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.d>
From: Rick Warner <rick@microway.com>
Subject: stall/hang on 4.15 kernel with some Xeon skylake CPUs and extended
 APIC
Message-ID: <831e8a53-05d1-edfb-6287-fecfba22b8bd@microway.com>
Date: Tue, 1 May 2018 12:37:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8479E6DD40DAF35647650B2B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8479E6DD40DAF35647650B2B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi All,

I've discovered that some new Supermicro skylake systems will hang/stall
while booting the 4.15 kernel when extended APIC (x2apic) is enabled in
the BIOS. The issue happens on specific CPUs only and follows the CPUs.

We had (4) quad socket systems with Xeon 6134 CPUs; 2 out of 4 were
exhibiting this behavior.  We replaced 2 CPUs at that time and the
behavior was eliminated. Those systems were then shipped to our customer
(we are an HPC system integrator).

Now, we have 5 single socket systems with 5122 CPUs.  2 out of the 5 are
hanging.  If we swap the CPUs from the hanging systems with working
systems, the behavior follows the CPU.

I've done a git bisect between 4.14 and 4.15 and found this commit is
triggering the issue:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=023a611748fd58d46c8aa049cf4f22ebada983f5

Some of the commits right before it also seemed to trigger this warning:
[    5.062563] Debug warning: early ioremap leak of 1 areas detected.
               please boot with early_ioremap_debug and report the dmesg.

I have a dmesg log of 1 commit prior to the referenced link with
early_ioremap_debug enabled if it is desired.

The latest git still has the issue.

I've attached a dmesg log captured via serial console from a system
exhibiting this problem.  Here is an excerpt from it where the problems
start:

ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
INFO: rcu_sched self-detected stall on CPU
        34-....: (14997 ticks this GP) idle=b3e/140000000000001/0
softirq=18/18 fqs=7497
INFO: rcu_sched detected stalls on CPUs/tasks:

        34-....: (14997 ticks this GP) idle=b3e/140000000000001/0
softirq=18/18 fqs=7498
 (t=15002 jiffies g=-294 c=-295 q=391)
        (detected by 0, t=15002 jiffies, g=-294, c=-295, q=391)
NMI backtrace for cpu 34
CPU: 34 PID: 1 Comm: swapper/0 Not tainted 4.15.7-gentoo-r1-netuno-x86_64 #4
Hardware name: Supermicro SYS-2049U-TR4/X11QPH+, BIOS 2.0c 02/23/2018
Call Trace:
 <IRQ>
 dump_stack+0x5d/0x79
 nmi_cpu_backtrace+0x94/0xae
 ? irq_force_complete_move+0x6f/0x6f
 nmi_trigger_cpumask_backtrace+0x56/0xd3
 rcu_dump_cpu_stacks+0x96/0xc0
 rcu_check_callbacks+0x285/0x697
 update_process_times+0x28/0x4a
 tick_handle_periodic+0x20/0x5f
 smp_apic_timer_interrupt+0x93/0xf9
 apic_timer_interrupt+0x7d/0x90
 </IRQ>
RIP: 0010:smp_call_function_many+0x1f1/0x204
RSP: 0000:ffffc900000f3af0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff11
RAX: 0000000000000001 RBX: ffff880c110a0488 RCX: 0000000000000001
RDX: ffff880c10e64440 RSI: 0000000000000000 RDI: ffff880c110a0488
RBP: ffff880c110a0480 R08: fffffffffffffffe R09: 0000000000000003
R10: 0000000000000000 R11: ffffea00c03c1a60 R12: 0000000000000001
R13: ffff880c110a04b8 R14: 0000000000020440 R15: ffffffff81ed5400
 ? slub_cpu_dead+0xa0/0xa0
 ? slub_cpu_dead+0xa0/0xa0
 ? __mmu_notifier_mm_destroy+0x32/0x32
 on_each_cpu_mask+0x23/0x53
 ? slub_cpu_dead+0xa0/0xa0
 on_each_cpu_cond+0x7c/0x8b
 __kmem_cache_shrink+0x3c/0x237
 ? acpi_ps_delete_parse_tree+0x2d/0x59
 ? set_debug_rodata+0x11/0x11
 ? acpi_os_purge_cache+0xa/0xd
 acpi_os_purge_cache+0xa/0xd
 acpi_purge_cached_objects+0x29/0x38
 acpi_initialize_objects+0x46/0x4f
 ? acpi_sleep_init+0xd6/0xd6
 acpi_init+0xb6/0x324
 ? scan_for_dmi_ipmi+0x15/0xec
 ? acpi_sleep_init+0xd6/0xd6
 do_one_initcall+0x89/0x128
 ? set_debug_rodata+0x11/0x11
 ? set_debug_rodata+0x11/0x11
 kernel_init_freeable+0x112/0x18e
 ? rest_init+0xaa/0xaa
 kernel_init+0xa/0xf0
 ret_from_fork+0x35/0x40

The NMI dump info repeats periodically after that but never progresses
further.

If any other information is needed, please let me know.  I've reported
this issue to Supermicro already and they believe it is an issue with
the kernel opposed to an issue specific to their systems.  I don't have
any other brand Xeon skylake systems with extended APIC support that I
can try this with.

Thanks,
Rick


Richard Warner
Chief Technology Officer
Microway, Inc

--------------8479E6DD40DAF35647650B2B
Content-Type: application/gzip;
 name="dmesg-hang-with-extended-APIC-enabled.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-hang-with-extended-APIC-enabled.txt.gz"

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
--------------8479E6DD40DAF35647650B2B--
