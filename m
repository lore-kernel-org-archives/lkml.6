Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeDSFJs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:09:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:42664 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeDSFJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:09:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="44426259"
Date: Thu, 19 Apr 2018 13:09:39 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@mellanox.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: Re: [test_parman_move] watchdog: BUG: soft lockup - CPU#0 stuck for
 22s! [swapper:1]
Message-ID: <20180419050939.ha6bxrup7dmef375@wfg-t540p.sh.intel.com>
References: <20171130131620.rm7sndeoahgjm7jb@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20171130131620.rm7sndeoahgjm7jb@wfg-t540p.sh.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this problem is still in current mainline kernel.  Perhaps
adding cond_resched() somewhere in the code to stop the complaint?

On Thu, Nov 30, 2017 at 09:16:20PM +0800, Fengguang Wu wrote:
>Hello,
>
>FYI this happens in mainline kernel 4.15.0-rc1.
>It at least dates back to v4.12 .
>
>It occurs in 2 out of 2 boots.
>
>[   95.347718] test passed
>[   95.359028] test_printf: all 260 tests passed
>[   96.656859] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 3332
>[   96.770961] test_bitmap: all 460506 tests passed
>[   96.783469] test_uuid: all 18 tests passed
>[  124.230111] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:1]
>[  124.230111] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1 #360
>[  124.230111] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[  124.230111] task: d3430000 task.stack: d342c000
>[  124.230111] EIP: test_parman_move+0xe/0xb0:
>						test_parman_move at lib/test_parman.c:119
>[  124.230111] EFLAGS: 00200212 CPU: 0
>[  124.230111] EAX: d0c00000 EBX: 00000004 ECX: 00000930 EDX: 0000090c
>[  124.230111] ESI: d0740324 EDI: d359f680 EBP: d342dec4 ESP: d342debc
>[  124.230111]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
>[  124.230111] CR0: 80050033 CR2: 00000000 CR3: 02b2b000 CR4: 000006b0
>[  124.230111] Call Trace:
>[  124.230111]  parman_lsort_item_add+0x9d/0x190:
>						__list_del_entry at include/linux/list.h:117
>						 (inlined by) list_move_tail at include/linux/list.h:182
>						 (inlined by) parman_prio_shift_down at lib/parman.c:144
>						 (inlined by) parman_lsort_item_add at lib/parman.c:200
>[  124.230111]  parman_item_add+0x9/0x10:
>						parman_item_add at lib/parman.c:356
>[  124.230111]  test_parman_init+0x358/0x3b5:
>						test_parman_run at lib/test_parman.c:284
>						 (inlined by) test_parman_lsort at lib/test_parman.c:369
>						 (inlined by) test_parman_init at lib/test_parman.c:383
>[  124.230111]  ? test_uuid_init+0x1a9/0x1a9:
>						test_parman_init at lib/test_parman.c:382
>[  124.230111]  do_one_initcall+0x7c/0x10e:
>						do_one_initcall at init/main.c:826
>[  124.230111]  ? kernel_init_freeable+0xc3/0x15b:
>						do_initcall_level at init/main.c:891
>						 (inlined by) do_initcalls at init/main.c:900
>						 (inlined by) do_basic_setup at init/main.c:918
>						 (inlined by) kernel_init_freeable at init/main.c:1066
>[  124.230111]  kernel_init_freeable+0xe3/0x15b:
>						do_initcall_level at init/main.c:892
>						 (inlined by) do_initcalls at init/main.c:900
>						 (inlined by) do_basic_setup at init/main.c:918
>						 (inlined by) kernel_init_freeable at init/main.c:1066
>[  124.230111]  ? rest_init+0xc0/0xc0:
>						kernel_init at init/main.c:990
>[  124.230111]  kernel_init+0xb/0xf0:
>						kernel_init at init/main.c:995
>[  124.230111]  ? schedule_tail_wrapper+0x9/0xc:
>						schedule_tail_wrapper at arch/x86/entry/entry_32.S:267
>[  124.230111]  ret_from_fork+0x19/0x24:
>						ret_from_fork at arch/x86/entry/entry_32.S:299
>[  124.230111] Code: e8 48 5f c2 00 5d 85 c0 0f 94 c0 0f b6 c0 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 57 53 8b 5d 08 8b 40 04 c1 e3 02 <8d> 3c 90 89 fa 8d 04 88 89 d9 e8 a3 be c2 00 83 fb 08 89 da 73
>[  124.230111] Kernel panic - not syncing: softlockup: hung tasks
>[  124.230111] CPU: 0 PID: 1 Comm: swapper Tainted: G             L   4.15.0-rc1 #360
>[  124.230111] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[  124.230111] Call Trace:
>[  124.230111]  dump_stack+0x16/0x19:
>						dump_stack at lib/dump_stack.c:64
>[  124.230111]  panic+0x86/0x1bd:
>						panic at kernel/panic.c:194
>[  124.230111]  watchdog_timer_fn+0x1e7/0x1f0:
>						watchdog_timer_fn at kernel/watchdog.c:443
>[  124.230111]  ? watchdog+0x20/0x20:
>						watchdog_timer_fn at kernel/watchdog.c:340
>[  124.230111]  hrtimer_run_queues+0xf3/0x1d0:
>						__run_hrtimer at kernel/time/hrtimer.c:1211
>						 (inlined by) __hrtimer_run_queues at kernel/time/hrtimer.c:1275
>						 (inlined by) hrtimer_run_queues at kernel/time/hrtimer.c:1414
>[  124.230111]  run_local_timers+0x8/0x40:
>						run_local_timers at kernel/time/timer.c:1700
>[  124.230111]  update_process_times+0x22/0x50:
>						update_process_times at kernel/time/timer.c:1630
>[  124.230111]  tick_nohz_handler+0x66/0x100:
>						tick_nohz_handler at kernel/time/tick-sched.c:1068
>[  124.230111]  smp_apic_timer_interrupt+0x40/0x80:
>						exiting_irq at arch/x86/include/asm/apic.h:540
>						 (inlined by) smp_apic_timer_interrupt at arch/x86/kernel/apic/apic.c:1052
>[  124.230111]  ? irq_exit+0x2f/0xb0:
>						tick_irq_exit at kernel/softirq.c:385
>						 (inlined by) irq_exit at kernel/softirq.c:407
>[  124.230111]  apic_timer_interrupt+0x35/0x3c:
>						apic_timer_interrupt at arch/x86/include/asm/entry_arch.h:36
>[  124.230111] EIP: test_parman_move+0xe/0xb0:
>						test_parman_move at lib/test_parman.c:119
>[  124.230111] EFLAGS: 00200212 CPU: 0
>[  124.230111] EAX: d0c00000 EBX: 00000004 ECX: 00000930 EDX: 0000090c
>[  124.230111] ESI: d0740324 EDI: d359f680 EBP: d342dec4 ESP: d342debc
>[  124.230111]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
>[  124.230111]  parman_lsort_item_add+0x9d/0x190:
>						__list_del_entry at include/linux/list.h:117
>						 (inlined by) list_move_tail at include/linux/list.h:182
>						 (inlined by) parman_prio_shift_down at lib/parman.c:144
>						 (inlined by) parman_lsort_item_add at lib/parman.c:200
>[  124.230111]  parman_item_add+0x9/0x10:
>						parman_item_add at lib/parman.c:356
>[  124.230111]  test_parman_init+0x358/0x3b5:
>						test_parman_run at lib/test_parman.c:284
>						 (inlined by) test_parman_lsort at lib/test_parman.c:369
>						 (inlined by) test_parman_init at lib/test_parman.c:383
>[  124.230111]  ? test_uuid_init+0x1a9/0x1a9:
>						test_parman_init at lib/test_parman.c:382
>[  124.230111]  do_one_initcall+0x7c/0x10e:
>						do_one_initcall at init/main.c:826
>[  124.230111]  ? kernel_init_freeable+0xc3/0x15b:
>						do_initcall_level at init/main.c:891
>						 (inlined by) do_initcalls at init/main.c:900
>						 (inlined by) do_basic_setup at init/main.c:918
>						 (inlined by) kernel_init_freeable at init/main.c:1066
>[  124.230111]  kernel_init_freeable+0xe3/0x15b:
>						do_initcall_level at init/main.c:892
>						 (inlined by) do_initcalls at init/main.c:900
>						 (inlined by) do_basic_setup at init/main.c:918
>						 (inlined by) kernel_init_freeable at init/main.c:1066
>[  124.230111]  ? rest_init+0xc0/0xc0:
>						kernel_init at init/main.c:990
>[  124.230111]  kernel_init+0xb/0xf0:
>						kernel_init at init/main.c:995
>[  124.230111]  ? schedule_tail_wrapper+0x9/0xc:
>						schedule_tail_wrapper at arch/x86/entry/entry_32.S:267
>[  124.230111]  ret_from_fork+0x19/0x24:
>						ret_from_fork at arch/x86/entry/entry_32.S:299
>[  124.230111] Kernel Offset: disabled
>
>Attached the full dmesg, kconfig and reproduce scripts.
>
>Thanks,
>Fengguang

>early console in setup code
>early console in extract_kernel
>input_data: 0x02753080
>input_len: 0x00cdd49a
>output: 0x01000000
>output_len: 0x01cc4624
>kernel_total_size: 0x02835000
>
>Decompressing Linux... Parsing ELF... No relocation needed... done.
>Booting the kernel.
>[    0.000000] Linux version 4.15.0-rc1 (kbuild@xian) (gcc version 5.4.1 20171010 (Debian 5.5.0-3)) #360 Wed Nov 29 18:13:29 CST 2017
>[    0.000000] x86/fpu: x87 FPU will use FXSAVE
>[    0.000000] e820: BIOS-provided physical RAM map:
>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
>[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
>[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000013fdbfff] usable
>[    0.000000] BIOS-e820: [mem 0x0000000013fdc000-0x0000000013ffffff] reserved
>[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
>[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
>[    0.000000] debug: ignoring loglevel setting.
>[    0.000000] bootconsole [earlyser0] enabled
>[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
>[    0.000000] random: fast init done
>[    0.000000] SMBIOS 2.8 present.
>[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[    0.000000] Hypervisor detected: KVM
>[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
>[    0.000000] e820: last_pfn = 0x13fdc max_arch_pfn = 0x1000000
>[    0.000000] MTRR: Disabled
>[    0.000000] x86/PAT: MTRRs disabled, skipping PAT initialization too.
>[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
>[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
>[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
>[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
>[    0.000000] found SMP MP-table at [mem 0x000f6a90-0x000f6a9f] mapped at [ffc00a90]
>[    0.000000]   mpc: f6aa0-f6b80
>[    0.000000] initial memory mapped: [mem 0x00000000-0x03bfffff]
>[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
>[    0.000000] BRK [0x0362a000, 0x0362afff] PGTABLE
>[    0.000000] BRK [0x0362b000, 0x0362bfff] PGTABLE
>[    0.000000] RAMDISK: [mem 0x13bf2000-0x13fcffff]
>[    0.000000] ACPI: Early table checksum verification disabled
>[    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
>[    0.000000] ACPI: RSDT 0x0000000013FE15CE 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
>[    0.000000] ACPI: FACP 0x0000000013FE142A 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
>[    0.000000] ACPI: DSDT 0x0000000013FE0040 0013EA (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
>[    0.000000] ACPI: FACS 0x0000000013FE0000 000040
>[    0.000000] ACPI: APIC 0x0000000013FE151E 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
>[    0.000000] ACPI: HPET 0x0000000013FE1596 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
>[    0.000000] ACPI: Local APIC address 0xfee00000
>[    0.000000] mapped APIC to         ffffc000 (        fee00000)
>[    0.000000] 0MB HIGHMEM available.
>[    0.000000] 319MB LOWMEM available.
>[    0.000000]   mapped low ram: 0 - 13fdc000
>[    0.000000]   low ram: 0 - 13fdc000
>[    0.000000] cma: dma_contiguous_reserve(limit 13fdc000)
>[    0.000000] kvm-clock: cpu 0, msr 0:13fda001, primary cpu clock
>[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
>[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>[    0.000000] Zone ranges:
>[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>[    0.000000]   Normal   [mem 0x0000000001000000-0x0000000013fdbfff]
>[    0.000000]   HighMem  empty
>[    0.000000] Movable zone start for each node
>[    0.000000] Early memory node ranges
>[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
>[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000013fdbfff]
>[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000013fdbfff]
>[    0.000000] On node 0 totalpages: 81786
>[    0.000000]   DMA zone: 32 pages used for memmap
>[    0.000000]   DMA zone: 0 pages reserved
>[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
>[    0.000000]   Normal zone: 608 pages used for memmap
>[    0.000000]   Normal zone: 77788 pages, LIFO batch:15
>[    0.000000] Reserved but unavailable: 98 pages
>[    0.000000] Using APIC driver default
>[    0.000000] ACPI: PM-Timer IO Port: 0x608
>[    0.000000] ACPI: Local APIC address 0xfee00000
>[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
>[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
>[    0.000000] ACPI: IRQ0 used by override.
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
>[    0.000000] ACPI: IRQ5 used by override.
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
>[    0.000000] ACPI: IRQ9 used by override.
>[    0.000000] ACPI: IRQ10 used by override.
>[    0.000000] ACPI: IRQ11 used by override.
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
>[    0.000000] Using ACPI (MADT) for SMP configuration information
>[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
>[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
>[    0.000000] KVM setup async PF for cpu 0
>[    0.000000] kvm-stealtime: cpu 0, msr 27f1f00
>[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
>[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
>[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
>[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
>[    0.000000] e820: [mem 0x14000000-0xfeffbfff] available for PCI devices
>[    0.000000] Booting paravirtualized kernel on KVM
>[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
>[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
>[    0.000000] pcpu-alloc: [0] 0
>[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 81146
>[    0.000000] Kernel command line: ip=::::vm-lkp-wsx03-openwrt-i386-23::dhcp root=/dev/ram0 user=lkp job=/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-23/trinity-300s-openwrt-i386-2016-03-16.cgz-4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323-20171129-81955-j5mius-0.yaml ARCH=i386 kconfig=i386-randconfig-x0-11291749 branch=linus/master commit=4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323 BOOT_IMAGE=/pkg/linux/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/vmlinuz-4.15.0-rc1 max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/0 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=nor
>[    0.000000] sysrq: sysrq always enabled.
>[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>[    0.000000] Initializing CPU#0
>[    0.000000] allocated 331628 bytes of page_ext
>[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
>[    0.000000] Memory: 280688K/327144K available (18138K kernel code, 2576K rwdata, 6200K rodata, 708K init, 11148K bss, 46456K reserved, 0K cma-reserved, 0K highmem)
>[    0.000000] virtual kernel memory layout:
>[    0.000000]     fixmap  : 0xfff8c000 - 0xfffff000   ( 460 kB)
>[    0.000000]     pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
>[    0.000000]     vmalloc : 0xd47dc000 - 0xffbfe000   ( 692 MB)
>[    0.000000]     lowmem  : 0xc0000000 - 0xd3fdc000   ( 319 MB)
>[    0.000000]       .init : 0xc2a77000 - 0xc2b28000   ( 708 kB)
>[    0.000000]       .data : 0xc21b6b18 - 0xc2a51080   (8809 kB)
>[    0.000000]       .text : 0xc1000000 - 0xc21b6b18   (18138 kB)
>[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
>[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>[    0.001000] NR_IRQS: 2304, nr_irqs: 48, preallocated irqs: 16
>[    0.001000] CPU 0 irqstacks, hard=d340e000 soft=d3410000
>[    0.001000] Console: colour VGA+ 80x25
>[    0.001000] console [tty0] enabled
>[    0.001000] console [ttyS0] enabled
>[    0.001000] bootconsole [earlyser0] disabled
>[    0.001000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
>[    0.001000] ... MAX_LOCKDEP_SUBCLASSES:  8
>[    0.001000] ... MAX_LOCK_DEPTH:          48
>[    0.001000] ... MAX_LOCKDEP_KEYS:        8191
>[    0.001000] ... CLASSHASH_SIZE:          4096
>[    0.001000] ... MAX_LOCKDEP_ENTRIES:     32768
>[    0.001000] ... MAX_LOCKDEP_CHAINS:      65536
>[    0.001000] ... CHAINHASH_SIZE:          32768
>[    0.001000]  memory used by lock dependency info: 4639 kB
>[    0.001000]  per task-struct memory footprint: 2112 bytes
>[    0.001000] ACPI: Core revision 20170831
>[    0.001000] ACPI: 1 ACPI AML tables successfully acquired and loaded
>[    0.001000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
>[    0.001000] hpet clockevent registered
>[    0.002068] APIC: Switch to symmetric I/O mode setup
>[    0.006064] Enabling APIC mode:  Flat.  Using 1 I/O APICs
>[    0.011920] enabled ExtINT on CPU#0
>[    0.096101] ENABLING IO-APIC IRQs
>[    0.098139] init IO_APIC IRQs
>[    0.100068]  apic 0 pin 0 not connected
>[    0.102159] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
>[    0.105160] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
>[    0.106000] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
>[    0.106000]  apic 0 pin 16 not connected
>[    0.106000]  apic 0 pin 17 not connected
>[    0.106000]  apic 0 pin 18 not connected
>[    0.106000]  apic 0 pin 19 not connected
>[    0.106000]  apic 0 pin 20 not connected
>[    0.106000]  apic 0 pin 21 not connected
>[    0.106000]  apic 0 pin 22 not connected
>[    0.106000]  apic 0 pin 23 not connected
>[    0.106000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>[    0.106000] tsc: Detected 2260.996 MHz processor
>[    0.107062] Calibrating delay loop (skipped) preset value.. 4521.99 BogoMIPS (lpj=2260996)
>[    0.108089] pid_max: default: 32768 minimum: 301
>[    0.119070] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>[    0.121169] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>[    0.131458] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
>[    0.132191] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
>[    0.133066] CPU: Intel QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
>[    0.154454] Performance Events: PMU not available due to virtualization, using software events only.
>[    0.232063] NMI watchdog: Perf event create on CPU 0 failed with -2
>[    0.233432] NMI watchdog: Perf NMI watchdog permanently disabled
>[    0.236397] Using local APIC timer interrupts.
>[    0.236397] calibrating APIC timer ...
>[    0.239000] ... lapic delta = 6252318
>[    0.239000] ... PM-Timer delta = 357822
>[    0.239000] ... PM-Timer result ok
>[    0.239000] ..... delta 6252318
>[    0.239000] ..... mult: 268535013
>[    0.239000] ..... calibration result: 1000370
>[    0.239000] ..... CPU clock speed is 2260.0958 MHz.
>[    0.239000] ..... host bus clock speed is 1000.0370 MHz.
>[    0.241754] devtmpfs: initialized
>[    0.279515] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
>[    0.280162] futex hash table entries: 256 (order: 1, 13312 bytes)
>[    0.282411] xor: measuring software checksum speed
>[    0.293054]    pIII_sse  :  1104.000 MB/sec
>[    0.304033]    prefetch64-sse:  1288.000 MB/sec
>[    0.305060] xor: using function: prefetch64-sse (1288.000 MB/sec)
>[    0.308521] regulator-dummy: no parameters
>[    0.313930] NET: Registered protocol family 16
>[    0.334517] audit: initializing netlink subsys (disabled)
>[    0.340000] cpuidle: using governor ladder
>[    0.340267] audit: type=2000 audit(1511952696.470:1): state=initialized audit_enabled=0 res=1
>[    0.341041] cpuidle: using governor menu
>[    0.359453] ACPI: bus type PCI registered
>[    0.371575] PCI: PCI BIOS revision 2.10 entry at 0xfd501, last bus=0
>[    0.373057] PCI: Using configuration type 1 for base access
>[    0.662102] raid6: mmxx1    gen()   296 MB/s
>[    0.680057] raid6: mmxx2    gen()   339 MB/s
>[    0.699231] raid6: sse1x1   gen()   238 MB/s
>[    0.718132] raid6: sse1x2   gen()   292 MB/s
>[    0.736122] raid6: sse2x1   gen()   511 MB/s
>[    0.754060] raid6: sse2x1   xor()   419 MB/s
>[    0.772102] raid6: sse2x2   gen()   621 MB/s
>[    0.790067] raid6: sse2x2   xor()   474 MB/s
>[    0.791132] raid6: using algorithm sse2x2 gen() 621 MB/s
>[    0.793036] raid6: .... xor() 474 MB/s, rmw enabled
>[    0.794037] raid6: using intx1 recovery algorithm
>[    0.799258] ACPI: Added _OSI(Module Device)
>[    0.800129] ACPI: Added _OSI(Processor Device)
>[    0.801040] ACPI: Added _OSI(3.0 _SCP Extensions)
>[    0.802061] ACPI: Added _OSI(Processor Aggregator Device)
>[    0.847000] ACPI: Interpreter enabled
>[    0.848130] ACPI: (supports S0 S4 S5)
>[    0.849091] ACPI: Using IOAPIC for interrupt routing
>[    0.851255] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>[    0.857000] ACPI: Enabled 2 GPEs in block 00 to 0F
>[    0.983185] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>[    0.985096] acpi PNP0A03:00: _OSC: OS supports [Segments]
>[    0.986255] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
>[    0.987159] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
>[    0.989802] PCI host bridge to bus 0000:00
>[    0.990065] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>[    0.991069] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>[    0.992067] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>[    0.993064] pci_bus 0000:00: root bus resource [mem 0x14000000-0xfebfffff window]
>[    0.994087] pci_bus 0000:00: root bus resource [bus 00-ff]
>[    0.996035] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
>[    1.008693] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
>[    1.021459] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
>[    1.036000] pci 0000:00:01.1: reg 0x20: [io  0xc0c0-0xc0cf]
>[    1.042379] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
>[    1.043095] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
>[    1.044068] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
>[    1.045094] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
>[    1.052173] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
>[    1.061628] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
>[    1.063037] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
>[    1.072426] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
>[    1.077000] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
>[    1.082000] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
>[    1.094000] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
>[    1.102268] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
>[    1.107000] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
>[    1.112000] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
>[    1.126000] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
>[    1.134306] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
>[    1.140000] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
>[    1.144000] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
>[    1.154000] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
>[    1.176207] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
>[    1.182000] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
>[    1.184000] pci 0000:00:05.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
>[    1.192000] pci 0000:00:05.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit pref]
>[    1.210344] pci 0000:00:06.0: [8086:25ab] type 00 class 0x088000
>[    1.215000] pci 0000:00:06.0: reg 0x10: [mem 0xfebf3000-0xfebf300f]
>[    1.240402] pci_bus 0000:00: on NUMA node 0
>[    1.252746] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
>[    1.256516] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
>[    1.260420] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
>[    1.264287] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
>[    1.266777] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
>[    1.279593] pci 0000:00:02.0: vgaarb: setting as boot VGA device
>[    1.280000] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>[    1.280092] pci 0000:00:02.0: vgaarb: bridge control possible
>[    1.281038] vgaarb: loaded
>[    1.287871] SCSI subsystem initialized
>[    1.289326] libata version 3.00 loaded.
>[    1.290767] ACPI: bus type USB registered
>[    1.291422] usbcore: registered new interface driver usbfs
>[    1.294151] usbcore: registered new interface driver hub
>[    1.295527] usbcore: registered new device driver usb
>[    1.298321] media: Linux media interface: v0.10
>[    1.300194] Linux video capture interface: v2.00
>[    1.302653] pps_core: LinuxPPS API ver. 1 registered
>[    1.303061] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
>[    1.304228] PTP clock support registered
>[    1.306258] EDAC MC: Ver: 3.0.0
>[    1.312161] EDAC DEBUG: edac_mc_sysfs_init: device mc created
>[    1.314750] dell_smbios: Unable to run on non-Dell system
>[    1.317711] FPGA manager framework
>[    1.319107] PCI: Using ACPI for IRQ routing
>[    1.320061] PCI: pci_cache_line_size set to 32 bytes
>[    1.324287] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
>[    1.325152] e820: reserve RAM buffer [mem 0x13fdc000-0x13ffffff]
>[    1.329872] NET: Registered protocol family 8
>[    1.331056] NET: Registered protocol family 20
>[    1.350894] clocksource: Switched to clocksource kvm-clock
>[    1.368848] VFS: Disk quotas dquot_6.6.0
>[    1.379822] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>[    1.397915] FS-Cache: Loaded
>[    1.407470] CacheFiles: Loaded
>[    1.416866] pnp: PnP ACPI init
>[    1.426977] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
>[    1.443508] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
>[    1.471024] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
>[    1.507829] pnp 00:03: [dma 2]
>[    1.518100] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
>[    1.553912] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
>[    1.597480] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
>[    1.622968] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
>[    1.684350] pnp: PnP ACPI: found 7 devices
>[    1.874492] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
>[    1.930054] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>[    1.956494] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
>[    1.981998] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
>[    2.021437] pci_bus 0000:00: resource 7 [mem 0x14000000-0xfebfffff window]
>[    2.056295] NET: Registered protocol family 2
>[    2.086729] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
>[    2.112062] TCP bind hash table entries: 4096 (order: 5, 180224 bytes)
>[    2.150634] TCP: Hash tables configured (established 4096 bind 4096)
>[    2.185241] UDP hash table entries: 256 (order: 2, 24576 bytes)
>[    2.215453] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes)
>[    2.258678] NET: Registered protocol family 1
>[    2.282683] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
>[    2.307712] pci 0000:00:01.0: PIIX3: Enabling Passive Release
>[    2.343220] pci 0000:00:01.0: Activating ISA DMA hang workarounds
>[    2.358946] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>[    2.380070] PCI: CLS 0 bytes, default 32
>[    2.392023] Trying to unpack rootfs image as initramfs...
>[    8.291061] Freeing initrd memory: 3960K
>[    8.339990] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
>[    8.357889] apm: overridden by ACPI.
>[    8.372815] PCLMULQDQ-NI instructions are not detected.
>[    8.387488] The force parameter has not been set to 1. The Iris poweroff handler will not be installed.
>[   15.015491] Initialise system trusted keyrings
>[   15.037379] Key type blacklist registered
>[   15.053437] workingset: timestamp_bits=30 max_order=17 bucket_order=0
>[   15.204615] zbud: loaded
>[   15.229295] DLM installed
>[   15.249754] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>[   15.307051] qnx6: QNX6 filesystem 1.0.0 registered.
>[   15.320402] fuse init (API version 7.26)
>[   15.338261] orangefs_debugfs_init: called with debug mask: :none: :0:
>[   15.364765] orangefs_init: module version upstream loaded
>[   15.410846] JFS: nTxBlock = 2223, nTxLock = 17790
>[   15.447431] NILFS version 2 loaded
>[   15.481283] ocfs2: Registered cluster interface user
>[   15.513374] OCFS2 User DLM kernel interface loaded
>[   15.639340] NET: Registered protocol family 38
>[   15.664289] Key type asymmetric registered
>[   15.688369] Asymmetric key parser 'x509' registered
>[   15.702179] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
>[   15.722273] io scheduler noop registered (default)
>[   15.737429] io scheduler cfq registered
>[   15.759174] io scheduler mq-deadline registered
>[   15.782894] io scheduler kyber registered
>[   20.024725] String selftests succeeded
>[   20.044036] test_string_helpers: Running tests...
>[   20.083825] test_hexdump: all 1184 tests passed
>[   20.297062] test_hash: __hash_32() has no arch implementation to test.
>[   20.327974] test_hash: hash_32() has no arch implementation to test.
>[   20.357758] test_hash: hash_64() has no arch implementation to test.
>[   20.391786] test_hash: 33152 tests passed.
>[   20.415743] test_siphash: self-tests: pass
>[   20.456988] Running rhashtable test nelem=8, max_size=0, shrinking=0
>[   20.488623] Test 00:
>[   20.503876]   Adding 50000 keys
>[   23.569993]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   24.134229]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   24.174860]   Deleting 50000 keys
>[   24.832636]   Duration of test: 4310524039 ns
>[   24.844696] Test 01:
>[   24.852787]   Adding 50000 keys
>[   26.136621]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   26.664988]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   26.715315]   Deleting 50000 keys
>[   27.801930]   Duration of test: 2940016871 ns
>[   27.813784] Test 02:
>[   27.822184]   Adding 50000 keys
>[   29.056979]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   29.509726]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   29.530167]   Deleting 50000 keys
>[   30.085066]   Duration of test: 2253196798 ns
>[   30.095985] Test 03:
>[   30.102825]   Adding 50000 keys
>[   31.585403]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   31.983858]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[   32.004184]   Deleting 50000 keys
>[   32.686077]   Duration of test: 2574862752 ns
>[   32.949370] test if its possible to exceed max_size 8192: no, ok
>[   32.965838] Average test time: 3019650115
>[   32.977217] Testing concurrent rhashtable access from 10 threads
>[   94.666183] test 3125 add/delete pairs into rhlist
>[   95.069229] test 3125 random rhlist add/delete operations
>[   95.330726] Started 10 threads, 0 failed, rhltable test returns 0
>[   95.347718] test passed
>[   95.359028] test_printf: all 260 tests passed
>[   96.656859] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 3332
>[   96.770961] test_bitmap: all 460506 tests passed
>[   96.783469] test_uuid: all 18 tests passed
>[  124.230111] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:1]
>[  124.230111] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1 #360
>[  124.230111] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[  124.230111] task: d3430000 task.stack: d342c000
>[  124.230111] EIP: test_parman_move+0xe/0xb0
>[  124.230111] EFLAGS: 00200212 CPU: 0
>[  124.230111] EAX: d0c00000 EBX: 00000004 ECX: 00000930 EDX: 0000090c
>[  124.230111] ESI: d0740324 EDI: d359f680 EBP: d342dec4 ESP: d342debc
>[  124.230111]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
>[  124.230111] CR0: 80050033 CR2: 00000000 CR3: 02b2b000 CR4: 000006b0
>[  124.230111] Call Trace:
>[  124.230111]  parman_lsort_item_add+0x9d/0x190
>[  124.230111]  parman_item_add+0x9/0x10
>[  124.230111]  test_parman_init+0x358/0x3b5
>[  124.230111]  ? test_uuid_init+0x1a9/0x1a9
>[  124.230111]  do_one_initcall+0x7c/0x10e
>[  124.230111]  ? kernel_init_freeable+0xc3/0x15b
>[  124.230111]  kernel_init_freeable+0xe3/0x15b
>[  124.230111]  ? rest_init+0xc0/0xc0
>[  124.230111]  kernel_init+0xb/0xf0
>[  124.230111]  ? schedule_tail_wrapper+0x9/0xc
>[  124.230111]  ret_from_fork+0x19/0x24
>[  124.230111] Code: e8 48 5f c2 00 5d 85 c0 0f 94 c0 0f b6 c0 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 57 53 8b 5d 08 8b 40 04 c1 e3 02 <8d> 3c 90 89 fa 8d 04 88 89 d9 e8 a3 be c2 00 83 fb 08 89 da 73
>[  124.230111] Kernel panic - not syncing: softlockup: hung tasks
>[  124.230111] CPU: 0 PID: 1 Comm: swapper Tainted: G             L   4.15.0-rc1 #360
>[  124.230111] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[  124.230111] Call Trace:
>[  124.230111]  dump_stack+0x16/0x19
>[  124.230111]  panic+0x86/0x1bd
>[  124.230111]  watchdog_timer_fn+0x1e7/0x1f0
>[  124.230111]  ? watchdog+0x20/0x20
>[  124.230111]  hrtimer_run_queues+0xf3/0x1d0
>[  124.230111]  run_local_timers+0x8/0x40
>[  124.230111]  update_process_times+0x22/0x50
>[  124.230111]  tick_nohz_handler+0x66/0x100
>[  124.230111]  smp_apic_timer_interrupt+0x40/0x80
>[  124.230111]  ? irq_exit+0x2f/0xb0
>[  124.230111]  apic_timer_interrupt+0x35/0x3c
>[  124.230111] EIP: test_parman_move+0xe/0xb0
>[  124.230111] EFLAGS: 00200212 CPU: 0
>[  124.230111] EAX: d0c00000 EBX: 00000004 ECX: 00000930 EDX: 0000090c
>[  124.230111] ESI: d0740324 EDI: d359f680 EBP: d342dec4 ESP: d342debc
>[  124.230111]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
>[  124.230111]  parman_lsort_item_add+0x9d/0x190
>[  124.230111]  parman_item_add+0x9/0x10
>[  124.230111]  test_parman_init+0x358/0x3b5
>[  124.230111]  ? test_uuid_init+0x1a9/0x1a9
>[  124.230111]  do_one_initcall+0x7c/0x10e
>[  124.230111]  ? kernel_init_freeable+0xc3/0x15b
>[  124.230111]  kernel_init_freeable+0xe3/0x15b
>[  124.230111]  ? rest_init+0xc0/0xc0
>[  124.230111]  kernel_init+0xb/0xf0
>[  124.230111]  ? schedule_tail_wrapper+0x9/0xc
>[  124.230111]  ret_from_fork+0x19/0x24
>[  124.230111] Kernel Offset: disabled
>
>Elapsed time: 40
>
>#!/bin/bash
>
># To reproduce,
># 1) save job-script and this script (both are attached in 0day report email)
># 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH
>
>kernel=$1
>
>initrds=(
>	/osimage/openwrt/openwrt-i386-2016-03-16.cgz
>	/lkp/lkp/lkp-i386.cgz
>	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-i386-x86_64-6ddabfd2_2017-11-10.cgz
>)
>
>HTTP_PREFIX=https://github.com/0day-ci/lkp-qemu/raw/master
>wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
>
>{
>	cat "${initrds[@]//*\//}"
>	[[ $INSTALL_MOD_PATH ]] && (
>		cd "$INSTALL_MOD_PATH"
>		find lib | cpio -o -H newc --quiet | gzip
>	)
>	echo  job-script | cpio -o -H newc --quiet | gzip
>} > initrd.img
>
>qemu-img create -f qcow2 disk-vm-lkp-wsx03-openwrt-i386-23-0 256G
>qemu-img create -f qcow2 disk-vm-lkp-wsx03-openwrt-i386-23-1 256G
>
>kvm=(
>	qemu-system-i386
>	-enable-kvm
>	-kernel $kernel
>	-initrd initrd.img
>	-m 320
>	-smp 1
>	-device e1000,netdev=net0
>	-netdev user,id=net0
>	-boot order=nc
>	-no-reboot
>	-watchdog i6300esb
>	-watchdog-action debug
>	-rtc base=localtime
>	-drive file=disk-vm-lkp-wsx03-openwrt-i386-23-0,media=disk,if=virtio
>	-drive file=disk-vm-lkp-wsx03-openwrt-i386-23-1,media=disk,if=virtio
>	-serial stdio
>	-display none
>	-monitor null
>)
>
>append=(
>	ip=::::vm-lkp-wsx03-openwrt-i386-23::dhcp
>	root=/dev/ram0
>	user=lkp
>	job=/job-script
>	ARCH=i386
>	kconfig=i386-randconfig-x0-11291749
>	branch=linus/master
>	commit=4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
>	BOOT_IMAGE=/pkg/linux/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/vmlinuz-4.15.0-rc1
>	max_uptime=1500
>	RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/0
>	result_service=tmpfs
>	debug
>	apic=debug
>	sysrq_always_enabled
>	rcupdate.rcu_cpu_stall_timeout=100
>	net.ifnames=0
>	printk.devkmsg=on
>	panic=-1
>	softlockup_panic=1
>	nmi_watchdog=panic
>	oops=panic
>	load_ramdisk=2
>	prompt_ramdisk=0
>	drbd.minor_count=8
>	systemd.log_level=err
>	ignore_loglevel
>	console=tty0
>	earlyprintk=ttyS0,115200
>	console=ttyS0,115200
>	vga=normal
>	rw
>	drbd.minor_count=8
>)
>
>"${kvm[@]}" -append "${append[*]}"

>#
># Automatically generated file; DO NOT EDIT.
># Linux/i386 4.15.0-rc1 Kernel Configuration
>#
># CONFIG_64BIT is not set
>CONFIG_X86_32=y
>CONFIG_X86=y
>CONFIG_INSTRUCTION_DECODER=y
>CONFIG_OUTPUT_FORMAT="elf32-i386"
>CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
>CONFIG_LOCKDEP_SUPPORT=y
>CONFIG_STACKTRACE_SUPPORT=y
>CONFIG_MMU=y
>CONFIG_ARCH_MMAP_RND_BITS_MIN=8
>CONFIG_ARCH_MMAP_RND_BITS_MAX=16
>CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
>CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
>CONFIG_NEED_DMA_MAP_STATE=y
>CONFIG_NEED_SG_DMA_LENGTH=y
>CONFIG_GENERIC_ISA_DMA=y
>CONFIG_GENERIC_BUG=y
>CONFIG_GENERIC_HWEIGHT=y
>CONFIG_ARCH_MAY_HAVE_PC_FDC=y
>CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>CONFIG_GENERIC_CALIBRATE_DELAY=y
>CONFIG_ARCH_HAS_CPU_RELAX=y
>CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
>CONFIG_HAVE_SETUP_PER_CPU_AREA=y
>CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
>CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
>CONFIG_ARCH_HIBERNATION_POSSIBLE=y
>CONFIG_ARCH_SUSPEND_POSSIBLE=y
>CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
>CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
>CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
>CONFIG_X86_32_LAZY_GS=y
>CONFIG_ARCH_SUPPORTS_UPROBES=y
>CONFIG_FIX_EARLYCON_MEM=y
>CONFIG_PGTABLE_LEVELS=3
>CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>CONFIG_IRQ_WORK=y
>CONFIG_BUILDTIME_EXTABLE_SORT=y
>CONFIG_THREAD_INFO_IN_TASK=y
>
>#
># General setup
>#
>CONFIG_BROKEN_ON_SMP=y
>CONFIG_INIT_ENV_ARG_LIMIT=32
>CONFIG_CROSS_COMPILE=""
># CONFIG_COMPILE_TEST is not set
>CONFIG_LOCALVERSION=""
>CONFIG_LOCALVERSION_AUTO=y
>CONFIG_HAVE_KERNEL_GZIP=y
>CONFIG_HAVE_KERNEL_BZIP2=y
>CONFIG_HAVE_KERNEL_LZMA=y
>CONFIG_HAVE_KERNEL_XZ=y
>CONFIG_HAVE_KERNEL_LZO=y
>CONFIG_HAVE_KERNEL_LZ4=y
># CONFIG_KERNEL_GZIP is not set
>CONFIG_KERNEL_BZIP2=y
># CONFIG_KERNEL_LZMA is not set
># CONFIG_KERNEL_XZ is not set
># CONFIG_KERNEL_LZO is not set
># CONFIG_KERNEL_LZ4 is not set
>CONFIG_DEFAULT_HOSTNAME="(none)"
>CONFIG_SWAP=y
># CONFIG_SYSVIPC is not set
># CONFIG_POSIX_MQUEUE is not set
>CONFIG_CROSS_MEMORY_ATTACH=y
># CONFIG_USELIB is not set
>CONFIG_AUDIT=y
>CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>CONFIG_AUDITSYSCALL=y
>CONFIG_AUDIT_WATCH=y
>CONFIG_AUDIT_TREE=y
>
>#
># IRQ subsystem
>#
>CONFIG_GENERIC_IRQ_PROBE=y
>CONFIG_GENERIC_IRQ_SHOW=y
>CONFIG_IRQ_DOMAIN=y
>CONFIG_IRQ_SIM=y
>CONFIG_IRQ_DOMAIN_HIERARCHY=y
>CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
>CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
># CONFIG_IRQ_DOMAIN_DEBUG is not set
>CONFIG_IRQ_FORCED_THREADING=y
>CONFIG_SPARSE_IRQ=y
>CONFIG_GENERIC_IRQ_DEBUGFS=y
>CONFIG_CLOCKSOURCE_WATCHDOG=y
>CONFIG_ARCH_CLOCKSOURCE_DATA=y
>CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
>CONFIG_GENERIC_TIME_VSYSCALL=y
>CONFIG_GENERIC_CLOCKEVENTS=y
>CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
>CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
>CONFIG_GENERIC_CMOS_UPDATE=y
>
>#
># Timers subsystem
>#
>CONFIG_TICK_ONESHOT=y
>CONFIG_NO_HZ_COMMON=y
># CONFIG_HZ_PERIODIC is not set
>CONFIG_NO_HZ_IDLE=y
>CONFIG_NO_HZ=y
># CONFIG_HIGH_RES_TIMERS is not set
>
>#
># CPU/Task time and stats accounting
>#
>CONFIG_TICK_CPU_ACCOUNTING=y
># CONFIG_IRQ_TIME_ACCOUNTING is not set
># CONFIG_BSD_PROCESS_ACCT is not set
># CONFIG_TASKSTATS is not set
># CONFIG_CPU_ISOLATION is not set
>
>#
># RCU Subsystem
>#
>CONFIG_TINY_RCU=y
># CONFIG_RCU_EXPERT is not set
>CONFIG_SRCU=y
>CONFIG_TINY_SRCU=y
># CONFIG_TASKS_RCU is not set
># CONFIG_RCU_STALL_COMMON is not set
># CONFIG_RCU_NEED_SEGCBLIST is not set
>CONFIG_BUILD_BIN2C=y
>CONFIG_IKCONFIG=y
>CONFIG_IKCONFIG_PROC=y
>CONFIG_LOG_BUF_SHIFT=20
>CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
>CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
>CONFIG_CGROUPS=y
># CONFIG_MEMCG is not set
># CONFIG_BLK_CGROUP is not set
># CONFIG_CGROUP_SCHED is not set
># CONFIG_CGROUP_PIDS is not set
># CONFIG_CGROUP_RDMA is not set
># CONFIG_CGROUP_FREEZER is not set
># CONFIG_CGROUP_DEVICE is not set
># CONFIG_CGROUP_CPUACCT is not set
># CONFIG_CGROUP_PERF is not set
># CONFIG_CGROUP_DEBUG is not set
># CONFIG_SOCK_CGROUP_DATA is not set
>CONFIG_NAMESPACES=y
># CONFIG_UTS_NS is not set
># CONFIG_USER_NS is not set
># CONFIG_PID_NS is not set
># CONFIG_NET_NS is not set
># CONFIG_SCHED_AUTOGROUP is not set
># CONFIG_SYSFS_DEPRECATED is not set
>CONFIG_RELAY=y
>CONFIG_BLK_DEV_INITRD=y
>CONFIG_INITRAMFS_SOURCE=""
>CONFIG_RD_GZIP=y
>CONFIG_RD_BZIP2=y
>CONFIG_RD_LZMA=y
>CONFIG_RD_XZ=y
>CONFIG_RD_LZO=y
>CONFIG_RD_LZ4=y
>CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
># CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>CONFIG_SYSCTL=y
>CONFIG_ANON_INODES=y
>CONFIG_HAVE_UID16=y
>CONFIG_SYSCTL_EXCEPTION_TRACE=y
>CONFIG_HAVE_PCSPKR_PLATFORM=y
>CONFIG_BPF=y
># CONFIG_EXPERT is not set
>CONFIG_UID16=y
>CONFIG_MULTIUSER=y
>CONFIG_SGETMASK_SYSCALL=y
>CONFIG_SYSFS_SYSCALL=y
># CONFIG_SYSCTL_SYSCALL is not set
>CONFIG_FHANDLE=y
>CONFIG_POSIX_TIMERS=y
>CONFIG_PRINTK=y
>CONFIG_PRINTK_NMI=y
>CONFIG_BUG=y
>CONFIG_ELF_CORE=y
>CONFIG_PCSPKR_PLATFORM=y
>CONFIG_BASE_FULL=y
>CONFIG_FUTEX=y
>CONFIG_FUTEX_PI=y
>CONFIG_EPOLL=y
>CONFIG_SIGNALFD=y
>CONFIG_TIMERFD=y
>CONFIG_EVENTFD=y
>CONFIG_SHMEM=y
>CONFIG_AIO=y
>CONFIG_ADVISE_SYSCALLS=y
>CONFIG_MEMBARRIER=y
># CONFIG_CHECKPOINT_RESTORE is not set
>CONFIG_KALLSYMS=y
>CONFIG_KALLSYMS_ALL=y
># CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
>CONFIG_KALLSYMS_BASE_RELATIVE=y
># CONFIG_BPF_SYSCALL is not set
>CONFIG_USERFAULTFD=y
># CONFIG_EMBEDDED is not set
>CONFIG_HAVE_PERF_EVENTS=y
>CONFIG_PERF_USE_VMALLOC=y
># CONFIG_PC104 is not set
>
>#
># Kernel Performance Events And Counters
>#
>CONFIG_PERF_EVENTS=y
>CONFIG_DEBUG_PERF_USE_VMALLOC=y
>CONFIG_VM_EVENT_COUNTERS=y
>CONFIG_SLUB_DEBUG=y
># CONFIG_COMPAT_BRK is not set
># CONFIG_SLAB is not set
>CONFIG_SLUB=y
>CONFIG_SLAB_MERGE_DEFAULT=y
># CONFIG_SLAB_FREELIST_RANDOM is not set
>CONFIG_SLAB_FREELIST_HARDENED=y
>CONFIG_SYSTEM_DATA_VERIFICATION=y
># CONFIG_PROFILING is not set
>CONFIG_CRASH_CORE=y
>CONFIG_KEXEC_CORE=y
>CONFIG_HAVE_OPROFILE=y
>CONFIG_OPROFILE_NMI_TIMER=y
># CONFIG_JUMP_LABEL is not set
># CONFIG_UPROBES is not set
># CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
>CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>CONFIG_ARCH_USE_BUILTIN_BSWAP=y
>CONFIG_HAVE_IOREMAP_PROT=y
>CONFIG_HAVE_KPROBES=y
>CONFIG_HAVE_KRETPROBES=y
>CONFIG_HAVE_OPTPROBES=y
>CONFIG_HAVE_KPROBES_ON_FTRACE=y
>CONFIG_HAVE_NMI=y
>CONFIG_HAVE_ARCH_TRACEHOOK=y
>CONFIG_HAVE_DMA_CONTIGUOUS=y
>CONFIG_GENERIC_SMP_IDLE_THREAD=y
>CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
>CONFIG_ARCH_HAS_SET_MEMORY=y
>CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>CONFIG_HAVE_CLK=y
>CONFIG_HAVE_DMA_API_DEBUG=y
>CONFIG_HAVE_HW_BREAKPOINT=y
>CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
>CONFIG_HAVE_USER_RETURN_NOTIFIER=y
>CONFIG_HAVE_PERF_EVENTS_NMI=y
>CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
>CONFIG_HAVE_PERF_REGS=y
>CONFIG_HAVE_PERF_USER_STACK_DUMP=y
>CONFIG_HAVE_ARCH_JUMP_LABEL=y
>CONFIG_HAVE_RCU_TABLE_FREE=y
>CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
>CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
>CONFIG_HAVE_CMPXCHG_LOCAL=y
>CONFIG_HAVE_CMPXCHG_DOUBLE=y
>CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
>CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
>CONFIG_HAVE_GCC_PLUGINS=y
># CONFIG_GCC_PLUGINS is not set
>CONFIG_HAVE_CC_STACKPROTECTOR=y
># CONFIG_CC_STACKPROTECTOR is not set
>CONFIG_CC_STACKPROTECTOR_NONE=y
># CONFIG_CC_STACKPROTECTOR_REGULAR is not set
># CONFIG_CC_STACKPROTECTOR_STRONG is not set
>CONFIG_THIN_ARCHIVES=y
>CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
>CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
>CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>CONFIG_HAVE_ARCH_HUGE_VMAP=y
>CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
>CONFIG_MODULES_USE_ELF_REL=y
>CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
>CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
>CONFIG_HAVE_EXIT_THREAD=y
>CONFIG_ARCH_MMAP_RND_BITS=8
>CONFIG_HAVE_COPY_THREAD_TLS=y
># CONFIG_HAVE_ARCH_HASH is not set
># CONFIG_ISA_BUS_API is not set
>CONFIG_CLONE_BACKWARDS=y
>CONFIG_OLD_SIGSUSPEND3=y
>CONFIG_OLD_SIGACTION=y
># CONFIG_CPU_NO_EFFICIENT_FFS is not set
># CONFIG_HAVE_ARCH_VMAP_STACK is not set
># CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
># CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
>CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
>CONFIG_STRICT_KERNEL_RWX=y
>CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
>CONFIG_ARCH_HAS_REFCOUNT=y
># CONFIG_REFCOUNT_FULL is not set
>
>#
># GCOV-based kernel profiling
>#
># CONFIG_GCOV_KERNEL is not set
>CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
>CONFIG_HAVE_GENERIC_DMA_COHERENT=y
>CONFIG_RT_MUTEXES=y
>CONFIG_BASE_SMALL=0
># CONFIG_MODULES is not set
>CONFIG_MODULES_TREE_LOOKUP=y
>CONFIG_BLOCK=y
># CONFIG_LBDAF is not set
>CONFIG_BLK_SCSI_REQUEST=y
>CONFIG_BLK_DEV_BSG=y
>CONFIG_BLK_DEV_BSGLIB=y
>CONFIG_BLK_DEV_INTEGRITY=y
># CONFIG_BLK_DEV_ZONED is not set
>CONFIG_BLK_CMDLINE_PARSER=y
># CONFIG_BLK_WBT is not set
># CONFIG_BLK_DEBUG_FS is not set
>CONFIG_BLK_SED_OPAL=y
>
>#
># Partition Types
>#
>CONFIG_PARTITION_ADVANCED=y
># CONFIG_ACORN_PARTITION is not set
># CONFIG_AIX_PARTITION is not set
># CONFIG_OSF_PARTITION is not set
>CONFIG_AMIGA_PARTITION=y
># CONFIG_ATARI_PARTITION is not set
>CONFIG_MAC_PARTITION=y
># CONFIG_MSDOS_PARTITION is not set
># CONFIG_LDM_PARTITION is not set
>CONFIG_SGI_PARTITION=y
># CONFIG_ULTRIX_PARTITION is not set
>CONFIG_SUN_PARTITION=y
>CONFIG_KARMA_PARTITION=y
># CONFIG_EFI_PARTITION is not set
># CONFIG_SYSV68_PARTITION is not set
>CONFIG_CMDLINE_PARTITION=y
>CONFIG_BLK_MQ_PCI=y
>CONFIG_BLK_MQ_VIRTIO=y
>
>#
># IO Schedulers
>#
>CONFIG_IOSCHED_NOOP=y
># CONFIG_IOSCHED_DEADLINE is not set
>CONFIG_IOSCHED_CFQ=y
># CONFIG_DEFAULT_CFQ is not set
>CONFIG_DEFAULT_NOOP=y
>CONFIG_DEFAULT_IOSCHED="noop"
>CONFIG_MQ_IOSCHED_DEADLINE=y
>CONFIG_MQ_IOSCHED_KYBER=y
># CONFIG_IOSCHED_BFQ is not set
>CONFIG_ASN1=y
>CONFIG_UNINLINE_SPIN_UNLOCK=y
>CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
>CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
>CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
>CONFIG_FREEZER=y
>
>#
># Processor type and features
>#
>CONFIG_ZONE_DMA=y
># CONFIG_SMP is not set
>CONFIG_X86_FEATURE_NAMES=y
>CONFIG_X86_FAST_FEATURE_TESTS=y
>CONFIG_X86_MPPARSE=y
># CONFIG_GOLDFISH is not set
># CONFIG_INTEL_RDT is not set
># CONFIG_X86_EXTENDED_PLATFORM is not set
># CONFIG_X86_INTEL_LPSS is not set
># CONFIG_X86_AMD_PLATFORM_DEVICE is not set
># CONFIG_IOSF_MBI is not set
>CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
>CONFIG_X86_32_IRIS=y
># CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>CONFIG_HYPERVISOR_GUEST=y
>CONFIG_PARAVIRT=y
># CONFIG_PARAVIRT_DEBUG is not set
># CONFIG_XEN is not set
>CONFIG_KVM_GUEST=y
># CONFIG_KVM_DEBUG_FS is not set
># CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
>CONFIG_PARAVIRT_CLOCK=y
>CONFIG_NO_BOOTMEM=y
># CONFIG_M486 is not set
># CONFIG_M586 is not set
># CONFIG_M586TSC is not set
># CONFIG_M586MMX is not set
>CONFIG_M686=y
># CONFIG_MPENTIUMII is not set
># CONFIG_MPENTIUMIII is not set
># CONFIG_MPENTIUMM is not set
># CONFIG_MPENTIUM4 is not set
># CONFIG_MK6 is not set
># CONFIG_MK7 is not set
># CONFIG_MK8 is not set
># CONFIG_MCRUSOE is not set
># CONFIG_MEFFICEON is not set
># CONFIG_MWINCHIPC6 is not set
># CONFIG_MWINCHIP3D is not set
># CONFIG_MELAN is not set
># CONFIG_MGEODEGX1 is not set
># CONFIG_MGEODE_LX is not set
># CONFIG_MCYRIXIII is not set
># CONFIG_MVIAC3_2 is not set
># CONFIG_MVIAC7 is not set
># CONFIG_MCORE2 is not set
># CONFIG_MATOM is not set
># CONFIG_X86_GENERIC is not set
>CONFIG_X86_INTERNODE_CACHE_SHIFT=5
>CONFIG_X86_L1_CACHE_SHIFT=5
># CONFIG_X86_PPRO_FENCE is not set
>CONFIG_X86_USE_PPRO_CHECKSUM=y
>CONFIG_X86_TSC=y
>CONFIG_X86_CMPXCHG64=y
>CONFIG_X86_CMOV=y
>CONFIG_X86_MINIMUM_CPU_FAMILY=5
>CONFIG_X86_DEBUGCTLMSR=y
>CONFIG_CPU_SUP_INTEL=y
>CONFIG_CPU_SUP_AMD=y
>CONFIG_CPU_SUP_CENTAUR=y
>CONFIG_CPU_SUP_TRANSMETA_32=y
>CONFIG_HPET_TIMER=y
>CONFIG_DMI=y
>CONFIG_SWIOTLB=y
>CONFIG_IOMMU_HELPER=y
>CONFIG_NR_CPUS=1
>CONFIG_PREEMPT_NONE=y
># CONFIG_PREEMPT_VOLUNTARY is not set
># CONFIG_PREEMPT is not set
>CONFIG_PREEMPT_COUNT=y
>CONFIG_UP_LATE_INIT=y
>CONFIG_X86_UP_APIC=y
>CONFIG_X86_UP_IOAPIC=y
>CONFIG_X86_LOCAL_APIC=y
>CONFIG_X86_IO_APIC=y
>CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
>CONFIG_X86_MCE=y
>CONFIG_X86_MCELOG_LEGACY=y
>CONFIG_X86_MCE_INTEL=y
>CONFIG_X86_MCE_AMD=y
>CONFIG_X86_ANCIENT_MCE=y
>CONFIG_X86_MCE_THRESHOLD=y
># CONFIG_X86_MCE_INJECT is not set
>CONFIG_X86_THERMAL_VECTOR=y
>
>#
># Performance monitoring
>#
>CONFIG_PERF_EVENTS_INTEL_UNCORE=y
>CONFIG_PERF_EVENTS_INTEL_RAPL=y
>CONFIG_PERF_EVENTS_INTEL_CSTATE=y
># CONFIG_PERF_EVENTS_AMD_POWER is not set
># CONFIG_X86_LEGACY_VM86 is not set
># CONFIG_VM86 is not set
>CONFIG_X86_16BIT=y
>CONFIG_X86_ESPFIX32=y
>CONFIG_TOSHIBA=y
># CONFIG_I8K is not set
># CONFIG_X86_REBOOTFIXUPS is not set
>CONFIG_MICROCODE=y
>CONFIG_MICROCODE_INTEL=y
>CONFIG_MICROCODE_AMD=y
>CONFIG_MICROCODE_OLD_INTERFACE=y
>CONFIG_X86_MSR=y
>CONFIG_X86_CPUID=y
># CONFIG_NOHIGHMEM is not set
># CONFIG_HIGHMEM4G is not set
>CONFIG_HIGHMEM64G=y
>CONFIG_PAGE_OFFSET=0xC0000000
>CONFIG_HIGHMEM=y
>CONFIG_X86_PAE=y
>CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
>CONFIG_ARCH_DMA_ADDR_T_64BIT=y
>CONFIG_ARCH_HAS_MEM_ENCRYPT=y
>CONFIG_ARCH_FLATMEM_ENABLE=y
>CONFIG_ARCH_SPARSEMEM_ENABLE=y
>CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>CONFIG_ILLEGAL_POINTER_VALUE=0
>CONFIG_SELECT_MEMORY_MODEL=y
>CONFIG_FLATMEM_MANUAL=y
># CONFIG_SPARSEMEM_MANUAL is not set
>CONFIG_FLATMEM=y
>CONFIG_FLAT_NODE_MEM_MAP=y
>CONFIG_SPARSEMEM_STATIC=y
>CONFIG_HAVE_MEMBLOCK=y
>CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
>CONFIG_HAVE_GENERIC_GUP=y
>CONFIG_ARCH_DISCARD_MEMBLOCK=y
>CONFIG_MEMORY_ISOLATION=y
># CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
>CONFIG_SPLIT_PTLOCK_CPUS=4
>CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
>CONFIG_MEMORY_BALLOON=y
># CONFIG_COMPACTION is not set
>CONFIG_MIGRATION=y
>CONFIG_PHYS_ADDR_T_64BIT=y
># CONFIG_BOUNCE is not set
>CONFIG_VIRT_TO_BUS=y
>CONFIG_KSM=y
>CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
># CONFIG_MEMORY_FAILURE is not set
># CONFIG_TRANSPARENT_HUGEPAGE is not set
># CONFIG_ARCH_WANTS_THP_SWAP is not set
>CONFIG_NEED_PER_CPU_KM=y
># CONFIG_CLEANCACHE is not set
># CONFIG_FRONTSWAP is not set
>CONFIG_CMA=y
>CONFIG_CMA_DEBUG=y
># CONFIG_CMA_DEBUGFS is not set
>CONFIG_CMA_AREAS=7
>CONFIG_ZPOOL=y
>CONFIG_ZBUD=y
>CONFIG_Z3FOLD=y
>CONFIG_ZSMALLOC=y
># CONFIG_PGTABLE_MAPPING is not set
># CONFIG_ZSMALLOC_STAT is not set
>CONFIG_GENERIC_EARLY_IOREMAP=y
>CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
>CONFIG_IDLE_PAGE_TRACKING=y
>CONFIG_FRAME_VECTOR=y
># CONFIG_PERCPU_STATS is not set
># CONFIG_GUP_BENCHMARK is not set
># CONFIG_X86_PMEM_LEGACY is not set
># CONFIG_HIGHPTE is not set
>CONFIG_X86_CHECK_BIOS_CORRUPTION=y
># CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
>CONFIG_X86_RESERVE_LOW=64
># CONFIG_MATH_EMULATION is not set
>CONFIG_MTRR=y
># CONFIG_MTRR_SANITIZER is not set
>CONFIG_X86_PAT=y
>CONFIG_ARCH_USES_PG_UNCACHED=y
>CONFIG_ARCH_RANDOM=y
>CONFIG_X86_SMAP=y
>CONFIG_X86_INTEL_UMIP=y
># CONFIG_EFI is not set
># CONFIG_SECCOMP is not set
># CONFIG_HZ_100 is not set
># CONFIG_HZ_250 is not set
># CONFIG_HZ_300 is not set
>CONFIG_HZ_1000=y
>CONFIG_HZ=1000
># CONFIG_SCHED_HRTICK is not set
>CONFIG_KEXEC=y
># CONFIG_CRASH_DUMP is not set
># CONFIG_KEXEC_JUMP is not set
>CONFIG_PHYSICAL_START=0x1000000
>CONFIG_RELOCATABLE=y
># CONFIG_RANDOMIZE_BASE is not set
>CONFIG_X86_NEED_RELOCS=y
>CONFIG_PHYSICAL_ALIGN=0x200000
># CONFIG_COMPAT_VDSO is not set
># CONFIG_CMDLINE_BOOL is not set
>CONFIG_MODIFY_LDT_SYSCALL=y
>CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>
>#
># Power management and ACPI options
>#
># CONFIG_SUSPEND is not set
>CONFIG_HIBERNATE_CALLBACKS=y
>CONFIG_HIBERNATION=y
>CONFIG_PM_STD_PARTITION=""
>CONFIG_PM_SLEEP=y
># CONFIG_PM_AUTOSLEEP is not set
>CONFIG_PM_WAKELOCKS=y
>CONFIG_PM_WAKELOCKS_LIMIT=100
>CONFIG_PM_WAKELOCKS_GC=y
>CONFIG_PM=y
># CONFIG_PM_DEBUG is not set
>CONFIG_PM_CLK=y
>CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>CONFIG_ACPI=y
>CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
>CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
>CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
># CONFIG_ACPI_DEBUGGER is not set
>CONFIG_ACPI_SLEEP=y
># CONFIG_ACPI_PROCFS_POWER is not set
>CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
># CONFIG_ACPI_EC_DEBUGFS is not set
>CONFIG_ACPI_AC=y
>CONFIG_ACPI_BATTERY=y
>CONFIG_ACPI_BUTTON=y
># CONFIG_ACPI_VIDEO is not set
>CONFIG_ACPI_FAN=y
># CONFIG_ACPI_DOCK is not set
>CONFIG_ACPI_CPU_FREQ_PSS=y
>CONFIG_ACPI_PROCESSOR_CSTATE=y
>CONFIG_ACPI_PROCESSOR_IDLE=y
>CONFIG_ACPI_PROCESSOR=y
># CONFIG_ACPI_IPMI is not set
># CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
>CONFIG_ACPI_THERMAL=y
>CONFIG_ACPI_CUSTOM_DSDT_FILE=""
># CONFIG_ACPI_CUSTOM_DSDT is not set
>CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
>CONFIG_ACPI_TABLE_UPGRADE=y
># CONFIG_ACPI_DEBUG is not set
># CONFIG_ACPI_PCI_SLOT is not set
>CONFIG_X86_PM_TIMER=y
># CONFIG_ACPI_CONTAINER is not set
>CONFIG_ACPI_HOTPLUG_IOAPIC=y
># CONFIG_ACPI_SBS is not set
># CONFIG_ACPI_HED is not set
># CONFIG_ACPI_CUSTOM_METHOD is not set
># CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
>CONFIG_HAVE_ACPI_APEI=y
>CONFIG_HAVE_ACPI_APEI_NMI=y
># CONFIG_ACPI_APEI is not set
># CONFIG_DPTF_POWER is not set
># CONFIG_ACPI_EXTLOG is not set
># CONFIG_PMIC_OPREGION is not set
># CONFIG_ACPI_CONFIGFS is not set
># CONFIG_SFI is not set
>CONFIG_X86_APM_BOOT=y
>CONFIG_APM=y
>CONFIG_APM_IGNORE_USER_SUSPEND=y
># CONFIG_APM_DO_ENABLE is not set
># CONFIG_APM_CPU_IDLE is not set
># CONFIG_APM_DISPLAY_BLANK is not set
>CONFIG_APM_ALLOW_INTS=y
>
>#
># CPU Frequency scaling
>#
># CONFIG_CPU_FREQ is not set
>
>#
># CPU Idle
>#
>CONFIG_CPU_IDLE=y
>CONFIG_CPU_IDLE_GOV_LADDER=y
>CONFIG_CPU_IDLE_GOV_MENU=y
># CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
># CONFIG_INTEL_IDLE is not set
>
>#
># Bus options (PCI etc.)
>#
>CONFIG_PCI=y
># CONFIG_PCI_GOBIOS is not set
># CONFIG_PCI_GOMMCONFIG is not set
># CONFIG_PCI_GODIRECT is not set
>CONFIG_PCI_GOANY=y
>CONFIG_PCI_BIOS=y
>CONFIG_PCI_DIRECT=y
>CONFIG_PCI_MMCONFIG=y
>CONFIG_PCI_DOMAINS=y
># CONFIG_PCIEPORTBUS is not set
>CONFIG_PCI_BUS_ADDR_T_64BIT=y
># CONFIG_PCI_MSI is not set
>CONFIG_PCI_QUIRKS=y
># CONFIG_PCI_DEBUG is not set
># CONFIG_PCI_STUB is not set
>CONFIG_PCI_LOCKLESS_CONFIG=y
># CONFIG_PCI_IOV is not set
># CONFIG_PCI_PRI is not set
># CONFIG_PCI_PASID is not set
>CONFIG_PCI_LABEL=y
># CONFIG_HOTPLUG_PCI is not set
>
>#
># DesignWare PCI Core Support
>#
>
>#
># PCI host controller drivers
>#
>
>#
># PCI Endpoint
>#
># CONFIG_PCI_ENDPOINT is not set
>
>#
># PCI switch controller drivers
>#
># CONFIG_PCI_SW_SWITCHTEC is not set
>CONFIG_ISA_DMA_API=y
># CONFIG_ISA is not set
># CONFIG_SCx200 is not set
># CONFIG_ALIX is not set
># CONFIG_NET5501 is not set
>CONFIG_GEOS=y
>CONFIG_AMD_NB=y
># CONFIG_PCCARD is not set
># CONFIG_RAPIDIO is not set
>CONFIG_X86_SYSFB=y
>
>#
># Executable file formats / Emulations
>#
>CONFIG_BINFMT_ELF=y
>CONFIG_ELFCORE=y
>CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
>CONFIG_BINFMT_SCRIPT=y
>CONFIG_HAVE_AOUT=y
>CONFIG_BINFMT_AOUT=y
>CONFIG_BINFMT_MISC=y
>CONFIG_COREDUMP=y
>CONFIG_COMPAT_32=y
>CONFIG_HAVE_ATOMIC_IOMAP=y
>CONFIG_NET=y
>CONFIG_NET_INGRESS=y
>CONFIG_NET_EGRESS=y
>
>#
># Networking options
>#
>CONFIG_PACKET=y
># CONFIG_PACKET_DIAG is not set
>CONFIG_UNIX=y
>CONFIG_UNIX_DIAG=y
>CONFIG_TLS=y
>CONFIG_XFRM=y
>CONFIG_XFRM_OFFLOAD=y
>CONFIG_XFRM_ALGO=y
>CONFIG_XFRM_USER=y
>CONFIG_XFRM_SUB_POLICY=y
># CONFIG_XFRM_MIGRATE is not set
>CONFIG_XFRM_STATISTICS=y
>CONFIG_XFRM_IPCOMP=y
>CONFIG_NET_KEY=y
># CONFIG_NET_KEY_MIGRATE is not set
>CONFIG_INET=y
># CONFIG_IP_MULTICAST is not set
># CONFIG_IP_ADVANCED_ROUTER is not set
>CONFIG_IP_ROUTE_CLASSID=y
>CONFIG_IP_PNP=y
>CONFIG_IP_PNP_DHCP=y
>CONFIG_IP_PNP_BOOTP=y
>CONFIG_IP_PNP_RARP=y
>CONFIG_NET_IPIP=y
>CONFIG_NET_IPGRE_DEMUX=y
>CONFIG_NET_IP_TUNNEL=y
>CONFIG_NET_IPGRE=y
># CONFIG_SYN_COOKIES is not set
>CONFIG_NET_UDP_TUNNEL=y
>CONFIG_NET_FOU=y
>CONFIG_NET_FOU_IP_TUNNELS=y
>CONFIG_INET_AH=y
>CONFIG_INET_ESP=y
>CONFIG_INET_ESP_OFFLOAD=y
>CONFIG_INET_IPCOMP=y
>CONFIG_INET_XFRM_TUNNEL=y
>CONFIG_INET_TUNNEL=y
>CONFIG_INET_XFRM_MODE_TRANSPORT=y
># CONFIG_INET_XFRM_MODE_TUNNEL is not set
># CONFIG_INET_XFRM_MODE_BEET is not set
>CONFIG_INET_DIAG=y
>CONFIG_INET_TCP_DIAG=y
># CONFIG_INET_UDP_DIAG is not set
>CONFIG_INET_RAW_DIAG=y
>CONFIG_INET_DIAG_DESTROY=y
># CONFIG_TCP_CONG_ADVANCED is not set
>CONFIG_TCP_CONG_CUBIC=y
>CONFIG_DEFAULT_TCP_CONG="cubic"
>CONFIG_TCP_MD5SIG=y
># CONFIG_IPV6 is not set
>CONFIG_NETWORK_SECMARK=y
>CONFIG_NET_PTP_CLASSIFY=y
>CONFIG_NETWORK_PHY_TIMESTAMPING=y
># CONFIG_NETFILTER is not set
>CONFIG_IP_DCCP=y
>CONFIG_INET_DCCP_DIAG=y
>
>#
># DCCP CCIDs Configuration
>#
># CONFIG_IP_DCCP_CCID2_DEBUG is not set
># CONFIG_IP_DCCP_CCID3 is not set
>
>#
># DCCP Kernel Hacking
>#
>CONFIG_IP_DCCP_DEBUG=y
>CONFIG_IP_SCTP=y
>CONFIG_SCTP_DBG_OBJCNT=y
># CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
># CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
>CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
># CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
>CONFIG_SCTP_COOKIE_HMAC_SHA1=y
>CONFIG_INET_SCTP_DIAG=y
># CONFIG_RDS is not set
>CONFIG_TIPC=y
>CONFIG_TIPC_MEDIA_UDP=y
>CONFIG_ATM=y
>CONFIG_ATM_CLIP=y
>CONFIG_ATM_CLIP_NO_ICMP=y
>CONFIG_ATM_LANE=y
># CONFIG_ATM_MPOA is not set
>CONFIG_ATM_BR2684=y
># CONFIG_ATM_BR2684_IPFILTER is not set
>CONFIG_L2TP=y
># CONFIG_L2TP_DEBUGFS is not set
>CONFIG_L2TP_V3=y
>CONFIG_L2TP_IP=y
># CONFIG_L2TP_ETH is not set
>CONFIG_STP=y
>CONFIG_BRIDGE=y
># CONFIG_BRIDGE_IGMP_SNOOPING is not set
>CONFIG_BRIDGE_VLAN_FILTERING=y
>CONFIG_HAVE_NET_DSA=y
>CONFIG_NET_DSA=y
>CONFIG_NET_DSA_TAG_BRCM=y
>CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
>CONFIG_NET_DSA_TAG_LAN9303=y
>CONFIG_NET_DSA_TAG_TRAILER=y
>CONFIG_NET_DSA_TAG_QCA=y
>CONFIG_VLAN_8021Q=y
># CONFIG_VLAN_8021Q_GVRP is not set
># CONFIG_VLAN_8021Q_MVRP is not set
>CONFIG_DECNET=y
>CONFIG_DECNET_ROUTER=y
>CONFIG_LLC=y
># CONFIG_LLC2 is not set
>CONFIG_IPX=y
>CONFIG_IPX_INTERN=y
># CONFIG_ATALK is not set
>CONFIG_X25=y
>CONFIG_LAPB=y
># CONFIG_PHONET is not set
>CONFIG_IEEE802154=y
>CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
># CONFIG_IEEE802154_SOCKET is not set
>CONFIG_MAC802154=y
>CONFIG_NET_SCHED=y
>
>#
># Queueing/Scheduling
>#
>CONFIG_NET_SCH_CBQ=y
># CONFIG_NET_SCH_HTB is not set
>CONFIG_NET_SCH_HFSC=y
>CONFIG_NET_SCH_ATM=y
>CONFIG_NET_SCH_PRIO=y
>CONFIG_NET_SCH_MULTIQ=y
>CONFIG_NET_SCH_RED=y
>CONFIG_NET_SCH_SFB=y
># CONFIG_NET_SCH_SFQ is not set
># CONFIG_NET_SCH_TEQL is not set
>CONFIG_NET_SCH_TBF=y
># CONFIG_NET_SCH_CBS is not set
># CONFIG_NET_SCH_GRED is not set
>CONFIG_NET_SCH_DSMARK=y
>CONFIG_NET_SCH_NETEM=y
>CONFIG_NET_SCH_DRR=y
># CONFIG_NET_SCH_MQPRIO is not set
>CONFIG_NET_SCH_CHOKE=y
># CONFIG_NET_SCH_QFQ is not set
>CONFIG_NET_SCH_CODEL=y
># CONFIG_NET_SCH_FQ_CODEL is not set
># CONFIG_NET_SCH_FQ is not set
>CONFIG_NET_SCH_HHF=y
># CONFIG_NET_SCH_PIE is not set
>CONFIG_NET_SCH_INGRESS=y
># CONFIG_NET_SCH_PLUG is not set
># CONFIG_NET_SCH_DEFAULT is not set
>
>#
># Classification
>#
>CONFIG_NET_CLS=y
>CONFIG_NET_CLS_BASIC=y
>CONFIG_NET_CLS_TCINDEX=y
>CONFIG_NET_CLS_ROUTE4=y
># CONFIG_NET_CLS_FW is not set
>CONFIG_NET_CLS_U32=y
>CONFIG_CLS_U32_PERF=y
># CONFIG_CLS_U32_MARK is not set
>CONFIG_NET_CLS_RSVP=y
>CONFIG_NET_CLS_RSVP6=y
># CONFIG_NET_CLS_FLOW is not set
># CONFIG_NET_CLS_CGROUP is not set
># CONFIG_NET_CLS_BPF is not set
># CONFIG_NET_CLS_FLOWER is not set
>CONFIG_NET_CLS_MATCHALL=y
>CONFIG_NET_EMATCH=y
>CONFIG_NET_EMATCH_STACK=32
># CONFIG_NET_EMATCH_CMP is not set
>CONFIG_NET_EMATCH_NBYTE=y
># CONFIG_NET_EMATCH_U32 is not set
># CONFIG_NET_EMATCH_META is not set
># CONFIG_NET_EMATCH_TEXT is not set
># CONFIG_NET_EMATCH_CANID is not set
>CONFIG_NET_CLS_ACT=y
>CONFIG_NET_ACT_POLICE=y
>CONFIG_NET_ACT_GACT=y
>CONFIG_GACT_PROB=y
>CONFIG_NET_ACT_MIRRED=y
># CONFIG_NET_ACT_SAMPLE is not set
>CONFIG_NET_ACT_NAT=y
>CONFIG_NET_ACT_PEDIT=y
>CONFIG_NET_ACT_SIMP=y
># CONFIG_NET_ACT_SKBEDIT is not set
>CONFIG_NET_ACT_CSUM=y
># CONFIG_NET_ACT_VLAN is not set
># CONFIG_NET_ACT_BPF is not set
>CONFIG_NET_ACT_SKBMOD=y
># CONFIG_NET_ACT_IFE is not set
>CONFIG_NET_ACT_TUNNEL_KEY=y
># CONFIG_NET_CLS_IND is not set
>CONFIG_NET_SCH_FIFO=y
># CONFIG_DCB is not set
>CONFIG_DNS_RESOLVER=y
># CONFIG_BATMAN_ADV is not set
># CONFIG_OPENVSWITCH is not set
># CONFIG_VSOCKETS is not set
>CONFIG_NETLINK_DIAG=y
># CONFIG_MPLS is not set
>CONFIG_NET_NSH=y
>CONFIG_HSR=y
>CONFIG_NET_SWITCHDEV=y
># CONFIG_NET_L3_MASTER_DEV is not set
>CONFIG_NET_NCSI=y
># CONFIG_CGROUP_NET_PRIO is not set
># CONFIG_CGROUP_NET_CLASSID is not set
>CONFIG_NET_RX_BUSY_POLL=y
>CONFIG_BQL=y
>
>#
># Network testing
>#
>CONFIG_NET_PKTGEN=y
>CONFIG_HAMRADIO=y
>
>#
># Packet Radio protocols
>#
>CONFIG_AX25=y
># CONFIG_AX25_DAMA_SLAVE is not set
># CONFIG_NETROM is not set
>CONFIG_ROSE=y
>
>#
># AX.25 network device drivers
>#
>CONFIG_MKISS=y
>CONFIG_6PACK=y
>CONFIG_BPQETHER=y
>CONFIG_BAYCOM_SER_FDX=y
>CONFIG_BAYCOM_SER_HDX=y
>CONFIG_YAM=y
>CONFIG_CAN=y
>CONFIG_CAN_RAW=y
>CONFIG_CAN_BCM=y
>CONFIG_CAN_GW=y
>
>#
># CAN Device Drivers
>#
># CONFIG_CAN_VCAN is not set
>CONFIG_CAN_VXCAN=y
># CONFIG_CAN_SLCAN is not set
>CONFIG_CAN_DEV=y
>CONFIG_CAN_CALC_BITTIMING=y
>CONFIG_CAN_LEDS=y
># CONFIG_CAN_GRCAN is not set
># CONFIG_PCH_CAN is not set
>CONFIG_CAN_C_CAN=y
>CONFIG_CAN_C_CAN_PLATFORM=y
># CONFIG_CAN_C_CAN_PCI is not set
># CONFIG_CAN_CC770 is not set
># CONFIG_CAN_IFI_CANFD is not set
>CONFIG_CAN_M_CAN=y
># CONFIG_CAN_PEAK_PCIEFD is not set
>CONFIG_CAN_SJA1000=y
># CONFIG_CAN_SJA1000_ISA is not set
># CONFIG_CAN_SJA1000_PLATFORM is not set
># CONFIG_CAN_EMS_PCI is not set
># CONFIG_CAN_PEAK_PCI is not set
># CONFIG_CAN_KVASER_PCI is not set
># CONFIG_CAN_PLX_PCI is not set
>CONFIG_CAN_SOFTING=y
>
>#
># CAN SPI interfaces
>#
>CONFIG_CAN_HI311X=y
>CONFIG_CAN_MCP251X=y
>
>#
># CAN USB interfaces
>#
>CONFIG_CAN_EMS_USB=y
>CONFIG_CAN_ESD_USB2=y
>CONFIG_CAN_GS_USB=y
>CONFIG_CAN_KVASER_USB=y
>CONFIG_CAN_PEAK_USB=y
>CONFIG_CAN_8DEV_USB=y
>CONFIG_CAN_MCBA_USB=y
># CONFIG_CAN_DEBUG_DEVICES is not set
># CONFIG_BT is not set
>CONFIG_AF_RXRPC=y
>CONFIG_AF_RXRPC_INJECT_LOSS=y
># CONFIG_AF_RXRPC_DEBUG is not set
># CONFIG_RXKAD is not set
># CONFIG_AF_KCM is not set
># CONFIG_STREAM_PARSER is not set
>CONFIG_FIB_RULES=y
>CONFIG_WIRELESS=y
>CONFIG_WIRELESS_EXT=y
>CONFIG_WEXT_CORE=y
>CONFIG_WEXT_PROC=y
>CONFIG_WEXT_PRIV=y
>CONFIG_CFG80211=y
># CONFIG_NL80211_TESTMODE is not set
>CONFIG_CFG80211_DEVELOPER_WARNINGS=y
>CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
>CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
>CONFIG_CFG80211_DEFAULT_PS=y
>CONFIG_CFG80211_DEBUGFS=y
>CONFIG_CFG80211_CRDA_SUPPORT=y
>CONFIG_CFG80211_WEXT=y
># CONFIG_LIB80211 is not set
># CONFIG_MAC80211 is not set
>CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
>CONFIG_WIMAX=y
>CONFIG_WIMAX_DEBUG_LEVEL=8
>CONFIG_RFKILL=y
>CONFIG_RFKILL_LEDS=y
>CONFIG_RFKILL_INPUT=y
>CONFIG_RFKILL_GPIO=y
>CONFIG_NET_9P=y
>CONFIG_NET_9P_VIRTIO=y
>CONFIG_NET_9P_DEBUG=y
># CONFIG_CAIF is not set
>CONFIG_CEPH_LIB=y
># CONFIG_CEPH_LIB_PRETTYDEBUG is not set
>CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
># CONFIG_NFC is not set
>CONFIG_PSAMPLE=y
># CONFIG_NET_IFE is not set
># CONFIG_LWTUNNEL is not set
>CONFIG_DST_CACHE=y
>CONFIG_GRO_CELLS=y
>CONFIG_NET_DEVLINK=y
>CONFIG_MAY_USE_DEVLINK=y
>
>#
># Device Drivers
>#
>
>#
># Generic Driver Options
>#
>CONFIG_UEVENT_HELPER=y
>CONFIG_UEVENT_HELPER_PATH=""
>CONFIG_DEVTMPFS=y
># CONFIG_DEVTMPFS_MOUNT is not set
># CONFIG_STANDALONE is not set
># CONFIG_PREVENT_FIRMWARE_BUILD is not set
>CONFIG_FW_LOADER=y
>CONFIG_FIRMWARE_IN_KERNEL=y
>CONFIG_EXTRA_FIRMWARE=""
>CONFIG_FW_LOADER_USER_HELPER=y
># CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
>CONFIG_ALLOW_DEV_COREDUMP=y
># CONFIG_DEBUG_DRIVER is not set
># CONFIG_DEBUG_DEVRES is not set
># CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
># CONFIG_SYS_HYPERVISOR is not set
># CONFIG_GENERIC_CPU_DEVICES is not set
>CONFIG_GENERIC_CPU_AUTOPROBE=y
>CONFIG_REGMAP=y
>CONFIG_REGMAP_I2C=y
>CONFIG_REGMAP_SPI=y
>CONFIG_REGMAP_W1=y
>CONFIG_REGMAP_MMIO=y
>CONFIG_REGMAP_IRQ=y
>CONFIG_DMA_SHARED_BUFFER=y
># CONFIG_DMA_FENCE_TRACE is not set
>CONFIG_DMA_CMA=y
>
>#
># Default contiguous memory area size:
>#
>CONFIG_CMA_SIZE_PERCENTAGE=0
># CONFIG_CMA_SIZE_SEL_MBYTES is not set
>CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
># CONFIG_CMA_SIZE_SEL_MIN is not set
># CONFIG_CMA_SIZE_SEL_MAX is not set
>CONFIG_CMA_ALIGNMENT=8
>
>#
># Bus devices
>#
>CONFIG_SIMPLE_PM_BUS=y
>CONFIG_CONNECTOR=y
>CONFIG_PROC_EVENTS=y
>CONFIG_MTD=y
>CONFIG_MTD_REDBOOT_PARTS=y
>CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
>CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
>CONFIG_MTD_REDBOOT_PARTS_READONLY=y
>CONFIG_MTD_CMDLINE_PARTS=y
># CONFIG_MTD_OF_PARTS is not set
>CONFIG_MTD_AR7_PARTS=y
>
>#
># Partition parsers
>#
>
>#
># User Modules And Translation Layers
>#
>CONFIG_MTD_BLKDEVS=y
>CONFIG_MTD_BLOCK=y
>CONFIG_FTL=y
>CONFIG_NFTL=y
># CONFIG_NFTL_RW is not set
># CONFIG_INFTL is not set
>CONFIG_RFD_FTL=y
>CONFIG_SSFDC=y
># CONFIG_SM_FTL is not set
>CONFIG_MTD_OOPS=y
># CONFIG_MTD_SWAP is not set
>CONFIG_MTD_PARTITIONED_MASTER=y
>
>#
># RAM/ROM/Flash chip drivers
>#
>CONFIG_MTD_CFI=y
>CONFIG_MTD_JEDECPROBE=y
>CONFIG_MTD_GEN_PROBE=y
>CONFIG_MTD_CFI_ADV_OPTIONS=y
>CONFIG_MTD_CFI_NOSWAP=y
># CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
># CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
>CONFIG_MTD_CFI_GEOMETRY=y
># CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
># CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
>CONFIG_MTD_MAP_BANK_WIDTH_4=y
># CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
># CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
># CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
>CONFIG_MTD_CFI_I1=y
># CONFIG_MTD_CFI_I2 is not set
># CONFIG_MTD_CFI_I4 is not set
>CONFIG_MTD_CFI_I8=y
>CONFIG_MTD_OTP=y
>CONFIG_MTD_CFI_INTELEXT=y
>CONFIG_MTD_CFI_AMDSTD=y
>CONFIG_MTD_CFI_STAA=y
>CONFIG_MTD_CFI_UTIL=y
>CONFIG_MTD_RAM=y
>CONFIG_MTD_ROM=y
>CONFIG_MTD_ABSENT=y
>
>#
># Mapping drivers for chip access
>#
>CONFIG_MTD_COMPLEX_MAPPINGS=y
># CONFIG_MTD_PHYSMAP is not set
>CONFIG_MTD_PHYSMAP_OF=y
>CONFIG_MTD_PHYSMAP_OF_VERSATILE=y
># CONFIG_MTD_PHYSMAP_OF_GEMINI is not set
># CONFIG_MTD_SBC_GXX is not set
>CONFIG_MTD_AMD76XROM=y
># CONFIG_MTD_ICHXROM is not set
># CONFIG_MTD_ESB2ROM is not set
># CONFIG_MTD_CK804XROM is not set
># CONFIG_MTD_SCB2_FLASH is not set
># CONFIG_MTD_NETtel is not set
># CONFIG_MTD_L440GX is not set
># CONFIG_MTD_PCI is not set
># CONFIG_MTD_GPIO_ADDR is not set
># CONFIG_MTD_INTEL_VR_NOR is not set
>CONFIG_MTD_PLATRAM=y
>CONFIG_MTD_LATCH_ADDR=y
>
>#
># Self-contained MTD device drivers
>#
># CONFIG_MTD_PMC551 is not set
>CONFIG_MTD_DATAFLASH=y
># CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
>CONFIG_MTD_DATAFLASH_OTP=y
>CONFIG_MTD_M25P80=y
># CONFIG_MTD_MCHP23K256 is not set
>CONFIG_MTD_SST25L=y
>CONFIG_MTD_SLRAM=y
>CONFIG_MTD_PHRAM=y
>CONFIG_MTD_MTDRAM=y
>CONFIG_MTDRAM_TOTAL_SIZE=4096
>CONFIG_MTDRAM_ERASE_SIZE=128
># CONFIG_MTD_BLOCK2MTD is not set
>
>#
># Disk-On-Chip Device Drivers
>#
>CONFIG_MTD_DOCG3=y
>CONFIG_BCH_CONST_M=14
>CONFIG_BCH_CONST_T=4
># CONFIG_MTD_NAND is not set
># CONFIG_MTD_ONENAND is not set
>
>#
># LPDDR & LPDDR2 PCM memory drivers
>#
># CONFIG_MTD_LPDDR is not set
>CONFIG_MTD_SPI_NOR=y
>CONFIG_MTD_MT81xx_NOR=y
># CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
># CONFIG_SPI_INTEL_SPI_PCI is not set
># CONFIG_SPI_INTEL_SPI_PLATFORM is not set
># CONFIG_MTD_UBI is not set
>CONFIG_OF=y
># CONFIG_OF_UNITTEST is not set
>CONFIG_OF_KOBJ=y
>CONFIG_OF_ADDRESS=y
>CONFIG_OF_ADDRESS_PCI=y
>CONFIG_OF_IRQ=y
>CONFIG_OF_NET=y
>CONFIG_OF_MDIO=y
>CONFIG_OF_PCI=y
>CONFIG_OF_PCI_IRQ=y
># CONFIG_OF_OVERLAY is not set
>CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
># CONFIG_PARPORT is not set
>CONFIG_PNP=y
>CONFIG_PNP_DEBUG_MESSAGES=y
>
>#
># Protocols
>#
>CONFIG_PNPACPI=y
>CONFIG_BLK_DEV=y
>CONFIG_BLK_DEV_NULL_BLK=y
>CONFIG_BLK_DEV_FD=y
>CONFIG_CDROM=y
># CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
># CONFIG_ZRAM is not set
># CONFIG_BLK_DEV_DAC960 is not set
># CONFIG_BLK_DEV_UMEM is not set
># CONFIG_BLK_DEV_COW_COMMON is not set
>CONFIG_BLK_DEV_LOOP=y
>CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
># CONFIG_BLK_DEV_CRYPTOLOOP is not set
>CONFIG_BLK_DEV_DRBD=y
>CONFIG_DRBD_FAULT_INJECTION=y
>CONFIG_BLK_DEV_NBD=y
># CONFIG_BLK_DEV_SX8 is not set
>CONFIG_BLK_DEV_RAM=y
>CONFIG_BLK_DEV_RAM_COUNT=16
>CONFIG_BLK_DEV_RAM_SIZE=4096
>CONFIG_CDROM_PKTCDVD=y
>CONFIG_CDROM_PKTCDVD_BUFFERS=8
>CONFIG_CDROM_PKTCDVD_WCACHE=y
>CONFIG_ATA_OVER_ETH=y
># CONFIG_VIRTIO_BLK is not set
>CONFIG_BLK_DEV_RBD=y
># CONFIG_BLK_DEV_RSXX is not set
>
>#
># NVME Support
>#
># CONFIG_BLK_DEV_NVME is not set
># CONFIG_NVME_FC is not set
>CONFIG_NVME_TARGET=y
># CONFIG_NVME_TARGET_LOOP is not set
># CONFIG_NVME_TARGET_FC is not set
>
>#
># Misc devices
>#
># CONFIG_SENSORS_LIS3LV02D is not set
># CONFIG_AD525X_DPOT is not set
>CONFIG_DUMMY_IRQ=y
># CONFIG_IBM_ASM is not set
># CONFIG_PHANTOM is not set
># CONFIG_SGI_IOC4 is not set
># CONFIG_TIFM_CORE is not set
># CONFIG_ICS932S401 is not set
># CONFIG_ENCLOSURE_SERVICES is not set
># CONFIG_HP_ILO is not set
># CONFIG_APDS9802ALS is not set
>CONFIG_ISL29003=y
>CONFIG_ISL29020=y
>CONFIG_SENSORS_TSL2550=y
># CONFIG_SENSORS_BH1770 is not set
>CONFIG_SENSORS_APDS990X=y
>CONFIG_HMC6352=y
># CONFIG_DS1682 is not set
># CONFIG_PCH_PHUB is not set
>CONFIG_USB_SWITCH_FSA9480=y
># CONFIG_LATTICE_ECP3_CONFIG is not set
># CONFIG_SRAM is not set
># CONFIG_PCI_ENDPOINT_TEST is not set
>CONFIG_C2PORT=y
># CONFIG_C2PORT_DURAMAR_2150 is not set
>
>#
># EEPROM support
>#
># CONFIG_EEPROM_AT24 is not set
>CONFIG_EEPROM_AT25=y
>CONFIG_EEPROM_LEGACY=y
># CONFIG_EEPROM_MAX6875 is not set
>CONFIG_EEPROM_93CX6=y
>CONFIG_EEPROM_93XX46=y
>CONFIG_EEPROM_IDT_89HPESX=y
># CONFIG_CB710_CORE is not set
>
>#
># Texas Instruments shared transport line discipline
>#
># CONFIG_TI_ST is not set
># CONFIG_SENSORS_LIS3_I2C is not set
>CONFIG_ALTERA_STAPL=y
># CONFIG_INTEL_MEI is not set
># CONFIG_INTEL_MEI_ME is not set
># CONFIG_INTEL_MEI_TXE is not set
># CONFIG_VMWARE_VMCI is not set
>
>#
># Intel MIC & related support
>#
>
>#
># Intel MIC Bus Driver
>#
>
>#
># SCIF Bus Driver
>#
>
>#
># VOP Bus Driver
>#
>
>#
># Intel MIC Host Driver
>#
>
>#
># Intel MIC Card Driver
>#
>
>#
># SCIF Driver
>#
>
>#
># Intel MIC Coprocessor State Management (COSM) Drivers
>#
>
>#
># VOP Driver
>#
># CONFIG_ECHO is not set
># CONFIG_CXL_BASE is not set
># CONFIG_CXL_AFU_DRIVER_OPS is not set
># CONFIG_CXL_LIB is not set
>CONFIG_HAVE_IDE=y
># CONFIG_IDE is not set
>
>#
># SCSI device support
>#
>CONFIG_SCSI_MOD=y
>CONFIG_RAID_ATTRS=y
>CONFIG_SCSI=y
>CONFIG_SCSI_DMA=y
>CONFIG_SCSI_NETLINK=y
>CONFIG_SCSI_MQ_DEFAULT=y
># CONFIG_SCSI_PROC_FS is not set
>
>#
># SCSI support type (disk, tape, CD-ROM)
>#
>CONFIG_BLK_DEV_SD=y
>CONFIG_CHR_DEV_ST=y
>CONFIG_CHR_DEV_OSST=y
>CONFIG_BLK_DEV_SR=y
>CONFIG_BLK_DEV_SR_VENDOR=y
>CONFIG_CHR_DEV_SG=y
># CONFIG_CHR_DEV_SCH is not set
>CONFIG_SCSI_CONSTANTS=y
>CONFIG_SCSI_LOGGING=y
># CONFIG_SCSI_SCAN_ASYNC is not set
>
>#
># SCSI Transports
>#
>CONFIG_SCSI_SPI_ATTRS=y
>CONFIG_SCSI_FC_ATTRS=y
>CONFIG_SCSI_ISCSI_ATTRS=y
>CONFIG_SCSI_SAS_ATTRS=y
>CONFIG_SCSI_SAS_LIBSAS=y
>CONFIG_SCSI_SAS_ATA=y
>CONFIG_SCSI_SAS_HOST_SMP=y
>CONFIG_SCSI_SRP_ATTRS=y
>CONFIG_SCSI_LOWLEVEL=y
>CONFIG_ISCSI_TCP=y
># CONFIG_ISCSI_BOOT_SYSFS is not set
># CONFIG_SCSI_CXGB3_ISCSI is not set
># CONFIG_SCSI_CXGB4_ISCSI is not set
># CONFIG_SCSI_BNX2_ISCSI is not set
># CONFIG_SCSI_BNX2X_FCOE is not set
># CONFIG_BE2ISCSI is not set
># CONFIG_BLK_DEV_3W_XXXX_RAID is not set
># CONFIG_SCSI_HPSA is not set
># CONFIG_SCSI_3W_9XXX is not set
># CONFIG_SCSI_3W_SAS is not set
># CONFIG_SCSI_ACARD is not set
># CONFIG_SCSI_AACRAID is not set
># CONFIG_SCSI_AIC7XXX is not set
># CONFIG_SCSI_AIC79XX is not set
># CONFIG_SCSI_AIC94XX is not set
># CONFIG_SCSI_MVSAS is not set
># CONFIG_SCSI_MVUMI is not set
># CONFIG_SCSI_DPT_I2O is not set
># CONFIG_SCSI_ADVANSYS is not set
># CONFIG_SCSI_ARCMSR is not set
># CONFIG_SCSI_ESAS2R is not set
># CONFIG_MEGARAID_NEWGEN is not set
># CONFIG_MEGARAID_LEGACY is not set
># CONFIG_MEGARAID_SAS is not set
># CONFIG_SCSI_MPT3SAS is not set
># CONFIG_SCSI_MPT2SAS is not set
># CONFIG_SCSI_SMARTPQI is not set
>CONFIG_SCSI_UFSHCD=y
># CONFIG_SCSI_UFSHCD_PCI is not set
>CONFIG_SCSI_UFSHCD_PLATFORM=y
>CONFIG_SCSI_UFS_DWC_TC_PLATFORM=y
># CONFIG_SCSI_HPTIOP is not set
># CONFIG_SCSI_BUSLOGIC is not set
># CONFIG_VMWARE_PVSCSI is not set
>CONFIG_LIBFC=y
>CONFIG_LIBFCOE=y
># CONFIG_FCOE is not set
># CONFIG_FCOE_FNIC is not set
># CONFIG_SCSI_SNIC is not set
># CONFIG_SCSI_DMX3191D is not set
># CONFIG_SCSI_EATA is not set
># CONFIG_SCSI_FUTURE_DOMAIN is not set
># CONFIG_SCSI_GDTH is not set
># CONFIG_SCSI_ISCI is not set
># CONFIG_SCSI_IPS is not set
># CONFIG_SCSI_INITIO is not set
># CONFIG_SCSI_INIA100 is not set
># CONFIG_SCSI_STEX is not set
># CONFIG_SCSI_SYM53C8XX_2 is not set
># CONFIG_SCSI_IPR is not set
># CONFIG_SCSI_QLOGIC_1280 is not set
># CONFIG_SCSI_QLA_FC is not set
># CONFIG_SCSI_QLA_ISCSI is not set
># CONFIG_SCSI_LPFC is not set
># CONFIG_SCSI_DC395x is not set
># CONFIG_SCSI_AM53C974 is not set
># CONFIG_SCSI_NSP32 is not set
># CONFIG_SCSI_WD719X is not set
>CONFIG_SCSI_DEBUG=y
># CONFIG_SCSI_PMCRAID is not set
># CONFIG_SCSI_PM8001 is not set
># CONFIG_SCSI_BFA_FC is not set
>CONFIG_SCSI_VIRTIO=y
># CONFIG_SCSI_CHELSIO_FCOE is not set
>CONFIG_SCSI_DH=y
>CONFIG_SCSI_DH_RDAC=y
># CONFIG_SCSI_DH_HP_SW is not set
># CONFIG_SCSI_DH_EMC is not set
>CONFIG_SCSI_DH_ALUA=y
># CONFIG_SCSI_OSD_INITIATOR is not set
>CONFIG_ATA=y
># CONFIG_ATA_NONSTANDARD is not set
>CONFIG_ATA_VERBOSE_ERROR=y
>CONFIG_ATA_ACPI=y
># CONFIG_SATA_ZPODD is not set
>CONFIG_SATA_PMP=y
>
>#
># Controllers with non-SFF native interface
>#
># CONFIG_SATA_AHCI is not set
>CONFIG_SATA_AHCI_PLATFORM=y
>CONFIG_AHCI_CEVA=y
>CONFIG_AHCI_QORIQ=y
># CONFIG_SATA_INIC162X is not set
># CONFIG_SATA_ACARD_AHCI is not set
># CONFIG_SATA_SIL24 is not set
>CONFIG_ATA_SFF=y
>
>#
># SFF controllers with custom DMA interface
>#
># CONFIG_PDC_ADMA is not set
># CONFIG_SATA_QSTOR is not set
># CONFIG_SATA_SX4 is not set
># CONFIG_ATA_BMDMA is not set
>
>#
># PIO-only SFF controllers
>#
># CONFIG_PATA_CMD640_PCI is not set
># CONFIG_PATA_MPIIX is not set
># CONFIG_PATA_NS87410 is not set
># CONFIG_PATA_OPTI is not set
># CONFIG_PATA_RZ1000 is not set
>
>#
># Generic fallback / legacy drivers
>#
># CONFIG_PATA_LEGACY is not set
>CONFIG_MD=y
># CONFIG_BLK_DEV_MD is not set
>CONFIG_BCACHE=y
># CONFIG_BCACHE_DEBUG is not set
># CONFIG_BCACHE_CLOSURES_DEBUG is not set
># CONFIG_BLK_DEV_DM is not set
># CONFIG_TARGET_CORE is not set
># CONFIG_FUSION is not set
>
>#
># IEEE 1394 (FireWire) support
>#
>CONFIG_FIREWIRE=y
># CONFIG_FIREWIRE_OHCI is not set
>CONFIG_FIREWIRE_SBP2=y
>CONFIG_FIREWIRE_NET=y
># CONFIG_FIREWIRE_NOSY is not set
># CONFIG_MACINTOSH_DRIVERS is not set
>CONFIG_NETDEVICES=y
>CONFIG_MII=y
># CONFIG_NET_CORE is not set
># CONFIG_ARCNET is not set
># CONFIG_ATM_DRIVERS is not set
>
>#
># CAIF transport drivers
>#
>
>#
># Distributed Switch Architecture drivers
>#
>CONFIG_B53=y
>CONFIG_B53_SPI_DRIVER=y
>CONFIG_B53_MDIO_DRIVER=y
>CONFIG_B53_MMAP_DRIVER=y
>CONFIG_B53_SRAB_DRIVER=y
># CONFIG_NET_DSA_BCM_SF2 is not set
>CONFIG_NET_DSA_LOOP=y
># CONFIG_NET_DSA_MT7530 is not set
>CONFIG_NET_DSA_MV88E6060=y
># CONFIG_MICROCHIP_KSZ is not set
># CONFIG_NET_DSA_MV88E6XXX is not set
>CONFIG_NET_DSA_QCA8K=y
>CONFIG_NET_DSA_SMSC_LAN9303=y
>CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
>CONFIG_NET_DSA_SMSC_LAN9303_MDIO=y
>CONFIG_ETHERNET=y
>CONFIG_MDIO=y
>CONFIG_NET_VENDOR_3COM=y
># CONFIG_VORTEX is not set
># CONFIG_TYPHOON is not set
>CONFIG_NET_VENDOR_ADAPTEC=y
># CONFIG_ADAPTEC_STARFIRE is not set
>CONFIG_NET_VENDOR_AGERE=y
># CONFIG_ET131X is not set
>CONFIG_NET_VENDOR_ALACRITECH=y
># CONFIG_SLICOSS is not set
>CONFIG_NET_VENDOR_ALTEON=y
># CONFIG_ACENIC is not set
># CONFIG_ALTERA_TSE is not set
>CONFIG_NET_VENDOR_AMAZON=y
>CONFIG_NET_VENDOR_AMD=y
># CONFIG_AMD8111_ETH is not set
># CONFIG_PCNET32 is not set
># CONFIG_AMD_XGBE is not set
># CONFIG_AMD_XGBE_HAVE_ECC is not set
>CONFIG_NET_VENDOR_AQUANTIA=y
>CONFIG_NET_VENDOR_ARC=y
>CONFIG_NET_VENDOR_ATHEROS=y
># CONFIG_ATL2 is not set
># CONFIG_ATL1 is not set
># CONFIG_ATL1E is not set
># CONFIG_ATL1C is not set
># CONFIG_ALX is not set
># CONFIG_NET_VENDOR_AURORA is not set
>CONFIG_NET_CADENCE=y
>CONFIG_MACB=y
>CONFIG_MACB_USE_HWSTAMP=y
># CONFIG_MACB_PCI is not set
># CONFIG_NET_VENDOR_BROADCOM is not set
>CONFIG_NET_VENDOR_BROCADE=y
># CONFIG_BNA is not set
>CONFIG_NET_VENDOR_CAVIUM=y
>CONFIG_NET_VENDOR_CHELSIO=y
># CONFIG_CHELSIO_T1 is not set
># CONFIG_CHELSIO_T3 is not set
># CONFIG_CHELSIO_T4 is not set
># CONFIG_CHELSIO_T4VF is not set
>CONFIG_NET_VENDOR_CISCO=y
># CONFIG_ENIC is not set
># CONFIG_CX_ECAT is not set
># CONFIG_DNET is not set
>CONFIG_NET_VENDOR_DEC=y
># CONFIG_NET_TULIP is not set
>CONFIG_NET_VENDOR_DLINK=y
># CONFIG_DL2K is not set
># CONFIG_SUNDANCE is not set
>CONFIG_NET_VENDOR_EMULEX=y
># CONFIG_BE2NET is not set
># CONFIG_NET_VENDOR_EZCHIP is not set
>CONFIG_NET_VENDOR_EXAR=y
># CONFIG_S2IO is not set
># CONFIG_VXGE is not set
>CONFIG_NET_VENDOR_HP=y
># CONFIG_HP100 is not set
>CONFIG_NET_VENDOR_HUAWEI=y
>CONFIG_NET_VENDOR_INTEL=y
># CONFIG_E100 is not set
>CONFIG_E1000=y
>CONFIG_E1000E=y
>CONFIG_E1000E_HWTS=y
>CONFIG_IGB=y
>CONFIG_IGB_HWMON=y
># CONFIG_IGBVF is not set
># CONFIG_IXGB is not set
>CONFIG_IXGBE=y
>CONFIG_IXGBE_HWMON=y
># CONFIG_I40E is not set
>CONFIG_NET_VENDOR_I825XX=y
># CONFIG_JME is not set
># CONFIG_NET_VENDOR_MARVELL is not set
>CONFIG_NET_VENDOR_MELLANOX=y
># CONFIG_MLX4_EN is not set
># CONFIG_MLX4_CORE is not set
># CONFIG_MLX5_CORE is not set
>CONFIG_MLXSW_CORE=y
>CONFIG_MLXSW_CORE_HWMON=y
>CONFIG_MLXSW_CORE_THERMAL=y
>CONFIG_MLXSW_PCI=y
># CONFIG_MLXSW_I2C is not set
>CONFIG_MLXSW_SWITCHIB=y
>CONFIG_MLXSW_SWITCHX2=y
>CONFIG_MLXSW_SPECTRUM=y
>CONFIG_MLXFW=y
>CONFIG_NET_VENDOR_MICREL=y
>CONFIG_KS8851=y
># CONFIG_KS8851_MLL is not set
># CONFIG_KSZ884X_PCI is not set
># CONFIG_NET_VENDOR_MICROCHIP is not set
>CONFIG_NET_VENDOR_MYRI=y
># CONFIG_MYRI10GE is not set
># CONFIG_FEALNX is not set
># CONFIG_NET_VENDOR_NATSEMI is not set
># CONFIG_NET_VENDOR_NETRONOME is not set
>CONFIG_NET_VENDOR_NVIDIA=y
># CONFIG_FORCEDETH is not set
>CONFIG_NET_VENDOR_OKI=y
># CONFIG_PCH_GBE is not set
>CONFIG_ETHOC=y
>CONFIG_NET_PACKET_ENGINE=y
># CONFIG_HAMACHI is not set
># CONFIG_YELLOWFIN is not set
>CONFIG_NET_VENDOR_QLOGIC=y
># CONFIG_QLA3XXX is not set
># CONFIG_QLCNIC is not set
># CONFIG_QLGE is not set
># CONFIG_NETXEN_NIC is not set
># CONFIG_QED is not set
>CONFIG_NET_VENDOR_QUALCOMM=y
>CONFIG_QCA7000=y
>CONFIG_QCA7000_SPI=y
># CONFIG_QCOM_EMAC is not set
>CONFIG_RMNET=y
>CONFIG_NET_VENDOR_REALTEK=y
># CONFIG_8139CP is not set
># CONFIG_8139TOO is not set
># CONFIG_R8169 is not set
>CONFIG_NET_VENDOR_RENESAS=y
>CONFIG_NET_VENDOR_RDC=y
># CONFIG_R6040 is not set
># CONFIG_NET_VENDOR_ROCKER is not set
>CONFIG_NET_VENDOR_SAMSUNG=y
># CONFIG_SXGBE_ETH is not set
>CONFIG_NET_VENDOR_SEEQ=y
>CONFIG_NET_VENDOR_SILAN=y
># CONFIG_SC92031 is not set
>CONFIG_NET_VENDOR_SIS=y
># CONFIG_SIS900 is not set
># CONFIG_SIS190 is not set
>CONFIG_NET_VENDOR_SOLARFLARE=y
># CONFIG_SFC is not set
># CONFIG_SFC_FALCON is not set
>CONFIG_NET_VENDOR_SMSC=y
># CONFIG_EPIC100 is not set
># CONFIG_SMSC911X is not set
># CONFIG_SMSC9420 is not set
>CONFIG_NET_VENDOR_STMICRO=y
># CONFIG_STMMAC_ETH is not set
>CONFIG_NET_VENDOR_SUN=y
># CONFIG_HAPPYMEAL is not set
># CONFIG_SUNGEM is not set
># CONFIG_CASSINI is not set
># CONFIG_NIU is not set
>CONFIG_NET_VENDOR_TEHUTI=y
># CONFIG_TEHUTI is not set
>CONFIG_NET_VENDOR_TI=y
># CONFIG_TI_CPSW_ALE is not set
># CONFIG_TLAN is not set
>CONFIG_NET_VENDOR_VIA=y
>CONFIG_VIA_RHINE=y
># CONFIG_VIA_RHINE_MMIO is not set
>CONFIG_VIA_VELOCITY=y
>CONFIG_NET_VENDOR_WIZNET=y
>CONFIG_WIZNET_W5100=y
># CONFIG_WIZNET_W5300 is not set
># CONFIG_WIZNET_BUS_DIRECT is not set
>CONFIG_WIZNET_BUS_INDIRECT=y
># CONFIG_WIZNET_BUS_ANY is not set
># CONFIG_NET_VENDOR_SYNOPSYS is not set
># CONFIG_FDDI is not set
># CONFIG_HIPPI is not set
># CONFIG_NET_SB1000 is not set
>CONFIG_MDIO_DEVICE=y
>CONFIG_MDIO_BUS=y
>CONFIG_MDIO_BCM_UNIMAC=y
>CONFIG_MDIO_BITBANG=y
>CONFIG_MDIO_BUS_MUX=y
># CONFIG_MDIO_BUS_MUX_GPIO is not set
>CONFIG_MDIO_BUS_MUX_MMIOREG=y
># CONFIG_MDIO_GPIO is not set
>CONFIG_MDIO_HISI_FEMAC=y
>CONFIG_PHYLIB=y
>CONFIG_SWPHY=y
># CONFIG_LED_TRIGGER_PHY is not set
>
>#
># MII PHY device drivers
>#
># CONFIG_AMD_PHY is not set
>CONFIG_AQUANTIA_PHY=y
>CONFIG_AT803X_PHY=y
>CONFIG_BCM7XXX_PHY=y
># CONFIG_BCM87XX_PHY is not set
>CONFIG_BCM_NET_PHYLIB=y
># CONFIG_BROADCOM_PHY is not set
># CONFIG_CICADA_PHY is not set
># CONFIG_CORTINA_PHY is not set
>CONFIG_DAVICOM_PHY=y
>CONFIG_DP83822_PHY=y
># CONFIG_DP83848_PHY is not set
>CONFIG_DP83867_PHY=y
>CONFIG_FIXED_PHY=y
># CONFIG_ICPLUS_PHY is not set
># CONFIG_INTEL_XWAY_PHY is not set
># CONFIG_LSI_ET1011C_PHY is not set
>CONFIG_LXT_PHY=y
># CONFIG_MARVELL_PHY is not set
>CONFIG_MARVELL_10G_PHY=y
>CONFIG_MICREL_PHY=y
>CONFIG_MICROCHIP_PHY=y
>CONFIG_MICROSEMI_PHY=y
>CONFIG_NATIONAL_PHY=y
># CONFIG_QSEMI_PHY is not set
># CONFIG_REALTEK_PHY is not set
>CONFIG_RENESAS_PHY=y
>CONFIG_ROCKCHIP_PHY=y
>CONFIG_SMSC_PHY=y
># CONFIG_STE10XP is not set
># CONFIG_TERANETICS_PHY is not set
>CONFIG_VITESSE_PHY=y
># CONFIG_XILINX_GMII2RGMII is not set
># CONFIG_MICREL_KS8995MA is not set
>CONFIG_PPP=y
># CONFIG_PPP_BSDCOMP is not set
># CONFIG_PPP_DEFLATE is not set
># CONFIG_PPP_FILTER is not set
>CONFIG_PPP_MPPE=y
>CONFIG_PPP_MULTILINK=y
># CONFIG_PPPOATM is not set
>CONFIG_PPPOE=y
># CONFIG_PPTP is not set
>CONFIG_PPPOL2TP=y
># CONFIG_PPP_ASYNC is not set
>CONFIG_PPP_SYNC_TTY=y
>CONFIG_SLIP=y
>CONFIG_SLHC=y
># CONFIG_SLIP_COMPRESSED is not set
># CONFIG_SLIP_SMART is not set
># CONFIG_SLIP_MODE_SLIP6 is not set
>CONFIG_USB_NET_DRIVERS=y
>CONFIG_USB_CATC=y
># CONFIG_USB_KAWETH is not set
>CONFIG_USB_PEGASUS=y
>CONFIG_USB_RTL8150=y
># CONFIG_USB_RTL8152 is not set
>CONFIG_USB_LAN78XX=y
>CONFIG_USB_USBNET=y
># CONFIG_USB_NET_AX8817X is not set
>CONFIG_USB_NET_AX88179_178A=y
>CONFIG_USB_NET_CDCETHER=y
># CONFIG_USB_NET_CDC_EEM is not set
>CONFIG_USB_NET_CDC_NCM=y
>CONFIG_USB_NET_HUAWEI_CDC_NCM=y
># CONFIG_USB_NET_CDC_MBIM is not set
>CONFIG_USB_NET_DM9601=y
>CONFIG_USB_NET_SR9700=y
>CONFIG_USB_NET_SR9800=y
>CONFIG_USB_NET_SMSC75XX=y
>CONFIG_USB_NET_SMSC95XX=y
>CONFIG_USB_NET_GL620A=y
>CONFIG_USB_NET_NET1080=y
>CONFIG_USB_NET_PLUSB=y
>CONFIG_USB_NET_MCS7830=y
>CONFIG_USB_NET_RNDIS_HOST=y
>CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
>CONFIG_USB_NET_CDC_SUBSET=y
>CONFIG_USB_ALI_M5632=y
>CONFIG_USB_AN2720=y
># CONFIG_USB_BELKIN is not set
># CONFIG_USB_ARMLINUX is not set
># CONFIG_USB_EPSON2888 is not set
># CONFIG_USB_KC2190 is not set
>CONFIG_USB_NET_ZAURUS=y
># CONFIG_USB_NET_CX82310_ETH is not set
>CONFIG_USB_NET_KALMIA=y
>CONFIG_USB_NET_QMI_WWAN=y
># CONFIG_USB_HSO is not set
>CONFIG_USB_NET_INT51X1=y
>CONFIG_USB_IPHETH=y
>CONFIG_USB_SIERRA_NET=y
>CONFIG_USB_VL600=y
># CONFIG_USB_NET_CH9200 is not set
>CONFIG_WLAN=y
># CONFIG_WLAN_VENDOR_ADMTEK is not set
># CONFIG_WLAN_VENDOR_ATH is not set
># CONFIG_WLAN_VENDOR_ATMEL is not set
>CONFIG_WLAN_VENDOR_BROADCOM=y
># CONFIG_BRCMFMAC is not set
># CONFIG_WLAN_VENDOR_CISCO is not set
>CONFIG_WLAN_VENDOR_INTEL=y
># CONFIG_IPW2100 is not set
># CONFIG_IPW2200 is not set
># CONFIG_WLAN_VENDOR_INTERSIL is not set
># CONFIG_WLAN_VENDOR_MARVELL is not set
># CONFIG_WLAN_VENDOR_MEDIATEK is not set
># CONFIG_WLAN_VENDOR_RALINK is not set
>CONFIG_WLAN_VENDOR_REALTEK=y
># CONFIG_WLAN_VENDOR_RSI is not set
>CONFIG_WLAN_VENDOR_ST=y
>CONFIG_WLAN_VENDOR_TI=y
>CONFIG_WLAN_VENDOR_ZYDAS=y
># CONFIG_USB_ZD1201 is not set
>CONFIG_WLAN_VENDOR_QUANTENNA=y
># CONFIG_QTNFMAC_PEARL_PCIE is not set
>CONFIG_USB_NET_RNDIS_WLAN=y
>
>#
># WiMAX Wireless Broadband devices
>#
>CONFIG_WIMAX_I2400M=y
>CONFIG_WIMAX_I2400M_USB=y
>CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
># CONFIG_WAN is not set
>CONFIG_IEEE802154_DRIVERS=y
>CONFIG_IEEE802154_FAKELB=y
># CONFIG_IEEE802154_AT86RF230 is not set
>CONFIG_IEEE802154_MRF24J40=y
># CONFIG_IEEE802154_CC2520 is not set
># CONFIG_IEEE802154_ATUSB is not set
>CONFIG_IEEE802154_ADF7242=y
># CONFIG_IEEE802154_CA8210 is not set
># CONFIG_VMXNET3 is not set
># CONFIG_FUJITSU_ES is not set
># CONFIG_ISDN is not set
># CONFIG_NVM is not set
>
>#
># Input device support
>#
>CONFIG_INPUT=y
>CONFIG_INPUT_LEDS=y
>CONFIG_INPUT_FF_MEMLESS=y
>CONFIG_INPUT_POLLDEV=y
>CONFIG_INPUT_SPARSEKMAP=y
>CONFIG_INPUT_MATRIXKMAP=y
>
>#
># Userland interfaces
>#
>CONFIG_INPUT_MOUSEDEV=y
># CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>CONFIG_INPUT_JOYDEV=y
>CONFIG_INPUT_EVDEV=y
>CONFIG_INPUT_EVBUG=y
>
>#
># Input Device Drivers
>#
>CONFIG_INPUT_KEYBOARD=y
># CONFIG_KEYBOARD_ADP5520 is not set
>CONFIG_KEYBOARD_ADP5588=y
># CONFIG_KEYBOARD_ADP5589 is not set
>CONFIG_KEYBOARD_ATKBD=y
>CONFIG_KEYBOARD_QT1070=y
># CONFIG_KEYBOARD_QT2160 is not set
>CONFIG_KEYBOARD_DLINK_DIR685=y
>CONFIG_KEYBOARD_LKKBD=y
>CONFIG_KEYBOARD_GPIO=y
># CONFIG_KEYBOARD_GPIO_POLLED is not set
>CONFIG_KEYBOARD_TCA6416=y
># CONFIG_KEYBOARD_TCA8418 is not set
>CONFIG_KEYBOARD_MATRIX=y
>CONFIG_KEYBOARD_LM8323=y
>CONFIG_KEYBOARD_LM8333=y
>CONFIG_KEYBOARD_MAX7359=y
>CONFIG_KEYBOARD_MCS=y
>CONFIG_KEYBOARD_MPR121=y
>CONFIG_KEYBOARD_NEWTON=y
>CONFIG_KEYBOARD_OPENCORES=y
># CONFIG_KEYBOARD_SAMSUNG is not set
>CONFIG_KEYBOARD_STOWAWAY=y
>CONFIG_KEYBOARD_SUNKBD=y
># CONFIG_KEYBOARD_OMAP4 is not set
># CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
># CONFIG_KEYBOARD_XTKBD is not set
># CONFIG_KEYBOARD_CAP11XX is not set
># CONFIG_KEYBOARD_BCM is not set
>CONFIG_INPUT_MOUSE=y
># CONFIG_MOUSE_PS2 is not set
># CONFIG_MOUSE_SERIAL is not set
>CONFIG_MOUSE_APPLETOUCH=y
>CONFIG_MOUSE_BCM5974=y
>CONFIG_MOUSE_CYAPA=y
>CONFIG_MOUSE_ELAN_I2C=y
># CONFIG_MOUSE_ELAN_I2C_I2C is not set
># CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
>CONFIG_MOUSE_VSXXXAA=y
>CONFIG_MOUSE_GPIO=y
>CONFIG_MOUSE_SYNAPTICS_I2C=y
>CONFIG_MOUSE_SYNAPTICS_USB=y
># CONFIG_INPUT_JOYSTICK is not set
>CONFIG_INPUT_TABLET=y
>CONFIG_TABLET_USB_ACECAD=y
># CONFIG_TABLET_USB_AIPTEK is not set
>CONFIG_TABLET_USB_GTCO=y
># CONFIG_TABLET_USB_HANWANG is not set
>CONFIG_TABLET_USB_KBTAB=y
>CONFIG_TABLET_USB_PEGASUS=y
>CONFIG_TABLET_SERIAL_WACOM4=y
># CONFIG_INPUT_TOUCHSCREEN is not set
>CONFIG_INPUT_MISC=y
># CONFIG_INPUT_88PM860X_ONKEY is not set
>CONFIG_INPUT_88PM80X_ONKEY=y
>CONFIG_INPUT_AD714X=y
># CONFIG_INPUT_AD714X_I2C is not set
>CONFIG_INPUT_AD714X_SPI=y
>CONFIG_INPUT_ATMEL_CAPTOUCH=y
>CONFIG_INPUT_BMA150=y
>CONFIG_INPUT_E3X0_BUTTON=y
>CONFIG_INPUT_PCSPKR=y
>CONFIG_INPUT_MAX77693_HAPTIC=y
>CONFIG_INPUT_MAX8997_HAPTIC=y
>CONFIG_INPUT_MC13783_PWRBUTTON=y
># CONFIG_INPUT_MMA8450 is not set
>CONFIG_INPUT_APANEL=y
># CONFIG_INPUT_GP2A is not set
>CONFIG_INPUT_GPIO_BEEPER=y
>CONFIG_INPUT_GPIO_TILT_POLLED=y
># CONFIG_INPUT_GPIO_DECODER is not set
>CONFIG_INPUT_WISTRON_BTNS=y
># CONFIG_INPUT_ATLAS_BTNS is not set
>CONFIG_INPUT_ATI_REMOTE2=y
>CONFIG_INPUT_KEYSPAN_REMOTE=y
># CONFIG_INPUT_KXTJ9 is not set
>CONFIG_INPUT_POWERMATE=y
>CONFIG_INPUT_YEALINK=y
>CONFIG_INPUT_CM109=y
># CONFIG_INPUT_REGULATOR_HAPTIC is not set
># CONFIG_INPUT_AXP20X_PEK is not set
># CONFIG_INPUT_UINPUT is not set
># CONFIG_INPUT_PCF8574 is not set
># CONFIG_INPUT_PWM_BEEPER is not set
>CONFIG_INPUT_PWM_VIBRA=y
>CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
>CONFIG_INPUT_DA9052_ONKEY=y
>CONFIG_INPUT_DA9055_ONKEY=y
>CONFIG_INPUT_DA9063_ONKEY=y
>CONFIG_INPUT_WM831X_ON=y
>CONFIG_INPUT_PCAP=y
>CONFIG_INPUT_ADXL34X=y
>CONFIG_INPUT_ADXL34X_I2C=y
>CONFIG_INPUT_ADXL34X_SPI=y
>CONFIG_INPUT_IMS_PCU=y
>CONFIG_INPUT_CMA3000=y
># CONFIG_INPUT_CMA3000_I2C is not set
>CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
>CONFIG_INPUT_SOC_BUTTON_ARRAY=y
>CONFIG_INPUT_DRV260X_HAPTICS=y
># CONFIG_INPUT_DRV2665_HAPTICS is not set
>CONFIG_INPUT_DRV2667_HAPTICS=y
>CONFIG_RMI4_CORE=y
>CONFIG_RMI4_I2C=y
>CONFIG_RMI4_SPI=y
># CONFIG_RMI4_SMB is not set
>CONFIG_RMI4_F03=y
>CONFIG_RMI4_F03_SERIO=y
>CONFIG_RMI4_2D_SENSOR=y
>CONFIG_RMI4_F11=y
>CONFIG_RMI4_F12=y
>CONFIG_RMI4_F30=y
># CONFIG_RMI4_F34 is not set
>CONFIG_RMI4_F54=y
>CONFIG_RMI4_F55=y
>
>#
># Hardware I/O ports
>#
>CONFIG_SERIO=y
>CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
>CONFIG_SERIO_I8042=y
>CONFIG_SERIO_SERPORT=y
>CONFIG_SERIO_CT82C710=y
># CONFIG_SERIO_PCIPS2 is not set
>CONFIG_SERIO_LIBPS2=y
># CONFIG_SERIO_RAW is not set
>CONFIG_SERIO_ALTERA_PS2=y
>CONFIG_SERIO_PS2MULT=y
>CONFIG_SERIO_ARC_PS2=y
>CONFIG_SERIO_APBPS2=y
>CONFIG_SERIO_GPIO_PS2=y
>CONFIG_USERIO=y
>CONFIG_GAMEPORT=y
># CONFIG_GAMEPORT_NS558 is not set
>CONFIG_GAMEPORT_L4=y
># CONFIG_GAMEPORT_EMU10K1 is not set
># CONFIG_GAMEPORT_FM801 is not set
>
>#
># Character devices
>#
>CONFIG_TTY=y
>CONFIG_VT=y
>CONFIG_CONSOLE_TRANSLATIONS=y
>CONFIG_VT_CONSOLE=y
>CONFIG_VT_CONSOLE_SLEEP=y
>CONFIG_HW_CONSOLE=y
>CONFIG_VT_HW_CONSOLE_BINDING=y
>CONFIG_UNIX98_PTYS=y
>CONFIG_LEGACY_PTYS=y
>CONFIG_LEGACY_PTY_COUNT=256
>CONFIG_SERIAL_NONSTANDARD=y
># CONFIG_ROCKETPORT is not set
># CONFIG_CYCLADES is not set
># CONFIG_MOXA_INTELLIO is not set
># CONFIG_MOXA_SMARTIO is not set
># CONFIG_SYNCLINK is not set
># CONFIG_SYNCLINKMP is not set
># CONFIG_SYNCLINK_GT is not set
># CONFIG_NOZOMI is not set
># CONFIG_ISI is not set
># CONFIG_N_HDLC is not set
># CONFIG_N_GSM is not set
>CONFIG_TRACE_ROUTER=y
>CONFIG_TRACE_SINK=y
># CONFIG_DEVMEM is not set
>CONFIG_DEVKMEM=y
>
>#
># Serial drivers
>#
>CONFIG_SERIAL_EARLYCON=y
>CONFIG_SERIAL_8250=y
>CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
>CONFIG_SERIAL_8250_PNP=y
># CONFIG_SERIAL_8250_FINTEK is not set
>CONFIG_SERIAL_8250_CONSOLE=y
>CONFIG_SERIAL_8250_PCI=y
>CONFIG_SERIAL_8250_EXAR=y
># CONFIG_SERIAL_8250_MEN_MCB is not set
>CONFIG_SERIAL_8250_NR_UARTS=4
>CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>CONFIG_SERIAL_8250_EXTENDED=y
>CONFIG_SERIAL_8250_MANY_PORTS=y
># CONFIG_SERIAL_8250_ASPEED_VUART is not set
># CONFIG_SERIAL_8250_SHARE_IRQ is not set
># CONFIG_SERIAL_8250_DETECT_IRQ is not set
>CONFIG_SERIAL_8250_RSA=y
># CONFIG_SERIAL_8250_FSL is not set
># CONFIG_SERIAL_8250_DW is not set
># CONFIG_SERIAL_8250_RT288X is not set
>CONFIG_SERIAL_8250_LPSS=y
>CONFIG_SERIAL_8250_MID=y
># CONFIG_SERIAL_8250_MOXA is not set
># CONFIG_SERIAL_OF_PLATFORM is not set
>
>#
># Non-8250 serial port support
>#
># CONFIG_SERIAL_MAX3100 is not set
>CONFIG_SERIAL_MAX310X=y
>CONFIG_SERIAL_UARTLITE=y
>CONFIG_SERIAL_UARTLITE_CONSOLE=y
>CONFIG_SERIAL_UARTLITE_NR_UARTS=1
>CONFIG_SERIAL_CORE=y
>CONFIG_SERIAL_CORE_CONSOLE=y
># CONFIG_SERIAL_JSM is not set
># CONFIG_SERIAL_SCCNXP is not set
># CONFIG_SERIAL_SC16IS7XX is not set
>CONFIG_SERIAL_TIMBERDALE=y
># CONFIG_SERIAL_ALTERA_JTAGUART is not set
>CONFIG_SERIAL_ALTERA_UART=y
>CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
>CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
># CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
>CONFIG_SERIAL_IFX6X60=y
># CONFIG_SERIAL_PCH_UART is not set
># CONFIG_SERIAL_XILINX_PS_UART is not set
>CONFIG_SERIAL_ARC=y
>CONFIG_SERIAL_ARC_CONSOLE=y
>CONFIG_SERIAL_ARC_NR_PORTS=1
># CONFIG_SERIAL_RP2 is not set
>CONFIG_SERIAL_FSL_LPUART=y
>CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
># CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
>CONFIG_SERIAL_MEN_Z135=y
># CONFIG_SERIAL_DEV_BUS is not set
># CONFIG_VIRTIO_CONSOLE is not set
>CONFIG_IPMI_HANDLER=y
>CONFIG_IPMI_DMI_DECODE=y
># CONFIG_IPMI_PROC_INTERFACE is not set
># CONFIG_IPMI_PANIC_EVENT is not set
># CONFIG_IPMI_DEVICE_INTERFACE is not set
>CONFIG_IPMI_SI=y
>CONFIG_IPMI_SSIF=y
># CONFIG_IPMI_WATCHDOG is not set
>CONFIG_IPMI_POWEROFF=y
># CONFIG_HW_RANDOM is not set
>CONFIG_NVRAM=y
>CONFIG_R3964=y
># CONFIG_APPLICOM is not set
># CONFIG_SONYPI is not set
>CONFIG_MWAVE=y
>CONFIG_PC8736x_GPIO=y
>CONFIG_NSC_GPIO=y
># CONFIG_RAW_DRIVER is not set
># CONFIG_HPET is not set
>CONFIG_HANGCHECK_TIMER=y
>CONFIG_TCG_TPM=y
>CONFIG_TCG_TIS_CORE=y
># CONFIG_TCG_TIS is not set
>CONFIG_TCG_TIS_SPI=y
># CONFIG_TCG_TIS_I2C_ATMEL is not set
># CONFIG_TCG_TIS_I2C_INFINEON is not set
># CONFIG_TCG_TIS_I2C_NUVOTON is not set
>CONFIG_TCG_NSC=y
>CONFIG_TCG_ATMEL=y
># CONFIG_TCG_INFINEON is not set
># CONFIG_TCG_CRB is not set
># CONFIG_TCG_VTPM_PROXY is not set
>CONFIG_TCG_TIS_ST33ZP24=y
>CONFIG_TCG_TIS_ST33ZP24_I2C=y
>CONFIG_TCG_TIS_ST33ZP24_SPI=y
>CONFIG_TELCLOCK=y
>CONFIG_DEVPORT=y
>CONFIG_XILLYBUS=y
>CONFIG_XILLYBUS_OF=y
>
>#
># I2C support
>#
>CONFIG_I2C=y
>CONFIG_ACPI_I2C_OPREGION=y
>CONFIG_I2C_BOARDINFO=y
># CONFIG_I2C_COMPAT is not set
># CONFIG_I2C_CHARDEV is not set
>CONFIG_I2C_MUX=y
>
>#
># Multiplexer I2C Chip support
>#
>CONFIG_I2C_ARB_GPIO_CHALLENGE=y
>CONFIG_I2C_MUX_GPIO=y
>CONFIG_I2C_MUX_GPMUX=y
>CONFIG_I2C_MUX_LTC4306=y
>CONFIG_I2C_MUX_PCA9541=y
>CONFIG_I2C_MUX_PCA954x=y
>CONFIG_I2C_MUX_REG=y
>CONFIG_I2C_MUX_MLXCPLD=y
>CONFIG_I2C_HELPER_AUTO=y
>CONFIG_I2C_SMBUS=y
>CONFIG_I2C_ALGOBIT=y
>CONFIG_I2C_ALGOPCA=y
>
>#
># I2C Hardware Bus support
>#
>
>#
># PC SMBus host controller drivers
>#
># CONFIG_I2C_ALI1535 is not set
># CONFIG_I2C_ALI1563 is not set
># CONFIG_I2C_ALI15X3 is not set
># CONFIG_I2C_AMD756 is not set
># CONFIG_I2C_AMD8111 is not set
># CONFIG_I2C_I801 is not set
># CONFIG_I2C_ISCH is not set
># CONFIG_I2C_ISMT is not set
># CONFIG_I2C_PIIX4 is not set
># CONFIG_I2C_NFORCE2 is not set
># CONFIG_I2C_SIS5595 is not set
># CONFIG_I2C_SIS630 is not set
># CONFIG_I2C_SIS96X is not set
># CONFIG_I2C_VIA is not set
># CONFIG_I2C_VIAPRO is not set
>
>#
># ACPI drivers
>#
># CONFIG_I2C_SCMI is not set
>
>#
># I2C system bus drivers (mostly embedded / system-on-chip)
>#
>CONFIG_I2C_CBUS_GPIO=y
>CONFIG_I2C_DESIGNWARE_CORE=y
>CONFIG_I2C_DESIGNWARE_PLATFORM=y
># CONFIG_I2C_DESIGNWARE_SLAVE is not set
># CONFIG_I2C_DESIGNWARE_PCI is not set
># CONFIG_I2C_EG20T is not set
># CONFIG_I2C_EMEV2 is not set
>CONFIG_I2C_GPIO=y
># CONFIG_I2C_KEMPLD is not set
>CONFIG_I2C_OCORES=y
>CONFIG_I2C_PCA_PLATFORM=y
># CONFIG_I2C_PXA is not set
># CONFIG_I2C_PXA_PCI is not set
># CONFIG_I2C_RK3X is not set
>CONFIG_I2C_SIMTEC=y
>CONFIG_I2C_XILINX=y
>
>#
># External I2C/SMBus adapter drivers
>#
># CONFIG_I2C_DIOLAN_U2C is not set
>CONFIG_I2C_DLN2=y
>CONFIG_I2C_PARPORT_LIGHT=y
>CONFIG_I2C_ROBOTFUZZ_OSIF=y
># CONFIG_I2C_TAOS_EVM is not set
>CONFIG_I2C_TINY_USB=y
>
>#
># Other I2C/SMBus bus drivers
>#
># CONFIG_SCx200_ACB is not set
># CONFIG_I2C_SLAVE is not set
># CONFIG_I2C_DEBUG_CORE is not set
># CONFIG_I2C_DEBUG_ALGO is not set
># CONFIG_I2C_DEBUG_BUS is not set
>CONFIG_SPI=y
>CONFIG_SPI_DEBUG=y
>CONFIG_SPI_MASTER=y
>
>#
># SPI Master Controller Drivers
>#
># CONFIG_SPI_ALTERA is not set
>CONFIG_SPI_AXI_SPI_ENGINE=y
>CONFIG_SPI_BITBANG=y
>CONFIG_SPI_CADENCE=y
>CONFIG_SPI_DESIGNWARE=y
># CONFIG_SPI_DW_PCI is not set
>CONFIG_SPI_DW_MMIO=y
># CONFIG_SPI_DLN2 is not set
>CONFIG_SPI_GPIO=y
>CONFIG_SPI_FSL_LIB=y
>CONFIG_SPI_FSL_SPI=y
># CONFIG_SPI_OC_TINY is not set
># CONFIG_SPI_PXA2XX is not set
># CONFIG_SPI_PXA2XX_PCI is not set
>CONFIG_SPI_ROCKCHIP=y
>CONFIG_SPI_SC18IS602=y
># CONFIG_SPI_TOPCLIFF_PCH is not set
>CONFIG_SPI_XCOMM=y
>CONFIG_SPI_XILINX=y
>CONFIG_SPI_ZYNQMP_GQSPI=y
>
>#
># SPI Protocol Masters
>#
>CONFIG_SPI_SPIDEV=y
>CONFIG_SPI_TLE62X0=y
># CONFIG_SPI_SLAVE is not set
>CONFIG_SPMI=y
>CONFIG_HSI=y
>CONFIG_HSI_BOARDINFO=y
>
>#
># HSI controllers
>#
>
>#
># HSI clients
>#
># CONFIG_HSI_CHAR is not set
>CONFIG_PPS=y
># CONFIG_PPS_DEBUG is not set
>
>#
># PPS clients support
>#
>CONFIG_PPS_CLIENT_KTIMER=y
>CONFIG_PPS_CLIENT_LDISC=y
>CONFIG_PPS_CLIENT_GPIO=y
>
>#
># PPS generators support
>#
>
>#
># PTP clock support
>#
>CONFIG_PTP_1588_CLOCK=y
># CONFIG_DP83640_PHY is not set
>CONFIG_PTP_1588_CLOCK_PCH=y
>CONFIG_PTP_1588_CLOCK_KVM=y
># CONFIG_PINCTRL is not set
>CONFIG_GPIOLIB=y
>CONFIG_OF_GPIO=y
>CONFIG_GPIO_ACPI=y
>CONFIG_GPIOLIB_IRQCHIP=y
># CONFIG_DEBUG_GPIO is not set
>CONFIG_GPIO_SYSFS=y
>CONFIG_GPIO_GENERIC=y
>CONFIG_GPIO_MAX730X=y
>
>#
># Memory mapped GPIO drivers
>#
># CONFIG_GPIO_74XX_MMIO is not set
>CONFIG_GPIO_ALTERA=y
># CONFIG_GPIO_AMDPT is not set
># CONFIG_GPIO_AXP209 is not set
># CONFIG_GPIO_DWAPB is not set
># CONFIG_GPIO_EXAR is not set
># CONFIG_GPIO_FTGPIO010 is not set
>CONFIG_GPIO_GENERIC_PLATFORM=y
># CONFIG_GPIO_GRGPIO is not set
># CONFIG_GPIO_ICH is not set
># CONFIG_GPIO_LYNXPOINT is not set
>CONFIG_GPIO_MB86S7X=y
>CONFIG_GPIO_MENZ127=y
>CONFIG_GPIO_MOCKUP=y
>CONFIG_GPIO_SYSCON=y
># CONFIG_GPIO_VX855 is not set
>CONFIG_GPIO_XILINX=y
>
>#
># Port-mapped I/O GPIO drivers
>#
>CONFIG_GPIO_F7188X=y
>CONFIG_GPIO_IT87=y
># CONFIG_GPIO_SCH is not set
># CONFIG_GPIO_SCH311X is not set
>
>#
># I2C GPIO expanders
>#
>CONFIG_GPIO_ADP5588=y
># CONFIG_GPIO_ADP5588_IRQ is not set
>CONFIG_GPIO_ADNP=y
>CONFIG_GPIO_MAX7300=y
>CONFIG_GPIO_MAX732X=y
># CONFIG_GPIO_MAX732X_IRQ is not set
>CONFIG_GPIO_PCA953X=y
>CONFIG_GPIO_PCA953X_IRQ=y
>CONFIG_GPIO_PCF857X=y
>CONFIG_GPIO_TPIC2810=y
>
>#
># MFD GPIO expanders
>#
>CONFIG_GPIO_ADP5520=y
># CONFIG_GPIO_ARIZONA is not set
>CONFIG_GPIO_BD9571MWV=y
>CONFIG_GPIO_DA9052=y
>CONFIG_GPIO_DA9055=y
># CONFIG_GPIO_DLN2 is not set
>CONFIG_GPIO_KEMPLD=y
>CONFIG_GPIO_LP3943=y
>CONFIG_GPIO_LP873X=y
>CONFIG_GPIO_MAX77620=y
>CONFIG_GPIO_RC5T583=y
>CONFIG_GPIO_TPS65086=y
># CONFIG_GPIO_TPS6586X is not set
># CONFIG_GPIO_TPS65910 is not set
>CONFIG_GPIO_TPS65912=y
>CONFIG_GPIO_WM831X=y
>
>#
># PCI GPIO expanders
>#
># CONFIG_GPIO_AMD8111 is not set
># CONFIG_GPIO_BT8XX is not set
># CONFIG_GPIO_ML_IOH is not set
># CONFIG_GPIO_PCH is not set
># CONFIG_GPIO_PCI_IDIO_16 is not set
># CONFIG_GPIO_RDC321X is not set
># CONFIG_GPIO_SODAVILLE is not set
>
>#
># SPI GPIO expanders
>#
># CONFIG_GPIO_74X164 is not set
>CONFIG_GPIO_MAX3191X=y
>CONFIG_GPIO_MAX7301=y
># CONFIG_GPIO_MC33880 is not set
>CONFIG_GPIO_PISOSR=y
>CONFIG_GPIO_XRA1403=y
>
>#
># USB GPIO expanders
>#
>CONFIG_W1=y
>CONFIG_W1_CON=y
>
>#
># 1-wire Bus Masters
>#
># CONFIG_W1_MASTER_MATROX is not set
># CONFIG_W1_MASTER_DS2490 is not set
># CONFIG_W1_MASTER_DS2482 is not set
># CONFIG_W1_MASTER_DS1WM is not set
>CONFIG_W1_MASTER_GPIO=y
>
>#
># 1-wire Slaves
>#
>CONFIG_W1_SLAVE_THERM=y
># CONFIG_W1_SLAVE_SMEM is not set
># CONFIG_W1_SLAVE_DS2405 is not set
>CONFIG_W1_SLAVE_DS2408=y
>CONFIG_W1_SLAVE_DS2408_READBACK=y
># CONFIG_W1_SLAVE_DS2413 is not set
>CONFIG_W1_SLAVE_DS2406=y
># CONFIG_W1_SLAVE_DS2423 is not set
>CONFIG_W1_SLAVE_DS2805=y
>CONFIG_W1_SLAVE_DS2431=y
>CONFIG_W1_SLAVE_DS2433=y
># CONFIG_W1_SLAVE_DS2433_CRC is not set
>CONFIG_W1_SLAVE_DS2438=y
>CONFIG_W1_SLAVE_DS2760=y
>CONFIG_W1_SLAVE_DS2780=y
>CONFIG_W1_SLAVE_DS2781=y
>CONFIG_W1_SLAVE_DS28E04=y
># CONFIG_W1_SLAVE_DS28E17 is not set
>CONFIG_POWER_AVS=y
># CONFIG_POWER_RESET is not set
>CONFIG_POWER_SUPPLY=y
>CONFIG_POWER_SUPPLY_DEBUG=y
># CONFIG_PDA_POWER is not set
># CONFIG_WM831X_BACKUP is not set
>CONFIG_WM831X_POWER=y
>CONFIG_TEST_POWER=y
>CONFIG_BATTERY_88PM860X=y
>CONFIG_BATTERY_DS2760=y
>CONFIG_BATTERY_DS2780=y
># CONFIG_BATTERY_DS2781 is not set
>CONFIG_BATTERY_DS2782=y
>CONFIG_BATTERY_SBS=y
># CONFIG_CHARGER_SBS is not set
>CONFIG_MANAGER_SBS=y
>CONFIG_BATTERY_BQ27XXX=y
>CONFIG_BATTERY_BQ27XXX_I2C=y
>CONFIG_BATTERY_BQ27XXX_HDQ=y
># CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
># CONFIG_BATTERY_DA9052 is not set
>CONFIG_BATTERY_DA9150=y
># CONFIG_AXP288_CHARGER is not set
>CONFIG_BATTERY_MAX17040=y
>CONFIG_BATTERY_MAX17042=y
>CONFIG_BATTERY_MAX1721X=y
># CONFIG_CHARGER_88PM860X is not set
>CONFIG_CHARGER_ISP1704=y
>CONFIG_CHARGER_MAX8903=y
>CONFIG_CHARGER_LP8727=y
>CONFIG_CHARGER_GPIO=y
># CONFIG_CHARGER_MANAGER is not set
>CONFIG_CHARGER_LTC3651=y
>CONFIG_CHARGER_DETECTOR_MAX14656=y
>CONFIG_CHARGER_MAX8997=y
># CONFIG_CHARGER_BQ2415X is not set
>CONFIG_CHARGER_BQ24190=y
>CONFIG_CHARGER_BQ24257=y
># CONFIG_CHARGER_BQ24735 is not set
>CONFIG_CHARGER_BQ25890=y
>CONFIG_CHARGER_SMB347=y
># CONFIG_CHARGER_TPS65090 is not set
>CONFIG_BATTERY_GAUGE_LTC2941=y
># CONFIG_CHARGER_RT9455 is not set
>CONFIG_HWMON=y
>CONFIG_HWMON_VID=y
>CONFIG_HWMON_DEBUG_CHIP=y
>
>#
># Native drivers
>#
># CONFIG_SENSORS_ABITUGURU is not set
>CONFIG_SENSORS_ABITUGURU3=y
>CONFIG_SENSORS_AD7314=y
># CONFIG_SENSORS_AD7414 is not set
># CONFIG_SENSORS_AD7418 is not set
>CONFIG_SENSORS_ADM1021=y
>CONFIG_SENSORS_ADM1025=y
>CONFIG_SENSORS_ADM1026=y
># CONFIG_SENSORS_ADM1029 is not set
>CONFIG_SENSORS_ADM1031=y
>CONFIG_SENSORS_ADM9240=y
>CONFIG_SENSORS_ADT7X10=y
>CONFIG_SENSORS_ADT7310=y
># CONFIG_SENSORS_ADT7410 is not set
>CONFIG_SENSORS_ADT7411=y
># CONFIG_SENSORS_ADT7462 is not set
># CONFIG_SENSORS_ADT7470 is not set
># CONFIG_SENSORS_ADT7475 is not set
>CONFIG_SENSORS_ASC7621=y
># CONFIG_SENSORS_K8TEMP is not set
># CONFIG_SENSORS_K10TEMP is not set
># CONFIG_SENSORS_FAM15H_POWER is not set
># CONFIG_SENSORS_APPLESMC is not set
>CONFIG_SENSORS_ASB100=y
>CONFIG_SENSORS_ASPEED=y
>CONFIG_SENSORS_ATXP1=y
>CONFIG_SENSORS_DS620=y
>CONFIG_SENSORS_DS1621=y
># CONFIG_SENSORS_DELL_SMM is not set
>CONFIG_SENSORS_DA9052_ADC=y
>CONFIG_SENSORS_DA9055=y
># CONFIG_SENSORS_I5K_AMB is not set
># CONFIG_SENSORS_F71805F is not set
>CONFIG_SENSORS_F71882FG=y
>CONFIG_SENSORS_F75375S=y
>CONFIG_SENSORS_MC13783_ADC=y
># CONFIG_SENSORS_FSCHMD is not set
>CONFIG_SENSORS_GL518SM=y
>CONFIG_SENSORS_GL520SM=y
>CONFIG_SENSORS_G760A=y
># CONFIG_SENSORS_G762 is not set
># CONFIG_SENSORS_GPIO_FAN is not set
>CONFIG_SENSORS_HIH6130=y
>CONFIG_SENSORS_IBMAEM=y
>CONFIG_SENSORS_IBMPEX=y
># CONFIG_SENSORS_I5500 is not set
>CONFIG_SENSORS_CORETEMP=y
>CONFIG_SENSORS_IT87=y
># CONFIG_SENSORS_JC42 is not set
># CONFIG_SENSORS_POWR1220 is not set
>CONFIG_SENSORS_LINEAGE=y
># CONFIG_SENSORS_LTC2945 is not set
># CONFIG_SENSORS_LTC2990 is not set
>CONFIG_SENSORS_LTC4151=y
># CONFIG_SENSORS_LTC4215 is not set
># CONFIG_SENSORS_LTC4222 is not set
># CONFIG_SENSORS_LTC4245 is not set
>CONFIG_SENSORS_LTC4260=y
>CONFIG_SENSORS_LTC4261=y
>CONFIG_SENSORS_MAX1111=y
>CONFIG_SENSORS_MAX16065=y
>CONFIG_SENSORS_MAX1619=y
>CONFIG_SENSORS_MAX1668=y
># CONFIG_SENSORS_MAX197 is not set
>CONFIG_SENSORS_MAX31722=y
>CONFIG_SENSORS_MAX6621=y
># CONFIG_SENSORS_MAX6639 is not set
># CONFIG_SENSORS_MAX6642 is not set
>CONFIG_SENSORS_MAX6650=y
># CONFIG_SENSORS_MAX6697 is not set
>CONFIG_SENSORS_MAX31790=y
>CONFIG_SENSORS_MCP3021=y
>CONFIG_SENSORS_TC654=y
>CONFIG_SENSORS_ADCXX=y
># CONFIG_SENSORS_LM63 is not set
>CONFIG_SENSORS_LM70=y
># CONFIG_SENSORS_LM73 is not set
># CONFIG_SENSORS_LM75 is not set
>CONFIG_SENSORS_LM77=y
>CONFIG_SENSORS_LM78=y
>CONFIG_SENSORS_LM80=y
># CONFIG_SENSORS_LM83 is not set
>CONFIG_SENSORS_LM85=y
># CONFIG_SENSORS_LM87 is not set
>CONFIG_SENSORS_LM90=y
># CONFIG_SENSORS_LM92 is not set
># CONFIG_SENSORS_LM93 is not set
># CONFIG_SENSORS_LM95234 is not set
>CONFIG_SENSORS_LM95241=y
>CONFIG_SENSORS_LM95245=y
># CONFIG_SENSORS_PC87360 is not set
>CONFIG_SENSORS_PC87427=y
>CONFIG_SENSORS_NTC_THERMISTOR=y
># CONFIG_SENSORS_NCT6683 is not set
>CONFIG_SENSORS_NCT6775=y
># CONFIG_SENSORS_NCT7802 is not set
># CONFIG_SENSORS_NCT7904 is not set
>CONFIG_SENSORS_PCF8591=y
>CONFIG_PMBUS=y
>CONFIG_SENSORS_PMBUS=y
>CONFIG_SENSORS_ADM1275=y
>CONFIG_SENSORS_IBM_CFFPS=y
># CONFIG_SENSORS_IR35221 is not set
># CONFIG_SENSORS_LM25066 is not set
>CONFIG_SENSORS_LTC2978=y
>CONFIG_SENSORS_LTC2978_REGULATOR=y
># CONFIG_SENSORS_LTC3815 is not set
># CONFIG_SENSORS_MAX16064 is not set
># CONFIG_SENSORS_MAX20751 is not set
>CONFIG_SENSORS_MAX31785=y
>CONFIG_SENSORS_MAX34440=y
>CONFIG_SENSORS_MAX8688=y
>CONFIG_SENSORS_TPS40422=y
>CONFIG_SENSORS_TPS53679=y
>CONFIG_SENSORS_UCD9000=y
># CONFIG_SENSORS_UCD9200 is not set
># CONFIG_SENSORS_ZL6100 is not set
>CONFIG_SENSORS_PWM_FAN=y
># CONFIG_SENSORS_SHT15 is not set
>CONFIG_SENSORS_SHT21=y
>CONFIG_SENSORS_SHT3x=y
># CONFIG_SENSORS_SHTC1 is not set
># CONFIG_SENSORS_SIS5595 is not set
>CONFIG_SENSORS_DME1737=y
># CONFIG_SENSORS_EMC1403 is not set
>CONFIG_SENSORS_EMC2103=y
>CONFIG_SENSORS_EMC6W201=y
>CONFIG_SENSORS_SMSC47M1=y
>CONFIG_SENSORS_SMSC47M192=y
>CONFIG_SENSORS_SMSC47B397=y
># CONFIG_SENSORS_SCH56XX_COMMON is not set
># CONFIG_SENSORS_STTS751 is not set
>CONFIG_SENSORS_SMM665=y
>CONFIG_SENSORS_ADC128D818=y
># CONFIG_SENSORS_ADS1015 is not set
># CONFIG_SENSORS_ADS7828 is not set
>CONFIG_SENSORS_ADS7871=y
># CONFIG_SENSORS_AMC6821 is not set
>CONFIG_SENSORS_INA209=y
># CONFIG_SENSORS_INA2XX is not set
># CONFIG_SENSORS_INA3221 is not set
>CONFIG_SENSORS_TC74=y
># CONFIG_SENSORS_THMC50 is not set
>CONFIG_SENSORS_TMP102=y
>CONFIG_SENSORS_TMP103=y
>CONFIG_SENSORS_TMP108=y
>CONFIG_SENSORS_TMP401=y
>CONFIG_SENSORS_TMP421=y
>CONFIG_SENSORS_VIA_CPUTEMP=y
># CONFIG_SENSORS_VIA686A is not set
>CONFIG_SENSORS_VT1211=y
># CONFIG_SENSORS_VT8231 is not set
># CONFIG_SENSORS_W83781D is not set
># CONFIG_SENSORS_W83791D is not set
># CONFIG_SENSORS_W83792D is not set
>CONFIG_SENSORS_W83793=y
>CONFIG_SENSORS_W83795=y
>CONFIG_SENSORS_W83795_FANCTRL=y
>CONFIG_SENSORS_W83L785TS=y
>CONFIG_SENSORS_W83L786NG=y
>CONFIG_SENSORS_W83627HF=y
>CONFIG_SENSORS_W83627EHF=y
>CONFIG_SENSORS_WM831X=y
>
>#
># ACPI drivers
>#
># CONFIG_SENSORS_ACPI_POWER is not set
># CONFIG_SENSORS_ATK0110 is not set
>CONFIG_THERMAL=y
>CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
>CONFIG_THERMAL_HWMON=y
>CONFIG_THERMAL_OF=y
>CONFIG_THERMAL_WRITABLE_TRIPS=y
>CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
># CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
># CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
># CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
># CONFIG_THERMAL_GOV_FAIR_SHARE is not set
>CONFIG_THERMAL_GOV_STEP_WISE=y
># CONFIG_THERMAL_GOV_BANG_BANG is not set
>CONFIG_THERMAL_GOV_USER_SPACE=y
># CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
># CONFIG_CLOCK_THERMAL is not set
># CONFIG_DEVFREQ_THERMAL is not set
># CONFIG_THERMAL_EMULATION is not set
># CONFIG_MAX77620_THERMAL is not set
># CONFIG_QORIQ_THERMAL is not set
># CONFIG_DA9062_THERMAL is not set
># CONFIG_INTEL_POWERCLAMP is not set
>CONFIG_X86_PKG_TEMP_THERMAL=y
># CONFIG_INTEL_SOC_DTS_THERMAL is not set
>
>#
># ACPI INT340X thermal drivers
>#
># CONFIG_INT340X_THERMAL is not set
># CONFIG_INTEL_PCH_THERMAL is not set
># CONFIG_WATCHDOG is not set
>CONFIG_SSB_POSSIBLE=y
>
>#
># Sonics Silicon Backplane
>#
># CONFIG_SSB is not set
>CONFIG_BCMA_POSSIBLE=y
># CONFIG_BCMA is not set
>
>#
># Multifunction device drivers
>#
>CONFIG_MFD_CORE=y
># CONFIG_MFD_CS5535 is not set
># CONFIG_MFD_ACT8945A is not set
># CONFIG_MFD_AS3711 is not set
>CONFIG_MFD_AS3722=y
>CONFIG_PMIC_ADP5520=y
>CONFIG_MFD_AAT2870_CORE=y
># CONFIG_MFD_ATMEL_FLEXCOM is not set
>CONFIG_MFD_ATMEL_HLCDC=y
># CONFIG_MFD_BCM590XX is not set
>CONFIG_MFD_BD9571MWV=y
>CONFIG_MFD_AXP20X=y
>CONFIG_MFD_AXP20X_I2C=y
># CONFIG_MFD_CROS_EC is not set
># CONFIG_PMIC_DA903X is not set
>CONFIG_PMIC_DA9052=y
># CONFIG_MFD_DA9052_SPI is not set
>CONFIG_MFD_DA9052_I2C=y
>CONFIG_MFD_DA9055=y
>CONFIG_MFD_DA9062=y
>CONFIG_MFD_DA9063=y
>CONFIG_MFD_DA9150=y
>CONFIG_MFD_DLN2=y
>CONFIG_MFD_MC13XXX=y
># CONFIG_MFD_MC13XXX_SPI is not set
>CONFIG_MFD_MC13XXX_I2C=y
>CONFIG_MFD_HI6421_PMIC=y
>CONFIG_HTC_PASIC3=y
>CONFIG_HTC_I2CPLD=y
># CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
># CONFIG_LPC_ICH is not set
># CONFIG_LPC_SCH is not set
># CONFIG_INTEL_SOC_PMIC is not set
># CONFIG_INTEL_SOC_PMIC_CHTWC is not set
># CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
># CONFIG_MFD_INTEL_LPSS_ACPI is not set
># CONFIG_MFD_INTEL_LPSS_PCI is not set
># CONFIG_MFD_JANZ_CMODIO is not set
>CONFIG_MFD_KEMPLD=y
>CONFIG_MFD_88PM800=y
>CONFIG_MFD_88PM805=y
>CONFIG_MFD_88PM860X=y
># CONFIG_MFD_MAX14577 is not set
>CONFIG_MFD_MAX77620=y
>CONFIG_MFD_MAX77686=y
># CONFIG_MFD_MAX77693 is not set
>CONFIG_MFD_MAX77843=y
>CONFIG_MFD_MAX8907=y
># CONFIG_MFD_MAX8925 is not set
>CONFIG_MFD_MAX8997=y
># CONFIG_MFD_MAX8998 is not set
># CONFIG_MFD_MT6397 is not set
># CONFIG_MFD_MENF21BMC is not set
>CONFIG_EZX_PCAP=y
># CONFIG_MFD_CPCAP is not set
># CONFIG_MFD_VIPERBOARD is not set
># CONFIG_MFD_RETU is not set
># CONFIG_MFD_PCF50633 is not set
># CONFIG_MFD_RDC321X is not set
># CONFIG_MFD_RTSX_PCI is not set
># CONFIG_MFD_RT5033 is not set
>CONFIG_MFD_RTSX_USB=y
>CONFIG_MFD_RC5T583=y
># CONFIG_MFD_RK808 is not set
>CONFIG_MFD_RN5T618=y
># CONFIG_MFD_SEC_CORE is not set
># CONFIG_MFD_SI476X_CORE is not set
>CONFIG_MFD_SM501=y
>CONFIG_MFD_SM501_GPIO=y
>CONFIG_MFD_SKY81452=y
># CONFIG_MFD_SMSC is not set
>CONFIG_ABX500_CORE=y
># CONFIG_AB3100_CORE is not set
># CONFIG_MFD_STMPE is not set
>CONFIG_MFD_SYSCON=y
>CONFIG_MFD_TI_AM335X_TSCADC=y
>CONFIG_MFD_LP3943=y
>CONFIG_MFD_LP8788=y
>CONFIG_MFD_TI_LMU=y
># CONFIG_MFD_PALMAS is not set
>CONFIG_TPS6105X=y
># CONFIG_TPS65010 is not set
>CONFIG_TPS6507X=y
>CONFIG_MFD_TPS65086=y
>CONFIG_MFD_TPS65090=y
># CONFIG_MFD_TPS65217 is not set
># CONFIG_MFD_TPS68470 is not set
>CONFIG_MFD_TI_LP873X=y
># CONFIG_MFD_TI_LP87565 is not set
># CONFIG_MFD_TPS65218 is not set
>CONFIG_MFD_TPS6586X=y
>CONFIG_MFD_TPS65910=y
>CONFIG_MFD_TPS65912=y
>CONFIG_MFD_TPS65912_I2C=y
>CONFIG_MFD_TPS65912_SPI=y
># CONFIG_MFD_TPS80031 is not set
># CONFIG_TWL4030_CORE is not set
># CONFIG_TWL6040_CORE is not set
>CONFIG_MFD_WL1273_CORE=y
># CONFIG_MFD_LM3533 is not set
># CONFIG_MFD_TIMBERDALE is not set
># CONFIG_MFD_TC3589X is not set
># CONFIG_MFD_TMIO is not set
># CONFIG_MFD_VX855 is not set
>CONFIG_MFD_ARIZONA=y
>CONFIG_MFD_ARIZONA_I2C=y
># CONFIG_MFD_ARIZONA_SPI is not set
>CONFIG_MFD_CS47L24=y
>CONFIG_MFD_WM5102=y
># CONFIG_MFD_WM5110 is not set
># CONFIG_MFD_WM8997 is not set
># CONFIG_MFD_WM8998 is not set
># CONFIG_MFD_WM8400 is not set
>CONFIG_MFD_WM831X=y
># CONFIG_MFD_WM831X_I2C is not set
>CONFIG_MFD_WM831X_SPI=y
># CONFIG_MFD_WM8350_I2C is not set
># CONFIG_MFD_WM8994 is not set
>CONFIG_REGULATOR=y
>CONFIG_REGULATOR_DEBUG=y
>CONFIG_REGULATOR_FIXED_VOLTAGE=y
>CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
>CONFIG_REGULATOR_USERSPACE_CONSUMER=y
># CONFIG_REGULATOR_88PM800 is not set
># CONFIG_REGULATOR_88PM8607 is not set
>CONFIG_REGULATOR_ACT8865=y
>CONFIG_REGULATOR_AD5398=y
>CONFIG_REGULATOR_ANATOP=y
>CONFIG_REGULATOR_AAT2870=y
># CONFIG_REGULATOR_AS3722 is not set
>CONFIG_REGULATOR_AXP20X=y
>CONFIG_REGULATOR_BD9571MWV=y
>CONFIG_REGULATOR_DA9052=y
># CONFIG_REGULATOR_DA9055 is not set
>CONFIG_REGULATOR_DA9062=y
># CONFIG_REGULATOR_DA9063 is not set
># CONFIG_REGULATOR_DA9210 is not set
>CONFIG_REGULATOR_DA9211=y
># CONFIG_REGULATOR_FAN53555 is not set
>CONFIG_REGULATOR_GPIO=y
># CONFIG_REGULATOR_HI6421 is not set
># CONFIG_REGULATOR_HI6421V530 is not set
># CONFIG_REGULATOR_ISL9305 is not set
>CONFIG_REGULATOR_ISL6271A=y
>CONFIG_REGULATOR_LM363X=y
># CONFIG_REGULATOR_LP3971 is not set
>CONFIG_REGULATOR_LP3972=y
>CONFIG_REGULATOR_LP872X=y
>CONFIG_REGULATOR_LP873X=y
># CONFIG_REGULATOR_LP8755 is not set
>CONFIG_REGULATOR_LP8788=y
>CONFIG_REGULATOR_LTC3589=y
>CONFIG_REGULATOR_LTC3676=y
>CONFIG_REGULATOR_MAX1586=y
># CONFIG_REGULATOR_MAX77620 is not set
>CONFIG_REGULATOR_MAX8649=y
>CONFIG_REGULATOR_MAX8660=y
># CONFIG_REGULATOR_MAX8907 is not set
>CONFIG_REGULATOR_MAX8952=y
># CONFIG_REGULATOR_MAX8973 is not set
>CONFIG_REGULATOR_MAX8997=y
># CONFIG_REGULATOR_MAX77686 is not set
># CONFIG_REGULATOR_MAX77693 is not set
># CONFIG_REGULATOR_MAX77802 is not set
>CONFIG_REGULATOR_MC13XXX_CORE=y
># CONFIG_REGULATOR_MC13783 is not set
>CONFIG_REGULATOR_MC13892=y
>CONFIG_REGULATOR_MT6311=y
>CONFIG_REGULATOR_PCAP=y
># CONFIG_REGULATOR_PFUZE100 is not set
># CONFIG_REGULATOR_PV88060 is not set
># CONFIG_REGULATOR_PV88080 is not set
>CONFIG_REGULATOR_PV88090=y
>CONFIG_REGULATOR_PWM=y
># CONFIG_REGULATOR_QCOM_SPMI is not set
>CONFIG_REGULATOR_RC5T583=y
>CONFIG_REGULATOR_RN5T618=y
>CONFIG_REGULATOR_SKY81452=y
>CONFIG_REGULATOR_TPS51632=y
># CONFIG_REGULATOR_TPS6105X is not set
>CONFIG_REGULATOR_TPS62360=y
>CONFIG_REGULATOR_TPS65023=y
>CONFIG_REGULATOR_TPS6507X=y
># CONFIG_REGULATOR_TPS65086 is not set
>CONFIG_REGULATOR_TPS65090=y
>CONFIG_REGULATOR_TPS65132=y
>CONFIG_REGULATOR_TPS6524X=y
>CONFIG_REGULATOR_TPS6586X=y
>CONFIG_REGULATOR_TPS65910=y
>CONFIG_REGULATOR_TPS65912=y
>CONFIG_REGULATOR_VCTRL=y
>CONFIG_REGULATOR_WM831X=y
>CONFIG_CEC_CORE=y
># CONFIG_RC_CORE is not set
>CONFIG_MEDIA_SUPPORT=y
>
>#
># Multimedia core support
>#
># CONFIG_MEDIA_CAMERA_SUPPORT is not set
>CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
>CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
>CONFIG_MEDIA_RADIO_SUPPORT=y
># CONFIG_MEDIA_SDR_SUPPORT is not set
>CONFIG_MEDIA_CEC_SUPPORT=y
>CONFIG_MEDIA_CONTROLLER=y
>CONFIG_MEDIA_CONTROLLER_DVB=y
>CONFIG_VIDEO_DEV=y
># CONFIG_VIDEO_V4L2_SUBDEV_API is not set
>CONFIG_VIDEO_V4L2=y
># CONFIG_VIDEO_ADV_DEBUG is not set
>CONFIG_VIDEO_FIXED_MINOR_RANGES=y
>CONFIG_VIDEO_TUNER=y
>CONFIG_V4L2_FWNODE=y
>CONFIG_VIDEOBUF2_CORE=y
>CONFIG_VIDEOBUF2_MEMOPS=y
>CONFIG_VIDEOBUF2_VMALLOC=y
>CONFIG_DVB_CORE=y
>CONFIG_DVB_NET=y
># CONFIG_TTPCI_EEPROM is not set
>CONFIG_DVB_MAX_ADAPTERS=16
># CONFIG_DVB_DYNAMIC_MINORS is not set
># CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
>
>#
># Media drivers
>#
>CONFIG_MEDIA_USB_SUPPORT=y
>
>#
># Analog TV USB devices
>#
>CONFIG_VIDEO_PVRUSB2=y
>CONFIG_VIDEO_PVRUSB2_SYSFS=y
># CONFIG_VIDEO_PVRUSB2_DVB is not set
>CONFIG_VIDEO_PVRUSB2_DEBUGIFC=y
>CONFIG_VIDEO_HDPVR=y
># CONFIG_VIDEO_USBVISION is not set
>CONFIG_VIDEO_STK1160_COMMON=y
>CONFIG_VIDEO_STK1160=y
>
>#
># Analog/digital TV USB devices
>#
>CONFIG_VIDEO_AU0828=y
># CONFIG_VIDEO_AU0828_V4L2 is not set
>
>#
># Digital TV USB devices
>#
>CONFIG_DVB_USB_V2=y
>CONFIG_DVB_USB_AF9015=y
>CONFIG_DVB_USB_AF9035=y
># CONFIG_DVB_USB_ANYSEE is not set
>CONFIG_DVB_USB_AU6610=y
>CONFIG_DVB_USB_AZ6007=y
># CONFIG_DVB_USB_CE6230 is not set
># CONFIG_DVB_USB_EC168 is not set
># CONFIG_DVB_USB_GL861 is not set
>CONFIG_DVB_USB_MXL111SF=y
>CONFIG_DVB_USB_RTL28XXU=y
>CONFIG_DVB_USB_DVBSKY=y
>CONFIG_DVB_USB_ZD1301=y
># CONFIG_DVB_TTUSB_BUDGET is not set
># CONFIG_DVB_TTUSB_DEC is not set
># CONFIG_SMS_USB_DRV is not set
>CONFIG_DVB_B2C2_FLEXCOP_USB=y
>CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=y
># CONFIG_DVB_AS102 is not set
>
>#
># Webcam, TV (analog/digital) USB devices
>#
>CONFIG_VIDEO_EM28XX=y
># CONFIG_VIDEO_EM28XX_V4L2 is not set
># CONFIG_VIDEO_EM28XX_DVB is not set
>
>#
># USB HDMI CEC adapters
>#
># CONFIG_USB_PULSE8_CEC is not set
>CONFIG_USB_RAINSHADOW_CEC=y
># CONFIG_MEDIA_PCI_SUPPORT is not set
>CONFIG_DVB_PLATFORM_DRIVERS=y
>CONFIG_CEC_PLATFORM_DRIVERS=y
>
>#
># Supported MMC/SDIO adapters
>#
>CONFIG_SMS_SDIO_DRV=y
># CONFIG_RADIO_ADAPTERS is not set
>
>#
># Supported FireWire (IEEE 1394) Adapters
>#
>CONFIG_DVB_FIREDTV=y
>CONFIG_DVB_FIREDTV_INPUT=y
>CONFIG_MEDIA_COMMON_OPTIONS=y
>
>#
># common driver options
>#
>CONFIG_VIDEO_CX2341X=y
>CONFIG_VIDEO_TVEEPROM=y
>CONFIG_CYPRESS_FIRMWARE=y
>CONFIG_DVB_B2C2_FLEXCOP=y
>CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
>CONFIG_SMS_SIANO_MDTV=y
>
>#
># Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
>#
># CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
>
>#
># I2C Encoders, decoders, sensors and other helper chips
>#
>
>#
># Audio decoders, processors and mixers
>#
># CONFIG_VIDEO_TVAUDIO is not set
># CONFIG_VIDEO_TDA7432 is not set
># CONFIG_VIDEO_TDA9840 is not set
>CONFIG_VIDEO_TEA6415C=y
>CONFIG_VIDEO_TEA6420=y
>CONFIG_VIDEO_MSP3400=y
># CONFIG_VIDEO_CS3308 is not set
>CONFIG_VIDEO_CS5345=y
>CONFIG_VIDEO_CS53L32A=y
>CONFIG_VIDEO_TLV320AIC23B=y
># CONFIG_VIDEO_UDA1342 is not set
>CONFIG_VIDEO_WM8775=y
>CONFIG_VIDEO_WM8739=y
># CONFIG_VIDEO_VP27SMPX is not set
>CONFIG_VIDEO_SONY_BTF_MPX=y
>
>#
># RDS decoders
>#
>CONFIG_VIDEO_SAA6588=y
>
>#
># Video decoders
>#
># CONFIG_VIDEO_ADV7183 is not set
>CONFIG_VIDEO_BT819=y
># CONFIG_VIDEO_BT856 is not set
>CONFIG_VIDEO_BT866=y
>CONFIG_VIDEO_KS0127=y
># CONFIG_VIDEO_ML86V7667 is not set
>CONFIG_VIDEO_AD5820=y
>CONFIG_VIDEO_SAA7110=y
>CONFIG_VIDEO_SAA711X=y
>CONFIG_VIDEO_TVP514X=y
># CONFIG_VIDEO_TVP5150 is not set
>CONFIG_VIDEO_TVP7002=y
>CONFIG_VIDEO_TW2804=y
>CONFIG_VIDEO_TW9903=y
>CONFIG_VIDEO_TW9906=y
>CONFIG_VIDEO_VPX3220=y
>
>#
># Video and audio decoders
>#
>CONFIG_VIDEO_SAA717X=y
>CONFIG_VIDEO_CX25840=y
>
>#
># Video encoders
>#
># CONFIG_VIDEO_SAA7127 is not set
>CONFIG_VIDEO_SAA7185=y
>CONFIG_VIDEO_ADV7170=y
>CONFIG_VIDEO_ADV7175=y
>CONFIG_VIDEO_ADV7343=y
>CONFIG_VIDEO_ADV7393=y
># CONFIG_VIDEO_AK881X is not set
>CONFIG_VIDEO_THS8200=y
>
>#
># Camera sensor devices
>#
># CONFIG_VIDEO_MT9M111 is not set
>
>#
># Flash devices
>#
>
>#
># Video improvement chips
>#
>CONFIG_VIDEO_UPD64031A=y
>CONFIG_VIDEO_UPD64083=y
>
>#
># Audio/Video compression chips
>#
># CONFIG_VIDEO_SAA6752HS is not set
>
>#
># SDR tuner chips
>#
>
>#
># Miscellaneous helper chips
>#
># CONFIG_VIDEO_THS7303 is not set
>CONFIG_VIDEO_M52790=y
>
>#
># Sensors used on soc_camera driver
>#
>
>#
># SPI helper chips
>#
>CONFIG_MEDIA_TUNER=y
>
>#
># Customize TV tuners
>#
>CONFIG_MEDIA_TUNER_SIMPLE=y
># CONFIG_MEDIA_TUNER_TDA8290 is not set
>CONFIG_MEDIA_TUNER_TDA827X=y
># CONFIG_MEDIA_TUNER_TDA18271 is not set
>CONFIG_MEDIA_TUNER_TDA9887=y
># CONFIG_MEDIA_TUNER_TEA5761 is not set
>CONFIG_MEDIA_TUNER_TEA5767=y
>CONFIG_MEDIA_TUNER_MSI001=y
>CONFIG_MEDIA_TUNER_MT20XX=y
># CONFIG_MEDIA_TUNER_MT2060 is not set
>CONFIG_MEDIA_TUNER_MT2063=y
>CONFIG_MEDIA_TUNER_MT2266=y
># CONFIG_MEDIA_TUNER_MT2131 is not set
>CONFIG_MEDIA_TUNER_QT1010=y
># CONFIG_MEDIA_TUNER_XC2028 is not set
>CONFIG_MEDIA_TUNER_XC5000=y
># CONFIG_MEDIA_TUNER_XC4000 is not set
># CONFIG_MEDIA_TUNER_MXL5005S is not set
>CONFIG_MEDIA_TUNER_MXL5007T=y
>CONFIG_MEDIA_TUNER_MC44S803=y
>CONFIG_MEDIA_TUNER_MAX2165=y
>CONFIG_MEDIA_TUNER_TDA18218=y
># CONFIG_MEDIA_TUNER_FC0011 is not set
># CONFIG_MEDIA_TUNER_FC0012 is not set
># CONFIG_MEDIA_TUNER_FC0013 is not set
># CONFIG_MEDIA_TUNER_TDA18212 is not set
># CONFIG_MEDIA_TUNER_E4000 is not set
>CONFIG_MEDIA_TUNER_FC2580=y
>CONFIG_MEDIA_TUNER_M88RS6000T=y
>CONFIG_MEDIA_TUNER_TUA9001=y
># CONFIG_MEDIA_TUNER_SI2157 is not set
>CONFIG_MEDIA_TUNER_IT913X=y
>CONFIG_MEDIA_TUNER_R820T=y
>CONFIG_MEDIA_TUNER_MXL301RF=y
>CONFIG_MEDIA_TUNER_QM1D1C0042=y
>
>#
># Customise DVB Frontends
>#
>
>#
># Multistandard (satellite) frontends
>#
>CONFIG_DVB_STB0899=y
>CONFIG_DVB_STB6100=y
># CONFIG_DVB_STV090x is not set
>CONFIG_DVB_STV0910=y
>CONFIG_DVB_STV6110x=y
>CONFIG_DVB_STV6111=y
>CONFIG_DVB_MXL5XX=y
>CONFIG_DVB_M88DS3103=y
>
>#
># Multistandard (cable + terrestrial) frontends
>#
>CONFIG_DVB_DRXK=y
>CONFIG_DVB_TDA18271C2DD=y
>CONFIG_DVB_SI2165=y
>CONFIG_DVB_MN88472=y
>CONFIG_DVB_MN88473=y
>
>#
># DVB-S (satellite) frontends
>#
>CONFIG_DVB_CX24110=y
>CONFIG_DVB_CX24123=y
>CONFIG_DVB_MT312=y
># CONFIG_DVB_ZL10036 is not set
># CONFIG_DVB_ZL10039 is not set
>CONFIG_DVB_S5H1420=y
>CONFIG_DVB_STV0288=y
># CONFIG_DVB_STB6000 is not set
>CONFIG_DVB_STV0299=y
># CONFIG_DVB_STV6110 is not set
># CONFIG_DVB_STV0900 is not set
>CONFIG_DVB_TDA8083=y
>CONFIG_DVB_TDA10086=y
># CONFIG_DVB_TDA8261 is not set
>CONFIG_DVB_VES1X93=y
>CONFIG_DVB_TUNER_ITD1000=y
>CONFIG_DVB_TUNER_CX24113=y
>CONFIG_DVB_TDA826X=y
>CONFIG_DVB_TUA6100=y
># CONFIG_DVB_CX24116 is not set
># CONFIG_DVB_CX24117 is not set
># CONFIG_DVB_CX24120 is not set
>CONFIG_DVB_SI21XX=y
>CONFIG_DVB_TS2020=y
>CONFIG_DVB_DS3000=y
>CONFIG_DVB_MB86A16=y
># CONFIG_DVB_TDA10071 is not set
>
>#
># DVB-T (terrestrial) frontends
>#
># CONFIG_DVB_SP8870 is not set
>CONFIG_DVB_SP887X=y
>CONFIG_DVB_CX22700=y
>CONFIG_DVB_CX22702=y
>CONFIG_DVB_S5H1432=y
>CONFIG_DVB_DRXD=y
>CONFIG_DVB_L64781=y
># CONFIG_DVB_TDA1004X is not set
>CONFIG_DVB_NXT6000=y
># CONFIG_DVB_MT352 is not set
># CONFIG_DVB_ZL10353 is not set
># CONFIG_DVB_DIB3000MB is not set
>CONFIG_DVB_DIB3000MC=y
>CONFIG_DVB_DIB7000M=y
># CONFIG_DVB_DIB7000P is not set
># CONFIG_DVB_DIB9000 is not set
>CONFIG_DVB_TDA10048=y
>CONFIG_DVB_AF9013=y
>CONFIG_DVB_EC100=y
># CONFIG_DVB_STV0367 is not set
>CONFIG_DVB_CXD2820R=y
>CONFIG_DVB_CXD2841ER=y
>CONFIG_DVB_RTL2830=y
>CONFIG_DVB_RTL2832=y
># CONFIG_DVB_SI2168 is not set
># CONFIG_DVB_AS102_FE is not set
># CONFIG_DVB_ZD1301_DEMOD is not set
># CONFIG_DVB_GP8PSK_FE is not set
>
>#
># DVB-C (cable) frontends
>#
>CONFIG_DVB_VES1820=y
>CONFIG_DVB_TDA10021=y
>CONFIG_DVB_TDA10023=y
>CONFIG_DVB_STV0297=y
>
>#
># ATSC (North American/Korean Terrestrial/Cable DTV) frontends
>#
>CONFIG_DVB_NXT200X=y
>CONFIG_DVB_OR51211=y
>CONFIG_DVB_OR51132=y
>CONFIG_DVB_BCM3510=y
>CONFIG_DVB_LGDT330X=y
>CONFIG_DVB_LGDT3305=y
># CONFIG_DVB_LGDT3306A is not set
>CONFIG_DVB_LG2160=y
>CONFIG_DVB_S5H1409=y
>CONFIG_DVB_AU8522=y
>CONFIG_DVB_AU8522_DTV=y
># CONFIG_DVB_AU8522_V4L is not set
># CONFIG_DVB_S5H1411 is not set
>
>#
># ISDB-T (terrestrial) frontends
>#
>CONFIG_DVB_S921=y
>CONFIG_DVB_DIB8000=y
># CONFIG_DVB_MB86A20S is not set
>
>#
># ISDB-S (satellite) & ISDB-T (terrestrial) frontends
>#
>CONFIG_DVB_TC90522=y
>
>#
># Digital terrestrial only tuners/PLL
>#
># CONFIG_DVB_PLL is not set
>CONFIG_DVB_TUNER_DIB0070=y
># CONFIG_DVB_TUNER_DIB0090 is not set
>
>#
># SEC control devices for DVB-S
>#
># CONFIG_DVB_DRX39XYJ is not set
>CONFIG_DVB_LNBH25=y
>CONFIG_DVB_LNBP21=y
>CONFIG_DVB_LNBP22=y
>CONFIG_DVB_ISL6405=y
>CONFIG_DVB_ISL6421=y
>CONFIG_DVB_ISL6423=y
>CONFIG_DVB_A8293=y
># CONFIG_DVB_SP2 is not set
>CONFIG_DVB_LGS8GL5=y
># CONFIG_DVB_LGS8GXX is not set
># CONFIG_DVB_ATBM8830 is not set
>CONFIG_DVB_TDA665x=y
>CONFIG_DVB_IX2505V=y
>CONFIG_DVB_M88RS2000=y
>CONFIG_DVB_AF9033=y
># CONFIG_DVB_HORUS3A is not set
>CONFIG_DVB_ASCOT2E=y
># CONFIG_DVB_HELENE is not set
>
>#
># Tools to develop new frontends
>#
>CONFIG_DVB_DUMMY_FE=y
>
>#
># Graphics support
>#
># CONFIG_AGP is not set
>CONFIG_VGA_ARB=y
>CONFIG_VGA_ARB_MAX_GPUS=16
># CONFIG_VGA_SWITCHEROO is not set
>CONFIG_DRM=y
>CONFIG_DRM_MIPI_DSI=y
># CONFIG_DRM_DP_AUX_CHARDEV is not set
># CONFIG_DRM_DEBUG_MM is not set
>CONFIG_DRM_DEBUG_MM_SELFTEST=y
>CONFIG_DRM_KMS_HELPER=y
>CONFIG_DRM_KMS_FB_HELPER=y
>CONFIG_DRM_FBDEV_EMULATION=y
>CONFIG_DRM_FBDEV_OVERALLOC=100
># CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
>CONFIG_DRM_GEM_CMA_HELPER=y
>CONFIG_DRM_KMS_CMA_HELPER=y
>CONFIG_DRM_VM=y
>
>#
># I2C encoder or helper chips
>#
>CONFIG_DRM_I2C_CH7006=y
>CONFIG_DRM_I2C_SIL164=y
># CONFIG_DRM_I2C_NXP_TDA998X is not set
># CONFIG_DRM_RADEON is not set
># CONFIG_DRM_AMDGPU is not set
>
>#
># ACP (Audio CoProcessor) Configuration
>#
>
>#
># AMD Library routines
>#
># CONFIG_CHASH is not set
># CONFIG_DRM_NOUVEAU is not set
># CONFIG_DRM_I915 is not set
>CONFIG_DRM_VGEM=y
># CONFIG_DRM_VMWGFX is not set
># CONFIG_DRM_GMA500 is not set
>CONFIG_DRM_UDL=y
># CONFIG_DRM_AST is not set
># CONFIG_DRM_MGAG200 is not set
># CONFIG_DRM_CIRRUS_QEMU is not set
># CONFIG_DRM_RCAR_DW_HDMI is not set
># CONFIG_DRM_QXL is not set
># CONFIG_DRM_BOCHS is not set
># CONFIG_DRM_VIRTIO_GPU is not set
>CONFIG_DRM_PANEL=y
>
>#
># Display Panels
>#
>CONFIG_DRM_PANEL_LVDS=y
>CONFIG_DRM_PANEL_SIMPLE=y
>CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
>CONFIG_DRM_PANEL_JDI_LT070ME05000=y
># CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
>CONFIG_DRM_PANEL_LG_LG4573=y
>CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
>CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
>CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
>CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
>CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
>CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
>CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
>CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
># CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
>CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
>CONFIG_DRM_BRIDGE=y
>CONFIG_DRM_PANEL_BRIDGE=y
>
>#
># Display Interface Bridges
>#
>CONFIG_DRM_ANALOGIX_ANX78XX=y
># CONFIG_DRM_DUMB_VGA_DAC is not set
>CONFIG_DRM_LVDS_ENCODER=y
># CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
>CONFIG_DRM_NXP_PTN3460=y
># CONFIG_DRM_PARADE_PS8622 is not set
>CONFIG_DRM_SII902X=y
># CONFIG_DRM_SII9234 is not set
># CONFIG_DRM_TOSHIBA_TC358767 is not set
>CONFIG_DRM_TI_TFP410=y
># CONFIG_DRM_I2C_ADV7511 is not set
>CONFIG_DRM_ARCPGU=y
># CONFIG_DRM_HISI_HIBMC is not set
># CONFIG_DRM_MXSFB is not set
>CONFIG_DRM_TINYDRM=y
>CONFIG_TINYDRM_MIPI_DBI=y
>CONFIG_TINYDRM_MI0283QT=y
># CONFIG_TINYDRM_REPAPER is not set
># CONFIG_TINYDRM_ST7586 is not set
>CONFIG_DRM_LEGACY=y
># CONFIG_DRM_TDFX is not set
># CONFIG_DRM_R128 is not set
># CONFIG_DRM_MGA is not set
># CONFIG_DRM_VIA is not set
># CONFIG_DRM_SAVAGE is not set
>CONFIG_DRM_LIB_RANDOM=y
>
>#
># Frame buffer Devices
>#
>CONFIG_FB=y
># CONFIG_FIRMWARE_EDID is not set
>CONFIG_FB_CMDLINE=y
>CONFIG_FB_NOTIFY=y
># CONFIG_FB_DDC is not set
># CONFIG_FB_BOOT_VESA_SUPPORT is not set
>CONFIG_FB_CFB_FILLRECT=y
>CONFIG_FB_CFB_COPYAREA=y
>CONFIG_FB_CFB_IMAGEBLIT=y
># CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
>CONFIG_FB_SYS_FILLRECT=y
>CONFIG_FB_SYS_COPYAREA=y
>CONFIG_FB_SYS_IMAGEBLIT=y
># CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
># CONFIG_FB_FOREIGN_ENDIAN is not set
>CONFIG_FB_SYS_FOPS=y
>CONFIG_FB_DEFERRED_IO=y
>CONFIG_FB_HECUBA=y
># CONFIG_FB_SVGALIB is not set
># CONFIG_FB_MACMODES is not set
>CONFIG_FB_BACKLIGHT=y
>CONFIG_FB_MODE_HELPERS=y
># CONFIG_FB_TILEBLITTING is not set
>
>#
># Frame buffer hardware drivers
>#
># CONFIG_FB_CIRRUS is not set
># CONFIG_FB_PM2 is not set
># CONFIG_FB_CYBER2000 is not set
>CONFIG_FB_ARC=y
># CONFIG_FB_ASILIANT is not set
># CONFIG_FB_IMSTT is not set
># CONFIG_FB_VGA16 is not set
># CONFIG_FB_UVESA is not set
># CONFIG_FB_VESA is not set
>CONFIG_FB_N411=y
>CONFIG_FB_HGA=y
># CONFIG_FB_OPENCORES is not set
>CONFIG_FB_S1D13XXX=y
># CONFIG_FB_NVIDIA is not set
># CONFIG_FB_RIVA is not set
># CONFIG_FB_I740 is not set
># CONFIG_FB_LE80578 is not set
># CONFIG_FB_MATROX is not set
># CONFIG_FB_RADEON is not set
># CONFIG_FB_ATY128 is not set
># CONFIG_FB_ATY is not set
># CONFIG_FB_S3 is not set
># CONFIG_FB_SAVAGE is not set
># CONFIG_FB_SIS is not set
># CONFIG_FB_VIA is not set
># CONFIG_FB_NEOMAGIC is not set
># CONFIG_FB_KYRO is not set
># CONFIG_FB_3DFX is not set
># CONFIG_FB_VOODOO1 is not set
># CONFIG_FB_VT8623 is not set
># CONFIG_FB_TRIDENT is not set
># CONFIG_FB_ARK is not set
># CONFIG_FB_PM3 is not set
># CONFIG_FB_CARMINE is not set
># CONFIG_FB_GEODE is not set
>CONFIG_FB_SM501=y
># CONFIG_FB_SMSCUFX is not set
># CONFIG_FB_UDL is not set
>CONFIG_FB_IBM_GXT4500=y
>CONFIG_FB_VIRTUAL=y
># CONFIG_FB_METRONOME is not set
># CONFIG_FB_MB862XX is not set
>CONFIG_FB_BROADSHEET=y
># CONFIG_FB_AUO_K190X is not set
>CONFIG_FB_SIMPLE=y
>CONFIG_FB_SSD1307=y
># CONFIG_FB_SM712 is not set
>CONFIG_BACKLIGHT_LCD_SUPPORT=y
>CONFIG_LCD_CLASS_DEVICE=y
>CONFIG_LCD_L4F00242T03=y
>CONFIG_LCD_LMS283GF05=y
># CONFIG_LCD_LTV350QV is not set
>CONFIG_LCD_ILI922X=y
>CONFIG_LCD_ILI9320=y
>CONFIG_LCD_TDO24M=y
># CONFIG_LCD_VGG2432A4 is not set
># CONFIG_LCD_PLATFORM is not set
>CONFIG_LCD_S6E63M0=y
>CONFIG_LCD_LD9040=y
>CONFIG_LCD_AMS369FG06=y
>CONFIG_LCD_LMS501KF03=y
># CONFIG_LCD_HX8357 is not set
>CONFIG_BACKLIGHT_CLASS_DEVICE=y
>CONFIG_BACKLIGHT_GENERIC=y
>CONFIG_BACKLIGHT_PWM=y
>CONFIG_BACKLIGHT_DA9052=y
># CONFIG_BACKLIGHT_APPLE is not set
># CONFIG_BACKLIGHT_PM8941_WLED is not set
>CONFIG_BACKLIGHT_SAHARA=y
># CONFIG_BACKLIGHT_WM831X is not set
># CONFIG_BACKLIGHT_ADP5520 is not set
># CONFIG_BACKLIGHT_ADP8860 is not set
># CONFIG_BACKLIGHT_ADP8870 is not set
>CONFIG_BACKLIGHT_88PM860X=y
>CONFIG_BACKLIGHT_AAT2870=y
>CONFIG_BACKLIGHT_LM3630A=y
>CONFIG_BACKLIGHT_LM3639=y
># CONFIG_BACKLIGHT_LP855X is not set
>CONFIG_BACKLIGHT_LP8788=y
>CONFIG_BACKLIGHT_SKY81452=y
>CONFIG_BACKLIGHT_GPIO=y
>CONFIG_BACKLIGHT_LV5207LP=y
># CONFIG_BACKLIGHT_BD6107 is not set
>CONFIG_BACKLIGHT_ARCXCNN=y
># CONFIG_VGASTATE is not set
>CONFIG_VIDEOMODE_HELPERS=y
>CONFIG_HDMI=y
>
>#
># Console display driver support
>#
>CONFIG_VGA_CONSOLE=y
># CONFIG_VGACON_SOFT_SCROLLBACK is not set
>CONFIG_DUMMY_CONSOLE=y
>CONFIG_DUMMY_CONSOLE_COLUMNS=80
>CONFIG_DUMMY_CONSOLE_ROWS=25
>CONFIG_FRAMEBUFFER_CONSOLE=y
>CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
># CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
>CONFIG_LOGO=y
># CONFIG_LOGO_LINUX_MONO is not set
># CONFIG_LOGO_LINUX_VGA16 is not set
># CONFIG_LOGO_LINUX_CLUT224 is not set
># CONFIG_SOUND is not set
>
>#
># HID support
>#
>CONFIG_HID=y
>CONFIG_HID_BATTERY_STRENGTH=y
>CONFIG_HIDRAW=y
>CONFIG_UHID=y
>CONFIG_HID_GENERIC=y
>
>#
># Special HID drivers
>#
>CONFIG_HID_A4TECH=y
># CONFIG_HID_ACCUTOUCH is not set
>CONFIG_HID_ACRUX=y
>CONFIG_HID_ACRUX_FF=y
># CONFIG_HID_APPLE is not set
># CONFIG_HID_APPLEIR is not set
>CONFIG_HID_ASUS=y
>CONFIG_HID_AUREAL=y
># CONFIG_HID_BELKIN is not set
>CONFIG_HID_BETOP_FF=y
>CONFIG_HID_CHERRY=y
># CONFIG_HID_CHICONY is not set
># CONFIG_HID_CORSAIR is not set
># CONFIG_HID_CMEDIA is not set
># CONFIG_HID_CP2112 is not set
>CONFIG_HID_CYPRESS=y
># CONFIG_HID_DRAGONRISE is not set
># CONFIG_HID_EMS_FF is not set
>CONFIG_HID_ELECOM=y
>CONFIG_HID_ELO=y
>CONFIG_HID_EZKEY=y
>CONFIG_HID_GEMBIRD=y
># CONFIG_HID_GFRM is not set
># CONFIG_HID_HOLTEK is not set
># CONFIG_HID_GT683R is not set
># CONFIG_HID_KEYTOUCH is not set
>CONFIG_HID_KYE=y
>CONFIG_HID_UCLOGIC=y
>CONFIG_HID_WALTOP=y
># CONFIG_HID_GYRATION is not set
># CONFIG_HID_ICADE is not set
># CONFIG_HID_ITE is not set
># CONFIG_HID_TWINHAN is not set
># CONFIG_HID_KENSINGTON is not set
>CONFIG_HID_LCPOWER=y
>CONFIG_HID_LED=y
>CONFIG_HID_LENOVO=y
># CONFIG_HID_LOGITECH is not set
>CONFIG_HID_MAGICMOUSE=y
># CONFIG_HID_MAYFLASH is not set
>CONFIG_HID_MICROSOFT=y
># CONFIG_HID_MONTEREY is not set
>CONFIG_HID_MULTITOUCH=y
>CONFIG_HID_NTI=y
>CONFIG_HID_NTRIG=y
>CONFIG_HID_ORTEK=y
>CONFIG_HID_PANTHERLORD=y
>CONFIG_PANTHERLORD_FF=y
>CONFIG_HID_PENMOUNT=y
>CONFIG_HID_PETALYNX=y
>CONFIG_HID_PICOLCD=y
>CONFIG_HID_PICOLCD_FB=y
>CONFIG_HID_PICOLCD_BACKLIGHT=y
>CONFIG_HID_PICOLCD_LCD=y
>CONFIG_HID_PICOLCD_LEDS=y
># CONFIG_HID_PLANTRONICS is not set
>CONFIG_HID_PRIMAX=y
># CONFIG_HID_RETRODE is not set
>CONFIG_HID_ROCCAT=y
>CONFIG_HID_SAITEK=y
># CONFIG_HID_SAMSUNG is not set
>CONFIG_HID_SONY=y
># CONFIG_SONY_FF is not set
># CONFIG_HID_SPEEDLINK is not set
># CONFIG_HID_STEELSERIES is not set
>CONFIG_HID_SUNPLUS=y
>CONFIG_HID_RMI=y
>CONFIG_HID_GREENASIA=y
># CONFIG_GREENASIA_FF is not set
>CONFIG_HID_SMARTJOYPLUS=y
>CONFIG_SMARTJOYPLUS_FF=y
>CONFIG_HID_TIVO=y
>CONFIG_HID_TOPSEED=y
># CONFIG_HID_THINGM is not set
>CONFIG_HID_THRUSTMASTER=y
>CONFIG_THRUSTMASTER_FF=y
>CONFIG_HID_UDRAW_PS3=y
># CONFIG_HID_WACOM is not set
>CONFIG_HID_WIIMOTE=y
># CONFIG_HID_XINMO is not set
># CONFIG_HID_ZEROPLUS is not set
>CONFIG_HID_ZYDACRON=y
>CONFIG_HID_SENSOR_HUB=y
>CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
>CONFIG_HID_ALPS=y
>
>#
># USB HID support
>#
>CONFIG_USB_HID=y
>CONFIG_HID_PID=y
># CONFIG_USB_HIDDEV is not set
>
>#
># I2C HID support
>#
>CONFIG_I2C_HID=y
>CONFIG_USB_OHCI_LITTLE_ENDIAN=y
>CONFIG_USB_SUPPORT=y
>CONFIG_USB_COMMON=y
>CONFIG_USB_ARCH_HAS_HCD=y
>CONFIG_USB=y
>CONFIG_USB_PCI=y
># CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
>
>#
># Miscellaneous USB options
>#
>CONFIG_USB_DEFAULT_PERSIST=y
># CONFIG_USB_DYNAMIC_MINORS is not set
>CONFIG_USB_OTG=y
># CONFIG_USB_OTG_WHITELIST is not set
># CONFIG_USB_OTG_BLACKLIST_HUB is not set
>CONFIG_USB_OTG_FSM=y
>CONFIG_USB_LEDS_TRIGGER_USBPORT=y
>CONFIG_USB_MON=y
>CONFIG_USB_WUSB_CBAF=y
>CONFIG_USB_WUSB_CBAF_DEBUG=y
>
>#
># USB Host Controller Drivers
>#
>CONFIG_USB_C67X00_HCD=y
>CONFIG_USB_XHCI_HCD=y
>CONFIG_USB_XHCI_PCI=y
>CONFIG_USB_XHCI_PLATFORM=y
>CONFIG_USB_EHCI_HCD=y
>CONFIG_USB_EHCI_ROOT_HUB_TT=y
>CONFIG_USB_EHCI_TT_NEWSCHED=y
>CONFIG_USB_EHCI_PCI=y
># CONFIG_USB_EHCI_HCD_PLATFORM is not set
># CONFIG_USB_OXU210HP_HCD is not set
>CONFIG_USB_ISP116X_HCD=y
># CONFIG_USB_ISP1362_HCD is not set
># CONFIG_USB_FOTG210_HCD is not set
>CONFIG_USB_MAX3421_HCD=y
>CONFIG_USB_OHCI_HCD=y
>CONFIG_USB_OHCI_HCD_PCI=y
>CONFIG_USB_OHCI_HCD_PLATFORM=y
># CONFIG_USB_UHCI_HCD is not set
>CONFIG_USB_U132_HCD=y
>CONFIG_USB_SL811_HCD=y
>CONFIG_USB_SL811_HCD_ISO=y
>CONFIG_USB_R8A66597_HCD=y
># CONFIG_USB_HCD_TEST_MODE is not set
>
>#
># USB Device Class drivers
>#
>CONFIG_USB_ACM=y
>CONFIG_USB_PRINTER=y
>CONFIG_USB_WDM=y
>CONFIG_USB_TMC=y
>
>#
># NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
>#
>
>#
># also be needed; see USB_STORAGE Help for more info
>#
>CONFIG_USB_STORAGE=y
># CONFIG_USB_STORAGE_DEBUG is not set
>CONFIG_USB_STORAGE_REALTEK=y
># CONFIG_REALTEK_AUTOPM is not set
># CONFIG_USB_STORAGE_DATAFAB is not set
>CONFIG_USB_STORAGE_FREECOM=y
>CONFIG_USB_STORAGE_ISD200=y
># CONFIG_USB_STORAGE_USBAT is not set
>CONFIG_USB_STORAGE_SDDR09=y
>CONFIG_USB_STORAGE_SDDR55=y
>CONFIG_USB_STORAGE_JUMPSHOT=y
>CONFIG_USB_STORAGE_ALAUDA=y
>CONFIG_USB_STORAGE_ONETOUCH=y
>CONFIG_USB_STORAGE_KARMA=y
>CONFIG_USB_STORAGE_CYPRESS_ATACB=y
>CONFIG_USB_STORAGE_ENE_UB6250=y
>CONFIG_USB_UAS=y
>
>#
># USB Imaging devices
>#
>CONFIG_USB_MDC800=y
>CONFIG_USB_MICROTEK=y
>CONFIG_USBIP_CORE=y
># CONFIG_USBIP_VHCI_HCD is not set
># CONFIG_USBIP_HOST is not set
>CONFIG_USBIP_VUDC=y
># CONFIG_USBIP_DEBUG is not set
>CONFIG_USB_MUSB_HDRC=y
># CONFIG_USB_MUSB_HOST is not set
># CONFIG_USB_MUSB_GADGET is not set
>CONFIG_USB_MUSB_DUAL_ROLE=y
>
>#
># Platform Glue Layer
>#
>
>#
># MUSB DMA mode
>#
>CONFIG_MUSB_PIO_ONLY=y
># CONFIG_USB_DWC3 is not set
># CONFIG_USB_DWC2 is not set
>CONFIG_USB_CHIPIDEA=y
>CONFIG_USB_CHIPIDEA_OF=y
>CONFIG_USB_CHIPIDEA_PCI=y
>CONFIG_USB_CHIPIDEA_UDC=y
>CONFIG_USB_CHIPIDEA_HOST=y
>CONFIG_USB_CHIPIDEA_ULPI=y
># CONFIG_USB_ISP1760 is not set
>
>#
># USB port drivers
>#
>CONFIG_USB_SERIAL=y
>CONFIG_USB_SERIAL_CONSOLE=y
># CONFIG_USB_SERIAL_GENERIC is not set
>CONFIG_USB_SERIAL_SIMPLE=y
># CONFIG_USB_SERIAL_AIRCABLE is not set
># CONFIG_USB_SERIAL_ARK3116 is not set
>CONFIG_USB_SERIAL_BELKIN=y
>CONFIG_USB_SERIAL_CH341=y
>CONFIG_USB_SERIAL_WHITEHEAT=y
>CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
># CONFIG_USB_SERIAL_CP210X is not set
>CONFIG_USB_SERIAL_CYPRESS_M8=y
>CONFIG_USB_SERIAL_EMPEG=y
>CONFIG_USB_SERIAL_FTDI_SIO=y
>CONFIG_USB_SERIAL_VISOR=y
># CONFIG_USB_SERIAL_IPAQ is not set
>CONFIG_USB_SERIAL_IR=y
>CONFIG_USB_SERIAL_EDGEPORT=y
>CONFIG_USB_SERIAL_EDGEPORT_TI=y
>CONFIG_USB_SERIAL_F81232=y
>CONFIG_USB_SERIAL_F8153X=y
>CONFIG_USB_SERIAL_GARMIN=y
># CONFIG_USB_SERIAL_IPW is not set
>CONFIG_USB_SERIAL_IUU=y
># CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
>CONFIG_USB_SERIAL_KEYSPAN=y
>CONFIG_USB_SERIAL_KEYSPAN_MPR=y
># CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
>CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
>CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
>CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
># CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
>CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
>CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
># CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
>CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
># CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
>CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
># CONFIG_USB_SERIAL_KLSI is not set
>CONFIG_USB_SERIAL_KOBIL_SCT=y
>CONFIG_USB_SERIAL_MCT_U232=y
># CONFIG_USB_SERIAL_METRO is not set
>CONFIG_USB_SERIAL_MOS7720=y
>CONFIG_USB_SERIAL_MOS7840=y
># CONFIG_USB_SERIAL_MXUPORT is not set
># CONFIG_USB_SERIAL_NAVMAN is not set
># CONFIG_USB_SERIAL_PL2303 is not set
>CONFIG_USB_SERIAL_OTI6858=y
>CONFIG_USB_SERIAL_QCAUX=y
>CONFIG_USB_SERIAL_QUALCOMM=y
>CONFIG_USB_SERIAL_SPCP8X5=y
># CONFIG_USB_SERIAL_SAFE is not set
>CONFIG_USB_SERIAL_SIERRAWIRELESS=y
># CONFIG_USB_SERIAL_SYMBOL is not set
>CONFIG_USB_SERIAL_TI=y
>CONFIG_USB_SERIAL_CYBERJACK=y
>CONFIG_USB_SERIAL_XIRCOM=y
>CONFIG_USB_SERIAL_WWAN=y
>CONFIG_USB_SERIAL_OPTION=y
># CONFIG_USB_SERIAL_OMNINET is not set
># CONFIG_USB_SERIAL_OPTICON is not set
>CONFIG_USB_SERIAL_XSENS_MT=y
># CONFIG_USB_SERIAL_WISHBONE is not set
>CONFIG_USB_SERIAL_SSU100=y
># CONFIG_USB_SERIAL_QT2 is not set
># CONFIG_USB_SERIAL_UPD78F0730 is not set
># CONFIG_USB_SERIAL_DEBUG is not set
>
>#
># USB Miscellaneous drivers
>#
># CONFIG_USB_EMI62 is not set
># CONFIG_USB_EMI26 is not set
>CONFIG_USB_ADUTUX=y
>CONFIG_USB_SEVSEG=y
>CONFIG_USB_RIO500=y
>CONFIG_USB_LEGOTOWER=y
>CONFIG_USB_LCD=y
>CONFIG_USB_CYPRESS_CY7C63=y
>CONFIG_USB_CYTHERM=y
>CONFIG_USB_IDMOUSE=y
>CONFIG_USB_FTDI_ELAN=y
>CONFIG_USB_APPLEDISPLAY=y
>CONFIG_USB_SISUSBVGA=y
>CONFIG_USB_SISUSBVGA_CON=y
>CONFIG_USB_LD=y
>CONFIG_USB_TRANCEVIBRATOR=y
>CONFIG_USB_IOWARRIOR=y
>CONFIG_USB_TEST=y
>CONFIG_USB_EHSET_TEST_FIXTURE=y
>CONFIG_USB_ISIGHTFW=y
># CONFIG_USB_YUREX is not set
>CONFIG_USB_EZUSB_FX2=y
>CONFIG_USB_HUB_USB251XB=y
># CONFIG_USB_HSIC_USB3503 is not set
>CONFIG_USB_HSIC_USB4604=y
>CONFIG_USB_LINK_LAYER_TEST=y
>CONFIG_USB_ATM=y
># CONFIG_USB_SPEEDTOUCH is not set
># CONFIG_USB_CXACRU is not set
>CONFIG_USB_UEAGLEATM=y
>CONFIG_USB_XUSBATM=y
>
>#
># USB Physical Layer drivers
>#
>CONFIG_USB_PHY=y
>CONFIG_NOP_USB_XCEIV=y
># CONFIG_USB_GPIO_VBUS is not set
># CONFIG_USB_ISP1301 is not set
>CONFIG_USB_GADGET=y
># CONFIG_USB_GADGET_DEBUG is not set
># CONFIG_USB_GADGET_DEBUG_FILES is not set
>CONFIG_USB_GADGET_DEBUG_FS=y
>CONFIG_USB_GADGET_VBUS_DRAW=2
>CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
>CONFIG_U_SERIAL_CONSOLE=y
>
>#
># USB Peripheral Controller
>#
>CONFIG_USB_FOTG210_UDC=y
>CONFIG_USB_GR_UDC=y
>CONFIG_USB_R8A66597=y
>CONFIG_USB_PXA27X=y
>CONFIG_USB_MV_UDC=y
>CONFIG_USB_MV_U3D=y
>CONFIG_USB_SNP_CORE=y
>CONFIG_USB_SNP_UDC_PLAT=y
>CONFIG_USB_M66592=y
># CONFIG_USB_BDC_UDC is not set
># CONFIG_USB_AMD5536UDC is not set
>CONFIG_USB_NET2272=y
>CONFIG_USB_NET2272_DMA=y
># CONFIG_USB_NET2280 is not set
># CONFIG_USB_GOKU is not set
># CONFIG_USB_EG20T is not set
>CONFIG_USB_GADGET_XILINX=y
>CONFIG_USB_DUMMY_HCD=y
>CONFIG_USB_LIBCOMPOSITE=y
>CONFIG_USB_U_SERIAL=y
>CONFIG_USB_U_ETHER=y
>CONFIG_USB_F_OBEX=y
>CONFIG_USB_F_EEM=y
>CONFIG_USB_F_SUBSET=y
>CONFIG_USB_F_MASS_STORAGE=y
>CONFIG_USB_F_FS=y
>CONFIG_USB_F_UVC=y
>CONFIG_USB_F_PRINTER=y
>CONFIG_USB_CONFIGFS=y
># CONFIG_USB_CONFIGFS_SERIAL is not set
># CONFIG_USB_CONFIGFS_ACM is not set
>CONFIG_USB_CONFIGFS_OBEX=y
># CONFIG_USB_CONFIGFS_NCM is not set
># CONFIG_USB_CONFIGFS_ECM is not set
>CONFIG_USB_CONFIGFS_ECM_SUBSET=y
># CONFIG_USB_CONFIGFS_RNDIS is not set
>CONFIG_USB_CONFIGFS_EEM=y
>CONFIG_USB_CONFIGFS_MASS_STORAGE=y
># CONFIG_USB_CONFIGFS_F_LB_SS is not set
>CONFIG_USB_CONFIGFS_F_FS=y
># CONFIG_USB_CONFIGFS_F_HID is not set
>CONFIG_USB_CONFIGFS_F_UVC=y
>CONFIG_USB_CONFIGFS_F_PRINTER=y
>
>#
># USB Power Delivery and Type-C drivers
>#
>CONFIG_TYPEC=y
># CONFIG_TYPEC_TCPM is not set
># CONFIG_TYPEC_UCSI is not set
>CONFIG_TYPEC_TPS6598X=y
>CONFIG_USB_LED_TRIG=y
>CONFIG_USB_ULPI_BUS=y
># CONFIG_UWB is not set
>CONFIG_MMC=y
># CONFIG_PWRSEQ_EMMC is not set
># CONFIG_PWRSEQ_SIMPLE is not set
># CONFIG_MMC_BLOCK is not set
># CONFIG_SDIO_UART is not set
>CONFIG_MMC_TEST=y
>
>#
># MMC/SD/SDIO Host Controller Drivers
>#
>CONFIG_MMC_DEBUG=y
>CONFIG_MMC_SDHCI=y
># CONFIG_MMC_SDHCI_PCI is not set
># CONFIG_MMC_SDHCI_ACPI is not set
># CONFIG_MMC_SDHCI_PLTFM is not set
>CONFIG_MMC_WBSD=y
># CONFIG_MMC_TIFM_SD is not set
>CONFIG_MMC_SPI=y
># CONFIG_MMC_CB710 is not set
># CONFIG_MMC_VIA_SDMMC is not set
>CONFIG_MMC_VUB300=y
>CONFIG_MMC_USHC=y
>CONFIG_MMC_USDHI6ROL0=y
>CONFIG_MMC_REALTEK_USB=y
># CONFIG_MMC_TOSHIBA_PCI is not set
>CONFIG_MMC_MTK=y
>CONFIG_MEMSTICK=y
>CONFIG_MEMSTICK_DEBUG=y
>
>#
># MemoryStick drivers
>#
># CONFIG_MEMSTICK_UNSAFE_RESUME is not set
>CONFIG_MSPRO_BLOCK=y
># CONFIG_MS_BLOCK is not set
>
>#
># MemoryStick Host Controller Drivers
>#
># CONFIG_MEMSTICK_TIFM_MS is not set
># CONFIG_MEMSTICK_JMICRON_38X is not set
># CONFIG_MEMSTICK_R592 is not set
>CONFIG_MEMSTICK_REALTEK_USB=y
>CONFIG_NEW_LEDS=y
>CONFIG_LEDS_CLASS=y
># CONFIG_LEDS_CLASS_FLASH is not set
>CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
>
>#
># LED drivers
>#
>CONFIG_LEDS_88PM860X=y
># CONFIG_LEDS_APU is not set
>CONFIG_LEDS_BCM6328=y
># CONFIG_LEDS_BCM6358 is not set
>CONFIG_LEDS_LM3530=y
>CONFIG_LEDS_LM3642=y
># CONFIG_LEDS_PCA9532 is not set
># CONFIG_LEDS_GPIO is not set
>CONFIG_LEDS_LP3944=y
># CONFIG_LEDS_LP3952 is not set
>CONFIG_LEDS_LP55XX_COMMON=y
># CONFIG_LEDS_LP5521 is not set
>CONFIG_LEDS_LP5523=y
># CONFIG_LEDS_LP5562 is not set
>CONFIG_LEDS_LP8501=y
>CONFIG_LEDS_LP8788=y
>CONFIG_LEDS_LP8860=y
>CONFIG_LEDS_CLEVO_MAIL=y
># CONFIG_LEDS_PCA955X is not set
>CONFIG_LEDS_PCA963X=y
># CONFIG_LEDS_WM831X_STATUS is not set
># CONFIG_LEDS_DA9052 is not set
># CONFIG_LEDS_DAC124S085 is not set
># CONFIG_LEDS_PWM is not set
># CONFIG_LEDS_REGULATOR is not set
>CONFIG_LEDS_BD2802=y
># CONFIG_LEDS_INTEL_SS4200 is not set
>CONFIG_LEDS_LT3593=y
>CONFIG_LEDS_ADP5520=y
>CONFIG_LEDS_MC13783=y
># CONFIG_LEDS_TCA6507 is not set
>CONFIG_LEDS_TLC591XX=y
>CONFIG_LEDS_MAX8997=y
># CONFIG_LEDS_LM355x is not set
># CONFIG_LEDS_OT200 is not set
># CONFIG_LEDS_IS31FL319X is not set
># CONFIG_LEDS_IS31FL32XX is not set
>
>#
># LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
>#
>CONFIG_LEDS_BLINKM=y
># CONFIG_LEDS_SYSCON is not set
>CONFIG_LEDS_USER=y
># CONFIG_LEDS_NIC78BX is not set
>
>#
># LED Triggers
>#
>CONFIG_LEDS_TRIGGERS=y
># CONFIG_LEDS_TRIGGER_TIMER is not set
>CONFIG_LEDS_TRIGGER_ONESHOT=y
># CONFIG_LEDS_TRIGGER_DISK is not set
># CONFIG_LEDS_TRIGGER_MTD is not set
>CONFIG_LEDS_TRIGGER_HEARTBEAT=y
># CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
>CONFIG_LEDS_TRIGGER_CPU=y
>CONFIG_LEDS_TRIGGER_ACTIVITY=y
>CONFIG_LEDS_TRIGGER_GPIO=y
># CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
>
>#
># iptables trigger is under Netfilter config (LED target)
>#
>CONFIG_LEDS_TRIGGER_TRANSIENT=y
>CONFIG_LEDS_TRIGGER_CAMERA=y
>CONFIG_LEDS_TRIGGER_PANIC=y
># CONFIG_ACCESSIBILITY is not set
># CONFIG_INFINIBAND is not set
>CONFIG_EDAC_ATOMIC_SCRUB=y
>CONFIG_EDAC_SUPPORT=y
>CONFIG_EDAC=y
># CONFIG_EDAC_LEGACY_SYSFS is not set
>CONFIG_EDAC_DEBUG=y
>CONFIG_EDAC_DECODE_MCE=y
># CONFIG_EDAC_AMD64 is not set
># CONFIG_EDAC_AMD76X is not set
># CONFIG_EDAC_E7XXX is not set
># CONFIG_EDAC_E752X is not set
># CONFIG_EDAC_I82875P is not set
># CONFIG_EDAC_I82975X is not set
># CONFIG_EDAC_I3000 is not set
># CONFIG_EDAC_I3200 is not set
># CONFIG_EDAC_IE31200 is not set
># CONFIG_EDAC_X38 is not set
># CONFIG_EDAC_I5400 is not set
># CONFIG_EDAC_I7CORE is not set
># CONFIG_EDAC_I82860 is not set
># CONFIG_EDAC_R82600 is not set
># CONFIG_EDAC_I5000 is not set
># CONFIG_EDAC_I5100 is not set
># CONFIG_EDAC_I7300 is not set
>CONFIG_RTC_LIB=y
>CONFIG_RTC_MC146818_LIB=y
># CONFIG_RTC_CLASS is not set
># CONFIG_DMADEVICES is not set
>
>#
># DMABUF options
>#
>CONFIG_SYNC_FILE=y
># CONFIG_SW_SYNC is not set
>CONFIG_AUXDISPLAY=y
>CONFIG_CHARLCD=y
>CONFIG_HD44780=y
>CONFIG_IMG_ASCII_LCD=y
># CONFIG_HT16K33 is not set
># CONFIG_UIO is not set
>CONFIG_VIRT_DRIVERS=y
>CONFIG_VIRTIO=y
>
>#
># Virtio drivers
>#
># CONFIG_VIRTIO_PCI is not set
>CONFIG_VIRTIO_BALLOON=y
>CONFIG_VIRTIO_INPUT=y
>CONFIG_VIRTIO_MMIO=y
>CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
>
>#
># Microsoft Hyper-V guest support
>#
># CONFIG_HYPERV is not set
># CONFIG_HYPERV_TSCPAGE is not set
>CONFIG_STAGING=y
>CONFIG_IRDA=y
>
>#
># IrDA protocols
>#
>CONFIG_IRLAN=y
># CONFIG_IRNET is not set
>CONFIG_IRCOMM=y
># CONFIG_IRDA_ULTRA is not set
>
>#
># IrDA options
>#
># CONFIG_IRDA_CACHE_LAST_LSAP is not set
># CONFIG_IRDA_FAST_RR is not set
># CONFIG_IRDA_DEBUG is not set
>
>#
># Infrared-port device drivers
>#
>
>#
># SIR device drivers
>#
>CONFIG_IRTTY_SIR=y
>
>#
># Dongle support
>#
># CONFIG_DONGLE is not set
># CONFIG_KINGSUN_DONGLE is not set
>CONFIG_KSDAZZLE_DONGLE=y
># CONFIG_KS959_DONGLE is not set
>
>#
># FIR device drivers
>#
># CONFIG_USB_IRDA is not set
>CONFIG_SIGMATEL_FIR=y
>CONFIG_NSC_FIR=y
>CONFIG_WINBOND_FIR=y
># CONFIG_TOSHIBA_FIR is not set
># CONFIG_SMC_IRCC_FIR is not set
># CONFIG_ALI_FIR is not set
># CONFIG_VLSI_FIR is not set
>CONFIG_VIA_FIR=y
># CONFIG_MCS_FIR is not set
>CONFIG_PRISM2_USB=y
># CONFIG_COMEDI is not set
>CONFIG_R8712U=y
># CONFIG_RTS5208 is not set
># CONFIG_FB_SM750 is not set
># CONFIG_FB_XGI is not set
>
>#
># Speakup console speech
>#
>CONFIG_SPEAKUP=y
>CONFIG_SPEAKUP_SYNTH_ACNTSA=y
>CONFIG_SPEAKUP_SYNTH_APOLLO=y
>CONFIG_SPEAKUP_SYNTH_AUDPTR=y
># CONFIG_SPEAKUP_SYNTH_BNS is not set
># CONFIG_SPEAKUP_SYNTH_DECTLK is not set
>CONFIG_SPEAKUP_SYNTH_DECEXT=y
>CONFIG_SPEAKUP_SYNTH_LTLK=y
>CONFIG_SPEAKUP_SYNTH_SOFT=y
>CONFIG_SPEAKUP_SYNTH_SPKOUT=y
>CONFIG_SPEAKUP_SYNTH_TXPRT=y
>CONFIG_SPEAKUP_SYNTH_DUMMY=y
># CONFIG_STAGING_MEDIA is not set
>
>#
># Android
>#
># CONFIG_STAGING_BOARD is not set
># CONFIG_FIREWIRE_SERIAL is not set
># CONFIG_DGNC is not set
>CONFIG_GS_FPGABOOT=y
># CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
># CONFIG_FB_TFT is not set
>CONFIG_WILC1000=y
>CONFIG_WILC1000_SDIO=y
>CONFIG_WILC1000_SPI=y
># CONFIG_WILC1000_HW_OOB_INTR is not set
># CONFIG_MOST is not set
>CONFIG_KS7010=y
>CONFIG_GREYBUS=y
>CONFIG_GREYBUS_ES2=y
>CONFIG_GREYBUS_BOOTROM=y
>CONFIG_GREYBUS_FIRMWARE=y
># CONFIG_GREYBUS_HID is not set
># CONFIG_GREYBUS_LIGHT is not set
># CONFIG_GREYBUS_LOG is not set
># CONFIG_GREYBUS_LOOPBACK is not set
>CONFIG_GREYBUS_POWER=y
>CONFIG_GREYBUS_RAW=y
># CONFIG_GREYBUS_VIBRATOR is not set
>CONFIG_GREYBUS_BRIDGED_PHY=y
>CONFIG_GREYBUS_GPIO=y
># CONFIG_GREYBUS_I2C is not set
># CONFIG_GREYBUS_PWM is not set
>CONFIG_GREYBUS_SDIO=y
>CONFIG_GREYBUS_SPI=y
># CONFIG_GREYBUS_UART is not set
>CONFIG_GREYBUS_USB=y
># CONFIG_CRYPTO_DEV_CCREE is not set
>
>#
># USB Power Delivery and Type-C drivers
>#
># CONFIG_DRM_VBOXVIDEO is not set
># CONFIG_PI433 is not set
>CONFIG_X86_PLATFORM_DEVICES=y
># CONFIG_ACERHDF is not set
># CONFIG_ASUS_LAPTOP is not set
>CONFIG_DELL_SMBIOS=y
>CONFIG_DELL_LAPTOP=y
># CONFIG_DELL_SMO8800 is not set
># CONFIG_DELL_RBTN is not set
># CONFIG_FUJITSU_LAPTOP is not set
># CONFIG_FUJITSU_TABLET is not set
># CONFIG_AMILO_RFKILL is not set
># CONFIG_HP_ACCEL is not set
># CONFIG_HP_WIRELESS is not set
># CONFIG_MSI_LAPTOP is not set
># CONFIG_PANASONIC_LAPTOP is not set
># CONFIG_COMPAL_LAPTOP is not set
># CONFIG_SONY_LAPTOP is not set
># CONFIG_IDEAPAD_LAPTOP is not set
># CONFIG_THINKPAD_ACPI is not set
>CONFIG_SENSORS_HDAPS=y
># CONFIG_INTEL_MENLOW is not set
># CONFIG_ASUS_WIRELESS is not set
># CONFIG_ACPI_WMI is not set
># CONFIG_TOPSTAR_LAPTOP is not set
># CONFIG_TOSHIBA_BT_RFKILL is not set
># CONFIG_TOSHIBA_HAPS is not set
># CONFIG_ACPI_CMPC is not set
># CONFIG_INTEL_CHT_INT33FE is not set
># CONFIG_INTEL_INT0002_VGPIO is not set
># CONFIG_INTEL_HID_EVENT is not set
># CONFIG_INTEL_VBTN is not set
># CONFIG_INTEL_IPS is not set
># CONFIG_INTEL_PMC_CORE is not set
># CONFIG_IBM_RTL is not set
># CONFIG_SAMSUNG_LAPTOP is not set
># CONFIG_INTEL_OAKTRAIL is not set
># CONFIG_SAMSUNG_Q10 is not set
># CONFIG_APPLE_GMUX is not set
># CONFIG_INTEL_RST is not set
># CONFIG_INTEL_SMARTCONNECT is not set
># CONFIG_PVPANIC is not set
># CONFIG_INTEL_PMC_IPC is not set
># CONFIG_SURFACE_PRO3_BUTTON is not set
># CONFIG_SURFACE_3_BUTTON is not set
>CONFIG_INTEL_PUNIT_IPC=y
># CONFIG_MLX_CPLD_PLATFORM is not set
>CONFIG_PMC_ATOM=y
># CONFIG_CHROME_PLATFORMS is not set
>CONFIG_CLKDEV_LOOKUP=y
>CONFIG_HAVE_CLK_PREPARE=y
>CONFIG_COMMON_CLK=y
>
>#
># Common Clock Framework
>#
># CONFIG_COMMON_CLK_WM831X is not set
># CONFIG_CLK_HSDK is not set
># CONFIG_COMMON_CLK_MAX77686 is not set
># CONFIG_COMMON_CLK_SI5351 is not set
># CONFIG_COMMON_CLK_SI514 is not set
># CONFIG_COMMON_CLK_SI570 is not set
># CONFIG_COMMON_CLK_CDCE706 is not set
># CONFIG_COMMON_CLK_CDCE925 is not set
># CONFIG_COMMON_CLK_CS2000_CP is not set
># CONFIG_COMMON_CLK_NXP is not set
># CONFIG_COMMON_CLK_PWM is not set
># CONFIG_COMMON_CLK_PXA is not set
># CONFIG_COMMON_CLK_PIC32 is not set
># CONFIG_COMMON_CLK_VC5 is not set
># CONFIG_HWSPINLOCK is not set
>
>#
># Clock Source drivers
>#
>CONFIG_CLKSRC_I8253=y
>CONFIG_CLKEVT_I8253=y
>CONFIG_I8253_LOCK=y
>CONFIG_CLKBLD_I8253=y
># CONFIG_ATMEL_PIT is not set
># CONFIG_SH_TIMER_CMT is not set
># CONFIG_SH_TIMER_MTU2 is not set
># CONFIG_SH_TIMER_TMU is not set
># CONFIG_EM_TIMER_STI is not set
># CONFIG_MAILBOX is not set
>CONFIG_IOMMU_SUPPORT=y
>
>#
># Generic IOMMU Pagetable Support
>#
>
>#
># Remoteproc drivers
>#
>CONFIG_REMOTEPROC=y
>
>#
># Rpmsg drivers
>#
>CONFIG_RPMSG=y
>CONFIG_RPMSG_CHAR=y
>CONFIG_RPMSG_VIRTIO=y
>
>#
># SOC (System On Chip) specific Drivers
>#
>
>#
># Amlogic SoC drivers
>#
>
>#
># Broadcom SoC drivers
>#
>
>#
># i.MX SoC drivers
>#
>
>#
># Qualcomm SoC drivers
>#
># CONFIG_SUNXI_SRAM is not set
># CONFIG_SOC_TI is not set
>CONFIG_PM_DEVFREQ=y
>
>#
># DEVFREQ Governors
>#
>CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>CONFIG_DEVFREQ_GOV_PERFORMANCE=y
>CONFIG_DEVFREQ_GOV_POWERSAVE=y
>CONFIG_DEVFREQ_GOV_USERSPACE=y
># CONFIG_DEVFREQ_GOV_PASSIVE is not set
>
>#
># DEVFREQ Drivers
>#
># CONFIG_PM_DEVFREQ_EVENT is not set
>CONFIG_EXTCON=y
>
>#
># Extcon Device Drivers
>#
>CONFIG_EXTCON_AXP288=y
>CONFIG_EXTCON_GPIO=y
># CONFIG_EXTCON_INTEL_INT3496 is not set
># CONFIG_EXTCON_MAX3355 is not set
>CONFIG_EXTCON_MAX77843=y
># CONFIG_EXTCON_MAX8997 is not set
># CONFIG_EXTCON_RT8973A is not set
>CONFIG_EXTCON_SM5502=y
>CONFIG_EXTCON_USB_GPIO=y
># CONFIG_MEMORY is not set
># CONFIG_IIO is not set
># CONFIG_NTB is not set
># CONFIG_VME_BUS is not set
>CONFIG_PWM=y
>CONFIG_PWM_SYSFS=y
># CONFIG_PWM_ATMEL_HLCDC_PWM is not set
># CONFIG_PWM_FSL_FTM is not set
># CONFIG_PWM_LP3943 is not set
># CONFIG_PWM_LPSS_PCI is not set
># CONFIG_PWM_LPSS_PLATFORM is not set
># CONFIG_PWM_PCA9685 is not set
>
>#
># IRQ chip support
>#
>CONFIG_IRQCHIP=y
>CONFIG_ARM_GIC_MAX_NR=1
># CONFIG_ARM_GIC_V3_ITS is not set
>CONFIG_IPACK_BUS=y
># CONFIG_BOARD_TPCI200 is not set
>CONFIG_SERIAL_IPOCTAL=y
>CONFIG_RESET_CONTROLLER=y
># CONFIG_RESET_ATH79 is not set
># CONFIG_RESET_AXS10X is not set
># CONFIG_RESET_BERLIN is not set
># CONFIG_RESET_IMX7 is not set
># CONFIG_RESET_LANTIQ is not set
># CONFIG_RESET_LPC18XX is not set
># CONFIG_RESET_MESON is not set
># CONFIG_RESET_PISTACHIO is not set
># CONFIG_RESET_SIMPLE is not set
># CONFIG_RESET_SUNXI is not set
>CONFIG_RESET_TI_SYSCON=y
># CONFIG_RESET_ZYNQ is not set
># CONFIG_RESET_TEGRA_BPMP is not set
>CONFIG_FMC=y
># CONFIG_FMC_FAKEDEV is not set
># CONFIG_FMC_TRIVIAL is not set
># CONFIG_FMC_WRITE_EEPROM is not set
>CONFIG_FMC_CHARDEV=y
>
>#
># PHY Subsystem
>#
>CONFIG_GENERIC_PHY=y
># CONFIG_BCM_KONA_USB2_PHY is not set
>CONFIG_PHY_PXA_28NM_HSIC=y
># CONFIG_PHY_PXA_28NM_USB2 is not set
># CONFIG_PHY_QCOM_USB_HS is not set
>CONFIG_PHY_QCOM_USB_HSIC=y
>CONFIG_PHY_TUSB1210=y
># CONFIG_POWERCAP is not set
>CONFIG_MCB=y
># CONFIG_MCB_PCI is not set
># CONFIG_MCB_LPC is not set
>
>#
># Performance monitor support
>#
>CONFIG_RAS=y
># CONFIG_THUNDERBOLT is not set
>
>#
># Android
>#
># CONFIG_ANDROID is not set
># CONFIG_LIBNVDIMM is not set
>CONFIG_DAX=y
>CONFIG_NVMEM=y
># CONFIG_STM is not set
>CONFIG_INTEL_TH=y
># CONFIG_INTEL_TH_PCI is not set
>CONFIG_INTEL_TH_GTH=y
># CONFIG_INTEL_TH_MSU is not set
>CONFIG_INTEL_TH_PTI=y
># CONFIG_INTEL_TH_DEBUG is not set
>CONFIG_FPGA=y
>CONFIG_FPGA_REGION=y
># CONFIG_FPGA_MGR_ICE40_SPI is not set
># CONFIG_FPGA_MGR_ALTERA_CVP is not set
># CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
># CONFIG_FPGA_MGR_XILINX_SPI is not set
>CONFIG_FPGA_BRIDGE=y
>CONFIG_ALTERA_PR_IP_CORE=y
># CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
># CONFIG_XILINX_PR_DECOUPLER is not set
>
>#
># FSI support
>#
>CONFIG_FSI=y
>CONFIG_FSI_MASTER_GPIO=y
>CONFIG_FSI_MASTER_HUB=y
>CONFIG_FSI_SCOM=y
>CONFIG_MULTIPLEXER=y
>
>#
># Multiplexer drivers
>#
>CONFIG_MUX_ADG792A=y
>CONFIG_MUX_GPIO=y
>CONFIG_MUX_MMIO=y
>CONFIG_PM_OPP=y
>
>#
># Firmware Drivers
>#
># CONFIG_EDD is not set
>CONFIG_FIRMWARE_MEMMAP=y
># CONFIG_DELL_RBU is not set
># CONFIG_DCDBAS is not set
>CONFIG_DMIID=y
>CONFIG_DMI_SYSFS=y
>CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
># CONFIG_ISCSI_IBFT_FIND is not set
>CONFIG_FW_CFG_SYSFS=y
>CONFIG_FW_CFG_SYSFS_CMDLINE=y
>CONFIG_GOOGLE_FIRMWARE=y
># CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
># CONFIG_GOOGLE_COREBOOT_TABLE_OF is not set
># CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
># CONFIG_EFI_DEV_PATH_PARSER is not set
>
>#
># Tegra firmware driver
>#
>
>#
># File systems
>#
>CONFIG_DCACHE_WORD_ACCESS=y
>CONFIG_FS_IOMAP=y
>CONFIG_EXT2_FS=y
>CONFIG_EXT2_FS_XATTR=y
># CONFIG_EXT2_FS_POSIX_ACL is not set
>CONFIG_EXT2_FS_SECURITY=y
>CONFIG_EXT3_FS=y
>CONFIG_EXT3_FS_POSIX_ACL=y
>CONFIG_EXT3_FS_SECURITY=y
>CONFIG_EXT4_FS=y
>CONFIG_EXT4_FS_POSIX_ACL=y
>CONFIG_EXT4_FS_SECURITY=y
>CONFIG_EXT4_ENCRYPTION=y
>CONFIG_EXT4_FS_ENCRYPTION=y
>CONFIG_EXT4_DEBUG=y
>CONFIG_JBD2=y
>CONFIG_JBD2_DEBUG=y
>CONFIG_FS_MBCACHE=y
>CONFIG_REISERFS_FS=y
>CONFIG_REISERFS_CHECK=y
># CONFIG_REISERFS_PROC_INFO is not set
>CONFIG_REISERFS_FS_XATTR=y
>CONFIG_REISERFS_FS_POSIX_ACL=y
># CONFIG_REISERFS_FS_SECURITY is not set
>CONFIG_JFS_FS=y
># CONFIG_JFS_POSIX_ACL is not set
>CONFIG_JFS_SECURITY=y
>CONFIG_JFS_DEBUG=y
># CONFIG_JFS_STATISTICS is not set
>CONFIG_OCFS2_FS=y
># CONFIG_OCFS2_FS_O2CB is not set
>CONFIG_OCFS2_FS_USERSPACE_CLUSTER=y
># CONFIG_OCFS2_FS_STATS is not set
>CONFIG_OCFS2_DEBUG_MASKLOG=y
>CONFIG_OCFS2_DEBUG_FS=y
>CONFIG_BTRFS_FS=y
>CONFIG_BTRFS_FS_POSIX_ACL=y
>CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
># CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>CONFIG_BTRFS_DEBUG=y
># CONFIG_BTRFS_ASSERT is not set
># CONFIG_BTRFS_FS_REF_VERIFY is not set
>CONFIG_NILFS2_FS=y
>CONFIG_F2FS_FS=y
>CONFIG_F2FS_STAT_FS=y
># CONFIG_F2FS_FS_XATTR is not set
>CONFIG_F2FS_CHECK_FS=y
># CONFIG_F2FS_FAULT_INJECTION is not set
>CONFIG_FS_DAX=y
>CONFIG_FS_POSIX_ACL=y
>CONFIG_EXPORTFS=y
>CONFIG_EXPORTFS_BLOCK_OPS=y
>CONFIG_FILE_LOCKING=y
># CONFIG_MANDATORY_FILE_LOCKING is not set
>CONFIG_FS_ENCRYPTION=y
>CONFIG_FSNOTIFY=y
>CONFIG_DNOTIFY=y
>CONFIG_INOTIFY_USER=y
># CONFIG_FANOTIFY is not set
>CONFIG_QUOTA=y
># CONFIG_QUOTA_NETLINK_INTERFACE is not set
># CONFIG_PRINT_QUOTA_WARNING is not set
># CONFIG_QUOTA_DEBUG is not set
>CONFIG_QUOTA_TREE=y
># CONFIG_QFMT_V1 is not set
># CONFIG_QFMT_V2 is not set
>CONFIG_QUOTACTL=y
>CONFIG_AUTOFS4_FS=y
>CONFIG_FUSE_FS=y
># CONFIG_CUSE is not set
># CONFIG_OVERLAY_FS is not set
>
>#
># Caches
>#
>CONFIG_FSCACHE=y
>CONFIG_FSCACHE_STATS=y
># CONFIG_FSCACHE_HISTOGRAM is not set
># CONFIG_FSCACHE_DEBUG is not set
>CONFIG_FSCACHE_OBJECT_LIST=y
>CONFIG_CACHEFILES=y
>CONFIG_CACHEFILES_DEBUG=y
># CONFIG_CACHEFILES_HISTOGRAM is not set
>
>#
># CD-ROM/DVD Filesystems
>#
># CONFIG_ISO9660_FS is not set
>CONFIG_UDF_FS=y
>CONFIG_UDF_NLS=y
>
>#
># DOS/FAT/NT Filesystems
>#
>CONFIG_FAT_FS=y
>CONFIG_MSDOS_FS=y
>CONFIG_VFAT_FS=y
>CONFIG_FAT_DEFAULT_CODEPAGE=437
>CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
># CONFIG_FAT_DEFAULT_UTF8 is not set
># CONFIG_NTFS_FS is not set
>
>#
># Pseudo filesystems
>#
>CONFIG_PROC_FS=y
># CONFIG_PROC_KCORE is not set
>CONFIG_PROC_SYSCTL=y
>CONFIG_PROC_PAGE_MONITOR=y
># CONFIG_PROC_CHILDREN is not set
>CONFIG_KERNFS=y
>CONFIG_SYSFS=y
>CONFIG_TMPFS=y
># CONFIG_TMPFS_POSIX_ACL is not set
># CONFIG_TMPFS_XATTR is not set
># CONFIG_HUGETLBFS is not set
># CONFIG_HUGETLB_PAGE is not set
>CONFIG_CONFIGFS_FS=y
>CONFIG_MISC_FILESYSTEMS=y
>CONFIG_ORANGEFS_FS=y
># CONFIG_ADFS_FS is not set
>CONFIG_AFFS_FS=y
>CONFIG_ECRYPT_FS=y
># CONFIG_ECRYPT_FS_MESSAGING is not set
>CONFIG_HFS_FS=y
>CONFIG_HFSPLUS_FS=y
># CONFIG_HFSPLUS_FS_POSIX_ACL is not set
># CONFIG_BEFS_FS is not set
>CONFIG_BFS_FS=y
># CONFIG_EFS_FS is not set
>CONFIG_JFFS2_FS=y
>CONFIG_JFFS2_FS_DEBUG=0
># CONFIG_JFFS2_FS_WRITEBUFFER is not set
>CONFIG_JFFS2_SUMMARY=y
># CONFIG_JFFS2_FS_XATTR is not set
># CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
>CONFIG_JFFS2_ZLIB=y
># CONFIG_JFFS2_LZO is not set
>CONFIG_JFFS2_RTIME=y
># CONFIG_JFFS2_RUBIN is not set
># CONFIG_CRAMFS is not set
>CONFIG_SQUASHFS=y
># CONFIG_SQUASHFS_FILE_CACHE is not set
>CONFIG_SQUASHFS_FILE_DIRECT=y
>CONFIG_SQUASHFS_DECOMP_SINGLE=y
># CONFIG_SQUASHFS_DECOMP_MULTI is not set
># CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
>CONFIG_SQUASHFS_XATTR=y
># CONFIG_SQUASHFS_ZLIB is not set
>CONFIG_SQUASHFS_LZ4=y
># CONFIG_SQUASHFS_LZO is not set
># CONFIG_SQUASHFS_XZ is not set
>CONFIG_SQUASHFS_ZSTD=y
># CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
># CONFIG_SQUASHFS_EMBEDDED is not set
>CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
># CONFIG_VXFS_FS is not set
>CONFIG_MINIX_FS=y
>CONFIG_OMFS_FS=y
>CONFIG_HPFS_FS=y
># CONFIG_QNX4FS_FS is not set
>CONFIG_QNX6FS_FS=y
># CONFIG_QNX6FS_DEBUG is not set
># CONFIG_ROMFS_FS is not set
>CONFIG_PSTORE=y
># CONFIG_PSTORE_ZLIB_COMPRESS is not set
># CONFIG_PSTORE_LZO_COMPRESS is not set
>CONFIG_PSTORE_LZ4_COMPRESS=y
># CONFIG_PSTORE_CONSOLE is not set
>CONFIG_PSTORE_PMSG=y
>CONFIG_PSTORE_RAM=y
># CONFIG_SYSV_FS is not set
>CONFIG_UFS_FS=y
>CONFIG_UFS_FS_WRITE=y
># CONFIG_UFS_DEBUG is not set
># CONFIG_NETWORK_FILESYSTEMS is not set
>CONFIG_NLS=y
>CONFIG_NLS_DEFAULT="iso8859-1"
># CONFIG_NLS_CODEPAGE_437 is not set
># CONFIG_NLS_CODEPAGE_737 is not set
># CONFIG_NLS_CODEPAGE_775 is not set
>CONFIG_NLS_CODEPAGE_850=y
>CONFIG_NLS_CODEPAGE_852=y
>CONFIG_NLS_CODEPAGE_855=y
># CONFIG_NLS_CODEPAGE_857 is not set
>CONFIG_NLS_CODEPAGE_860=y
>CONFIG_NLS_CODEPAGE_861=y
># CONFIG_NLS_CODEPAGE_862 is not set
># CONFIG_NLS_CODEPAGE_863 is not set
>CONFIG_NLS_CODEPAGE_864=y
>CONFIG_NLS_CODEPAGE_865=y
>CONFIG_NLS_CODEPAGE_866=y
># CONFIG_NLS_CODEPAGE_869 is not set
>CONFIG_NLS_CODEPAGE_936=y
>CONFIG_NLS_CODEPAGE_950=y
>CONFIG_NLS_CODEPAGE_932=y
># CONFIG_NLS_CODEPAGE_949 is not set
># CONFIG_NLS_CODEPAGE_874 is not set
># CONFIG_NLS_ISO8859_8 is not set
>CONFIG_NLS_CODEPAGE_1250=y
>CONFIG_NLS_CODEPAGE_1251=y
>CONFIG_NLS_ASCII=y
># CONFIG_NLS_ISO8859_1 is not set
>CONFIG_NLS_ISO8859_2=y
># CONFIG_NLS_ISO8859_3 is not set
>CONFIG_NLS_ISO8859_4=y
>CONFIG_NLS_ISO8859_5=y
># CONFIG_NLS_ISO8859_6 is not set
>CONFIG_NLS_ISO8859_7=y
>CONFIG_NLS_ISO8859_9=y
># CONFIG_NLS_ISO8859_13 is not set
>CONFIG_NLS_ISO8859_14=y
>CONFIG_NLS_ISO8859_15=y
>CONFIG_NLS_KOI8_R=y
>CONFIG_NLS_KOI8_U=y
># CONFIG_NLS_MAC_ROMAN is not set
>CONFIG_NLS_MAC_CELTIC=y
># CONFIG_NLS_MAC_CENTEURO is not set
>CONFIG_NLS_MAC_CROATIAN=y
>CONFIG_NLS_MAC_CYRILLIC=y
>CONFIG_NLS_MAC_GAELIC=y
>CONFIG_NLS_MAC_GREEK=y
>CONFIG_NLS_MAC_ICELAND=y
>CONFIG_NLS_MAC_INUIT=y
># CONFIG_NLS_MAC_ROMANIAN is not set
>CONFIG_NLS_MAC_TURKISH=y
>CONFIG_NLS_UTF8=y
>CONFIG_DLM=y
>CONFIG_DLM_DEBUG=y
>
>#
># Kernel hacking
>#
>CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>
>#
># printk and dmesg options
>#
>CONFIG_PRINTK_TIME=y
>CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
>CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
>CONFIG_BOOT_PRINTK_DELAY=y
>CONFIG_DYNAMIC_DEBUG=y
>
>#
># Compile-time checks and compiler options
>#
>CONFIG_DEBUG_INFO=y
>CONFIG_DEBUG_INFO_REDUCED=y
># CONFIG_DEBUG_INFO_SPLIT is not set
># CONFIG_DEBUG_INFO_DWARF4 is not set
># CONFIG_GDB_SCRIPTS is not set
>CONFIG_ENABLE_WARN_DEPRECATED=y
>CONFIG_ENABLE_MUST_CHECK=y
>CONFIG_FRAME_WARN=1024
># CONFIG_STRIP_ASM_SYMS is not set
>CONFIG_READABLE_ASM=y
># CONFIG_UNUSED_SYMBOLS is not set
>CONFIG_PAGE_OWNER=y
>CONFIG_DEBUG_FS=y
>CONFIG_HEADERS_CHECK=y
>CONFIG_DEBUG_SECTION_MISMATCH=y
># CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>CONFIG_FRAME_POINTER=y
>CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
>CONFIG_MAGIC_SYSRQ=y
>CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
>CONFIG_MAGIC_SYSRQ_SERIAL=y
>CONFIG_DEBUG_KERNEL=y
>
>#
># Memory Debugging
>#
>CONFIG_PAGE_EXTENSION=y
># CONFIG_DEBUG_PAGEALLOC is not set
>CONFIG_PAGE_POISONING=y
>CONFIG_PAGE_POISONING_NO_SANITY=y
>CONFIG_PAGE_POISONING_ZERO=y
># CONFIG_DEBUG_RODATA_TEST is not set
># CONFIG_DEBUG_OBJECTS is not set
># CONFIG_SLUB_DEBUG_ON is not set
>CONFIG_SLUB_STATS=y
>CONFIG_HAVE_DEBUG_KMEMLEAK=y
># CONFIG_DEBUG_KMEMLEAK is not set
># CONFIG_DEBUG_STACK_USAGE is not set
># CONFIG_DEBUG_VM is not set
>CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
>CONFIG_DEBUG_VIRTUAL=y
>CONFIG_DEBUG_MEMORY_INIT=y
>CONFIG_DEBUG_HIGHMEM=y
>CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
>CONFIG_DEBUG_STACKOVERFLOW=y
># CONFIG_DEBUG_SHIRQ is not set
>
>#
># Debug Lockups and Hangs
>#
>CONFIG_LOCKUP_DETECTOR=y
>CONFIG_SOFTLOCKUP_DETECTOR=y
>CONFIG_HARDLOCKUP_DETECTOR_PERF=y
>CONFIG_HARDLOCKUP_DETECTOR=y
># CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
>CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
># CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
>CONFIG_DETECT_HUNG_TASK=y
>CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
># CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
>CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
># CONFIG_WQ_WATCHDOG is not set
>CONFIG_PANIC_ON_OOPS=y
>CONFIG_PANIC_ON_OOPS_VALUE=1
>CONFIG_PANIC_TIMEOUT=0
># CONFIG_SCHED_DEBUG is not set
>CONFIG_SCHED_INFO=y
>CONFIG_SCHEDSTATS=y
># CONFIG_SCHED_STACK_END_CHECK is not set
># CONFIG_DEBUG_TIMEKEEPING is not set
>
>#
># Lock Debugging (spinlocks, mutexes, etc...)
>#
>CONFIG_DEBUG_RT_MUTEXES=y
>CONFIG_DEBUG_SPINLOCK=y
>CONFIG_DEBUG_MUTEXES=y
>CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
>CONFIG_DEBUG_LOCK_ALLOC=y
># CONFIG_PROVE_LOCKING is not set
>CONFIG_LOCKDEP=y
>CONFIG_LOCK_STAT=y
>CONFIG_DEBUG_LOCKDEP=y
>CONFIG_DEBUG_ATOMIC_SLEEP=y
># CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
># CONFIG_LOCK_TORTURE_TEST is not set
>CONFIG_WW_MUTEX_SELFTEST=y
>CONFIG_STACKTRACE=y
># CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
># CONFIG_DEBUG_KOBJECT is not set
>CONFIG_DEBUG_BUGVERBOSE=y
>CONFIG_DEBUG_LIST=y
># CONFIG_DEBUG_PI_LIST is not set
># CONFIG_DEBUG_SG is not set
># CONFIG_DEBUG_NOTIFIERS is not set
># CONFIG_DEBUG_CREDENTIALS is not set
>
>#
># RCU Debugging
>#
># CONFIG_PROVE_RCU is not set
># CONFIG_TORTURE_TEST is not set
># CONFIG_RCU_PERF_TEST is not set
># CONFIG_RCU_TORTURE_TEST is not set
># CONFIG_RCU_TRACE is not set
># CONFIG_RCU_EQS_DEBUG is not set
># CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
># CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
># CONFIG_NOTIFIER_ERROR_INJECTION is not set
>CONFIG_FAULT_INJECTION=y
>CONFIG_FAILSLAB=y
>CONFIG_FAIL_PAGE_ALLOC=y
>CONFIG_FAIL_MAKE_REQUEST=y
># CONFIG_FAIL_IO_TIMEOUT is not set
># CONFIG_FAIL_MMC_REQUEST is not set
>CONFIG_FAIL_FUTEX=y
>CONFIG_FAULT_INJECTION_DEBUG_FS=y
># CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
># CONFIG_LATENCYTOP is not set
>CONFIG_USER_STACKTRACE_SUPPORT=y
>CONFIG_HAVE_FUNCTION_TRACER=y
>CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
>CONFIG_HAVE_DYNAMIC_FTRACE=y
>CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
>CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
>CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
>CONFIG_HAVE_C_RECORDMCOUNT=y
>CONFIG_TRACING_SUPPORT=y
># CONFIG_FTRACE is not set
># CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
># CONFIG_DMA_API_DEBUG is not set
>
>#
># Runtime Testing
>#
>CONFIG_LKDTM=y
>CONFIG_TEST_LIST_SORT=y
>CONFIG_TEST_SORT=y
># CONFIG_BACKTRACE_SELF_TEST is not set
># CONFIG_RBTREE_TEST is not set
>CONFIG_INTERVAL_TREE_TEST=y
>CONFIG_ATOMIC64_SELFTEST=y
>CONFIG_TEST_HEXDUMP=y
>CONFIG_TEST_STRING_HELPERS=y
># CONFIG_TEST_KSTRTOX is not set
>CONFIG_TEST_PRINTF=y
>CONFIG_TEST_BITMAP=y
>CONFIG_TEST_UUID=y
>CONFIG_TEST_RHASHTABLE=y
>CONFIG_TEST_HASH=y
>CONFIG_TEST_PARMAN=y
># CONFIG_TEST_FIND_BIT is not set
># CONFIG_TEST_FIRMWARE is not set
>CONFIG_TEST_SYSCTL=y
># CONFIG_TEST_UDELAY is not set
># CONFIG_TEST_DEBUG_VIRTUAL is not set
>CONFIG_MEMTEST=y
>CONFIG_BUG_ON_DATA_CORRUPTION=y
># CONFIG_SAMPLES is not set
>CONFIG_HAVE_ARCH_KGDB=y
># CONFIG_KGDB is not set
>CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
># CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
># CONFIG_UBSAN is not set
>CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
>CONFIG_X86_VERBOSE_BOOTUP=y
>CONFIG_EARLY_PRINTK=y
># CONFIG_EARLY_PRINTK_DBGP is not set
># CONFIG_EARLY_PRINTK_USB_XDBC is not set
>CONFIG_X86_PTDUMP_CORE=y
>CONFIG_X86_PTDUMP=y
># CONFIG_DEBUG_WX is not set
>CONFIG_DOUBLEFAULT=y
>CONFIG_DEBUG_TLBFLUSH=y
>CONFIG_IOMMU_STRESS=y
>CONFIG_HAVE_MMIOTRACE_SUPPORT=y
>CONFIG_IO_DELAY_TYPE_0X80=0
>CONFIG_IO_DELAY_TYPE_0XED=1
>CONFIG_IO_DELAY_TYPE_UDELAY=2
>CONFIG_IO_DELAY_TYPE_NONE=3
>CONFIG_IO_DELAY_0X80=y
># CONFIG_IO_DELAY_0XED is not set
># CONFIG_IO_DELAY_UDELAY is not set
># CONFIG_IO_DELAY_NONE is not set
>CONFIG_DEFAULT_IO_DELAY_TYPE=0
># CONFIG_DEBUG_BOOT_PARAMS is not set
># CONFIG_CPA_DEBUG is not set
>CONFIG_OPTIMIZE_INLINING=y
># CONFIG_DEBUG_ENTRY is not set
># CONFIG_DEBUG_NMI_SELFTEST is not set
># CONFIG_X86_DEBUG_FPU is not set
># CONFIG_PUNIT_ATOM_DEBUG is not set
>CONFIG_UNWINDER_FRAME_POINTER=y
>
>#
># Security options
>#
>CONFIG_KEYS=y
>CONFIG_PERSISTENT_KEYRINGS=y
># CONFIG_BIG_KEYS is not set
>CONFIG_TRUSTED_KEYS=y
># CONFIG_ENCRYPTED_KEYS is not set
># CONFIG_KEY_DH_OPERATIONS is not set
># CONFIG_SECURITY_DMESG_RESTRICT is not set
># CONFIG_SECURITY is not set
>CONFIG_SECURITYFS=y
>CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>CONFIG_HARDENED_USERCOPY=y
># CONFIG_FORTIFY_SOURCE is not set
>CONFIG_STATIC_USERMODEHELPER=y
>CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
>CONFIG_DEFAULT_SECURITY_DAC=y
>CONFIG_DEFAULT_SECURITY=""
>CONFIG_XOR_BLOCKS=y
>CONFIG_CRYPTO=y
>
>#
># Crypto core or helper
>#
>CONFIG_CRYPTO_ALGAPI=y
>CONFIG_CRYPTO_ALGAPI2=y
>CONFIG_CRYPTO_AEAD=y
>CONFIG_CRYPTO_AEAD2=y
>CONFIG_CRYPTO_BLKCIPHER=y
>CONFIG_CRYPTO_BLKCIPHER2=y
>CONFIG_CRYPTO_HASH=y
>CONFIG_CRYPTO_HASH2=y
>CONFIG_CRYPTO_RNG=y
>CONFIG_CRYPTO_RNG2=y
>CONFIG_CRYPTO_RNG_DEFAULT=y
>CONFIG_CRYPTO_AKCIPHER2=y
>CONFIG_CRYPTO_AKCIPHER=y
>CONFIG_CRYPTO_KPP2=y
>CONFIG_CRYPTO_ACOMP2=y
>CONFIG_CRYPTO_RSA=y
># CONFIG_CRYPTO_DH is not set
>CONFIG_CRYPTO_ECDH=y
>CONFIG_CRYPTO_MANAGER=y
>CONFIG_CRYPTO_MANAGER2=y
>CONFIG_CRYPTO_USER=y
>CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>CONFIG_CRYPTO_GF128MUL=y
>CONFIG_CRYPTO_NULL=y
>CONFIG_CRYPTO_NULL2=y
>CONFIG_CRYPTO_WORKQUEUE=y
>CONFIG_CRYPTO_CRYPTD=y
>CONFIG_CRYPTO_MCRYPTD=y
>CONFIG_CRYPTO_AUTHENC=y
>CONFIG_CRYPTO_SIMD=y
>
>#
># Authenticated Encryption with Associated Data
>#
>CONFIG_CRYPTO_CCM=y
>CONFIG_CRYPTO_GCM=y
>CONFIG_CRYPTO_CHACHA20POLY1305=y
>CONFIG_CRYPTO_SEQIV=y
>CONFIG_CRYPTO_ECHAINIV=y
>
>#
># Block modes
>#
>CONFIG_CRYPTO_CBC=y
>CONFIG_CRYPTO_CTR=y
>CONFIG_CRYPTO_CTS=y
>CONFIG_CRYPTO_ECB=y
># CONFIG_CRYPTO_LRW is not set
>CONFIG_CRYPTO_PCBC=y
>CONFIG_CRYPTO_XTS=y
>CONFIG_CRYPTO_KEYWRAP=y
>
>#
># Hash modes
>#
># CONFIG_CRYPTO_CMAC is not set
>CONFIG_CRYPTO_HMAC=y
># CONFIG_CRYPTO_XCBC is not set
># CONFIG_CRYPTO_VMAC is not set
>
>#
># Digest
>#
>CONFIG_CRYPTO_CRC32C=y
>CONFIG_CRYPTO_CRC32C_INTEL=y
>CONFIG_CRYPTO_CRC32=y
>CONFIG_CRYPTO_CRC32_PCLMUL=y
>CONFIG_CRYPTO_CRCT10DIF=y
>CONFIG_CRYPTO_GHASH=y
>CONFIG_CRYPTO_POLY1305=y
>CONFIG_CRYPTO_MD4=y
>CONFIG_CRYPTO_MD5=y
>CONFIG_CRYPTO_MICHAEL_MIC=y
># CONFIG_CRYPTO_RMD128 is not set
>CONFIG_CRYPTO_RMD160=y
># CONFIG_CRYPTO_RMD256 is not set
>CONFIG_CRYPTO_RMD320=y
>CONFIG_CRYPTO_SHA1=y
>CONFIG_CRYPTO_SHA256=y
>CONFIG_CRYPTO_SHA512=y
>CONFIG_CRYPTO_SHA3=y
>CONFIG_CRYPTO_SM3=y
>CONFIG_CRYPTO_TGR192=y
>CONFIG_CRYPTO_WP512=y
>
>#
># Ciphers
>#
>CONFIG_CRYPTO_AES=y
># CONFIG_CRYPTO_AES_TI is not set
>CONFIG_CRYPTO_AES_586=y
>CONFIG_CRYPTO_AES_NI_INTEL=y
>CONFIG_CRYPTO_ANUBIS=y
>CONFIG_CRYPTO_ARC4=y
>CONFIG_CRYPTO_BLOWFISH=y
>CONFIG_CRYPTO_BLOWFISH_COMMON=y
># CONFIG_CRYPTO_CAMELLIA is not set
>CONFIG_CRYPTO_CAST_COMMON=y
>CONFIG_CRYPTO_CAST5=y
># CONFIG_CRYPTO_CAST6 is not set
>CONFIG_CRYPTO_DES=y
>CONFIG_CRYPTO_FCRYPT=y
>CONFIG_CRYPTO_KHAZAD=y
>CONFIG_CRYPTO_SALSA20=y
># CONFIG_CRYPTO_SALSA20_586 is not set
>CONFIG_CRYPTO_CHACHA20=y
>CONFIG_CRYPTO_SEED=y
># CONFIG_CRYPTO_SERPENT is not set
># CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
># CONFIG_CRYPTO_TEA is not set
>CONFIG_CRYPTO_TWOFISH=y
>CONFIG_CRYPTO_TWOFISH_COMMON=y
>CONFIG_CRYPTO_TWOFISH_586=y
>
>#
># Compression
>#
>CONFIG_CRYPTO_DEFLATE=y
>CONFIG_CRYPTO_LZO=y
># CONFIG_CRYPTO_842 is not set
># CONFIG_CRYPTO_LZ4 is not set
># CONFIG_CRYPTO_LZ4HC is not set
>
>#
># Random Number Generation
>#
>CONFIG_CRYPTO_ANSI_CPRNG=y
>CONFIG_CRYPTO_DRBG_MENU=y
>CONFIG_CRYPTO_DRBG_HMAC=y
>CONFIG_CRYPTO_DRBG_HASH=y
>CONFIG_CRYPTO_DRBG_CTR=y
>CONFIG_CRYPTO_DRBG=y
>CONFIG_CRYPTO_JITTERENTROPY=y
>CONFIG_CRYPTO_USER_API=y
>CONFIG_CRYPTO_USER_API_HASH=y
>CONFIG_CRYPTO_USER_API_SKCIPHER=y
>CONFIG_CRYPTO_USER_API_RNG=y
>CONFIG_CRYPTO_USER_API_AEAD=y
>CONFIG_CRYPTO_HASH_INFO=y
>CONFIG_CRYPTO_HW=y
># CONFIG_CRYPTO_DEV_PADLOCK is not set
># CONFIG_CRYPTO_DEV_GEODE is not set
># CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
># CONFIG_CRYPTO_DEV_CCP is not set
># CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
># CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
># CONFIG_CRYPTO_DEV_QAT_C62X is not set
># CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
># CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
># CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
># CONFIG_CRYPTO_DEV_VIRTIO is not set
>CONFIG_ASYMMETRIC_KEY_TYPE=y
>CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
>CONFIG_X509_CERTIFICATE_PARSER=y
>CONFIG_PKCS7_MESSAGE_PARSER=y
># CONFIG_PKCS7_TEST_KEY is not set
>CONFIG_SIGNED_PE_FILE_VERIFICATION=y
>
>#
># Certificates for signature checking
>#
>CONFIG_SYSTEM_TRUSTED_KEYRING=y
>CONFIG_SYSTEM_TRUSTED_KEYS=""
>CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
>CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
>CONFIG_SECONDARY_TRUSTED_KEYRING=y
>CONFIG_SYSTEM_BLACKLIST_KEYRING=y
>CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
>CONFIG_HAVE_KVM=y
>CONFIG_VIRTUALIZATION=y
>CONFIG_VHOST_NET=y
>CONFIG_VHOST=y
>CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
># CONFIG_BINARY_PRINTF is not set
>
>#
># Library routines
>#
>CONFIG_RAID6_PQ=y
>CONFIG_BITREVERSE=y
># CONFIG_HAVE_ARCH_BITREVERSE is not set
>CONFIG_RATIONAL=y
>CONFIG_GENERIC_STRNCPY_FROM_USER=y
>CONFIG_GENERIC_STRNLEN_USER=y
>CONFIG_GENERIC_NET_UTILS=y
>CONFIG_GENERIC_FIND_FIRST_BIT=y
>CONFIG_GENERIC_PCI_IOMAP=y
>CONFIG_GENERIC_IOMAP=y
>CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
>CONFIG_CRC_CCITT=y
>CONFIG_CRC16=y
>CONFIG_CRC_T10DIF=y
>CONFIG_CRC_ITU_T=y
>CONFIG_CRC32=y
># CONFIG_CRC32_SELFTEST is not set
>CONFIG_CRC32_SLICEBY8=y
># CONFIG_CRC32_SLICEBY4 is not set
># CONFIG_CRC32_SARWATE is not set
># CONFIG_CRC32_BIT is not set
>CONFIG_CRC4=y
>CONFIG_CRC7=y
>CONFIG_LIBCRC32C=y
>CONFIG_CRC8=y
>CONFIG_XXHASH=y
>CONFIG_AUDIT_GENERIC=y
># CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
># CONFIG_RANDOM32_SELFTEST is not set
>CONFIG_ZLIB_INFLATE=y
>CONFIG_ZLIB_DEFLATE=y
>CONFIG_LZO_COMPRESS=y
>CONFIG_LZO_DECOMPRESS=y
>CONFIG_LZ4_COMPRESS=y
>CONFIG_LZ4_DECOMPRESS=y
>CONFIG_ZSTD_COMPRESS=y
>CONFIG_ZSTD_DECOMPRESS=y
>CONFIG_XZ_DEC=y
>CONFIG_XZ_DEC_X86=y
>CONFIG_XZ_DEC_POWERPC=y
>CONFIG_XZ_DEC_IA64=y
>CONFIG_XZ_DEC_ARM=y
>CONFIG_XZ_DEC_ARMTHUMB=y
>CONFIG_XZ_DEC_SPARC=y
>CONFIG_XZ_DEC_BCJ=y
>CONFIG_XZ_DEC_TEST=y
>CONFIG_DECOMPRESS_GZIP=y
>CONFIG_DECOMPRESS_BZIP2=y
>CONFIG_DECOMPRESS_LZMA=y
>CONFIG_DECOMPRESS_XZ=y
>CONFIG_DECOMPRESS_LZO=y
>CONFIG_DECOMPRESS_LZ4=y
>CONFIG_GENERIC_ALLOCATOR=y
>CONFIG_REED_SOLOMON=y
>CONFIG_REED_SOLOMON_ENC8=y
>CONFIG_REED_SOLOMON_DEC8=y
>CONFIG_BCH=y
>CONFIG_BCH_CONST_PARAMS=y
>CONFIG_INTERVAL_TREE=y
>CONFIG_ASSOCIATIVE_ARRAY=y
>CONFIG_HAS_IOMEM=y
>CONFIG_HAS_IOPORT_MAP=y
>CONFIG_HAS_DMA=y
># CONFIG_DMA_NOOP_OPS is not set
># CONFIG_DMA_VIRT_OPS is not set
>CONFIG_CHECK_SIGNATURE=y
>CONFIG_DQL=y
>CONFIG_GLOB=y
># CONFIG_GLOB_SELFTEST is not set
>CONFIG_NLATTR=y
>CONFIG_LRU_CACHE=y
>CONFIG_CLZ_TAB=y
>CONFIG_CORDIC=y
>CONFIG_DDR=y
># CONFIG_IRQ_POLL is not set
>CONFIG_MPILIB=y
>CONFIG_OID_REGISTRY=y
>CONFIG_FONT_SUPPORT=y
># CONFIG_FONTS is not set
>CONFIG_FONT_8x8=y
>CONFIG_FONT_8x16=y
># CONFIG_SG_SPLIT is not set
>CONFIG_SG_POOL=y
>CONFIG_ARCH_HAS_SG_CHAIN=y
>CONFIG_STACKDEPOT=y
>CONFIG_SBITMAP=y
>CONFIG_PARMAN=y
>CONFIG_PRIME_NUMBERS=y
>CONFIG_STRING_SELFTEST=y

>#!/bin/sh
>
>export_top_env()
>{
>	export suite='trinity'
>	export testcase='trinity'
>	export runtime=300
>	export job_origin='/lkp/lkp/src/allot/rand/vm-lkp-wsx03-openwrt-i386/trinity.yaml'
>	export testbox='vm-lkp-wsx03-openwrt-i386-23'
>	export tbox_group='vm-lkp-wsx03-openwrt-i386'
>	export kconfig='i386-randconfig-x0-11291749'
>	export compiler='gcc-5'
>	export queue='rand'
>	export branch='linus/master'
>	export commit='4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323'
>	export submit_id='5a1e90790b9a934023057a16'
>	export job_file='/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-23/trinity-300s-openwrt-i386-2016-03-16.cgz-4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323-20171129-81955-j5mius-0.yaml'
>	export id='0eb805331357745a39c19f4c6dd64961c3776a4b'
>	export model='qemu-system-i386 -enable-kvm'
>	export nr_vm=32
>	export nr_cpu=1
>	export memory='320M'
>	export rootfs='openwrt-i386-2016-03-16.cgz'
>	export hdd_partitions='/dev/vda'
>	export swap_partitions='/dev/vdb'
>	export need_kconfig='CONFIG_KVM_GUEST=y'
>	export enqueue_time='2017-11-29 18:48:25 +0800'
>	export _id='5a1e90790b9a934023057a16'
>	export _rt='/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323'
>	export user='lkp'
>	export kernel='/pkg/linux/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/vmlinuz-4.15.0-rc1'
>	export result_root='/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/0'
>	export dequeue_time='2017-11-29 18:50:44 +0800'
>	export LKP_SERVER='inn'
>	export max_uptime=1500
>	export initrd='/osimage/openwrt/openwrt-i386-2016-03-16.cgz'
>	export bootloader_append='root=/dev/ram0
>user=lkp
>job=/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-23/trinity-300s-openwrt-i386-2016-03-16.cgz-4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323-20171129-81955-j5mius-0.yaml
>ARCH=i386
>kconfig=i386-randconfig-x0-11291749
>branch=linus/master
>commit=4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
>BOOT_IMAGE=/pkg/linux/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/vmlinuz-4.15.0-rc1
>max_uptime=1500
>RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/0
>LKP_SERVER=inn
>debug
>apic=debug
>sysrq_always_enabled
>rcupdate.rcu_cpu_stall_timeout=100
>net.ifnames=0
>printk.devkmsg=on
>panic=-1
>softlockup_panic=1
>nmi_watchdog=panic
>oops=panic
>load_ramdisk=2
>prompt_ramdisk=0
>drbd.minor_count=8
>systemd.log_level=err
>ignore_loglevel
>console=tty0
>earlyprintk=ttyS0,115200
>console=ttyS0,115200
>vga=normal
>rw'
>	export bm_initrd='/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-i386-x86_64-6ddabfd2_2017-11-10.cgz'
>	export lkp_initrd='/lkp/lkp/lkp-i386.cgz'
>	export site='inn'
>	export LKP_CGI_PORT=80
>	export LKP_CIFS_PORT=139
>	export job_initrd='/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-23/trinity-300s-openwrt-i386-2016-03-16.cgz-4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323-20171129-81955-j5mius-0.cgz'
>
>	[ -n "$LKP_SRC" ] ||
>	export LKP_SRC=/lkp/${user:-lkp}/src
>}
>
>run_job()
>{
>	echo $$ > $TMP/run-job.pid
>
>	. $LKP_SRC/lib/http.sh
>	. $LKP_SRC/lib/job.sh
>	. $LKP_SRC/lib/env.sh
>
>	export_top_env
>
>	run_monitor $LKP_SRC/monitors/wrapper kmsg
>	run_monitor $LKP_SRC/monitors/wrapper oom-killer
>	run_monitor $LKP_SRC/monitors/plain/watchdog
>
>	run_test $LKP_SRC/tests/wrapper trinity
>}
>
>extract_stats()
>{
>	$LKP_SRC/stats/wrapper kmsg
>
>	$LKP_SRC/stats/wrapper time trinity.time
>	$LKP_SRC/stats/wrapper time
>	$LKP_SRC/stats/wrapper dmesg
>	$LKP_SRC/stats/wrapper kmsg
>	$LKP_SRC/stats/wrapper stderr
>	$LKP_SRC/stats/wrapper last_state
>}
>
>"$@"

>#!/bin/bash
>
># To reproduce,
># 1) save job-script and this script (both are attached in 0day report email)
># 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH
>
>kernel=$1
>
>initrds=(
>	/osimage/openwrt/openwrt-i386-2016-03-16.cgz
>	/lkp/lkp/lkp-i386.cgz
>	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-i386-x86_64-6ddabfd2_2017-11-10.cgz
>)
>
>HTTP_PREFIX=https://github.com/0day-ci/lkp-qemu/raw/master
>wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
>
>{
>	cat "${initrds[@]//*\//}"
>	[[ $INSTALL_MOD_PATH ]] && (
>		cd "$INSTALL_MOD_PATH"
>		find lib | cpio -o -H newc --quiet | gzip
>	)
>	echo  job-script | cpio -o -H newc --quiet | gzip
>} > initrd.img
>
>qemu-img create -f qcow2 disk-vm-lkp-wsx03-openwrt-i386-23-0 256G
>qemu-img create -f qcow2 disk-vm-lkp-wsx03-openwrt-i386-23-1 256G
>
>kvm=(
>	qemu-system-i386
>	-enable-kvm
>	-kernel $kernel
>	-initrd initrd.img
>	-m 320
>	-smp 1
>	-device e1000,netdev=net0
>	-netdev user,id=net0
>	-boot order=nc
>	-no-reboot
>	-watchdog i6300esb
>	-watchdog-action debug
>	-rtc base=localtime
>	-drive file=disk-vm-lkp-wsx03-openwrt-i386-23-0,media=disk,if=virtio
>	-drive file=disk-vm-lkp-wsx03-openwrt-i386-23-1,media=disk,if=virtio
>	-serial stdio
>	-display none
>	-monitor null
>)
>
>append=(
>	ip=::::vm-lkp-wsx03-openwrt-i386-23::dhcp
>	root=/dev/ram0
>	user=lkp
>	job=/job-script
>	ARCH=i386
>	kconfig=i386-randconfig-x0-11291749
>	branch=linus/master
>	commit=4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
>	BOOT_IMAGE=/pkg/linux/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/vmlinuz-4.15.0-rc1
>	max_uptime=1500
>	RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-x0-11291749/gcc-5/4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323/0
>	result_service=tmpfs
>	debug
>	apic=debug
>	sysrq_always_enabled
>	rcupdate.rcu_cpu_stall_timeout=100
>	net.ifnames=0
>	printk.devkmsg=on
>	panic=-1
>	softlockup_panic=1
>	nmi_watchdog=panic
>	oops=panic
>	load_ramdisk=2
>	prompt_ramdisk=0
>	drbd.minor_count=8
>	systemd.log_level=err
>	ignore_loglevel
>	console=tty0
>	earlyprintk=ttyS0,115200
>	console=ttyS0,115200
>	vga=normal
>	rw
>	drbd.minor_count=8
>)
>
>"${kvm[@]}" -append "${append[*]}"
