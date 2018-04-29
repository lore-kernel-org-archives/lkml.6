Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AB8JxZrQAEn2mW8RsgDzAwvmP2psrLW9klkb588Un65qdboir+uhOsjYplz6+Wc0+IKIiqWTeZBX
ARC-Seal: i=1; a=rsa-sha256; t=1524968778; cv=none;
        d=google.com; s=arc-20160816;
        b=OESF+91hLJYkWUbtRq2qQKyDrIsKYWOJ2POCAspzn+GdsJZpO9X4ug664OyBiP5Ch2
         XUn/+8G1i2pYu5n7D4d/r0wNJFaNcFQsg7qCeag2xBheHa+xvh/ilTKuQXuyTRITKgiV
         VXy87LGLj6xN/DVEdQAA6HzzXwXXMkMFrHMxx+XQtDVEnzKL2fUEYCl9sQb9+/y3TNK6
         Ilmnlr6IC00foXMdg82xU12ng/ioH+hkYQhkg4Y+u2QSQdm0zFIuXrNcDRbEAwvtuK5R
         r+rfRuFdHGnR33biDOcUOqabMgaZMfZYeGu/QiKtJHILgvwcp1c5/DhaQ2Wb9PS5JkHE
         yOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=szvopDlBDz3BDua+aj1a+igQbUUUmiief/CUDX7DmRY=;
        b=mC7gma+mJ8fTqQ6vU4TDdrS6UIt1QO6U5EoecNUvk1QTQ2qJN79nDGi3fpFZ4mzDCx
         ee4vFDHsPnEAIzTyYTLz2oS0VZVIYKYdktOcM0pwpF1oIckqimuCyV1imQejLCDBZVcf
         n4k4ZeI7WVr29vJj3DCTd300QmMkBtyDXW/Xgzo8+oniFuI/cPMBe+SjPFdWPwpIge2i
         arxWqwrT+VhGsRXI+cjPhW6V9xgTH6DqTsZIHA9OBRkwIM4Zo6miDFCXwWJcHE5em3hi
         Rv/vzDceh5+SBEiKMGuTsR4tzPDKT5w8HWRmntHVCQ8maAYFXdO1kJ39YctOzfnTXzM2
         y2QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,341,1520924400";
   d="scan'208";a="45377845"
Date: Sun, 29 Apr 2018 10:26:06 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, lkp@01.org,
	"Kohli, Gaurav" <gkohli@codeaurora.org>
Subject: [crng_reseed] WARNING: inconsistent lock state
Message-ID: <20180429022606.267zucef42hm37m7@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wru5vry3cjtl6h2j"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599045662105370125?=
X-GMAIL-MSGID: =?utf-8?q?1599045662105370125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--wru5vry3cjtl6h2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

FYI this happens in mainline kernel 4.17.0-rc2.
It looks like a new regression.

It occurs in 3 out of 3 boots.

There is another "[  294.642506] BUG: sleeping function called from
invalid context at mm/slab.h:421" at the bottom of this long dmesg:

[  123.885728] Writes:  Total: 41708535  Max/Min: 0/0   Fail: 0
[  185.312613] Writes:  Total: 61148802  Max/Min: 0/0   Fail: 0
[  246.752095] Writes:  Total: 86067258  Max/Min: 0/0   Fail: 0
[  294.560671]
[  294.560924] ================================
[  294.561539] WARNING: inconsistent lock state
[  294.562165] 4.17.0-rc2 #145 Not tainted
[  294.562724] --------------------------------
[  294.563338] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[  294.564201] kworker/0:2/28 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  294.564976]         (ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire+0x0/0x30
[  294.566157] {HARDIRQ-ON-W} state was registered at:
[  294.566863]   lock_acquire+0x79/0xd0:
						lock_acquire at kernel/locking/lockdep.c:3922
[  294.567379]   fs_reclaim_acquire+0x24/0x30
[  294.568069]   fs_reclaim_acquire+0x14/0x20:
						fs_reclaim_acquire at mm/page_alloc.c:3740
[  294.568660]   kmem_cache_alloc_node+0x32/0x240:
						slab_pre_alloc_hook at mm/slab.h:419
						 (inlined by) slab_alloc_node at mm/slab.c:3299
						 (inlined by) kmem_cache_alloc_node at mm/slab.c:3642
[  294.569294]   __kmalloc_node+0x24/0x30:
						__kmalloc_node at mm/slab.c:3690

[  294.569841]   alloc_cpumask_var_node+0x1f/0x50
[  294.570477]   zalloc_cpumask_var+0x14/0x20
[  294.571071]   native_smp_prepare_cpus+0xf4/0x364
[  294.571738]   kvm_smp_prepare_cpus+0x21/0xff
[  294.572349]   kernel_init_freeable+0x2b5/0x4db
[  294.572995]   kernel_init+0x9/0x100
[  294.573499]   ret_from_fork+0x24/0x30
[  294.574169] irq event stamp: 141042
[  294.574681] hardirqs last  enabled at (141041): [<ffffffff81d6dd81>] _raw_spin_unlock_irqrestore+0x31/0x60
[  294.576050] hardirqs last disabled at (141042): [<ffffffff81e008d4>] interrupt_entry+0xd4/0x100
[  294.577278] softirqs last  enabled at (140644): [<ffffffff81aaec82>] update_defense_level+0x122/0x450
[  294.578577] softirqs last disabled at (140642): [<ffffffff81aaeb60>] update_defense_level+0x0/0x450
[  294.579855]
[  294.579855] other info that might help us debug this:
[  294.580867]  Possible unsafe locking scenario:
[  294.580867]
[  294.581714]        CPU0
[  294.582073]        ----
[  294.582431]   lock(fs_reclaim);
[  294.582892]   <Interrupt>
[  294.583273]     lock(fs_reclaim);
[  294.583757]
[  294.583757]  *** DEADLOCK ***
[  294.583757]
[  294.584592] 2 locks held by kworker/0:2/28:
[  294.585196]  #0:         (ptrval) ((wq_completion)"events"){+.+.}, at: process_one_work+0x1d6/0x460
[  294.586497]  #1:         (ptrval) ((work_completion)(&(&adapter->watchdog_task)->work)){+.+.}, at: process_one_work+0x1d6/0x460
[  294.588125]
[  294.588125] stack backtrace:
[  294.588753] CPU: 0 PID: 28 Comm: kworker/0:2 Not tainted 4.17.0-rc2 #145
[  294.589803] Workqueue: events e1000_watchdog
[  294.590410] Call Trace:
[  294.590776]  <IRQ>
[  294.591078]  dump_stack+0x8e/0xd5
[  294.591557]  print_usage_bug+0x247/0x262
[  294.592221]  mark_lock+0x5c5/0x660
[  294.592719]  ? check_usage_backwards+0x160/0x160
[  294.593436]  __lock_acquire+0xdcf/0x1b70
[  294.594006]  ? __lock_acquire+0x3f1/0x1b70
[  294.594595]  ? trace_hardirqs_off+0xd/0x10
[  294.595190]  lock_acquire+0x79/0xd0
[  294.595706]  ? lock_acquire+0x79/0xd0
[  294.596259]  ? find_suitable_fallback+0x80/0x80
[  294.609933]  ? crng_reseed+0x13e/0x2e0
[  294.610479]  fs_reclaim_acquire+0x24/0x30
[  294.611163]  ? find_suitable_fallback+0x80/0x80
[  294.611915]  fs_reclaim_acquire+0x14/0x20
[  294.612490]  __kmalloc+0x35/0x240
[  294.612982]  crng_reseed+0x13e/0x2e0
[  294.613499]  credit_entropy_bits+0x21c/0x230
[  294.625342]  add_interrupt_randomness+0x293/0x300
[  294.626072]  handle_irq_event_percpu+0x3b/0x70
[  294.626718]  handle_irq_event+0x34/0x60
[  294.627272]  handle_fasteoi_irq+0x70/0x120
[  294.627867]  handle_irq+0x15/0x20
[  294.628349]  do_IRQ+0x53/0x100
[  294.628803]  common_interrupt+0xf/0xf
[  294.629331]  </IRQ>
[  294.629653] RIP: 0010:e1000_watchdog+0x126/0x530
[  294.630335] RSP: 0000:ffff880016823e00 EFLAGS: 00000297 ORIG_RAX: ffffffffffffffda
[  294.631690] RAX: 0000000000000010 RBX: ffff880014f992c0 RCX: 0000000000000006
[  294.632971] RDX: ffffc900008e0000 RSI: ffff88001681d3b8 RDI: ffff880014f98e70
[  294.634237] RBP: ffff880016823e38 R08: 0000000097c673cd R09: 0000000000000000
[  294.635549] R10: 0000000000000000 R11: 0000000000000000 R12: ffff880014f98a80
[  294.636838] R13: ffff880014f98000 R14: ffff880018994480 R15: ffff880014f98e70
[  294.638276]  process_one_work+0x236/0x460
[  294.638993]  ? process_one_work+0x1d6/0x460
[  294.639652]  worker_thread+0x35/0x3f0
[  294.640175]  kthread+0x122/0x140
[  294.640646]  ? process_one_work+0x460/0x460
[  294.641242]  ? __kthread_create_on_node+0x190/0x190
[  294.641941]  ret_from_fork+0x24/0x30
[  294.642506] BUG: sleeping function called from invalid context at mm/slab.h:421
[  294.644135] in_atomic(): 1, irqs_disabled(): 1, pid: 28, name: kworker/0:2
[  294.646373] INFO: lockdep is turned off.
[  294.647940] irq event stamp: 141042
[  294.648638] hardirqs last  enabled at (141041): [<ffffffff81d6dd81>] _raw_spin_unlock_irqrestore+0x31/0x60
[  294.655362] hardirqs last disabled at (141042): [<ffffffff81e008d4>] interrupt_entry+0xd4/0x100
[  294.676115] softirqs last  enabled at (140644): [<ffffffff81aaec82>] update_defense_level+0x122/0x450
[  294.677737] softirqs last disabled at (140642): [<ffffffff81aaeb60>] update_defense_level+0x0/0x450
[  294.682738] CPU: 0 PID: 28 Comm: kworker/0:2 Not tainted 4.17.0-rc2 #145
[  294.683763] Workqueue: events e1000_watchdog
[  294.684414] Call Trace:
[  294.697850]  <IRQ>
[  294.698174]  dump_stack+0x8e/0xd5
[  294.698697]  ___might_sleep+0x15f/0x250
[  294.699288]  __might_sleep+0x45/0x80
[  294.699853]  __kmalloc+0x1a3/0x240
[  294.700387]  crng_reseed+0x13e/0x2e0
[  294.700957]  credit_entropy_bits+0x21c/0x230
[  294.701642]  add_interrupt_randomness+0x293/0x300
[  294.702382]  handle_irq_event_percpu+0x3b/0x70
[  294.703080]  handle_irq_event+0x34/0x60
[  294.703689]  handle_fasteoi_irq+0x70/0x120
[  294.704325]  handle_irq+0x15/0x20
[  294.704863]  do_IRQ+0x53/0x100
[  294.705347]  common_interrupt+0xf/0xf
[  294.705927]  </IRQ>
[  294.706267] RIP: 0010:e1000_watchdog+0x126/0x530
[  294.706983] RSP: 0000:ffff880016823e00 EFLAGS: 00000297 ORIG_RAX: ffffffffffffffda
[  294.708142] RAX: 0000000000000010 RBX: ffff880014f992c0 RCX: 0000000000000006
[  294.709228] RDX: ffffc900008e0000 RSI: ffff88001681d3b8 RDI: ffff880014f98e70
[  294.710314] RBP: ffff880016823e38 R08: 0000000097c673cd R09: 0000000000000000
[  294.715815] R10: 0000000000000000 R11: 0000000000000000 R12: ffff880014f98a80
[  294.716907] R13: ffff880014f98000 R14: ffff880018994480 R15: ffff880014f98e70
[  294.718019]  process_one_work+0x236/0x460
[  294.718643]  ? process_one_work+0x1d6/0x460
[  294.719281]  worker_thread+0x35/0x3f0
[  294.719859]  kthread+0x122/0x140
[  294.720361]  ? process_one_work+0x460/0x460
[  294.721008]  ? __kthread_create_on_node+0x190/0x190
[  294.721766]  ret_from_fork+0x24/0x30
[  294.722324] random: crng init done

Attached the full dmesg, kconfig and reproduce scripts.

Thanks,
Fengguang

--wru5vry3cjtl6h2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-vm-ivb41-yocto-ia32-18:20180425110746:x86_64-randconfig-s4-04251005:4.17.0-rc2:145"
Content-Transfer-Encoding: quoted-printable

early console in setup code
[    0.000000] Linux version 4.17.0-rc2 (kbuild@lkp-hsx03) (gcc version 7.3=
=2E0 (Debian 7.3.0-16)) #145 SMP Wed Apr 25 10:08:32 CST 2018
[    0.000000] Command line: ip=3D::::vm-ivb41-yocto-ia32-18::dhcp root=3D/=
dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-ivb41-yocto-ia32-18/trinity-300=
s-yocto-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-2=
0180425-6417-i7ogw5-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-s4-042=
51005 branch=3Dlinus/master commit=3D6d08b06e67cd117f6992c46611dfb4ce267cd7=
1e BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd=
117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2 max_uptime=3D1500 RESULT_RO=
OT=3D/result/trinity/300s/vm-ivb41-yocto-ia32/yocto-tiny-i386-2016-04-22.cg=
z/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd=
71e/2 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu=
_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 sof=
tlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt=
_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel c=
onsole=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnorma=
l rw drbd.
[    0.000000] KERNEL supported cpus:
[    0.000000]   Centaur CentaurHauls
[    0.000000] CPU: vendor_id 'GenuineIntel' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
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
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001a3ddfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001a3de000-0x000000001a3fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x1a3de max_arch_pfn =3D 0x400000000
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
[    0.000000] found SMP MP-table at [mem 0x000f6a90-0x000f6a9f] mapped at =
[        (ptrval)]
[    0.000000]   mpc: f6aa0-f6b78
[    0.000000] Base memory trampoline at [        (ptrval)] 99000 size 24576
[    0.000000] BRK [0x03e00000, 0x03e00fff] PGTABLE
[    0.000000] BRK [0x03e01000, 0x03e01fff] PGTABLE
[    0.000000] BRK [0x03e02000, 0x03e02fff] PGTABLE
[    0.000000] BRK [0x03e03000, 0x03e03fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x19ff9000-0x1a3cffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000001A3E15CE 000030 (v01 BOCHS  BXPCRSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000001A3E142A 000074 (v01 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000001A3E0040 0013EA (v01 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000001A3E0000 000040
[    0.000000] ACPI: APIC 0x000000001A3E151E 000078 (v01 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000001A3E1596 000038 (v01 BOCHS  BXPCHPET 00=
000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001a3ddfff]
[    0.000000] NODE_DATA(0) allocated [mem 0x19fd7000-0x19ff8fff]
[    0.000000] kvm-clock: cpu 0, msr 0:19f57001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 425782853 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000001a3ddfff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001a3ddfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001a3dd=
fff]
[    0.000000] On node 0 totalpages: 107388
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 1616 pages used for memmap
[    0.000000]   DMA32 zone: 103390 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
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
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.000000] e820: [mem 0x1a400000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] random: get_random_bytes called from start_kernel+0xc5/0x596=
 with crng_init=3D0
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:1 nr_cpu_ids:1 nr=
_node_ids:1
[    0.000000] percpu: Embedded 484 pages/cpu @        (ptrval) s1950936 r0=
 d31528 u2097152
[    0.000000] pcpu-alloc: s1950936 r0 d31528 u2097152 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 19c108c0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 105687
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: ip=3D::::vm-ivb41-yocto-ia32-18::dhcp r=
oot=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-ivb41-yocto-ia32-18/trin=
ity-300s-yocto-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267=
cd71e-20180425-6417-i7ogw5-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig=
-s4-04251005 branch=3Dlinus/master commit=3D6d08b06e67cd117f6992c46611dfb4c=
e267cd71e BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s4-04251005/gcc-7/6d08b=
06e67cd117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2 max_uptime=3D1500 RE=
SULT_ROOT=3D/result/trinity/300s/vm-ivb41-yocto-ia32/yocto-tiny-i386-2016-0=
4-22.cgz/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4=
ce267cd71e/2 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupd=
ate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=
=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=
=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore=
_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 =
vga=3Dnormal r
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] Memory: 214540K/429552K available (16396K kernel code, 3328K=
 rwdata, 5164K rodata, 4180K init, 14860K bss, 61996K reserved, 0K cma-rese=
rved)
[    0.004000] Running RCU self tests
[    0.004000] Hierarchical RCU implementation.
[    0.004000] 	RCU event tracing is enabled.
[    0.004000] 	RCU lockdep checking is enabled.
[    0.004000] 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D1.
[    0.004000] 	RCU debug extended QS entry/exit.
[    0.004000] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    0.004000] 	Tasks RCU enabled.
[    0.004000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.004000] NR_IRQS: 4352, nr_irqs: 48, preallocated irqs: 16
[    0.004000] 	Offload RCU callbacks from CPUs: (none).
[    0.004000] console [ttyS0] enabled
[    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.004000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.004000] ... MAX_LOCK_DEPTH:          48
[    0.004000] ... MAX_LOCKDEP_KEYS:        8191
[    0.004000] ... CLASSHASH_SIZE:          4096
[    0.004000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.004000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.004000] ... CHAINHASH_SIZE:          32768
[    0.004000]  memory used by lock dependency info: 7903 kB
[    0.004000]  per task-struct memory footprint: 2688 bytes
[    0.004000] ------------------------
[    0.004000] | Locking API testsuite:
[    0.004000] ------------------------------------------------------------=
----------------
[    0.004000]                                  | spin |wlock |rlock |mutex=
 | wsem | rsem |
[    0.004000]   ----------------------------------------------------------=
----------------
[    0.004000]                      A-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]                     double unlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]                   initialize held:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |
[    0.004000]   ----------------------------------------------------------=
----------------
[    0.004000]               recursive read-lock:             |  ok  |     =
        |  ok  |
[    0.004000]            recursive read-lock #2:             |  ok  |     =
        |  ok  |
[    0.004000]             mixed read-write-lock:             |  ok  |     =
        |  ok  |
[    0.004000]             mixed write-read-lock:             |  ok  |     =
        |  ok  |
[    0.004000]   mixed read-lock/lock-write ABBA:             |FAILED|     =
        |  ok  |
[    0.004000]    mixed read-lock/lock-read ABBA:             |  ok  |     =
        |  ok  |
[    0.004000]  mixed write-lock/lock-write ABBA:             |  ok  |     =
        |  ok  |
[    0.004000]   ----------------------------------------------------------=
----------------
[    0.004000]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.004000]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.004000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.004000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.004000]        sirq-safe-A =3D> hirqs-on/12:  ok  |  ok  |  ok  |
[    0.004000]        sirq-safe-A =3D> hirqs-on/21:  ok  |  ok  |  ok  |
[    0.004000]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.004000]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.004000]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.004000]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.004000]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.004000]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.004000]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.004000]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.004000]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.004000]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.004000]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.004000]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.004000]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.004000]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.004000]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.004000]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.004000]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.004000]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.004000]       hard-irq read-recursion/123:  ok  |
[    0.004000]       soft-irq read-recursion/123:  ok  |
[    0.004000]       hard-irq read-recursion/132:  ok  |
[    0.004000]       soft-irq read-recursion/132:  ok  |
[    0.004000]       hard-irq read-recursion/213:  ok  |
[    0.004000]       soft-irq read-recursion/213:  ok  |
[    0.004000]       hard-irq read-recursion/231:  ok  |
[    0.004000]       soft-irq read-recursion/231:  ok  |
[    0.004000]       hard-irq read-recursion/312:  ok  |
[    0.004000]       soft-irq read-recursion/312:  ok  |
[    0.004000]       hard-irq read-recursion/321:  ok  |
[    0.004000]       soft-irq read-recursion/321:  ok  |
[    0.004000]   ----------------------------------------------------------=
----------------
[    0.004000]   | Wound/wait tests |
[    0.004000]   ---------------------
[    0.004000]                   ww api failures:  ok  |  ok  |  ok  |
[    0.004000]                ww contexts mixing:  ok  |  ok  |
[    0.004000]              finishing ww context:  ok  |  ok  |  ok  |  ok =
 |
[    0.004000]                locking mismatches:  ok  |  ok  |  ok  |
[    0.004000]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.004000]            spinlock nest unlocked:  ok  |
[    0.004000]   -----------------------------------------------------
[    0.004000]                                  |block | try  |context|
[    0.004000]   -----------------------------------------------------
[    0.004000]                           context:  ok  |  ok  |  ok  |
[    0.004000]                               try:  ok  |  ok  |  ok  |
[    0.004000]                             block:  ok  |  ok  |  ok  |
[    0.004000]                          spinlock:  ok  |  ok  |  ok  |
[    0.004000] -------------------------------------------------------
[    0.004000] Good, all 261 testcases passed! |
[    0.004000] ---------------------------------
[    0.004000] ACPI: Core revision 20180313
[    0.004000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns
[    0.004000] hpet clockevent registered
[    0.004027] APIC: Switch to symmetric I/O mode setup
[    0.004917] enabled ExtINT on CPU#0
[    0.006450] ENABLING IO-APIC IRQs
[    0.007044] init IO_APIC IRQs
[    0.008012]  apic 0 pin 0 not connected
[    0.008609] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    0.009910] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.011259] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Ac=
tive:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 =
Active:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 =
Active:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    0.012000] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    0.012000]  apic 0 pin 16 not connected
[    0.012000]  apic 0 pin 17 not connected
[    0.012000]  apic 0 pin 18 not connected
[    0.012000]  apic 0 pin 19 not connected
[    0.012000]  apic 0 pin 20 not connected
[    0.012000]  apic 0 pin 21 not connected
[    0.012000]  apic 0 pin 22 not connected
[    0.012000]  apic 0 pin 23 not connected
[    0.012000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.012000] tsc: Detected 2693.508 MHz processor
[    0.012000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x26d349e8249, max_idle_ns: 440795288087 ns
[    0.012034] Calibrating delay loop (skipped) preset value.. 5387.01 Bogo=
MIPS (lpj=3D10774032)
[    0.013444] pid_max: default: 4096 minimum: 301
[    0.014373] Security Framework initialized
[    0.015113] Smack:  Initializing.
[    0.016009] Smack:  IPv6 port labeling enabled.
[    0.016687] AppArmor: AppArmor disabled by boot time parameter
[    0.017731] Dentry cache hash table entries: 65536 (order: 7, 524288 byt=
es)
[    0.018919] Inode-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.020053] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.021126] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 by=
tes)
[    0.023340] mce: CPU supports 10 MCE banks
[    0.024013] mce: unknown CPU type - not enabling MCE support
[    0.025070] numa_add_cpu cpu 0 node 0: mask now 0
[    0.026007] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.026935] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.028016] Spectre V2 : Spectre mitigation: kernel not compiled with re=
tpoline; no mitigation available!
[    0.039774] Freeing SMP alternatives memory: 40K
[    0.045485] TSC deadline timer enabled
[    0.046138] smpboot: CPU0: GenuineIntel Intel Xeon E3-12xx v2 (Ivy Bridg=
e) (family: 0x6, model: 0x3a, stepping: 0x9)
[    0.048000] Performance Events: no PMU driver, software events only.
[    0.048000] Hierarchical SRCU implementation.
[    0.048474] NMI watchdog: Perf event create on CPU 0 failed with -2
[    0.049572] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.050939] smp: Bringing up secondary CPUs ...
[    0.051823] smp: Brought up 1 node, 1 CPU
[    0.052014] smpboot: Max logical packages: 1
[    0.052772] smpboot: Total of 1 processors activated (5387.01 BogoMIPS)
[    0.056015] node 0 initialised, 38254 pages in 4ms
[    0.057678] devtmpfs: initialized
[    0.060869] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.062603] futex hash table entries: 16 (order: -1, 2048 bytes)
[    0.063999] prandom: seed boundary self test passed
[    0.064854] prandom: 100 self tests passed
[    0.065583] pinctrl core: initialized pinctrl subsystem
[    0.067147] regulator-dummy: no parameters
[    0.069336] NET: Registered protocol family 16
[    0.071229] audit: initializing netlink subsys (disabled)
[    0.072996] cpuidle: using governor ladder
[    0.074561] ACPI: bus type PCI registered
[    0.075412] PCI: Using configuration type 1 for base access
[    0.076541] audit: type=3D2000 audit(1524625361.051:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.101625] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.103630] cryptd: max_cpu_qlen set to 1000
[    0.104605] ACPI: Added _OSI(Module Device)
[    0.105337] ACPI: Added _OSI(Processor Device)
[    0.106122] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.107018] ACPI: Added _OSI(Processor Aggregator Device)
[    0.107901] ACPI: Added _OSI(Linux-Dell-Video)
[    0.113448] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.120801] ACPI: Interpreter enabled
[    0.121520] ACPI: (supports S0 S3 S5)
[    0.122140] ACPI: Using IOAPIC for interrupt routing
[    0.123090] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.124654] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.145971] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.147017] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.147946] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.148081] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.150212] PCI host bridge to bus 0000:00
[    0.150960] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.152017] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.153107] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.154353] pci_bus 0000:00: root bus resource [mem 0x1a400000-0xfebffff=
f window]
[    0.155548] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.156122] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.158585] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.161111] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.167901] pci 0000:00:01.1: reg 0x20: [io  0xc080-0xc08f]
[    0.170870] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.172016] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.173162] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.174387] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.176405] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.178063] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI
[    0.179240] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB
[    0.184310] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.188039] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.196035] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.209321] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.212947] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.216955] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.221975] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.233781] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.236013] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.240018] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    0.244020] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.253446] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit=
 pref]
[    0.259005] pci 0000:00:05.0: [8086:25ab] type 00 class 0x088000
[    0.261833] pci 0000:00:05.0: reg 0x10: [mem 0xfebf2000-0xfebf200f]
[    0.272394] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.273864] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.275438] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.276455] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.277696] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.280352] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.281532] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.283001] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.284015] vgaarb: loaded
[    0.285550] ACPI: bus type USB registered
[    0.286373] usbcore: registered new interface driver usbfs
[    0.287496] usbcore: registered new interface driver hub
[    0.288101] usbcore: registered new device driver usb
[    0.289266] Linux video capture interface: v2.00
[    0.290215] pps_core: LinuxPPS API ver. 1 registered
[    0.291079] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.292670] PCI: Using ACPI for IRQ routing
[    0.293426] PCI: pci_cache_line_size set to 64 bytes
[    0.294507] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.295549] e820: reserve RAM buffer [mem 0x1a3de000-0x1bffffff]
[    0.296868] NetLabel: Initializing
[    0.302649] NetLabel:  domain hash size =3D 128
[    0.303558] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.306231] NetLabel:  unlabeled traffic allowed by default
[    0.309103] dcdbas dcdbas: Dell Systems Management Base Driver (version =
5.6.0-3.2)
[    0.311126] clocksource: Switched to clocksource kvm-clock
[    0.312000] FS-Cache: Loaded
[    0.312000] pnp: PnP ACPI init
[    0.312000] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.312718] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.314027] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.315276] pnp 00:03: [dma 2]
[    0.315931] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.317456] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.318963] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.320386] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.322657] pnp: PnP ACPI: found 7 devices
[    0.329473] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.331115] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.332254] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.333274] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.334399] pci_bus 0000:00: resource 7 [mem 0x1a400000-0xfebfffff windo=
w]
[    0.335971] NET: Registered protocol family 2
[    0.339809] tcp_listen_portaddr_hash hash table entries: 256 (order: 2, =
22528 bytes)
[    0.341261] TCP established hash table entries: 4096 (order: 3, 32768 by=
tes)
[    0.342574] TCP bind hash table entries: 4096 (order: 6, 327680 bytes)
[    0.343990] TCP: Hash tables configured (established 4096 bind 4096)
[    0.345423] UDP hash table entries: 256 (order: 3, 49152 bytes)
[    0.346531] UDP-Lite hash table entries: 256 (order: 3, 49152 bytes)
[    0.347891] NET: Registered protocol family 1
[    0.349458] RPC: Registered named UNIX socket transport module.
[    0.350509] RPC: Registered udp transport module.
[    0.351334] RPC: Registered tcp transport module.
[    0.352303] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.353432] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.354481] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.355632] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.356988] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.358693] PCI: CLS 0 bytes, default 64
[    0.359960] Unpacking initramfs...
[    1.712096] Freeing initrd memory: 3932K
[    1.720179] Machine check injector initialized
[    1.730721] AVX2 or AES-NI instructions are not detected.
[    1.731645] AVX2 instructions are not detected.
[    1.733369] spin_lock-torture:--- Start of test [debug]: nwriters_stress=
=3D2 nreaders_stress=3D0 stat_interval=3D60 verbose=3D1 shuffle_interval=3D=
3 stutter=3D5 shutdown_secs=3D0 onoff_interval=3D0 onoff_holdoff=3D0
[    1.736896] spin_lock-torture: Creating torture_shuffle task
[    1.737966] spin_lock-torture: Creating torture_stutter task
[    1.738966] spin_lock-torture: torture_shuffle task started
[    1.739908] spin_lock-torture: Creating lock_torture_writer task
[    1.741008] spin_lock-torture: torture_stutter task started
[    1.741956] spin_lock-torture: Creating lock_torture_writer task
[    1.743004] spin_lock-torture: lock_torture_writer task started
[    1.744108] spin_lock-torture: Creating lock_torture_stats task
[    1.745171] spin_lock-torture: lock_torture_writer task started
[    1.746329] spin_lock-torture: lock_torture_stats task started
[    2.720196] tsc: Refined TSC clocksource calibration: 2693.508 MHz
[    2.721299] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x26d=
349e8249, max_idle_ns: 440795288087 ns
[    8.297489] torture_init_begin: Refusing rcu init: spin_lock running.
[    8.298959] torture_init_begin: One torture test at a time!
[    8.300996] Initialise system trusted keyrings
[    8.301759] Key type blacklist registered
[    8.304123] workingset: timestamp_bits=3D36 max_order=3D17 bucket_order=
=3D0
[    8.305214] zbud: loaded
[    8.306509] DLM installed
[    8.307959] FS-Cache: Netfs 'nfs' registered for caching
[    8.309227] NFS: Registering the id_resolver key type
[    8.310058] Key type id_resolver registered
[    8.310719] Key type id_legacy registered
[    8.311362] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    8.312406] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...
[    8.313558] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    8.315290] FS-Cache: Netfs 'cifs' registered for caching
[    8.317607] fuse init (API version 7.26)
[    8.318681] orangefs_debugfs_init: called with debug mask: :none: :0:
[    8.319863] orangefs_init: module version upstream loaded
[    8.320731] 9p: Installing v9fs 9p2000 file system support
[    8.321574] FS-Cache: Netfs '9p' registered for caching
[    8.322513] ceph: loaded (mds proto 32)
[    8.323115] pstore: using lz4 compression
[    8.340256] NET: Registered protocol family 38
[    8.341133] Key type asymmetric registered
[    8.341783] Asymmetric key parser 'x509' registered
[    8.704240] String selftests succeeded
[    8.705218] crc32: CRC_LE_BITS =3D 64, CRC_BE BITS =3D 64
[    8.705970] crc32: self tests passed, processed 225944 bytes in 164471 n=
sec
[    8.707153] crc32c: CRC_LE_BITS =3D 64
[    8.707693] crc32c: self tests passed, processed 225944 bytes in 82457 n=
sec
[    8.725055] crc32_combine: 8373 self tests passed
[    8.742094] crc32c_combine: 8373 self tests passed
[    8.743231] xz_dec_test: module loaded
[    8.743813] xz_dec_test: Create a device node with 'mknod xz_dec_test c =
249 0' and write .xz files to it.
[    8.746225] gpio_it87: no device
[    8.747199] gpio_winbond: chip ID at 2e is ffff
[    8.747903] gpio_winbond: not an our chip
[    8.748604] gpio_winbond: chip ID at 4e is ffff
[    8.749298] gpio_winbond: not an our chip
[    8.750959] no IO addresses supplied
[    8.751846] hgafb: HGA card not detected.
[    8.752543] hgafb: probe of hgafb.0 failed with error -22
[    8.753522] usbcore: registered new interface driver udlfb
[    8.754423] usbcore: registered new interface driver smscufx
[    8.756666] uvesafb: failed to execute /sbin/v86d
[    8.757400] uvesafb: make sure that the v86d helper is installed and exe=
cutable
[    8.758543] uvesafb: Getting VBE info block failed (eax=3D0x4f00, err=3D=
-2)
[    8.759558] uvesafb: vbe_init() failed with -22
[    8.760316] uvesafb: probe of uvesafb.0 failed with error -22
[    8.761284] ipmi message handler version 39.2
[    8.761963] IPMI System Interface driver.
[    8.762785] ipmi_si: Unable to find any System Interface(s)
[    8.763649] IPMI SSIF Interface driver
[    8.764346] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via =
sys_reboot.
[    8.765927] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    8.767235] ACPI: Power Button [PWRF]
[    8.831894] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    8.859699] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    8.890312] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[    8.893084] lp: driver loaded but no devices found
[    8.893900] telclk_interrupt =3D 0xf non-mcpbl0010 hw.
[    8.895850] parport_pc 00:04: reported by Plug and Play ACPI
[    8.897125] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    9.009198] lp0: using parport0 (interrupt-driven).
[    9.011908] dummy-irq: no IRQ given.  Use irq=3DN
[    9.012941] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Gi=
ometti
[    9.014374] c2port c2port0: C2 port uc added
[    9.015119] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 by=
tes total)
[    9.024135] usbcore: registered new interface driver rtsx_usb
[    9.025822] usbcore: registered new interface driver viperboard
[    9.027010] usbcore: registered new interface driver dln2
[    9.028341] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    9.031779] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[    9.033398] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[    9.034988] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[    9.036579] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[    9.038166] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[    9.039752] [nandsim] warning: read_byte: unexpected data output cycle, =
state is STATE_READY return 0x0
[    9.041339] nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
[    9.042424] nand: Toshiba NAND 128MiB 1,8V 8-bit
[    9.043220] nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB =
size: 16
[    9.044651] flash size: 128 MiB
[    9.045202] page size: 512 bytes
[    9.045771] OOB area size: 16 bytes
[    9.046369] sector size: 16 KiB
[    9.046919] pages number: 262144
[    9.047476] pages per sector: 32
[    9.048072] bus width: 8
[    9.048522] bits in sector size: 14
[    9.049129] bits in page size: 9
[    9.049694] bits in OOB size: 4
[    9.050235] flash size with OOB: 135168 KiB
[    9.050954] page address bytes: 4
[    9.051524] sector address bytes: 3
[    9.052146] options: 0x42
[    9.053547] Scanning device for bad blocks
[    9.085915] Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
[    9.087074] 0x000000000000-0x000008000000 : "NAND simulator partition 0"
[    9.098734] [nandsim] warning: CONFIG_MTD_PARTITIONED_MASTER must be ena=
bled to expose debugfs stuff
[    9.100420] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[    9.106356] libphy: Fixed MDIO Bus: probed
[    9.109695] tun: Universal TUN/TAP device driver, 1.6
[    9.110850] vcan: Virtual CAN interface driver
[    9.111622] vxcan: Virtual CAN Tunnel driver
[    9.112572] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    9.113786] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    9.449861] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    9.900712] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    9.901936] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    9.903399] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    9.904459] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    9.905591] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.=
0-k
[    9.906842] igb: Copyright (c) 2007-2014 Intel Corporation.
[    9.907886] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - vers=
ion 5.1.0-k
[    9.909348] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    9.916336] YAM driver version 0.8 by F1OAT/F6FBB
[    9.919093] AX.25: bpqether driver version 004
[    9.919909] baycom_ser_hdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[    9.919909] baycom_ser_hdx: version 0.10
[    9.923602] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA
[    9.924669] hdlcdrv: version 0.8
[    9.925263] baycom_par: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[    9.925263] baycom_par: version 0.9
[    9.930109] NET3 PLIP version 2.4-parport gniibe@mri.co.jp
[    9.931110] plip0: Parallel port at 0x378, using IRQ 7.
[    9.932078] PPP generic driver version 2.4.2
[    9.933193] PPP Deflate Compression module registered
[    9.934134] PPP MPPE Compression module registered
[    9.934998] NET: Registered protocol family 24
[    9.937773] ieee802154fakelb ieee802154fakelb: added 2 fake ieee802154 h=
ardware devices
[    9.939352] usbcore: registered new interface driver atusb
[    9.940635] parport0: cannot grant exclusive access for device ks0108
[    9.941784] ks0108: ERROR: parport didn't register new device
[    9.942930] cfag12864b: ERROR: ks0108 is not initialized
[    9.943872] cfag12864bfb: ERROR: cfag12864b is not initialized
[   10.214804] panel: panel driver registered on parport0 (io=3D0x378).
[   10.216447] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   10.217831] ehci-pci: EHCI PCI platform driver
[   10.218650] ehci-platform: EHCI generic platform driver
[   10.219679] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   10.220843] ohci-pci: OHCI PCI platform driver
[   10.221686] ohci-platform: OHCI generic platform driver
[   10.224320] driver u132_hcd
[   10.225093] fotg210_hcd: FOTG210 Host Controller (EHCI) Driver
[   10.226098] Warning! fotg210_hcd should always be loaded before uhci_hcd=
 and ohci_hcd, not after
[   10.236674] usbcore: registered new interface driver usblp
[   10.237808] usbcore: registered new interface driver cdc_wdm
[   10.238795] usbcore: registered new interface driver usbtmc
[   10.239607] usbcore: registered new interface driver mdc800
[   10.250923] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Dig=
ital Camera
[   10.252450] usbcore: registered new interface driver adutux
[   10.253571] usbcore: registered new interface driver appledisplay
[   10.254796] usbcore: registered new interface driver cytherm
[   10.255954] usbcore: registered new interface driver emi26 - firmware lo=
ader
[   10.257271] usbcore: registered new interface driver emi62 - firmware lo=
ader
[   10.258421] ftdi_elan: driver ftdi-elan
[   10.259112] usbcore: registered new interface driver ftdi-elan
[   10.273179] usbcore: registered new interface driver usblcd
[   10.274162] usbcore: registered new interface driver legousbtower
[   10.275285] usbcore: registered new interface driver rio500
[   10.276272] usbcore: registered new interface driver usbtest
[   10.277267] usbcore: registered new interface driver usb_ehset_test
[   10.278367] usbcore: registered new interface driver trancevibrator
[   10.279452] usbcore: registered new interface driver yurex
[   10.280599] usbcore: registered new interface driver lvs
[   10.282764] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
[   10.284180] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus nu=
mber 1
[   10.285454] vhci_hcd: created sysfs vhci_hcd.0
[   10.299701] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.17
[   10.301110] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.302421] usb usb1: Product: USB/IP Virtual Host Controller
[   10.303487] usb usb1: Manufacturer: Linux 4.17.0-rc2 vhci_hcd
[   10.304482] usb usb1: SerialNumber: vhci_hcd.0
[   10.308954] hub 1-0:1.0: USB hub found
[   10.309924] hub 1-0:1.0: 8 ports detected
[   10.312522] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
[   10.314128] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus nu=
mber 2
[   10.315868] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[   10.317922] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 4.17
[   10.319784] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.321470] usb usb2: Product: USB/IP Virtual Host Controller
[   10.322537] usb usb2: Manufacturer: Linux 4.17.0-rc2 vhci_hcd
[   10.323481] usb usb2: SerialNumber: vhci_hcd.0
[   10.324891] hub 2-0:1.0: USB hub found
[   10.325567] hub 2-0:1.0: 8 ports detected
[   10.327892] usbcore: registered new device driver usbip-host
[   10.329893] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[   10.332579] serio: i8042 KBD port at 0x60,0x64 irq 1
[   10.333455] serio: i8042 AUX port at 0x60,0x64 irq 12
[   10.334888] parport0: cannot grant exclusive access for device parkbd
[   10.443807] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[   10.446495] i2c-parport: adapter type unspecified
[   10.447288] i2c-parport-light: adapter type unspecified
[   10.448344] usbcore: registered new interface driver RobotFuzz Open Sour=
ce InterFace, OSIF
[   10.449758] usbcore: registered new interface driver i2c-tiny-usb
[   10.469447] usbcore: registered new interface driver dvb_usb_af9015
[   10.474372] usbcore: registered new interface driver dvb_usb_af9035
[   10.475155] usbcore: registered new interface driver dvb_usb_dvbsky
[   10.475956] usbcore: registered new interface driver zd1301
[   10.476979] usbcore: registered new interface driver smsusb
[   10.477977] usbcore: registered new interface driver usbvision
[   10.478947] USBVision USB Video Device Driver for Linux : 0.9.11
[   10.480229] pps pps0: new PPS source ktimer
[   10.480944] pps pps0: ktimer PPS source registered
[   10.481749] Driver for 1-wire Dallas network protocol.
[   10.482757] usbcore: registered new interface driver DS9490R
[   10.483843] w1_f0d_init()
[   10.486346] f71882fg: Not a Fintek device
[   10.487048] f71882fg: Not a Fintek device
[   10.489110] pc87360: PC8736x not detected, module not inserted
[   10.491455] CAPI 2.0 started up with major 68 (no middleware)
[   10.492519] sdhci: Secure Digital Host Controller Interface driver
[   10.493526] sdhci: Copyright(c) Pierre Ossman
[   10.494370] VUB300 Driver rom wait states =3D 1C irqpoll timeout =3D 0400
[   10.494820] usbcore: registered new interface driver vub300
[   10.496761] usbcore: registered new interface driver ushc
[   10.497650] sdhci-pltfm: SDHCI platform and OF driver helper
[   10.501147] usbcore: registered new interface driver usbhid
[   10.502060] usbhid: USB HID core driver
[   10.502680] dell_smbios: Unable to run on non-Dell system
[   10.512327] pktgen: Packet Generator for packet performance testing. Ver=
sion: 2.75
[   10.514714] IPVS: Registered protocols (SCTP, AH, ESP)
[   10.515585] IPVS: Connection hash table configured (size=3D4096, memory=
=3D64Kbytes)
[   10.516802] IPVS: Each connection entry needs 400 bytes at least
[   10.517982] IPVS: ipvs loaded.
[   10.518379] IPVS: [rr] scheduler registered.
[   10.518993] IPVS: [wrr] scheduler registered.
[   10.519682] IPVS: [lc] scheduler registered.
[   10.520387] IPVS: [ovf] scheduler registered.
[   10.521038] IPVS: [lblc] scheduler registered.
[   10.521690] IPVS: [sh] scheduler registered.
[   10.522343] IPVS: [sed] scheduler registered.
[   10.523115] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   10.524639] gre: GRE over IPv4 demultiplexor driver
[   10.525447] ip_gre: GRE over IPv4 tunneling driver
[   10.528208] NET: Registered protocol family 10
[   10.531417] Segment Routing with IPv6
[   10.532195] mip6: Mobile IPv6
[   10.533046] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   10.535200] ip6_gre: GRE over IPv6 tunneling driver
[   10.538142] NET: Registered protocol family 17
[   10.538917] NET: Registered protocol family 15
[   10.539859] NET: Registered protocol family 5
[   10.553890] NET: Registered protocol family 6
[   10.554715] NET: Registered protocol family 3
[   10.555445] can: controller area network core (rev 20170425 abi 9)
[   10.564200] NET: Registered protocol family 29
[   10.564995] can: raw protocol (rev 20170425)
[   10.566321] NET: Registered protocol family 33
[   10.567051] Key type rxrpc registered
[   10.567572] Key type rxrpc_s registered
[   10.568263] NET: Registered protocol family 35
[   10.569350] DCCP: Activated CCID 2 (TCP-like)
[   10.570447] sctp: Hash tables configured (bind 32/51)
[   10.571483] tipc: Activated (version 2.0.0)
[   10.572363] NET: Registered protocol family 30
[   10.573536] tipc: Started in single node mode
[   10.574297] 9pnet: Installing 9P2000 support
[   10.575256] Key type dns_resolver registered
[   10.576096] Key type ceph registered
[   10.577560] libceph: loaded (mon/osd proto 15/24)
[   10.578821] batman_adv: B.A.T.M.A.N. advanced 2018.1 (compatibility vers=
ion 15) loaded
[   10.580417] openvswitch: Open vSwitch switching datapath
[   10.581673] mpls_gso: MPLS GSO support
[   10.582608] mce: Unable to init MCE device (rc: -5)
[   10.584096] ... APIC ID:      00000000 (0)
[   10.584811] ... APIC VERSION: 01050014
[   10.585459] 000000000000000000000000000000000000000000000000000000000000=
0000
[   10.586677] 000000000000000000000000000000000000000000000000000000000000=
0000
[   10.587879] 000000000000000000000000000000000000000000000000000000000000=
0000
[   10.589105] number of MP IRQ sources: 15.
[   10.589874] number of IO-APIC #0 registers: 24.
[   10.590642] testing the IO APIC.......................
[   10.591521] IO APIC #0......
[   10.592043] .... register #00: 00000000
[   10.592718] .......    : physical APIC id: 00
[   10.593463] .......    : Delivery Type: 0
[   10.594139] .......    : LTS          : 0
[   10.594820] .... register #01: 00170011
[   10.595498] .......     : max redirection entries: 17
[   10.596423] .......     : PRQ implemented: 0
[   10.597130] .......     : IO APIC version: 11
[   10.597854] .... register #02: 00000000
[   10.598494] .......     : arbitration: 00
[   10.599152] .... IRQ redirection table:
[   10.599945] IOAPIC 0:
[   10.600368]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.601591]  pin01, enabled , edge , high, V(24), IRR(0), S(0), logical =
, D(01), M(0)
[   10.602749]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical =
, D(01), M(0)
[   10.604058]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.605381]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.606497]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.607602]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.608993]  pin07, enabled , edge , high, V(22), IRR(0), S(0), logical =
, D(01), M(0)
[   10.610448]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.611613]  pin09, enabled , level, high, V(21), IRR(0), S(0), logical =
, D(01), M(0)
[   10.612751]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.613897]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.615289]  pin0c, enabled , edge , high, V(23), IRR(0), S(0), logical =
, D(01), M(0)
[   10.616673]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.618030]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.619382]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.625417]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.626778]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.628143]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.629488]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.635874]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.637250]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.638600]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.640893]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   10.642239] IRQ to pin mappings:
[   10.642814] IRQ0 -> 0:2
[   10.643274] IRQ1 -> 0:1
[   10.643756] IRQ3 -> 0:3
[   10.644251] IRQ4 -> 0:4
[   10.644738] IRQ5 -> 0:5
[   10.645216] IRQ6 -> 0:6
[   10.645844] IRQ7 -> 0:7
[   10.646306] IRQ8 -> 0:8
[   10.646773] IRQ9 -> 0:9
[   10.647218] IRQ10 -> 0:10
[   10.647699] IRQ11 -> 0:11
[   10.648198] IRQ12 -> 0:12
[   10.648679] IRQ13 -> 0:13
[   10.649150] IRQ14 -> 0:14
[   10.649623] IRQ15 -> 0:15
[   10.650179] .................................... done.
[   10.651192] AVX version of gcm_enc/dec engaged.
[   10.651989] AES CTR mode by8 optimization enabled
[   10.655547] sched_clock: Marking stable (10652813941, 0)->(11241770164, =
-588956223)
[   10.658218] registered taskstats version 1
[   10.658915] Loading compiled-in X.509 certificates
[   10.660468] Key type encrypted registered
[   10.661933] console [netcon0] enabled
[   10.662642] netconsole: network logging started
[   10.664683] Duplicate name in testcase-data, renamed to "duplicate-name#=
1"
[   10.668032] ### dt-test ### start of unittest - you will see error messa=
ges
[   10.669661] OF: /testcase-data/phandle-tests/consumer-a: could not get #=
phandle-cells-missing for /testcase-data/phandle-tests/provider1
[   10.671812] OF: /testcase-data/phandle-tests/consumer-a: could not get #=
phandle-cells-missing for /testcase-data/phandle-tests/provider1
[   10.673907] OF: /testcase-data/phandle-tests/consumer-a: could not find =
phandle
[   10.675160] OF: /testcase-data/phandle-tests/consumer-a: could not find =
phandle
[   10.676425] OF: /testcase-data/phandle-tests/consumer-a: arguments longe=
r than property
[   10.677817] OF: /testcase-data/phandle-tests/consumer-a: arguments longe=
r than property
[   10.680218] OF: /testcase-data/phandle-tests/consumer-b: could not get #=
phandle-missing-cells for /testcase-data/phandle-tests/provider1
[   10.682003] OF: /testcase-data/phandle-tests/consumer-b: could not find =
phandle
[   10.683261] OF: /testcase-data/phandle-tests/consumer-b: arguments longe=
r than property
[   10.694798] OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/t=
estcase-data/overlay-node/test-bus/test-unittest8
[   10.696724] OF: overlay: overlay #6 is not topmost
[   10.703799] i2c i2c-0: Added multiplexed i2c bus 1
[   10.707648] i2c i2c-0: Added multiplexed i2c bus 2
[   10.712881] ### dt-test ### FAIL of_unittest_overlay_high_level():2304 o=
verlay_base_root not initialized
[   10.714501] ### dt-test ### end of unittest - 207 passed, 1 failed
[   10.716915] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[   10.723110] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.724769] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX
[   10.726722] IP-Config: Failed to open plip0
[   10.727470] DHCP/BOOTP: Ignoring device wpan0, MTU 123 too small
[   10.728552] DHCP/BOOTP: Ignoring device wpan1, MTU 123 too small
[   10.729580] IP-Config: Failed to open gretap0
[   10.730389] IP-Config: Failed to open erspan0
[   10.731161] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   10.748078] Sending DHCP requests ., OK
[   10.756751] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0=
=2E2.15
[   10.757947] IP-Config: Complete:
[   10.758503]      device=3Deth0, hwaddr=3D52:54:00:12:34:56, ipaddr=3D10.=
0.2.15, mask=3D255.255.255.0, gw=3D10.0.2.2
[   10.760121]      host=3Dvm-ivb41-yocto-ia32-18, domain=3D, nis-domain=3D=
(none)
[   10.761243]      bootserver=3D10.0.2.2, rootserver=3D10.0.2.2, rootpath=
=3D     nameserver0=3D10.0.2.3
[   10.774348] Freeing unused kernel memory: 4180K
[   10.775224] Write protecting the kernel read-only data: 24576k
[   10.778454] Freeing unused kernel memory: 2000K
[   10.783817] Freeing unused kernel memory: 980K
[   10.784906] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   10.785966] rodata_test: all tests were successful
/ # PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/lkp/lkp/src/bin
LKP: HOSTNAME vm-ivb41-yocto-ia32-18, MAC 12:4d:1c:c2:ba:e8, kernel 4.17.0-=
rc2 145, serial console /dev/ttyS0
[   11.091342] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input3
[   11.283615] random: fast init done
[   11.831486] /lkp/lkp/src/monitors/heartbeat: line 9: vmstat: not found
[   11.831486] /lkp/lkp/src/monitors/heartbeat: exec: line 23: vmstat: not =
found
[   11.833991] Kernel tests: Boot OK!
[   11.833991] /lkp/lkp/src/bin/run-lkp
[   11.833991] RESULT_ROOT=3D/result/trinity/300s/vm-ivb41-yocto-ia32/yocto=
-tiny-i386-2016-04-22.cgz/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd1=
17f6992c46611dfb4ce267cd71e/2
[   11.833991] job=3D/lkp/scheduled/vm-ivb41-yocto-ia32-18/trinity-300s-yoc=
to-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-201804=
25-6417-i7ogw5-0.yaml
[   11.833991] run-job /lkp/scheduled/vm-ivb41-yocto-ia32-18/trinity-300s-y=
octo-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-2018=
0425-6417-i7ogw5-0.yaml
[   11.833991] /bin/busybox wget -q http://inn:80/~lkp/cgi-bin/lkp-jobfile-=
append-var?job_file=3D/lkp/scheduled/vm-ivb41-yocto-ia32-18/trinity-300s-yo=
cto-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-20180=
425-6417-i7ogw5-0.yaml&job_state=3Drunning -O /dev/null
[   11.833991] skip microcode check for virtual machine
[   12.848089] BusyBox v1.24.1 (2016-04-18 23:03:30 GMT) multi-call binary.
[   12.848089]=20
[   12.848089] Usage: time [-v] PROG ARGS
[   12.864300] Seeding trinity based on x86_64-randconfig-s4-04251005
[   12.864300] 2018-04-25 03:02:53 trinity -q -q -l off -s 897068 -x get_ro=
bust_list -x remap_file_pages -N 999999999 -X
[   12.864300] Trinity 1.8  Dave Jones <davej@codemonkey.org.uk>
[   12.864300] shm:0xf764d000-0x3df9e14 (4 pages)
[   12.864300] [main] Marking syscall get_robust_list (312) as to be disabl=
ed.
[   12.864300] [main] Marking syscall remap_file_pages (257) as to be disab=
led.
[   12.864300] Error getting nobody pwent (No such file or directory)
[   62.432136] Writes:  Total: 20944057  Max/Min: 0/0   Fail: 0=20
[  123.885728] Writes:  Total: 41708535  Max/Min: 0/0   Fail: 0=20
[  185.312613] Writes:  Total: 61148802  Max/Min: 0/0   Fail: 0=20
[  246.752095] Writes:  Total: 86067258  Max/Min: 0/0   Fail: 0=20
[  294.560671]=20
[  294.560924] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  294.561539] WARNING: inconsistent lock state
[  294.562165] 4.17.0-rc2 #145 Not tainted
[  294.562724] --------------------------------
[  294.563338] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[  294.564201] kworker/0:2/28 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  294.564976]         (ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire+=
0x0/0x30
[  294.566157] {HARDIRQ-ON-W} state was registered at:
[  294.566863]   lock_acquire+0x79/0xd0
[  294.567379]   fs_reclaim_acquire+0x24/0x30
[  294.568069]   fs_reclaim_acquire+0x14/0x20
[  294.568660]   kmem_cache_alloc_node+0x32/0x240
[  294.569294]   __kmalloc_node+0x24/0x30
[  294.569841]   alloc_cpumask_var_node+0x1f/0x50
[  294.570477]   zalloc_cpumask_var+0x14/0x20
[  294.571071]   native_smp_prepare_cpus+0xf4/0x364
[  294.571738]   kvm_smp_prepare_cpus+0x21/0xff
[  294.572349]   kernel_init_freeable+0x2b5/0x4db
[  294.572995]   kernel_init+0x9/0x100
[  294.573499]   ret_from_fork+0x24/0x30
[  294.574169] irq event stamp: 141042
[  294.574681] hardirqs last  enabled at (141041): [<ffffffff81d6dd81>] _ra=
w_spin_unlock_irqrestore+0x31/0x60
[  294.576050] hardirqs last disabled at (141042): [<ffffffff81e008d4>] int=
errupt_entry+0xd4/0x100
[  294.577278] softirqs last  enabled at (140644): [<ffffffff81aaec82>] upd=
ate_defense_level+0x122/0x450
[  294.578577] softirqs last disabled at (140642): [<ffffffff81aaeb60>] upd=
ate_defense_level+0x0/0x450
[  294.579855]=20
[  294.579855] other info that might help us debug this:
[  294.580867]  Possible unsafe locking scenario:
[  294.580867]=20
[  294.581714]        CPU0
[  294.582073]        ----
[  294.582431]   lock(fs_reclaim);
[  294.582892]   <Interrupt>
[  294.583273]     lock(fs_reclaim);
[  294.583757]=20
[  294.583757]  *** DEADLOCK ***
[  294.583757]=20
[  294.584592] 2 locks held by kworker/0:2/28:
[  294.585196]  #0:         (ptrval) ((wq_completion)"events"){+.+.}, at: p=
rocess_one_work+0x1d6/0x460
[  294.586497]  #1:         (ptrval) ((work_completion)(&(&adapter->watchdo=
g_task)->work)){+.+.}, at: process_one_work+0x1d6/0x460
[  294.588125]=20
[  294.588125] stack backtrace:
[  294.588753] CPU: 0 PID: 28 Comm: kworker/0:2 Not tainted 4.17.0-rc2 #145
[  294.589803] Workqueue: events e1000_watchdog
[  294.590410] Call Trace:
[  294.590776]  <IRQ>
[  294.591078]  dump_stack+0x8e/0xd5
[  294.591557]  print_usage_bug+0x247/0x262
[  294.592221]  mark_lock+0x5c5/0x660
[  294.592719]  ? check_usage_backwards+0x160/0x160
[  294.593436]  __lock_acquire+0xdcf/0x1b70
[  294.594006]  ? __lock_acquire+0x3f1/0x1b70
[  294.594595]  ? trace_hardirqs_off+0xd/0x10
[  294.595190]  lock_acquire+0x79/0xd0
[  294.595706]  ? lock_acquire+0x79/0xd0
[  294.596259]  ? find_suitable_fallback+0x80/0x80
[  294.609933]  ? crng_reseed+0x13e/0x2e0
[  294.610479]  fs_reclaim_acquire+0x24/0x30
[  294.611163]  ? find_suitable_fallback+0x80/0x80
[  294.611915]  fs_reclaim_acquire+0x14/0x20
[  294.612490]  __kmalloc+0x35/0x240
[  294.612982]  crng_reseed+0x13e/0x2e0
[  294.613499]  credit_entropy_bits+0x21c/0x230
[  294.625342]  add_interrupt_randomness+0x293/0x300
[  294.626072]  handle_irq_event_percpu+0x3b/0x70
[  294.626718]  handle_irq_event+0x34/0x60
[  294.627272]  handle_fasteoi_irq+0x70/0x120
[  294.627867]  handle_irq+0x15/0x20
[  294.628349]  do_IRQ+0x53/0x100
[  294.628803]  common_interrupt+0xf/0xf
[  294.629331]  </IRQ>
[  294.629653] RIP: 0010:e1000_watchdog+0x126/0x530
[  294.630335] RSP: 0000:ffff880016823e00 EFLAGS: 00000297 ORIG_RAX: ffffff=
ffffffffda
[  294.631690] RAX: 0000000000000010 RBX: ffff880014f992c0 RCX: 00000000000=
00006
[  294.632971] RDX: ffffc900008e0000 RSI: ffff88001681d3b8 RDI: ffff880014f=
98e70
[  294.634237] RBP: ffff880016823e38 R08: 0000000097c673cd R09: 00000000000=
00000
[  294.635549] R10: 0000000000000000 R11: 0000000000000000 R12: ffff880014f=
98a80
[  294.636838] R13: ffff880014f98000 R14: ffff880018994480 R15: ffff880014f=
98e70
[  294.638276]  process_one_work+0x236/0x460
[  294.638993]  ? process_one_work+0x1d6/0x460
[  294.639652]  worker_thread+0x35/0x3f0
[  294.640175]  kthread+0x122/0x140
[  294.640646]  ? process_one_work+0x460/0x460
[  294.641242]  ? __kthread_create_on_node+0x190/0x190
[  294.641941]  ret_from_fork+0x24/0x30
[  294.642506] BUG: sleeping function called from invalid context at mm/sla=
b.h:421
[  294.644135] in_atomic(): 1, irqs_disabled(): 1, pid: 28, name: kworker/0=
:2
[  294.646373] INFO: lockdep is turned off.
[  294.647940] irq event stamp: 141042
[  294.648638] hardirqs last  enabled at (141041): [<ffffffff81d6dd81>] _ra=
w_spin_unlock_irqrestore+0x31/0x60
[  294.655362] hardirqs last disabled at (141042): [<ffffffff81e008d4>] int=
errupt_entry+0xd4/0x100
[  294.676115] softirqs last  enabled at (140644): [<ffffffff81aaec82>] upd=
ate_defense_level+0x122/0x450
[  294.677737] softirqs last disabled at (140642): [<ffffffff81aaeb60>] upd=
ate_defense_level+0x0/0x450
[  294.682738] CPU: 0 PID: 28 Comm: kworker/0:2 Not tainted 4.17.0-rc2 #145
[  294.683763] Workqueue: events e1000_watchdog
[  294.684414] Call Trace:
[  294.697850]  <IRQ>
[  294.698174]  dump_stack+0x8e/0xd5
[  294.698697]  ___might_sleep+0x15f/0x250
[  294.699288]  __might_sleep+0x45/0x80
[  294.699853]  __kmalloc+0x1a3/0x240
[  294.700387]  crng_reseed+0x13e/0x2e0
[  294.700957]  credit_entropy_bits+0x21c/0x230
[  294.701642]  add_interrupt_randomness+0x293/0x300
[  294.702382]  handle_irq_event_percpu+0x3b/0x70
[  294.703080]  handle_irq_event+0x34/0x60
[  294.703689]  handle_fasteoi_irq+0x70/0x120
[  294.704325]  handle_irq+0x15/0x20
[  294.704863]  do_IRQ+0x53/0x100
[  294.705347]  common_interrupt+0xf/0xf
[  294.705927]  </IRQ>
[  294.706267] RIP: 0010:e1000_watchdog+0x126/0x530
[  294.706983] RSP: 0000:ffff880016823e00 EFLAGS: 00000297 ORIG_RAX: ffffff=
ffffffffda
[  294.708142] RAX: 0000000000000010 RBX: ffff880014f992c0 RCX: 00000000000=
00006
[  294.709228] RDX: ffffc900008e0000 RSI: ffff88001681d3b8 RDI: ffff880014f=
98e70
[  294.710314] RBP: ffff880016823e38 R08: 0000000097c673cd R09: 00000000000=
00000
[  294.715815] R10: 0000000000000000 R11: 0000000000000000 R12: ffff880014f=
98a80
[  294.716907] R13: ffff880014f98000 R14: ffff880018994480 R15: ffff880014f=
98e70
[  294.718019]  process_one_work+0x236/0x460
[  294.718643]  ? process_one_work+0x1d6/0x460
[  294.719281]  worker_thread+0x35/0x3f0
[  294.719859]  kthread+0x122/0x140
[  294.720361]  ? process_one_work+0x460/0x460
[  294.721008]  ? __kthread_create_on_node+0x190/0x190
[  294.721766]  ret_from_fork+0x24/0x30
[  294.722324] random: crng init done

Elapsed time: 300

#!/bin/bash

# To reproduce,
# 1) save job-script and this script (both are attached in 0day report emai=
l)
# 2) run this script with your compiled kernel and optional env $INSTALL_MO=
D_PATH

kernel=3D$1

initrds=3D(
	/osimage/yocto/yocto-tiny-i386-2016-04-22.cgz
	/lkp/lkp/lkp-i386.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig.i386_2016-09-03.cgz
	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-i386-x86_64-6ddab=
fd2_2017-11-10.cgz
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

qemu-img create -f qcow2 disk-vm-ivb41-yocto-ia32-18-0 256G

kvm=3D(
	qemu-system-x86_64
	-enable-kvm
	-cpu IvyBridge
	-kernel $kernel
	-initrd initrd.img
	-m 420
	-smp 1
	-device e1000,netdev=3Dnet0
	-netdev user,id=3Dnet0
	-boot order=3Dnc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=3Dlocaltime
	-drive file=3Ddisk-vm-ivb41-yocto-ia32-18-0,media=3Ddisk,if=3Dvirtio
	-serial stdio
	-display none
	-monitor null
)

append=3D(
	ip=3D::::vm-ivb41-yocto-ia32-18::dhcp
	root=3D/dev/ram0
	user=3Dlkp
	job=3D/job-script
	ARCH=3Dx86_64
	kconfig=3Dx86_64-randconfig-s4-04251005
	branch=3Dlinus/master
	commit=3D6d08b06e67cd117f6992c46611dfb4ce267cd71e
	BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd11=
7f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2
	max_uptime=3D1500
	RESULT_ROOT=3D/result/trinity/300s/vm-ivb41-yocto-ia32/yocto-tiny-i386-201=
6-04-22.cgz/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611d=
fb4ce267cd71e/2
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
	drbd.minor_count=3D8
	rcuperf.shutdown=3D0
)

"${kvm[@]}" -append "${append[*]}"

--wru5vry3cjtl6h2j
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

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
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
# CONFIG_TASK_XACCT is not set
CONFIG_CPU_ISOLATION=y

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
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_SANCOV=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
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
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
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
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
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
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
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
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
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
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
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
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_VERIFY_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
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
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
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
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set

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
# CONFIG_PCIE_CADENCE_HOST is not set

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
# CONFIG_COREDUMP is not set
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
# CONFIG_TCP_CONG_CUBIC is not set
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=y
# CONFIG_TCP_CONG_HYBLA is not set
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=y
CONFIG_TCP_CONG_VENO=y
# CONFIG_TCP_CONG_YEAH is not set
# CONFIG_TCP_CONG_ILLINOIS is not set
CONFIG_TCP_CONG_DCTCP=y
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
CONFIG_DEFAULT_VENO=y
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_BBR is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="veno"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_NETLABEL=y
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
CONFIG_NF_CONNTRACK_BROADCAST=y
CONFIG_NF_CONNTRACK_NETBIOS_NS=y
CONFIG_NF_CONNTRACK_SIP=y
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_INET=y
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_EXTHDR is not set
# CONFIG_NFT_META is not set
CONFIG_NFT_RT=y
CONFIG_NFT_NUMGEN=y
# CONFIG_NFT_CT is not set
CONFIG_NFT_SET_RBTREE=y
CONFIG_NFT_SET_HASH=y
# CONFIG_NFT_SET_BITMAP is not set
CONFIG_NFT_COUNTER=y
CONFIG_NFT_LOG=y
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=y
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=y
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=y
# CONFIG_NFT_HASH is not set
CONFIG_NFT_FIB=y
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
# CONFIG_NETFILTER_XT_MARK is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_NAT=y
CONFIG_NETFILTER_XT_TARGET_NETMAP=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
CONFIG_NETFILTER_XT_MATCH_STATE=y
CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
CONFIG_IP_SET_BITMAP_IPMAC=y
# CONFIG_IP_SET_BITMAP_PORT is not set
CONFIG_IP_SET_HASH_IP=y
CONFIG_IP_SET_HASH_IPMARK=y
# CONFIG_IP_SET_HASH_IPPORT is not set
CONFIG_IP_SET_HASH_IPPORTIP=y
CONFIG_IP_SET_HASH_IPPORTNET=y
CONFIG_IP_SET_HASH_IPMAC=y
# CONFIG_IP_SET_HASH_MAC is not set
CONFIG_IP_SET_HASH_NETPORTNET=y
# CONFIG_IP_SET_HASH_NET is not set
# CONFIG_IP_SET_HASH_NETNET is not set
# CONFIG_IP_SET_HASH_NETPORT is not set
CONFIG_IP_SET_HASH_NETIFACE=y
CONFIG_IP_SET_LIST_SET=y
CONFIG_IP_VS=y
# CONFIG_IP_VS_IPV6 is not set
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
# CONFIG_IP_VS_PROTO_UDP is not set
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=y
CONFIG_IP_VS_WRR=y
CONFIG_IP_VS_LC=y
# CONFIG_IP_VS_WLC is not set
# CONFIG_IP_VS_FO is not set
CONFIG_IP_VS_OVF=y
CONFIG_IP_VS_LBLC=y
# CONFIG_IP_VS_LBLCR is not set
# CONFIG_IP_VS_DH is not set
CONFIG_IP_VS_SH=y
CONFIG_IP_VS_SED=y
# CONFIG_IP_VS_NQ is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#
# CONFIG_IP_VS_NFCT is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_CONNTRACK_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_CHAIN_ROUTE_IPV4 is not set
# CONFIG_NFT_DUP_IPV4 is not set
CONFIG_NFT_FIB_IPV4=y
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_NF_NAT_IPV4=y
# CONFIG_NFT_CHAIN_NAT_IPV4 is not set
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NFT_MASQ_IPV4=y
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_FILTER is not set
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_CONNTRACK_IPV6=y
CONFIG_NF_SOCKET_IPV6=y
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_CHAIN_ROUTE_IPV6=y
CONFIG_NFT_DUP_IPV6=y
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_REJECT=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_RAW=y
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
CONFIG_BRIDGE_EBT_AMONG=y
CONFIG_BRIDGE_EBT_ARP=y
CONFIG_BRIDGE_EBT_IP=y
CONFIG_BRIDGE_EBT_IP6=y
CONFIG_BRIDGE_EBT_LIMIT=y
CONFIG_BRIDGE_EBT_MARK=y
# CONFIG_BRIDGE_EBT_PKTTYPE is not set
CONFIG_BRIDGE_EBT_STP=y
CONFIG_BRIDGE_EBT_VLAN=y
# CONFIG_BRIDGE_EBT_ARPREPLY is not set
# CONFIG_BRIDGE_EBT_DNAT is not set
CONFIG_BRIDGE_EBT_MARK_T=y
CONFIG_BRIDGE_EBT_REDIRECT=y
CONFIG_BRIDGE_EBT_SNAT=y
# CONFIG_BRIDGE_EBT_LOG is not set
# CONFIG_BRIDGE_EBT_NFLOG is not set
CONFIG_IP_DCCP=y

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
# CONFIG_IP_DCCP_CCID3 is not set

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
# CONFIG_RDS is not set
CONFIG_TIPC=y
# CONFIG_TIPC_MEDIA_UDP is not set
# CONFIG_TIPC_DIAG is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_6LOWPAN=y
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=y
CONFIG_6LOWPAN_NHC_DEST=y
CONFIG_6LOWPAN_NHC_FRAGMENT=y
CONFIG_6LOWPAN_NHC_HOP=y
CONFIG_6LOWPAN_NHC_IPV6=y
# CONFIG_6LOWPAN_NHC_MOBILITY is not set
CONFIG_6LOWPAN_NHC_ROUTING=y
CONFIG_6LOWPAN_NHC_UDP=y
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=y
# CONFIG_6LOWPAN_GHC_UDP is not set
CONFIG_6LOWPAN_GHC_ICMPV6=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=y
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=y
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_IEEE802154_6LOWPAN=y
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUGFS is not set
CONFIG_OPENVSWITCH=y
CONFIG_OPENVSWITCH_GRE=y
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=y
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=y
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=y
CONFIG_YAM=y
CONFIG_CAN=y
CONFIG_CAN_RAW=y
# CONFIG_CAN_BCM is not set
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_IPV6 is not set
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
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
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_BCH=y
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_PLATFORM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
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
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
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
CONFIG_NET_CORE=y
CONFIG_BONDING=y
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y
CONFIG_IPVLAN=y
CONFIG_IPVTAP=y
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=y
CONFIG_TAP=y
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

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
CONFIG_NET_VENDOR_AMAZON=y
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
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=y
CONFIG_NET_CADENCE=y
CONFIG_MACB=y
# CONFIG_MACB_USE_HWSTAMP is not set
# CONFIG_MACB_PCI is not set
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
# CONFIG_NET_VENDOR_CORTINA is not set
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
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NET_VENDOR_8390 is not set
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
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
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
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_PLATFORM is not set
# CONFIG_STMMAC_PCI is not set
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
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=y
# CONFIG_MDIO_HISI_FEMAC is not set
CONFIG_MDIO_OCTEON=y
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
CONFIG_AQUANTIA_PHY=y
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83848_PHY=y
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=y
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
# CONFIG_VITESSE_PHY is not set
CONFIG_XILINX_GMII2RGMII=y
CONFIG_PLIP=y
CONFIG_PPP=y
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOE=y
# CONFIG_PPTP is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=y
# CONFIG_USB_NET_DRIVERS is not set
CONFIG_WLAN=y
CONFIG_WIRELESS_WDS=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_WLAN_VENDOR_CISCO is not set
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_WLAN_VENDOR_RSI is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
# CONFIG_WLAN_VENDOR_QUANTENNA is not set

#
# WiMAX Wireless Broadband devices
#
# CONFIG_WIMAX_I2400M_USB is not set
CONFIG_WAN=y
# CONFIG_HDLC is not set
# CONFIG_DLCI is not set
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
CONFIG_IEEE802154_ATUSB=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=y
CONFIG_ISDN=y
# CONFIG_ISDN_I4L is not set
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_CAPI20=y
# CONFIG_ISDN_CAPI_MIDDLEWARE is not set

#
# CAPI hardware drivers
#
# CONFIG_CAPI_AVM is not set
# CONFIG_CAPI_EICON is not set
# CONFIG_ISDN_DRV_GIGASET is not set
# CONFIG_MISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PROC_INTERFACE is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set

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
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

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
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_DLN2=y
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
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_MAX77620 is not set
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set

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
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_MAX8925_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_BATTERY_TWL4030_MADC=y
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_LP8788=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
# CONFIG_MFD_CROS_EC_CHARDEV is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
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
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8997 is not set
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RK808=y
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65217 is not set
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
# CONFIG_DVB_NET is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Analog TV USB devices
#
# CONFIG_VIDEO_PVRUSB2 is not set
# CONFIG_VIDEO_HDPVR is not set
CONFIG_VIDEO_USBVISION=y
# CONFIG_VIDEO_STK1160_COMMON is not set

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set

#
# Digital TV USB devices
#
CONFIG_DVB_USB_V2=y
CONFIG_DVB_USB_AF9015=y
CONFIG_DVB_USB_AF9035=y
# CONFIG_DVB_USB_ANYSEE is not set
# CONFIG_DVB_USB_AU6610 is not set
# CONFIG_DVB_USB_AZ6007 is not set
# CONFIG_DVB_USB_CE6230 is not set
# CONFIG_DVB_USB_EC168 is not set
# CONFIG_DVB_USB_GL861 is not set
# CONFIG_DVB_USB_MXL111SF is not set
# CONFIG_DVB_USB_RTL28XXU is not set
CONFIG_DVB_USB_DVBSKY=y
CONFIG_DVB_USB_ZD1301=y
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_SMS_USB_DRV=y
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_SMS_SIANO_MDTV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=y

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_TS2020=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_ZD1301_DEMOD=y

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_AF9033=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_SP2=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

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
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

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
CONFIG_FB_UVESA=y
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
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
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=y
CONFIG_FB_AUO_K1901=y
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

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
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_OTG_FSM=y
CONFIG_USB_MON=y
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
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
CONFIG_USBIP_VHCI_HCD=y
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=y
CONFIG_USBIP_VUDC=y
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_OF=y
CONFIG_USB_CHIPIDEA_PCI=y
# CONFIG_USB_CHIPIDEA_UDC is not set
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_ULPI=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_RIO500=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_F_NCM=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_PHONET is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_UVC is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y
# CONFIG_TYPEC is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_UWB is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
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
CONFIG_MMC_GOLDFISH=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=y
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=y
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
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
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_SMM=y
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
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
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# CONFIG_SOUNDWIRE is not set

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
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
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
CONFIG_BMA180=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=y
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_DLN2_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HX711 is not set
CONFIG_LP8788_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
# CONFIG_LTC2497 is not set
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STX104=y
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_AM335X_ADC is not set
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=y
# CONFIG_VF610_ADC is not set
# CONFIG_VIPERBOARD_ADC is not set

#
# Amplifiers
#

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=y
CONFIG_IIO_CROS_EC_SENSORS_CORE=y
# CONFIG_IIO_CROS_EC_SENSORS is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
CONFIG_104_QUAD_8=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_CIO_DAC is not set
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
# CONFIG_M62332 is not set
CONFIG_MAX517=y
CONFIG_MAX5821=y
# CONFIG_MCP4725 is not set
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

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
# CONFIG_SI7020 is not set

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
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=y
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Multiplexers
#
CONFIG_IIO_MUX=y

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MCP4018=y
# CONFIG_MCP4531 is not set
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
CONFIG_IIO_CROS_EC_BARO=y
CONFIG_HP03=y
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
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
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y

#
# Temperature sensors
#
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_QCOM_USB_HS=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_TUSB1210=y
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# CONFIG_DAX is not set
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
# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
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
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
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
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_UBIFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_SWAP=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_FLEXFILE_LAYOUT=y
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFS_FSCACHE=y
CONFIG_NFS_USE_LEGACY_DNS=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_FLEXFILELAYOUT=y
# CONFIG_NFSD_V4_SECURITY_LABEL is not set
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=y
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
# CONFIG_CIFS_POSIX is not set
# CONFIG_CIFS_ACL is not set
# CONFIG_CIFS_DEBUG is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
CONFIG_CIFS_FSCACHE=y
CONFIG_CODA_FS=y
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FSCACHE=y
# CONFIG_9P_FS_POSIX_ACL is not set
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
# CONFIG_DLM_DEBUG is not set

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
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
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
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_NULL=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SELINUX is not set
CONFIG_SECURITY_SMACK=y
# CONFIG_SECURITY_SMACK_BRINGUP is not set
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_SMACK=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="smack"
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
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

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
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SHA1_MB is not set
CONFIG_CRYPTO_SHA256_MB=y
# CONFIG_CRYPTO_SHA512_MB is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
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
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SPECK is not set
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
# CONFIG_CRYPTO_LZO is not set
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
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

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
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_RADIX_TREE_MULTIORDER=y
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
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STRING_SELFTEST=y

--wru5vry3cjtl6h2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export runtime=300
	export job_origin='/lkp/lkp/src/allot/rand/vm-ivb41-yocto-ia32/trinity.yaml'
	export testbox='vm-ivb41-yocto-ia32-18'
	export tbox_group='vm-ivb41-yocto-ia32'
	export kconfig='x86_64-randconfig-s4-04251005'
	export compiler='gcc-7'
	export queue='rand'
	export branch='linus/master'
	export commit='6d08b06e67cd117f6992c46611dfb4ce267cd71e'
	export submit_id='5adfebb10b9a93191136d1ef'
	export job_file='/lkp/scheduled/vm-ivb41-yocto-ia32-18/trinity-300s-yocto-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-20180425-6417-i7ogw5-0.yaml'
	export id='053a57363bceef5dd090edb7395354e4752406f5'
	export model='qemu-system-x86_64 -enable-kvm -cpu IvyBridge'
	export nr_vm=32
	export nr_cpu=1
	export memory='420M'
	export rootfs='yocto-tiny-i386-2016-04-22.cgz'
	export swap_partitions='/dev/vda'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export enqueue_time='2018-04-25 10:45:05 +0800'
	export _id='5adfebb10b9a93191136d1ef'
	export _rt='/result/trinity/300s/vm-ivb41-yocto-ia32/yocto-tiny-i386-2016-04-22.cgz/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e'
	export user='lkp'
	export kernel='/pkg/linux/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2'
	export result_root='/result/trinity/300s/vm-ivb41-yocto-ia32/yocto-tiny-i386-2016-04-22.cgz/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/2'
	export dequeue_time='2018-04-25 11:02:38 +0800'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/yocto/yocto-tiny-i386-2016-04-22.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/scheduled/vm-ivb41-yocto-ia32-18/trinity-300s-yocto-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-20180425-6417-i7ogw5-0.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-s4-04251005
branch=linus/master
commit=6d08b06e67cd117f6992c46611dfb4ce267cd71e
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2
max_uptime=1500
RESULT_ROOT=/result/trinity/300s/vm-ivb41-yocto-ia32/yocto-tiny-i386-2016-04-22.cgz/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/2
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
	export bm_initrd='/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig.i386_2016-09-03.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-i386-x86_64-6ddabfd2_2017-11-10.cgz'
	export lkp_initrd='/lkp/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/scheduled/vm-ivb41-yocto-ia32-18/trinity-300s-yocto-tiny-i386-2016-04-22.cgz-6d08b06e67cd117f6992c46611dfb4ce267cd71e-20180425-6417-i7ogw5-0.cgz'

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

--wru5vry3cjtl6h2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-vm-ivb41-yocto-ia32-18:20180425110746:x86_64-randconfig-s4-04251005:4.17.0-rc2:145"

#!/bin/bash

# To reproduce,
# 1) save job-script and this script (both are attached in 0day report email)
# 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH

kernel=$1

initrds=(
	/osimage/yocto/yocto-tiny-i386-2016-04-22.cgz
	/lkp/lkp/lkp-i386.cgz
	/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig.i386_2016-09-03.cgz
	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-i386-x86_64-6ddabfd2_2017-11-10.cgz
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

qemu-img create -f qcow2 disk-vm-ivb41-yocto-ia32-18-0 256G

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu IvyBridge
	-kernel $kernel
	-initrd initrd.img
	-m 420
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-drive file=disk-vm-ivb41-yocto-ia32-18-0,media=disk,if=virtio
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-ivb41-yocto-ia32-18::dhcp
	root=/dev/ram0
	user=lkp
	job=/job-script
	ARCH=x86_64
	kconfig=x86_64-randconfig-s4-04251005
	branch=linus/master
	commit=6d08b06e67cd117f6992c46611dfb4ce267cd71e
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/vmlinuz-4.17.0-rc2
	max_uptime=1500
	RESULT_ROOT=/result/trinity/300s/vm-ivb41-yocto-ia32/yocto-tiny-i386-2016-04-22.cgz/x86_64-randconfig-s4-04251005/gcc-7/6d08b06e67cd117f6992c46611dfb4ce267cd71e/2
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
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--wru5vry3cjtl6h2j--
