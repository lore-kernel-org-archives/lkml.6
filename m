Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeDSBcJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:32:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:60774 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753008AbeDSBcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:32:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="txt'?scan'208";a="38577407"
Date: Thu, 19 Apr 2018 04:32:00 +0300
From: Imre Deak <imre.deak@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Early timeouts due to inaccurate jiffies during system suspend/resume
Message-ID: <20180419013200.wxkzqfdacfsijci5@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u2te2ork33f3tlwv"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u2te2ork33f3tlwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

while checking bug [1], I noticed that jiffies based timing loops like

	expire = jiffies + timeout + 1;
	while (!time_after(jiffies, expire))
		do_something;

can last shorter than expected (that is less than timeout). This happens
at least on an Intel Geminilake system when running the timing loop from
a driver's system suspend and resume hooks. To me it looks like expire
above is calculated with a stale jiffies value at the beginning and then
jiffies is updated - corresponding to the actual current time - with a >1
increment in the middle of the loop causing an early expiry.

With the following simplified testcase ran from a driver's suspend/resume
hooks

	cpu = raw_smp_processor_id();
        cpu_clock_start = cpu_clock(cpu);     // 1.
        jiffies_start = jiffies;              // 2.

        usleep_range(200, 200);

        jiffies_end = jiffies;                // 3.
        cpu_clock_end = cpu_clock(cpu);       // 4.

        jiffies_delta = jiffies_end - jiffies_start;
        cpu_clock_delta = cpu_clock_end - cpu_clock_start;

        if (jiffies_to_nsecs(jiffies_delta) >
            cpu_clock_delta + jiffies_to_nsecs(1))
                pr_info("cpu %d jiffies-delta %llu ns (%llu->%llu) cpu_clock-delta %llu ns (%llu -> %llu)\n",
                        cpu,
                        jiffies_to_nsecs(jiffies_delta), jiffies_start, jiffies_end,
                        cpu_clock_delta, cpu_clock_start, cpu_clock_end);



and doing suspend/resume to mem cycles in a loop, I can trigger the
following:

[   42.415713] cpu 1 jiffies-delta 11000000 ns (4294709700->4294709711) cpu_clock-delta 215738 ns (42415489466 -> 42415705204)

So according to jiffies the delay was 11ms while according to cpu_clock()
it was ~216usec. I have CONFIG_HZ=1000, so AFAIU - due to the ordering of
1.,2.,3.,4. - cpu_clock-delta should be bigger than jiffies-delta
minus 1ms.

Are the above timing loops/assumptions incorrect?

After some ftracing it seems like jiffies gets stale due to a missed
LAPIC timer interrupt after the interrupt is armed in
lapic_next_deadline() and before jiffies is sampled at 2. above.
Eventually the interrupt does get delivered, at which point jiffies gets
updated via tick_do_update_jiffies64() with a >1 ticks increment.
Between lapic_next_deadline() and the - late - delivery of the interrupt
the CPU on which the interrupt is armed doesn't go idle.

Booting with nolapic_timer I couldn't yet trigger the problem.

I'm still trying to do a bisect, without high hopes, since triggering
the problem can take rather long and I suspect this could also be some
HW issue.

Any idea what could go wrong or how to debug this further?

I attached my dmesg.

Thanks,
Imre

[1] https://bugs.freedesktop.org/show_bug.cgi?id=105771

--u2te2ork33f3tlwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

[    0.000000] Linux version 4.17.0-rc1-CI-CI_DRM_4040+ (jim@ideak-desk) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2)) #86 SMP PREEMPT Wed Apr 18 22:35:05 EEST 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.17.0-rc1-CI-CI_DRM_4040+ root=UUID=39b51f91-8fce-4449-acb4-3e740303a4fe ro quiet splash drm.debug=0xe intel_iommu=igfx_off 3 modprobe.blacklist=i915,snd_hda_intel apic=debug vt.handoff=1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[3]:  576, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  640, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1b, context size is 704 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000003dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000003e000-0x000000000003ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000040000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000010000000-0x0000000012150fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000012151000-0x00000000674a9fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000674aa000-0x0000000069d58fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000069d59000-0x0000000069d7cfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000069d7d000-0x0000000069ddcfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000069ddd000-0x000000006a0a3fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006a0a4000-0x000000006a164fff] type 20
[    0.000000] BIOS-e820: [mem 0x000000006a165000-0x000000006a562fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006a563000-0x000000006a60efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006a60f000-0x000000006abfffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006ac00000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d3709000-0x00000000d3709fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe042000-0x00000000fe044fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe900000-0x00000000fe902fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.60 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0x69d69000  ACPI=0x69d69000  SMBIOS=0x6a000000  SMBIOS 3.0=0x69fff000  ESRT=0x69fcaf98  MEMATTR=0x63479018 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: Intel Corporation NUC7CJYH/NUC7JYB, BIOS JYGLKCPX.86A.0027.2018.0125.1347 01/25/2018
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x280000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00FF000000 mask 7FFF000000 write-combining
[    0.000000]   1 base 0000000000 mask 7F80000000 write-back
[    0.000000]   2 base 006B000000 mask 7FFF000000 uncachable
[    0.000000]   3 base 006C000000 mask 7FFC000000 uncachable
[    0.000000]   4 base 0070000000 mask 7FF0000000 uncachable
[    0.000000]   5 base 0100000000 mask 7F00000000 write-back
[    0.000000]   6 base 0200000000 mask 7F80000000 write-back
[    0.000000]   7 base 0090000000 mask 7FF0000000 write-combining
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: last_pfn = 0x6ac00 max_arch_pfn = 0x400000000
[    0.000000] esrt: Reserving ESRT space from 0x0000000069fcaf98 to 0x0000000069fcafd0.
[    0.000000] Base memory trampoline at [        (ptrval)] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x05573000, 0x05573fff] PGTABLE
[    0.000000] BRK [0x05574000, 0x05574fff] PGTABLE
[    0.000000] BRK [0x05575000, 0x05575fff] PGTABLE
[    0.000000] BRK [0x05576000, 0x05576fff] PGTABLE
[    0.000000] BRK [0x05577000, 0x05577fff] PGTABLE
[    0.000000] BRK [0x05578000, 0x05578fff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x312fb000-0x34974fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000069D69000 000024 (v02 INTEL )
[    0.000000] ACPI: XSDT 0x0000000069D690C0 0000EC (v01 INTEL  NUC7CJYB 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x0000000069D76270 000114 (v06 INTEL  NUC7CJYB 01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x0000000069D69250 00D020 (v02 INTEL  NUC7CJYB 01072009 INTL 20160930)
[    0.000000] ACPI: FACS 0x0000000069DDC080 000040
[    0.000000] ACPI: FPDT 0x0000000069D76390 000044 (v01 INTEL  NUC7CJYB 01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x0000000069D763E0 00009C (v01 INTEL  NUC7CJYB 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x0000000069D76480 00003C (v01 INTEL  NUC7CJYB 01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x0000000069D764C0 000038 (v01 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: LPIT 0x0000000069D76500 00005C (v01 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: APIC 0x0000000069D76560 000084 (v03 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: NPKT 0x0000000069D765F0 000065 (v01 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: SSDT 0x0000000069D76660 0010B3 (v02 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: SSDT 0x0000000069D77720 00153E (v01 INTEL  NUC7CJYB 00001000 INTL 20160930)
[    0.000000] ACPI: SSDT 0x0000000069D78C60 0000B1 (v01 INTEL  NUC7CJYB 00001000 INTL 20160930)
[    0.000000] ACPI: SSDT 0x0000000069D78D20 0005BC (v02 INTEL  NUC7CJYB 00003000 INTL 20160930)
[    0.000000] ACPI: SSDT 0x0000000069D792E0 000775 (v02 INTEL  NUC7CJYB 00003000 INTL 20160930)
[    0.000000] ACPI: SSDT 0x0000000069D79A60 00035F (v02 INTEL  NUC7CJYB 00003000 INTL 20160930)
[    0.000000] ACPI: SSDT 0x0000000069D79DC0 0001E6 (v02 INTEL  NUC7CJYB 00003000 INTL 20160930)
[    0.000000] ACPI: SSDT 0x0000000069D79FB0 0028FE (v02 INTEL  NUC7CJYB 00003000 INTL 20160930)
[    0.000000] ACPI: UEFI 0x0000000069D7C8B0 000042 (v01 INTEL  NUC7CJYB 00000002      01000013)
[    0.000000] ACPI: BGRT 0x0000000069D7C900 000038 (v01 INTEL  NUC7CJYB 01072009 AMI  00010013)
[    0.000000] ACPI: TPM2 0x0000000069D7C940 000034 (v03 INTEL  NUC7CJYB 00000001 AMI  00000000)
[    0.000000] ACPI: SSDT 0x0000000069D7C980 0001CC (v01 INTEL  NUC7CJYB 00001000 INTL 20160930)
[    0.000000] ACPI: DBGP 0x0000000069D7CB50 000034 (v01 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: DBG2 0x0000000069D7CB90 000072 (v00 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: DMAR 0x0000000069D7CC10 0000A8 (v01 INTEL  NUC7CJYB 00000003 BRXT 0100000D)
[    0.000000] ACPI: WDAT 0x0000000069D7CCC0 000104 (v01 INTEL  NUC7CJYB 00000000      00000000)
[    0.000000] ACPI: WSMT 0x0000000069D7CDD0 000028 (v01 INTEL  NUC7CJYB 01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] tsc: Using PIT calibration value
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000027fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000003dfff]
[    0.000000]   node   0: [mem 0x0000000000040000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000012151000-0x00000000674a9fff]
[    0.000000]   node   0: [mem 0x000000006a165000-0x000000006a562fff]
[    0.000000]   node   0: [mem 0x000000006a60f000-0x000000006abfffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000027fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000027fffffff]
[    0.000000] On node 0 totalpages: 1989859
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6454 pages used for memmap
[    0.000000]   DMA32 zone: 413000 pages, LIFO batch:31
[    0.000000]   Normal zone: 24576 pages used for memmap
[    0.000000]   Normal zone: 1572864 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 99 pages
[    0.000000] Reserving Intel graphics memory at [mem 0x7c000000-0x7fffffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 1, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 1, APIC INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 1, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 1, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 1, APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 1, APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 1, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 1, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 1, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 1, APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 1, APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 1, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 1, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 1, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 1, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0003e000-0x0003ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x10000000-0x12150fff]
[    0.000000] PM: Registered nosave memory: [mem 0x674aa000-0x69d58fff]
[    0.000000] PM: Registered nosave memory: [mem 0x69d59000-0x69d7cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x69d7d000-0x69ddcfff]
[    0.000000] PM: Registered nosave memory: [mem 0x69ddd000-0x6a0a3fff]
[    0.000000] PM: Registered nosave memory: [mem 0x6a0a4000-0x6a164fff]
[    0.000000] PM: Registered nosave memory: [mem 0x6a563000-0x6a60efff]
[    0.000000] PM: Registered nosave memory: [mem 0x6ac00000-0x7fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0xcfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd0000000-0xd0ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd1000000-0xd3708fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd3709000-0xd3709fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd370a000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfe041fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe042000-0xfe044fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe045000-0xfe8fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe900000-0xfe902fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe903000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed02000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x80000000-0xcfffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 44 pages/cpu @        (ptrval) s142216 r8192 d29816 u524288
[    0.000000] pcpu-alloc: s142216 r8192 d29816 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1958743
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.17.0-rc1-CI-CI_DRM_4040+ root=UUID=39b51f91-8fce-4449-acb4-3e740303a4fe ro quiet splash drm.debug=0xe intel_iommu=igfx_off 3 modprobe.blacklist=i915,snd_hda_intel apic=debug vt.handoff=1
[    0.000000] DMAR: Disable GFX device mapping
[    0.000000] log_buf_len individual max cpu contribution: 262144 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 786432 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 1048576 bytes
[    0.000000] early log buf free: 246752(94%)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Memory: 7639724K/7959436K available (12300K kernel code, 1336K rwdata, 3604K rodata, 1520K init, 13524K bss, 319712K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 33684 entries in 132 pages
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
[    0.000000] 	RCU callback double-/use-after-free debug enabled.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000000] ... CHAINHASH_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 7391 kB
[    0.000000]  per task-struct memory footprint: 1920 bytes
[    0.000000] kmemleak: Early log buffer exceeded (1044), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.000000] ACPI: Core revision 20180313
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 99544814920 ns
[    0.000000] hpet clockevent registered
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.001000] DMAR: Host address width 39
[    0.001000] DMAR: DRHD base: 0x000000fed64000 flags: 0x0
[    0.001000] DMAR: dmar0: reg_base_addr fed64000 ver 1:0 cap 1c0000c40660462 ecap 9e2ff0505e
[    0.001000] DMAR: DRHD base: 0x000000fed65000 flags: 0x1
[    0.001000] DMAR: dmar1: reg_base_addr fed65000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.001000] DMAR: RMRR base: 0x00000069d08000 end: 0x00000069d27fff
[    0.001000] DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
[    0.001000] DMAR-IR: IOAPIC id 1 under DRHD base  0xfed65000 IOMMU 1
[    0.001000] DMAR-IR: HPET id 0 under DRHD base 0xfed65000
[    0.001000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.003000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.003000] x2apic enabled
[    0.003000] Switched APIC routing to cluster x2apic.
[    0.003000] enabled ExtINT on CPU#0
[    0.008000] ENABLING IO-APIC IRQs
[    0.008000] init IO_APIC IRQs
[    0.008000]  apic 1 pin 0 not connected
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-5 -> 0xef -> IRQ 5 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-9 -> 0xef -> IRQ 9 Mode:1 Active:1 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-10 -> 0xef -> IRQ 10 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-11 -> 0xef -> IRQ 11 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
[    0.008000] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    0.008000] IOAPIC[0]: Set routing entry (1-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
[    0.008000]  apic 1 pin 16 not connected
[    0.008000]  apic 1 pin 17 not connected
[    0.008000]  apic 1 pin 18 not connected
[    0.008000]  apic 1 pin 19 not connected
[    0.008000]  apic 1 pin 20 not connected
[    0.008000]  apic 1 pin 21 not connected
[    0.008000]  apic 1 pin 22 not connected
[    0.008000]  apic 1 pin 23 not connected
[    0.008000]  apic 1 pin 24 not connected
[    0.008000]  apic 1 pin 25 not connected
[    0.008000]  apic 1 pin 26 not connected
[    0.008000]  apic 1 pin 27 not connected
[    0.008000]  apic 1 pin 28 not connected
[    0.008000]  apic 1 pin 29 not connected
[    0.008000]  apic 1 pin 30 not connected
[    0.008000]  apic 1 pin 31 not connected
[    0.008000]  apic 1 pin 32 not connected
[    0.008000]  apic 1 pin 33 not connected
[    0.008000]  apic 1 pin 34 not connected
[    0.008000]  apic 1 pin 35 not connected
[    0.008000]  apic 1 pin 36 not connected
[    0.008000]  apic 1 pin 37 not connected
[    0.008000]  apic 1 pin 38 not connected
[    0.008000]  apic 1 pin 39 not connected
[    0.008000]  apic 1 pin 40 not connected
[    0.008000]  apic 1 pin 41 not connected
[    0.008000]  apic 1 pin 42 not connected
[    0.008000]  apic 1 pin 43 not connected
[    0.008000]  apic 1 pin 44 not connected
[    0.008000]  apic 1 pin 45 not connected
[    0.008000]  apic 1 pin 46 not connected
[    0.008000]  apic 1 pin 47 not connected
[    0.008000]  apic 1 pin 48 not connected
[    0.008000]  apic 1 pin 49 not connected
[    0.008000]  apic 1 pin 50 not connected
[    0.008000]  apic 1 pin 51 not connected
[    0.008000]  apic 1 pin 52 not connected
[    0.008000]  apic 1 pin 53 not connected
[    0.008000]  apic 1 pin 54 not connected
[    0.008000]  apic 1 pin 55 not connected
[    0.008000]  apic 1 pin 56 not connected
[    0.008000]  apic 1 pin 57 not connected
[    0.008000]  apic 1 pin 58 not connected
[    0.008000]  apic 1 pin 59 not connected
[    0.008000]  apic 1 pin 60 not connected
[    0.008000]  apic 1 pin 61 not connected
[    0.008000]  apic 1 pin 62 not connected
[    0.008000]  apic 1 pin 63 not connected
[    0.008000]  apic 1 pin 64 not connected
[    0.008000]  apic 1 pin 65 not connected
[    0.008000]  apic 1 pin 66 not connected
[    0.008000]  apic 1 pin 67 not connected
[    0.008000]  apic 1 pin 68 not connected
[    0.008000]  apic 1 pin 69 not connected
[    0.008000]  apic 1 pin 70 not connected
[    0.008000]  apic 1 pin 71 not connected
[    0.008000]  apic 1 pin 72 not connected
[    0.008000]  apic 1 pin 73 not connected
[    0.008000]  apic 1 pin 74 not connected
[    0.008000]  apic 1 pin 75 not connected
[    0.008000]  apic 1 pin 76 not connected
[    0.008000]  apic 1 pin 77 not connected
[    0.008000]  apic 1 pin 78 not connected
[    0.008000]  apic 1 pin 79 not connected
[    0.008000]  apic 1 pin 80 not connected
[    0.008000]  apic 1 pin 81 not connected
[    0.008000]  apic 1 pin 82 not connected
[    0.008000]  apic 1 pin 83 not connected
[    0.008000]  apic 1 pin 84 not connected
[    0.008000]  apic 1 pin 85 not connected
[    0.008000]  apic 1 pin 86 not connected
[    0.008000]  apic 1 pin 87 not connected
[    0.008000]  apic 1 pin 88 not connected
[    0.008000]  apic 1 pin 89 not connected
[    0.008000]  apic 1 pin 90 not connected
[    0.008000]  apic 1 pin 91 not connected
[    0.008000]  apic 1 pin 92 not connected
[    0.008000]  apic 1 pin 93 not connected
[    0.008000]  apic 1 pin 94 not connected
[    0.008000]  apic 1 pin 95 not connected
[    0.008000]  apic 1 pin 96 not connected
[    0.008000]  apic 1 pin 97 not connected
[    0.008000]  apic 1 pin 98 not connected
[    0.008000]  apic 1 pin 99 not connected
[    0.008000]  apic 1 pin 100 not connected
[    0.008000]  apic 1 pin 101 not connected
[    0.008000]  apic 1 pin 102 not connected
[    0.008000]  apic 1 pin 103 not connected
[    0.008000]  apic 1 pin 104 not connected
[    0.008000]  apic 1 pin 105 not connected
[    0.008000]  apic 1 pin 106 not connected
[    0.008000]  apic 1 pin 107 not connected
[    0.008000]  apic 1 pin 108 not connected
[    0.008000]  apic 1 pin 109 not connected
[    0.008000]  apic 1 pin 110 not connected
[    0.008000]  apic 1 pin 111 not connected
[    0.008000]  apic 1 pin 112 not connected
[    0.008000]  apic 1 pin 113 not connected
[    0.008000]  apic 1 pin 114 not connected
[    0.008000]  apic 1 pin 115 not connected
[    0.008000]  apic 1 pin 116 not connected
[    0.008000]  apic 1 pin 117 not connected
[    0.008000]  apic 1 pin 118 not connected
[    0.008000]  apic 1 pin 119 not connected
[    0.008000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.014000] tsc: PIT calibration matches HPET. 1 loops
[    0.014000] tsc: Detected 1997.142 MHz processor
[    0.014000] tsc: Detected 1996.800 MHz TSC
[    0.014000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3990bec8342, max_idle_ns: 881590769617 ns
[    0.014000] Calibrating delay loop (skipped), value calculated using timer frequency.. 3993.60 BogoMIPS (lpj=1996800)
[    0.014000] pid_max: default: 32768 minimum: 301
[    0.016190] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.016214] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.017645] CPU: Physical Processor ID: 0
[    0.017648] CPU: Processor Core ID: 0
[    0.017659] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[    0.017673] mce: CPU supports 7 MCE banks
[    0.017724] CPU0: Thermal monitoring enabled (TM1)
[    0.017787] process: using mwait in idle threads
[    0.017792] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.017795] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.017799] Spectre V2 : Vulnerable: Minimal generic ASM retpoline
[    0.018109] Freeing SMP alternatives memory: 36K
[    0.022451] TSC deadline timer enabled
[    0.022468] smpboot: CPU0: Intel(R) Celeron(R) J4005 CPU @ 2.00GHz (family: 0x6, model: 0x7a, stepping: 0x1)
[    0.027069] Performance Events: PEBS fmt3+, Goldmont plus events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.027132] ... version:                4
[    0.027135] ... bit width:              48
[    0.027138] ... generic registers:      4
[    0.027141] ... value mask:             0000ffffffffffff
[    0.027143] ... max period:             00007fffffffffff
[    0.027146] ... fixed-purpose events:   3
[    0.027149] ... event mask:             000000070000000f
[    0.029018] Hierarchical SRCU implementation.
[    0.035566] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.037018] smp: Bringing up secondary CPUs ...
[    0.045143] x86: Booting SMP configuration:
[    0.045153] .... node  #0, CPUs:      #1
[    0.001000] masked ExtINT on CPU#1
[    0.001000] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[    0.046296] smp: Brought up 1 node, 2 CPUs
[    0.046296] smpboot: Max logical packages: 2
[    0.046296] smpboot: Total of 2 processors activated (7987.20 BogoMIPS)
[    0.048482] devtmpfs: initialized
[    0.052161] PM: Registering ACPI NVS region [mem 0x69d7d000-0x69ddcfff] (393216 bytes)
[    0.055059] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.055059] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.055377] xor: measuring software checksum speed
[    0.065022]    prefetch64-sse: 10520.000 MB/sec
[    0.074007]    generic_sse:  9060.000 MB/sec
[    0.074011] xor: using function: prefetch64-sse (10520.000 MB/sec)
[    0.074037] pinctrl core: initialized pinctrl subsystem
[    0.077940] NET: Registered protocol family 16
[    0.080674] cpuidle: using governor menu
[    0.081011] ACPI: bus type PCI registered
[    0.081015] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.081504] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.081512] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.081556] PCI: Using configuration type 1 for base access
[    0.104178] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.105404] cryptd: max_cpu_qlen set to 1000
[    0.122879] raid6: sse2x1   gen()  4722 MB/s
[    0.139808] raid6: sse2x1   xor()  3085 MB/s
[    0.156810] raid6: sse2x2   gen()  5503 MB/s
[    0.173766] raid6: sse2x2   xor()  3656 MB/s
[    0.190760] raid6: sse2x4   gen()  6367 MB/s
[    0.207752] raid6: sse2x4   xor()  2400 MB/s
[    0.207757] raid6: using algorithm sse2x4 gen() 6367 MB/s
[    0.207760] raid6: .... xor() 2400 MB/s, rmw enabled
[    0.207764] raid6: using ssse3x2 recovery algorithm
[    0.208357] ACPI: Added _OSI(Module Device)
[    0.208362] ACPI: Added _OSI(Processor Device)
[    0.208365] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.208369] ACPI: Added _OSI(Processor Aggregator Device)
[    0.208384] ACPI: Added _OSI(Linux-Dell-Video)
[    0.460967] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.524408] ACPI: Dynamic OEM Table Load:
[    0.524447] ACPI: SSDT 0xFFFF880276099A88 000190 (v02 PmRef  Cpu0Cst  00003001 INTL 20160930)
[    0.532675] ACPI: Dynamic OEM Table Load:
[    0.532711] ACPI: SSDT 0xFFFF880276099DD8 0001E6 (v02 PmRef  ApIst    00003000 INTL 20160930)
[    0.536191] ACPI: Dynamic OEM Table Load:
[    0.536226] ACPI: SSDT 0xFFFF88027601DBC8 0000C9 (v02 PmRef  ApCst    00003000 INTL 20160930)
[    0.544565] ACPI: EC: EC started
[    0.544575] ACPI: EC: interrupt blocked
[    0.544935] ACPI: \_SB_.PCI0.SBRG.H_EC: Used as first EC
[    0.544950] ACPI: \_SB_.PCI0.SBRG.H_EC: GPE=0x22, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.544964] ACPI: \_SB_.PCI0.SBRG.H_EC: Used as boot DSDT EC to handle transactions
[    0.544970] ACPI: Interpreter enabled
[    0.545174] ACPI: (supports S0 S3 S4 S5)
[    0.545179] ACPI: Using IOAPIC for interrupt routing
[    0.545577] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.551516] ACPI: Enabled 1 GPEs in block 00 to 7F
[    0.649023] ACPI: Power Resource [DRST] (on)
[    0.655686] ACPI: Power Resource [DRST] (on)
[    0.663356] ACPI: Power Resource [DRST] (on)
[    0.669984] ACPI: Power Resource [DRST] (on)
[    0.676622] ACPI: Power Resource [DRST] (on)
[    0.684096] ACPI: Power Resource [DRST] (on)
[    0.691858] ACPI: Power Resource [WRST] (on)
[    0.766715] ACPI: Power Resource [FN00] (on)
[    0.782696] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.782728] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.799978] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.802522] acpi PNP0A08:00: host bridge window [mem 0x1000000010000 window] (ignored, not CPU addressable)
[    0.809194] PCI host bridge to bus 0000:00
[    0.809206] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.809216] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.809225] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.809234] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.809249] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.809259] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.809269] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.809278] pci_bus 0000:00: root bus resource [mem 0x7c000001-0x7fffffff window]
[    0.809287] pci_bus 0000:00: root bus resource [mem 0x80000000-0xbfffffff window]
[    0.809297] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xefffffff window]
[    0.809306] pci_bus 0000:00: root bus resource [mem 0xfea00000-0xfeafffff window]
[    0.809315] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed003ff window]
[    0.809324] pci_bus 0000:00: root bus resource [mem 0xfed01000-0xfed01fff window]
[    0.809333] pci_bus 0000:00: root bus resource [mem 0xfed03000-0xfed03fff window]
[    0.809342] pci_bus 0000:00: root bus resource [mem 0xfed06000-0xfed06fff window]
[    0.809351] pci_bus 0000:00: root bus resource [mem 0xfed08000-0xfed09fff window]
[    0.809360] pci_bus 0000:00: root bus resource [mem 0xfed80000-0xfedbffff window]
[    0.809369] pci_bus 0000:00: root bus resource [mem 0xfed1c000-0xfed1cfff window]
[    0.809378] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xfeefffff window]
[    0.809388] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.809448] pci 0000:00:00.0: [8086:31f0] type 00 class 0x060000
[    0.813867] pci 0000:00:02.0: [8086:3185] type 00 class 0x030000
[    0.813895] pci 0000:00:02.0: reg 0x10: [mem 0xa0000000-0xa0ffffff 64bit]
[    0.813911] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.813921] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.813998] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.819667] pci 0000:00:0c.0: [8086:31dc] type 00 class 0x028000
[    0.819779] pci 0000:00:0c.0: reg 0x10: [mem 0xa1314000-0xa1317fff 64bit]
[    0.820218] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    0.824770] pci 0000:00:0e.0: [8086:3198] type 00 class 0x040300
[    0.824816] pci 0000:00:0e.0: reg 0x10: [mem 0xa1310000-0xa1313fff 64bit]
[    0.824867] pci 0000:00:0e.0: reg 0x20: [mem 0xa1000000-0xa10fffff 64bit]
[    0.825036] pci 0000:00:0e.0: PME# supported from D0 D3hot D3cold
[    0.832734] pci 0000:00:0f.0: [8086:319a] type 00 class 0x078000
[    0.832805] pci 0000:00:0f.0: reg 0x10: [mem 0xa131f000-0xa131ffff 64bit]
[    0.833076] pci 0000:00:0f.0: PME# supported from D3hot
[    0.837264] pci 0000:00:12.0: [8086:31e3] type 00 class 0x010601
[    0.837307] pci 0000:00:12.0: reg 0x10: [mem 0xa1318000-0xa1319fff]
[    0.837325] pci 0000:00:12.0: reg 0x14: [mem 0xa131e000-0xa131e0ff]
[    0.837342] pci 0000:00:12.0: reg 0x18: [io  0xf090-0xf097]
[    0.837360] pci 0000:00:12.0: reg 0x1c: [io  0xf080-0xf083]
[    0.837378] pci 0000:00:12.0: reg 0x20: [io  0xf060-0xf07f]
[    0.837396] pci 0000:00:12.0: reg 0x24: [mem 0xa131d000-0xa131d7ff]
[    0.837548] pci 0000:00:12.0: PME# supported from D3hot
[    0.841667] pci 0000:00:13.0: [8086:31d8] type 01 class 0x060400
[    0.841880] pci 0000:00:13.0: PME# supported from D0 D3hot D3cold
[    0.846052] pci 0000:00:13.2: [8086:31da] type 01 class 0x060400
[    0.846268] pci 0000:00:13.2: PME# supported from D0 D3hot D3cold
[    0.850577] pci 0000:00:15.0: [8086:31a8] type 00 class 0x0c0330
[    0.850620] pci 0000:00:15.0: reg 0x10: [mem 0xa1300000-0xa130ffff 64bit]
[    0.850792] pci 0000:00:15.0: PME# supported from D3hot D3cold
[    0.855027] pci 0000:00:1c.0: [8086:31cc] type 00 class 0x080501
[    0.855099] pci 0000:00:1c.0: reg 0x10: [mem 0xa131c000-0xa131cfff 64bit]
[    0.855138] pci 0000:00:1c.0: reg 0x18: [mem 0xa131b000-0xa131bfff 64bit]
[    0.859928] pci 0000:00:1f.0: [8086:31e8] type 00 class 0x060100
[    0.864290] pci 0000:00:1f.1: [8086:31d4] type 00 class 0x0c0500
[    0.864374] pci 0000:00:1f.1: reg 0x10: [mem 0xa131a000-0xa131a0ff 64bit]
[    0.864467] pci 0000:00:1f.1: reg 0x20: [io  0xf040-0xf05f]
[    0.868965] pci 0000:01:00.0: [10ec:5229] type 00 class 0xff0000
[    0.869027] pci 0000:01:00.0: reg 0x10: [mem 0xa1200000-0xa1200fff]
[    0.869128] pci 0000:01:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
[    0.869316] pci 0000:01:00.0: supports D1 D2
[    0.869320] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.870028] pci 0000:00:13.0: PCI bridge to [bus 01]
[    0.870039] pci 0000:00:13.0:   bridge window [mem 0xa1200000-0xa12fffff]
[    0.870532] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[    0.870579] pci 0000:02:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.870621] pci 0000:02:00.0: reg 0x18: [mem 0xa1104000-0xa1104fff 64bit]
[    0.870648] pci 0000:02:00.0: reg 0x20: [mem 0xa1100000-0xa1103fff 64bit]
[    0.870674] pci 0000:02:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
[    0.870913] pci 0000:02:00.0: supports D1 D2
[    0.870917] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.871641] pci 0000:00:13.2: PCI bridge to [bus 02]
[    0.871648] pci 0000:00:13.2:   bridge window [io  0xe000-0xefff]
[    0.871656] pci 0000:00:13.2:   bridge window [mem 0xa1100000-0xa11fffff]
[    0.871689] pci_bus 0000:00: on NUMA node 0
[    0.899042] ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.900675] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 10 11 12 14 15)
[    0.902273] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.903870] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 10 11 12 14 15)
[    0.905467] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *7
[    0.907059] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *9
[    0.908642] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.910229] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.924390] ACPI: EC: interrupt unblocked
[    0.924425] ACPI: EC: event unblocked
[    0.924461] ACPI: \_SB_.PCI0.SBRG.H_EC: GPE=0x22, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.924477] ACPI: \_SB_.PCI0.SBRG.H_EC: Used as boot DSDT EC to handle transactions and events
[    0.926147] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.926147] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.926147] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.926147] vgaarb: loaded
[    0.927159] SCSI subsystem initialized
[    0.928149] libata version 3.00 loaded.
[    0.928436] ACPI: bus type USB registered
[    0.928436] usbcore: registered new interface driver usbfs
[    0.928436] usbcore: registered new interface driver hub
[    0.928436] usbcore: registered new device driver usb
[    0.928843] pps_core: LinuxPPS API ver. 1 registered
[    0.928846] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.928892] PTP clock support registered
[    0.930296] Registered efivars operations
[    0.950364] Advanced Linux Sound Architecture Driver Initialized.
[    0.950481] PCI: Using ACPI for IRQ routing
[    0.981981] PCI: pci_cache_line_size set to 64 bytes
[    0.982103] e820: reserve RAM buffer [mem 0x0003e000-0x0003ffff]
[    0.982130] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.982143] e820: reserve RAM buffer [mem 0x674aa000-0x67ffffff]
[    0.982154] e820: reserve RAM buffer [mem 0x6a563000-0x6bffffff]
[    0.982166] e820: reserve RAM buffer [mem 0x6ac00000-0x6bffffff]
[    0.983509] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.983509] hpet0: 8 comparators, 64-bit 19.200000 MHz counter
[    0.987083] clocksource: Switched to clocksource tsc-early
[    1.105701] pnp: PnP ACPI init
[    1.111784] system 00:00: [io  0x0a00-0x0a1f] has been reserved
[    1.111809] system 00:00: [io  0x0a20-0x0a2f] has been reserved
[    1.111824] system 00:00: [io  0x0a30-0x0a3f] has been reserved
[    1.111845] system 00:00: [io  0x0a40-0x0a4f] has been reserved
[    1.111861] system 00:00: [io  0x0a50-0x0a5f] has been reserved
[    1.111876] system 00:00: [io  0x0a60-0x0a6f] has been reserved
[    1.111929] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.116148] pnp 00:01: [dma 0 disabled]
[    1.116467] pnp 00:01: Plug and Play ACPI device, IDs ITE8708 (active)
[    1.117044] system 00:02: [io  0x0680-0x069f] has been reserved
[    1.117060] system 00:02: [io  0x0400-0x047f] has been reserved
[    1.117075] system 00:02: [io  0x0500-0x05fe] has been reserved
[    1.117090] system 00:02: [io  0x0600-0x061f] has been reserved
[    1.117107] system 00:02: [io  0x164e-0x164f] has been reserved
[    1.117144] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.124301] system 00:03: [mem 0xe0000000-0xefffffff] has been reserved
[    1.124317] system 00:03: [mem 0xfea00000-0xfeafffff] has been reserved
[    1.124332] system 00:03: [mem 0xfed01000-0xfed01fff] has been reserved
[    1.124346] system 00:03: [mem 0xfed03000-0xfed03fff] has been reserved
[    1.124360] system 00:03: [mem 0xfed06000-0xfed06fff] has been reserved
[    1.124374] system 00:03: [mem 0xfed08000-0xfed09fff] has been reserved
[    1.124389] system 00:03: [mem 0xfed80000-0xfedbffff] has been reserved
[    1.124410] system 00:03: [mem 0xfed1c000-0xfed1cfff] has been reserved
[    1.124438] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.124474] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.128361] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.132477] pnp: PnP ACPI: found 5 devices
[    1.159450] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.159488] pci 0000:00:13.0: PCI bridge to [bus 01]
[    1.159500] pci 0000:00:13.0:   bridge window [mem 0xa1200000-0xa12fffff]
[    1.159513] pci 0000:00:13.2: PCI bridge to [bus 02]
[    1.159518] pci 0000:00:13.2:   bridge window [io  0xe000-0xefff]
[    1.159525] pci 0000:00:13.2:   bridge window [mem 0xa1100000-0xa11fffff]
[    1.159538] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    1.159543] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    1.159546] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    1.159550] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    1.159554] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    1.159558] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    1.159561] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    1.159565] pci_bus 0000:00: resource 11 [mem 0x7c000001-0x7fffffff window]
[    1.159569] pci_bus 0000:00: resource 12 [mem 0x80000000-0xbfffffff window]
[    1.159573] pci_bus 0000:00: resource 13 [mem 0xe0000000-0xefffffff window]
[    1.159576] pci_bus 0000:00: resource 14 [mem 0xfea00000-0xfeafffff window]
[    1.159580] pci_bus 0000:00: resource 15 [mem 0xfed00000-0xfed003ff window]
[    1.159583] pci_bus 0000:00: resource 16 [mem 0xfed01000-0xfed01fff window]
[    1.159587] pci_bus 0000:00: resource 17 [mem 0xfed03000-0xfed03fff window]
[    1.159590] pci_bus 0000:00: resource 18 [mem 0xfed06000-0xfed06fff window]
[    1.159594] pci_bus 0000:00: resource 19 [mem 0xfed08000-0xfed09fff window]
[    1.159597] pci_bus 0000:00: resource 20 [mem 0xfed80000-0xfedbffff window]
[    1.159601] pci_bus 0000:00: resource 21 [mem 0xfed1c000-0xfed1cfff window]
[    1.159604] pci_bus 0000:00: resource 22 [mem 0xfee00000-0xfeefffff window]
[    1.159609] pci_bus 0000:01: resource 1 [mem 0xa1200000-0xa12fffff]
[    1.159613] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    1.159616] pci_bus 0000:02: resource 1 [mem 0xa1100000-0xa11fffff]
[    1.161177] NET: Registered protocol family 2
[    1.162592] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes)
[    1.163168] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    1.163310] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
[    1.171649] TCP: Hash tables configured (established 65536 bind 65536)
[    1.172093] UDP hash table entries: 4096 (order: 7, 655360 bytes)
[    1.173276] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
[    1.174969] NET: Registered protocol family 1
[    1.175053] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.177406] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    1.177425] IOAPIC[0]: Set routing entry (1-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
[    1.179782] PCI: CLS 64 bytes, default 64
[    1.180447] Unpacking initramfs...
[    2.613861] Freeing initrd memory: 55784K
[    2.614116] DMAR: No ATSR found
[    2.614564] DMAR: dmar1: Using Queued invalidation
[    2.614629] DMAR: Setting RMRR:
[    2.615218] DMAR: Setting identity map for device 0000:00:15.0 [0x69d08000 - 0x69d27fff]
[    2.615243] DMAR: Prepare 0-16MiB unity mapping for LPC
[    2.615657] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    2.615676] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    2.616160] iommu: Adding device 0000:00:00.0 to group 0
[    2.616310] iommu: Adding device 0000:00:0c.0 to group 1
[    2.616433] iommu: Adding device 0000:00:0e.0 to group 2
[    2.616564] iommu: Adding device 0000:00:0f.0 to group 3
[    2.616680] iommu: Adding device 0000:00:12.0 to group 4
[    2.616803] iommu: Adding device 0000:00:13.0 to group 5
[    2.616927] iommu: Adding device 0000:00:13.2 to group 6
[    2.617070] iommu: Adding device 0000:00:15.0 to group 7
[    2.617189] iommu: Adding device 0000:00:1c.0 to group 8
[    2.617325] iommu: Adding device 0000:00:1f.0 to group 9
[    2.617399] iommu: Adding device 0000:00:1f.1 to group 9
[    2.617528] iommu: Adding device 0000:01:00.0 to group 10
[    2.617646] iommu: Adding device 0000:02:00.0 to group 11
[    2.634749] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    2.634753] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    2.634756] RAPL PMU: hw unit of domain package 2^-14 Joules
[    2.634758] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    2.634761] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    2.634917] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3990bec8342, max_idle_ns: 881590769617 ns
[    2.634957] clocksource: Switched to clocksource tsc
[    2.637959] cryptomgr_test (38) used greatest stack depth: 14776 bytes left
[    2.644033] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    2.682060] ntfs: driver 2.1.32 [Flags: R/O].
[    2.683822] pstore: using deflate compression
[    2.684834] cryptomgr_test (40) used greatest stack depth: 14320 bytes left
[    2.685848] cryptomgr_test (44) used greatest stack depth: 14184 bytes left
[    2.686380] cryptomgr_test (45) used greatest stack depth: 13864 bytes left
[    2.711752] cryptomgr_test (64) used greatest stack depth: 13552 bytes left
[    2.711770] cryptomgr_test (69) used greatest stack depth: 13384 bytes left
[    2.727830] NET: Registered protocol family 38
[    2.728398] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    2.728414] io scheduler noop registered
[    2.729031] io scheduler cfq registered (default)
[    2.729036] io scheduler mq-deadline registered
[    2.729040] io scheduler kyber registered
[    2.733755] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    2.733775] IOAPIC[0]: Set routing entry (1-21 -> 0xef -> IRQ 21 Mode:1 Active:1 Dest:1)
[    2.737658] pcieport 0000:00:13.0: Signaling PME with IRQ 122
[    2.737867] pcieport 0000:00:13.2: Signaling PME with IRQ 123
[    2.738804] uvesafb: failed to execute /sbin/v86d
[    2.738848] uvesafb: make sure that the v86d helper is installed and executable
[    2.738892] uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)
[    2.738934] uvesafb: vbe_init() failed with -22
[    2.739039] uvesafb: probe of uvesafb.0 failed with error -22
[    2.739187] intel_idle: MWAIT substates: 0x11242020
[    2.739191] intel_idle: v0.4.1 model 0x7A
[    2.741058] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.741916] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.742290] ACPI: Power Button [PWRB]
[    2.742762] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    2.742866] ACPI: Sleep Button [SLPB]
[    2.802110] thermal LNXTHERM:00: registered as thermal_zone0
[    2.802133] ACPI: Thermal Zone [TZ01] (44 C)
[    2.803156] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.808242] Non-volatile memory driver v1.3
[    2.808737] Linux agpgart interface v0.103
[    2.810846] loop: module loaded
[    2.813603] ahci 0000:00:12.0: version 3.0
[    2.815827] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    2.815843] IOAPIC[0]: Set routing entry (1-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
[    2.826774] ahci 0000:00:12.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    2.826783] ahci 0000:00:12.0: flags: 64bit ncq sntf pm clo only pmp pio slum part deso sadm sds apst 
[    2.831413] scsi host0: ahci
[    2.833106] scsi host1: ahci
[    2.833665] ata1: SATA max UDMA/133 abar m2048@0xa131d000 port 0xa131d100 irq 124
[    2.833671] ata2: SATA max UDMA/133 abar m2048@0xa131d000 port 0xa131d180 irq 124
[    2.834281] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.834330] ehci-pci: EHCI PCI platform driver
[    2.834414] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.834438] ohci-pci: OHCI PCI platform driver
[    2.834523] uhci_hcd: USB Universal Host Controller Interface driver
[    2.837476] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    2.837492] IOAPIC[0]: Set routing entry (1-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
[    2.837680] xhci_hcd 0000:00:15.0: xHCI Host Controller
[    2.837828] xhci_hcd 0000:00:15.0: new USB bus registered, assigned bus number 1
[    2.839474] xhci_hcd 0000:00:15.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    2.839487] xhci_hcd 0000:00:15.0: cache line size of 64 is not supported
[    2.841222] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
[    2.841232] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.841237] usb usb1: Product: xHCI Host Controller
[    2.841241] usb usb1: Manufacturer: Linux 4.17.0-rc1-CI-CI_DRM_4040+ xhci-hcd
[    2.841245] usb usb1: SerialNumber: 0000:00:15.0
[    2.843030] hub 1-0:1.0: USB hub found
[    2.843250] hub 1-0:1.0: 9 ports detected
[    2.879748] xhci_hcd 0000:00:15.0: xHCI Host Controller
[    2.879793] xhci_hcd 0000:00:15.0: new USB bus registered, assigned bus number 2
[    2.879827] xhci_hcd 0000:00:15.0: Host supports USB 3.0  SuperSpeed
[    2.880534] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.17
[    2.880541] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.880545] usb usb2: Product: xHCI Host Controller
[    2.880549] usb usb2: Manufacturer: Linux 4.17.0-rc1-CI-CI_DRM_4040+ xhci-hcd
[    2.880553] usb usb2: SerialNumber: 0000:00:15.0
[    2.882117] hub 2-0:1.0: USB hub found
[    2.882299] hub 2-0:1.0: 7 ports detected
[    2.909214] usbcore: registered new interface driver usb-storage
[    2.909729] i8042: PNP: No PS/2 controller found.
[    2.909732] i8042: Probing ports directly.
[    3.023312] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.023902] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.024680] mousedev: PS/2 mouse device common for all mice
[    3.027093] rtc_cmos 00:04: RTC can wake from S4
[    3.028269] rtc_cmos 00:04: registered as rtc0
[    3.028510] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    3.028660] IR NEC protocol handler initialized
[    3.028664] IR RC5(x/sz) protocol handler initialized
[    3.028667] IR RC6 protocol handler initialized
[    3.028670] IR JVC protocol handler initialized
[    3.028674] IR Sony protocol handler initialized
[    3.028677] IR SANYO protocol handler initialized
[    3.028680] IR Sharp protocol handler initialized
[    3.028683] IR MCE Keyboard/mouse protocol handler initialized
[    3.028687] IR XMP protocol handler initialized
[    3.029599] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
[    3.030554] device-mapper: uevent: version 1.0.3
[    3.031700] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    3.031713] intel_pstate: Intel P-state driver initializing
[    3.032902] sdhci: Secure Digital Host Controller Interface driver
[    3.032909] sdhci: Copyright(c) Pierre Ossman
[    3.033228] sdhci-pci 0000:00:1c.0: SDHCI controller found [8086:31cc] (rev 3)
[    3.039234] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    3.039270] IOAPIC[0]: Set routing entry (1-39 -> 0xef -> IRQ 39 Mode:1 Active:1 Dest:1)
[    3.044784] mmc0: CQHCI version 5.10
[    3.045842] mmc0: SDHCI controller on PCI [0000:00:1c.0] using ADMA 64-bit
[    3.048977] EFI Variables Facility v0.08 2004-May-17
[    3.068826] input: AT Raw Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    3.080162] pstore: Registered efi as persistent store backend
[    3.080281] hidraw: raw HID events driver (C) Jiri Kosina
[    3.081198] usbcore: registered new interface driver usbhid
[    3.081201] usbhid: USB HID core driver
[    3.081747] intel_rapl: Found RAPL domain package
[    3.081756] intel_rapl: Found RAPL domain core
[    3.081761] intel_rapl: Found RAPL domain uncore
[    3.081766] intel_rapl: Found RAPL domain dram
[    3.084354] Initializing XFRM netlink socket
[    3.086740] NET: Registered protocol family 10
[    3.090844] Segment Routing with IPv6
[    3.090905] mip6: Mobile IPv6
[    3.090923] NET: Registered protocol family 17
[    3.090951] NET: Registered protocol family 15
[    3.090954] start plist test
[    3.092520] end plist test
[    3.093763] microcode: sig=0x706a1, pf=0x1, revision=0x20
[    3.094084] microcode: Microcode Update Driver: v2.2.
[    3.094193] ... APIC ID:      00000000 (0)
[    3.094197] ... APIC VERSION: 01060014
[    3.094201] 0000000000000000000000000000000000000000000000000000000000000000
[    3.094220] 0000000000000000000000000000000000000000000000000000000000000000
[    3.094238] 0000000000000000000000000000000000000000000000000000000000000000
[    3.094258] number of MP IRQ sources: 15.
[    3.094261] number of IO-APIC #1 registers: 120.
[    3.094263] testing the IO APIC.......................
[    3.094289] IO APIC #1......
[    3.094292] .... register #00: 01000000
[    3.094294] .......    : physical APIC id: 01
[    3.094296] .......    : Delivery Type: 0
[    3.094298] .......    : LTS          : 0
[    3.094300] .... register #01: 00770020
[    3.094302] .......     : max redirection entries: 77
[    3.094304] .......     : PRQ implemented: 0
[    3.094306] .......     : IO APIC version: 20
[    3.094308] .... register #02: 00000000
[    3.094311] .......     : arbitration: 00
[    3.094313] .... IRQ redirection table:
[    3.094315] IOAPIC 0:
[    3.094333]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094348]  pin01, enabled , edge , high, V(01), IRR(0), S(0), remapped, I(0000),  Z(0)
[    3.094364]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped, I(0001),  Z(0)
[    3.094380]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094395]  pin04, disabled, edge , high, V(1D), IRR(0), S(0), physical, D(D7), M(2)
[    3.094411]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094427]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094442]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094458]  pin08, enabled , level, high, V(08), IRR(0), S(0), remapped, I(0007),  Z(0)
[    3.094474]  pin09, enabled , level, low , V(09), IRR(0), S(0), remapped, I(0008),  Z(0)
[    3.094490]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094505]  pin0b, disabled, edge , high, V(A7), IRR(0), S(0), remapped, I(8882),  Z(2)
[    3.094521]  pin0c, enabled , edge , high, V(0C), IRR(0), S(0), remapped, I(000B),  Z(0)
[    3.094536]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094552]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094568]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094593]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094609]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094624]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094640]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094655]  pin14, disabled, edge , high, V(35), IRR(0), S(0), physical, D(BE), M(2)
[    3.094671]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094687]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094702]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094718]  pin18, disabled, edge , high, V(06), IRR(0), S(0), logical , D(32), M(2)
[    3.094733]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094749]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094765]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094780]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094796]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094811]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094827]  pin1f, disabled, edge , high, V(42), IRR(0), S(0), remapped, I(9AD7),  Z(2)
[    3.094842]  pin20, disabled, edge , high, V(50), IRR(0), S(0), remapped, I(89C3),  Z(2)
[    3.094858]  pin21, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094874]  pin22, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094889]  pin23, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094905]  pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094920]  pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094936]  pin26, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.094952]  pin27, enabled , level, low , V(27), IRR(0), S(0), remapped, I(0016),  Z(0)
[    3.094967]  pin28, disabled, edge , high, V(02), IRR(0), S(0), physical, D(60), M(2)
[    3.094983]  pin29, disabled, edge , high, V(A8), IRR(0), S(0), logical , D(90), M(2)
[    3.094998]  pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095025]  pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095041]  pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095060]  pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095076]  pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095091]  pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095107]  pin30, disabled, edge , high, V(47), IRR(0), S(0), logical , D(E2), M(2)
[    3.095123]  pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095138]  pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095154]  pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095169]  pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095185]  pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095201]  pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095217]  pin37, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095232]  pin38, disabled, edge , high, V(C4), IRR(0), S(0), physical, D(10), M(2)
[    3.095248]  pin39, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095264]  pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095279]  pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095295]  pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095311]  pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095326]  pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095342]  pin3f, disabled, edge , high, V(C0), IRR(0), S(0), physical, D(04), M(2)
[    3.095357]  pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095373]  pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095389]  pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095404]  pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095420]  pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095435]  pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095451]  pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095467]  pin47, disabled, edge , high, V(5C), IRR(0), S(0), physical, D(9C), M(2)
[    3.095482]  pin48, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095498]  pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095513]  pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095529]  pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095545]  pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095560]  pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095576]  pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095592]  pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095607]  pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095623]  pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095639]  pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095654]  pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095670]  pin54, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095685]  pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095701]  pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095717]  pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095732]  pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095748]  pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095764]  pin5a, disabled, edge , high, V(EC), IRR(0), S(0), remapped, I(C9E3),  Z(2)
[    3.095779]  pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095795]  pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095810]  pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095826]  pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095842]  pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095857]  pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095873]  pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095889]  pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095905]  pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095920]  pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095936]  pin65, disabled, edge , high, V(58), IRR(0), S(0), physical, D(B6), M(2)
[    3.095951]  pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095967]  pin67, disabled, edge , high, V(65), IRR(0), S(0), physical, D(88), M(2)
[    3.095983]  pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.095998]  pin69, disabled, edge , high, V(F6), IRR(0), S(0), logical , D(9D), M(2)
[    3.096027]  pin6a, disabled, edge , high, V(14), IRR(0), S(0), logical , D(68), M(2)
[    3.096042]  pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096058]  pin6c, disabled, edge , high, V(D0), IRR(0), S(0), remapped, I(79FC),  Z(2)
[    3.096073]  pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096089]  pin6e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096105]  pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096120]  pin70, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096136]  pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096151]  pin72, disabled, edge , high, V(A7), IRR(0), S(0), remapped, I(2628),  Z(2)
[    3.096167]  pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096183]  pin74, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096198]  pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096214]  pin76, disabled, edge , high, V(2A), IRR(0), S(0), physical, D(96), M(2)
[    3.096229]  pin77, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.096232] IRQ to pin mappings:
[    3.096235] IRQ0 -> 0:2
[    3.096242] IRQ1 -> 0:1
[    3.096249] IRQ3 -> 0:3
[    3.096255] IRQ4 -> 0:4
[    3.096262] IRQ5 -> 0:5
[    3.096268] IRQ6 -> 0:6
[    3.096275] IRQ7 -> 0:7
[    3.096281] IRQ8 -> 0:8
[    3.096288] IRQ9 -> 0:9
[    3.096294] IRQ10 -> 0:10
[    3.096301] IRQ11 -> 0:11
[    3.096308] IRQ12 -> 0:12
[    3.096315] IRQ13 -> 0:13
[    3.096321] IRQ14 -> 0:14
[    3.096328] IRQ15 -> 0:15
[    3.096334] IRQ17 -> 0:17
[    3.096341] IRQ19 -> 0:19
[    3.096348] IRQ21 -> 0:21
[    3.096354] IRQ39 -> 0:39
[    3.096362] .................................... done.
[    3.096417] SSE version of gcm_enc/dec engaged.
[    3.121923] cryptomgr_test (125) used greatest stack depth: 13208 bytes left
[    3.143787] ata2: SATA link down (SStatus 4 SControl 300)
[    3.169808] alg: No test for pcbc(aes) (pcbc-aes-aesni)
[    3.169842] sched_clock: Marking stable (3169820745, 0)->(3169309447, 511298)
[    3.171109] registered taskstats version 1
[    3.176119] Btrfs loaded, crc32c=crc32c-generic
[    3.186603] rtc_cmos 00:04: setting system clock to 2018-04-19 01:09:22 UTC (1524100162)
[    3.187585] ALSA device list:
[    3.187587]   No soundcards found.
[    3.203341] usb 1-9: new full-speed USB device number 2 using xhci_hcd
[    3.304335] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.308093] ata1.00: ATA-10: INTEL SSDSC2BW120H6, RG20, max UDMA/133
[    3.308105] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.324091] ata1.00: configured for UDMA/133
[    3.325553] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BW12 RG20 PQ: 0 ANSI: 5
[    3.327882] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    3.327965] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.327975] sd 0:0:0:0: [sda] Write Protect is off
[    3.327993] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.328157] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.330715] usb 1-9: New USB device found, idVendor=8087, idProduct=0aaa, bcdDevice= 0.02
[    3.330722] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.334504]  sda: sda1 sda2
[    3.336964] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.350552] Freeing unused kernel memory: 1520K
[    3.350556] Write protecting the kernel read-only data: 18432k
[    3.352497] Freeing unused kernel memory: 2008K
[    3.353997] Freeing unused kernel memory: 492K
[    3.367845] mount (164) used greatest stack depth: 13200 bytes left
[    4.049324] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    4.053337] IOAPIC[1]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:FAF8 SQ:0 SVT:1)
[    4.053351] IOAPIC[0]: Set routing entry (1-20 -> 0xef -> IRQ 20 Mode:1 Active:1 Dest:1)
[    4.059719] r8169 0000:02:00.0 eth0: RTL8168h/8111h at 0x00000000b3cf7dc3, 94:c6:91:1b:4d:6b, XID 14100880 IRQ 126
[    4.059723] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    4.225407] r8169 0000:02:00.0 enp2s0: renamed from eth0
[    4.241675] systemd-udevd (196) used greatest stack depth: 12944 bytes left
[    4.246555] systemd-udevd (203) used greatest stack depth: 12888 bytes left
[    4.375323] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    4.420734] run-init (237) used greatest stack depth: 12680 bytes left
[    4.741933] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    4.754639] systemd[1]: Detected architecture x86-64.
[    4.764324] systemd[1]: Set hostname to <glk5>.
[    4.998397] systemd-sysv-ge (252) used greatest stack depth: 11920 bytes left
[    5.014644] systemd[1]: File /lib/systemd/system/systemd-journald.service:36 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    5.014660] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    5.122733] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    5.123034] systemd[1]: Reached target Remote File Systems.
[    5.124341] systemd[1]: Created slice System Slice.
[    5.125079] systemd[1]: Listening on Journal Socket.
[    5.130586] systemd[1]: Mounting POSIX Message Queue File System...
[    5.261296] EXT4-fs (sda2): re-mounted. Opts: errors=panic
[    5.995046] systemd-journald[267]: Received request to flush runtime journal from PID 1
[    6.077901] Adding 2097148k swap on /swapfile.  Priority:-2 extents:6 across:2260988k SSFS
[    7.246762] Bluetooth: Core ver 2.22
[    7.246883] NET: Registered protocol family 31
[    7.246886] Bluetooth: HCI device and connection manager initialized
[    7.259055] Bluetooth: HCI socket layer initialized
[    7.259081] Bluetooth: L2CAP socket layer initialized
[    7.259246] Bluetooth: SCO socket layer initialized
[    7.298732] usbcore: registered new interface driver btusb
[    7.309471] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[    7.311186] Bluetooth: hci0: Device revision is 2
[    7.311189] Bluetooth: hci0: Secure boot is enabled
[    7.311192] Bluetooth: hci0: OTP lock is enabled
[    7.311194] Bluetooth: hci0: API lock is enabled
[    7.311197] Bluetooth: hci0: Debug lock is disabled
[    7.311200] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    7.319357] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
[    8.073837] random: crng init done
[    8.815604] Bluetooth: hci0: Waiting for firmware download to complete
[    8.816221] Bluetooth: hci0: Firmware loaded in 1477999 usecs
[    8.816719] Bluetooth: hci0: Waiting for device to boot
[    8.830134] Bluetooth: hci0: Device booted in 13306 usecs
[    8.830848] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-17-16-1.ddc
[    8.834187] Bluetooth: hci0: Applying Intel DDC parameters completed
[    9.533121] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[    9.553212] r8169 0000:02:00.0 enp2s0: link down
[    9.553243] r8169 0000:02:00.0 enp2s0: link down
[    9.553870] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[   13.119804] r8169 0000:02:00.0 enp2s0: link up
[   13.119857] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0: link becomes ready
[   30.243749] systemd-journald[267]: Failed to set ACL on /var/log/journal/699f4ba165754644b46a8b2fcb791cac/user-1001.journal, ignoring: Operation not supported
[   42.258190] PM: suspend entry (deep)
[   42.258542] PM: Syncing filesystems ... done.
[   42.343609] Freezing user space processes ... (elapsed 0.012 seconds) done.
[   42.357238] OOM killer disabled.
[   42.357242] Freezing remaining freezable tasks ... (elapsed 0.006 seconds) done.
[   42.367789] Suspending console(s) (use no_console_suspend to debug)
[   42.415713] cpu 1 jiffies-delta 11000000 ns (4294709700->4294709711) cpu_clock-delta 215738 ns (42415489466 -> 42415705204)
[   42.448902] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   42.455895] sd 0:0:0:0: [sda] Stopping disk
[   42.613682] ACPI: EC: interrupt blocked
[   42.636067] ACPI: Preparing to enter system sleep state S3
[   42.645582] ACPI: EC: event blocked
[   42.645591] ACPI: EC: EC stopped
[   42.645596] PM: Saving platform NVS memory
[   42.645663] Disabling non-boot CPUs ...
[   42.665753] smpboot: CPU 1 is now offline
[   42.679016] ACPI: Low-level resume complete
[   42.679227] ACPI: EC: EC started
[   42.679232] PM: Restoring platform NVS memory
[   42.681171] Enabling non-boot CPUs ...
[   42.681499] x86: Booting SMP configuration:
[   42.681530] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   42.682246] masked ExtINT on CPU#1
[   42.682281] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[   42.685207]  cache: parent cpu1 should not be sleeping
[   42.688175] CPU1 is up
[   42.692325] ACPI: Waking up from system sleep state S3
[   42.711832] ACPI: EC: interrupt unblocked
[   42.751683] ACPI: EC: event unblocked
[   42.762874] sd 0:0:0:0: [sda] Starting disk
[   42.772740] r8169 0000:02:00.0 enp2s0: link down
[   42.867202] acpi LNXPOWER:06: Turning OFF
[   42.870448] acpi LNXPOWER:05: Turning OFF
[   42.873646] acpi LNXPOWER:04: Turning OFF
[   42.876867] acpi LNXPOWER:03: Turning OFF
[   42.880060] acpi LNXPOWER:02: Turning OFF
[   42.883277] acpi LNXPOWER:01: Turning OFF
[   42.886492] acpi LNXPOWER:00: Turning OFF
[   42.888130] OOM killer enabled.
[   42.888134] Restarting tasks ... done.
[   42.932112] PM: suspend exit
[   43.068715] ata2: SATA link down (SStatus 4 SControl 300)
[   43.239069] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   43.256735] ata1.00: configured for UDMA/133
[   45.993881] r8169 0000:02:00.0 enp2s0: link up

--u2te2ork33f3tlwv--
