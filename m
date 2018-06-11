Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id opo5AB2kHlv5WQAAmS7hNA
	; Mon, 11 Jun 2018 16:32:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74411607A4; Mon, 11 Jun 2018 16:32:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 678A760541;
	Mon, 11 Jun 2018 16:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 678A760541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933606AbeFKQcn convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 12:32:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932484AbeFKQck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:32:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3401ACF0;
        Mon, 11 Jun 2018 16:32:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3BAAF1E04CC; Mon, 11 Jun 2018 18:32:38 +0200 (CEST)
Date: Mon, 11 Jun 2018 18:32:38 +0200
From: Jan Kara <jack@suse.cz>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Page fault in UDF FS driver
Message-ID: <20180611163238.vswxkjmgwtoozhs7@quack2.suse.cz>
References: <CAE5jQCeD-dXDSGK=CZcwYP1_cFd4TB2nprC80-kpSXMEJ+8_oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAE5jQCeD-dXDSGK=CZcwYP1_cFd4TB2nprC80-kpSXMEJ+8_oQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03-06-18 19:26:41, Anatoly Trosinenko wrote:
> When mounting corrupted UDF file system and performing specific
> actions, [BUG: unable to handle kernel paging request at
> ffffa136c7fe0000] occurs.
> 
> How to reproduce:
> 1. Compile the v4.17-rc7 kernel with the attached config
> 2. Unpack and mount attached FS as udf (supposing, mount point in /mnt)
> 3. Execute
> $ echo >>  /mnt/1111111111111111111111111111111111111111111111111111111111111111111111111
> $ ln -s /mnt/. /mnt/foo

Thanks for the reproducer. I'll look into this.

								Honza

> 
> [    2.296245] BUG: unable to handle kernel paging request at ffffa394c7fe0000
> [    2.296613] PGD 573e067 P4D 573e067 PUD 573f067 PMD 5742067 PTE 0
> [    2.296895] Oops: 0000 [#1] SMP NOPTI
> [    2.297062] Modules linked in:
> [    2.297298] CPU: 0 PID: 991 Comm: init Not tainted 4.17.0-rc7+ #1
> [    2.297403] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [    2.297899] RIP: 0010:crc_itu_t+0x1b/0x30
> [    2.297974] RSP: 0018:ffffbfb6c08d7a28 EFLAGS: 00000a86
> [    2.298088] RAX: 000000009d2ad400 RBX: ffffa394c4ff1400 RCX: 000000000000002a
> [    2.298203] RDX: ffffa394f6304549 RSI: ffffa394c7fe0001 RDI: ffffffff9444a2c0
> [    2.298307] RBP: ffffa394c6750098 R08: 0000000000000001 R09: 0000000000000001
> [    2.298409] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> [    2.298509] R13: 0000000000000010 R14: 0000000000000002 R15: 0000000000000000
> [    2.298647] FS:  0000000000ba08c0(0000) GS:ffffa394c7800000(0000)
> knlGS:0000000000000000
> [    2.298764] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.298856] CR2: ffffa394c7fe0000 CR3: 0000000005c2e000 CR4: 00000000000006f0
> [    2.299015] Call Trace:
> [    2.299478]  udf_update_tag+0x19/0x40
> [    2.299653]  udf_write_aext+0xa8/0x120
> [    2.299739]  inode_getblk+0xa90/0x12f0
> [    2.299822]  ? __wake_up_common_lock+0x84/0xb0
> [    2.299905]  ? __lookup_slow+0x92/0x150
> [    2.299972]  udf_get_block+0xc0/0x140
> [    2.300035]  udf_getblk+0x39/0xf0
> [    2.300112]  ? _cond_resched+0x10/0x40
> [    2.300178]  ? __getblk_gfp+0x27/0x2a0
> [    2.300244]  ? inode_bmap+0x10a/0x1c0
> [    2.300307]  udf_bread+0x26/0xa0
> [    2.300364]  udf_add_entry+0x3ac/0xa10
> [    2.300434]  udf_add_nondir+0x50/0x150
> [    2.300541]  ? udf_symlink+0x34f/0x4d0
> [    2.300605]  udf_symlink+0x34f/0x4d0
> [    2.300668]  vfs_symlink+0xbb/0x140
> [    2.300729]  do_symlinkat+0x76/0xd0
> [    2.300792]  do_syscall_64+0x43/0xf0
> [    2.300856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    2.301058] RIP: 0033:0x487a07
> [    2.301114] RSP: 002b:00007ffcab237978 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000058
> [    2.301234] RAX: ffffffffffffffda RBX: 0000000000ba32e0 RCX: 0000000000487a07
> [    2.301336] RDX: 0000000000000000 RSI: 0000000000ba32a8 RDI: 0000000000ba3290
> [    2.301436] RBP: 0000000000ba32a8 R08: 0000000000000000 R09: 0000000000000000
> [    2.301536] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [    2.301636] R13: 0000000000ba32a8 R14: 0000000000000000 R15: 0000000000000000
> [    2.301776] Code: b6 c9 66 33 04 4f 48 39 d6 75 e6 f3 c3 89 f8 c3
> 48 85 d2 74 27 89 f8 48 01 f2 48 c7 c7 c0 a2 44 94 48 83 c6 01 0f b6
> cc c1 e0 08 <32> 4e ff 0f b6 c9 66 33 04 4f 48 39 d6 75 e7 f3 c3 89 f8
> c3 90
> [    2.302793] RIP: crc_itu_t+0x1b/0x30 RSP: ffffbfb6c08d7a28
> [    2.302914] CR2: ffffa394c7fe0000
> [    2.303173] ---[ end trace fcae3e3ff19df0fb ]---
> 
> Thanks,
> Anatoly

> W[    0.000000] Linux version 4.17.0-rc7+ (trosinenko@trosinenko-pc) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #1 SMP Sun Jun 3 16:40:58 MSK 2018
> [    0.000000] Command line: console=ttyS0
> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000007fdffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000007fe0000-0x0000000007ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [    0.000000] e820: last_pfn = 0x7fe0 max_arch_pfn = 0x400000000
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000000] found SMP MP-table at [mem 0x000f6aa0-0x000f6aaf] mapped at [        (ptrval)]
> [    0.000000] Scanning 1 areas for low memory corruption
> [    0.000000] RAMDISK: [mem 0x07b2d000-0x07fdffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
> [    0.000000] ACPI: RSDT 0x0000000007FE15FC 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACP 0x0000000007FE1458 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> [    0.000000] ACPI: DSDT 0x0000000007FE0040 001418 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACS 0x0000000007FE0000 000040
> [    0.000000] ACPI: APIC 0x0000000007FE154C 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> [    0.000000] ACPI: HPET 0x0000000007FE15C4 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000007fdffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x07b29000-0x07b2cfff]
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000007fdffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x0000000007fdffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000007fdffff]
> [    0.000000] Reserved but unavailable: 98 pages
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
> [    0.000000] e820: [mem 0x08000000-0xfffbffff] available for PCI devices
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.000000] random: get_random_bytes called from start_kernel+0x8b/0x49f with crng_init=0
> [    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
> [    0.000000] percpu: Embedded 43 pages/cpu @        (ptrval) s137304 r8192 d30632 u2097152
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32105
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: console=ttyS0
> [    0.000000] Memory: 95420K/130552K available (14348K kernel code, 1363K rwdata, 3092K rodata, 1260K init, 592K bss, 35132K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU event tracing is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> [    0.000000] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [ttyS0] enabled
> [    0.000000] ACPI: Core revision 20180313
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
> [    0.000000] APIC: Switch to symmetric I/O mode setup
> [    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.009000] tsc: Fast TSC calibration using PIT
> [    0.010000] tsc: Detected 2808.060 MHz processor
> [    0.011350] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2879febc7be, max_idle_ns: 440795208100 ns
> [    0.011751] Calibrating delay loop (skipped), value calculated using timer frequency.. 5616.12 BogoMIPS (lpj=2808060)
> [    0.012105] pid_max: default: 32768 minimum: 301
> [    0.012672] Security Framework initialized
> [    0.013056] SELinux:  Initializing.
> [    0.014039] Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
> [    0.014280] Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.014500] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> [    0.014622] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
> [    0.025149] mce: CPU supports 10 MCE banks
> [    0.025995] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.026131] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.026275] Spectre V2 : Spectre mitigation: LFENCE not serializing, switching to generic retpoline
> [    0.026414] Spectre V2 : Mitigation: Full generic retpoline
> [    0.026516] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
> [    0.026646] Speculative Store Bypass: Vulnerable
> [    0.256205] random: fast init done
> [    0.327891] Freeing SMP alternatives memory: 40K
> [    0.337000] APIC calibration not consistent with PM-Timer: 105ms instead of 100ms
> [    0.337000] APIC delta adjusted to PM-Timer: 6249982 (6562749)
> [    0.337000] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
> [    0.341184] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.343727] Hierarchical SRCU implementation.
> [    0.347253] Huh? What family is it: 0x6?!
> [    0.348450] smp: Bringing up secondary CPUs ...
> [    0.349056] smp: Brought up 1 node, 1 CPU
> [    0.349447] smpboot: Max logical packages: 1
> [    0.349874] smpboot: Total of 1 processors activated (5616.12 BogoMIPS)
> [    0.358500] devtmpfs: initialized
> [    0.364513] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.364887] futex hash table entries: 256 (order: 2, 16384 bytes)
> [    0.367549] RTC time: 16:20:56, date: 06/03/18
> [    0.374292] NET: Registered protocol family 16
> [    0.377101] kworker/u2:0 (16) used greatest stack depth: 14640 bytes left
> [    0.378622] audit: initializing netlink subsys (disabled)
> [    0.385161] audit: type=2000 audit(1528042856.380:1): state=initialized audit_enabled=0 res=1
> [    0.388195] kworker/u2:1 (21) used greatest stack depth: 14144 bytes left
> [    0.389735] cpuidle: using governor menu
> [    0.391164] ACPI: bus type PCI registered
> [    0.393247] PCI: Using configuration type 1 for base access
> [    0.516637] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.520583] ACPI: Added _OSI(Module Device)
> [    0.520695] ACPI: Added _OSI(Processor Device)
> [    0.520767] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.520837] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.521160] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.532913] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    0.544705] ACPI: Interpreter enabled
> [    0.545461] ACPI: (supports S0 S3 S4 S5)
> [    0.545579] ACPI: Using IOAPIC for interrupt routing
> [    0.546346] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.547692] ACPI: Enabled 2 GPEs in block 00 to 0F
> [    0.605259] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.605712] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
> [    0.606149] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    0.607095] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
> [    0.609424] PCI host bridge to bus 0000:00
> [    0.609621] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.609737] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.609846] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.609957] pci_bus 0000:00: root bus resource [mem 0x08000000-0xfebfffff window]
> [    0.610086] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
> [    0.610299] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.618359] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    0.618515] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.618636] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    0.618750] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.620776] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
> [    0.620933] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
> [    0.642367] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> [    0.643640] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> [    0.644404] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> [    0.645100] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> [    0.645441] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> [    0.651228] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.651417] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.651583] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.651728] vgaarb: loaded
> [    0.653881] SCSI subsystem initialized
> [    0.656571] ACPI: bus type USB registered
> [    0.657510] usbcore: registered new interface driver usbfs
> [    0.657935] usbcore: registered new interface driver hub
> [    0.658267] usbcore: registered new device driver usb
> [    0.659660] pps_core: LinuxPPS API ver. 1 registered
> [    0.659762] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.662513] PTP clock support registered
> [    0.664366] EDAC MC: Ver: 3.0.0
> [    0.667198] Advanced Linux Sound Architecture Driver Initialized.
> [    0.668193] PCI: Using ACPI for IRQ routing
> [    0.676182] NetLabel: Initializing
> [    0.676272] NetLabel:  domain hash size = 128
> [    0.676345] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.677800] NetLabel:  unlabeled traffic allowed by default
> [    0.679188] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> [    0.679465] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.679604] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> [    0.684812] clocksource: Switched to clocksource tsc-early
> [    0.820213] VFS: Disk quotas dquot_6.6.0
> [    0.820458] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.822865] pnp: PnP ACPI init
> [    0.831572] pnp: PnP ACPI: found 6 devices
> [    0.880471] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.882321] NET: Registered protocol family 2
> [    0.886578] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes)
> [    0.886783] TCP established hash table entries: 1024 (order: 1, 8192 bytes)
> [    0.887003] TCP bind hash table entries: 1024 (order: 2, 16384 bytes)
> [    0.887256] TCP: Hash tables configured (established 1024 bind 1024)
> [    0.888281] UDP hash table entries: 256 (order: 1, 8192 bytes)
> [    0.888515] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
> [    0.889657] NET: Registered protocol family 1
> [    0.891397] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    0.891555] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> [    0.891723] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> [    0.891990] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.895695] Unpacking initramfs...
> [    0.941535] Freeing initrd memory: 4812K
> [    0.945291] Scanning for low memory corruption every 60 seconds
> [    0.956378] Initialise system trusted keyrings
> [    0.958543] workingset: timestamp_bits=56 max_order=15 bucket_order=0
> [    1.000958] SGI XFS with ACLs, security attributes, no debug enabled
> [    1.027638] Key type asymmetric registered
> [    1.027773] Asymmetric key parser 'x509' registered
> [    1.028371] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> [    1.028604] io scheduler noop registered
> [    1.028694] io scheduler deadline registered
> [    1.029747] io scheduler cfq registered (default)
> [    1.029868] io scheduler mq-deadline registered
> [    1.029944] io scheduler kyber registered
> [    1.034220] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    1.037571] ACPI: Power Button [PWRF]
> [    1.044368] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    1.067140] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    1.077611] Non-volatile memory driver v1.3
> [    1.078344] Linux agpgart interface v0.103
> [    1.107755] loop: module loaded
> [    1.120873] scsi host0: ata_piix
> [    1.123804] scsi host1: ata_piix
> [    1.124680] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
> [    1.124839] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
> [    1.129555] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> [    1.129674] e100: Copyright(c) 1999-2006 Intel Corporation
> [    1.129963] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    1.130175] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    1.284095] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
> [    1.284216] ata1.00: 2048 sectors, multi 16: LBA48 
> [    1.285454] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    1.286293] ata2.00: configured for MWDMA2
> [    1.287241] ata1.00: configured for MWDMA2
> [    1.298404] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> [    1.301806] PCI Interrupt Link [LNKC] enabled at IRQ 11
> [    1.307340] sd 0:0:0:0: [sda] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> [    1.307960] sd 0:0:0:0: [sda] Write Protect is off
> [    1.308618] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.309848] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    1.312503] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
> [    1.329987] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [    1.330341] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    1.334532] sr 1:0:0:0: Attached scsi generic sg1 type 5
> [    1.348524] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.611316] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> [    1.611583] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> [    1.612818] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    1.612948] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.613728] sky2: driver version 1.30
> [    1.616907] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.617208] ehci-pci: EHCI PCI platform driver
> [    1.617649] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.617985] ohci-pci: OHCI PCI platform driver
> [    1.620753] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.621647] usbcore: registered new interface driver usblp
> [    1.621985] usbcore: registered new interface driver usb-storage
> [    1.623696] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [    1.627897] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.628306] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    1.633720] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [    1.637964] rtc_cmos 00:00: RTC can wake from S4
> [    1.644572] rtc_cmos 00:00: registered as rtc0
> [    1.646497] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
> [    1.650030] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
> [    1.652678] hidraw: raw HID events driver (C) Jiri Kosina
> [    1.661694] usbcore: registered new interface driver usbhid
> [    1.661841] usbhid: USB HID core driver
> [    1.674543] Initializing XFRM netlink socket
> [    1.677433] NET: Registered protocol family 10
> [    1.684890] Segment Routing with IPv6
> [    1.687394] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    1.690205] NET: Registered protocol family 17
> [    1.690471] Key type dns_resolver registered
> [    1.692918] sched_clock: Marking stable (1692061351, 0)->(1790236173, -98174822)
> [    1.697498] registered taskstats version 1
> [    1.697614] Loading compiled-in X.509 certificates
> [    1.701558]   Magic number: 6:193:337
> [    1.701816] tty tty58: hash matches
> [    1.702418] console [netcon0] enabled
> [    1.702510] netconsole: network logging started
> [    1.704322] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    1.733603] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    1.738570] ALSA device list:
> [    1.738679]   No soundcards found.
> [    1.739867] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    1.740308] cfg80211: failed to load regulatory.db
> [    1.759567] Freeing unused kernel memory: 1260K
> [    1.761244] Write protecting the kernel read-only data: 20480k
> [    1.763844] Freeing unused kernel memory: 2004K
> [    1.771766] Freeing unused kernel memory: 1004K
> [    2.296245] BUG: unable to handle kernel paging request at ffffa394c7fe0000
> [    2.296613] PGD 573e067 P4D 573e067 PUD 573f067 PMD 5742067 PTE 0
> [    2.296895] Oops: 0000 [#1] SMP NOPTI
> [    2.297062] Modules linked in:
> [    2.297298] CPU: 0 PID: 991 Comm: init Not tainted 4.17.0-rc7+ #1
> [    2.297403] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [    2.297899] RIP: 0010:crc_itu_t+0x1b/0x30
> [    2.297974] RSP: 0018:ffffbfb6c08d7a28 EFLAGS: 00000a86
> [    2.298088] RAX: 000000009d2ad400 RBX: ffffa394c4ff1400 RCX: 000000000000002a
> [    2.298203] RDX: ffffa394f6304549 RSI: ffffa394c7fe0001 RDI: ffffffff9444a2c0
> [    2.298307] RBP: ffffa394c6750098 R08: 0000000000000001 R09: 0000000000000001
> [    2.298409] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> [    2.298509] R13: 0000000000000010 R14: 0000000000000002 R15: 0000000000000000
> [    2.298647] FS:  0000000000ba08c0(0000) GS:ffffa394c7800000(0000) knlGS:0000000000000000
> [    2.298764] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.298856] CR2: ffffa394c7fe0000 CR3: 0000000005c2e000 CR4: 00000000000006f0
> [    2.299015] Call Trace:
> [    2.299478]  udf_update_tag+0x19/0x40
> [    2.299653]  udf_write_aext+0xa8/0x120
> [    2.299739]  inode_getblk+0xa90/0x12f0
> [    2.299822]  ? __wake_up_common_lock+0x84/0xb0
> [    2.299905]  ? __lookup_slow+0x92/0x150
> [    2.299972]  udf_get_block+0xc0/0x140
> [    2.300035]  udf_getblk+0x39/0xf0
> [    2.300112]  ? _cond_resched+0x10/0x40
> [    2.300178]  ? __getblk_gfp+0x27/0x2a0
> [    2.300244]  ? inode_bmap+0x10a/0x1c0
> [    2.300307]  udf_bread+0x26/0xa0
> [    2.300364]  udf_add_entry+0x3ac/0xa10
> [    2.300434]  udf_add_nondir+0x50/0x150
> [    2.300541]  ? udf_symlink+0x34f/0x4d0
> [    2.300605]  udf_symlink+0x34f/0x4d0
> [    2.300668]  vfs_symlink+0xbb/0x140
> [    2.300729]  do_symlinkat+0x76/0xd0
> [    2.300792]  do_syscall_64+0x43/0xf0
> [    2.300856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    2.301058] RIP: 0033:0x487a07
> [    2.301114] RSP: 002b:00007ffcab237978 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
> [    2.301234] RAX: ffffffffffffffda RBX: 0000000000ba32e0 RCX: 0000000000487a07
> [    2.301336] RDX: 0000000000000000 RSI: 0000000000ba32a8 RDI: 0000000000ba3290
> [    2.301436] RBP: 0000000000ba32a8 R08: 0000000000000000 R09: 0000000000000000
> [    2.301536] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [    2.301636] R13: 0000000000ba32a8 R14: 0000000000000000 R15: 0000000000000000
> [    2.301776] Code: b6 c9 66 33 04 4f 48 39 d6 75 e6 f3 c3 89 f8 c3 48 85 d2 74 27 89 f8 48 01 f2 48 c7 c7 c0 a2 44 94 48 83 c6 01 0f b6 cc c1 e0 08 <32> 4e ff 0f b6 c9 66 33 04 4f 48 39 d6 75 e7 f3 c3 89 f8 c3 90 
> [    2.302793] RIP: crc_itu_t+0x1b/0x30 RSP: ffffbfb6c08d7a28
> [    2.302914] CR2: ffffa394c7fe0000
> [    2.303173] ---[ end trace fcae3e3ff19df0fb ]---
> [    2.303991] tsc: Refined TSC clocksource calibration: 2808.022 MHz
> [    2.304478] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2879db23480, max_idle_ns: 440795344018 ns
> [    2.305891] clocksource: Switched to clocksource tsc
> [    2.306722] init (991) used greatest stack depth: 13032 bytes left
> Killed
> 
> 
> BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3) built-in shell (ash)
> Enter 'help' for a list of built-in commands.
> 
> /bin/sh: can't access tty; job control turned off
> / # [6n[    2.508355] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3



-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
