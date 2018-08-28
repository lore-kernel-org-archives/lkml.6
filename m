Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5008CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E652087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c6CmulHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E652087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeH2DWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:22:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37192 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH2DWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:22:54 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7SNSh3r088559;
        Tue, 28 Aug 2018 18:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535498923;
        bh=u6v6LvV34aframfp6QtLh0HAM2ylyBexG+9YmBuqfMA=;
        h=To:From:Subject:CC:Date;
        b=c6CmulHvTQfDD/3eThtjYphG8+46nQpZfPyjsROaBkWejxh3sePgGaG/D1ysOYXIa
         WqBY1wRsjk22Q4JmwiWcocjGTD3ipr1JFL0l0oplfheguTl/j5CM8AzmDdXE5IPO4n
         yfHiU1aMyoY87ZJf1dU7z07opAtSKxl9d9fWQbsY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SNShhG032135;
        Tue, 28 Aug 2018 18:28:43 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 28
 Aug 2018 18:28:42 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 28 Aug 2018 18:28:42 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SNSgZN008355;
        Tue, 28 Aug 2018 18:28:42 -0500
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function called
 from invalid context at kernel/locking/rtmutex.c:974
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
Date:   Tue, 28 Aug 2018 18:28:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I can see below back traces during secondary CPUs initialization (boot) on TI's AM6 SoC (ARM64 4 CPUs)
with debug options enabled it happens without CONFIG_NUMA=n (log 1) and with CONFIG_NUMA=y.
This is TI branch, there are no RT specific changes.

I've also found the similar issue was reported by Mike Galbraith [1]

[1] https://www.spinics.net/lists/linux-rt-users/msg19058.html

===== Log 1 =====
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.66-rt40-02415-g6a801ed-dirty (a0226610local@uda0226610) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5 SMP PREEMPT RT Mon Aug 27 21:04:26 CDT 2018
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] Machine model: Texas Instruments AM654 Base Board
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000002800000 (options '')
[    0.000000] bootconsole [ns16550a0] enabled
[    0.000000] cma: Reserved 512 MiB at 0x00000000c0000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 2 pages/cpu @ffff80087feb0000 s55504 r8192 d67376 u131072
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65088
[    0.000000] Kernel command line: console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000 mtdparts=47040000.ospi.0:512k(ospi.tiboot3),2m(ospi.tispl),5m(ospi.u-boot),128k(ospi.env),-@8m(ospi.rootfs) root=PARTUUID=f2c6fe8e-0t
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 9, 33554432 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
[    0.000000] software IO TLB [mem 0xf9dd0000-0xfddd0000] (64MB) mapped at [ffff800079dd0000-ffff80007ddcffff]
[    0.000000] Memory: 3511168K/4169728K available (7806K kernel code, 1000K rwdata, 3008K rodata, 512K init, 14066K bss, 134272K reserved, 524288K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000   (126847 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008820000   (  7808 KB)
[    0.000000]     .rodata : 0xffff000008820000 - 0xffff000008b20000   (  3072 KB)
[    0.000000]       .init : 0xffff000008b20000 - 0xffff000008ba0000   (   512 KB)
[    0.000000]       .data : 0xffff000008ba0000 - 0xffff000008c9a008   (  1001 KB)
[    0.000000]        .bss : 0xffff000008c9a008 - 0xffff000009a56af0   ( 14067 KB)
[    0.000000]     fixed   : 0xffff7fdffe7b0000 - 0xffff7fdffec00000   (  4416 KB)
[    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000   (   128 GB maximum)
[    0.000000]               0xffff7fe000000000 - 0xffff7fe002200000   (    34 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800880000000   ( 34816 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU event tracing is enabled.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000]  RCU priority boosting: priority 1 delay 500 ms.
[    0.000000]  RCU callback double-/use-after-free debug enabled.
[    0.000000]  No expedited grace period (rcu_normal_after_boot).
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] ITS [mem 0x01820000-0x0182ffff]
[    0.000000] GIC: enabling workaround for ITS: Socionext Synquacer pre-ITS
[    0.000000] ITS@0x0000000001820000: allocated 1048576 Devices @8fc000000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GIC: using LPI property table @0x00000008fd730000
[    0.000000] ITS: Allocated 1792 chunks for LPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000001880000
[    0.000000] CPU0: using LPI pending table @0x00000008ffd80000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] arch_timer: cp15 timer(s) running at 200.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2e2049d3e8, max_idle_ns: 440795210634 ns
[    0.000007] sched_clock: 56 bits at 200MHz, resolution 5ns, wraps every 4398046511102ns
[    0.000811] Console: colour dummy device 80x25
[    0.392008] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.392013] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.392016] ... MAX_LOCK_DEPTH:          48
[    0.392020] ... MAX_LOCKDEP_KEYS:        8191
[    0.392024] ... CLASSHASH_SIZE:          4096
[    0.392027] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.392031] ... MAX_LOCKDEP_CHAINS:      65536
[    0.392034] ... CHAINHASH_SIZE:          32768
[    0.392038]  memory used by lock dependency info: 7391 kB
[    0.392041]  per task-struct memory footprint: 1920 bytes
[    0.393633] Calibrating delay loop (skipped), value calculated using timer frequency.. 400.00 BogoMIPS (lpj=800000)
[    0.393652] pid_max: default: 32768 minimum: 301
[    0.394444] Security Framework initialized
[    0.394724] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.394770] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.418449] ASID allocator initialised with 32768 entries
[    0.522829] Hierarchical SRCU implementation.
[    0.553963] PCI/MSI: /soc0/interrupt-controller@1800000/gic-its@1000000 domain created
[    0.562559] Platform MSI: /soc0/interrupt-controller@1800000/gic-its@1000000 domain created
[    0.579342] smp: Bringing up secondary CPUs ...
[    0.625109] Detected VIPT I-cache on CPU1
[    0.625149] GICv3: CPU1: found redistributor 1 region 0:0x00000000018a0000
[    0.625176] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[    0.625182] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
[    0.625189] 1 lock held by swapper/1/0:
[    0.625193]  #0:  ((pa_lock).lock){+.+.}, at: [<ffff0000081a73e8>] get_page_from_freelist+0x160/0xd20
[    0.625228] irq event stamp: 0
[    0.625233] hardirqs last  enabled at (0): [<          (null)>]           (null)
[    0.625246] hardirqs last disabled at (0): [<ffff0000080c2f50>] copy_process.isra.5.part.6+0x2c0/0x18a8
[    0.625255] softirqs last  enabled at (0): [<ffff0000080c2f50>] copy_process.isra.5.part.6+0x2c0/0x18a8
[    0.625260] softirqs last disabled at (0): [<          (null)>]           (null)
[    0.625263] Preemption disabled at:
[    0.625274] [<ffff0000080909b8>] secondary_start_kernel+0x80/0x118
[    0.625286] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.66-rt40-02415-g6a801ed-dirty #5
[    0.625290] Hardware name: Texas Instruments AM654 Base Board (DT)
[    0.625295] Call trace:
[    0.625306] [<ffff000008089d60>] dump_backtrace+0x0/0x400
[    0.625313] [<ffff00000808a174>] show_stack+0x14/0x20
[    0.625324] [<ffff0000087db658>] dump_stack+0xac/0xe4
[    0.625333] [<ffff0000080f26b4>] ___might_sleep+0x154/0x228
[    0.625342] [<ffff0000087f291c>] rt_spin_lock+0x5c/0x70
[    0.625350] [<ffff0000081a73e8>] get_page_from_freelist+0x160/0xd20
[    0.625359] [<ffff0000081a8804>] __alloc_pages_nodemask+0xe4/0xc68
[    0.625368] [<ffff00000845bb10>] its_allocate_pending_table+0x68/0xa8
[    0.625375] [<ffff00000845e5b4>] its_cpu_init+0x294/0x374
[    0.625382] [<ffff00000845b4a4>] gic_cpu_init.part.6+0x15c/0x170
[    0.625388] [<ffff00000845b4cc>] gic_starting_cpu+0x14/0x20
[    0.625396] [<ffff0000080c5ad4>] cpuhp_invoke_callback+0x9c/0x260
[    0.625404] [<ffff0000080c7c38>] notify_cpu_starting+0x70/0xa8
[    0.625412] [<ffff0000080909e4>] secondary_start_kernel+0xac/0x118

===== Log 2 =====
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.66-rt40-02415-g6a801ed-dirty (a0226610local@uda0226610) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #4 SMP PREEMPT RT Mon Aug 27 20:44:32 CDT 2018
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] Machine model: Texas Instruments AM654 Base Board
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000002800000 (options '')
[    0.000000] bootconsole [ns16550a0] enabled
[    0.000000] cma: Reserved 512 MiB at 0x00000000c0000000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000008ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8ffffdc80-0x8fffffc7f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009e7fffff]
[    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000008ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 2 pages/cpu @ffff80087feb0000 s55760 r8192 d67120 u131072
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65088
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000 mtdparts=47040000.ospi.0:512k(ospi.tiboot3),2m(ospi.tispl),5m(ospi.u-boot),128k(ospi.env),-@8m(ospi.rootfs) root=PARTUUID=f2c6fe8e-0t
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] software IO TLB [mem 0xf9dd0000-0xfddd0000] (64MB) mapped at [ffff800079dd0000-ffff80007ddcffff]
[    0.000000] Memory: 3545856K/4169728K available (7870K kernel code, 1062K rwdata, 3008K rodata, 512K init, 14071K bss, 99584K reserved, 524288K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000   (126847 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008830000   (  7872 KB)
[    0.000000]     .rodata : 0xffff000008830000 - 0xffff000008b30000   (  3072 KB)
[    0.000000]       .init : 0xffff000008b30000 - 0xffff000008bb0000   (   512 KB)
[    0.000000]       .data : 0xffff000008bb0000 - 0xffff000008cb9808   (  1063 KB)
[    0.000000]        .bss : 0xffff000008cb9808 - 0xffff000009a775f0   ( 14072 KB)
[    0.000000]     fixed   : 0xffff7fdffe7b0000 - 0xffff7fdffec00000   (  4416 KB)
[    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000   (   128 GB maximum)
[    0.000000]               0xffff7fe000000000 - 0xffff7fe002200000   (    34 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800880000000   ( 34816 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU event tracing is enabled.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000]  RCU priority boosting: priority 1 delay 500 ms.
[    0.000000]  RCU callback double-/use-after-free debug enabled.
[    0.000000]  No expedited grace period (rcu_normal_after_boot).
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] ITS [mem 0x01820000-0x0182ffff]
[    0.000000] GIC: enabling workaround for ITS: Socionext Synquacer pre-ITS
[    0.000000] ITS@0x0000000001820000: allocated 1048576 Devices @8ff000000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GIC: using LPI property table @0x00000008ff930000
[    0.000000] ITS: Allocated 1792 chunks for LPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000001880000
[    0.000000] CPU0: using LPI pending table @0x00000008ffd80000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] arch_timer: cp15 timer(s) running at 200.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2e2049d3e8, max_idle_ns: 440795210634 ns
[    0.000006] sched_clock: 56 bits at 200MHz, resolution 5ns, wraps every 4398046511102ns
[    0.000803] Console: colour dummy device 80x25
[    0.447578] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.447582] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.447586] ... MAX_LOCK_DEPTH:          48
[    0.447589] ... MAX_LOCKDEP_KEYS:        8191
[    0.447592] ... CLASSHASH_SIZE:          4096
[    0.447596] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.447600] ... MAX_LOCKDEP_CHAINS:      65536
[    0.447603] ... CHAINHASH_SIZE:          32768
[    0.447606]  memory used by lock dependency info: 7391 kB
[    0.447610]  per task-struct memory footprint: 1920 bytes
[    0.449497] Calibrating delay loop (skipped), value calculated using timer frequency.. 400.00 BogoMIPS (lpj=800000)
[    0.449521] pid_max: default: 32768 minimum: 301
[    0.450213] Security Framework initialized
[    0.465026] Dentry cache hash table entries: 524288 (order: 9, 33554432 bytes)
[    0.665565] Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
[    0.665800] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.665855] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.689219] ASID allocator initialised with 32768 entries
[    0.809703] Hierarchical SRCU implementation.
[    0.840914] PCI/MSI: /soc0/interrupt-controller@1800000/gic-its@1000000 domain created
[    0.849549] Platform MSI: /soc0/interrupt-controller@1800000/gic-its@1000000 domain created
[    0.866228] smp: Bringing up secondary CPUs ...
[    0.912009] Detected VIPT I-cache on CPU1
[    0.912050] GICv3: CPU1: found redistributor 1 region 0:0x00000000018a0000
[    0.912081] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[    0.912087] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
[    0.912092] 1 lock held by swapper/1/0:
[    0.912096]  #0:  ((pa_lock).lock){+.+.}, at: [<ffff0000081ad194>] get_page_from_freelist+0x154/0xeb0
[    0.912130] irq event stamp: 0
[    0.912135] hardirqs last  enabled at (0): [<          (null)>]           (null)
[    0.912147] hardirqs last disabled at (0): [<ffff0000080c31c0>] copy_process.isra.5.part.6+0x438/0x1920
[    0.912156] softirqs last  enabled at (0): [<ffff0000080c31c0>] copy_process.isra.5.part.6+0x438/0x1920
[    0.912160] softirqs last disabled at (0): [<          (null)>]           (null)
[    0.912164] Preemption disabled at:
[    0.912175] [<ffff0000080909b8>] secondary_start_kernel+0x80/0x118
[    0.912188] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.66-rt40-02415-g6a801ed-dirty #4
[    0.912192] Hardware name: Texas Instruments AM654 Base Board (DT)
[    0.912197] Call trace:
[    0.912207] [<ffff000008089d60>] dump_backtrace+0x0/0x400
[    0.912215] [<ffff00000808a174>] show_stack+0x14/0x20
[    0.912225] [<ffff0000087ecc78>] dump_stack+0xac/0xe4
[    0.912234] [<ffff0000080f3014>] ___might_sleep+0x154/0x228
[    0.912245] [<ffff00000880400c>] rt_spin_lock+0x5c/0x70
[    0.912251] [<ffff0000081ad194>] get_page_from_freelist+0x154/0xeb0
[    0.912258] [<ffff0000081ae530>] __alloc_pages_nodemask+0x108/0xc88
[    0.912268] [<ffff000008201d20>] alloc_page_interleave+0x18/0xa0
[    0.912275] [<ffff0000082023cc>] alloc_pages_current+0xcc/0xe0
[    0.912287] [<ffff00000846bb00>] its_allocate_pending_table+0x60/0xa0
[    0.912295] [<ffff00000846e5d8>] its_cpu_init+0x2a0/0x380
[    0.912303] [<ffff00000846b484>] gic_cpu_init.part.6+0x15c/0x170
[    0.912311] [<ffff00000846b4ac>] gic_starting_cpu+0x14/0x20
[    0.912319] [<ffff0000080c5c5c>] cpuhp_invoke_callback+0x9c/0x260
[    0.912327] [<ffff0000080c7dc0>] notify_cpu_starting+0x70/0xa8
[    0.912335] [<ffff0000080909e4>] secondary_start_kernel+0xac/0x118
[    0.912396] CPU1: using LPI pending table @0x00000008fd460000
[    0.912486] CPU1: Booted secondary processor [410fd034]
[    0.985563] Detected VIPT I-cache on CPU2
[    0.985607] GICv3: CPU2: found redistributor 100 region 0:0x00000000018c0000
[    0.985695] CPU2: using LPI pending table @0x00000008fd4f0000


-- 
regards,
-grygorii
