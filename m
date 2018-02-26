Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeBZJOL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:14:11 -0500
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:56151 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbeBZJOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:14:01 -0500
Date: Mon, 26 Feb 2018 11:13:56 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on HP
 DL380G3
Message-ID: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16 git bootup on HP Proliant DL380 G3 pauses for a a minute or two and 
then continues with "blocked for more than 120 seconds" message with 
libata detection functions in ther stack - 
async_synchronize_cookie_domain() as the last. It seems to happen during 
IDE CD-ROM detection (detected before but registered as sr0 after the 
warning). After detection, the eject button on the drive did not work.


pata_serverworks is the libata driver in use.

4.15 works fine.


[    0.000000] Linux version 4.16.0-rc2-00374-g3664ce2d9309 (mroos@dl380g3) (gcc version 7.3.0 (Debian 7.3.0-5)) #36 SMP Sun Feb 25 18:11:43 EET 2018
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000efff9fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000efffa000-0x00000000efffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffefff] usable
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: HP ProLiant DL380 G3, BIOS P29 09/15/2004
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x17ffff max_arch_pfn = 0x1000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0E0000000 mask FF0000000 write-back
[    0.000000]   1 base 0C0000000 mask FE0000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 000000000 mask F80000000 write-back
[    0.000000]   4 base 100000000 mask F80000000 write-back
[    0.000000]   5 base 4000A0000 mask FFFFF0000 uncachable
[    0.000000]   6 base 4000C0000 mask FFFFF0000 uncachable
[    0.000000]   7 base 4000E0000 mask FFFFF0000 uncachable
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] total RAM covered: 5888M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 512M 	num_reg: 3  	lose cover RAM: 0G
[    0.000000] e820: update [mem 0xf0000000-0xffffffff] usable ==> reserved
[    0.000000] found SMP MP-table at [mem 0x000f4fd0-0x000f4fdf] mapped at [(ptrval)]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x021fffff]
[    0.000000] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.000000] BRK [0x01d06000, 0x01d06fff] PGTABLE
[    0.000000] BRK [0x01d07000, 0x01d07fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F4F70 000014 (v00 COMPAQ)
[    0.000000] ACPI: RSDT 0x00000000EFFFA000 000030 (v01 COMPAQ P29      00000002 \xd2?   0000162E)
[    0.000000] ACPI: FACP 0x00000000EFFFA040 000074 (v01 COMPAQ P29      00000002 \xd2?   0000162E)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 32, using default 16 (20180105/tbfadt-708)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1bControlBlock: 32, using default 16 (20180105/tbfadt-708)
[    0.000000] ACPI: DSDT 0x00000000EFFFA240 003C44 (v01 COMPAQ DSDT     00000001 MSFT 0100000B)
[    0.000000] ACPI: FACS 0x00000000EFFFA0C0 000040
[    0.000000] ACPI: APIC 0x00000000EFFFA100 0000AC (v01 COMPAQ 00000083 00000002      00000000)
[    0.000000] ACPI: SPCR 0x00000000EFFFA1C0 000050 (v01 COMPAQ SPCRRBSU 00000001 \xd2?   0000162E)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 5256MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] BRK [0x01d08000, 0x01d08fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.000000]   HighMem  [mem 0x00000000377fe000-0x000000017fffefff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000efff9fff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000017fffefff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000017fffefff]
[    0.000000] On node 0 totalpages: 1507223
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 223230 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1279995 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x920
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
[    0.000000] IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, GSI 16-31
[    0.000000] IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, GSI 32-47
[    0.000000] IOAPIC[3]: apic_id 5, version 17, address 0xfec03000, GSI 48-63
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: SPCR: SPCR table version 1
[    0.000000] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.000000] ACPI: SPCR: console: uart,mmio,0x0,9600
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0xf0000000-0xfebfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 28 pages/cpu @(ptrval) s84876 r0 d29812 u114688
[    0.000000] pcpu-alloc: s84876 r0 d29812 u114688 alloc=28*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1505447
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.16.0-rc2-00374-g3664ce2d9309 root=/dev/sda1 ro
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000377fe:0017ffff)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 5965080K/6028892K available (7600K kernel code, 3390K rwdata, 1268K rodata, 572K init, 332K bss, 63812K reserved, 0K cma-reserved, 5119980K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xfff18000 - 0xfffff000   ( 924 kB)
                 cpu_entry : 0xffa00000 - 0xffb39000   (1252 kB)
                   pkmap   : 0xff800000 - 0xffa00000   (2048 kB)
                   vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
                     .init : 0xc1c0c000 - 0xc1c9b000   ( 572 kB)
                     .data : 0xc176c17a - 0xc1bfea80   (4682 kB)
                     .text : 0xc1000000 - 0xc176c17a   (7600 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 2304, nr_irqs: 1024, preallocated irqs: 16
[    0.000000] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180105
[    0.000000] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.004000] APIC: Switch to symmetric I/O mode setup
[    0.004000] Enabling APIC mode:  Flat.  Using 4 I/O APICs
[    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.024000] tsc: Fast TSC calibration using PIT
[    0.028000] tsc: Detected 3185.085 MHz processor
[    0.028000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2de9407577c, max_idle_ns: 440795271586 ns
[    0.028000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6370.17 BogoMIPS (lpj=12740340)
[    0.028000] pid_max: default: 32768 minimum: 301
[    0.028000] Security Framework initialized
[    0.028000] AppArmor: AppArmor initialized
[    0.028000] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.028000] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.028000] CPU: Physical Processor ID: 0
[    0.028000] CPU: Processor Core ID: 0
[    0.028000] mce: CPU supports 4 MCE banks
[    0.028000] CPU0: Thermal monitoring enabled (TM1)
[    0.028000] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 64
[    0.028000] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 64, 1GB 0
[    0.028000] Spectre V2 : Mitigation: Full generic retpoline
[    0.028000] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.028000] Freeing SMP alternatives memory: 24K
[    0.032000] smpboot: CPU0: Intel(R) Xeon(TM) CPU 3.20GHz (family: 0xf, model: 0x2, stepping: 0x5)
[    0.032000] Performance Events: Netburst events, Netburst P4/Xeon PMU driver.
[    0.032000] ... version:                0
[    0.032000] ... bit width:              40
[    0.032000] ... generic registers:      18
[    0.032000] ... value mask:             000000ffffffffff
[    0.032000] ... max period:             0000007fffffffff
[    0.032000] ... fixed-purpose events:   0
[    0.032000] ... event mask:             000000000003ffff
[    0.032000] Hierarchical SRCU implementation.
[    0.032000] smp: Bringing up secondary CPUs ...
[    0.032000] CPU 1 irqstacks, hard=d3d437a4 soft=2597607a
[    0.032000] x86: Booting SMP configuration:
[    0.032000] .... node  #0, CPUs:      #1
[    0.004000] Initializing CPU#1
[    0.040809] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.004000] smpboot: CPU 1 Converting physical 3 to logical package 1
[    0.124183] CPU 2 irqstacks, hard=cf167a25 soft=771891a2
[    0.124498]  #2
[    0.004000] Initializing CPU#2
[    0.218021] CPU 3 irqstacks, hard=0c496f54 soft=594583fb
[    0.218021]  #3
[    0.004000] Initializing CPU#3
[    0.310017] smp: Brought up 1 node, 4 CPUs
[    0.310017] smpboot: Max logical packages: 2
[    0.310017] smpboot: Total of 4 processors activated (25481.78 BogoMIPS)
[    0.312885] devtmpfs: initialized
[    0.312885] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.312885] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.313081] NET: Registered protocol family 16
[    0.316021] audit: initializing netlink subsys (disabled)
[    0.316030] audit: type=2000 audit(1519581650.316:1): state=initialized audit_enabled=0 res=1
[    0.316352] cpuidle: using governor ladder
[    0.316495] cpuidle: using governor menu
[    0.316495] ACPI: bus type PCI registered
[    0.337013] PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=9
[    0.337137] PCI: Using configuration type 1 for base access
[    0.337268] PCI: HP ProLiant DL380 detected, enabling pci=bfsort.
[    0.340941] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.340941] ACPI: Added _OSI(Module Device)
[    0.340941] ACPI: Added _OSI(Processor Device)
[    0.340941] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.340941] ACPI: Added _OSI(Processor Aggregator Device)
[    0.344806] ACPI: Interpreter enabled
[    0.344935] ACPI: (supports S0 S5)
[    0.345053] ACPI: Using IOAPIC for interrupt routing
[    0.345233] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.356029] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00])
[    0.356029] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.356029] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.356029] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.356226] acpi PNP0A03:00: host bridge window expanded to [io  0x0000-0x28ff window]; [io  0x0000-0x28ff window] ignored
[    0.356438] acpi PNP0A03:00: host bridge window expanded to [io  0x0000-0x28ff window]; [io  0x03b0-0x03bb window] ignored
[    0.356662] acpi PNP0A03:00: host bridge window expanded to [io  0x0000-0x28ff window]; [io  0x03c0-0x03df window] ignored
[    0.356942] PCI host bridge to bus 0000:00
[    0.357066] pci_bus 0000:00: root bus resource [io  0x0000-0x28ff window]
[    0.360006] pci_bus 0000:00: root bus resource [mem 0xf5e00000-0xf6ffffff window]
[    0.360006] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.360006] pci_bus 0000:00: root bus resource [bus 00]
[    0.360006] pci 0000:00:00.0: [1166:0014] type 00 class 0x060000
[    0.360008] pci 0000:00:00.1: [1166:0014] type 00 class 0x060000
[    0.360037] pci 0000:00:00.2: [1166:0014] type 00 class 0x060000
[    0.360037] pci 0000:00:03.0: [1002:4752] type 00 class 0x030000
[    0.360037] pci 0000:00:03.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
[    0.360037] pci 0000:00:03.0: reg 0x14: [io  0x2400-0x24ff]
[    0.360037] pci 0000:00:03.0: reg 0x18: [mem 0xf5ff0000-0xf5ff0fff]
[    0.360037] pci 0000:00:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.360037] pci 0000:00:03.0: supports D1 D2
[    0.360037] pci 0000:00:04.0: [0e11:b203] type 00 class 0x088000
[    0.360037] pci 0000:00:04.0: reg 0x10: [io  0x1800-0x18ff]
[    0.360037] pci 0000:00:04.0: reg 0x14: [mem 0xf5fe0000-0xf5fe01ff]
[    0.360159] pci 0000:00:04.2: [0e11:b204] type 00 class 0x088000
[    0.360187] pci 0000:00:04.2: reg 0x10: [io  0x2800-0x28ff]
[    0.360199] pci 0000:00:04.2: reg 0x14: [mem 0xf5fd0000-0xf5fd07ff]
[    0.360211] pci 0000:00:04.2: reg 0x18: [mem 0xf5fc0000-0xf5fc1fff]
[    0.360223] pci 0000:00:04.2: reg 0x1c: [mem 0xf5f00000-0xf5f7ffff]
[    0.360253] pci 0000:00:04.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.360290] pci 0000:00:04.2: PME# supported from D0 D3hot D3cold
[    0.360392] pci 0000:00:0f.0: [1166:0201] type 00 class 0x060100
[    0.360550] pci 0000:00:0f.1: [1166:0212] type 00 class 0x01018a
[    0.360573] pci 0000:00:0f.1: reg 0x10: [io  0x01f0-0x01f7]
[    0.360583] pci 0000:00:0f.1: reg 0x14: [io  0x03f4-0x03f7]
[    0.360593] pci 0000:00:0f.1: reg 0x18: [io  0x0170-0x0177]
[    0.360603] pci 0000:00:0f.1: reg 0x1c: [io  0x0374-0x0377]
[    0.360612] pci 0000:00:0f.1: reg 0x20: [io  0x2000-0x200f]
[    0.360634] pci 0000:00:0f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.360732] pci 0000:00:0f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.360827] pci 0000:00:0f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.360922] pci 0000:00:0f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.361100] pci 0000:00:0f.2: [1166:0220] type 00 class 0x0c0310
[    0.361123] pci 0000:00:0f.2: reg 0x10: [mem 0xf5ef0000-0xf5ef0fff]
[    0.361258] pci 0000:00:0f.3: [1166:0225] type 00 class 0x060000
[    0.361392] pci 0000:00:10.0: [1166:0101] type 00 class 0x060000
[    0.361519] pci 0000:00:10.2: [1166:0101] type 00 class 0x060000
[    0.361655] pci 0000:00:11.0: [1166:0101] type 00 class 0x060000
[    0.361782] pci 0000:00:11.2: [1166:0101] type 00 class 0x060000
[    0.361925] pci_bus 0000:00: on NUMA node 0
[    0.364029] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 01])
[    0.364029] acpi PNP0A03:01: _OSC: OS supports [Segments MSI]
[    0.364029] acpi PNP0A03:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.364029] acpi PNP0A03:01: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.364029] PCI host bridge to bus 0000:01
[    0.364029] pci_bus 0000:01: root bus resource [io  0x3000-0x30ff window]
[    0.364029] pci_bus 0000:01: root bus resource [mem 0xf7b00000-0xf7cfffff window]
[    0.364029] pci_bus 0000:01: root bus resource [bus 01]
[    0.364029] pci 0000:01:03.0: [0e11:b178] type 00 class 0x010400
[    0.364029] pci 0000:01:03.0: reg 0x10: [mem 0xf7cc0000-0xf7cfffff 64bit]
[    0.364029] pci 0000:01:03.0: reg 0x18: [io  0x3000-0x30ff]
[    0.364029] pci 0000:01:03.0: reg 0x1c: [mem 0xf7bf0000-0xf7bf3fff 64bit pref]
[    0.364029] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x00003fff pref]
[    0.364029] pci 0000:01:03.0: supports D1
[    0.364029] pci_bus 0000:01: on NUMA node 0
[    0.364070] ACPI: PCI Root Bridge [PCI2] (domain 0000 [bus 02])
[    0.364171] acpi PNP0A03:02: _OSC: OS supports [Segments MSI]
[    0.364271] acpi PNP0A03:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.364369] acpi PNP0A03:02: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.364781] PCI host bridge to bus 0000:02
[    0.364881] pci_bus 0000:02: root bus resource [mem 0xf7d00000-0xf7dfffff window]
[    0.365041] pci_bus 0000:02: root bus resource [bus 02]
[    0.365149] pci 0000:02:01.0: [14e4:16a7] type 00 class 0x020000
[    0.365172] pci 0000:02:01.0: reg 0x10: [mem 0xf7df0000-0xf7dfffff 64bit]
[    0.365246] pci 0000:02:01.0: PME# supported from D3hot D3cold
[    0.365324] pci 0000:02:02.0: [14e4:16a7] type 00 class 0x020000
[    0.365349] pci 0000:02:02.0: reg 0x10: [mem 0xf7de0000-0xf7deffff 64bit]
[    0.365422] pci 0000:02:02.0: PME# supported from D3hot D3cold
[    0.365511] pci_bus 0000:02: on NUMA node 0
[    0.365702] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 03-05])
[    0.365803] acpi PNP0A03:03: _OSC: OS supports [Segments MSI]
[    0.365902] acpi PNP0A03:03: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.368009] acpi PNP0A03:03: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.368013] PCI host bridge to bus 0000:03
[    0.368032] pci_bus 0000:03: root bus resource [bus 03-05]
[    0.368032] pci_bus 0000:03: on NUMA node 0
[    0.368032] ACPI: PCI Root Bridge [PCI4] (domain 0000 [bus 06-ff])
[    0.368032] acpi PNP0A03:04: _OSC: OS supports [Segments MSI]
[    0.368032] acpi PNP0A03:04: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.368032] acpi PNP0A03:04: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.368036] PCI host bridge to bus 0000:06
[    0.368036] pci_bus 0000:06: root bus resource [io  0x4000-0x5fff window]
[    0.368036] pci_bus 0000:06: root bus resource [mem 0xf7e00000-0xf7ffffff window]
[    0.368036] pci_bus 0000:06: root bus resource [bus 06-ff]
[    0.368036] pci 0000:06:01.0: [12d8:01a7] type 01 class 0x060400
[    0.368154] pci 0000:06:02.0: [10b7:1700] type 00 class 0x020000
[    0.368176] pci 0000:06:02.0: reg 0x10: [mem 0xf7ef0000-0xf7ef3fff]
[    0.368186] pci 0000:06:02.0: reg 0x14: [io  0x4000-0x40ff]
[    0.368220] pci 0000:06:02.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.368251] pci 0000:06:02.0: supports D1 D2
[    0.368254] pci 0000:06:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.368353] pci 0000:06:1e.0: [0e11:a0f7] type 00 class 0x080400
[    0.368372] pci 0000:06:1e.0: reg 0x10: [mem 0xf7ee0000-0xf7ee0fff]
[    0.368567] pci 0000:07:04.0: [8086:10b5] type 00 class 0x020000
[    0.368599] pci 0000:07:04.0: reg 0x10: [mem 0xf7fe0000-0xf7ffffff 64bit]
[    0.368614] pci 0000:07:04.0: reg 0x18: [mem 0xf7f80000-0xf7fbffff 64bit]
[    0.368625] pci 0000:07:04.0: reg 0x20: [io  0x5000-0x503f]
[    0.368644] pci 0000:07:04.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.368690] pci 0000:07:04.0: PME# supported from D0 D3hot D3cold
[    0.368770] pci 0000:07:04.1: [8086:10b5] type 00 class 0x020000
[    0.368803] pci 0000:07:04.1: reg 0x10: [mem 0xf7f60000-0xf7f7ffff 64bit]
[    0.368830] pci 0000:07:04.1: reg 0x20: [io  0x5040-0x507f]
[    0.368893] pci 0000:07:04.1: PME# supported from D0 D3hot
[    0.368977] pci 0000:07:06.0: [8086:10b5] type 00 class 0x020000
[    0.369007] pci 0000:07:06.0: reg 0x10: [mem 0xf7f40000-0xf7f5ffff 64bit]
[    0.369034] pci 0000:07:06.0: reg 0x20: [io  0x5080-0x50bf]
[    0.369176] pci 0000:07:06.1: [8086:10b5] type 00 class 0x020000
[    0.369209] pci 0000:07:06.1: reg 0x10: [mem 0xf7f20000-0xf7f3ffff 64bit]
[    0.369236] pci 0000:07:06.1: reg 0x20: [io  0x50c0-0x50ff]
[    0.369396] pci 0000:06:01.0: PCI bridge to [bus 07]
[    0.369496] pci 0000:06:01.0:   bridge window [io  0x5000-0x5fff]
[    0.369500] pci 0000:06:01.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    0.369512] pci_bus 0000:06: on NUMA node 0
[    0.369648] ACPI: PCI Interrupt Link [IUSB] (IRQs 4 5 *7 10 11 15)
[    0.369897] ACPI: PCI Interrupt Link [IN16] (IRQs 4 5 7 10 11 15) *3
[    0.372030] ACPI: PCI Interrupt Link [IN17] (IRQs 4 *5 7 10 11 15)
[    0.372030] ACPI: PCI Interrupt Link [IN18] (IRQs 4 5 7 10 *11 15)
[    0.372030] ACPI: PCI Interrupt Link [IN19] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.372030] ACPI: PCI Interrupt Link [IN20] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.372030] ACPI: PCI Interrupt Link [IN21] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.372030] ACPI: PCI Interrupt Link [IN22] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.372030] ACPI: PCI Interrupt Link [IN23] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.372153] ACPI: PCI Interrupt Link [IN24] (IRQs 4 5 *7 10 11 15)
[    0.372403] ACPI: PCI Interrupt Link [IN25] (IRQs 4 *5 7 10 11 15)
[    0.372651] ACPI: PCI Interrupt Link [IN26] (IRQs 4 5 7 10 11 *15)
[    0.372899] ACPI: PCI Interrupt Link [IN27] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.373211] ACPI: PCI Interrupt Link [IN28] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.373524] ACPI: PCI Interrupt Link [IN29] (IRQs 4 5 7 10 *11 15)
[    0.373774] ACPI: PCI Interrupt Link [IN30] (IRQs 4 5 7 *10 11 15)
[    0.376005] ACPI: PCI Interrupt Link [IN31] (IRQs 4 5 7 10 11 *15)
[    0.376005] ACPI: PCI Interrupt Link [IN32] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.376005] ACPI: PCI Interrupt Link [IN33] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.376005] ACPI: PCI Interrupt Link [IN34] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.376064] pci 0000:00:03.0: vgaarb: setting as boot VGA device
[    0.376128] pci 0000:00:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.376304] pci 0000:00:03.0: vgaarb: bridge control possible
[    0.376399] vgaarb: loaded
[    0.376399] SCSI subsystem initialized
[    0.376399] PCI: Using ACPI for IRQ routing
[    0.376562] PCI: pci_cache_line_size set to 64 bytes
[    0.376630] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    0.376633] e820: reserve RAM buffer [mem 0xefffa000-0xefffffff]
[    0.376635] e820: reserve RAM buffer [mem 0x17ffff000-0x17fffffff]
[    0.376912] clocksource: Switched to clocksource tsc-early
[    0.376912] AppArmor: AppArmor Filesystem Enabled
[    0.376912] pnp: PnP ACPI init
[    0.376912] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    0.376912] system 00:00: [io  0x0408-0x040f] has been reserved
[    0.376936] system 00:00: [io  0x0900-0x0903] has been reserved
[    0.377039] system 00:00: [io  0x0910-0x0911] has been reserved
[    0.377136] system 00:00: [io  0x0920-0x0923] has been reserved
[    0.377231] system 00:00: [io  0x0930-0x0937] has been reserved
[    0.377327] system 00:00: [io  0x0940-0x0947] has been reserved
[    0.377422] system 00:00: [io  0x0950-0x0957] has been reserved
[    0.377518] system 00:00: [io  0x0c06-0x0c08] has been reserved
[    0.377613] system 00:00: [io  0x0c14] has been reserved
[    0.377706] system 00:00: [io  0x0c49-0x0c4a] has been reserved
[    0.377802] system 00:00: [io  0x0c50-0x0c52] has been reserved
[    0.377897] system 00:00: [io  0x0c6c-0x0c6f] has been reserved
[    0.377992] system 00:00: [io  0x0230-0x0233] has been reserved
[    0.378088] system 00:00: [io  0x0260-0x0267] has been reserved
[    0.378183] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.378279] system 00:00: [io  0x0700-0x070f] has been reserved
[    0.378374] system 00:00: [io  0x0800-0x081f] has been reserved
[    0.378470] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    0.378565] system 00:00: [io  0x0cd4-0x0cd7] has been reserved
[    0.378661] system 00:00: [io  0x0cf9] could not be reserved
[    0.378772] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.378848] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.378912] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    0.379197] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    0.379424] pnp 00:04: [dma 2]
[    0.379476] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.380427] pnp: PnP ACPI: found 5 devices
[    0.418759] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.418940] pci 0000:00:03.0: BAR 6: assigned [mem 0xf5e00000-0xf5e1ffff pref]
[    0.419108] pci 0000:00:04.2: BAR 6: assigned [mem 0xf5e20000-0xf5e2ffff pref]
[    0.419271] pci_bus 0000:00: resource 4 [io  0x0000-0x28ff window]
[    0.419274] pci_bus 0000:00: resource 5 [mem 0xf5e00000-0xf6ffffff window]
[    0.419276] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.419305] pci 0000:01:03.0: BAR 6: assigned [mem 0xf7b00000-0xf7b03fff pref]
[    0.419466] pci_bus 0000:01: resource 4 [io  0x3000-0x30ff window]
[    0.419469] pci_bus 0000:01: resource 5 [mem 0xf7b00000-0xf7cfffff window]
[    0.419476] pci_bus 0000:02: resource 4 [mem 0xf7d00000-0xf7dfffff window]
[    0.419495] pci 0000:06:02.0: BAR 6: assigned [mem 0xf7e00000-0xf7e1ffff pref]
[    0.419662] pci 0000:07:04.0: BAR 6: no space for [mem size 0x00040000 pref]
[    0.419760] pci 0000:07:04.0: BAR 6: failed to assign [mem size 0x00040000 pref]
[    0.419920] pci 0000:06:01.0: PCI bridge to [bus 07]
[    0.420014] pci 0000:06:01.0:   bridge window [io  0x5000-0x5fff]
[    0.420111] pci 0000:06:01.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    0.420214] pci_bus 0000:06: resource 4 [io  0x4000-0x5fff window]
[    0.420217] pci_bus 0000:06: resource 5 [mem 0xf7e00000-0xf7ffffff window]
[    0.420219] pci_bus 0000:07: resource 0 [io  0x5000-0x5fff]
[    0.420222] pci_bus 0000:07: resource 1 [mem 0xf7f00000-0xf7ffffff]
[    0.420269] NET: Registered protocol family 2
[    0.420592] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
[    0.420759] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.420877] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.421010] TCP: Hash tables configured (established 8192 bind 8192)
[    0.421165] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.421271] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.421437] NET: Registered protocol family 1
[    0.421559] pci 0000:00:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.421988] PCI Interrupt Link [IUSB] enabled at IRQ 11
[    0.503097] PCI: CLS 64 bytes, default 64
[    0.503210] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.503523] Scanning for low memory corruption every 60 seconds
[    0.504439] workingset: timestamp_bits=30 max_order=21 bucket_order=0
[    0.510803] bounce: pool size: 64 pages
[    0.510986] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.511158] io scheduler noop registered
[    0.511344] io scheduler cfq registered (default)
[    0.511707] Serial: 8250/16550 driver, 16 ports, IRQ sharing disabled
[    0.532227] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.533933] Non-volatile memory driver v1.3
[    0.534032] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    0.534364] HP HPSA Driver (v 3.4.20-125)
[    0.534468] hpsa 0000:01:03.0: legacy board ID: 0x40800e11
[    0.534593] hpsa 0000:01:03.0: legacy board ID: 0x40800e11
[    0.534596] Floppy drive(s): fd0 is 1.44M
[    0.534866] hpsa 0000:01:03.0: Controller reports max supported commands of 0 Using 16 instead. Ensure that firmware is up to date.
[    0.535053] hpsa 0000:01:03.0: Physical aborts not supported
[    0.535148] hpsa 0000:01:03.0: Logical aborts not supported
[    0.535241] hpsa 0000:01:03.0: HP SSD Smart Path aborts not supported
[    0.554503] FDC 0 is a National Semiconductor PC87306
[    0.555121] hpsa 0000:01:03.0: Controller reports max supported commands of 0 Using 16 instead. Ensure that firmware is up to date.
[    0.655189] scsi host0: hpsa
[    0.655486] hpsa can't handle SMP requests
[    0.655912] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    0.657863] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.657963] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.658208] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.658521] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    0.658649] rtc_cmos rtc_cmos: alarms up to one year, y3k, 114 bytes nvram
[    0.658807] hidraw: raw HID events driver (C) Jiri Kosina
[    0.659665] NET: Registered protocol family 10
[    0.660627] Segment Routing with IPv6
[    0.660748] NET: Registered protocol family 17
[    0.661308] microcode: sig=0xf25, pf=0x1, revision=0x29
[    0.661494] microcode: Microcode Update Driver: v2.2.
[    0.661503] Using IPI Shortcut mode
[    0.661696] sched_clock: Marking stable (661479191, 0)->(760056445, -98577254)
[    0.663646] registered taskstats version 1
[    0.663775] AppArmor: AppArmor sha1 policy hashing enabled
[    0.664190] console [netcon0] enabled
[    0.664282] netconsole: network logging started
[    0.664413] rtc_cmos rtc_cmos: setting system clock to 2018-02-25 18:00:51 UTC (1519581651)
[    0.664642] p4_clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
[    0.680831] hpsa 0000:01:03.0: C0:T0:L0 Volume status not available, assuming online.
[    0.695140] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.699303] hpsa 0000:01:03.0: C0:T0:L0 Volume status not available, assuming online.
[    0.699983] hpsa 0000:01:03.0: scsi 0:0:0:0: masked Direct-Access     SEAGATE  ST318436LC       PHYS DRV SSDSmartPathCap- En- Exp=0
[    0.700154] hpsa 0000:01:03.0: scsi 0:0:1:0: masked Direct-Access     SEAGATE  ST318436LC       PHYS DRV SSDSmartPathCap- En- Exp=0
[    0.700329] hpsa 0000:01:03.0: scsi 0:1:0:0: added Direct-Access     COMPAQ   LOGICAL VOLUME   RAID-1(+0) SSDSmartPathCap- En- Exp=1
[    0.700505] hpsa 0000:01:03.0: scsi 0:1:0:1: added Direct-Access     COMPAQ   LOGICAL VOLUME   RAID-1(+0) SSDSmartPathCap- En- Exp=1
[    0.700676] hpsa 0000:01:03.0: scsi 0:3:0:0: added RAID              COMPAQ   Smart Array 5i   controller SSDSmartPathCap- En- Exp=1
[    0.701162] scsi 0:1:0:0: Direct-Access     COMPAQ   LOGICAL VOLUME   2.76 PQ: 0 ANSI: 4
[    0.701746] scsi 0:1:0:1: Direct-Access     COMPAQ   LOGICAL VOLUME   2.76 PQ: 0 ANSI: 4
[    0.702420] scsi 0:3:0:0: RAID              COMPAQ   Smart Array 5i   2.76 PQ: 0 ANSI: 0
[    0.703156] sd 0:1:0:0: [sda] 71119755 512-byte logical blocks: (36.4 GB/33.9 GiB)
[    0.703558] sd 0:1:0:0: [sda] Write Protect is off
[    0.703566] sd 0:1:0:1: [sdb] 35871360 512-byte logical blocks: (18.4 GB/17.1 GiB)
[    0.703662] sd 0:1:0:0: [sda] Mode Sense: 5b 00 00 08
[    0.703849] sd 0:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    0.703931] sd 0:1:0:1: [sdb] Write Protect is off
[    0.704121] sd 0:1:0:1: [sdb] Mode Sense: 5b 00 00 08
[    0.704324] sd 0:1:0:1: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    0.719148]  sda: sda1 sda2 < sda5 >
[    0.720211] sd 0:1:0:0: [sda] Attached SCSI disk
[    0.725752]  sdb: sdb1 sdb2 < sdb5 >
[    0.726812] sd 0:1:0:1: [sdb] Attached SCSI disk
[    0.728125] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[    0.728656] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[    0.732529] EXT4-fs (sda1): INFO: recovery required on readonly filesystem
[    0.732625] EXT4-fs (sda1): write access will be enabled during recovery
[    0.760402] EXT4-fs (sda1): recovery complete
[    0.760783] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    0.760960] VFS: Mounted root (ext4 filesystem) readonly on device 259:262144.
[    0.769073] devtmpfs: mounted
[    0.769626] Freeing unused kernel memory: 572K
[    0.769812] Write protecting the kernel text: 7604k
[    0.769985] Write protecting the kernel read-only data: 1288k
[    1.536033] tsc: Refined TSC clocksource calibration: 3184.955 MHz
[    1.536147] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2de8c57900c, max_idle_ns: 440795212290 ns
[    1.536365] clocksource: Switched to clocksource tsc
[    2.295655] hpwdt 0000:00:04.0: This server does not have an iLO2+ ASIC.
[    2.339145] Linux agpgart interface v0.103
[    2.343523] ACPI: bus type USB registered
[    2.343798] usbcore: registered new interface driver usbfs
[    2.343954] usbcore: registered new interface driver hub
[    2.344155] usbcore: registered new device driver usb
[    2.347022] piix4_smbus 0000:00:0f.0: SMBus Host Controller at 0x700, revision 0
[    2.352706] libata version 3.00 loaded.
[    2.354268] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    2.354460] ACPI: Power Button [PWRF]
[    2.359316] scsi host1: pata_serverworks
[    2.359722] scsi host2: pata_serverworks
[    2.359961] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x2000 irq 14
[    2.360118] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x2008 irq 15
[    2.367092] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.369180] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.374223] ehci-pci: EHCI PCI platform driver
[    2.393940] ohci-pci: OHCI PCI platform driver
[    2.394244] ohci-pci 0000:00:0f.2: OHCI PCI host controller
[    2.394348] ohci-pci 0000:00:0f.2: new USB bus registered, assigned bus number 1
[    2.394565] ohci-pci 0000:00:0f.2: irq 11, io mem 0xf5ef0000
[    2.432997] sd 0:1:0:0: Attached scsi generic sg0 type 0
[    2.433175] sd 0:1:0:1: Attached scsi generic sg1 type 0
[    2.433341] scsi 0:3:0:0: Attached scsi generic sg2 type 12
[    2.452467] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    2.454213] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    2.454350] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.454580] usb usb1: Product: OHCI PCI host controller
[    2.454708] usb usb1: Manufacturer: Linux 4.16.0-rc2-00374-g3664ce2d9309 ohci_hcd
[    2.454933] usb usb1: SerialNumber: 0000:00:0f.2
[    2.455470] hub 1-0:1.0: USB hub found
[    2.455623] hub 1-0:1.0: 4 ports detected
[    2.542949] skge: 1.14 addr 0xf7ef0000 irq 18 chip Yukon rev 1
[    2.543398] skge 0000:06:02.0 eth0: addr 00:0a:5e:54:2d:1e
[    2.606517] tg3.c:v3.137 (May 11, 2014)
[    2.642654] ata1.00: ATAPI: COMPAQ  CD-ROM SN-124, N104, max PIO4
[    2.644446] tg3 0000:02:01.0 eth1: Tigon3 [partno(NA) rev 1002] (PCIX:100MHz:64-bit) MAC address 00:0b:cd:ef:fd:b3
[    2.644622] tg3 0000:02:01.0 eth1: attached PHY is 5703 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    2.644798] tg3 0000:02:01.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.644968] tg3 0000:02:01.0 eth1: dma_rwctrl[769c4000] dma_mask[64-bit]
[    2.647540] ata1.00: configured for PIO4
[    2.648290] scsi 1:0:0:0: CD-ROM            COMPAQ   CD-ROM SN-124    N104 PQ: 0 ANSI: 5
[    2.653324] skge 0000:06:02.0 enp6s2: renamed from eth0
[    2.686986] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    2.687120] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.691852] tg3 0000:02:02.0 eth0: Tigon3 [partno(NA) rev 1002] (PCIX:100MHz:64-bit) MAC address 00:0b:cd:ef:fd:b2
[    2.692108] tg3 0000:02:02.0 eth0: attached PHY is 5703 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    2.692325] tg3 0000:02:02.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.692538] tg3 0000:02:02.0 eth0: dma_rwctrl[769c4000] dma_mask[64-bit]
[    2.696274] tg3 0000:02:01.0 rename3: renamed from eth1
[    2.724318] tg3 0000:02:02.0 rename4: renamed from eth0
[    2.932773] tg3 0000:02:01.0 eth0: renamed from rename3
[    2.984310] tg3 0000:02:02.0 eth1: renamed from rename4
[    3.017275] e1000 0000:07:04.0 eth2: (PCI-X:133MHz:64-bit) 00:13:21:78:d3:bc
[    3.017403] e1000 0000:07:04.0 eth2: Intel(R) PRO/1000 Network Connection
[    3.345677] e1000 0000:07:04.1 eth3: (PCI-X:133MHz:64-bit) 00:13:21:78:d3:bd
[    3.345784] e1000 0000:07:04.1 eth3: Intel(R) PRO/1000 Network Connection
[    3.669603] e1000 0000:07:06.0 eth4: (PCI-X:133MHz:64-bit) 00:13:21:78:d3:be
[    3.669703] e1000 0000:07:06.0 eth4: Intel(R) PRO/1000 Network Connection
[    3.993602] e1000 0000:07:06.1 eth5: (PCI-X:133MHz:64-bit) 00:13:21:78:d3:bf
[    3.993702] e1000 0000:07:06.1 eth5: Intel(R) PRO/1000 Network Connection
[    4.011232] e1000 0000:07:06.0 enp7s6f0: renamed from eth4
[    4.132251] e1000 0000:07:06.1 enp7s6f1: renamed from eth5
[    4.208615] e1000 0000:07:04.1 enp7s4f1: renamed from eth3
[    4.276577] e1000 0000:07:04.0 enp7s4f0: renamed from eth2
[  122.811059] Adding 1489916k swap on /dev/sda5.  Priority:-2 extents:1 across:1489916k 
[  122.869375] EXT4-fs (sda1): re-mounted. Opts: (null)
[  122.983753] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[  123.273076] loop: module loaded
[  123.852767] audit: type=1400 audit(1519581774.840:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1528 comm="apparmor_parser"
[  123.853029] audit: type=1400 audit(1519581774.840:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man//filter" pid=1528 comm="apparmor_parser"
[  123.853300] audit: type=1400 audit(1519581774.840:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man//groff" pid=1528 comm="apparmor_parser"
[  242.652061] INFO: task kworker/u8:4:613 blocked for more than 120 seconds.
[  242.652230]       Not tainted 4.16.0-rc2-00374-g3664ce2d9309 #36
[  242.654171] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.654386] kworker/u8:4    D    0   613      2 0x80000000
[  242.654517] Workqueue: events_unbound async_run_entry_fn
[  242.654637] Call Trace:
[  242.654759]  __schedule+0x1bc/0x8d3
[  242.654877]  ? set_next_entity+0xc1/0x39a
[  242.654994]  schedule+0x28/0xb2
[  242.655096]  async_synchronize_cookie_domain+0xac/0xf4
[  242.655217]  ? __clear_rsb+0x1d/0x32
[  242.655334]  ? wait_woken+0xb7/0xb7
[  242.655449]  async_synchronize_cookie+0xd/0x15
[  242.655583]  async_port_probe+0x57/0x87 [libata]
[  242.655703]  ? __clear_rsb+0xd/0x32
[  242.655825]  ? ata_port_probe+0x52/0x52 [libata]
[  242.655945]  async_run_entry_fn+0x49/0x1f2
[  242.656075]  process_one_work+0x20a/0x568
[  242.656191]  worker_thread+0x4c/0x631
[  242.656312]  kthread+0x140/0x1e4
[  242.656428]  ? process_one_work+0x568/0x568
[  242.656547]  ? kthread_create_on_node+0x23/0x23
[  242.656667]  ret_from_fork+0x2e/0x38
[  242.656793] INFO: task systemd-udevd:803 blocked for more than 120 seconds.
[  242.656920]       Not tainted 4.16.0-rc2-00374-g3664ce2d9309 #36
[  242.657039] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.657257] systemd-udevd   D    0   803    758 0x80000004
[  242.657379] Call Trace:
[  242.657495]  __schedule+0x1bc/0x8d3
[  242.657614]  ? kfree_skbmem+0x65/0x85
[  242.657730]  schedule+0x28/0xb2
[  242.657846]  async_synchronize_cookie_domain+0xac/0xf4
[  242.657968]  ? wait_woken+0xb7/0xb7
[  242.658082]  async_synchronize_full+0x14/0x16
[  242.658206]  do_init_module+0x10f/0x24b
[  242.658323]  load_module+0x29c9/0x3865
[  242.658443]  ? kernel_read+0x50/0xa7
[  242.658558]  SyS_finit_module+0x78/0x8d
[  242.658681]  do_fast_syscall_32+0xc7/0x323
[  242.658800]  entry_SYSENTER_32+0x4e/0x7c
[  242.658916] EIP: 0xb7f0cad5
[  242.659030] EFLAGS: 00000292 CPU: 0
[  242.659145] EAX: ffffffda EBX: 0000000d ECX: b7d03bdd EDX: 00000000
[  242.659265] ESI: 011ba740 EDI: 011bdb50 EBP: 00000000 ESP: bfcf1bcc
[  242.659388]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  244.422337] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[  246.012767] tg3 0000:02:01.0 eth0: Link is up at 100 Mbps, full duplex
[  246.012875] tg3 0000:02:01.0 eth0: Flow control is off for TX and off for RX
[  246.012990] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  316.432903] scsi 1:0:0:0: Attached scsi generic sg3 type 5
[  316.667528] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[  316.667571] cdrom: Uniform CD-ROM driver Revision: 3.20
[  316.667837] sr 1:0:0:0: Attached scsi CD-ROM sr0
[ 4097.814125] random: crng init done

-- 
Meelis Roos (mroos@linux.ee)
