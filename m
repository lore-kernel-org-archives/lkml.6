Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeEOUTV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:19:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33523 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeEOUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:19:19 -0400
Date: Tue, 15 May 2018 22:19:16 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rick Warner <rick@microway.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bisected] rcu_sched detected stalls - 4.15 or newer kernel with
 some Xeon skylake CPUs and extended APIC
In-Reply-To: <b346f6d2-dd4e-d19b-099e-633045e88f4b@microway.com>
Message-ID: <alpine.DEB.2.21.1805152208590.1605@nanos.tec.linutronix.de>
References: <831e8a53-05d1-edfb-6287-fecfba22b8bd@microway.com> <b346f6d2-dd4e-d19b-099e-633045e88f4b@microway.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-268709719-1526415556=:1605"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-268709719-1526415556=:1605
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 15 May 2018, Rick Warner wrote:
> > I've discovered that some new Supermicro skylake systems will hang/stall
> > while booting the 4.15 kernel when extended APIC (x2apic) is enabled in
> > the BIOS. The issue happens on specific CPUs only and follows the CPUs.
> > 
> > We had (4) quad socket systems with Xeon 6134 CPUs; 2 out of 4 were
> > exhibiting this behavior.  We replaced 2 CPUs at that time and the
> > behavior was eliminated. Those systems were then shipped to our customer
> > (we are an HPC system integrator).
> > 
> > Now, we have 5 single socket systems with 5122 CPUs.  2 out of the 5 are
> > hanging.  If we swap the CPUs from the hanging systems with working
> > systems, the behavior follows the CPU.

That's weird.

> > I've done a git bisect between 4.14 and 4.15 and found this commit is
> > triggering the issue:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=023a611748fd58d46c8aa049cf4f22ebada983f5
> >

Interesting.

> > I've attached a dmesg log captured via serial console from a system
> > exhibiting this problem.  Here is an excerpt from it where the problems
> > start:

> > NMI backtrace for cpu 34

> > RIP: 0010:smp_call_function_many+0x1f1/0x204

So this waits for the IPI to be handled on some other CPU(s).

> > RSP: 0000:ffffc900000f3af0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff11
> > RAX: 0000000000000001 RBX: ffff880c110a0488 RCX: 0000000000000001
> > RDX: ffff880c10e64440 RSI: 0000000000000000 RDI: ffff880c110a0488
> > RBP: ffff880c110a0480 R08: fffffffffffffffe R09: 0000000000000003
> > R10: 0000000000000000 R11: ffffea00c03c1a60 R12: 0000000000000001
> > R13: ffff880c110a04b8 R14: 0000000000020440 R15: ffffffff81ed5400
> >   ? slub_cpu_dead+0xa0/0xa0
> >   ? slub_cpu_dead+0xa0/0xa0
> >   ? __mmu_notifier_mm_destroy+0x32/0x32
> >   on_each_cpu_mask+0x23/0x53
> >   ? slub_cpu_dead+0xa0/0xa0
> >   on_each_cpu_cond+0x7c/0x8b
> >   __kmem_cache_shrink+0x3c/0x237
> >   ? acpi_ps_delete_parse_tree+0x2d/0x59
> >   ? set_debug_rodata+0x11/0x11
> >   ? acpi_os_purge_cache+0xa/0xd
> >   acpi_os_purge_cache+0xa/0xd
> >   acpi_purge_cached_objects+0x29/0x38
> >   acpi_initialize_objects+0x46/0x4f
> >   ? acpi_sleep_init+0xd6/0xd6
> >   acpi_init+0xb6/0x324
> >   ? scan_for_dmi_ipmi+0x15/0xec
> >   ? acpi_sleep_init+0xd6/0xd6
> >   do_one_initcall+0x89/0x128
> >   ? set_debug_rodata+0x11/0x11
> >   ? set_debug_rodata+0x11/0x11
> >   kernel_init_freeable+0x112/0x18e
> >   ? rest_init+0xaa/0xaa
> >   kernel_init+0xa/0xf0
> >   ret_from_fork+0x35/0x40

> > If any other information is needed, please let me know.  I've reported
> > this issue to Supermicro already and they believe it is an issue with
> > the kernel opposed to an issue specific to their systems.  I don't have
> > any other brand Xeon skylake systems with extended APIC support that I
> > can try this with.

I can't spot an immediate fail with that commit, but I'll have a look
tomorrow for instrumenting this with tracepoints which can be dumped from
the stall detector.

Thanks,

	tglx
--8323329-268709719-1526415556=:1605--
