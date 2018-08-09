Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBA4C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33762239B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33762239B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeHJBB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:01:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:46278 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeHJBB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:01:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 15:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="gz'50?scan'50,208,50";a="80444921"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2018 15:34:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fntVP-0003eW-QC; Fri, 10 Aug 2018 06:34:07 +0800
Date:   Fri, 10 Aug 2018 06:33:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: a13c600e15 ("x86/mm/pti: Move user W+X check into .."):  WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page
Message-ID: <5b6cc146.lVmfvLKHKgZxC5d8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5b6cc146.U8hLVbO2k8dYhO5fMmGe93zK66Q/sYXw/enFqpf9S6grbMmN"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5b6cc146.U8hLVbO2k8dYhO5fMmGe93zK66Q/sYXw/enFqpf9S6grbMmN
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti

commit a13c600e15de44ccf03df28d3311ef3cb754ed9b
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed Aug 8 13:16:40 2018 +0200
Commit:     Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu Aug 9 20:42:07 2018 +0200

    x86/mm/pti: Move user W+X check into pti_finalize()
    
    The user page-table gets the updated kernel mappings in pti_finalize(),
    which runs after the RO+X permissions got applied to the kernel page-table
    in mark_readonly().
    
    But with CONFIG_DEBUG_WX enabled, the user page-table is already checked in
    mark_readonly() for insecure mappings.  This causes false-positive
    warnings, because the user page-table did not get the updated mappings yet.
    
    Move the W+X check for the user page-table into pti_finalize() after it
    updated all required mappings.
    
    Signed-off-by: Joerg Roedel <jroedel@suse.de>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: "H . Peter Anvin" <hpa@zytor.com>
    Cc: linux-mm@kvack.org
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Andy Lutomirski <luto@kernel.org>
    Cc: Dave Hansen <dave.hansen@intel.com>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Juergen Gross <jgross@suse.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Jiri Kosina <jkosina@suse.cz>
    Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
    Cc: Brian Gerst <brgerst@gmail.com>
    Cc: David Laight <David.Laight@aculab.com>
    Cc: Denys Vlasenko <dvlasenk@redhat.com>
    Cc: Eduardo Valentin <eduval@amazon.com>
    Cc: Greg KH <gregkh@linuxfoundation.org>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: aliguori@amazon.com
    Cc: daniel.gruss@iaik.tugraz.at
    Cc: hughd@google.com
    Cc: keescook@google.com
    Cc: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Waiman Long <llong@redhat.com>
    Cc: Pavel Machek <pavel@ucw.cz>
    Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
    Cc: joro@8bytes.org
    Link: https://lkml.kernel.org/r/1533727000-9172-1-git-send-email-joro@8bytes.org

a29dba161a  x86/relocs: Add __end_rodata_aligned to S_REL
a13c600e15  x86/mm/pti: Move user W+X check into pti_finalize()
81540b5937  Merge branch 'x86/pti'
+-----------------------------------------------------+------------+------------+------------+
|                                                     | a29dba161a | a13c600e15 | 81540b5937 |
+-----------------------------------------------------+------------+------------+------------+
| boot_successes                                      | 64         | 0          | 0          |
| boot_failures                                       | 0          | 43         | 35         |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page | 0          | 43         | 35         |
| EIP:note_page                                       | 0          | 43         | 35         |
+-----------------------------------------------------+------------+------------+------------+

[    9.633348] Write protecting the kernel read-only data: 2560k
[    9.634304] rodata_test: all tests were successful
[    9.635329] x86/mm: Checking user space page tables
[    9.636271] ------------[ cut here ]------------
[    9.637045] x86/mm: Found insecure W+X mapping at address (ptrval)/0xffc01000
[    9.638228] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page+0x66b/0x870
[    9.639857] Modules linked in:
[    9.640375] CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc8-00061-ga13c600 #870
[    9.641608] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.642970] EIP: note_page+0x66b/0x870
[    9.643589] Code: c6 00 10 00 00 75 d4 e9 0b fc ff ff 8b 43 0c c7 04 24 84 f4 7c 79 c6 05 82 ff 8f 79 01 89 44 24 08 89 44 24 04 e8 15 4d 00 00 <0f> 0b e9 bb fd ff ff 83 c2 0c 89 53 14 c7 43 18 00 00 00 00 e9 0d 
[    9.646710] EAX: 00000041 EBX: 8d037f4c ECX: 790332c0 EDX: 00000201
[    9.647727] ESI: 00000000 EDI: 00000000 EBP: 8d037f24 ESP: 8d037ef4
[    9.648745] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00210286
[    9.649861] CR0: 80050033 CR2: 7961fd7c CR3: 019c2000 CR4: 00000690
[    9.650889] Call Trace:
[    9.651304]  ptdump_walk_pgd_level_core+0x25c/0x380
[    9.652109]  ? 0x79000000
[    9.652548]  ptdump_walk_user_pgd_level_checkwx+0x35/0x40
[    9.653316]  pti_finalize+0x68/0x70
[    9.653702]  ? rest_init+0xb0/0xb0
[    9.654142]  kernel_init+0x3b/0x110
[    9.654526]  ? schedule_tail_wrapper+0x9/0xc
[    9.654999]  ret_from_fork+0x2e/0x38
[    9.655392] irq event stamp: 1756564
[    9.655891] hardirqs last  enabled at (1756563): [<79080c75>] console_unlock+0x405/0x590
[    9.657293] hardirqs last disabled at (1756564): [<7960a964>] common_exception+0xf6/0x116
[    9.658747] softirqs last  enabled at (1755714): [<7960b091>] __do_softirq+0x1d1/0x205
[    9.660065] softirqs last disabled at (1755707): [<79012997>] call_on_stack+0x47/0x60
[    9.661267] ---[ end trace 77b3d4fa5b464bc9 ]---
[    9.662063] x86/mm: Checked W+X mappings: FAILED, 8 W+X pages found.

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start e85b2d7cff5935e546bde680af031a845e540b3e 1ffaddd029c867d134a1dde39f540dcc8c52e274 --
git bisect  bad fd42d9639f95a4efc31454eac7cfe528977460d4  # 03:24  B      0     1   29  13  Merge 'linux-review/zhouxianrong/zsmalloc-fix-linking-bug-in-init_zspage/20180810-024718' into devel-catchup-201808100258
git bisect good 33112e036381aaea4d96b0a3597d05ac8c0056c7  # 03:55  G     10     0    0   2  0day base guard for 'devel-catchup-201808100258'
git bisect  bad 8db8f8032e729ba40be9d4dfef0729c9c4ac47ba  # 04:05  B      0     1   18   2  Merge 'tip/x86/pti' into devel-catchup-201808100258
git bisect good b976690f5db26fbc7c2be413bfa0fbd270547a94  # 04:39  G     10     0   10  40  x86/mm/pti: Introduce pti_finalize()
git bisect good 6863ea0cda8725072522cd78bda332d9a0b73150  # 04:58  G     11     0   11  18  x86/mm: Remove in_nmi() warning from vmalloc_fault()
git bisect good 315706049c343794ad0d3e5b6f6b60b900457b11  # 05:06  G     11     0    1   1  Merge branch 'x86/pti-urgent' into x86/pti
git bisect good 16a3fe634f6a568c6234b8747e5d50487fed3526  # 05:15  G     11     0    1   1  x86/mm/pti: Clone kernel-image on PTE level for 32 bit
git bisect  bad a13c600e15de44ccf03df28d3311ef3cb754ed9b  # 05:23  B      0     2   21   4  x86/mm/pti: Move user W+X check into pti_finalize()
git bisect good a29dba161ad1a01bbfbc80aa184b089ddd169a4e  # 05:39  G     10     0    0   0  x86/relocs: Add __end_rodata_aligned to S_REL
# first bad commit: [a13c600e15de44ccf03df28d3311ef3cb754ed9b] x86/mm/pti: Move user W+X check into pti_finalize()
git bisect good a29dba161ad1a01bbfbc80aa184b089ddd169a4e  # 05:43  G     31     0    1   1  x86/relocs: Add __end_rodata_aligned to S_REL
# extra tests with debug options
git bisect  bad a13c600e15de44ccf03df28d3311ef3cb754ed9b  # 05:49  B      0     1   16   0  x86/mm/pti: Move user W+X check into pti_finalize()
# extra tests on HEAD of linux-devel/devel-catchup-201808100258
git bisect  bad e85b2d7cff5935e546bde680af031a845e540b3e  # 05:54  B      0    34   53   0  0day head guard for 'devel-catchup-201808100258'
# extra tests on tree/branch tip/x86/pti
git bisect  bad a13c600e15de44ccf03df28d3311ef3cb754ed9b  # 06:07  B      0    42   57   0  x86/mm/pti: Move user W+X check into pti_finalize()
# extra tests with first bad commit reverted
git bisect good ada51a550192bf1d3842d0e8b9335a56d062049a  # 06:22  G     11     0    0   0  Revert "x86/mm/pti: Move user W+X check into pti_finalize()"
# extra tests on tree/branch tip/master
git bisect  bad 81540b5937465348e9e623555e1c1e9dc7cf4434  # 06:27  B      0     3   36  18  Merge branch 'x86/pti'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5b6cc146.U8hLVbO2k8dYhO5fMmGe93zK66Q/sYXw/enFqpf9S6grbMmN
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-ivb41-100:20180810052309:i386-randconfig-a0-201831:4.18.0-rc8-00061-ga13c600:870.gz"

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

--=_5b6cc146.U8hLVbO2k8dYhO5fMmGe93zK66Q/sYXw/enFqpf9S6grbMmN
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-ivb41-48:20180810054140:i386-randconfig-a0-201831:4.18.0-rc8-00060-ga29dba1:874.gz"

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

--=_5b6cc146.U8hLVbO2k8dYhO5fMmGe93zK66Q/sYXw/enFqpf9S6grbMmN
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-ivb41-100:20180810052309:i386-randconfig-a0-201831:4.18.0-rc8-00061-ga13c600:870"

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
	-m 369
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

--=_5b6cc146.U8hLVbO2k8dYhO5fMmGe93zK66Q/sYXw/enFqpf9S6grbMmN
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.18.0-rc8-00061-ga13c600"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.18.0-rc8 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40904
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
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
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
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
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
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
CONFIG_SECCOMP_FILTER=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=m
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
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
CONFIG_PARAVIRT_DEBUG=y
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
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
CONFIG_MCRUSOE=y
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
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
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
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=m
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_2G_OPT=y
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x78000000
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
CONFIG_SPLIT_PTLOCK_CPUS=4
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
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
# CONFIG_ZBUD is not set
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
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
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_TEST_SUSPEND=y
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
# CONFIG_ACPI_IPMI is not set
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
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

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
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
CONFIG_PCI_GOMMCONFIG=y
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
# CONFIG_PCIE_CADENCE_HOST is not set
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCIE_DW_PLAT=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCIE_DW_PLAT_EP=y

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_SCx200=m
# CONFIG_SCx200HR_TIMER is not set
CONFIG_OLPC=y
CONFIG_OLPC_XO1_PM=y
# CONFIG_OLPC_XO15_SCI is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
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
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
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
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
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
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

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
# CONFIG_FAILOVER is not set
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
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
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
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=m
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
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
# CONFIG_MTD_RAM is not set
CONFIG_MTD_ROM=y
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=m
CONFIG_MTD_PCMCIA_ANONYMOUS=y
# CONFIG_MTD_GPIO_ADDR is not set
CONFIG_MTD_INTEL_VR_NOR=m
# CONFIG_MTD_PLATRAM is not set
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
# CONFIG_MTD_PMC551_BUGFIX is not set
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
# CONFIG_MTD_M25P80 is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=m
# CONFIG_MTD_MT81xx_NOR is not set
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
CONFIG_SPI_INTEL_SPI_PCI=m
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
# CONFIG_OF_DYNAMIC is not set
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=m
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_CS5535_MFGPT is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=m
CONFIG_VMWARE_BALLOON=m
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=m
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
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
CONFIG_ECHO=m
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
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
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
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
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
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
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
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
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
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
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
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
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
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
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
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
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
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
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=m
CONFIG_KEYBOARD_LKKBD=m
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=m
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_OMAP4=m
CONFIG_KEYBOARD_TC3589X=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_KEYBOARD_CAP11XX=m
CONFIG_KEYBOARD_BCM=m
CONFIG_KEYBOARD_MTK_PMIC=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
# CONFIG_MOUSE_PS2_ELANTECH_SMBUS is not set
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_PS2_OLPC is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PSXPAD_SPI=m
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
CONFIG_JOYSTICK_PXRC=m
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
# CONFIG_TABLET_USB_AIPTEK is not set
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_PEGASUS=m
CONFIG_TABLET_SERIAL_WACOM4=m
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_OLPC_APSP=m
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
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
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=m
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=m
CONFIG_DTLK=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
CONFIG_SONYPI=m

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=m
CONFIG_XILLYBUS_OF=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=m
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
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
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
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=m
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_DLN2 is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_PALMAS=m
CONFIG_PINCTRL_RK805=m
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
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=m

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CS5535=m
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_TC3589X is not set
# CONFIG_GPIO_TIMBERDALE is not set
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_UCB1400=m
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=m
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
CONFIG_W1=m

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=m
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_OLPC=m
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=m
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9052=m
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=y
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_QORIQ_THERMAL=m
# CONFIG_DA9062_THERMAL is not set
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=m
# CONFIG_MFD_CROS_EC_I2C is not set
# CONFIG_MFD_CROS_EC_SPI is not set
CONFIG_MFD_CROS_EC_CHARDEV=m
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=m
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=m
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=m
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TC3589X=y
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=m
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_CPCAP=m
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9052=m
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=m
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RK808=m
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS65218 is not set
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TPS80031 is not set
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8400=m
CONFIG_REGULATOR_WM8994=y
CONFIG_RC_CORE=m
# CONFIG_RC_MAP is not set
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
# CONFIG_IR_ENE is not set
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IMON=m
CONFIG_IR_IMON_RAW=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_REDRAT3=m
# CONFIG_IR_SPI is not set
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
CONFIG_IR_GPIO_CIR=m
CONFIG_IR_GPIO_TX=m
# CONFIG_IR_PWM_TX is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_V4L2_FWNODE=y

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=m
# CONFIG_VIDEO_TW5864 is not set
CONFIG_VIDEO_TW68=m
# CONFIG_VIDEO_TW686X is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_CYPRESS_FIRMWARE=m
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
# CONFIG_VIDEO_IR_I2C is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=m
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=y

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
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_AD5820=m
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=m
CONFIG_VIDEO_OV2685=m
CONFIG_VIDEO_OV6650=m
# CONFIG_VIDEO_OV5695 is not set
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_SR030PC30=m

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
CONFIG_VIDEO_LM3560=y
CONFIG_VIDEO_LM3646=y

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=y
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
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=m
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=m
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=y
CONFIG_FB_GEODE_GX=m
CONFIG_FB_GEODE_GX1=y
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=m
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_S6E63M0=y
CONFIG_LCD_LD9040=y
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB16_DSP=m
# CONFIG_SND_ISA is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ALS300=m
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=m
# CONFIG_SND_ATIIXP_MODEM is not set
CONFIG_SND_AU8810=m
# CONFIG_SND_AU8820 is not set
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
CONFIG_SND_AZT3328=m
# CONFIG_SND_BT87X is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
# CONFIG_SND_OXYGEN is not set
CONFIG_SND_CS4281=m
CONFIG_SND_CS46XX=m
# CONFIG_SND_CS46XX_NEW_DSP is not set
CONFIG_SND_CS5530=m
CONFIG_SND_CS5535AUDIO=m
# CONFIG_SND_CTXFI is not set
CONFIG_SND_DARLA20=m
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
CONFIG_SND_DARLA24=m
# CONFIG_SND_GINA24 is not set
CONFIG_SND_LAYLA24=m
# CONFIG_SND_MONA is not set
CONFIG_SND_MIA=m
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
# CONFIG_SND_ES1968_INPUT is not set
CONFIG_SND_FM801=m
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_KORG1212 is not set
CONFIG_SND_LOLA=m
# CONFIG_SND_LX6464ES is not set
CONFIG_SND_MAESTRO3=m
# CONFIG_SND_MAESTRO3_INPUT is not set
# CONFIG_SND_MIXART is not set
CONFIG_SND_NM256=m
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
# CONFIG_SND_VIA82XX is not set
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
# CONFIG_SND_HDA_CODEC_CA0132 is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_SPI is not set
# CONFIG_SND_USB is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_SSI=m
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_IMX_AUDMUX=m
CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_ZX_TDM=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU1761_SPI=m
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_BD28623=m
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CPCAP=m
# CONFIG_SND_SOC_CS35L32 is not set
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
# CONFIG_SND_SOC_CS4265 is not set
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
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
# CONFIG_SND_SOC_ES8328_I2C is not set
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX9860=m
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM186X_SPI=m
CONFIG_SND_SOC_PCM3168A=m
# CONFIG_SND_SOC_PCM3168A_I2C is not set
CONFIG_SND_SOC_PCM3168A_SPI=m
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=m
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=m
# CONFIG_SND_SOC_TAS6424 is not set
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
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8770=m
CONFIG_SND_SOC_WM8776=m
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=m
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8804_SPI=m
# CONFIG_SND_SOC_WM8903 is not set
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_SIMPLE_SCU_CARD=m
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_AUDIO_GRAPH_SCU_CARD=m
CONFIG_SND_X86=y
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=m
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
# CONFIG_USB_MOUSE is not set

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_OTG_FSM is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_FOTG210_HCD=m
# CONFIG_USB_MAX3421_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
CONFIG_USB_SL811_HCD=m
# CONFIG_USB_SL811_HCD_ISO is not set
# CONFIG_USB_SL811_CS is not set
CONFIG_USB_R8A66597_HCD=m
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
# CONFIG_USB_WDM is not set
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
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_OF=m
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_RIO500=m
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=m
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=m
# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_ACPI is not set
CONFIG_TYPEC_TPS6598X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_ROLE_SWITCH=m
CONFIG_UWB=y
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=y
# CONFIG_UWB_I1480U is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
# CONFIG_MMC_SDRICOH_CS is not set
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=m
# CONFIG_MMC_CQHCI is not set
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_APU=m
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_CR0014114=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=m
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=m
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8925=y
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_RK808=y
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TWL4030=m
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS80031=m
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=m
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=m
CONFIG_RTC_DRV_RS5C348=m
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=m
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=m
CONFIG_RTC_DRV_WM8350=m
# CONFIG_RTC_DRV_AB3100 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=m
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_R7301=m
CONFIG_RTC_DRV_CPCAP=m

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
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
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=m
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
# CONFIG_COMEDI_ADDI_APCI_2200 is not set
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
# CONFIG_COMEDI_ADL_PCI6208 is not set
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
# CONFIG_COMEDI_ADV_PCI1723 is not set
CONFIG_COMEDI_ADV_PCI1724=m
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
# CONFIG_COMEDI_AMPLC_PC263_PCI is not set
# CONFIG_COMEDI_AMPLC_PCI224 is not set
CONFIG_COMEDI_AMPLC_PCI230=m
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
# CONFIG_COMEDI_DYNA_PCI10XX is not set
CONFIG_COMEDI_GSC_HPDI=m
# CONFIG_COMEDI_MF6X4 is not set
# CONFIG_COMEDI_ICP_MULTI is not set
CONFIG_COMEDI_DAQBOARD2000=m
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
# CONFIG_COMEDI_CB_PCIDAS64 is not set
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
# CONFIG_COMEDI_ME_DAQ is not set
CONFIG_COMEDI_NI_6527=m
# CONFIG_COMEDI_NI_65XX is not set
# CONFIG_COMEDI_NI_660X is not set
CONFIG_COMEDI_NI_670X=m
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=m
# CONFIG_COMEDI_NI_PCIMIO is not set
CONFIG_COMEDI_RTD520=m
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
# CONFIG_COMEDI_NI_MIO_CS is not set
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
CONFIG_COMEDI_NI_USB6501=m
CONFIG_COMEDI_USBDUX=m
# CONFIG_COMEDI_USBDUXFAST is not set
CONFIG_COMEDI_USBDUXSIGMA=m
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_FB_OLPC_DCON=m
CONFIG_FB_OLPC_DCON_1=y
CONFIG_FB_OLPC_DCON_1_5=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
CONFIG_FB_SM750=m
CONFIG_FB_XGI=m

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y
# CONFIG_VIDEO_ZORAN is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ANDROID_VSOC=m
# CONFIG_ION is not set
CONFIG_STAGING_BOARD=y
# CONFIG_LTE_GDM724X is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=m
# CONFIG_UNISYSSPAR is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_FB_TFT=y
# CONFIG_FB_TFT_AGM1264K_FL is not set
# CONFIG_FB_TFT_BD663474 is not set
CONFIG_FB_TFT_HX8340BN=m
CONFIG_FB_TFT_HX8347D=y
CONFIG_FB_TFT_HX8353D=m
CONFIG_FB_TFT_HX8357D=y
CONFIG_FB_TFT_ILI9163=m
CONFIG_FB_TFT_ILI9320=y
# CONFIG_FB_TFT_ILI9325 is not set
CONFIG_FB_TFT_ILI9340=m
CONFIG_FB_TFT_ILI9341=m
CONFIG_FB_TFT_ILI9481=y
CONFIG_FB_TFT_ILI9486=m
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
# CONFIG_FB_TFT_S6D02A1 is not set
CONFIG_FB_TFT_S6D1121=m
CONFIG_FB_TFT_SH1106=y
CONFIG_FB_TFT_SSD1289=y
# CONFIG_FB_TFT_SSD1305 is not set
CONFIG_FB_TFT_SSD1306=y
CONFIG_FB_TFT_SSD1331=m
# CONFIG_FB_TFT_SSD1351 is not set
CONFIG_FB_TFT_ST7735R=m
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
# CONFIG_FB_TFT_TLS8204 is not set
CONFIG_FB_TFT_UC1611=y
# CONFIG_FB_TFT_UC1701 is not set
CONFIG_FB_TFT_UPD161704=y
# CONFIG_FB_TFT_WATTEROTT is not set
CONFIG_FB_FLEX=y
CONFIG_FB_TFT_FBTFT_DEVICE=y
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
# CONFIG_MOST_SOUND is not set
CONFIG_MOST_VIDEO=m
# CONFIG_MOST_DIM2 is not set
# CONFIG_MOST_I2C is not set
# CONFIG_MOST_USB is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=y
# CONFIG_GREYBUS_ES2 is not set
CONFIG_GREYBUS_AUDIO=y
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_HID=m
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
# CONFIG_GREYBUS_GPIO is not set
# CONFIG_GREYBUS_I2C is not set
# CONFIG_GREYBUS_PWM is not set
# CONFIG_GREYBUS_SDIO is not set
CONFIG_GREYBUS_SPI=m
# CONFIG_GREYBUS_UART is not set
# CONFIG_GREYBUS_USB is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
CONFIG_PI433=y
CONFIG_MTK_MMC=m
CONFIG_MTK_AEE_KDUMP=y
CONFIG_MTK_MMC_CD_POLL=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_SMM=y
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=m
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
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=m
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_CTL=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=m
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_RK808=m
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=m
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=m
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_CLK_TWL6040=m
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_INTEL_IOMMU is not set

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
# CONFIG_EXTCON_ARIZONA is not set
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=m
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m
CONFIG_FMC=m
# CONFIG_FMC_FAKEDEV is not set
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=m
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_QCOM_USB_HS=m
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_TUSB1210=m
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# CONFIG_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_DUMMY=m
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=m
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_SCOM is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
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
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
CONFIG_OVERLAY_FS_XINO_AUTO=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
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
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
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
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
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
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
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
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
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
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
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
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
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
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
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
CONFIG_CRYPTO_AKCIPHER=m
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=m
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_AEGIS128L=y
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_MORUS640=m
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=m
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

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
CONFIG_CRC16=m
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
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
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=m
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=m
CONFIG_FONT_SUPPORT=m
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_HAS_SG_CHAIN=y
# CONFIG_STRING_SELFTEST is not set

--=_5b6cc146.U8hLVbO2k8dYhO5fMmGe93zK66Q/sYXw/enFqpf9S6grbMmN--
