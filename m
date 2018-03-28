Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeC1HeF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:34:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:55756 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbeC1Haq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:30:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,370,1517904000";
   d="gz'50?scan'50,208,50";a="41341043"
Date: Wed, 28 Mar 2018 15:29:50 +0800
From: kernel test robot <fengguang.wu@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        wfg@linux.intel.com
Subject: 98f929b1bd ("ipc/shm: Fix shmctl(..., IPC_STAT, ...) between
 .."):  Oops: 0000 [#1]
Message-ID: <5abb446e.XtEK088UbWSHCPaF%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5abb446e.HmcMFJTSiEaMHH03YI+CSahTaVIhOtfwLsa+GJGYT2IZH70a"
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5abb446e.HmcMFJTSiEaMHH03YI+CSahTaVIhOtfwLsa+GJGYT2IZH70a
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
| boot_successes                           | 33         | 4          | 2          |
| boot_failures                            | 0          | 11         | 19         |
| Oops:#[##]                               | 0          | 10         | 12         |
| RIP:put_pid                              | 0          | 11         | 15         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 11         | 15         |
| BUG:unable_to_handle_kernel              | 0          | 2          | 4          |
| BUG:kernel_in_stage                      | 0          | 0          | 4          |
| general_protection_fault:#[##]           | 0          | 0          | 3          |
+------------------------------------------+------------+------------+------------+

[    8.040360] gfs2: path_lookup on rootfs returned error -2
[    8.044048] mount (541) used greatest stack depth: 13352 bytes left
Kernel tests: Boot OK!
[   18.532190] IP: put_pid+0x22/0x5c
[   18.532552] PGD 19efa067 P4D 19efa067 PUD 0 
[   18.533006] Oops: 0000 [#1]
[   18.533318] CPU: 0 PID: 727 Comm: trinity Not tainted 4.16.0-rc2-00010-g98f929b #1
[   18.534144] RIP: 0010:put_pid+0x22/0x5c
[   18.534586] RSP: 0018:ffff986719f73e48 EFLAGS: 00010202
[   18.535129] RAX: 00000006d765f710 RBX: ffff98671a4fa4d0 RCX: ffff986719f73d40
[   18.535871] RDX: 000000006f6e6125 RSI: 0000000000000000 RDI: ffffffffa01e6d21
[   18.536616] RBP: ffffffffa0955fe0 R08: 0000000000000020 R09: 0000000000000000
[   18.537386] R10: 0000000000000078 R11: ffff986719f73e76 R12: 0000000000001000
[   18.538120] R13: 00000000ffffffea R14: 0000000054000fb0 R15: 0000000000000000
[   18.538892] FS:  00000000028c2880(0000) GS:ffffffffa06ad000(0000) knlGS:0000000000000000
[   18.539736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.540360] CR2: 0000000677846439 CR3: 0000000019fc1005 CR4: 00000000000606b0
[   18.541115] Call Trace:
[   18.541385]  ? ipc_update_pid+0x36/0x3e
[   18.541792]  ? newseg+0x34c/0x3a6
[   18.542146]  ? ipcget+0x5d/0x528
[   18.542523]  ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
[   18.543068]  ? SyS_shmget+0x5a/0x84
[   18.543444]  ? do_syscall_64+0x194/0x1b3
[   18.543884]  ? entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   18.544434] Code: ff 05 e7 20 9b 03 58 c9 c3 48 ff 05 85 21 9b 03 48 85 ff 74 4f 8b 47 04 8b 17 48 ff 05 7c 21 9b 03 48 83 c0 03 48 c1 e0 04 ff ca <48> 8b 44 07 08 74 1f 48 ff 05 6c 21 9b 03 ff 0f 0f 94 c2 48 ff 
[   18.546443] RIP: put_pid+0x22/0x5c RSP: ffff986719f73e48
[   18.547026] CR2: 0000000677846439
[   18.547395] ---[ end trace ab8c5cb4389d37c5 ]---
[   18.547888] Kernel panic - not syncing: Fatal exception

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 77a1df249bf89af82d6a2a6fe5f57c3da270f8d9 3eb2ce825ea1ad89d20f7a3b5780df850e4be274 --
git bisect  bad dd5963ef89e4dbe5abfea40df18549a440570cdf  # 11:17  B      0    11   24   0  Merge 'tj-libata/for-next' into devel-spot-201803280843
git bisect  bad 3fb00b899e5e53dd42cc3ef865c017e34f52563d  # 11:39  B      0     2   15   0  Merge 'linux-review/NeilBrown/rhashtable-assorted-fixes-and-enhancements/20180328-024648' into devel-spot-201803280843
git bisect good 0d5dbbbdbdf1b6dc50c40fe936e3b0eaf278ab32  # 11:59  G     11     0    4   4  Merge 'masahiroy/for-next' into devel-spot-201803280843
git bisect good 44cf2417eb69f79e9ed9c4023907a286c7a48501  # 12:23  G     11     0    0   0  Merge 'userns/userns-next' into devel-spot-201803280843
git bisect  bad a299bee013ccdda737d11cbafeb024e5a8ebcc56  # 12:40  B      0    11   24   0  Merge 'linux-review/Li-RongQing/mm-list_lru-replace-spinlock-with-RCU-in-__list_lru_count_one/20180328-042620' into devel-spot-201803280843
git bisect  bad 919db40dc9754fa11973ffcbfbb95f7cf87db991  # 13:00  B      0    11   26   2  Merge 'linux-review/Pablo-Neira-Ayuso/netfilter-ipt_CLUSTERIP-Allow-configuring-local-node-0-again/20180328-044503' into devel-spot-201803280843
git bisect  bad a878805a8837c1bfde9745c505d3c37b1f0f73e0  # 13:14  B      0     2   15   0  Merge 'userns/userns-test' into devel-spot-201803280843
git bisect good 34b56df922b10ac2876f268c522951785bf333fd  # 13:31  G     11     0    0   0  msg: Move struct msg_queue into ipc/msg.c
git bisect good 03f1fc09180b345582889a344b012d069b3a6dbe  # 13:52  G     11     0    0   0  ipc/util: Helpers for making the sysvipc operations pid namespace aware
git bisect  bad 39a4940eaa185910bb802ca9829c12268fd2c855  # 14:10  B      0    11   24   0  ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
git bisect  bad 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454  # 14:20  B      0    11   25   0  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
# first bad commit: [98f929b1bd4d0b7c7a77d0d9776d1b924db2e454] ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
git bisect good 03f1fc09180b345582889a344b012d069b3a6dbe  # 14:23  G     31     0    2   2  ipc/util: Helpers for making the sysvipc operations pid namespace aware
# extra tests with debug options
git bisect  bad 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454  # 14:35  B      0    11   25   0  ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
# extra tests on HEAD of linux-devel/devel-spot-201803280843
git bisect  bad 77a1df249bf89af82d6a2a6fe5f57c3da270f8d9  # 14:35  B      0    18   42   7  0day head guard for 'devel-spot-201803280843'
# extra tests on tree/branch userns/for-next
git bisect  bad 0d79cbf83be07bb38a1224f47fd0e2b163310442  # 15:06  B      0     4   17   0  ipc/smack: Tidy up from the change in type of the ipc security hooks
# extra tests with first bad commit reverted
git bisect good 96c582dca4d93f55c7dbcb67e4dcaa28b00bc2b1  # 15:29  G     11     0    1   1  Revert "ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces."

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5abb446e.HmcMFJTSiEaMHH03YI+CSahTaVIhOtfwLsa+GJGYT2IZH70a
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vp-13:20180328142009:x86_64-randconfig-s3-03281023:4.16.0-rc2-00010-g98f929b:1.gz"

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

--=_5abb446e.HmcMFJTSiEaMHH03YI+CSahTaVIhOtfwLsa+GJGYT2IZH70a
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vp-42:20180328142210:x86_64-randconfig-s3-03281023:4.16.0-rc2-00009-g03f1fc0:1.gz"

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
/werYPvuNzMBAA==

--=_5abb446e.HmcMFJTSiEaMHH03YI+CSahTaVIhOtfwLsa+GJGYT2IZH70a
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-vp-13:20180328142009:x86_64-randconfig-s3-03281023:4.16.0-rc2-00010-g98f929b:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 512
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

--=_5abb446e.HmcMFJTSiEaMHH03YI+CSahTaVIhOtfwLsa+GJGYT2IZH70a
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.16.0-rc2-00010-g98f929b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.16.0-rc2 Kernel Configuration
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
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
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
# CONFIG_RCU_STALL_COMMON is not set
# CONFIG_RCU_NEED_SEGCBLIST is not set
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
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
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
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
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
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
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
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
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
CONFIG_CC_STACKPROTECTOR_STRONG=y
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
CONFIG_ISA_BUS_API=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_FORMAT_AUTODETECT is not set
# CONFIG_GCOV_FORMAT_3_4 is not set
CONFIG_GCOV_FORMAT_4_7=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=y
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
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
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
CONFIG_CALGARY_IOMMU=y
# CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_ARCH_USE_MEMREMAP_PROT=y
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
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_INTEL_UMIP is not set
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_EFI is not set
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
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
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
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
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
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
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
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEAER_INJECT=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEBUG=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
CONFIG_PCIEASPM_POWER_SUPERSAVE=y
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
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
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#
CONFIG_VMD=y

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_SMC=y
# CONFIG_SMC_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
CONFIG_INET_XFRM_MODE_TUNNEL=y
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
CONFIG_INET6_TUNNEL=y
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
CONFIG_IP_DCCP=y

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
CONFIG_TIPC=y
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=y
# CONFIG_NET_DSA_LEGACY is not set
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
CONFIG_X25=y
CONFIG_LAPB=y
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=y
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=y
CONFIG_6LOWPAN_NHC_DEST=y
CONFIG_6LOWPAN_NHC_FRAGMENT=y
CONFIG_6LOWPAN_NHC_HOP=y
# CONFIG_6LOWPAN_NHC_IPV6 is not set
CONFIG_6LOWPAN_NHC_MOBILITY=y
CONFIG_6LOWPAN_NHC_ROUTING=y
CONFIG_6LOWPAN_NHC_UDP=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
CONFIG_6LOWPAN_GHC_UDP=y
CONFIG_6LOWPAN_GHC_ICMPV6=y
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=y
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=y
CONFIG_IEEE802154_6LOWPAN=y
# CONFIG_MAC802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VMWARE_VMCI_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
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
CONFIG_CAN_C_CAN=y
# CONFIG_CAN_C_CAN_PLATFORM is not set
CONFIG_CAN_C_CAN_PCI=y
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_IFI_CANFD=y
CONFIG_CAN_M_CAN=y
CONFIG_CAN_PEAK_PCIEFD=y
CONFIG_CAN_SJA1000=y
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=y
# CONFIG_CAN_EMS_PCI is not set
CONFIG_CAN_PEAK_PCI=y
# CONFIG_CAN_PEAK_PCIEC is not set
# CONFIG_CAN_KVASER_PCI is not set
CONFIG_CAN_PLX_PCI=y
CONFIG_CAN_SOFTING=y
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_BCM=y
CONFIG_BT_QCA=y
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_ATH3K is not set
# CONFIG_BT_HCIUART_LL is not set
CONFIG_BT_HCIUART_3WIRE=y
# CONFIG_BT_HCIUART_INTEL is not set
CONFIG_BT_HCIUART_QCA=y
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIVHCI=y
# CONFIG_BT_MRVL is not set
CONFIG_BT_WILINK=y
CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=y
CONFIG_NFC_NCI_UART=y
CONFIG_NFC_HCI=y
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=y
CONFIG_NFC_FDP=y
# CONFIG_NFC_FDP_I2C is not set
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_MEI=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_MEI=y
CONFIG_NFC_MRVL=y
CONFIG_NFC_MRVL_UART=y
# CONFIG_NFC_MRVL_I2C is not set
CONFIG_NFC_ST_NCI=y
CONFIG_NFC_ST_NCI_I2C=y
CONFIG_NFC_NXP_NCI=y
CONFIG_NFC_NXP_NCI_I2C=y
CONFIG_NFC_S3FWRN5=y
CONFIG_NFC_S3FWRN5_I2C=y
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
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
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=y
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
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

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
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_PCI=y
CONFIG_MTD_GPIO_ADDR=y
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=y
# CONFIG_MTD_NAND_ECC_BCH is not set
CONFIG_MTD_SM_COMMON=y
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
CONFIG_MTD_NAND_RICOH=y
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_DOCG4=y
CONFIG_MTD_NAND_CAFE=y
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_PLATFORM is not set
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
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
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_RDMA=y
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_VMWARE_BALLOON=y
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_MISC_RTSX is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

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
CONFIG_SCIF_BUS=y

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=y

#
# Intel MIC Host Driver
#
CONFIG_INTEL_MIC_HOST=y

#
# Intel MIC Card Driver
#
# CONFIG_INTEL_MIC_CARD is not set

#
# SCIF Driver
#
CONFIG_SCIF=y

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#
CONFIG_MIC_COSM=y

#
# VOP Driver
#
# CONFIG_VOP is not set
CONFIG_VHOST_RING=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
CONFIG_BLK_DEV_IT821X=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_TC86C001=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=y
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
CONFIG_SCSI_CXGB4_ISCSI=y
CONFIG_SCSI_BNX2_ISCSI=y
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_DPT_I2O=y
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
CONFIG_SCSI_ESAS2R=y
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
CONFIG_SCSI_SMARTPQI=y
# CONFIG_SCSI_UFSHCD is not set
CONFIG_SCSI_HPTIOP=y
CONFIG_VMWARE_PVSCSI=y
# CONFIG_LIBFC is not set
CONFIG_SCSI_SNIC=y
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FUTURE_DOMAIN=y
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=y
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_STEX=y
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_QLOGIC_1280=y
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_QEDI=y
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=y
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_CHELSIO_FCOE=y
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
CONFIG_TCM_USER2=y
CONFIG_LOOPBACK_TARGET=y
CONFIG_ISCSI_TARGET=y
CONFIG_ISCSI_TARGET_CXGB4=y
CONFIG_SBP_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
CONFIG_ARCNET=y
# CONFIG_ARCNET_1201 is not set
# CONFIG_ARCNET_1051 is not set
# CONFIG_ARCNET_RAW is not set
CONFIG_ARCNET_CAP=y
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=y
# CONFIG_ARCNET_RIM_I is not set
# CONFIG_ARCNET_COM20020 is not set

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=y
CONFIG_CAIF_SPI_SLAVE=y
# CONFIG_CAIF_SPI_SYNC is not set
# CONFIG_CAIF_HSI is not set
CONFIG_CAIF_VIRTIO=y

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
# CONFIG_B53_MDIO_DRIVER is not set
# CONFIG_B53_MMAP_DRIVER is not set
# CONFIG_B53_SRAB_DRIVER is not set
CONFIG_NET_DSA_LOOP=y
CONFIG_NET_DSA_MT7530=y
# CONFIG_MICROCHIP_KSZ is not set
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_QCA8K is not set
CONFIG_NET_DSA_SMSC_LAN9303=y
CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=y
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_TYPHOON=y
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=y
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=y
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
CONFIG_ATL1=y
CONFIG_ATL1E=y
CONFIG_ATL1C=y
CONFIG_ALX=y
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_CADENCE is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=y
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_CX_ECAT=y
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
CONFIG_SUNDANCE=y
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGB_DCA=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_JME=y
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=y
CONFIG_MLX4_CORE=y
# CONFIG_MLX4_DEBUG is not set
# CONFIG_MLX4_CORE_GEN2 is not set
CONFIG_MLX5_CORE=y
# CONFIG_MLX5_FPGA is not set
# CONFIG_MLX5_CORE_EN is not set
# CONFIG_MLXSW_CORE is not set
CONFIG_MLXFW=y
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_PACKET_ENGINE=y
CONFIG_HAMACHI=y
CONFIG_YELLOWFIN=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
CONFIG_QLCNIC=y
# CONFIG_QLCNIC_HWMON is not set
# CONFIG_QLGE is not set
CONFIG_NETXEN_NIC=y
CONFIG_QED=y
CONFIG_QED_LL2=y
CONFIG_QEDE=y
CONFIG_QED_RDMA=y
CONFIG_QED_ISCSI=y
CONFIG_QED_OOO=y
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
CONFIG_8139_OLD_RX_RESET=y
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=y
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_PLATFORM is not set
CONFIG_STMMAC_PCI=y
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_CPSW_ALE=y
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_VIA_VELOCITY=y
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=y
# CONFIG_WIZNET_W5300 is not set
# CONFIG_WIZNET_BUS_DIRECT is not set
CONFIG_WIZNET_BUS_INDIRECT=y
# CONFIG_WIZNET_BUS_ANY is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_FDDI=y
CONFIG_DEFXX=y
CONFIG_DEFXX_MMIO=y
# CONFIG_SKFP is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=y
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
CONFIG_AQUANTIA_PHY=y
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_BROADCOM_PHY is not set
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=y
# CONFIG_ICPLUS_PHY is not set
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
CONFIG_QSEMI_PHY=y
# CONFIG_REALTEK_PHY is not set
# CONFIG_RENESAS_PHY is not set
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

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
CONFIG_HDLC_RAW=y
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=y
CONFIG_HDLC_FR=y
# CONFIG_HDLC_PPP is not set
CONFIG_HDLC_X25=y
CONFIG_PCI200SYN=y
# CONFIG_WANXL is not set
CONFIG_PC300TOO=y
# CONFIG_FARSYNC is not set
CONFIG_DLCI=y
CONFIG_DLCI_MAX=8
CONFIG_LAPBETHER=y
CONFIG_X25_ASY=y
CONFIG_SBNI=y
# CONFIG_SBNI_MULTILINE is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_VMXNET3=y
# CONFIG_FUJITSU_ES is not set
CONFIG_THUNDERBOLT_NET=y
CONFIG_NETDEVSIM=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=y
# CONFIG_ISDN_PPP is not set
# CONFIG_ISDN_AUDIO is not set
CONFIG_ISDN_X25=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=y
# CONFIG_ISDN_DIVERSION is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=y

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
# CONFIG_DE_AOC is not set
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
CONFIG_HISAX_1TR6=y
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
# CONFIG_HISAX_S0BOX is not set
# CONFIG_HISAX_FRITZPCI is not set
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
CONFIG_HISAX_DIEHLDIVA=y
# CONFIG_HISAX_SEDLBAUER is not set
CONFIG_HISAX_NETJET=y
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
CONFIG_HISAX_BKM_A4T=y
# CONFIG_HISAX_SCT_QUADRO is not set
CONFIG_HISAX_GAZEL=y
# CONFIG_HISAX_HFC_PCI is not set
CONFIG_HISAX_W6692=y
# CONFIG_HISAX_HFC_SX is not set
CONFIG_HISAX_ENTERNOW_PCI=y
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_HFC4S8S=y
# CONFIG_HISAX_FRITZ_PCIPNP is not set
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_CAPI20=y
# CONFIG_ISDN_CAPI_MIDDLEWARE is not set
# CONFIG_ISDN_CAPI_CAPIDRV is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=y
# CONFIG_ISDN_DRV_AVMB1_B1PCIV4 is not set
# CONFIG_ISDN_DRV_AVMB1_T1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_C4 is not set
# CONFIG_CAPI_EICON is not set
CONFIG_ISDN_DRV_GIGASET=y
# CONFIG_GIGASET_CAPI is not set
CONFIG_GIGASET_I4L=y
# CONFIG_GIGASET_DUMMYLL is not set
CONFIG_GIGASET_M101=y
# CONFIG_GIGASET_DEBUG is not set
CONFIG_MISDN=y
CONFIG_MISDN_DSP=y
CONFIG_MISDN_L1OIP=y

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=y
CONFIG_MISDN_HFCMULTI=y
CONFIG_MISDN_AVMFRITZ=y
# CONFIG_MISDN_SPEEDFAX is not set
# CONFIG_MISDN_INFINEON is not set
# CONFIG_MISDN_W6692 is not set
# CONFIG_MISDN_NETJET is not set
CONFIG_MISDN_IPAC=y
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
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9055_ONKEY=y
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
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
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINKMP is not set
CONFIG_SYNCLINK_GT=y
CONFIG_NOZOMI=y
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
CONFIG_N_GSM=y
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
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
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
# CONFIG_SERIAL_8250_EXAR is not set
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=y
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PROC_INTERFACE is not set
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=y
CONFIG_R3964=y
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
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
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

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
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM8350=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
CONFIG_MAX8925_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MAX8998=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=y
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
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
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8400=y
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
# CONFIG_IR_SERIAL is not set
CONFIG_IR_SIR=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=y
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
CONFIG_VIDEO_FB_IVTV=y
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_HEXIUM_ORION=y
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=y
# CONFIG_VIDEO_CX25821 is not set
# CONFIG_VIDEO_CX88 is not set
CONFIG_VIDEO_BT848=y
CONFIG_DVB_BT8XX=y
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
CONFIG_DVB_BUDGET_CORE=y
CONFIG_DVB_BUDGET=y
CONFIG_DVB_BUDGET_CI=y
# CONFIG_DVB_BUDGET_AV is not set
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
CONFIG_DVB_PLUTO2=y
CONFIG_DVB_DM1105=y
CONFIG_DVB_PT1=y
CONFIG_DVB_PT3=y
CONFIG_MANTIS_CORE=y
CONFIG_DVB_MANTIS=y
CONFIG_DVB_HOPPER=y
CONFIG_DVB_NGENE=y
# CONFIG_DVB_DDBRIDGE is not set
CONFIG_DVB_SMIPCIE=y
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=y
CONFIG_RADIO_SI470X=y
# CONFIG_I2C_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_TEA5764=y
# CONFIG_RADIO_TEA5764_XTAL is not set
# CONFIG_RADIO_SAA7706H is not set
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_WL1273=y

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_RADIO_WL128X=y

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
# CONFIG_VIDEO_IR_I2C is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9M111=y

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
CONFIG_VIDEO_M52790=y

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC5000 is not set
# CONFIG_MEDIA_TUNER_XC4000 is not set
CONFIG_MEDIA_TUNER_MXL5005S=y
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set
CONFIG_DVB_MXL5XX=y
# CONFIG_DVB_M88DS3103 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_TDA18271C2DD is not set
# CONFIG_DVB_SI2165 is not set
# CONFIG_DVB_MN88472 is not set
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_TDA10048 is not set
CONFIG_DVB_AF9013=y
CONFIG_DVB_EC100=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_SI2168=y
# CONFIG_DVB_AS102_FE is not set
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_LGDT3305 is not set
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_DRX39XYJ is not set
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBP21=y
# CONFIG_DVB_LNBP22 is not set
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_SP2=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_TDA665x is not set
# CONFIG_DVB_IX2505V is not set
# CONFIG_DVB_M88RS2000 is not set
# CONFIG_DVB_AF9033 is not set
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_HELENE=y

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=y
# CONFIG_VGA_ARB is not set
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
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=y
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
CONFIG_FB_INTEL=y
CONFIG_FB_INTEL_DEBUG=y
CONFIG_FB_INTEL_I2C=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_SM501=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
# CONFIG_FB_AUO_K1900 is not set
CONFIG_FB_AUO_K1901=y
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SM712=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
CONFIG_VGASTATE=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y

#
# I2C HID support
#
CONFIG_I2C_HID=y

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
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
CONFIG_INFINIBAND_CXGB3=y
# CONFIG_INFINIBAND_CXGB3_DEBUG is not set
CONFIG_INFINIBAND_CXGB4=y
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_MLX5_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_VMWARE_PVRDMA=y
CONFIG_INFINIBAND_IPOIB=y
CONFIG_INFINIBAND_IPOIB_CM=y
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
# CONFIG_INFINIBAND_SRP is not set
# CONFIG_INFINIBAND_SRPT is not set
CONFIG_INFINIBAND_ISER=y
CONFIG_INFINIBAND_ISERT=y
CONFIG_INFINIBAND_OPA_VNIC=y
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_RDMA_RXE is not set
CONFIG_INFINIBAND_QEDR=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
# CONFIG_EDAC_I5400 is not set
CONFIG_EDAC_I5000=y
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_LP8788 is not set
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8925 is not set
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX8997=y
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_TPS6586X is not set
# CONFIG_RTC_DRV_TPS65910 is not set
# CONFIG_RTC_DRV_TPS80031 is not set
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DS1685_PROC_REGS=y
CONFIG_RTC_DS1685_SYSFS_REGS=y
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=y

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=y
CONFIG_INTEL_MIC_X100_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
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
# CONFIG_GOLDFISH_BUS is not set
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_NXP is not set
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_HWSPINLOCK=y

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
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
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
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
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
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=y
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
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=y
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_BRIDGE is not set
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_SCOM is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
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
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
CONFIG_OCFS2_FS=y
CONFIG_OCFS2_FS_O2CB=y
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
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
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set

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
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
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
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
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
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_UBSAN_NULL is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
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
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
# CONFIG_UNWINDER_ORC is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_LSM_MMAP_MIN_ADDR=65536
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_SECURITY_SELINUX=y
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
CONFIG_SECURITY_SELINUX_DISABLE=y
# CONFIG_SECURITY_SELINUX_DEVELOP is not set
# CONFIG_SECURITY_SELINUX_AVC_STATS is not set
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
CONFIG_SECURITY_SMACK=y
# CONFIG_SECURITY_SMACK_BRINGUP is not set
# CONFIG_SECURITY_SMACK_APPEND_SIGNALS is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENABLED=y
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_INTEGRITY_AUDIT is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
CONFIG_DEFAULT_SECURITY_SMACK=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="smack"
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
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

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
# CONFIG_CRYPTO_KEYWRAP is not set

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
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
# CONFIG_CRYPTO_MD4 is not set
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
# CONFIG_CRYPTO_SHA256_MB is not set
# CONFIG_CRYPTO_SHA512_MB is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
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
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
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
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
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
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
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
CONFIG_XXHASH=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
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
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_RADIX_TREE_MULTIORDER=y
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
CONFIG_CORDIC=y
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

--=_5abb446e.HmcMFJTSiEaMHH03YI+CSahTaVIhOtfwLsa+GJGYT2IZH70a--
