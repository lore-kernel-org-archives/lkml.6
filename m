Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69345C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C2620873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C2620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeG2QQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 12:16:56 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:38542 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeG2QQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 12:16:56 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 7E2F59001D;
        Sun, 29 Jul 2018 17:46:03 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 689FB22091F; Sun, 29 Jul 2018 17:46:01 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 69622220685;
        Sun, 29 Jul 2018 17:46:01 +0300 (EEST)
Date:   Sun, 29 Jul 2018 17:46:01 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Linux Kernel list <linux-kernel@vger.kernel.org>
cc:     netdev@vger.kernel.org
Subject: New(?) UBSAN warnings in 4.18.0-rc6-00218-ga26fb01c2879 with gcc-8
Message-ID: <alpine.LRH.2.21.1807291739370.12061@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After testing 4.18.0-rc6-00192 successfully with gcc-7, I upgraded my 
Debian unstable to latest gcc (now defaults to gcc-8) and compiled latest git 
4.18.0-rc6-00218-ga26fb01c2879. The new kernel spits out multiple 
UBSAN warnings in different places: in mm, radix-tree and network code. 
I have compilead a coubple of kernels with gcc-8 before but most have 
been 64-bit, this is the first 32-bit one.

[    0.000000] Linux version 4.18.0-rc6-00218-ga26fb01c2879-dirty (mroos@rx100s2) (gcc version 8.2.0 (Debian 8.2.0-1)) #80 SMP Sun Jul 29 14:45:46 EEST 2018
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009afff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009b000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000ca000-0x00000000000cbfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000dc000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ff6ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ff70000-0x000000003ff79fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003ff7a000-0x000000003ff7ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003ff80000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffbfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffffc00-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: FUJITSU SIEMENS PRIMERGY RX100S2/D1571/M71IXG, BIOS 6.0 Rev. C0F2.1571 04/27/2005
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x3ff70 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 03FF80000 mask FFFF80000 uncachable
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] total RAM covered: 1023M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 1M 	num_reg: 2  	lose cover RAM: 0G
[    0.000000] found SMP MP-table at [mem 0x000f6680-0x000f668f] mapped at [(ptrval)]
[    0.000000] initial memory mapped: [mem 0x00000000-0x1dffffff]
[    0.000000] Base memory trampoline at [(ptrval)] 97000 size 16384
[    0.000000] BRK [0x1ddf8000, 0x1ddf8fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F66B0 000014 (v00 PTLTD )
[    0.000000] ACPI: RSDT 0x000000003FF75B79 000038 (v01 PTLTD    RSDT   06040000  LTP 00000000)
[    0.000000] ACPI: FACP 0x000000003FF79E69 000074 (v01 INTEL  CANTWOOD 06040000 PTL  00000003)
[    0.000000] ACPI: DSDT 0x000000003FF75BB1 0042B8 (v01 INTEL  CANTWOOD 06040000 MSFT 0100000B)
[    0.000000] ACPI: FACS 0x000000003FF7AFC0 000040
[    0.000000] ACPI: SPCR 0x000000003FF79EDD 000050 (v01 PTLTD  $UCRTBL$ 06040000 PTL  00000001)
[    0.000000] ACPI: APIC 0x000000003FF79F2D 000074 (v01 PTLTD  ? APIC   06040000  LTP 00000000)
[    0.000000] ACPI: BOOT 0x000000003FF79FA1 000028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 00000001)
[    0.000000] ACPI: SSDT 0x000000003FF79FC9 000037 (v01 PTLTD  ACPIHT   06040000  LTP 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 135MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] BRK [0x1ddf9000, 0x1ddf9fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.000000]   HighMem  [mem 0x00000000377fe000-0x000000003ff6ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009afff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000003ff6ffff]
[    0.000000] Reserved but unavailable: 102 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003ff6ffff]
[    0.000000] On node 0 totalpages: 261898
[    0.000000]   DMA zone: 36 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3994 pages, LIFO batch:0
[    0.000000]   Normal zone: 1962 pages used for memmap
[    0.000000]   Normal zone: 223230 pages, LIFO batch:31
[    0.000000]   HighMem zone: 34674 pages, LIFO batch:7
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: SPCR: SPCR table version 1
[    0.000000] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009b000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000c9fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000ca000-0x000cbfff]
[    0.000000] PM: Registered nosave memory: [mem 0x000cc000-0x000dbfff]
[    0.000000] PM: Registered nosave memory: [mem 0x000dc000-0x000fffff]
[    0.000000] [mem 0x40000000-0xfebfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x78/0x3f3 with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] percpu: Embedded 28 pages/cpu @(ptrval) s85900 r0 d28788 u114688
[    0.000000] pcpu-alloc: s85900 r0 d28788 u114688 alloc=28*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 259900
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.18.0-rc6-00218-ga26fb01c2879-dirty root=/dev/sda1 ro
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000377fe:0003ff70)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 1022972K/1047592K available (8195K kernel code, 3428K rwdata, 1196K rodata, 564K init, 332K bss, 24620K reserved, 0K cma-reserved, 138696K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xfff8e000 - 0xfffff000   ( 452 kB)
                 cpu_entry : 0xffc00000 - 0xffc4f000   ( 316 kB)
                   pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
                   vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
                     .init : 0xddc99000 - 0xddd26000   ( 564 kB)
                     .data : 0xdd800e10 - 0xddc8b080   (4648 kB)
                     .text : 0xdd000000 - 0xdd800e10   (8195 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...
[    0.000000] ================================================================================
[    0.000000] UBSAN: Undefined behaviour in arch/x86/mm/fault.c:1225:12
[    0.000000] member access within null pointer of type 'struct mm_struct'
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc6-00218-ga26fb01c2879-dirty #80
[    0.000000] Hardware name: FUJITSU SIEMENS PRIMERGY RX100S2/D1571/M71IXG, BIOS 6.0 Rev. C0F2.1571 04/27/2005
[    0.000000] Call Trace:
[    0.000000]  dump_stack+0x55/0x83
[    0.000000]  ubsan_epilogue+0xb/0x33
[    0.000000]  handle_null_ptr_deref+0x77/0x7e
[    0.000000]  __ubsan_handle_type_mismatch_v1+0x54/0x5f
[    0.000000]  __do_page_fault+0x43f/0x4ee
[    0.000000]  ? vmalloc_sync_all+0x2f6/0x2f6
[    0.000000]  do_page_fault+0xb/0xd
[    0.000000]  common_exception+0x6f/0x8a
[    0.000000] EIP: __copy_user_ll+0x40/0xde
[    0.000000] Code: 1d 00 b0 c8 dd 75 2f 89 cb 89 c7 89 d6 83 f9 07 76 18 89 f9 f7 d9 83 e1 07 29 cb f3 a4 89 d9 c1 e9 02 83 e3 03 90 f3 a5 89 d9 <f3> a4 89 c8 90 90 90 5b 5e 5f 5d c3 89 c7 89 d6 8b 46 20 83 f9 43 
[    0.000000] EAX: ffd8e000 EBX: 00000001 ECX: 00000001 EDX: dd933f6b
[    0.000000] ESI: dd933f6b EDI: ffd8e000 EBP: dd933f40 ESP: dd933f34
[    0.000000] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210097
[    0.000000]  ? memcg_stat_show+0xa8/0x9d1
[    0.000000]  __probe_kernel_write+0x84/0x14d
[    0.000000]  mem_init+0x1b7/0x200
[    0.000000]  start_kernel+0x286/0x3f3
[    0.000000]  i386_start_kernel+0x11a/0x11d
[    0.000000]  startup_32_smp+0x164/0x168
[    0.000000] ================================================================================
[    0.000000] Ok.
[    0.000000] ================================================================================
[    0.000000] UBSAN: Undefined behaviour in lib/radix-tree.c:123:14
[    0.000000] member access within null pointer of type 'const struct radix_tree_node'
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc6-00218-ga26fb01c2879-dirty #80
[    0.000000] Hardware name: FUJITSU SIEMENS PRIMERGY RX100S2/D1571/M71IXG, BIOS 6.0 Rev. C0F2.1571 04/27/2005
[    0.000000] Call Trace:
[    0.000000]  dump_stack+0x55/0x83
[    0.000000]  ubsan_epilogue+0xb/0x33
[    0.000000]  handle_null_ptr_deref+0x77/0x7e
[    0.000000]  __ubsan_handle_type_mismatch_v1+0x54/0x5f
[    0.000000]  ? idr_get_free+0x2ce/0x42a
[    0.000000]  __radix_tree_replace+0x11d/0x122
[    0.000000]  radix_tree_iter_replace+0x28/0x43
[    0.000000]  idr_alloc_u32+0x9e/0xee
[    0.000000]  idr_alloc+0x3c/0x64
[    0.000000]  workqueue_init_early+0x2a5/0x68d
[    0.000000]  start_kernel+0x2b5/0x3f3
[    0.000000]  i386_start_kernel+0x11a/0x11d
[    0.000000]  startup_32_smp+0x164/0x168
[    0.000000] ================================================================================
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 2304, nr_irqs: 512, preallocated irqs: 16
[    0.000000] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180531
[    0.004000] APIC: Switch to symmetric I/O mode setup
[    0.004000] Enabling APIC mode:  Flat.  Using 2 I/O APICs
[    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.024000] tsc: Fast TSC calibration using PIT
[    0.028000] tsc: Detected 3400.387 MHz processor
[    0.028000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3103bc1e9ad, max_idle_ns: 440795299795 ns
[    0.028000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6800.77 BogoMIPS (lpj=13601548)
[    0.028000] pid_max: default: 32768 minimum: 301
[    0.028000] Security Framework initialized
[    0.028000] AppArmor: AppArmor initialized
[    0.028000] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.028000] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.028000] CPU: Physical Processor ID: 0
[    0.028000] CPU: Processor Core ID: 0
[    0.028000] mce: CPU supports 4 MCE banks
[    0.028000] CPU0: Thermal monitoring enabled (TM1)
[    0.028000] process: using mwait in idle threads
[    0.028000] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 64
[    0.028000] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 64, 1GB 0
[    0.028000] Spectre V2 : Mitigation: Full generic retpoline
[    0.032004] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.032105] Speculative Store Bypass: Vulnerable
[    0.032305] Freeing SMP alternatives memory: 24K
[    0.036000] smpboot: CPU0: Intel(R) Pentium(R) 4 CPU 3.40GHz (family: 0xf, model: 0x3, stepping: 0x4)
[    0.036000] Performance Events: Netburst events, Netburst P4/Xeon PMU driver.
[    0.036000] ... version:                0
[    0.036000] ... bit width:              40
[    0.036000] ... generic registers:      18
[    0.036000] ... value mask:             000000ffffffffff
[    0.036000] ... max period:             0000007fffffffff
[    0.036000] ... fixed-purpose events:   0
[    0.036000] ... event mask:             000000000003ffff
[    0.036000] Hierarchical SRCU implementation.
[    0.036000] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.036000] smp: Bringing up secondary CPUs ...
[    0.036000] CPU 1 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.036000] x86: Booting SMP configuration:
[    0.036000] .... node  #0, CPUs:      #1
[    0.004000] Initializing CPU#1
[    0.047116] smp: Brought up 1 node, 2 CPUs
[    0.047116] smpboot: Max logical packages: 1
[    0.047116] smpboot: Total of 2 processors activated (13601.54 BogoMIPS)
[    0.048219] devtmpfs: initialized
[    0.048455] PM: Registering ACPI NVS region [mem 0x3ff7a000-0x3ff7ffff] (24576 bytes)
[    0.048714] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.048879] futex hash table entries: 512 (order: 4, 65536 bytes)
[    0.049180] NET: Registered protocol family 16
[    0.049456] audit: initializing netlink subsys (disabled)
[    0.049575] audit: type=2000 audit(1532870745.048:1): state=initialized audit_enabled=0 res=1
[    0.049575] cpuidle: using governor ladder
[    0.049575] cpuidle: using governor menu
[    0.049575] Simple Boot Flag at 0x38 set to 0x80
[    0.049575] ACPI: bus type PCI registered
[    0.052312] PCI: PCI BIOS revision 2.10 entry at 0xfd920, last bus=4
[    0.052408] PCI: Using configuration type 1 for base access
[    0.054046] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[    0.054046] ACPI: Added _OSI(Module Device)
[    0.054046] ACPI: Added _OSI(Processor Device)
[    0.054046] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.054046] ACPI: Added _OSI(Processor Aggregator Device)
[    0.054046] ACPI: Added _OSI(Linux-Dell-Video)
[    0.057924] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.059827] ACPI: Interpreter enabled
[    0.059967] ACPI: (supports S0 S1 S4 S5)
[    0.060006] ACPI: Using IOAPIC for interrupt routing
[    0.060156] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.060526] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.066378] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.066486] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.066592] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.066696] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.068021] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.068024] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.068027] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.068030] acpi PNP0A03:00: host bridge window [mem 0x000cc000-0x000cffff window] (ignored)
[    0.068032] acpi PNP0A03:00: host bridge window [mem 0x000d0000-0x000d3fff window] (ignored)
[    0.068035] acpi PNP0A03:00: host bridge window [mem 0x000d4000-0x000d7fff window] (ignored)
[    0.068037] acpi PNP0A03:00: host bridge window [mem 0x000d8000-0x000dbfff window] (ignored)
[    0.068040] acpi PNP0A03:00: host bridge window [mem 0x3ff80000-0xfebfffff window] (ignored)
[    0.068042] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.068045] acpi PNP0A03:00: host bridge window [mem 0xfed20000-0xfed8ffff window] (ignored)
[    0.068047] PCI: root bus 00: using default resources
[    0.068172] PCI host bridge to bus 0000:00
[    0.068271] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.068371] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.068474] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.068586] pci 0000:00:00.0: [8086:2578] type 00 class 0x060000
[    0.068602] pci 0000:00:00.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.068752] pci 0000:00:03.0: [8086:257b] type 01 class 0x060400
[    0.068915] pci 0000:00:06.0: [8086:257e] type 00 class 0x088000
[    0.068930] pci 0000:00:06.0: reg 0x10: [mem 0xfecf0000-0xfecf0fff]
[    0.069097] pci 0000:00:1c.0: [8086:25ae] type 01 class 0x060400
[    0.069271] pci 0000:00:1d.0: [8086:25a9] type 00 class 0x0c0300
[    0.069322] pci 0000:00:1d.0: reg 0x20: [io  0x1400-0x141f]
[    0.069463] pci 0000:00:1d.1: [8086:25aa] type 00 class 0x0c0300
[    0.069514] pci 0000:00:1d.1: reg 0x20: [io  0x1420-0x143f]
[    0.069657] pci 0000:00:1d.4: [8086:25ab] type 00 class 0x088000
[    0.069676] pci 0000:00:1d.4: reg 0x10: [mem 0xf8000000-0xf800000f]
[    0.069829] pci 0000:00:1d.5: [8086:25ac] type 00 class 0x080020
[    0.070017] pci 0000:00:1d.7: [8086:25ad] type 00 class 0x0c0320
[    0.070044] pci 0000:00:1d.7: reg 0x10: [mem 0xf8000400-0xf80007ff]
[    0.070142] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.070266] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060400
[    0.070424] pci 0000:00:1f.0: [8086:25a1] type 00 class 0x060100
[    0.070501] pci 0000:00:1f.0: quirk: [io  0x1000-0x107f] claimed by ICH4 ACPI/GPIO/TCO
[    0.070659] pci 0000:00:1f.0: quirk: [io  0x1180-0x11bf] claimed by ICH4 GPIO
[    0.070866] pci 0000:00:1f.1: [8086:25a2] type 00 class 0x01018a
[    0.070885] pci 0000:00:1f.1: reg 0x10: [io  0x0000-0x0007]
[    0.070895] pci 0000:00:1f.1: reg 0x14: [io  0x0000-0x0003]
[    0.070905] pci 0000:00:1f.1: reg 0x18: [io  0x0000-0x0007]
[    0.070915] pci 0000:00:1f.1: reg 0x1c: [io  0x0000-0x0003]
[    0.070926] pci 0000:00:1f.1: reg 0x20: [io  0x1460-0x146f]
[    0.070936] pci 0000:00:1f.1: reg 0x24: [mem 0x00000000-0x000003ff]
[    0.070950] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.071052] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.071152] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.071252] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.071465] pci 0000:00:1f.3: [8086:25a4] type 00 class 0x0c0500
[    0.071515] pci 0000:00:1f.3: reg 0x20: [io  0x1440-0x145f]
[    0.071642] pci_bus 0000:02: extended config space not accessible
[    0.071791] pci 0000:02:01.0: [8086:1075] type 00 class 0x020000
[    0.071807] pci 0000:02:01.0: reg 0x10: [mem 0xf8120000-0xf813ffff]
[    0.071816] pci 0000:02:01.0: reg 0x14: [mem 0xf8100000-0xf811ffff]
[    0.071825] pci 0000:02:01.0: reg 0x18: [io  0x2000-0x201f]
[    0.071852] pci 0000:02:01.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.071882] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    0.071991] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.072009] pci 0000:00:03.0:   bridge window [io  0x2000-0x2fff]
[    0.072013] pci 0000:00:03.0:   bridge window [mem 0xf8100000-0xf81fffff]
[    0.072040] pci_bus 0000:03: extended config space not accessible
[    0.072180] pci 0000:03:01.0: [13c1:1001] type 00 class 0x010400
[    0.072200] pci 0000:03:01.0: reg 0x10: [io  0x30e0-0x30ef]
[    0.072211] pci 0000:03:01.0: reg 0x14: [mem 0xf8261000-0xf826100f]
[    0.072222] pci 0000:03:01.0: reg 0x18: [mem 0xf8800000-0xf8ffffff]
[    0.072257] pci 0000:03:01.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.072293] pci 0000:03:01.0: supports D1
[    0.072363] pci 0000:03:02.0: [8086:1008] type 00 class 0x020000
[    0.072384] pci 0000:03:02.0: reg 0x10: [mem 0xf8220000-0xf823ffff]
[    0.072395] pci 0000:03:02.0: reg 0x14: [mem 0xf8200000-0xf821ffff]
[    0.072406] pci 0000:03:02.0: reg 0x18: [io  0x30c0-0x30df]
[    0.072442] pci 0000:03:02.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.072493] pci 0000:03:02.0: PME# supported from D0 D3hot D3cold
[    0.072575] pci 0000:03:04.0: [105a:3319] type 00 class 0x010400
[    0.072594] pci 0000:03:04.0: reg 0x10: [io  0x3080-0x30bf]
[    0.072605] pci 0000:03:04.0: reg 0x14: [io  0x30f0-0x30ff]
[    0.072616] pci 0000:03:04.0: reg 0x18: [io  0x3000-0x307f]
[    0.072627] pci 0000:03:04.0: reg 0x1c: [mem 0xf8260000-0xf8260fff]
[    0.072638] pci 0000:03:04.0: reg 0x20: [mem 0xf8240000-0xf825ffff]
[    0.072691] pci 0000:03:04.0: supports D1
[    0.072783] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.072890] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.072895] pci 0000:00:1c.0:   bridge window [mem 0xf8200000-0xf8ffffff]
[    0.072914] pci_bus 0000:04: extended config space not accessible
[    0.073058] pci 0000:04:05.0: [1002:4752] type 00 class 0x030000
[    0.073077] pci 0000:04:05.0: reg 0x10: [mem 0xf9000000-0xf9ffffff]
[    0.073087] pci 0000:04:05.0: reg 0x14: [io  0x4000-0x40ff]
[    0.073098] pci 0000:04:05.0: reg 0x18: [mem 0xfa040000-0xfa040fff]
[    0.073132] pci 0000:04:05.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.073168] pci 0000:04:05.0: supports D1 D2
[    0.073235] pci 0000:04:06.0: [8086:1076] type 00 class 0x020000
[    0.073255] pci 0000:04:06.0: reg 0x10: [mem 0xfa020000-0xfa03ffff]
[    0.073265] pci 0000:04:06.0: reg 0x14: [mem 0xfa000000-0xfa01ffff]
[    0.073275] pci 0000:04:06.0: reg 0x18: [io  0x4400-0x443f]
[    0.073306] pci 0000:04:06.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.073347] pci 0000:04:06.0: PME# supported from D0 D3hot D3cold
[    0.073442] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive decode)
[    0.073546] pci 0000:00:1e.0:   bridge window [io  0x4000-0x4fff]
[    0.073551] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xfa0fffff]
[    0.073556] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.073559] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff] (subtractive decode)
[    0.073577] pci_bus 0000:00: on NUMA node 0
[    0.073906] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 11 14 15) *5
[    0.074130] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *10 11 14 15)
[    0.074351] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *7
[    0.074573] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 10 11 14 15)
[    0.074800] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
[    0.075089] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
[    0.075373] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
[    0.075656] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 10 *11 14 15)
[    0.076400] pci 0000:04:05.0: vgaarb: setting as boot VGA device
[    0.076400] pci 0000:04:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.076400] pci 0000:04:05.0: vgaarb: bridge control possible
[    0.076400] vgaarb: loaded
[    0.076615] SCSI subsystem initialized
[    0.076767] PCI: Using ACPI for IRQ routing
[    0.076897] PCI: pci_cache_line_size set to 64 bytes
[    0.076954] e820: reserve RAM buffer [mem 0x0009b000-0x0009ffff]
[    0.076957] e820: reserve RAM buffer [mem 0x3ff70000-0x3fffffff]
[    0.080100] clocksource: Switched to clocksource tsc-early
[    0.080453] AppArmor: AppArmor Filesystem Enabled
[    0.080572] pnp: PnP ACPI init
[    0.080989] system 00:00: [io  0x1000-0x107f] has been reserved
[    0.081094] system 00:00: [io  0x1180-0x11bf] has been reserved
[    0.081194] system 00:00: [io  0x012e-0x012f] has been reserved
[    0.081294] system 00:00: [io  0x0372-0x0375] has been reserved
[    0.081394] system 00:00: [io  0x0377] has been reserved
[    0.081493] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.081593] system 00:00: [io  0x0600-0x067f] has been reserved
[    0.081692] system 00:00: [io  0x0ca2-0x0ca5] could not be reserved
[    0.081792] system 00:00: [io  0xfe00] has been reserved
[    0.081890] system 00:00: [io  0xfe10-0xfe11] has been reserved
[    0.081992] system 00:00: [mem 0xfecf0000-0xfecfffff] could not be reserved
[    0.082092] system 00:00: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.082203] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.082299] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.082421] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.082478] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.082920] pnp 00:04: [dma 2]
[    0.082972] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.083083] pnp: PnP ACPI: found 5 devices
[    0.120908] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.121108] pci 0000:00:03.0: BAR 9: assigned [mem 0x40000000-0x400fffff pref]
[    0.121264] pci 0000:00:1e.0: BAR 9: assigned [mem 0x40100000-0x401fffff pref]
[    0.121418] pci 0000:00:1f.1: BAR 5: assigned [mem 0x40200000-0x402003ff]
[    0.121527] pci 0000:02:01.0: BAR 6: assigned [mem 0x40000000-0x4001ffff pref]
[    0.121683] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.121784] pci 0000:00:03.0:   bridge window [io  0x2000-0x2fff]
[    0.121886] pci 0000:00:03.0:   bridge window [mem 0xf8100000-0xf81fffff]
[    0.121986] pci 0000:00:03.0:   bridge window [mem 0x40000000-0x400fffff pref]
[    0.122139] pci 0000:03:02.0: BAR 6: assigned [mem 0xf8280000-0xf829ffff pref]
[    0.122286] pci 0000:03:01.0: BAR 6: assigned [mem 0xf8270000-0xf827ffff pref]
[    0.122436] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.122533] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.122631] pci 0000:00:1c.0:   bridge window [mem 0xf8200000-0xf8ffffff]
[    0.122737] pci 0000:04:05.0: BAR 6: assigned [mem 0x40100000-0x4011ffff pref]
[    0.122884] pci 0000:04:06.0: BAR 6: assigned [mem 0x40120000-0x4013ffff pref]
[    0.123031] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.123126] pci 0000:00:1e.0:   bridge window [io  0x4000-0x4fff]
[    0.123232] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xfa0fffff]
[    0.123332] pci 0000:00:1e.0:   bridge window [mem 0x40100000-0x401fffff pref]
[    0.123485] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.123488] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.123491] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    0.123494] pci_bus 0000:02: resource 1 [mem 0xf8100000-0xf81fffff]
[    0.123496] pci_bus 0000:02: resource 2 [mem 0x40000000-0x400fffff pref]
[    0.123499] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.123502] pci_bus 0000:03: resource 1 [mem 0xf8200000-0xf8ffffff]
[    0.123505] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.123507] pci_bus 0000:04: resource 1 [mem 0xf9000000-0xfa0fffff]
[    0.123510] pci_bus 0000:04: resource 2 [mem 0x40100000-0x401fffff pref]
[    0.123512] pci_bus 0000:04: resource 4 [io  0x0000-0xffff]
[    0.123515] pci_bus 0000:04: resource 5 [mem 0x00000000-0xffffffff]
[    0.123655] NET: Registered protocol family 2
[    0.124027] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
[    0.124193] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.124314] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.124450] TCP: Hash tables configured (established 8192 bind 8192)
[    0.124592] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.124702] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.124878] NET: Registered protocol family 1
[    0.125474] pci 0000:00:1d.5: disabled boot interrupts on device [8086:25ac]
[    0.125909] PCI: CLS mismatch (64 != 32), using 64 bytes
[    0.125927] pci 0000:04:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.127113] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    0.127378] pstore: using deflate compression
[    0.129020] bounce: pool size: 64 pages
[    0.129121] io scheduler noop registered
[    0.129215] io scheduler deadline registered
[    0.129335] io scheduler cfq registered (default)
[    0.130413] tsc: Marking TSC unstable due to TSC halts in idle
[    0.130567] clocksource: Switched to clocksource acpi_pm
[    0.131968] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.132637] Linux agpgart interface v0.103
[    0.132843] agpgart-intel 0000:00:00.0: Intel i875 Chipset
[    0.134733] agpgart-intel 0000:00:00.0: AGP aperture is 32M @ 0xfc000000
[    0.135064] 3ware Storage Controller device driver for Linux v1.26.02.003.
[    0.135930] Floppy drive(s): fd0 is 1.44M
[    0.159827] FDC 0 is a post-1991 82077
[    6.076028] 3w-xxxx: AEN: ERROR: Unit degraded: Unit #1.
[    6.556030] scsi host0: 3ware Storage Controller
[    6.556216] 3w-xxxx: scsi0: Found a 3ware Storage Controller at 0x30e0, IRQ: 24.
[    6.556577] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[    6.557116] scsi 0:0:1:0: Direct-Access     3ware    Logical Disk 1   1.2  PQ: 0 ANSI: 0
[    6.559996] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.560129] serio: i8042 AUX port at 0x60,0x64 irq 12
[    6.560475] rtc_cmos 00:01: RTC can wake from S4
[    6.560777] rtc_cmos 00:01: registered as rtc0
[    6.560913] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    6.561226] NET: Registered protocol family 10
[    6.561787] Segment Routing with IPv6
[    6.561927] mip6: Mobile IPv6
[    6.562277] sd 0:0:1:0: [sda] 312579760 512-byte logical blocks: (160 GB/149 GiB)
[    6.563309] NET: Registered protocol family 17
[    6.563653] sd 0:0:1:0: [sda] Write Protect is off
[    6.563759] microcode: sig=0xf34, pf=0x4, revision=0x13
[    6.563761] sd 0:0:1:0: [sda] Mode Sense: 00 00 00 00
[    6.563979] microcode: Microcode Update Driver: v2.2.
[    6.563986] Using IPI No-Shortcut mode
[    6.564141] sd 0:0:1:0: [sda] Write cache: enabled, read cache: disabled, supports DPO and FUA
[    6.564636] registered taskstats version 1
[    6.564746] AppArmor: AppArmor sha1 policy hashing enabled
[    6.565113] console [netcon0] enabled
[    6.565220] netconsole: network logging started
[    6.565372] rtc_cmos 00:01: setting system clock to 2018-07-29 13:25:52 UTC (1532870752)
[    6.582852] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    6.595461]  sda: sda1 sda2 < sda5 >
[    6.596717] sd 0:0:1:0: [sda] Attached SCSI disk
[    6.973272] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    6.973446] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    7.004973] devtmpfs: mounted
[    7.005422] Freeing unused kernel memory: 564K
[    7.020051] Write protecting the kernel text: 8196k
[    7.020180] Write protecting the kernel read-only data: 1220k
[    7.081825] ================================================================================
[    7.081984] UBSAN: Undefined behaviour in fs/ext4/readpage.c:129:13
[    7.082080] member access within null pointer of type 'struct page'
[    7.082180] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc6-00218-ga26fb01c2879-dirty #80
[    7.082331] Hardware name: FUJITSU SIEMENS PRIMERGY RX100S2/D1571/M71IXG, BIOS 6.0 Rev. C0F2.1571 04/27/2005
[    7.082486] Call Trace:
[    7.082589]  dump_stack+0x55/0x83
[    7.082689]  ubsan_epilogue+0xb/0x33
[    7.082788]  handle_null_ptr_deref+0x77/0x7e
[    7.082889]  __ubsan_handle_type_mismatch_v1+0x54/0x5f
[    7.082988]  ? _raw_read_trylock+0x51/0x52
[    7.083086]  ext4_mpage_readpages+0xd86/0xe1c
[    7.083185]  ? __ext4_ext_check+0x155/0x62f
[    7.083285]  ? woken_wake_function+0x3d/0x3d
[    7.083381]  ? __ext4_get_inode_loc+0x412/0x593
[    7.083475]  ext4_readpages+0x45/0x81
[    7.083570]  ? ext4_bmap+0x217/0x217
[    7.083667]  read_pages+0x5a/0x21b
[    7.083765]  __do_page_cache_readahead+0x1aa/0x22e
[    7.083861]  ? __radix_tree_lookup+0x36/0xd3
[    7.083958]  ondemand_readahead+0x168/0x2c6
[    7.084056]  page_cache_sync_readahead+0x44/0x71
[    7.084155]  generic_file_read_iter+0x5f1/0x11ca
[    7.084254]  ext4_file_read_iter+0x65/0xe2
[    7.084351]  __vfs_read+0x15f/0x241
[    7.084446]  vfs_read+0x89/0x1ed
[    7.084541]  kernel_read+0x5a/0xea
[    7.084636]  prepare_binprm+0x1ee/0x388
[    7.084731]  __do_execve_file+0x5b4/0xd9e
[    7.084826]  ? rest_init+0x39/0xa1
[    7.084921]  do_execve+0x27/0x29
[    7.085017]  run_init_process+0x1c/0x1e
[    7.085111]  try_to_run_init_process+0xc/0x2e
[    7.085206]  ? rest_init+0x39/0xa1
[    7.085301]  kernel_init+0xae/0xed
[    7.085397]  ? rest_init+0xa1/0xa1
[    7.085493]  ret_from_fork+0x2e/0x38
[    7.085587] ================================================================================
[    7.343073] random: fast init done
[    8.759370] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    8.759874] systemd[1]: Detected architecture x86.
[    8.807126] systemd[1]: Set hostname to <rx100s2>.
[    8.822317] ================================================================================
[    8.822470] UBSAN: Undefined behaviour in net/ipv4/fib_trie.c:504:6
[    8.822566] member access within null pointer of type 'struct tnode'
[    8.822665] CPU: 1 PID: 1 Comm: systemd Not tainted 4.18.0-rc6-00218-ga26fb01c2879-dirty #80
[    8.822815] Hardware name: FUJITSU SIEMENS PRIMERGY RX100S2/D1571/M71IXG, BIOS 6.0 Rev. C0F2.1571 04/27/2005
[    8.822966] Call Trace:
[    8.823068]  dump_stack+0x55/0x83
[    8.823167]  ubsan_epilogue+0xb/0x33
[    8.823263]  handle_null_ptr_deref+0x77/0x7e
[    8.823359]  __ubsan_handle_type_mismatch_v1+0x54/0x5f
[    8.823457]  tnode_free+0xb4/0xf7
[    8.823551]  replace+0x8a/0x19f
[    8.823644]  resize+0x453/0x979
[    8.823739]  fib_insert_alias+0x398/0x6ea
[    8.823833]  fib_table_insert+0x1dc/0x57d
[    8.823931]  fib_magic+0x122/0x17e
[    8.824033]  fib_add_ifaddr+0x179/0x1b1
[    8.824137]  fib_netdev_event+0x6c/0x1bc
[    8.824233]  ? fib_add_ifaddr+0x1b1/0x1b1
[    8.824329]  notifier_call_chain+0x5d/0xa2
[    8.824426]  ? fib_add_ifaddr+0x1b1/0x1b1
[    8.824521]  raw_notifier_call_chain+0x28/0x43
[    8.824618]  call_netdevice_notifiers_info+0x23/0x66
[    8.824714]  ? __dev_change_flags+0x184/0x26a
[    8.824810]  __dev_notify_flags+0x51/0xe1
[    8.824905]  dev_change_flags+0x52/0x6a
[    8.825001]  do_setlink+0x340/0x105a
[    8.825096]  ? add_timer+0x13a/0x394
[    8.825191]  ? nla_parse+0x37/0x166
[    8.825286]  ? set_next_entity+0x11c/0x98f
[    8.825382]  rtnl_setlink+0x10f/0x1cf
[    8.825479]  ? _cond_resched+0x12/0x22
[    8.825573]  ? mutex_lock+0x1a/0x6d
[    8.825669]  ? do_setlink+0x105a/0x105a
[    8.825764]  rtnetlink_rcv_msg+0x2b5/0x50c
[    8.825860]  ? rtnl_calcit+0x20b/0x20b
[    8.825956]  netlink_rcv_skb+0x77/0x10b
[    8.825998]  rtnetlink_rcv+0xd/0xf
[    8.825998]  netlink_unicast+0x192/0x28c
[    8.825998]  netlink_sendmsg+0x2bf/0x56a
[    8.825998]  ? netlink_broadcast_filtered+0x500/0x500
[    8.825998]  sock_sendmsg+0x42/0x8d
[    8.825998]  __sys_sendto+0xe9/0x15b
[    8.825998]  ? handle_mm_fault+0xd13/0x14ad
[    8.825998]  ? netlink_getsockopt+0x1ef/0x2db
[    8.825998]  ? _copy_from_user+0x37/0x6c
[    8.825998]  sys_socketcall+0x1e2/0x322
[    8.825998]  do_fast_syscall_32+0xc7/0x3b3
[    8.825998]  entry_SYSENTER_32+0x4e/0x7c
[    8.825998] EIP: 0xb7f84b1d
[    8.825998] Code: 00 05 58 f8 ff ff 8b 55 08 8b 80 5c cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
[    8.825998] EAX: ffffffda EBX: 0000000b ECX: bffad3c4 EDX: 00000000
[    8.825998] ESI: 00000000 EDI: 0225fae0 EBP: 0225f600 ESP: bffad3b0
[    8.825998] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000286
[    8.825998] ================================================================================
[    9.913452] random: crng init done
[   10.095365] systemd[1]: Listening on udev Control Socket.
[   10.096316] systemd[1]: Listening on Journal Socket.
[   10.097033] systemd[1]: Listening on Journal Audit Socket.
[   10.100449] systemd[1]: Starting Wait for network to be configured by ifupdown...
[   10.101745] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   10.137595] systemd[1]: Starting Load Kernel Modules...
[   10.138503] systemd[1]: Listening on udev Kernel Socket.
[   11.182762] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.335976] systemd-journald[84]: Received request to flush runtime journal from PID 1
[   12.509386] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0C:00/input/input2
[   12.509570] ACPI: Power Button [PWRB]
[   12.509794] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   12.510390] ACPI: Power Button [PWRF]
[   12.531423] ACPI: bus type USB registered
[   12.531602] usbcore: registered new interface driver usbfs
[   12.531737] usbcore: registered new interface driver hub
[   12.533926] usbcore: registered new device driver usb
[   12.537543] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.546162] ehci-pci: EHCI PCI platform driver
[   12.546545] ehci-pci 0000:00:1d.7: EHCI Host Controller
[   12.546659] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   12.546832] ehci-pci 0000:00:1d.7: debug port 1
[   12.550850] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[   12.552726] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf8000400
[   12.568064] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[   12.568303] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[   12.568463] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.568622] usb usb1: Product: EHCI Host Controller
[   12.568727] usb usb1: Manufacturer: Linux 4.18.0-rc6-00218-ga26fb01c2879-dirty ehci_hcd
[   12.568885] usb usb1: SerialNumber: 0000:00:1d.7
[   12.569299] hub 1-0:1.0: USB hub found
[   12.569425] hub 1-0:1.0: 4 ports detected
[   12.595998] uhci_hcd: USB Universal Host Controller Interface driver
[   12.596402] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   12.596517] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   12.596729] uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001400
[   12.596993] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[   12.597156] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.597314] usb usb2: Product: UHCI Host Controller
[   12.597414] usb usb2: Manufacturer: Linux 4.18.0-rc6-00218-ga26fb01c2879-dirty uhci_hcd
[   12.597570] usb usb2: SerialNumber: 0000:00:1d.0
[   12.597962] hub 2-0:1.0: USB hub found
[   12.598080] hub 2-0:1.0: 2 ports detected
[   12.598681] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   12.598792] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   12.598994] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001420
[   12.599209] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[   12.599368] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.599528] usb usb3: Product: UHCI Host Controller
[   12.599635] usb usb3: Manufacturer: Linux 4.18.0-rc6-00218-ga26fb01c2879-dirty uhci_hcd
[   12.599796] usb usb3: SerialNumber: 0000:00:1d.1
[   12.608212] hub 3-0:1.0: USB hub found
[   12.608339] hub 3-0:1.0: 2 ports detected
[   12.616146] i6300ESB timer 0000:00:1d.4: initialized (0xe3a06cc7). heartbeat=30 sec (nowayout=0)
[   12.640770] ipmi message handler version 39.2
[   12.642016] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   12.642937] ipmi device interface
[   12.656172] IPMI System Interface driver.
[   12.656302] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   12.656409] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   12.656510] ipmi_si: Adding SMBIOS-specified kcs state machine
[   12.657139] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x24, irq 0
[   12.736477] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   12.799519] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   12.834094] intel_rng: FWH not detected
[   12.836606] libata version 3.00 loaded.
[   12.950797] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   12.950908] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   12.996478] ata_piix 0000:00:1f.1: version 2.13
[   13.016247] scsi host1: ata_piix
[   13.029646] ipmi_si dmi-ipmi-si.0: Found new BMC (man_id: 0x002880, prod_id: 0x0000, dev_id: 0x00)
[   13.061553] scsi host2: ata_piix
[   13.061794] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1460 irq 14
[   13.061898] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1468 irq 15
[   13.063044] ata2: port disabled--ignoring
[   13.130761] ipmi_si dmi-ipmi-si.0: IPMI kcs interface initialized
[   13.222624] ata1.00: ATAPI: HL-DT-STDVD-ROM GDR8082N, 0002, max UDMA/33
[   13.242281] e1000 0000:02:01.0 eth0: (PCI:33MHz:32-bit) 00:0a:e4:13:60:82
[   13.242397] e1000 0000:02:01.0 eth0: Intel(R) PRO/1000 Network Connection
[   13.251727] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVD-ROM GDR8082N 0002 PQ: 0 ANSI: 5
[   13.365584] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   13.440933] iTCO_vendor_support: vendor-support=0
[   13.546137] e1000 0000:03:02.0 eth1: (PCI:66MHz:64-bit) 00:02:b3:b9:10:b5
[   13.546253] e1000 0000:03:02.0 eth1: Intel(R) PRO/1000 Network Connection
[   13.832862] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   13.833014] iTCO_wdt: Found a 6300ESB TCO device (Version=1, TCOBASE=0x1060)
[   13.833916] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   13.921486] sr 1:0:0:0: [sr0] scsi3-mmc drive: 10x/24x cd/rw xa/form2 cdda tray
[   13.921663] cdrom: Uniform CD-ROM driver Revision: 3.20
[   13.922102] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   13.950344] Adding 2093052k swap on /dev/sda5.  Priority:-2 extents:1 across:2093052k 
[   14.001568] audit: type=1400 audit(1532870759.931:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=157 comm="apparmor_parser"
[   14.058347] e1000 0000:04:06.0 eth2: (PCI:33MHz:32-bit) 00:0a:e4:13:60:83
[   14.058463] e1000 0000:04:06.0 eth2: Intel(R) PRO/1000 Network Connection
[   14.076980] audit: type=1400 audit(1532870760.007:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=167 comm="apparmor_parser"
[   14.077232] audit: type=1400 audit(1532870760.007:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=167 comm="apparmor_parser"
[   14.077465] audit: type=1400 audit(1532870760.007:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=167 comm="apparmor_parser"
[   14.160334] e1000 0000:03:02.0 enp3s2: renamed from eth1
[   14.161568] audit: type=1400 audit(1532870760.091:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ntpd" pid=156 comm="apparmor_parser"
[   14.177598] e1000 0000:02:01.0 enp2s1: renamed from eth0
[   14.202912] e1000 0000:04:06.0 enp4s6: renamed from eth2
[   17.373443] IPv6: ADDRCONF(NETDEV_UP): enp2s1: link is not ready
[   17.380463] e1000: enp2s1 NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX
[   17.380679] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s1: link becomes ready
[   24.375427] ================================================================================
[   24.375590] UBSAN: Undefined behaviour in ./include/net/route.h:239:2
[   24.375687] member access within null pointer of type 'struct rtable'
[   24.375786] CPU: 1 PID: 378 Comm: ntpdate Not tainted 4.18.0-rc6-00218-ga26fb01c2879-dirty #80
[   24.375937] Hardware name: FUJITSU SIEMENS PRIMERGY RX100S2/D1571/M71IXG, BIOS 6.0 Rev. C0F2.1571 04/27/2005
[   24.376089] Call Trace:
[   24.376191]  dump_stack+0x55/0x83
[   24.376289]  ubsan_epilogue+0xb/0x33
[   24.376385]  handle_null_ptr_deref+0x77/0x7e
[   24.376480]  __ubsan_handle_type_mismatch_v1+0x54/0x5f
[   24.376579]  udp_sendmsg+0xb3e/0xf1a
[   24.376676]  ? ip_output+0x135/0x135
[   24.376775]  ? apparmor_socket_recvmsg+0x4b/0x4b
[   24.376830]  ? aa_sk_perm+0x5a/0x32a
[   24.376830]  ? apparmor_socket_recvmsg+0x4b/0x4b
[   24.376830]  ? udp_cmsg_send+0xe0/0xe0
[   24.376830]  inet_sendmsg+0x68/0x1a9
[   24.376830]  ? ipv4_mib_init_net+0x232/0x232
[   24.376830]  sock_sendmsg+0x42/0x8d
[   24.376830]  ___sys_sendmsg+0xf9/0x34e
[   24.376830]  ? find_next_iomem_res+0x36/0x11f
[   24.376830]  ? walk_system_ram_range+0x62/0xa6
[   24.376830]  ? _raw_spin_unlock_bh+0x30/0x63
[   24.376830]  ? pat_pagerange_is_ram+0x68/0x84
[   24.376830]  ? memtype_seq_stop+0x1/0x1
[   24.376830]  ? __get_locked_pte+0xb3/0x133
[   24.376830]  ? insert_pfn+0x7e/0xfb
[   24.376830]  ? __fdget+0xd/0xf
[   24.376830]  ? sockfd_lookup_light+0x13/0x9c
[   24.376830]  __sys_sendmmsg+0xe9/0x1c2
[   24.376830]  ? handle_mm_fault+0x97a/0x14ad
[   24.376830]  ? ktime_get_real_ts64+0x6a/0x19f
[   24.376830]  sys_sendmmsg+0x22/0x24
[   24.376830]  do_fast_syscall_32+0xc7/0x3b3
[   24.376830]  entry_SYSENTER_32+0x4e/0x7c
[   24.376830] EIP: 0xb7f2fb1d
[   24.376830] Code: 00 05 58 f8 ff ff 8b 55 08 8b 80 5c cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
[   24.376830] EAX: ffffffda EBX: 00000005 ECX: bffafe7c EDX: 00000002
[   24.376830] ESI: 00004000 EDI: bffafebc EBP: 127aaeb0 ESP: bffafd60
[   24.376830] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
[   24.376830] ================================================================================


-- 
Meelis Roos (mroos@linux.ee)
