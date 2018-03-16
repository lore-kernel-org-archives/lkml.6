Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeCPKud (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:50:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeCPKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:50:30 -0400
Date: Fri, 16 Mar 2018 11:50:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>, tglx@linutronix.de,
        Dmitry.Prohorov@intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.weaver@maine.edu, kan.liang@intel.com, eranian@google.com,
        davidcc@google.com, valery.cherepennikov@intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [PATCH] perf: Fix sibling iteration
Message-ID: <20180316105017.GD4064@hirez.programming.kicks-ass.net>
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
 <20180315170129.GX4043@hirez.programming.kicks-ass.net>
 <0be54adb-a7be-cd2f-dfcb-4166dfe432ea@linux.intel.com>
 <20180316103129.GC4064@hirez.programming.kicks-ass.net>
 <20180316103946.GA6960@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316103946.GA6960@krava>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:39:46AM +0100, Jiri Olsa wrote:
> On Fri, Mar 16, 2018 at 11:31:29AM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 16, 2018 at 12:59:34PM +0300, Alexey Budankov wrote:
> > > Hi,
> > > On 15.03.2018 20:01, Peter Zijlstra wrote:
> > > > Subject: perf: Fix sibling iteration
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > > Date: Thu Mar 15 17:36:56 CET 2018
> > > > 
> > > > Mark noticed that the change to sibling_list changed some iteration
> > > > semantics; because previously we used group_list as list entry,
> > > > sibling events would always have an empty sibling_list.
> > > > 
> > > > But because we now use sibling_list for both list head and list entry,
> > > > siblings will report as having siblings.
> > > > 
> > > > Fix this with a custom for_each_sibling_event() iterator.
> > > > 
> > > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > > > Fixes: 8343aae66167 ("perf/core: Remove perf_event::group_entry")
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > 
> > > Applied to tip repo and run testing on Fedora 27/x86_64 (client skylake 8 cores):
> > 
> > There is at least one more known issue with that patch, but neither Mark
> > nor me could reproduce so far, so we don't know if we're right about the
> > cause.
> 
> is there more info about that issue? I could try it

Find below, 0day report didn't go out to lkml. We think moving the
list_del_init() out from the !RB_NODE_EMPTY() test might fix, but since
we can't repro so far, its all guesses.

---

From: kernel test robot <fengguang.wu@intel.com>

--nc77mklvjeziman5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

commit 8343aae66167df6708128a778e750d48dbe31302
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon Nov 13 14:28:33 2017 +0100
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Mon Mar 12 15:28:49 2018 +0100

    perf/core: Remove perf_event::group_entry
    
    Now that all the grouping is done with RB trees, we no longer need
    group_entry and can replace the whole thing with sibling_list.
    
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Acked-by: Mark Rutland <mark.rutland@arm.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: David Carrillo-Cisneros <davidcc@google.com>
    Cc: Dmitri Prokhorov <Dmitry.Prohorov@intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Kan Liang <kan.liang@intel.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Valery Cherepennikov <valery.cherepennikov@intel.com>
    Cc: Vince Weaver <vincent.weaver@maine.edu>
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

1cac7b1ae3  perf/core: Fix event schedule order
8343aae661  perf/core: Remove perf_event::group_entry
71b7a51644  Add linux-next specific files for 20180314
+----------------------------------------------------+------------+------------+---------------+
|                                                    | 1cac7b1ae3 | 8343aae661 | next-20180314 |
+----------------------------------------------------+------------+------------+---------------+
| boot_successes                                     | 591        | 194        | 37            |
| boot_failures                                      | 3          | 14         | 1             |
| Mem-Info                                           | 3          |            |               |
| WARNING:at_kernel/events/core.c:#perf_group_detach | 0          | 5          | 1             |
| EIP:perf_group_detach                              | 0          | 14         | 1             |
| BUG:unable_to_handle_kernel                        | 0          | 14         | 1             |
| Oops:#[##]                                         | 0          | 14         | 1             |
| Kernel_panic-not_syncing:Fatal_exception           | 0          | 14         | 1             |
+----------------------------------------------------+------------+------------+---------------+

[   59.787647] trinity-c1 uses obsolete (PF_INET,SOCK_PACKET)
[   70.624113] rcu-torture: rtc: 5fb1edf0 ver: 4620 tfle: 0 rta: 4620 rtaf: 0 rtf: 4611 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3211 barrier: 0/0:0 cbflood: 31
[   70.626491] rcu-torture: Reader Pipe:  3515778 0 0 0 0 0 0 0 0 0 0
[   70.627483] rcu-torture: Reader Batch:  0 3515778 0 0 0 0 0 0 0 0 0
[   70.628691] rcu-torture: Free-Block Circulation:  4619 4619 4618 4617 4616 4615 4614 4613 4612 4611 0
[   72.812997] WARNING: CPU: 0 PID: 1449 at kernel/events/core.c:1929 perf_group_detach+0x15f/0x1d0
[   72.816596] Modules linked in:
[   72.817084] CPU: 0 PID: 1449 Comm: trinity-c3 Not tainted 4.16.0-rc4-00162-g8343aae #1
[   72.818178] EIP: perf_group_detach+0x15f/0x1d0
[   72.818789] EFLAGS: 00010883 CPU: 0
[   72.819328] EAX: 00000001 EBX: 00000001 ECX: cf343900 EDX: 00000000
[   72.820246] ESI: 6b6b6b63 EDI: cf2d57a0 EBP: cf957e58 ESP: cf957e3c
[   72.821123]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[   72.821957] CR0: 80050033 CR2: 47f8704b CR3: 0f881000 CR4: 000406d0
[   72.822849] DR0: b6d7c000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   72.842464] DR6: ffff0ff0 DR7: 00000600
[   72.843026] Call Trace:
[   72.843414]  perf_remove_from_context+0x9a/0xc0
[   72.844121]  perf_event_release_kernel+0x214/0x3e0
[   72.844806]  ? _raw_spin_unlock+0x8/0x10
[   72.845376]  ? locks_remove_file+0x219/0x230
[   72.846093]  perf_release+0xe/0x20
[   72.846592]  __fput+0x1b6/0x330
[   72.847037]  ____fput+0x8/0x10
[   72.847519]  task_work_run+0x97/0xc0
[   72.848083]  do_exit+0x6c9/0x1220
[   72.848590]  do_group_exit+0x96/0x110
[   72.849143]  SyS_exit_group+0x11/0x20
[   72.849665]  do_fast_syscall_32+0x24f/0x480
[   72.850252]  entry_SYSENTER_32+0x53/0x86
[   72.867675] EIP: 0xb7f6dc95
[   72.868119] EFLAGS: 00000296 CPU: 0
[   72.868658] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[   72.869611] ESI: fffffff9 EDI: 0000ffeb EBP: 00000020 ESP: bfef5ebc
[   72.870549]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   72.871287] Code: 1f 36 ce 0f 95 c3 89 4d e8 89 da 31 c9 e8 2a 41 fb ff 8b 14 9d fc ec 3f ce 8b 4d e8 39 4d ec 8d 42 01 89 04 9d fc ec 3f ce 74 11 <0f> 0b eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 31 c9 89 da
[   72.874075] ---[ end trace 8506324d57bc7803 ]---
[   72.874802] BUG: unable to handle kernel paging request at 6b6b6b6b

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 18a103cf46c2da85073efa97fe76659b6712f429 fc6eabbbf8ef99efed778dd5afabc83c21dba585 --
git bisect  bad 1c8719e49dc7b3181100e94e0d7567e4c4b0a39a  # 17:55  B     23     1    0   0  Merge branch 'perf/core'
git bisect good 3864ccdffaa259f95fecd7f5da87c69adbe78030  # 18:34  G    200     0    5   5  Merge branch 'efi/core'
git bisect good 3c72f1aa962ab7bdfe6f66d4cb50d48a7c77c0c0  # 19:04  G    195     0    6   6  Merge branch 'irq/core'
git bisect good f9fa2816263e020dcdb361052db3bb6365c7eb44  # 19:40  G    202     0    1   1  Merge branch 'irq/urgent'
git bisect good 1237b8ab58700b577722c982eb9df54175db927d  # 20:27  G    195     0    5   8  Merge branch 'locking/core'
git bisect good 55b4ce61a2a1608881ef7eab8a4e3fab3718dc4d  # 20:59  G    196     0    7   7  Merge tag 'perf-core-for-mingo-4.17-20180305' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
git bisect good 8ef278bb9305e1269f236013718801fe06a183d1  # 21:30  G    195     0    5   5  perf report: Fix the output for stdio events list
git bisect good fbf8a1e12c3ba3afdf0804bc80f5f13dfec1cffe  # 22:07  G    197     0    7   7  Merge tag 'perf-core-for-mingo-4.17-20180308' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
git bisect  bad 8d5bce0c37fa10f21dbdd6a6d8fcba85202fe24e  # 22:29  B     47     2    1   1  perf/core: Optimize perf_rotate_context() event scheduling
git bisect good 1cac7b1ae3579457200213303fc28ca13b75592f  # 22:55  G    203     0    2   2  perf/core: Fix event schedule order
git bisect  bad 6668128a9e25f7a11d25359e46df2541e6b43fc9  # 23:05  B     13     1    2   2  perf/core: Optimize ctx_sched_out()
git bisect  bad 8343aae66167df6708128a778e750d48dbe31302  # 23:26  B      1     2    1   1  perf/core: Remove perf_event::group_entry
# first bad commit: [8343aae66167df6708128a778e750d48dbe31302] perf/core: Remove perf_event::group_entry
git bisect good 1cac7b1ae3579457200213303fc28ca13b75592f  # 00:06  G    585     0    8  10  perf/core: Fix event schedule order
# extra tests with debug options
git bisect  bad 8343aae66167df6708128a778e750d48dbe31302  # 00:22  B     19     1    0   0  perf/core: Remove perf_event::group_entry
# extra tests on HEAD of tip/master
git bisect  bad 18a103cf46c2da85073efa97fe76659b6712f429  # 00:22  B     10     2    0   0  Merge branch 'x86/pti'
# extra tests on tree/branch linux-next/master
git bisect  bad 71b7a5164471c2e42e870bdbcca3176d9a9b281c  # 00:25  B      1     1    0   0  Add linux-next specific files for 20180314

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--nc77mklvjeziman5
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-13:20180314232600:i386-randconfig-s0-201810:4.16.0-rc4-00162-g8343aae:1.gz"
Content-Transfer-Encoding: base64

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
898bpiuLYihTR9fvUKz9D4pdd2kkywAA

--nc77mklvjeziman5
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-20:20180314235746:i386-randconfig-s0-201810:4.16.0-rc4-00161-g1cac7b1:1.gz"
Content-Transfer-Encoding: base64

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
AA==

--nc77mklvjeziman5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vp-13:20180314232600:i386-randconfig-s0-201810:4.16.0-rc4-00162-g8343aae:1"

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
	-m 296
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

--nc77mklvjeziman5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-rc4-00162-g8343aae"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.16.0-rc4 Kernel Configuration
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
CONFIG_PGTABLE_LEVELS=2
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
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
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
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
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
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
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
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
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
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
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
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

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
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
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
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
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
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# CONFIG_GCOV_FORMAT_AUTODETECT is not set
# CONFIG_GCOV_FORMAT_3_4 is not set
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

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
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=m
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
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
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
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
# CONFIG_X86_PPRO_FENCE is not set
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_ANCIENT_MCE=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=y
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
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
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=m
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
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
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
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
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=y
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

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
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_I82365=m
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
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
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
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
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
CONFIG_DMASCC=m
CONFIG_SCC=m
# CONFIG_SCC_DELAY is not set
# CONFIG_SCC_TRXECHO is not set
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_CALC_BITTIMING is not set
# CONFIG_CAN_LEDS is not set
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
CONFIG_CAN_SOFTING=m
CONFIG_CAN_SOFTING_CS=m

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
CONFIG_CAN_MCP251X=m

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_8DEV_USB is not set
CONFIG_CAN_MCBA_USB=m
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
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
CONFIG_NET_9P=m
# CONFIG_NET_9P_VIRTIO is not set
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=m
CONFIG_MAY_USE_DEVLINK=m

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
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_BLK_SCSI=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_FCLOOP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_AD525X_DPOT_SPI is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_MISC_RTSX is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
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
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
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
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set

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
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
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
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

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
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_HTCPEN=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
# CONFIG_TOUCHSCREEN_USB_3M is not set
# CONFIG_TOUCHSCREEN_USB_ITM is not set
CONFIG_TOUCHSCREEN_USB_ETURBO=y
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
# CONFIG_TOUCHSCREEN_USB_DMC_TSC10 is not set
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
CONFIG_TOUCHSCREEN_USB_ELO=y
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
# CONFIG_TOUCHSCREEN_USB_ETT_TC45USB is not set
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_RM_TS=m
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=m
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SUR40=m
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_BMA150=m
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_KXTJ9_POLLED_MODE=y
CONFIG_INPUT_POWERMATE=m
# CONFIG_INPUT_YEALINK is not set
CONFIG_INPUT_CM109=m
# CONFIG_INPUT_RETU_PWRBUTTON is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF50633_PMU is not set
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
# CONFIG_INPUT_ADXL34X_SPI is not set
CONFIG_INPUT_IMS_PCU=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
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
CONFIG_DEVMEM=y
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
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=m
CONFIG_DTLK=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

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
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PCA_ISA=m
# CONFIG_SCx200_ACB is not set
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
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_OC_TINY=m
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=m
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPMI=m
# CONFIG_HSI is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=m
CONFIG_PINCTRL=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=m
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
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

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
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_WM8994 is not set

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
CONFIG_GPIO_MAX3191X=m
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_LTC3651=y
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=m
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

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
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
# CONFIG_SSB_SILENT is not set
CONFIG_SSB_DEBUG=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS65912=m
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8994=m
# CONFIG_REGULATOR is not set
CONFIG_CEC_CORE=m
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_VMALLOC=m
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_USB_VIDEO_CLASS is not set
# CONFIG_USB_GSPCA is not set
CONFIG_USB_PWC=m
CONFIG_USB_PWC_DEBUG=y
# CONFIG_USB_PWC_INPUT_EVDEV is not set
CONFIG_VIDEO_CPIA2=m
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set

#
# Analog/digital TV USB devices
#

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# USB HDMI CEC adapters
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_SH_VEU=m
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIMC is not set
# CONFIG_VIDEO_VIVID is not set
# CONFIG_VIDEO_VIM2M is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m

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
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_TLV320AIC23B=m
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV7604=m
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=m
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_AD5820=m
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=m
CONFIG_VIDEO_ADV7511=m
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AD9389B=m
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
CONFIG_VIDEO_IMX274=m
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV5647=m
# CONFIG_VIDEO_OV6650 is not set
CONFIG_VIDEO_OV5670=m
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_OV7740=m
CONFIG_VIDEO_OV9650=m
# CONFIG_VIDEO_OV13858 is not set
CONFIG_VIDEO_VS6624=m
CONFIG_VIDEO_MT9M032=m
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9P031=m
CONFIG_VIDEO_MT9T001=m
CONFIG_VIDEO_MT9V011=m
# CONFIG_VIDEO_MT9V032 is not set
CONFIG_VIDEO_SR030PC30=m
CONFIG_VIDEO_NOON010PC30=m
CONFIG_VIDEO_M5MOLS=m
# CONFIG_VIDEO_S5K6AA is not set
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_S5K4ECGX=m
CONFIG_VIDEO_S5K5BAF=m
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
# CONFIG_VIDEO_LM3560 is not set
CONFIG_VIDEO_LM3646=m

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#

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
CONFIG_VIDEO_GS1662=m
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set

#
# Customise DVB Frontends
#

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
CONFIG_DRM=m
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
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
CONFIG_DRM_VIRTIO_GPU=m
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
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_TINYDRM_REPAPER=m
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=m
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
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
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
# CONFIG_FB_OPENCORES is not set
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
CONFIG_FB_SM501=m
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_VGASTATE is not set
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
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
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=m
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
CONFIG_USB_XHCI_PLATFORM=m
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=m
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_SL811_CS is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_USB_HCD_SSB=m
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
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
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_UDC=y
# CONFIG_USB_CHIPIDEA_ULPI is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=m
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=m
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=m
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=m
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=m
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=m
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_UVC=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_HID=y
CONFIG_USB_CONFIGFS_F_UVC=y
CONFIG_USB_CONFIGFS_F_PRINTER=y
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=m
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=m
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_DA9052=m
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
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
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABX80X=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=m
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV8803=m

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=y
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=m
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=m

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
CONFIG_RTC_DRV_DS17885=y
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=y

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_IRDA is not set
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
CONFIG_NCP_FS=y
# CONFIG_NCPFS_PACKET_SIGNING is not set
CONFIG_NCPFS_IOCTL_LOCKING=y
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=y
# CONFIG_COMEDI_RTI802 is not set
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=m
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=y
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
# CONFIG_COMEDI_FL512 is not set
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
CONFIG_COMEDI_II_PCI20KC=y
CONFIG_COMEDI_C6XDIGIO=y
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
# CONFIG_COMEDI_NI_AT_A2150 is not set
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
# CONFIG_COMEDI_PCMDA12 is not set
# CONFIG_COMEDI_PCMMIO is not set
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
# CONFIG_COMEDI_CB_DAS16_CS is not set
CONFIG_COMEDI_DAS08_CS=m
# CONFIG_COMEDI_NI_DAQ_700_CS is not set
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
# CONFIG_COMEDI_NI_USB6501 is not set
# CONFIG_COMEDI_USBDUX is not set
CONFIG_COMEDI_USBDUXFAST=m
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
CONFIG_COMEDI_NI_TIO=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y

#
# Android
#
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_FB_TFT=m
# CONFIG_FB_TFT_AGM1264K_FL is not set
# CONFIG_FB_TFT_BD663474 is not set
CONFIG_FB_TFT_HX8340BN=m
CONFIG_FB_TFT_HX8347D=m
# CONFIG_FB_TFT_HX8353D is not set
CONFIG_FB_TFT_HX8357D=m
# CONFIG_FB_TFT_ILI9163 is not set
# CONFIG_FB_TFT_ILI9320 is not set
CONFIG_FB_TFT_ILI9325=m
CONFIG_FB_TFT_ILI9340=m
CONFIG_FB_TFT_ILI9341=m
CONFIG_FB_TFT_ILI9481=m
# CONFIG_FB_TFT_ILI9486 is not set
CONFIG_FB_TFT_PCD8544=m
# CONFIG_FB_TFT_RA8875 is not set
CONFIG_FB_TFT_S6D02A1=m
CONFIG_FB_TFT_S6D1121=m
# CONFIG_FB_TFT_SH1106 is not set
# CONFIG_FB_TFT_SSD1289 is not set
CONFIG_FB_TFT_SSD1305=m
# CONFIG_FB_TFT_SSD1306 is not set
# CONFIG_FB_TFT_SSD1331 is not set
CONFIG_FB_TFT_SSD1351=m
# CONFIG_FB_TFT_ST7735R is not set
# CONFIG_FB_TFT_ST7789V is not set
CONFIG_FB_TFT_TINYLCD=m
CONFIG_FB_TFT_TLS8204=m
# CONFIG_FB_TFT_UC1611 is not set
CONFIG_FB_TFT_UC1701=m
CONFIG_FB_TFT_UPD161704=m
# CONFIG_FB_TFT_WATTEROTT is not set
# CONFIG_FB_FLEX is not set
CONFIG_FB_TFT_FBTFT_DEVICE=m
CONFIG_MOST=m
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_NET is not set
CONFIG_MOST_VIDEO=m
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
# CONFIG_MOST_USB is not set
CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
# CONFIG_GREYBUS_RAW is not set
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_TYPEC_TCPCI is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_PI433=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
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
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_MLX_PLATFORM=y
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PWM is not set
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
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=m
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
CONFIG_RESET_TI_SYSCON=m
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=m
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=m
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
CONFIG_PHY_TUSB1210=m
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=y
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=m
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=y
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
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
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y

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
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

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
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
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
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
CONFIG_PREEMPTIRQ_EVENTS=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
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
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
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
CONFIG_CRYPTO_ECDH=m
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
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=y

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
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=m
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_586 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
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
CONFIG_CRYPTO_DEV_VIRTIO=y
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
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
CONFIG_BINARY_PRINTF=y

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
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
CONFIG_STRING_SELFTEST=y

--nc77mklvjeziman5--
