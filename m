Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2636BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C151C224E6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C151C224E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeGDPQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:16:23 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:57296 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeGDPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:14:03 -0400
Received: by mail-it0-f72.google.com with SMTP id g4-v6so4753341itf.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ng0rxbL9jwUvOWGW/sd3ClzedPwYix1tEA8bTO2Gf3o=;
        b=NY2uZXYvpsQnNPYo1MXPJ0UKV3IzAcw24YSb1w/ME3GqDV65Pi12jKA0115hyroANS
         7n5l6tNB+ULQZ7vIShM3oOnmPRAcMSo5JhhF00pU3wLRWM2a8h/z05WWV1eUZl7eGBKZ
         qNKsIiTuvn5vS3ErYijRasFw5VT+WKJoHTEYfysHqx35XqUWMh7hyMtZs+BRRTH6jSxA
         d2PXEy5MwYAbw7FzOPEr0gSBiT9bxkJ3ip3wq5xLq9kxbiC1SG1JneElOkXeyqDVFa7N
         y9yRa+P+7SRUN2fjj6u3UCgSBcFcvDKRei5LYM64dyGEJw1hNwjVequtrt+6KCDmucUt
         TEYw==
X-Gm-Message-State: APt69E39CCVYvLl66EiZUfWOxI15pLDT6TY5jR0pKlfsfjtx2r6lRqAe
        j6UJYOOTtypnDtHwZDZMiZMRJ6r4/QYquktDoIbZtTpucrWI
X-Google-Smtp-Source: AAOMgpe+AahPcCbN65PoJ77btAfH32sQNNfZ/gwWf1DcHJayz1e9ysW1QS4CLUDjcATImqwrh2X36JlNtB3C8K42a6YKiKpzkfE+
MIME-Version: 1.0
X-Received: by 2002:a24:6b8f:: with SMTP id v137-v6mr1031084itc.2.1530717242517;
 Wed, 04 Jul 2018 08:14:02 -0700 (PDT)
Date:   Wed, 04 Jul 2018 08:14:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dfbf005702de11c@google.com>
Subject: KASAN: stack-out-of-bounds Read in __hrtimer_run_queues
From:   syzbot <syzbot+1fe433a61ed065e1848a@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=155b32d0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
dashboard link: https://syzkaller.appspot.com/bug?extid=1fe433a61ed065e1848a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1fe433a61ed065e1848a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in __hrtimer_run_queues+0xf78/0x10c0  
kernel/time/hrtimer.c:1457
Read of size 8 at addr ffff8801a9757d00 by task syz-executor7/16190

CPU: 0 PID: 16190 Comm: syz-executor7 Not tainted 4.18.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __hrtimer_run_queues+0xf78/0x10c0 kernel/time/hrtimer.c:1457
Linux version 4.18.0-rc3+ (syzkaller@ci) (gcc version 8.0.1 20180413  
(experimental) (GCC)) #45 SMP Wed Jul 4 07:02:20 UTC 2018
Command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0  
earlyprintk=serial vsyscall=native rodata=n ftrace_dump_on_oops=orig_cpu  
oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400  
kvm-intel.nested=1 nf-conntrack-ftp.ports=20000  
nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000  
nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 nopcid
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes,  
using 'standard' format.
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000bfff2fff] usable
BIOS-e820: [mem 0x00000000bfff3000-0x00000000bfffffff] reserved
BIOS-e820: [mem 0x00000000fffbc000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000021fffffff] usable
bootconsole [earlyser0] enabled
Malformed early option 'vsyscall'
nopcid: PCID feature disabled
NX (Execute Disable) protection: active
SMBIOS 2.4 present.
DMI: Google Google Compute Engine/Google Compute Engine, BIOS Google  
01/01/2011
Hypervisor detected: KVM
last_pfn = 0x220000 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
last_pfn = 0xbfff3 max_arch_pfn = 0x400000000
found SMP MP-table at [mem 0x000f2310-0x000f231f] mapped at  
[(____ptrval____)]
Scanning 1 areas for low memory corruption
Using GB pages for direct mapping
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F22D0 000014 (v00 Google)
ACPI: RSDT 0x00000000BFFF3430 000038 (v01 Google GOOGRSDT 00000001 GOOG  
00000001)
ACPI: FACP 0x00000000BFFFCF60 0000F4 (v02 Google GOOGFACP 00000001 GOOG  
00000001)
ACPI: DSDT 0x00000000BFFF3470 0017B2 (v01 Google GOOGDSDT 00000001 GOOG  
00000001)
ACPI: FACS 0x00000000BFFFCF00 000040
ACPI: FACS 0x00000000BFFFCF00 000040
ACPI: SSDT 0x00000000BFFF65F0 00690D (v01 Google GOOGSSDT 00000001 GOOG  
00000001)
ACPI: APIC 0x00000000BFFF5D10 000076 (v01 Google GOOGAPIC 00000001 GOOG  
00000001)
ACPI: WAET 0x00000000BFFF5CE0 000028 (v01 Google GOOGWAET 00000001 GOOG  
00000001)
ACPI: SRAT 0x00000000BFFF4C30 0000C8 (v01 Google GOOGSRAT 00000001 GOOG  
00000001)
SRAT: PXM 0 -> APIC 0x00 -> Node 0
SRAT: PXM 0 -> APIC 0x01 -> Node 0
ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x21fffffff]
NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] ->  
[mem 0x00000000-0xbfffffff]
NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x21fffffff] ->  
[mem 0x00000000-0x21fffffff]
NODE_DATA(0) allocated [mem 0x21fffa000-0x21fffdfff]
kvm-clock: cpu 0, msr 2:1fff8001, primary cpu clock
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: using sched offset of 4633492886 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb,  
max_idle_ns: 881590591483 ns
Zone ranges:
   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
   Normal   [mem 0x0000000100000000-0x000000021fffffff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000000001000-0x000000000009efff]
   node   0: [mem 0x0000000000100000-0x00000000bfff2fff]
   node   0: [mem 0x0000000100000000-0x000000021fffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000021fffffff]
Reserved but unavailable: 111 pages
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0xb008
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Using ACPI (MADT) for SMP configuration information
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
PM: Registered nosave memory: [mem 0xbfff3000-0xbfffffff]
PM: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
PM: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[mem 0xc0000000-0xfffbbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff,  
max_idle_ns: 1910969940391419 ns
random: get_random_bytes called from boot_init_stack_canary  
arch/x86/include/asm/stackprotector.h:75 [inline] with crng_init=0
random: get_random_bytes called from start_kernel+0x112/0x949  
init/main.c:559 with crng_init=0
setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
percpu: Embedded 56 pages/cpu @(____ptrval____) s188616 r8192 d32568  
u1048576
Built 1 zonelists, mobility grouping on.  Total pages: 1935228
Policy zone: Normal
Kernel command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0  
earlyprintk=serial vsyscall=native rodata=n ftrace_dump_on_oops=orig_cpu  
oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400  
kvm-intel.nested=1 nf-conntrack-ftp.ports=20000  
nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000  
nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 nopcid
Memory: 6499788K/7863876K available (110620K kernel code, 12321K rwdata,  
16056K rodata, 3968K init, 23144K bss, 1364088K reserved, 0K cma-reserved)
Running RCU self tests
Hierarchical RCU implementation.
	RCU lockdep checking is enabled.
	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
	RCU callback double-/use-after-free debug enabled.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
Console: colour VGA+ 80x25
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [earlyser0] disabled
bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
  memory used by lock dependency info: 7391 kB
  per task-struct memory footprint: 1920 bytes
ACPI: Core revision 20180531
APIC: Switch to symmetric I/O mode setup
x2apic enabled
Switched APIC routing to physical x2apic.
..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
tsc: Detected 2300.000 MHz processor
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212735223b2,  
max_idle_ns: 440795277976 ns
Calibrating delay loop (skipped) preset value.. 4600.00 BogoMIPS  
(lpj=2300000)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Yama: becoming mindful.
SELinux:  Initializing.
AppArmor: AppArmor disabled by boot time parameter
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Physical Processor ID: 0
mce: CPU supports 32 MCE banks
Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
Spectre V2 : Mitigation: Full generic retpoline
Speculative Store Bypass: Vulnerable
Freeing SMP alternatives memory: 64K
smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f,  
stepping: 0x0)
Performance Events: unsupported p6 CPU model 63 no PMU driver, software  
events only.
Hierarchical SRCU implementation.
NMI watchdog: Perf event create on CPU 0 failed with -2
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
kvm-clock: cpu 1, msr 2:1fff8041, secondary cpu clock
smp: Brought up 1 node, 2 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 2 processors activated (9200.00 BogoMIPS)
devtmpfs: initialized
kworker/u4:0 (24) used greatest stack depth: 24072 bytes left
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:  
1911260446275000 ns
futex hash table entries: 512 (order: 4, 65536 bytes)
xor: automatically using best checksumming function   avx
RTC time: 12:14:59, date: 07/04/18
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1530706499.296:1): state=initialized audit_enabled=0  
res=1
cpuidle: using governor menu
kworker/u4:1 (38) used greatest stack depth: 23840 bytes left
ACPI: bus type PCI registered
PCI: Using configuration type 1 for base access
kworker/u4:3 (214) used greatest stack depth: 22816 bytes left
kworker/u4:3 (319) used greatest stack depth: 21704 bytes left
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
cryptd: max_cpu_qlen set to 1000
raid6: sse2x1   gen()  1859 MB/s
raid6: sse2x1   xor()  1013 MB/s
raid6: sse2x2   gen()  3746 MB/s
raid6: sse2x2   xor()  1914 MB/s
raid6: sse2x4   gen()  5972 MB/s
raid6: sse2x4   xor()  3417 MB/s
raid6: avx2x1   gen()  2042 MB/s
raid6: avx2x1   xor()  1896 MB/s
raid6: avx2x2   gen()  5832 MB/s
raid6: avx2x2   xor()  3832 MB/s
raid6: avx2x4   gen() 11617 MB/s
raid6: avx2x4   xor()  6251 MB/s
raid6: using algorithm avx2x4 gen() 11617 MB/s
raid6: .... xor() 6251 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: 2 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and  
report a bug
ACPI: Enabled 16 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended  
PCI configuration space under this bridge.
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
vgaarb: loaded
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti  
<giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
PCI: Using ACPI for IRQ routing
Bluetooth: Core ver 2.22
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
NET: Registered protocol family 8
NET: Registered protocol family 20
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
nfc: nfc_init: NFC Core ver 0.1
NET: Registered protocol family 39
clocksource: Switched to clocksource kvm-clock
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
FS-Cache: Loaded
CacheFiles: Loaded
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns:  
2085701024 ns
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
UDP hash table entries: 4096 (order: 7, 655360 bytes)
UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NET: Registered protocol family 44
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB [mem 0xbbff3000-0xbfff3000] (64MB) mapped at  
[(____ptrval____)-(____ptrval____)]
RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 10737418240 ms ovfl  
timer
RAPL PMU: hw unit of domain pp0-core 2^-0 Joules
RAPL PMU: hw unit of domain package 2^-0 Joules
RAPL PMU: hw unit of domain dram 2^-16 Joules
VPID CAP should not exist if not support 1-setting enable VPID VM-execution  
control
kvm: already loaded the other module
Machine check injector initialized
Scanning for low memory corruption every 60 seconds
Initialise system trusted keyrings
workingset: timestamp_bits=40 max_order=21 bucket_order=0
DLM installed
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ntfs: driver 2.1.32 [Flags: R/W].
fuse init (API version 7.27)
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, realtime, no debug enabled
9p: Installing v9fs 9p2000 file system support
FS-Cache: Netfs '9p' registered for caching
gfs2: GFS2 installed
FS-Cache: Netfs 'ceph' registered for caching
ceph: loaded (mds proto 32)
NET: Registered protocol family 38
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Key type pkcs7_test registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: Sleep Button [SLPF]
PCI Interrupt Link [LNKC] enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
PCI Interrupt Link [LNKD] enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] radeon kernel modesetting enabled.
[drm] amdgpu kernel modesetting enabled.
brd: module loaded
loop: module loaded


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
