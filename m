Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeD2CM7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 22:12:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:52659 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeD2CMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 22:12:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,341,1520924400";
   d="scan'208";a="45376594"
Date: Sun, 29 Apr 2018 10:12:35 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: netdev <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linzhang <xiaolou4617@gmail.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: [llc_ui_release] BUG: unable to handle kernel NULL pointer
 dereference at 0000000000000004
Message-ID: <20180429021235.vibzosv34t264nbs@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="chst6szrdxt2yire"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--chst6szrdxt2yire
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

FYI this happens in mainline kernel 4.17.0-rc2.
It looks like a new regression.

It occurs in 5 out of 5 boots.

[main] 375 sockets created based on info from socket cachefile.
[main] Generating file descriptors
[main] Added 83 filenames from /dev
udevd[507]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:regulatory': No such file or directory
[  372.057947] caif:caif_disconnect_client(): nothing to disconnect
[  372.082415] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
[  372.083866] PGD 16e5b067 P4D 16e5b067 PUD 16cce067 PMD 0
[  372.085033] Oops: 0000 [#1] SMP
[  372.085654] CPU: 1 PID: 494 Comm: trinity-main Not tainted 4.17.0-rc2 #171
[  372.086910] RIP: 0010:refcount_inc_not_zero+0x25/0x2f0:
						__read_once_size at include/linux/compiler.h:188
						 (inlined by) arch_atomic_read at arch/x86/include/asm/atomic.h:31
						 (inlined by) atomic_read at include/asm-generic/atomic-instrumented.h:22
						 (inlined by) refcount_inc_not_zero at lib/refcount.c:120
[  372.087918] RSP: 0018:ffff880016fb7d08 EFLAGS: 00010206
[  372.089279] RAX: ffff880016bd5f00 RBX: 0000000000000004 RCX: ffffffff818317ed
[  372.090142] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
[  372.091443] RBP: ffff880016f46878 R08: 0000000000000002 R09: 0000000000000000
[  372.093103] R10: 0000000001a0ae15 R11: 0000000011e52352 R12: 0000000000000004
[  372.094480] R13: 0000000000000000 R14: ffffffff84655070 R15: ffff88001f2f93c0
[  372.095848] FS:  00007fc0f65dc700(0000) GS:ffff88001d600000(0000) knlGS:0000000000000000
[  372.097643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  372.098736] CR2: 0000000000000004 CR3: 0000000016e5a000 CR4: 00000000000006a0
[  372.099978] DR0: 0000000000693000 DR1: 0000000000000000 DR2: 0000000000000000
[  372.101483] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  372.102856] Call Trace:
[  372.103434]  refcount_inc+0x19/0x190:
						refcount_inc at lib/refcount.c:153
[  372.104200]  llc_ui_release+0xf5/0x270:
						constant_test_bit at arch/x86/include/asm/bitops.h:328
						 (inlined by) sock_flag at include/net/sock.h:802
						 (inlined by) llc_ui_release at net/llc/af_llc.c:208
[  372.105122]  sock_release+0x56/0x120:
						sock_release at net/socket.c:594
[  372.105773]  ? sock_release+0x120/0x120:
						sock_close at net/socket.c:1148
[  372.106490]  sock_close+0x1f/0x30:
						sock_close at net/socket.c:1151
[  372.107176]  __fput+0x2e9/0x620:
						__fput at fs/file_table.c:209
[  372.107858]  ____fput+0x1e/0x30:
						____fput at fs/file_table.c:243
[  372.108526]  task_work_run+0x11a/0x180:
						task_work_run at kernel/task_work.c:115 (discriminator 1)
[  372.109491]  do_exit+0xda4/0x2210:
						do_exit at kernel/exit.c:866
[  372.110171]  ? __do_page_fault+0xffe/0x1150:
						__do_page_fault at arch/x86/mm/fault.c:1444 (discriminator 1)
[  372.110677]  do_group_exit+0x1ce/0x1f0:
						do_group_exit at kernel/exit.c:957
[  372.111130]  __do_sys_exit_group+0x1b/0x20:
						__do_sys_exit_group at kernel/exit.c:979
[  372.111878]  __x64_sys_exit_group+0x1f/0x20:
						__x64_sys_exit_group at kernel/exit.c:977
[  372.112655]  do_syscall_64+0x3c8/0x940:
						do_syscall_64 at arch/x86/entry/common.c:287
[  372.113612]  entry_SYSCALL_64_after_hwframe+0x49/0xbe:
						entry_SYSCALL_64_after_hwframe at arch/x86/entry/entry_64.S:240
[  372.114638] RIP: 0033:0x7fc0f60c1408
[  372.115389] RSP: 002b:00007fff057791b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[  372.117042] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc0f60c1408
[  372.118462] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[  372.119892] RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffffa0
[  372.121479] R10: 00007fff05778f50 R11: 0000000000000206 R12: 0000000000000005
[  372.122831] R13: 00007fff057793a0 R14: 0000000000000000 R15: 0000000000000000
[  372.124211] Code: 84 00 00 00 00 00 41 57 41 56 49 c7 c6 70 50 65 84 41 55 41 54 49 89 fc 55 53 48 83 ec 08 e8 a3 53 a4 ff 48 83 05 4b 01 9d 04 01 <45> 8b 2c 24 e8 92 53 a4 ff 31 c0 45 85 ed 41 8d 6d 01 0f 94 c0
[  372.129128] RIP: refcount_inc_not_zero+0x25/0x2f0:
						__read_once_size at include/linux/compiler.h:188
						 (inlined by) arch_atomic_read at arch/x86/include/asm/atomic.h:31
						 (inlined by) atomic_read at include/asm-generic/atomic-instrumented.h:22
						 (inlined by) refcount_inc_not_zero at lib/refcount.c:120 RSP: ffff880016fb7d08
[  372.130205] CR2: 0000000000000004
[  372.130604] ---[ end trace a6d858cc768df5f2 ]---
[  372.131122] Kernel panic - not syncing: Fatal exception

Attached the full dmesg, kconfig and reproduce scripts.

Thanks,
Fengguang

--chst6szrdxt2yire
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-quantal-ivb41-78:20180425191426:x86_64-randconfig-s3-04251452:4.17.0-rc2:171"

early console in setup code
[    0.000000] Linux version 4.17.0-rc2 (kbuild@lkp-hsx03) (gcc version 7.3.0 (Debian 7.3.0-16)) #171 SMP Wed Apr 25 14:55:04 CST 2018
[    0.000000] Command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw link=/kbuild-tests/run-queue/kvm/x86_64-randconfig-s3-04251452/linux-devel:devel-hourly-2018042507:6d08b06e67cd117f6992c46611dfb4ce267cd71e/.vmlinuz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-20180425153748-21:quantal-ivb41-78 branch=linux-devel/devel-hourly-2018042507 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-04251452/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2 drbd.minor_count=8 rcuperf.shutdown=0
[    0.000000] KERNEL supported cpus:
[    0.000000]   Centaur CentaurHauls
[    0.000000] CPU: vendor_id 'GenuineIntel' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffd1fff] usable
[    0.000000] BIOS-e820: [mem 0x000000001ffd2000-0x000000001fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1ffd2 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f6a50-0x000f6a5f] mapped at [        (ptrval)]
[    0.000000]   mpc: f6a60-f6b7c
[    0.000000] Base memory trampoline at [        (ptrval)] 99000 size 24576
[    0.000000] BRK [0x069ac000, 0x069acfff] PGTABLE
[    0.000000] BRK [0x069ad000, 0x069adfff] PGTABLE
[    0.000000] BRK [0x069ae000, 0x069aefff] PGTABLE
[    0.000000] BRK [0x069af000, 0x069affff] PGTABLE
[    0.000000] RAMDISK: [mem 0x1e91d000-0x1ffcffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6840 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000001FFE1628 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000001FFE147C 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000001FFE0040 00143C (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000001FFE0000 000040
[    0.000000] ACPI: APIC 0x000000001FFE1570 000080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000001FFE15F0 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001ffd1fff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1e918000-0x1e91cfff]
[    0.000000] cma: dma_contiguous_reserve(limit 1ffd2000)
[    0.000000] kvm-clock: cpu 0, msr 0:1ffd0001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 3565075264 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000001000-0x000000001ffd1fff]
[    0.000000]   Normal   empty
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffd1fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffd1fff]
[    0.000000] On node 0 totalpages: 130928
[    0.000000]   DMA32 zone: 2048 pages used for memmap
[    0.000000]   DMA32 zone: 21 pages reserved
[    0.000000]   DMA32 zone: 130928 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.000000] e820: [mem 0x20000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] random: get_random_bytes called from start_kernel+0xdf/0xad4 with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] percpu: Embedded 483 pages/cpu @        (ptrval) s1947992 r0 d30376 u2097152
[    0.000000] pcpu-alloc: s1947992 r0 d30376 u2097152 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1d4105c0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128859
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw link=/kbuild-tests/run-queue/kvm/x86_64-randconfig-s3-04251452/linux-devel:devel-hourly-2018042507:6d08b06e67cd117f6992c46611dfb4ce267cd71e/.vmlinuz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-20180425153748-21:quantal-ivb41-78 branch=linux-devel/devel-hourly-2018042507 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-04251452/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2 drbd.minor_count=8 rcuperf.shutdown=0
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] Memory: 396376K/523712K available (30732K kernel code, 15433K rwdata, 11752K rodata, 3984K init, 21516K bss, 127336K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] ftrace: allocating 48009 entries in 188 pages
[    0.003333] Hierarchical RCU implementation.
[    0.003333] 	RCU event tracing is enabled.
[    0.003333] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.003333] 	RCU debug extended QS entry/exit.
[    0.003333] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
[    0.003333] 	Tasks RCU enabled.
[    0.003333] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.003333] NR_IRQS: 4352, nr_irqs: 56, preallocated irqs: 16
[    0.003333] console [ttyS0] enabled
[    0.003333] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.003333] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.003333] ... MAX_LOCK_DEPTH:          48
[    0.003333] ... MAX_LOCKDEP_KEYS:        8191
[    0.003333] ... CLASSHASH_SIZE:          4096
[    0.003333] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.003333] ... MAX_LOCKDEP_CHAINS:      65536
[    0.003333] ... CHAINHASH_SIZE:          32768
[    0.003333]  memory used by lock dependency info: 7871 kB
[    0.003333]  per task-struct memory footprint: 2688 bytes
[    0.003333] ACPI: Core revision 20180313
[    0.003333] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.003333] hpet clockevent registered
[    0.003373] APIC: Switch to symmetric I/O mode setup
[    0.004332] enabled ExtINT on CPU#0
[    0.007142] ENABLING IO-APIC IRQs
[    0.007819] init IO_APIC IRQs
[    0.008404]  apic 0 pin 0 not connected
[    0.009193] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
[    0.010070] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
[    0.011525] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
[    0.013101] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
[    0.013333]  apic 0 pin 16 not connected
[    0.013333]  apic 0 pin 17 not connected
[    0.013333]  apic 0 pin 18 not connected
[    0.013333]  apic 0 pin 19 not connected
[    0.013333]  apic 0 pin 20 not connected
[    0.013333]  apic 0 pin 21 not connected
[    0.013333]  apic 0 pin 22 not connected
[    0.013333]  apic 0 pin 23 not connected
[    0.013333] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.013333] tsc: Detected 2693.508 MHz processor
[    0.013333] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.013333] Calibrating delay loop (skipped) preset value.. 5389.47 BogoMIPS (lpj=8978360)
[    0.013362] pid_max: default: 32768 minimum: 301
[    0.016934] Security Framework initialized
[    0.019190] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.020237] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.023432] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.025344] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.028142] numa_add_cpu cpu 0 node 0: mask now 0
[    0.030019] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.031547] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.033402] Spectre V2 : Mitigation: Full generic retpoline
[    0.034994] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.037402] Freeing SMP alternatives memory: 28K
[    0.041481] Using local APIC timer interrupts.
[    0.041481] calibrating APIC timer ...
[    0.046666] ... lapic delta = 6248872
[    0.046666] ... PM-Timer delta = 357874
[    0.046666] ... PM-Timer result ok
[    0.046666] ..... delta 6248872
[    0.046666] ..... mult: 268387035
[    0.046666] ..... calibration result: 3332731
[    0.046666] ..... CPU clock speed is 2693.0449 MHz.
[    0.046666] ..... host bus clock speed is 999.3064 MHz.
[    0.046773] smpboot: CPU0: GenuineIntel Common KVM processor (family: 0xf, model: 0x6, stepping: 0x1)
[    0.055019] Performance Events: no PMU driver, software events only.
[    0.057014] Hierarchical SRCU implementation.
[    0.059519] smp: Bringing up secondary CPUs ...
[    0.061074] x86: Booting SMP configuration:
[    0.063371] .... node  #0, CPUs:      #1
[    0.003333] kvm-clock: cpu 1, msr 0:1ffd0041, secondary cpu clock
[    0.003333] masked ExtINT on CPU#1
[    0.003333] numa_add_cpu cpu 1 node 0: mask now 0-1
[    0.090139] KVM setup async PF for cpu 1
[    0.090139] kvm-stealtime: cpu 1, msr 1d6105c0
[    0.093360] smp: Brought up 1 node, 2 CPUs
[    0.094044] smpboot: Max logical packages: 2
[    0.094772] ----------------
[    0.096682] | NMI testsuite:
[    0.097169] --------------------
[    0.097713]   remote IPI:  ok  |
[    0.108611]    local IPI:  ok  |
[    0.109258] --------------------
[    0.109978] Good, all   2 testcases passed! |
[    0.110017] ---------------------------------
[    0.110764] smpboot: Total of 2 processors activated (10778.95 BogoMIPS)
[    0.117777] devtmpfs: initialized
[    0.120563] x86/mm: Memory block size: 128MB
[    0.123417] gcov: version magic: 0x4137332a
[    0.130284] evm: security.capability
[    0.133688] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.136780] futex hash table entries: 512 (order: 4, 65536 bytes)
[    0.140716] NET: Registered protocol family 16
[    0.147020] cpuidle: using governor ladder
[    0.159628] ACPI: bus type PCI registered
[    0.160956] PCI: Using configuration type 1 for base access
[    0.233954] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.236407] cryptd: max_cpu_qlen set to 1000
[    0.237453] ACPI: Added _OSI(Module Device)
[    0.238256] ACPI: Added _OSI(Processor Device)
[    0.239081] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.240029] ACPI: Added _OSI(Processor Aggregator Device)
[    0.241022] ACPI: Added _OSI(Linux-Dell-Video)
[    0.264985] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.287536] ACPI: Interpreter enabled
[    0.288319] ACPI: (supports S0 S5)
[    0.289012] ACPI: Using IOAPIC for interrupt routing
[    0.290160] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.294000] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.349890] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.350042] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.351119] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.353493] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.356112] PCI host bridge to bus 0000:00
[    0.356697] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.357944] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.359251] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.360030] pci_bus 0000:00: root bus resource [mem 0x20000000-0xfebfffff window]
[    0.361385] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.363470] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.367209] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.370994] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.402484] pci 0000:00:01.1: reg 0x20: [io  0xc200-0xc20f]
[    0.413415] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.416692] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.417889] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.419191] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.423356] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.425279] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.426714] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.430049] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.436713] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.450049] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.480046] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.484827] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.490033] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.496708] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.530047] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.535605] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.543372] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    0.553370] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.573371] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
[    0.582857] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    0.590034] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
[    0.596706] pci 0000:00:05.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.616704] pci 0000:00:05.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit pref]
[    0.632290] pci 0000:00:06.0: [1af4:1001] type 00 class 0x010000
[    0.640036] pci 0000:00:06.0: reg 0x10: [io  0xc0c0-0xc0ff]
[    0.646705] pci 0000:00:06.0: reg 0x14: [mem 0xfebf3000-0xfebf3fff]
[    0.666705] pci 0000:00:06.0: reg 0x20: [mem 0xfe008000-0xfe00bfff 64bit pref]
[    0.679331] pci 0000:00:07.0: [1af4:1001] type 00 class 0x010000
[    0.686712] pci 0000:00:07.0: reg 0x10: [io  0xc100-0xc13f]
[    0.696701] pci 0000:00:07.0: reg 0x14: [mem 0xfebf4000-0xfebf4fff]
[    0.716705] pci 0000:00:07.0: reg 0x20: [mem 0xfe00c000-0xfe00ffff 64bit pref]
[    0.731759] pci 0000:00:08.0: [1af4:1001] type 00 class 0x010000
[    0.736706] pci 0000:00:08.0: reg 0x10: [io  0xc140-0xc17f]
[    0.743370] pci 0000:00:08.0: reg 0x14: [mem 0xfebf5000-0xfebf5fff]
[    0.770036] pci 0000:00:08.0: reg 0x20: [mem 0xfe010000-0xfe013fff 64bit pref]
[    0.782285] pci 0000:00:09.0: [1af4:1001] type 00 class 0x010000
[    0.806760] pci 0000:00:09.0: reg 0x10: [io  0xc180-0xc1bf]
[    0.820044] pci 0000:00:09.0: reg 0x14: [mem 0xfebf6000-0xfebf6fff]
[    0.880059] pci 0000:00:09.0: reg 0x20: [mem 0xfe014000-0xfe017fff 64bit pref]
[    0.895720] pci 0000:00:0a.0: [1af4:1001] type 00 class 0x010000
[    0.910047] pci 0000:00:0a.0: reg 0x10: [io  0xc1c0-0xc1ff]
[    0.923378] pci 0000:00:0a.0: reg 0x14: [mem 0xfebf7000-0xfebf7fff]
[    0.960047] pci 0000:00:0a.0: reg 0x20: [mem 0xfe018000-0xfe01bfff 64bit pref]
[    0.976041] pci 0000:00:0b.0: [8086:25ab] type 00 class 0x088000
[    0.981817] pci 0000:00:0b.0: reg 0x10: [mem 0xfebf8000-0xfebf800f]
[    1.011244] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.013762] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.015850] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.017962] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.019467] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.026666] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.026666] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.026727] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.027678] vgaarb: loaded
[    1.028623] ACPI: bus type USB registered
[    1.029489] usbcore: registered new interface driver usbfs
[    1.029999] usbcore: registered new interface driver hub
[    1.029999] usbcore: registered new device driver usb
[    1.029999] pps_core: LinuxPPS API ver. 1 registered
[    1.029999] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.029999] PTP clock support registered
[    1.033527] FPGA manager framework
[    1.034413] Advanced Linux Sound Architecture Driver Initialized.
[    1.035547] PCI: Using ACPI for IRQ routing
[    1.036259] PCI: pci_cache_line_size set to 64 bytes
[    1.036666] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.036666] e820: reserve RAM buffer [mem 0x1ffd2000-0x1fffffff]
[    1.037623] NET: Registered protocol family 8
[    1.038379] NET: Registered protocol family 20
[    1.040168] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    1.046368] clocksource: Switched to clocksource kvm-clock
[    1.104237] Warning: could not register all branches stats
[    1.105228] Warning: could not register annotated branches stats
[    1.252246] VFS: Disk quotas dquot_6.6.0
[    1.253116] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.254775] FS-Cache: Loaded
[    1.255703] pnp: PnP ACPI init
[    1.256906] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.258522] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.260054] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.261303] pnp 00:03: [dma 2]
[    1.262041] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    1.263824] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.265532] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.267262] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.271495] pnp: PnP ACPI: found 7 devices
[    1.280582] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.282302] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.283379] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.284430] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.285564] pci_bus 0000:00: resource 7 [mem 0x20000000-0xfebfffff window]
[    1.287845] NET: Registered protocol family 2
[    1.299390] tcp_listen_portaddr_hash hash table entries: 256 (order: 2, 22528 bytes)
[    1.300827] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    1.302240] TCP bind hash table entries: 4096 (order: 6, 327680 bytes)
[    1.304083] TCP: Hash tables configured (established 4096 bind 4096)
[    1.305365] UDP hash table entries: 256 (order: 3, 49152 bytes)
[    1.306487] UDP-Lite hash table entries: 256 (order: 3, 49152 bytes)
[    1.321809] NET: Registered protocol family 1
[    1.323758] RPC: Registered named UNIX socket transport module.
[    1.324757] RPC: Registered udp transport module.
[    1.325544] RPC: Registered tcp transport module.
[    1.326341] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.331210] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.332242] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.333282] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.334497] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.336213] PCI: CLS 0 bytes, default 64
[    1.337552] Unpacking initramfs...
[    5.128842] Freeing initrd memory: 23244K
[    5.145704] cryptomgr_test (34) used greatest stack depth: 15032 bytes left
[    5.155461] PCLMULQDQ-NI instructions are not detected.
[    5.157074] AVX or AES-NI instructions are not detected.
[    5.158052] CPU feature 'AVX registers' is not supported.
[    5.159204] CPU feature 'AVX registers' is not supported.
[    5.160238] CPU feature 'AVX registers' is not supported.
[    5.161475] CPU feature 'AVX registers' is not supported.
[    5.162460] AVX2 or AES-NI instructions are not detected.
[    5.163537] AVX2 instructions are not detected.
[    5.164760] spin_lock-torture:--- Start of test [debug]: nwriters_stress=4 nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
[    5.168244] spin_lock-torture: Creating torture_shuffle task
[    5.169645] spin_lock-torture: torture_shuffle task started
[    5.170720] spin_lock-torture: Creating torture_stutter task
[    5.172049] spin_lock-torture: torture_stutter task started
[    5.173295] spin_lock-torture: Creating lock_torture_writer task
[    5.175530] spin_lock-torture: lock_torture_writer task started
[    5.179525] spin_lock-torture: Creating lock_torture_writer task
[    5.180921] spin_lock-torture: Creating lock_torture_writer task
[    5.182282] spin_lock-torture: lock_torture_writer task started
[    5.183868] spin_lock-torture: lock_torture_writer task started
[    5.185054] spin_lock-torture: Creating lock_torture_writer task
[    5.186706] spin_lock-torture: lock_torture_writer task started
[    5.187902] spin_lock-torture: Creating lock_torture_stats task
[    5.189279] spin_lock-torture: lock_torture_stats task started
[    5.190598] torture_init_begin: Refusing rcu init: spin_lock running.
[    5.191748] torture_init_begin: One torture test at a time!
[    8.899521] Initialise system trusted keyrings
[    8.902836] Key type blacklist registered
[    8.903924] workingset: timestamp_bits=56 max_order=17 bucket_order=0
[    8.950884] NFS: Registering the id_resolver key type
[    8.951869] Key type id_resolver registered
[    8.952685] Key type id_legacy registered
[    8.960198] orangefs_debugfs_init: called with debug mask: :none: :0:
[    8.966157] orangefs_init: module version upstream loaded
[    8.985203] cryptomgr_test (62) used greatest stack depth: 14904 bytes left
[    9.094847] NET: Registered protocol family 38
[    9.096096] Key type asymmetric registered
[    9.096807] Asymmetric key parser 'x509' registered
[    9.097542] Key type pkcs7_test registered
[    9.098883] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    9.099643] crc32: self tests passed, processed 225944 bytes in 306669 nsec
[    9.101054] crc32c: CRC_LE_BITS = 64
[    9.101661] crc32c: self tests passed, processed 225944 bytes in 174200 nsec
[    9.319236] crc32_combine: 8373 self tests passed
[    9.474150] crc32c_combine: 8373 self tests passed
[    9.476428] xz_dec_test: module loaded
[    9.477054] xz_dec_test: Create a device node with 'mknod xz_dec_test c 245 0' and write .xz files to it.
[    9.535705] gpio_winbond: chip ID at 2e is ffff
[    9.536552] gpio_winbond: not an our chip
[    9.537386] gpio_winbond: chip ID at 4e is ffff
[    9.538202] gpio_winbond: not an our chip
[    9.541264] no IO addresses supplied
[    9.542764] usbcore: registered new interface driver udlfb
[    9.543831] usbcore: registered new interface driver smscufx
[    9.545020] ipmi message handler version 39.2
[    9.545820] ipmi device interface
[    9.547606] IPMI System Interface driver.
[    9.548879] ipmi_si: Unable to find any System Interface(s)
[    9.549954] IPMI SSIF Interface driver
[    9.550838] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
[    9.553333] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    9.554729] ACPI: Power Button [PWRF]
[    9.555787] Warning: Processor Platform Limit event detected, but not handled.
[    9.557092] Consider compiling CPUfreq support into your kernel.
[    9.596523] r3964: Philips r3964 Driver $Revision: 1.10 $
[    9.598176] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    9.661336] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    9.691382] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    9.697434] lp: driver loaded but no devices found
[    9.702691] ppdev: user-space parallel port driver
[    9.703641] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    9.729203] drm_mm: Testing DRM range manger (struct drm_mm), with random_seed=0x13132325 max_iterations=8192 max_prime=128
[    9.731290] drm_mm: igt_sanitycheck - ok!
[    9.732099] igt_debug 0x0000000000000000-0x0000000000000200: 512: free
[    9.733239] igt_debug 0x0000000000000200-0x0000000000000600: 1024: used
[    9.734320] igt_debug 0x0000000000000600-0x0000000000000a00: 1024: free
[    9.735444] igt_debug 0x0000000000000a00-0x0000000000000e00: 1024: used
[    9.736559] igt_debug 0x0000000000000e00-0x0000000000001000: 512: free
[    9.737665] igt_debug total: 4096, used 2048 free 2048
[   69.324579] Writes:  Total: 756183  Max/Min: 0/0   Fail: 0 
[  135.567352] Writes:  Total: 1024355  Max/Min: 0/0   Fail: 0 
[  200.593350] Writes:  Total: 1331475  Max/Min: 0/0   Fail: 0 
[  264.821387] Writes:  Total: 1647088  Max/Min: 0/0   Fail: 0 
[  331.246899] Writes:  Total: 3320945  Max/Min: 0/0   Fail: 0 
[  349.948352] [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
[  349.950274] usbcore: registered new interface driver udl
[  349.984026] dummy-irq: no IRQ given.  Use irq=N
[  349.991374] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
[  349.993256] c2port c2port0: C2 port uc added
[  349.994143] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 bytes total)
[  349.997712] usbcore: registered new interface driver rtsx_usb
[  350.003591] usbcore: registered new interface driver viperboard
[  350.004728] usbcore: registered new interface driver dln2
[  350.008251] HSI/SSI char device loaded
[  350.041837] libphy: Fixed MDIO Bus: probed
[  350.057854] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[  350.059036] e1000: Copyright (c) 1999-2006 Intel Corporation.
[  351.787453] PCI Interrupt Link [LNKC] enabled at IRQ 11
[  352.433737] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[  352.435069] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[  352.436789] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[  352.437776] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[  352.439021] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[  352.440460] igb: Copyright (c) 2007-2014 Intel Corporation.
[  352.441556] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
[  352.442847] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[  352.448915] AX.25: bpqether driver version 004
[  352.449694] baycom_ser_fdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[  352.449694] baycom_ser_fdx: version 0.10
[  352.455696] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA
[  352.456764] hdlcdrv: version 0.8
[  352.457443] baycom_ser_hdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[  352.457443] baycom_ser_hdx: version 0.10
[  352.470992] baycom_par: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[  352.470992] baycom_par: version 0.9
[  352.486965] PPP generic driver version 2.4.2
[  352.488266] NET: Registered protocol family 24
[  352.489490] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
[  352.491118] SLIP linefill/keepalive option.
[  352.492222] usbcore: registered new interface driver brcmfmac
[  352.496061] usbcore: registered new interface driver usb8xxx
[  352.500110] usbcore: registered new interface driver mwifiex_usb
[  352.501215] usbcore: registered new interface driver catc
[  352.502217] usbcore: registered new interface driver kaweth
[  352.503246] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[  352.507095] usbcore: registered new interface driver pegasus
[  352.508145] usbcore: registered new interface driver rtl8150
[  352.509222] usbcore: registered new interface driver r8152
[  352.522790] hso: drivers/net/usb/hso.c: Option Wireless
[  352.524083] usbcore: registered new interface driver hso
[  352.525065] usbcore: registered new interface driver lan78xx
[  352.526133] usbcore: registered new interface driver ipheth
[  352.527887] panel: panel driver not yet registered
[  352.529044] usbcore: registered new interface driver hwa-rc
[  352.530079] usbcore: registered new interface driver i1480-dfu-usb
[  352.532503] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[  352.533610] ehci-pci: EHCI PCI platform driver
[  352.534509] ehci-platform: EHCI generic platform driver
[  352.538775] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  352.539950] ohci-pci: OHCI PCI platform driver
[  352.540840] ohci-platform: OHCI generic platform driver
[  352.542168] usbcore: registered new interface driver usbtmc
[  352.543220] usbcore: registered new interface driver mdc800
[  352.544158] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
[  352.545666] usbcore: registered new interface driver aircable
[  352.546767] usbserial: USB Serial support registered for aircable
[  352.547876] usbcore: registered new interface driver ark3116
[  352.548940] usbserial: USB Serial support registered for ark3116
[  352.550029] usbcore: registered new interface driver belkin_sa
[  352.551083] usbserial: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
[  352.565808] usbcore: registered new interface driver ch341
[  352.566817] usbserial: USB Serial support registered for ch341-uart
[  352.567935] usbcore: registered new interface driver cyberjack
[  352.569032] usbserial: USB Serial support registered for Reiner SCT Cyberjack USB card reader
[  352.570520] usbcore: registered new interface driver cypress_m8
[  352.571586] usbserial: USB Serial support registered for DeLorme Earthmate USB
[  352.572875] usbserial: USB Serial support registered for HID->COM RS232 Adapter
[  352.574178] usbserial: USB Serial support registered for Nokia CA-42 V2 Adapter
[  352.575490] usbcore: registered new interface driver io_edgeport
[  352.576581] usbserial: USB Serial support registered for Edgeport 2 port adapter
[  352.577878] usbserial: USB Serial support registered for Edgeport 4 port adapter
[  352.579203] usbserial: USB Serial support registered for Edgeport 8 port adapter
[  352.580563] usbserial: USB Serial support registered for EPiC device
[  352.581705] usbcore: registered new interface driver io_ti
[  352.582723] usbserial: USB Serial support registered for Edgeport TI 1 port adapter
[  352.584065] usbserial: USB Serial support registered for Edgeport TI 2 port adapter
[  352.585429] usbcore: registered new interface driver empeg
[  352.586463] usbserial: USB Serial support registered for empeg
[  352.587509] usbcore: registered new interface driver f81232
[  352.589444] usbserial: USB Serial support registered for f81232
[  352.590887] usbcore: registered new interface driver garmin_gps
[  352.592450] usbserial: USB Serial support registered for Garmin GPS usb/tty
[  352.594099] usbcore: registered new interface driver ipw
[  352.595427] usbserial: USB Serial support registered for IPWireless converter
[  352.598940] usbcore: registered new interface driver iuu_phoenix
[  352.600350] usbserial: USB Serial support registered for iuu_phoenix
[  352.601811] usbcore: registered new interface driver keyspan_pda
[  352.603267] usbserial: USB Serial support registered for Keyspan PDA
[  352.604710] usbserial: USB Serial support registered for Keyspan PDA - (prerenumeration)
[  352.606511] usbserial: USB Serial support registered for Xircom / Entrega PGS - (prerenumeration)
[  352.608378] usbcore: registered new interface driver kl5kusb105
[  352.609850] usbserial: USB Serial support registered for KL5KUSB105D / PalmConnect
[  352.611464] usbcore: registered new interface driver kobil_sct
[  352.612923] usbserial: USB Serial support registered for KOBIL USB smart card terminal
[  352.614587] usbcore: registered new interface driver mos7720
[  352.615991] usbserial: USB Serial support registered for Moschip 2 port adapter
[  352.617312] usbcore: registered new interface driver mos7840
[  352.618339] usbserial: USB Serial support registered for Moschip 7840/7820 USB Serial Driver
[  352.619835] usbcore: registered new interface driver mxuport
[  352.620857] usbserial: USB Serial support registered for MOXA UPort
[  352.622007] usbcore: registered new interface driver navman
[  352.623068] usbserial: USB Serial support registered for navman
[  352.624129] usbcore: registered new interface driver omninet
[  352.625180] usbserial: USB Serial support registered for ZyXEL - omni.net lcd plus usb
[  352.626569] usbcore: registered new interface driver qcserial
[  352.627627] usbserial: USB Serial support registered for Qualcomm USB modem
[  352.628876] usbcore: registered new interface driver safe_serial
[  352.629971] usbserial: USB Serial support registered for safe_serial
[  352.631103] usbcore: registered new interface driver usb_serial_simple
[  352.632319] usbserial: USB Serial support registered for carelink
[  352.636262] usbserial: USB Serial support registered for zio
[  352.637676] usbserial: USB Serial support registered for funsoft
[  352.642380] usbserial: USB Serial support registered for flashloader
[  352.643843] usbserial: USB Serial support registered for google
[  352.645295] usbserial: USB Serial support registered for vivopay
[  352.646683] usbserial: USB Serial support registered for moto_modem
[  352.648155] usbserial: USB Serial support registered for motorola_tetra
[  352.649707] usbserial: USB Serial support registered for novatel_gps
[  352.651153] usbserial: USB Serial support registered for hp4x
[  352.652540] usbserial: USB Serial support registered for suunto
[  352.653910] usbserial: USB Serial support registered for siemens_mpi
[  352.655447] usbcore: registered new interface driver ssu100
[  352.656781] usbserial: USB Serial support registered for Quatech SSU-100 USB to Serial Driver
[  352.658618] usbcore: registered new interface driver symbolserial
[  352.659752] usbserial: USB Serial support registered for symbol
[  352.660826] usbcore: registered new interface driver ti_usb_3410_5052
[  352.662020] usbserial: USB Serial support registered for TI USB 3410 1 port adapter
[  352.663433] usbserial: USB Serial support registered for TI USB 5052 2 port adapter
[  352.664793] usbcore: registered new interface driver visor
[  352.665944] usbserial: USB Serial support registered for Handspring Visor / Palm OS
[  352.667336] usbserial: USB Serial support registered for Sony Clie 5.0
[  352.668542] usbserial: USB Serial support registered for Sony Clie 3.5
[  352.669709] usbcore: registered new interface driver wishbone_serial
[  352.670848] usbserial: USB Serial support registered for wishbone_serial
[  352.672129] usbcore: registered new interface driver whiteheat
[  352.673213] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT - (prerenumeration)
[  352.674814] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT
[  352.679674] usbcore: registered new interface driver adutux
[  352.688621] usbcore: registered new interface driver appledisplay
[  352.689851] usbcore: registered new interface driver emi26 - firmware loader
[  352.691131] usbcore: registered new interface driver emi62 - firmware loader
[  352.692455] usbcore: registered new interface driver idmouse
[  352.693513] usbcore: registered new interface driver iowarrior
[  352.694588] usbcore: registered new interface driver isight_firmware
[  352.695777] usbcore: registered new interface driver usblcd
[  352.696819] usbcore: registered new interface driver ldusb
[  352.697895] usbcore: registered new interface driver legousbtower
[  352.699045] usbcore: registered new interface driver usbtest
[  352.700093] usbcore: registered new interface driver usb_ehset_test
[  352.701295] usbcore: registered new interface driver trancevibrator
[  352.702563] usbcore: registered new interface driver yurex
[  352.703924] usbcore: registered new interface driver sisusb
[  352.704962] usbcore: registered new interface driver lvs
[  352.706379] usbcore: registered new interface driver speedtch
[  352.707925] usbcore: registered new interface driver ueagle-atm
[  352.715454] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
[  352.717307] dummy_hcd dummy_hcd.0: Dummy host controller
[  352.718324] dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
[  352.720213] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
[  352.721601] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  352.722840] usb usb1: Product: Dummy host controller
[  352.723764] usb usb1: Manufacturer: Linux 4.17.0-rc2 dummy_hcd
[  352.724750] usb usb1: SerialNumber: dummy_hcd.0
[  352.733793] hub 1-0:1.0: USB hub found
[  352.734954] hub 1-0:1.0: 1 port detected
[  352.756964] userial_init: registered 4 ttyGS* devices
[  352.766219] usbcore: registered new device driver usbip-host
[  352.768412] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[  352.774778] serio: i8042 KBD port at 0x60,0x64 irq 1
[  352.776070] serio: i8042 AUX port at 0x60,0x64 irq 12
[  352.783510] mousedev: PS/2 mouse device common for all mice
[  352.785921] evbug: Connected device: input0 (Power Button at LNXPWRBN/button/input0)
[  352.791861] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[  352.794517] evbug: Connected device: input1 (AT Translated Set 2 keyboard at isa0060/serio0/input0)
[  352.795593] apanel: Fujitsu BIOS signature 'FJKEYINF' not found...
[  352.800308] usbcore: registered new interface driver keyspan_remote
[  352.805771] input: PC Speaker as /devices/platform/pcspkr/input/input3
[  352.808218] evbug: Connected device: input3 (PC Speaker at isa0061/input0)
[  352.810130] usbcore: registered new interface driver powermate
[  352.811745] usbcore: registered new interface driver yealink
[  352.812877] ideapad_slidebar: DMI does not match
[  352.815224] usbcore: registered new interface driver i2c-diolan-u2c
[  352.816355] i2c-parport: adapter type unspecified
[  352.817213] i2c-parport-light: adapter type unspecified
[  352.818318] usbcore: registered new interface driver RobotFuzz Open Source InterFace, OSIF
[  352.819952] usbcore: registered new interface driver i2c-tiny-usb
[  352.823397] pps pps0: new PPS source ktimer
[  352.824211] pps pps0: ktimer PPS source registered
[  352.825083] pps_ldisc: PPS line discipline registered
[  352.826294] Driver for 1-wire Dallas network protocol.
[  352.827563] usbcore: registered new interface driver DS9490R
[  352.828619] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[  352.830112] w1_f0d_init()
[  352.834709] applesmc: supported laptop not found!
[  352.835610] applesmc: driver init failed (ret=-19)!
[  352.851490] pc87360: PC8736x not detected, module not inserted
[  352.853046] usb usb1: dummy_bus_suspend
[  352.885250] ISDN subsystem Rev: 1.1.2.3/
[  352.885264] 1.1.2.2/
[  352.885968] none/
[  352.886368] none/
[  352.886717] 1.1.2.2
[  352.887067] 
[  352.887776] Modular ISDN core version 1.1.29
[  352.890204] NET: Registered protocol family 34
[  352.890976] DSP module 2.0
[  352.891468] mISDN_dsp: DSP clocks every 80 samples. This equals 3 jiffies.
[  352.907781] mISDN: Layer-1-over-IP driver Rev. 2.00
[  352.909290] 0 virtual devices registered
[  352.910097] usbcore: registered new interface driver HFC-S_USB
[  352.911111] dss1_divert module successfully installed
[  352.911982] HiSax: Linux Driver for passive ISDN cards
[  352.912885] HiSax: Version 3.5 (kernel)
[  352.913560] HiSax: Layer1 Revision 2.46.2.5
[  352.914268] HiSax: Layer2 Revision 2.30.2.4
[  352.914985] HiSax: TeiMgr Revision 2.20.2.3
[  352.915736] HiSax: Layer3 Revision 2.22.2.3
[  352.916449] HiSax: LinkLayer Revision 2.59.2.4
[  352.917230] HiSax: Total 1 card defined
[  352.917952] HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
[  352.918816] Gazel: Driver Revision 2.19.2.4
[  352.919650] Gazel: ISA PnP card automatic recognition
[  352.920517] Gazel: Card ISA R647/R648 found
[  352.921225] Gazel: config irq:15 isac:0x8180  cfg:0xC180
[  352.922119] Gazel: hscx A:0x180  hscx B:0x4180
[  352.971951] Gazel: ISAC version (ff): 2085 V2.3
[  352.972832] Gazel: HSCX version A: ???  B: ???
[  352.973557] Gazel: wrong HSCX versions check IO address
[  352.974534] HiSax: Card Gazel not installed !
[  352.975265] HFC-S USB: driver module revision 2.3.2.24 date 2007/10/14 loaded, (debug=0)
[  352.981462] usbcore: registered new interface driver hfc_usb
[  352.982486] HFC-4S/8S: Layer 1 driver module for HFC-4S/8S isdn chips, Revision: 1.10
[  352.983767] HFC-4S/8S: (C) 2003 Cornelius Consult, www.cornelius-consult.de
[  352.985139] HFC-4S/8S: found 0 cards
[  353.002625] usbcore: registered new interface driver usbkbd
[  353.003664] usbcore: registered new interface driver usbmouse
[  353.007726] NET: Registered protocol family 40
[  353.010950] NET: Registered protocol family 4
[  353.012655] usbcore: registered new interface driver prism2_usb
[  353.013724] comedi: version 0.7.76 - http://www.comedi.org
[  353.015457] usbcore: registered new interface driver usbdux
[  353.016859] usbcore: registered new interface driver usbduxsigma
[  353.017981] usbcore: registered new interface driver vmk80xx
[  353.019154] usbcore: registered new interface driver r8712u
[  353.088104] no UART detected at 0x1
[  353.098743] NET: Registered protocol family 26
[  353.108497] NET: Registered protocol family 10
[  353.114007] Segment Routing with IPv6
[  353.114836] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[  353.118578] NET: Registered protocol family 17
[  353.119572] Bridge firewalling registered
[  353.120284] NET: Registered protocol family 5
[  353.121189] NET: Registered protocol family 9
[  353.122723] X25: Linux Version 0.2
[  353.127951] NET: Registered protocol family 6
[  353.145435] NET: Registered protocol family 11
[  353.146388] NET: Registered protocol family 3
[  353.147405] lec:lane_module_init: lec.c: initialized
[  353.148361] NET: Registered protocol family 35
[  353.149543] lib80211: common routines for IEEE802.11 drivers
[  353.150532] lib80211_crypt: registered algorithm 'NULL'
[  353.151579] 9pnet: Installing 9P2000 support
[  353.152597] NET: Registered protocol family 37
[  353.153789] NET: Registered protocol family 36
[  353.155014] Key type dns_resolver registered
[  353.163978] batman_adv: B.A.T.M.A.N. advanced 2018.1 (compatibility version 15) loaded
[  353.166044] mpls_gso: MPLS GSO support
[  353.168979] ... APIC ID:      00000000 (0)
[  353.169799] ... APIC VERSION: 01050014
[  353.170504] 0000000000000000000000000000000000000000000000000000000000000000
[  353.171870] 0000000000000000000000000000000000000000000000000000000000000000
[  353.172271] 0000000000000000000000000000000000000000000000000000000000001000
[  353.174624] number of MP IRQ sources: 15.
[  353.175386] number of IO-APIC #0 registers: 24.
[  353.176200] testing the IO APIC.......................
[  353.177072] IO APIC #0......
[  353.177577] .... register #00: 00000000
[  353.178230] .......    : physical APIC id: 00
[  353.179011] .......    : Delivery Type: 0
[  353.179723] .......    : LTS          : 0
[  353.180404] .... register #01: 00170011
[  353.181052] .......     : max redirection entries: 17
[  353.181916] .......     : PRQ implemented: 0
[  353.182651] .......     : IO APIC version: 11
[  353.183398] .... register #02: 00000000
[  353.184044] .......     : arbitration: 00
[  353.184725] .... IRQ redirection table:
[  353.185400] IOAPIC 0:
[  353.185834]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.187143]  pin01, enabled , edge , high, V(22), IRR(0), S(0), logical , D(02), M(0)
[  353.188481]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(0)
[  353.189793]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.191090]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.192429]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.193737]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.195061]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.196389]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.197698]  pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(02), M(0)
[  353.199030]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.200342]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.201650]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), logical , D(01), M(0)
[  353.202973]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.204332]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.205664]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.206978]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.208294]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.209622]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.210932]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.212278]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.213613]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.214914]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.216257]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[  353.217541] IRQ to pin mappings:
[  353.218095] IRQ0 -> 0:2
[  353.218569] IRQ1 -> 0:1
[  353.219022] IRQ3 -> 0:3
[  353.219475] IRQ4 -> 0:4
[  353.219927] IRQ5 -> 0:5
[  353.220384] IRQ6 -> 0:6
[  353.220831] IRQ7 -> 0:7
[  353.221285] IRQ8 -> 0:8
[  353.221758] IRQ9 -> 0:9
[  353.222216] IRQ10 -> 0:10
[  353.222707] IRQ11 -> 0:11
[  353.223188] IRQ12 -> 0:12
[  353.223682] IRQ13 -> 0:13
[  353.224159] IRQ14 -> 0:14
[  353.224645] IRQ15 -> 0:15
[  353.225141] .................................... done.
[  353.229953] sched_clock: Marking stable (353229606652, 0)->(354747913545, -1518306893)
[  353.232890] registered taskstats version 1
[  353.233607] Loading compiled-in X.509 certificates
[  353.236828] cryptomgr_probe (141) used greatest stack depth: 13912 bytes left
[  353.238277] Key type encrypted registered
[  353.239197] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[  353.240344] ima: Allocated hash algorithm: sha1
[  353.242329] evm: HMAC attrs: 0x1
[  353.248821] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  353.261799] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  353.263332] ALSA device list:
[  353.263920]   #0: Dummy 1
[  353.264431]   #1: Loopback 1
[  353.264989]   #2: Virtual MIDI Card 1
[  353.267616] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[  353.269281] platform regulatory.0: Falling back to user helper
[  353.355831] Freeing unused kernel memory: 3984K
[  353.356736] Write protecting the kernel read-only data: 45056k
[  353.389269] Freeing unused kernel memory: 2024K
[  353.429881] Freeing unused kernel memory: 536K
[  353.430789] rodata_test: all tests were successful
[  353.466221] random: init: uninitialized urandom read (12 bytes read)
[  353.502462] hostname (148) used greatest stack depth: 13880 bytes left
[  353.622041] hwclock (150) used greatest stack depth: 13640 bytes left
[  353.679110] plymouthd (149) used greatest stack depth: 13608 bytes left
[  353.836120] random: trinity: uninitialized urandom read (4 bytes read)
mountall: Event failed
[  353.907704] random: mountall: uninitialized urandom read (12 bytes read)
[  354.033954] init: Failed to create pty - disabling logging for job
[  354.035347] init: Temporary process spawn error: No such file or directory
[  354.113368] init: Failed to create pty - disabling logging for job
[  354.114722] init: Temporary process spawn error: No such file or directory
[  354.242405] init: Failed to create pty - disabling logging for job
[  354.243795] init: Temporary process spawn error: No such file or directory
[  354.256283] init: Failed to create pty - disabling logging for job
[  354.258418] init: Temporary process spawn error: No such file or directory
[  354.316528] sh (186) used greatest stack depth: 13520 bytes left
[  354.598113] init: Failed to create pty - disabling logging for job
[  354.612585] init: Temporary process spawn error: No such file or directory
[  354.635228] init: Failed to create pty - disabling logging for job
[  354.637790] init: Temporary process spawn error: No such file or directory
[  354.677764] init: Failed to create pty - disabling logging for job
[  354.686275] sysctl (212) used greatest stack depth: 13512 bytes left
[  354.689696] init: Temporary process spawn error: No such file or directory
[  354.710084] init: Failed to create pty - disabling logging for job
[  354.712402] init: Temporary process spawn error: No such file or directory
[  354.740432] init: Failed to create pty - disabling logging for job
[  354.742790] init: Temporary process spawn error: No such file or directory
[  354.771200] init: plymouth-log main process (214) terminated with status 1
[  354.799931] init: Failed to create pty - disabling logging for job
[  354.801603] init: Temporary process spawn error: No such file or directory
[  354.808750] udevd[220]: starting version 175
[  354.816517] init: Failed to create pty - disabling logging for job
[  354.817529] init: Temporary process spawn error: No such file or directory
[  354.833560] init: Failed to create pty - disabling logging for job
[  354.844578] init: Temporary process spawn error: No such file or directory
udevd[228]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:LNXSYSTM:': No such file or directory
udevd[232]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:LNXSYBUS:': No such file or directory
udevd[234]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv input:b0019v0000p0001e0000-e0,1,k74,ramlsfw': No such file or directory
udevd[235]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:LNXSYBUS:': No such file or directory
udevd[237]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00008086d00001237sv00001AF4sd00001100bc06sc00i00': No such file or directory
udevd[240]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:ACPI0010:PNP0A05:': No such file or directory
udevd[239]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00008086d00007010sv00001AF4sd00001100bc01sc01i80': No such file or directory
udevd[244]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00008086d00007000sv00001AF4sd00001100bc06sc01i00': No such file or directory
udevd[247]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0103:': No such file or directory
udevd[250]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0A03:': No such file or directory
udevd[252]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0C0F:': No such file or directory
udevd[254]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0C0F:': No such file or directory
udevd[255]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0C0F:': No such file or directory
udevd[259]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:LNXCPU:': No such file or directory
udevd[257]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001234d00001111sv00001AF4sd00001100bc03sc00i00': No such file or directory
udevd[264]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0C0F:': No such file or directory
udevd[258]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:LNXCPU:': No such file or directory
udevd[256]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0C0F:': No such file or directory
udevd[262]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0A06:': No such file or directory
udevd[260]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0A06:': No such file or directory
udevd[261]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0A06:': No such file or directory
udevd[263]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:QEMU0002:': No such file or directory
udevd[266]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00008086d00007113sv00001AF4sd00001100bc06sc80i00': No such file or directory
udevd[298]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0303:': No such file or directory
udevd[300]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0501:': No such file or directory
udevd[304]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0700:': No such file or directory
udevd[301]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0400:': No such file or directory
udevd[305]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0B00:': No such file or directory
udevd[299]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0F13:': No such file or directory
udevd[302]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0501:': No such file or directory
udevd[306]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001AF4d00001001sv00001AF4sd00000002bc01sc00i00': No such file or directory
udevd[307]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001AF4d00001001sv00001AF4sd00000002bc01sc00i00': No such file or directory
udevd[309]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001AF4d00001001sv00001AF4sd00000002bc01sc00i00': No such file or directory
[  356.102723] init: Failed to create pty - disabling logging for job
udevd[313]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:QEMU0002:': No such file or directory
udevd[308]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001AF4d00001001sv00001AF4sd00000002bc01sc00i00': No such file or directory
udevd[316]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv acpi:PNP0103:': No such file or directory
udevd[314]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001AF4d00001001sv00001AF4sd00000002bc01sc00i00': No such file or directory
[  356.177177] init: Failed to create pty - disabling logging for job
[  356.179317] init: Temporary process spawn error: No such file or directory
udevd[315]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:dell_rbu': No such file or directory
udevd[311]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001AF4d00001001sv00001AF4sd00000002bc01sc00i00': No such file or directory
udevd[310]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00008086d000025ABsv00001AF4sd00001100bc08sc80i00': No such file or directory
udevd[312]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv pci:v00001AF4d00001001sv00001AF4sd00000002bc01sc00i00': No such file or directory
udevd[318]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:Fixed MDIO bus': No such file or directory
udevd[321]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:regulatory': No such file or directory
udevd[319]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:platform-framebuffer': No such file or directory
udevd[322]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv input:b0010v001Fp0001e0100-e0,12,kramls1,2,fw': No such file or directory
[  356.320155] cfg80211: failed to load regulatory.db
udevd[325]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv serio:ty01pr00id00ex00': No such file or directory
udevd[326]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv input:b0011v0001p0001eAB41-e0,1,4,11,14,k71,72,73,74,75,76,77,79,7A,7B,7C,7D,7E,7F,80,8C,8E,8F,9B,9C,9D,9E,9F,A3,A4,A5,A6,AC,AD,B7,B8,B9,D9,E2,ram4,l0,1,2,sfw': No such file or directory
udevd[327]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:vgem': No such file or directory
udevd[352]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:regulatory': No such file or directory
[  357.439793] init: Failed to create pty - disabling logging for job
[  357.441917] init: Temporary process spawn error: No such file or directory
[  357.958734] init: udev-fallback-graphics main process (370) terminated with status 127
[  358.342076] init: Failed to create pty - disabling logging for job
[  358.343869] init: Temporary process spawn error: No such file or directory
[  358.391492] init: Failed to create pty - disabling logging for job
[  358.393363] init: Temporary process spawn error: No such file or directory
[  358.413950] init: Failed to create pty - disabling logging for job
[  358.415445] init: Temporary process spawn error: No such file or directory
[  358.494913] init: plymouth-splash main process (406) terminated with status 1
[  358.658564] init: Failed to create pty - disabling logging for job
[  358.659930] init: Temporary process spawn error: No such file or directory
[  358.703538] init: Failed to create pty - disabling logging for job
[  358.711791] init: Temporary process spawn error: No such file or directory
[  358.741912] ip (428) used greatest stack depth: 11888 bytes left
[  359.076350] init: failsafe main process (426) killed by TERM signal
[  359.261634] init: networking main process (413) terminated with status 1
[  359.389059] random: dd: uninitialized urandom read (4096 bytes read)
[  359.460669] init: Failed to create pty - disabling logging for job
[  359.462627] init: Temporary process spawn error: No such file or directory
[  359.506665] init: Failed to create pty - disabling logging for job
[  359.508606] init: Temporary process spawn error: No such file or directory
[  359.526837] init: Failed to create pty - disabling logging for job
[  359.529076] init: Temporary process spawn error: No such file or directory
[  359.544316] init: Failed to create pty - disabling logging for job
[  359.545727] init: Temporary process spawn error: No such file or directory
[  359.576557] init: Failed to create pty - disabling logging for job
[  359.578536] init: Temporary process spawn error: No such file or directory
udevd[476]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:regulatory': No such file or directory
Kernel tests: Boot OK!
Trinity v1.4pre  Dave Jones <davej@redhat.com>
[  360.138539] random: trinity: uninitialized urandom read (4 bytes read)
[init] Marking syscall get_robust_list (64bit:274 32bit:312) as to be disabled.
Done parsing arguments.
Marking all syscalls as enabled.
[init] Disabling syscalls marked as disabled by command line options
[init] Marked 64-bit syscall get_robust_list (274) as deactivated.
[init] Marked 32-bit syscall get_robust_list (312) as deactivated.
[init] 32-bit syscalls: 350 enabled, 1 disabled.  64-bit syscalls: 313 enabled, 1 disabled.
DANGER: RUNNING AS ROOT.
Unless you are running in a virtual machine, this could cause serious problems such as overwriting CMOS
or similar which could potentially make this machine unbootable without a firmware reset.

ctrl-c now unless you really know what you are doing.
[  363.932005] sock: process `trinity-main' is using obsolete setsockopt SO_BSDCOMPAT
[  369.342926] random: trinity-main: uninitialized urandom read (4 bytes read)
[  369.370272] random: trinity-main: uninitialized urandom read (4 bytes read)
[  369.530251] init: tty4 main process (462) terminated with status 1
[  369.534296] init: tty4 main process ended, respawning
[  369.571332] init: tty2 main process (465) terminated with status 1
[  369.572879] init: tty2 main process ended, respawning
[  369.612017] init: tty5 main process (464) terminated with status 1
[  369.614842] init: tty5 main process ended, respawning
[  369.657658] init: tty3 main process (466) terminated with status 1
[  369.659698] init: tty3 main process ended, respawning
[  369.703916] init: tty6 main process (468) terminated with status 1
[  369.708191] init: tty6 main process ended, respawning
[init] Using pid_max = 32768
[init] Started watchdog process, PID is 505
[main] Main thread is alive.
[main] Setsockopt(0 7 68b000 1) on fd 8 [2:1:0]
[main] Setsockopt(1 f 68b000 df) on fd 9 [3:2:0]
[main] Setsockopt(100 1 68b000 4) on fd 10 [4:2:226]
[main] Setsockopt(1 a 68b000 4) on fd 11 [5:2:0]
[main] Setsockopt(1 1 68b000 4) on fd 12 [8:4:71]
[main] Setsockopt(6 c 68b000 4) on fd 14 [10:1:0]
[main] Setsockopt(1 c 68b000 39) on fd 17 [20:4:21]
[main] Setsockopt(1 2b 68b000 4) on fd 18 [26:1:3]
[main] Setsockopt(1 29 68b000 af) on fd 19 [35:2:0]
[main] Setsockopt(1 b 68b000 d7) on fd 20 [37:5:0]
[main] Setsockopt(0 b 68b000 1) on fd 22 [2:3:133]
[main] Setsockopt(101 2 68b000 fc) on fd 23 [3:3:133]
[main] Setsockopt(100 1 68b000 4) on fd 24 [4:2:161]
[main] Setsockopt(1 2 68b000 4) on fd 25 [5:2:0]
[main] Setsockopt(1 6 68b000 6c) on fd 26 [8:2:57]
[main] Setsockopt(1 23 68b000 4e) on fd 27 [9:5:0]
[main] Setsockopt(29 b 68b000 4) on fd 28 [10:3:183]
[main] Setsockopt(107 11 68b000 4) on fd 29 [17:2:768]
[main] Setsockopt(10c 9 68b000 4) on fd 31 [26:2:101]
[main] Setsockopt(116 7f 68b000 4) on fd 33 [37:5:4]
[main] Setsockopt(0 7 68b000 4) on fd 35 [2:3:184]
[main] Setsockopt(1 9 68b000 4) on fd 36 [3:2:0]
[main] Setsockopt(100 1 68b000 4) on fd 37 [4:2:184]
[main] Setsockopt(1 7 68b000 4) on fd 40 [9:5:0]
[main] Setsockopt(1 21 68b000 4) on fd 41 [10:2:17]
[main] Setsockopt(1 2f 68b000 4) on fd 43 [20:10:87]
[main] Setsockopt(1 1 68b000 4) on fd 45 [35:5:0]
[main] Setsockopt(116 7f 68b000 6b) on fd 46 [37:5:4]
[main] Setsockopt(1 2f 68b000 4) on fd 48 [2:2:0]
[main] Setsockopt(1 a 68b000 9a) on fd 49 [3:3:0]
[main] Setsockopt(100 1 68b000 4) on fd 50 [4:2:112]
[main] Setsockopt(1 6 68b000 4e) on fd 51 [5:3:46]
[main] Setsockopt(1 21 68b000 35) on fd 52 [8:3:47]
[main] Setsockopt(6 9 68b000 4) on fd 54 [10:1:0]
[main] Setsockopt(1 f 68b000 4) on fd 55 [17:10:768]
[main] Setsockopt(1 2c 68b000 4) on fd 56 [20:10:11]
[main] Setsockopt(1 23 68b000 6) on fd 57 [26:2:111]
[main] Setsockopt(116 7f 68b000 4) on fd 59 [37:1:5]
[main] Setsockopt(1 2c 68b000 7b) on fd 60 [1:1:1]
[main] Setsockopt(0 22 68b000 1) on fd 61 [2:1:0]
[main] Setsockopt(101 a 68b000 4) on fd 62 [3:3:0]
[main] Setsockopt(1 10 68b000 9a) on fd 64 [5:2:0]
[main] Setsockopt(1 a 68b000 4) on fd 65 [9:5:0]
[main] Setsockopt(29 3 0 5a) on fd 66 [10:2:17]
[main] Setsockopt(1 2d 68b000 4) on fd 67 [17:3:2053]
[main] Setsockopt(10c 9 68b000 4) on fd 69 [26:2:25]
[main] Setsockopt(1 8 68b000 cb) on fd 73 [1:1:1]
[main] Setsockopt(1 2d 68b000 4) on fd 74 [2:1:0]
[main] Setsockopt(1 d 68b000 8) on fd 75 [3:3:0]
[main] Setsockopt(1 6 68b000 63) on fd 78 [8:2:204]
[main] Setsockopt(1 23 68b000 cb) on fd 80 [10:3:42]
[main] Setsockopt(1 5 68b000 1c) on fd 81 [16:3:21]
[main] Setsockopt(107 11 68b000 4) on fd 82 [17:2:768]
[main] Setsockopt(1 a 68b000 4) on fd 83 [20:2:213]
[main] Setsockopt(1 1d 68b000 8f) on fd 85 [35:2:0]
[main] Setsockopt(1 7 68b000 61) on fd 86 [37:5:0]
[main] Setsockopt(1 6 68b000 da) on fd 88 [2:3:243]
[main] Setsockopt(101 4 68b000 4) on fd 89 [3:2:0]
[main] Setsockopt(100 1 68b000 4) on fd 90 [4:2:195]
[main] Setsockopt(1 6 68b000 4) on fd 92 [8:5:0]
[main] Setsockopt(29 12 68b000 d0) on fd 94 [10:3:116]
[main] Setsockopt(107 8 68b000 4) on fd 95 [17:3:768]
[main] Setsockopt(1 29 68b000 a2) on fd 96 [20:3:227]
[main] Setsockopt(1 28 68b000 b2) on fd 97 [26:2:202]
[main] Setsockopt(1 2d 68b000 4) on fd 98 [35:5:0]
[main] Setsockopt(1 7 68b000 4) on fd 99 [36:3:179]
[main] Setsockopt(101 c 68b000 4) on fd 103 [3:2:0]
[main] Setsockopt(1 23 68b000 4) on fd 104 [4:2:189]
[main] Setsockopt(108 42000004 68b000 4) on fd 106 [8:10:99]
[main] Setsockopt(1 9 68b000 b4) on fd 107 [9:5:0]
[main] Setsockopt(29 10 0 ce) on fd 108 [10:2:0]
[main] Setsockopt(1 22 68b000 4) on fd 109 [17:3:768]
[main] Setsockopt(1 2b 68b000 4) on fd 110 [20:2:214]
[main] Setsockopt(1 9 68b000 b5) on fd 111 [26:2:66]
[main] Setsockopt(1 b 68b000 4) on fd 112 [35:2:0]
[main] Setsockopt(1 7 68b000 c7) on fd 113 [37:1:0]
[main] Setsockopt(1 21 68b000 4) on fd 114 [1:5:1]
[main] Setsockopt(1 2c 68b000 43) on fd 115 [2:1:6]
[main] Setsockopt(1 1 68b000 b4) on fd 116 [4:2:255]
[main] Setsockopt(1 29 68b000 4) on fd 117 [5:2:0]
[main] Setsockopt(1 2e 68b000 ab) on fd 119 [9:5:0]
[main] Setsockopt(1 2d 68b000 d4) on fd 120 [10:1:0]
[main] Setsockopt(1 29 68b000 4) on fd 121 [16:2:10]
[main] Setsockopt(1 2e 68b000 4) on fd 122 [17:10:768]
[main] Setsockopt(1 23 68b000 8d) on fd 123 [20:10:219]
[main] Setsockopt(10c 2 68b000 4) on fd 124 [26:1:95]
[main] Setsockopt(116 7f 68b000 20) on fd 126 [37:1:0]
[main] Setsockopt(1 2e 68b000 4) on fd 127 [1:1:1]
[main] Setsockopt(101 8 68b000 67) on fd 129 [3:3:210]
[main] Setsockopt(100 1 68b000 4) on fd 130 [4:2:213]
[main] Setsockopt(29 1a 68b000 4) on fd 133 [10:1:0]
[main] Setsockopt(107 e 68b000 4) on fd 134 [17:2:768]
[main] Setsockopt(1 b 68b000 9b) on fd 135 [20:2:135]
[main] Setsockopt(1 c 68b000 c2) on fd 137 [35:2:0]
[main] Setsockopt(116 7f 68b000 cb) on fd 138 [37:5:1]
[main] Setsockopt(1 d 68b000 8) on fd 139 [1:5:1]
[main] Setsockopt(1 7 68b000 56) on fd 140 [2:1:6]
[main] Setsockopt(1 6 68b000 4) on fd 141 [3:5:195]
[main] Setsockopt(100 1 68b000 4) on fd 142 [4:2:254]
[main] Setsockopt(1 7 68b000 58) on fd 143 [5:2:0]
[main] Setsockopt(29 4 68b000 4) on fd 146 [10:1:0]
[main] Setsockopt(1 c 68b000 4) on fd 147 [17:2:768]
[main] Setsockopt(108 42000004 68b000 4) on fd 148 [20:4:53]
[main] Setsockopt(1 2b 68b000 8f) on fd 150 [35:2:0]
[main] Setsockopt(1 2f 68b000 4) on fd 153 [1:2:1]
[main] Setsockopt(11 1 68b000 4f) on fd 154 [2:2:0]
[main] Setsockopt(101 8 68b000 79) on fd 155 [3:2:0]
[main] Setsockopt(1 a 68b000 2c) on fd 156 [4:2:177]
[main] Setsockopt(1 28 68b000 4) on fd 157 [5:3:25]
[main] Setsockopt(29 2 0 75) on fd 160 [10:3:74]
[main] Setsockopt(107 c 68b000 4) on fd 161 [17:3:768]
[main] Setsockopt(1 9 68b000 4) on fd 162 [20:3:130]
[main] Setsockopt(1 12 68b000 4) on fd 163 [26:1:68]
[main] Setsockopt(1 b 68b000 4) on fd 164 [35:2:0]
[main] Setsockopt(1 20 68b000 4) on fd 166 [1:2:1]
[main] Setsockopt(1 10 68b000 4) on fd 167 [2:2:0]
[main] Setsockopt(1 2f 68b000 eb) on fd 169 [4:2:144]
[main] Setsockopt(1 b 68b000 4) on fd 171 [8:10:148]
[main] Setsockopt(1 b 68b000 4) on fd 172 [9:5:0]
[main] Setsockopt(1 2c 68b000 1b) on fd 173 [10:2:17]
[main] Setsockopt(1 10 68b000 fb) on fd 174 [17:2:22]
[main] Setsockopt(108 42000004 68b000 4) on fd 175 [20:3:140]
[main] Setsockopt(1 29 68b000 4) on fd 177 [35:5:0]
[main] Setsockopt(1 2b 68b000 4) on fd 178 [37:1:2]
[main] Setsockopt(11 1 68b000 4) on fd 180 [2:2:17]
[main] Setsockopt(1 2 68b000 5f) on fd 181 [3:3:17]
[main] Setsockopt(100 1 68b000 4) on fd 182 [4:2:35]
[main] Setsockopt(1 12 68b000 4) on fd 183 [5:2:0]
[main] Setsockopt(1 2f 68b000 42) on fd 184 [8:3:108]
[main] Setsockopt(1 20 68b000 2d) on fd 185 [9:5:0]
[main] Setsockopt(1 1d 68b000 1d) on fd 187 [17:3:768]
[main] Setsockopt(1 e 68b000 4) on fd 189 [26:1:215]
[main] Setsockopt(1 7 68b000 4) on fd 191 [37:1:1]
[main] Setsockopt(1 21 68b000 4) on fd 192 [1:1:1]
[main] Setsockopt(1 2a 68b000 4) on fd 193 [2:2:0]
[main] Setsockopt(101 5 68b000 74) on fd 194 [3:3:0]
[main] Setsockopt(1 8 68b000 4) on fd 195 [4:2:5]
[main] Setsockopt(1 a 68b000 b1) on fd 197 [8:5:98]
[main] Setsockopt(1 25 68b000 4) on fd 198 [9:5:0]
[main] Setsockopt(6 9 68b000 4) on fd 199 [10:1:0]
[main] Setsockopt(1 1d 68b000 d) on fd 200 [16:2:15]
[main] Setsockopt(1 2d 68b000 69) on fd 204 [35:5:0]
[main] Setsockopt(1 9 68b000 4) on fd 205 [37:1:2]
[main] Setsockopt(1 9 68b000 95) on fd 206 [1:5:1]
[main] Setsockopt(0 21 68b000 1) on fd 207 [2:3:148]
[main] Setsockopt(1 5 68b000 97) on fd 208 [3:2:0]
[main] Setsockopt(100 1 68b000 4) on fd 209 [4:2:75]
[main] Setsockopt(1 23 68b000 4) on fd 210 [5:2:0]
[main] Setsockopt(1 d 68b000 8) on fd 211 [9:5:0]
[main] Setsockopt(0 12 68b000 4) on fd 212 [10:2:17]
[main] Setsockopt(1 2e 68b000 f7) on fd 213 [16:2:21]
[main] Setsockopt(1 29 68b000 bc) on fd 214 [17:10:768]
[main] Setsockopt(1 29 68b000 4) on fd 215 [20:2:147]
[main] Setsockopt(1 5 68b000 4) on fd 216 [26:1:136]
[main] Setsockopt(1 f 68b000 4) on fd 217 [35:5:0]
[main] Setsockopt(1 21 68b000 8c) on fd 218 [37:5:4]
[main] Setsockopt(6 9 68b000 4) on fd 220 [2:1:6]
[main] Setsockopt(1 2d 68b000 4) on fd 221 [3:3:6]
[main] Setsockopt(1 2c 68b000 b6) on fd 222 [4:2:102]
[main] Setsockopt(1 23 68b000 4) on fd 227 [17:3:768]
[main] Setsockopt(1 2d 68b000 57) on fd 229 [26:2:0]
[main] Setsockopt(116 80 68b000 4) on fd 231 [37:1:3]
[main] Setsockopt(1 1d 68b000 36) on fd 232 [1:2:1]
[main] Setsockopt(0 3 68b000 4) on fd 233 [2:3:49]
[main] Setsockopt(101 5 68b000 b3) on fd 234 [3:2:0]
[main] Setsockopt(100 1 68b000 4) on fd 235 [4:2:29]
[main] Setsockopt(1 2b 68b000 4) on fd 237 [8:3:67]
[main] Setsockopt(1 5 68b000 4) on fd 238 [9:5:0]
[main] Setsockopt(1 2c 68b000 cc) on fd 239 [10:3:237]
[main] Setsockopt(1 c 68b000 4) on fd 240 [17:3:768]
[main] Setsockopt(1 1 68b000 4) on fd 243 [35:2:0]
[main] Setsockopt(1 25 68b000 f8) on fd 244 [37:5:3]
[main] Setsockopt(1 2c 68b000 5b) on fd 245 [1:5:1]
[main] Setsockopt(1 6 68b000 f7) on fd 246 [2:2:17]
[main] Setsockopt(101 c 68b000 7b) on fd 247 [3:3:17]
[main] Setsockopt(1 12 68b000 4) on fd 250 [9:5:0]
[main] Setsockopt(10c 6 68b000 4) on fd 254 [26:1:33]
[main] Setsockopt(1 2b 68b000 cb) on fd 256 [37:5:1]
[main] Setsockopt(1 29 68b000 4) on fd 258 [2:3:206]
[main] Setsockopt(1 9 68b000 39) on fd 259 [4:2:126]
[main] Setsockopt(1 5 68b000 6) on fd 261 [9:5:0]
[main] Setsockopt(29 8 0 7a) on fd 262 [10:3:241]
[main] Setsockopt(1 7 68b000 2b) on fd 266 [35:2:0]
[main] Setsockopt(1 2b 68b000 61) on fd 267 [36:3:187]
[main] Setsockopt(116 7f 68b000 fe) on fd 268 [37:5:1]
[main] Setsockopt(0 5 68b000 1) on fd 270 [2:3:171]
[main] Setsockopt(1 2b 68b000 4) on fd 271 [3:2:0]
[main] Setsockopt(1 2b 68b000 4) on fd 272 [4:2:113]
[main] Setsockopt(1 8 68b000 4) on fd 274 [8:3:55]
[main] Setsockopt(1 f 68b000 4) on fd 275 [9:5:0]
[main] Setsockopt(29 b 0 4a) on fd 276 [10:2:0]
[main] Setsockopt(107 e 68b000 4) on fd 277 [17:3:768]
[main] Setsockopt(1 2b 68b000 4) on fd 278 [20:5:227]
[main] Setsockopt(1 d 68b000 8) on fd 279 [26:1:149]
[main] Setsockopt(116 7f 68b000 4) on fd 281 [37:5:0]
[main] Setsockopt(1 22 68b000 4) on fd 282 [1:5:1]
[main] Setsockopt(88 64 68b000 4) on fd 283 [2:2:17]
[main] Setsockopt(1 24 68b000 c1) on fd 284 [3:5:203]
[main] Setsockopt(1 6 68b000 4) on fd 285 [4:2:173]
[main] Setsockopt(1 10 68b000 4) on fd 286 [5:2:0]
[main] Setsockopt(1 b 68b000 60) on fd 287 [8:5:64]
[main] Setsockopt(1 1d 68b000 4) on fd 288 [9:5:0]
[main] Setsockopt(29 5 0 9a) on fd 289 [10:2:0]
[main] Setsockopt(10e 5 68b000 4) on fd 290 [16:2:16]
[main] Setsockopt(1 22 68b000 89) on fd 293 [35:2:0]
[main] Setsockopt(1 2b 68b000 1a) on fd 294 [37:5:3]
[main] Setsockopt(1 5 68b000 4) on fd 295 [1:1:1]
[main] Setsockopt(0 31 68b000 4) on fd 296 [2:1:6]
[main] Setsockopt(1 6 68b000 54) on fd 297 [3:5:203]
[main] Setsockopt(1 25 68b000 4) on fd 300 [8:2:224]
[main] Setsockopt(1 12 68b000 18) on fd 302 [10:2:0]
[main] Setsockopt(1 2d 68b000 a9) on fd 303 [17:2:32923]
[main] Setsockopt(1 1 68b000 4) on fd 305 [26:1:159]
[main] Setsockopt(1 7 68b000 b3) on fd 307 [37:5:0]
[main] Setsockopt(1 d 68b000 8) on fd 309 [2:1:0]
[main] Setsockopt(1 2f 68b000 36) on fd 310 [3:2:0]
[main] Setsockopt(1 2b 68b000 4) on fd 312 [5:3:190]
[main] Setsockopt(108 42000004 68b000 4) on fd 313 [8:2:199]
[main] Setsockopt(29 17 0 fe) on fd 315 [10:2:0]
[main] Setsockopt(1 b 68b000 b5) on fd 317 [26:1:12]
[main] Setsockopt(1 5 68b000 7a) on fd 318 [35:2:0]
[main] Setsockopt(116 7f 68b000 4) on fd 320 [37:1:0]
[main] Setsockopt(1 1 68b000 4) on fd 321 [1:5:1]
[main] Setsockopt(0 21 68b000 1) on fd 322 [2:3:70]
[main] Setsockopt(1 22 68b000 61) on fd 323 [4:2:192]
[main] Setsockopt(1 5 68b000 4) on fd 324 [5:3:58]
[main] Setsockopt(29 4 0 c3) on fd 327 [10:1:0]
[main] Setsockopt(10e 5 68b000 3f) on fd 328 [16:3:15]
[main] Setsockopt(107 8 68b000 4) on fd 329 [17:2:768]
[main] Setsockopt(1 7 68b000 ba) on fd 331 [26:1:69]
[main] Setsockopt(1 21 68b000 4) on fd 332 [35:2:0]
[main] Setsockopt(1 1d 68b000 62) on fd 333 [36:2:81]
[main] Setsockopt(1 e 68b000 aa) on fd 337 [3:3:0]
[main] Setsockopt(100 1 68b000 4) on fd 338 [4:2:146]
[main] Setsockopt(1 8 68b000 4) on fd 339 [5:2:0]
[main] Setsockopt(1 6 68b000 4) on fd 341 [9:5:0]
[main] Setsockopt(1 12 68b000 15) on fd 342 [10:3:212]
[main] Setsockopt(1 22 68b000 4) on fd 346 [36:2:129]
[main] Setsockopt(1 2c 68b000 4) on fd 347 [37:1:1]
[main] Setsockopt(1 1d 68b000 4) on fd 349 [2:3:109]
[main] Setsockopt(101 2 68b000 4) on fd 350 [3:3:109]
[main] Setsockopt(100 1 68b000 4) on fd 351 [4:2:229]
[main] Setsockopt(1 21 68b000 4) on fd 352 [5:2:0]
[main] Setsockopt(1 c 68b000 5b) on fd 353 [8:3:202]
[main] Setsockopt(1 8 68b000 4) on fd 354 [9:5:0]
[main] Setsockopt(1 23 68b000 4) on fd 355 [10:2:0]
[main] Setsockopt(1 1d 68b000 4) on fd 356 [17:10:768]
[main] Setsockopt(1 6 68b000 4) on fd 357 [26:1:119]
[main] Setsockopt(1 2d 68b000 d6) on fd 359 [37:5:3]
[main] Setsockopt(6 3 68b000 4) on fd 361 [2:1:6]
[main] Setsockopt(1 24 68b000 7d) on fd 363 [4:2:130]
[main] Setsockopt(1 7 68b000 4) on fd 364 [5:2:0]
[main] Setsockopt(1 c 68b000 2c) on fd 365 [8:3:206]
[main] Setsockopt(6 3 68b000 4) on fd 367 [10:1:0]
[main] Setsockopt(1 24 68b000 73) on fd 368 [17:10:768]
[main] Setsockopt(1 5 68b000 4) on fd 371 [35:2:0]
[main] Setsockopt(1 8 68b000 a0) on fd 372 [36:2:130]
[main] Setsockopt(116 7f 68b000 4) on fd 373 [37:5:5]
[main] Setsockopt(1 b 68b000 f6) on fd 374 [1:1:1]
[main] Setsockopt(6 1 68b000 2a) on fd 375 [2:1:0]
[main] Setsockopt(1 2b 68b000 4) on fd 376 [3:5:195]
[main] Setsockopt(1 2c 68b000 28) on fd 377 [4:2:180]
[main] Setsockopt(1 c 68b000 4) on fd 378 [5:3:56]
[main] Setsockopt(1 d 68b000 8) on fd 379 [9:5:0]
[main] Setsockopt(29 5 0 83) on fd 380 [10:3:125]
[main] 375 sockets created based on info from socket cachefile.
[main] Generating file descriptors
[main] Added 83 filenames from /dev
udevd[507]: failed to execute '/sbin/modprobe' '/sbin/modprobe -bv platform:regulatory': No such file or directory
[  372.057947] caif:caif_disconnect_client(): nothing to disconnect
[  372.082415] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
[  372.083866] PGD 16e5b067 P4D 16e5b067 PUD 16cce067 PMD 0 
[  372.085033] Oops: 0000 [#1] SMP
[  372.085654] CPU: 1 PID: 494 Comm: trinity-main Not tainted 4.17.0-rc2 #171
[  372.086910] RIP: 0010:refcount_inc_not_zero+0x25/0x2f0
[  372.087918] RSP: 0018:ffff880016fb7d08 EFLAGS: 00010206
[  372.089279] RAX: ffff880016bd5f00 RBX: 0000000000000004 RCX: ffffffff818317ed
[  372.090142] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
[  372.091443] RBP: ffff880016f46878 R08: 0000000000000002 R09: 0000000000000000
[  372.093103] R10: 0000000001a0ae15 R11: 0000000011e52352 R12: 0000000000000004
[  372.094480] R13: 0000000000000000 R14: ffffffff84655070 R15: ffff88001f2f93c0
[  372.095848] FS:  00007fc0f65dc700(0000) GS:ffff88001d600000(0000) knlGS:0000000000000000
[  372.097643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  372.098736] CR2: 0000000000000004 CR3: 0000000016e5a000 CR4: 00000000000006a0
[  372.099978] DR0: 0000000000693000 DR1: 0000000000000000 DR2: 0000000000000000
[  372.101483] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  372.102856] Call Trace:
[  372.103434]  refcount_inc+0x19/0x190
[  372.104200]  llc_ui_release+0xf5/0x270
[  372.105122]  sock_release+0x56/0x120
[  372.105773]  ? sock_release+0x120/0x120
[  372.106490]  sock_close+0x1f/0x30
[  372.107176]  __fput+0x2e9/0x620
[  372.107858]  ____fput+0x1e/0x30
[  372.108526]  task_work_run+0x11a/0x180
[  372.109491]  do_exit+0xda4/0x2210
[  372.110171]  ? __do_page_fault+0xffe/0x1150
[  372.110677]  do_group_exit+0x1ce/0x1f0
[  372.111130]  __do_sys_exit_group+0x1b/0x20
[  372.111878]  __x64_sys_exit_group+0x1f/0x20
[  372.112655]  do_syscall_64+0x3c8/0x940
[  372.113612]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  372.114638] RIP: 0033:0x7fc0f60c1408
[  372.115389] RSP: 002b:00007fff057791b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[  372.117042] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc0f60c1408
[  372.118462] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[  372.119892] RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffffa0
[  372.121479] R10: 00007fff05778f50 R11: 0000000000000206 R12: 0000000000000005
[  372.122831] R13: 00007fff057793a0 R14: 0000000000000000 R15: 0000000000000000
[  372.124211] Code: 84 00 00 00 00 00 41 57 41 56 49 c7 c6 70 50 65 84 41 55 41 54 49 89 fc 55 53 48 83 ec 08 e8 a3 53 a4 ff 48 83 05 4b 01 9d 04 01 <45> 8b 2c 24 e8 92 53 a4 ff 31 c0 45 85 ed 41 8d 6d 01 0f 94 c0 
[  372.129128] RIP: refcount_inc_not_zero+0x25/0x2f0 RSP: ffff880016fb7d08
[  372.130205] CR2: 0000000000000004
[  372.130604] ---[ end trace a6d858cc768df5f2 ]---
[  372.131122] Kernel panic - not syncing: Fatal exception
[  372.131749] Kernel Offset: disabled

Elapsed time: 380

qemu-img create -f qcow2 disk-quantal-ivb41-78-0 256G
qemu-img create -f qcow2 disk-quantal-ivb41-78-1 256G
qemu-img create -f qcow2 disk-quantal-ivb41-78-2 256G
qemu-img create -f qcow2 disk-quantal-ivb41-78-3 256G
qemu-img create -f qcow2 disk-quantal-ivb41-78-4 256G
qemu-img create -f qcow2 disk-quantal-ivb41-78-5 256G
qemu-img create -f qcow2 disk-quantal-ivb41-78-6 256G

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd /osimage/quantal/quantal-core-x86_64.cgz
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-drive file=disk-quantal-ivb41-78-0,media=disk,if=virtio
	-drive file=disk-quantal-ivb41-78-1,media=disk,if=virtio
	-drive file=disk-quantal-ivb41-78-2,media=disk,if=virtio
	-drive file=disk-quantal-ivb41-78-3,media=disk,if=virtio
	-drive file=disk-quantal-ivb41-78-4,media=disk,if=virtio
	-drive file=disk-quantal-ivb41-78-5,media=disk,if=virtio
	-drive file=disk-quantal-ivb41-78-6,media=disk,if=virtio
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	branch=linux-devel/devel-hourly-2018042507
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-04251452/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--chst6szrdxt2yire
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.17.0-rc2 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_SANCOV=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_AMD is not set
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_DEVICE_PUBLIC=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_LOG_NETDEV is not set
# CONFIG_NF_TABLES is not set
# CONFIG_NETFILTER_XTABLES is not set
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUGFS=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=y
# CONFIG_YAM is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=y
CONFIG_NL80211_TESTMODE=y
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=y
CONFIG_LIB80211_DEBUG=y
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=y
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
CONFIG_CAIF_SPI_SLAVE=y
CONFIG_CAIF_SPI_SYNC=y
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_I40E is not set
# CONFIG_NET_VENDOR_I825XX is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
CONFIG_MLXSW_CORE=y
# CONFIG_MLXSW_CORE_HWMON is not set
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=y
# CONFIG_MLXSW_I2C is not set
CONFIG_MLXFW=y
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=y
CONFIG_KS8851_MLL=y
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_GPIO=y
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
CONFIG_AQUANTIA_PHY=y
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83822_PHY=y
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_PLIP=y
CONFIG_PPP=y
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_DEFLATE is not set
CONFIG_PPP_FILTER=y
# CONFIG_PPP_MPPE is not set
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPPOATM is not set
CONFIG_PPPOE=y
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=y
CONFIG_USB_LAN78XX=y
# CONFIG_USB_USBNET is not set
CONFIG_USB_HSO=y
CONFIG_USB_IPHETH=y
CONFIG_WLAN=y
CONFIG_WIRELESS_WDS=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_BRCMUTIL=y
CONFIG_BRCMFMAC=y
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_USB=y
# CONFIG_BRCMFMAC_PCIE is not set
# CONFIG_BRCM_TRACING is not set
CONFIG_BRCMDBG=y
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_LIBERTAS=y
CONFIG_LIBERTAS_USB=y
CONFIG_LIBERTAS_DEBUG=y
CONFIG_LIBERTAS_MESH=y
CONFIG_MWIFIEX=y
# CONFIG_MWIFIEX_PCIE is not set
CONFIG_MWIFIEX_USB=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# WiMAX Wireless Broadband devices
#
# CONFIG_WIMAX_I2400M_USB is not set
# CONFIG_WAN is not set
# CONFIG_IEEE802154_DRIVERS is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=y
# CONFIG_ISDN_PPP is not set
# CONFIG_ISDN_AUDIO is not set
# CONFIG_ISDN_X25 is not set

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=y

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=y

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
# CONFIG_DE_AOC is not set
CONFIG_HISAX_NO_SENDCOMPLETE=y
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
CONFIG_HISAX_FRITZPCI=y
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
CONFIG_HISAX_NICCY=y
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
CONFIG_HISAX_GAZEL=y
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
# CONFIG_HISAX_ST5481 is not set
CONFIG_HISAX_HFCUSB=y
CONFIG_HISAX_HFC4S8S=y
# CONFIG_HISAX_FRITZ_PCIPNP is not set
# CONFIG_ISDN_CAPI is not set
# CONFIG_ISDN_DRV_GIGASET is not set
CONFIG_MISDN=y
CONFIG_MISDN_DSP=y
CONFIG_MISDN_L1OIP=y

#
# mISDN hardware drivers
#
# CONFIG_MISDN_HFCPCI is not set
# CONFIG_MISDN_HFCMULTI is not set
CONFIG_MISDN_HFCUSB=y
# CONFIG_MISDN_AVMFRITZ is not set
# CONFIG_MISDN_SPEEDFAX is not set
# CONFIG_MISDN_INFINEON is not set
# CONFIG_MISDN_W6692 is not set
# CONFIG_MISDN_NETJET is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_MAX77693_HAPTIC=y
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_CMA3000=y
# CONFIG_INPUT_CMA3000_I2C is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
CONFIG_N_GSM=y
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_NVRAM is not set
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65086=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
CONFIG_AXP20X_POWER=y
# CONFIG_AXP288_CHARGER is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_LP8788=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_LTC3651=y
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_SILENT is not set
CONFIG_SSB_DEBUG=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_MM_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_PCM_OSS_PLUGINS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_USB is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LEDS is not set
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB is not set
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
# CONFIG_USBIP_VHCI_HCD is not set
CONFIG_USBIP_HOST=y
# CONFIG_USBIP_VUDC is not set
CONFIG_USBIP_DEBUG=y
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_PCI=y
# CONFIG_USB_CHIPIDEA_UDC is not set
# CONFIG_USB_CHIPIDEA_HOST is not set
# CONFIG_USB_CHIPIDEA_ULPI is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=y
CONFIG_USB_SERIAL_ARK3116=y
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=y
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=y
CONFIG_USB_SERIAL_EDGEPORT_TI=y
CONFIG_USB_SERIAL_F81232=y
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=y
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=y
# CONFIG_USB_SERIAL_MOS7715_PARPORT is not set
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
CONFIG_USB_SERIAL_QUALCOMM=y
# CONFIG_USB_SERIAL_SPCP8X5 is not set
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
CONFIG_USB_SERIAL_SYMBOL=y
CONFIG_USB_SERIAL_TI=y
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=y
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=y
CONFIG_USB_SPEEDTOUCH=y
# CONFIG_USB_CXACRU is not set
CONFIG_USB_UEAGLEATM=y
# CONFIG_USB_XUSBATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_DUMMY_HCD=y
CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_PHONET=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_SERIAL=y
# CONFIG_USB_CONFIGFS_ACM is not set
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_PHONET=y
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_UAC1 is not set
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
# CONFIG_USB_CONFIGFS_F_UAC2 is not set
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_ROLE_SWITCH=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=y
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IOATDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_IPX=y
CONFIG_IPX_INTERN=y
# CONFIG_NCP_FS is not set
CONFIG_PRISM2_USB=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=y
# CONFIG_COMEDI_DT9812 is not set
# CONFIG_COMEDI_NI_USB6501 is not set
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_R8712U=y

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=y

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7152=y
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#

#
# Digital gyroscope sensors
#

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set

#
# Light sensors
#
CONFIG_TSL2x7x=y

#
# Active energy metering IC
#
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y

#
# Resolver to digital converters
#
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_CRYPTO_SKEIN=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_MOST is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
CONFIG_BMA180=y
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=y
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
CONFIG_DA9150_GPADC=y
# CONFIG_DLN2_ADC is not set
CONFIG_HX711=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
CONFIG_TI_ADC081C=y
# CONFIG_TI_AM335X_ADC is not set
CONFIG_VIPERBOARD_ADC=y

#
# Amplifiers
#

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_VZ89X=y
CONFIG_IIO_CROS_EC_SENSORS_CORE=y
CONFIG_IIO_CROS_EC_SENSORS=y

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
CONFIG_DS4424=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MCP4725=y

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=y
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_IIO_ST_LSM6DSX is not set

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
CONFIG_CM36651=y
CONFIG_IIO_CROS_EC_LIGHT_PROX=y
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Multiplexers
#

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=y

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=y

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_IIO_CROS_EC_BARO=y
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
CONFIG_SX9500=y
# CONFIG_SRF08 is not set

#
# Temperature sensors
#
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_LP3943=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_QCOM_USB_HS=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_PSTORE is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
CONFIG_KCOV_INSTRUMENT_ALL=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
CONFIG_STACK_TRACER=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_UBSAN_NULL is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_TEMPLATE=y
# CONFIG_IMA_NG_TEMPLATE is not set
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
# CONFIG_IMA_APPRAISE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA1_MB=y
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_PRIME_NUMBERS=y
# CONFIG_STRING_SELFTEST is not set

--chst6szrdxt2yire
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-ivb41-78:20180425191426:x86_64-randconfig-s3-04251452:4.17.0-rc2:171"

#!/bin/bash

kernel=$1
initrd=quantal-core-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--chst6szrdxt2yire--
