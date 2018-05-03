Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeECPxj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:53:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:56064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbeECPxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:53:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="gz'50?scan'50,208,50";a="48044235"
Date: Thu, 03 May 2018 23:52:31 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, wfg@linux.intel.com
Subject: 85f1abe001 ("kthread, sched/wait: Fix kthread_parkme() .."):
  WARNING: CPU: 0 PID: 1 at kernel/kthread.c:486 kthread_park
Message-ID: <5aeb303f.ZSZnAoV6lBIOMHs0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5aeb303f.elQMsCBOA+ZwIjjyOsaMOqcaJIiBw+BKDJtF5tVWXW6n9MYA"
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5aeb303f.elQMsCBOA+ZwIjjyOsaMOqcaJIiBw+BKDJtF5tVWXW6n9MYA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent

commit 85f1abe0019fcb3ea10df7029056cf42702283a8
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue May 1 18:14:45 2018 +0200
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Thu May 3 07:38:05 2018 +0200

    kthread, sched/wait: Fix kthread_parkme() completion issue
    
    Even with the wait-loop fixed, there is a further issue with
    kthread_parkme(). Upon hotplug, when we do takedown_cpu(),
    smpboot_park_threads() can return before all those threads are in fact
    blocked, due to the placement of the complete() in __kthread_parkme().
    
    When that happens, sched_cpu_dying() -> migrate_tasks() can end up
    migrating such a still runnable task onto another CPU.
    
    Normally the task will have hit schedule() and gone to sleep by the
    time we do kthread_unpark(), which will then do __kthread_bind() to
    re-bind the task to the correct CPU.
    
    However, when we loose the initial TASK_PARKED store to the concurrent
    wakeup issue described previously, do the complete(), get migrated, it
    is possible to either:
    
     - observe kthread_unpark()'s clearing of SHOULD_PARK and terminate
       the park and set TASK_RUNNING, or
    
     - __kthread_bind()'s wait_task_inactive() to observe the competing
       TASK_RUNNING store.
    
    Either way the WARN() in __kthread_bind() will trigger and fail to
    correctly set the CPU affinity.
    
    Fix this by only issuing the complete() when the kthread has scheduled
    out. This does away with all the icky 'still running' nonsense.
    
    The alternative is to promote TASK_PARKED to a special state, this
    guarantees wait_task_inactive() cannot observe a 'stale' TASK_RUNNING
    and we'll end up doing the right thing, but this preserves the whole
    icky business of potentially migating the still runnable thing.
    
    Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Oleg Nesterov <oleg@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

741a76b350  kthread, sched/wait: Fix kthread_parkme() wait-loop
85f1abe001  kthread, sched/wait: Fix kthread_parkme() completion issue
12bc056bd1  Merge branch 'sched/urgent'
+-------------------------------------------+------------+------------+------------+
|                                           | 741a76b350 | 85f1abe001 | 12bc056bd1 |
+-------------------------------------------+------------+------------+------------+
| boot_successes                            | 44         | 0          | 0          |
| boot_failures                             | 0          | 26         | 22         |
| WARNING:at_kernel/kthread.c:#kthread_park | 0          | 26         | 22         |
| EIP:kthread_park                          | 0          | 26         | 22         |
+-------------------------------------------+------------+------------+------------+

[    0.011005] CPU: GenuineIntel Intel Core Processor (Haswell) (family: 0x6, model: 0x3c, stepping: 0x4)
[    0.012011] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    0.013949] Performance Events: no PMU driver, software events only.
[    0.019490] NMI watchdog: Perf event create on CPU 0 failed with -2
[    0.020005] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.020692] WARNING: CPU: 0 PID: 1 at kernel/kthread.c:486 kthread_park+0x2b/0x56
[    0.021000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc3-00038-g85f1abe #687
[    0.021000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    0.021000] EIP: kthread_park+0x2b/0x56
[    0.021000] EFLAGS: 00210202 CPU: 0
[    0.021000] EAX: cf464d40 EBX: cf422500 ECX: 00000000 EDX: 00000004
[    0.021000] ESI: c221e2c0 EDI: 00000000 EBP: cf42df68 ESP: cf42df60
[    0.021000]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[    0.021000] CR0: 80050033 CR2: ffffffff CR3: 022e8000 CR4: 00140690
[    0.021000] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.021000] DR6: fffe0ff0 DR7: 00000400
[    0.021000] Call Trace:
[    0.021000]  smpboot_update_cpumask_percpu_thread+0x28/0x42
[    0.021000]  softlockup_update_smpboot_threads+0x37/0x39
[    0.021000]  lockup_detector_reconfigure+0x17/0x62
[    0.021000]  lockup_detector_init+0x5d/0x69
[    0.021000]  kernel_init_freeable+0x52/0x15c
[    0.021000]  ? rest_init+0xf4/0xf4
[    0.021000]  kernel_init+0x8/0xd0
[    0.021000]  ret_from_fork+0x19/0x30
[    0.021000] Code: 55 89 e5 56 53 8b 50 14 0f ba e2 15 72 02 0f 0b 8b 98 44 03 00 00 80 e2 04 74 09 0f 0b be da ff ff ff eb 2c 8b 13 80 e2 04 74 09 <0f> 0b be f0 ff ff ff eb 1c 80 0b 04 8b 15 70 de f6 c1 31 f6 39 
[    0.021000] ---[ end trace 3a71adb42feecba7 ]---
[    0.021060] TSC deadline timer enabled

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start d17cc3a1a1091797eff4a671659c15f2dc667996 6d08b06e67cd117f6992c46611dfb4ce267cd71e --
git bisect good 99309e94100238f4e0d1d6bdc31f4034587d5fb9  # 19:13  G     11     0    0   1  Merge 'linux-review/Bj-rn-Mork/qmi_wwan-do-not-steal-interfaces-from-class-drivers/20180503-164137' into devel-catchup-201805031730
git bisect  bad 067517401c4ab83974fb63d7c4a98eb82791d15f  # 19:22  B      0     3   27  11  Merge 'tip/sched/urgent' into devel-catchup-201805031730
git bisect good 7ff5000268355c63dc948ecb01f4de17987586e5  # 19:35  G     11     0    0   1  Merge tag 'sound-4.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 0d95cfa922c24bcc20b5ccf7496b6ac7c8e29efb  # 20:44  G     11     0    0   0  Merge tag 'powerpc-4.17-4' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 65f4d6d0f80b3c55830ec5735194703fa2909ba1  # 20:58  G     11     0    0   1  Merge branch 'x86-pti-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 2d618bdf71635463a4aa4ad0fe46ec852292bc0c  # 21:00  G     10     0    0   0  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel
git bisect good ecd649b3408408841d5793038b0241e55ac7a141  # 21:09  G     11     0    0   0  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect good dcf234577cd31fa16874e828b90659166ad6b80d  # 21:20  G     11     0    0   0  tracing: Add field modifier parsing hist error for hist triggers
git bisect good 0b26351b910fb8fe6a056f8a1bbccabe50c0e19f  # 21:35  G     11     0    0   1  stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock
git bisect good 741a76b350897604c48fb12beff1c9b77724dc96  # 21:51  G     11     0    0   2  kthread, sched/wait: Fix kthread_parkme() wait-loop
git bisect  bad 85f1abe0019fcb3ea10df7029056cf42702283a8  # 22:03  B      0    11   35  11  kthread, sched/wait: Fix kthread_parkme() completion issue
# first bad commit: [85f1abe0019fcb3ea10df7029056cf42702283a8] kthread, sched/wait: Fix kthread_parkme() completion issue
git bisect good 741a76b350897604c48fb12beff1c9b77724dc96  # 22:06  G     31     0    0   2  kthread, sched/wait: Fix kthread_parkme() wait-loop
# extra tests with debug options
git bisect  bad 85f1abe0019fcb3ea10df7029056cf42702283a8  # 22:20  B      0     3   16   0  kthread, sched/wait: Fix kthread_parkme() completion issue
# extra tests on HEAD of linux-devel/devel-catchup-201805031730
git bisect  bad d17cc3a1a1091797eff4a671659c15f2dc667996  # 22:25  B      0    13   29   0  0day head guard for 'devel-catchup-201805031730'
# extra tests on tree/branch tip/sched/urgent
git bisect  bad 85f1abe0019fcb3ea10df7029056cf42702283a8  # 22:33  B      0    26   39   0  kthread, sched/wait: Fix kthread_parkme() completion issue
# extra tests with first bad commit reverted
git bisect good 8058ae7fe7b61a67f8a7da7013e4c3d7fa5c0ba8  # 23:39  G     11     0    0   1  Revert "kthread, sched/wait: Fix kthread_parkme() completion issue"
# extra tests on tree/branch tip/master
git bisect  bad 12bc056bd1170303f849954e8e566488acfc7202  # 23:51  B      0    11   35  11  Merge branch 'sched/urgent'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5aeb303f.elQMsCBOA+ZwIjjyOsaMOqcaJIiBw+BKDJtF5tVWXW6n9MYA
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-openwrt-lkp-hsw01-103:20180503220225:i386-randconfig-i1-201817:4.17.0-rc3-00038-g85f1abe:687.gz"

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
Nfnt+7/R5Z3/BVaUvOE95QAA

--=_5aeb303f.elQMsCBOA+ZwIjjyOsaMOqcaJIiBw+BKDJtF5tVWXW6n9MYA
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-ivb41-33:20180503215015:i386-randconfig-i1-201817:4.17.0-rc3-00037-g741a76b:686.gz"

H4sICCAw61oAA2RtZXNnLXlvY3RvLWl2YjQxLTMzOjIwMTgwNTAzMjE1MDE1OmkzODYtcmFu
ZGNvbmZpZy1pMS0yMDE4MTc6NC4xNy4wLXJjMy0wMDAzNy1nNzQxYTc2Yjo2ODYAvFxrU+O4
0v5+fkWf2g8D7+Jg2YlzeStbb4DMkIJAljCXc6amUo4tBy+OnfUFyNT8+LdbsnOzHRIms6aI
b9KjRy2p1a2LuRl6c7ACPwo8Dq4PEY+TGT6w+b8GYTB2/Ql0Ly7giNt2O3AciAOw3cgce/y4
UqlA8Pivr4CHWlHF8Q2uXT95gSceRm7gQ7XC6hVVCS1dwbd6XZnUq8ysG2M4ehwnrmf/n/s0
rurHcDSxrEWsekWvqHB0wceumd4pzDg+ht+MhgH3Dwn0zTnooLFWtd5iDTgf3oOmssYmmavu
3U33GqJkNgvCmNtgzZKotRkKoNO/gE4SP3A/di28yYe4GZ7DB45igfGcbvIhzueh+yJ/e34U
c9POh/nYP1/93wxwPvjYQiH4dhCOXBvefeB+4vq858fceweJ/+gHz/4JJBEVy4T7PHQtLDQ3
rhQi/SdIQojmyGUKUxTYmCNGFFPh5SK8NIxTZ5a0YChlRSl8GXY+dcHhZpyEHNQXVWUtePfS
qIPjBaYIMgtcP4aQT1xMJYzevQ1WQ9jhsPvTOFXE6Xz6sgvOC8oh5iOs0ljjv2rfWgC1unGS
PY/c7zySj7WaUYrS9UmYdhor4xIhmfoJtaqYv8RAWOBG0NA1rDwxj7ISfIexfNsM7XfgBOHU
zBcjb2hqC856t0NlFgZPro1pzR7mkWuZHtx1+liss1x1FsFlzK9TLHqSzPqhrD1qOmPH+Yac
KC97gTUdKw/mEBgKgYdPPNcEtsI5eW7O2+FYLquOYzPnTVnFmFoO7M3cHO6Q4Fbh6NGb4STa
Gtyr7Gw+TiYtcCd+EFJd9IKJx5+4Rx0Ata5cVbwJUDXyFtx8gaPuC7cSrO8XaU8AWDljbsWk
uy3T94OYdA2XjaMFfuArg04XHnnoc+/fm8jDPuUNtEoDcZCun28HF/1eC/7s9j/CMG0yMDiH
I7daVd9/gd9h0Ot9OQHWbBrHJ0JSwCpMrWgKA7V6qrJT7Byqm6CX8xmKxo2CEKVB9Inr1ad+
cSNMZjY18Q3ZZzJfqVbQbv9RKnaJFfJp8LSKZS6x0nIrrqIyumdG8Wjm+NDG2FQ1UQ28jMzQ
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

--=_5aeb303f.elQMsCBOA+ZwIjjyOsaMOqcaJIiBw+BKDJtF5tVWXW6n9MYA
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-openwrt-lkp-hsw01-103:20180503220225:i386-randconfig-i1-201817:4.17.0-rc3-00038-g85f1abe:687"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel $kernel
	-initrd $initrd
	-m 256
	-smp 1
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

--=_5aeb303f.elQMsCBOA+ZwIjjyOsaMOqcaJIiBw+BKDJtF5tVWXW6n9MYA
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.17.0-rc3-00038-g85f1abe"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.17.0-rc3 Kernel Configuration
#
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
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
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
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
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
CONFIG_SYSCTL_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
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
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_MEMCG_SYSFS_ON=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
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
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
CONFIG_KVM_DEBUG_FS=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
CONFIG_MWINCHIPC6=y
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
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
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
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
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

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

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOOLPC=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_OLPC=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCIE_CADENCE_EP is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
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
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
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
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_ATM=y
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=y
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=y
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_FQ=y
# CONFIG_NET_SCH_HHF is not set
CONFIG_NET_SCH_PIE=y
# CONFIG_NET_SCH_INGRESS is not set
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_CLS_U32_PERF=y
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=y
# CONFIG_NET_CLS_FLOWER is not set
CONFIG_NET_CLS_MATCHALL=y
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
# CONFIG_NET_ACT_GACT is not set
CONFIG_NET_ACT_MIRRED=y
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=y
# CONFIG_NET_ACT_CSUM is not set
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
CONFIG_NET_IFE_SKBMARK=y
# CONFIG_NET_IFE_SKBPRIO is not set
# CONFIG_NET_IFE_SKBTCINDEX is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
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
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
CONFIG_6PACK=y
CONFIG_BPQETHER=y
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=y
# CONFIG_YAM is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
CONFIG_CAN_GRCAN=y
CONFIG_PCH_CAN=y
CONFIG_CAN_C_CAN=y
CONFIG_CAN_C_CAN_PLATFORM=y
CONFIG_CAN_C_CAN_PCI=y
CONFIG_CAN_CC770=y
CONFIG_CAN_CC770_ISA=y
CONFIG_CAN_CC770_PLATFORM=y
CONFIG_CAN_IFI_CANFD=y
CONFIG_CAN_M_CAN=y
CONFIG_CAN_PEAK_PCIEFD=y
CONFIG_CAN_SJA1000=y
CONFIG_CAN_SJA1000_ISA=y
CONFIG_CAN_SJA1000_PLATFORM=y
CONFIG_CAN_EMS_PCMCIA=y
CONFIG_CAN_EMS_PCI=y
CONFIG_CAN_PEAK_PCMCIA=y
# CONFIG_CAN_PEAK_PCI is not set
CONFIG_CAN_KVASER_PCI=y
CONFIG_CAN_PLX_PCI=y
CONFIG_CAN_SOFTING=y
CONFIG_CAN_SOFTING_CS=y

#
# CAN USB interfaces
#
CONFIG_CAN_EMS_USB=y
CONFIG_CAN_ESD_USB2=y
CONFIG_CAN_GS_USB=y
CONFIG_CAN_KVASER_USB=y
CONFIG_CAN_PEAK_USB=y
CONFIG_CAN_8DEV_USB=y
CONFIG_CAN_MCBA_USB=y
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
# CONFIG_BT_BNEP is not set
CONFIG_BT_HIDP=y
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_RTL=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_H4=y
# CONFIG_BT_HCIUART_BCSP is not set
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_3WIRE=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_QCA is not set
CONFIG_BT_HCIUART_AG6XX=y
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=y
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIDTL1=y
# CONFIG_BT_HCIBT3C is not set
CONFIG_BT_HCIBLUECARD=y
# CONFIG_BT_HCIVHCI is not set
CONFIG_BT_MRVL=y
CONFIG_BT_ATH3K=y
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_CRDA_SUPPORT is not set
# CONFIG_CFG80211_WEXT is not set
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
# CONFIG_CAIF_USB is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
CONFIG_NFC_NCI=y
CONFIG_NFC_NCI_UART=y
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=y
CONFIG_NFC_SIM=y
CONFIG_NFC_PORT100=y
CONFIG_NFC_FDP=y
CONFIG_NFC_FDP_I2C=y
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_I2C=y
CONFIG_NFC_PN544_MEI=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_USB=y
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_MICROREAD=y
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_MICROREAD_MEI=y
CONFIG_NFC_MRVL=y
CONFIG_NFC_MRVL_USB=y
CONFIG_NFC_MRVL_UART=y
# CONFIG_NFC_MRVL_I2C is not set
CONFIG_NFC_ST21NFCA=y
CONFIG_NFC_ST21NFCA_I2C=y
# CONFIG_NFC_ST_NCI_I2C is not set
CONFIG_NFC_NXP_NCI=y
# CONFIG_NFC_NXP_NCI_I2C is not set
CONFIG_NFC_S3FWRN5=y
CONFIG_NFC_S3FWRN5_I2C=y
# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
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
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
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
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=y
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

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
# CONFIG_ECHO is not set
CONFIG_MISC_RTSX_PCI=y
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
# CONFIG_CAIF_SPI_SLAVE is not set
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
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
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
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
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
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
# CONFIG_PCMCIA_SMC91C92 is not set
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
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH6KL is not set
# CONFIG_WIL6210 is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
# CONFIG_AIRO_CS is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_MWIFIEX is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_WL3501 is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
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
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
CONFIG_MOUSE_PS2_TOUCHKIT=y
# CONFIG_MOUSE_PS2_OLPC is not set
# CONFIG_MOUSE_PS2_FOCALTECH is not set
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MAX77693_HAPTIC is not set
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=y
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_KXTJ9_POLLED_MODE=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_RK805_PWRKEY=y
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
CONFIG_INPUT_DA9052_ONKEY=y
CONFIG_INPUT_DA9055_ONKEY=y
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_IMS_PCU=y
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
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
CONFIG_RMI4_F34=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
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
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
CONFIG_SONYPI=y

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=y
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
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
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
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
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SLAVE is not set
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
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_PALMAS=y
CONFIG_PINCTRL_RK805=y
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
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_BD9571MWV is not set
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2760=y
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_MAX8925_POWER=y
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_BATTERY_ACT8945A is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_OLPC=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_BATTERY_RX51 is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX8997 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_MAX77620_THERMAL is not set
CONFIG_DA9062_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9052_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_MAX77620_WATCHDOG=y
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
CONFIG_KEMPLD_WDT=y
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_SC1200_WDT=y
CONFIG_SCx200_WDT=y
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
# CONFIG_RDC321X_WDT is not set
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8925=y
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX77686 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=y
# CONFIG_VIDEO_PVRUSB2_SYSFS is not set
CONFIG_VIDEO_PVRUSB2_DVB=y
CONFIG_VIDEO_HDPVR=y
# CONFIG_VIDEO_USBVISION is not set
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set

#
# Digital TV USB devices
#
CONFIG_DVB_USB_V2=y
# CONFIG_DVB_USB_AF9015 is not set
# CONFIG_DVB_USB_AF9035 is not set
CONFIG_DVB_USB_ANYSEE=y
CONFIG_DVB_USB_AU6610=y
CONFIG_DVB_USB_AZ6007=y
# CONFIG_DVB_USB_CE6230 is not set
CONFIG_DVB_USB_EC168=y
CONFIG_DVB_USB_GL861=y
# CONFIG_DVB_USB_MXL111SF is not set
CONFIG_DVB_USB_RTL28XXU=y
CONFIG_DVB_USB_DVBSKY=y
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=y
CONFIG_DVB_TTUSB_DEC=y
CONFIG_SMS_USB_DRV=y
CONFIG_DVB_B2C2_FLEXCOP_USB=y
CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=y
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
CONFIG_VIDEO_EM28XX_ALSA=y
CONFIG_VIDEO_EM28XX_DVB=y

#
# USB HDMI CEC adapters
#
CONFIG_USB_PULSE8_CEC=y
CONFIG_USB_RAINSHADOW_CEC=y
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_SMS_SIANO_MDTV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_WM8775=y

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP5150=y

#
# Video and audio decoders
#
CONFIG_VIDEO_CX25840=y

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
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_CX22700=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_EC100=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y

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
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_ATI=y
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_SIS is not set
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=y
CONFIG_INTEL_GTT=y
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
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_VX_LIB=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_MTPAV=y
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=y
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=y
CONFIG_SND_USB_UA101=y
CONFIG_SND_USB_USX2Y=y
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
CONFIG_SND_USB_6FIRE=y
# CONFIG_SND_USB_HIFACE is not set
CONFIG_SND_BCD2000=y
CONFIG_SND_USB_LINE6=y
CONFIG_SND_USB_POD=y
CONFIG_SND_USB_PODHD=y
CONFIG_SND_USB_TONEPORT=y
CONFIG_SND_USB_VARIAX=y
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=y
# CONFIG_SND_PDAUDIOCF is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=y
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
CONFIG_SND_SOC_FSL_SSI=y
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_IMX_AUDMUX=y
CONFIG_SND_I2S_HI6210_I2S=y
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_PCI=y
CONFIG_SND_SST_IPC_ACPI=y
# CONFIG_SND_SOC_INTEL_HASWELL is not set
# CONFIG_SND_SOC_INTEL_BAYTRAIL is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU1701=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_AK4458=y
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
# CONFIG_SND_SOC_CS35L32 is not set
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS42L42 is not set
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=y
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_DIO2125=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
# CONFIG_SND_SOC_GTM601 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98504=y
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC31XX=y
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=y
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_ZX_AUD96P22=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8824=y
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_SIMPLE_SCU_CARD=y
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_AUDIO_GRAPH_SCU_CARD=y
# CONFIG_SND_X86 is not set

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
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CP2112=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_GOOGLE_HAMMER=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SONY=y
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_WHITELIST=y
CONFIG_USB_OTG_BLACKLIST_HUB=y
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=y
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_PCI is not set
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_SL811_CS is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_WHCI_HCD=y
# CONFIG_USB_HWA_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

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
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=y
# CONFIG_USB_SPEEDTOUCH is not set
# CONFIG_USB_CXACRU is not set
# CONFIG_USB_UEAGLEATM is not set
CONFIG_USB_XUSBATM=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
CONFIG_USB_AMD5536UDC=y
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
CONFIG_USB_NET2280=y
CONFIG_USB_GOKU=y
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_DUMMY_HCD=y
CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_PHONET=y
CONFIG_USB_F_EEM=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_UAC2=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_MIDI=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_SERIAL=y
# CONFIG_USB_CONFIGFS_ACM is not set
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
CONFIG_USB_CONFIGFS_PHONET=y
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_UAC1 is not set
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
CONFIG_USB_CONFIGFS_F_UAC2=y
CONFIG_USB_CONFIGFS_F_MIDI=y
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_UVC=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_HWA=y
CONFIG_UWB_WHCI=y
CONFIG_UWB_I1480U=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_NET48XX=y
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
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
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_DW_AXI_DMAC is not set
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
CONFIG_PCH_DMA=y
CONFIG_TIMB_DMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
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
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

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
CONFIG_DELL_LAPTOP=y
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_AMILO_RFKILL=y
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
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
CONFIG_INTEL_PMC_CORE=y
CONFIG_IBM_RTL=y
CONFIG_XO1_RFKILL=y
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
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
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
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
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_KXSD9=y
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD7291=y
CONFIG_AD799X=y
CONFIG_CC10001_ADC=y
CONFIG_DLN2_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HX711 is not set
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADS1015=y
# CONFIG_TI_AM335X_ADC is not set
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
# CONFIG_VZ89X is not set

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
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_CIO_DAC=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
# CONFIG_VF610_DAC is not set

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set

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
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y

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
CONFIG_HTU21=y
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
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
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
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
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
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MCP4018=y
CONFIG_MCP4531=y
CONFIG_TPL0102=y

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
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
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9500=y
# CONFIG_SRF08 is not set

#
# Temperature sensors
#
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
CONFIG_NTB=y
# CONFIG_NTB_IDT is not set
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set

#
# VME Device Drivers
#
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_STMPE=y
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_MAPPHONE_MDM6600=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
CONFIG_THUNDERBOLT=y

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
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
CONFIG_GOOGLE_COREBOOT_TABLE_OF=y
CONFIG_GOOGLE_MEMCONSOLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
CONFIG_GOOGLE_VPD=y

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
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y

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
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
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
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
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
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
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
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
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
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_FUTEX=y
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
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
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
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
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
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
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_CRYPTO_DEV_CCP=y
# CONFIG_CRYPTO_DEV_CCP_DD is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_CCREE=y
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
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
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
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
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
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STRING_SELFTEST=y

--=_5aeb303f.elQMsCBOA+ZwIjjyOsaMOqcaJIiBw+BKDJtF5tVWXW6n9MYA--
