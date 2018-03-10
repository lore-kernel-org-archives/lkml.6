Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeCJMmj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 07:42:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:40375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeCJMmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 07:42:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,451,1515484800";
   d="gz'50?scan'50,208,50";a="23398824"
Date: Sat, 10 Mar 2018 20:42:00 +0800
From: kernel test robot <fengguang.wu@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKP <lkp@01.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wfg@linux.intel.com
Subject: ea1b3dde97 ("Merge branch 'locking/core'"):  BUG: KASAN:
 use-after-scope in console_unlock
Message-ID: <5aa3d298.I8TDuf5eNCFe8oh5%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8"
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

commit ea1b3dde972c3dd4f51060c297c66e4c08919e8c
Merge: 65cce31629b3d bd5c0ba2cd78a
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sat Mar 10 10:22:28 2018 +0100
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Sat Mar 10 10:22:28 2018 +0100

    Merge branch 'locking/core'

65cce31629  Merge branch 'timers/core'
bd5c0ba2cd  tools/memory-model: Finish the removal of rb-dep, smp_read_barrier_depends(), and lockless_dereference()
ea1b3dde97  Merge branch 'locking/core'
+------------------------------------------------------------------+------------+------------+------------+
|                                                                  | 65cce31629 | bd5c0ba2cd | ea1b3dde97 |
+------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                   | 41         | 4          | 0          |
| boot_failures                                                    | 0          | 14         | 21         |
| invoked_oom-killer:gfp_mask=0x                                   | 0          | 9          |            |
| Mem-Info                                                         | 0          | 13         |            |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 0          | 7          |            |
| Out_of_memory:Kill_process                                       | 0          | 5          |            |
| BUG:KASAN:use-after-scope_in_c                                   | 0          | 0          | 21         |
+------------------------------------------------------------------+------------+------------+------------+

[    0.000000] Memory: 361580K/523712K available (16396K kernel code, 4349K rwdata, 5812K rodata, 1264K init, 23100K bss, 162132K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.001000] Running RCU self tests
[    0.001000] NR_IRQS: 4352, nr_irqs: 48, preallocated irqs: 16
[    0.001000] ==================================================================
[    0.001000] BUG: KASAN: use-after-scope in console_unlock+0x470/0x734
[    0.001000] Write of size 1 at addr ffffffff82807970 by task swapper/0
[    0.001000] 
[    0.001000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.16.0-rc4-00677-gea1b3dde #65
[    0.001000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    0.001000] Call Trace:
[    0.001000]  ? print_address_description+0x50/0x21d
[    0.001000]  ? console_unlock+0x470/0x734
[    0.001000]  ? kasan_report+0x226/0x24c
[    0.001000]  ? console_unlock+0x470/0x734
[    0.001000]  ? wake_up_klogd+0xcf/0xcf
[    0.001000]  ? lock_acquire+0x9d/0xd8
[    0.001000]  ? vprintk_emit+0x565/0x819
[    0.001000]  ? lock_acquire+0xa9/0xd8
[    0.001000]  ? vprintk_emit+0x565/0x819
[    0.001000]  ? arch_local_irq_restore+0x7/0x8
[    0.001000]  ? __down_trylock_console_sem+0x8b/0x9f
[    0.001000]  ? vprintk_emit+0x7d7/0x819
[    0.001000]  ? console_unlock+0x734/0x734
[    0.001000]  ? memblock_add_range+0x32f/0x340
[    0.001000]  ? memblock_reserve+0xbb/0xe1
[    0.001000]  ? memblock_add+0xe1/0xe1
[    0.001000]  ? memblock_reserve+0xbb/0xe1
[    0.001000]  ? memset+0x1f/0x31
[    0.001000]  ? vprintk_func+0x8a/0x9b
[    0.001000]  ? printk+0xb0/0xcc
[    0.001000]  ? show_regs_print_info+0x14/0x14
[    0.001000]  ? native_flush_tlb_global+0x47/0x73
[    0.001000]  ? kasan_init+0x22b/0x276
[    0.001000]  ? setup_arch+0x1025/0x1199
[    0.001000]  ? reserve_standard_io_resources+0x34/0x34
[    0.001000]  ? css_set_populated+0x77/0x77
[    0.001000]  ? INIT_LIST_HEAD+0xb0/0xb0
[    0.001000]  ? vprintk_func+0x93/0x9b
[    0.001000]  ? printk+0xb0/0xcc
[    0.001000]  ? show_regs_print_info+0x14/0x14
[    0.001000]  ? start_kernel+0xb4/0x59e
[    0.001000]  ? mem_encrypt_init+0x5/0x5
[    0.001000]  ? memcpy_orig+0x16/0x110
[    0.001000]  ? secondary_startup_64+0xa5/0xb0
[    0.001000] 
[    0.001000] Memory state around the buggy address:
[    0.001000]  ffffffff82807800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.001000]  ffffffff82807880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.001000] >ffffffff82807900: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f8 f2

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start ea1b3dde972c3dd4f51060c297c66e4c08919e8c 661e50bc853209e41a5c14a290ca4decc43cbfd1 --
git bisect good 253d8bb3a3c4a009cead7b53c749ba2c86f422cb  # 18:38  G     12     0    1   1  Merge branch 'perf/core'
git bisect good 3d7c4fa6842d3b1ca777d2c9f52120adea3a4d64  # 18:52  G     16     0    1   1  Merge branch 'perf/core'
git bisect good 1f739db70244a91002a4f49274e5c96643fb0f10  # 19:05  G     13     0    8  13  Merge branch 'x86/pti'
git bisect good ef4a975beadee1207c1a3c5167ada5c4b6fb2553  # 19:19  G     12     0    3   3  Merge branch 'timers/urgent'
git bisect good 9dcf3577913e121599893d5d1295c83cd51de7e4  # 19:24  G     10     0    0   0  Merge branch 'linus'
git bisect good 65cce31629b3dffaee37658efc785972d7ac0589  # 20:09  G     19     0    5   7  Merge branch 'timers/core'
git bisect good d095c12c53c7b941ad4ea96dc229a08296b37d2e  # 20:25  G     11     0    4   4  tools/memory-model: Remove mention of docker/gentoo image
git bisect good bd5c0ba2cd78a4c116726ead84f8f37dc92d043e  # 20:28  G     11     0   11  18  tools/memory-model: Finish the removal of rb-dep, smp_read_barrier_depends(), and lockless_dereference()
# first bad commit: [ea1b3dde972c3dd4f51060c297c66e4c08919e8c] Merge branch 'locking/core'
git bisect good 65cce31629b3dffaee37658efc785972d7ac0589  # 20:31  G     31     0    2   9  Merge branch 'timers/core'
git bisect good bd5c0ba2cd78a4c116726ead84f8f37dc92d043e  # 20:39  G     33     0   32  50  tools/memory-model: Finish the removal of rb-dep, smp_read_barrier_depends(), and lockless_dereference()
# extra tests on HEAD of tip/master
git bisect  bad ea1b3dde972c3dd4f51060c297c66e4c08919e8c  # 20:39  B      0    21   40   0  Merge branch 'locking/core'
# extra tests on tree/branch tip/master
git bisect  bad ea1b3dde972c3dd4f51060c297c66e4c08919e8c  # 20:40  B      0    21   40   0  Merge branch 'locking/core'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-vp-46:20180310181339:x86_64-randconfig-i0-201809:4.16.0-rc4-00677-gea1b3dde:65.gz"

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
BRSTsALBbwAA

--=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-intel12-14:20180310200850:x86_64-randconfig-i0-201809:4.16.0-rc4-00671-g65cce31:74.gz"

H4sICEzSo1oAA2RtZXNnLXlvY3RvLWludGVsMTItMTQ6MjAxODAzMTAyMDA4NTA6eDg2XzY0
LXJhbmRjb25maWctaTAtMjAxODA5OjQuMTYuMC1yYzQtMDA2NzEtZzY1Y2NlMzE6NzQA7Fxb
c+JIsn4+/StyY17sHYNVuoE4wcbBGHcTNm3GuGfm7EQHIaQSaK0Lowu2J+bHb2YVYIwQRm56
nkYdbd0qv8rKqszKLGXB7SR4BieO0jjg4EeQ8iyf4wOXf+Db7/hTlthONn7gScSDD340z7Ox
a2d2C5QnZXXojqGqE335OuDRq7eKZU80tfkhzjN8/eoVk6flqwKlpjp2U1M+yNrHWZzZwTj1
/+CvazcZJ5APl9yJw3nC09SPpnDjR/lTvV6HoZ2IB72bK7p144jXP1zEcUYPsxkHCV//8Bvg
odQl6lcJAAuO1HEEep2ZdaWWOHpNUcwGq01Nw3G4xuDkYZL7gft/wcO85k8U7RROpo6zJmzU
tboCJ5d84tvLuxo7PYUfGjoM73q9wfAeRnYGAzsBpoCqtBS9xZrQHd3jDWtus9WNw9COXAj8
COWQYDva5y5fnCd2qMAsj6bjzE4fxnM78p02A5dP8inYc7yRl+lzmvw+toNH+zkd88ieBNyF
xMnn2K28jhdjZ56PUxQ1StwPOfZNG/sJIp7VfS+yQ562FZgnfpQ91LHihzCdtrGdssIagzT2
siB2HvL5moko9MePdubM3HjaFg8hjufp8jKIbXeM7Lt++tBWERp7MVs/UMBNJm499KM4GTtx
HmXtJjUi46FbD+IpjpoFD9o8ScCfYhk+xofi2Wogt7PsWQExtiXb9GCknDFmqNiwjVIvDxdT
u41goR1A8kiyfmify36uZTzN0vMkj2q/5zzn5w+L8PypaY5NvZZgxyCc509rvlKj3lOs88yf
t0Ib+U1ayyFjqtZEcz3P5lxrmEaTe06jaVgN1W3YjmI0rdbET7mT1QIagjVmntcXIV3/UTsU
QVauMQUb02B6rdF6jp0srmHzecDUGtNhgtw6szaydy7Zg4vb2/txf9D52Gufzx+m56L6vW3D
gV5rnB/K1PmqFeXKtKOvaWzyxKunszxz48eorWyrBHJ47s3zFl404Gr4BR79IIA85XD166jz
c2+7PG+ilsFF/3ZUw8G28F3UgPnsOfUd7O67zgBCe97aJhLFJeVvIQ9fWTh51F49sryJ531F
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
9fD0/R0+5P/+89WHm+9uH15evCKr1N3jde+zp7ibHt5e3N5df3zJn7//cHNxffV491xGMAYo
ruY933Cyrny+MB5/8ebu9tWVHP3Fq/vnP/Bj/dVDTkt9cktzckt7ckt3ckt/cktaaskD4BV4
+IfbytGrx3evrz7x4vstfrM3DzzKHt5fYAX+5OdPnuC9+/YWI/09j4rnz3gMPXt/9YbHzncf
37588YGXYjybf/vq5jmPv3o0XL3jP+v/5lvj/Z94Bffnq0+PL6r74pZ93VRLrEv+jxd8g+CB
yS9jjBteGD7n4fvkKx6hl6/useh+fM5/vuPx/+H7Sz7/928eXz5/eMsfyXmf8okfH+4/4Dn8
8V13MW/fvHrRDNfn8umTrx4e3j02//364eqWF7Zv0EHPDU7w8Obdh/YTPuXt++vbS34rPbx/
ccOP7A/Po3wfvtVvL18/vHzx+u6Hu9fP796/f/LVq5dvQSf4U/nwyVc3D295FnP3/MOHT+zp
7ur960/VN8An/6Z+obU3+JY9u96nP7y8es4O31yxp/d/fvLV9furtzffPf/w6t0zXvx+uOMz
/vrbb3//4p+++dU/fv382bvvXz57/ertx788q54OT9n8lj3fv3r59JV6ahRPmtOzlzc3T8Oz
mnSQSdf29v7+6u7OBvLx7v4mRJ+CuQ1XNzwBTM9+eAOX//F0EZbMdxB+2rv395eP3338cPvw
57fckTyM/u7v/zc/Df/9v/3x//7dxdNqTF3wZ9V//fs/8MdP/h8XU47IxaUCAA==

--=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-ivb41-23:20180310180811:x86_64-randconfig-i0-201809:4.16.0-rc4-00302-gbd5c0ba:64.gz"

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

--=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-vp-46:20180310181339:x86_64-randconfig-i0-201809:4.16.0-rc4-00677-gea1b3dde:65"

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

--=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.16.0-rc4-00677-gea1b3dde"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.16.0-rc4 Kernel Configuration
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
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
# CONFIG_TASKS_RCU is not set
# CONFIG_RCU_STALL_COMMON is not set
# CONFIG_RCU_NEED_SEGCBLIST is not set
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
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
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_OPTPROBES=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_GCC_PLUGIN_SANCOV=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_THIN_ARCHIVES=y
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
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
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
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_CALGARY_IOMMU=y
# CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
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
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=m
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_PROCFS_POWER=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=m
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
# CONFIG_TPS68470_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
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
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
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
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=m
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=m
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=m
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
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
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
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
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_MRP=m
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=m
CONFIG_LLC2=m
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=y
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_GRED=m
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=y
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_FQ is not set
CONFIG_NET_SCH_HHF=m
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ_CODEL is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
# CONFIG_NET_CLS_RSVP is not set
CONFIG_NET_CLS_RSVP6=y
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=y
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=m
# CONFIG_NET_CLS_ACT is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUGFS=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
CONFIG_NET_NSH=m
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_VXCAN=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_LEDS=y
CONFIG_CAN_JANZ_ICAN3=m
# CONFIG_CAN_C_CAN is not set
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
CONFIG_CAN_IFI_CANFD=m
# CONFIG_CAN_M_CAN is not set
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
# CONFIG_CAN_PEAK_PCIEC is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
# CONFIG_BT_RFCOMM_TTY is not set
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=y
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
CONFIG_BT_SELFTEST=y
# CONFIG_BT_SELFTEST_ECDH is not set
CONFIG_BT_SELFTEST_SMP=y
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_QCA=m
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_QCA=y
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIVHCI=m
# CONFIG_BT_MRVL is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_WIRELESS is not set
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=m
# CONFIG_NET_9P_VIRTIO is not set
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
# CONFIG_NFC_DIGITAL is not set
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN544_MEI=m
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_I2C=m
# CONFIG_NFC_MICROREAD_MEI is not set
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
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
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=m
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_VIRTIO_BLK_SCSI=y
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=m
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=m

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=m

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
CONFIG_VOP=m
CONFIG_VHOST_RING=m
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_HAVE_IDE=y
CONFIG_IDE=m

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=m
CONFIG_IDE_GD_ATA=y
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEACPI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_PLATFORM=m
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=m
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=m
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=m
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_JMICRON=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_IT8172=m
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=m
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_TC86C001=m
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
CONFIG_SCSI_BNX2_ISCSI=m
# CONFIG_SCSI_BNX2X_FCOE is not set
CONFIG_BE2ISCSI=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=m
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=m
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_FLASHPOINT=y
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
# CONFIG_FCOE is not set
CONFIG_FCOE_FNIC=m
CONFIG_SCSI_SNIC=m
CONFIG_SCSI_SNIC_DEBUG_FS=y
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
CONFIG_SCSI_DC395x=m
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
CONFIG_SBP_TARGET=m
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
CONFIG_EQUALIZER=m
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=m
# CONFIG_MACVTAP is not set
# CONFIG_VXLAN is not set
CONFIG_MACSEC=m
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
CONFIG_NTB_NETDEV=m
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
# CONFIG_ARCNET_1051 is not set
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
# CONFIG_ARCNET_COM90xxIO is not set
CONFIG_ARCNET_RIM_I=m
# CONFIG_ARCNET_COM20020 is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
CONFIG_ATM_LANAI=m
# CONFIG_ATM_ENI is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
CONFIG_ATM_ZATM_DEBUG=y
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_IDT77252=m
CONFIG_ATM_IDT77252_DEBUG=y
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E=m
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
# CONFIG_ATM_HE is not set
CONFIG_ATM_SOLOS=m

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
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=y
CONFIG_NET_CADENCE=y
CONFIG_MACB=m
# CONFIG_MACB_USE_HWSTAMP is not set
CONFIG_MACB_PCI=m
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_BNX2X=m
# CONFIG_BNX2X_SRIOV is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_CX_ECAT=m
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
# CONFIG_SUNDANCE is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
CONFIG_ENCX24J600=m
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=y
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
# CONFIG_8139TOO is not set
CONFIG_R8169=m
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=m
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=m
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
CONFIG_SFC_FALCON=y
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_FDDI=y
CONFIG_DEFXX=y
# CONFIG_DEFXX_MMIO is not set
CONFIG_SKFP=y
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
CONFIG_AQUANTIA_PHY=y
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83822_PHY=m
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=m
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=y
CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_MPPE is not set
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=m
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
CONFIG_WAN=y
# CONFIG_HDLC is not set
CONFIG_DLCI=y
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
# CONFIG_VMXNET3 is not set
CONFIG_FUJITSU_ES=y
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
CONFIG_NVM_DEBUG=y
# CONFIG_NVM_PBLK is not set

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
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
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
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=y
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK is not set
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_NOZOMI is not set
CONFIG_ISI=m
# CONFIG_N_HDLC is not set
CONFIG_N_GSM=y
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=m
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=m
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_DEV_BUS=m
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_NVRAM=y
CONFIG_R3964=y
CONFIG_APPLICOM=m
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=m

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_CHT_WC=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
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
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=y
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=m
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
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

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
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EXAR=m
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VX855=m

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=m

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_TWL6040=m
# CONFIG_GPIO_WM8350 is not set

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=m
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=y
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=m
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=m
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=m
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM8350=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CLOCK_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_X86_PKG_TEMP_THERMAL is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_WDAT_WDT=y
CONFIG_WM8350_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=y
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=m
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
CONFIG_KEMPLD_WDT=m
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=m
CONFIG_MEN_A21_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS68470=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=m
CONFIG_DVB_CORE=m
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_SMS_SIANO_MDTV=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=m
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=m
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9M111=m

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
# CONFIG_MEDIA_TUNER_TDA18250 is not set
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
# CONFIG_MEDIA_TUNER_TEA5761 is not set
# CONFIG_MEDIA_TUNER_TEA5767 is not set
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_TDA18218=m
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
# CONFIG_MEDIA_TUNER_SI2157 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
# CONFIG_DVB_STV090x is not set
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
# CONFIG_DVB_TDA10086 is not set
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
# CONFIG_DVB_TUNER_ITD1000 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
# CONFIG_DVB_CX24120 is not set
# CONFIG_DVB_SI21XX is not set
# CONFIG_DVB_TS2020 is not set
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_CX22700=m
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_AS102_FE is not set
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
# CONFIG_DVB_OR51132 is not set
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
# CONFIG_DVB_LGDT3305 is not set
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LG2160=m
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_SP2=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

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
# CONFIG_CHASH is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=m
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=m
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_AUO_K190X=m
CONFIG_FB_AUO_K1900=m
CONFIG_FB_AUO_K1901=m
CONFIG_FB_SM712=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_S6E63M0=m
CONFIG_LCD_LD9040=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
# CONFIG_LCD_HX8357 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_APPLE=m
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_VGASTATE=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# CONFIG_LOGO is not set
CONFIG_SOUND=m
# CONFIG_SOUND_OSS_CORE is not set
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
CONFIG_I2C_HID=y

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
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
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_GOLDFISH=m
CONFIG_MMC_SPI=y
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_PCI=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM8350=m
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_ACCESSIBILITY=y
# CONFIG_A11Y_BRAILLE_CONSOLE is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_E752X is not set
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_HWMON is not set
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_LP8788=m
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=m
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX8997=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=m
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=y
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RX6110=y
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=y
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=m
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9055=m
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=m
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=m

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780=m
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_IRDA is not set
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
# CONFIG_NCP_FS is not set
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
CONFIG_COMEDI_SERIAL2002=m
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
# CONFIG_COMEDI_PCL818 is not set
CONFIG_COMEDI_PCM3724=m
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=m
CONFIG_COMEDI_RTI802=m
CONFIG_COMEDI_DAC02=m
CONFIG_COMEDI_DAS16M1=m
CONFIG_COMEDI_DAS08_ISA=m
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
# CONFIG_COMEDI_DT2814 is not set
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
CONFIG_COMEDI_FL512=m
# CONFIG_COMEDI_AIO_AIO12_8 is not set
# CONFIG_COMEDI_AIO_IIRO_16 is not set
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=m
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
# CONFIG_COMEDI_NI_ATMIO is not set
# CONFIG_COMEDI_NI_ATMIO16D is not set
# CONFIG_COMEDI_NI_LABPC_ISA is not set
# CONFIG_COMEDI_PCMAD is not set
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
# CONFIG_COMEDI_PCMUIO is not set
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_RTS5208=m

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16203=m
CONFIG_ADIS16209=m
CONFIG_ADIS16240=m

#
# Analog to digital converters
#
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7780=m
CONFIG_AD7816=m
CONFIG_AD7192=m
CONFIG_AD7280=m

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
# CONFIG_ADT7316_I2C is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7152 is not set
CONFIG_AD7746=m

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16060=m

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Light sensors
#
CONFIG_TSL2x7x=m

#
# Active energy metering IC
#
CONFIG_ADE7753=m
# CONFIG_ADE7754 is not set
# CONFIG_ADE7758 is not set
# CONFIG_ADE7759 is not set
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1200=m
CONFIG_AD2S1210=m

#
# Triggers - standalone
#
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
CONFIG_STAGING_MEDIA=y
CONFIG_DVB_CXD2099=m

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ION is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
CONFIG_CRYPTO_SKEIN=m
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORNIC=m
# CONFIG_UNISYS_VISORINPUT is not set
CONFIG_UNISYS_VISORHBA=m
# CONFIG_FB_TFT is not set
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
# CONFIG_MOST_VIDEO is not set
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
CONFIG_GREYBUS=m
CONFIG_GREYBUS_AUDIO=m
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_PI433=m
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
CONFIG_ACER_WIRELESS=y
CONFIG_ACERHDF=m
CONFIG_ALIENWARE_WMI=y
CONFIG_ASUS_LAPTOP=m
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=m
CONFIG_DELL_LAPTOP=y
# CONFIG_DELL_WMI is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=y
CONFIG_DELL_WMI_LED=y
CONFIG_DELL_SMO8800=m
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_TABLET is not set
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=y
# CONFIG_HP_WMI is not set
CONFIG_PANASONIC_LAPTOP=y
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
# CONFIG_THINKPAD_ACPI_VIDEO is not set
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
# CONFIG_SENSORS_HDAPS is not set
CONFIG_ASUS_WIRELESS=y
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_MSI_WMI is not set
CONFIG_PEAQ_WMI=y
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=m
CONFIG_ACPI_CMPC=y
CONFIG_INTEL_INT0002_VGPIO=m
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_IBM_RTL=m
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_MXM_WMI=m
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_APPLE_GMUX=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
CONFIG_SURFACE_PRO3_BUTTON=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=m
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_BUS=y
CONFIG_SOUNDWIRE_CADENCE=y
CONFIG_SOUNDWIRE_INTEL=y

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
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=m
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
# CONFIG_EXTCON is not set
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL345_SPI=m
CONFIG_BMA180=m
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=m
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7266=m
# CONFIG_AD7291 is not set
CONFIG_AD7298=m
# CONFIG_AD7476 is not set
CONFIG_AD7766=m
CONFIG_AD7791=m
CONFIG_AD7793=m
CONFIG_AD7887=m
CONFIG_AD7923=m
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
CONFIG_DA9150_GPADC=m
CONFIG_HI8435=m
CONFIG_HX711=m
# CONFIG_INA2XX_ADC is not set
# CONFIG_LP8788_ADC is not set
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=m
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=m
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
CONFIG_MCP3422=m
CONFIG_NAU7802=m
CONFIG_QCOM_SPMI_IADC=m
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
# CONFIG_VZ89X is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=m
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686 is not set
CONFIG_AD5755=m
CONFIG_AD5761=m
CONFIG_AD5764=m
CONFIG_AD5791=m
# CONFIG_AD7303 is not set
CONFIG_AD8801=m
# CONFIG_DS4424 is not set
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MCP4725=m
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16480=m
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
# CONFIG_MAX44000 is not set
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1145=m
CONFIG_STK3310=m
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m

#
# Multiplexers
#

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_DS1803=m
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
CONFIG_MCP4131=m
CONFIG_MCP4531=m
CONFIG_TPL0102=m

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=m
# CONFIG_BMP280 is not set
# CONFIG_HID_SENSOR_PRESS is not set
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
# CONFIG_MS5611_I2C is not set
CONFIG_MS5611_SPI=m
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m

#
# Lightning sensors
#
CONFIG_AS3935=m

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=m
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
CONFIG_NTB=m
CONFIG_NTB_AMD=m
CONFIG_NTB_IDT=m
CONFIG_NTB_INTEL=m
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=m
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=m
CONFIG_VME_TSI148=m
CONFIG_VME_FAKE=m

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=m

#
# VME Device Drivers
#
CONFIG_VME_USER=m
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=m
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=m
CONFIG_FMC_WRITE_EEPROM=m
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=m

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
CONFIG_ND_BLK=y
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_DAX=y
CONFIG_NVMEM=y
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_FSI is not set
CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=m
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_RUNTIME_MAP is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=m
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
CONFIG_UEFI_CPER=y
CONFIG_EFI_DEV_PATH_PARSER=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
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
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
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
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
CONFIG_KASAN_EXTRA=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_TEST_KASAN=m
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
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
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_LIST_SORT=m
# CONFIG_TEST_SORT is not set
CONFIG_KPROBES_SANITY_TEST=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=m
# CONFIG_TEST_LKM is not set
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
CONFIG_FIND_BIT_BENCHMARK=m
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
CONFIG_TEST_UDELAY=y
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_EFI_PGT_DUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
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
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=m
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=m
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SHA1_MB is not set
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_X86_64=m
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
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
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=m
CONFIG_VHOST=m
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

--=_5aa3d298.LZXQuBbBD+5Rjns/qxaly3u4yk2/Lken0OlbZnlBwEY66YN8--
