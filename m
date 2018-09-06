Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD899C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5240520652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5240520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIFUs6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:48:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbeIFUs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:48:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7976AE6D;
        Thu,  6 Sep 2018 16:12:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 72A0E1E3606; Thu,  6 Sep 2018 18:12:40 +0200 (CEST)
Date:   Thu, 6 Sep 2018 18:12:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [UDF] BUG: KASAN: slab-out-of-bounds in iput+0x8df/0xa80
Message-ID: <20180906161240.GD19319@quack2.suse.cz>
References: <CAE5jQCcO=wf82KTfi+u2VcFzQEV+EdN7+29NBACyO3EU8RCKgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAE5jQCcO=wf82KTfi+u2VcFzQEV+EdN7+29NBACyO3EU8RCKgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-06-18 22:48:51, Anatoly Trosinenko wrote:
> Mounting broken UDF image causes KASAN warning on v4.18-rc2.
> 
> How to reproduce:
> 1. Compile v4.18-rc2 kernel with the attached config
> 2. Unpack and mount the attached FS image as UDF

Thanks for the report and reproducer. I'll send fixes for the bug shortly.

								Honza

> 
> What happens:
> [   24.002776] UDF-fs: warning (device sda): udf_fill_super: No fileset found
> [   24.003207] ==================================================================
> [   24.003402] BUG: KASAN: slab-out-of-bounds in iput+0x8df/0xa80
> [   24.003584] Read of size 8 at addr ffff880067e82100 by task exe/1090
> [   24.003684]
> [   24.004030] CPU: 0 PID: 1090 Comm: exe Not tainted 4.18.0-rc2 #1
> [   24.004146] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [   24.004420] Call Trace:
> [   24.004629]  dump_stack+0xae/0x14b
> [   24.004736]  ? show_regs_print_info+0x5/0x5
> [   24.004815]  ? printk+0x97/0xbe
> [   24.004876]  ? kmsg_dump_rewind_nolock+0xf0/0xf0
> [   24.004950]  ? __switch_to_asm+0x40/0x70
> [   24.005018]  ? iput+0x8df/0xa80
> [   24.005076]  print_address_description+0x75/0x3e0
> [   24.005157]  ? iput+0x8df/0xa80
> [   24.005217]  kasan_report+0x1d8/0x460
> [   24.005284]  ? __switch_to_asm+0x40/0x70
> [   24.005353]  ? iput+0x8df/0xa80
> [   24.005412]  iput+0x8df/0xa80
> [   24.005472]  ? __sched_text_start+0x8/0x8
> [   24.005540]  ? inode_add_lru+0x280/0x280
> [   24.005610]  ? inode_add_lru+0x280/0x280
> [   24.005676]  ? kmsg_dump_rewind_nolock+0xf0/0xf0
> [   24.005753]  ? submit_bio+0x97/0x480
> [   24.005825]  ? submit_bio+0x97/0x480
> [   24.005890]  ? bio_alloc_bioset+0x224/0x680
> [   24.005964]  ? _udf_warn+0x104/0x190
> [   24.006027]  ? apic_timer_interrupt+0xa/0x20
> [   24.006107]  udf_sb_free_partitions+0x4e1/0x9b0
> [   24.006190]  udf_fill_super+0xe00/0x1ed0
> [   24.006265]  ? udf_load_vrs+0xc80/0xc80
> [   24.006331]  ? strspn+0x230/0x250
> [   24.006394]  ? vsnprintf+0x587/0x1380
> [   24.006461]  ? pointer+0x790/0x790
> [   24.006522]  ? rcu_note_context_switch+0x4e3/0x500
> [   24.006603]  ? udf_load_vrs+0xc80/0xc80
> [   24.006669]  ? snprintf+0x8f/0xc0
> [   24.006729]  ? vsprintf+0x10/0x10
> [   24.006791]  ? udf_load_vrs+0xc80/0xc80
> [   24.006861]  ? udf_load_vrs+0xc80/0xc80
> [   24.006925]  mount_bdev+0x25e/0x330
> [   24.006993]  mount_fs+0x59/0x330
> [   24.007059]  vfs_kern_mount.part.8+0xba/0x460
> [   24.007136]  ? unlock_mount+0x190/0x190
> [   24.007207]  ? __get_fs_type+0x82/0xe0
> [   24.007276]  do_mount+0xe13/0x34f0
> [   24.007345]  ? copy_mount_string+0x20/0x20
> [   24.007417]  ? strndup_user+0x42/0xb0
> [   24.007479]  ? save_stack+0x89/0xb0
> [   24.007541]  ? __kmalloc_track_caller+0x11a/0x360
> [   24.007614]  ? memdup_user+0x23/0x60
> [   24.007673]  ? strndup_user+0x42/0xb0
> [   24.007733]  ? ksys_mount+0x49/0xd0
> [   24.007793]  ? __x64_sys_mount+0xbe/0x170
> [   24.007857]  ? do_syscall_64+0x13c/0x520
> [   24.007921]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   24.008014]  ? d_move+0xf0/0xf0
> [   24.008077]  ? selinux_inode_getattr+0x19f/0x260
> [   24.008153]  ? selinux_sctp_assoc_request+0x9e0/0x9e0
> [   24.008233]  ? kmem_cache_alloc+0xfa/0x2d0
> [   24.008304]  ? _copy_to_user+0x6d/0xb0
> [   24.008369]  ? cp_new_stat+0x66a/0x8e0
> [   24.008433]  ? inode_get_bytes+0x210/0x210
> [   24.008509]  ? kasan_unpoison_shadow+0x30/0x40
> [   24.008583]  ? kasan_kmalloc+0xa0/0xd0
> [   24.008649]  ? __kmalloc_track_caller+0x11a/0x360
> [   24.008726]  ? _copy_from_user+0x75/0xc0
> [   24.008794]  ? memdup_user+0x39/0x60
> [   24.008860]  ksys_mount+0x7b/0xd0
> [   24.008926]  __x64_sys_mount+0xbe/0x170
> [   24.008996]  do_syscall_64+0x13c/0x520
> [   24.009065]  ? syscall_return_slowpath+0x370/0x370
> [   24.009145]  ? __do_page_fault+0xb80/0xb80
> [   24.009215]  ? prepare_exit_to_usermode+0x1df/0x280
> [   24.009293]  ? perf_trace_sys_enter+0x17e0/0x17e0
> [   24.009370]  ? __put_user_4+0x1c/0x30
> [   24.009437]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   24.009621] RIP: 0033:0x48d31a
> [   24.009692] Code: b8 67 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 6d
> cc 01 00 c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 4a cc 01 00 c3 66 0f 1f 84 00 00 00
> 00 00
> [   24.010213] RSP: 002b:00007ffdd66b17e8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a5
> [   24.010368] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 000000000048d31a
> [   24.010487] RDX: 00007ffdd66b2fa2 RSI: 00007ffdd66b2f9a RDI: 00007ffdd66b2f91
> [   24.010605] RBP: 0000000001d668a0 R08: 0000000000000000 R09: 0000000000000000
> [   24.010723] R10: 0000000000008000 R11: 0000000000000246 R12: 0000000000000000
> [   24.010839] R13: 0000000000000000 R14: 00007ffdd66b1a58 R15: 0000000000000000
> [   24.011020]
> [   24.011147] Allocated by task 0:
> [   24.011209] (stack is not available)
> [   24.011277]
> [   24.011314] Freed by task 0:
> [   24.011359] (stack is not available)
> [   24.011413]
> [   24.011457] The buggy address belongs to the object at ffff880067e82100
> [   24.011457]  which belongs to the cache kmalloc-16 of size 16
> [   24.011662] The buggy address is located 0 bytes inside of
> [   24.011662]  16-byte region [ffff880067e82100, ffff880067e82110)
> [   24.011839] The buggy address belongs to the page:
> [   24.012064] page:ffffea00019fa080 count:1 mapcount:0
> mapping:ffff88006c001b40 index:0x0
> [   24.012318] flags: 0x100000000000100(slab)
> [   24.012614] raw: 0100000000000100 dead000000000100 dead000000000200
> ffff88006c001b40
> [   24.012744] raw: 0000000000000000 0000000080800080 00000001ffffffff
> 0000000000000000
> [   24.012991] page dumped because: kasan: bad access detected
> [   24.013105]
> [   24.013162] Memory state around the buggy address:
> [   24.013453]  ffff880067e82000: fb fb fc fc 00 00 fc fc 00 00 fc fc
> 00 00 fc fc
> [   24.013581]  ffff880067e82080: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [   24.013700] >ffff880067e82100: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [   24.013851]                    ^
> [   24.013912]  ffff880067e82180: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [   24.014012]  ffff880067e82200: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [   24.014132] ==================================================================
> [   24.014250] Disabling lock debugging due to kernel taint
> mount: mounting /dev/sda on /mnt failed: Invalid argument
> [   24.027931] exe (1090) used greatest stack depth: 19824 bytes left
> 
> (Full log attached)
> 
> Thanks,
> Anatoly

> q[    0.000000] Linux version 4.18.0-rc2 (trosinenko@trosinenko-pc) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #1 SMP Thu Jun 28 22:26:49 MSK 2018
> [    0.000000] Command line: console=ttyS0
> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [    0.000000] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000000] found SMP MP-table at [mem 0x000f6aa0-0x000f6aaf] mapped at [(____ptrval____)]
> [    0.000000] Scanning 1 areas for low memory corruption
> [    0.000000] RAMDISK: [mem 0x7f991000-0x7ffdffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
> [    0.000000] ACPI: RSDT 0x000000007FFE15FC 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACP 0x000000007FFE1458 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> [    0.000000] ACPI: DSDT 0x000000007FFE0040 001418 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACS 0x000000007FFE0000 000040
> [    0.000000] ACPI: APIC 0x000000007FFE154C 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> [    0.000000] ACPI: HPET 0x000000007FFE15C4 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x7f98d000-0x7f990fff]
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
> [    0.000000] Reserved but unavailable: 98 pages
> [    0.000000] kasan: KernelAddressSanitizer initialized
> [    0.000000] ACPI: PM-Timer IO Port: 0x608
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.000000] [mem 0x80000000-0xfffbffff] available for PCI devices
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.000000] random: get_random_bytes called from start_kernel+0xed/0x7f6 with crng_init=0
> [    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
> [    0.000000] percpu: Embedded 52 pages/cpu @(____ptrval____) s175128 r8192 d29672 u2097152
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 515945
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: console=ttyS0
> [    0.000000] Memory: 1643244K/2096632K available (55308K kernel code, 49708K rwdata, 6688K rodata, 2008K init, 9040K bss, 453388K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU event tracing is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> [    0.000000] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [ttyS0] enabled
> [    0.000000] ACPI: Core revision 20180531
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
> [    0.003000] APIC: Switch to symmetric I/O mode setup
> [    0.009000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.014000] tsc: Fast TSC calibration using PIT
> [    0.015000] tsc: Detected 2808.209 MHz processor
> [    0.017473] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x287a8b8a1c0, max_idle_ns: 440795227519 ns
> [    0.018141] Calibrating delay loop (skipped), value calculated using timer frequency.. 5616.41 BogoMIPS (lpj=2808209)
> [    0.018450] pid_max: default: 32768 minimum: 301
> [    0.020681] Security Framework initialized
> [    0.021073] SELinux:  Initializing.
> [    0.027162] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.028626] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.029311] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.029577] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.061230] mce: CPU supports 10 MCE banks
> [    0.063110] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.063205] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.063442] Spectre V2 : Spectre mitigation: LFENCE not serializing, switching to generic retpoline
> [    0.063590] Spectre V2 : Mitigation: Full generic retpoline
> [    0.063723] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
> [    0.063924] Speculative Store Bypass: Vulnerable
> [    0.256397] random: fast init done
> [    0.455845] Freeing SMP alternatives memory: 40K
> [    0.481000] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
> [    0.493825] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.498073] Hierarchical SRCU implementation.
> [    0.505165] Huh? What family is it: 0x6?!
> [    0.506387] smp: Bringing up secondary CPUs ...
> [    0.506553] smp: Brought up 1 node, 1 CPU
> [    0.506734] smpboot: Max logical packages: 1
> [    0.506899] smpboot: Total of 1 processors activated (5616.41 BogoMIPS)
> [    0.529340] devtmpfs: initialized
> [    0.607599] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.608193] futex hash table entries: 256 (order: 2, 16384 bytes)
> [    0.618953] RTC time: 19:33:37, date: 06/28/18
> [    0.623415] kworker/u2:0 (17) used greatest stack depth: 24496 bytes left
> [    0.638162] NET: Registered protocol family 16
> [    0.649060] audit: initializing netlink subsys (disabled)
> [    0.654074] audit: type=2000 audit(1530214416.651:1): state=initialized audit_enabled=0 res=1
> [    0.663356] kworker/u2:1 (21) used greatest stack depth: 24112 bytes left
> [    0.671352] kworker/u2:1 (24) used greatest stack depth: 22936 bytes left
> [    0.688550] cpuidle: using governor menu
> [    0.693503] ACPI: bus type PCI registered
> [    0.702697] PCI: Using configuration type 1 for base access
> [    1.193628] kworker/u2:2 (233) used greatest stack depth: 22792 bytes left
> [    1.561817] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    1.577757] ACPI: Added _OSI(Module Device)
> [    1.577877] ACPI: Added _OSI(Processor Device)
> [    1.577947] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    1.578147] ACPI: Added _OSI(Processor Aggregator Device)
> [    1.578475] ACPI: Added _OSI(Linux-Dell-Video)
> [    1.800896] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    1.868847] ACPI: Interpreter enabled
> [    1.871322] ACPI: (supports S0 S3 S4 S5)
> [    1.871453] ACPI: Using IOAPIC for interrupt routing
> [    1.873657] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    1.891553] ACPI: Enabled 2 GPEs in block 00 to 0F
> [    2.546287] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    2.548667] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
> [    2.550450] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    2.553086] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
> [    2.561868] PCI host bridge to bus 0000:00
> [    2.562399] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    2.562586] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    2.562757] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    2.562923] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
> [    2.563100] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
> [    2.563520] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.613125] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    2.613305] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    2.613458] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    2.613600] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    2.633780] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
> [    2.633944] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
> [    2.775527] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> [    2.788069] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> [    2.800167] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> [    2.812044] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> [    2.817261] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> [    2.849000] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    2.849000] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    2.849090] pci 0000:00:02.0: vgaarb: bridge control possible
> [    2.849356] vgaarb: loaded
> [    2.862274] SCSI subsystem initialized
> [    2.883787] ACPI: bus type USB registered
> [    2.890761] usbcore: registered new interface driver usbfs
> [    2.893496] usbcore: registered new interface driver hub
> [    2.894455] usbcore: registered new device driver usb
> [    2.903395] pps_core: LinuxPPS API ver. 1 registered
> [    2.903507] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    2.907834] PTP clock support registered
> [    2.915465] EDAC MC: Ver: 3.0.0
> [    2.932454] Advanced Linux Sound Architecture Driver Initialized.
> [    2.937315] PCI: Using ACPI for IRQ routing
> [    2.969872] NetLabel: Initializing
> [    2.970041] NetLabel:  domain hash size = 128
> [    2.970115] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    2.974292] NetLabel:  unlabeled traffic allowed by default
> [    2.979336] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> [    2.979857] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    2.980076] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> [    2.986696] clocksource: Switched to clocksource tsc-early
> [    4.324764] VFS: Disk quotas dquot_6.6.0
> [    4.325423] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    4.332741] pnp: PnP ACPI init
> [    4.407246] pnp: PnP ACPI: found 6 devices
> [    4.713833] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    4.726418] NET: Registered protocol family 2
> [    4.741225] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes)
> [    4.741854] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> [    4.742779] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
> [    4.743522] TCP: Hash tables configured (established 16384 bind 16384)
> [    4.746491] UDP hash table entries: 1024 (order: 3, 32768 bytes)
> [    4.747208] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
> [    4.751439] NET: Registered protocol family 1
> [    4.760941] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    4.761267] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> [    4.761562] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> [    4.762047] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    4.774561] Unpacking initramfs...
> [    5.130716] Freeing initrd memory: 6460K
> [    5.145346] Scanning for low memory corruption every 60 seconds
> [    5.206053] Initialise system trusted keyrings
> [    5.211246] workingset: timestamp_bits=56 max_order=19 bucket_order=0
> [    5.577481] kworker/u2:2 (743) used greatest stack depth: 21168 bytes left
> [    5.720731] SGI XFS with ACLs, security attributes, no debug enabled
> [    5.916791] Key type asymmetric registered
> [    5.916998] Asymmetric key parser 'x509' registered
> [    5.921445] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> [    5.921759] io scheduler noop registered
> [    5.921878] io scheduler deadline registered
> [    5.930274] io scheduler cfq registered (default)
> [    5.930413] io scheduler mq-deadline registered
> [    5.930491] io scheduler kyber registered
> [    5.975911] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    5.977769] ACPI: Power Button [PWRF]
> [    6.014555] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    6.039447] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    6.096560] Non-volatile memory driver v1.3
> [    6.100775] Linux agpgart interface v0.103
> [    6.176494] tsc: Refined TSC clocksource calibration: 2808.082 MHz
> [    6.176741] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x287a13892a4, max_idle_ns: 440795348502 ns
> [    6.177109] clocksource: Switched to clocksource tsc
> [    6.289643] loop: module loaded
> [    6.366407] scsi host0: ata_piix
> [    6.382885] scsi host1: ata_piix
> [    6.391381] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
> [    6.391581] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
> [    6.414667] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> [    6.414797] e100: Copyright(c) 1999-2006 Intel Corporation
> [    6.417634] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    6.417763] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    6.561478] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
> [    6.561619] ata1.00: 2048 sectors, multi 16: LBA48 
> [    6.567791] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    6.608970] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> [    6.659396] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    6.662495] sd 0:0:0:0: [sda] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> [    6.665960] sd 0:0:0:0: [sda] Write Protect is off
> [    6.678630] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.679878] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
> [    6.723763] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [    6.724296] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    6.786185] sr 1:0:0:0: Attached scsi generic sg1 type 5
> [    6.836523] sd 0:0:0:0: [sda] Attached SCSI disk
> [   19.893823] PCI Interrupt Link [LNKC] enabled at IRQ 11
> [   20.203979] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> [   20.204505] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> [   20.207769] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [   20.207881] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   20.209804] sky2: driver version 1.30
> [   20.233708] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [   20.233886] ehci-pci: EHCI PCI platform driver
> [   20.234950] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   20.235938] ohci-pci: OHCI PCI platform driver
> [   20.236867] uhci_hcd: USB Universal Host Controller Interface driver
> [   20.246727] usbcore: registered new interface driver usblp
> [   20.250392] usbcore: registered new interface driver usb-storage
> [   20.257766] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [   20.270772] serio: i8042 KBD port at 0x60,0x64 irq 1
> [   20.272798] serio: i8042 AUX port at 0x60,0x64 irq 12
> [   20.302861] rtc_cmos 00:00: RTC can wake from S4
> [   20.304033] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [   20.326954] rtc_cmos 00:00: registered as rtc0
> [   20.339642] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
> [   20.380001] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
> [   20.385520] hidraw: raw HID events driver (C) Jiri Kosina
> [   20.443299] usbcore: registered new interface driver usbhid
> [   20.443437] usbhid: USB HID core driver
> [   20.496845] Initializing XFRM netlink socket
> [   20.521833] NET: Registered protocol family 10
> [   20.552610] Segment Routing with IPv6
> [   20.564402] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [   20.586536] NET: Registered protocol family 17
> [   20.587435] Key type dns_resolver registered
> [   20.596490] sched_clock: Marking stable (20596083277, 0)->(20731580955, -135497678)
> [   20.614255] registered taskstats version 1
> [   20.614383] Loading compiled-in X.509 certificates
> [   20.618946] Unable to create integrity sysfs dir: -19
> [   20.651619]   Magic number: 6:151:598
> [   20.652449] console [netcon0] enabled
> [   20.652576] netconsole: network logging started
> [   20.659513] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   20.690194] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   20.693610] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [   20.694296] cfg80211: failed to load regulatory.db
> [   20.694714] ALSA device list:
> [   20.694811]   No soundcards found.
> [   20.752768] Freeing unused kernel memory: 2008K
> [   20.754450] Write protecting the kernel read-only data: 65536k
> [   20.760006] Freeing unused kernel memory: 2004K
> [   20.808943] Freeing unused kernel memory: 1504K
> [   21.020827] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
> 
> Mounting...
> 
> [   24.002776] UDF-fs: warning (device sda): udf_fill_super: No fileset found
> [   24.003207] ==================================================================
> [   24.003402] BUG: KASAN: slab-out-of-bounds in iput+0x8df/0xa80
> [   24.003584] Read of size 8 at addr ffff880067e82100 by task exe/1090
> [   24.003684] 
> [   24.004030] CPU: 0 PID: 1090 Comm: exe Not tainted 4.18.0-rc2 #1
> [   24.004146] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [   24.004420] Call Trace:
> [   24.004629]  dump_stack+0xae/0x14b
> [   24.004736]  ? show_regs_print_info+0x5/0x5
> [   24.004815]  ? printk+0x97/0xbe
> [   24.004876]  ? kmsg_dump_rewind_nolock+0xf0/0xf0
> [   24.004950]  ? __switch_to_asm+0x40/0x70
> [   24.005018]  ? iput+0x8df/0xa80
> [   24.005076]  print_address_description+0x75/0x3e0
> [   24.005157]  ? iput+0x8df/0xa80
> [   24.005217]  kasan_report+0x1d8/0x460
> [   24.005284]  ? __switch_to_asm+0x40/0x70
> [   24.005353]  ? iput+0x8df/0xa80
> [   24.005412]  iput+0x8df/0xa80
> [   24.005472]  ? __sched_text_start+0x8/0x8
> [   24.005540]  ? inode_add_lru+0x280/0x280
> [   24.005610]  ? inode_add_lru+0x280/0x280
> [   24.005676]  ? kmsg_dump_rewind_nolock+0xf0/0xf0
> [   24.005753]  ? submit_bio+0x97/0x480
> [   24.005825]  ? submit_bio+0x97/0x480
> [   24.005890]  ? bio_alloc_bioset+0x224/0x680
> [   24.005964]  ? _udf_warn+0x104/0x190
> [   24.006027]  ? apic_timer_interrupt+0xa/0x20
> [   24.006107]  udf_sb_free_partitions+0x4e1/0x9b0
> [   24.006190]  udf_fill_super+0xe00/0x1ed0
> [   24.006265]  ? udf_load_vrs+0xc80/0xc80
> [   24.006331]  ? strspn+0x230/0x250
> [   24.006394]  ? vsnprintf+0x587/0x1380
> [   24.006461]  ? pointer+0x790/0x790
> [   24.006522]  ? rcu_note_context_switch+0x4e3/0x500
> [   24.006603]  ? udf_load_vrs+0xc80/0xc80
> [   24.006669]  ? snprintf+0x8f/0xc0
> [   24.006729]  ? vsprintf+0x10/0x10
> [   24.006791]  ? udf_load_vrs+0xc80/0xc80
> [   24.006861]  ? udf_load_vrs+0xc80/0xc80
> [   24.006925]  mount_bdev+0x25e/0x330
> [   24.006993]  mount_fs+0x59/0x330
> [   24.007059]  vfs_kern_mount.part.8+0xba/0x460
> [   24.007136]  ? unlock_mount+0x190/0x190
> [   24.007207]  ? __get_fs_type+0x82/0xe0
> [   24.007276]  do_mount+0xe13/0x34f0
> [   24.007345]  ? copy_mount_string+0x20/0x20
> [   24.007417]  ? strndup_user+0x42/0xb0
> [   24.007479]  ? save_stack+0x89/0xb0
> [   24.007541]  ? __kmalloc_track_caller+0x11a/0x360
> [   24.007614]  ? memdup_user+0x23/0x60
> [   24.007673]  ? strndup_user+0x42/0xb0
> [   24.007733]  ? ksys_mount+0x49/0xd0
> [   24.007793]  ? __x64_sys_mount+0xbe/0x170
> [   24.007857]  ? do_syscall_64+0x13c/0x520
> [   24.007921]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   24.008014]  ? d_move+0xf0/0xf0
> [   24.008077]  ? selinux_inode_getattr+0x19f/0x260
> [   24.008153]  ? selinux_sctp_assoc_request+0x9e0/0x9e0
> [   24.008233]  ? kmem_cache_alloc+0xfa/0x2d0
> [   24.008304]  ? _copy_to_user+0x6d/0xb0
> [   24.008369]  ? cp_new_stat+0x66a/0x8e0
> [   24.008433]  ? inode_get_bytes+0x210/0x210
> [   24.008509]  ? kasan_unpoison_shadow+0x30/0x40
> [   24.008583]  ? kasan_kmalloc+0xa0/0xd0
> [   24.008649]  ? __kmalloc_track_caller+0x11a/0x360
> [   24.008726]  ? _copy_from_user+0x75/0xc0
> [   24.008794]  ? memdup_user+0x39/0x60
> [   24.008860]  ksys_mount+0x7b/0xd0
> [   24.008926]  __x64_sys_mount+0xbe/0x170
> [   24.008996]  do_syscall_64+0x13c/0x520
> [   24.009065]  ? syscall_return_slowpath+0x370/0x370
> [   24.009145]  ? __do_page_fault+0xb80/0xb80
> [   24.009215]  ? prepare_exit_to_usermode+0x1df/0x280
> [   24.009293]  ? perf_trace_sys_enter+0x17e0/0x17e0
> [   24.009370]  ? __put_user_4+0x1c/0x30
> [   24.009437]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   24.009621] RIP: 0033:0x48d31a
> [   24.009692] Code: b8 67 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 6d cc 01 00 c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 4a cc 01 00 c3 66 0f 1f 84 00 00 00 00 00 
> [   24.010213] RSP: 002b:00007ffdd66b17e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [   24.010368] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 000000000048d31a
> [   24.010487] RDX: 00007ffdd66b2fa2 RSI: 00007ffdd66b2f9a RDI: 00007ffdd66b2f91
> [   24.010605] RBP: 0000000001d668a0 R08: 0000000000000000 R09: 0000000000000000
> [   24.010723] R10: 0000000000008000 R11: 0000000000000246 R12: 0000000000000000
> [   24.010839] R13: 0000000000000000 R14: 00007ffdd66b1a58 R15: 0000000000000000
> [   24.011020] 
> [   24.011147] Allocated by task 0:
> [   24.011209] (stack is not available)
> [   24.011277] 
> [   24.011314] Freed by task 0:
> [   24.011359] (stack is not available)
> [   24.011413] 
> [   24.011457] The buggy address belongs to the object at ffff880067e82100
> [   24.011457]  which belongs to the cache kmalloc-16 of size 16
> [   24.011662] The buggy address is located 0 bytes inside of
> [   24.011662]  16-byte region [ffff880067e82100, ffff880067e82110)
> [   24.011839] The buggy address belongs to the page:
> [   24.012064] page:ffffea00019fa080 count:1 mapcount:0 mapping:ffff88006c001b40 index:0x0
> [   24.012318] flags: 0x100000000000100(slab)
> [   24.012614] raw: 0100000000000100 dead000000000100 dead000000000200 ffff88006c001b40
> [   24.012744] raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
> [   24.012991] page dumped because: kasan: bad access detected
> [   24.013105] 
> [   24.013162] Memory state around the buggy address:
> [   24.013453]  ffff880067e82000: fb fb fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
> [   24.013581]  ffff880067e82080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   24.013700] >ffff880067e82100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   24.013851]                    ^
> [   24.013912]  ffff880067e82180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   24.014012]  ffff880067e82200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   24.014132] ==================================================================
> [   24.014250] Disabling lock debugging due to kernel taint
> mount: mounting /dev/sda on /mnt failed: Invalid argument
> [   24.027931] exe (1090) used greatest stack depth: 19824 bytes left
> 
> 
> 
> BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3) built-in shell (ash)
> Enter 'help' for a list of built-in commands.
> 
> /bin/sh: can't access tty; job control turned off
> / # [6n



-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
