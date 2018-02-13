Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935191AbeBMMpb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:45:31 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38281 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:45:25 -0500
X-Google-Smtp-Source: AH8x224jqAS3VRO1AVhtH7AwXgCxscYTjhSiTThG/UfpZBqp9kkZ4HEks3uRnq0Fz0cMwgdydYU/pA==
Subject: Re: smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
From: Tvrtko Ursulin <tursulin@ursulin.net>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <1696e2c6-8d0a-e954-1205-439d70a81f77@ursulin.net>
Message-ID: <f4069994-6065-af69-0ab5-0587efe26636@ursulin.net>
Date: Tue, 13 Feb 2018 12:45:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1696e2c6-8d0a-e954-1205-439d70a81f77@ursulin.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

On 07/02/18 12:48, Tvrtko Ursulin wrote:
> 
> Hi,
> 
> We are seeing failures to online the CPU0 on Apollo Lake in the form of:
> 
>   <6>[  126.508783] smpboot: CPU 0 is now offline
>   <6>[  127.520746] smpboot: Booting Node 0 Processor 0 APIC 0x0
>   <3>[  137.521036] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
> 
> I unfortunately cannot say with which kernel version this started since
> we added a test which does this only recently. I also have no local
> access to this machine. (It is part of a test farm for i915 driver
> development testing.) But we recently added a test which off-lines, and
> on-lines back, CPUs and started seeing this. Small reproducer looks like
> this (without boilerplate):
> 
> static void cpu_hotplug_raw(int gem_fd)
> {
> 	int cpu = 0;
> 	char name[128];
> 	int cpufd;
> 
> 	igt_require(cpu0_hotplug_support());
> 
> 	for (;;) {
> 		igt_assert_lt(snprintf(name, sizeof(name),
> 				       "/sys/devices/system/cpu/cpu%d/online",
> 				       cpu),
> 			      sizeof(name));
> 		cpufd = open(name, O_WRONLY);
> 		if (cpufd == -1) {
> 			igt_assert(cpu > 0);
> 			break;
> 		}
> 
> 		/* Offline followed by online a CPU. */
> 		igt_assert_eq(write(cpufd, "0", 2), 2);
> 		usleep(1e6);
> 		igt_assert_eq(write(cpufd, "1", 2), 2);
> 
> 		close(cpufd);
> 		cpu++;
> 	}
> }
> 
> Any suggestions on how to debug this further? Dmesg from boot is pasted
> below.

Any hints on how to debug this? Could it be firwmare? Try some boot 
options or something?

Regards,

Tvrtko

> Regards,
> 
> Tvrtko
> 
> <5>[    0.000000] Linux version 4.15.0-CI-CI_DRM_3731+ (cidrm@ci-worker1.fi.intel.com) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2)) #1 SMP PREEMPT Wed Feb 7 10:22:14 EET 2018
> <6>[    0.000000] Command line: BOOT_IMAGE=/boot/drm_intel root=/dev/sda2 rootwait fsck.repair=yes intel_iommu=igfx_off nmi_watchdog=panic,auto panic=5 softdog.soft_panic=5 drm.debug=0xe 3 ro
> <6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> <6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> <6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> <6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> <6>[    0.000000] x86/fpu: xstate_offset[3]:  576, xstate_sizes[3]:   64
> <6>[    0.000000] x86/fpu: xstate_offset[4]:  640, xstate_sizes[4]:   64
> <6>[    0.000000] x86/fpu: Enabled xstate features 0x1b, context size is 704 bytes, using 'compacted' format.
> <6>[    0.000000] e820: BIOS-provided physical RAM map:
> <6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000003efff] usable
> <6>[    0.000000] BIOS-e820: [mem 0x000000000003f000-0x000000000003ffff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x0000000000040000-0x000000000009dfff] usable
> <6>[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff] usable
> <6>[    0.000000] BIOS-e820: [mem 0x0000000010000000-0x0000000012150fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x0000000012151000-0x0000000077715fff] usable
> <6>[    0.000000] BIOS-e820: [mem 0x0000000077716000-0x0000000079837fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x0000000079838000-0x0000000079852fff] ACPI data
> <6>[    0.000000] BIOS-e820: [mem 0x0000000079853000-0x00000000798b2fff] ACPI NVS
> <6>[    0.000000] BIOS-e820: [mem 0x00000000798b3000-0x0000000079bdcfff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x0000000079bdd000-0x0000000079c41fff] type 20
> <6>[    0.000000] BIOS-e820: [mem 0x0000000079c42000-0x0000000079fc4fff] usable
> <6>[    0.000000] BIOS-e820: [mem 0x0000000079fc5000-0x0000000079fc5fff] ACPI NVS
> <6>[    0.000000] BIOS-e820: [mem 0x0000000079fc6000-0x0000000079feffff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x0000000079ff0000-0x000000007a9defff] usable
> <6>[    0.000000] BIOS-e820: [mem 0x000000007a9df000-0x000000007a9e0fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x000000007a9e1000-0x000000007affffff] usable
> <6>[    0.000000] BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000fe042000-0x00000000fe044fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000fe900000-0x00000000fe902fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> <6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
> <6>[    0.000000] NX (Execute Disable) protection: active
> <6>[    0.000000] efi: EFI v2.50 by American Megatrends
> <6>[    0.000000] efi:  ACPI=0x79845000  ACPI 2.0=0x79845000  SMBIOS=0x79aa6000  SMBIOS 3.0=0x79aa5000  ESRT=0x79aa0a58
> <5>[    0.000000] random: fast init done
> <6>[    0.000000] SMBIOS 3.0.0 present.
> <6>[    0.000000] DMI:                  /NUC6CAYB, BIOS AYAPLCEL.86A.0040.2017.0619.1722 06/19/2017
> <7>[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> <7>[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> <6>[    0.000000] e820: last_pfn = 0x280000 max_arch_pfn = 0x400000000
> <7>[    0.000000] MTRR default type: uncachable
> <7>[    0.000000] MTRR fixed ranges enabled:
> <7>[    0.000000]   00000-6FFFF write-back
> <7>[    0.000000]   70000-7FFFF uncachable
> <7>[    0.000000]   80000-9FFFF write-back
> <7>[    0.000000]   A0000-BFFFF uncachable
> <7>[    0.000000]   C0000-FFFFF write-protect
> <7>[    0.000000] MTRR variable ranges enabled:
> <7>[    0.000000]   0 base 0000000000 mask 7F80000000 write-back
> <7>[    0.000000]   1 base 007C000000 mask 7FFC000000 uncachable
> <7>[    0.000000]   2 base 007B000000 mask 7FFF000000 uncachable
> <7>[    0.000000]   3 base 0100000000 mask 7F00000000 write-back
> <7>[    0.000000]   4 base 0200000000 mask 7F80000000 write-back
> <7>[    0.000000]   5 base 00FF000000 mask 7FFF000000 write-combining
> <7>[    0.000000]   6 disabled
> <7>[    0.000000]   7 disabled
> <7>[    0.000000]   8 disabled
> <7>[    0.000000]   9 disabled
> <6>[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> <6>[    0.000000] e820: last_pfn = 0x7b000 max_arch_pfn = 0x400000000
> <6>[    0.000000] esrt: Reserving ESRT space from 0x0000000079aa0a58 to 0x0000000079aa0a90.
> <7>[    0.000000] Base memory trampoline at [        (ptrval)] 98000 size 24576
> <6>[    0.000000] Using GB pages for direct mapping
> <7>[    0.000000] BRK [0x0702c000, 0x0702cfff] PGTABLE
> <7>[    0.000000] BRK [0x0702d000, 0x0702dfff] PGTABLE
> <7>[    0.000000] BRK [0x0702e000, 0x0702efff] PGTABLE
> <7>[    0.000000] BRK [0x0702f000, 0x0702ffff] PGTABLE
> <7>[    0.000000] BRK [0x07030000, 0x07030fff] PGTABLE
> <7>[    0.000000] BRK [0x07031000, 0x07031fff] PGTABLE
> <6>[    0.000000] Secure boot could not be determined
> <6>[    0.000000] ACPI: Early table checksum verification disabled
> <6>[    0.000000] ACPI: RSDP 0x0000000079845000 000024 (v02 INTEL )
> <6>[    0.000000] ACPI: XSDT 0x00000000798450C0 0000EC (v01 INTEL  NUC6CAYB 01072009 AMI  00010013)
> <6>[    0.000000] ACPI: FACP 0x000000007984DF50 000114 (v06 INTEL  NUC6CAYB 01072009 AMI  00010013)
> <6>[    0.000000] ACPI: DSDT 0x0000000079845250 008CF8 (v02 INTEL  NUC6CAYB 01072009 INTL 20120913)
> <6>[    0.000000] ACPI: FACS 0x0000000079882080 000040
> <6>[    0.000000] ACPI: FPDT 0x000000007984E070 000044 (v01 INTEL  NUC6CAYB 01072009 AMI  00010013)
> <6>[    0.000000] ACPI: FIDT 0x000000007984E0C0 00009C (v01 INTEL  NUC6CAYB 01072009 AMI  00010013)
> <6>[    0.000000] ACPI: MCFG 0x000000007984E160 00003C (v01 INTEL  NUC6CAYB 01072009 MSFT 00000097)
> <6>[    0.000000] ACPI: DBG2 0x000000007984E1A0 000072 (v00 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: DBGP 0x000000007984E220 000034 (v01 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: HPET 0x000000007984E260 000038 (v01 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: LPIT 0x000000007984E2A0 00005C (v01 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: APIC 0x000000007984E300 000084 (v03 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: NPKT 0x000000007984E390 000065 (v01 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: PRAM 0x000000007984E400 000030 (v01 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: WSMT 0x000000007984E430 000028 (v01 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: SSDT 0x000000007984E460 00002B (v02 INTEL  NUC6CAYB 00000003 BRXT 0100000D)
> <6>[    0.000000] ACPI: SSDT 0x000000007984E490 000A19 (v01 INTEL  NUC6CAYB 00001000 INTL 20120913)
> <6>[    0.000000] ACPI: SSDT 0x000000007984EEB0 000442 (v02 INTEL  NUC6CAYB 00003000 INTL 20120913)
> <6>[    0.000000] ACPI: SSDT 0x000000007984F300 00072B (v02 INTEL  NUC6CAYB 00003000 INTL 20120913)
> <6>[    0.000000] ACPI: SSDT 0x000000007984FA30 00032D (v02 INTEL  NUC6CAYB 00003000 INTL 20120913)
> <6>[    0.000000] ACPI: SSDT 0x000000007984FD60 00017C (v02 INTEL  NUC6CAYB 00003000 INTL 20120913)
> <6>[    0.000000] ACPI: SSDT 0x000000007984FEE0 002740 (v02 INTEL  NUC6CAYB 00003000 INTL 20120913)
> <6>[    0.000000] ACPI: UEFI 0x0000000079852620 000042 (v01 INTEL  NUC6CAYB 00000000      00000000)
> <6>[    0.000000] ACPI: BGRT 0x0000000079852670 000038 (v01 INTEL  NUC6CAYB 01072009 AMI  00010013)
> <6>[    0.000000] ACPI: TPM2 0x00000000798526B0 000034 (v03 INTEL  NUC6CAYB 00000001 AMI  00000000)
> <6>[    0.000000] ACPI: SSDT 0x00000000798526F0 0001F8 (v01 INTEL  NUC6CAYB 00001000 INTL 20120913)
> <6>[    0.000000] ACPI: WDAT 0x00000000798528F0 000104 (v01 INTEL  NUC6CAYB 00000000      00000000)
> <6>[    0.000000] ACPI: NHLT 0x0000000079852A00 00002D (v00 INTEL  NUC6CAYB 00000002      01000013)
> <7>[    0.000000] ACPI: Local APIC address 0xfee00000
> <6>[    0.000000] tsc: Using PIT calibration value
> <6>[    0.000000] Zone ranges:
> <6>[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> <6>[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> <6>[    0.000000]   Normal   [mem 0x0000000100000000-0x000000027fffffff]
> <6>[    0.000000] Movable zone start for each node
> <6>[    0.000000] Early memory node ranges
> <6>[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000003efff]
> <6>[    0.000000]   node   0: [mem 0x0000000000040000-0x000000000009dfff]
> <6>[    0.000000]   node   0: [mem 0x0000000000100000-0x000000000fffffff]
> <6>[    0.000000]   node   0: [mem 0x0000000012151000-0x0000000077715fff]
> <6>[    0.000000]   node   0: [mem 0x0000000079c42000-0x0000000079fc4fff]
> <6>[    0.000000]   node   0: [mem 0x0000000079ff0000-0x000000007a9defff]
> <6>[    0.000000]   node   0: [mem 0x000000007a9e1000-0x000000007affffff]
> <6>[    0.000000]   node   0: [mem 0x0000000100000000-0x000000027fffffff]
> <6>[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000027fffffff]
> <7>[    0.000000] On node 0 totalpages: 2058482
> <7>[    0.000000]   DMA zone: 64 pages used for memmap
> <7>[    0.000000]   DMA zone: 22 pages reserved
> <7>[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
> <7>[    0.000000]   DMA32 zone: 7526 pages used for memmap
> <7>[    0.000000]   DMA32 zone: 481622 pages, LIFO batch:31
> <7>[    0.000000]   Normal zone: 24576 pages used for memmap
> <7>[    0.000000]   Normal zone: 1572864 pages, LIFO batch:31
> <6>[    0.000000] Reserved but unavailable: 99 pages
> <6>[    0.000000] Reserving Intel graphics memory at [mem 0x7c000000-0x7fffffff]
> <6>[    0.000000] ACPI: PM-Timer IO Port: 0x408
> <7>[    0.000000] ACPI: Local APIC address 0xfee00000
> <6>[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
> <6>[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
> <6>[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
> <6>[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
> <6>[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-119
> <6>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> <6>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> <7>[    0.000000] ACPI: IRQ0 used by override.
> <7>[    0.000000] ACPI: IRQ9 used by override.
> <6>[    0.000000] Using ACPI (MADT) for SMP configuration information
> <6>[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> <6>[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x0003f000-0x0003ffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x000fffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x10000000-0x12150fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x77716000-0x79837fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x79838000-0x79852fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x79853000-0x798b2fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x798b3000-0x79bdcfff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x79bdd000-0x79c41fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x79fc5000-0x79fc5fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x79fc6000-0x79feffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x7a9df000-0x7a9e0fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x7b000000-0x7fffffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0xcfffffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xd0000000-0xd0ffffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xd1000000-0xdfffffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfe041fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfe042000-0xfe044fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfe045000-0xfe8fffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfe900000-0xfe902fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfe903000-0xfebfffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed00fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed01fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfed02000-0xfedfffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> <6>[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
> <6>[    0.000000] e820: [mem 0x80000000-0xcfffffff] available for PCI devices
> <6>[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> <6>[    0.000000] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:4 nr_node_ids:1
> <6>[    0.000000] percpu: Embedded 44 pages/cpu @        (ptrval) s141832 r8192 d30200 u524288
> <7>[    0.000000] pcpu-alloc: s141832 r8192 d30200 u524288 alloc=1*2097152
> <7>[    0.000000] pcpu-alloc: [0] 0 1 2 3
> <6>[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2026294
> <5>[    0.000000] Kernel command line: BOOT_IMAGE=/boot/drm_intel root=/dev/sda2 rootwait fsck.repair=yes intel_iommu=igfx_off nmi_watchdog=panic,auto panic=5 softdog.soft_panic=5 drm.debug=0xe 3 ro
> <6>[    0.000000] DMAR: Disable GFX device mapping
> <6>[    0.000000] log_buf_len individual max cpu contribution: 262144 bytes
> <6>[    0.000000] log_buf_len total cpu_extra contributions: 786432 bytes
> <6>[    0.000000] log_buf_len min size: 262144 bytes
> <6>[    0.000000] log_buf_len: 1048576 bytes
> <6>[    0.000000] early log buf free: 248084(94%)
> <6>[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> <6>[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> <6>[    0.000000] Memory: 7884232K/8233928K available (12300K kernel code, 1296K rwdata, 3640K rodata, 1216K init, 24856K bss, 349696K reserved, 0K cma-reserved)
> <6>[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> <6>[    0.000000] Kernel/User page tables isolation: enabled
> <6>[    0.000000] Running RCU self tests
> <6>[    0.000000] Preemptible hierarchical RCU implementation.
> <6>[    0.000000] 	RCU lockdep checking is enabled.
> <6>[    0.000000] 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
> <6>[    0.000000] 	RCU callback double-/use-after-free debug enabled.
> <6>[    0.000000] 	Tasks RCU enabled.
> <6>[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> <6>[    0.000000] kmemleak: Kernel memory leak detector disabled
> <6>[    0.000000] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
> <6>[    0.000000] Console: colour dummy device 80x25
> <6>[    0.000000] console [tty0] enabled
> <4>[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> <4>[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> <4>[    0.000000] ... MAX_LOCK_DEPTH:          48
> <4>[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> <4>[    0.000000] ... CLASSHASH_SIZE:          4096
> <4>[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
> <4>[    0.000000] ... MAX_LOCKDEP_CHAINS:      131072
> <4>[    0.000000] ... CHAINHASH_SIZE:          65536
> <4>[    0.000000]  memory used by lock dependency info: 9951 kB
> <4>[    0.000000]  per task-struct memory footprint: 1920 bytes
> <4>[    0.000000] kmemleak: Early log buffer exceeded (1006), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> <6>[    0.000000] ACPI: Core revision 20170831
> <6>[    0.000000] ACPI: 9 ACPI AML tables successfully acquired and loaded
> <6>[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 99544814920 ns
> <7>[    0.000000] hpet clockevent registered
> <6>[    0.001000] APIC: Switch to symmetric I/O mode setup
> <6>[    0.002000] x2apic: IRQ remapping doesn't support X2APIC mode
> <6>[    0.007000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> <6>[    0.013000] tsc: PIT calibration matches HPET. 1 loops
> <6>[    0.013000] tsc: Detected 1497.665 MHz processor
> <6>[    0.013000] tsc: Detected 1497.600 MHz TSC
> <6>[    0.013000] Calibrating delay loop (skipped), value calculated using timer frequency.. 2995.20 BogoMIPS (lpj=1497600)
> <6>[    0.013000] pid_max: default: 32768 minimum: 301
> <6>[    0.015294] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> <6>[    0.015369] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
> <6>[    0.017518] CPU: Physical Processor ID: 0
> <6>[    0.017551] CPU: Processor Core ID: 0
> <6>[    0.017604] mce: CPU supports 7 MCE banks
> <6>[    0.017715] CPU0: Thermal monitoring enabled (TM1)
> <6>[    0.017833] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
> <6>[    0.017867] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> <6>[    0.017906] Spectre V2 mitigation: Vulnerable: Minimal generic ASM retpoline
> <6>[    0.018492] Freeing SMP alternatives memory: 36K
> <7>[    0.049258] TSC deadline timer enabled
> <6>[    0.049281] smpboot: CPU0: Intel(R) Celeron(R) CPU J3455 @ 1.50GHz (family: 0x6, model: 0x5c, stepping: 0x9)
> <6>[    0.053116] Performance Events: PEBS fmt3+, Goldmont events, 32-deep LBR, full-width counters, Intel PMU driver.
> <6>[    0.053283] ... version:                4
> <6>[    0.053313] ... bit width:              48
> <6>[    0.053342] ... generic registers:      4
> <6>[    0.053370] ... value mask:             0000ffffffffffff
> <6>[    0.053405] ... max period:             00007fffffffffff
> <6>[    0.053440] ... fixed-purpose events:   3
> <6>[    0.053468] ... event mask:             000000070000000f
> <6>[    0.055028] Hierarchical SRCU implementation.
> <6>[    0.062958] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> <6>[    0.065029] smp: Bringing up secondary CPUs ...
> <6>[    0.073223] x86: Booting SMP configuration:
> <6>[    0.073274] .... node  #0, CPUs:      #1 #2 #3
> <6>[    0.091655] smp: Brought up 1 node, 4 CPUs
> <6>[    0.091655] smpboot: Max logical packages: 1
> <6>[    0.091655] smpboot: Total of 4 processors activated (11980.80 BogoMIPS)
> <6>[    0.095683] devtmpfs: initialized
> <6>[    0.099189] PM: Registering ACPI NVS region [mem 0x79853000-0x798b2fff] (393216 bytes)
> <6>[    0.099816] PM: Registering ACPI NVS region [mem 0x79fc5000-0x79fc5fff] (4096 bytes)
> <6>[    0.102075] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> <6>[    0.102092] futex hash table entries: 1024 (order: 5, 131072 bytes)
> <6>[    0.102729] xor: measuring software checksum speed
> <6>[    0.112026]    prefetch64-sse:  7672.000 MB/sec
> <6>[    0.121133]    generic_sse:  6644.000 MB/sec
> <6>[    0.121165] xor: using function: prefetch64-sse (7672.000 MB/sec)
> <6>[    0.121245] pinctrl core: initialized pinctrl subsystem
> <6>[    0.126593] NET: Registered protocol family 16
> <6>[    0.131044] cpuidle: using governor menu
> <6>[    0.131044] ACPI: bus type PCI registered
> <6>[    0.131044] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> <6>[    0.131532] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> <6>[    0.131599] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
> <6>[    0.131705] PCI: Using configuration type 1 for base access
> <6>[    0.170190] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> <6>[    0.188999] raid6: sse2x1   gen()  3234 MB/s
> <6>[    0.205963] raid6: sse2x1   xor()  1927 MB/s
> <6>[    0.222957] raid6: sse2x2   gen()  3730 MB/s
> <6>[    0.239953] raid6: sse2x2   xor()  2308 MB/s
> <6>[    0.256963] raid6: sse2x4   gen()  4277 MB/s
> <6>[    0.273958] raid6: sse2x4   xor()  2281 MB/s
> <6>[    0.273992] raid6: using algorithm sse2x4 gen() 4277 MB/s
> <6>[    0.274015] raid6: .... xor() 2281 MB/s, rmw enabled
> <6>[    0.274052] raid6: using ssse3x2 recovery algorithm
> <6>[    0.275011] ACPI: Added _OSI(Module Device)
> <6>[    0.275019] ACPI: Added _OSI(Processor Device)
> <6>[    0.275053] ACPI: Added _OSI(3.0 _SCP Extensions)
> <6>[    0.275087] ACPI: Added _OSI(Processor Aggregator Device)
> <6>[    0.280812] ACPI: Executed 3 blocks of module-level executable AML code
> <6>[    0.486523] ACPI: Dynamic OEM Table Load:
> <6>[    0.486617] ACPI: SSDT 0xFFFF8802762E5738 000102 (v02 PmRef  Cpu0Cst  00003001 INTL 20120913)
> <6>[    0.499644] ACPI: Dynamic OEM Table Load:
> <6>[    0.499735] ACPI: SSDT 0xFFFF8802762E6128 00015F (v02 PmRef  ApIst    00003000 INTL 20120913)
> <6>[    0.505865] ACPI: Dynamic OEM Table Load:
> <6>[    0.505954] ACPI: SSDT 0xFFFF880276325088 00008D (v02 PmRef  ApCst    00003000 INTL 20120913)
> <6>[    0.540115] ACPI: EC: EC started
> <6>[    0.540157] ACPI: EC: interrupt blocked
> <6>[    0.540751] ACPI: \_SB_.PCI0.SBRG.H_EC: Used as first EC
> <6>[    0.540808] ACPI: \_SB_.PCI0.SBRG.H_EC: GPE=0x40, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> <6>[    0.540874] ACPI: \_SB_.PCI0.SBRG.H_EC: Used as boot DSDT EC to handle transactions
> <6>[    0.540931] ACPI: Interpreter enabled
> <6>[    0.541274] ACPI: (supports S0 S3 S4 S5)
> <6>[    0.541309] ACPI: Using IOAPIC for interrupt routing
> <6>[    0.541941] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> <6>[    0.551660] ACPI: Enabled 1 GPEs in block 00 to 7F
> <6>[    0.874146] ACPI: Power Resource [FN00] (on)
> <6>[    0.901169] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> <6>[    0.901263] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> <6>[    0.927830] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> <6>[    0.943660] PCI host bridge to bus 0000:00
> <6>[    0.943712] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
> <6>[    0.943768] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
> <6>[    0.943826] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
> <6>[    0.943882] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> <6>[    0.943942] pci_bus 0000:00: root bus resource [mem 0x7c000001-0x7fffffff window]
> <6>[    0.944000] pci_bus 0000:00: root bus resource [mem 0x7b800001-0x7bffffff window]
> <6>[    0.944029] pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
> <6>[    0.944091] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xefffffff window]
> <6>[    0.944155] pci_bus 0000:00: root bus resource [bus 00-ff]
> <7>[    0.944287] pci 0000:00:00.0: [8086:5af0] type 00 class 0x060000
> <7>[    0.950997] pci 0000:00:02.0: [8086:5a85] type 00 class 0x030000
> <7>[    0.951046] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x90ffffff 64bit]
> <7>[    0.951068] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff 64bit pref]
> <7>[    0.951085] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
> <6>[    0.951202] pci 0000:00:02.0: BAR 2: assigned to efifb
> <7>[    0.958362] pci 0000:00:0e.0: [8086:5a98] type 00 class 0x040380
> <7>[    0.958424] pci 0000:00:0e.0: reg 0x10: [mem 0x91410000-0x91413fff 64bit]
> <7>[    0.958494] pci 0000:00:0e.0: reg 0x20: [mem 0x91000000-0x910fffff 64bit]
> <7>[    0.958723] pci 0000:00:0e.0: PME# supported from D0 D3hot D3cold
> <7>[    0.966687] pci 0000:00:0f.0: [8086:5a9a] type 00 class 0x078000
> <7>[    0.966766] pci 0000:00:0f.0: reg 0x10: [mem 0x91427000-0x91427fff 64bit]
> <7>[    0.967071] pci 0000:00:0f.0: PME# supported from D3hot
> <7>[    0.973416] pci 0000:00:12.0: [8086:5ae3] type 00 class 0x010601
> <7>[    0.973467] pci 0000:00:12.0: reg 0x10: [mem 0x91414000-0x91415fff]
> <7>[    0.973488] pci 0000:00:12.0: reg 0x14: [mem 0x91424000-0x914240ff]
> <7>[    0.973508] pci 0000:00:12.0: reg 0x18: [io  0xf090-0xf097]
> <7>[    0.973530] pci 0000:00:12.0: reg 0x1c: [io  0xf080-0xf083]
> <7>[    0.973552] pci 0000:00:12.0: reg 0x20: [io  0xf060-0xf07f]
> <7>[    0.973572] pci 0000:00:12.0: reg 0x24: [mem 0x91423000-0x914237ff]
> <7>[    0.973754] pci 0000:00:12.0: PME# supported from D3hot
> <7>[    0.979970] pci 0000:00:13.0: [8086:5ad8] type 01 class 0x060400
> <7>[    0.980249] pci 0000:00:13.0: PME# supported from D0 D3hot D3cold
> <7>[    0.986517] pci 0000:00:13.1: [8086:5ad9] type 01 class 0x060400
> <7>[    0.986790] pci 0000:00:13.1: PME# supported from D0 D3hot D3cold
> <7>[    0.993064] pci 0000:00:13.2: [8086:5ada] type 01 class 0x060400
> <7>[    0.993343] pci 0000:00:13.2: PME# supported from D0 D3hot D3cold
> <7>[    0.999668] pci 0000:00:15.0: [8086:5aa8] type 00 class 0x0c0330
> <7>[    0.999730] pci 0000:00:15.0: reg 0x10: [mem 0x91400000-0x9140ffff 64bit]
> <7>[    0.999982] pci 0000:00:15.0: PME# supported from D3hot D3cold
> <7>[    1.007217] pci 0000:00:16.0: [8086:5aac] type 00 class 0x118000
> <7>[    1.007282] pci 0000:00:16.0: reg 0x10: [mem 0x91422000-0x91422fff 64bit]
> <7>[    1.007317] pci 0000:00:16.0: reg 0x18: [mem 0x91421000-0x91421fff 64bit]
> <7>[    1.013664] pci 0000:00:18.0: [8086:5abc] type 00 class 0x118000
> <7>[    1.013727] pci 0000:00:18.0: reg 0x10: [mem 0x91420000-0x91420fff 64bit]
> <7>[    1.013761] pci 0000:00:18.0: reg 0x18: [mem 0x9141f000-0x9141ffff 64bit]
> <7>[    1.020080] pci 0000:00:19.0: [8086:5ac2] type 00 class 0x118000
> <7>[    1.020143] pci 0000:00:19.0: reg 0x10: [mem 0x9141e000-0x9141efff 64bit]
> <7>[    1.020177] pci 0000:00:19.0: reg 0x18: [mem 0x9141d000-0x9141dfff 64bit]
> <7>[    1.026464] pci 0000:00:19.1: [8086:5ac4] type 00 class 0x118000
> <7>[    1.026525] pci 0000:00:19.1: reg 0x10: [mem 0x9141c000-0x9141cfff 64bit]
> <7>[    1.026559] pci 0000:00:19.1: reg 0x18: [mem 0x9141b000-0x9141bfff 64bit]
> <7>[    1.032846] pci 0000:00:19.2: [8086:5ac6] type 00 class 0x118000
> <7>[    1.032905] pci 0000:00:19.2: reg 0x10: [mem 0x9141a000-0x9141afff 64bit]
> <7>[    1.032940] pci 0000:00:19.2: reg 0x18: [mem 0x91419000-0x91419fff 64bit]
> <7>[    1.039244] pci 0000:00:1a.0: [8086:5ac8] type 00 class 0x0c8000
> <7>[    1.039308] pci 0000:00:1a.0: reg 0x10: [mem 0x91418000-0x91418fff 64bit]
> <7>[    1.039343] pci 0000:00:1a.0: reg 0x18: [mem 0x91417000-0x91417fff 64bit]
> <7>[    1.039562] pci 0000:00:1a.0: PME# supported from D0 D3hot
> <7>[    1.045780] pci 0000:00:1f.0: [8086:5ae8] type 00 class 0x060100
> <7>[    1.052239] pci 0000:00:1f.1: [8086:5ad4] type 00 class 0x0c0500
> <7>[    1.052333] pci 0000:00:1f.1: reg 0x10: [mem 0x91416000-0x914160ff 64bit]
> <7>[    1.052433] pci 0000:00:1f.1: reg 0x20: [io  0xf040-0xf05f]
> <7>[    1.059163] pci 0000:01:00.0: [10ec:5229] type 00 class 0xff0000
> <7>[    1.059218] pci 0000:01:00.0: reg 0x10: [mem 0x91300000-0x91300fff]
> <4>[    1.059336] pci 0000:01:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
> <7>[    1.059670] pci 0000:01:00.0: supports D1 D2
> <7>[    1.059676] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
> <6>[    1.060711] pci 0000:00:13.0: PCI bridge to [bus 01]
> <7>[    1.060763] pci 0000:00:13.0:   bridge window [mem 0x91300000-0x913fffff]
> <7>[    1.061420] pci 0000:02:00.0: [8086:24fb] type 00 class 0x028000
> <7>[    1.061503] pci 0000:02:00.0: reg 0x10: [mem 0x91200000-0x91201fff 64bit]
> <4>[    1.061602] pci 0000:02:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
> <7>[    1.061974] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> <6>[    1.062974] pci 0000:00:13.1: PCI bridge to [bus 02]
> <7>[    1.063027] pci 0000:00:13.1:   bridge window [mem 0x91200000-0x912fffff]
> <7>[    1.063777] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
> <7>[    1.063842] pci 0000:03:00.0: reg 0x10: [io  0xe000-0xe0ff]
> <7>[    1.063896] pci 0000:03:00.0: reg 0x18: [mem 0x91104000-0x91104fff 64bit]
> <7>[    1.063931] pci 0000:03:00.0: reg 0x20: [mem 0x91100000-0x91103fff 64bit]
> <4>[    1.063963] pci 0000:03:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
> <7>[    1.064308] pci 0000:03:00.0: supports D1 D2
> <7>[    1.064315] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> <6>[    1.065363] pci 0000:00:13.2: PCI bridge to [bus 03]
> <7>[    1.065407] pci 0000:00:13.2:   bridge window [io  0xe000-0xefff]
> <7>[    1.065417] pci 0000:00:13.2:   bridge window [mem 0x91100000-0x911fffff]
> <7>[    1.065468] pci_bus 0000:00: on NUMA node 0
> <6>[    1.084118] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.086631] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.089110] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.091607] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.094098] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.096594] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.099093] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.101571] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 *15), disabled.
> <6>[    1.120595] ACPI: EC: interrupt unblocked
> <6>[    1.120688] ACPI: EC: event unblocked
> <6>[    1.120766] ACPI: \_SB_.PCI0.SBRG.H_EC: GPE=0x40, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> <6>[    1.120844] ACPI: \_SB_.PCI0.SBRG.H_EC: Used as boot DSDT EC to handle transactions and events
> <6>[    1.123130] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> <6>[    1.123185] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> <6>[    1.123269] pci 0000:00:02.0: vgaarb: bridge control possible
> <6>[    1.123310] vgaarb: loaded
> <5>[    1.124524] SCSI subsystem initialized
> <7>[    1.125183] libata version 3.00 loaded.
> <6>[    1.125601] ACPI: bus type USB registered
> <6>[    1.126041] usbcore: registered new interface driver usbfs
> <6>[    1.126287] usbcore: registered new interface driver hub
> <6>[    1.127025] usbcore: registered new device driver usb
> <6>[    1.128349] Registered efivars operations
> <6>[    1.157361] Advanced Linux Sound Architecture Driver Initialized.
> <6>[    1.157550] PCI: Using ACPI for IRQ routing
> <7>[    1.191755] PCI: pci_cache_line_size set to 64 bytes
> <7>[    1.191920] e820: reserve RAM buffer [mem 0x0003f000-0x0003ffff]
> <7>[    1.191963] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> <7>[    1.191982] e820: reserve RAM buffer [mem 0x77716000-0x77ffffff]
> <7>[    1.192000] e820: reserve RAM buffer [mem 0x79fc5000-0x7bffffff]
> <7>[    1.192028] e820: reserve RAM buffer [mem 0x7a9df000-0x7bffffff]
> <7>[    1.192047] e820: reserve RAM buffer [mem 0x7b000000-0x7bffffff]
> <6>[    1.194389] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> <6>[    1.194478] hpet0: 8 comparators, 64-bit 19.200000 MHz counter
> <6>[    1.196153] clocksource: Switched to clocksource hpet
> <6>[    1.358830] pnp: PnP ACPI init
> <6>[    1.369714] system 00:00: [io  0x0a00-0x0a1f] has been reserved
> <6>[    1.369785] system 00:00: [io  0x0a20-0x0a2f] has been reserved
> <6>[    1.369846] system 00:00: [io  0x0a30-0x0a3f] has been reserved
> <6>[    1.369906] system 00:00: [io  0x0a40-0x0a4f] has been reserved
> <6>[    1.369969] system 00:00: [io  0x0a50-0x0a5f] has been reserved
> <6>[    1.370087] system 00:00: [io  0x0a60-0x0a6f] has been reserved
> <7>[    1.370223] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> <7>[    1.376711] pnp 00:01: [dma 0 disabled]
> <7>[    1.377238] pnp 00:01: Plug and Play ACPI device, IDs ITE8708 (active)
> <6>[    1.378123] system 00:02: [io  0x0680-0x069f] has been reserved
> <6>[    1.378187] system 00:02: [io  0x0400-0x047f] has been reserved
> <6>[    1.378247] system 00:02: [io  0x0500-0x05fe] has been reserved
> <6>[    1.378305] system 00:02: [io  0x0600-0x061f] has been reserved
> <6>[    1.378367] system 00:02: [io  0x164e-0x164f] has been reserved
> <7>[    1.378461] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
> <6>[    1.388472] system 00:03: [mem 0xe0000000-0xefffffff] has been reserved
> <6>[    1.388545] system 00:03: [mem 0xfea00000-0xfeafffff] has been reserved
> <6>[    1.388612] system 00:03: [mem 0xfed01000-0xfed01fff] has been reserved
> <6>[    1.388678] system 00:03: [mem 0xfed03000-0xfed03fff] has been reserved
> <6>[    1.388743] system 00:03: [mem 0xfed06000-0xfed06fff] has been reserved
> <6>[    1.388807] system 00:03: [mem 0xfed08000-0xfed09fff] has been reserved
> <6>[    1.388871] system 00:03: [mem 0xfed80000-0xfedbffff] has been reserved
> <6>[    1.388935] system 00:03: [mem 0xfed1c000-0xfed1cfff] has been reserved
> <6>[    1.389078] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
> <7>[    1.389186] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
> <7>[    1.393813] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
> <6>[    1.399157] pnp: PnP ACPI: found 5 devices
> <6>[    1.440558] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> <6>[    1.440687] pci 0000:00:13.0: PCI bridge to [bus 01]
> <6>[    1.440733] pci 0000:00:13.0:   bridge window [mem 0x91300000-0x913fffff]
> <6>[    1.440790] pci 0000:00:13.1: PCI bridge to [bus 02]
> <6>[    1.440831] pci 0000:00:13.1:   bridge window [mem 0x91200000-0x912fffff]
> <6>[    1.440888] pci 0000:00:13.2: PCI bridge to [bus 03]
> <6>[    1.440925] pci 0000:00:13.2:   bridge window [io  0xe000-0xefff]
> <6>[    1.440970] pci 0000:00:13.2:   bridge window [mem 0x91100000-0x911fffff]
> <7>[    1.441084] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
> <7>[    1.441091] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
> <7>[    1.441098] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
> <7>[    1.441103] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
> <7>[    1.441109] pci_bus 0000:00: resource 8 [mem 0x7c000001-0x7fffffff window]
> <7>[    1.441115] pci_bus 0000:00: resource 9 [mem 0x7b800001-0x7bffffff window]
> <7>[    1.441121] pci_bus 0000:00: resource 10 [mem 0x80000000-0xcfffffff window]
> <7>[    1.441127] pci_bus 0000:00: resource 11 [mem 0xe0000000-0xefffffff window]
> <7>[    1.441133] pci_bus 0000:01: resource 1 [mem 0x91300000-0x913fffff]
> <7>[    1.441140] pci_bus 0000:02: resource 1 [mem 0x91200000-0x912fffff]
> <7>[    1.441146] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
> <7>[    1.441151] pci_bus 0000:03: resource 1 [mem 0x91100000-0x911fffff]
> <6>[    1.443612] NET: Registered protocol family 2
> <6>[    1.445628] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
> <6>[    1.446086] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
> <6>[    1.463163] TCP: Hash tables configured (established 65536 bind 65536)
> <6>[    1.463834] UDP hash table entries: 4096 (order: 7, 655360 bytes)
> <6>[    1.466288] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
> <6>[    1.469774] NET: Registered protocol family 1
> <6>[    1.469891] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> <7>[    1.476964] PCI: CLS 0 bytes, default 64
> <6>[    1.478102] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> <6>[    1.478154] software IO TLB [mem 0x6f165000-0x73165000] (64MB) mapped at [0000000009a3761f-0000000040abd890]
> <6>[    1.478786] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> <6>[    1.478841] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> <6>[    1.478880] RAPL PMU: hw unit of domain package 2^-14 Joules
> <6>[    1.478916] RAPL PMU: hw unit of domain dram 2^-14 Joules
> <6>[    1.478952] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> <6>[    1.479426] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x159647815e3, max_idle_ns: 440795269835 ns
> <6>[    1.479583] clocksource: Switched to clocksource tsc
> <6>[    1.495756] workingset: timestamp_bits=46 max_order=21 bucket_order=0
> <6>[    1.550382] ntfs: driver 2.1.32 [Flags: R/O].
> <6>[    1.589502] NET: Registered protocol family 38
> <6>[    1.590234] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> <6>[    1.590306] io scheduler noop registered
> <6>[    1.591232] io scheduler cfq registered (default)
> <6>[    1.591269] io scheduler mq-deadline registered
> <6>[    1.591303] io scheduler kyber registered
> <6>[    1.608081] pcieport 0000:00:13.0: Signaling PME with IRQ 120
> <6>[    1.608414] pcieport 0000:00:13.1: Signaling PME with IRQ 121
> <6>[    1.608752] pcieport 0000:00:13.2: Signaling PME with IRQ 122
> <3>[    1.610321] uvesafb: failed to execute /sbin/v86d
> <3>[    1.610364] uvesafb: make sure that the v86d helper is installed and executable
> <3>[    1.610427] uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)
> <3>[    1.610488] uvesafb: vbe_init() failed with -22
> <4>[    1.610603] uvesafb: probe of uvesafb.0 failed with error -22
> <7>[    1.610866] intel_idle: Please enable MWAIT in BIOS SETUP
> <6>[    1.612169] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> <6>[    1.612691] ACPI: Power Button [PWRB]
> <6>[    1.613469] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> <6>[    1.613679] ACPI: Sleep Button [SLPB]
> <6>[    1.614436] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> <6>[    1.614620] ACPI: Power Button [PWRF]
> <4>[    1.684405] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> <6>[    1.712236] thermal LNXTHERM:00: registered as thermal_zone0
> <6>[    1.712287] ACPI: Thermal Zone [TZ01] (85 C)
> <6>[    1.713758] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> <6>[    1.721886] Non-volatile memory driver v1.3
> <6>[    1.722819] Linux agpgart interface v0.103
> <6>[    1.729176] loop: module loaded
> <6>[    1.793931] dw-apb-uart.1: ttyS0 at MMIO 0x91420000 (irq = 4, base_baud = 115200) is a 16550A
> <7>[    1.813971] ahci 0000:00:12.0: version 3.0
> <6>[    1.828656] ahci 0000:00:12.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> <6>[    1.828729] ahci 0000:00:12.0: flags: 64bit ncq sntf pm clo only pmp pio slum part deso sadm sds apst
> <6>[    1.835388] scsi host0: ahci
> <6>[    1.838602] scsi host1: ahci
> <6>[    1.839593] ata1: SATA max UDMA/133 abar m2048@0x91423000 port 0x91423100 irq 123
> <6>[    1.839653] ata2: SATA max UDMA/133 abar m2048@0x91423000 port 0x91423180 irq 123
> <6>[    1.840345] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> <6>[    1.840437] ehci-pci: EHCI PCI platform driver
> <6>[    1.840605] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> <6>[    1.840676] ohci-pci: OHCI PCI platform driver
> <6>[    1.840831] uhci_hcd: USB Universal Host Controller Interface driver
> <6>[    1.845413] xhci_hcd 0000:00:15.0: xHCI Host Controller
> <6>[    1.845686] xhci_hcd 0000:00:15.0: new USB bus registered, assigned bus number 1
> <6>[    1.847383] xhci_hcd 0000:00:15.0: hcc params 0x200077c1 hci version 0x100 quirks 0x01109810
> <7>[    1.847463] xhci_hcd 0000:00:15.0: cache line size of 64 is not supported
> <6>[    1.849916] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> <6>[    1.849988] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> <6>[    1.850081] usb usb1: Product: xHCI Host Controller
> <6>[    1.850125] usb usb1: Manufacturer: Linux 4.15.0-CI-CI_DRM_3731+ xhci-hcd
> <6>[    1.850180] usb usb1: SerialNumber: 0000:00:15.0
> <6>[    1.853099] hub 1-0:1.0: USB hub found
> <6>[    1.853444] hub 1-0:1.0: 8 ports detected
> <6>[    1.870375] xhci_hcd 0000:00:15.0: xHCI Host Controller
> <6>[    1.870476] xhci_hcd 0000:00:15.0: new USB bus registered, assigned bus number 2
> <6>[    1.871600] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
> <6>[    1.871659] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> <6>[    1.871718] usb usb2: Product: xHCI Host Controller
> <6>[    1.871761] usb usb2: Manufacturer: Linux 4.15.0-CI-CI_DRM_3731+ xhci-hcd
> <6>[    1.871814] usb usb2: SerialNumber: 0000:00:15.0
> <6>[    1.874329] hub 2-0:1.0: USB hub found
> <6>[    1.874615] hub 2-0:1.0: 7 ports detected
> <6>[    1.889799] usbcore: registered new interface driver usb-storage
> <6>[    1.890645] i8042: PNP: No PS/2 controller found.
> <6>[    1.890682] i8042: Probing ports directly.
> <6>[    1.907622] serio: i8042 KBD port at 0x60,0x64 irq 1
> <6>[    1.908647] serio: i8042 AUX port at 0x60,0x64 irq 12
> <6>[    1.910107] mousedev: PS/2 mouse device common for all mice
> <6>[    1.913038] rtc_cmos 00:04: RTC can wake from S4
> <6>[    1.914552] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
> <6>[    1.914760] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> <6>[    1.915055] IR NEC protocol handler initialized
> <6>[    1.915090] IR RC5(x/sz) protocol handler initialized
> <6>[    1.915125] IR RC6 protocol handler initialized
> <6>[    1.915156] IR JVC protocol handler initialized
> <6>[    1.915187] IR Sony protocol handler initialized
> <6>[    1.915219] IR SANYO protocol handler initialized
> <6>[    1.915251] IR Sharp protocol handler initialized
> <6>[    1.915283] IR MCE Keyboard/mouse protocol handler initialized
> <6>[    1.915321] IR XMP protocol handler initialized
> <6>[    1.916783] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=5 (nowayout=0)
> <6>[    1.918727] device-mapper: uevent: version 1.0.3
> <6>[    1.920538] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
> <6>[    1.920610] intel_pstate: Intel P-state driver initializing
> <6>[    1.923241] sdhci: Secure Digital Host Controller Interface driver
> <6>[    1.923325] sdhci: Copyright(c) Pierre Ossman
> <6>[    1.928914] input: AT Raw Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
> <6>[    1.935722] EFI Variables Facility v0.08 2004-May-17
> <6>[    1.974763] pstore: using zlib compression
> <6>[    1.974816] pstore: Registered efi as persistent store backend
> <6>[    1.975030] hidraw: raw HID events driver (C) Jiri Kosina
> <6>[    1.976085] usbcore: registered new interface driver usbhid
> <6>[    1.976113] usbhid: USB HID core driver
> <6>[    1.977012] intel_rapl: Found RAPL domain package
> <6>[    1.977089] intel_rapl: Found RAPL domain core
> <6>[    1.977114] intel_rapl: Found RAPL domain uncore
> <6>[    1.977139] intel_rapl: Found RAPL domain dram
> <6>[    1.981487] Initializing XFRM netlink socket
> <6>[    1.983962] NET: Registered protocol family 10
> <6>[    1.987531] Segment Routing with IPv6
> <6>[    1.987645] mip6: Mobile IPv6
> <6>[    1.987699] NET: Registered protocol family 17
> <6>[    1.987756] NET: Registered protocol family 15
> <7>[    1.987782] start plist test
> <7>[    1.989950] end plist test
> <6>[    1.992724] SSE version of gcm_enc/dec engaged.
> <6>[    2.027724] alg: No test for pcbc(aes) (pcbc-aes-aesni)
> <6>[    2.027968] sched_clock: Marking stable (2027855179, 0)->(2031492047, -3636868)
> <6>[    2.031190] registered taskstats version 1
> <6>[    2.040839] Btrfs loaded, crc32c=crc32c-generic
> <6>[    2.048848] rtc_cmos 00:04: setting system clock to 2018-02-07 10:21:18 UTC (1517998878)
> <6>[    2.050163] ALSA device list:
> <6>[    2.050181]   No soundcards found.
> <6>[    2.149331] ata2: SATA link down (SStatus 4 SControl 300)
> <6>[    2.196483] usb 1-8: new full-speed USB device number 2 using xhci_hcd
> <6>[    2.311397] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> <6>[    2.313428] ata1.00: ATA-9: INTEL SSDSC2CW240A3, 400i, max UDMA/133
> <6>[    2.313527] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> <6>[    2.323384] ata1.00: configured for UDMA/133
> <5>[    2.327283] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2CW24 400i PQ: 0 ANSI: 5
> <6>[    2.327549] usb 1-8: New USB device found, idVendor=8087, idProduct=0aa7
> <6>[    2.327670] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> <5>[    2.334677] sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
> <5>[    2.334849] sd 0:0:0:0: [sda] Write Protect is off
> <7>[    2.334878] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> <5>[    2.335154] sd 0:0:0:0: Attached scsi generic sg0 type 0
> <5>[    2.335172] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> <6>[    2.343565]  sda: sda1 sda2
> <5>[    2.347600] sd 0:0:0:0: [sda] Attached SCSI disk
> <6>[    2.347981] md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
> <3>[    2.349336] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
> <3>[    2.350624] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
> <6>[    2.418990] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> <6>[    2.419176] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
> <6>[    2.421990] devtmpfs: mounted
> <6>[    2.425764] Freeing unused kernel memory: 1216K
> <6>[    2.425796] Write protecting the kernel read-only data: 18432k
> <6>[    2.428381] Freeing unused kernel memory: 2008K
> <6>[    2.430311] Freeing unused kernel memory: 456K
> <7>[    2.675613] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> <7>[    2.688578] systemd[1]: Detected architecture x86-64.
> <7>[    2.690748] systemd[1]: Set hostname to <apl5>.
> <7>[    2.965182] systemd[1]: cups.socket: Cannot add dependency job, ignoring: Unit cups.socket is masked.
> <7>[    2.965285] systemd[1]: cups-browsed.service: Cannot add dependency job, ignoring: Unit cups-browsed.service is masked.
> <7>[    2.965456] systemd[1]: cups.path: Cannot add dependency job, ignoring: Unit cups.path is masked.
> <7>[    2.967434] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
> <7>[    2.969871] systemd[1]: Created slice User and Session Slice.
> <7>[    2.970886] systemd[1]: Listening on Journal Socket.
> <7>[    2.971536] systemd[1]: Listening on fsck to fsckd communication Socket.
> <6>[    3.531239] EXT4-fs (sda2): re-mounted. Opts: errors=panic
> <7>[    3.583627] systemd-journald[183]: Received request to flush runtime journal from PID 1
> <6>[    3.974325] Adding 2097148k swap on /swapfile.  Priority:-2 extents:6 across:2260988k SSFS
> <6>[    4.479513] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> <6>[    4.501302] r8169 0000:03:00.0 eth0: RTL8168h/8111h at 0x000000003e1df49a, f4:4d:30:6b:c4:04, XID 14100800 IRQ 126
> <6>[    4.501310] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> <5>[    4.509741] lpc_ich 0000:00:1f.0: I/O space for ACPI uninitialized
> <2>[    4.619980] CPU2: Package temperature above threshold, cpu clock throttled (total events = 1)
> <2>[    4.619983] CPU3: Package temperature above threshold, cpu clock throttled (total events = 1)
> <2>[    4.619988] CPU1: Core temperature above threshold, cpu clock throttled (total events = 1)
> <2>[    4.619990] CPU0: Core temperature above threshold, cpu clock throttled (total events = 1)
> <2>[    4.619996] CPU0: Package temperature above threshold, cpu clock throttled (total events = 1)
> <2>[    4.620197] CPU1: Package temperature above threshold, cpu clock throttled (total events = 1)
> <6>[    4.621024] CPU0: Core temperature/speed normal
> <6>[    4.621032] CPU2: Package temperature/speed normal
> <6>[    4.621034] CPU3: Package temperature/speed normal
> <6>[    4.621035] CPU1: Core temperature/speed normal
> <6>[    4.621040] CPU0: Package temperature/speed normal
> <6>[    4.621041] CPU1: Package temperature/speed normal
> 
> <4>[    4.789553] **********************************************************
> <4>[    4.789556] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> <4>[    4.789559] **                                                      **
> <4>[    4.789562] ** trace_printk() being used. Allocating extra memory.  **
> <4>[    4.789566] **                                                      **
> <4>[    4.789569] ** This means that this is a DEBUG kernel and it is     **
> <4>[    4.789572] ** unsafe for production use.                           **
> <4>[    4.789575] **                                                      **
> <4>[    4.789578] ** If you see this message and you are not debugging    **
> <4>[    4.789581] ** the kernel, report this immediately to your vendor!  **
> <4>[    4.789584] **                                                      **
> <4>[    4.789587] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> <4>[    4.789590] **********************************************************
> <7>[    4.836427] [drm:i915_driver_load [i915]] No PCH found.
> <7>[    4.836493] [drm:intel_power_domains_init [i915]] Allowed DC state mask 09
> <7>[    4.843909] [drm:i915_driver_load [i915]] ppgtt mode: 3
> <7>[    4.843981] [drm:intel_uc_sanitize_options [i915]] enable_guc=0 (submission:no huc:no)
> <7>[    4.844115] [drm:intel_uc_sanitize_options [i915]] guc_log_level=0 (enabled:no verbosity:-1)
> <7>[    4.844337] [drm:i915_ggtt_probe_hw [i915]] GGTT size = 4096M
> <7>[    4.844397] [drm:i915_ggtt_probe_hw [i915]] GMADR size = 256M
> <7>[    4.844456] [drm:i915_ggtt_probe_hw [i915]] DSM size = 64M
> <6>[    4.844577] [drm] Replacing VGA console driver
> <7>[    4.844806] [drm:i915_gem_init_stolen [i915]] Memory reserved for graphics device: 65536K, usable: 64512K
> <7>[    4.845028] [drm:intel_opregion_setup [i915]] graphic opregion physical addr: 0x7987d018
> <7>[    4.845244] [drm:intel_opregion_setup [i915]] Public ACPI methods supported
> <7>[    4.845308] [drm:intel_opregion_setup [i915]] ASLE supported
> <7>[    4.845415] [drm:intel_opregion_setup [i915]] Found valid VBT in ACPI OpRegion (RVDA)
> <7>[    4.845902] [drm:intel_gvt_init [i915]] GVT-g is disabled by kernel params
> <6>[    4.845929] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> <6>[    4.845933] [drm] Driver supports precise vblank timestamp query.
> <7>[    4.846001] [drm:intel_bios_init [i915]] Set default to SSC at 100000 kHz
> <7>[    4.846115] [drm:intel_bios_init [i915]] VBT signature "$VBT BROXTON        ", BDB version 207
> <7>[    4.846180] [drm:intel_bios_init [i915]] BDB_GENERAL_FEATURES int_tv_support 0 int_crt_support 0 lvds_use_ssc 0 lvds_ssc_freq 120000 display_clock_mode 1 fdi_rx_polarity_inverted 0
> <7>[    4.846243] [drm:intel_bios_init [i915]] crt_ddc_bus_pin: 2
> <7>[    4.846325] [drm:intel_opregion_get_panel_type [i915]] Failed to get panel details from OpRegion (-19)
> <7>[    4.846390] [drm:intel_bios_init [i915]] Panel type: 0 (VBT)
> <7>[    4.846453] [drm:intel_bios_init [i915]] DRRS supported mode is static
> <7>[    4.846533] [drm:intel_bios_init [i915]] Found panel mode in BIOS VBT tables:
> <7>[    4.846542] [drm:drm_mode_debug_printmodeline] Modeline 0:"1920x1200" 0 148350 1920 1960 2000 2040 1200 1204 1208 1212 0x8 0xa
> <7>[    4.846607] [drm:intel_bios_init [i915]] VBT backlight PWM modulation frequency 200 Hz, active high, min brightness 0, level 255, controller 1
> <7>[    4.846671] [drm:intel_bios_init [i915]] DRRS State Enabled:1
> <7>[    4.846736] [drm:intel_bios_init [i915]] Skipping SDVO device mapping
> <7>[    4.846801] [drm:intel_bios_init [i915]] Port B VBT info: DP:1 HDMI:1 DVI:1 EDP:0 CRT:0
> <7>[    4.846865] [drm:intel_bios_init [i915]] VBT HDMI level shift for port B: 0
> <7>[    4.846929] [drm:intel_bios_init [i915]] Port C VBT info: DP:1 HDMI:0 DVI:0 EDP:0 CRT:0
> <7>[    4.846992] [drm:intel_bios_init [i915]] VBT HDMI level shift for port C: 0
> <7>[    4.847915] [drm:intel_dsm_detect [i915]] no _DSM method for intel device
> <7>[    4.848000] [drm:gen9_set_dc_state [i915]] Setting DC state from 00 to 00
> <7>[    4.848235] [drm:intel_power_well_enable [i915]] enabling power well 1
> <7>[    4.848341] [drm:intel_dump_cdclk_state [i915]] Current CDCLK 624000 kHz, VCO 1248000 kHz, ref 19200 kHz, bypass 19200 kHz, voltage level 25
> <7>[    4.848419] [drm:intel_power_well_enable [i915]] enabling always-on
> <7>[    4.848477] [drm:intel_power_well_enable [i915]] enabling DC off
> <7>[    4.848536] [drm:gen9_set_dc_state [i915]] Setting DC state from 00 to 00
> <7>[    4.848607] [drm:intel_power_well_enable [i915]] enabling power well 2
> <6>[    4.848637] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> <7>[    4.848804] [drm:intel_power_well_enable [i915]] enabling dpio-common-a
> <7>[    4.849347] [drm:intel_power_well_enable [i915]] enabling dpio-common-bc
> <7>[    4.849473] [drm:intel_power_well_enable [i915]] DDI PHY 0 already enabled, won't reprogram it
> <7>[    4.849566] [drm:intel_csr_ucode_init [i915]] Loading i915/bxt_dmc_ver1_07.bin
> <6>[    4.855051] [drm] Finished loading DMC firmware i915/bxt_dmc_ver1_07.bin (v1.7)
> <7>[    4.855249] [drm:__bxt_hpd_detection_setup [i915]] Invert bit setting: hp_ctl:10001818 hp_port:38
> <7>[    4.859132] [drm:intel_fbc_init [i915]] Sanitized enable_fbc value: 1
> <7>[    4.859215] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM0 latency 7 (7.0 usec)
> <7>[    4.859272] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM1 latency 7 (7.0 usec)
> <7>[    4.859328] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM2 latency 8 (8.0 usec)
> <7>[    4.859384] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM3 latency 22 (22.0 usec)
> <7>[    4.859440] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM4 latency 22 (22.0 usec)
> <7>[    4.859497] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM5 latency 22 (22.0 usec)
> <7>[    4.859553] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM6 latency 22 (22.0 usec)
> <7>[    4.859609] [drm:intel_print_wm_latency [i915]] Gen9 Plane WM7 latency 22 (22.0 usec)
> <7>[    4.859674] [drm:intel_modeset_init [i915]] 3 display pipes available.
> <7>[    4.860991] [drm:intel_dump_cdclk_state [i915]] Current CDCLK 624000 kHz, VCO 1248000 kHz, ref 19200 kHz, bypass 19200 kHz, voltage level 25
> <7>[    4.861060] [drm:intel_update_max_cdclk [i915]] Max CD clock rate: 624000 kHz
> <7>[    4.861155] [drm:intel_modeset_init [i915]] Max dotclock rate: 624000 kHz
> <7>[    4.861539] [drm:intel_modeset_init [i915]] VBT says port A is not DVI/HDMI/DP compatible, respect it
> <7>[    4.861606] [drm:intel_ddi_init [i915]] VBT says port B has lspcon
> <7>[    4.861754] [drm:intel_ddi_init [i915]] Forcing DDI_A_4_LANES for port A
> <7>[    4.861861] [drm:intel_dp_init_connector [i915]] Adding DP connector on port B
> <7>[    4.862048] [drm:intel_dp_init_connector [i915]] using AUX B for port B (VBT)
> <7>[    4.865392] [drm:lspcon_wake_native_aux_ch [i915]] Native AUX CH up, DPCD version: 1.2
> <7>[    4.865885] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.867201] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.868546] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.869822] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.871240] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.872088] [drm:drm_dp_dual_mode_detect] DP dual mode HDMI ID: DP-HDMI ADAPTOR\004 (err 0)
> <7>[    4.872563] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.873862] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.875176] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.876522] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.877821] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.878657] [drm:drm_dp_dual_mode_detect] DP dual mode adaptor ID: a8 (err 0)
> <7>[    4.878750] [drm:lspcon_init [i915]] LSPCON detected
> <7>[    4.879240] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.880584] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.881876] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.883154] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.884443] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.885328] [drm:lspcon_wait_mode [i915]] Current LSPCON mode PCON
> <7>[    4.885903] [drm:intel_dp_read_dpcd [i915]] DPCD: 12 14 c4 01 01 15 00 01 00 00 04 00 0f 00 04
> <7>[    4.886404] [drm:drm_dp_read_desc] DP branch: OUI 00-60-ad dev-ID MC2800 HW-rev 2.2 SW-rev 1.60 quirks 0x0000
> <7>[    4.886489] [drm:lspcon_init [i915]] Success: LSPCON init
> <7>[    4.886557] [drm:intel_modeset_init [i915]] LSPCON init success on port B
> <7>[    4.886673] [drm:intel_ddi_init [i915]] Forcing DDI_A_4_LANES for port A
> <7>[    4.886768] [drm:intel_dp_init_connector [i915]] Adding DP connector on port C
> <7>[    4.886853] [drm:intel_dp_init_connector [i915]] using AUX C for port C (VBT)
> <7>[    4.887199] [drm:intel_dsi_init [i915]]
> <7>[    4.887618] [drm:intel_modeset_setup_hw_state [i915]] pipe A active planes 0x1
> <7>[    4.887698] [drm:intel_modeset_setup_hw_state [i915]] pipe A active planes 0x1
> <7>[    4.887767] [drm:intel_modeset_setup_hw_state [i915]] pipe A active planes 0x1
> <7>[    4.887836] [drm:intel_modeset_setup_hw_state [i915]] pipe A active planes 0x1
> <7>[    4.887903] [drm:intel_modeset_setup_hw_state [i915]] [CRTC:40:pipe A] hw state readout: enabled
> <7>[    4.887982] [drm:intel_modeset_setup_hw_state [i915]] pipe B active planes 0x0
> <7>[    4.888051] [drm:intel_modeset_setup_hw_state [i915]] pipe B active planes 0x0
> <7>[    4.888156] [drm:intel_modeset_setup_hw_state [i915]] pipe B active planes 0x0
> <7>[    4.888224] [drm:intel_modeset_setup_hw_state [i915]] pipe B active planes 0x0
> <7>[    4.888290] [drm:intel_modeset_setup_hw_state [i915]] [CRTC:53:pipe B] hw state readout: disabled
> <7>[    4.888370] [drm:intel_modeset_setup_hw_state [i915]] pipe C active planes 0x0
> <7>[    4.888438] [drm:intel_modeset_setup_hw_state [i915]] pipe C active planes 0x0
> <7>[    4.888507] [drm:intel_modeset_setup_hw_state [i915]] pipe C active planes 0x0
> <7>[    4.888572] [drm:intel_modeset_setup_hw_state [i915]] [CRTC:63:pipe C] hw state readout: disabled
> <7>[    4.888643] [drm:intel_modeset_setup_hw_state [i915]] PORT PLL A hw state readout: crtc_mask 0x00000000, on 0
> <7>[    4.888711] [drm:intel_modeset_setup_hw_state [i915]] PORT PLL B hw state readout: crtc_mask 0x00000000, on 0
> <7>[    4.888844] [drm:intel_modeset_setup_hw_state [i915]] PORT PLL C hw state readout: crtc_mask 0x00000001, on 1
> <7>[    4.888914] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:64:DDI B] hw state readout: disabled, pipe A
> <7>[    4.888980] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:66:DP-MST A] hw state readout: disabled, pipe A
> <7>[    4.889047] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:67:DP-MST B] hw state readout: disabled, pipe B
> <7>[    4.889142] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:68:DP-MST C] hw state readout: disabled, pipe C
> <7>[    4.889257] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:72:DDI C] hw state readout: enabled, pipe A
> <7>[    4.889322] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:74:DP-MST A] hw state readout: disabled, pipe A
> <7>[    4.889388] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:75:DP-MST B] hw state readout: disabled, pipe B
> <7>[    4.889454] [drm:intel_modeset_setup_hw_state [i915]] [ENCODER:76:DP-MST C] hw state readout: disabled, pipe C
> <7>[    4.889686] [drm:intel_modeset_setup_hw_state [i915]] [CONNECTOR:65:DP-1] hw state readout: disabled
> <7>[    4.889773] [drm:intel_modeset_setup_hw_state [i915]] [CONNECTOR:73:DP-2] hw state readout: enabled
> <7>[    4.890198] [drm:intel_dump_pipe_config [i915]] [CRTC:40:pipe A][setup_hw_state]
> <7>[    4.890267] [drm:intel_dump_pipe_config [i915]] output_types: DP (0x80)
> <7>[    4.890333] [drm:intel_dump_pipe_config [i915]] cpu_transcoder: A, pipe bpp: 24, dithering: 0
> <7>[    4.890400] [drm:intel_dump_pipe_config [i915]] dp m_n: lanes: 2; gmch_m: 3029219, gmch_n: 8388608, link_m: 126217, link_n: 524288, tu: 64
> <7>[    4.890466] [drm:intel_dump_pipe_config [i915]] audio: 0, infoframes: 0
> <7>[    4.890531] [drm:intel_dump_pipe_config [i915]] requested mode:
> <7>[    4.890540] [drm:drm_mode_debug_printmodeline] Modeline 0:"1024x768" 60 64999 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> <7>[    4.890604] [drm:intel_dump_pipe_config [i915]] adjusted mode:
> <7>[    4.890612] [drm:drm_mode_debug_printmodeline] Modeline 0:"1024x768" 60 64999 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> <7>[    4.890680] [drm:intel_dump_pipe_config [i915]] crtc timings: 64999 1024 1048 1184 1344 768 771 777 806, type: 0x40 flags: 0xa
> <7>[    4.890746] [drm:intel_dump_pipe_config [i915]] port clock: 270000, pipe src size: 1024x768, pixel rate 64999
> <7>[    4.890811] [drm:intel_dump_pipe_config [i915]] num_scalers: 2, scaler_users: 0x80000000, scaler_id: 0
> <7>[    4.890877] [drm:intel_dump_pipe_config [i915]] pch pfit: pos: 0x00000000, size: 0x04000300, enabled
> <7>[    4.890942] [drm:intel_dump_pipe_config [i915]] ips: 0, double wide: 0
> <7>[    4.891011] [drm:bxt_dump_hw_state [i915]] dpll_hw_state: ebb0: 0x8100, ebb4: 0x2000,pll0: 0x1b, pll1: 0x100, pll2: 0x0, pll3: 0x0, pll6: 0x10803, pll8: 0x9, pll9: 0xa, pll10: 0x8003c00, pcsdw12: 0x4d
> <7>[    4.891112] [drm:intel_dump_pipe_config [i915]] planes on this crtc
> <7>[    4.891178] [drm:intel_dump_pipe_config [i915]] [PLANE:28:plane 1A] disabled, scaler_id = -1
> <7>[    4.891244] [drm:intel_dump_pipe_config [i915]] [PLANE:31:plane 2A] disabled, scaler_id = -1
> <7>[    4.891310] [drm:intel_dump_pipe_config [i915]] [PLANE:34:plane 3A] disabled, scaler_id = -1
> <7>[    4.891376] [drm:intel_dump_pipe_config [i915]] [PLANE:37:cursor A] disabled, scaler_id = -1
> <7>[    4.891444] [drm:intel_dump_pipe_config [i915]] [CRTC:53:pipe B][setup_hw_state]
> <7>[    4.891509] [drm:intel_dump_pipe_config [i915]] output_types:  (0x0)
> <7>[    4.891575] [drm:intel_dump_pipe_config [i915]] cpu_transcoder: B, pipe bpp: 0, dithering: 0
> <7>[    4.891641] [drm:intel_dump_pipe_config [i915]] audio: 0, infoframes: 0
> <7>[    4.891706] [drm:intel_dump_pipe_config [i915]] requested mode:
> <7>[    4.891714] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
> <7>[    4.891778] [drm:intel_dump_pipe_config [i915]] adjusted mode:
> <7>[    4.891785] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
> <7>[    4.891850] [drm:intel_dump_pipe_config [i915]] crtc timings: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
> <7>[    4.891915] [drm:intel_dump_pipe_config [i915]] port clock: 0, pipe src size: 0x0, pixel rate 0
> <7>[    4.891982] [drm:intel_dump_pipe_config [i915]] num_scalers: 2, scaler_users: 0x0, scaler_id: -1
> <7>[    4.892049] [drm:intel_dump_pipe_config [i915]] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
> <7>[    4.892142] [drm:intel_dump_pipe_config [i915]] ips: 0, double wide: 0
> <7>[    4.892208] [drm:bxt_dump_hw_state [i915]] dpll_hw_state: ebb0: 0x0, ebb4: 0x0,pll0: 0x0, pll1: 0x0, pll2: 0x0, pll3: 0x0, pll6: 0x0, pll8: 0x0, pll9: 0x0, pll10: 0x0, pcsdw12: 0x0
> <7>[    4.892273] [drm:intel_dump_pipe_config [i915]] planes on this crtc
> <7>[    4.892340] [drm:intel_dump_pipe_config [i915]] [PLANE:41:plane 1B] disabled, scaler_id = -1
> <7>[    4.892406] [drm:intel_dump_pipe_config [i915]] [PLANE:44:plane 2B] disabled, scaler_id = -1
> <7>[    4.892471] [drm:intel_dump_pipe_config [i915]] [PLANE:47:plane 3B] disabled, scaler_id = -1
> <7>[    4.892536] [drm:intel_dump_pipe_config [i915]] [PLANE:50:cursor B] disabled, scaler_id = -1
> <7>[    4.892604] [drm:intel_dump_pipe_config [i915]] [CRTC:63:pipe C][setup_hw_state]
> <7>[    4.892670] [drm:intel_dump_pipe_config [i915]] output_types:  (0x0)
> <7>[    4.892736] [drm:intel_dump_pipe_config [i915]] cpu_transcoder: C, pipe bpp: 0, dithering: 0
> <7>[    4.892801] [drm:intel_dump_pipe_config [i915]] audio: 0, infoframes: 0
> <7>[    4.892865] [drm:intel_dump_pipe_config [i915]] requested mode:
> <7>[    4.892874] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
> <7>[    4.892938] [drm:intel_dump_pipe_config [i915]] adjusted mode:
> <7>[    4.892945] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
> <7>[    4.893013] [drm:intel_dump_pipe_config [i915]] crtc timings: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
> <7>[    4.893112] [drm:intel_dump_pipe_config [i915]] port clock: 0, pipe src size: 0x0, pixel rate 0
> <7>[    4.893177] [drm:intel_dump_pipe_config [i915]] num_scalers: 1, scaler_users: 0x0, scaler_id: -1
> <7>[    4.893243] [drm:intel_dump_pipe_config [i915]] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
> <7>[    4.893309] [drm:intel_dump_pipe_config [i915]] ips: 0, double wide: 0
> <7>[    4.893376] [drm:bxt_dump_hw_state [i915]] dpll_hw_state: ebb0: 0x0, ebb4: 0x0,pll0: 0x0, pll1: 0x0, pll2: 0x0, pll3: 0x0, pll6: 0x0, pll8: 0x0, pll9: 0x0, pll10: 0x0, pcsdw12: 0x0
> <7>[    4.893441] [drm:intel_dump_pipe_config [i915]] planes on this crtc
> <7>[    4.893507] [drm:intel_dump_pipe_config [i915]] [PLANE:54:plane 1C] disabled, scaler_id = -1
> <7>[    4.893572] [drm:intel_dump_pipe_config [i915]] [PLANE:57:plane 2C] disabled, scaler_id = -1
> <7>[    4.893639] [drm:intel_dump_pipe_config [i915]] [PLANE:60:cursor C] disabled, scaler_id = -1
> <7>[    4.893869] [drm:intel_power_well_disable [i915]] disabling dpio-common-a
> <7>[    4.894030] [drm:skylake_get_initial_plane_config [i915]] pipe A/plane 1A with fb: size=1024x768@32, offset=0, pitch 4096, size 0x300000
> <7>[    4.894203] [drm:i915_gem_object_create_stolen_for_preallocated [i915]] creating preallocated stolen object: stolen_offset=0x0000000000000000, gtt_offset=0x0000000000000000, size=0x0000000000300000
> <7>[    4.894395] [drm:i915_gem_object_create_stolen_for_preallocated [i915]] failed to allocate stolen space
> <7>[    4.894488] [drm:intel_plane_disable_noatomic [i915]] pipe A active planes 0x0
> <7>[    4.900057] [drm:i915_gem_init_ggtt [i915]] clearing unused GTT space: [1000, 100000000]
> <7>[    4.901410] [drm:i915_gem_contexts_init [i915]] logical context support initialized
> <7>[    4.901876] [drm:intel_engine_create_scratch [i915]] rcs0 pipe control offset: 0xfffff000
> <7>[    4.907564] [drm:intel_engine_init_common [i915]] rcs0 hws offset: 0x00003000
> <7>[    4.909405] [drm:intel_engine_init_common [i915]] bcs0 hws offset: 0x00006000
> <7>[    4.910931] [drm:intel_engine_init_common [i915]] vcs0 hws offset: 0x00009000
> <7>[    4.912388] [drm:intel_engine_init_common [i915]] vecs0 hws offset: 0x0000c000
> <7>[    4.912458] [drm:intel_init_gt_powersave [i915]] BIOS enabled RC states: HW_CTRL off HW_RC6 off SW_TARGET_STATE 4
> <7>[    4.912881] [drm:init_workarounds_ring [i915]] rcs0: Number of context specific w/a: 12
> <7>[    4.917066] [drm:intel_fbdev_init [i915]] pipe A not active or no fb, skipping
> <7>[    4.917168] [drm:intel_fbdev_init [i915]] pipe B not active or no fb, skipping
> <7>[    4.917245] [drm:intel_fbdev_init [i915]] pipe C not active or no fb, skipping
> <7>[    4.917319] [drm:intel_fbdev_init [i915]] no active fbs found, not using BIOS config
> <7>[    4.917632] [drm:__bxt_hpd_detection_setup [i915]] Invert bit setting: hp_ctl:10001818 hp_port:30
> <7>[    4.931302] [drm:intel_dp_connector_register [i915]] registering DPDDC-B bus for card0-DP-1
> <7>[    4.933412] [drm:intel_dp_connector_register [i915]] registering DPDDC-C bus for card0-DP-2
> <6>[    4.934481] [drm] Initialized i915 1.6.0 20180207 for 0000:00:02.0 on minor 0
> <7>[    4.937270] [drm:intel_opregion_register [i915]] 2 outputs detected
> <6>[    4.963020] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> <7>[    4.976446] [drm:asle_work [i915]] bclp = 0x80000005
> <7>[    4.976555] [drm:asle_work [i915]] updating opregion backlight 5/255
> <7>[    4.981327] [drm:asle_work [i915]] bclp = 0x800000ff
> <7>[    4.981402] [drm:asle_work [i915]] updating opregion backlight 255/255
> <6>[    4.984065] acpi device:10: registered as cooling_device5
> <6>[    4.985521] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
> <6>[    4.988002] snd_hda_intel 0000:00:0e.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> <7>[    4.988119] i915 device info: pciid=0x5a85 rev=0x0b platform=BROXTON gen=9
> <7>[    4.988124] i915 device info: is_mobile: no
> <7>[    4.988128] i915 device info: is_lp: yes
> <7>[    4.988132] i915 device info: is_alpha_support: no
> <7>[    4.988135] i915 device info: has_64bit_reloc: yes
> <7>[    4.988139] i915 device info: has_aliasing_ppgtt: yes
> <7>[    4.988143] i915 device info: has_csr: yes
> <7>[    4.988146] i915 device info: has_ddi: yes
> <7>[    4.988150] i915 device info: has_dp_mst: yes
> <7>[    4.988154] i915 device info: has_reset_engine: yes
> <7>[    4.988157] i915 device info: has_fbc: yes
> <7>[    4.988161] i915 device info: has_fpga_dbg: yes
> <7>[    4.988165] i915 device info: has_full_ppgtt: yes
> <7>[    4.988168] i915 device info: has_full_48bit_ppgtt: yes
> <7>[    4.988172] i915 device info: has_gmch_display: no
> <7>[    4.988175] i915 device info: has_guc: yes
> <7>[    4.988179] i915 device info: has_guc_ct: no
> <7>[    4.988183] i915 device info: has_hotplug: yes
> <7>[    4.988187] i915 device info: has_l3_dpf: no
> <7>[    4.988193] [drm:drm_setup_crtcs]
> <7>[    4.988198] i915 device info: has_llc: no
> <7>[    4.988202] i915 device info: has_logical_ring_contexts: yes
> <7>[    4.988204] i915 device info: has_logical_ring_preemption: yes
> <7>[    4.988206] i915 device info: has_overlay: no
> <7>[    4.988209] i915 device info: has_pooled_eu: no
> <7>[    4.988214] i915 device info: has_psr: yes
> <7>[    4.988217] i915 device info: has_rc6: yes
> <7>[    4.988221] i915 device info: has_rc6p: no
> <7>[    4.988225] i915 device info: has_resource_streamer: yes
> <7>[    4.988228] i915 device info: has_runtime_pm: yes
> <7>[    4.988232] i915 device info: has_snoop: yes
> <7>[    4.988236] i915 device info: unfenced_needs_alignment: no
> <7>[    4.988239] i915 device info: cursor_needs_physical: no
> <7>[    4.988243] i915 device info: hws_needs_physical: no
> <7>[    4.988247] i915 device info: overlay_needs_physical: no
> <7>[    4.988251] i915 device info: supports_tv: no
> <7>[    4.988254] i915 device info: has_ipc: yes
> <7>[    4.988258] i915 device info: slice mask: 0001
> <7>[    4.988265] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:65:DP-1]
> <7>[    4.988270] i915 device info: slice total: 1
> <7>[    4.988272] i915 device info: subslice total: 2
> <7>[    4.988274] i915 device info: subslice mask 0006
> <7>[    4.988276] i915 device info: subslice per slice: 2
> <7>[    4.988278] i915 device info: EU total: 12
> <7>[    4.988283] i915 device info: EU per subslice: 6
> <7>[    4.988287] i915 device info: has slice power gating: no
> <7>[    4.988291] i915 device info: has subslice power gating: yes
> <7>[    4.988371] [drm:intel_dp_detect [i915]] [CONNECTOR:65:DP-1]
> <7>[    4.988374] i915 device info: has EU power gating: yes
> <7>[    4.988379] i915 device info: CS timestamp frequency: 19200 kHz
> <6>[    4.988382] [drm] DRM_I915_DEBUG enabled
> <6>[    4.988386] [drm] DRM_I915_DEBUG_GEM enabled
> <7>[    4.989065] [drm:lspcon_wake_native_aux_ch [i915]] Native AUX CH up, DPCD version: 1.2
> <7>[    4.989192] [drm:lspcon_resume [i915]] LSPCON recovering in PCON mode after 0 ms
> <7>[    4.989703] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.991064] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.992410] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.993719] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.995035] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    4.995945] [drm:lspcon_wait_mode [i915]] Current LSPCON mode PCON
> <7>[    4.996529] [drm:intel_dp_read_dpcd [i915]] DPCD: 12 14 c4 01 01 15 00 01 00 00 04 00 0f 00 04
> <7>[    4.996931] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:65:DP-1] status updated from unknown to disconnected
> <7>[    4.997250] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:65:DP-1] disconnected
> <7>[    4.997264] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:DP-2]
> <7>[    4.997355] [drm:intel_dp_detect [i915]] [CONNECTOR:73:DP-2]
> <7>[    4.998450] [drm:intel_dp_read_dpcd [i915]] DPCD: 11 0a 82 01 00 03 01 01 02 00 00 00 00 00 00
> <7>[    4.999471] [drm:intel_dp_print_rates [i915]] source rates: 162000, 216000, 243000, 270000, 324000, 432000, 540000
> <7>[    4.999540] [drm:intel_dp_print_rates [i915]] sink rates: 162000, 270000
> <7>[    4.999605] [drm:intel_dp_print_rates [i915]] common rates: 162000, 270000
> <7>[    5.000108] [drm:drm_dp_read_desc] DP branch: OUI 00-00-00 dev-ID  HW-rev 0.0 SW-rev 0.0 quirks 0x0000
> <7>[    5.000199] [drm:intel_dp_detect [i915]] Sink is not MST capable
> <7>[    5.005366] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:DP-2] status updated from unknown to connected
> <7>[    5.005391] [drm:drm_add_display_info] non_desktop set to 0
> <7>[    5.005434] [drm:drm_add_edid_modes] ELD: no CEA Extension found
> <7>[    5.005440] [drm:drm_add_display_info] non_desktop set to 0
> <7>[    5.005685] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:DP-2] probed modes :
> <7>[    5.005704] [drm:drm_mode_debug_printmodeline] Modeline 80:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x48 0xa
> <7>[    5.005710] [drm:drm_mode_debug_printmodeline] Modeline 86:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa
> <7>[    5.005717] [drm:drm_mode_debug_printmodeline] Modeline 85:"1600x1200" 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
> <7>[    5.005723] [drm:drm_mode_debug_printmodeline] Modeline 87:"1680x1050" 60 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6
> <7>[    5.005729] [drm:drm_mode_debug_printmodeline] Modeline 88:"1400x1050" 60 121750 1400 1488 1632 1864 1050 1053 1057 1089 0x40 0x6
> <7>[    5.005735] [drm:drm_mode_debug_printmodeline] Modeline 90:"1600x900" 60 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5
> <7>[    5.005741] [drm:drm_mode_debug_printmodeline] Modeline 84:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> <7>[    5.005747] [drm:drm_mode_debug_printmodeline] Modeline 89:"1440x900" 60 106500 1440 1520 1672 1904 900 903 909 934 0x40 0x6
> <7>[    5.005753] [drm:drm_mode_debug_printmodeline] Modeline 82:"1280x960" 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> <7>[    5.005759] [drm:drm_mode_debug_printmodeline] Modeline 81:"1366x768" 60 85500 1366 1436 1579 1792 768 771 774 798 0x40 0x5
> <7>[    5.005765] [drm:drm_mode_debug_printmodeline] Modeline 83:"1280x720" 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> <7>[    5.005771] [drm:drm_mode_debug_printmodeline] Modeline 91:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> <7>[    5.005777] [drm:drm_mode_debug_printmodeline] Modeline 92:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> <7>[    5.005784] [drm:drm_setup_crtcs] connector 65 enabled? no
> <7>[    5.005789] [drm:drm_setup_crtcs] connector 73 enabled? yes
> <7>[    5.005927] [drm:intel_fb_initial_config [i915]] Not using firmware configuration
> <7>[    5.005952] [drm:drm_setup_crtcs] looking for cmdline mode on connector 73
> <7>[    5.005958] [drm:drm_setup_crtcs] looking for preferred mode on connector 73 0
> <7>[    5.005963] [drm:drm_setup_crtcs] found mode 1024x768
> <7>[    5.005967] [drm:drm_setup_crtcs] picking CRTCs for 8192x8192 config
> <7>[    5.005993] [drm:drm_setup_crtcs] desired mode 1024x768 set on crtc 40 (0,0)
> <7>[    5.006144] [drm:intelfb_create [i915]] no BIOS fb, allocating a new one
> <7>[    5.007587] [drm:intelfb_create [i915]] allocated 1024x768 fb: 0x00040000
> <6>[    5.010240] fbcon: inteldrmfb (fb0) is primary device
> <7>[    5.012838] [drm:intel_atomic_check [i915]] [CONNECTOR:73:DP-2] checking for sink bpp constrains
> <7>[    5.012911] [drm:intel_atomic_check [i915]] clamping display bpp (was 36) to default limit of 24
> <7>[    5.012979] [drm:intel_dp_compute_config [i915]] DP link computation with max lane count 2 max bw 270000 pixel clock 64999KHz
> <7>[    5.013051] [drm:intel_dp_compute_config [i915]] DP link bw 06 rate select 00 lane count 2 clock 162000 bpp 24
> <7>[    5.013174] [drm:intel_dp_compute_config [i915]] DP link bw required 194997 available 324000
> <7>[    5.013239] [drm:intel_atomic_check [i915]] hw max bpp: 36, pipe bpp: 24, dithering: 0
> <7>[    5.013305] [drm:intel_dump_pipe_config [i915]] [CRTC:40:pipe A][modeset]
> <7>[    5.013369] [drm:intel_dump_pipe_config [i915]] output_types: DP (0x80)
> <7>[    5.013433] [drm:intel_dump_pipe_config [i915]] cpu_transcoder: A, pipe bpp: 24, dithering: 0
> <7>[    5.013497] [drm:intel_dump_pipe_config [i915]] dp m_n: lanes: 2; gmch_m: 2524310, gmch_n: 4194304, link_m: 105179, link_n: 262144, tu: 64
> <7>[    5.013561] [drm:intel_dump_pipe_config [i915]] audio: 0, infoframes: 0
> <7>[    5.013624] [drm:intel_dump_pipe_config [i915]] requested mode:
> <7>[    5.013633] [drm:drm_mode_debug_printmodeline] Modeline 0:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x48 0xa
> <7>[    5.013696] [drm:intel_dump_pipe_config [i915]] adjusted mode:
> <7>[    5.013701] [drm:drm_mode_debug_printmodeline] Modeline 0:"1024x768" 60 64999 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> <7>[    5.013765] [drm:intel_dump_pipe_config [i915]] crtc timings: 64999 1024 1048 1184 1344 768 771 777 806, type: 0x40 flags: 0xa
> <7>[    5.013829] [drm:intel_dump_pipe_config [i915]] port clock: 162000, pipe src size: 1024x768, pixel rate 64999
> <7>[    5.013895] [drm:intel_dump_pipe_config [i915]] num_scalers: 2, scaler_users: 0x80000000, scaler_id: 0
> <7>[    5.013960] [drm:intel_dump_pipe_config [i915]] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
> <7>[    5.014024] [drm:intel_dump_pipe_config [i915]] ips: 0, double wide: 0
> <7>[    5.014131] [drm:bxt_dump_hw_state [i915]] dpll_hw_state: ebb0: 0x8100, ebb4: 0x2000,pll0: 0x1b, pll1: 0x100, pll2: 0x0, pll3: 0x0, pll6: 0x10803, pll8: 0x9, pll9: 0xa, pll10: 0x8003c00, pcsdw12: 0x4d
> <7>[    5.014195] [drm:intel_dump_pipe_config [i915]] planes on this crtc
> <7>[    5.014260] [drm:intel_dump_pipe_config [i915]] [PLANE:28:plane 1A] disabled, scaler_id = -1
> <7>[    5.014325] [drm:intel_dump_pipe_config [i915]] [PLANE:31:plane 2A] disabled, scaler_id = -1
> <7>[    5.014389] [drm:intel_dump_pipe_config [i915]] [PLANE:34:plane 3A] disabled, scaler_id = -1
> <7>[    5.014452] [drm:intel_dump_pipe_config [i915]] [PLANE:37:cursor A] disabled, scaler_id = -1
> <7>[    5.014526] [drm:intel_atomic_check [i915]] New cdclk calculated to be logical 144000 kHz, actual 144000 kHz
> <7>[    5.014590] [drm:intel_atomic_check [i915]] New voltage level calculated to be logical 6, actual 6
> <7>[    5.014666] [drm:bxt_get_dpll [i915]] [CRTC:40:pipe A] using pre-allocated PORT PLL C
> <7>[    5.014729] [drm:intel_reference_shared_dpll [i915]] using PORT PLL C for pipe A
> <7>[    5.014794] [drm:skl_update_scaler [i915]] scaler_user index 0.31: Staged freeing scaler id 0 scaler_users = 0x0
> <7>[    5.018608] [drm:intel_disable_pipe [i915]] disabling pipe A
> <7>[    5.028452] [drm:intel_disable_shared_dpll [i915]] disable PORT PLL C (active 1, on? 1) for crtc 40
> <7>[    5.028643] [drm:intel_disable_shared_dpll [i915]] disabling PORT PLL C
> <7>[    5.028729] [drm:intel_dump_cdclk_state [i915]] Changing CDCLK to 144000 kHz, VCO 1152000 kHz, ref 19200 kHz, bypass 19200 kHz, voltage level 6
> <7>[    5.029304] [drm:intel_atomic_commit_tail [i915]] [ENCODER:64:DDI B]
> <7>[    5.029368] [drm:intel_atomic_commit_tail [i915]] [ENCODER:66:DP-MST A]
> <7>[    5.029432] [drm:intel_atomic_commit_tail [i915]] [ENCODER:67:DP-MST B]
> <7>[    5.029495] [drm:intel_atomic_commit_tail [i915]] [ENCODER:68:DP-MST C]
> <7>[    5.029559] [drm:intel_atomic_commit_tail [i915]] [ENCODER:72:DDI C]
> <7>[    5.029623] [drm:intel_atomic_commit_tail [i915]] [ENCODER:74:DP-MST A]
> <7>[    5.029686] [drm:intel_atomic_commit_tail [i915]] [ENCODER:75:DP-MST B]
> <7>[    5.029749] [drm:intel_atomic_commit_tail [i915]] [ENCODER:76:DP-MST C]
> <7>[    5.029814] [drm:verify_single_dpll_state.isra.77 [i915]] PORT PLL A
> <7>[    5.029885] [drm:verify_single_dpll_state.isra.77 [i915]] PORT PLL B
> <7>[    5.029952] [drm:verify_single_dpll_state.isra.77 [i915]] PORT PLL C
> <7>[    5.030052] [drm:intel_enable_shared_dpll [i915]] enable PORT PLL C (active 1, on? 0) for crtc 40
> <7>[    5.030148] [drm:intel_enable_shared_dpll [i915]] enabling PORT PLL C
> <7>[    5.032361] [drm:intel_dp_set_signal_levels [i915]] Using vswing level 0
> <7>[    5.032427] [drm:intel_dp_set_signal_levels [i915]] Using pre-emphasis level 0
> <7>[    5.032493] [drm:intel_dp_program_link_training_pattern [i915]] Using DP training pattern TPS1
> <7>[    5.033424] [drm:intel_dp_start_link_train [i915]] clock recovery OK
> <7>[    5.033491] [drm:intel_dp_program_link_training_pattern [i915]] Using DP training pattern TPS2
> <7>[    5.034748] [drm:intel_dp_start_link_train [i915]] Channel EQ done. DP Training successful
> <7>[    5.035247] [drm:intel_dp_start_link_train [i915]] [CONNECTOR:73:DP-2] Link Training Passed at Link Rate = 162000, Lane count = 2
> <7>[    5.037211] [drm:intel_enable_pipe [i915]] enabling pipe A
> <7>[    5.037354] [drm:intel_enable_ddi [i915]] Panel doesn't support DRRS
> <7>[    5.037483] [drm:intel_fbc_enable [i915]] reserved 6291456 bytes of contiguous stolen space for FBC, threshold: 1
> <7>[    5.037560] [drm:intel_fbc_enable [i915]] Enabling FBC on pipe A
> <7>[    5.054517] [drm:verify_connector_state.isra.76 [i915]] [CONNECTOR:73:DP-2]
> <7>[    5.054624] [drm:intel_atomic_commit_tail [i915]] [CRTC:40:pipe A]
> <7>[    5.054845] [drm:verify_single_dpll_state.isra.77 [i915]] PORT PLL C
> <6>[    5.055769] Console: switching to colour frame buffer device 128x48
> <6>[    5.063418] r8169 0000:03:00.0 enp3s0: renamed from eth0
> <6>[    5.074545] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> <7>[    5.092442] [drm:drm_fb_helper_hotplug_event.part.21]
> <7>[    5.092460] [drm:drm_setup_crtcs]
> <7>[    5.092531] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:65:DP-1]
> <7>[    5.092627] [drm:intel_dp_detect [i915]] [CONNECTOR:65:DP-1]
> <7>[    5.093407] [drm:lspcon_wake_native_aux_ch [i915]] Native AUX CH up, DPCD version: 1.2
> <7>[    5.093462] [drm:lspcon_resume [i915]] LSPCON recovering in PCON mode after 0 ms
> <7>[    5.093972] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.095382] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.096714] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.098530] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.099862] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.100747] [drm:lspcon_wait_mode [i915]] Current LSPCON mode PCON
> <7>[    5.101343] [drm:intel_dp_read_dpcd [i915]] DPCD: 12 14 c4 01 01 15 00 01 00 00 04 00 0f 00 04
> <7>[    5.101737] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:65:DP-1] disconnected
> <7>[    5.101750] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:DP-2]
> <7>[    5.101817] [drm:intel_dp_detect [i915]] [CONNECTOR:73:DP-2]
> <7>[    5.102432] [drm:intel_dp_read_dpcd [i915]] DPCD: 11 0a 82 01 00 03 01 01 02 00 00 00 00 00 00
> <7>[    5.103452] [drm:intel_dp_print_rates [i915]] source rates: 162000, 216000, 243000, 270000, 324000, 432000, 540000
> <7>[    5.103512] [drm:intel_dp_print_rates [i915]] sink rates: 162000, 270000
> <7>[    5.103561] [drm:intel_dp_print_rates [i915]] common rates: 162000, 270000
> <7>[    5.104076] [drm:drm_dp_read_desc] DP branch: OUI 00-00-00 dev-ID  HW-rev 0.0 SW-rev 0.0 quirks 0x0000
> <7>[    5.104135] [drm:intel_dp_detect [i915]] Sink is not MST capable
> <7>[    5.109241] [drm:drm_add_display_info] non_desktop set to 0
> <7>[    5.109304] [drm:drm_add_edid_modes] ELD: no CEA Extension found
> <7>[    5.109310] [drm:drm_add_display_info] non_desktop set to 0
> <7>[    5.109573] [drm:drm_mode_debug_printmodeline] Modeline 86:"1920x1080" 0 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa
> <7>[    5.109579] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
> <7>[    5.109594] [drm:drm_mode_debug_printmodeline] Modeline 85:"1600x1200" 0 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
> <7>[    5.109599] [drm:drm_mode_prune_invalid] Not using 1600x1200 mode: VIRTUAL_X
> <7>[    5.109612] [drm:drm_mode_debug_printmodeline] Modeline 87:"1680x1050" 0 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6
> <7>[    5.109617] [drm:drm_mode_prune_invalid] Not using 1680x1050 mode: VIRTUAL_X
> <7>[    5.109629] [drm:drm_mode_debug_printmodeline] Modeline 88:"1400x1050" 0 121750 1400 1488 1632 1864 1050 1053 1057 1089 0x40 0x6
> <7>[    5.109635] [drm:drm_mode_prune_invalid] Not using 1400x1050 mode: VIRTUAL_X
> <7>[    5.109647] [drm:drm_mode_debug_printmodeline] Modeline 90:"1600x900" 0 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5
> <7>[    5.109653] [drm:drm_mode_prune_invalid] Not using 1600x900 mode: VIRTUAL_X
> <7>[    5.109665] [drm:drm_mode_debug_printmodeline] Modeline 84:"1280x1024" 0 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> <7>[    5.109671] [drm:drm_mode_prune_invalid] Not using 1280x1024 mode: VIRTUAL_X
> <7>[    5.109683] [drm:drm_mode_debug_printmodeline] Modeline 89:"1440x900" 0 106500 1440 1520 1672 1904 900 903 909 934 0x40 0x6
> <7>[    5.109689] [drm:drm_mode_prune_invalid] Not using 1440x900 mode: VIRTUAL_X
> <7>[    5.109701] [drm:drm_mode_debug_printmodeline] Modeline 82:"1280x960" 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> <7>[    5.109707] [drm:drm_mode_prune_invalid] Not using 1280x960 mode: VIRTUAL_X
> <7>[    5.109719] [drm:drm_mode_debug_printmodeline] Modeline 81:"1366x768" 60 85500 1366 1436 1579 1792 768 771 774 798 0x40 0x5
> <7>[    5.109725] [drm:drm_mode_prune_invalid] Not using 1366x768 mode: VIRTUAL_X
> <7>[    5.109737] [drm:drm_mode_debug_printmodeline] Modeline 83:"1280x720" 0 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> <7>[    5.109743] [drm:drm_mode_prune_invalid] Not using 1280x720 mode: VIRTUAL_X
> <7>[    5.109765] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:DP-2] probed modes :
> <7>[    5.109787] [drm:drm_mode_debug_printmodeline] Modeline 80:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x48 0xa
> <7>[    5.109793] [drm:drm_mode_debug_printmodeline] Modeline 91:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> <7>[    5.109799] [drm:drm_mode_debug_printmodeline] Modeline 92:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> <7>[    5.109806] [drm:drm_setup_crtcs] connector 65 enabled? no
> <7>[    5.109810] [drm:drm_setup_crtcs] connector 73 enabled? yes
> <7>[    5.109930] [drm:intel_fb_initial_config [i915]] Not using firmware configuration
> <7>[    5.109952] [drm:drm_setup_crtcs] looking for cmdline mode on connector 73
> <7>[    5.109957] [drm:drm_setup_crtcs] looking for preferred mode on connector 73 0
> <7>[    5.109962] [drm:drm_setup_crtcs] found mode 1024x768
> <7>[    5.109967] [drm:drm_setup_crtcs] picking CRTCs for 1024x768 config
> <7>[    5.110058] [drm:drm_setup_crtcs] desired mode 1024x768 set on crtc 40 (0,0)
> <7>[    5.121144] [drm:drm_fb_helper_hotplug_event.part.21]
> <7>[    5.121147] [drm:drm_setup_crtcs]
> <7>[    5.121177] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:65:DP-1]
> <7>[    5.121240] [drm:intel_dp_detect [i915]] [CONNECTOR:65:DP-1]
> <7>[    5.121754] [drm:lspcon_wake_native_aux_ch [i915]] Native AUX CH up, DPCD version: 1.2
> <7>[    5.121804] [drm:lspcon_resume [i915]] LSPCON recovering in PCON mode after 0 ms
> <7>[    5.122297] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.123607] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.124901] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.126192] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.127660] [drm:drm_dp_i2c_do_msg] native defer
> <7>[    5.128530] [drm:lspcon_wait_mode [i915]] Current LSPCON mode PCON
> <7>[    5.129123] [drm:intel_dp_read_dpcd [i915]] DPCD: 12 14 c4 01 01 15 00 01 00 00 04 00 0f 00 04
> <7>[    5.129518] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:65:DP-1] disconnected
> <7>[    5.129531] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:DP-2]
> <7>[    5.129600] [drm:intel_dp_detect [i915]] [CONNECTOR:73:DP-2]
> <7>[    5.130179] [drm:intel_dp_read_dpcd [i915]] DPCD: 11 0a 82 01 00 03 01 01 02 00 00 00 00 00 00
> <7>[    5.131145] [drm:intel_dp_print_rates [i915]] source rates: 162000, 216000, 243000, 270000, 324000, 432000, 540000
> <7>[    5.131199] [drm:intel_dp_print_rates [i915]] sink rates: 162000, 270000
> <7>[    5.131248] [drm:intel_dp_print_rates [i915]] common rates: 162000, 270000
> <7>[    5.131745] [drm:drm_dp_read_desc] DP branch: OUI 00-00-00 dev-ID  HW-rev 0.0 SW-rev 0.0 quirks 0x0000
> <7>[    5.131813] [drm:intel_dp_detect [i915]] Sink is not MST capable
> <7>[    5.136941] [drm:drm_add_display_info] non_desktop set to 0
> <7>[    5.136989] [drm:drm_add_edid_modes] ELD: no CEA Extension found
> <7>[    5.136996] [drm:drm_add_display_info] non_desktop set to 0
> <7>[    5.137222] [drm:drm_mode_debug_printmodeline] Modeline 83:"1366x768" 60 85500 1366 1436 1579 1792 768 771 774 798 0x40 0x5
> <7>[    5.137230] [drm:drm_mode_prune_invalid] Not using 1366x768 mode: VIRTUAL_X
> <7>[    5.137245] [drm:drm_mode_debug_printmodeline] Modeline 84:"1280x960" 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> <7>[    5.137250] [drm:drm_mode_prune_invalid] Not using 1280x960 mode: VIRTUAL_X
> <7>[    5.137263] [drm:drm_mode_debug_printmodeline] Modeline 85:"1280x720" 0 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> <7>[    5.137269] [drm:drm_mode_prune_invalid] Not using 1280x720 mode: VIRTUAL_X
> <7>[    5.137281] [drm:drm_mode_debug_printmodeline] Modeline 86:"1280x1024" 0 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> <7>[    5.137287] [drm:drm_mode_prune_invalid] Not using 1280x1024 mode: VIRTUAL_X
> <7>[    5.137300] [drm:drm_mode_debug_printmodeline] Modeline 87:"1600x1200" 0 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
> <7>[    5.137305] [drm:drm_mode_prune_invalid] Not using 1600x1200 mode: VIRTUAL_X
> <7>[    5.137318] [drm:drm_mode_debug_printmodeline] Modeline 88:"1920x1080" 0 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa
> <7>[    5.137324] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
> <7>[    5.137336] [drm:drm_mode_debug_printmodeline] Modeline 89:"1680x1050" 0 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6
> <7>[    5.137342] [drm:drm_mode_prune_invalid] Not using 1680x1050 mode: VIRTUAL_X
> <7>[    5.137354] [drm:drm_mode_debug_printmodeline] Modeline 90:"1400x1050" 0 121750 1400 1488 1632 1864 1050 1053 1057 1089 0x40 0x6
> <7>[    5.137360] [drm:drm_mode_prune_invalid] Not using 1400x1050 mode: VIRTUAL_X
> <7>[    5.137372] [drm:drm_mode_debug_printmodeline] Modeline 93:"1440x900" 0 106500 1440 1520 1672 1904 900 903 909 934 0x40 0x6
> <7>[    5.137378] [drm:drm_mode_prune_invalid] Not using 1440x900 mode: VIRTUAL_X
> <7>[    5.137391] [drm:drm_mode_debug_printmodeline] Modeline 95:"1600x900" 0 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5
> <7>[    5.137396] [drm:drm_mode_prune_invalid] Not using 1600x900 mode: VIRTUAL_X
> <7>[    5.137411] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:DP-2] probed modes :
> <7>[    5.137419] [drm:drm_mode_debug_printmodeline] Modeline 80:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x48 0xa
> <7>[    5.137425] [drm:drm_mode_debug_printmodeline] Modeline 91:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> <7>[    5.137431] [drm:drm_mode_debug_printmodeline] Modeline 92:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> <7>[    5.137438] [drm:drm_setup_crtcs] connector 65 enabled? no
> <7>[    5.137443] [drm:drm_setup_crtcs] connector 73 enabled? yes
> <7>[    5.137533] [drm:intel_fb_initial_config [i915]] Not using firmware configuration
> <7>[    5.137550] [drm:drm_setup_crtcs] looking for cmdline mode on connector 73
> <7>[    5.137556] [drm:drm_setup_crtcs] looking for preferred mode on connector 73 0
> <7>[    5.137561] [drm:drm_setup_crtcs] found mode 1024x768
> <7>[    5.137566] [drm:drm_setup_crtcs] picking CRTCs for 1024x768 config
> <7>[    5.137596] [drm:drm_setup_crtcs] desired mode 1024x768 set on crtc 40 (0,0)
> <6>[    5.165692] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC283: line_outs=2 (0x1b/0x21/0x0/0x0/0x0) type:hp
> <6>[    5.165696] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> <6>[    5.165698] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
> <6>[    5.165701] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> <6>[    5.165703] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
> <6>[    5.165705] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> <6>[    5.165708] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
> <6>[    5.165711] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> <7>[    5.253684] [drm:asle_work [i915]] bclp = 0x800000ff
> <7>[    5.253744] [drm:asle_work [i915]] updating opregion backlight 255/255
> <7>[    5.264962] [drm:i915_audio_component_get_eld [i915]] Not valid for port B
> <7>[    5.265036] [drm:i915_audio_component_get_eld [i915]] Not valid for port B
> <7>[    5.265127] [drm:i915_audio_component_get_eld [i915]] Not valid for port B
> <7>[    5.265179] [drm:i915_audio_component_get_eld [i915]] Not valid for port C
> <7>[    5.265231] [drm:i915_audio_component_get_eld [i915]] Not valid for port C
> <7>[    5.265282] [drm:i915_audio_component_get_eld [i915]] Not valid for port C
> <7>[    5.265333] [drm:i915_audio_component_get_eld [i915]] Not valid for port D
> <7>[    5.265384] [drm:i915_audio_component_get_eld [i915]] Not valid for port D
> <7>[    5.265435] [drm:i915_audio_component_get_eld [i915]] Not valid for port D
> <6>[    5.279951] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:0e.0/sound/card0/input6
> <6>[    5.281692] input: HDA Intel PCH Headphone Front as /devices/pci0000:00/0000:00:0e.0/sound/card0/input7
> <6>[    5.291619] input: HDA Intel PCH Front Headphone Surround as /devices/pci0000:00/0000:00:0e.0/sound/card0/input8
> <6>[    5.304345] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input9
> <6>[    5.305254] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input10
> <6>[    5.307604] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input11
> <6>[    5.308519] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input12
> <6>[    5.319295] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input13
> <6>[    7.086333] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
> <6>[    7.106076] r8169 0000:03:00.0 enp3s0: link down
> <6>[    7.106344] r8169 0000:03:00.0 enp3s0: link down
> <6>[    7.106687] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
> <5>[    7.761898] random: crng init done
> <6>[    9.981991] r8169 0000:03:00.0 enp3s0: link up
> <6>[    9.982150] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s0: link becomes ready
> 
> 
