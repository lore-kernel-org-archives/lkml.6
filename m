Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeEGThF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:37:05 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:37081 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeEGThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:37:04 -0400
X-Google-Smtp-Source: AB8JxZpJr3H3qxEsQyJF/PL2mZa1dTcMVgCmgeR2moPl/E1h8CUi58FQEYwUYFXtLt/h0WpueCTkEBZAN0513oIC/oA=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <20180507174909.GF19594@google.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
 <20180507174909.GF19594@google.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 7 May 2018 21:37:01 +0200
Message-ID: <CA+icZUU=F7jbwYQLVjD2OaYyuefhaZDCVCqfq+_gDAvmOdOM4w@mail.gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: Matthias Kaehlcke <mka@chromium.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        AlistairStrachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 7:49 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Sun, May 06, 2018 at 09:42:09AM +0200, Sedat Dilek wrote:
>> On Wed, Apr 25, 2018 at 1:06 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> > On Tue, Apr 24, 2018 at 01:54:29PM +0200, Sedat Dilek wrote:
>> >> Hi Matthias,
>> >>
>> >> a big thank you for giving all the informations!
>> >>
>> >> I used your mka/llvm/v4.14_ext Git tree...
>> >>
>> >> https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/sandbox/mka/llvm/v4.14_ext
>> >>
>> >> ...and was able to compile with clang-6.0 from Debian/buster64 with...
>> >>
>> >> ...reverting the clang-3/clang-4 patches...
>> >>
>> >> user$ for p in 69e44656ae43 222b88977a00 cdfcf1e45537 26f14c9225a6
>> >> 0385a18e9995 68dab143c9b4 ; do echo [ $p ] ; LC_ALL=C git revert
>> >> --no-edit $p ; done
>> >>
>> >> 0001-Revert-CLANG3-core-clang-work-around-x86-regparm-int.patch
>> >> 0002-Revert-CLANG4-futex-don-t-optimize-futex_detect_cmpx.patch
>> >> 0003-Revert-CLANG4-Disable-lkdtm-when-ftrace-is-enabled.patch
>> >> 0004-Revert-CLANG4-arm64-prefetch-Use-__builtin_arm_prefe.patch
>> >> 0005-Revert-CLANG4-kbuild-Add-meabi-gnu-to-the-clang-para.patch
>> >> 0006-Revert-CLANG4-crypto-arm64-aes-ce-Explicitly-pass-th.patch
>> >>
>> >> ...and needed two additional patches from upstream:
>> >>
>> >> 0007-kbuild-clang-remove-crufty-HOSTCFLAGS.patch <--- Label with
>> >> BACKPORT (XXX: Backported; Required when using HOSTCC in make-line,
>> >> see below)
>> >> 0008-x86-xen-remove-the-use-of-VLAIS.patch <--- Label with UPSTREAM
>> >> (XXX: cherry-picked)
>> >>
>> >> These 3 patches in your Git branch are in Linux v4.14.36...
>> >>
>> >> 9af5ddf981ed BACKPORT: kbuild: disable clang's default use of
>> >> -fmerge-all-constants
>> >> f24088a3842c BACKPORT: kbuild: Set KBUILD_CFLAGS before incl. arch Makefile
>> >> d4dfe384346d UPSTREAM: kbuild: fix linker feature test macros when
>> >> cross compiling with Clang
>> >>
>> >> ...and can be dropped.
>> >> I do not know your work-flow/policy: Maybe you want to keep your
>> >> patch-stack against vanilla Linux v4.14 - without stables from
>> >> linux-stable-4.14.y.
>> >
>> > Yes, these patch stacks are based on vanilla Linux v4.14, one reason
>> > is that it isn't a moving target. Also I think it makes it easier for
>> > folks not merging LTS (though they probably should!) to locate all
>> > patches, and it's fairly trivial to skip the (currently) few patches
>> > not needed with the -stable tree.
>> >
>> >> For easy switching "mycompiler" I use a wrapper-script:
>> >>
>> >> root# cat /usr/bin/mycompiler
>> >> #!/bin/bash
>> >>
>> >> clang-6.0 "$@"
>> >> - EOF -
>> >>
>> >> user$ cp -v /boot/config-4.14.35-1-iniza-amd64 .config
>> >> user$ MAKE="make V=1" ; COMPILER="mycompiler" ;
>> >> MAKE_OPTS="CC=$COMPILER HOSTCC=$COMPILER"
>> >> user$ yes "" | $MAKE $MAKE_OPTS oldconfig && $MAKE $MAKE_OPTS
>> >> silentoldconfig < /dev/null
>> >>
>> >> The diffconfig to my current kernel-config-4.14 looks like this...
>> >>
>> >> user$ ./scripts/diffconfig /boot/config-4.14.35-1-iniza-amd64 .config
>> >> -ARCH_HAS_REFCOUNT y
>> >> -BPF_JIT_ALWAYS_ON n
>> >> -EXOFS_DEBUG n
>> >> -EXOFS_FS m
>> >> -GENERIC_CPU_VULNERABILITIES y
>> >> -KASAN n
>> >> -ORE m
>> >> -PAGE_TABLE_ISOLATION y
>> >> -RETPOLINE y
>> >> -UNWINDER_FRAME_POINTER n
>> >> -UNWINDER_GUESS n
>> >> -UNWINDER_ORC y
>> >> +FRAME_POINTER y
>> >> +FRAME_POINTER_UNWINDER y
>> >> +GUESS_UNWINDER n
>> >> +HAVE_ARCH_KMEMCHECK y
>> >> +HAVE_RELIABLE_STACKTRACE y
>> >> +ORC_UNWINDER n
>> >>
>> >> Unfortunately, I cannot boot into the generated kernel on bare metal.
>> >>
>> >> Checking with QEMU (version: 2.12~rc3) and catching earlyprintk, I see this...
>> >>
>> >> user$ echo $KPATH
>> >> $HOME/src/linux-kernel/important-files
>> >>
>> >> user$ ls -al
>> >> insgesamt 344916
>> >> drwxr-xr-x  2 sdi sdi      4096 Apr 24 13:15 .
>> >> drwxr-xr-x 20 sdi sdi      4096 Apr 24 13:13 ..
>> >> -rw-r--r--  1 sdi sdi   4528416 Apr 24 12:42 bzImage
>> >> lrwxrwxrwx  1 sdi sdi        35 Apr 24 13:15 initrd.img ->
>> >> initrd.img-4.14.0-1-iniza-llvmlinux
>> >> -rw-r--r--  1 sdi sdi  25572955 Apr 24 13:08
>> >> initrd.img-4.14.0-1-iniza-llvmlinux
>> >> -rw-r--r--  1 sdi sdi   2887195 Apr 24 12:42 System.map
>> >> -rwxr-xr-x  1 sdi sdi 326116744 Apr 24 12:42 vmlinux
>> >>
>> >> user$ sudo qemu-system-x86_64 -enable-kvm -M pc -kernel $KPATH/bzImage
>> >> -initrd $KPATH/initrd.img -m 512 -net none -serial stdio -append
>> >> "root=/dev/ram0 console=ttyS0 hung_task_panic=1
>> >> earlyprintk=ttyS0,115200"
>> >>
>> >> Probing EDD (edd=off to disable)... ok
>> >> [    0.000000] Linux version 4.14.0-1-iniza-llvmlinux
>> >> (sedat.dilek@gmail.com@iniza) (clang version 6.0.0-1
>> >> (tags/RELEASE_600/final)) #1 SMP Tue Apr 24 12:42:21 CEST 2018
>> >> [    0.000000] Command line: root=/dev/ram0 console=ttyS0
>> >> hung_task_panic=1 earlyprintk=ttyS0,115200
>> >> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
>> >> [    0.000000] e820: BIOS-provided physical RAM map:
>> >> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
>> >> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
>> >> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
>> >> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
>> >> [    0.000000] BIOS-e820: [mem 0x000000001ffe0000-0x000000001fffffff] reserved
>> >> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
>> >> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
>> >> [    0.000000] bootconsole [earlyser0] enabled
>> >> [    0.000000] NX (Execute Disable) protection: active
>> >> [    0.000000] random: fast init done
>> >> [    0.000000] SMBIOS 2.8 present.
>> >> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> >> 1.11.1-1 04/01/2014
>> >> [    0.000000] Hypervisor detected: KVM
>> >> [    0.000000] tsc: Fast TSC calibration using PIT
>> >> [    0.000000] e820: last_pfn = 0x1ffe0 max_arch_pfn = 0x400000000
>> >> [    0.000000] x86/PAT: PAT not supported by CPU.
>> >> [    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
>> >> Memory KASLR using RDTSC...
>> >> [    0.000000] found SMP MP-table at [mem 0x000f5d60-0x000f5d6f]
>> >> mapped at [ffffffffff000d60]
>> >> [    0.000000] RAMDISK: [mem 0x1e77c000-0x1ffdffff]
>> >> [    0.000000] ACPI: Early table checksum verification disabled
>> >> [    0.000000] ACPI: RSDP 0x00000000000F5B90 000014 (v00 BOCHS )
>> >> [    0.000000] ACPI: RSDT 0x000000001FFE157C 000030 (v01 BOCHS
>> >> BXPCRSDT 00000001 BXPC 00000001)
>> >> [    0.000000] ACPI: FACP 0x000000001FFE1458 000074 (v01 BOCHS
>> >> BXPCFACP 00000001 BXPC 00000001)
>> >> [    0.000000] ACPI: DSDT 0x000000001FFE0040 001418 (v01 BOCHS
>> >> BXPCDSDT 00000001 BXPC 00000001)
>> >> [    0.000000] ACPI: FACS 0x000000001FFE0000 000040
>> >> [    0.000000] ACPI: APIC 0x000000001FFE14CC 000078 (v01 BOCHS
>> >> BXPCAPIC 00000001 BXPC 00000001)
>> >> [    0.000000] ACPI: HPET 0x000000001FFE1544 000038 (v01 BOCHS
>> >> BXPCHPET 00000001 BXPC 00000001)
>> >> [    0.000000] No NUMA configuration found
>> >> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001ffdffff]
>> >> [    0.000000] NODE_DATA(0) allocated [mem 0x1e777000-0x1e77bfff]
>> >> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
>> >> [    0.000000] kvm-clock: cpu 0, msr 0:1e76f001, primary cpu clock
>> >> [    0.000000] kvm-clock: using sched offset of 528742140 cycles
>> >> [    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff
>> >> max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>> >> [    0.000000] Zone ranges:
>> >> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>> >> [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000001ffdffff]
>> >> [    0.000000]   Normal   empty
>> >> [    0.000000]   Device   empty
>> >> [    0.000000] Movable zone start for each node
>> >> [    0.000000] Early memory node ranges
>> >> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
>> >> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffdffff]
>> >> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdffff]
>> >> [    0.000000] ACPI: PM-Timer IO Port: 0x608
>> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
>> >> [    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
>> >> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> >> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
>> >> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>> >> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
>> >> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
>> >> [    0.000000] Using ACPI (MADT) for SMP configuration information
>> >> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
>> >> [    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
>> >> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
>> >> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
>> >> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
>> >> [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
>> >> [    0.000000] e820: [mem 0x20000000-0xfeffbfff] available for PCI devices
>> >> [    0.000000] Booting paravirtualized kernel on KVM
>> >> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
>> >> max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
>> >> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512
>> >> nr_cpu_ids:1 nr_node_ids:1
>> >> [    0.000000] percpu: Embedded 37 pages/cpu @ffff96dd9e400000 s114392
>> >> r8192 d28968 u2097152
>> >> [    0.000000] KVM setup async PF for cpu 0
>> >> [    0.000000] kvm-stealtime: cpu 0, msr 1e40d900
>> >> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128872
>> >> [    0.000000] Policy zone: DMA32
>> >> [    0.000000] Kernel command line: root=/dev/ram0 console=ttyS0
>> >> hung_task_panic=1 earlyprintk=ttyS0,115200
>> >> [    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
>> >> [    0.000000] Memory: 474480K/523768K available (7639K kernel code,
>> >> 1005K rwdata, 2936K rodata, 1636K init, 688K bss, 49288K reserved, 0K
>> >> cma-reserved)
>> >> [    0.000000] ftrace: allocating 27586 entries in 108 pages
>> >> [    0.004000] Hierarchical RCU implementation.
>> >> [    0.004000]  RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=1.
>> >> [    0.004000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
>> >> [    0.004000] NR_IRQS: 33024, nr_irqs: 256, preallocated irqs: 16
>> >> [    0.004000] Console: colour VGA+ 80x25
>> >> [    0.004000] console [ttyS0] enabled
>> >> [    0.004000] console [ttyS0] enabled
>> >> [    0.004000] bootconsole [earlyser0] disabled
>> >> [    0.004000] bootconsole [earlyser0] disabled
>> >> [    0.004000] clocksource: hpet: mask: 0xffffffff max_cycles:
>> >> 0xffffffff, max_idle_ns: 19112604467 ns
>> >> [    0.004000] general protection fault: 0000 [#1] SMP
>> >> [    0.004000] Modules linked in:
>> >> [    0.004000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>> >> 4.14.0-1-iniza-llvmlinux #1
>> >> [    0.004000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> >> BIOS 1.11.1-1 04/01/2014
>> >> [    0.004000] task: ffffffffaa610480 task.stack: ffffffffaa600000
>> >> [    0.004000] RIP: 0010:irq_work_tick+0x9d/0x110
>> >> [    0.004000] RSP: 0000:ffff96dd9e403e58 EFLAGS: 00010046
>> >> [    0.004000] RAX: 0000000000000082 RBX: ffff96dd9e411d80 RCX: adecc9cc04e2ca00
>> >> [    0.004000] RDX: 000000000001ba00 RSI: fffffffffffffed4 RDI: ffff96dd9e41ba38
>> >> [    0.004000] RBP: ffff96dd9e403e78 R08: 0000000000000000 R09: 0000000000000018
>> >> [    0.004000] R10: 0000000000000000 R11: 0000000000000018 R12: ffffffffaa61bd40
>> >> [    0.004000] R13: 0000000000000000 R14: ffffffffaa610480 R15: 0000000000000000
>> >> [    0.004000] FS:  0000000000000000(0000) GS:ffff96dd9e400000(0000)
>> >> knlGS:0000000000000000
>> >> [    0.004000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >> [    0.004000] CR2: 00000000ffffffff CR3: 0000000008a09000 CR4: 00000000000006b0
>> >> [    0.004000] Call Trace:
>> >> [    0.004000]  <IRQ>
>> >> [    0.004000]  update_process_times+0x6e/0xa0
>> >> [    0.004000]  tick_periodic+0x78/0x90
>> >> [    0.004000]  tick_handle_periodic+0x26/0x80
>> >> [    0.004000]  timer_interrupt+0x13/0x20
>> >> [    0.004000]  __handle_irq_event_percpu+0x106/0x230
>> >> [    0.004000]  handle_irq_event+0x5a/0xc0
>> >> [    0.004000]  handle_level_irq+0x11a/0x190
>> >> [    0.004000]  handle_irq+0x1f/0x30
>> >> [    0.004000]  do_IRQ+0x4b/0xd0
>> >> [    0.004000]  common_interrupt+0x93/0x93
>> >> [    0.004000]  </IRQ>
>> >> [    0.004000] RIP: 0010:native_restore_fl+0x12/0x20
>> >> [    0.004000] RSP: 0000:ffffffffaa603e10 EFLAGS: 00000286 ORIG_RAX:
>> >> ffffffffffffffcf
>> >> [    0.004000] RAX: 0000000000000001 RBX: ffff96dd9d0c0608 RCX: 0000000000000000
>> >> [    0.004000] RDX: ffff96dd9d0c0400 RSI: 0000000000000286 RDI: 0000000000000286
>> >> [    0.004000] RBP: ffffffffaa603e18 R08: 0000000000000001 R09: 000000000000003f
>> >> [    0.004000] R10: 0000000000000286 R11: 0000000000000007 R12: ffff96dd9d0c0514
>> >> [    0.004000] R13: ffff96dd9d0c04e0 R14: ffffffffaa61bd40 R15: ffff96dd9d0c0400
>> >> [    0.004000]  _raw_spin_unlock_irqrestore+0x1a/0x20
>> >> [    0.004000]  __setup_irq+0x5d9/0x780
>> >> [    0.004000]  setup_irq+0x5c/0x90
>> >> [    0.004000]  hpet_time_init+0x32/0x40
>> >> [    0.004000]  x86_late_time_init+0x10/0x20
>> >> [    0.004000]  start_kernel+0x45d/0x580
>> >> [    0.004000]  x86_64_start_kernel+0x30f/0x320
>> >> [    0.004000]  secondary_startup_64+0xa5/0xa5
>> >> [    0.004000] Code: f0 f0 4c 0f b1 7b f8 4c 89 e3 4d 85 e4 75 cf 48
>> >> c7 c1 88 5b 01 00 65 48 03 0c 25 d8 a1 00 00 ff 14 25 10 08 62 aa f6
>> >> c4 02 75 4d <48> 83 39 00 74 3e 31 db 48 87 19 48 85 db 74 34 0f 1f 00
>> >> 48 8d
>> >> [    0.004000] RIP: irq_work_tick+0x9d/0x110 RSP: ffff96dd9e403e58
>> >> [    0.004000] ---[ end trace 8c7851007fbc6b6f ]---
>> >> [    0.004000] Kernel panic - not syncing: Fatal exception in interrupt
>> >> [    0.004000] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
>> >>
>> >> Is this saying someting to you?
>> >
>> > It doesn't ring a bell, but I can repro it (with different offsets):
>> >
>> > [    0.004000] general protection fault: 0000 [#1] SMP
>> > [    0.004000] Modules linked in:
>> > [    0.004000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0+ #10
>> > [    0.004000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> > [    0.004000] task: ffffffffbb410480 task.stack: ffffffffbb400000
>> > [    0.004000] RIP: 0010:irq_work_tick+0xaf/0x120
>> > [    0.004000] RSP: 0000:ffff96fb5fc03e58 EFLAGS: 00010046
>> > [    0.004000] RAX: 0000000000000082 RBX: ffff96fb5fc11d80 RCX: 47e992c1bc778d00
>> > [    0.004000] RDX: 000000000001ba00 RSI: fffffffffffffed4 RDI: ffff96fb5fc1ba38
>> > [    0.004000] RBP: ffff96fb5fc03e78 R08: 0000000000000000 R09: 0000000000000018
>> > [    0.004000] R10: 0000000000000000 R11: 0000000000000018 R12: ffffffffbb41bd40
>> > [    0.004000] R13: 0000000000000000 R14: ffffffffbb410480 R15: 0000000000000000
>> > [    0.004000] FS:  0000000000000000(0000) GS:ffff96fb5fc00000(0000) knlGS:0000000000000000
>> > [    0.004000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [    0.004000] CR2: 00000000ffffffff CR3: 000000001ec09000 CR4: 00000000000006b0
>> > [    0.004000] Call Trace:
>> > [    0.004000]  <IRQ>
>> > [    0.004000]  update_process_times+0x6e/0xa0
>> > [    0.004000]  tick_periodic+0x78/0x90
>> > [    0.004000]  tick_handle_periodic+0x26/0x80
>> > [    0.004000]  timer_interrupt+0x13/0x20
>> > [    0.004000]  __handle_irq_event_percpu+0x106/0x230
>> > [    0.004000]  handle_irq_event+0x5a/0xc0
>> > [    0.004000]  handle_level_irq+0x11a/0x190
>> > [    0.004000]  handle_irq+0x1f/0x30
>> > [    0.004000]  do_IRQ+0x4b/0xd0
>> > [    0.004000]  common_interrupt+0x93/0x93
>> > [    0.004000]  </IRQ>
>> > [    0.004000] RIP: 0010:native_restore_fl+0xd/0x20
>> > [    0.004000] RSP: 0000:ffffffffbb403e08 EFLAGS: 00000282 ORIG_RAX: ffffffffffffffcf
>> > [    0.004000] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
>> > [    0.004000] RDX: ffff96fb5f01b800 RSI: 0000000000000282 RDI: 0000000000000282
>> > [    0.004000] RBP: ffffffffbb403e10 R08: 0000000000000001 R09: 000000000000003f
>> > [    0.004000] R10: ffff96fb5f01b800 R11: 0000000000000007 R12: ffff96fb5f01ba08
>> > [    0.004000] R13: ffff96fb5f01b8e0 R14: ffffffffbb41bd40 R15: ffff96fb5f01b800
>> > [    0.004000]  _raw_spin_unlock_irqrestore+0x1a/0x20
>> > [    0.004000]  __setup_irq+0x610/0x7b0
>> > [    0.004000]  setup_irq+0x5b/0x90
>> > [    0.004000]  hpet_time_init+0x32/0x40
>> > [    0.004000]  x86_late_time_init+0x10/0x20
>> > [    0.004000]  start_kernel+0x460/0x580
>> > [    0.004000]  x86_64_start_kernel+0x30f/0x320
>> > [    0.004000]  secondary_startup_64+0xa5/0xa5
>> > [    0.004000] Code: 4c 0f b1 7b f8 4c 89 e3 4d 85 e4 75 cf 48 c7 c1 88 5b 01 00 65 48 03 0c 25 d8 a1 00 00 ff 14 25 10 08 42 bb a9 00 02 00 00 75 4b <48> 83 39 00 74 3c 31 db 48 87 19 48 85 db 74 32 90 48 8d 7b f8
>> > [    0.004000] RIP: irq_work_tick+0xaf/0x120 RSP: ffff96fb5fc03e58
>> > [    0.004000] ---[ end trace 08945838e05bf5b2 ]---
>> > [    0.004000] Kernel panic - not syncing: Fatal exception in interrupt
>> > [    0.004000] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
>> >
>> > The exception occurs at 'irq_work_tick+0xaf'
>> >
>> > objdump -d -S --start-address=0x$(grep irq_work_tick System.map | sed -e
>> >  "s/ \+.*//") vmlinux | less
>> >
>> > ...
>> > void irq_work_tick(void)
>> > {
>> > ffffffff81193200:       55                      push   %rbp
>> > ...
>> > static inline struct llist_node *llist_del_all(struct llist_head *head)
>> > {
>> >         return xchg(&head->first, NULL);
>> > ffffffff8119324a:       48 87 19                xchg   %rbx,(%rcx)
>> >         while (llnode != NULL) {
>> > ffffffff8119324d:       48 85 db                test   %rbx,%rbx
>> > ffffffff81193250:       74 3f                   je     ffffffff81193291 <irq_work_tick+0x91>
>> > ffffffff81193252:       0f 1f 40 00             nopl   0x0(%rax)
>> > ffffffff81193256:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>> > ffffffff8119325d:       00 00 00
>> >                 work = llist_entry(llnode, struct irq_work, llnode);
>> > ffffffff81193260:       48 8d 7b f8             lea    -0x8(%rbx),%rdi
>> >                 flags = work->flags & ~IRQ_WORK_PENDING;
>> > ffffffff81193264:       4c 8b 7b f8             mov    -0x8(%rbx),%r15
>> >         return node->next;
>> > ffffffff81193268:       4c 8b 23                mov    (%rbx),%r12
>> > ffffffff8119326b:       4d 89 fe                mov    %r15,%r14
>> > ffffffff8119326e:       49 83 e6 fe             and    $0xfffffffffffffffe,%r14
>> >                 xchg(&work->flags, flags);
>> > ffffffff81193272:       4c 89 f0                mov    %r14,%rax
>> > ffffffff81193275:       48 87 43 f8             xchg   %rax,-0x8(%rbx)
>> >                 work->func(work);
>> > ffffffff81193279:       ff 53 08                callq  *0x8(%rbx)
>> >                 (void)cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
>> > ffffffff8119327c:       49 83 e7 fc             and    $0xfffffffffffffffc,%r15
>> > ffffffff81193280:       4c 89 f0                mov    %r14,%rax
>> > ffffffff81193283:       f0 4c 0f b1 7b f8       lock cmpxchg %r15,-0x8(%rbx)
>> > ffffffff81193289:       4c 89 e3                mov    %r12,%rbx
>> >         while (llnode != NULL) {
>> > ffffffff8119328c:       4d 85 e4                test   %r12,%r12
>> > ffffffff8119328f:       75 cf                   jne    ffffffff81193260 <irq_work_tick+0x60>
>> >                 irq_work_run_list(raised);
>> >         irq_work_run_list(this_cpu_ptr(&lazy_list));
>> > ffffffff81193291:       48 c7 c1 88 5b 01 00    mov    $0x15b88,%rcx
>> > ffffffff81193298:       65 48 03 0c 25 d8 a1    add    %gs:0xa1d8,%rcx
>> > ffffffff8119329f:       00 00
>> > ffffffff811932a1:       ff 14 25 10 08 c2 81    callq  *0xffffffff81c20810
>> >         BUG_ON(!irqs_disabled());
>> > ffffffff811932a8:       a9 00 02 00 00          test   $0x200,%eax
>> > ffffffff811932ad:       75 4b                   jne    ffffffff811932fa <irq_work_tick+0xfa>
>> >         return ACCESS_ONCE(head->first) == NULL;
>> > ffffffff811932af:       48 83 39 00             cmpq   $0x0,(%rcx)
>> >
>> >
>> > I'm no x86/assembly expert, anyway my interpretation is:
>> >
>> > 'irq_work_tick+0xaf' corresponds to address 0xffffffff811932af, so the
>> > exception occurs during the execution of 'cmpq   $0x0,(%rcx)' or
>> > 'ACCESS_ONCE(head->first) == NULL'. The instruction checks if the
>> > memory location in RCX contains 0. Supposedly the register should
>> > contain the address of 'head->first', however the value is
>> > 0x47e992c1bc778d00, which doesn't look like a valid address.
>> >
>> > RCX is set shortly before:
>> >
>> > ffffffff81193291:       48 c7 c1 88 5b 01 00    mov    $0x15b88,%rcx
>> > ffffffff81193298:       65 48 03 0c 25 d8 a1    add    %gs:0xa1d8,%rcx
>> >
>> > As stated in https://www.kernel.org/doc/Documentation/this_cpu_ops.txt
>> > the GS segment register is used by the kernel for per-cpu
>> > variables. And effectively System.map tells us the offset 0x15b88
>> > corresponds to the per-cpu variable lazy_list:
>> >
>> > 0000000000015b88 d lazy_list
>> >
>> > The register dump shows GS with a value of 0xffff96fb5fc00000, which
>> > looks reasonable.
>> >
>> > But wait, right after setting RCX we do this:
>> >
>> > ffffffff811932a1:       ff 14 25 10 08 c2 81    callq  *0xffffffff81c20810
>> >         BUG_ON(!irqs_disabled());
>> >
>> > According to my (limited) understanding of x86 calling conventions RCX
>> > is a caller-saved register, thus the caller should save it on the
>> > stack to preserve its value across a function call.
>> > (https://en.wikipedia.org/wiki/X86_calling_conventions)
>> >
>> > The call to '*0xffffffff81c20810' appears to be related with
>> > KVM/paravirtualization:
>> >
>> > grep ffffffff81c20810 System.map
>> > ffffffff81c20810 D pv_irq_ops
>> >
>> > Since there is no offset it must be calling the first function in the
>> > structure, which is 'safe_fl' and points to 'native_save_fl'
>> > (https://elixir.bootlin.com/linux/v4.14.36/source/arch/x86/kernel/paravirt.c#L316)
>> >
>> > objdump -d -S --start-address=0x$(grep native_save_fl System.map | sed
>> >  -e "s/ \+.*//") vmlinux | less
>> >
>> > static inline unsigned long native_save_fl(void)
>> > {
>> > ffffffff81060240:       55                      push   %rbp
>> > ffffffff81060241:       48 89 e5                mov    %rsp,%rbp
>> > ffffffff81060244:       48 83 ec 10             sub    $0x10,%rsp
>> > ffffffff81060248:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
>> > ffffffff8106024f:       00 00
>> > ffffffff81060251:       48 89 45 f8             mov    %rax,-0x8(%rbp)
>> >         /*
>> >          * "=rm" is safe here, because "pop" adjusts the stack before
>> >          * it evaluates its effective address -- this is part of the
>> >          * documented behavior of the "pop" instruction.
>> >          */
>> >         asm volatile("# __raw_save_flags\n\t"
>> > ffffffff81060255:       9c                      pushfq
>> > ffffffff81060256:       8f 45 f0                popq   -0x10(%rbp)
>> >                      "pushf ; pop %0"
>> >                      : "=rm" (flags)
>> >                      : /* no input */
>> >                      : "memory");
>> >
>> >         return flags;
>> > ffffffff81060259:       48 8b 45 f0             mov    -0x10(%rbp),%rax
>> > ffffffff8106025d:       65 48 8b 0c 25 28 00    mov    %gs:0x28,%rcx
>> > ffffffff81060264:       00 00
>> > ffffffff81060266:       48 3b 4d f8             cmp    -0x8(%rbp),%rcx
>> > ffffffff8106026a:       75 06                   jne    ffffffff81060272 <native_save_fl+0x32>
>> > ffffffff8106026c:       48 83 c4 10             add    $0x10,%rsp
>> > ffffffff81060270:       5d                      pop    %rbp
>> > ffffffff81060271:       c3                      retq
>> > ffffffff81060272:       e8 09 ec 01 00          callq  ffffffff8107ee80 <__stack_chk_fail>
>> > ffffffff81060277:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>> > ffffffff8106027e:       00 0
>> >
>> > At 0xffffffff8106025d this clobbers RCX! I don't know why clang
>> > doesn't save the value on the stack before calling native_save_fl(),
>> > but that seems to be the problem.
>> >
>> > Again, I'm not an expert in this area and ventured into territory
>> > unknown to me, so please excuse if I got something totally wrong ...
>> >
>>
>> Hi Matthias,
>>
>> again you helped me a lot.
>>
>> I recalled that I had success in the early days of llvmlinux with...
>>
>>     CONFIG_PARAVIRT=n
>>
>> ...as suggested by Steve Rostedt.
>>
>> This needed some more hackish kconfig kungfu these days - patches attached.
>>
>> In the end I could boot into a 4.14.37-1-iniza-llvmlinux kernel
>> (kernel-config and dmesg-log attached).
>>
>> Concerning your analysis...
>>
>> Is this a clang-bug?
>> Or can this be solved in the linux-kernel code?
>> What are your suggestion?
>> And can you help on getting this fixed with the help of your Chromium
>> team and/or bring it to the right persons?
>
> Apparently stack-protector code is clobbering RCX, however the
> paravirt code expects the register to be preserved:
>
> struct pv_irq_ops {
>         /*
>          * ...
>          * NOTE: These functions callers expect the callee to preserve
>          * more registers than the standard C calling convention.
>          */
>         struct paravirt_callee_save save_fl;
>
> We think the solution is to mark native_save_fl with
> '__nostackprotector', however this requires adding support for
> such an attribute to clang. Our compiler team is working on this.
>

OK, cool.
Can you inform me when there is progress on this?
Thanks.

>> IMHO an analysis like you did might help, too.
>> I am not an expert in this area to say it is good/correct but I could
>> follow and read it like a thriller.
>> Where is Lieutenant Columbo when you need him :-)?
>>
>> Moreover, a test-case can be helpful, e.g. "Is clang clobbering RCX?"
>> when it's a clang-bug.
>>
>> I tried to find some suitable test-case myself.
>>
>> The clang-source has a test-dir, but this is new to me.
>>
>> I tried to run a single test like test/Sema/asm.c in [1] with
>> llvm-tools Debian-package which ships "lit.py" script.
>>
>> Not sure if this is a suitable for x86-64 (amd64) as the first line says...
>>
>> // RUN: %clang_cc1 %s -Wno-private-extern -triple i386-pc-linux-gnu
>> -verify -fsyntax-only
>>
>> root# cd /path/to/clang-source
>>
>> root# python /usr/lib/llvm-7/build/utils/lit/lit.py -sv test/Sema
>> lit.py: /usr/lib/llvm-7/build/utils/lit/lit/TestingConfig.py:101:
>> fatal: unable to parse config file
>> '/path/to/clang-source/test/lit.cfg.py', traceback: Traceback (most
>> recent call last):
>>   File "/usr/lib/llvm-7/build/utils/lit/lit/TestingConfig.py", line
>> 88, in load_from_path
>>     exec(compile(data, path, 'exec'), cfg_globals, None)
>>   File "/home/sdi/src/linux-kernel/clang/test/lit.cfg.py", line 25, in <module>
>>     config.test_format = lit.formats.ShTest(not llvm_config.use_lit_shell)
>> AttributeError: 'NoneType' object has no attribute 'use_lit_shell'
>>
>> Not sure if you have any experiences in this area, but I think asking
>> on llvm-dev is a good idea.
>>
>> If we have a reproducible test-case we could ask on llvm-dev?
>>
>> In the case of linux-kernel...
>> Ask Linux/x86 folks for a test-case to see if the compiler clobbers RCX?
>> Show your analysis to Linux/(x86)/KVM folks?
>
> I'm not an expert, but I don't think there is a generic test case for
> this special scenario involving paravirt and stack protector. It's
> probably best to just fix the problem and move on.

Yeah, I was able to run a single clang-test like Sema/asm.c.
There is a thread on llvm-dev "[clang] Running a single testcase"
where I had success with using the built clang binary etc.
A nice excursion in that area.

Thanks again.

- Sedat -
