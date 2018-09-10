Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C9C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E1206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6E1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIJNJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:09:16 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:52337 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbeIJNJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:09:15 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id 0ECE4206F1;
        Mon, 10 Sep 2018 11:16:15 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id E2506220A79; Mon, 10 Sep 2018 11:16:12 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id DA8FE220A39;
        Mon, 10 Sep 2018 11:16:12 +0300 (EEST)
Date:   Mon, 10 Sep 2018 11:16:12 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Subject: 4.19-rc3: IOMMU PT warnings: WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:4065
 __alloc_pages_slowpath+0xb7b/0xcd0
Message-ID: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 4.19-rc1, I found that to keep Intel integrated graphics working when 
VT-d is on, I need to have IOMMU passthough on or GPU init would fail 
with DMAR error and the screen would display static gibberish. So I 
turned IOMMU PT on by default in kernel config. It worked, also in rc2.

Now with rc3, it still works but I get some warning splats in dmesg 
about IOMMU passthrough:

[    0.000000] microcode: microcode updated early to revision 0x8e, date = 2018-03-24
[    0.000000] Linux version 4.19.0-rc3 (mroos@ilves) (gcc version 8.2.0 (Debian 8.2.0-6)) #326 SMP Mon Sep 10 10:45:38 EEST 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-rc3 root=/dev/nvme0n1p1 ro
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c4acdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c4ace000-0x00000000c4acefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000c4acf000-0x00000000c4acffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c4ad0000-0x00000000c9d6ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9d70000-0x00000000ca0a4fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca0a5000-0x00000000ca21ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ca220000-0x00000000ca8fbfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ca8fc000-0x00000000caffdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000caffe000-0x00000000caffefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cafff000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042dffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. Q270M-D3H/Q270M-D3H, BIOS F6d 03/09/2018
[    0.000000] tsc: Detected 3400.000 MHz processor
[    0.001446] tsc: Detected 3408.000 MHz TSC
[    0.001446] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001447] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001452] last_pfn = 0x42e000 max_arch_pfn = 0x400000000
[    0.001455] MTRR default type: write-back
[    0.001455] MTRR fixed ranges enabled:
[    0.001456]   00000-9FFFF write-back
[    0.001456]   A0000-BFFFF uncachable
[    0.001457]   C0000-FFFFF write-protect
[    0.001457] MTRR variable ranges enabled:
[    0.001458]   0 base 00E0000000 mask 7FE0000000 uncachable
[    0.001459]   1 base 00D0000000 mask 7FF0000000 uncachable
[    0.001459]   2 base 00CC000000 mask 7FFC000000 uncachable
[    0.001459]   3 base 00CB800000 mask 7FFF800000 uncachable
[    0.001460]   4 disabled
[    0.001460]   5 disabled
[    0.001460]   6 disabled
[    0.001460]   7 disabled
[    0.001460]   8 disabled
[    0.001461]   9 disabled
[    0.002133] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002490] last_pfn = 0xcafff max_arch_pfn = 0x400000000
[    0.007442] found SMP MP-table at [mem 0x000fccb0-0x000fccbf] mapped at [(____ptrval____)]
[    0.007451] Base memory trampoline at [(____ptrval____)] 96000 size 24576
[    0.007454] Using GB pages for direct mapping
[    0.007455] BRK [0x309612000, 0x309612fff] PGTABLE
[    0.007456] BRK [0x309613000, 0x309613fff] PGTABLE
[    0.007457] BRK [0x309614000, 0x309614fff] PGTABLE
[    0.007469] BRK [0x309615000, 0x309615fff] PGTABLE
[    0.007470] BRK [0x309616000, 0x309616fff] PGTABLE
[    0.007519] BRK [0x309617000, 0x309617fff] PGTABLE
[    0.007537] BRK [0x309618000, 0x309618fff] PGTABLE
[    0.007595] BRK [0x309619000, 0x309619fff] PGTABLE
[    0.007618] BRK [0x30961a000, 0x30961afff] PGTABLE
[    0.007619] BRK [0x30961b000, 0x30961bfff] PGTABLE
[    0.007652] BRK [0x30961c000, 0x30961cfff] PGTABLE
[    0.007678] ACPI: Early table checksum verification disabled
[    0.007704] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.007707] ACPI: XSDT 0x00000000CA5200A8 0000D4 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007711] ACPI: FACP 0x00000000CA546E30 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.007714] ACPI: DSDT 0x00000000CA520218 026C16 (v02 ALASKA A M I    01072009 INTL 20160422)
[    0.007716] ACPI: FACS 0x00000000CA8CBC40 000040
[    0.007718] ACPI: APIC 0x00000000CA546F48 000084 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.007720] ACPI: FPDT 0x00000000CA546FD0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007722] ACPI: MCFG 0x00000000CA547018 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.007724] ACPI: SSDT 0x00000000CA547058 0003BC (v01 SataRe SataTabl 00001000 INTL 20160422)
[    0.007726] ACPI: FIDT 0x00000000CA547418 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007728] ACPI: SSDT 0x00000000CA5474B8 003159 (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.007730] ACPI: SSDT 0x00000000CA54A618 00255F (v02 PegSsd PegSsdt  00001000 INTL 20160422)
[    0.007732] ACPI: HPET 0x00000000CA54CB78 000038 (v01 INTEL  KBL      00000001 MSFT 0000005F)
[    0.007733] ACPI: SSDT 0x00000000CA54CBB0 000DE5 (v02 INTEL  Ther_Rvp 00001000 INTL 20160422)
[    0.007735] ACPI: SSDT 0x00000000CA54D998 002AD7 (v02 INTEL  xh_rvp10 00000000 INTL 20160422)
[    0.007737] ACPI: UEFI 0x00000000CA550470 000042 (v01 INTEL  EDK2     00000002      01000013)
[    0.007739] ACPI: SSDT 0x00000000CA5504B8 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.007741] ACPI: LPIT 0x00000000CA551398 000094 (v01 INTEL  KBL      00000000 MSFT 0000005F)
[    0.007743] ACPI: WSMT 0x00000000CA551430 000028 (v01 INTEL  KBL      00000000 MSFT 0000005F)
[    0.007745] ACPI: SSDT 0x00000000CA551458 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.007747] ACPI: SSDT 0x00000000CA5516F8 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.007748] ACPI: DBGP 0x00000000CA554700 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.007750] ACPI: DBG2 0x00000000CA554738 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.007752] ACPI: DMAR 0x00000000CA554790 0000A8 (v01 INTEL  KBL      00000001 INTL 00000001)
[    0.007754] ACPI: TPM2 0x00000000CA554838 000034 (v03 ALASKA A M I    00000001 AMI  00000000)
[    0.007756] ACPI: ASF! 0x00000000CA554870 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.007762] ACPI: Local APIC address 0xfee00000
[    0.007774] Zone ranges:
[    0.007775]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007776]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007777]   Normal   [mem 0x0000000100000000-0x000000042dffffff]
[    0.007778] Movable zone start for each node
[    0.007779] Early memory node ranges
[    0.007780]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.007780]   node   0: [mem 0x0000000000100000-0x00000000c4acdfff]
[    0.007781]   node   0: [mem 0x00000000c4ad0000-0x00000000c9d6ffff]
[    0.007781]   node   0: [mem 0x00000000ca0a5000-0x00000000ca21ffff]
[    0.007782]   node   0: [mem 0x00000000caffe000-0x00000000caffefff]
[    0.007782]   node   0: [mem 0x0000000100000000-0x000000042dffffff]
[    0.008045] Reserved but unavailable: 24955 pages
[    0.008046] Initmem setup node 0 [mem 0x0000000000001000-0x000000042dffffff]
[    0.008047] On node 0 totalpages: 4161157
[    0.008047]   DMA zone: 64 pages used for memmap
[    0.008048]   DMA zone: 21 pages reserved
[    0.008048]   DMA zone: 3995 pages, LIFO batch:0
[    0.008095]   DMA32 zone: 12860 pages used for memmap
[    0.008095]   DMA32 zone: 823018 pages, LIFO batch:63
[    0.018132]   Normal zone: 52096 pages used for memmap
[    0.018132]   Normal zone: 3334144 pages, LIFO batch:63
[    0.056334] Reserving Intel graphics memory at [mem 0xcc000000-0xcfffffff]
[    0.056497] ACPI: PM-Timer IO Port: 0x1808
[    0.056498] ACPI: Local APIC address 0xfee00000
[    0.056501] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.056502] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.056502] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.056503] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.056529] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.056530] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.056531] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.056532] ACPI: IRQ0 used by override.
[    0.056533] ACPI: IRQ9 used by override.
[    0.056534] Using ACPI (MADT) for SMP configuration information
[    0.056535] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.056537] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.056547] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.056548] PM: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
[    0.056548] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.056549] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.056549] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.056550] PM: Registered nosave memory: [mem 0xc4ace000-0xc4acefff]
[    0.056551] PM: Registered nosave memory: [mem 0xc4acf000-0xc4acffff]
[    0.056552] PM: Registered nosave memory: [mem 0xc9d70000-0xca0a4fff]
[    0.056553] PM: Registered nosave memory: [mem 0xca220000-0xca8fbfff]
[    0.056553] PM: Registered nosave memory: [mem 0xca8fc000-0xcaffdfff]
[    0.056554] PM: Registered nosave memory: [mem 0xcafff000-0xcfffffff]
[    0.056555] PM: Registered nosave memory: [mem 0xd0000000-0xf7ffffff]
[    0.056555] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.056556] PM: Registered nosave memory: [mem 0xfc000000-0xfdffffff]
[    0.056556] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.056557] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.056557] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.056558] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.056558] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.056559] PM: Registered nosave memory: [mem 0xfed01000-0xfedfffff]
[    0.056559] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.056560] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.056560] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.056562] [mem 0xd0000000-0xf7ffffff] available for PCI devices
[    0.056564] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.124095] random: get_random_bytes called from start_kernel+0x8f/0x502 with crng_init=0
[    0.124099] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.124189] percpu: Embedded 44 pages/cpu @(____ptrval____) s141208 r8192 d30824 u524288
[    0.124193] pcpu-alloc: s141208 r8192 d30824 u524288 alloc=1*2097152
[    0.124193] pcpu-alloc: [0] 0 1 2 3 
[    0.124205] Built 1 zonelists, mobility grouping on.  Total pages: 4096116
[    0.124206] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-rc3 root=/dev/nvme0n1p1 ro
[    0.124806] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.125096] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.154435] Memory: 16268440K/16644628K available (10252K kernel code, 1067K rwdata, 2540K rodata, 1348K init, 464K bss, 376188K reserved, 0K cma-reserved)
[    0.154459] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.154462] Kernel/User page tables isolation: enabled
[    0.160347] ftrace: allocating 33216 entries in 130 pages
[    0.169354] rcu: Hierarchical RCU implementation.
[    0.169356] rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.169356] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.171137] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
[    0.171301] rcu: 	Offload RCU callbacks from CPUs: (none).
[    0.171406] Console: colour dummy device 80x25
[    0.171518] console [tty0] enabled
[    0.171522] ACPI: Core revision 20180810
[    0.171779] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.171809] hpet clockevent registered
[    0.171844] APIC: Switch to symmetric I/O mode setup
[    0.171846] DMAR: Host address width 39
[    0.171847] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.171853] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.171854] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.171857] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.171859] DMAR: RMRR base: 0x000000ca02f000 end: 0x000000ca04efff
[    0.171860] DMAR: RMRR base: 0x000000cb800000 end: 0x000000cfffffff
[    0.171862] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.171863] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.173289] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.177208] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.195818] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[    0.195828] Calibrating delay loop (skipped), value calculated using timer frequency.. 6816.00 BogoMIPS (lpj=13632000)
[    0.195830] pid_max: default: 32768 minimum: 301
[    0.195841] Security Framework initialized
[    0.195850] AppArmor: AppArmor initialized
[    0.195882] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.195901] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.196009] mce: CPU supports 10 MCE banks
[    0.196016] CPU0: Thermal monitoring enabled (TM1)
[    0.196029] process: using mwait in idle threads
[    0.196032] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.196033] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.196035] Spectre V2 : Mitigation: Full generic retpoline
[    0.196036] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.196037] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    0.196038] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.196040] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.199149] Freeing SMP alternatives memory: 32K
[    0.199420] TSC deadline timer enabled
[    0.199425] smpboot: CPU0: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz (family: 0x6, model: 0x9e, stepping: 0x9)
[    0.199469] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.199492] ... version:                4
[    0.199493] ... bit width:              48
[    0.199495] ... generic registers:      8
[    0.199496] ... value mask:             0000ffffffffffff
[    0.199497] ... max period:             00007fffffffffff
[    0.199498] ... fixed-purpose events:   3
[    0.199499] ... event mask:             00000007000000ff
[    0.199523] rcu: Hierarchical SRCU implementation.
[    0.199576] random: crng done (trusting CPU's manufacturer)
[    0.199752] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.199774] smp: Bringing up secondary CPUs ...
[    0.199809] x86: Booting SMP configuration:
[    0.199810] .... node  #0, CPUs:      #1 #2 #3
[    0.200531] smp: Brought up 1 node, 4 CPUs
[    0.200531] smpboot: Max logical packages: 1
[    0.200531] smpboot: Total of 4 processors activated (27264.00 BogoMIPS)
[    0.201809] devtmpfs: initialized
[    0.201809] PM: Registering ACPI NVS region [mem 0xc4ace000-0xc4acefff] (4096 bytes)
[    0.201809] PM: Registering ACPI NVS region [mem 0xca220000-0xca8fbfff] (7192576 bytes)
[    0.201809] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.201809] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.201809] NET: Registered protocol family 16
[    0.201809] audit: initializing netlink subsys (disabled)
[    0.201809] audit: type=2000 audit(1536566041.032:1): state=initialized audit_enabled=0 res=1
[    0.201809] cpuidle: using governor ladder
[    0.201809] cpuidle: using governor menu
[    0.201809] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.201809] ACPI: bus type PCI registered
[    0.201809] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.201809] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.201809] PCI: Using configuration type 1 for base access
[    0.204001] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.204001] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.204001] ACPI: Added _OSI(Module Device)
[    0.204001] ACPI: Added _OSI(Processor Device)
[    0.204001] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.204001] ACPI: Added _OSI(Processor Aggregator Device)
[    0.204001] ACPI: Added _OSI(Linux-Dell-Video)
[    0.204001] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.226448] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.230450] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.232765] ACPI: Dynamic OEM Table Load:
[    0.232770] ACPI: SSDT 0xFFFF8EEADB7D3800 000717 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    0.233065] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.233925] ACPI: Dynamic OEM Table Load:
[    0.233929] ACPI: SSDT 0xFFFF8EEADB7DE000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    0.234355] ACPI: Dynamic OEM Table Load:
[    0.234359] ACPI: SSDT 0xFFFF8EEADB7D4000 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    0.234774] ACPI: Dynamic OEM Table Load:
[    0.234778] ACPI: SSDT 0xFFFF8EEADB0F6400 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.236553] ACPI: Interpreter enabled
[    0.236580] ACPI: (supports S0 S3 S4 S5)
[    0.236582] ACPI: Using IOAPIC for interrupt routing
[    0.236604] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.237226] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.238705] ACPI: Power Resource [PG00] (on)
[    0.238962] ACPI: Power Resource [PG01] (on)
[    0.239211] ACPI: Power Resource [PG02] (on)
[    0.241361] ACPI: Power Resource [WRST] (on)
[    0.241564] ACPI: Power Resource [WRST] (on)
[    0.241763] ACPI: Power Resource [WRST] (on)
[    0.241961] ACPI: Power Resource [WRST] (on)
[    0.242157] ACPI: Power Resource [WRST] (on)
[    0.242357] ACPI: Power Resource [WRST] (on)
[    0.242555] ACPI: Power Resource [WRST] (on)
[    0.242752] ACPI: Power Resource [WRST] (on)
[    0.242950] ACPI: Power Resource [WRST] (on)
[    0.243148] ACPI: Power Resource [WRST] (on)
[    0.243345] ACPI: Power Resource [WRST] (on)
[    0.243547] ACPI: Power Resource [WRST] (on)
[    0.243746] ACPI: Power Resource [WRST] (on)
[    0.243945] ACPI: Power Resource [WRST] (on)
[    0.244142] ACPI: Power Resource [WRST] (on)
[    0.244347] ACPI: Power Resource [WRST] (on)
[    0.244543] ACPI: Power Resource [WRST] (on)
[    0.245295] ACPI: Power Resource [WRST] (on)
[    0.245492] ACPI: Power Resource [WRST] (on)
[    0.245689] ACPI: Power Resource [WRST] (on)
[    0.253881] ACPI: Power Resource [FN00] (off)
[    0.253933] ACPI: Power Resource [FN01] (off)
[    0.253982] ACPI: Power Resource [FN02] (off)
[    0.254034] ACPI: Power Resource [FN03] (off)
[    0.254085] ACPI: Power Resource [FN04] (off)
[    0.254818] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.254823] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.254845] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.255128] PCI host bridge to bus 0000:00
[    0.255131] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.255133] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.255134] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.255136] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7ffffff window]
[    0.255138] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.255140] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.255147] pci 0000:00:00.0: [8086:591f] type 00 class 0x060000
[    0.255355] pci 0000:00:02.0: [8086:5912] type 00 class 0x030000
[    0.255363] pci 0000:00:02.0: reg 0x10: [mem 0xf6000000-0xf6ffffff 64bit]
[    0.255367] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.255370] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.255472] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.255481] pci 0000:00:08.0: reg 0x10: [mem 0xf714e000-0xf714efff 64bit]
[    0.255594] pci 0000:00:14.0: [8086:a2af] type 00 class 0x0c0330
[    0.255612] pci 0000:00:14.0: reg 0x10: [mem 0xf7130000-0xf713ffff 64bit]
[    0.255665] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.255812] pci 0000:00:16.0: [8086:a2ba] type 00 class 0x078000
[    0.255834] pci 0000:00:16.0: reg 0x10: [mem 0xf714d000-0xf714dfff 64bit]
[    0.255896] pci 0000:00:16.0: PME# supported from D3hot
[    0.256008] pci 0000:00:17.0: [8086:a282] type 00 class 0x010601
[    0.256022] pci 0000:00:17.0: reg 0x10: [mem 0xf7148000-0xf7149fff]
[    0.256028] pci 0000:00:17.0: reg 0x14: [mem 0xf714c000-0xf714c0ff]
[    0.256033] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    0.256039] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    0.256045] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    0.256050] pci 0000:00:17.0: reg 0x24: [mem 0xf714b000-0xf714b7ff]
[    0.256082] pci 0000:00:17.0: PME# supported from D3hot
[    0.256174] pci 0000:00:1b.0: [8086:a2e7] type 01 class 0x060400
[    0.256221] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.256325] pci 0000:00:1b.2: [8086:a2e9] type 01 class 0x060400
[    0.256376] pci 0000:00:1b.2: PME# supported from D0 D3hot D3cold
[    0.256385] pci 0000:00:1b.2: Intel SPT PCH root port ACS workaround enabled
[    0.256485] pci 0000:00:1b.3: [8086:a2ea] type 01 class 0x060400
[    0.256536] pci 0000:00:1b.3: PME# supported from D0 D3hot D3cold
[    0.256546] pci 0000:00:1b.3: Intel SPT PCH root port ACS workaround enabled
[    0.256645] pci 0000:00:1b.4: [8086:a2eb] type 01 class 0x060400
[    0.256703] pci 0000:00:1b.4: PME# supported from D0 D3hot D3cold
[    0.256714] pci 0000:00:1b.4: Intel SPT PCH root port ACS workaround enabled
[    0.256823] pci 0000:00:1c.0: [8086:a290] type 01 class 0x060400
[    0.256877] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.256980] pci 0000:00:1c.2: [8086:a292] type 01 class 0x060400
[    0.257037] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.257049] pci 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[    0.257151] pci 0000:00:1c.4: [8086:a294] type 01 class 0x060400
[    0.257208] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.257220] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    0.257328] pci 0000:00:1d.0: [8086:a298] type 01 class 0x060400
[    0.257378] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.257388] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[    0.257512] pci 0000:00:1f.0: [8086:a2c6] type 00 class 0x060100
[    0.257689] pci 0000:00:1f.2: [8086:a2a1] type 00 class 0x058000
[    0.257702] pci 0000:00:1f.2: reg 0x10: [mem 0xf7144000-0xf7147fff]
[    0.257827] pci 0000:00:1f.3: [8086:a2f0] type 00 class 0x040300
[    0.257851] pci 0000:00:1f.3: reg 0x10: [mem 0xf7140000-0xf7143fff 64bit]
[    0.257879] pci 0000:00:1f.3: reg 0x20: [mem 0xf7120000-0xf712ffff 64bit]
[    0.257921] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.258050] pci 0000:00:1f.4: [8086:a2a3] type 00 class 0x0c0500
[    0.258109] pci 0000:00:1f.4: reg 0x10: [mem 0xf714a000-0xf714a0ff 64bit]
[    0.258177] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.258337] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    0.258362] pci 0000:00:1f.6: reg 0x10: [mem 0xf7100000-0xf711ffff]
[    0.258461] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.258574] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.258615] pci 0000:02:00.0: [1283:8892] type 01 class 0x060401
[    0.258727] pci 0000:02:00.0: supports D1 D2
[    0.258728] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.258789] pci 0000:00:1b.2: PCI bridge to [bus 02-03]
[    0.258829] pci_bus 0000:03: extended config space not accessible
[    0.258899] pci 0000:02:00.0: PCI bridge to [bus 03] (subtractive decode)
[    0.258949] pci 0000:00:1b.3: PCI bridge to [bus 04]
[    0.258979] pci 0000:00:1b.4: PCI bridge to [bus 05]
[    0.259009] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.259039] pci 0000:00:1c.2: PCI bridge to [bus 07]
[    0.259070] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.259107] pci 0000:09:00.0: [144d:a804] type 00 class 0x010802
[    0.259129] pci 0000:09:00.0: reg 0x10: [mem 0xf7000000-0xf7003fff 64bit]
[    0.259303] pci 0000:00:1d.0: PCI bridge to [bus 09]
[    0.259307] pci 0000:00:1d.0:   bridge window [mem 0xf7000000-0xf70fffff]
[    0.259336] pci_bus 0000:00: on NUMA node 0
[    0.260805] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.260841] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.260875] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.260910] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.260944] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.260978] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.261012] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.261047] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.261340] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.261340] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.261340] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.261340] vgaarb: loaded
[    0.261340] SCSI subsystem initialized
[    0.261340] libata version 3.00 loaded.
[    0.261340] PCI: Using ACPI for IRQ routing
[    0.267432] PCI: pci_cache_line_size set to 64 bytes
[    0.267474] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    0.267475] e820: reserve RAM buffer [mem 0xc4ace000-0xc7ffffff]
[    0.267475] e820: reserve RAM buffer [mem 0xc9d70000-0xcbffffff]
[    0.267476] e820: reserve RAM buffer [mem 0xca220000-0xcbffffff]
[    0.267476] e820: reserve RAM buffer [mem 0xcafff000-0xcbffffff]
[    0.267477] e820: reserve RAM buffer [mem 0x42e000000-0x42fffffff]
[    0.267532] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.267532] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.268842] clocksource: Switched to clocksource tsc-early
[    0.273473] AppArmor: AppArmor Filesystem Enabled
[    0.273486] pnp: PnP ACPI init
[    0.273638] system 00:00: [io  0x0a00-0x0a2f] has been reserved
[    0.273641] system 00:00: [io  0x0a30-0x0a3f] has been reserved
[    0.273643] system 00:00: [io  0x0a40-0x0a4f] has been reserved
[    0.273646] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.273971] pnp 00:01: [dma 0 disabled]
[    0.274066] pnp 00:01: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.274343] pnp 00:02: [dma 0 disabled]
[    0.274368] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.274607] pnp 00:03: [dma 0 disabled]
[    0.274631] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.274711] system 00:04: [io  0x0680-0x069f] has been reserved
[    0.274714] system 00:04: [io  0xffff] has been reserved
[    0.274716] system 00:04: [io  0xffff] has been reserved
[    0.274717] system 00:04: [io  0xffff] has been reserved
[    0.274719] system 00:04: [io  0x1800-0x18fe] has been reserved
[    0.274721] system 00:04: [io  0x164e-0x164f] has been reserved
[    0.274724] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.274778] system 00:05: [io  0x0800-0x087f] has been reserved
[    0.274781] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.274791] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.274804] system 00:07: [io  0x1854-0x1857] has been reserved
[    0.274804] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.274804] system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.274804] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.274804] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.274804] system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.274804] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.274804] system 00:08: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.274804] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.274804] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    0.274804] system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.274804] system 00:08: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.274804] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.274804] system 00:09: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.274804] system 00:09: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.274804] system 00:09: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.274804] system 00:09: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.274804] system 00:09: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.274804] system 00:09: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.274804] system 00:09: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.274804] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.274804] system 00:0a: [io  0xff00-0xfffe] has been reserved
[    0.274804] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.275875] system 00:0b: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.275877] system 00:0b: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.275879] system 00:0b: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.275882] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.276405] pnp: PnP ACPI: found 12 devices
[    0.281502] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.281550] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.281557] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.281574] pci 0000:00:1b.2: PCI bridge to [bus 02-03]
[    0.281581] pci 0000:00:1b.3: PCI bridge to [bus 04]
[    0.281587] pci 0000:00:1b.4: PCI bridge to [bus 05]
[    0.281594] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.281602] pci 0000:00:1c.2: PCI bridge to [bus 07]
[    0.281609] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.281616] pci 0000:00:1d.0: PCI bridge to [bus 09]
[    0.281620] pci 0000:00:1d.0:   bridge window [mem 0xf7000000-0xf70fffff]
[    0.281625] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.281626] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.281627] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.281628] pci_bus 0000:00: resource 7 [mem 0xd0000000-0xf7ffffff window]
[    0.281629] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    0.281630] pci_bus 0000:09: resource 1 [mem 0xf7000000-0xf70fffff]
[    0.281714] NET: Registered protocol family 2
[    0.281781] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes)
[    0.281795] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.281875] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.281965] TCP: Hash tables configured (established 131072 bind 65536)
[    0.281980] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.282001] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.282039] NET: Registered protocol family 1
[    0.282043] NET: Registered protocol family 44
[    0.282049] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.308543] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x6a1 took 25865 usecs
[    0.308576] PCI: CLS 64 bytes, default 64
[    0.308602] DMAR: No ATSR found
[    0.308617] DMAR: dmar0: Using Queued invalidation
[    0.308662] DMAR: dmar1: Using Queued invalidation
[    0.308886] DMAR: Hardware identity mapping for device 0000:00:00.0
[    0.308895] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:4065 __alloc_pages_slowpath+0xb7b/0xcd0
[    0.308896] Modules linked in:
[    0.308899] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc3 #326
[    0.308900] Hardware name: Gigabyte Technology Co., Ltd. Q270M-D3H/Q270M-D3H, BIOS F6d 03/09/2018
[    0.308903] RIP: 0010:__alloc_pages_slowpath+0xb7b/0xcd0
[    0.308905] Code: 24 38 00 00 00 00 c7 44 24 50 00 00 00 00 c7 44 24 3c 01 00 00 00 e9 5f fd ff ff 31 c0 41 81 e7 00 02 00 00 0f 85 22 fa ff ff <0f> 0b e9 1b fa ff ff 65 48 8b 04 25 40 4d 01 00 8b 4c 24 58 3b 88
[    0.308907] RSP: 0000:ffffaab3c002fb80 EFLAGS: 00010046
[    0.308909] RAX: 0000000000000000 RBX: 0000000000488020 RCX: 000000000000000b
[    0.308911] RDX: ffffaab3c002fc70 RSI: 000000000000000b RDI: 0000000000488020
[    0.308912] RBP: 0000000000488020 R08: 0000000000000001 R09: 0000000000000787
[    0.308914] R10: 0000000000000002 R11: 0000000000000000 R12: 000000000000000b
[    0.308915] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.308917] FS:  0000000000000000(0000) GS:ffff8eeadda00000(0000) knlGS:0000000000000000
[    0.308919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.308920] CR2: 0000000000000000 CR3: 000000030900a001 CR4: 00000000003606f0
[    0.308922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.308923] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.308925] Call Trace:
[    0.308928]  ? get_page_from_freelist+0x27c/0xe60
[    0.308931]  ? dummycon_cursor+0x10/0x10
[    0.308933]  ? con_scroll+0x15e/0x1e0
[    0.308936]  ? pci_mmcfg_read+0x3e/0xe0
[    0.308938]  __alloc_pages_nodemask+0x240/0x260
[    0.308941]  intel_pasid_alloc_table+0x11a/0x180
[    0.308943]  dmar_insert_one_dev_info+0x29d/0x4a0
[    0.308946]  ? klist_iter_exit+0x17/0x30
[    0.308949]  ? bus_find_device+0x90/0xc0
[    0.308951]  domain_add_dev_info+0x50/0x90
[    0.308954]  dev_prepare_static_identity_mapping+0x30/0x72
[    0.308957]  intel_iommu_init+0xbeb/0x10c3
[    0.308960]  ? do_utimes+0xfc/0x170
[    0.308961]  ? free_one_page+0x5e/0x3b0
[    0.308964]  ? do_early_param+0x8e/0x8e
[    0.308966]  ? e820__memblock_setup+0x9b/0x9b
[    0.308967]  pci_iommu_init+0x16/0x3f
[    0.308970]  do_one_initcall+0x46/0x1b8
[    0.308972]  ? do_early_param+0x8e/0x8e
[    0.308974]  kernel_init_freeable+0x16a/0x1f4
[    0.308976]  ? rest_init+0x9a/0x9a
[    0.308978]  kernel_init+0xa/0x106
[    0.308980]  ret_from_fork+0x35/0x40
[    0.308983] ---[ end trace 8500df6a3f7aa4dd ]---
[    0.308985] DMAR: Failed to setup IOMMU pass-through
[    0.308993] DMAR: Initialization failed
[    0.327846] =============================================================================
[    0.327855] BUG iommu_domain (Tainted: G        W        ): Objects remaining in iommu_domain on __kmem_cache_shutdown()
[    0.327862] -----------------------------------------------------------------------------

[    0.327871] Disabling lock debugging due to kernel taint
[    0.327880] INFO: Slab 0x00000000de83fb3c objects=11 used=1 fp=0x0000000090a3fdd6 flags=0x8000000000008100
[    0.327890] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B   W         4.19.0-rc3 #326
[    0.327906] Hardware name: Gigabyte Technology Co., Ltd. Q270M-D3H/Q270M-D3H, BIOS F6d 03/09/2018
[    0.327907] Call Trace:
[    0.327910]  dump_stack+0x46/0x60
[    0.327912]  slab_err+0xb0/0xd4
[    0.327915]  ? on_each_cpu_cond+0x8a/0xc0
[    0.327918]  ? __kmalloc+0x1ee/0x200
[    0.327919]  __kmem_cache_shutdown.cold.105+0x1b/0x13c
[    0.327922]  shutdown_cache+0x11/0x140
[    0.327924]  kmem_cache_destroy+0x1dc/0x210
[    0.327927]  intel_iommu_init+0xf58/0x10c3
[    0.327929]  ? do_utimes+0xfc/0x170
[    0.327931]  ? free_one_page+0x5e/0x3b0
[    0.327933]  ? do_early_param+0x8e/0x8e
[    0.327934]  ? e820__memblock_setup+0x9b/0x9b
[    0.327936]  pci_iommu_init+0x16/0x3f
[    0.327938]  do_one_initcall+0x46/0x1b8
[    0.327940]  ? do_early_param+0x8e/0x8e
[    0.327941]  kernel_init_freeable+0x16a/0x1f4
[    0.327943]  ? rest_init+0x9a/0x9a
[    0.327945]  kernel_init+0xa/0x106
[    0.327947]  ret_from_fork+0x35/0x40
[    0.327949] INFO: Object 0x00000000b2ef53ae @offset=0
[    0.327950] kmem_cache_destroy iommu_domain: Slab cache still has objects
[    0.327952] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B   W         4.19.0-rc3 #326
[    0.327954] Hardware name: Gigabyte Technology Co., Ltd. Q270M-D3H/Q270M-D3H, BIOS F6d 03/09/2018
[    0.327955] Call Trace:
[    0.327957]  dump_stack+0x46/0x60
[    0.327959]  kmem_cache_destroy+0x1fa/0x210
[    0.327961]  intel_iommu_init+0xf58/0x10c3
[    0.327963]  ? do_utimes+0xfc/0x170
[    0.327965]  ? free_one_page+0x5e/0x3b0
[    0.327967]  ? do_early_param+0x8e/0x8e
[    0.327969]  ? e820__memblock_setup+0x9b/0x9b
[    0.327970]  pci_iommu_init+0x16/0x3f
[    0.327972]  do_one_initcall+0x46/0x1b8
[    0.327974]  ? do_early_param+0x8e/0x8e
[    0.327976]  kernel_init_freeable+0x16a/0x1f4
[    0.327977]  ? rest_init+0x9a/0x9a
[    0.327979]  kernel_init+0xa/0x106
[    0.327981]  ret_from_fork+0x35/0x40
[    0.327983] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.327985] software IO TLB: mapped [mem 0xc5d70000-0xc9d70000] (64MB)
[    0.328012] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    0.328014] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    0.328015] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.328016] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    0.328017] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    0.328019] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    0.328074] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[    0.328081] clocksource: Switched to clocksource tsc
[    0.328257] simple-framebuffer simple-framebuffer.0: framebuffer at 0xe0000000, 0x8ca000 bytes, mapped to 0x00000000f62e1f12
[    0.328260] simple-framebuffer simple-framebuffer.0: format=a8r8g8b8, mode=1920x1200x32, linelength=7680
[    0.331033] Console: switching to colour frame buffer device 240x75
[    0.333653] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
[    0.333867] workingset: timestamp_bits=46 max_order=22 bucket_order=0
[    0.334760] pstore: using deflate compression
[    0.335190] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.335221] io scheduler noop registered
[    0.335231] io scheduler deadline registered (default)
[    0.335247] io scheduler mq-deadline registered (default)
[    0.335968] intel_idle: MWAIT substates: 0x142120
[    0.335968] intel_idle: v0.4.1 model 0x9E
[    0.336062] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.336110] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.336132] ACPI: Sleep Button [SLPB]
[    0.336156] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.336176] ACPI: Power Button [PWRB]
[    0.336202] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.336222] ACPI: Power Button [PWRF]
[    0.336534] thermal LNXTHERM:00: registered as thermal_zone0
[    0.336548] ACPI: Thermal Zone [TZ00] (28 C)
[    0.336631] thermal LNXTHERM:01: registered as thermal_zone1
[    0.336645] ACPI: Thermal Zone [TZ01] (30 C)
[    0.336682] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.357212] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.377757] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.378130] Linux agpgart interface v0.103
[    0.378719] [drm] VT-d active for gfx access
[    0.378730] checking generic (e0000000 8ca000) vs hw (e0000000 10000000)
[    0.378731] fb: switching to inteldrmfb from simple
[    0.378751] Console: switching to colour dummy device 80x25
[    0.378837] [drm] Replacing VGA console driver
[    0.379421] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.379423] [drm] Driver supports precise vblank timestamp query.
[    0.379808] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.380115] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    0.918459] [drm] Initialized i915 1.6.0 20180719 for 0000:00:02.0 on minor 0
[    0.919554] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    0.919714] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    0.920252] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    0.920721] nvme nvme0: pci function 0000:09:00.0
[    0.920740] ahci 0000:00:17.0: version 3.0
[    0.921209] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    0.921213] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[    0.941545] fbcon: inteldrmfb (fb0) is primary device
[    0.980588] scsi host0: ahci
[    0.980719] scsi host1: ahci
[    0.983143] Console: switching to colour frame buffer device 240x75
[    0.983309] scsi host2: ahci
[    0.983619] scsi host3: ahci
[    0.983769] scsi host4: ahci
[    0.983950] scsi host5: ahci
[    0.983998] ata1: SATA max UDMA/133 abar m2048@0xf714b000 port 0xf714b100 irq 125
[    0.984000] ata2: SATA max UDMA/133 abar m2048@0xf714b000 port 0xf714b180 irq 125
[    0.984001] ata3: SATA max UDMA/133 abar m2048@0xf714b000 port 0xf714b200 irq 125
[    0.984002] ata4: SATA max UDMA/133 abar m2048@0xf714b000 port 0xf714b280 irq 125
[    0.984003] ata5: SATA max UDMA/133 abar m2048@0xf714b000 port 0xf714b300 irq 125
[    0.984004] ata6: SATA max UDMA/133 abar m2048@0xf714b000 port 0xf714b380 irq 125
[    0.984054] i8042: PNP: No PS/2 controller found.
[    0.984179] mousedev: PS/2 mouse device common for all mice
[    0.984213] rtc_cmos 00:06: RTC can wake from S4
[    0.984658] rtc_cmos 00:06: registered as rtc0
[    0.984665] rtc_cmos 00:06: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.984670] intel_pstate: Intel P-state driver initializing
[    0.984759] intel_pstate: HWP enabled
[    0.984859] NET: Registered protocol family 10
[    0.985108] Segment Routing with IPv6
[    0.985118] mip6: Mobile IPv6
[    0.985119] NET: Registered protocol family 17
[    0.985134] Key type dns_resolver registered
[    0.985252] RAS: Correctable Errors collector initialized.
[    0.985265] microcode: sig=0x906e9, pf=0x2, revision=0x8e
[    0.985285] microcode: Microcode Update Driver: v2.2.
[    0.985290] sched_clock: Marking stable (988854796, -3571923)->(990748273, -5465400)
[    0.985382] registered taskstats version 1
[    0.985389] AppArmor: AppArmor sha1 policy hashing enabled
[    0.986239] rtc_cmos 00:06: setting system clock to 2018-09-10 07:54:02 UTC (1536566042)
[    1.000898] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.154817]  nvme0n1: p1 p2 p3
[    1.296314] ata6: SATA link down (SStatus 0 SControl 300)
[    1.296409] ata4: SATA link down (SStatus 0 SControl 300)
[    1.296499] ata2: SATA link down (SStatus 0 SControl 300)
[    1.296587] ata1: SATA link down (SStatus 0 SControl 300)
[    1.296676] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.296757] ata5: SATA link down (SStatus 0 SControl 300)
[    1.298134] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.SAT0.PRT2._GTF.DSSP], AE_NOT_FOUND (20180810/psargs-330)
[    1.298260] ACPI Error: Method parse/execution failed \_SB.PCI0.SAT0.PRT2._GTF, AE_NOT_FOUND (20180810/psparse-516)
[    1.298374] ata3.00: ATAPI: HL-DT-ST DVDRAM GH24NSD1, LG00, max UDMA/133
[    1.300107] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.SAT0.PRT2._GTF.DSSP], AE_NOT_FOUND (20180810/psargs-330)
[    1.300233] ACPI Error: Method parse/execution failed \_SB.PCI0.SAT0.PRT2._GTF, AE_NOT_FOUND (20180810/psparse-516)
[    1.302994] ata3.00: configured for UDMA/133
[    1.308381] scsi 2:0:0:0: CD-ROM            HL-DT-ST DVDRAM GH24NSD1  LG00 PQ: 0 ANSI: 5
[    1.371245] sr 2:0:0:0: [sr0] scsi3-mmc drive: 48x/12x writer dvd-ram cd/rw xa/form2 cdda tray
[    1.374193] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.377500] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.377702] sr 2:0:0:0: Attached scsi generic sg0 type 5
[    1.385116] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
[    1.388194] VFS: Mounted root (ext4 filesystem) readonly on device 259:1.
[    1.391704] devtmpfs: mounted
[    1.576165] Freeing unused kernel image memory: 1348K
[    1.592044] Write protecting the kernel read-only data: 16384k
[    1.597267] Freeing unused kernel image memory: 2000K
[    1.598163] Freeing unused kernel image memory: 1556K
[    1.602742] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.603397] x86/mm: Checking user space page tables
[    1.607823] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.608472] Run /sbin/init as init process
[    1.676454] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    1.700466] systemd[1]: Detected architecture x86-64.
[    1.716835] systemd[1]: Set hostname to <ilves>.
[    1.808285] systemd[1]: Created slice system-postfix.slice.
[    1.810380] systemd[1]: Created slice User and Session Slice.
[    1.812472] systemd[1]: Created slice system-getty.slice.
[    1.814386] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    1.816740] systemd[1]: Listening on LVM2 poll daemon socket.
[    1.818732] systemd[1]: Listening on Journal Audit Socket.
[    1.820732] systemd[1]: Listening on LVM2 metadata daemon socket.
[    1.835740] i2c /dev entries driver
[    1.838708] loop: module loaded
[    1.853296] RPC: Registered named UNIX socket transport module.
[    1.853297] RPC: Registered udp transport module.
[    1.853297] RPC: Registered tcp transport module.
[    1.853297] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.902863] EXT4-fs (nvme0n1p1): re-mounted. Opts: errors=remount-ro
[    1.921935] systemd-journald[154]: Received request to flush runtime journal from PID 1
[    1.977732] parport_pc 00:01: reported by Plug and Play ACPI
[    1.978512] parport0: PC-style at 0x378, irq 5 [PCSPP,TRISTATE,EPP]
[    1.999903] ACPI: bus type USB registered
[    2.000585] usbcore: registered new interface driver usbfs
[    2.001253] usbcore: registered new interface driver hub
[    2.001918] usbcore: registered new device driver usb
[    2.002618] i801_smbus 0000:00:1f.4: enabling device (0001 -> 0003)
[    2.003373] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.004062] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.006700] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.007356] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.008987] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.009502] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    2.009645] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.010992] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.011154] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    2.011187] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    2.011831] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.011832] usb usb1: Product: xHCI Host Controller
[    2.011834] usb usb1: Manufacturer: Linux 4.19.0-rc3 xhci-hcd
[    2.014543] usb usb1: SerialNumber: 0000:00:14.0
[    2.015331] hub 1-0:1.0: USB hub found
[    2.016056] hub 1-0:1.0: 16 ports detected
[    2.017712] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.018392] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.019323] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[    2.020039] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    2.020711] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.021377] usb usb2: Product: xHCI Host Controller
[    2.022042] usb usb2: Manufacturer: Linux 4.19.0-rc3 xhci-hcd
[    2.022716] usb usb2: SerialNumber: 0000:00:14.0
[    2.023450] hub 2-0:1.0: USB hub found
[    2.024797] hub 2-0:1.0: 10 ports detected
[    2.026273] usb: port power management may be unreliable
[    2.030494] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops 0xffffffff8ac82280)
[    2.033328] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    2.034666] Error: Driver 'pcspkr' is already registered, aborting...
[    2.052402] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC887-VD: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[    2.053096] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
[    2.053800] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    2.054289] Adding 16777212k swap on /dev/nvme0n1p2.  Priority:-2 extents:1 across:16777212k SS
[    2.054528] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    2.055941] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[    2.056640] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    2.057349] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    2.058034] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    2.058718] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    2.068638] cryptd: max_cpu_qlen set to 1000
[    2.070605] AVX2 version of gcm_enc/dec engaged.
[    2.071288] AES CTR mode by8 optimization enabled
[    2.086598] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input5
[    2.088275] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input6
[    2.088983] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
[    2.089692] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[    2.090405] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[    2.091122] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    2.091846] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    2.092579] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    2.093327] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    2.094074] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    2.094803] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    2.095529] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    2.096252] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    2.121497] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data mode. Opts: errors=remount-ro
[    2.150231] iTCO_vendor_support: vendor-support=0
[    2.151992] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.152745] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[    2.153535] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    2.178410] audit: type=1400 audit(1536566043.687:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=296 comm="apparmor_parser"
[    2.178739] audit: type=1400 audit(1536566043.687:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/haveged" pid=294 comm="apparmor_parser"
[    2.182063] audit: type=1400 audit(1536566043.691:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ntpd" pid=300 comm="apparmor_parser"
[    2.182409] audit: type=1400 audit(1536566043.691:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/unreal-*/System/*.bin" pid=299 comm="apparmor_parser"
[    2.186221] audit: type=1400 audit(1536566043.695:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/cups/backend/cups-pdf" pid=298 comm="apparmor_parser"
[    2.186222] audit: type=1400 audit(1536566043.695:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cupsd" pid=298 comm="apparmor_parser"
[    2.186223] audit: type=1400 audit(1536566043.695:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cupsd//third_party" pid=298 comm="apparmor_parser"
[    2.187375] audit: type=1400 audit(1536566043.695:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=308 comm="apparmor_parser"
[    2.188377] audit: type=1400 audit(1536566043.699:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=309 comm="apparmor_parser"
[    2.196163] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 1c:1b:0d:97:f1:31
[    2.196164] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    2.196577] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    2.203112] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    2.244195] pktcdvd: pktcdvd0: writer mapped to sr0
[    2.302546] new mount options do not match the existing superblock, will be ignored
[    2.336786] fuse init (API version 7.27)
[    2.355847] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    2.529932] usb 1-1: New USB device found, idVendor=046d, idProduct=0a44, bcdDevice= 1.27
[    2.529938] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.529942] usb 1-1: Product: Logitech USB Headset
[    2.529957] usb 1-1: Manufacturer: Logitech
[    2.604262] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
[    2.655882] usb 1-12: new full-speed USB device number 3 using xhci_hcd
[    2.812972] usb 1-12: New USB device found, idVendor=058f, idProduct=9540, bcdDevice= 1.20
[    2.812974] usb 1-12: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.812975] usb 1-12: Product: EMV Smartcard Reader
[    2.812975] usb 1-12: Manufacturer: Generic
[    2.893925] bpfilter: Loaded bpfilter_umh pid 744
[    2.939847] usb 1-13: new high-speed USB device number 4 using xhci_hcd
[    3.091957] usb 1-13: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= b.b3
[    3.091958] usb 1-13: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.092474] hub 1-13:1.0: USB hub found
[    3.092496] hub 1-13:1.0: 4 ports detected
[    3.102513] hidraw: raw HID events driver (C) Jiri Kosina
[    3.119270] usbcore: registered new interface driver snd-usb-audio
[    3.120214] usbcore: registered new interface driver usbhid
[    3.120215] usbhid: USB HID core driver
[    3.122228] input: Logitech Logitech USB Headset as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.3/0003:046D:0A44.0001/input/input18
[    3.180301] hid-generic 0003:046D:0A44.0001: input,hidraw0: USB HID v1.00 Device [Logitech Logitech USB Headset] on usb-0000:00:14.0-1/input3
[    3.308619] device-mapper: uevent: version 1.0.3
[    3.310672] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    3.387867] usb 1-13.1: new low-speed USB device number 5 using xhci_hcd
[    3.499236] usb 1-13.1: New USB device found, idVendor=046d, idProduct=c05a, bcdDevice=63.00
[    3.499242] usb 1-13.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.499246] usb 1-13.1: Product: USB Optical Mouse
[    3.499249] usb 1-13.1: Manufacturer: Logitech
[    3.504241] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-13/1-13.1/1-13.1:1.0/0003:046D:C05A.0002/input/input19
[    3.504699] hid-generic 0003:046D:C05A.0002: input,hidraw1: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-13.1/input0
[    3.531914] device-mapper: ioctl: remove_all left 1 open device(s)
[    3.583922] usb 1-13.2: new low-speed USB device number 6 using xhci_hcd
[    3.634843] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    3.637633] Bridge firewalling registered
[    3.708627] usb 1-13.2: New USB device found, idVendor=03f0, idProduct=034a, bcdDevice= 1.21
[    3.708633] usb 1-13.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.708637] usb 1-13.2: Product: HP Elite USB Keyboard
[    3.708641] usb 1-13.2: Manufacturer: Chicony
[    3.723385] input: Chicony HP Elite USB Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-13/1-13.2/1-13.2:1.0/0003:03F0:034A.0003/input/input20
[    3.764650] Initializing XFRM netlink socket
[    3.779930] hid-generic 0003:03F0:034A.0003: input,hidraw2: USB HID v1.10 Keyboard [Chicony HP Elite USB Keyboard] on usb-0000:00:14.0-13.2/input0
[    3.787145] input: Chicony HP Elite USB Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-13/1-13.2/1-13.2:1.1/0003:03F0:034A.0004/input/input21
[    3.797143] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[    3.843920] input: Chicony HP Elite USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-13/1-13.2/1-13.2:1.1/0003:03F0:034A.0004/input/input22
[    3.843957] hid-generic 0003:03F0:034A.0004: input,hidraw3: USB HID v1.10 Device [Chicony HP Elite USB Keyboard] on usb-0000:00:14.0-13.2/input1
[    3.923887] usb 1-13.4: new full-speed USB device number 7 using xhci_hcd
[    4.034877] usb 1-13.4: New USB device found, idVendor=076b, idProduct=1021, bcdDevice= 1.00
[    4.034891] usb 1-13.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.034892] usb 1-13.4: Product: Smart Card Reader USB
[    4.034892] usb 1-13.4: Manufacturer: OMNIKEY
[    5.978103] e1000e: enp0s31f6 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[    5.978146] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s31f6: link becomes ready

-- 
Meelis Roos (mroos@linux.ee)
