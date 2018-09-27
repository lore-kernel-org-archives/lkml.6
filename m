Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27E62156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27E62156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeI0NEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:04:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:22942 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeI0NEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:04:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 23:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,309,1534834800"; 
   d="gz'50?scan'50,208,50";a="76576601"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2018 23:39:49 -0700
Date:   Thu, 27 Sep 2018 14:40:10 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] 3b745c8969 [ 71.340100] WARNING: CPU: 1 PID: 48 at
 kernel/rcu/rcutorture.c:1478 rcu_torture_stats_print
Message-ID: <20180927064010.GE27173@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 3b745c8969c752601cb68c82a06735363563ab42
Author:     Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate: Sun Jun 10 16:45:44 2018 -0700
Commit:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Thu Jul 12 15:42:06 2018 -0700

    rcutorture: Make boost test more robust
    
    Currently, with RCU_BOOST disabled, I get no failures when forcing
    rcutorture to test RCU boost priority inversion. The reason seems to be
    that we don't check for failures if the callback never ran at all for
    the duration of the boost-test loop.
    
    Further, the 'rtb' and 'rtbf' counters seem to be used inconsistently.
    'rtb' is incremented at the start of each test and 'rtbf' is incremented
    per-cpu on each failure of call_rcu. So its possible 'rtbf' > 'rtb'.
    
    To test the boost with rcutorture, I did following on a 4-CPU x86 machine:
    
    modprobe rcutorture  test_boost=2
    sleep 20
    rmmod rcutorture
    
    With patch:
    rtbf: 8 rtb: 12
    
    Without patch:
    rtbf: 0 rtb: 2
    
    In summary this patch:
     - Increments failed and total test counters once per boost-test.
     - Checks for failure cases correctly.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

450efca718  rcutorture: Disable RT throttling for boost tests
3b745c8969  rcutorture: Make boost test more robust
c307aaf3eb  Merge tag 'iommu-fixes-v4.19-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
9aa0219c6a  Add linux-next specific files for 20180926
+---------------------------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                                       | 450efca718 | 3b745c8969 | c307aaf3eb | next-20180926 |
+---------------------------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                                        | 182        | 0          | 37         | 0             |
| boot_failures                                                                         | 13         | 16         | 34         | 16            |
| BUG:kernel_hang_in_test_stage                                                         | 8          | 7          | 4          |               |
| BUG:workqueue_lockup-pool                                                             | 4          | 2          | 1          |               |
| INFO:rcu_preempt_detected_stalls_on_CPUs/tasks                                        | 1          |            |            |               |
| EIP:lock_is_held_type                                                                 | 5          | 4          | 3          |               |
| EIP:___might_sleep                                                                    | 4          | 2          | 3          |               |
| INFO:rcu_preempt_self-detected_stall_on_CPU                                           | 4          | 4          | 3          |               |
| EIP:debug_lockdep_rcu_enabled                                                         | 1          | 2          | 2          |               |
| INFO:rcu_sched_detected_stalls_on_CPUs/tasks                                          | 1          | 2          | 1          |               |
| Mem-Info                                                                              | 1          |            |            |               |
| invoked_oom-killer:gfp_mask=0x                                                        | 1          |            |            |               |
| WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print                           | 0          | 7          | 29         |               |
| EIP:rcu_torture_stats_print                                                           | 0          | 7          | 29         |               |
| EIP:stutter_wait                                                                      | 0          | 1          |            |               |
| EIP:__lock_is_held                                                                    | 0          | 1          |            |               |
| EIP:queued_spin_lock_slowpath                                                         | 0          | 0          | 3          |               |
| INFO:rcu_sched_self-detected_stall_on_CPU                                             | 0          | 0          | 1          |               |
| IP-Config:Auto-configuration_of_network_failed                                        | 0          | 0          | 2          |               |
| BUG:sleeping_function_called_from_invalid_context_at_security/apparmor/include/cred.h | 0          | 0          | 0          | 16            |
+---------------------------------------------------------------------------------------+------------+------------+------------+---------------+

[   66.041535] init: tty2 main process ended, respawning
[   66.073982] init: tty3 main process (1857) terminated with status 1
[   66.075086] init: tty3 main process ended, respawning
[   71.320525] rcu-torture: rtc: (ptrval) ver: 274 tfle: 0 rta: 275 rtaf: 0 rtf: 261 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 10 rtb: 12 nt: 612 barrier: 0/0:0 cbflood: 11
[   71.340077] rcu-torture: !!! 
[   71.340100] WARNING: CPU: 1 PID: 48 at kernel/rcu/rcutorture.c:1478 rcu_torture_stats_print+0x198/0x389
[   71.342317] Modules linked in:
[   71.342809] CPU: 1 PID: 48 Comm: rcu_torture_sta Tainted: G                T 4.18.0-rc1-00089-g3b745c8 #1
[   71.344269] EIP: rcu_torture_stats_print+0x198/0x389
[   71.345037] Code: 3d 88 61 93 ca 00 75 0c 83 3d 84 61 93 ca 00 75 03 4b 7e 1a 68 ec 6c dc c9 68 0f 5f db c9 e8 59 60 ff ff f0 ff 05 94 61 93 ca <0f> 0b 58 5a 68 f1 6c dc c9 31 db e8 42 60 ff ff 5f ff 74 9d 9c 43 
[   71.348018] EAX: 00000004 EBX: 00000001 ECX: 00000001 EDX: 00000007
[   71.348975] ESI: 00000105 EDI: ca110da0 EBP: d0a1ff84 ESP: d0a1ff08
[   71.349935] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
[   71.350977] CR0: 80050033 CR2: b7f22060 CR3: 176c09e0 CR4: 000006b0
[   71.351933] DR0: 080d3000 DR1: b79d5800 DR2: 00000000 DR3: 00000000
[   71.365922] DR6: ffff0ff0 DR7: 00000600
[   71.366527] Call Trace:
[   71.366935]  rcu_torture_stats+0x38/0x59
[   71.367555]  kthread+0xef/0xf4
[   71.368036]  ? rcu_torture_stats_print+0x389/0x389
[   71.368787]  ? kthread_flush_work_fn+0xd/0xd
[   71.369449]  ret_from_fork+0x19/0x24
[   71.370019] irq event stamp: 128
[   71.370528] hardirqs last  enabled at (127): [<c9681e11>] console_unlock+0x42f/0x46a
[   71.371705] hardirqs last disabled at (128): [<c9bc998b>] common_exception+0x39/0x42
[   71.372875] softirqs last  enabled at (110): [<c9bca026>] __do_softirq+0x18e/0x1c4
[   71.374029] softirqs last disabled at (79): [<c96131a8>] do_softirq_own_stack+0x1d/0x23
[   71.375247] ---[ end trace bfc17b1da179232b ]---
[   71.405196] Reader Pipe:  4555290 39 0 0 0 0 0 0 0 0 0

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84 v4.18 --
git bisect  bad ee090756962c58b32af62b768ac7c58cc53af700  # 16:43  B      2    10    1   1  Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect  bad c1c2ad82c772966d3cdb9a4852329fa2cf71853a  # 16:54  B      2     3    0   0  Merge tag 'edac_for_4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp
git bisect  bad 10f3e23f07cb0c20f9bcb77a5b5a7eb2a1b2a2fe  # 17:05  B      0     2   18   1  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect  bad 30de24c7dd21348b142ee977b687afc70b392af6  # 17:20  B      0     1   16   0  Merge branch 'x86-cache-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad de5d1b39ea0b38a9f4dfb08966042b7b91e2df30  # 17:32  B      0     1   16   0  Merge branch 'locking-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad b99cdfdf0b1c077dcb24c0053d36d4ff5832224e  # 17:47  B      1     2    1   1  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 0ad6b38ab2cc00b886c34d945b6a30fdf5108c61  # 18:05  G     16     0    0   0  Merge branch 'core-debugobjects-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 400439275d9543286f9d3f2925c3156f888e6b18  # 18:16  G     16     0    0   0  Merge branch 'efi-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good d0daaeaf60143c02a2ef87f9f0703b63a0a7f8b3  # 18:26  G     16     0    0   0  Merge branch 'irq-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good c74859d1eb2d8578bdf6d78ba893e394085aba1a  # 18:40  G     15     0    2   2  rcu: Make rcu_report_unblock_qs_rnp() warn on violated preconditions
git bisect good 9622179519c52ead944c3b6a07aed9c6db3659e2  # 18:54  G     16     0    2   2  rcu: Remove "inline" from rcu_perf_print_module_parms()
git bisect good c7cd161ecb2188c07ba9560ca82aee756575359f  # 19:07  G     16     0    0   0  rcu: Assign higher prio to RCU threads if rcutorture is built-in
git bisect good 2397d072f76b552fc21cda19686d24a8066ced22  # 19:20  G     16     0    0   0  rcutorture: Handle extended read-side critical sections
git bisect  bad 622be33fcbc93e9b672b99ed338369eb5e843ac3  # 19:31  B      1     1    1   1  rcutorture: Use monotonic timestamp for stall detection
git bisect good 450efca7182a516a12dfcc0311abfd242bde42b2  # 20:14  G     16     0    3   3  rcutorture: Disable RT throttling for boost tests
git bisect  bad 3b745c8969c752601cb68c82a06735363563ab42  # 20:23  B      0     2   17   0  rcutorture: Make boost test more robust
# first bad commit: [3b745c8969c752601cb68c82a06735363563ab42] rcutorture: Make boost test more robust
git bisect good 450efca7182a516a12dfcc0311abfd242bde42b2  # 20:53  G     45     0    6   9  rcutorture: Disable RT throttling for boost tests
# extra tests with debug options
git bisect  bad 3b745c8969c752601cb68c82a06735363563ab42  # 21:05  B      0     1   16   0  rcutorture: Make boost test more robust
# extra tests on HEAD of linux-devel/devel-spot-201809251433
git bisect  bad 030b766240e3f8af8ca8cf9de250d492a894e638  # 21:05  B      1     9    0   4  0day head guard for 'devel-spot-201809251433'
# extra tests on tree/branch linus/master
git bisect  bad c307aaf3eb47969105887e4e8991ec00960a7ce8  # 21:54  B      4     7    1   1  Merge tag 'iommu-fixes-v4.19-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
# extra tests with first bad commit reverted
git bisect good 7fb1a0a661cc3bd8653194d8dcd6680e43f1deee  # 00:23  G     16     0    2   2  Revert "rcutorture: Make boost test more robust"
# extra tests on tree/branch linux-next/master
git bisect good 9aa0219c6a4cdb18c18e1b7b18202274ca802ccc  # 00:34  G     16     0   16  16  Add linux-next specific files for 20180926

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--hK8Uo4Yp55NZU70L
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vp-38:20180926202312:i386-randconfig-c0-09261511:4.18.0-rc1-00089-g3b745c8:1.gz"
Content-Transfer-Encoding: base64

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

--hK8Uo4Yp55NZU70L
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vp-17:20180926205736:i386-randconfig-c0-09261511:4.18.0-rc1-00088-g450efca:1.gz"
Content-Transfer-Encoding: base64

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
25wDDr8BPcAEuqgPAQA=

--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vp-38:20180926202312:i386-randconfig-c0-09261511:4.18.0-rc1-00089-g3b745c8:1"

#!/bin/bash

kernel=$1
initrd=quantal-core-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 384
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

--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.18.0-rc1-00089-g3b745c8"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.18.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
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
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
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
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
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
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
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
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
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
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
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
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
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
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_INTEL_RDT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=y
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
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
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
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
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
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
# CONFIG_COMPACTION is not set
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
# CONFIG_ZBUD is not set
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=m
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
CONFIG_X86_GX_SUSPMOD=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_YENTA_O2 is not set
CONFIG_YENTA_RICOH=y
# CONFIG_YENTA_TI is not set
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_I82365=m
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_TSI568=m
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=m
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
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
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
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
# CONFIG_NF_TPROXY_IPV4 is not set
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
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=y
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=m
CONFIG_LTPC=m
# CONFIG_COPS is not set
# CONFIG_IPDDP is not set
CONFIG_X25=y
CONFIG_LAPB=m
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUGFS=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
# CONFIG_VMWARE_VMCI_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=m
CONFIG_SCC=m
# CONFIG_SCC_DELAY is not set
# CONFIG_SCC_TRXECHO is not set
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
# CONFIG_YAM is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
# CONFIG_PCH_CAN is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
CONFIG_CAN_M_CAN=m
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
# CONFIG_CAN_EMS_PCMCIA is not set
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_PEAK_PCMCIA is not set
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_TSCAN1 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=m
CONFIG_MAY_USE_DEVLINK=m
CONFIG_FAILOVER=y
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

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_AR7_PARTS=m

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
# CONFIG_MTD_RAM is not set
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=m
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_BCH=y
CONFIG_MTD_NAND_ECC_BCH=y
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_CS553X is not set
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_PLATFORM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_CS5535_MFGPT=m
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
# CONFIG_CS5535_CLOCK_EVENT_SRC is not set
CONFIG_HP_ILO=y
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=y
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=m
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_VMWARE_VMCI=m

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
CONFIG_ECHO=y
CONFIG_MISC_RTSX_PCI=y
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
CONFIG_SUNGEM_PHY=m
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=m
# CONFIG_ARCNET_1051 is not set
# CONFIG_ARCNET_RAW is not set
CONFIG_ARCNET_CAP=m
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=y
CONFIG_ARCNET_COM20020_ISA=y
CONFIG_ARCNET_COM20020_PCI=y
CONFIG_ARCNET_COM20020_CS=m

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
CONFIG_ACENIC_OMIT_TIGON_I=y
CONFIG_ALTERA_TSE=m
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=y
CONFIG_LANCE=y
CONFIG_PCNET32=m
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
CONFIG_CHELSIO_T1_1G=y
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
CONFIG_CHELSIO_T4VF=y
# CONFIG_NET_VENDOR_CIRRUS is not set
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_CX_ECAT=y
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
# CONFIG_TULIP_MMIO is not set
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
CONFIG_DM9102=y
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_FUJITSU is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=m
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
# CONFIG_IGB_HWMON is not set
# CONFIG_IGBVF is not set
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
CONFIG_I40EVF=y
# CONFIG_ICE is not set
CONFIG_FM10K=y
CONFIG_NET_VENDOR_EXAR=y
CONFIG_S2IO=y
CONFIG_VXGE=y
CONFIG_VXGE_DEBUG_TRACE_ALL=y
CONFIG_JME=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=y
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=y
CONFIG_KS8851=y
CONFIG_KS8851_MLL=m
CONFIG_KSZ884X_PCI=y
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_FEALNX=y
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=m
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=y
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=m
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=m
CONFIG_SIS190=m
# CONFIG_NET_VENDOR_SMSC is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
CONFIG_SUNGEM=m
# CONFIG_CASSINI is not set
CONFIG_NIU=m
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_CPSW_ALE=y
CONFIG_TLAN=y
# CONFIG_NET_VENDOR_VIA is not set
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=m
CONFIG_WIZNET_W5300=m
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
# CONFIG_WIZNET_W5100_SPI is not set
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=y
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
CONFIG_AQUANTIA_PHY=m
CONFIG_ASIX_PHY=m
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=m
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_INTEL_XWAY_PHY=m
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=y
# CONFIG_NATIONAL_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_MICREL_KS8995MA=m
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
# CONFIG_PPPOE is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=m

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
# CONFIG_HOSTESS_SV11 is not set
CONFIG_COSA=m
CONFIG_LANMEDIA=m
# CONFIG_SEALEVEL_4021 is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
CONFIG_HDLC_RAW_ETH=m
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m
# CONFIG_HDLC_X25 is not set
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
CONFIG_PC300TOO=m
CONFIG_N2=m
# CONFIG_C101 is not set
CONFIG_FARSYNC=m
CONFIG_DSCC4=m
CONFIG_DSCC4_PCISYNC=y
CONFIG_DSCC4_PCI_RST=y
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
# CONFIG_LAPBETHER is not set
# CONFIG_X25_ASY is not set
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
CONFIG_IEEE802154_CC2520=m
CONFIG_IEEE802154_ADF7242=m
CONFIG_IEEE802154_CA8210=m
CONFIG_IEEE802154_CA8210_DEBUGFS=y
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_VMXNET3 is not set
CONFIG_FUJITSU_ES=y
# CONFIG_THUNDERBOLT_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=m
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=m
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=m
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_SAMSUNG=m
CONFIG_KEYBOARD_STOWAWAY=m
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_S6SY761=m
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
# CONFIG_TOUCHSCREEN_HTCPEN is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
# CONFIG_TOUCHSCREEN_WM9713 is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=m
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=m
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
# CONFIG_GAMEPORT is not set

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
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_NVRAM is not set
CONFIG_DTLK=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=m

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

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
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=m
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
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
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=m
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MID_DMA=y
# CONFIG_SPI_DW_MMIO is not set
CONFIG_SPI_GPIO=y
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=m
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_TOPCLIFF_PCH=m
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
# CONFIG_SPI_LOOPBACK_TEST is not set
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
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=m
CONFIG_GPIO_104_IDI_48=m
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_CS5535=m
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TPS68470 is not set
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WHISKEY_COVE=y
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=m

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_MAX17040=m
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_MAX8997=m
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=m
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=m
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=y
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_WDAT_WDT=m
# CONFIG_WM8350_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
# CONFIG_GEODE_WDT is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=m
CONFIG_SCx200_WDT=m
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=m
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=m
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=m
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_BXTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS68470=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TIMBERDALE=m
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_RAVE_SP_CORE=m
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_ARIZONA_LDO1=m
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=m
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS80031=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=m
CONFIG_CEC_PIN=y
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
# CONFIG_CEC_PIN_ERROR_INJ is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_CEC_GPIO=m
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
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
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=m
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
# CONFIG_VIDEO_CX25840 is not set

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
CONFIG_VIDEO_AK881X=m
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
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_I2C=m

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
# CONFIG_MEDIA_TUNER_MC44S803 is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set

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
# CONFIG_DVB_STV6111 is not set
CONFIG_DVB_MXL5XX=m
# CONFIG_DVB_M88DS3103 is not set

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
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
# CONFIG_DVB_STV6110 is not set
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_TUNER_ITD1000 is not set
CONFIG_DVB_TUNER_CX24113=m
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
# CONFIG_DVB_DS3000 is not set
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
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
# CONFIG_DVB_DIB3000MC is not set
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
# CONFIG_DVB_STV0297 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_S5H1409=m
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
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_DRX39XYJ is not set
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBP21=m
# CONFIG_DVB_LNBP22 is not set
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
CONFIG_DVB_SP2=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=m
CONFIG_AGP_ALI=m
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_AMDGPU=m
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y

#
# Display Engine Configuration
#
# CONFIG_DRM_AMD_DC is not set

#
# AMD Library routines
#
CONFIG_CHASH=m
CONFIG_CHASH_STATS=y
CONFIG_CHASH_SELFTEST=y
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_ALPHA_SUPPORT=y
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
CONFIG_DRM_I915_DEBUG_GUC=y
CONFIG_DRM_I915_SELFTEST=y
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
CONFIG_DRM_VGEM=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
# CONFIG_DRM_GMA600 is not set
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_QXL is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_HISI_HIBMC=m
CONFIG_DRM_TINYDRM=m
CONFIG_TINYDRM_MIPI_DBI=m
CONFIG_TINYDRM_ILI9225=m
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=m
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=m
CONFIG_FB_GEODE_GX=m
CONFIG_FB_GEODE_GX1=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_PM8941_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_OT200=m
CONFIG_BACKLIGHT_SKY81452=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=m
CONFIG_VGASTATE=m
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_ISA is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_SPI is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=m
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_DESIGNWARE_I2S=m
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_IMX_AUDMUX=m
CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_PCI=m
CONFIG_SND_SST_IPC_ACPI=m
# CONFIG_SND_SOC_INTEL_HASWELL is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
# CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH is not set
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_ZX_TDM=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_AK4104=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_AK5558=m
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
# CONFIG_SND_SOC_DIO2125 is not set
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM186X_SPI=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM3168A_SPI=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8770=m
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_ZX_AUD96P22=m
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_X86 is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=m
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m

#
# I2C HID support
#
CONFIG_I2C_HID=m
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
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=m
CONFIG_MMC=m
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_USDHI6ROL0=m
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=m
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set

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
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_AMD76X is not set
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
# CONFIG_EDAC_I82875P is not set
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=m
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=m
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=m
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_RS5C372=m
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS80031=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=y
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=m
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9055=m
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM8350 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_MT6397 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_INTEL_IDMA64 is not set
CONFIG_PCH_DMA=y
CONFIG_TIMB_DMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=m
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
# CONFIG_COMEDI_PCL724 is not set
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=m
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=m
# CONFIG_COMEDI_PCL818 is not set
# CONFIG_COMEDI_PCM3724 is not set
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=m
CONFIG_COMEDI_DAC02=m
CONFIG_COMEDI_DAS16M1=m
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
# CONFIG_COMEDI_DAS1800 is not set
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=m
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
# CONFIG_COMEDI_NI_AT_A2150 is not set
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=m
# CONFIG_COMEDI_NI_LABPC_ISA is not set
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=m
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
CONFIG_COMEDI_ADDI_APCI_1564=m
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=m
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
# CONFIG_COMEDI_ADL_PCI6208 is not set
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
# CONFIG_COMEDI_AMPLC_PCI230 is not set
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=m
# CONFIG_COMEDI_JR3_PCI is not set
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
# CONFIG_COMEDI_NI_670X is not set
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=m
CONFIG_COMEDI_NI_PCIMIO=m
# CONFIG_COMEDI_RTD520 is not set
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_TIO=m

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
CONFIG_ADIS16240=m

#
# Analog to digital converters
#
# CONFIG_AD7606 is not set
# CONFIG_AD7780 is not set
CONFIG_AD7816=y
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
CONFIG_ADT7316_I2C=m

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7152=y
CONFIG_AD7746=y

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16060 is not set

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Active energy metering IC
#
CONFIG_ADE7854=m
# CONFIG_ADE7854_I2C is not set
CONFIG_ADE7854_SPI=m

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1210=y
# CONFIG_FB_SM750 is not set
CONFIG_FB_XGI=m

#
# Speakup console speech
#
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_MTD_SPINAND_MT29F is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_FB_TFT=m
CONFIG_FB_TFT_AGM1264K_FL=m
CONFIG_FB_TFT_BD663474=m
# CONFIG_FB_TFT_HX8340BN is not set
# CONFIG_FB_TFT_HX8347D is not set
# CONFIG_FB_TFT_HX8353D is not set
CONFIG_FB_TFT_HX8357D=m
# CONFIG_FB_TFT_ILI9163 is not set
# CONFIG_FB_TFT_ILI9320 is not set
CONFIG_FB_TFT_ILI9325=m
CONFIG_FB_TFT_ILI9340=m
CONFIG_FB_TFT_ILI9341=m
CONFIG_FB_TFT_ILI9481=m
CONFIG_FB_TFT_ILI9486=m
CONFIG_FB_TFT_PCD8544=m
# CONFIG_FB_TFT_RA8875 is not set
# CONFIG_FB_TFT_S6D02A1 is not set
# CONFIG_FB_TFT_S6D1121 is not set
# CONFIG_FB_TFT_SH1106 is not set
# CONFIG_FB_TFT_SSD1289 is not set
CONFIG_FB_TFT_SSD1305=m
CONFIG_FB_TFT_SSD1306=m
CONFIG_FB_TFT_SSD1331=m
CONFIG_FB_TFT_SSD1351=m
# CONFIG_FB_TFT_ST7735R is not set
CONFIG_FB_TFT_ST7789V=m
CONFIG_FB_TFT_TINYLCD=m
# CONFIG_FB_TFT_TLS8204 is not set
CONFIG_FB_TFT_UC1611=m
# CONFIG_FB_TFT_UC1701 is not set
CONFIG_FB_TFT_UPD161704=m
CONFIG_FB_TFT_WATTEROTT=m
# CONFIG_FB_FLEX is not set
CONFIG_FB_TFT_FBTFT_DEVICE=m
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
# CONFIG_MOST_NET is not set
CONFIG_MOST_SOUND=m
CONFIG_MOST_VIDEO=m
CONFIG_MOST_I2C=m
CONFIG_GREYBUS=y
CONFIG_GREYBUS_AUDIO=m
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_FIRMWARE=y
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_DRM_VBOXVIDEO=m
CONFIG_PI433=y
# CONFIG_MTK_MMC is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
CONFIG_ACER_WIRELESS=m
# CONFIG_ACERHDF is not set
CONFIG_ALIENWARE_WMI=m
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_LED=y
CONFIG_DELL_SMO8800=y
# CONFIG_DELL_RBTN is not set
CONFIG_FUJITSU_LAPTOP=m
# CONFIG_FUJITSU_TABLET is not set
CONFIG_AMILO_RFKILL=m
CONFIG_GPD_POCKET_FAN=m
CONFIG_TC1100_WMI=y
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
# CONFIG_SONYPI_COMPAT is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
CONFIG_ASUS_WIRELESS=m
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_INTEL_WMI_THUNDERBOLT=y
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
CONFIG_INTEL_CHT_INT33FE=m
CONFIG_INTEL_INT0002_VGPIO=m
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
CONFIG_IBM_RTL=m
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=y
# CONFIG_INTEL_OAKTRAIL is not set
CONFIG_SAMSUNG_Q10=y
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_PVPANIC=y
CONFIG_INTEL_PMC_IPC=y
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_SURFACE_3_BUTTON=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_CHTDC_TI_PWRBTN is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CHROMEOS_TBMC=m
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_CLK_TWL6040=m
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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
CONFIG_XILINX_VCU=m
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_ARIZONA is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
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
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL345_SPI is not set
# CONFIG_BMA180 is not set
CONFIG_BMA220=m
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=m
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=m
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=m
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=y
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7266=m
CONFIG_AD7291=m
CONFIG_AD7298=y
CONFIG_AD7476=y
# CONFIG_AD7766 is not set
CONFIG_AD7791=y
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
CONFIG_AD7923=m
CONFIG_AD799X=m
CONFIG_CC10001_ADC=m
CONFIG_HI8435=m
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1027=m
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=m
CONFIG_STX104=m
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=m
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=m
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=m
CONFIG_TI_AM335X_ADC=m
# CONFIG_TI_TLC4541 is not set

#
# Analog Front Ends
#

#
# Amplifiers
#
CONFIG_AD8366=m

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
# CONFIG_VZ89X is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=y
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
CONFIG_104_QUAD_8=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
CONFIG_AD5380=m
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
# CONFIG_AD5592R is not set
CONFIG_AD5593R=m
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=m
# CONFIG_LTC2632 is not set
CONFIG_AD5686=y
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=y
CONFIG_AD5755=m
CONFIG_AD5761=m
# CONFIG_AD5764 is not set
CONFIG_AD5791=m
# CONFIG_AD7303 is not set
CONFIG_CIO_DAC=y
CONFIG_AD8801=m
# CONFIG_DS4424 is not set
CONFIG_M62332=y
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
CONFIG_TI_DAC5571=y

#
# IIO dummy driver
#

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
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=m
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=m
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=m
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16480=y
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_BMI160_SPI is not set
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=m
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1145=m
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=m
CONFIG_US5182D=y
CONFIG_VCNL4000=m
CONFIG_VEML6070=m
CONFIG_VL6180=y
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=y

#
# Multiplexers
#

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=m
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=m
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=m
CONFIG_MCP4531=y
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_HP03=m
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=m
# CONFIG_MS5611_SPI is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
CONFIG_AS3935=y

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y

#
# Resolver to digital converters
#
CONFIG_AD2S1200=m

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
CONFIG_NTB=y
CONFIG_NTB_IDT=y
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_CA91CX42 is not set
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=m

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set

#
# VME Device Drivers
#
CONFIG_VME_USER=y
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_MGR_XILINX_SPI is not set
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
# CONFIG_FPGA_BRIDGE is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_RUNTIME_MAP is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
CONFIG_EFI_TEST=m

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
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
# CONFIG_JFFS2_FS_SECURITY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_CRAMFS is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
# CONFIG_PSTORE is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=m
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
# CONFIG_NLS_UTF8 is not set
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
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
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
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

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
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_EFI=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_EFI_PGT_DUMP=y
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
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_DEBUG=y
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=y
# CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
# CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
CONFIG_EVM_ADD_XATTRS=y
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="apparmor"
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
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_AEGIS128L=y
# CONFIG_CRYPTO_AEGIS256 is not set
CONFIG_CRYPTO_MORUS640=m
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=m
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
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
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

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
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=m
CONFIG_CRC7=y
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_AUDIT_GENERIC=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_XZ_DEC=m
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_PRIME_NUMBERS=m
CONFIG_STRING_SELFTEST=m

--hK8Uo4Yp55NZU70L--
