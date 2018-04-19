Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeDSCgu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:36:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:44521 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeDSCgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:36:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="42999622"
Date: Thu, 19 Apr 2018 10:36:39 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, lkp@01.org
Subject: [dummy_stm_init] swapper/0: page allocation failure: order:9,
 mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Message-ID: <20180419023639.cddsueaq47mohfma@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gxj6wzvssma7hlss"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gxj6wzvssma7hlss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexander,

FYI this happens in mainline kernel 4.17.0-rc1.
It dates back to at least v4.15.

It occurs in 4 out of 4 boots. Here KVM has 1G memory.

This high order allocation caused lots of noises in our boot testing.
We could disable this device in our tests, but it would be great if
there are better ways out.

[   75.039408]       Product name: fake-design-for-testing
[   75.040995] fmc fake-design-for-testing-f001: Driver has no ID: matches all
[   75.042509] fmc_trivial: probe of fake-design-for-testing-f001 failed with error -95
[   75.044323] fmc fake-design-for-testing-f001: Driver has no ID: matches all
[   75.045644] fmc_chardev fake-design-for-testing-f001: Created misc device "fake-design-for-testing-f001"
[   75.061570] swapper/0: page allocation failure: order:9, mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
[   75.063053] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #262
[   75.063338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   75.063338] Call Trace:
[   75.063338]  dump_stack+0x71/0xab:
						dump_stack at lib/dump_stack.c:115
[   75.063338]  warn_alloc+0x180/0x280:
						warn_alloc_show_mem at mm/page_alloc.c:3398
						 (inlined by) warn_alloc at mm/page_alloc.c:3437
[   75.063338]  ? zone_watermark_ok_safe+0x260/0x260:
						warn_alloc at mm/page_alloc.c:3417
[   75.063338]  ? __zone_watermark_ok+0x260/0x260:
						get_page_from_freelist at mm/page_alloc.c:3262
[   75.063338]  ? _cond_resched+0x14/0x30:
						_cond_resched at kernel/sched/core.c:4982
[   75.063338]  __alloc_pages_nodemask+0x1068/0x19a0:
						__alloc_pages_slowpath at mm/page_alloc.c:4293
						 (inlined by) __alloc_pages_nodemask at mm/page_alloc.c:4384
[   75.063338]  ? gfp_pfmemalloc_allowed+0x150/0x150:
						__alloc_pages_nodemask at mm/page_alloc.c:4350
[   75.063338]  ? sched_clock_cpu+0x14f/0x180:
						sched_clock_cpu at kernel/sched/clock.c:362
[   75.063338]  cache_alloc_refill+0x27e/0x770:
						kmem_getpages at mm/slab.c:1412
						 (inlined by) cache_grow_begin at mm/slab.c:2678
						 (inlined by) cache_alloc_refill at mm/slab.c:3045
[   75.063338]  ? lock_acquire+0xd0/0x190:
						get_current at arch/x86/include/asm/current.h:15
						 (inlined by) lock_acquire at kernel/locking/lockdep.c:3922
[   75.063338]  __kmalloc+0x14b/0x180:
						____cache_alloc at mm/slab.c:3127
						 (inlined by) __do_cache_alloc at mm/slab.c:3366
						 (inlined by) slab_alloc at mm/slab.c:3384
						 (inlined by) __do_kmalloc at mm/slab.c:3716
						 (inlined by) __kmalloc at mm/slab.c:3727
[   75.063338]  stm_register_device+0xf3/0x5c0:
						stm_register_device at drivers/hwtracing/stm/core.c:695
[   75.063338]  ? stp_policy_node_put+0x10/0x10:
						dummy_stm_packet at drivers/hwtracing/stm/dummy_stm.c:33
[   75.063338]  dummy_stm_init+0x175/0x2b0:
						dummy_stm_init at drivers/hwtracing/stm/dummy_stm.c:93
[   75.063338]  ? intel_th_pti_lpp_init+0x37/0x37:
						stm_core_init at drivers/hwtracing/stm/core.c:1149
[   75.063338]  ? dummy_stm_exit+0x80/0x80:
						dummy_stm_init at drivers/hwtracing/stm/dummy_stm.c:70
[   75.063338]  do_one_initcall+0xd8/0x1e0:
						do_trace_initcall_finish at init/main.c:867
						 (inlined by) do_one_initcall at init/main.c:884
[   75.063338]  ? start_kernel+0x9c2/0x9c2:
						do_one_initcall at init/main.c:874
[   75.063338]  ? __wake_up_common+0x580/0x580:
						__wake_up_common_lock at kernel/sched/wait.c:109
[   75.063338]  ? lock_downgrade+0x5e0/0x5e0:
						lock_release at kernel/locking/lockdep.c:3929
[   75.063338]  kernel_init_freeable+0x2b6/0x348:
						do_initcall_level at init/main.c:951
						 (inlined by) do_initcalls at init/main.c:959
						 (inlined by) do_basic_setup at init/main.c:977
						 (inlined by) kernel_init_freeable at init/main.c:1127
[   75.063338]  ? rest_init+0x170/0x170:
						kernel_init at init/main.c:1050
[   75.063338]  kernel_init+0xa/0x110:
						kernel_init at init/main.c:1055
[   75.063338]  ? rest_init+0x170/0x170:
						kernel_init at init/main.c:1050
[   75.063338]  ret_from_fork+0x1f/0x30:
						ret_from_fork at arch/x86/entry/entry_64.S:418
[   75.089849] Mem-Info:
[   75.090370] active_anon:0 inactive_anon:0 isolated_anon:0
[   75.090370]  active_file:0 inactive_file:0 isolated_file:0
[   75.090370]  unevictable:123532 dirty:0 writeback:0 unstable:0
[   75.090370]  slab_reclaimable:6653 slab_unreclaimable:10019
[   75.090370]  mapped:0 shmem:0 pagetables:0 bounce:0
[   75.090370]  free:10580 free_pcp:0 free_cma:0
[   75.094750] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:494128kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[   75.097690] DMA free:12232kB min:80kB low:100kB high:120kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:1180kB writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   75.101009] lowmem_reserve[]: 0 588 588 588

Attached the full dmesg, kconfig and reproduce scripts.

Thanks,
Fengguang

--gxj6wzvssma7hlss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-vm-lkp-hsw01-1G-9:20180417231439:x86_64-randconfig-s5-04172210:4.17.0-rc1:262"
Content-Transfer-Encoding: quoted-printable

early console in setup code
early console in extract_kernel
input_data: 0x0000000005fce295
input_len: 0x00000000020fb0c8
output: 0x0000000001000000
output_len: 0x00000000060e0960
kernel_total_size: 0x00000000070ef000
trampoline_32bit: 0x000000000009d000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 4.17.0-rc1 (kbuild@lkp-hsx03) (gcc version 7.3=
=2E0 (Debian 7.3.0-1)) #262 SMP Tue Apr 17 22:20:14 CST 2018
[    0.000000] Command line: ip=3D::::vm-lkp-hsw01-1G-9::dhcp root=3D/dev/r=
am0 user=3Dlkp job=3D/lkp/scheduled/vm-lkp-hsw01-1G-9/trinity-300s-debian-x=
86_64-2016-08-31.cgz-60cc43fc888428bb2f18f08997432d426a243338-20180417-9003=
8-7ko8tn-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-s5-04172210 branc=
h=3Dlinus/master commit=3D60cc43fc888428bb2f18f08997432d426a243338 BOOT_IMA=
GE=3D/pkg/linux/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08=
997432d426a243338/vmlinuz-4.17.0-rc1 max_uptime=3D1500 RESULT_ROOT=3D/resul=
t/trinity/300s/vm-lkp-hsw01-1G/debian-x86_64-2016-08-31.cgz/x86_64-randconf=
ig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/2 LKP_SERVER=
=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeo=
ut=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D=
1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drb=
d.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 ea=
rlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shu=
tdown=3D0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 0=
4/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x3ffe0 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f6a80-0x000f6a8f] mapped at =
[        (ptrval)]
[    0.000000]   mpc: f6a90-f6b74
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [        (ptrval)] 99000 size 24576
[    0.000000] BRK [0x080ca000, 0x080cafff] PGTABLE
[    0.000000] BRK [0x080cb000, 0x080cbfff] PGTABLE
[    0.000000] BRK [0x080cc000, 0x080ccfff] PGTABLE
[    0.000000] BRK [0x080cd000, 0x080cdfff] PGTABLE
[    0.000000] BRK [0x080ce000, 0x080cefff] PGTABLE
[    0.000000] BRK [0x080cf000, 0x080cffff] PGTABLE
[    0.000000] RAMDISK: [mem 0x37246000-0x3ffdffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6870 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000003FFE1628 000030 (v01 BOCHS  BXPCRSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000003FFE147C 000074 (v01 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000003FFE0040 00143C (v01 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000003FFE0000 000040
[    0.000000] ACPI: APIC 0x000000003FFE1570 000080 (v01 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000003FFE15F0 000038 (v01 BOCHS  BXPCHPET 00=
000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] kvm-clock: cpu 0, msr 0:37244001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 310478239 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000003ffdffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000003ffdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003ffdf=
fff]
[    0.000000] On node 0 totalpages: 262014
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3528 pages used for memmap
[    0.000000]   DMA32 zone: 258016 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] kasan: KernelAddressSanitizer initialized
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.000000] e820: [mem 0x40000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:2 nr_cpu_ids:2 nr_n=
ode_ids:1
[    0.000000] percpu: Embedded 500 pages/cpu @        (ptrval) s2019328 r0=
 d28672 u2097152
[    0.000000] pcpu-alloc: s2019328 r0 d28672 u2097152 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 2cfec040
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 258409
[    0.000000] Kernel command line: ip=3D::::vm-lkp-hsw01-1G-9::dhcp root=
=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-lkp-hsw01-1G-9/trinity-300s=
-debian-x86_64-2016-08-31.cgz-60cc43fc888428bb2f18f08997432d426a243338-2018=
0417-90038-7ko8tn-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-s5-04172=
210 branch=3Dlinus/master commit=3D60cc43fc888428bb2f18f08997432d426a243338=
 BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428=
bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1 max_uptime=3D1500 RESULT_ROOT=
=3D/result/trinity/300s/vm-lkp-hsw01-1G/debian-x86_64-2016-08-31.cgz/x86_64=
-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/2 LK=
P_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_sta=
ll_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_=
panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=
=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=
=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw r=
cuperf.shutdow
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 b=
ytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 byte=
s)
[    0.000000] Memory: 618360K/1048056K available (57352K kernel code, 1075=
4K rwdata, 11624K rodata, 3664K init, 20388K bss, 429696K reserved, 0K cma-=
reserved)
[    0.003333] Hierarchical RCU implementation.
[    0.003333] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.003333] 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D2.
[    0.003333] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    0.003333] 	Tasks RCU enabled.
[    0.003333] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.003333] NR_IRQS: 4352, nr_irqs: 56, preallocated irqs: 16
[    0.003333] 	Offload RCU callbacks from CPUs: (none).
[    0.003333] Console: colour VGA+ 80x25
[    0.003333] console [tty0] enabled
[    0.003333] console [ttyS0] enabled
[    0.003333] bootconsole [earlyser0] disabled
[    0.003333] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.003333] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.003333] ... MAX_LOCK_DEPTH:          48
[    0.003333] ... MAX_LOCKDEP_KEYS:        8191
[    0.003333] ... CLASSHASH_SIZE:          4096
[    0.003333] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.003333] ... MAX_LOCKDEP_CHAINS:      65536
[    0.003333] ... CHAINHASH_SIZE:          32768
[    0.003333]  memory used by lock dependency info: 7871 kB
[    0.003333]  per task-struct memory footprint: 2688 bytes
[    0.003333] ------------------------
[    0.003333] | Locking API testsuite:
[    0.003333] ------------------------------------------------------------=
----------------
[    0.003333]                                  | spin |wlock |rlock |mutex=
 | wsem | rsem |
[    0.003333]   ----------------------------------------------------------=
----------------
[    0.003333]                      A-A deadlock:failed|failed|  ok  |faile=
d|failed|failed|failed|
[    0.003333]                  A-B-B-A deadlock:failed|failed|  ok  |faile=
d|failed|failed|failed|
[    0.003333]              A-B-B-C-C-A deadlock:failed|failed|  ok  |faile=
d|failed|failed|failed|
[    0.003333]              A-B-C-A-B-C deadlock:failed|failed|  ok  |faile=
d|failed|failed|failed|
[    0.003333]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |faile=
d|failed|failed|failed|
[    0.003333]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |faile=
d|failed|failed|failed|
[    0.003333]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |faile=
d|failed|failed|failed|
[    0.003333]                     double unlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.003333]                   initialize held:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.003333]   ----------------------------------------------------------=
----------------
[    0.003333]               recursive read-lock:             |  ok  |     =
        |failed|
[    0.003333]            recursive read-lock #2:             |  ok  |     =
        |failed|
[    0.003333]             mixed read-write-lock:             |failed|     =
        |failed|
[    0.003333]             mixed write-read-lock:             |failed|     =
        |failed|
[    0.003333]   mixed read-lock/lock-write ABBA:             |failed|     =
        |failed|
[    0.003333]    mixed read-lock/lock-read ABBA:             |  ok  |     =
        |failed|
[    0.003333]  mixed write-lock/lock-write ABBA:             |failed|     =
        |failed|
[    0.003333]   ----------------------------------------------------------=
----------------
[    0.003333]      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.003333]      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.003333]      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.003333]      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.003333]        sirq-safe-A =3D> hirqs-on/12:failed|failed|  ok  |
[    0.003333]        sirq-safe-A =3D> hirqs-on/21:failed|failed|  ok  |
[    0.003333]          hard-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.003333]          soft-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.003333]          hard-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.003333]          soft-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.003333]     hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.003333]     soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.003333]       hard-irq lock-inversion/123:failed|failed|  ok  |
[    0.003333]       soft-irq lock-inversion/123:failed|failed|  ok  |
[    0.003333]       hard-irq lock-inversion/132:failed|failed|  ok  |
[    0.003333]       soft-irq lock-inversion/132:failed|failed|  ok  |
[    0.003333]       hard-irq lock-inversion/213:failed|failed|  ok  |
[    0.003333]       soft-irq lock-inversion/213:failed|failed|  ok  |
[    0.003333]       hard-irq lock-inversion/231:failed|failed|  ok  |
[    0.003333]       soft-irq lock-inversion/231:failed|failed|  ok  |
[    0.003333]       hard-irq lock-inversion/312:failed|failed|  ok  |
[    0.003333]       soft-irq lock-inversion/312:failed|failed|  ok  |
[    0.003333]       hard-irq lock-inversion/321:failed|failed|  ok  |
[    0.003333]       soft-irq lock-inversion/321:failed|failed|  ok  |
[    0.003333]       hard-irq read-recursion/123:  ok  |
[    0.003333]       soft-irq read-recursion/123:  ok  |
[    0.003333]       hard-irq read-recursion/132:  ok  |
[    0.003333]       soft-irq read-recursion/132:  ok  |
[    0.003333]       hard-irq read-recursion/213:  ok  |
[    0.003333]       soft-irq read-recursion/213:  ok  |
[    0.003333]       hard-irq read-recursion/231:  ok  |
[    0.003333]       soft-irq read-recursion/231:  ok  |
[    0.003333]       hard-irq read-recursion/312:  ok  |
[    0.003333]       soft-irq read-recursion/312:  ok  |
[    0.003333]       hard-irq read-recursion/321:  ok  |
[    0.003333]       soft-irq read-recursion/321:  ok  |
[    0.003333]   ----------------------------------------------------------=
----------------
[    0.003333]   | Wound/wait tests |
[    0.003333]   ---------------------
[    0.003333]                   ww api failures:  ok  |  ok  |  ok  |
[    0.003333]                ww contexts mixing:failed|  ok  |
[    0.003333]              finishing ww context:  ok  |  ok  |  ok  |  ok =
 |
[    0.003333]                locking mismatches:  ok  |  ok  |  ok  |
[    0.003333]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.003333]            spinlock nest unlocked:  ok  |
[    0.003333]   -----------------------------------------------------
[    0.003333]                                  |block | try  |context|
[    0.003333]   -----------------------------------------------------
[    0.003333]                           context:failed|  ok  |  ok  |
[    0.003333]                               try:failed|  ok  |failed|
[    0.003333]                             block:failed|  ok  |failed|
[    0.003333]                          spinlock:failed|  ok  |failed|
[    0.003333] --------------------------------------------------------
[    0.003333] 153 out of 262 testcases failed, as expected. |
[    0.003333] ----------------------------------------------------
[    0.003333] ACPI: Core revision 20180313
[    0.003333] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns
[    0.003333] hpet clockevent registered
[    0.003367] APIC: Switch to symmetric I/O mode setup
[    0.004267] enabled ExtINT on CPU#0
[    0.006684] ENABLING IO-APIC IRQs
[    0.007407] init IO_APIC IRQs
[    0.008037]  apic 0 pin 0 not connected
[    0.008840] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    0.010076] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.011543] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    0.013043] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Ac=
tive:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 =
Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 =
Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    0.013333] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    0.013333]  apic 0 pin 16 not connected
[    0.013333]  apic 0 pin 17 not connected
[    0.013333]  apic 0 pin 18 not connected
[    0.013333]  apic 0 pin 19 not connected
[    0.013333]  apic 0 pin 20 not connected
[    0.013333]  apic 0 pin 21 not connected
[    0.013333]  apic 0 pin 22 not connected
[    0.013333]  apic 0 pin 23 not connected
[    0.013333] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.013333] tsc: Detected 2593.992 MHz processor
[    0.013333] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x25641074d3b, max_idle_ns: 440795244898 ns
[    0.013359] Calibrating delay loop (skipped) preset value.. 5190.15 Bogo=
MIPS (lpj=3D8646640)
[    0.016678] pid_max: default: 32768 minimum: 301
[    0.018474] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.019859] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 b=
ytes)
[    0.024938] CPU: Physical Processor ID: 0
[    0.030018] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.031174] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.032510] Spectre V2 : Spectre mitigation: kernel not compiled with re=
tpoline; no mitigation available!
[    0.032689] debug: unmapping init [mem 0xffffffff86cd4000-0xffffffff86cd=
ffff]
[    0.038337] TSC deadline timer enabled
[    0.039522] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2697 v3 @ 2.60GHz (fa=
mily: 0x6, model: 0x3f, stepping: 0x2)
[    0.039999] Performance Events: Haswell events, Intel PMU driver.
[    0.041136] ... version:                2
[    0.041941] ... bit width:              48
[    0.042751] ... generic registers:      4
[    0.043343] ... value mask:             0000ffffffffffff
[    0.044308] ... max period:             000000007fffffff
[    0.045271] ... fixed-purpose events:   3
[    0.046067] ... event mask:             000000070000000f
[    0.046954] Hierarchical SRCU implementation.
[    0.052556] smp: Bringing up secondary CPUs ...
[    0.054680] x86: Booting SMP configuration:
[    0.055513] .... node  #0, CPUs:      #1
[    0.003333] kvm-clock: cpu 1, msr 0:37244041, secondary cpu clock
[    0.003333] masked ExtINT on CPU#1
[    0.060135] KVM setup async PF for cpu 1
[    0.060855] kvm-stealtime: cpu 1, msr 2d1ec040
[    0.061738] smp: Brought up 1 node, 2 CPUs
[    0.061738] smpboot: Max logical packages: 2
[    0.061738] ----------------
[    0.063356] | NMI testsuite:
[    0.064249] --------------------
[    0.065220]   remote IPI:  ok  |
[    0.066274]    local IPI:  ok  |
[    0.066699] --------------------
[    0.067658] Good, all   2 testcases passed! |
[    0.068774] ---------------------------------
[    0.069710] smpboot: Total of 2 processors activated (10380.30 BogoMIPS)
[    0.071112] devtmpfs: initialized
[    0.071393] x86/mm: Memory block size: 128MB
[    0.082630] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.083356] futex hash table entries: 512 (order: 4, 65536 bytes)
[    0.084515] xor: automatically using best checksumming function   avx   =
   =20
[    0.085542] prandom: seed boundary self test passed
[    0.087459] prandom: 100 self tests passed
[    0.089680] regulator-dummy: no parameters
[    0.091812] NET: Registered protocol family 16
[    0.096091] workqueue: round-robin CPU selection forced, expect performa=
nce impact
[    0.096821] cpuidle: using governor menu
[    0.098499] ACPI: bus type PCI registered
[    0.100356] PCI: Using configuration type 1 for base access
[    0.102404] core: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT=
 off
[    0.140522] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.141985] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.144255] cryptd: max_cpu_qlen set to 1000
[    0.200015] raid6: sse2x1   gen()  5655 MB/s
[    0.256680] raid6: sse2x1   xor()  5595 MB/s
[    0.313351] raid6: sse2x2   gen()  7008 MB/s
[    0.370019] raid6: sse2x2   xor()  4144 MB/s
[    0.426683] raid6: sse2x4   gen()  7416 MB/s
[    0.483351] raid6: sse2x4   xor()  4965 MB/s
[    0.540023] raid6: avx2x1   gen() 10190 MB/s
[    0.596685] raid6: avx2x1   xor()  6367 MB/s
[    0.653352] raid6: avx2x2   gen() 12813 MB/s
[    0.710015] raid6: avx2x2   xor()  8274 MB/s
[    0.766684] raid6: avx2x4   gen() 16068 MB/s
[    0.823350] raid6: avx2x4   xor()  9102 MB/s
[    0.824633] raid6: using algorithm avx2x4 gen() 16068 MB/s
[    0.826036] raid6: .... xor() 9102 MB/s, rmw enabled
[    0.826682] raid6: using avx2x2 recovery algorithm
[    0.828853] gpio-f7188x: Not a Fintek device at 0x0000002e
[    0.830105] gpio-f7188x: Not a Fintek device at 0x0000004e
[    0.833211] ACPI: Added _OSI(Module Device)
[    0.833345] ACPI: Added _OSI(Processor Device)
[    0.834537] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.835716] ACPI: Added _OSI(Processor Aggregator Device)
[    0.836706] ACPI: Added _OSI(Linux-Dell-Video)
[    0.869431] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.882611] ACPI: Interpreter enabled
[    0.890239] ACPI: (supports S0 S3 S5)
[    0.891377] ACPI: Using IOAPIC for interrupt routing
[    0.892937] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.896651] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.974498] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.975933] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.980198] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.981652] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.983960] PCI host bridge to bus 0000:00
[    0.984675] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.985610] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.986558] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.986696] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebffff=
f window]
[    0.988610] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.989967] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.993255] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.998840] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.003136] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    1.004924] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    1.006401] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.006677] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    1.007642] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.010722] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.012076] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI
[    1.013361] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB
[    1.018285] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    1.021235] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    1.030036] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    1.038296] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    1.043640] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    1.046263] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.047806] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.055107] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    1.060304] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
[    1.062823] pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
[    1.069474] pci_bus 0000:00: on NUMA node 0
[    1.078770] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.083284] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.083333] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.083333] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.083333] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.096683] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.096683] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    1.100017] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.101267] vgaarb: loaded
[    1.106315] SCSI subsystem initialized
[    1.107828] pps_core: LinuxPPS API ver. 1 registered
[    1.108997] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.114804] FPGA manager framework
[    1.116967] PCI: Using ACPI for IRQ routing
[    1.117644] PCI: pci_cache_line_size set to 64 bytes
[    1.118486] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.120010] e820: reserve RAM buffer [mem 0x3ffe0000-0x3fffffff]
[    1.121104] Bluetooth: Core ver 2.22
[    1.121804] NET: Registered protocol family 31
[    1.122499] Bluetooth: HCI device and connection manager initialized
[    1.123368] Bluetooth: HCI socket layer initialized
[    1.124117] Bluetooth: L2CAP socket layer initialized
[    1.124945] NET: Registered protocol family 8
[    1.125630] NET: Registered protocol family 20
[    1.126886] nfc: nfc_init: NFC Core ver 0.1
[    1.127690] NET: Registered protocol family 39
[    1.128730] dcdbas dcdbas: Dell Systems Management Base Driver (version =
5.6.0-3.2)
[    1.130515] clocksource: Switched to clocksource kvm-clock
[    1.131853] VFS: Disk quotas dquot_6.6.0
[    1.132602] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.133684] pnp: PnP ACPI init
[    1.134796] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.136597] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.138800] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.140412] pnp 00:03: [dma 2]
[    1.149395] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    1.151582] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.153683] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.155778] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.161539] pnp: PnP ACPI: found 7 devices
[    1.192253] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.194877] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.196367] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.197857] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    1.199439] pci_bus 0000:00: resource 7 [mem 0x40000000-0xfebfffff windo=
w]
[    1.202314] NET: Registered protocol family 2
[    1.205219] tcp_listen_portaddr_hash hash table entries: 512 (order: 3, =
45056 bytes)
[    1.207967] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes)
[    1.209788] TCP bind hash table entries: 8192 (order: 7, 655360 bytes)
[    1.212273] TCP: Hash tables configured (established 8192 bind 8192)
[    1.214152] UDP hash table entries: 512 (order: 4, 98304 bytes)
[    1.215735] UDP-Lite hash table entries: 512 (order: 4, 98304 bytes)
[    1.223324] NET: Registered protocol family 1
[    1.224642] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.226072] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.227526] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.229089] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    1.231395] PCI: CLS 0 bytes, default 64
[    1.233325] Unpacking initramfs...
[    8.746828] debug: unmapping init [mem 0xffff880037246000-0xffff88003ffd=
ffff]
[    8.762311] Scanning for low memory corruption every 60 seconds
[    8.771122] cryptomgr_test (35) used greatest stack depth: 30552 bytes l=
eft
[    8.777954] cryptomgr_test (53) used greatest stack depth: 30384 bytes l=
eft
[    8.796108] spin_lock-torture:--- Start of test [debug]: nwriters_stress=
=3D4 nreaders_stress=3D0 stat_interval=3D60 verbose=3D1 shuffle_interval=3D=
3 stutter=3D5 shutdown_secs=3D0 onoff_interval=3D0 onoff_holdoff=3D0
[    8.799940] spin_lock-torture: Creating torture_shuffle task
[    8.801896] spin_lock-torture: torture_shuffle task started
[    8.802394] spin_lock-torture: Creating torture_stutter task
[    8.805296] spin_lock-torture: Creating lock_torture_writer task
[    8.806779] spin_lock-torture: torture_stutter task started
[    8.808708] spin_lock-torture: Creating lock_torture_writer task
[    8.810094] spin_lock-torture: lock_torture_writer task started
[    8.810189] spin_lock-torture: Creating lock_torture_writer task
[    8.811431] spin_lock-torture: lock_torture_writer task started
[    8.812804] spin_lock-torture: Creating lock_torture_writer task
[    8.813964] spin_lock-torture: lock_torture_writer task started
[    8.817693] spin_lock-torture: Creating lock_torture_stats task
[    8.817700] spin_lock-torture: lock_torture_writer task started
[    8.819913] torture_init_begin: Refusing rcu init: spin_lock running.
[    8.821831] torture_init_begin: One torture test at a time!
[    8.826935] Initialise system trusted keyrings
[    8.828211] Key type blacklist registered
[    8.842403] spin_lock-torture: lock_torture_stats task started
[    8.844873] workingset: timestamp_bits=3D62 max_order=3D18 bucket_order=
=3D0
[    8.850202] zbud: loaded
[    8.858328] DLM installed
[    8.860156] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    8.862891] ntfs: driver 2.1.32 [Flags: R/W].
[    8.864305] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    8.865590] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    8.866952] QNX4 filesystem 0.2.3 registered.
[    8.868194] qnx6: QNX6 filesystem 1.0.0 registered.
[    8.877244] JFS: nTxBlock =3D 4830, nTxLock =3D 38647
[    8.894916] SGI XFS with security attributes, scrub, debug enabled
[    8.899071] NILFS version 2 loaded
[    8.900099] befs: version: 0.9.3
[    8.914318] ocfs2: Registered cluster interface user
[    8.916268] OCFS2 User DLM kernel interface loaded
[    8.921879] gfs2: GFS2 installed
[    8.923765] pstore: using 842 compression
[    8.976330] NET: Registered protocol family 38
[    8.977976] Key type asymmetric registered
[    8.979370] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 248)
[    8.983774] io scheduler noop registered
[    8.984893] io scheduler deadline registered (default)
[    8.986337] io scheduler cfq registered
[    8.987423] io scheduler mq-deadline registered (default)
[    8.989026] io scheduler kyber registered
[    8.990290] io scheduler bfq registered
[    9.315024] String selftests succeeded
[    9.325229] crc32: CRC_LE_BITS =3D 1, CRC_BE BITS =3D 1
[    9.326491] crc32: self tests passed, processed 225944 bytes in 3552547 =
nsec
[    9.332192] crc32c: CRC_LE_BITS =3D 1
[    9.333208] crc32c: self tests passed, processed 225944 bytes in 1999230=
 nsec
[    9.520513] crc32_combine: 8373 self tests passed
[    9.714192] crc32c_combine: 8373 self tests passed
[    9.715811] xz_dec_test: module loaded
[    9.716479] xz_dec_test: Create a device node with 'mknod xz_dec_test c =
247 0' and write .xz files to it.
[    9.719880] gpio_it87: no device
[    9.721797] gpio_winbond: chip ID at 2e is ffff
[    9.723009] gpio_winbond: not an our chip
[    9.724226] gpio_winbond: chip ID at 4e is ffff
[    9.725443] gpio_winbond: not an our chip
[    9.732743] hgafb: HGA card not detected.
[    9.734270] hgafb: probe of hgafb.0 failed with error -22
[    9.737461] ipmi message handler version 39.2
[    9.738627] IPMI System Interface driver.
[    9.740215] ipmi_si: Unable to find any System Interface(s)
[    9.741599] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via =
sys_reboot.
[    9.744786] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    9.752430] ACPI: Power Button [PWRF]
[    9.754015] Warning: Processor Platform Limit event detected, but not ha=
ndled.
[    9.756152] Consider compiling CPUfreq support into your kernel.
[    9.761826] tsc: Refined TSC clocksource calibration: 2593.993 MHz
[    9.763256] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x256=
411d258c, max_idle_ns: 440795337342 ns
[   10.056593] r3964: Philips r3964 Driver $Revision: 1.10 $
[   10.057910] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   10.085122] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   10.110302] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[   10.120034] lp: driver loaded but no devices found
[   10.122752] smapi::smapi_init, ERROR invalid usSmapiID
[   10.123709] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is=
 not available on this machine
[   10.125091] mwave: mwavedd::mwave_init: Error: Failed to initialize boar=
d data
[   10.126324] mwave: mwavedd::mwave_init: Error: Failed to initialize
[   10.127219] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 secon=
ds, margin is 60 seconds).
[   10.128642] drm_mm: Testing DRM range manger (struct drm_mm), with rando=
m_seed=3D0x11bab461 max_iterations=3D8192 max_prime=3D128
[   10.130290] drm_mm: igt_sanitycheck - ok!
[   10.130977] igt_debug 0x0000000000000000-0x0000000000000200: 512: free
[   10.131867] igt_debug 0x0000000000000200-0x0000000000000600: 1024: used
[   10.132759] igt_debug 0x0000000000000600-0x0000000000000a00: 1024: free
[   10.133690] igt_debug 0x0000000000000a00-0x0000000000000e00: 1024: used
[   10.134603] igt_debug 0x0000000000000e00-0x0000000000001000: 512: free
[   10.135488] igt_debug total: 4096, used 2048 free 2048
[   69.609239] Writes:  Total: 9149708  Max/Min: 0/0   Fail: 0=20
[   72.281726] [drm] Initialized vgem 1.0.0 20120112 for virtual device on =
minor 0
[   72.284902] parport_pc 00:04: reported by Plug and Play ACPI
[   72.286011] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
[   72.287450] lp0: using parport0 (interrupt-driven).
[   72.288194] lp0: console ready
[   72.292622] dummy-irq: no IRQ given.  Use irq=3DN
[   72.297572] nfcsim 0.2 initialized
[   72.298861] Uniform Multi-Platform E-IDE driver
[   72.301032] ide_generic: please use "probe_mask=3D0x3f" module parameter=
 for probing all legacy ISA IDE ports
[   72.303581] ide-gd driver 1.18
[   72.305159] Loading iSCSI transport class v2.0-870.
[   72.308011] rdac: device handler registered
[   72.310066] hp_sw: device handler registered
[   72.313403] alua: device handler registered
[   72.314446] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   72.316151] SCSI Media Changer driver v0.25=20
[   72.317730] osd: LOADED open-osd 0.2.1
[   72.326628] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[   72.334571] SSFDC read-only Flash Translation layer
[   72.336026] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[   72.337427] L440GX flash mapping: failed to find PIIX4 ISA bridge, canno=
t continue
[   72.338815] platform physmap-flash.0: failed to claim resource 0: [mem 0=
x08000000-0x07ffffff]
[   72.340649] slram: not enough parameters.
[   72.341570] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[   72.342965] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[   72.344406] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[   72.345826] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[   72.347218] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[   72.348636] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[   72.350065] nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
[   72.350965] nand: Toshiba NAND 128MiB 1,8V 8-bit
[   72.351678] nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB =
size: 16
[   72.352912] flash size: 128 MiB
[   72.353508] page size: 512 bytes
[   72.359073] OOB area size: 16 bytes
[   72.359727] sector size: 16 KiB
[   72.360320] pages number: 262144
[   72.360910] pages per sector: 32
[   72.361494] bus width: 8
[   72.362007] bits in sector size: 14
[   72.362614] bits in page size: 9
[   72.363189] bits in OOB size: 4
[   72.363812] flash size with OOB: 135168 KiB
[   72.364496] page address bytes: 4
[   72.365081] sector address bytes: 3
[   72.365686] options: 0x42
[   72.367992] Scanning device for bad blocks
[   72.410631] Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
[   72.411909] 0x000000000000-0x000008000000 : "NAND simulator partition 0"
[   72.426144] ftl_cs: FTL header not found.
[   72.428949] [nandsim] warning: CONFIG_MTD_PARTITIONED_MASTER must be ena=
bled to expose debugfs stuff
[   72.552874] parport0: AVR Butterfly
[   72.553943] parport0: cannot grant exclusive access for device spi-lm70l=
lp
[   72.554943] spi_lm70llp: spi_lm70llp probe fail, status -12
[   72.556029] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[   72.575937] eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S.=
 Miller (davem@redhat.com)
[   72.579481] MACsec IEEE 802.1AE
[   72.584349] mdio_bus fixed-0: GPIO lookup for consumer reset
[   72.585186] mdio_bus fixed-0: using lookup tables for GPIO lookup
[   72.586048] mdio_bus fixed-0: No GPIO consumer reset found
[   72.586935] libphy: Fixed MDIO Bus: probed
[   72.590695] vcan: Virtual CAN interface driver
[   72.591440] CAN device driver interface
[   72.593056] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[   72.594038] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   74.422442] PCI Interrupt Link [LNKC] enabled at IRQ 11
[   74.797926] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[   74.799369] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[   74.800982] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   74.802260] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   74.803716] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.=
0-k
[   74.805148] igb: Copyright (c) 2007-2014 Intel Corporation.
[   74.806528] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - vers=
ion 5.1.0-k
[   74.808458] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   74.811341] atp.c:v1.09=3Dac 2002/10/01 Donald Becker <becker@scyld.com>
[   74.815257] NET3 PLIP version 2.4-parport gniibe@mri.co.jp
[   74.816506] plip0: Parallel port at 0x378, using IRQ 7.
[   74.817718] PPP generic driver version 2.4.2
[   74.820313] PPP BSD Compression module registered
[   74.821518] PPP MPPE Compression module registered
[   74.822658] NET: Registered protocol family 24
[   74.823799] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=
=3D256).
[   74.825238] CSLIP: code copyright 1989 Regents of the University of Cali=
fornia.
[   74.827128] SLIP linefill/keepalive option.
[   74.828193] hdlc: HDLC support module revision 1.22
[   74.829356] LAPB Ethernet driver version 0.02
[   74.831458] panel: could not claim access to parport0. Aborting.
[   74.833012] panel: panel driver not yet registered
[   74.834552] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[   74.838140] serio: i8042 KBD port at 0x60,0x64 irq 1
[   74.839381] serio: i8042 AUX port at 0x60,0x64 irq 12
[   74.840895] parport0: cannot grant exclusive access for device parkbd
[   74.905063] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[   74.905330] i2c-parport: adapter type unspecified
[   74.911023] serial_ir serial_ir.0: port 03f8 already in use
[   74.912277] serial_ir serial_ir.0: use 'setserial /dev/ttySX uart none'
[   74.913703] serial_ir serial_ir.0: or compile the serial port driver as =
module and
[   74.915612] serial_ir serial_ir.0: make sure this module is loaded first
[   74.917119] serial_ir: probe of serial_ir.0 failed with error -16
[   74.919222] sir_ir: port existence test failed, cannot continue
[   74.920675] pps_ldisc: PPS line discipline registered
[   74.921948] Driver for 1-wire Dallas network protocol.
[   74.923478] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[   74.928272] applesmc: supported laptop not found!
[   74.929408] applesmc: driver init failed (ret=3D-19)!
[   74.935962] pc87360: PC8736x not detected, module not inserted
[   74.939416] Bluetooth: HCI UART driver ver 2.3
[   74.940566] Bluetooth: HCI UART protocol H4 registered
[   74.941752] Bluetooth: HCI UART protocol BCSP registered
[   74.942954] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   74.944295] Bluetooth: HCI UART protocol QCA registered
[   74.945492] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[   74.968108] ISDN subsystem Rev: 1.1.2.3/
[   74.968113] 1.1.2.2/
[   74.969156] 1.1.2.3/
[   74.969931] none/
[   74.970731] 1.1.2.2
[   74.971472]=20
[   74.972973] PPP BSD Compression module registered
[   74.974115] Modular ISDN core version 1.1.29
[   74.978309] NET: Registered protocol family 34
[   74.979462] dss1_divert module successfully installed
[   74.980676] gigaset: Driver for Gigaset 307x (debug build)
[   74.981909] gigaset: ISDN4Linux interface
[   74.983572] sdhci: Secure Digital Host Controller Interface driver
[   74.984915] sdhci: Copyright(c) Pierre Ossman
[   74.986263] sdhci-pltfm: SDHCI platform and OF driver helper
[   74.988388] No PC Engines board detected
[   74.992700] ledtrig-cpu: registered to indicate activity on CPUs
[   74.995142] OPA Virtual Network Driver - v1.0
[   75.000950] hidraw: raw HID events driver (C) Jiri Kosina
[   75.008021] NET: Registered protocol family 4
[   75.009449] comedi: version 0.7.76 - http://www.comedi.org
[   75.012618] FPGA DOWNLOAD --->
[   75.013512] FPGA image file name: xlinx_fpga_firmware.bit
[   75.015163] GPIO INIT FAIL!!
[   75.037234]  fake-fmc-carrier: mezzanine 0
[   75.038329]       Manufacturer: fake-vendor
[   75.039408]       Product name: fake-design-for-testing
[   75.040995] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[   75.042509] fmc_trivial: probe of fake-design-for-testing-f001 failed wi=
th error -95
[   75.044323] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[   75.045644] fmc_chardev fake-design-for-testing-f001: Created misc devic=
e "fake-design-for-testing-f001"
[   75.061570] swapper/0: page allocation failure: order:9, mode:0x14040c0(=
GFP_KERNEL|__GFP_COMP), nodemask=3D(null)
[   75.063053] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #262
[   75.063338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   75.063338] Call Trace:
[   75.063338]  dump_stack+0x71/0xab
[   75.063338]  warn_alloc+0x180/0x280
[   75.063338]  ? zone_watermark_ok_safe+0x260/0x260
[   75.063338]  ? __zone_watermark_ok+0x260/0x260
[   75.063338]  ? _cond_resched+0x14/0x30
[   75.063338]  __alloc_pages_nodemask+0x1068/0x19a0
[   75.063338]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   75.063338]  ? sched_clock_cpu+0x14f/0x180
[   75.063338]  cache_alloc_refill+0x27e/0x770
[   75.063338]  ? lock_acquire+0xd0/0x190
[   75.063338]  __kmalloc+0x14b/0x180
[   75.063338]  stm_register_device+0xf3/0x5c0
[   75.063338]  ? stp_policy_node_put+0x10/0x10
[   75.063338]  dummy_stm_init+0x175/0x2b0
[   75.063338]  ? intel_th_pti_lpp_init+0x37/0x37
[   75.063338]  ? dummy_stm_exit+0x80/0x80
[   75.063338]  do_one_initcall+0xd8/0x1e0
[   75.063338]  ? start_kernel+0x9c2/0x9c2
[   75.063338]  ? __wake_up_common+0x580/0x580
[   75.063338]  ? lock_downgrade+0x5e0/0x5e0
[   75.063338]  kernel_init_freeable+0x2b6/0x348
[   75.063338]  ? rest_init+0x170/0x170
[   75.063338]  kernel_init+0xa/0x110
[   75.063338]  ? rest_init+0x170/0x170
[   75.063338]  ret_from_fork+0x1f/0x30
[   75.089849] Mem-Info:
[   75.090370] active_anon:0 inactive_anon:0 isolated_anon:0
[   75.090370]  active_file:0 inactive_file:0 isolated_file:0
[   75.090370]  unevictable:123532 dirty:0 writeback:0 unstable:0
[   75.090370]  slab_reclaimable:6653 slab_unreclaimable:10019
[   75.090370]  mapped:0 shmem:0 pagetables:0 bounce:0
[   75.090370]  free:10580 free_pcp:0 free_cma:0
[   75.094750] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB ina=
ctive_file:0kB unevictable:494128kB isolated(anon):0kB isolated(file):0kB m=
apped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB unstable:0kB =
all_unreclaimable? no
[   75.097690] DMA free:12232kB min:80kB low:100kB high:120kB active_anon:0=
kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:1180kB w=
ritepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stack:0k=
B pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   75.101009] lowmem_reserve[]: 0 588 588 588
[   75.101700] DMA32 free:30088kB min:3060kB low:3824kB high:4588kB active_=
anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:49=
2948kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB kern=
el_stack:2432kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_c=
ma:0kB
[   75.105101] lowmem_reserve[]: 0 0 0 0
[   75.105734] DMA: 2*4kB (ME) 106*8kB (UM) 111*16kB (UM) 96*32kB (UM) 32*6=
4kB (UM) 3*128kB (UME) 2*256kB (UM) 3*512kB (UME) 2*1024kB (ME) 0*2048kB 0*=
4096kB =3D 12232kB
[   75.107933] DMA32: 24*4kB (U) 20*8kB (UME) 55*16kB (UME) 176*32kB (UME) =
234*64kB (UE) 54*128kB (U) 4*256kB (UE) 0*512kB 1*1024kB (U) 0*2048kB 0*409=
6kB =3D 30704kB
[   75.110042] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   75.111347] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   75.117500] 123546 total pagecache pages
[   75.118150] 0 pages in swap cache
[   75.118738] Swap cache stats: add 0, delete 0, find 0/0
[   75.119496] Free swap  =3D 0kB
[   75.120059] Total swap =3D 0kB
[   75.120629] 262014 pages RAM
[   75.121182] 0 pages HighMem/MovableOnly
[   75.121900] 107424 pages reserved
[   75.126964] pktgen: Packet Generator for packet performance testing. Ver=
sion: 2.75
[   75.130659] IPVS: Registered protocols (SCTP, AH)
[   75.131511] IPVS: Connection hash table configured (size=3D4096, memory=
=3D64Kbytes)
[   75.132736] IPVS: Each connection entry needs 400 bytes at least
[   75.134500] IPVS: ipvs loaded.
[   75.135458] IPVS: [rr] scheduler registered.
[   75.136364] IPVS: [lc] scheduler registered.
[   75.137285] IPVS: [wlc] scheduler registered.
[   75.138312] IPVS: [fo] scheduler registered.
[   75.139423] IPVS: [lblc] scheduler registered.
[   75.140558] IPVS: [dh] scheduler registered.
[   75.141585] IPVS: [sh] scheduler registered.
[   75.142568] IPVS: [nq] scheduler registered.
[   75.143321] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   75.145151] IPv4 over IPsec tunneling driver
[   75.147417] NET: Registered protocol family 10
[   75.150264] Segment Routing with IPv6
[   75.151509] mip6: Mobile IPv6
[   75.153303] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   75.155396] NET: Registered protocol family 15
[   75.156455] NET: Registered protocol family 9
[   75.157226] X25: Linux Version 0.2
[   75.157845] can: controller area network core (rev 20170425 abi 9)
[   75.158842] NET: Registered protocol family 29
[   75.159562] can: raw protocol (rev 20170425)
[   75.160314] can: broadcast manager protocol (rev 20170425 t)
[   75.161150] can: netlink gateway (rev 20170425) max_hops=3D1
[   75.162496] cryptomgr_probe (250) used greatest stack depth: 29288 bytes=
 left
[   75.163738] NET: Registered protocol family 33
[   75.164867] Key type rxrpc registered
[   75.165884] Key type rxrpc_s registered
[   75.173464] NET: Registered protocol family 41
[   75.174550] l2tp_core: L2TP core driver, V2.0
[   75.175516] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   75.176734] l2tp_netlink: L2TP netlink interface
[   75.177972] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   75.179293] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   75.180798] NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet=
 Project Team
[   75.182486] DECnet: Routing cache hash table of 512 buckets, 40Kbytes
[   75.183511] NET: Registered protocol family 12
[   75.184317] NET: Registered protocol family 35
[   75.185130] 8021q: 802.1Q VLAN Support v1.8
[   75.186834] DCCP: Activated CCID 2 (TCP-like)
[   75.187897] sctp: Hash tables configured (bind 32/51)
[   75.188890] tipc: Activated (version 2.0.0)
[   75.189926] NET: Registered protocol family 30
[   75.191736] tipc: Started in single node mode
[   75.193054] NET: Registered protocol family 43
[   75.194507] 9pnet: Installing 9P2000 support
[   75.195372] NET: Registered protocol family 36
[   75.196109] Key type dns_resolver registered
[   75.196864] Key type ceph registered
[   75.197802] libceph: loaded (mon/osd proto 15/24)
[   75.199277] batman_adv: B.A.T.M.A.N. advanced 2018.1 (compatibility vers=
ion 15) loaded
[   75.200637] mpls_gso: MPLS GSO support
[   75.201648] start plist test
[   75.205365] end plist test
[   75.207035] ... APIC ID:      00000000 (0)
[   75.207852] ... APIC VERSION: 01050014
[   75.208500] 000000000000000000000000000000000000000000000000000000000000=
0000
[   75.209472] 000000000000000000000000000000000000000000000000000000000000=
0000
[   75.210054] 000000000000000000000000000000000000000000000000000000000000=
1000
[   75.211461] number of MP IRQ sources: 15.
[   75.212531] number of IO-APIC #0 registers: 24.
[   75.213682] testing the IO APIC.......................
[   75.214975] IO APIC #0......
[   75.215915] .... register #00: 00000000
[   75.216973] .......    : physical APIC id: 00
[   75.218136] .......    : Delivery Type: 0
[   75.219247] .......    : LTS          : 0
[   75.220385] .... register #01: 00170011
[   75.221473] .......     : max redirection entries: 17
[   75.222752] .......     : PRQ implemented: 0
[   75.223925] .......     : IO APIC version: 11
[   75.225097] .... register #02: 00000000
[   75.226194] .......     : arbitration: 00
[   75.227337] .... IRQ redirection table:
[   75.228423] IOAPIC 0:
[   75.229288]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.231411]  pin01, enabled , edge , high, V(22), IRR(0), S(0), logical =
, D(01), M(0)
[   75.233514]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical =
, D(01), M(0)
[   75.235569]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.237633]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.239655]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.241700]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.243276]  pin07, enabled , edge , high, V(21), IRR(0), S(0), logical =
, D(01), M(0)
[   75.244522]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.245757]  pin09, enabled , level, high, V(21), IRR(0), S(0), logical =
, D(02), M(0)
[   75.246998]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.248229]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.249451]  pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical =
, D(02), M(0)
[   75.250695]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.251923]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.253144]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.254396]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.255623]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.256871]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.258119]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.259346]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.260579]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.261818]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.263080]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   75.264315] IRQ to pin mappings:
[   75.264901] IRQ0 -> 0:2
[   75.265408] IRQ1 -> 0:1
[   75.265918] IRQ3 -> 0:3
[   75.266424] IRQ4 -> 0:4
[   75.266973] IRQ5 -> 0:5
[   75.267485] IRQ6 -> 0:6
[   75.267995] IRQ7 -> 0:7
[   75.268502] IRQ8 -> 0:8
[   75.269012] IRQ9 -> 0:9
[   75.269517] IRQ10 -> 0:10
[   75.270057] IRQ11 -> 0:11
[   75.270580] IRQ12 -> 0:12
[   75.271130] IRQ13 -> 0:13
[   75.271652] IRQ14 -> 0:14
[   75.272181] IRQ15 -> 0:15
[   75.272705] .................................... done.
[   75.273557] sched_clock: Marking stable (75273464413, 0)->(76368316643, =
-1094852230)
[   75.276032] Loading compiled-in X.509 certificates
[   75.278797] Btrfs loaded, crc32c=3Dcrc32c-intel, integrity-checker=3Don
[   75.287214] Key type big_key registered
[   75.288253] Key type encrypted registered
[   75.290087] console [netcon0] enabled
[   75.290718] netconsole: network logging started
[   75.291552] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   75.293449] Duplicate name in testcase-data, renamed to "duplicate-name#=
1"
[   75.298700] ### dt-test ### start of unittest - you will see error messa=
ges
[   75.300020] OF: /testcase-data/phandle-tests/consumer-a: could not get #=
phandle-cells-missing for /testcase-data/phandle-tests/provider1
[   75.302279] OF: /testcase-data/phandle-tests/consumer-a: could not get #=
phandle-cells-missing for /testcase-data/phandle-tests/provider1
[   75.305030] OF: /testcase-data/phandle-tests/consumer-a: could not find =
phandle
[   75.306987] OF: /testcase-data/phandle-tests/consumer-a: could not find =
phandle
[   75.309004] OF: /testcase-data/phandle-tests/consumer-a: arguments longe=
r than property
[   75.311136] OF: /testcase-data/phandle-tests/consumer-a: arguments longe=
r than property
[   75.313707] OF: /testcase-data/phandle-tests/consumer-b: could not get #=
phandle-missing-cells for /testcase-data/phandle-tests/provider1
[   75.327064] OF: /testcase-data/phandle-tests/consumer-b: could not find =
phandle
[   75.329052] OF: /testcase-data/phandle-tests/consumer-b: arguments longe=
r than property
[   75.336987] ### dt-test ### end of unittest - 162 passed, 0 failed
[   75.341645] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[   75.343132] 8021q: adding VLAN 0 to HW filter on device bond0
[   75.347977] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   75.350325] 8021q: adding VLAN 0 to HW filter on device eth0
[   75.351733] IP-Config: Failed to open plip0
[   75.353304] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX
[   75.355210] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   75.366723] Sending DHCP requests ., OK
[   75.374418] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0=
=2E2.15
[   75.375866] IP-Config: Complete:
[   75.376796]      device=3Deth0, hwaddr=3D52:54:00:12:34:56, ipaddr=3D10.=
0.2.15, mask=3D255.255.255.0, gw=3D10.0.2.2
[   75.378946]      host=3Dvm-lkp-hsw01-1G-9, domain=3D, nis-domain=3D(none)
[   75.380290]      bootserver=3D10.0.2.2, rootserver=3D10.0.2.2, rootpath=
=3D     nameserver0=3D10.0.2.3
[   75.387314] debug: unmapping init [mem 0xffffffff86940000-0xffffffff86cd=
3fff]
[   75.389040] Write protecting the kernel read-only data: 71680k
[   75.392446] debug: unmapping init [mem 0xffff880004804000-0xffff8800049f=
ffff]
[   75.394123] debug: unmapping init [mem 0xffff88000555a000-0xffff8800055f=
ffff]
[   75.411784] systemd[1]: RTC configured in localtime, applying delta of 4=
80 minutes to system time.

[   75.467752] systemd-getty-g (264) used greatest stack depth: 28520 bytes=
 left
[   75.492908] systemd-debug-g (266) used greatest stack depth: 27816 bytes=
 left
[   75.495785] systemd-hiberna (270) used greatest stack depth: 27520 bytes=
 left
         Mounting Huge Pages File System...
         Mounting Debug File System...
         Mounting POSIX Message Queue File System...
         Starting Remount Root and Kernel File Systems...
         Starting Load Kernel Modules...
         Mounting RPC Pipe File System...
         Starting Create Static Device Nodes in /dev...
         Starting Journal Service...
See 'systemctl status run-rpc_pipefs.mount' for details.
[   75.622629] systemd-tmpfile (282) used greatest stack depth: 27024 bytes=
 left
         Starting udev Kernel Device Manager...
         Mounting Configuration File System...
         Starting Apply Kernel Variables...
         Starting Load/Save Random Seed...
         Starting udev Coldplug all Devices...
         Starting Preprocess NFS configuration...
         Starting Flush Journal to Persistent Storage...
         Starting Create Volatile Files and Directories...
         Starting Network Time Synchronization...
         Starting RPC bind portmap service...
         Starting Update UTMP about System Boot/Shutdown...
[   75.938670] udevadm invoked oom-killer: gfp_mask=3D0x14040c0(GFP_KERNEL|=
__GFP_COMP), nodemask=3D(null), order=3D1, oom_score_adj=3D0
[   75.941240] CPU: 1 PID: 294 Comm: udevadm Not tainted 4.17.0-rc1 #262
[   75.942651] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   75.944711] Call Trace:
[   75.945595]  dump_stack+0x71/0xab
[   75.946554]  dump_header+0x14b/0x8d3
[   75.947681]  ? ___ratelimit+0x1cb/0x410
[   75.948712]  oom_kill_process+0x55f/0xc60
[   75.949815]  ? lock_downgrade+0x5e0/0x5e0
[   75.950870]  ? _raw_spin_unlock+0x1f/0x30
[   75.951974]  ? oom_badness+0x425/0x570
[   75.952992]  out_of_memory+0x214/0xf90
[   75.954045]  ? unregister_oom_notifier+0x10/0x10
[   75.955202]  ? zone_reclaimable_pages+0x240/0x6a0
[   75.956367]  ? mutex_trylock+0x15e/0x190
[   75.957401]  __alloc_pages_nodemask+0xfcd/0x19a0
[   75.958580]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   75.959743]  ? kvm_sched_clock_read+0x21/0x30
[   75.960893]  ? sched_clock+0x5/0x10
[   75.961886]  ? sched_clock_cpu+0x18/0x180
[   75.962976]  cache_alloc_refill+0x27e/0x770
[   75.964070]  ? lock_acquire+0xd0/0x190
[   75.965111]  kmem_cache_alloc+0x10b/0x130
[   75.966165]  getname_flags+0x4a/0x400
[   75.967172]  ? cp_new_stat+0x3ae/0x530
[   75.968205]  user_path_at_empty+0x18/0x30
[   75.969287]  vfs_statx+0xb4/0x130
[   75.970235]  ? __se_sys_newfstat+0xd0/0xd0
[   75.971352]  ? sched_clock_cpu+0x18/0x180
[   75.972405]  __se_sys_newlstat+0x77/0xd0
[   75.973483]  ? __se_sys_newstat+0xd0/0xd0
[   75.974545]  ? up_read+0x17/0x110
[   75.975531]  ? __do_page_fault+0x45d/0x980
[   75.976608]  do_syscall_64+0xed/0x800
[   75.977663]  ? syscall_return_slowpath+0x190/0x190
[   75.978899]  ? mm_fault_error+0x2e0/0x2e0
[   75.979972]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   75.981196] RIP: 0033:0x7f9bcc709a85
[   75.982208] RSP: 002b:00007fffc084da98 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000006
[   75.984191] RAX: ffffffffffffffda RBX: 0000557c73e5c960 RCX: 00007f9bcc7=
09a85
[   75.985685] RDX: 00007fffc084dae0 RSI: 00007fffc084dae0 RDI: 0000557c73e=
5b960
[   75.987231] RBP: 00007fffc084dba0 R08: 0000000000000003 R09: 00000000000=
01011
[   75.988767] R10: 0000000000000063 R11: 0000000000000246 R12: 0000557c73e=
5b960
[   75.990244] R13: 0000557c73e5b968 R14: 00007fffc084dc25 R15: 00007fffc08=
4dc28
[   75.991237] Mem-Info:
[   75.991735] active_anon:1590 inactive_anon:974 isolated_anon:0
[   75.991735]  active_file:0 inactive_file:0 isolated_file:0
[   75.991735]  unevictable:123548 dirty:0 writeback:0 unstable:0
[   75.991735]  slab_reclaimable:7607 slab_unreclaimable:14104
[   75.991735]  mapped:2090 shmem:975 pagetables:152 bounce:0
[   75.991735]  free:1286 free_pcp:182 free_cma:0
[   75.996096] Node 0 active_anon:6360kB inactive_anon:3896kB active_file:0=
kB inactive_file:0kB unevictable:494192kB isolated(anon):0kB isolated(file)=
:0kB mapped:8360kB dirty:0kB writeback:0kB shmem:3900kB writeback_tmp:0kB u=
nstable:0kB all_unreclaimable? yes
[   75.999118] DMA free:2428kB min:80kB low:100kB high:120kB active_anon:11=
20kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:1180kB=
 writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stack:=
32kB pagetables:120kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   76.002438] lowmem_reserve[]: 0 588 588 588
[   76.003117] DMA32 free:2716kB min:3060kB low:3824kB high:4588kB active_a=
non:5136kB inactive_anon:3896kB active_file:0kB inactive_file:0kB unevictab=
le:493012kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:2944kB pagetables:488kB bounce:0kB free_pcp:728kB local_pcp:2=
40kB free_cma:0kB
[   76.006586] lowmem_reserve[]: 0 0 0 0
[   76.007434] DMA: 1*4kB (U) 3*8kB (UME) 2*16kB (UE) 14*32kB (U) 14*64kB (=
UM) 4*128kB (UME) 2*256kB (UM) 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2428kB
[   76.010314] DMA32: 191*4kB (UM) 0*8kB 0*16kB 27*32kB (UM) 17*64kB (UM) 0=
*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2716kB
[   76.012791] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   76.014826] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   76.016586] 124523 total pagecache pages
[   76.017482] 0 pages in swap cache
[   76.018290] Swap cache stats: add 0, delete 0, find 0/0
[   76.019319] Free swap  =3D 0kB
[   76.020083] Total swap =3D 0kB
[   76.020844] 262014 pages RAM
[   76.021594] 0 pages HighMem/MovableOnly
[   76.022455] 107424 pages reserved
[   76.023255] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   76.025025] [  284]     0   284     9987     1121   110592        0     =
        0 systemd-journal
[   76.026852] [  288]     0   288    10417      754   114688        0     =
    -1000 systemd-udevd
[   76.028638] [  294]     0   294     7367     1429   102400        0     =
        0 udevadm
[   76.030378] [  306]   104   306    31279     1017   143360        0     =
        0 systemd-timesyn
[   76.032175] [  307]     0   307    11933      879   131072        0     =
        0 rpcbind
[   76.033899] Out of memory: Kill process 294 (udevadm) score 9 or sacrifi=
ce child
[   76.035528] Killed process 294 (udevadm) total-vm:29468kB, anon-rss:3320=
kB, file-rss:2396kB, shmem-rss:0kB
[   76.037983] oom_reaper: reaped process 294 (udevadm), now anon-rss:0kB, =
file-rss:0kB, shmem-rss:0kB
See 'systemctl status systemd-udev-trigger.service' for details.
         Starting OpenBSD Secure Shell server...
         Starting Permit User Sessions...
         Starting /etc/rc.local Compatibility...
         Starting Login Service...
         Starting LKP bootstrap...
[   76.158205] lkp-bootstrap invoked oom-killer: gfp_mask=3D0x14040c0(GFP_K=
ERNEL|__GFP_COMP), nodemask=3D(null), order=3D1, oom_score_adj=3D0
[   76.158212] CPU: 1 PID: 328 Comm: lkp-bootstrap Not tainted 4.17.0-rc1 #=
262
[   76.158215] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   76.158218] Call Trace:
[   76.158230]  dump_stack+0x71/0xab
[   76.158239]  dump_header+0x14b/0x8d3
[   76.158244]  ? ___ratelimit+0x1cb/0x410
[   76.158249]  oom_kill_process+0x55f/0xc60
[   76.158256]  ? lock_downgrade+0x5e0/0x5e0
[   76.158263]  ? _raw_spin_unlock+0x1f/0x30
[   76.158267]  ? oom_badness+0x425/0x570
[   76.158271]  out_of_memory+0x214/0xf90
[   76.158276]  ? unregister_oom_notifier+0x10/0x10
[   76.158281]  ? zone_reclaimable_pages+0x240/0x6a0
[   76.158285]  ? mutex_trylock+0x15e/0x190
[   76.158290]  __alloc_pages_nodemask+0xfcd/0x19a0
[   76.158294]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   76.158301]  ? kvm_sched_clock_read+0x21/0x30
[   76.158306]  ? sched_clock+0x5/0x10
[   76.158311]  ? sched_clock_cpu+0x18/0x180
[   76.158319]  cache_alloc_refill+0x27e/0x770
[   76.158323]  ? lock_acquire+0xd0/0x190
[   76.158327]  kmem_cache_alloc+0x10b/0x130
[   76.158333]  getname_kernel+0x48/0x2a0
[   76.158337]  open_exec+0x7/0x40
[   76.158343]  load_elf_binary+0xf49/0x2a88
[   76.158347]  ? sched_clock_cpu+0x18/0x180
[   76.158352]  ? elf_core_dump+0x17d0/0x17d0
[   76.158356]  ? search_binary_handler+0xe5/0x220
[   76.158360]  search_binary_handler+0xd6/0x220
[   76.158364]  do_execveat_common+0x1239/0x1ae0
[   76.158368]  ? search_binary_handler+0x220/0x220
[   76.158371]  ? getname_flags+0x88/0x400
[   76.158375]  __x64_sys_execve+0x77/0xa0
[   76.158381]  do_syscall_64+0xed/0x800
[   76.158386]  ? syscall_return_slowpath+0x190/0x190
[   76.158391]  ? mm_fault_error+0x2e0/0x2e0
[   76.158396]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   76.158400] RIP: 0033:0x7fbe701981f7
[   76.158403] RSP: 002b:00007ffc8fa3cd78 EFLAGS: 00000246 ORIG_RAX: 000000=
000000003b
[   76.158408] RAX: ffffffffffffffda RBX: 0000560f794acba0 RCX: 00007fbe701=
981f7
[   76.158411] RDX: 0000560f796e9f58 RSI: 0000560f794acba0 RDI: 0000560f796=
ea0d8
[   76.158414] RBP: 0000560f796ea0d8 R08: 0000000000000410 R09: 00000000000=
00211
[   76.158417] R10: 00007fbe7069e9d0 R11: 0000000000000246 R12: 0000560f796=
e9f58
[   76.158420] R13: 00007ffc8fa3cda8 R14: 0000560f796e9f58 R15: 0000560f794=
acb28
[   76.158423] Mem-Info:
[   76.158432] active_anon:1488 inactive_anon:975 isolated_anon:0
[   76.158432]  active_file:0 inactive_file:0 isolated_file:0
[   76.158432]  unevictable:123548 dirty:0 writeback:0 unstable:0
[   76.158432]  slab_reclaimable:7406 slab_unreclaimable:13839
[   76.158432]  mapped:2912 shmem:977 pagetables:374 bounce:0
[   76.158432]  free:1360 free_pcp:206 free_cma:0
[   76.158439] Node 0 active_anon:5952kB inactive_anon:3900kB active_file:0=
kB inactive_file:0kB unevictable:494192kB isolated(anon):0kB isolated(file)=
:0kB mapped:11648kB dirty:0kB writeback:0kB shmem:3908kB writeback_tmp:0kB =
unstable:0kB all_unreclaimable? yes
[   76.158447] DMA free:2416kB min:80kB low:100kB high:120kB active_anon:10=
80kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:1180kB=
 writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stack:=
288kB pagetables:384kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   76.158448] lowmem_reserve[]: 0 588 588 588
[   76.158464] DMA32 free:3024kB min:3060kB low:3824kB high:4588kB active_a=
non:4920kB inactive_anon:3900kB active_file:0kB inactive_file:0kB unevictab=
le:493012kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3200kB pagetables:1112kB bounce:0kB free_pcp:824kB local_pcp:=
276kB free_cma:0kB
[   76.158466] lowmem_reserve[]: 0 0 0 0
[   76.158476] DMA: 2*4kB (UE) 1*8kB (M) 17*16kB (UME) 8*32kB (U) 15*64kB (=
UM) 3*128kB (UM) 2*256kB (UM) 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2400kB
[   76.158509] DMA32: 46*4kB (U) 2*8kB (UE) 70*16kB (UE) 15*32kB (U) 17*64k=
B (UE) 1*128kB (M) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3016kB
[   76.158531] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   76.158533] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   76.158534] 124525 total pagecache pages
[   76.158537] 0 pages in swap cache
[   76.158538] Swap cache stats: add 0, delete 0, find 0/0
[   76.158539] Free swap  =3D 0kB
[   76.158541] Total swap =3D 0kB
[   76.158543] 262014 pages RAM
[   76.158544] 0 pages HighMem/MovableOnly
[   76.158545] 107424 pages reserved
[   76.158547] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   76.158554] [  284]     0   284     9987     1121   110592        0     =
        0 systemd-journal
[   76.158558] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   76.158561] [  306]   104   306    31279     1017   143360        0     =
        0 systemd-timesyn
[   76.158564] [  307]     0   307    11933      879   131072        0     =
        0 rpcbind
[   76.158568] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   76.158571] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   76.158575] [  315]     0   315     1075      179    53248        0     =
        0 rc.local
[   76.158578] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   76.158581] [  317]     0   317     7002      600   102400        0     =
        0 cron
[   76.158584] [  318]     0   318     1075      200    53248        0     =
        0 lkp-bootstrap
[   76.158587] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   76.158590] [  324]     0   324     3267      254    65536        0     =
        0 mkdir
[   76.158593] [  326]     0   326    10417       97   106496        0     =
        0 systemd-udevd
[   76.158597] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   76.158600] [  328]     0   328     1075       34    53248        0     =
        0 lkp-bootstrap
[   76.158603] [  329]     0   329    10417       97   106496        0     =
        0 systemd-udevd
[   76.158606] [  330]     0   330     1075      186    53248        0     =
        0 lkp-setup-rootf
[   76.158609] [  331]     0   331    10417       97   106496        0     =
        0 systemd-udevd
[   76.158612] [  332]     0   332    10417       97   102400        0     =
    -1000 systemd-udevd
[   76.158615] [  333]     0   333     1075       32    45056        0     =
        0 lkp-setup-rootf
[   76.158618] Out of memory: Kill process 284 (systemd-journal) score 7 or=
 sacrifice child
[   76.158629] Killed process 284 (systemd-journal) total-vm:39948kB, anon-=
rss:500kB, file-rss:3552kB, shmem-rss:432kB
[   76.170505] oom_reaper: reaped process 284 (systemd-journal), now anon-r=
ss:0kB, file-rss:0kB, shmem-rss:432kB
[   76.250976] lkp-setup-rootf invoked oom-killer: gfp_mask=3D0x15080c0(GFP=
_KERNEL_ACCOUNT|__GFP_ZERO), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[   76.250982] CPU: 0 PID: 348 Comm: lkp-setup-rootf Not tainted 4.17.0-rc1=
 #262
[   76.250984] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   76.250986] Call Trace:
[   76.250994]  dump_stack+0x71/0xab
[   76.251000]  dump_header+0x14b/0x8d3
[   76.251004]  ? ___ratelimit+0x1cb/0x410
[   76.251007]  oom_kill_process+0x55f/0xc60
[   76.251011]  ? lock_downgrade+0x5e0/0x5e0
[   76.251016]  ? _raw_spin_unlock+0x1f/0x30
[   76.251018]  ? oom_badness+0x425/0x570
[   76.251021]  out_of_memory+0x214/0xf90
[   76.251024]  ? unregister_oom_notifier+0x10/0x10
[   76.251026]  ? mutex_trylock+0x15e/0x190
[   76.251028]  __alloc_pages_nodemask+0xfcd/0x19a0
[   76.251031]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   76.251034]  ? finish_mkwrite_fault+0x600/0x600
[   76.251037]  ? __handle_mm_fault+0x57a/0x22b0
[   76.251039]  ? __handle_mm_fault+0x105c/0x22b0
[   76.251042]  ? unlock_page+0x50/0x50
[   76.251046]  pte_alloc_one+0x12/0x80
[   76.251049]  __handle_mm_fault+0x1ab4/0x22b0
[   76.251051]  ? vm_iomap_memory+0x160/0x160
[   76.251054]  __do_page_fault+0x439/0x980
[   76.251056]  ? mm_fault_error+0x2e0/0x2e0
[   76.251058]  do_page_fault+0x2a/0x70
[   76.251062]  ? syscall_return_slowpath+0xc9/0x190
[   76.251066]  ? async_page_fault+0x8/0x30
[   76.251068]  async_page_fault+0x1e/0x30
[   76.251071] RIP: 0033:0x7fe309af5e9a
[   76.251073] RSP: 002b:00007fff587bcaa0 EFLAGS: 00010246
[   76.251076] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe309a=
f5e9a
[   76.251078] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   76.251079] RBP: 00007fff587bcad0 R08: 0000000000000000 R09: 00007fe309f=
fc700
[   76.251081] R10: 00007fe309ffc9d0 R11: 0000000000000246 R12: 00000000000=
0014a
[   76.251083] R13: 0000000000000000 R14: 0000000000000000 R15: 00005582443=
445a0
[   76.251084] Mem-Info:
[   76.251090] active_anon:2695 inactive_anon:975 isolated_anon:0
[   76.251090]  active_file:0 inactive_file:0 isolated_file:0
[   76.251090]  unevictable:123548 dirty:0 writeback:0 unstable:0
[   76.251090]  slab_reclaimable:7406 slab_unreclaimable:12862
[   76.251090]  mapped:2980 shmem:977 pagetables:318 bounce:0
[   76.251090]  free:1351 free_pcp:121 free_cma:0
[   76.251094] Node 0 active_anon:10780kB inactive_anon:3900kB active_file:=
0kB inactive_file:0kB unevictable:494192kB isolated(anon):0kB isolated(file=
):0kB mapped:11920kB dirty:0kB writeback:0kB shmem:3908kB writeback_tmp:0kB=
 unstable:0kB all_unreclaimable? yes
[   76.251099] DMA free:2432kB min:80kB low:100kB high:120kB active_anon:24=
60kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:1180kB=
 writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stack:=
128kB pagetables:160kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   76.251100] lowmem_reserve[]: 0 588 588 588
[   76.251109] DMA32 free:2972kB min:3060kB low:3824kB high:4588kB active_a=
non:8252kB inactive_anon:3900kB active_file:0kB inactive_file:0kB unevictab=
le:493012kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3264kB pagetables:1112kB bounce:0kB free_pcp:484kB local_pcp:=
176kB free_cma:0kB
[   76.251110] lowmem_reserve[]: 0 0 0 0
[   76.251116] DMA: 34*4kB (UE) 24*8kB (U) 20*16kB (UME) 36*32kB (U) 10*64k=
B (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2440kB
[   76.251137] DMA32: 1*4kB (M) 31*8kB (U) 128*16kB (U) 22*32kB (UE) 0*64kB=
 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3004kB
[   76.251157] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   76.251159] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   76.251160] 124525 total pagecache pages
[   76.251162] 0 pages in swap cache
[   76.251164] Swap cache stats: add 0, delete 0, find 0/0
[   76.251165] Free swap  =3D 0kB
[   76.251166] Total swap =3D 0kB
[   76.251169] 262014 pages RAM
[   76.251170] 0 pages HighMem/MovableOnly
[   76.251171] 107424 pages reserved
[   76.251173] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   76.251180] [  284]     0   284     9987      108   110592        0     =
        0 systemd-journal
[   76.251184] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   76.251188] [  306]   104   306    31279     1017   143360        0     =
        0 systemd-timesyn
[   76.251192] [  307]     0   307    11933      879   131072        0     =
        0 rpcbind
[   76.251195] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   76.251199] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   76.251203] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   76.251206] [  317]     0   317     7002      600   102400        0     =
        0 cron
[   76.251214] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   76.251218] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   76.251221] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   76.251225] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   76.251228] [  342]     0   342     1480      197    57344        0     =
        0 tail
[   76.251231] [  343]     0   343     5428     1700    90112        0     =
        0 sed
[   76.251235] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   76.251238] [  345]     0   345     4354      651    69632        0     =
        0 sed
[   76.251241] [  348]     0   348     1075       53    45056        0     =
        0 lkp-setup-rootf
[   76.251244] Out of memory: Kill process 343 (sed) score 11 or sacrifice =
child
[   76.251252] Killed process 343 (sed) total-vm:21712kB, anon-rss:4764kB, =
file-rss:2036kB, shmem-rss:0kB
[   76.268934] lkp-setup-rootf invoked oom-killer: gfp_mask=3D0x15080c0(GFP=
_KERNEL_ACCOUNT|__GFP_ZERO), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[   76.409937] CPU: 0 PID: 348 Comm: lkp-setup-rootf Not tainted 4.17.0-rc1=
 #262
[   76.409941] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   76.409943] Call Trace:
[   76.409956]  dump_stack+0x71/0xab
[   76.409965]  dump_header+0x14b/0x8d3
[   76.414307]  ? ___ratelimit+0x1cb/0x410
[   76.414313]  oom_kill_process+0x55f/0xc60
[   76.414319]  ? lock_downgrade+0x5e0/0x5e0
[   76.414327]  ? _raw_spin_unlock+0x1f/0x30
[   76.417986]  ? oom_badness+0x425/0x570
[   76.418815]  out_of_memory+0x214/0xf90
[   76.419641]  ? unregister_oom_notifier+0x10/0x10
[   76.420572]  ? mutex_trylock+0x15e/0x190
[   76.421418]  __alloc_pages_nodemask+0xfcd/0x19a0
[   76.422343]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   76.423273]  ? finish_mkwrite_fault+0x600/0x600
[   76.424197]  ? __handle_mm_fault+0x57a/0x22b0
[   76.425093]  ? __handle_mm_fault+0x105c/0x22b0
[   76.425999]  ? unlock_page+0x50/0x50
[   76.426810]  pte_alloc_one+0x12/0x80
[   76.427615]  __handle_mm_fault+0x1ab4/0x22b0
[   76.428503]  ? vm_iomap_memory+0x160/0x160
[   76.429367]  __do_page_fault+0x439/0x980
[   76.430211]  ? mm_fault_error+0x2e0/0x2e0
[   76.431064]  do_page_fault+0x2a/0x70
[   76.431871]  ? syscall_return_slowpath+0xc9/0x190
[   76.432811]  ? async_page_fault+0x8/0x30
[   76.433664]  async_page_fault+0x1e/0x30
[   76.434506] RIP: 0033:0x7fe309af5e9a
[   76.435310] RSP: 002b:00007fff587bcaa0 EFLAGS: 00010246
[   76.436299] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe309a=
f5e9a
[   76.437519] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   76.438729] RBP: 00007fff587bcad0 R08: 0000000000000000 R09: 00007fe309f=
fc700
[   76.439941] R10: 00007fe309ffc9d0 R11: 0000000000000246 R12: 00000000000=
0014a
[   76.441158] R13: 0000000000000000 R14: 0000000000000000 R15: 00005582443=
445a0
[   76.442419] Mem-Info:
[   76.443087] active_anon:2545 inactive_anon:975 isolated_anon:0
[   76.443087]  active_file:0 inactive_file:0 isolated_file:0
[   76.443087]  unevictable:123548 dirty:0 writeback:0 unstable:0
[   76.443087]  slab_reclaimable:7413 slab_unreclaimable:12864
[   76.443087]  mapped:2825 shmem:978 pagetables:271 bounce:0
[   76.443087]  free:1364 free_pcp:295 free_cma:0
[   76.443094] Node 0 active_anon:10180kB inactive_anon:3900kB active_file:=
0kB inactive_file:0kB unevictable:494192kB isolated(anon):0kB isolated(file=
):0kB mapped:11300kB dirty:0kB writeback:0kB shmem:3912kB writeback_tmp:0kB=
 unstable:0kB all_unreclaimable? yes
[   76.443107] DMA free:2420kB min:80kB low:100kB high:120kB active_anon:24=
80kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:1180kB=
 writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stack:=
128kB pagetables:144kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   76.459643] lowmem_reserve[]: 0 588 588 588
[   76.460822] DMA32 free:3036kB min:3060kB low:3824kB high:4588kB active_a=
non:7708kB inactive_anon:3900kB active_file:0kB inactive_file:0kB unevictab=
le:493012kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3200kB pagetables:940kB bounce:0kB free_pcp:1204kB local_pcp:=
760kB free_cma:0kB
[   76.465767] lowmem_reserve[]: 0 0 0 0
[   76.466863] DMA: 33*4kB (UE) 24*8kB (U) 19*16kB (UE) 36*32kB (U) 10*64kB=
 (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2420kB
[   76.469574] DMA32: 1*4kB (M) 16*8kB (UM) 134*16kB (U) 23*32kB (UE) 1*64k=
B (U) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3076kB
[   76.472154] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   76.474388] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   76.476342] 124526 total pagecache pages
[   76.477274] 0 pages in swap cache
[   76.478287] Swap cache stats: add 0, delete 0, find 0/0
[   76.479576] Free swap  =3D 0kB
[   76.480532] Total swap =3D 0kB
[   76.481478] 262014 pages RAM
[   76.482420] 0 pages HighMem/MovableOnly
[   76.483175] 107424 pages reserved
[   76.484116] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   76.486319] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   76.488557] [  306]   104   306    31279     1017   143360        0     =
        0 systemd-timesyn
[   76.490369] [  307]     0   307    11933      879   131072        0     =
        0 rpcbind
[   76.492534] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   76.494654] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   76.496485] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   76.498637] [  317]     0   317     7002      600   102400        0     =
        0 cron
[   76.500764] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   76.502886] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   76.504876] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   76.507136] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   76.509255] [  342]     0   342     1480      197    57344        0     =
        0 tail
[   76.511050] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   76.513159] [  345]     0   345     5463     1773    77824        0     =
        0 sed
[   76.515261] [  348]     0   348     1075       53    45056        0     =
        0 lkp-setup-rootf
[   76.517101] Out of memory: Kill process 345 (sed) score 11 or sacrifice =
child
[   76.518692] Killed process 345 (sed) total-vm:21852kB, anon-rss:5024kB, =
file-rss:2068kB, shmem-rss:0kB
         Stopping Flush Journal to Persistent Storage...
         Starting Journal Service...
LKP: HOSTNAME vm-lkp-hsw01-1G-9, MAC 52:54:00:12:34:56, kernel 4.17.0-rc1 2=
62, serial console /dev/ttyS0
[   76.600742] lkp-setup-rootf invoked oom-killer: gfp_mask=3D0x15080c0(GFP=
_KERNEL_ACCOUNT|__GFP_ZERO), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[   76.602449] CPU: 0 PID: 365 Comm: lkp-setup-rootf Not tainted 4.17.0-rc1=
 #262
[   76.603391] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   76.604654] Call Trace:
[   76.605163]  dump_stack+0x71/0xab
[   76.605757]  dump_header+0x14b/0x8d3
[   76.606426]  ? ___ratelimit+0x1cb/0x410
[   76.607058]  oom_kill_process+0x55f/0xc60
[   76.607710]  ? lock_downgrade+0x5e0/0x5e0
[   76.608357]  ? _raw_spin_unlock+0x1f/0x30
[   76.609008]  ? oom_badness+0x425/0x570
[   76.609637]  out_of_memory+0x214/0xf90
[   76.610261]  ? unregister_oom_notifier+0x10/0x10
[   76.610971]  ? zone_reclaimable_pages+0x240/0x6a0
[   76.611683]  ? mutex_trylock+0x15e/0x190
[   76.612320]  __alloc_pages_nodemask+0xfcd/0x19a0
[   76.613025]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   76.613739]  ? finish_mkwrite_fault+0x600/0x600
[   76.614437]  ? __handle_mm_fault+0x57a/0x22b0
[   76.615114]  ? __handle_mm_fault+0x105c/0x22b0
[   76.615804]  ? unlock_page+0x50/0x50
[   76.616587]  pte_alloc_one+0x12/0x80
[   76.617399]  __handle_mm_fault+0x1ab4/0x22b0
[   76.618076]  ? vm_iomap_memory+0x160/0x160
[   76.618737]  __do_page_fault+0x439/0x980
[   76.619375]  ? mm_fault_error+0x2e0/0x2e0
[   76.620026]  do_page_fault+0x2a/0x70
[   76.620646]  ? syscall_return_slowpath+0xc9/0x190
[   76.621357]  ? async_page_fault+0x8/0x30
[   76.622000]  async_page_fault+0x1e/0x30
[   76.622635] RIP: 0033:0x7fe309af5e9a
[   76.623241] RSP: 002b:00007fff587bc660 EFLAGS: 00010246
[   76.624004] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe309a=
f5e9a
[   76.624938] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   76.625871] RBP: 00007fff587bc690 R08: 0000000000000000 R09: 00007fe309f=
fc700
[   76.626805] R10: 00007fe309ffc9d0 R11: 0000000000000246 R12: 00000000000=
0014a
[   76.627738] R13: 0000000000000002 R14: 0000000000000000 R15: 00005582443=
47760
[   76.628723] Mem-Info:
[   76.629226] active_anon:1472 inactive_anon:1559 isolated_anon:0
[   76.629226]  active_file:0 inactive_file:0 isolated_file:0
[   76.629226]  unevictable:123547 dirty:0 writeback:0 unstable:0
[   76.629226]  slab_reclaimable:7262 slab_unreclaimable:13457
[   76.629226]  mapped:2812 shmem:1597 pagetables:297 bounce:0
[   76.629226]  free:1347 free_pcp:305 free_cma:0
[   76.633641] Node 0 active_anon:5888kB inactive_anon:6236kB active_file:0=
kB inactive_file:0kB unevictable:494188kB isolated(anon):0kB isolated(file)=
:0kB mapped:11248kB dirty:0kB writeback:0kB shmem:6388kB writeback_tmp:0kB =
unstable:0kB all_unreclaimable? yes
[   76.641572] DMA free:2420kB min:80kB low:100kB high:120kB active_anon:66=
0kB inactive_anon:1632kB active_file:0kB inactive_file:0kB unevictable:1180=
kB writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stac=
k:160kB pagetables:152kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   76.644935] lowmem_reserve[]: 0 588 588 588
[   76.645621] DMA32 free:2968kB min:3060kB low:3824kB high:4588kB active_a=
non:5188kB inactive_anon:4592kB active_file:0kB inactive_file:0kB unevictab=
le:493008kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3200kB pagetables:1036kB bounce:0kB free_pcp:1220kB local_pcp=
:612kB free_cma:0kB
[   76.649121] lowmem_reserve[]: 0 0 0 0
[   76.649755] DMA: 9*4kB (UE) 1*8kB (E) 24*16kB (UM) 36*32kB (UM) 13*64kB =
(UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2412kB
[   76.651419] DMA32: 6*4kB (UE) 2*8kB (E) 89*16kB (U) 31*32kB (UME) 8*64kB=
 (U) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2968kB
[   76.653082] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   76.654391] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   76.655677] 125144 total pagecache pages
[   76.656316] 0 pages in swap cache
[   76.656919] Swap cache stats: add 0, delete 0, find 0/0
[   76.657686] Free swap  =3D 0kB
[   76.658231] Total swap =3D 0kB
[   76.658782] 262014 pages RAM
[   76.659326] 0 pages HighMem/MovableOnly
[   76.659966] 107424 pages reserved
[   76.660569] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   76.661872] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   76.663201] [  306]   104   306    31279     1017   143360        0     =
        0 systemd-timesyn
[   76.664539] [  307]     0   307    11933      879   131072        0     =
        0 rpcbind
[   76.665807] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   76.667055] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   76.668349] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   76.669672] [  317]     0   317     7002      600   102400        0     =
        0 cron
[   76.670913] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   76.672223] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   76.673540] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   76.674866] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   76.676558] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   76.678514] [  357]     0   357     8931      942   106496        0     =
        0 systemd-journal
[   76.680591] [  358]     0   358    13615      288   139264        0     =
        0 (agetty)
[   76.682571] [  365]     0   365     1075       55    45056        0     =
        0 lkp-setup-rootf
[   76.684639] Out of memory: Kill process 306 (systemd-timesyn) score 6 or=
 sacrifice child
[   76.686583] Killed process 306 (systemd-timesyn) total-vm:125116kB, anon=
-rss:488kB, file-rss:3580kB, shmem-rss:0kB
[   76.693605] lkp-setup-rootf invoked oom-killer: gfp_mask=3D0x15080c0(GFP=
_KERNEL_ACCOUNT|__GFP_ZERO), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[   76.695285] CPU: 0 PID: 365 Comm: lkp-setup-rootf Not tainted 4.17.0-rc1=
 #262
[   76.696226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   76.697499] Call Trace:
[   76.698008]  dump_stack+0x71/0xab
[   76.698605]  dump_header+0x14b/0x8d3
[   76.699269]  ? ___ratelimit+0x1cb/0x410
[   76.699905]  oom_kill_process+0x55f/0xc60
[   76.700560]  ? lock_downgrade+0x5e0/0x5e0
[   76.701207]  ? _raw_spin_unlock+0x1f/0x30
[   76.701861]  ? oom_badness+0x425/0x570
[   76.702488]  out_of_memory+0x214/0xf90
[   76.703113]  ? unregister_oom_notifier+0x10/0x10
[   76.703822]  ? zone_reclaimable_pages+0x240/0x6a0
[   76.704541]  ? mutex_trylock+0x15e/0x190
[   76.705179]  __alloc_pages_nodemask+0xfcd/0x19a0
[   76.705885]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   76.706599]  ? finish_mkwrite_fault+0x600/0x600
[   76.707291]  ? __handle_mm_fault+0x57a/0x22b0
[   76.707972]  ? __handle_mm_fault+0x105c/0x22b0
[   76.708662]  ? unlock_page+0x50/0x50
[   76.709269]  pte_alloc_one+0x12/0x80
[   76.709880]  __handle_mm_fault+0x1ab4/0x22b0
[   76.710553]  ? vm_iomap_memory+0x160/0x160
[   76.711206]  __do_page_fault+0x439/0x980
[   76.711864]  ? mm_fault_error+0x2e0/0x2e0
[   76.712516]  do_page_fault+0x2a/0x70
[   76.713125]  ? syscall_return_slowpath+0xc9/0x190
[   76.713840]  ? async_page_fault+0x8/0x30
[   76.714482]  async_page_fault+0x1e/0x30
[   76.715113] RIP: 0033:0x7fe309af5e9a
[   76.715725] RSP: 002b:00007fff587bc660 EFLAGS: 00010246
[   76.716489] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe309a=
f5e9a
[   76.717417] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   76.718350] RBP: 00007fff587bc690 R08: 0000000000000000 R09: 00007fe309f=
fc700
[   76.719285] R10: 00007fe309ffc9d0 R11: 0000000000000246 R12: 00000000000=
0014a
[   76.720220] R13: 0000000000000002 R14: 0000000000000000 R15: 00005582443=
47760
[   76.721204] Mem-Info:
[   76.721713] active_anon:1339 inactive_anon:1763 isolated_anon:0
[   76.721713]  active_file:0 inactive_file:0 isolated_file:0
[   76.721713]  unevictable:123547 dirty:0 writeback:0 unstable:0
[   76.721713]  slab_reclaimable:7264 slab_unreclaimable:13471
[   76.721713]  mapped:2746 shmem:1791 pagetables:267 bounce:0
[   76.721713]  free:1363 free_pcp:285 free_cma:0
[   76.726095] Node 0 active_anon:5356kB inactive_anon:7052kB active_file:0=
kB inactive_file:0kB unevictable:494188kB isolated(anon):0kB isolated(file)=
:0kB mapped:10984kB dirty:0kB writeback:0kB shmem:7164kB writeback_tmp:0kB =
unstable:0kB all_unreclaimable? yes
[   76.729146] DMA free:2428kB min:80kB low:100kB high:120kB active_anon:42=
8kB inactive_anon:1912kB active_file:0kB inactive_file:0kB unevictable:1180=
kB writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stac=
k:160kB pagetables:136kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   76.732510] lowmem_reserve[]: 0 588 588 588
[   76.733193] DMA32 free:3652kB min:3060kB low:3824kB high:4588kB active_a=
non:4956kB inactive_anon:5752kB active_file:0kB inactive_file:0kB unevictab=
le:493008kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3136kB pagetables:932kB bounce:0kB free_pcp:1156kB local_pcp:=
612kB free_cma:0kB
[   76.736703] lowmem_reserve[]: 0 0 0 0
[   76.737336] DMA: 15*4kB (UME) 3*8kB (UME) 24*16kB (UM) 35*32kB (U) 13*64=
kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2420kB
[   76.739027] DMA32: 7*4kB (U) 136*8kB (U) 94*16kB (U) 27*32kB (UM) 2*64kB=
 (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3612kB
[   76.740722] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   76.740725] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   76.740728] 125491 total pagecache pages
[   76.740731] 0 pages in swap cache
[   76.740733] Swap cache stats: add 0, delete 0, find 0/0
[   76.740735] Free swap  =3D 0kB
[   76.740737] Total swap =3D 0kB
[   76.740741] 262014 pages RAM
[   76.750493] 0 pages HighMem/MovableOnly
[   76.751569] 107424 pages reserved
[   76.752577] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   76.752599] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   76.755884] [  307]     0   307    11933      879   131072        0     =
        0 rpcbind
[   76.757232] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   76.758509] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   76.759800] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   76.761162] [  317]     0   317     7002      600   102400        0     =
        0 cron
[   76.762452] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   76.764167] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   76.765522] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   76.766905] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   76.768193] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   76.769424] [  357]     0   357     9898     1010   114688        0     =
        0 systemd-journal
[   76.771115] [  358]     0   358    13615      288   139264        0     =
        0 (agetty)
[   76.772457] [  365]     0   365     1075       55    45056        0     =
        0 lkp-setup-rootf
[   76.773826] [  366]     0   366    13615      288   135168        0     =
        0 systemd
[   76.775141] Out of memory: Kill process 357 (systemd-journal) score 6 or=
 sacrifice child
[   76.776417] Killed process 357 (systemd-journal) total-vm:39592kB, anon-=
rss:448kB, file-rss:3356kB, shmem-rss:236kB
         Starting Flush Journal to Persistent Storage...
[   76.792395] systemd invoked oom-killer: gfp_mask=3D0x14040c0(GFP_KERNEL|=
__GFP_COMP), nodemask=3D(null), order=3D1, oom_score_adj=3D0
[   76.795117] CPU: 1 PID: 1 Comm: systemd Not tainted 4.17.0-rc1 #262
[   76.795985] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   76.803199] Call Trace:
[   76.804020]  dump_stack+0x71/0xab
[   76.804769]  dump_header+0x14b/0x8d3
[   76.805430]  ? ___ratelimit+0x1cb/0x410
[   76.806060]  oom_kill_process+0x55f/0xc60
[   76.806737]  ? lock_downgrade+0x5e0/0x5e0
[   76.807822]  ? _raw_spin_unlock+0x1f/0x30
[   76.808471]  ? oom_badness+0x425/0x570
[   76.809094]  out_of_memory+0x214/0xf90
[   76.809717]  ? unregister_oom_notifier+0x10/0x10
[   76.810752]  ? zone_reclaimable_pages+0x240/0x6a0
[   76.811599]  ? mutex_trylock+0x15e/0x190
[   76.812234]  __alloc_pages_nodemask+0xfcd/0x19a0
[   76.812935]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   76.813906]  ? lock_contended+0xba0/0xba0
[   76.814755]  ? kvm_sched_clock_read+0x21/0x30
[   76.815428]  ? sched_clock+0x5/0x10
[   76.816027]  ? sched_clock_cpu+0x18/0x180
[   76.816678]  cache_alloc_refill+0x27e/0x770
[   76.817804]  ? lock_acquire+0xd0/0x190
[   76.818428]  __kmalloc+0x14b/0x180
[   76.819021]  seq_read+0x6f1/0x1110
[   76.819614]  ? kvm_sched_clock_read+0x21/0x30
[   76.820550]  ? sched_clock_cpu+0x18/0x180
[   76.821407]  ? __fdget_pos+0xac/0xe0
[   76.822015]  ? seq_open+0x1a0/0x1a0
[   76.822616]  ? lock_contended+0xba0/0xba0
[   76.823259]  ? lock_acquire+0xd0/0x190
[   76.824288]  ? __fdget_pos+0xac/0xe0
[   76.824966]  __vfs_read+0xd0/0x650
[   76.825557]  ? __fdget_pos+0xac/0xe0
[   76.826159]  ? do_sendfile+0xba0/0xba0
[   76.826888]  ? __ww_mutex_wakeup_for_backoff+0x230/0x230
[   76.827991]  ? cdev_init+0xa0/0xa0
[   76.828587]  ? lock_downgrade+0x5e0/0x5e0
[   76.829229]  ? lock_acquire+0xd0/0x190
[   76.829851]  ? __fget+0x42/0x220
[   76.830760]  ? __fget+0x1a9/0x220
[   76.831479]  vfs_read+0x100/0x270
[   76.832066]  ksys_read+0xb3/0x180
[   76.832649]  ? kernel_write+0x130/0x130
[   76.833276]  do_syscall_64+0xed/0x800
[   76.834300]  ? syscall_return_slowpath+0x190/0x190
[   76.835080]  ? mm_fault_error+0x2e0/0x2e0
[   76.835727]  ? search_binary_handler+0x220/0x220
[   76.836422]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   76.837546] RIP: 0033:0x7f7d3b15d07d
[   76.838242] RSP: 002b:00007ffd2c7704f0 EFLAGS: 00000293 ORIG_RAX: 000000=
0000000000
[   76.839426] RAX: ffffffffffffffda RBX: 000055fc31244f00 RCX: 00007f7d3b1=
5d07d
[   76.840664] RDX: 0000000000001000 RSI: 000055fc31241290 RDI: 00000000000=
00021
[   76.841760] RBP: 00007ffd2c770c00 R08: 0000000000001110 R09: 00000000000=
01011
[   76.842690] R10: 0000000000000000 R11: 0000000000000293 R12: 000055fc312=
44f00
[   76.843861] R13: 0000000000000000 R14: 00007f7d3b41f420 R15: fffffffffff=
ffe10
[   76.845025] Mem-Info:
[   76.845523] active_anon:1388 inactive_anon:1926 isolated_anon:0
[   76.845523]  active_file:0 inactive_file:0 isolated_file:0
[   76.845523]  unevictable:123547 dirty:0 writeback:0 unstable:0
[   76.845523]  slab_reclaimable:7253 slab_unreclaimable:13211
[   76.845523]  mapped:2727 shmem:1945 pagetables:296 bounce:0
[   76.845523]  free:1367 free_pcp:247 free_cma:0
[   76.850516] Node 0 active_anon:5552kB inactive_anon:7704kB active_file:0=
kB inactive_file:0kB unevictable:494188kB isolated(anon):0kB isolated(file)=
:0kB mapped:10908kB dirty:0kB writeback:0kB shmem:7780kB writeback_tmp:0kB =
unstable:0kB all_unreclaimable? yes
[   76.854193] DMA free:2428kB min:80kB low:100kB high:120kB active_anon:40=
8kB inactive_anon:1932kB active_file:0kB inactive_file:0kB unevictable:1180=
kB writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stac=
k:160kB pagetables:136kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   76.858168] lowmem_reserve[]: 0 588 588 588
[   76.858847] DMA32 free:3040kB min:3060kB low:3824kB high:4588kB active_a=
non:5152kB inactive_anon:5772kB active_file:0kB inactive_file:0kB unevictab=
le:493008kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3232kB pagetables:1048kB bounce:0kB free_pcp:988kB local_pcp:=
592kB free_cma:0kB
[   76.862704] lowmem_reserve[]: 0 0 0 0
[   76.863327] DMA: 21*4kB (UME) 3*8kB (UME) 22*16kB (UM) 35*32kB (U) 13*64=
kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2412kB
[   76.865420] DMA32: 4*4kB (U) 96*8kB (U) 91*16kB (UE) 24*32kB (UE) 0*64kB=
 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3008kB
[   76.867366] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   76.868832] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   76.870199] 125492 total pagecache pages
[   76.871221] 0 pages in swap cache
[   76.871813] Swap cache stats: add 0, delete 0, find 0/0
[   76.872570] Free swap  =3D 0kB
[   76.873109] Total swap =3D 0kB
[   76.873935] 262014 pages RAM
[   76.874681] 0 pages HighMem/MovableOnly
[   76.875309] 107424 pages reserved
[   76.875893] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   76.877642] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   76.879004] [  307]     0   307    11933      879   131072        0     =
        0 rpcbind
[   76.880486] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   76.881951] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   76.883731] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   76.885960] [  317]     0   317     7002      600   102400        0     =
        0 cron
[   76.888096] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   76.890145] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   76.891445] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   76.892758] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   76.894639] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   76.896756] [  358]     0   358    13615      288   139264        0     =
        0 (agetty)
[   76.898906] [  365]     0   365     1075       55    53248        0     =
        0 lkp-setup-rootf
[   76.901150] [  366]     0   366    13615      289   139264        0     =
        0 (urnalctl)
[   76.903321] [  368]     0   368     8902      510   110592        0     =
        0 systemd-cgroups
[   76.905554] Out of memory: Kill process 307 (rpcbind) score 5 or sacrifi=
ce child
[   76.907606] Killed process 307 (rpcbind) total-vm:47732kB, anon-rss:432k=
B, file-rss:3084kB, shmem-rss:0kB
         Starting Journal Service...
[   76.937486] systemd invoked oom-killer: gfp_mask=3D0x14200ca(GFP_HIGHUSE=
R_MOVABLE), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[   76.940216] CPU: 1 PID: 1 Comm: systemd Not tainted 4.17.0-rc1 #262
[   76.941699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   76.943803] Call Trace:
[   76.944661]  dump_stack+0x71/0xab
[   76.945648]  dump_header+0x14b/0x8d3
[   76.946743]  ? ___ratelimit+0x1cb/0x410
[   76.947787]  oom_kill_process+0x55f/0xc60
[   76.948878]  ? lock_downgrade+0x5e0/0x5e0
[   76.949955]  ? _raw_spin_unlock+0x1f/0x30
[   76.951001]  ? oom_badness+0x425/0x570
[   76.952061]  out_of_memory+0x214/0xf90
[   76.953066]  ? unregister_oom_notifier+0x10/0x10
[   76.954253]  ? zone_reclaimable_pages+0x240/0x6a0
[   76.955400]  ? mutex_trylock+0x15e/0x190
[   76.956475]  __alloc_pages_nodemask+0xfcd/0x19a0
[   76.957635]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   76.958809]  ? kvm_sched_clock_read+0x21/0x30
[   76.959941]  ? sched_clock+0x5/0x10
[   76.960929]  ? sched_clock_cpu+0x18/0x180
[   76.962017]  ? kvm_sched_clock_read+0x21/0x30
[   76.963142]  ? sched_clock+0x5/0x10
[   76.964128]  ? sched_clock_cpu+0x18/0x180
[   76.965186]  ? kvm_sched_clock_read+0x21/0x30
[   76.966313]  ? sched_clock+0x5/0x10
[   76.967309]  wp_page_copy+0x130/0x1610
[   76.968358]  do_wp_page+0x3df/0x1870
[   76.969363]  ? finish_mkwrite_fault+0x600/0x600
[   76.970515]  ? __handle_mm_fault+0x57a/0x22b0
[   76.971651]  __handle_mm_fault+0x105c/0x22b0
[   76.972741]  ? vm_iomap_memory+0x160/0x160
[   76.973871]  __do_page_fault+0x439/0x980
[   76.974928]  ? mm_fault_error+0x2e0/0x2e0
[   76.976004]  ? search_binary_handler+0x220/0x220
[   76.977155]  do_page_fault+0x2a/0x70
[   76.978187]  ? async_page_fault+0x8/0x30
[   76.979220]  async_page_fault+0x1e/0x30
[   76.980004] RIP: 0033:0x7f7d3b139fc8
[   76.980608] RSP: 002b:00007ffd2c770bd0 EFLAGS: 00010246
[   76.981357] RAX: 0000000000000001 RBX: 00007ffd2c770bd0 RCX: 00007f7d3b1=
39e9a
[   76.982279] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   76.983201] RBP: 00007ffd2c770c20 R08: 0000000000000001 R09: 00007f7d3cb=
81900
[   76.984123] R10: 00007f7d3cb81bd0 R11: 0000000000000246 R12: 00000000000=
00001
[   76.985067] R13: 0000000000000176 R14: 0000000000000001 R15: 000055fc312=
787e0
[   76.986012] Mem-Info:
[   76.986503] active_anon:1380 inactive_anon:1924 isolated_anon:0
[   76.986503]  active_file:0 inactive_file:0 isolated_file:0
[   76.986503]  unevictable:123548 dirty:0 writeback:0 unstable:0
[   76.986503]  slab_reclaimable:7279 slab_unreclaimable:13273
[   76.986503]  mapped:2697 shmem:1945 pagetables:341 bounce:0
[   76.986503]  free:1367 free_pcp:145 free_cma:0
[   76.995829] Node 0 active_anon:5520kB inactive_anon:7696kB active_file:0=
kB inactive_file:0kB unevictable:494192kB isolated(anon):0kB isolated(file)=
:0kB mapped:10788kB dirty:0kB writeback:0kB shmem:7780kB writeback_tmp:0kB =
unstable:0kB all_unreclaimable? yes
[   76.998851] DMA free:2424kB min:80kB low:100kB high:120kB active_anon:76=
8kB inactive_anon:1928kB active_file:0kB inactive_file:0kB unevictable:1180=
kB writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stac=
k:128kB pagetables:188kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   77.002182] lowmem_reserve[]: 0 588 588 588
[   77.002864] DMA32 free:3044kB min:3060kB low:3824kB high:4588kB active_a=
non:4736kB inactive_anon:5768kB active_file:0kB inactive_file:0kB unevictab=
le:493012kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3232kB pagetables:1176kB bounce:0kB free_pcp:576kB local_pcp:=
336kB free_cma:0kB
[   77.006316] lowmem_reserve[]: 0 0 0 0
[   77.006951] DMA: 10*4kB (UME) 16*8kB (U) 26*16kB (U) 33*32kB (UM) 12*64k=
B (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2408kB
[   77.008622] DMA32: 69*4kB (UME) 56*8kB (UM) 95*16kB (UM) 25*32kB (UE) 0*=
64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3044kB
[   77.010273] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   77.011575] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   77.012845] 125493 total pagecache pages
[   77.013488] 0 pages in swap cache
[   77.014076] Swap cache stats: add 0, delete 0, find 0/0
[   77.014829] Free swap  =3D 0kB
[   77.015370] Total swap =3D 0kB
[   77.015916] 262014 pages RAM
[   77.016455] 0 pages HighMem/MovableOnly
[   77.017096] 107424 pages reserved
[   77.017683] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   77.018969] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   77.020272] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   77.021499] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   77.022778] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   77.024086] [  317]     0   317     7002      600   102400        0     =
        0 cron
[   77.025310] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   77.026603] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   77.027899] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   77.029210] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   77.030447] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   77.031682] [  358]     0   358    13615      288   139264        0     =
        0 (agetty)
[   77.032932] [  366]     0   366     8916      520   110592        0     =
        0 journalctl
[   77.034210] [  367]     0   367     8902      482   110592        0     =
        0 systemd-cgroups
[   77.035551] [  371]     0   371     3675      176    65536        0     =
        0 systemd-cgroups
[   77.037049] [  372]     0   372    34097      297   151552        0     =
        0 (journald)
[   77.038360] [  373]     0   373     1075       55    45056        0     =
        0 lkp-setup-rootf
[   77.039674] [  374]     0   374    34097      297   147456        0     =
        0 systemd
[   77.041630] Out of memory: Kill process 317 (cron) score 4 or sacrifice =
child
[   77.042676] Killed process 317 (cron) total-vm:28008kB, anon-rss:240kB, =
file-rss:2160kB, shmem-rss:0kB
[   77.066748] systemd invoked oom-killer: gfp_mask=3D0x14200ca(GFP_HIGHUSE=
R_MOVABLE), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[   77.068327] CPU: 1 PID: 1 Comm: systemd Not tainted 4.17.0-rc1 #262
[   77.069191] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   77.070467] Call Trace:
[   77.070988]  dump_stack+0x71/0xab
[   77.071577]  dump_header+0x14b/0x8d3
[   77.072254]  ? ___ratelimit+0x1cb/0x410
[   77.072894]  oom_kill_process+0x55f/0xc60
[   77.073546]  ? lock_downgrade+0x5e0/0x5e0
[   77.074200]  ? _raw_spin_unlock+0x1f/0x30
[   77.074848]  ? oom_badness+0x425/0x570
[   77.075469]  out_of_memory+0x214/0xf90
[   77.076095]  ? unregister_oom_notifier+0x10/0x10
[   77.076801]  ? mutex_trylock+0x15e/0x190
[   77.077439]  __alloc_pages_nodemask+0xfcd/0x19a0
[   77.078146]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   77.078867]  ? kvm_sched_clock_read+0x21/0x30
[   77.079545]  ? sched_clock+0x5/0x10
[   77.080149]  ? sched_clock_cpu+0x18/0x180
[   77.080847]  ? kvm_sched_clock_read+0x21/0x30
[   77.081534]  ? sched_clock+0x5/0x10
[   77.082136]  ? sched_clock_cpu+0x18/0x180
[   77.082783]  ? kvm_sched_clock_read+0x21/0x30
[   77.083457]  ? sched_clock+0x5/0x10
[   77.084058]  wp_page_copy+0x130/0x1610
[   77.084682]  do_wp_page+0x3df/0x1870
[   77.085286]  ? finish_mkwrite_fault+0x600/0x600
[   77.085979]  ? __handle_mm_fault+0x57a/0x22b0
[   77.086657]  __handle_mm_fault+0x105c/0x22b0
[   77.087324]  ? vm_iomap_memory+0x160/0x160
[   77.087982]  __do_page_fault+0x439/0x980
[   77.088649]  ? mm_fault_error+0x2e0/0x2e0
[   77.089665]  ? search_binary_handler+0x220/0x220
[   77.090733]  do_page_fault+0x2a/0x70
[   77.091712]  ? async_page_fault+0x8/0x30
[   77.092578]  async_page_fault+0x1e/0x30
[   77.093254] RIP: 0033:0x7f7d3b139fc8
[   77.094238] RSP: 002b:00007ffd2c770bd0 EFLAGS: 00010246
[   77.095008] RAX: 0000000000000001 RBX: 00007ffd2c770bd0 RCX: 00007f7d3b1=
39e9a
[   77.096326] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   77.097584] RBP: 00007ffd2c770c20 R08: 0000000000000001 R09: 00007f7d3cb=
81900
[   77.098866] R10: 00007f7d3cb81bd0 R11: 0000000000000246 R12: 00000000000=
00001
[   77.100469] R13: 0000000000000176 R14: 0000000000000001 R15: 000055fc312=
787e0
[   77.101441] Mem-Info:
[   77.101941] active_anon:1345 inactive_anon:1922 isolated_anon:0
[   77.101941]  active_file:0 inactive_file:0 isolated_file:0
[   77.101941]  unevictable:123548 dirty:0 writeback:0 unstable:0
[   77.101941]  slab_reclaimable:7284 slab_unreclaimable:13288
[   77.101941]  mapped:2685 shmem:1945 pagetables:318 bounce:0
[   77.101941]  free:1363 free_pcp:232 free_cma:0
[   77.106294] Node 0 active_anon:5380kB inactive_anon:7688kB active_file:0=
kB inactive_file:0kB unevictable:494192kB isolated(anon):0kB isolated(file)=
:0kB mapped:10740kB dirty:0kB writeback:0kB shmem:7780kB writeback_tmp:0kB =
unstable:0kB all_unreclaimable? yes
[   77.109309] DMA free:2408kB min:80kB low:100kB high:120kB active_anon:78=
4kB inactive_anon:1924kB active_file:0kB inactive_file:0kB unevictable:1180=
kB writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stac=
k:128kB pagetables:200kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   77.112636] lowmem_reserve[]: 0 588 588 588
[   77.113319] DMA32 free:3044kB min:3060kB low:3824kB high:4588kB active_a=
non:4596kB inactive_anon:5764kB active_file:0kB inactive_file:0kB unevictab=
le:493012kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3200kB pagetables:1072kB bounce:0kB free_pcp:928kB local_pcp:=
336kB free_cma:0kB
[   77.117312] lowmem_reserve[]: 0 0 0 0
[   77.117991] DMA: 10*4kB (UME) 16*8kB (U) 26*16kB (U) 33*32kB (UM) 12*64k=
B (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2408kB
[   77.120469] DMA32: 69*4kB (UME) 56*8kB (UM) 95*16kB (UM) 26*32kB (UE) 0*=
64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3076kB
[   77.122486] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   77.124247] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   77.126064] 125493 total pagecache pages
[   77.126763] 0 pages in swap cache
[   77.127540] Swap cache stats: add 0, delete 0, find 0/0
[   77.128306] Free swap  =3D 0kB
[   77.129990] Total swap =3D 0kB
[   77.130550] 262014 pages RAM
[   77.131317] 0 pages HighMem/MovableOnly
[   77.132124] 107424 pages reserved
[   77.132714] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   77.134037] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   77.135350] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   77.136582] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   77.138120] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   77.140201] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   77.141762] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   77.143162] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   77.144491] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   77.145745] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   77.146985] [  358]     0   358    13615      288   139264        0     =
        0 (agetty)
[   77.148254] [  366]     0   366     8916      520   110592        0     =
        0 journalctl
[   77.149532] [  367]     0   367     8902      482   110592        0     =
        0 systemd-cgroups
[   77.150855] [  371]     0   371     3675      176    65536        0     =
        0 systemd-cgroups
[   77.152178] [  372]     0   372    34097      297   151552        0     =
        0 (journald)
[   77.158761] [  373]     0   373     1075       55    45056        0     =
        0 lkp-setup-rootf
[   77.160542] [  374]     0   374    34097      297   147456        0     =
        0 systemd
[   77.161980] Out of memory: Kill process 366 (journalctl) score 3 or sacr=
ifice child
[   77.163232] Killed process 366 (journalctl) total-vm:35664kB, anon-rss:3=
64kB, file-rss:1716kB, shmem-rss:0kB
[   77.185020] systemd invoked oom-killer: gfp_mask=3D0x14200ca(GFP_HIGHUSE=
R_MOVABLE), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[   77.186601] CPU: 1 PID: 1 Comm: systemd Not tainted 4.17.0-rc1 #262
[   77.187913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   77.189752] Call Trace:
[   77.190361]  dump_stack+0x71/0xab
[   77.191252]  dump_header+0x14b/0x8d3
[   77.191923]  ? ___ratelimit+0x1cb/0x410
[   77.192554]  oom_kill_process+0x55f/0xc60
[   77.193206]  ? lock_downgrade+0x5e0/0x5e0
[   77.193855]  ? _raw_spin_unlock+0x1f/0x30
[   77.194566]  ? oom_badness+0x425/0x570
[   77.195196]  out_of_memory+0x214/0xf90
[   77.195825]  ? unregister_oom_notifier+0x10/0x10
[   77.196525]  ? mutex_trylock+0x15e/0x190
[   77.197167]  __alloc_pages_nodemask+0xfcd/0x19a0
[   77.197873]  ? gfp_pfmemalloc_allowed+0x150/0x150
[   77.198585]  ? kvm_sched_clock_read+0x21/0x30
[   77.199269]  ? sched_clock+0x5/0x10
[   77.199871]  ? sched_clock_cpu+0x18/0x180
[   77.200517]  ? kvm_sched_clock_read+0x21/0x30
[   77.201320]  ? sched_clock+0x5/0x10
[   77.202147]  ? sched_clock_cpu+0x18/0x180
[   77.202799]  ? kvm_sched_clock_read+0x21/0x30
[   77.203472]  ? sched_clock+0x5/0x10
[   77.204074]  wp_page_copy+0x130/0x1610
[   77.204697]  do_wp_page+0x3df/0x1870
[   77.205299]  ? finish_mkwrite_fault+0x600/0x600
[   77.205992]  ? __handle_mm_fault+0x57a/0x22b0
[   77.206664]  __handle_mm_fault+0x105c/0x22b0
[   77.207336]  ? vm_iomap_memory+0x160/0x160
[   77.207990]  __do_page_fault+0x439/0x980
[   77.208623]  ? mm_fault_error+0x2e0/0x2e0
[   77.209271]  ? search_binary_handler+0x220/0x220
[   77.209973]  do_page_fault+0x2a/0x70
[   77.210600]  ? async_page_fault+0x8/0x30
[   77.211246]  async_page_fault+0x1e/0x30
[   77.211876] RIP: 0033:0x7f7d3b139fc8
[   77.212479] RSP: 002b:00007ffd2c770bd0 EFLAGS: 00010246
[   77.213235] RAX: 0000000000000001 RBX: 00007ffd2c770bd0 RCX: 00007f7d3b1=
39e9a
[   77.214163] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   77.215091] RBP: 00007ffd2c770c20 R08: 0000000000000001 R09: 00007f7d3cb=
81900
[   77.216023] R10: 00007f7d3cb81bd0 R11: 0000000000000246 R12: 00000000000=
00001
[   77.216952] R13: 0000000000000176 R14: 0000000000000001 R15: 000055fc312=
787e0
[   77.217911] Mem-Info:
[   77.218408] active_anon:1260 inactive_anon:1922 isolated_anon:0
[   77.218408]  active_file:0 inactive_file:0 isolated_file:0
[   77.218408]  unevictable:123548 dirty:0 writeback:0 unstable:0
[   77.218408]  slab_reclaimable:7284 slab_unreclaimable:13288
[   77.218408]  mapped:2685 shmem:1945 pagetables:293 bounce:0
[   77.218408]  free:1367 free_pcp:325 free_cma:0
[   77.222789] Node 0 active_anon:5040kB inactive_anon:7688kB active_file:0=
kB inactive_file:0kB unevictable:494192kB isolated(anon):0kB isolated(file)=
:0kB mapped:10740kB dirty:0kB writeback:0kB shmem:7780kB writeback_tmp:0kB =
unstable:0kB all_unreclaimable? yes
[   77.225812] DMA free:2424kB min:80kB low:100kB high:120kB active_anon:68=
4kB inactive_anon:1924kB active_file:0kB inactive_file:0kB unevictable:1180=
kB writepending:0kB present:15992kB managed:15904kB mlocked:0kB kernel_stac=
k:160kB pagetables:200kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   77.229146] lowmem_reserve[]: 0 588 588 588
[   77.229827] DMA32 free:3044kB min:3060kB low:3824kB high:4588kB active_a=
non:4324kB inactive_anon:5764kB active_file:0kB inactive_file:0kB unevictab=
le:493012kB writepending:0kB present:1032064kB managed:602456kB mlocked:0kB=
 kernel_stack:3168kB pagetables:972kB bounce:0kB free_pcp:1300kB local_pcp:=
708kB free_cma:0kB
[   77.233895] lowmem_reserve[]: 0 0 0 0
[   77.234522] DMA: 12*4kB (UME) 13*8kB (U) 26*16kB (U) 34*32kB (UM) 12*64k=
B (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2424kB
[   77.236197] DMA32: 69*4kB (UME) 56*8kB (UM) 95*16kB (UM) 27*32kB (UE) 0*=
64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 3108kB
[   77.237855] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   77.239151] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   77.240431] 125493 total pagecache pages
[   77.241076] 0 pages in swap cache
[   77.241655] Swap cache stats: add 0, delete 0, find 0/0
[   77.242410] Free swap  =3D 0kB
[   77.242953] Total swap =3D 0kB
[   77.243503] 262014 pages RAM
[   77.244051] 0 pages HighMem/MovableOnly
[   77.244676] 107424 pages reserved
[   77.245262] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapent=
s oom_score_adj name
[   77.246547] [  288]     0   288    10417      767   114688        0     =
    -1000 systemd-udevd
[   77.247846] [  312]     0   312    16955     1412   167936        0     =
    -1000 sshd
[   77.249159] [  313]   101   313    10747      935   135168        0     =
     -900 dbus-daemon
[   77.250459] [  316]     0   316     8952      517   110592        0     =
        0 systemd-logind
[   77.251863] [  319]     0   319     1075      190    49152        0     =
        0 lkp-bootstrap
[   77.254044] [  327]     0   327     1075       33    53248        0     =
        0 lkp-bootstrap
[   77.256234] [  330]     0   330     1075      405    53248        0     =
        0 lkp-setup-rootf
[   77.258499] [  334]     0   334     1053      165    53248        0     =
        0 sleep
[   77.260645] [  344]     0   344     1480      182    53248        0     =
        0 tail
[   77.262739] [  358]     0   358    13615      288   139264        0     =
        0 (agetty)
[   77.264837] [  367]     0   367     8902      482   110592        0     =
        0 systemd-cgroups
[   77.267099] [  371]     0   371     5008      203    73728        0     =
        0 systemd-cgroups
[   77.269325] [  372]     0   372    34097      297   151552        0     =
        0 (journald)
[   77.271461] [  373]     0   373     1075       55    45056        0     =
        0 lkp-setup-rootf
[   77.273668] [  374]     0   374    34097      297   147456        0     =
        0 systemd
[   77.275789] Out of memory: Kill process 316 (systemd-logind) score 3 or =
sacrifice child
[   77.277852] Killed process 316 (systemd-logind) total-vm:35808kB, anon-r=
ss:380kB, file-rss:1688kB, shmem-rss:0kB
[   77.285047] systemd-logind (316) used greatest stack depth: 26816 bytes =
left
[   77.311941] Out of memory: Kill process 372 (systemd-journal) score 6 or=
 sacrifice child
[   77.313993] Killed process 372 (systemd-journal) total-vm:35724kB, anon-=
rss:424kB, file-rss:3324kB, shmem-rss:0kB
         Starting Network Time Synchronization...
See 'systemctl status systemd-journal-flush.service' for details.
See 'systemctl status systemd-journald.service' for details.
[   77.352364] Out of memory: Kill process 374 ((imesyncd)) score 5 or sacr=
ifice child
[   77.353631] Killed process 374 ((imesyncd)) total-vm:136388kB, anon-rss:=
1160kB, file-rss:2236kB, shmem-rss:0kB
         Starting Login Service...
[   77.377233] Out of memory: Kill process 373 (dpkg) score 5 or sacrifice =
child
[   77.378215] Killed process 380 (dpkg-deb) total-vm:16780kB, anon-rss:128=
kB, file-rss:944kB, shmem-rss:0kB
         Starting Journal Service...
[   77.392978] Out of memory: Kill process 373 (dpkg) score 5 or sacrifice =
child
[   77.394769] Killed process 385 (rm) total-vm:5916kB, anon-rss:76kB, file=
-rss:652kB, shmem-rss:0kB
[   77.397620] oom_reaper: reaped process 385 (rm), now anon-rss:0kB, file-=
rss:0kB, shmem-rss:0kB
[   77.399768] Out of memory: Kill process 373 (dpkg) score 5 or sacrifice =
child
[   77.401321] Killed process 373 (dpkg) total-vm:26200kB, anon-rss:940kB, =
file-rss:2428kB, shmem-rss:0kB
[   77.423976] Out of memory: Kill process 387 (systemd-cgroups) score 3 or=
 sacrifice child
[   77.425252] Killed process 387 (systemd-cgroups) total-vm:35608kB, anon-=
rss:364kB, file-rss:1468kB, shmem-rss:0kB
[   77.508337] Out of memory: Kill process 384 (systemd-logind) score 3 or =
sacrifice child
[   77.510349] Killed process 384 (systemd-logind) total-vm:35808kB, anon-r=
ss:380kB, file-rss:1716kB, shmem-rss:0kB
[   77.522564] Out of memory: Kill process 386 (systemd-journal) score 6 or=
 sacrifice child
[   77.524849] Killed process 386 (systemd-journal) total-vm:35724kB, anon-=
rss:420kB, file-rss:3348kB, shmem-rss:0kB
         Starting RPC bind portmap service...
See 'systemctl status systemd-timesyncd.service' for details.
See 'systemctl status systemd-logind.service' for details.
[   77.568626] Out of memory: Kill process 393 (rpcbind) score 5 or sacrifi=
ce child
[   77.570597] Killed process 393 (rpcbind) total-vm:47732kB, anon-rss:428k=
B, file-rss:3008kB, shmem-rss:0kB
[   77.591014] Out of memory: Kill process 392 (dpkg) score 5 or sacrifice =
child
[   77.592053] Killed process 396 (dpkg-split) total-vm:4kB, anon-rss:4kB, =
file-rss:0kB, shmem-rss:0kB
See 'systemctl status systemd-journald.service' for details.
See 'systemctl status rpcbind.service' for details.
         Starting Network Time Synchronization...
         Starting Journal Service...
[   77.635051] Out of memory: Kill process 402 ((journald)) score 6 or sacr=
ifice child
[   77.637049] Killed process 402 ((journald)) total-vm:136388kB, anon-rss:=
1160kB, file-rss:2412kB, shmem-rss:0kB
         Starting Login Service...
[   77.645520] Out of memory: Kill process 401 ((imesyncd)) score 5 or sacr=
ifice child
[   77.646772] Killed process 401 ((imesyncd)) total-vm:136388kB, anon-rss:=
1160kB, file-rss:2236kB, shmem-rss:0kB
[   77.660182] Out of memory: Kill process 330 (lkp-setup-rootf) score 2 or=
 sacrifice child
[   77.662175] Killed process 400 (ldconfig) total-vm:2948kB, anon-rss:164k=
B, file-rss:1048kB, shmem-rss:0kB
See 'systemctl status systemd-journald.service' for details.
[   77.677242] Out of memory: Kill process 330 (lkp-setup-rootf) score 2 or=
 sacrifice child
[   77.684700] Killed process 406 (lkp-setup-rootf) total-vm:4412kB, anon-r=
ss:236kB, file-rss:0kB, shmem-rss:0kB
See 'systemctl status systemd-timesyncd.service' for details.
See 'systemctl status systemd-journald.service' for details.
[   77.712113] Out of memory: Kill process 403 (systemd-logind) score 3 or =
sacrifice child
[   77.714319] Killed process 403 (systemd-logind) total-vm:35808kB, anon-r=
ss:384kB, file-rss:1720kB, shmem-rss:0kB
[   77.727912] Out of memory: Kill process 330 (lkp-setup-rootf) score 2 or=
 sacrifice child
[   77.730303] Killed process 330 (lkp-setup-rootf) total-vm:4412kB, anon-r=
ss:236kB, file-rss:1472kB, shmem-rss:0kB
         Starting Network Time Synchronization...
See 'systemctl status systemd-logind.service' for details.
         Starting Login Service...
         Starting RPC bind portmap service...
[   77.769649] Out of memory: Kill process 415 ((imesyncd)) score 5 or sacr=
ifice child
[   77.771855] Killed process 415 ((imesyncd)) total-vm:136388kB, anon-rss:=
1160kB, file-rss:2236kB, shmem-rss:0kB
[   77.783843] Out of memory: Kill process 417 (rpcbind) score 2 or sacrifi=
ce child
[   77.785068] Killed process 417 (rpcbind) total-vm:45492kB, anon-rss:224k=
B, file-rss:1292kB, shmem-rss:0kB
See 'systemctl status rpcbind.service' for details.
See 'systemctl status systemd-timesyncd.service' for details.
         Starting Network Time Synchronization...
[   77.819257] Out of memory: Kill process 416 (systemd-logind) score 3 or =
sacrifice child
[   77.820557] Killed process 416 (systemd-logind) total-vm:35808kB, anon-r=
ss:380kB, file-rss:1760kB, shmem-rss:0kB
[   77.827693] Out of memory: Kill process 422 ((imesyncd)) score 2 or sacr=
ifice child
[   77.829486] Killed process 422 ((imesyncd)) total-vm:136388kB, anon-rss:=
1160kB, file-rss:28kB, shmem-rss:0kB
         Starting Login Service...
See 'systemctl status systemd-timesyncd.service' for details.
         Starting RPC bind portmap service...
[   78.112950] Out of memory: Kill process 425 (systemd-logind) score 3 or =
sacrifice child
[   78.116987] Killed process 425 (systemd-logind) total-vm:35808kB, anon-r=
ss:380kB, file-rss:1720kB, shmem-rss:0kB
See 'systemctl status systemd-logind.service' for details.

Elapsed time: 80

#!/bin/bash

# To reproduce,
# 1) save job-script and this script (both are attached in 0day report emai=
l)
# 2) run this script with your compiled kernel and optional env $INSTALL_MO=
D_PATH

kernel=3D$1

initrds=3D(
	/osimage/debian/debian-x86_64-2016-08-31.cgz
	/lkp/lkp/lkp-x86_64.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2017-12-14.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz
	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-x86_64-6ddabfd2_2017-11-=
10.cgz
)

HTTP_PREFIX=3Dhttps://github.com/0day-ci/lkp-qemu/raw/master
wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"

{
	cat "${initrds[@]//*\//}"
	[[ $INSTALL_MOD_PATH ]] && (
		cd "$INSTALL_MOD_PATH"
		find lib | cpio -o -H newc --quiet | gzip
	)
	echo  job-script | cpio -o -H newc --quiet | gzip
} > initrd.img

kvm=3D(
	qemu-system-x86_64
	-enable-kvm
	-cpu host
	-kernel $kernel
	-initrd initrd.img
	-m 1024
	-smp 2
	-device e1000,netdev=3Dnet0
	-netdev user,id=3Dnet0
	-boot order=3Dnc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=3Dlocaltime
	-serial stdio
	-display none
	-monitor null
)

append=3D(
	ip=3D::::vm-lkp-hsw01-1G-9::dhcp
	root=3D/dev/ram0
	user=3Dlkp
	job=3D/job-script
	ARCH=3Dx86_64
	kconfig=3Dx86_64-randconfig-s5-04172210
	branch=3Dlinus/master
	commit=3D60cc43fc888428bb2f18f08997432d426a243338
	BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428=
bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1
	max_uptime=3D1500
	RESULT_ROOT=3D/result/trinity/300s/vm-lkp-hsw01-1G/debian-x86_64-2016-08-3=
1.cgz/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426=
a243338/2
	result_service=3Dtmpfs
	debug
	apic=3Ddebug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=3D100
	net.ifnames=3D0
	printk.devkmsg=3Don
	panic=3D-1
	softlockup_panic=3D1
	nmi_watchdog=3Dpanic
	oops=3Dpanic
	load_ramdisk=3D2
	prompt_ramdisk=3D0
	drbd.minor_count=3D8
	systemd.log_level=3Derr
	ignore_loglevel
	console=3Dtty0
	earlyprintk=3DttyS0,115200
	console=3DttyS0,115200
	vga=3Dnormal
	rw
	rcuperf.shutdown=3D0
)

"${kvm[@]}" -append "${append[*]}"

--gxj6wzvssma7hlss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.17.0-rc1 Kernel Configuration
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
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
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
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
CONFIG_RCU_NOCB_CPU=y
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
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
# CONFIG_NET_NS is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_PROFILING is not set
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
CONFIG_CC_STACKPROTECTOR_STRONG=y
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
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_ISA_BUS_API=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
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
# CONFIG_GCOV_PROFILE_ALL is not set
# CONFIG_GCOV_FORMAT_AUTODETECT is not set
# CONFIG_GCOV_FORMAT_3_4 is not set
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
CONFIG_ACORN_PARTITION_POWERTEC=y
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
CONFIG_PADATA=y
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
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
# CONFIG_INTEL_RDT is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
# CONFIG_SPARSEMEM_VMEMMAP is not set
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
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
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
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
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
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
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
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
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCIE_CADENCE_EP is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_SMC=y
CONFIG_SMC_DIAG=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_ESP_OFFLOAD=y
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_BEET=y
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
CONFIG_IPV6_FOU=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=y
# CONFIG_NF_LOG_NETDEV is not set
# CONFIG_NF_CONNTRACK_SECMARK is not set
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
CONFIG_NF_CONNTRACK_BROADCAST=y
CONFIG_NF_CONNTRACK_NETBIOS_NS=y
# CONFIG_NF_CONNTRACK_SIP is not set
CONFIG_NF_CT_NETLINK=y
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_IP_SET is not set
CONFIG_IP_VS=y
CONFIG_IP_VS_IPV6=y
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
# CONFIG_IP_VS_PROTO_UDP is not set
CONFIG_IP_VS_PROTO_AH_ESP=y
# CONFIG_IP_VS_PROTO_ESP is not set
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=y
# CONFIG_IP_VS_WRR is not set
CONFIG_IP_VS_LC=y
CONFIG_IP_VS_WLC=y
CONFIG_IP_VS_FO=y
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=y
# CONFIG_IP_VS_LBLCR is not set
CONFIG_IP_VS_DH=y
CONFIG_IP_VS_SH=y
# CONFIG_IP_VS_SED is not set
CONFIG_IP_VS_NQ=y

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#
CONFIG_IP_VS_NFCT=y

#
# IP: Netfilter Configuration
#
# CONFIG_NF_CONNTRACK_IPV4 is not set
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
CONFIG_NF_LOG_ARP=y
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
# CONFIG_IP_NF_TARGET_REJECT is not set
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_CONNTRACK_IPV6=y
CONFIG_NF_SOCKET_IPV6=y
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_REJECT=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_RAW=y
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
# CONFIG_IP_DCCP_CCID3 is not set

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_IB=y
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_DIAG=y
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
CONFIG_L2TP=y
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=y
CONFIG_L2TP_ETH=y
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=y
CONFIG_NET_DSA_LEGACY=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_KSZ=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_TRAILER=y
CONFIG_NET_DSA_TAG_QCA=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_6LOWPAN=y
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=y
# CONFIG_6LOWPAN_NHC_DEST is not set
CONFIG_6LOWPAN_NHC_FRAGMENT=y
CONFIG_6LOWPAN_NHC_HOP=y
CONFIG_6LOWPAN_NHC_IPV6=y
CONFIG_6LOWPAN_NHC_MOBILITY=y
CONFIG_6LOWPAN_NHC_ROUTING=y
CONFIG_6LOWPAN_NHC_UDP=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=y
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=y
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
# CONFIG_IEEE802154_6LOWPAN is not set
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUGFS=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
CONFIG_MPLS_IPTUNNEL=y
# CONFIG_NET_NSH is not set
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=y
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
# CONFIG_CAN_CALC_BITTIMING is not set
# CONFIG_CAN_LEDS is not set
CONFIG_CAN_GRCAN=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_IFI_CANFD=y
CONFIG_CAN_M_CAN=y
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
CONFIG_CAN_SOFTING=y

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=y
CONFIG_CAN_MCP251X=y
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_QCA=y
CONFIG_BT_HCIBTSDIO=y
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_3WIRE=y
# CONFIG_BT_HCIUART_INTEL is not set
CONFIG_BT_HCIUART_QCA=y
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
# CONFIG_BT_MRVL_SDIO is not set
CONFIG_BT_WILINK=y
CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_RDMA=y
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=y
CONFIG_NFC_SIM=y
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_ST95HF=y
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
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
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PHYSMAP_OF_VERSATILE is not set
# CONFIG_MTD_PHYSMAP_OF_GEMINI is not set
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_M25P80=y
CONFIG_MTD_MCHP23K256=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=y
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_PLATFORM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=y
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_MTD_UBI_BLOCK=y
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
# CONFIG_OF_DYNAMIC is not set
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
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
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
# CONFIG_IDE_GD_ATAPI is not set
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_CLOSURES_DEBUG=y
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=y
# CONFIG_DUMMY is not set
CONFIG_EQUALIZER=y
# CONFIG_NET_FC is not set
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_BROADCAST=y
# CONFIG_NET_TEAM_MODE_ROUNDROBIN is not set
CONFIG_NET_TEAM_MODE_RANDOM=y
# CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
CONFIG_NET_TEAM_MODE_LOADBALANCE=y
# CONFIG_MACVLAN is not set
CONFIG_IPVLAN=y
CONFIG_IPVTAP=y
CONFIG_VXLAN=y
# CONFIG_GENEVE is not set
CONFIG_GTP=y
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
CONFIG_TAP=y
CONFIG_TUN_VNET_CROSS_LE=y
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
CONFIG_B53_SPI_DRIVER=y
CONFIG_B53_MDIO_DRIVER=y
# CONFIG_B53_MMAP_DRIVER is not set
# CONFIG_B53_SRAB_DRIVER is not set
CONFIG_NET_DSA_BCM_SF2=y
# CONFIG_NET_DSA_LOOP is not set
CONFIG_NET_DSA_MT7530=y
CONFIG_NET_DSA_MV88E6060=y
CONFIG_MICROCHIP_KSZ=y
CONFIG_MICROCHIP_KSZ_SPI_DRIVER=y
# CONFIG_NET_DSA_MV88E6XXX is not set
CONFIG_NET_DSA_QCA8K=y
# CONFIG_NET_DSA_SMSC_LAN9303_I2C is not set
# CONFIG_NET_DSA_SMSC_LAN9303_MDIO is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
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
CONFIG_GEMINI_ETHERNET=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
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
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=y
# CONFIG_KS8851 is not set
CONFIG_KS8851_MLL=y
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=y
CONFIG_ENC28J60_WRITEVERIFY=y
CONFIG_ENCX24J600=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
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
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
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
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
CONFIG_WIZNET_W5300=y
# CONFIG_WIZNET_BUS_DIRECT is not set
CONFIG_WIZNET_BUS_INDIRECT=y
# CONFIG_WIZNET_BUS_ANY is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
# CONFIG_DWC_XLGMAC_PCI is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_GPIO=y
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=y
# CONFIG_MDIO_HISI_FEMAC is not set
CONFIG_MDIO_OCTEON=y
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AT803X_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=y
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=y
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=y
CONFIG_PLIP=y
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
# CONFIG_PPPOATM is not set
CONFIG_PPPOE=y
# CONFIG_PPPOL2TP is not set
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=y
# CONFIG_HDLC_RAW is not set
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
# CONFIG_HDLC_FR is not set
CONFIG_HDLC_PPP=y
CONFIG_HDLC_X25=y
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DLCI is not set
CONFIG_LAPBETHER=y
# CONFIG_X25_ASY is not set
CONFIG_SBNI=y
# CONFIG_SBNI_MULTILINE is not set
# CONFIG_IEEE802154_DRIVERS is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
# CONFIG_ISDN_MPP is not set
CONFIG_IPPP_FILTER=y
CONFIG_ISDN_PPP_BSDCOMP=y
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
# CONFIG_ISDN_DRV_HISAX is not set
# CONFIG_ISDN_CAPI is not set
CONFIG_ISDN_DRV_GIGASET=y
CONFIG_GIGASET_I4L=y
# CONFIG_GIGASET_M101 is not set
CONFIG_GIGASET_DEBUG=y
CONFIG_MISDN=y
# CONFIG_MISDN_DSP is not set
# CONFIG_MISDN_L1OIP is not set

#
# mISDN hardware drivers
#
# CONFIG_MISDN_HFCPCI is not set
# CONFIG_MISDN_HFCMULTI is not set
# CONFIG_MISDN_AVMFRITZ is not set
# CONFIG_MISDN_SPEEDFAX is not set
# CONFIG_MISDN_INFINEON is not set
# CONFIG_MISDN_W6692 is not set
# CONFIG_MISDN_NETJET is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
# CONFIG_RMI4_SMB is not set
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
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
CONFIG_N_GSM=y
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_IFX6X60=y
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PROC_INTERFACE is not set
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_NVRAM is not set
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
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
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
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
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=y
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX8998 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_STMPE_SPI=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AS3711=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCAP is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RK808 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=y
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SPI=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_GPIO_CIR=y
CONFIG_IR_GPIO_TX=y
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=y
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_MM_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
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
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=y
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_DUMB_VGA_DAC=y
CONFIG_DRM_LVDS_ENCODER=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_SIL_SII8620=y
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_DW_HDMI=y
# CONFIG_DRM_DW_HDMI_CEC is not set
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
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
CONFIG_FB_BOOT_VESA_SUPPORT=y
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
CONFIG_FB_BACKLIGHT=y
# CONFIG_FB_MODE_HELPERS is not set
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
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
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
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_AUO_K190X=y
# CONFIG_FB_AUO_K1900 is not set
CONFIG_FB_AUO_K1901=y
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_S6E63M0=y
CONFIG_LCD_LD9040=y
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y

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
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_AT91 is not set
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MMC_SDHCI_OMAP is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_ACCESSIBILITY=y
# CONFIG_A11Y_BRAILLE_CONSOLE is not set
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_IPOIB=y
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
# CONFIG_INFINIBAND_SRP is not set
# CONFIG_INFINIBAND_SRPT is not set
# CONFIG_INFINIBAND_ISER is not set
CONFIG_INFINIBAND_OPA_VNIC=y
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_RDMA_RXE is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_DW_AXI_DMAC is not set
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IOATDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
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
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_CHARLCD=y
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
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
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
# CONFIG_COMEDI_PCL812 is not set
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
CONFIG_COMEDI_RTI800=y
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=y
# CONFIG_COMEDI_DAS16M1 is not set
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
# CONFIG_COMEDI_DAS1800 is not set
CONFIG_COMEDI_DAS6402=y
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=y
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
# CONFIG_COMEDI_FL512 is not set
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
CONFIG_COMEDI_II_PCI20KC=y
CONFIG_COMEDI_C6XDIGIO=y
# CONFIG_COMEDI_MPC624 is not set
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=y
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
# CONFIG_COMEDI_PCMAD is not set
CONFIG_COMEDI_PCMDA12=y
# CONFIG_COMEDI_PCMMIO is not set
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16203=y
CONFIG_ADIS16209=y
CONFIG_ADIS16240=y

#
# Analog to digital converters
#
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7780=y
CONFIG_AD7816=y
CONFIG_AD7192=y
CONFIG_AD7280=y

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
CONFIG_ADT7316_I2C=y

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7152=y
CONFIG_AD7746=y

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
CONFIG_AD9834=y

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16060 is not set

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y

#
# Light sensors
#
CONFIG_TSL2x7x=y

#
# Active energy metering IC
#
CONFIG_ADE7753=y
# CONFIG_ADE7754 is not set
# CONFIG_ADE7758 is not set
# CONFIG_ADE7759 is not set
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y
CONFIG_ADE7854_SPI=y

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=y
CONFIG_AD2S1210=y
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
CONFIG_STAGING_MEDIA=y

#
# Android
#
# CONFIG_STAGING_BOARD is not set
# CONFIG_GOLDFISH_AUDIO is not set
CONFIG_MTD_GOLDFISH_NAND=y
CONFIG_MTD_SPINAND_MT29F=y
# CONFIG_MTD_SPINAND_ONDIEECC is not set
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
CONFIG_CRYPTO_SKEIN=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
CONFIG_FB_TFT_BD663474=y
CONFIG_FB_TFT_HX8340BN=y
CONFIG_FB_TFT_HX8347D=y
# CONFIG_FB_TFT_HX8353D is not set
CONFIG_FB_TFT_HX8357D=y
CONFIG_FB_TFT_ILI9163=y
CONFIG_FB_TFT_ILI9320=y
# CONFIG_FB_TFT_ILI9325 is not set
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
CONFIG_FB_TFT_ILI9481=y
CONFIG_FB_TFT_ILI9486=y
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=y
# CONFIG_FB_TFT_S6D1121 is not set
CONFIG_FB_TFT_SH1106=y
CONFIG_FB_TFT_SSD1289=y
# CONFIG_FB_TFT_SSD1305 is not set
CONFIG_FB_TFT_SSD1306=y
CONFIG_FB_TFT_SSD1331=y
CONFIG_FB_TFT_SSD1351=y
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
# CONFIG_FB_TFT_TLS8204 is not set
# CONFIG_FB_TFT_UC1611 is not set
CONFIG_FB_TFT_UC1701=y
CONFIG_FB_TFT_UPD161704=y
CONFIG_FB_TFT_WATTEROTT=y
# CONFIG_FB_FLEX is not set
CONFIG_FB_TFT_FBTFT_DEVICE=y
# CONFIG_MOST is not set
CONFIG_KS7010=y
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_PI433=y
CONFIG_MTK_MMC=y
# CONFIG_MTK_AEE_KDUMP is not set
CONFIG_MTK_MMC_CD_POLL=y
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_VIRTIO=y
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
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
# CONFIG_SCA3000 is not set
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD7266 is not set
CONFIG_AD7291=y
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
CONFIG_AD7766=y
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
# CONFIG_DA9150_GPADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=y
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=y
CONFIG_MAX11100=y
CONFIG_MAX1118=y
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=y
# CONFIG_MCP3422 is not set
CONFIG_NAU7802=y
# CONFIG_PALMAS_GPADC is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_AM335X_ADC=y
# CONFIG_TI_TLC4541 is not set
CONFIG_VF610_ADC=y

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=y

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=y
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
CONFIG_AD5380=y
# CONFIG_AD5421 is not set
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
# CONFIG_LTC2632 is not set
CONFIG_AD5686=y
# CONFIG_AD5755 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
CONFIG_AD7303=y
# CONFIG_AD8801 is not set
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_MCP4922=y
# CONFIG_TI_DAC082S085 is not set
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
CONFIG_HID_SENSOR_GYRO_3D=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HID_SENSOR_HUMIDITY=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16480=y
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_SPI=y
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y

#
# Multiplexers
#
CONFIG_IIO_MUX=y

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_AD5272=y
# CONFIG_DS1803 is not set
CONFIG_MAX5481=y
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=y

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
CONFIG_SRF08=y

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_HID_SENSOR_TEMP=y
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_PWM_STMPE=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_POWERCAP=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
# CONFIG_FPGA_MGR_ICE40_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
# CONFIG_GFS2_FS_LOCKING_DLM is not set
CONFIG_OCFS2_FS=y
# CONFIG_OCFS2_FS_O2CB is not set
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=y
# CONFIG_OCFS2_FS_STATS is not set
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FS_ENCRYPTION is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
CONFIG_OVERLAY_FS_XINO_AUTO=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
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
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
# CONFIG_HFSPLUS_FS_POSIX_ACL is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_UBIFS_FS_ENCRYPTION is not set
# CONFIG_UBIFS_FS_SECURITY is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
# CONFIG_ROMFS_BACKED_BY_MTD is not set
CONFIG_ROMFS_BACKED_BY_BOTH=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
CONFIG_DLM_DEBUG=y

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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
# CONFIG_KASAN_EXTRA is not set
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
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
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
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
CONFIG_UBSAN_NULL=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
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
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
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
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

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
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA1_MB=y
# CONFIG_CRYPTO_SHA256_MB is not set
# CONFIG_CRYPTO_SHA512_MB is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_X86_64=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
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
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_AEAD is not set
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
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
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
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=y
CONFIG_STRING_SELFTEST=y

--gxj6wzvssma7hlss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export runtime=300
	export job_origin='/lkp/lkp/src/allot/rand/vm-lkp-hsw01-1G/trinity.yaml'
	export testbox='vm-lkp-hsw01-1G-9'
	export tbox_group='vm-lkp-hsw01-1G'
	export kconfig='x86_64-randconfig-s5-04172210'
	export compiler='gcc-7'
	export queue='rand'
	export branch='linus/master'
	export commit='60cc43fc888428bb2f18f08997432d426a243338'
	export submit_id='5ad60efd0b9a935fb6139fba'
	export job_file='/lkp/scheduled/vm-lkp-hsw01-1G-9/trinity-300s-debian-x86_64-2016-08-31.cgz-60cc43fc888428bb2f18f08997432d426a243338-20180417-90038-7ko8tn-0.yaml'
	export id='b244081dd1efea7cf83223868613fe5fa62158f1'
	export model='qemu-system-x86_64 -enable-kvm -cpu host'
	export nr_vm=10
	export nr_cpu=2
	export memory='1G'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export rootfs='debian-x86_64-2016-08-31.cgz'
	export enqueue_time='2018-04-17 23:13:01 +0800'
	export _id='5ad60efd0b9a935fb6139fba'
	export _rt='/result/trinity/300s/vm-lkp-hsw01-1G/debian-x86_64-2016-08-31.cgz/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338'
	export user='lkp'
	export tbox_host_file='/lkp/lkp/.src-20180417-175914/hosts/vm-lkp-hsw01-1G-9'
	export verify_tbox_config='true'
	export kernel='/pkg/linux/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1'
	export result_root='/result/trinity/300s/vm-lkp-hsw01-1G/debian-x86_64-2016-08-31.cgz/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/2'
	export dequeue_time='2018-04-17 23:13:14 +0800'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-2016-08-31.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/scheduled/vm-lkp-hsw01-1G-9/trinity-300s-debian-x86_64-2016-08-31.cgz-60cc43fc888428bb2f18f08997432d426a243338-20180417-90038-7ko8tn-0.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-s5-04172210
branch=linus/master
commit=60cc43fc888428bb2f18f08997432d426a243338
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1
max_uptime=1500
RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-1G/debian-x86_64-2016-08-31.cgz/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/2
LKP_SERVER=inn
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
rw'
	export bm_initrd='/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2017-12-14.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-x86_64-6ddabfd2_2017-11-10.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/scheduled/vm-lkp-hsw01-1G-9/trinity-300s-debian-x86_64-2016-08-31.cgz-60cc43fc888428bb2f18f08997432d426a243338-20180417-90038-7ko8tn-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	$LKP_SRC/stats/wrapper kmsg

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--gxj6wzvssma7hlss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-vm-lkp-hsw01-1G-9:20180417231439:x86_64-randconfig-s5-04172210:4.17.0-rc1:262"

#!/bin/bash

# To reproduce,
# 1) save job-script and this script (both are attached in 0day report email)
# 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH

kernel=$1

initrds=(
	/osimage/debian/debian-x86_64-2016-08-31.cgz
	/lkp/lkp/lkp-x86_64.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2017-12-14.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz
	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-x86_64-6ddabfd2_2017-11-10.cgz
)

HTTP_PREFIX=https://github.com/0day-ci/lkp-qemu/raw/master
wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"

{
	cat "${initrds[@]//*\//}"
	[[ $INSTALL_MOD_PATH ]] && (
		cd "$INSTALL_MOD_PATH"
		find lib | cpio -o -H newc --quiet | gzip
	)
	echo  job-script | cpio -o -H newc --quiet | gzip
} > initrd.img

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu host
	-kernel $kernel
	-initrd initrd.img
	-m 1024
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
	ip=::::vm-lkp-hsw01-1G-9::dhcp
	root=/dev/ram0
	user=lkp
	job=/job-script
	ARCH=x86_64
	kconfig=x86_64-randconfig-s5-04172210
	branch=linus/master
	commit=60cc43fc888428bb2f18f08997432d426a243338
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1
	max_uptime=1500
	RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-1G/debian-x86_64-2016-08-31.cgz/x86_64-randconfig-s5-04172210/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/2
	result_service=tmpfs
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
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--gxj6wzvssma7hlss--
