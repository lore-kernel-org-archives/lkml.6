Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeC1D7y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:59:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:17850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeC1D7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:59:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,369,1517904000";
   d="gz'50?scan'50,208,50";a="29043638"
Date: Wed, 28 Mar 2018 12:00:24 +0800
From: kernel test robot <fengguang.wu@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [lkp-robot] [bisect done] 98f929b1bd [   22.331302] Oops: 0000 [#1]
 DEBUG_PAGEALLOC
Message-ID: <20180328040024.wnotng3j5fctndof@shao2-debian>
Reply-To: kernel test robot <fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mfnwd263itd6w5rb"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfnwd263itd6w5rb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-next

commit 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454
Author:     Eric W. Biederman <ebiederm@xmission.com>
AuthorDate: Fri Mar 23 00:29:57 2018 -0500
Commit:     Eric W. Biederman <ebiederm@xmission.com>
CommitDate: Tue Mar 27 15:53:09 2018 -0500

    ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
    
    Today shm_cpid and shm_lpid are remembered in the pid namespace of the
    creator and the processes that last touched a sysvipc shared memory
    segment.   If you have processes in multiple pid namespaces that
    is just wrong, and I don't know how this has been over-looked for
    so long.
    
    As only creation and shared memory attach and shared memory detach
    update the pids I do not expect there to be a repeat of the issues
    when struct pid was attached to each af_unix skb, which in some
    notable cases cut the performance in half.  The problem was threads of
    the same process updating same struct pid from different cpus causing
    the cache line to be highly contended and bounce between cpus.
    
    As creation, attach, and detach are expected to be rare operations for
    sysvipc shared memory segments I do not expect that kind of cache line
    ping pong to cause probems.  In addition because the pid is at a fixed
    location in the structure instead of being dynamic on a skb, the
    reference count of the pid does not need to be updated on each
    operation if the pid is the same.  This ability to simply skip the pid
    reference count changes if the pid is unchanging further reduces the
    likelihood of the a cache line holding a pid reference count
    ping-ponging between cpus.
    
    Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
    Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

03f1fc0918  ipc/util: Helpers for making the sysvipc operations pid namespace aware
98f929b1bd  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
0d79cbf83b  ipc/smack: Tidy up from the change in type of the ipc security hooks
+------------------------------------------+------------+------------+------------+
|                                          | 03f1fc0918 | 98f929b1bd | 0d79cbf83b |
+------------------------------------------+------------+------------+------------+
| boot_successes                           | 27         | 4          | 6          |
| boot_failures                            | 2          | 11         | 13         |
| Mem-Info                                 | 2          | 1          |            |
| Oops:#[##]                               | 0          | 10         | 11         |
| EIP:put_pid                              | 0          | 10         | 11         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 10         | 11         |
| BUG:unable_to_handle_kernel              | 0          | 5          | 4          |
| BUG:kernel_in_stage                      | 0          | 0          | 2          |
+------------------------------------------+------------+------------+------------+

[   15.281438] VFS: Warning: trinity-c1 using old stat() call. Recompile your binary.
[   15.329050] trinity-c0 (914) used greatest stack depth: 5732 bytes left
[   16.269183] warning: process `trinity-c3' used the deprecated sysctl system call with 
[   22.330477] IP: put_pid+0x7/0x30
[   22.330775] *pdpt = 000000000d7d6001 *pde = 0000000000000000 
[   22.331302] Oops: 0000 [#1] DEBUG_PAGEALLOC
[   22.331699] Modules linked in:
[   22.331989] CPU: 0 PID: 504 Comm: trinity Not tainted 4.16.0-rc2-00010-g98f929b #1
[   22.332771] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   22.333596] EIP: put_pid+0x7/0x30
[   22.333925] EFLAGS: 00010202 CPU: 0
[   22.334253] EAX: 00000025 EBX: ccfb5488 ECX: 00000000 EDX: cd8f7ee3
[   22.334836] ESI: ffffffea EDI: c1b87360 EBP: cd8f7eb8 ESP: cd8f7eb8
[   22.335407]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[   22.335911] CR0: 80050033 CR2: 00000029 CR3: 0d7a00e0 CR4: 000006f0
[   22.336557] Call Trace:
[   22.336792]  newseg+0xe7/0x2e0
[   22.337072]  ipcget+0x135/0x2a0
[   22.337358]  SyS_shmget+0x3c/0x40
[   22.337731]  SyS_ipc+0x249/0x2b0
[   22.338062]  do_int80_syscall_32+0x74/0x140
[   22.338438]  entry_INT80_32+0x2e/0x2e
[   22.338796] EIP: 0x809af42
[   22.339055] EFLAGS: 00000246 CPU: 0
[   22.339385] EAX: ffffffda EBX: 00000017 ECX: 00000000 EDX: 00001000
[   22.339974] ESI: 54000fb0 EDI: 00000000 EBP: 08a813a0 ESP: bf98604c
[   22.340641]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   22.341380] Code: 13 8b 50 04 5d 8b 44 d0 20 c3 8d 76 00 8d bc 27 00 00 00 00 31 c0 5d c3 8d b6 00 00 00 00 8d bf 00 00 00 00 55 85 c0 89 e5 74 10 <8b> 50 04 8b 4c d0 20 8b 10 4a 74 0d ff 08 74 09 5d c3 8d b4 26
[   22.344042] EIP: put_pid+0x7/0x30 SS:ESP: 0068:cd8f7eb8
[   22.344757] CR2: 0000000000000029
[   22.345256] ---[ end trace 2c13dc12bffa3321 ]---
[   22.345969] Kernel panic - not syncing: Fatal exception

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start dc21675827ebff48dc926f0b368a34f638139398 7928b2cbe55b2a410a0f5c1f154610059c57b1b2 --
git bisect good 3a746b90796cda41b642a57111ec180b820fe898  # 09:14  G     11     0    6   6  Merge 'anna-nfs/linux-next' into devel-catchup-201803280625
git bisect good b3ab4fefc09001f5d7aa3c72646c0f4a37ef20ec  # 09:27  G     11     0    8   8  Merge 'hwmon/hwmon-next' into devel-catchup-201803280625
git bisect good 4bf897901cd4a894c23f3cb8062eb26f50c91e17  # 09:37  G     11     0    7   7  Merge 'linux-arm/fixes' into devel-catchup-201803280625
git bisect  bad 3981fbba8c7ca81052bb4452c011688e6124f485  # 09:51  B      1    10    1   1  Merge 'userns/userns-next' into devel-catchup-201803280625
git bisect good 34b56df922b10ac2876f268c522951785bf333fd  # 10:03  G     11     0    5   5  msg: Move struct msg_queue into ipc/msg.c
git bisect  bad 39a4940eaa185910bb802ca9829c12268fd2c855  # 10:16  B      0     1   15   0  ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
git bisect good 03f1fc09180b345582889a344b012d069b3a6dbe  # 10:30  G     10     0    4   4  ipc/util: Helpers for making the sysvipc operations pid namespace aware
git bisect  bad 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454  # 10:45  B      0     1   15   0  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
# first bad commit: [98f929b1bd4d0b7c7a77d0d9776d1b924db2e454] ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
git bisect good 03f1fc09180b345582889a344b012d069b3a6dbe  # 10:53  G     31     0    9  13  ipc/util: Helpers for making the sysvipc operations pid namespace aware
# extra tests with debug options
git bisect  bad 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454  # 11:01  B      0     2   16   0  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
# extra tests on HEAD of linux-devel/devel-catchup-201803280625
git bisect  bad dc21675827ebff48dc926f0b368a34f638139398  # 11:07  B      0    12   33   4  0day head guard for 'devel-catchup-201803280625'
# extra tests on tree/branch userns/for-next
git bisect  bad 0d79cbf83be07bb38a1224f47fd0e2b163310442  # 11:17  B      0    11   25   0  ipc/smack: Tidy up from the change in type of the ipc security hooks
# extra tests with first bad commit reverted
git bisect good 96c582dca4d93f55c7dbcb67e4dcaa28b00bc2b1  # 11:27  G     10     0    4   4  Revert "ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces."

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--mfnwd263itd6w5rb
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-intel12-12:20180328104555:i386-randconfig-sb0-03280131:4.16.0-rc2-00010-g98f929b:1.gz"
Content-Transfer-Encoding: base64

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
UE5AZkq330FsfwGAwkZ7mqoAAA==

--mfnwd263itd6w5rb
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-intel12-10:20180328105230:i386-randconfig-sb0-03280131:4.16.0-rc2-00009-g03f1fc0:2.gz"
Content-Transfer-Encoding: base64

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
d9O3vFqPeRvf33Kph2cf7vlL+vvHm4+3f7l7eH31JpC+d//0MvnuGWcsenh/dXf/8tNr+v7D
x9urlzdP9y8kVwcPT76bD29+uJdh/WJjNP7m3f3dmxv59TdvXr344c0HktpypT75SnPylfbk
K93JV/qTrwxbV9IAeHPz9urp490g6M3T49ubn0jDeM/P7N0DjTGa7zil51e/+uorTmr2/o7H
+QcaFS++pjH09YebdzR2/vLp/evrjzdP318/3rx/c/uCxt84Gm4e6eP4N70YH/79+ubtjzc/
PV0Pb8Udybr99HhHr9pz+uOaXg9OSvX27TWPm4dPH1/Q8P3qFzRCn795xTmCnl7Qx0ca/R+/
f071f//u6fWLh/f0ldT7jCp+enj1kXNdfXo83Mz7d2+up+H6Qr796hcPD49P099vH27urqkp
3EEvDFfw8O7x4/wNVXn34eXd83dv3j98uL59+PT+4wuQ9tCLfvecVNzrt/c/3L99cf/hw1e/
ePP6PWc1om/ly69+cfvw/umBHg6tYiTp/ubD25+GFvA3f1K/0aQDcyuTcsm3P7y+efFe8lFR
X/341S9efrh5f/uXF2/fvP/0V37J799+Lf/77JYb+OnxmVEalDVAKob/6he/++Mf/+X699/9
9h++ffH14/evv5brvuZ54xkJuqM6X715/ezpJb2BfA0t/F+/vr195p7j12NmVSRxL0lF8mAA
8IYU9JdKmztaSF/am3D38v7rH96x1P/xbDM5a77/+Mnff3j1/Okvnz7ePfz4nvqZRtl/+I//
k6bKP/8f//b//IerZ8OQu6Lvhr/+/Gv6+qv/F1qIpCO6JwMA

--mfnwd263itd6w5rb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-intel12-12:20180328104555:i386-randconfig-sb0-03280131:4.16.0-rc2-00010-g98f929b:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
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

--mfnwd263itd6w5rb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-rc2-00010-g98f929b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.16.0-rc2 Kernel Configuration
#
# CONFIG_64BIT is not set
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
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
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
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
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
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

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
# CONFIG_RCU_STALL_COMMON is not set
# CONFIG_RCU_NEED_SEGCBLIST is not set
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
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
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
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
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
CONFIG_SYSCTL_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_THIN_ARCHIVES=y
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
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=m
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
# CONFIG_IOSCHED_BFQ is not set
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
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
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
# CONFIG_X86_PPRO_FENCE is not set
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
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
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=m
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_NEED_NODE_MEMMAP_SIZE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
# CONFIG_COMPACTION is not set
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=m
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=m
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
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
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
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
CONFIG_SFI=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
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
CONFIG_ISA=y
# CONFIG_EISA is not set
CONFIG_SCx200=m
# CONFIG_SCx200HR_TIMER is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
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
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
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
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
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
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
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
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
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
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=m
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=m
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=m

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
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_M25P80=m
CONFIG_MTD_MCHP23K256=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_BCH=y
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_GPIO=m
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_PLATFORM is not set
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_MT81xx_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
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
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=m
CONFIG_C2PORT=m
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
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
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=m
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
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
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
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
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
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
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA_BM is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
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
# CONFIG_ATP is not set
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
# CONFIG_SMC9194 is not set
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
# CONFIG_MDIO_BUS is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_USB_NET_DRIVERS=m
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=m
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=m
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=m
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_PS2_ALPS is not set
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
# CONFIG_MOUSE_PS2_CYPRESS is not set
CONFIG_MOUSE_PS2_LIFEBOOK=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=m
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_INPORT=m
# CONFIG_MOUSE_ATIXL is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_PEGASUS=m
CONFIG_TABLET_SERIAL_WACOM4=m
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=m
# CONFIG_RMI4_SMB is not set
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
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
# CONFIG_DEVMEM is not set
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
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
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_NVRAM is not set
CONFIG_DTLK=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
# CONFIG_CARDMAN_4040 is not set
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
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
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_DLN2=m
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PCA_ISA=y
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=m
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SX150X=y
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
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=m

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=m
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
# CONFIG_AXP20X_POWER is not set
CONFIG_AXP288_CHARGER=m
CONFIG_AXP288_FUEL_GAUGE=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_TWL4030_MADC is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_BATTERY_RX51=m
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_TWL4030=m
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX8997=m
CONFIG_CHARGER_MAX8998=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
# CONFIG_WM8350_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=m
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
# CONFIG_RETU_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_RDC321X_WDT is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=m
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
CONFIG_MIXCOMWD=m
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_MFD_CROS_EC_SPI=m
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_HTC_PASIC3 is not set
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
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=m
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
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
CONFIG_DRM_ANALOGIX_ANX78XX=m
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_TINYDRM=m
CONFIG_TINYDRM_MIPI_DBI=m
CONFIG_TINYDRM_ILI9225=m
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
CONFIG_TINYDRM_ST7586=m
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
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
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_MAX8925=m
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_PANDORA=m
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_VGASTATE is not set
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_PCM_XRUN_DEBUG=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_ISA is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
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
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1_SEQ is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
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
# CONFIG_SND_SPI is not set
# CONFIG_SND_USB is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
# CONFIG_SND_SOC_FSL_SSI is not set
CONFIG_SND_SOC_FSL_SPDIF=m
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_IMX_AUDMUX=m
CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM is not set
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_INTEL_MACH=y

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
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
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_ALC5623=m
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
CONFIG_SND_SOC_DIO2125=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
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
# CONFIG_SND_SOC_RT5514_SPI_BUILTIN is not set
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
CONFIG_SND_SOC_SPDIF=m
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
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_X86=y
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
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
CONFIG_HID_GT683R=m
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_HIDPP is not set
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=m
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=m
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=m
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
# CONFIG_USB_SL811_HCD_ISO is not set
# CONFIG_USB_SL811_CS is not set
CONFIG_USB_R8A66597_HCD=m
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_REALTEK is not set
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
# CONFIG_USB_STORAGE_ONETOUCH is not set
CONFIG_USB_STORAGE_KARMA=m
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_GADGET=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC2=m
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_PCI=m
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_CHIPIDEA_HOST=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=m
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=m
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=m
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_CONFIGFS is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
# CONFIG_UWB_I1480U is not set
CONFIG_MMC=y
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_USB=m
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
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
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_APU=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_NET48XX=m
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8925=y
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX8997=y
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=m
CONFIG_RTC_DRV_DS1305=y
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=m
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=m
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_WM8350=m
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_MC13XXX is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=m
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
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=m
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_ARIZONA is not set
CONFIG_EXTCON_AXP288=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PALMAS=m
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
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
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL345_SPI=m
CONFIG_BMA180=m
CONFIG_BMA220=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=m
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
# CONFIG_SCA3000 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7266=m
CONFIG_AD7291=m
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7766=m
CONFIG_AD7791=m
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
CONFIG_AD7923=m
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
# CONFIG_DLN2_ADC is not set
CONFIG_HI8435=m
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_STX104=m
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=m
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
CONFIG_TWL4030_MADC=m
# CONFIG_TWL6030_GPADC is not set
# CONFIG_VIPERBOARD_ADC is not set

#
# Amplifiers
#
CONFIG_AD8366=m

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
# CONFIG_VZ89X is not set
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
# CONFIG_104_QUAD_8 is not set

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5360 is not set
CONFIG_AD5380=m
CONFIG_AD5421=m
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=m
CONFIG_LTC2632=m
CONFIG_AD5686=m
# CONFIG_AD5755 is not set
CONFIG_AD5761=m
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
CONFIG_AD7303=m
# CONFIG_CIO_DAC is not set
CONFIG_AD8801=m
CONFIG_DS4424=m
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MCP4725=m
CONFIG_MCP4922=m
CONFIG_TI_DAC082S085=m

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
# CONFIG_HTU21 is not set
CONFIG_SI7005=m
CONFIG_SI7020=m

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
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=m
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
# CONFIG_AL3320A is not set
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
CONFIG_SI1145=m
CONFIG_STK3310=m
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
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
CONFIG_MMC35240=m
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

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_DS1803=m
CONFIG_MAX5481=m
CONFIG_MAX5487=m
CONFIG_MCP4131=m
CONFIG_MCP4531=m
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_MLX90614=m
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
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
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
CONFIG_POWERCAP=y
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
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_32BIT=y
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=m
CONFIG_STM=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
# CONFIG_FPGA_REGION is not set
CONFIG_FSI=m
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_SCOM=m
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=m
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
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
CONFIG_CIFS=m
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
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
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
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
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
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
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
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_LIST_SORT=y
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=m
CONFIG_TEST_HEXDUMP=m
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=y
CONFIG_TEST_LKM=m
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
CONFIG_FIND_BIT_BENCHMARK=m
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=y
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_X86_PTDUMP_CORE is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
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
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=m
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
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
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
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=m
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_586=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
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
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
CONFIG_STRING_SELFTEST=m

--mfnwd263itd6w5rb--
