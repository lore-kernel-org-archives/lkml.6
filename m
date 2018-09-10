Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D279E2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D279E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeIJTBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:01:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:34391 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeIJTBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:01:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 07:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="bad'?good'?scan'208";a="68886658"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 10 Sep 2018 07:07:11 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Sep 2018 17:07:10 +0300
Date:   Mon, 10 Sep 2018 17:07:10 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Message-ID: <20180910140710.GR5565@intel.com>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Sep 10, 2018 at 02:48:45PM +0200, Thomas Gleixner wrote:
> Ville,
> 
> On Mon, 10 Sep 2018, Ville Syrjala wrote:
> 
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > This reverts commit 608008a45798fe9e2aee04f99b5270ea57c1376f.
> > 
> > It breaks wifi on my pentium 3 Fujitsu-Siemens Lifebook S6010
> > laptop. Scanning for APs doesn't seem to work most of the time,
> > and, even when it manages to find some APs it never manages to
> > authenticate successfully. dmesg is just littered with:
> > "wlan0: send auth to ... (try 1/3)
> >  wlan0: send auth to ... (try 2/3)
> >  wlan0: send auth to ... (try 3/3)
> >  wlan0: authentication with ... timed out"
> 
> I asked for that before and I really do not understand why you do not even
> make an attempt to report an issue first and allow the developers to work
> with you to figure out what exactly is the problem. All you do is to send
> an revert patch with a changelog which describes symptoms and probably
> breaks more than it cures. Not really helpful, really.

You're reading way too much into this. The revert is just a point to
start the conversion. I've found that it's the best way to get the
attention of the relevant developers. Other kind of regression
reports have an unfortunate habit of disappearing into /dev/null.

> 
> It's surely helpful to know that you bisected it to that commit and
> reverting it helps. Can you please provide more detailes information like
> dmesg of an good and a bad boot?

I think the only real difference (apart from the USB noise) is:
- clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1cbd01c4e18, max_idle_ns: 881590491211 ns
- Calibrating delay loop (skipped), value calculated using timer frequency.. 1718674.70 BogoMIPS (lpj=2863311530)
+ clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1cbc55fe3af, max_idle_ns: 881590592998 ns
+ Calibrating delay loop (skipped), value calculated using timer frequency.. 859455.59 BogoMIPS (lpj=1431852151)

Full logs attached.

-- 
Ville Syrjälä
Intel

--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.bad"

[    0.000000] Linux version 4.18.0-rc5-alm-bisect-00312-g608008a45798 (vsyrjala@stinkpad) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #14 PREEMPT Sun Sep 9 20:44:16 EEST 2018
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003f6dffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003f6e0000-0x000000003f6efbff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003f6efc00-0x000000003f6effff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003f6f0000-0x000000003f6fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003f700000-0x000000003f77ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003f780000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: FUJITSU SIEMENS LIFEBOOK S6010/FJNB159, BIOS Version 1.07  10/28/2002
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 996.769 MHz processor
[    0.006770] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.006778] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.006795] last_pfn = 0x3f780 max_arch_pfn = 0x1000000
[    0.006810] MTRR default type: uncachable
[    0.006812] MTRR fixed ranges enabled:
[    0.006816]   00000-9FFFF write-back
[    0.006819]   A0000-BFFFF uncachable
[    0.006821]   C0000-C7FFF write-protect
[    0.006825]   C8000-EFFFF uncachable
[    0.006827]   F0000-FFFFF write-protect
[    0.006829] MTRR variable ranges enabled:
[    0.006834]   0 base 000000000 mask FC0000000 write-back
[    0.006837]   1 base 03FF80000 mask FFFF80000 uncachable
[    0.006839]   2 disabled
[    0.006841]   3 disabled
[    0.006842]   4 disabled
[    0.006844]   5 disabled
[    0.006846]   6 disabled
[    0.006847]   7 disabled
[    0.007342] x86/PAT: PAT not supported by CPU.
[    0.007825] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.007842] Warning only 889MB will be used.
[    0.007846] Use a HIGHMEM enabled kernel.
[    0.007939] Scanning 1 areas for low memory corruption
[    0.007945] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.007956] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.008059] BRK [0x0179f000, 0x0179ffff] PGTABLE
[    0.008092] BRK [0x017a0000, 0x017a0fff] PGTABLE
[    0.008101] RAMDISK: [mem 0x37b18000-0x37feffff]
[    0.008109] Allocated new RAMDISK: [mem 0x37526000-0x379fd7ff]
[    0.030953] Move RAMDISK from [mem 0x37b18000-0x37fef7ff] to [mem 0x37526000-0x379fd7ff]
[    0.030995] ACPI: Early table checksum verification disabled
[    0.031919] ACPI: RSDP 0x00000000000F6300 000014 (v00 FUJ   )
[    0.031938] ACPI: RSDT 0x000000003F6EA053 000028 (v01 FUJ    LAUREL   01070000 FUJ  00001000)
[    0.031963] ACPI: FACP 0x000000003F6EFB8C 000074 (v01 FUJ    LAUREL   01070000 FUJ  00001000)
[    0.031987] ACPI: DSDT 0x000000003F6EA07B 005B11 (v01 FUJ    LAUREL   01070000 MSFT 01000007)
[    0.032004] ACPI: FACS 0x000000003F6EFFC0 000040
[    0.032053] 889MB LOWMEM available.
[    0.032058]   mapped low ram: 0 - 379fe000
[    0.032062]   low ram: 0 - 379fe000
[    0.032084] cma: Reserved 4 MiB at 0x0000000037000000
[    0.032097] Zone ranges:
[    0.032102]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.032109]   Normal   [mem 0x0000000001000000-0x00000000379fdfff]
[    0.032116] Movable zone start for each node
[    0.032120] Early memory node ranges
[    0.032125]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.032131]   node   0: [mem 0x0000000000100000-0x000000003f6dffff]
[    0.032137]   node   0: [mem 0x000000003f700000-0x000000003f77ffff]
[    0.032144] Initmem setup node 0 [mem 0x0000000000001000-0x000000003f77ffff]
[    0.032153] On node 0 totalpages: 227740
[    0.051804]   DMA zone: 32 pages used for memmap
[    0.051810]   DMA zone: 0 pages reserved
[    0.051814]   DMA zone: 3998 pages, LIFO batch:0
[    0.052459]   Normal zone: 1748 pages used for memmap
[    0.052466]   Normal zone: 223742 pages, LIFO batch:31
[    0.086740] Using APIC driver default
[    0.086780] Reserving Intel graphics memory at [mem 0x3f780000-0x3ff7ffff]
[    0.086925] ACPI: PM-Timer IO Port: 0xfc08
[    0.086946] Local APIC disabled by BIOS -- reenabling.
[    0.086952] Found and enabled local APIC!
[    0.087023] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.087034] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.087040] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.087045] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.087056] [mem 0x40000000-0xffefffff] available for PCI devices
[    0.087074] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.087127] random: get_random_bytes called from start_kernel+0x5b/0x390 with crng_init=0
[    0.087251] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.087258] pcpu-alloc: [0] 0 
[    0.087312] Built 1 zonelists, mobility grouping on.  Total pages: 225960
[    0.087323] Kernel command line: root=/dev/sda3 resume=/dev/sda2 lapic drm.debug=0xe modprobe.blacklist=i915
[    0.088946] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.089693] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.089736] Initializing CPU#0
[    0.130646] Memory: 886056K/910960K available (4942K kernel code, 521K rwdata, 1328K rodata, 472K init, 412K bss, 20808K reserved, 4096K cma-reserved)
[    0.130673] virtual kernel memory layout:
                   fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
                 cpu_entry : 0xffa00000 - 0xffa28000   ( 160 kB)
                   vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
                     .init : 0xc16b3000 - 0xc1729000   ( 472 kB)
                     .data : 0xc14d38e8 - 0xc16a67a0   (1867 kB)
                     .text : 0xc1000000 - 0xc14d38e8   (4942 kB)
[    0.130691] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.130967] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.131493] Preemptible hierarchical RCU implementation.
[    0.131517] 	Tasks RCU enabled.
[    0.132038] NR_IRQS: 2304, nr_irqs: 24, preallocated irqs: 16
[    0.132216] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.148390] Console: colour VGA+ 80x25
[    0.183252] console [tty0] enabled
[    0.183405] ACPI: Core revision 20180531
[    0.183780] ACPI: setting ELCR to 0200 (from 0800)
[    0.187761] APIC: ACPI MADT or MP tables are not detected
[    0.195102] APIC: Switch to virtual wire mode setup with no configuration
[    0.196629] Enabling APIC mode:  Flat.  Using 0 I/O APICs
[    0.196774] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1cbc55fe3af, max_idle_ns: 881590592998 ns
[    0.196998] Calibrating delay loop (skipped), value calculated using timer frequency.. 859455.59 BogoMIPS (lpj=1431852151)
[    0.197219] pid_max: default: 32768 minimum: 301
[    0.197463] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.197600] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.200842] mce: CPU supports 5 MCE banks
[    0.201004] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.201130] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.201254] CPU: Mobile Intel(R) Pentium(R) III CPU - M  1000MHz (family: 0x6, model: 0xb, stepping: 0x4)
[    0.201478] Spectre V2 : Mitigation: Full generic retpoline
[    0.201603] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.201730] Speculative Store Bypass: Vulnerable
[    0.204126] Performance Events: p6 PMU driver.
[    0.207008] ... version:                0
[    0.210340] ... bit width:              32
[    0.210462] ... generic registers:      2
[    0.210585] ... value mask:             00000000ffffffff
[    0.210709] ... max period:             000000007fffffff
[    0.210832] ... fixed-purpose events:   0
[    0.210954] ... event mask:             0000000000000003
[    0.211172] Hierarchical SRCU implementation.
[    0.216994] devtmpfs: initialized
[    0.217488] PM: Registering ACPI NVS region [mem 0x3f6efc00-0x3f6effff] (1024 bytes)
[    0.218961] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.219185] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.219634] NET: Registered protocol family 16
[    0.220651] audit: initializing netlink subsys (disabled)
[    0.221433] audit: type=2000 audit(1536525661.029:1): state=initialized audit_enabled=0 res=1
[    0.222050] cpuidle: using governor ladder
[    0.222193] cpuidle: using governor menu
[    0.222512] ACPI: bus type PCI registered
[    0.222638] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.226477] PCI: PCI BIOS revision 2.10 entry at 0xfd96e, last bus=3
[    0.227095] PCI: Using configuration type 1 for base access
[    0.249013] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.249807] ACPI: Added _OSI(Module Device)
[    0.253995] ACPI: Added _OSI(Processor Device)
[    0.257159] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.257286] ACPI: Added _OSI(Processor Aggregator Device)
[    0.257415] ACPI: Added _OSI(Linux-Dell-Video)
[    0.268328] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.279362] ACPI: EC: EC started
[    0.280332] ACPI: EC: interrupt blocked
[    0.283725] ACPI: \_SB_.PCI0.LPC0.EC__: Used as first EC
[    0.283855] ACPI: \_SB_.PCI0.LPC0.EC__: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.284069] ACPI: \_SB_.PCI0.LPC0.EC__: Used as boot DSDT EC to handle transactions
[    0.284279] ACPI: Interpreter enabled
[    0.284470] ACPI: (supports S0 S3 S4 S5)
[    0.284594] ACPI: Using PIC for interrupt routing
[    0.287048] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.287724] ACPI: Enabled 3 GPEs in block 00 to 0F
[    0.287859] ACPI: Enabled 2 GPEs in block 10 to 1F
[    0.304977] acpi LNXIOBAY:00: ACPI dock station (docks/bays count: 1)
[    0.309463] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.313880] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.315885] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.316023] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.317468] PCI host bridge to bus 0000:00
[    0.317600] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.317732] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.317863] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.318078] pci_bus 0000:00: root bus resource [mem 0x000cd200-0x000dffff window]
[    0.318294] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebfffff window]
[    0.318509] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.318655] pci 0000:00:00.0: [8086:3575] type 00 class 0x060000
[    0.318892] pci 0000:00:02.0: [8086:3577] type 00 class 0x030000
[    0.318910] pci 0000:00:02.0: reg 0x10: [mem 0xe8000000-0xefffffff pref]
[    0.318920] pci 0000:00:02.0: reg 0x14: [mem 0xe0000000-0xe007ffff]
[    0.318964] pci 0000:00:02.0: supports D1
[    0.319149] pci 0000:00:02.1: [8086:3577] type 00 class 0x038000
[    0.319166] pci 0000:00:02.1: reg 0x10: [mem 0xf0000000-0xf7ffffff pref]
[    0.319175] pci 0000:00:02.1: reg 0x14: [mem 0xe0080000-0xe00fffff]
[    0.319219] pci 0000:00:02.1: supports D1
[    0.319469] pci 0000:00:1d.0: [8086:2482] type 00 class 0x0c0300
[    0.319517] pci 0000:00:1d.0: reg 0x20: [io  0x1440-0x145f]
[    0.319724] pci 0000:00:1d.1: [8086:2484] type 00 class 0x0c0300
[    0.319772] pci 0000:00:1d.1: reg 0x20: [io  0x1460-0x147f]
[    0.319994] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060400
[    0.320257] pci 0000:00:1f.0: [8086:248c] type 00 class 0x060100
[    0.320406] pci 0000:00:1f.0: quirk: [io  0xfc00-0xfc7f] claimed by ICH4 ACPI/GPIO/TCO
[    0.323838] pci 0000:00:1f.0: quirk: [io  0xfc80-0xfcbf] claimed by ICH4 GPIO
[    0.324163] pci 0000:00:1f.1: [8086:248a] type 00 class 0x01018a
[    0.324186] pci 0000:00:1f.1: reg 0x10: [io  0x01f0-0x01f7]
[    0.324199] pci 0000:00:1f.1: reg 0x14: [io  0x03f4-0x03f7]
[    0.324211] pci 0000:00:1f.1: reg 0x18: [io  0x0170-0x0177]
[    0.324223] pci 0000:00:1f.1: reg 0x1c: [io  0x0374-0x0377]
[    0.324235] pci 0000:00:1f.1: reg 0x20: [io  0x14a0-0x14af]
[    0.324248] pci 0000:00:1f.1: reg 0x24: [mem 0xe0100000-0xe01003ff]
[    0.324263] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.324394] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.324524] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.324654] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.327195] pci 0000:00:1f.3: [8086:2483] type 00 class 0x0c0500
[    0.327243] pci 0000:00:1f.3: reg 0x20: [io  0x1480-0x149f]
[    0.327449] pci 0000:00:1f.5: [8086:2485] type 00 class 0x040100
[    0.327470] pci 0000:00:1f.5: reg 0x10: [io  0x1000-0x10ff]
[    0.327483] pci 0000:00:1f.5: reg 0x14: [io  0x1400-0x143f]
[    0.327722] pci_bus 0000:01: extended config space not accessible
[    0.328025] pci 0000:01:09.0: [10ec:8139] type 00 class 0x020000
[    0.328046] pci 0000:01:09.0: reg 0x10: [io  0x8000-0x80ff]
[    0.328059] pci 0000:01:09.0: reg 0x14: [mem 0xe0214800-0xe02148ff]
[    0.328130] pci 0000:01:09.0: supports D1 D2
[    0.328136] pci 0000:01:09.0: PME# supported from D1 D2 D3hot D3cold
[    0.328304] pci 0000:01:0a.0: [1217:6933] type 02 class 0x060700
[    0.328325] pci 0000:01:0a.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.328364] pci 0000:01:0a.0: supports D1 D2
[    0.328369] pci 0000:01:0a.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.328539] pci 0000:01:0a.1: [1217:6933] type 02 class 0x060700
[    0.328559] pci 0000:01:0a.1: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.328598] pci 0000:01:0a.1: supports D1 D2
[    0.328603] pci 0000:01:0a.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.328787] pci 0000:01:0c.0: [104c:8026] type 00 class 0x0c0010
[    0.328808] pci 0000:01:0c.0: reg 0x10: [mem 0xe0214000-0xe02147ff]
[    0.328821] pci 0000:01:0c.0: reg 0x14: [mem 0xe0210000-0xe0213fff]
[    0.328891] pci 0000:01:0c.0: supports D1 D2
[    0.328897] pci 0000:01:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.329059] pci 0000:01:0d.0: [168c:0029] type 00 class 0x028000
[    0.329079] pci 0000:01:0d.0: reg 0x10: [mem 0xe0200000-0xe020ffff]
[    0.329157] pci 0000:01:0d.0: PME# supported from D0 D3hot
[    0.329350] pci 0000:00:1e.0: PCI bridge to [bus 01-03] (subtractive decode)
[    0.329488] pci 0000:00:1e.0:   bridge window [io  0x8000-0x8fff]
[    0.329496] pci 0000:00:1e.0:   bridge window [mem 0xe0200000-0xe02fffff]
[    0.329505] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.329511] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.329517] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.329522] pci 0000:00:1e.0:   bridge window [mem 0x000cd200-0x000dffff window] (subtractive decode)
[    0.329528] pci 0000:00:1e.0:   bridge window [mem 0x40000000-0xfebfffff window] (subtractive decode)
[    0.329563] pci_bus 0000:02: extended config space not accessible
[    0.329790] pci_bus 0000:02: busn_res: [bus 02-03] end is updated to 02
[    0.329817] pci_bus 0000:03: extended config space not accessible
[    0.330635] pci_bus 0000:03: busn_res: [bus 03] end can not be updated to 06
[    0.330648] pci 0000:00:1e.0: bridge has subordinate 03 but max busn 06
[    0.333873] pci_bus 0000:00: on NUMA node 0
[    0.338071] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
[    0.340653] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
[    0.343890] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
[    0.344226] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
[    0.344562] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
[    0.347124] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
[    0.347462] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
[    0.347888] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11) *0, disabled.
[    0.349292] ACPI: EC: interrupt unblocked
[    0.349431] ACPI: EC: event unblocked
[    0.349563] ACPI: \_SB_.PCI0.LPC0.EC__: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.349865] ACPI: \_SB_.PCI0.LPC0.EC__: Used as boot DSDT EC to handle transactions and events
[    0.350874] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.351008] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.351231] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.351357] vgaarb: loaded
[    0.354111] SCSI subsystem initialized
[    0.354414] libata version 3.00 loaded.
[    0.354814] PCI: Using ACPI for IRQ routing
[    0.354954] PCI: pci_cache_line_size set to 32 bytes
[    0.355014] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.355020] e820: reserve RAM buffer [mem 0x3f6e0000-0x3fffffff]
[    0.355024] e820: reserve RAM buffer [mem 0x3f780000-0x3fffffff]
[    0.367842] clocksource: Switched to clocksource tsc-early
[    0.393244] pnp: PnP ACPI init
[    0.400961] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.401697] system 00:00: [io  0xf800-0xf87f] has been reserved
[    0.401828] system 00:00: [io  0xf880-0xf8ff] has been reserved
[    0.401958] system 00:00: [io  0xfd00-0xfd6f] has been reserved
[    0.402087] system 00:00: [io  0xfe00] has been reserved
[    0.402216] system 00:00: [io  0xfc00-0xfc7f] has been reserved
[    0.402354] system 00:00: [io  0xfc80-0xfcbf] has been reserved
[    0.402486] system 00:00: [mem 0x000cd200-0x000cffff] has been reserved
[    0.402618] system 00:00: [mem 0xffb00000-0xffbfffff] has been reserved
[    0.402800] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.403265] pnp 00:01: disabling [io  0x83b0-0x83bb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.403488] pnp 00:01: disabling [io  0x83c0-0x83df] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.403708] pnp 00:01: disabling [io  0x87b0-0x87bb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.403928] pnp 00:01: disabling [io  0x87c0-0x87df] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.404148] pnp 00:01: disabling [io  0x8bb0-0x8bbb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.404368] pnp 00:01: disabling [io  0x8bc0-0x8bdf] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.404588] pnp 00:01: disabling [io  0x8fb0-0x8fbb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.404808] pnp 00:01: disabling [io  0x8fc0-0x8fdf] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.405905] system 00:01: [io  0x07b0-0x07bb] has been reserved
[    0.413358] system 00:01: [io  0x07c0-0x07df] has been reserved
[    0.418327] system 00:01: [io  0x0bb0-0x0bbb] has been reserved
[    0.418458] system 00:01: [io  0x0bc0-0x0bdf] has been reserved
[    0.418588] system 00:01: [io  0x0fb0-0x0fbb] has been reserved
[    0.418719] system 00:01: [io  0x0fc0-0x0fdf] has been reserved
[    0.418849] system 00:01: [io  0x13b0-0x13bb] has been reserved
[    0.418979] system 00:01: [io  0x13c0-0x13df] has been reserved
[    0.419109] system 00:01: [io  0x17b0-0x17bb] has been reserved
[    0.419240] system 00:01: [io  0x17c0-0x17df] has been reserved
[    0.419370] system 00:01: [io  0x1bb0-0x1bbb] has been reserved
[    0.419535] system 00:01: [io  0x1bc0-0x1bdf] has been reserved
[    0.419674] system 00:01: [io  0x1fb0-0x1fbb] has been reserved
[    0.419804] system 00:01: [io  0x1fc0-0x1fdf] has been reserved
[    0.419935] system 00:01: [io  0x23b0-0x23bb] has been reserved
[    0.420064] system 00:01: [io  0x23c0-0x23df] has been reserved
[    0.420194] system 00:01: [io  0x27b0-0x27bb] has been reserved
[    0.420324] system 00:01: [io  0x27c0-0x27df] has been reserved
[    0.420454] system 00:01: [io  0x2bb0-0x2bbb] has been reserved
[    0.420584] system 00:01: [io  0x2bc0-0x2bdf] has been reserved
[    0.420714] system 00:01: [io  0x2fb0-0x2fbb] has been reserved
[    0.420844] system 00:01: [io  0x2fc0-0x2fdf] has been reserved
[    0.420974] system 00:01: [io  0x33b0-0x33bb] has been reserved
[    0.421104] system 00:01: [io  0x33c0-0x33df] has been reserved
[    0.421235] system 00:01: [io  0x37b0-0x37bb] has been reserved
[    0.421365] system 00:01: [io  0x37c0-0x37df] has been reserved
[    0.421495] system 00:01: [io  0x3bb0-0x3bbb] has been reserved
[    0.421625] system 00:01: [io  0x3bc0-0x3bdf] has been reserved
[    0.421756] system 00:01: [io  0x3fb0-0x3fbb] has been reserved
[    0.421886] system 00:01: [io  0x3fc0-0x3fdf] has been reserved
[    0.422016] system 00:01: [io  0x43b0-0x43bb] has been reserved
[    0.422146] system 00:01: [io  0x43c0-0x43df] has been reserved
[    0.424734] system 00:01: [io  0x47b0-0x47bb] has been reserved
[    0.432160] system 00:01: [io  0x47c0-0x47df] has been reserved
[    0.435003] system 00:01: [io  0x4bb0-0x4bbb] has been reserved
[    0.435134] system 00:01: [io  0x4bc0-0x4bdf] has been reserved
[    0.435264] system 00:01: [io  0x4fb0-0x4fbb] has been reserved
[    0.435395] system 00:01: [io  0x4fc0-0x4fdf] has been reserved
[    0.435525] system 00:01: [io  0x53b0-0x53bb] has been reserved
[    0.435656] system 00:01: [io  0x53c0-0x53df] has been reserved
[    0.435786] system 00:01: [io  0x57b0-0x57bb] has been reserved
[    0.435917] system 00:01: [io  0x57c0-0x57df] has been reserved
[    0.436047] system 00:01: [io  0x5bb0-0x5bbb] has been reserved
[    0.436183] system 00:01: [io  0x5bc0-0x5bdf] has been reserved
[    0.436322] system 00:01: [io  0x5fb0-0x5fbb] has been reserved
[    0.436453] system 00:01: [io  0x5fc0-0x5fdf] has been reserved
[    0.436583] system 00:01: [io  0x63b0-0x63bb] has been reserved
[    0.436714] system 00:01: [io  0x63c0-0x63df] has been reserved
[    0.436845] system 00:01: [io  0x67b0-0x67bb] has been reserved
[    0.436975] system 00:01: [io  0x67c0-0x67df] has been reserved
[    0.437106] system 00:01: [io  0x6bb0-0x6bbb] has been reserved
[    0.437237] system 00:01: [io  0x6bc0-0x6bdf] has been reserved
[    0.437367] system 00:01: [io  0x6fb0-0x6fbb] has been reserved
[    0.437498] system 00:01: [io  0x6fc0-0x6fdf] has been reserved
[    0.437629] system 00:01: [io  0x73b0-0x73bb] has been reserved
[    0.437759] system 00:01: [io  0x73c0-0x73df] has been reserved
[    0.437890] system 00:01: [io  0x77b0-0x77bb] has been reserved
[    0.438021] system 00:01: [io  0x77c0-0x77df] has been reserved
[    0.438152] system 00:01: [io  0x7bb0-0x7bbb] has been reserved
[    0.438283] system 00:01: [io  0x7bc0-0x7bdf] has been reserved
[    0.438413] system 00:01: [io  0x7fb0-0x7fbb] has been reserved
[    0.438544] system 00:01: [io  0x7fc0-0x7fdf] has been reserved
[    0.438679] system 00:01: [io  0x93b0-0x93bb] has been reserved
[    0.438811] system 00:01: [io  0x93c0-0x93df] has been reserved
[    0.441397] system 00:01: [io  0x97b0-0x97bb] has been reserved
[    0.448817] system 00:01: [io  0x97c0-0x97df] has been reserved
[    0.451668] system 00:01: [io  0x9bb0-0x9bbb] has been reserved
[    0.451800] system 00:01: [io  0x9bc0-0x9bdf] has been reserved
[    0.451932] system 00:01: [io  0x9fb0-0x9fbb] has been reserved
[    0.452063] system 00:01: [io  0x9fc0-0x9fdf] has been reserved
[    0.452194] system 00:01: [io  0xa3b0-0xa3bb] has been reserved
[    0.452326] system 00:01: [io  0xa3c0-0xa3df] has been reserved
[    0.452457] system 00:01: [io  0xa7b0-0xa7bb] has been reserved
[    0.452589] system 00:01: [io  0xa7c0-0xa7df] has been reserved
[    0.452720] system 00:01: [io  0xabb0-0xabbb] has been reserved
[    0.452857] system 00:01: [io  0xabc0-0xabdf] has been reserved
[    0.452998] system 00:01: [io  0xafb0-0xafbb] has been reserved
[    0.453129] system 00:01: [io  0xafc0-0xafdf] has been reserved
[    0.453260] system 00:01: [io  0xb3b0-0xb3bb] has been reserved
[    0.453392] system 00:01: [io  0xb3c0-0xb3df] has been reserved
[    0.453524] system 00:01: [io  0xb7b0-0xb7bb] has been reserved
[    0.453655] system 00:01: [io  0xb7c0-0xb7df] has been reserved
[    0.453787] system 00:01: [io  0xbbb0-0xbbbb] has been reserved
[    0.453919] system 00:01: [io  0xbbc0-0xbbdf] has been reserved
[    0.454051] system 00:01: [io  0xbfb0-0xbfbb] has been reserved
[    0.454182] system 00:01: [io  0xbfc0-0xbfdf] has been reserved
[    0.454314] system 00:01: [io  0xc3b0-0xc3bb] has been reserved
[    0.454446] system 00:01: [io  0xc3c0-0xc3df] has been reserved
[    0.454578] system 00:01: [io  0xc7b0-0xc7bb] has been reserved
[    0.454709] system 00:01: [io  0xc7c0-0xc7df] has been reserved
[    0.454841] system 00:01: [io  0xcbb0-0xcbbb] has been reserved
[    0.454973] system 00:01: [io  0xcbc0-0xcbdf] has been reserved
[    0.455105] system 00:01: [io  0xcfb0-0xcfbb] has been reserved
[    0.455236] system 00:01: [io  0xcfc0-0xcfdf] has been reserved
[    0.455368] system 00:01: [io  0xd3b0-0xd3bb] has been reserved
[    0.455500] system 00:01: [io  0xd3c0-0xd3df] has been reserved
[    0.459895] system 00:01: [io  0xd7b0-0xd7bb] has been reserved
[    0.467323] system 00:01: [io  0xd7c0-0xd7df] has been reserved
[    0.468350] system 00:01: [io  0xdbb0-0xdbbb] has been reserved
[    0.468482] system 00:01: [io  0xdbc0-0xdbdf] has been reserved
[    0.468614] system 00:01: [io  0xdfb0-0xdfbb] has been reserved
[    0.468746] system 00:01: [io  0xdfc0-0xdfdf] has been reserved
[    0.468878] system 00:01: [io  0xe3b0-0xe3bb] has been reserved
[    0.469010] system 00:01: [io  0xe3c0-0xe3df] has been reserved
[    0.469142] system 00:01: [io  0xe7b0-0xe7bb] has been reserved
[    0.469274] system 00:01: [io  0xe7c0-0xe7df] has been reserved
[    0.469406] system 00:01: [io  0xebb0-0xebbb] has been reserved
[    0.469544] system 00:01: [io  0xebc0-0xebdf] has been reserved
[    0.469679] system 00:01: [io  0xefb0-0xefbb] has been reserved
[    0.469811] system 00:01: [io  0xefc0-0xefdf] has been reserved
[    0.469943] system 00:01: [io  0xf3b0-0xf3bb] has been reserved
[    0.470075] system 00:01: [io  0xf3c0-0xf3df] has been reserved
[    0.470208] system 00:01: [io  0xf7b0-0xf7bb] has been reserved
[    0.470340] system 00:01: [io  0xf7c0-0xf7df] has been reserved
[    0.470472] system 00:01: [io  0xfbb0-0xfbbb] has been reserved
[    0.470604] system 00:01: [io  0xfbc0-0xfbdf] has been reserved
[    0.470736] system 00:01: [io  0xffb0-0xffbb] has been reserved
[    0.470869] system 00:01: [io  0xffc0-0xffdf] has been reserved
[    0.471051] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.471308] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.471457] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.471587] pnp 00:04: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.472466] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.473448] pnp 00:06: [dma 3]
[    0.473792] pnp 00:06: Plug and Play ACPI device, IDs SMCf010 (active)
[    0.474837] pnp 00:07: [dma 1]
[    0.475030] pnp 00:07: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.476044] pnp: PnP ACPI: found 8 devices
[    0.525265] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.535046] pci 0000:00:1e.0: bridge window [mem 0x04000000-0x0bffffff pref] to [bus 01-03] add_size 8000000 add_align 4000000
[    0.535083] pci 0000:00:1e.0: BAR 9: assigned [mem 0x40000000-0x4fffffff pref]
[    0.535318] pci 0000:01:0a.0: BAR 0: assigned [mem 0x50000000-0x50000fff]
[    0.535456] pci 0000:01:0a.0: BAR 9: assigned [mem 0x40000000-0x43ffffff pref]
[    0.535675] pci 0000:01:0a.0: BAR 10: assigned [mem 0x54000000-0x57ffffff]
[    0.535812] pci 0000:01:0a.1: BAR 0: assigned [mem 0x58000000-0x58000fff]
[    0.535947] pci 0000:01:0a.1: BAR 9: assigned [mem 0x44000000-0x47ffffff pref]
[    0.538508] pci 0000:01:0a.1: BAR 10: assigned [mem 0x5c000000-0x5fffffff]
[    0.538640] pci 0000:01:0a.0: BAR 7: assigned [io  0x8400-0x84ff]
[    0.538771] pci 0000:01:0a.0: BAR 8: assigned [io  0x8800-0x88ff]
[    0.539430] pci 0000:01:0a.1: BAR 7: assigned [io  0x8c00-0x8cff]
[    0.546906] pci 0000:01:0a.1: BAR 8: assigned [io  0x1800-0x18ff]
[    0.551628] pci 0000:01:0a.0: CardBus bridge to [bus 02]
[    0.551756] pci 0000:01:0a.0:   bridge window [io  0x8400-0x84ff]
[    0.551887] pci 0000:01:0a.0:   bridge window [io  0x8800-0x88ff]
[    0.552018] pci 0000:01:0a.0:   bridge window [mem 0x40000000-0x43ffffff pref]
[    0.552234] pci 0000:01:0a.0:   bridge window [mem 0x54000000-0x57ffffff]
[    0.552366] pci 0000:01:0a.1: CardBus bridge to [bus 03]
[    0.552493] pci 0000:01:0a.1:   bridge window [io  0x8c00-0x8cff]
[    0.552623] pci 0000:01:0a.1:   bridge window [io  0x1800-0x18ff]
[    0.552755] pci 0000:01:0a.1:   bridge window [mem 0x44000000-0x47ffffff pref]
[    0.552983] pci 0000:01:0a.1:   bridge window [mem 0x5c000000-0x5fffffff]
[    0.553116] pci 0000:00:1e.0: PCI bridge to [bus 01-03]
[    0.553245] pci 0000:00:1e.0:   bridge window [io  0x8000-0x8fff]
[    0.553377] pci 0000:00:1e.0:   bridge window [mem 0xe0200000-0xe02fffff]
[    0.553509] pci 0000:00:1e.0:   bridge window [mem 0x40000000-0x4fffffff pref]
[    0.553730] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.553736] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.553742] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.553747] pci_bus 0000:00: resource 7 [mem 0x000cd200-0x000dffff window]
[    0.553753] pci_bus 0000:00: resource 8 [mem 0x40000000-0xfebfffff window]
[    0.553759] pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
[    0.553764] pci_bus 0000:01: resource 1 [mem 0xe0200000-0xe02fffff]
[    0.553770] pci_bus 0000:01: resource 2 [mem 0x40000000-0x4fffffff pref]
[    0.553776] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
[    0.553781] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff window]
[    0.553787] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.553792] pci_bus 0000:01: resource 7 [mem 0x000cd200-0x000dffff window]
[    0.553798] pci_bus 0000:01: resource 8 [mem 0x40000000-0xfebfffff window]
[    0.553804] pci_bus 0000:02: resource 0 [io  0x8400-0x84ff]
[    0.553809] pci_bus 0000:02: resource 1 [io  0x8800-0x88ff]
[    0.553815] pci_bus 0000:02: resource 2 [mem 0x40000000-0x43ffffff pref]
[    0.553820] pci_bus 0000:02: resource 3 [mem 0x54000000-0x57ffffff]
[    0.553826] pci_bus 0000:03: resource 0 [io  0x8c00-0x8cff]
[    0.553831] pci_bus 0000:03: resource 1 [io  0x1800-0x18ff]
[    0.553837] pci_bus 0000:03: resource 2 [mem 0x44000000-0x47ffffff pref]
[    0.553842] pci_bus 0000:03: resource 3 [mem 0x5c000000-0x5fffffff]
[    0.554094] NET: Registered protocol family 2
[    0.554656] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    0.554882] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.555068] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.555246] TCP: Hash tables configured (established 8192 bind 8192)
[    0.555472] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.559219] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.566877] NET: Registered protocol family 1
[    0.568374] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.568967] PCI Interrupt Link [LNKA] enabled at IRQ 11
[    0.569096] PCI: setting IRQ 11 as level-triggered
[    0.569392] PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.569669] PCI: CLS 32 bytes, default 32
[    0.569842] Unpacking initramfs...
[    0.611003] Freeing initrd memory: 4960K
[    0.619213] Scanning for low memory corruption every 60 seconds
[    0.621903] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    0.635620] pstore: using deflate compression
[    0.637277] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.637506] io scheduler noop registered
[    0.637628] io scheduler deadline registered
[    0.637859] io scheduler cfq registered (default)
[    0.638518] ACPI: AC Adapter [AC] (on-line)
[    0.638823] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.651903] ACPI: Power Button [PWRB]
[    0.652250] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    0.652493] ACPI: Lid Switch [LID]
[    0.652782] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.653149] ACPI: Power Button [PWRF]
[    0.653490] tsc: Marking TSC unstable due to TSC halts in idle
[    0.653638] clocksource: Switched to clocksource acpi_pm
[    0.655713] ACPI: Battery Slot [CMB1] (battery present)
[    0.663194] isapnp: Scanning for PnP cards...
[    0.670721] ACPI: Battery Slot [CMB2] (battery absent)
[    0.692846] isapnp: No Plug & Play device found
[    0.700312] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.703388] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.703911] serial 00:06: skipping CIR port at 0x2e8 / 0x0, IRQ 3
[    0.705054] ata_piix 0000:00:1f.1: version 2.13
[    0.705078] ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
[    0.705563] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    0.716531] scsi host0: ata_piix
[    0.718946] scsi host1: ata_piix
[    0.719175] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x14a0 irq 14
[    0.719305] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x14a8 irq 15
[    0.719719] yenta_cardbus 0000:01:0a.0: CardBus bridge found [10cf:10e6]
[    0.719869] yenta_cardbus 0000:01:0a.0: O2: disabling read prefetch/write burst. If you experience problems or performance issues, use the yenta_socket parameter 'o2_speedup=on'
[    0.877357] ata2.01: NODEV after polling detection
[    0.880044] ata2.00: ATAPI: UJDA750FDVD/CDRW, 1.20, max UDMA/33
[    0.898753] ata1.00: ATA-8: KINGSTON SMS200S3120G, 60AABBF0, max UDMA/133
[    0.901612] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    0.935797] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SMS200S BBF0 PQ: 0 ANSI: 5
[    0.936823] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    0.937113] sd 0:0:0:0: [sda] Write Protect is off
[    0.937241] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.937305] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.938786]  sda: sda1 sda2 sda3
[    0.947108] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.951629] scsi 1:0:0:0: CD-ROM            MATSHITA UJDA750FDVD/CDRW 1.20 PQ: 0 ANSI: 5
[    0.999344] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    1.001675] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.002173] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.134013] yenta_cardbus 0000:01:0a.0: ISA IRQ mask 0x04b8, PCI irq 11
[    1.134906] yenta_cardbus 0000:01:0a.0: Socket status: 30000006
[    1.135044] yenta_cardbus 0000:01:0a.0: pcmcia: parent PCI bridge window: [io  0x8000-0x8fff]
[    1.135261] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x8000-0x8fff:
[    1.136660]  excluding 0x8000-0x80ff 0x8400-0x84ff 0x8800-0x88ff 0x8c00-0x8cff
[    1.151533] yenta_cardbus 0000:01:0a.0: pcmcia: parent PCI bridge window: [mem 0xe0200000-0xe02fffff]
[    1.151752] pcmcia_socket pcmcia_socket0: cs: memory probe 0xe0200000-0xe02fffff:
[    1.151967]  excluding 0xe0200000-0xe021ffff
[    1.152113] yenta_cardbus 0000:01:0a.0: pcmcia: parent PCI bridge window: [mem 0x40000000-0x4fffffff pref]
[    1.152331] pcmcia_socket pcmcia_socket0: cs: memory probe 0x40000000-0x4fffffff:
[    1.152563]  excluding 0x40000000-0x4fffffff
[    1.153630] PCI Interrupt Link [LNKB] enabled at IRQ 11
[    1.153816] yenta_cardbus 0000:01:0a.1: CardBus bridge found [10cf:10e6]
[    1.287374] yenta_cardbus 0000:01:0a.1: ISA IRQ mask 0x04b8, PCI irq 11
[    1.287505] yenta_cardbus 0000:01:0a.1: Socket status: 30000006
[    1.287639] yenta_cardbus 0000:01:0a.1: pcmcia: parent PCI bridge window: [io  0x8000-0x8fff]
[    1.287855] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x8000-0x8fff:
[    1.289252]  excluding 0x8000-0x80ff 0x8400-0x84ff 0x8800-0x88ff 0x8c00-0x8cff
[    1.301544] yenta_cardbus 0000:01:0a.1: pcmcia: parent PCI bridge window: [mem 0xe0200000-0xe02fffff]
[    1.301763] pcmcia_socket pcmcia_socket1: cs: memory probe 0xe0200000-0xe02fffff:
[    1.301977]  excluding 0xe0200000-0xe021ffff
[    1.302123] yenta_cardbus 0000:01:0a.1: pcmcia: parent PCI bridge window: [mem 0x40000000-0x4fffffff pref]
[    1.302342] pcmcia_socket pcmcia_socket1: cs: memory probe 0x40000000-0x4fffffff:
[    1.302574]  excluding 0x40000000-0x4fffffff
[    1.303399] i8042: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.307557] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.314947] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.318538] rtc_cmos 00:02: RTC can wake from S4
[    1.318922] rtc_cmos 00:02: registered as rtc0
[    1.319126] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    1.319360] IR NEC protocol handler initialized
[    1.319492] IR RC5(x/sz) protocol handler initialized
[    1.319615] IR RC6 protocol handler initialized
[    1.319738] IR JVC protocol handler initialized
[    1.319860] IR Sony protocol handler initialized
[    1.319983] IR SANYO protocol handler initialized
[    1.320105] IR Sharp protocol handler initialized
[    1.320228] IR MCE Keyboard/mouse protocol handler initialized
[    1.320614] IR XMP protocol handler initialized
[    1.320987] NET: Registered protocol family 17
[    1.321594] microcode: sig=0x6b4, pf=0x20, revision=0x2
[    1.321839] microcode: Microcode Update Driver: v2.2.
[    1.321849] Using IPI Shortcut mode
[    1.322509] registered taskstats version 1
[    1.330531] console [netcon0] enabled
[    1.334972] netconsole: network logging started
[    1.335138] rtc_cmos 00:02: setting system clock to 2018-09-09 20:41:02 UTC (1536525662)
[    1.337755] Unstable clock detected, switching default tracing clock to "global"
               If you want to keep using the local clock, then add:
                 "trace_clock=local"
               on the kernel command line
[    1.354510] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    1.378122] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    1.384929] VFS: Mounted root (ext4 filesystem) readonly on device 8:3.
[    1.387301] devtmpfs: mounted
[    1.388085] Freeing unused kernel memory: 472K
[    1.388372] Write protecting the kernel text: 4944k
[    1.388604] Write protecting the kernel read-only data: 1344k
[    1.439275] random: fast init done
[    2.754016] random: lvm: uninitialized urandom read (4 bytes read)
[    5.607659] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    5.608017] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/LNXVIDEO:00/input/input5
[    5.645705] fujitsu_laptop: ACPI: Fujitsu FUJ02B1 [FJEX]
[    5.646250] input: Fujitsu FUJ02B1 as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:03/FUJ02B1:00/input/input6
[    5.674512] fujitsu_laptop: driver 0.6.0 successfully loaded
[    5.695004] parport_pc 00:07: reported by Plug and Play ACPI
[    5.695105] parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[    5.771151] Linux agpgart interface v0.103
[    5.810644] intel_rng: FWH not detected
[    5.819837] agpgart-intel 0000:00:00.0: Intel 830M Chipset
[    5.863905] 8139too: 8139too Fast Ethernet driver 0.9.28
[    5.864619] PCI Interrupt Link [LNKF] enabled at IRQ 11
[    5.867241] 8139too 0000:01:09.0 eth0: RealTek RTL8139 at 0x(ptrval), 00:e0:00:f9:83:13, IRQ 11
[    5.883814] ACPI: bus type USB registered
[    5.883896] usbcore: registered new interface driver usbfs
[    5.883936] usbcore: registered new interface driver hub
[    5.884004] usbcore: registered new device driver usb
[    5.891538] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.907799] ehci-pci: EHCI PCI platform driver
[    5.910935] PCI Interrupt Link [LNKE] enabled at IRQ 11
[    5.915053] uhci_hcd: USB Universal Host Controller Interface driver
[    5.915278] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    5.915301] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    5.915371] uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001440
[    5.935602] hub 1-0:1.0: USB hub found
[    5.935626] hub 1-0:1.0: 2 ports detected
[    5.936080] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.936095] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    5.936158] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001460
[    5.949363] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af:
[    5.950621] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x100-0x3af:
[    5.951563]  excluding 0x160-0x167 0x170-0x177 0x1f0-0x1f7 0x2e8-0x2ef 0x370-0x37f
[    5.952313] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x3e0-0x4ff:
[    5.952669]  excluding 0x3f0-0x407 0x4d0-0x4d7
[    5.953026] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x820-0x8ff:
[    5.953605]  clean
[    5.953643] pcmcia_socket pcmcia_socket1: cs: IO port probe 0xc00-0xcf7:
[    5.955414] hub 2-0:1.0: USB hub found
[    5.955441] hub 2-0:1.0: 2 ports detected
[    5.959337]  excluding 0x170-0x177 0x1f0-0x1f7 0x2e8-0x2ef 0x370-0x37f
[    5.960149] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3e0-0x4ff:
[    5.967321] firewire_ohci 0000:01:0c.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x2
[    5.968565]  excluding 0x3f0-0x407 0x4d0-0x4d7
[    5.969104] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x8ff:
[    5.969683]  clean
[    5.969721] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcf7:
[    5.970045]  excluding 0xc08-0xc0f
[    5.981493]  clean
[    5.981597] pcmcia_socket pcmcia_socket1: cs: memory probe 0x0c0000-0x0fffff:
[    5.981612]  excluding 0xc0000-0xcffff 0xe0000-0xfffff
[    5.981673] pcmcia_socket pcmcia_socket1: cs: memory probe 0xa0000000-0xa0ffffff:
[    5.981702]  clean
[    5.981741] pcmcia_socket pcmcia_socket1: cs: memory probe 0x60000000-0x60ffffff:
[    5.981768]  clean
[    5.981809] pcmcia_socket pcmcia_socket1: cs: IO port probe 0xa00-0xaff:
[    5.982469]  clean
[    5.989809] pcmcia_socket pcmcia_socket0: cs: memory probe 0x0c0000-0x0fffff:
[    5.989822]  excluding 0xc0000-0xcffff 0xe0000-0xfffff
[    5.989884] pcmcia_socket pcmcia_socket0: cs: memory probe 0xa0000000-0xa0ffffff:
[    5.989914]  clean
[    5.989952] pcmcia_socket pcmcia_socket0: cs: memory probe 0x60000000-0x60ffffff:
[    5.989980]  clean
[    5.990021] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff:
[    5.990964]  clean
[    6.036390] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x0
[    6.070079] i801_smbus 0000:00:1f.3: SMBus using polling
[    6.081131] input: PC Speaker as /devices/platform/pcspkr/input/input7
[    6.231955] pnp 00:06: disabled
[    6.233628] pnp 00:06: activated
[    6.348192] pnp 00:06: disabled
[    6.349872] pnp 00:06: activated
[    6.484133] firewire_core 0000:01:0c.0: created device fw0: GUID 00000e1000a1646a, S400
[    6.673747] snd_intel8x0 0000:00:1f.5: intel8x0_measure_ac97_clock: measured 56266 usecs (2704 samples)
[    6.673758] snd_intel8x0 0000:00:1f.5: clocking to 48000
[    6.756470] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    6.756575] iTCO_wdt: Found a ICH3-M TCO device (Version=1, TCOBASE=0xfc60)
[    6.761822] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    6.885317] apanel: duplicate entry for devno 1
[    6.891822] input: Fujitsu Application Panel buttons as /devices/pci0000:00/0000:00:1f.3/i2c-0/0-0019/input/input9
[    7.113288] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio1/input/input8
[    7.120558] usb usb2-port2: Cannot enable. Maybe the USB cable is bad?
[    7.126325] mousedev: PS/2 mouse device common for all mice
[    8.080477] usb usb2-port2: Cannot enable. Maybe the USB cable is bad?
[    8.080514] usb usb2-port2: attempt power cycle
[    8.503461] random: lvm: uninitialized urandom read (4 bytes read)
[    9.431749] EXT4-fs (sda3): re-mounted. Opts: (null)
[    9.544296] ath: EEPROM regdomain: 0x809c
[    9.544302] ath: EEPROM indicates we should expect a country code
[    9.544306] ath: doing EEPROM country->regdmn map search
[    9.544308] ath: country maps to regdmn code: 0x52
[    9.544312] ath: Country alpha2 being used: CN
[    9.544314] ath: Regpair used: 0x52
[    9.560540] usb usb2-port2: Cannot enable. Maybe the USB cable is bad?
[    9.577556] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    9.579769] ieee80211 phy0: Atheros AR9280 Rev:2 mem=0xf8520000, irq=11
[    9.769385] random: ln: uninitialized urandom read (6 bytes read)
[    9.910511] Adding 1048572k swap on /dev/sda2.  Priority:-2 extents:1 across:1048572k SS
[   10.510810] usb 2-2: new full-speed USB device number 5 using uhci_hcd
[   10.790273] Bluetooth: Core ver 2.22
[   10.791178] NET: Registered protocol family 31
[   10.791182] Bluetooth: HCI device and connection manager initialized
[   10.791197] Bluetooth: HCI socket layer initialized
[   10.791203] Bluetooth: L2CAP socket layer initialized
[   10.791221] Bluetooth: SCO socket layer initialized
[   10.819256] usbcore: registered new interface driver btusb
[   10.974338] random: mktemp: uninitialized urandom read (10 bytes read)
[   14.189630] random: dd: uninitialized urandom read (512 bytes read)
[   14.562542] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   14.581658] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   15.043993] 8139too 0000:01:09.0 eth0: link down
[   18.001121] random: ssh-keygen: uninitialized urandom read (32 bytes read)
[   18.022286] random: sshd: uninitialized urandom read (32 bytes read)
[   18.106247] random: sshd: uninitialized urandom read (32 bytes read)
[   18.614021] random: crng init done
[   23.862329] wlan0: authenticate with ...
[   23.908342] wlan0: send auth to ... (try 1/3)
[   24.563819] wlan0: send auth to ... (try 2/3)
[   25.550463] wlan0: send auth to ... (try 3/3)
[   26.563807] wlan0: authentication with ... timed out
[   28.058770] wlan0: authenticate with ...
[   28.104784] wlan0: send auth to ... (try 1/3)
[   29.550470] wlan0: send auth to ... (try 2/3)
[   30.563810] wlan0: send auth to ... (try 3/3)
[   31.550473] wlan0: authentication with ... timed out
[   33.455831] wlan0: authenticate with ...
[   33.501867] wlan0: send auth to ... (try 1/3)
[   34.563807] wlan0: send auth to ... (try 2/3)
[   35.550470] wlan0: send auth to ... (try 3/3)
[   36.563803] wlan0: authentication with ... timed out
[   38.968743] wlan0: authenticate with ...
[   39.014749] wlan0: send auth to ... (try 1/3)
[   39.550463] wlan0: send auth to ... (try 2/3)
[   40.563805] wlan0: send auth to ... (try 3/3)
[   41.550471] wlan0: authentication with ... timed out
[   54.315472] wlan0: authenticate with ...
[   54.361478] wlan0: send auth to ... (try 1/3)
[   55.550473] wlan0: send auth to ... (try 2/3)
[   56.563802] wlan0: send auth to ... (try 3/3)
[   57.550470] wlan0: authentication with ... timed out
[   81.645392] wlan0: authenticate with ...
[   81.691515] wlan0: send auth to ... (try 1/3)
[   82.563798] wlan0: send auth to ... (try 2/3)
[   83.550463] wlan0: send auth to ... (try 3/3)
[   84.563792] wlan0: authentication with ... timed out

--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.good"

[    0.000000] Linux version 4.18.0-rc5-alm-bisect-00311-gbd9f943e5d2a (vsyrjala@stinkpad) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #19 PREEMPT Sun Sep 9 23:10:06 EEST 2018
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003f6dffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003f6e0000-0x000000003f6efbff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003f6efc00-0x000000003f6effff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003f6f0000-0x000000003f6fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003f700000-0x000000003f77ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003f780000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: FUJITSU SIEMENS LIFEBOOK S6010/FJNB159, BIOS Version 1.07  10/28/2002
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 996.860 MHz processor
[    0.006749] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.006757] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.006775] last_pfn = 0x3f780 max_arch_pfn = 0x1000000
[    0.006790] MTRR default type: uncachable
[    0.006792] MTRR fixed ranges enabled:
[    0.006796]   00000-9FFFF write-back
[    0.006799]   A0000-BFFFF uncachable
[    0.006802]   C0000-C7FFF write-protect
[    0.006805]   C8000-EFFFF uncachable
[    0.006808]   F0000-FFFFF write-protect
[    0.006810] MTRR variable ranges enabled:
[    0.006814]   0 base 000000000 mask FC0000000 write-back
[    0.006818]   1 base 03FF80000 mask FFFF80000 uncachable
[    0.006820]   2 disabled
[    0.006821]   3 disabled
[    0.006823]   4 disabled
[    0.006824]   5 disabled
[    0.006826]   6 disabled
[    0.006828]   7 disabled
[    0.007322] x86/PAT: PAT not supported by CPU.
[    0.007806] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.007822] Warning only 889MB will be used.
[    0.007826] Use a HIGHMEM enabled kernel.
[    0.007920] Scanning 1 areas for low memory corruption
[    0.007927] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.007938] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.008039] BRK [0x0179f000, 0x0179ffff] PGTABLE
[    0.008072] BRK [0x017a0000, 0x017a0fff] PGTABLE
[    0.008080] RAMDISK: [mem 0x37b18000-0x37feffff]
[    0.008088] Allocated new RAMDISK: [mem 0x37526000-0x379fd7ff]
[    0.031055] Move RAMDISK from [mem 0x37b18000-0x37fef7ff] to [mem 0x37526000-0x379fd7ff]
[    0.031097] ACPI: Early table checksum verification disabled
[    0.032019] ACPI: RSDP 0x00000000000F6300 000014 (v00 FUJ   )
[    0.032038] ACPI: RSDT 0x000000003F6EA053 000028 (v01 FUJ    LAUREL   01070000 FUJ  00001000)
[    0.032062] ACPI: FACP 0x000000003F6EFB8C 000074 (v01 FUJ    LAUREL   01070000 FUJ  00001000)
[    0.032087] ACPI: DSDT 0x000000003F6EA07B 005B11 (v01 FUJ    LAUREL   01070000 MSFT 01000007)
[    0.032104] ACPI: FACS 0x000000003F6EFFC0 000040
[    0.032152] 889MB LOWMEM available.
[    0.032157]   mapped low ram: 0 - 379fe000
[    0.032162]   low ram: 0 - 379fe000
[    0.032184] cma: Reserved 4 MiB at 0x0000000037000000
[    0.032197] Zone ranges:
[    0.032201]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.032208]   Normal   [mem 0x0000000001000000-0x00000000379fdfff]
[    0.032216] Movable zone start for each node
[    0.032219] Early memory node ranges
[    0.032225]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.032230]   node   0: [mem 0x0000000000100000-0x000000003f6dffff]
[    0.032236]   node   0: [mem 0x000000003f700000-0x000000003f77ffff]
[    0.032244] Initmem setup node 0 [mem 0x0000000000001000-0x000000003f77ffff]
[    0.032252] On node 0 totalpages: 227740
[    0.051784]   DMA zone: 32 pages used for memmap
[    0.051791]   DMA zone: 0 pages reserved
[    0.051795]   DMA zone: 3998 pages, LIFO batch:0
[    0.052439]   Normal zone: 1748 pages used for memmap
[    0.052446]   Normal zone: 223742 pages, LIFO batch:31
[    0.086714] Using APIC driver default
[    0.086751] Reserving Intel graphics memory at [mem 0x3f780000-0x3ff7ffff]
[    0.086895] ACPI: PM-Timer IO Port: 0xfc08
[    0.086914] Local APIC disabled by BIOS -- reenabling.
[    0.086922] Found and enabled local APIC!
[    0.086994] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.087004] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.087009] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.087014] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.087026] [mem 0x40000000-0xffefffff] available for PCI devices
[    0.087044] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.087099] random: get_random_bytes called from start_kernel+0x5b/0x390 with crng_init=0
[    0.087226] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.087233] pcpu-alloc: [0] 0 
[    0.087287] Built 1 zonelists, mobility grouping on.  Total pages: 225960
[    0.087297] Kernel command line: root=/dev/sda3 resume=/dev/sda2 lapic drm.debug=0xe modprobe.blacklist=i915
[    0.088921] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.089671] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.089711] Initializing CPU#0
[    0.130671] Memory: 886056K/910960K available (4942K kernel code, 521K rwdata, 1328K rodata, 472K init, 412K bss, 20808K reserved, 4096K cma-reserved)
[    0.130701] virtual kernel memory layout:
                   fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
                 cpu_entry : 0xffa00000 - 0xffa28000   ( 160 kB)
                   vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
                     .init : 0xc16b3000 - 0xc1729000   ( 472 kB)
                     .data : 0xc14d38e8 - 0xc16a67a0   (1867 kB)
                     .text : 0xc1000000 - 0xc14d38e8   (4942 kB)
[    0.130720] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.131006] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.131530] Preemptible hierarchical RCU implementation.
[    0.131554] 	Tasks RCU enabled.
[    0.132076] NR_IRQS: 2304, nr_irqs: 24, preallocated irqs: 16
[    0.132253] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.148485] Console: colour VGA+ 80x25
[    0.183406] console [tty0] enabled
[    0.183561] ACPI: Core revision 20180531
[    0.183936] ACPI: setting ELCR to 0200 (from 0800)
[    0.184150] APIC: ACPI MADT or MP tables are not detected
[    0.184276] APIC: Switch to virtual wire mode setup with no configuration
[    0.184403] Enabling APIC mode:  Flat.  Using 0 I/O APICs
[    0.184547] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1cbd01c4e18, max_idle_ns: 881590491211 ns
[    0.184772] Calibrating delay loop (skipped), value calculated using timer frequency.. 1718674.70 BogoMIPS (lpj=2863311530)
[    0.188109] pid_max: default: 32768 minimum: 301
[    0.191562] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.191700] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.192330] mce: CPU supports 5 MCE banks
[    0.192490] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.192616] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.192748] CPU: Mobile Intel(R) Pentium(R) III CPU - M  1000MHz (family: 0x6, model: 0xb, stepping: 0x4)
[    0.192972] Spectre V2 : Mitigation: Full generic retpoline
[    0.193097] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.193225] Speculative Store Bypass: Vulnerable
[    0.195237] Performance Events: p6 PMU driver.
[    0.198114] ... version:                0
[    0.201446] ... bit width:              32
[    0.201569] ... generic registers:      2
[    0.201691] ... value mask:             00000000ffffffff
[    0.201815] ... max period:             000000007fffffff
[    0.201939] ... fixed-purpose events:   0
[    0.202060] ... event mask:             0000000000000003
[    0.202278] Hierarchical SRCU implementation.
[    0.204767] devtmpfs: initialized
[    0.205265] PM: Registering ACPI NVS region [mem 0x3f6efc00-0x3f6effff] (1024 bytes)
[    0.208327] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.208550] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.209004] NET: Registered protocol family 16
[    0.209443] audit: initializing netlink subsys (disabled)
[    0.210222] audit: type=2000 audit(1536524848.026:1): state=initialized audit_enabled=0 res=1
[    0.210840] cpuidle: using governor ladder
[    0.210984] cpuidle: using governor menu
[    0.211567] ACPI: bus type PCI registered
[    0.211692] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.215547] PCI: PCI BIOS revision 2.10 entry at 0xfd96e, last bus=3
[    0.218197] PCI: Using configuration type 1 for base access
[    0.241253] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.242463] ACPI: Added _OSI(Module Device)
[    0.245067] ACPI: Added _OSI(Processor Device)
[    0.248226] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.248353] ACPI: Added _OSI(Processor Aggregator Device)
[    0.248480] ACPI: Added _OSI(Linux-Dell-Video)
[    0.257278] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.265061] ACPI: EC: EC started
[    0.268105] ACPI: EC: interrupt blocked
[    0.271498] ACPI: \_SB_.PCI0.LPC0.EC__: Used as first EC
[    0.271628] ACPI: \_SB_.PCI0.LPC0.EC__: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.271843] ACPI: \_SB_.PCI0.LPC0.EC__: Used as boot DSDT EC to handle transactions
[    0.272054] ACPI: Interpreter enabled
[    0.272243] ACPI: (supports S0 S3 S4 S5)
[    0.272368] ACPI: Using PIC for interrupt routing
[    0.272610] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.273287] ACPI: Enabled 3 GPEs in block 00 to 0F
[    0.273422] ACPI: Enabled 2 GPEs in block 10 to 1F
[    0.290812] acpi LNXIOBAY:00: ACPI dock station (docks/bays count: 1)
[    0.295309] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.298250] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.301510] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.301649] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.303053] PCI host bridge to bus 0000:00
[    0.303186] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.303317] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.303449] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.303664] pci_bus 0000:00: root bus resource [mem 0x000cd200-0x000dffff window]
[    0.303879] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebfffff window]
[    0.304095] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.304242] pci 0000:00:00.0: [8086:3575] type 00 class 0x060000
[    0.304482] pci 0000:00:02.0: [8086:3577] type 00 class 0x030000
[    0.304501] pci 0000:00:02.0: reg 0x10: [mem 0xe8000000-0xefffffff pref]
[    0.304510] pci 0000:00:02.0: reg 0x14: [mem 0xe0000000-0xe007ffff]
[    0.304555] pci 0000:00:02.0: supports D1
[    0.304917] pci 0000:00:02.1: [8086:3577] type 00 class 0x038000
[    0.304933] pci 0000:00:02.1: reg 0x10: [mem 0xf0000000-0xf7ffffff pref]
[    0.304943] pci 0000:00:02.1: reg 0x14: [mem 0xe0080000-0xe00fffff]
[    0.304987] pci 0000:00:02.1: supports D1
[    0.305250] pci 0000:00:1d.0: [8086:2482] type 00 class 0x0c0300
[    0.305298] pci 0000:00:1d.0: reg 0x20: [io  0x1440-0x145f]
[    0.305504] pci 0000:00:1d.1: [8086:2484] type 00 class 0x0c0300
[    0.305552] pci 0000:00:1d.1: reg 0x20: [io  0x1460-0x147f]
[    0.305775] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060400
[    0.306038] pci 0000:00:1f.0: [8086:248c] type 00 class 0x060100
[    0.306118] pci 0000:00:1f.0: quirk: [io  0xfc00-0xfc7f] claimed by ICH4 ACPI/GPIO/TCO
[    0.308299] pci 0000:00:1f.0: quirk: [io  0xfc80-0xfcbf] claimed by ICH4 GPIO
[    0.308622] pci 0000:00:1f.1: [8086:248a] type 00 class 0x01018a
[    0.308645] pci 0000:00:1f.1: reg 0x10: [io  0x01f0-0x01f7]
[    0.308657] pci 0000:00:1f.1: reg 0x14: [io  0x03f4-0x03f7]
[    0.308670] pci 0000:00:1f.1: reg 0x18: [io  0x0170-0x0177]
[    0.308682] pci 0000:00:1f.1: reg 0x1c: [io  0x0374-0x0377]
[    0.308694] pci 0000:00:1f.1: reg 0x20: [io  0x14a0-0x14af]
[    0.308707] pci 0000:00:1f.1: reg 0x24: [mem 0xe0100000-0xe01003ff]
[    0.308722] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.308853] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.308983] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.309113] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.309437] pci 0000:00:1f.3: [8086:2483] type 00 class 0x0c0500
[    0.309485] pci 0000:00:1f.3: reg 0x20: [io  0x1480-0x149f]
[    0.309692] pci 0000:00:1f.5: [8086:2485] type 00 class 0x040100
[    0.309714] pci 0000:00:1f.5: reg 0x10: [io  0x1000-0x10ff]
[    0.309726] pci 0000:00:1f.5: reg 0x14: [io  0x1400-0x143f]
[    0.309959] pci_bus 0000:01: extended config space not accessible
[    0.310259] pci 0000:01:09.0: [10ec:8139] type 00 class 0x020000
[    0.310280] pci 0000:01:09.0: reg 0x10: [io  0x8000-0x80ff]
[    0.310293] pci 0000:01:09.0: reg 0x14: [mem 0xe0214800-0xe02148ff]
[    0.310363] pci 0000:01:09.0: supports D1 D2
[    0.310368] pci 0000:01:09.0: PME# supported from D1 D2 D3hot D3cold
[    0.310537] pci 0000:01:0a.0: [1217:6933] type 02 class 0x060700
[    0.310557] pci 0000:01:0a.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.310596] pci 0000:01:0a.0: supports D1 D2
[    0.310602] pci 0000:01:0a.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.310783] pci 0000:01:0a.1: [1217:6933] type 02 class 0x060700
[    0.310804] pci 0000:01:0a.1: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.310843] pci 0000:01:0a.1: supports D1 D2
[    0.310849] pci 0000:01:0a.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.311034] pci 0000:01:0c.0: [104c:8026] type 00 class 0x0c0010
[    0.311055] pci 0000:01:0c.0: reg 0x10: [mem 0xe0214000-0xe02147ff]
[    0.311068] pci 0000:01:0c.0: reg 0x14: [mem 0xe0210000-0xe0213fff]
[    0.311138] pci 0000:01:0c.0: supports D1 D2
[    0.311143] pci 0000:01:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.311310] pci 0000:01:0d.0: [168c:0029] type 00 class 0x028000
[    0.311485] pci 0000:01:0d.0: reg 0x10: [mem 0xe0200000-0xe020ffff]
[    0.311564] pci 0000:01:0d.0: PME# supported from D0 D3hot
[    0.311764] pci 0000:00:1e.0: PCI bridge to [bus 01-03] (subtractive decode)
[    0.311904] pci 0000:00:1e.0:   bridge window [io  0x8000-0x8fff]
[    0.311912] pci 0000:00:1e.0:   bridge window [mem 0xe0200000-0xe02fffff]
[    0.311921] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.311927] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.311933] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.311938] pci 0000:00:1e.0:   bridge window [mem 0x000cd200-0x000dffff window] (subtractive decode)
[    0.311944] pci 0000:00:1e.0:   bridge window [mem 0x40000000-0xfebfffff window] (subtractive decode)
[    0.311980] pci_bus 0000:02: extended config space not accessible
[    0.312350] pci_bus 0000:02: busn_res: [bus 02-03] end is updated to 02
[    0.312379] pci_bus 0000:03: extended config space not accessible
[    0.315092] pci_bus 0000:03: busn_res: [bus 03] end can not be updated to 06
[    0.315102] pci 0000:00:1e.0: bridge has subordinate 03 but max busn 06
[    0.318199] pci_bus 0000:00: on NUMA node 0
[    0.323645] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
[    0.328194] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
[    0.331666] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
[    0.332002] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
[    0.332337] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
[    0.332672] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
[    0.333010] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
[    0.333435] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11) *0, disabled.
[    0.334995] ACPI: EC: interrupt unblocked
[    0.335136] ACPI: EC: event unblocked
[    0.335267] ACPI: \_SB_.PCI0.LPC0.EC__: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.336167] ACPI: \_SB_.PCI0.LPC0.EC__: Used as boot DSDT EC to handle transactions and events
[    0.338678] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.338813] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.339037] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.339163] vgaarb: loaded
[    0.339571] SCSI subsystem initialized
[    0.340070] libata version 3.00 loaded.
[    0.340426] PCI: Using ACPI for IRQ routing
[    0.340563] PCI: pci_cache_line_size set to 32 bytes
[    0.340621] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.340626] e820: reserve RAM buffer [mem 0x3f6e0000-0x3fffffff]
[    0.340631] e820: reserve RAM buffer [mem 0x3f780000-0x3fffffff]
[    0.353375] clocksource: Switched to clocksource tsc-early
[    0.377877] pnp: PnP ACPI init
[    0.385575] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.386352] system 00:00: [io  0xf800-0xf87f] has been reserved
[    0.386483] system 00:00: [io  0xf880-0xf8ff] has been reserved
[    0.386613] system 00:00: [io  0xfd00-0xfd6f] has been reserved
[    0.386743] system 00:00: [io  0xfe00] has been reserved
[    0.386872] system 00:00: [io  0xfc00-0xfc7f] has been reserved
[    0.387009] system 00:00: [io  0xfc80-0xfcbf] has been reserved
[    0.387141] system 00:00: [mem 0x000cd200-0x000cffff] has been reserved
[    0.387273] system 00:00: [mem 0xffb00000-0xffbfffff] has been reserved
[    0.387460] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.387882] pnp 00:01: disabling [io  0x83b0-0x83bb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.388105] pnp 00:01: disabling [io  0x83c0-0x83df] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.388325] pnp 00:01: disabling [io  0x87b0-0x87bb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.388545] pnp 00:01: disabling [io  0x87c0-0x87df] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.388765] pnp 00:01: disabling [io  0x8bb0-0x8bbb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.388985] pnp 00:01: disabling [io  0x8bc0-0x8bdf] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.389205] pnp 00:01: disabling [io  0x8fb0-0x8fbb] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.389425] pnp 00:01: disabling [io  0x8fc0-0x8fdf] because it overlaps 0000:00:1e.0 BAR 7 [io  0x8000-0x8fff]
[    0.390503] system 00:01: [io  0x07b0-0x07bb] has been reserved
[    0.397991] system 00:01: [io  0x07c0-0x07df] has been reserved
[    0.402930] system 00:01: [io  0x0bb0-0x0bbb] has been reserved
[    0.403061] system 00:01: [io  0x0bc0-0x0bdf] has been reserved
[    0.403191] system 00:01: [io  0x0fb0-0x0fbb] has been reserved
[    0.403321] system 00:01: [io  0x0fc0-0x0fdf] has been reserved
[    0.403451] system 00:01: [io  0x13b0-0x13bb] has been reserved
[    0.403582] system 00:01: [io  0x13c0-0x13df] has been reserved
[    0.403712] system 00:01: [io  0x17b0-0x17bb] has been reserved
[    0.403842] system 00:01: [io  0x17c0-0x17df] has been reserved
[    0.403972] system 00:01: [io  0x1bb0-0x1bbb] has been reserved
[    0.404103] system 00:01: [io  0x1bc0-0x1bdf] has been reserved
[    0.404241] system 00:01: [io  0x1fb0-0x1fbb] has been reserved
[    0.404371] system 00:01: [io  0x1fc0-0x1fdf] has been reserved
[    0.404502] system 00:01: [io  0x23b0-0x23bb] has been reserved
[    0.404632] system 00:01: [io  0x23c0-0x23df] has been reserved
[    0.404761] system 00:01: [io  0x27b0-0x27bb] has been reserved
[    0.404891] system 00:01: [io  0x27c0-0x27df] has been reserved
[    0.405021] system 00:01: [io  0x2bb0-0x2bbb] has been reserved
[    0.405151] system 00:01: [io  0x2bc0-0x2bdf] has been reserved
[    0.405281] system 00:01: [io  0x2fb0-0x2fbb] has been reserved
[    0.405412] system 00:01: [io  0x2fc0-0x2fdf] has been reserved
[    0.405542] system 00:01: [io  0x33b0-0x33bb] has been reserved
[    0.405672] system 00:01: [io  0x33c0-0x33df] has been reserved
[    0.405802] system 00:01: [io  0x37b0-0x37bb] has been reserved
[    0.405932] system 00:01: [io  0x37c0-0x37df] has been reserved
[    0.406063] system 00:01: [io  0x3bb0-0x3bbb] has been reserved
[    0.406229] system 00:01: [io  0x3bc0-0x3bdf] has been reserved
[    0.406360] system 00:01: [io  0x3fb0-0x3fbb] has been reserved
[    0.406490] system 00:01: [io  0x3fc0-0x3fdf] has been reserved
[    0.406620] system 00:01: [io  0x43b0-0x43bb] has been reserved
[    0.406750] system 00:01: [io  0x43c0-0x43df] has been reserved
[    0.408915] system 00:01: [io  0x47b0-0x47bb] has been reserved
[    0.416358] system 00:01: [io  0x47c0-0x47df] has been reserved
[    0.419615] system 00:01: [io  0x4bb0-0x4bbb] has been reserved
[    0.419746] system 00:01: [io  0x4bc0-0x4bdf] has been reserved
[    0.419876] system 00:01: [io  0x4fb0-0x4fbb] has been reserved
[    0.420006] system 00:01: [io  0x4fc0-0x4fdf] has been reserved
[    0.420137] system 00:01: [io  0x53b0-0x53bb] has been reserved
[    0.420267] system 00:01: [io  0x53c0-0x53df] has been reserved
[    0.420398] system 00:01: [io  0x57b0-0x57bb] has been reserved
[    0.420528] system 00:01: [io  0x57c0-0x57df] has been reserved
[    0.420658] system 00:01: [io  0x5bb0-0x5bbb] has been reserved
[    0.420789] system 00:01: [io  0x5bc0-0x5bdf] has been reserved
[    0.420927] system 00:01: [io  0x5fb0-0x5fbb] has been reserved
[    0.421058] system 00:01: [io  0x5fc0-0x5fdf] has been reserved
[    0.421188] system 00:01: [io  0x63b0-0x63bb] has been reserved
[    0.421319] system 00:01: [io  0x63c0-0x63df] has been reserved
[    0.421449] system 00:01: [io  0x67b0-0x67bb] has been reserved
[    0.421580] system 00:01: [io  0x67c0-0x67df] has been reserved
[    0.421711] system 00:01: [io  0x6bb0-0x6bbb] has been reserved
[    0.421841] system 00:01: [io  0x6bc0-0x6bdf] has been reserved
[    0.421972] system 00:01: [io  0x6fb0-0x6fbb] has been reserved
[    0.422102] system 00:01: [io  0x6fc0-0x6fdf] has been reserved
[    0.422233] system 00:01: [io  0x73b0-0x73bb] has been reserved
[    0.422364] system 00:01: [io  0x73c0-0x73df] has been reserved
[    0.422494] system 00:01: [io  0x77b0-0x77bb] has been reserved
[    0.422625] system 00:01: [io  0x77c0-0x77df] has been reserved
[    0.422755] system 00:01: [io  0x7bb0-0x7bbb] has been reserved
[    0.422893] system 00:01: [io  0x7bc0-0x7bdf] has been reserved
[    0.423025] system 00:01: [io  0x7fb0-0x7fbb] has been reserved
[    0.423155] system 00:01: [io  0x7fc0-0x7fdf] has been reserved
[    0.423290] system 00:01: [io  0x93b0-0x93bb] has been reserved
[    0.423421] system 00:01: [io  0x93c0-0x93df] has been reserved
[    0.426162] system 00:01: [io  0x97b0-0x97bb] has been reserved
[    0.433583] system 00:01: [io  0x97c0-0x97df] has been reserved
[    0.436278] system 00:01: [io  0x9bb0-0x9bbb] has been reserved
[    0.436410] system 00:01: [io  0x9bc0-0x9bdf] has been reserved
[    0.436541] system 00:01: [io  0x9fb0-0x9fbb] has been reserved
[    0.436672] system 00:01: [io  0x9fc0-0x9fdf] has been reserved
[    0.436804] system 00:01: [io  0xa3b0-0xa3bb] has been reserved
[    0.436935] system 00:01: [io  0xa3c0-0xa3df] has been reserved
[    0.437067] system 00:01: [io  0xa7b0-0xa7bb] has been reserved
[    0.437198] system 00:01: [io  0xa7c0-0xa7df] has been reserved
[    0.437329] system 00:01: [io  0xabb0-0xabbb] has been reserved
[    0.437461] system 00:01: [io  0xabc0-0xabdf] has been reserved
[    0.437600] system 00:01: [io  0xafb0-0xafbb] has been reserved
[    0.437732] system 00:01: [io  0xafc0-0xafdf] has been reserved
[    0.437863] system 00:01: [io  0xb3b0-0xb3bb] has been reserved
[    0.437995] system 00:01: [io  0xb3c0-0xb3df] has been reserved
[    0.438127] system 00:01: [io  0xb7b0-0xb7bb] has been reserved
[    0.438259] system 00:01: [io  0xb7c0-0xb7df] has been reserved
[    0.438390] system 00:01: [io  0xbbb0-0xbbbb] has been reserved
[    0.438522] system 00:01: [io  0xbbc0-0xbbdf] has been reserved
[    0.438654] system 00:01: [io  0xbfb0-0xbfbb] has been reserved
[    0.438786] system 00:01: [io  0xbfc0-0xbfdf] has been reserved
[    0.438918] system 00:01: [io  0xc3b0-0xc3bb] has been reserved
[    0.439050] system 00:01: [io  0xc3c0-0xc3df] has been reserved
[    0.439182] system 00:01: [io  0xc7b0-0xc7bb] has been reserved
[    0.439314] system 00:01: [io  0xc7c0-0xc7df] has been reserved
[    0.439445] system 00:01: [io  0xcbb0-0xcbbb] has been reserved
[    0.439585] system 00:01: [io  0xcbc0-0xcbdf] has been reserved
[    0.439717] system 00:01: [io  0xcfb0-0xcfbb] has been reserved
[    0.439848] system 00:01: [io  0xcfc0-0xcfdf] has been reserved
[    0.439980] system 00:01: [io  0xd3b0-0xd3bb] has been reserved
[    0.440112] system 00:01: [io  0xd3c0-0xd3df] has been reserved
[    0.444851] system 00:01: [io  0xd7b0-0xd7bb] has been reserved
[    0.452278] system 00:01: [io  0xd7c0-0xd7df] has been reserved
[    0.452965] system 00:01: [io  0xdbb0-0xdbbb] has been reserved
[    0.453098] system 00:01: [io  0xdbc0-0xdbdf] has been reserved
[    0.453229] system 00:01: [io  0xdfb0-0xdfbb] has been reserved
[    0.453361] system 00:01: [io  0xdfc0-0xdfdf] has been reserved
[    0.453493] system 00:01: [io  0xe3b0-0xe3bb] has been reserved
[    0.453625] system 00:01: [io  0xe3c0-0xe3df] has been reserved
[    0.453757] system 00:01: [io  0xe7b0-0xe7bb] has been reserved
[    0.453889] system 00:01: [io  0xe7c0-0xe7df] has been reserved
[    0.454021] system 00:01: [io  0xebb0-0xebbb] has been reserved
[    0.454153] system 00:01: [io  0xebc0-0xebdf] has been reserved
[    0.454285] system 00:01: [io  0xefb0-0xefbb] has been reserved
[    0.454417] system 00:01: [io  0xefc0-0xefdf] has been reserved
[    0.454549] system 00:01: [io  0xf3b0-0xf3bb] has been reserved
[    0.454681] system 00:01: [io  0xf3c0-0xf3df] has been reserved
[    0.454813] system 00:01: [io  0xf7b0-0xf7bb] has been reserved
[    0.454946] system 00:01: [io  0xf7c0-0xf7df] has been reserved
[    0.455078] system 00:01: [io  0xfbb0-0xfbbb] has been reserved
[    0.455210] system 00:01: [io  0xfbc0-0xfbdf] has been reserved
[    0.455343] system 00:01: [io  0xffb0-0xffbb] has been reserved
[    0.455476] system 00:01: [io  0xffc0-0xffdf] has been reserved
[    0.455651] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.455901] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.456060] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.456204] pnp 00:04: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.457089] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.458051] pnp 00:06: [dma 3]
[    0.458392] pnp 00:06: Plug and Play ACPI device, IDs SMCf010 (active)
[    0.459437] pnp 00:07: [dma 1]
[    0.459685] pnp 00:07: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.460708] pnp: PnP ACPI: found 8 devices
[    0.587873] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.588161] pci 0000:00:1e.0: bridge window [mem 0x04000000-0x0bffffff pref] to [bus 01-03] add_size 8000000 add_align 4000000
[    0.588198] pci 0000:00:1e.0: BAR 9: assigned [mem 0x40000000-0x4fffffff pref]
[    0.588437] pci 0000:01:0a.0: BAR 0: assigned [mem 0x50000000-0x50000fff]
[    0.588575] pci 0000:01:0a.0: BAR 9: assigned [mem 0x40000000-0x43ffffff pref]
[    0.588794] pci 0000:01:0a.0: BAR 10: assigned [mem 0x54000000-0x57ffffff]
[    0.588931] pci 0000:01:0a.1: BAR 0: assigned [mem 0x58000000-0x58000fff]
[    0.589067] pci 0000:01:0a.1: BAR 9: assigned [mem 0x44000000-0x47ffffff pref]
[    0.604066] pci 0000:01:0a.1: BAR 10: assigned [mem 0x5c000000-0x5fffffff]
[    0.604207] pci 0000:01:0a.0: BAR 7: assigned [io  0x8400-0x84ff]
[    0.604338] pci 0000:01:0a.0: BAR 8: assigned [io  0x8800-0x88ff]
[    0.604469] pci 0000:01:0a.1: BAR 7: assigned [io  0x8c00-0x8cff]
[    0.604609] pci 0000:01:0a.1: BAR 8: assigned [io  0x1800-0x18ff]
[    0.604742] pci 0000:01:0a.0: CardBus bridge to [bus 02]
[    0.604870] pci 0000:01:0a.0:   bridge window [io  0x8400-0x84ff]
[    0.605001] pci 0000:01:0a.0:   bridge window [io  0x8800-0x88ff]
[    0.605132] pci 0000:01:0a.0:   bridge window [mem 0x40000000-0x43ffffff pref]
[    0.605347] pci 0000:01:0a.0:   bridge window [mem 0x54000000-0x57ffffff]
[    0.605478] pci 0000:01:0a.1: CardBus bridge to [bus 03]
[    0.605606] pci 0000:01:0a.1:   bridge window [io  0x8c00-0x8cff]
[    0.605736] pci 0000:01:0a.1:   bridge window [io  0x1800-0x18ff]
[    0.605868] pci 0000:01:0a.1:   bridge window [mem 0x44000000-0x47ffffff pref]
[    0.606083] pci 0000:01:0a.1:   bridge window [mem 0x5c000000-0x5fffffff]
[    0.606222] pci 0000:00:1e.0: PCI bridge to [bus 01-03]
[    0.606352] pci 0000:00:1e.0:   bridge window [io  0x8000-0x8fff]
[    0.606484] pci 0000:00:1e.0:   bridge window [mem 0xe0200000-0xe02fffff]
[    0.606616] pci 0000:00:1e.0:   bridge window [mem 0x40000000-0x4fffffff pref]
[    0.608776] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.608782] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.608788] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.608794] pci_bus 0000:00: resource 7 [mem 0x000cd200-0x000dffff window]
[    0.608800] pci_bus 0000:00: resource 8 [mem 0x40000000-0xfebfffff window]
[    0.608806] pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
[    0.608811] pci_bus 0000:01: resource 1 [mem 0xe0200000-0xe02fffff]
[    0.608817] pci_bus 0000:01: resource 2 [mem 0x40000000-0x4fffffff pref]
[    0.608822] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
[    0.608828] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff window]
[    0.608833] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.608839] pci_bus 0000:01: resource 7 [mem 0x000cd200-0x000dffff window]
[    0.608845] pci_bus 0000:01: resource 8 [mem 0x40000000-0xfebfffff window]
[    0.608851] pci_bus 0000:02: resource 0 [io  0x8400-0x84ff]
[    0.608856] pci_bus 0000:02: resource 1 [io  0x8800-0x88ff]
[    0.608862] pci_bus 0000:02: resource 2 [mem 0x40000000-0x43ffffff pref]
[    0.608867] pci_bus 0000:02: resource 3 [mem 0x54000000-0x57ffffff]
[    0.608873] pci_bus 0000:03: resource 0 [io  0x8c00-0x8cff]
[    0.608878] pci_bus 0000:03: resource 1 [io  0x1800-0x18ff]
[    0.608884] pci_bus 0000:03: resource 2 [mem 0x44000000-0x47ffffff pref]
[    0.608890] pci_bus 0000:03: resource 3 [mem 0x5c000000-0x5fffffff]
[    0.609150] NET: Registered protocol family 2
[    0.616731] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    0.619674] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.619852] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.620051] TCP: Hash tables configured (established 8192 bind 8192)
[    0.620292] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.620440] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.620706] NET: Registered protocol family 1
[    0.620892] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.621483] PCI Interrupt Link [LNKA] enabled at IRQ 11
[    0.621612] PCI: setting IRQ 11 as level-triggered
[    0.621995] PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.622312] PCI: CLS 32 bytes, default 32
[    0.622487] Unpacking initramfs...
[    0.663555] Freeing initrd memory: 4960K
[    0.670633] Scanning for low memory corruption every 60 seconds
[    0.673357] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    0.689939] pstore: using deflate compression
[    0.691868] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.703119] io scheduler noop registered
[    0.703245] io scheduler deadline registered
[    0.703516] io scheduler cfq registered (default)
[    0.704198] ACPI: AC Adapter [AC] (on-line)
[    0.704612] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.704853] ACPI: Power Button [PWRB]
[    0.705176] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    0.705420] ACPI: Lid Switch [LID]
[    0.705722] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.705954] ACPI: Power Button [PWRF]
[    0.706510] tsc: Marking TSC unstable due to TSC halts in idle
[    0.706661] clocksource: Switched to clocksource acpi_pm
[    0.709450] ACPI: Battery Slot [CMB1] (battery present)
[    0.717144] isapnp: Scanning for PnP cards...
[    0.725176] ACPI: Battery Slot [CMB2] (battery absent)
[    1.437418] random: fast init done
[    6.825516] isapnp: No Plug & Play device found
[    6.832976] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    7.180561] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    7.185423] serial 00:06: skipping CIR port at 0x2e8 / 0x0, IRQ 3
[    7.186568] ata_piix 0000:00:1f.1: version 2.13
[    7.186592] ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
[    7.187091] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    7.190713] scsi host0: ata_piix
[    7.198209] scsi host1: ata_piix
[    7.202085] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x14a0 irq 14
[    7.202216] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x14a8 irq 15
[    7.204263] yenta_cardbus 0000:01:0a.0: CardBus bridge found [10cf:10e6]
[    7.204413] yenta_cardbus 0000:01:0a.0: O2: disabling read prefetch/write burst. If you experience problems or performance issues, use the yenta_socket parameter 'o2_speedup=on'
[    7.361366] ata2.01: NODEV after polling detection
[    7.366117] ata2.00: ATAPI: UJDA750FDVD/CDRW, 1.20, max UDMA/33
[    7.385617] ata1.00: ATA-8: KINGSTON SMS200S3120G, 60AABBF0, max UDMA/133
[    7.385749] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    7.403611] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SMS200S BBF0 PQ: 0 ANSI: 5
[    7.404628] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    7.404921] sd 0:0:0:0: [sda] Write Protect is off
[    7.405050] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    7.405114] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.407903]  sda: sda1 sda2 sda3
[    7.417047] sd 0:0:0:0: [sda] Attached SCSI disk
[    7.418523] scsi 1:0:0:0: CD-ROM            MATSHITA UJDA750FDVD/CDRW 1.20 PQ: 0 ANSI: 5
[    7.468527] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    7.468747] cdrom: Uniform CD-ROM driver Revision: 3.20
[    7.469157] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    7.612089] yenta_cardbus 0000:01:0a.0: ISA IRQ mask 0x04b8, PCI irq 11
[    7.618345] yenta_cardbus 0000:01:0a.0: Socket status: 30000006
[    7.618484] yenta_cardbus 0000:01:0a.0: pcmcia: parent PCI bridge window: [io  0x8000-0x8fff]
[    7.618701] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x8000-0x8fff:
[    7.620099]  excluding 0x8000-0x80ff 0x8400-0x84ff 0x8800-0x88ff 0x8c00-0x8cff
[    7.635032] yenta_cardbus 0000:01:0a.0: pcmcia: parent PCI bridge window: [mem 0xe0200000-0xe02fffff]
[    7.635251] pcmcia_socket pcmcia_socket0: cs: memory probe 0xe0200000-0xe02fffff:
[    7.635467]  excluding 0xe0200000-0xe021ffff
[    7.635612] yenta_cardbus 0000:01:0a.0: pcmcia: parent PCI bridge window: [mem 0x40000000-0x4fffffff pref]
[    7.635830] pcmcia_socket pcmcia_socket0: cs: memory probe 0x40000000-0x4fffffff:
[    7.636062]  excluding 0x40000000-0x4fffffff
[    7.637135] PCI Interrupt Link [LNKB] enabled at IRQ 11
[    7.637297] yenta_cardbus 0000:01:0a.1: CardBus bridge found [10cf:10e6]
[    7.778790] yenta_cardbus 0000:01:0a.1: ISA IRQ mask 0x04b8, PCI irq 11
[    7.784983] yenta_cardbus 0000:01:0a.1: Socket status: 30000006
[    7.785119] yenta_cardbus 0000:01:0a.1: pcmcia: parent PCI bridge window: [io  0x8000-0x8fff]
[    7.785336] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x8000-0x8fff:
[    7.786732]  excluding 0x8000-0x80ff 0x8400-0x84ff 0x8800-0x88ff 0x8c00-0x8cff
[    7.801671] yenta_cardbus 0000:01:0a.1: pcmcia: parent PCI bridge window: [mem 0xe0200000-0xe02fffff]
[    7.801890] pcmcia_socket pcmcia_socket1: cs: memory probe 0xe0200000-0xe02fffff:
[    7.802104]  excluding 0xe0200000-0xe021ffff
[    7.802250] yenta_cardbus 0000:01:0a.1: pcmcia: parent PCI bridge window: [mem 0x40000000-0x4fffffff pref]
[    7.802469] pcmcia_socket pcmcia_socket1: cs: memory probe 0x40000000-0x4fffffff:
[    7.802702]  excluding 0x40000000-0x4fffffff
[    7.803526] i8042: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    7.825352] serio: i8042 KBD port at 0x60,0x64 irq 1
[    7.832700] serio: i8042 AUX port at 0x60,0x64 irq 12
[    7.835354] rtc_cmos 00:02: RTC can wake from S4
[    7.835730] rtc_cmos 00:02: registered as rtc0
[    7.835931] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    7.836161] IR NEC protocol handler initialized
[    7.836293] IR RC5(x/sz) protocol handler initialized
[    7.836417] IR RC6 protocol handler initialized
[    7.836539] IR JVC protocol handler initialized
[    7.836661] IR Sony protocol handler initialized
[    7.836784] IR SANYO protocol handler initialized
[    7.836907] IR Sharp protocol handler initialized
[    7.837030] IR MCE Keyboard/mouse protocol handler initialized
[    7.837154] IR XMP protocol handler initialized
[    7.837501] NET: Registered protocol family 17
[    7.838404] microcode: sig=0x6b4, pf=0x20, revision=0x2
[    7.838642] microcode: Microcode Update Driver: v2.2.
[    7.838652] Using IPI Shortcut mode
[    7.839292] registered taskstats version 1
[    7.847135] console [netcon0] enabled
[    7.851784] netconsole: network logging started
[    7.851949] rtc_cmos 00:02: setting system clock to 2018-09-09 20:27:36 UTC (1536524856)
[    7.854870] Unstable clock detected, switching default tracing clock to "global"
               If you want to keep using the local clock, then add:
                 "trace_clock=local"
               on the kernel command line
[    7.870958] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    7.898181] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    7.901783] VFS: Mounted root (ext4 filesystem) readonly on device 8:3.
[    7.907266] devtmpfs: mounted
[    7.915022] Freeing unused kernel memory: 472K
[    7.918527] Write protecting the kernel text: 4944k
[    7.918761] Write protecting the kernel read-only data: 1344k
[    9.511364] random: lvm: uninitialized urandom read (4 bytes read)
[   12.651114] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   12.651426] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/LNXVIDEO:00/input/input5
[   12.732455] parport_pc 00:07: reported by Plug and Play ACPI
[   12.732552] parport0: PC-style at 0x378 (0x778), irq 7
[   12.756360] fujitsu_laptop: ACPI: Fujitsu FUJ02B1 [FJEX]
[   12.756888] input: Fujitsu FUJ02B1 as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:03/FUJ02B1:00/input/input6
[   12.778349] fujitsu_laptop: driver 0.6.0 successfully loaded
[   12.810969] Linux agpgart interface v0.103
[   12.866565] intel_rng: FWH not detected
[   12.875783] agpgart-intel 0000:00:00.0: Intel 830M Chipset
[   12.886799] , dma 1 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[   12.946993] 8139too: 8139too Fast Ethernet driver 0.9.28
[   12.947464] PCI Interrupt Link [LNKF] enabled at IRQ 11
[   12.948088] 8139too 0000:01:09.0 eth0: RealTek RTL8139 at 0x(ptrval), 00:e0:00:f9:83:13, IRQ 11
[   12.959395] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af:
[   12.960485]  excluding 0x170-0x177 0x1f0-0x1f7 0x2e8-0x2ef 0x370-0x37f
[   12.961306] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3e0-0x4ff:
[   12.961968] ACPI: bus type USB registered
[   12.962053] usbcore: registered new interface driver usbfs
[   12.962089] usbcore: registered new interface driver hub
[   12.962167] usbcore: registered new device driver usb
[   12.977229] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.981798]  excluding 0x3f0-0x407 0x4d0-0x4d7
[   12.982276] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x8ff:
[   12.982856]  clean
[   12.982896] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcf7:
[   12.983538]  clean
[   12.983599] pcmcia_socket pcmcia_socket0: cs: memory probe 0x0c0000-0x0fffff:
[   12.983611]  excluding 0xc0000-0xcffff 0xe0000-0xfffff
[   12.983675] pcmcia_socket pcmcia_socket0: cs: memory probe 0xa0000000-0xa0ffffff:
[   12.983704]  clean
[   12.983742] pcmcia_socket pcmcia_socket0: cs: memory probe 0x60000000-0x60ffffff:
[   12.983770]  clean
[   12.983808] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff:
[   12.984469]  clean
[   13.005790] ehci-pci: EHCI PCI platform driver
[   13.008039] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x100-0x3af:
[   13.008652] PCI Interrupt Link [LNKE] enabled at IRQ 11
[   13.020116]  excluding 0x170-0x177 0x1f0-0x1f7 0x2e8-0x2ef 0x370-0x37f
[   13.020907] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x3e0-0x4ff:
[   13.021265]  excluding 0x3f0-0x407
[   13.022711] uhci_hcd: USB Universal Host Controller Interface driver
[   13.022927] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   13.022948] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   13.023108] uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001440
[   13.045778] hub 1-0:1.0: USB hub found
[   13.045808] hub 1-0:1.0: 2 ports detected
[   13.046342] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   13.046359] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   13.046522] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001460
[   13.046682]  0x4d0-0x4d7
[   13.046861] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x820-0x8ff:
[   13.047440]  clean
[   13.047479] pcmcia_socket pcmcia_socket1: cs: IO port probe 0xc00-0xcf7:
[   13.048621] hub 2-0:1.0: USB hub found
[   13.050300] hub 2-0:1.0: 2 ports detected
[   13.061627]  clean
[   13.061791] pcmcia_socket pcmcia_socket1: cs: memory probe 0x0c0000-0x0fffff:
[   13.061806]  excluding 0xc0000-0xcffff 0xe0000-0xfffff
[   13.061866] pcmcia_socket pcmcia_socket1: cs: memory probe 0xa0000000-0xa0ffffff:
[   13.061895]  clean
[   13.061934] pcmcia_socket pcmcia_socket1: cs: memory probe 0x60000000-0x60ffffff:
[   13.061961]  clean
[   13.062002] pcmcia_socket pcmcia_socket1: cs: IO port probe 0xa00-0xaff:
[   13.062664]  clean
[   13.065176] firewire_ohci 0000:01:0c.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x2
[   13.074962] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x0
[   13.143481] i801_smbus 0000:00:1f.3: SMBus using polling
[   13.201297] input: PC Speaker as /devices/platform/pcspkr/input/input7
[   13.404844] usb 2-2: new full-speed USB device number 2 using uhci_hcd
[   13.456224] pnp 00:06: disabled
[   13.457883] pnp 00:06: activated
[   13.569520] firewire_core 0000:01:0c.0: created device fw0: GUID 00000e1000a1646a, S400
[   13.624088] pnp 00:06: disabled
[   13.625828] pnp 00:06: activated
[   13.884058] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   13.884159] iTCO_wdt: Found a ICH3-M TCO device (Version=1, TCOBASE=0xfc60)
[   13.884353] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   14.140997] apanel: duplicate entry for devno 1
[   14.170995] input: Fujitsu Application Panel buttons as /devices/pci0000:00/0000:00:1f.3/i2c-0/0-0019/input/input9
[   14.284867] snd_intel8x0 0000:00:1f.5: intel8x0_measure_ac97_clock: measured 56245 usecs (2702 samples)
[   14.284876] snd_intel8x0 0000:00:1f.5: clocking to 48000
[   14.463299] Bluetooth: Core ver 2.22
[   14.464108] NET: Registered protocol family 31
[   14.464114] Bluetooth: HCI device and connection manager initialized
[   14.464128] Bluetooth: HCI socket layer initialized
[   14.464134] Bluetooth: L2CAP socket layer initialized
[   14.464155] Bluetooth: SCO socket layer initialized
[   14.511070] usbcore: registered new interface driver btusb
[   14.682310] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio1/input/input8
[   14.700397] mousedev: PS/2 mouse device common for all mice
[   16.397989] random: lvm: uninitialized urandom read (4 bytes read)
[   17.243224] ath: EEPROM regdomain: 0x809c
[   17.243230] ath: EEPROM indicates we should expect a country code
[   17.243235] ath: doing EEPROM country->regdmn map search
[   17.243238] ath: country maps to regdmn code: 0x52
[   17.243241] ath: Country alpha2 being used: CN
[   17.243243] ath: Regpair used: 0x52
[   17.280437] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   17.282796] ieee80211 phy0: Atheros AR9280 Rev:2 mem=0xf83e0000, irq=11
[   17.379760] EXT4-fs (sda3): re-mounted. Opts: (null)
[   17.602707] random: ln: uninitialized urandom read (6 bytes read)
[   17.748345] Adding 1048572k swap on /dev/sda2.  Priority:-2 extents:1 across:1048572k SS
[   18.728600] random: mktemp: uninitialized urandom read (10 bytes read)
[   22.069409] random: dd: uninitialized urandom read (512 bytes read)
[   22.449603] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   22.484079] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   22.961902] 8139too 0000:01:09.0 eth0: link down
[   27.067695] random: ssh-keygen: uninitialized urandom read (32 bytes read)
[   27.100339] random: sshd: uninitialized urandom read (32 bytes read)
[   27.267611] random: sshd: uninitialized urandom read (32 bytes read)
[   28.012622] random: crng init done
[   28.214868] wlan0: authenticate with ...
[   28.590094] wlan0: send auth to ... (try 1/3)
[   28.593897] wlan0: authenticated
[   28.600317] wlan0: associate with ... (try 1/3)
[   28.603968] wlan0: RX AssocResp from ... (capab=0x411 status=0 aid=3)
[   28.604182] wlan0: associated

--48TaNjbzBVislYPb--
