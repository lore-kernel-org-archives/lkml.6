Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLACK,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D29B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB820873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDB820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeG3LdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:33:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48528 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbeG3LdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:33:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8819AFB1;
        Mon, 30 Jul 2018 09:58:39 +0000 (UTC)
Date:   Mon, 30 Jul 2018 11:58:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     yuzhoujian <yuzhoujian@didichuxing.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [mm, oom]  063b8b3171:
 BUG:sleeping_function_called_from_invalid_context_at_arch/x86/mm/fault.c
Message-ID: <20180730095838.GJ24267@dhcp22.suse.cz>
References: <20180730091133.GE30690@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730091133.GE30690@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be the same issue as http://lkml.kernel.org/r/20180730090320.GD30690@shao2-debian
AFAICS.

On Mon 30-07-18 17:11:33, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-4.9):
> 
> commit: 063b8b31719dbe80c0f4acd914d10794bfb83f1d ("mm, oom: reorganize the oom report in dump_header")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu Haswell,+smep,+smap -m 360M
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------------------------------------+------------+------------+
> |                                                                          | 147474fc72 | 063b8b3171 |
> +--------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                           | 4          | 4          |
> | boot_failures                                                            | 9          | 9          |
> | invoked_oom-killer:gfp_mask=0x                                           | 9          | 9          |
> | Mem-Info                                                                 | 9          | 9          |
> | Out_of_memory:Kill_process                                               | 9          | 9          |
> | EIP:copy_fpstate_to_sigframe                                             | 1          |            |
> | Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes         | 8          |            |
> | EIP:__copy_user_ll                                                       | 4          | 4          |
> | BUG:sleeping_function_called_from_invalid_context_at_arch/x86/mm/fault.c | 0          | 9          |
> | EIP:dump_header                                                          | 0          | 9          |
> | BUG:unable_to_handle_kernel                                              | 0          | 9          |
> | Oops:#[##]                                                               | 0          | 9          |
> | Kernel_panic-not_syncing:Fatal_exception                                 | 0          | 9          |
> +--------------------------------------------------------------------------+------------+------------+
> 
> 
> 
> [   19.139974] BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1340
> [   19.143410] in_atomic(): 0, irqs_disabled(): 0, pid: 440, name: run-lkp
> [   19.144147] 4 locks held by run-lkp/440:
> [   19.144592]  #0: (ptrval) (&mm->mmap_sem){....}, at: __do_page_fault+0x104/0x5c0
> [   19.145415]  #1: (ptrval) (oom_lock){....}, at: __alloc_pages_nodemask+0x6ee/0xa80
> [   19.146249]  #2: (ptrval) (rcu_read_lock){....}, at: dump_header+0x0/0x294
> [   19.147018]  #3: (ptrval) (&mm->mmap_sem){....}, at: __do_page_fault+0x104/0x5c0
> [   19.147839] Preemption disabled at:
> [   19.147843] [<8103b3aa>] __do_page_fault+0x27a/0x5c0
> [   19.148791] CPU: 0 PID: 440 Comm: run-lkp Tainted: G                T 4.18.0-rc6-00311-g063b8b3 #1
> [   19.149775] Call Trace:
> [   19.160769]  dump_stack+0x16/0x26
> [   19.161159]  ___might_sleep+0x13c/0x190
> [   19.161594]  ? __do_page_fault+0x27a/0x5c0
> [   19.162048]  ? __do_page_fault+0x27a/0x5c0
> [   19.162514]  __might_sleep+0x31/0x90
> [   19.162915]  ? down_read_trylock+0x5c/0x70
> [   19.163380]  __do_page_fault+0x11d/0x5c0
> [   19.163815]  ? preempt_count_add+0x4a/0xb0
> [   19.164286]  ? kvm_read_and_reset_pf_reason+0x50/0x50
> [   19.164841]  do_page_fault+0x21/0x30
> [   19.165242]  do_async_page_fault+0x28/0xa0
> [   19.165711]  common_exception+0x45/0x4a
> [   19.166138] EIP: dump_header+0x87/0x294
> [   19.166573] Code: ac dc b3 81 e8 f9 27 fa ff 83 c4 28 e8 d6 f6 fa ff 31 c9 31 d2 b8 28 84 db 81 68 7c 68 0e 81 6a 00 6a 00 6a 02 e8 dd 88 f9 ff <8b> 86 ff 09 00 00 8b 78 74 e8 8f 44 fb ff b9 7c 68 0e 81 ba 01 00 
> [   19.168739] EAX: 00000246 EBX: 85711e50 ECX: 43f73f41 EDX: 00000000
> [   19.169431] ESI: 000003ed EDI: 81c586c0 EBP: 85711db8 ESP: 85711d80
> [   19.170144] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   19.171218]  ? pagefault_out_of_memory+0x4c/0x4c
> [   19.171740]  ? oom_badness+0x5f/0x160
> [   19.172155]  out_of_memory+0x30e/0x3d0
> [   19.172584]  ? out_of_memory+0x1fb/0x3d0
> [   19.173020]  ? __alloc_pages_nodemask+0x6ee/0xa80
> [   19.173553]  __alloc_pages_nodemask+0x9b9/0xa80
> [   19.174082]  wp_page_copy+0x69/0x5c0
> [   19.174508]  do_wp_page+0x115/0x470
> [   19.174904]  handle_mm_fault+0x5a8/0xb00
> [   19.175364]  __do_page_fault+0x1a2/0x5c0
> [   19.175807]  ? filp_close+0x52/0x80
> [   19.176206]  ? kvm_read_and_reset_pf_reason+0x50/0x50
> [   19.176769]  do_page_fault+0x21/0x30
> [   19.177168]  do_async_page_fault+0x28/0xa0
> [   19.177633]  common_exception+0x45/0x4a
> [   19.178056] EIP: 0x807d20d
> [   19.178368] Code: 08 89 04 24 e8 c4 6f 03 00 8b 15 00 ad 12 08 a1 08 ad 12 08 8b 04 90 89 04 24 e8 de 45 ff ff a1 08 ad 12 08 8b 15 00 ad 12 08 <c7> 04 90 00 00 00 00 83 c4 1c e9 54 6f 03 00 8d 74 26 00 83 ec 1c 
> [   19.181252] EAX: 096cf6c8 EBX: 096fb5e8 ECX: 00000000 EDX: 00000002
> [   19.181949] ESI: 080f34f5 EDI: 00000000 EBP: 00000000 ESP: 7fc1c730
> [   19.182656] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
> [   19.183422] BUG: unable to handle kernel NULL pointer dereference at 00000dec
> [   19.184193] *pde = 00000000 
> [   19.184519] Oops: 0000 [#1] PREEMPT DEBUG_PAGEALLOC
> [   19.185051] CPU: 0 PID: 440 Comm: run-lkp Tainted: G        W       T 4.18.0-rc6-00311-g063b8b3 #1
> [   19.186027] EIP: dump_header+0x87/0x294
> [   19.186457] Code: ac dc b3 81 e8 f9 27 fa ff 83 c4 28 e8 d6 f6 fa ff 31 c9 31 d2 b8 28 84 db 81 68 7c 68 0e 81 6a 00 6a 00 6a 02 e8 dd 88 f9 ff <8b> 86 ff 09 00 00 8b 78 74 e8 8f 44 fb ff b9 7c 68 0e 81 ba 01 00 
> [   19.188808] EAX: 00000246 EBX: 85711e50 ECX: 43f73f41 EDX: 00000000
> [   19.189509] ESI: 000003ed EDI: 81c586c0 EBP: 85711db8 ESP: 85711d80
> [   19.190454] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   19.191179] CR0: 80050033 CR2: 00000dec CR3: 03e69000 CR4: 00040690
> [   19.191870] Call Trace:
> [   19.192146]  ? pagefault_out_of_memory+0x4c/0x4c
> [   19.192656]  ? oom_badness+0x5f/0x160
> [   19.193059]  out_of_memory+0x30e/0x3d0
> [   19.193480]  ? out_of_memory+0x1fb/0x3d0
> [   19.193911]  ? __alloc_pages_nodemask+0x6ee/0xa80
> [   19.194431]  __alloc_pages_nodemask+0x9b9/0xa80
> [   19.194931]  wp_page_copy+0x69/0x5c0
> [   19.195335]  do_wp_page+0x115/0x470
> [   19.195721]  handle_mm_fault+0x5a8/0xb00
> [   19.196202]  __do_page_fault+0x1a2/0x5c0
> [   19.196644]  ? filp_close+0x52/0x80
> [   19.197030]  ? kvm_read_and_reset_pf_reason+0x50/0x50
> [   19.197586]  do_page_fault+0x21/0x30
> [   19.197977]  do_async_page_fault+0x28/0xa0
> [   19.198433]  common_exception+0x45/0x4a
> [   19.198851] EIP: 0x807d20d
> [   19.199150] Code: 08 89 04 24 e8 c4 6f 03 00 8b 15 00 ad 12 08 a1 08 ad 12 08 8b 04 90 89 04 24 e8 de 45 ff ff a1 08 ad 12 08 8b 15 00 ad 12 08 <c7> 04 90 00 00 00 00 83 c4 1c e9 54 6f 03 00 8d 74 26 00 83 ec 1c 
> [   19.201213] EAX: 096cf6c8 EBX: 096fb5e8 ECX: 00000000 EDX: 00000002
> [   19.201999] ESI: 080f34f5 EDI: 00000000 EBP: 00000000 ESP: 7fc1c730
> [   19.203019] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
> [   19.203861] Modules linked in:
> [   19.204200] CR2: 0000000000000dec
> [   19.204786] ---[ end trace be7d06c89576f8c6 ]---
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong, Chen

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 4.18.0-rc6 Kernel Configuration
> #
> 
> #
> # Compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> #
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=2
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=40904
> CONFIG_CLANG_VERSION=0
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_EXTABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> CONFIG_KERNEL_BZIP2=y
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> # CONFIG_SYSVIPC is not set
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_IRQ_DEBUGFS=y
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_DATA=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> CONFIG_NO_HZ=y
> # CONFIG_HIGH_RES_TIMERS is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_HUGETLB is not set
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_DEBUG is not set
> # CONFIG_NAMESPACES is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> # CONFIG_RD_BZIP2 is not set
> CONFIG_RD_LZMA=y
> # CONFIG_RD_XZ is not set
> # CONFIG_RD_LZO is not set
> CONFIG_RD_LZ4=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> CONFIG_EXPERT=y
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_FHANDLE=y
> # CONFIG_POSIX_TIMERS is not set
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_PCSPKR_PLATFORM=y
> # CONFIG_BASE_FULL is not set
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> # CONFIG_EVENTFD is not set
> CONFIG_SHMEM=y
> # CONFIG_AIO is not set
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_CHECKPOINT_RESTORE=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_USERFAULTFD is not set
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_RSEQ=y
> # CONFIG_DEBUG_RSEQ is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> # CONFIG_VM_EVENT_COUNTERS is not set
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=y
> CONFIG_OPROFILE_EVENT_MULTIPLEX=y
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> CONFIG_STATIC_KEYS_SELFTEST=y
> CONFIG_OPTPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_PLUGIN_HOSTCC="g++"
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
> CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
> # CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
> CONFIG_GCC_PLUGIN_RANDSTRUCT=y
> # CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> CONFIG_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR_STRONG is not set
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_ISA_BUS_API=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_ARCH_HAS_REFCOUNT=y
> CONFIG_REFCOUNT_FULL=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=1
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_MODVERSIONS=y
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> CONFIG_MODULE_COMPRESS_XZ=y
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> # CONFIG_LBDAF is not set
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> # CONFIG_BLK_DEV_ZONED is not set
> CONFIG_BLK_CMDLINE_PARSER=y
> # CONFIG_BLK_WBT is not set
> # CONFIG_BLK_DEBUG_FS is not set
> CONFIG_BLK_SED_OPAL=y
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> CONFIG_OSF_PARTITION=y
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> # CONFIG_MSDOS_PARTITION is not set
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
> # CONFIG_SGI_PARTITION is not set
> CONFIG_ULTRIX_PARTITION=y
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> CONFIG_SYSV68_PARTITION=y
> CONFIG_CMDLINE_PARTITION=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_DEADLINE=m
> # CONFIG_IOSCHED_CFQ is not set
> CONFIG_DEFAULT_NOOP=y
> CONFIG_DEFAULT_IOSCHED="noop"
> # CONFIG_MQ_IOSCHED_DEADLINE is not set
> CONFIG_MQ_IOSCHED_KYBER=y
> # CONFIG_IOSCHED_BFQ is not set
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> CONFIG_FREEZER=y
> 
> #
> # Processor type and features
> #
> # CONFIG_ZONE_DMA is not set
> # CONFIG_SMP is not set
> CONFIG_X86_FEATURE_NAMES=y
> # CONFIG_X86_MPPARSE is not set
> # CONFIG_GOLDFISH is not set
> # CONFIG_RETPOLINE is not set
> # CONFIG_INTEL_RDT is not set
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_CE is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> CONFIG_IOSF_MBI_DEBUG=y
> CONFIG_X86_RDC321X=y
> # CONFIG_X86_32_IRIS is not set
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_KVM_GUEST=y
> # CONFIG_KVM_DEBUG_FS is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> CONFIG_NO_BOOTMEM=y
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_MVIAC7=y
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=6
> CONFIG_X86_DEBUGCTLMSR=y
> # CONFIG_PROCESSOR_SELECT is not set
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_CYRIX_32=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_TRANSMETA_32=y
> CONFIG_CPU_SUP_UMC_32=y
> CONFIG_HPET_TIMER=y
> # CONFIG_DMI is not set
> CONFIG_NR_CPUS_RANGE_BEGIN=1
> CONFIG_NR_CPUS_RANGE_END=1
> CONFIG_NR_CPUS_DEFAULT=1
> CONFIG_NR_CPUS=1
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_UP_LATE_INIT=y
> CONFIG_X86_UP_APIC=y
> # CONFIG_X86_UP_IOAPIC is not set
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
> # CONFIG_X86_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> # CONFIG_PERF_EVENTS_INTEL_RAPL is not set
> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> CONFIG_X86_LEGACY_VM86=y
> CONFIG_VM86=y
> CONFIG_TOSHIBA=y
> # CONFIG_I8K is not set
> CONFIG_X86_REBOOTFIXUPS=y
> CONFIG_MICROCODE=y
> # CONFIG_MICROCODE_INTEL is not set
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=y
> # CONFIG_X86_CPUID is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_VMSPLIT_3G is not set
> # CONFIG_VMSPLIT_3G_OPT is not set
> CONFIG_VMSPLIT_2G=y
> # CONFIG_VMSPLIT_2G_OPT is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0x80000000
> CONFIG_HIGHMEM=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_HAVE_GENERIC_GUP=y
> CONFIG_ARCH_DISCARD_MEMBLOCK=y
> CONFIG_MEMORY_ISOLATION=y
> # CONFIG_MEMORY_HOTPLUG is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_TRANSPARENT_HUGEPAGE=y
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_CLEANCACHE=y
> CONFIG_FRONTSWAP=y
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> CONFIG_CMA_DEBUGFS=y
> CONFIG_CMA_AREAS=7
> CONFIG_ZSWAP=y
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> CONFIG_Z3FOLD=m
> CONFIG_ZSMALLOC=m
> # CONFIG_PGTABLE_MAPPING is not set
> CONFIG_ZSMALLOC_STAT=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_IDLE_PAGE_TRACKING=y
> # CONFIG_PERCPU_STATS is not set
> CONFIG_GUP_BENCHMARK=y
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_HIGHPTE=y
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> # CONFIG_ARCH_RANDOM is not set
> CONFIG_X86_SMAP=y
> # CONFIG_X86_INTEL_UMIP is not set
> # CONFIG_EFI is not set
> CONFIG_SECCOMP=y
> CONFIG_HZ_100=y
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=100
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x1000000
> # CONFIG_RELOCATABLE is not set
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_COMPAT_VDSO=y
> # CONFIG_CMDLINE_BOOL is not set
> # CONFIG_MODIFY_LDT_SYSCALL is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> # CONFIG_HIBERNATION is not set
> CONFIG_PM_SLEEP=y
> CONFIG_PM_AUTOSLEEP=y
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_ADVANCED_DEBUG=y
> CONFIG_PM_SLEEP_DEBUG=y
> CONFIG_PM_TRACE=y
> CONFIG_PM_TRACE_RTC=y
> CONFIG_PM_CLK=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_PROCFS_POWER is not set
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=m
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> # CONFIG_ACPI_IPMI is not set
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> # CONFIG_ACPI_CONTAINER is not set
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> # CONFIG_ACPI_SBS is not set
> # CONFIG_ACPI_HED is not set
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> # CONFIG_DPTF_POWER is not set
> # CONFIG_PMIC_OPREGION is not set
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_X86_PM_TIMER=y
> CONFIG_SFI=y
> CONFIG_X86_APM_BOOT=y
> CONFIG_APM=m
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> CONFIG_APM_DO_ENABLE=y
> # CONFIG_APM_CPU_IDLE is not set
> # CONFIG_APM_DISPLAY_BLANK is not set
> CONFIG_APM_ALLOW_INTS=y
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_INTEL_IDLE is not set
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> CONFIG_PCI_GODIRECT=y
> # CONFIG_PCI_GOOLPC is not set
> # CONFIG_PCI_GOANY is not set
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> CONFIG_PCIEPORTBUS=y
> # CONFIG_HOTPLUG_PCI_PCIE is not set
> CONFIG_PCIEAER=y
> CONFIG_PCIEAER_INJECT=m
> # CONFIG_PCIE_ECRC is not set
> # CONFIG_PCIEASPM is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> CONFIG_PCIE_PTM=y
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> CONFIG_PCI_STUB=m
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> CONFIG_HOTPLUG_PCI=y
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> CONFIG_HOTPLUG_PCI_CPCI=y
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> # CONFIG_HOTPLUG_PCI_SHPC is not set
> 
> #
> # PCI controller drivers
> #
> 
> #
> # Cadence PCIe controllers support
> #
> # CONFIG_PCIE_CADENCE_HOST is not set
> CONFIG_PCI_FTPCI100=y
> # CONFIG_PCI_HOST_GENERIC is not set
> 
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=y
> # CONFIG_ISA is not set
> # CONFIG_SCx200 is not set
> CONFIG_OLPC=y
> # CONFIG_OLPC_XO15_SCI is not set
> # CONFIG_ALIX is not set
> # CONFIG_NET5501 is not set
> CONFIG_AMD_NB=y
> # CONFIG_PCCARD is not set
> CONFIG_RAPIDIO=y
> # CONFIG_RAPIDIO_TSI721 is not set
> CONFIG_RAPIDIO_DISC_TIMEOUT=30
> CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
> CONFIG_RAPIDIO_DMA_ENGINE=y
> # CONFIG_RAPIDIO_DEBUG is not set
> CONFIG_RAPIDIO_ENUM_BASIC=m
> # CONFIG_RAPIDIO_CHMAN is not set
> # CONFIG_RAPIDIO_MPORT_CDEV is not set
> 
> #
> # RapidIO Switch drivers
> #
> # CONFIG_RAPIDIO_TSI57X is not set
> CONFIG_RAPIDIO_CPS_XX=m
> CONFIG_RAPIDIO_TSI568=y
> CONFIG_RAPIDIO_CPS_GEN2=y
> CONFIG_RAPIDIO_RXS_GEN3=y
> CONFIG_X86_SYSFB=y
> 
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_HAVE_AOUT=y
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_MISC=y
> # CONFIG_COREDUMP is not set
> CONFIG_COMPAT_32=y
> CONFIG_HAVE_ATOMIC_IOMAP=y
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_ALGO=m
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> CONFIG_XFRM_MIGRATE=y
> # CONFIG_XFRM_STATISTICS is not set
> CONFIG_NET_KEY=m
> # CONFIG_NET_KEY_MIGRATE is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> CONFIG_INET6_XFRM_MODE_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_BEET=y
> # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_BRIDGE_NETFILTER=m
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_FAMILY_BRIDGE=y
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> # CONFIG_NETFILTER_NETLINK_QUEUE is not set
> # CONFIG_NETFILTER_NETLINK_LOG is not set
> # CONFIG_NF_CONNTRACK is not set
> # CONFIG_NF_LOG_NETDEV is not set
> # CONFIG_NF_TABLES is not set
> # CONFIG_NETFILTER_XTABLES is not set
> # CONFIG_IP_SET is not set
> # CONFIG_IP_VS is not set
> 
> #
> # IP: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV4 is not set
> # CONFIG_NF_TPROXY_IPV4 is not set
> # CONFIG_NF_DUP_IPV4 is not set
> # CONFIG_NF_LOG_ARP is not set
> # CONFIG_NF_LOG_IPV4 is not set
> # CONFIG_NF_REJECT_IPV4 is not set
> # CONFIG_IP_NF_IPTABLES is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV6 is not set
> # CONFIG_NF_TPROXY_IPV6 is not set
> # CONFIG_NF_DUP_IPV6 is not set
> # CONFIG_NF_REJECT_IPV6 is not set
> # CONFIG_NF_LOG_IPV6 is not set
> # CONFIG_IP6_NF_IPTABLES is not set
> 
> #
> # DECnet: Netfilter Configuration
> #
> CONFIG_DECNET_NF_GRABULATOR=m
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> CONFIG_ATM=m
> # CONFIG_ATM_CLIP is not set
> CONFIG_ATM_LANE=m
> # CONFIG_ATM_MPOA is not set
> # CONFIG_ATM_BR2684 is not set
> # CONFIG_L2TP is not set
> CONFIG_STP=y
> CONFIG_BRIDGE=y
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> CONFIG_DECNET=m
> # CONFIG_DECNET_ROUTER is not set
> CONFIG_LLC=y
> CONFIG_LLC2=m
> CONFIG_ATALK=m
> # CONFIG_DEV_APPLETALK is not set
> CONFIG_X25=y
> CONFIG_LAPB=m
> CONFIG_PHONET=m
> # CONFIG_6LOWPAN is not set
> CONFIG_IEEE802154=m
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=m
> # CONFIG_MAC802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> # CONFIG_DNS_RESOLVER is not set
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> CONFIG_VSOCKETS=m
> CONFIG_VSOCKETS_DIAG=m
> # CONFIG_VIRTIO_VSOCKETS is not set
> CONFIG_NETLINK_DIAG=m
> CONFIG_MPLS=y
> # CONFIG_NET_MPLS_GSO is not set
> CONFIG_MPLS_ROUTING=m
> CONFIG_NET_NSH=m
> CONFIG_HSR=m
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_JIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_HAMRADIO=y
> 
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=y
> CONFIG_AX25_DAMA_SLAVE=y
> # CONFIG_NETROM is not set
> # CONFIG_ROSE is not set
> 
> #
> # AX.25 network device drivers
> #
> # CONFIG_MKISS is not set
> # CONFIG_6PACK is not set
> CONFIG_BPQETHER=y
> # CONFIG_BAYCOM_SER_FDX is not set
> # CONFIG_BAYCOM_SER_HDX is not set
> # CONFIG_BAYCOM_PAR is not set
> # CONFIG_BAYCOM_EPP is not set
> CONFIG_YAM=y
> # CONFIG_CAN is not set
> CONFIG_BT=m
> CONFIG_BT_BREDR=y
> CONFIG_BT_RFCOMM=m
> # CONFIG_BT_RFCOMM_TTY is not set
> CONFIG_BT_BNEP=y
> CONFIG_BT_BNEP_MC_FILTER=y
> # CONFIG_BT_BNEP_PROTO_FILTER is not set
> CONFIG_BT_CMTP=m
> # CONFIG_BT_HIDP is not set
> # CONFIG_BT_HS is not set
> # CONFIG_BT_LE is not set
> # CONFIG_BT_LEDS is not set
> CONFIG_BT_SELFTEST=y
> CONFIG_BT_DEBUGFS=y
> 
> #
> # Bluetooth device drivers
> #
> # CONFIG_BT_HCIUART is not set
> CONFIG_BT_HCIVHCI=m
> CONFIG_BT_MRVL=m
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_WIRELESS=y
> CONFIG_WIRELESS_EXT=y
> CONFIG_WEXT_CORE=y
> CONFIG_WEXT_PROC=y
> CONFIG_WEXT_PRIV=y
> CONFIG_CFG80211=m
> # CONFIG_NL80211_TESTMODE is not set
> CONFIG_CFG80211_DEVELOPER_WARNINGS=y
> # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> CONFIG_CFG80211_DEFAULT_PS=y
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=y
> # CONFIG_CFG80211_WEXT is not set
> CONFIG_LIB80211=m
> # CONFIG_LIB80211_DEBUG is not set
> CONFIG_MAC80211=m
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_MINSTREL_HT=y
> CONFIG_MAC80211_RC_MINSTREL_VHT=y
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> CONFIG_MAC80211_MESH=y
> # CONFIG_MAC80211_LEDS is not set
> CONFIG_MAC80211_DEBUGFS=y
> CONFIG_MAC80211_MESSAGE_TRACING=y
> CONFIG_MAC80211_DEBUG_MENU=y
> CONFIG_MAC80211_NOINLINE=y
> CONFIG_MAC80211_VERBOSE_DEBUG=y
> CONFIG_MAC80211_MLME_DEBUG=y
> CONFIG_MAC80211_STA_DEBUG=y
> CONFIG_MAC80211_HT_DEBUG=y
> CONFIG_MAC80211_OCB_DEBUG=y
> # CONFIG_MAC80211_IBSS_DEBUG is not set
> # CONFIG_MAC80211_PS_DEBUG is not set
> CONFIG_MAC80211_MPL_DEBUG=y
> CONFIG_MAC80211_MPATH_DEBUG=y
> CONFIG_MAC80211_MHWMP_DEBUG=y
> # CONFIG_MAC80211_MESH_SYNC_DEBUG is not set
> # CONFIG_MAC80211_MESH_CSA_DEBUG is not set
> # CONFIG_MAC80211_MESH_PS_DEBUG is not set
> # CONFIG_MAC80211_TDLS_DEBUG is not set
> CONFIG_MAC80211_DEBUG_COUNTERS=y
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> CONFIG_RFKILL=m
> # CONFIG_RFKILL_INPUT is not set
> CONFIG_RFKILL_GPIO=m
> CONFIG_NET_9P=m
> # CONFIG_NET_9P_VIRTIO is not set
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> CONFIG_NFC=m
> CONFIG_NFC_DIGITAL=m
> CONFIG_NFC_NCI=m
> # CONFIG_NFC_NCI_UART is not set
> CONFIG_NFC_HCI=m
> CONFIG_NFC_SHDLC=y
> 
> #
> # Near Field Communication (NFC) devices
> #
> # CONFIG_NFC_MEI_PHY is not set
> CONFIG_NFC_SIM=m
> # CONFIG_NFC_FDP is not set
> # CONFIG_NFC_PN544_I2C is not set
> CONFIG_NFC_PN533=m
> CONFIG_NFC_PN533_I2C=m
> # CONFIG_NFC_MICROREAD_I2C is not set
> CONFIG_NFC_ST21NFCA=m
> CONFIG_NFC_ST21NFCA_I2C=m
> CONFIG_NFC_ST_NCI=m
> CONFIG_NFC_ST_NCI_I2C=m
> CONFIG_NFC_NXP_NCI=m
> CONFIG_NFC_NXP_NCI_I2C=m
> CONFIG_NFC_S3FWRN5=m
> CONFIG_NFC_S3FWRN5_I2C=m
> # CONFIG_PSAMPLE is not set
> CONFIG_NET_IFE=y
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_NET_DEVLINK is not set
> CONFIG_MAY_USE_DEVLINK=y
> CONFIG_FAILOVER=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=y
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPMI=m
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # CONFIG_DMA_CMA is not set
> 
> #
> # Bus devices
> #
> # CONFIG_SIMPLE_PM_BUS is not set
> # CONFIG_CONNECTOR is not set
> # CONFIG_MTD is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> CONFIG_OF_UNITTEST=y
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_PROMTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_NET=y
> CONFIG_OF_MDIO=y
> CONFIG_OF_RESOLVE=y
> CONFIG_OF_OVERLAY=y
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=y
> # CONFIG_PARPORT_PC is not set
> CONFIG_PARPORT_AX88796=m
> # CONFIG_PARPORT_1284 is not set
> CONFIG_PARPORT_NOT_PC=y
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_CDROM=y
> CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
> # CONFIG_ZRAM is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_UMEM=y
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_CDROM_PKTCDVD=m
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> CONFIG_ATA_OVER_ETH=m
> CONFIG_VIRTIO_BLK=m
> # CONFIG_VIRTIO_BLK_SCSI is not set
> # CONFIG_BLK_DEV_RBD is not set
> CONFIG_BLK_DEV_RSXX=y
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=m
> # CONFIG_NVME_MULTIPATH is not set
> CONFIG_NVME_FABRICS=y
> CONFIG_NVME_FC=y
> # CONFIG_NVME_TARGET is not set
> 
> #
> # Misc devices
> #
> # CONFIG_AD525X_DPOT is not set
> CONFIG_DUMMY_IRQ=y
> # CONFIG_IBM_ASM is not set
> CONFIG_PHANTOM=m
> CONFIG_SGI_IOC4=m
> CONFIG_TIFM_CORE=m
> CONFIG_TIFM_7XX1=m
> CONFIG_ICS932S401=m
> CONFIG_ENCLOSURE_SERVICES=y
> CONFIG_HP_ILO=m
> CONFIG_APDS9802ALS=m
> # CONFIG_ISL29003 is not set
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=m
> # CONFIG_SENSORS_BH1770 is not set
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> CONFIG_DS1682=y
> # CONFIG_PCH_PHUB is not set
> CONFIG_USB_SWITCH_FSA9480=y
> CONFIG_SRAM=y
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_MISC_RTSX=y
> CONFIG_C2PORT=m
> CONFIG_C2PORT_DURAMAR_2150=m
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=m
> # CONFIG_EEPROM_LEGACY is not set
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=m
> # CONFIG_EEPROM_IDT_89HPESX is not set
> CONFIG_CB710_CORE=m
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # CONFIG_SENSORS_LIS3_I2C is not set
> CONFIG_ALTERA_STAPL=y
> CONFIG_INTEL_MEI=m
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> 
> #
> # Intel MIC & related support
> #
> 
> #
> # Intel MIC Bus Driver
> #
> 
> #
> # SCIF Bus Driver
> #
> 
> #
> # VOP Bus Driver
> #
> 
> #
> # Intel MIC Host Driver
> #
> 
> #
> # Intel MIC Card Driver
> #
> 
> #
> # SCIF Driver
> #
> 
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> 
> #
> # VOP Driver
> #
> # CONFIG_ECHO is not set
> CONFIG_MISC_RTSX_PCI=y
> CONFIG_HAVE_IDE=y
> CONFIG_IDE=m
> 
> #
> # Please see Documentation/ide/ide.txt for help/info on IDE drives
> #
> CONFIG_IDE_XFER_MODE=y
> CONFIG_IDE_TIMINGS=y
> CONFIG_IDE_ATAPI=y
> CONFIG_BLK_DEV_IDE_SATA=y
> # CONFIG_IDE_GD is not set
> # CONFIG_BLK_DEV_IDECD is not set
> CONFIG_BLK_DEV_IDETAPE=m
> # CONFIG_BLK_DEV_IDEACPI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_PROC_FS=y
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=m
> CONFIG_BLK_DEV_PLATFORM=m
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEDMA_SFF=y
> 
> #
> # PCI IDE chipsets support
> #
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=m
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> CONFIG_BLK_DEV_TRIFLEX=m
> CONFIG_BLK_DEV_CS5520=m
> # CONFIG_BLK_DEV_CS5530 is not set
> CONFIG_BLK_DEV_CS5535=m
> CONFIG_BLK_DEV_CS5536=m
> CONFIG_BLK_DEV_HPT366=m
> CONFIG_BLK_DEV_JMICRON=m
> CONFIG_BLK_DEV_SC1200=m
> CONFIG_BLK_DEV_PIIX=m
> CONFIG_BLK_DEV_IT8172=m
> CONFIG_BLK_DEV_IT8213=m
> CONFIG_BLK_DEV_IT821X=m
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> CONFIG_BLK_DEV_PDC202XX_NEW=m
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> CONFIG_BLK_DEV_SLC90E66=m
> CONFIG_BLK_DEV_TRM290=m
> CONFIG_BLK_DEV_VIA82CXXX=m
> CONFIG_BLK_DEV_TC86C001=m
> CONFIG_BLK_DEV_IDEDMA=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_MQ_DEFAULT=y
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=y
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=y
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=m
> # CONFIG_CHR_DEV_SCH is not set
> CONFIG_SCSI_ENCLOSURE=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> # CONFIG_SCSI_SCAN_ASYNC is not set
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=y
> # CONFIG_SCSI_FC_ATTRS is not set
> CONFIG_SCSI_ISCSI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=y
> CONFIG_SCSI_SAS_LIBSAS=y
> CONFIG_SCSI_SAS_ATA=y
> # CONFIG_SCSI_SAS_HOST_SMP is not set
> CONFIG_SCSI_SRP_ATTRS=y
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> CONFIG_ISCSI_BOOT_SYSFS=y
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> CONFIG_SCSI_BNX2_ISCSI=m
> # CONFIG_BE2ISCSI is not set
> CONFIG_BLK_DEV_3W_XXXX_RAID=m
> CONFIG_SCSI_HPSA=y
> CONFIG_SCSI_3W_9XXX=y
> CONFIG_SCSI_3W_SAS=y
> CONFIG_SCSI_ACARD=m
> CONFIG_SCSI_AACRAID=y
> # CONFIG_SCSI_AIC7XXX is not set
> CONFIG_SCSI_AIC79XX=y
> CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> CONFIG_AIC79XX_RESET_DELAY_MS=5000
> # CONFIG_AIC79XX_BUILD_FIRMWARE is not set
> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> CONFIG_AIC79XX_DEBUG_MASK=0
> CONFIG_AIC79XX_REG_PRETTY_PRINT=y
> CONFIG_SCSI_AIC94XX=m
> # CONFIG_AIC94XX_DEBUG is not set
> CONFIG_SCSI_MVSAS=m
> # CONFIG_SCSI_MVSAS_DEBUG is not set
> # CONFIG_SCSI_MVSAS_TASKLET is not set
> # CONFIG_SCSI_MVUMI is not set
> CONFIG_SCSI_DPT_I2O=m
> CONFIG_SCSI_ADVANSYS=y
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> CONFIG_MEGARAID_NEWGEN=y
> CONFIG_MEGARAID_MM=y
> CONFIG_MEGARAID_MAILBOX=m
> CONFIG_MEGARAID_LEGACY=m
> CONFIG_MEGARAID_SAS=y
> CONFIG_SCSI_MPT3SAS=m
> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> CONFIG_SCSI_MPT2SAS=m
> # CONFIG_SCSI_SMARTPQI is not set
> CONFIG_SCSI_UFSHCD=m
> CONFIG_SCSI_UFSHCD_PCI=m
> CONFIG_SCSI_UFS_DWC_TC_PCI=m
> # CONFIG_SCSI_UFSHCD_PLATFORM is not set
> CONFIG_SCSI_HPTIOP=m
> CONFIG_SCSI_BUSLOGIC=m
> # CONFIG_SCSI_FLASHPOINT is not set
> CONFIG_VMWARE_PVSCSI=y
> CONFIG_SCSI_SNIC=m
> CONFIG_SCSI_SNIC_DEBUG_FS=y
> CONFIG_SCSI_DMX3191D=m
> CONFIG_SCSI_GDTH=m
> CONFIG_SCSI_ISCI=m
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> CONFIG_SCSI_INIA100=y
> # CONFIG_SCSI_STEX is not set
> CONFIG_SCSI_SYM53C8XX_2=m
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> # CONFIG_SCSI_SYM53C8XX_MMIO is not set
> CONFIG_SCSI_IPR=m
> CONFIG_SCSI_IPR_TRACE=y
> CONFIG_SCSI_IPR_DUMP=y
> CONFIG_SCSI_QLOGIC_1280=y
> CONFIG_SCSI_QLA_ISCSI=m
> CONFIG_SCSI_DC395x=y
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> CONFIG_SCSI_PM8001=m
> # CONFIG_SCSI_VIRTIO is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=m
> CONFIG_SCSI_DH_HP_SW=y
> CONFIG_SCSI_DH_EMC=y
> CONFIG_SCSI_DH_ALUA=y
> CONFIG_SCSI_OSD_INITIATOR=y
> # CONFIG_SCSI_OSD_ULD is not set
> CONFIG_SCSI_OSD_DPRINT_SENSE=1
> # CONFIG_SCSI_OSD_DEBUG is not set
> CONFIG_ATA=y
> # CONFIG_ATA_VERBOSE_ERROR is not set
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=y
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_SATA_AHCI_PLATFORM=m
> CONFIG_AHCI_CEVA=m
> # CONFIG_AHCI_QORIQ is not set
> CONFIG_SATA_INIC162X=m
> # CONFIG_SATA_ACARD_AHCI is not set
> CONFIG_SATA_SIL24=m
> # CONFIG_ATA_SFF is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=m
> # CONFIG_MD_LINEAR is not set
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> CONFIG_MD_MULTIPATH=m
> CONFIG_MD_FAULTY=m
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=y
> CONFIG_DM_MQ_DEFAULT=y
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=y
> CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
> # CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
> CONFIG_DM_BIO_PRISON=y
> CONFIG_DM_PERSISTENT_DATA=y
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=m
> # CONFIG_DM_SNAPSHOT is not set
> CONFIG_DM_THIN_PROVISIONING=y
> # CONFIG_DM_CACHE is not set
> CONFIG_DM_WRITECACHE=m
> CONFIG_DM_ERA=m
> CONFIG_DM_MIRROR=m
> # CONFIG_DM_LOG_USERSPACE is not set
> CONFIG_DM_RAID=m
> CONFIG_DM_ZERO=m
> CONFIG_DM_MULTIPATH=m
> CONFIG_DM_MULTIPATH_QL=m
> # CONFIG_DM_MULTIPATH_ST is not set
> # CONFIG_DM_DELAY is not set
> CONFIG_DM_UEVENT=y
> CONFIG_DM_FLAKEY=m
> # CONFIG_DM_VERITY is not set
> # CONFIG_DM_SWITCH is not set
> CONFIG_DM_LOG_WRITES=m
> # CONFIG_DM_INTEGRITY is not set
> CONFIG_TARGET_CORE=y
> CONFIG_TCM_IBLOCK=m
> CONFIG_TCM_FILEIO=m
> CONFIG_TCM_PSCSI=m
> CONFIG_TCM_USER2=m
> # CONFIG_LOOPBACK_TARGET is not set
> CONFIG_ISCSI_TARGET=y
> CONFIG_SBP_TARGET=m
> CONFIG_FUSION=y
> CONFIG_FUSION_SPI=m
> CONFIG_FUSION_SAS=m
> CONFIG_FUSION_MAX_SGE=128
> # CONFIG_FUSION_CTL is not set
> CONFIG_FUSION_LOGGING=y
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=m
> CONFIG_FIREWIRE_OHCI=m
> # CONFIG_FIREWIRE_SBP2 is not set
> # CONFIG_FIREWIRE_NET is not set
> # CONFIG_FIREWIRE_NOSY is not set
> CONFIG_MACINTOSH_DRIVERS=y
> # CONFIG_MAC_EMUMOUSEBTN is not set
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> # CONFIG_NET_CORE is not set
> # CONFIG_ARCNET is not set
> # CONFIG_ATM_DRIVERS is not set
> 
> #
> # CAIF transport drivers
> #
> 
> #
> # Distributed Switch Architecture drivers
> #
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_VENDOR_ADAPTEC is not set
> CONFIG_NET_VENDOR_AGERE=y
> CONFIG_ET131X=m
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> # CONFIG_NET_VENDOR_ALTEON is not set
> # CONFIG_ALTERA_TSE is not set
> # CONFIG_NET_VENDOR_AMAZON is not set
> # CONFIG_NET_VENDOR_AMD is not set
> # CONFIG_NET_VENDOR_AQUANTIA is not set
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> CONFIG_ATL2=m
> CONFIG_ATL1=m
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> CONFIG_ALX=m
> CONFIG_NET_VENDOR_AURORA=y
> CONFIG_AURORA_NB8800=m
> CONFIG_NET_VENDOR_BROADCOM=y
> CONFIG_B44=y
> CONFIG_B44_PCI_AUTOSELECT=y
> CONFIG_B44_PCICORE_AUTOSELECT=y
> CONFIG_B44_PCI=y
> CONFIG_BCMGENET=y
> CONFIG_BNX2=y
> CONFIG_CNIC=m
> CONFIG_TIGON3=m
> CONFIG_TIGON3_HWMON=y
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> CONFIG_BNXT=m
> CONFIG_BNXT_FLOWER_OFFLOAD=y
> # CONFIG_NET_VENDOR_BROCADE is not set
> # CONFIG_NET_CADENCE is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> CONFIG_CHELSIO_T1=y
> # CONFIG_CHELSIO_T1_1G is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> CONFIG_CHELSIO_T4VF=y
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_GEMINI_ETHERNET is not set
> CONFIG_CX_ECAT=y
> CONFIG_DNET=y
> # CONFIG_NET_VENDOR_DEC is not set
> # CONFIG_NET_VENDOR_DLINK is not set
> CONFIG_NET_VENDOR_EMULEX=y
> CONFIG_BE2NET=y
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=m
> CONFIG_NET_VENDOR_HP=y
> CONFIG_HP100=y
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> CONFIG_E1000E=m
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=m
> CONFIG_IGB_HWMON=y
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> CONFIG_IXGBE=m
> CONFIG_IXGBE_HWMON=y
> # CONFIG_IXGBEVF is not set
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> # CONFIG_NET_VENDOR_EXAR is not set
> # CONFIG_JME is not set
> # CONFIG_NET_VENDOR_MARVELL is not set
> # CONFIG_NET_VENDOR_MELLANOX is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> CONFIG_FEALNX=m
> # CONFIG_NET_VENDOR_NATSEMI is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NFP=m
> # CONFIG_NFP_DEBUG is not set
> # CONFIG_NET_VENDOR_NI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> CONFIG_FORCEDETH=y
> # CONFIG_NET_VENDOR_OKI is not set
> # CONFIG_ETHOC is not set
> # CONFIG_NET_PACKET_ENGINE is not set
> # CONFIG_NET_VENDOR_QLOGIC is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> CONFIG_QCA7000=m
> CONFIG_QCA7000_UART=m
> CONFIG_QCOM_EMAC=m
> CONFIG_RMNET=y
> CONFIG_NET_VENDOR_RDC=y
> CONFIG_R6040=m
> # CONFIG_NET_VENDOR_REALTEK is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> # CONFIG_NET_VENDOR_ROCKER is not set
> CONFIG_NET_VENDOR_SAMSUNG=y
> CONFIG_SXGBE_ETH=m
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> CONFIG_SFC=m
> CONFIG_SFC_MCDI_MON=y
> CONFIG_SFC_MCDI_LOGGING=y
> # CONFIG_SFC_FALCON is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> CONFIG_NET_VENDOR_SIS=y
> CONFIG_SIS900=y
> CONFIG_SIS190=y
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> CONFIG_SMSC9420=y
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> CONFIG_STMMAC_ETH=m
> CONFIG_STMMAC_PLATFORM=m
> CONFIG_DWMAC_DWC_QOS_ETH=m
> # CONFIG_DWMAC_GENERIC is not set
> CONFIG_STMMAC_PCI=m
> # CONFIG_NET_VENDOR_SUN is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> CONFIG_DWC_XLGMAC=y
> CONFIG_DWC_XLGMAC_PCI=y
> # CONFIG_NET_VENDOR_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> CONFIG_TI_CPSW_ALE=y
> # CONFIG_TLAN is not set
> # CONFIG_NET_VENDOR_VIA is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> CONFIG_FDDI=m
> CONFIG_DEFXX=m
> # CONFIG_DEFXX_MMIO is not set
> CONFIG_SKFP=m
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_MDIO_BCM_UNIMAC=y
> # CONFIG_MDIO_BITBANG is not set
> CONFIG_MDIO_BUS_MUX=y
> CONFIG_MDIO_BUS_MUX_GPIO=y
> # CONFIG_MDIO_BUS_MUX_MMIOREG is not set
> CONFIG_MDIO_HISI_FEMAC=y
> # CONFIG_MDIO_MSCC_MIIM is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> 
> #
> # MII PHY device drivers
> #
> CONFIG_AMD_PHY=y
> CONFIG_AQUANTIA_PHY=m
> # CONFIG_ASIX_PHY is not set
> CONFIG_AT803X_PHY=m
> CONFIG_BCM7XXX_PHY=y
> CONFIG_BCM87XX_PHY=m
> CONFIG_BCM_NET_PHYLIB=y
> CONFIG_BROADCOM_PHY=m
> CONFIG_CICADA_PHY=y
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> CONFIG_DP83822_PHY=y
> CONFIG_DP83TC811_PHY=m
> # CONFIG_DP83848_PHY is not set
> CONFIG_DP83867_PHY=y
> CONFIG_FIXED_PHY=y
> CONFIG_ICPLUS_PHY=y
> CONFIG_INTEL_XWAY_PHY=m
> CONFIG_LSI_ET1011C_PHY=y
> CONFIG_LXT_PHY=m
> CONFIG_MARVELL_PHY=y
> CONFIG_MARVELL_10G_PHY=m
> CONFIG_MICREL_PHY=y
> CONFIG_MICROCHIP_PHY=m
> CONFIG_MICROCHIP_T1_PHY=m
> CONFIG_MICROSEMI_PHY=m
> CONFIG_NATIONAL_PHY=m
> CONFIG_QSEMI_PHY=m
> CONFIG_REALTEK_PHY=y
> CONFIG_RENESAS_PHY=m
> # CONFIG_ROCKCHIP_PHY is not set
> CONFIG_SMSC_PHY=y
> CONFIG_STE10XP=y
> # CONFIG_TERANETICS_PHY is not set
> CONFIG_VITESSE_PHY=y
> CONFIG_XILINX_GMII2RGMII=y
> CONFIG_PLIP=m
> CONFIG_PPP=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_FILTER=y
> # CONFIG_PPP_MPPE is not set
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPPOATM=m
> # CONFIG_PPPOE is not set
> # CONFIG_PPP_ASYNC is not set
> # CONFIG_PPP_SYNC_TTY is not set
> # CONFIG_SLIP is not set
> CONFIG_SLHC=m
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> # CONFIG_WIRELESS_WDS is not set
> # CONFIG_WLAN_VENDOR_ADMTEK is not set
> CONFIG_WLAN_VENDOR_ATH=y
> CONFIG_ATH_DEBUG=y
> # CONFIG_ATH5K is not set
> CONFIG_ATH5K_PCI=y
> # CONFIG_ATH9K is not set
> CONFIG_ATH6KL=m
> # CONFIG_ATH6KL_DEBUG is not set
> CONFIG_WIL6210=m
> # CONFIG_WIL6210_ISR_COR is not set
> # CONFIG_WIL6210_DEBUGFS is not set
> # CONFIG_ATH10K is not set
> CONFIG_WCN36XX=m
> # CONFIG_WCN36XX_DEBUGFS is not set
> # CONFIG_WLAN_VENDOR_ATMEL is not set
> # CONFIG_WLAN_VENDOR_BROADCOM is not set
> # CONFIG_WLAN_VENDOR_CISCO is not set
> # CONFIG_WLAN_VENDOR_INTEL is not set
> # CONFIG_WLAN_VENDOR_INTERSIL is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> # CONFIG_LIBERTAS is not set
> CONFIG_LIBERTAS_THINFIRM=m
> CONFIG_LIBERTAS_THINFIRM_DEBUG=y
> CONFIG_MWIFIEX=m
> CONFIG_MWIFIEX_PCIE=m
> CONFIG_MWL8K=m
> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_RT2X00=m
> # CONFIG_RT2400PCI is not set
> # CONFIG_RT2500PCI is not set
> CONFIG_RT61PCI=m
> # CONFIG_RT2800PCI is not set
> CONFIG_RT2X00_LIB_MMIO=m
> CONFIG_RT2X00_LIB_PCI=m
> CONFIG_RT2X00_LIB=m
> CONFIG_RT2X00_LIB_FIRMWARE=y
> CONFIG_RT2X00_LIB_CRYPTO=y
> CONFIG_RT2X00_LIB_LEDS=y
> # CONFIG_RT2X00_LIB_DEBUGFS is not set
> # CONFIG_RT2X00_DEBUG is not set
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_RTL8180=m
> CONFIG_RTL_CARDS=m
> CONFIG_RTL8192CE=m
> CONFIG_RTL8192SE=m
> # CONFIG_RTL8192DE is not set
> CONFIG_RTL8723AE=m
> # CONFIG_RTL8723BE is not set
> # CONFIG_RTL8188EE is not set
> # CONFIG_RTL8192EE is not set
> CONFIG_RTL8821AE=m
> CONFIG_RTLWIFI=m
> CONFIG_RTLWIFI_PCI=m
> # CONFIG_RTLWIFI_DEBUG is not set
> CONFIG_RTL8192C_COMMON=m
> CONFIG_RTL8723_COMMON=m
> CONFIG_RTLBTCOEXIST=m
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_RSI_91X=m
> CONFIG_RSI_DEBUGFS=y
> # CONFIG_RSI_COEX is not set
> # CONFIG_WLAN_VENDOR_ST is not set
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WL1251=m
> # CONFIG_WL12XX is not set
> CONFIG_WL18XX=m
> CONFIG_WLCORE=m
> # CONFIG_WLAN_VENDOR_ZYDAS is not set
> # CONFIG_WLAN_VENDOR_QUANTENNA is not set
> CONFIG_MAC80211_HWSIM=m
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=m
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> CONFIG_NETDEVSIM=y
> # CONFIG_NET_FAILOVER is not set
> CONFIG_ISDN=y
> # CONFIG_ISDN_I4L is not set
> CONFIG_ISDN_CAPI=m
> CONFIG_CAPI_TRACE=y
> CONFIG_ISDN_CAPI_CAPI20=m
> # CONFIG_ISDN_CAPI_MIDDLEWARE is not set
> 
> #
> # CAPI hardware drivers
> #
> # CONFIG_CAPI_AVM is not set
> # CONFIG_CAPI_EICON is not set
> # CONFIG_ISDN_DRV_GIGASET is not set
> CONFIG_HYSDN=m
> CONFIG_HYSDN_CAPI=y
> CONFIG_MISDN=y
> # CONFIG_MISDN_DSP is not set
> CONFIG_MISDN_L1OIP=m
> 
> #
> # mISDN hardware drivers
> #
> CONFIG_MISDN_HFCPCI=y
> CONFIG_MISDN_HFCMULTI=m
> # CONFIG_MISDN_AVMFRITZ is not set
> # CONFIG_MISDN_SPEEDFAX is not set
> CONFIG_MISDN_INFINEON=m
> # CONFIG_MISDN_W6692 is not set
> # CONFIG_MISDN_NETJET is not set
> CONFIG_MISDN_IPAC=m
> # CONFIG_NVM is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_POLLDEV is not set
> # CONFIG_INPUT_SPARSEKMAP is not set
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5520 is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_STMPE is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CROS_EC is not set
> # CONFIG_KEYBOARD_CAP11XX is not set
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> # CONFIG_MOUSE_PS2_OLPC is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> # CONFIG_MOUSE_PS2_VMMOUSE is not set
> CONFIG_MOUSE_PS2_SMBUS=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> CONFIG_SERIO_PARKBD=m
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> CONFIG_SERIO_ALTERA_PS2=m
> CONFIG_SERIO_PS2MULT=m
> CONFIG_SERIO_ARC_PS2=m
> # CONFIG_SERIO_APBPS2 is not set
> CONFIG_SERIO_OLPC_APSP=m
> CONFIG_SERIO_GPIO_PS2=m
> CONFIG_USERIO=m
> CONFIG_GAMEPORT=y
> # CONFIG_GAMEPORT_NS558 is not set
> CONFIG_GAMEPORT_L4=m
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_N_GSM is not set
> # CONFIG_TRACE_SINK is not set
> CONFIG_DEVMEM=y
> CONFIG_DEVKMEM=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> # CONFIG_SERIAL_8250_MEN_MCB is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> # CONFIG_SERIAL_8250_ASPEED_VUART is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> # CONFIG_SERIAL_8250_MOXA is not set
> # CONFIG_SERIAL_OF_PLATFORM is not set
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_PCH_UART is not set
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> # CONFIG_SERIAL_MEN_Z135 is not set
> CONFIG_SERIAL_DEV_BUS=m
> # CONFIG_TTY_PRINTK is not set
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> # CONFIG_VIRTIO_CONSOLE is not set
> CONFIG_IPMI_HANDLER=y
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=m
> # CONFIG_IPMI_SSIF is not set
> CONFIG_IPMI_WATCHDOG=m
> CONFIG_IPMI_POWEROFF=y
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=m
> # CONFIG_HW_RANDOM_INTEL is not set
> # CONFIG_HW_RANDOM_AMD is not set
> CONFIG_HW_RANDOM_GEODE=m
> # CONFIG_HW_RANDOM_VIA is not set
> CONFIG_HW_RANDOM_VIRTIO=m
> CONFIG_NVRAM=m
> # CONFIG_R3964 is not set
> CONFIG_APPLICOM=y
> # CONFIG_SONYPI is not set
> # CONFIG_MWAVE is not set
> CONFIG_PC8736x_GPIO=y
> CONFIG_NSC_GPIO=y
> CONFIG_RAW_DRIVER=m
> CONFIG_MAX_RAW_DEVS=256
> # CONFIG_HPET is not set
> # CONFIG_HANGCHECK_TIMER is not set
> CONFIG_TCG_TPM=m
> # CONFIG_HW_RANDOM_TPM is not set
> CONFIG_TCG_TIS_CORE=m
> CONFIG_TCG_TIS=m
> CONFIG_TCG_TIS_I2C_ATMEL=m
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> CONFIG_TCG_TIS_I2C_NUVOTON=m
> CONFIG_TCG_NSC=m
> CONFIG_TCG_ATMEL=m
> # CONFIG_TCG_INFINEON is not set
> # CONFIG_TCG_CRB is not set
> CONFIG_TCG_VTPM_PROXY=m
> CONFIG_TCG_TIS_ST33ZP24=m
> CONFIG_TCG_TIS_ST33ZP24_I2C=m
> CONFIG_TELCLOCK=m
> CONFIG_DEVPORT=y
> CONFIG_XILLYBUS=y
> CONFIG_XILLYBUS_PCIE=m
> # CONFIG_XILLYBUS_OF is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_ARB_GPIO_CHALLENGE=y
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_GPMUX is not set
> CONFIG_I2C_MUX_LTC4306=m
> CONFIG_I2C_MUX_PCA9541=m
> CONFIG_I2C_MUX_PCA954x=y
> CONFIG_I2C_MUX_PINCTRL=m
> CONFIG_I2C_MUX_REG=m
> CONFIG_I2C_DEMUX_PINCTRL=y
> CONFIG_I2C_MUX_MLXCPLD=m
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=m
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=m
> CONFIG_I2C_ALI15X3=y
> CONFIG_I2C_AMD756=m
> # CONFIG_I2C_AMD756_S4882 is not set
> CONFIG_I2C_AMD8111=m
> CONFIG_I2C_I801=y
> # CONFIG_I2C_ISCH is not set
> CONFIG_I2C_ISMT=m
> CONFIG_I2C_PIIX4=y
> # CONFIG_I2C_NFORCE2 is not set
> CONFIG_I2C_SIS5595=y
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=m
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=y
> 
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> CONFIG_I2C_CBUS_GPIO=y
> CONFIG_I2C_DESIGNWARE_CORE=m
> CONFIG_I2C_DESIGNWARE_PLATFORM=m
> CONFIG_I2C_DESIGNWARE_SLAVE=y
> CONFIG_I2C_DESIGNWARE_PCI=m
> # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> CONFIG_I2C_EG20T=y
> # CONFIG_I2C_EMEV2 is not set
> CONFIG_I2C_GPIO=m
> # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> CONFIG_I2C_KEMPLD=m
> CONFIG_I2C_OCORES=m
> # CONFIG_I2C_PCA_PLATFORM is not set
> CONFIG_I2C_PXA=y
> CONFIG_I2C_PXA_PCI=y
> # CONFIG_I2C_RK3X is not set
> # CONFIG_I2C_SIMTEC is not set
> CONFIG_I2C_XILINX=m
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_PARPORT=m
> CONFIG_I2C_PARPORT_LIGHT=m
> # CONFIG_I2C_TAOS_EVM is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_CROS_EC_TUNNEL=m
> # CONFIG_SCx200_ACB is not set
> CONFIG_I2C_STUB=m
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=m
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_SPI is not set
> CONFIG_SPMI=y
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> CONFIG_HSI_CHAR=y
> CONFIG_PPS=m
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_PARPORT is not set
> CONFIG_PPS_CLIENT_GPIO=m
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_PTP_1588_CLOCK_PCH=m
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AS3722 is not set
> CONFIG_PINCTRL_AMD=m
> CONFIG_PINCTRL_MCP23S08=m
> # CONFIG_PINCTRL_SINGLE is not set
> CONFIG_PINCTRL_SX150X=y
> CONFIG_PINCTRL_PALMAS=m
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> CONFIG_DEBUG_GPIO=y
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> CONFIG_GPIO_ALTERA=y
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> CONFIG_GPIO_FTGPIO010=y
> CONFIG_GPIO_GENERIC_PLATFORM=m
> # CONFIG_GPIO_GRGPIO is not set
> CONFIG_GPIO_HLWD=y
> # CONFIG_GPIO_ICH is not set
> # CONFIG_GPIO_LYNXPOINT is not set
> # CONFIG_GPIO_MB86S7X is not set
> CONFIG_GPIO_MENZ127=m
> CONFIG_GPIO_MOCKUP=m
> CONFIG_GPIO_SYSCON=m
> CONFIG_GPIO_VX855=y
> CONFIG_GPIO_XILINX=m
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=m
> CONFIG_GPIO_IT87=m
> CONFIG_GPIO_SCH=y
> CONFIG_GPIO_SCH311X=m
> # CONFIG_GPIO_WINBOND is not set
> CONFIG_GPIO_WS16C48=y
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> CONFIG_GPIO_ADNP=y
> CONFIG_GPIO_MAX7300=y
> CONFIG_GPIO_MAX732X=y
> # CONFIG_GPIO_MAX732X_IRQ is not set
> CONFIG_GPIO_PCA953X=y
> CONFIG_GPIO_PCA953X_IRQ=y
> # CONFIG_GPIO_PCF857X is not set
> CONFIG_GPIO_TPIC2810=m
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ADP5520=m
> CONFIG_GPIO_ARIZONA=y
> CONFIG_GPIO_KEMPLD=m
> CONFIG_GPIO_LP3943=m
> CONFIG_GPIO_LP873X=y
> CONFIG_GPIO_LP87565=y
> CONFIG_GPIO_PALMAS=y
> CONFIG_GPIO_RC5T583=y
> CONFIG_GPIO_STMPE=y
> # CONFIG_GPIO_TPS65086 is not set
> CONFIG_GPIO_TPS6586X=y
> CONFIG_GPIO_TPS65910=y
> CONFIG_GPIO_TPS65912=m
> 
> #
> # PCI GPIO expanders
> #
> CONFIG_GPIO_AMD8111=y
> CONFIG_GPIO_BT8XX=m
> CONFIG_GPIO_ML_IOH=m
> # CONFIG_GPIO_PCH is not set
> CONFIG_GPIO_PCI_IDIO_16=y
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> CONFIG_GPIO_RDC321X=m
> CONFIG_GPIO_SODAVILLE=y
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_MATROX=m
> CONFIG_W1_MASTER_DS2482=m
> # CONFIG_W1_MASTER_DS1WM is not set
> # CONFIG_W1_MASTER_GPIO is not set
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> CONFIG_W1_SLAVE_SMEM=m
> CONFIG_W1_SLAVE_DS2405=y
> CONFIG_W1_SLAVE_DS2408=y
> # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> CONFIG_W1_SLAVE_DS2413=m
> # CONFIG_W1_SLAVE_DS2406 is not set
> CONFIG_W1_SLAVE_DS2423=y
> CONFIG_W1_SLAVE_DS2805=m
> CONFIG_W1_SLAVE_DS2431=y
> CONFIG_W1_SLAVE_DS2433=y
> # CONFIG_W1_SLAVE_DS2433_CRC is not set
> CONFIG_W1_SLAVE_DS2438=m
> # CONFIG_W1_SLAVE_DS2760 is not set
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=m
> CONFIG_W1_SLAVE_DS28E04=m
> # CONFIG_W1_SLAVE_DS28E17 is not set
> CONFIG_POWER_AVS=y
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_AS3722 is not set
> CONFIG_POWER_RESET_GPIO=y
> CONFIG_POWER_RESET_GPIO_RESTART=y
> # CONFIG_POWER_RESET_LTC2952 is not set
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_RESET_SYSCON=y
> # CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
> CONFIG_REBOOT_MODE=m
> CONFIG_SYSCON_REBOOT_MODE=m
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> CONFIG_PDA_POWER=y
> CONFIG_GENERIC_ADC_BATTERY=y
> # CONFIG_TEST_POWER is not set
> CONFIG_BATTERY_ACT8945A=m
> CONFIG_BATTERY_DS2780=y
> # CONFIG_BATTERY_DS2781 is not set
> CONFIG_BATTERY_DS2782=y
> # CONFIG_BATTERY_LEGO_EV3 is not set
> CONFIG_BATTERY_OLPC=y
> CONFIG_BATTERY_SBS=m
> CONFIG_CHARGER_SBS=y
> CONFIG_MANAGER_SBS=m
> CONFIG_BATTERY_BQ27XXX=m
> CONFIG_BATTERY_BQ27XXX_I2C=m
> CONFIG_BATTERY_BQ27XXX_HDQ=m
> CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
> CONFIG_BATTERY_MAX17040=y
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_BATTERY_MAX1721X is not set
> CONFIG_CHARGER_PCF50633=m
> CONFIG_CHARGER_MAX8903=y
> CONFIG_CHARGER_LP8727=y
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> CONFIG_CHARGER_LTC3651=m
> # CONFIG_CHARGER_MAX14577 is not set
> CONFIG_CHARGER_DETECTOR_MAX14656=m
> # CONFIG_CHARGER_BQ2415X is not set
> CONFIG_CHARGER_BQ24190=m
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> CONFIG_CHARGER_BQ25890=y
> # CONFIG_CHARGER_SMB347 is not set
> CONFIG_CHARGER_TPS65090=y
> CONFIG_CHARGER_TPS65217=m
> CONFIG_BATTERY_GAUGE_LTC2941=m
> CONFIG_BATTERY_RT5033=m
> CONFIG_CHARGER_RT9455=y
> CONFIG_HWMON=m
> CONFIG_HWMON_VID=m
> CONFIG_HWMON_DEBUG_CHIP=y
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_AD7414 is not set
> CONFIG_SENSORS_AD7418=m
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_ADM1025=m
> CONFIG_SENSORS_ADM1026=m
> CONFIG_SENSORS_ADM1029=m
> CONFIG_SENSORS_ADM1031=m
> CONFIG_SENSORS_ADM9240=m
> CONFIG_SENSORS_ADT7X10=m
> CONFIG_SENSORS_ADT7410=m
> CONFIG_SENSORS_ADT7411=m
> CONFIG_SENSORS_ADT7462=m
> CONFIG_SENSORS_ADT7470=m
> # CONFIG_SENSORS_ADT7475 is not set
> CONFIG_SENSORS_ASC7621=m
> CONFIG_SENSORS_K8TEMP=m
> # CONFIG_SENSORS_K10TEMP is not set
> CONFIG_SENSORS_FAM15H_POWER=m
> # CONFIG_SENSORS_APPLESMC is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=m
> CONFIG_SENSORS_DS620=m
> # CONFIG_SENSORS_DS1621 is not set
> CONFIG_SENSORS_DELL_SMM=m
> CONFIG_SENSORS_I5K_AMB=m
> CONFIG_SENSORS_F71805F=m
> CONFIG_SENSORS_F71882FG=m
> # CONFIG_SENSORS_F75375S is not set
> CONFIG_SENSORS_FSCHMD=m
> CONFIG_SENSORS_FTSTEUTATES=m
> CONFIG_SENSORS_GL518SM=m
> # CONFIG_SENSORS_GL520SM is not set
> CONFIG_SENSORS_G760A=m
> # CONFIG_SENSORS_G762 is not set
> CONFIG_SENSORS_GPIO_FAN=m
> CONFIG_SENSORS_HIH6130=m
> CONFIG_SENSORS_IBMAEM=m
> CONFIG_SENSORS_IBMPEX=m
> # CONFIG_SENSORS_IIO_HWMON is not set
> # CONFIG_SENSORS_I5500 is not set
> CONFIG_SENSORS_CORETEMP=m
> # CONFIG_SENSORS_IT87 is not set
> CONFIG_SENSORS_JC42=m
> CONFIG_SENSORS_POWR1220=m
> # CONFIG_SENSORS_LINEAGE is not set
> CONFIG_SENSORS_LTC2945=m
> CONFIG_SENSORS_LTC2990=m
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=m
> CONFIG_SENSORS_LTC4260=m
> CONFIG_SENSORS_LTC4261=m
> # CONFIG_SENSORS_MAX16065 is not set
> CONFIG_SENSORS_MAX1619=m
> # CONFIG_SENSORS_MAX1668 is not set
> CONFIG_SENSORS_MAX197=m
> # CONFIG_SENSORS_MAX6621 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6642 is not set
> CONFIG_SENSORS_MAX6650=m
> # CONFIG_SENSORS_MAX6697 is not set
> CONFIG_SENSORS_MAX31790=m
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_TC654 is not set
> CONFIG_SENSORS_MENF21BMC_HWMON=m
> CONFIG_SENSORS_LM63=m
> CONFIG_SENSORS_LM73=m
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> CONFIG_SENSORS_LM78=m
> CONFIG_SENSORS_LM80=m
> # CONFIG_SENSORS_LM83 is not set
> CONFIG_SENSORS_LM85=m
> # CONFIG_SENSORS_LM87 is not set
> CONFIG_SENSORS_LM90=m
> CONFIG_SENSORS_LM92=m
> # CONFIG_SENSORS_LM93 is not set
> # CONFIG_SENSORS_LM95234 is not set
> CONFIG_SENSORS_LM95241=m
> CONFIG_SENSORS_LM95245=m
> # CONFIG_SENSORS_PC87360 is not set
> CONFIG_SENSORS_PC87427=m
> CONFIG_SENSORS_NTC_THERMISTOR=m
> CONFIG_SENSORS_NCT6683=m
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> CONFIG_SENSORS_NCT7904=m
> CONFIG_SENSORS_PCF8591=m
> CONFIG_PMBUS=m
> # CONFIG_SENSORS_PMBUS is not set
> CONFIG_SENSORS_ADM1275=m
> CONFIG_SENSORS_IBM_CFFPS=m
> # CONFIG_SENSORS_IR35221 is not set
> CONFIG_SENSORS_LM25066=m
> CONFIG_SENSORS_LTC2978=m
> CONFIG_SENSORS_LTC2978_REGULATOR=y
> # CONFIG_SENSORS_LTC3815 is not set
> CONFIG_SENSORS_MAX16064=m
> CONFIG_SENSORS_MAX20751=m
> CONFIG_SENSORS_MAX31785=m
> # CONFIG_SENSORS_MAX34440 is not set
> CONFIG_SENSORS_MAX8688=m
> CONFIG_SENSORS_TPS40422=m
> # CONFIG_SENSORS_TPS53679 is not set
> CONFIG_SENSORS_UCD9000=m
> # CONFIG_SENSORS_UCD9200 is not set
> CONFIG_SENSORS_ZL6100=m
> CONFIG_SENSORS_SHT15=m
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=m
> CONFIG_SENSORS_DME1737=m
> CONFIG_SENSORS_EMC1403=m
> CONFIG_SENSORS_EMC2103=m
> # CONFIG_SENSORS_EMC6W201 is not set
> CONFIG_SENSORS_SMSC47M1=m
> # CONFIG_SENSORS_SMSC47M192 is not set
> CONFIG_SENSORS_SMSC47B397=m
> CONFIG_SENSORS_SCH56XX_COMMON=m
> # CONFIG_SENSORS_SCH5627 is not set
> CONFIG_SENSORS_SCH5636=m
> CONFIG_SENSORS_STTS751=m
> # CONFIG_SENSORS_SMM665 is not set
> CONFIG_SENSORS_ADC128D818=m
> CONFIG_SENSORS_ADS1015=m
> CONFIG_SENSORS_ADS7828=m
> CONFIG_SENSORS_AMC6821=m
> CONFIG_SENSORS_INA209=m
> CONFIG_SENSORS_INA2XX=m
> # CONFIG_SENSORS_INA3221 is not set
> CONFIG_SENSORS_TC74=m
> # CONFIG_SENSORS_THMC50 is not set
> CONFIG_SENSORS_TMP102=m
> CONFIG_SENSORS_TMP103=m
> CONFIG_SENSORS_TMP108=m
> CONFIG_SENSORS_TMP401=m
> # CONFIG_SENSORS_TMP421 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=m
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_VT1211=m
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> CONFIG_SENSORS_W83791D=m
> CONFIG_SENSORS_W83792D=m
> CONFIG_SENSORS_W83793=m
> CONFIG_SENSORS_W83795=m
> CONFIG_SENSORS_W83795_FANCTRL=y
> CONFIG_SENSORS_W83L785TS=m
> CONFIG_SENSORS_W83L786NG=m
> CONFIG_SENSORS_W83627HF=m
> CONFIG_SENSORS_W83627EHF=m
> 
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> # CONFIG_SENSORS_ATK0110 is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_OF=y
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_CLOCK_THERMAL is not set
> # CONFIG_DEVFREQ_THERMAL is not set
> # CONFIG_THERMAL_EMULATION is not set
> # CONFIG_QORIQ_THERMAL is not set
> # CONFIG_DA9062_THERMAL is not set
> # CONFIG_INTEL_POWERCLAMP is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # CONFIG_INTEL_PCH_THERMAL is not set
> # CONFIG_QCOM_SPMI_TEMP_ALARM is not set
> # CONFIG_GENERIC_ADC_THERMAL is not set
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> CONFIG_WATCHDOG_SYSFS=y
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=y
> # CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
> CONFIG_DA9062_WATCHDOG=m
> # CONFIG_GPIO_WATCHDOG is not set
> CONFIG_MENF21BMC_WATCHDOG=m
> # CONFIG_WDAT_WDT is not set
> CONFIG_XILINX_WATCHDOG=m
> CONFIG_ZIIRAVE_WATCHDOG=y
> CONFIG_RAVE_SP_WATCHDOG=m
> CONFIG_CADENCE_WATCHDOG=m
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_RETU_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> CONFIG_ALIM1535_WDT=m
> CONFIG_ALIM7101_WDT=y
> CONFIG_EBC_C384_WDT=m
> # CONFIG_F71808E_WDT is not set
> CONFIG_SP5100_TCO=m
> CONFIG_SBC_FITPC2_WATCHDOG=y
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> CONFIG_IBMASR=m
> CONFIG_WAFER_WDT=m
> # CONFIG_I6300ESB_WDT is not set
> CONFIG_IE6XX_WDT=y
> CONFIG_ITCO_WDT=y
> # CONFIG_ITCO_VENDOR_SUPPORT is not set
> CONFIG_IT8712F_WDT=y
> # CONFIG_IT87_WDT is not set
> CONFIG_HP_WATCHDOG=y
> # CONFIG_KEMPLD_WDT is not set
> CONFIG_HPWDT_NMI_DECODING=y
> # CONFIG_SC1200_WDT is not set
> CONFIG_PC87413_WDT=m
> # CONFIG_NV_TCO is not set
> CONFIG_RDC321X_WDT=y
> CONFIG_60XX_WDT=m
> CONFIG_SBC8360_WDT=y
> # CONFIG_SBC7240_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=y
> CONFIG_SMSC37B787_WDT=y
> CONFIG_VIA_WDT=m
> CONFIG_W83627HF_WDT=y
> CONFIG_W83877F_WDT=y
> CONFIG_W83977F_WDT=m
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> # CONFIG_INTEL_MEI_WDT is not set
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> CONFIG_MEN_A21_WDT=y
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=y
> CONFIG_WDTPCI=y
> 
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
> # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_SILENT=y
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> CONFIG_SSB_DRIVER_PCICORE=y
> CONFIG_SSB_DRIVER_GPIO=y
> CONFIG_BCMA_POSSIBLE=y
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_CS5535 is not set
> CONFIG_MFD_ACT8945A=m
> CONFIG_MFD_AS3711=y
> CONFIG_MFD_AS3722=y
> CONFIG_PMIC_ADP5520=y
> # CONFIG_MFD_AAT2870_CORE is not set
> CONFIG_MFD_ATMEL_FLEXCOM=m
> CONFIG_MFD_ATMEL_HLCDC=y
> CONFIG_MFD_BCM590XX=y
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> CONFIG_MFD_CROS_EC=m
> CONFIG_MFD_CROS_EC_I2C=m
> CONFIG_MFD_CROS_EC_CHARDEV=m
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> CONFIG_MFD_DA9062=m
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> CONFIG_MFD_HI6421_PMIC=y
> CONFIG_HTC_PASIC3=m
> # CONFIG_HTC_I2CPLD is not set
> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> CONFIG_MFD_KEMPLD=m
> CONFIG_MFD_88PM800=m
> CONFIG_MFD_88PM805=y
> # CONFIG_MFD_88PM860X is not set
> CONFIG_MFD_MAX14577=m
> # CONFIG_MFD_MAX77620 is not set
> CONFIG_MFD_MAX77686=m
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> CONFIG_MFD_MAX8907=y
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> CONFIG_MFD_MAX8998=y
> CONFIG_MFD_MT6397=m
> CONFIG_MFD_MENF21BMC=m
> CONFIG_MFD_RETU=y
> CONFIG_MFD_PCF50633=m
> CONFIG_PCF50633_ADC=m
> CONFIG_PCF50633_GPIO=m
> CONFIG_MFD_RDC321X=y
> CONFIG_MFD_RT5033=m
> CONFIG_MFD_RC5T583=y
> # CONFIG_MFD_RK808 is not set
> # CONFIG_MFD_RN5T618 is not set
> # CONFIG_MFD_SEC_CORE is not set
> CONFIG_MFD_SI476X_CORE=m
> CONFIG_MFD_SM501=y
> # CONFIG_MFD_SM501_GPIO is not set
> # CONFIG_MFD_SKY81452 is not set
> CONFIG_MFD_SMSC=y
> # CONFIG_ABX500_CORE is not set
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> CONFIG_STMPE_I2C=y
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=m
> CONFIG_MFD_LP3943=y
> # CONFIG_MFD_LP8788 is not set
> CONFIG_MFD_TI_LMU=m
> CONFIG_MFD_PALMAS=y
> CONFIG_TPS6105X=m
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=y
> CONFIG_MFD_TPS65086=y
> CONFIG_MFD_TPS65090=y
> CONFIG_MFD_TPS65217=m
> # CONFIG_MFD_TPS68470 is not set
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TI_LP87565=y
> # CONFIG_MFD_TPS65218 is not set
> CONFIG_MFD_TPS6586X=y
> CONFIG_MFD_TPS65910=y
> CONFIG_MFD_TPS65912=m
> CONFIG_MFD_TPS65912_I2C=m
> CONFIG_MFD_TPS80031=y
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> CONFIG_MFD_WL1273_CORE=m
> CONFIG_MFD_LM3533=m
> # CONFIG_MFD_TIMBERDALE is not set
> # CONFIG_MFD_TC3589X is not set
> CONFIG_MFD_VX855=y
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=m
> # CONFIG_MFD_CS47L24 is not set
> CONFIG_MFD_WM5102=y
> # CONFIG_MFD_WM5110 is not set
> CONFIG_MFD_WM8997=y
> # CONFIG_MFD_WM8998 is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> CONFIG_RAVE_SP_CORE=m
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_DEBUG=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=m
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> CONFIG_REGULATOR_88PG86X=m
> # CONFIG_REGULATOR_88PM800 is not set
> CONFIG_REGULATOR_ACT8865=y
> CONFIG_REGULATOR_ACT8945A=m
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_ANATOP is not set
> # CONFIG_REGULATOR_AS3711 is not set
> CONFIG_REGULATOR_AS3722=y
> # CONFIG_REGULATOR_BCM590XX is not set
> CONFIG_REGULATOR_DA9062=m
> # CONFIG_REGULATOR_DA9210 is not set
> CONFIG_REGULATOR_DA9211=m
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_GPIO=m
> CONFIG_REGULATOR_HI6421=y
> # CONFIG_REGULATOR_HI6421V530 is not set
> CONFIG_REGULATOR_ISL9305=y
> # CONFIG_REGULATOR_ISL6271A is not set
> # CONFIG_REGULATOR_LM363X is not set
> CONFIG_REGULATOR_LP3971=y
> CONFIG_REGULATOR_LP3972=y
> CONFIG_REGULATOR_LP872X=y
> CONFIG_REGULATOR_LP873X=y
> CONFIG_REGULATOR_LP8755=m
> # CONFIG_REGULATOR_LP87565 is not set
> # CONFIG_REGULATOR_LTC3589 is not set
> # CONFIG_REGULATOR_LTC3676 is not set
> CONFIG_REGULATOR_MAX14577=m
> CONFIG_REGULATOR_MAX1586=y
> CONFIG_REGULATOR_MAX8649=y
> # CONFIG_REGULATOR_MAX8660 is not set
> # CONFIG_REGULATOR_MAX8907 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> # CONFIG_REGULATOR_MAX8973 is not set
> # CONFIG_REGULATOR_MAX8998 is not set
> CONFIG_REGULATOR_MAX77686=m
> CONFIG_REGULATOR_MAX77802=m
> CONFIG_REGULATOR_MT6311=m
> CONFIG_REGULATOR_MT6323=m
> # CONFIG_REGULATOR_MT6397 is not set
> CONFIG_REGULATOR_PALMAS=y
> CONFIG_REGULATOR_PCF50633=m
> CONFIG_REGULATOR_PFUZE100=m
> # CONFIG_REGULATOR_PV88060 is not set
> CONFIG_REGULATOR_PV88080=m
> CONFIG_REGULATOR_PV88090=y
> CONFIG_REGULATOR_QCOM_SPMI=m
> CONFIG_REGULATOR_RC5T583=m
> CONFIG_REGULATOR_RT5033=m
> # CONFIG_REGULATOR_SY8106A is not set
> CONFIG_REGULATOR_TPS51632=m
> CONFIG_REGULATOR_TPS6105X=m
> # CONFIG_REGULATOR_TPS62360 is not set
> CONFIG_REGULATOR_TPS65023=m
> CONFIG_REGULATOR_TPS6507X=m
> # CONFIG_REGULATOR_TPS65086 is not set
> # CONFIG_REGULATOR_TPS65090 is not set
> # CONFIG_REGULATOR_TPS65132 is not set
> CONFIG_REGULATOR_TPS65217=m
> CONFIG_REGULATOR_TPS6586X=m
> CONFIG_REGULATOR_TPS65910=m
> CONFIG_REGULATOR_TPS65912=m
> CONFIG_REGULATOR_TPS80031=m
> CONFIG_REGULATOR_VCTRL=y
> CONFIG_CEC_CORE=m
> CONFIG_CEC_NOTIFIER=y
> # CONFIG_RC_CORE is not set
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> CONFIG_AGP=y
> CONFIG_AGP_ALI=y
> CONFIG_AGP_ATI=m
> CONFIG_AGP_AMD=m
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=m
> CONFIG_AGP_NVIDIA=y
> CONFIG_AGP_SIS=y
> CONFIG_AGP_SWORKS=y
> # CONFIG_AGP_VIA is not set
> CONFIG_AGP_EFFICEON=m
> CONFIG_INTEL_GTT=m
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=m
> CONFIG_DRM_MIPI_DSI=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> CONFIG_DRM_DEBUG_SELFTEST=m
> CONFIG_DRM_KMS_HELPER=m
> CONFIG_DRM_KMS_FB_HELPER=y
> # CONFIG_DRM_FBDEV_EMULATION is not set
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> CONFIG_DRM_TTM=m
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_KMS_CMA_HELPER=y
> CONFIG_DRM_VM=y
> CONFIG_DRM_SCHED=m
> 
> #
> # I2C encoder or helper chips
> #
> # CONFIG_DRM_I2C_CH7006 is not set
> # CONFIG_DRM_I2C_SIL164 is not set
> CONFIG_DRM_I2C_NXP_TDA998X=m
> CONFIG_DRM_I2C_NXP_TDA9950=m
> CONFIG_DRM_RADEON=m
> # CONFIG_DRM_RADEON_USERPTR is not set
> CONFIG_DRM_AMDGPU=m
> # CONFIG_DRM_AMDGPU_SI is not set
> # CONFIG_DRM_AMDGPU_CIK is not set
> CONFIG_DRM_AMDGPU_USERPTR=y
> CONFIG_DRM_AMDGPU_GART_DEBUGFS=y
> 
> #
> # ACP (Audio CoProcessor) Configuration
> #
> # CONFIG_DRM_AMD_ACP is not set
> 
> #
> # Display Engine Configuration
> #
> CONFIG_DRM_AMD_DC=y
> # CONFIG_DRM_AMD_DC_FBC is not set
> CONFIG_DRM_AMD_DC_DCN1_0=y
> # CONFIG_DEBUG_KERNEL_DC is not set
> 
> #
> # AMD Library routines
> #
> CONFIG_CHASH=m
> # CONFIG_CHASH_STATS is not set
> CONFIG_CHASH_SELFTEST=y
> CONFIG_DRM_NOUVEAU=m
> CONFIG_NOUVEAU_DEBUG=5
> CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> CONFIG_NOUVEAU_DEBUG_MMU=y
> # CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
> CONFIG_DRM_I915=m
> # CONFIG_DRM_I915_ALPHA_SUPPORT is not set
> # CONFIG_DRM_I915_CAPTURE_ERROR is not set
> # CONFIG_DRM_I915_USERPTR is not set
> 
> #
> # drm/i915 Debugging
> #
> # CONFIG_DRM_I915_WERROR is not set
> # CONFIG_DRM_I915_DEBUG is not set
> # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
> CONFIG_DRM_I915_DEBUG_GUC=y
> # CONFIG_DRM_I915_SELFTEST is not set
> CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> CONFIG_DRM_VGEM=m
> # CONFIG_DRM_VMWGFX is not set
> CONFIG_DRM_GMA500=m
> CONFIG_DRM_GMA600=y
> # CONFIG_DRM_GMA3600 is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> # CONFIG_DRM_CIRRUS_QEMU is not set
> CONFIG_DRM_RCAR_DW_HDMI=m
> CONFIG_DRM_RCAR_LVDS=m
> CONFIG_DRM_QXL=m
> # CONFIG_DRM_BOCHS is not set
> CONFIG_DRM_VIRTIO_GPU=m
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> CONFIG_DRM_PANEL_ARM_VERSATILE=m
> CONFIG_DRM_PANEL_LVDS=m
> CONFIG_DRM_PANEL_SIMPLE=m
> # CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
> # CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
> # CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
> CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
> CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
> # CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_ANALOGIX_ANX78XX=m
> CONFIG_DRM_CDNS_DSI=m
> # CONFIG_DRM_DUMB_VGA_DAC is not set
> CONFIG_DRM_LVDS_ENCODER=m
> CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
> CONFIG_DRM_NXP_PTN3460=m
> # CONFIG_DRM_PARADE_PS8622 is not set
> CONFIG_DRM_SII902X=m
> CONFIG_DRM_SII9234=m
> # CONFIG_DRM_THINE_THC63LVD1024 is not set
> CONFIG_DRM_TOSHIBA_TC358767=m
> CONFIG_DRM_TI_TFP410=m
> # CONFIG_DRM_I2C_ADV7511 is not set
> CONFIG_DRM_DW_HDMI=m
> CONFIG_DRM_DW_HDMI_CEC=m
> CONFIG_DRM_ARCPGU=m
> # CONFIG_DRM_HISI_HIBMC is not set
> CONFIG_DRM_MXS=y
> CONFIG_DRM_MXSFB=m
> CONFIG_DRM_TINYDRM=m
> CONFIG_DRM_LEGACY=y
> # CONFIG_DRM_TDFX is not set
> CONFIG_DRM_R128=m
> CONFIG_DRM_MGA=m
> # CONFIG_DRM_SIS is not set
> CONFIG_DRM_VIA=m
> CONFIG_DRM_SAVAGE=m
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
> CONFIG_DRM_LIB_RANDOM=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB=m
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB_DDC=m
> CONFIG_FB_CFB_FILLRECT=m
> CONFIG_FB_CFB_COPYAREA=m
> CONFIG_FB_CFB_IMAGEBLIT=m
> CONFIG_FB_SYS_FILLRECT=m
> CONFIG_FB_SYS_COPYAREA=m
> CONFIG_FB_SYS_IMAGEBLIT=m
> CONFIG_FB_FOREIGN_ENDIAN=y
> # CONFIG_FB_BOTH_ENDIAN is not set
> CONFIG_FB_BIG_ENDIAN=y
> # CONFIG_FB_LITTLE_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=m
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=m
> CONFIG_FB_SVGALIB=m
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> CONFIG_FB_CIRRUS=m
> # CONFIG_FB_PM2 is not set
> CONFIG_FB_CYBER2000=m
> CONFIG_FB_CYBER2000_DDC=y
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_N411=m
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> CONFIG_FB_S1D13XXX=m
> # CONFIG_FB_NVIDIA is not set
> CONFIG_FB_RIVA=m
> CONFIG_FB_RIVA_I2C=y
> CONFIG_FB_RIVA_DEBUG=y
> # CONFIG_FB_RIVA_BACKLIGHT is not set
> # CONFIG_FB_I740 is not set
> CONFIG_FB_I810=m
> # CONFIG_FB_I810_GTF is not set
> # CONFIG_FB_LE80578 is not set
> CONFIG_FB_INTEL=m
> CONFIG_FB_INTEL_DEBUG=y
> # CONFIG_FB_INTEL_I2C is not set
> CONFIG_FB_MATROX=m
> CONFIG_FB_MATROX_MILLENIUM=y
> CONFIG_FB_MATROX_MYSTIQUE=y
> # CONFIG_FB_MATROX_G is not set
> # CONFIG_FB_MATROX_I2C is not set
> CONFIG_FB_RADEON=m
> CONFIG_FB_RADEON_I2C=y
> # CONFIG_FB_RADEON_BACKLIGHT is not set
> CONFIG_FB_RADEON_DEBUG=y
> CONFIG_FB_ATY128=m
> CONFIG_FB_ATY128_BACKLIGHT=y
> CONFIG_FB_ATY=m
> # CONFIG_FB_ATY_CT is not set
> CONFIG_FB_ATY_GX=y
> # CONFIG_FB_ATY_BACKLIGHT is not set
> # CONFIG_FB_S3 is not set
> CONFIG_FB_SAVAGE=m
> CONFIG_FB_SAVAGE_I2C=y
> # CONFIG_FB_SAVAGE_ACCEL is not set
> # CONFIG_FB_SIS is not set
> CONFIG_FB_VIA=m
> CONFIG_FB_VIA_DIRECT_PROCFS=y
> # CONFIG_FB_VIA_X_COMPATIBILITY is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> CONFIG_FB_3DFX=m
> CONFIG_FB_3DFX_ACCEL=y
> # CONFIG_FB_3DFX_I2C is not set
> CONFIG_FB_VOODOO1=m
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> CONFIG_FB_ARK=m
> CONFIG_FB_PM3=m
> CONFIG_FB_CARMINE=m
> CONFIG_FB_CARMINE_DRAM_EVAL=y
> # CONFIG_CARMINE_DRAM_CUSTOM is not set
> CONFIG_FB_GEODE=y
> # CONFIG_FB_GEODE_LX is not set
> CONFIG_FB_GEODE_GX=m
> # CONFIG_FB_GEODE_GX1 is not set
> # CONFIG_FB_SM501 is not set
> CONFIG_FB_IBM_GXT4500=m
> CONFIG_FB_VIRTUAL=m
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_BROADSHEET=m
> # CONFIG_FB_SSD1307 is not set
> CONFIG_FB_SM712=m
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=m
> CONFIG_LCD_PLATFORM=m
> CONFIG_BACKLIGHT_CLASS_DEVICE=m
> CONFIG_BACKLIGHT_GENERIC=m
> CONFIG_BACKLIGHT_LM3533=m
> # CONFIG_BACKLIGHT_APPLE is not set
> # CONFIG_BACKLIGHT_PM8941_WLED is not set
> CONFIG_BACKLIGHT_SAHARA=m
> CONFIG_BACKLIGHT_ADP5520=m
> # CONFIG_BACKLIGHT_ADP8860 is not set
> CONFIG_BACKLIGHT_ADP8870=m
> # CONFIG_BACKLIGHT_PCF50633 is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_TPS65217=m
> CONFIG_BACKLIGHT_AS3711=m
> # CONFIG_BACKLIGHT_GPIO is not set
> CONFIG_BACKLIGHT_LV5207LP=m
> CONFIG_BACKLIGHT_BD6107=m
> CONFIG_BACKLIGHT_ARCXCNN=m
> CONFIG_BACKLIGHT_RAVE_SP=m
> CONFIG_VGASTATE=m
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> CONFIG_SOUND=m
> # CONFIG_SND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> # CONFIG_HID_ACRUX is not set
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_ASUS is not set
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> # CONFIG_HID_CHERRY is not set
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CMEDIA is not set
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELECOM is not set
> # CONFIG_HID_EZKEY is not set
> # CONFIG_HID_GEMBIRD is not set
> # CONFIG_HID_GFRM is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> # CONFIG_HID_ITE is not set
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> # CONFIG_HID_KENSINGTON is not set
> # CONFIG_HID_LCPOWER is not set
> # CONFIG_HID_LED is not set
> # CONFIG_HID_LENOVO is not set
> # CONFIG_HID_LOGITECH is not set
> # CONFIG_HID_MAGICMOUSE is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_REDRAGON is not set
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NTI is not set
> # CONFIG_HID_ORTEK is not set
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_SAITEK is not set
> # CONFIG_HID_SAMSUNG is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEAM is not set
> # CONFIG_HID_STEELSERIES is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> # CONFIG_HID_GREENASIA is not set
> # CONFIG_HID_SMARTJOYPLUS is not set
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THINGM is not set
> # CONFIG_HID_THRUSTMASTER is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_TAHVO_USB is not set
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ULPI_BUS is not set
> CONFIG_UWB=y
> CONFIG_UWB_WHCI=y
> # CONFIG_MMC is not set
> CONFIG_MEMSTICK=y
> # CONFIG_MEMSTICK_DEBUG is not set
> 
> #
> # MemoryStick drivers
> #
> CONFIG_MEMSTICK_UNSAFE_RESUME=y
> # CONFIG_MSPRO_BLOCK is not set
> CONFIG_MS_BLOCK=y
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=m
> CONFIG_MEMSTICK_JMICRON_38X=y
> # CONFIG_MEMSTICK_R592 is not set
> CONFIG_MEMSTICK_REALTEK_PCI=m
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=m
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_AAT1290 is not set
> CONFIG_LEDS_AS3645A=m
> CONFIG_LEDS_BCM6328=y
> # CONFIG_LEDS_BCM6358 is not set
> CONFIG_LEDS_LM3530=y
> CONFIG_LEDS_LM3533=m
> CONFIG_LEDS_LM3642=y
> CONFIG_LEDS_LM3692X=y
> # CONFIG_LEDS_LM3601X is not set
> # CONFIG_LEDS_MT6323 is not set
> # CONFIG_LEDS_PCA9532 is not set
> CONFIG_LEDS_GPIO=m
> # CONFIG_LEDS_LP3944 is not set
> CONFIG_LEDS_LP3952=m
> CONFIG_LEDS_LP55XX_COMMON=m
> CONFIG_LEDS_LP5521=m
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> CONFIG_LEDS_LP8501=m
> CONFIG_LEDS_LP8860=m
> CONFIG_LEDS_PCA955X=y
> CONFIG_LEDS_PCA955X_GPIO=y
> CONFIG_LEDS_PCA963X=y
> CONFIG_LEDS_REGULATOR=m
> CONFIG_LEDS_BD2802=y
> CONFIG_LEDS_LT3593=m
> CONFIG_LEDS_ADP5520=m
> # CONFIG_LEDS_TCA6507 is not set
> CONFIG_LEDS_TLC591XX=m
> # CONFIG_LEDS_LM355x is not set
> # CONFIG_LEDS_OT200 is not set
> # CONFIG_LEDS_MENF21BMC is not set
> # CONFIG_LEDS_KTD2692 is not set
> CONFIG_LEDS_IS31FL319X=y
> # CONFIG_LEDS_IS31FL32XX is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=m
> CONFIG_LEDS_SYSCON=y
> CONFIG_LEDS_MLXREG=m
> CONFIG_LEDS_USER=m
> # CONFIG_LEDS_NIC78BX is not set
> 
> #
> # LED Triggers
> #
> # CONFIG_LEDS_TRIGGERS is not set
> CONFIG_ACCESSIBILITY=y
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> CONFIG_EDAC_DEBUG=y
> # CONFIG_EDAC_AMD76X is not set
> CONFIG_EDAC_E7XXX=m
> # CONFIG_EDAC_E752X is not set
> CONFIG_EDAC_I82875P=m
> CONFIG_EDAC_I82975X=m
> CONFIG_EDAC_I3000=m
> CONFIG_EDAC_I3200=y
> CONFIG_EDAC_IE31200=m
> # CONFIG_EDAC_X38 is not set
> # CONFIG_EDAC_I5400 is not set
> CONFIG_EDAC_I82860=y
> # CONFIG_EDAC_R82600 is not set
> # CONFIG_EDAC_I5000 is not set
> CONFIG_EDAC_I5100=m
> CONFIG_EDAC_I7300=y
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> # CONFIG_RTC_CLASS is not set
> CONFIG_DMADEVICES=y
> CONFIG_DMADEVICES_DEBUG=y
> CONFIG_DMADEVICES_VDEBUG=y
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> CONFIG_DMA_OF=y
> CONFIG_ALTERA_MSGDMA=m
> # CONFIG_DW_AXI_DMAC is not set
> # CONFIG_FSL_EDMA is not set
> CONFIG_INTEL_IDMA64=m
> CONFIG_PCH_DMA=m
> CONFIG_QCOM_HIDMA_MGMT=y
> CONFIG_QCOM_HIDMA=y
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=y
> CONFIG_DW_DMAC_PCI=y
> CONFIG_HSU_DMA=y
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=y
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> CONFIG_SW_SYNC=y
> CONFIG_AUXDISPLAY=y
> CONFIG_HD44780=m
> CONFIG_IMG_ASCII_LCD=m
> # CONFIG_HT16K33 is not set
> CONFIG_PANEL=m
> CONFIG_PANEL_PARPORT=0
> CONFIG_PANEL_PROFILE=5
> # CONFIG_PANEL_CHANGE_MESSAGE is not set
> CONFIG_CHARLCD=m
> CONFIG_UIO=m
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=m
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=m
> CONFIG_UIO_SERCOS3=m
> CONFIG_UIO_PCI_GENERIC=m
> CONFIG_UIO_NETX=m
> CONFIG_UIO_PRUSS=m
> # CONFIG_UIO_MF624 is not set
> CONFIG_VIRT_DRIVERS=y
> # CONFIG_VBOXGUEST is not set
> CONFIG_VIRTIO=y
> # CONFIG_VIRTIO_MENU is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> CONFIG_STAGING=y
> # CONFIG_COMEDI is not set
> CONFIG_FB_OLPC_DCON=m
> CONFIG_FB_OLPC_DCON_1_5=y
> CONFIG_RTLLIB=m
> CONFIG_RTLLIB_CRYPTO_CCMP=m
> CONFIG_RTLLIB_CRYPTO_TKIP=m
> CONFIG_RTLLIB_CRYPTO_WEP=m
> CONFIG_RTL8192E=m
> CONFIG_R8822BE=m
> CONFIG_RTLWIFI_DEBUG_ST=y
> CONFIG_RTS5208=y
> CONFIG_VT6655=m
> 
> #
> # IIO staging drivers
> #
> 
> #
> # Accelerometers
> #
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD7606=m
> CONFIG_AD7606_IFACE_PARALLEL=m
> 
> #
> # Analog digital bi-direction converters
> #
> # CONFIG_ADT7316 is not set
> 
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> CONFIG_AD7152=m
> CONFIG_AD7746=m
> 
> #
> # Direct Digital Synthesis
> #
> 
> #
> # Digital gyroscope sensors
> #
> 
> #
> # Network Analyzer, Impedance Converters
> #
> # CONFIG_AD5933 is not set
> 
> #
> # Active energy metering IC
> #
> CONFIG_ADE7854=m
> CONFIG_ADE7854_I2C=m
> 
> #
> # Resolver to digital converters
> #
> CONFIG_FB_SM750=m
> # CONFIG_FB_XGI is not set
> 
> #
> # Speakup console speech
> #
> # CONFIG_STAGING_MEDIA is not set
> 
> #
> # Android
> #
> # CONFIG_STAGING_BOARD is not set
> # CONFIG_FIREWIRE_SERIAL is not set
> # CONFIG_DGNC is not set
> CONFIG_GS_FPGABOOT=y
> CONFIG_UNISYSSPAR=y
> CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
> CONFIG_MOST=y
> CONFIG_MOST_CDEV=y
> # CONFIG_MOST_NET is not set
> CONFIG_MOST_DIM2=m
> # CONFIG_MOST_I2C is not set
> CONFIG_GREYBUS=y
> CONFIG_GREYBUS_AUDIO=m
> CONFIG_GREYBUS_BOOTROM=y
> # CONFIG_GREYBUS_HID is not set
> # CONFIG_GREYBUS_LIGHT is not set
> # CONFIG_GREYBUS_LOG is not set
> CONFIG_GREYBUS_LOOPBACK=y
> CONFIG_GREYBUS_POWER=m
> # CONFIG_GREYBUS_RAW is not set
> CONFIG_GREYBUS_VIBRATOR=y
> # CONFIG_GREYBUS_BRIDGED_PHY is not set
> 
> #
> # USB Power Delivery and Type-C drivers
> #
> CONFIG_DRM_VBOXVIDEO=m
> CONFIG_X86_PLATFORM_DEVICES=y
> # CONFIG_ACER_WMI is not set
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ALIENWARE_WMI is not set
> # CONFIG_ASUS_LAPTOP is not set
> CONFIG_DELL_SMBIOS=m
> CONFIG_DELL_SMBIOS_WMI=y
> CONFIG_DELL_WMI_DESCRIPTOR=m
> # CONFIG_DELL_WMI_AIO is not set
> # CONFIG_DELL_WMI_LED is not set
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_DELL_RBTN is not set
> # CONFIG_FUJITSU_LAPTOP is not set
> # CONFIG_FUJITSU_TABLET is not set
> CONFIG_AMILO_RFKILL=m
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_TC1100_WMI is not set
> # CONFIG_HP_ACCEL is not set
> # CONFIG_HP_WIRELESS is not set
> # CONFIG_HP_WMI is not set
> # CONFIG_MSI_LAPTOP is not set
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_COMPAL_LAPTOP is not set
> # CONFIG_SONY_LAPTOP is not set
> # CONFIG_IDEAPAD_LAPTOP is not set
> # CONFIG_THINKPAD_ACPI is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_INTEL_MENLOW is not set
> # CONFIG_EEEPC_LAPTOP is not set
> # CONFIG_ASUS_WMI is not set
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ACPI_WMI=m
> CONFIG_WMI_BMOF=m
> # CONFIG_INTEL_WMI_THUNDERBOLT is not set
> # CONFIG_MSI_WMI is not set
> # CONFIG_PEAQ_WMI is not set
> # CONFIG_TOPSTAR_LAPTOP is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> # CONFIG_ACPI_CMPC is not set
> # CONFIG_INTEL_CHT_INT33FE is not set
> # CONFIG_INTEL_INT0002_VGPIO is not set
> # CONFIG_INTEL_HID_EVENT is not set
> # CONFIG_INTEL_VBTN is not set
> # CONFIG_INTEL_IPS is not set
> CONFIG_INTEL_PMC_CORE=y
> CONFIG_IBM_RTL=m
> CONFIG_XO1_RFKILL=m
> # CONFIG_XO15_EBOOK is not set
> CONFIG_SAMSUNG_LAPTOP=m
> CONFIG_MXM_WMI=m
> # CONFIG_INTEL_OAKTRAIL is not set
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> # CONFIG_PVPANIC is not set
> # CONFIG_INTEL_PMC_IPC is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_INTEL_PUNIT_IPC=y
> # CONFIG_MLX_PLATFORM is not set
> CONFIG_PMC_ATOM=y
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CHROMEOS_PSTORE=y
> # CONFIG_CHROMEOS_TBMC is not set
> CONFIG_CROS_EC_CTL=m
> # CONFIG_CROS_EC_LPC is not set
> CONFIG_CROS_EC_PROTO=y
> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> CONFIG_MELLANOX_PLATFORM=y
> # CONFIG_MLXREG_HOTPLUG is not set
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> CONFIG_CLK_HSDK=y
> CONFIG_COMMON_CLK_MAX77686=m
> CONFIG_COMMON_CLK_SI5351=y
> CONFIG_COMMON_CLK_SI514=m
> # CONFIG_COMMON_CLK_SI544 is not set
> CONFIG_COMMON_CLK_SI570=y
> # CONFIG_COMMON_CLK_CDCE706 is not set
> CONFIG_COMMON_CLK_CDCE925=m
> CONFIG_COMMON_CLK_CS2000_CP=m
> CONFIG_COMMON_CLK_PALMAS=m
> CONFIG_COMMON_CLK_VC5=m
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> CONFIG_MAILBOX=y
> CONFIG_PLATFORM_MHU=y
> # CONFIG_PCC is not set
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_MAILBOX_TEST=y
> # CONFIG_IOMMU_SUPPORT is not set
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=m
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_VIRTIO=y
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> 
> #
> # Broadcom SoC drivers
> #
> 
> #
> # i.MX SoC drivers
> #
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> CONFIG_XILINX_VCU=m
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> CONFIG_DEVFREQ_GOV_USERSPACE=m
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=y
> CONFIG_EXTCON=m
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=m
> # CONFIG_EXTCON_GPIO is not set
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> CONFIG_EXTCON_MAX14577=m
> # CONFIG_EXTCON_MAX3355 is not set
> CONFIG_EXTCON_PALMAS=m
> CONFIG_EXTCON_RT8973A=m
> CONFIG_EXTCON_SM5502=m
> CONFIG_EXTCON_USB_GPIO=m
> CONFIG_EXTCON_USBC_CROS_EC=m
> CONFIG_MEMORY=y
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=m
> CONFIG_IIO_BUFFER_HW_CONSUMER=m
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=y
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> # CONFIG_IIO_SW_DEVICE is not set
> CONFIG_IIO_SW_TRIGGER=y
> 
> #
> # Accelerometers
> #
> # CONFIG_ADXL345_I2C is not set
> # CONFIG_BMA180 is not set
> # CONFIG_BMC150_ACCEL is not set
> CONFIG_DA280=y
> CONFIG_DA311=m
> # CONFIG_DMARD06 is not set
> CONFIG_DMARD09=m
> # CONFIG_DMARD10 is not set
> CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
> # CONFIG_IIO_ST_ACCEL_3AXIS is not set
> CONFIG_KXSD9=m
> CONFIG_KXSD9_I2C=m
> CONFIG_KXCJK1013=y
> CONFIG_MC3230=y
> CONFIG_MMA7455=y
> CONFIG_MMA7455_I2C=y
> CONFIG_MMA7660=y
> CONFIG_MMA8452=y
> # CONFIG_MMA9551 is not set
> # CONFIG_MMA9553 is not set
> # CONFIG_MXC4005 is not set
> CONFIG_MXC6255=y
> CONFIG_STK8312=m
> CONFIG_STK8BA50=m
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD7291=m
> CONFIG_AD799X=y
> # CONFIG_CC10001_ADC is not set
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_HX711 is not set
> CONFIG_INA2XX_ADC=m
> CONFIG_LTC2471=y
> CONFIG_LTC2485=y
> CONFIG_LTC2497=y
> # CONFIG_MAX1363 is not set
> CONFIG_MAX9611=y
> CONFIG_MCP3422=m
> CONFIG_MEN_Z188_ADC=m
> # CONFIG_NAU7802 is not set
> # CONFIG_PALMAS_GPADC is not set
> CONFIG_QCOM_SPMI_IADC=m
> # CONFIG_QCOM_SPMI_VADC is not set
> CONFIG_SD_ADC_MODULATOR=y
> CONFIG_TI_ADC081C=y
> CONFIG_TI_ADS1015=m
> CONFIG_TI_AM335X_ADC=m
> # CONFIG_VF610_ADC is not set
> 
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> 
> #
> # Amplifiers
> #
> 
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> CONFIG_CCS811=y
> CONFIG_IAQCORE=y
> # CONFIG_VZ89X is not set
> CONFIG_IIO_CROS_EC_SENSORS_CORE=m
> # CONFIG_IIO_CROS_EC_SENSORS is not set
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_IIO_MS_SENSORS_I2C=m
> 
> #
> # SSP Sensor Common
> #
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Counters
> #
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD5064=y
> CONFIG_AD5380=m
> CONFIG_AD5446=y
> # CONFIG_AD5593R is not set
> # CONFIG_AD5696_I2C is not set
> # CONFIG_DPOT_DAC is not set
> # CONFIG_DS4424 is not set
> CONFIG_M62332=m
> CONFIG_MAX517=y
> CONFIG_MAX5821=y
> # CONFIG_MCP4725 is not set
> # CONFIG_TI_DAC5571 is not set
> CONFIG_VF610_DAC=y
> 
> #
> # IIO dummy driver
> #
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> 
> #
> # Digital gyroscope sensors
> #
> CONFIG_BMG160=y
> CONFIG_BMG160_I2C=y
> CONFIG_MPU3050=y
> CONFIG_MPU3050_I2C=y
> CONFIG_IIO_ST_GYRO_3AXIS=m
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> CONFIG_ITG3200=y
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4404=y
> CONFIG_MAX30100=y
> CONFIG_MAX30102=m
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=y
> # CONFIG_DHT11 is not set
> CONFIG_HDC100X=m
> CONFIG_HTS221=y
> CONFIG_HTS221_I2C=y
> CONFIG_HTU21=m
> CONFIG_SI7005=m
> # CONFIG_SI7020 is not set
> 
> #
> # Inertial measurement units
> #
> CONFIG_BMI160=y
> CONFIG_BMI160_I2C=y
> CONFIG_KMX61=y
> # CONFIG_INV_MPU6050_I2C is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
> 
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> # CONFIG_ADJD_S311 is not set
> CONFIG_AL3320A=m
> # CONFIG_APDS9300 is not set
> CONFIG_APDS9960=m
> CONFIG_BH1750=m
> CONFIG_BH1780=y
> CONFIG_CM32181=y
> CONFIG_CM3232=y
> CONFIG_CM3323=m
> CONFIG_CM3605=m
> CONFIG_CM36651=m
> CONFIG_IIO_CROS_EC_LIGHT_PROX=m
> # CONFIG_GP2AP020A00F is not set
> CONFIG_SENSORS_ISL29018=m
> # CONFIG_SENSORS_ISL29028 is not set
> # CONFIG_ISL29125 is not set
> # CONFIG_JSA1212 is not set
> CONFIG_RPR0521=m
> # CONFIG_SENSORS_LM3533 is not set
> CONFIG_LTR501=m
> CONFIG_LV0104CS=m
> CONFIG_MAX44000=y
> CONFIG_OPT3001=y
> CONFIG_PA12203001=m
> CONFIG_SI1145=m
> CONFIG_STK3310=m
> # CONFIG_ST_UVIS25 is not set
> CONFIG_TCS3414=m
> CONFIG_TCS3472=y
> CONFIG_SENSORS_TSL2563=m
> CONFIG_TSL2583=m
> CONFIG_TSL2772=y
> CONFIG_TSL4531=m
> CONFIG_US5182D=m
> CONFIG_VCNL4000=y
> CONFIG_VEML6070=m
> # CONFIG_VL6180 is not set
> CONFIG_ZOPT2201=m
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=m
> CONFIG_AK8975=m
> CONFIG_AK09911=m
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_MAG3110=y
> # CONFIG_MMC35240 is not set
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> CONFIG_SENSORS_HMC5843=m
> CONFIG_SENSORS_HMC5843_I2C=m
> 
> #
> # Multiplexers
> #
> CONFIG_IIO_MUX=y
> 
> #
> # Inclinometer sensors
> #
> 
> #
> # Triggers - standalone
> #
> CONFIG_IIO_HRTIMER_TRIGGER=m
> CONFIG_IIO_INTERRUPT_TRIGGER=m
> CONFIG_IIO_TIGHTLOOP_TRIGGER=y
> CONFIG_IIO_SYSFS_TRIGGER=y
> 
> #
> # Digital potentiometers
> #
> CONFIG_AD5272=y
> # CONFIG_DS1803 is not set
> CONFIG_MCP4018=m
> CONFIG_MCP4531=y
> CONFIG_TPL0102=y
> 
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> CONFIG_BMP280=m
> CONFIG_BMP280_I2C=m
> CONFIG_IIO_CROS_EC_BARO=m
> # CONFIG_HP03 is not set
> CONFIG_MPL115=y
> CONFIG_MPL115_I2C=y
> CONFIG_MPL3115=y
> # CONFIG_MS5611 is not set
> # CONFIG_MS5637 is not set
> CONFIG_IIO_ST_PRESS=m
> CONFIG_IIO_ST_PRESS_I2C=m
> CONFIG_T5403=m
> # CONFIG_HP206C is not set
> CONFIG_ZPA2326=y
> CONFIG_ZPA2326_I2C=y
> 
> #
> # Lightning sensors
> #
> 
> #
> # Proximity and distance sensors
> #
> # CONFIG_LIDAR_LITE_V2 is not set
> CONFIG_RFD77402=y
> CONFIG_SRF04=y
> CONFIG_SX9500=m
> CONFIG_SRF08=m
> 
> #
> # Resolver to digital converters
> #
> 
> #
> # Temperature sensors
> #
> CONFIG_MLX90614=m
> CONFIG_MLX90632=y
> # CONFIG_TMP006 is not set
> CONFIG_TMP007=m
> CONFIG_TSYS01=m
> # CONFIG_TSYS02D is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_ARM_GIC_MAX_NR=1
> CONFIG_IPACK_BUS=y
> CONFIG_BOARD_TPCI200=y
> # CONFIG_SERIAL_IPOCTAL is not set
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_TI_SYSCON=m
> CONFIG_FMC=m
> # CONFIG_FMC_FAKEDEV is not set
> CONFIG_FMC_TRIVIAL=m
> CONFIG_FMC_WRITE_EEPROM=m
> CONFIG_FMC_CHARDEV=m
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_BCM_KONA_USB2_PHY is not set
> CONFIG_PHY_PXA_28NM_HSIC=m
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_CPCAP_USB is not set
> # CONFIG_PHY_MAPPHONE_MDM6600 is not set
> # CONFIG_POWERCAP is not set
> CONFIG_MCB=m
> CONFIG_MCB_PCI=m
> CONFIG_MCB_LPC=m
> 
> #
> # Performance monitor support
> #
> CONFIG_RAS=y
> # CONFIG_THUNDERBOLT is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> CONFIG_DAX=y
> CONFIG_DEV_DAX=m
> CONFIG_NVMEM=y
> CONFIG_RAVE_SP_EEPROM=m
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> CONFIG_INTEL_TH=y
> CONFIG_INTEL_TH_PCI=y
> # CONFIG_INTEL_TH_ACPI is not set
> CONFIG_INTEL_TH_GTH=y
> # CONFIG_INTEL_TH_MSU is not set
> CONFIG_INTEL_TH_PTI=m
> # CONFIG_INTEL_TH_DEBUG is not set
> CONFIG_FPGA=y
> CONFIG_ALTERA_PR_IP_CORE=m
> CONFIG_ALTERA_PR_IP_CORE_PLAT=m
> CONFIG_FPGA_MGR_ALTERA_CVP=m
> CONFIG_FPGA_BRIDGE=y
> CONFIG_XILINX_PR_DECOUPLER=y
> CONFIG_FPGA_REGION=m
> CONFIG_OF_FPGA_REGION=m
> CONFIG_FSI=m
> CONFIG_FSI_MASTER_GPIO=m
> CONFIG_FSI_MASTER_HUB=m
> # CONFIG_FSI_SCOM is not set
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> CONFIG_MUX_GPIO=y
> # CONFIG_MUX_MMIO is not set
> CONFIG_PM_OPP=y
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> 
> #
> # Firmware Drivers
> #
> CONFIG_EDD=m
> # CONFIG_EDD_OFF is not set
> # CONFIG_FIRMWARE_MEMMAP is not set
> CONFIG_DELL_RBU=y
> # CONFIG_DCDBAS is not set
> # CONFIG_ISCSI_IBFT_FIND is not set
> CONFIG_FW_CFG_SYSFS=y
> CONFIG_FW_CFG_SYSFS_CMDLINE=y
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # Tegra firmware driver
> #
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> # CONFIG_EXT4_FS_POSIX_ACL is not set
> CONFIG_EXT4_FS_SECURITY=y
> CONFIG_EXT4_ENCRYPTION=y
> CONFIG_EXT4_FS_ENCRYPTION=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=m
> CONFIG_REISERFS_CHECK=y
> CONFIG_REISERFS_PROC_INFO=y
> # CONFIG_REISERFS_FS_XATTR is not set
> CONFIG_JFS_FS=y
> CONFIG_JFS_POSIX_ACL=y
> # CONFIG_JFS_SECURITY is not set
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> CONFIG_NILFS2_FS=y
> CONFIG_F2FS_FS=y
> # CONFIG_F2FS_STAT_FS is not set
> CONFIG_F2FS_FS_XATTR=y
> CONFIG_F2FS_FS_POSIX_ACL=y
> CONFIG_F2FS_FS_SECURITY=y
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FS_ENCRYPTION is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> CONFIG_FS_DAX=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_PRINT_QUOTA_WARNING is not set
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=m
> CONFIG_QFMT_V1=y
> CONFIG_QFMT_V2=m
> CONFIG_QUOTACTL=y
> # CONFIG_AUTOFS4_FS is not set
> CONFIG_AUTOFS_FS=y
> # CONFIG_FUSE_FS is not set
> CONFIG_OVERLAY_FS=m
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> CONFIG_OVERLAY_FS_INDEX=y
> # CONFIG_OVERLAY_FS_NFS_EXPORT is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=y
> # CONFIG_FSCACHE_STATS is not set
> CONFIG_FSCACHE_HISTOGRAM=y
> # CONFIG_FSCACHE_DEBUG is not set
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> CONFIG_CACHEFILES=m
> CONFIG_CACHEFILES_DEBUG=y
> CONFIG_CACHEFILES_HISTOGRAM=y
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_UDF_FS=m
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_FAT_DEFAULT_UTF8=y
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> # CONFIG_MISC_FILESYSTEMS is not set
> # CONFIG_NETWORK_FILESYSTEMS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=m
> # CONFIG_NLS_CODEPAGE_850 is not set
> CONFIG_NLS_CODEPAGE_852=y
> # CONFIG_NLS_CODEPAGE_855 is not set
> CONFIG_NLS_CODEPAGE_857=m
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=y
> # CONFIG_NLS_CODEPAGE_862 is not set
> CONFIG_NLS_CODEPAGE_863=m
> CONFIG_NLS_CODEPAGE_864=m
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> CONFIG_NLS_CODEPAGE_869=y
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> CONFIG_NLS_CODEPAGE_949=y
> # CONFIG_NLS_CODEPAGE_874 is not set
> CONFIG_NLS_ISO8859_8=y
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=m
> CONFIG_NLS_ASCII=m
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=m
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=m
> CONFIG_NLS_ISO8859_9=y
> # CONFIG_NLS_ISO8859_13 is not set
> CONFIG_NLS_ISO8859_14=y
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> CONFIG_NLS_MAC_CELTIC=m
> # CONFIG_NLS_MAC_CENTEURO is not set
> CONFIG_NLS_MAC_CROATIAN=y
> # CONFIG_NLS_MAC_CYRILLIC is not set
> CONFIG_NLS_MAC_GAELIC=m
> CONFIG_NLS_MAC_GREEK=y
> # CONFIG_NLS_MAC_ICELAND is not set
> CONFIG_NLS_MAC_INUIT=m
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_ENABLE_WARN_DEPRECATED=y
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=2048
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> CONFIG_UNUSED_SYMBOLS=y
> # CONFIG_PAGE_OWNER is not set
> CONFIG_DEBUG_FS=y
> CONFIG_HEADERS_CHECK=y
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_FRAME_POINTER=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_DEBUG_KERNEL=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> CONFIG_PAGE_POISONING=y
> # CONFIG_PAGE_POISONING_NO_SANITY is not set
> CONFIG_PAGE_POISONING_ZERO=y
> CONFIG_DEBUG_RODATA_TEST=y
> CONFIG_DEBUG_OBJECTS=y
> CONFIG_DEBUG_OBJECTS_SELFTEST=y
> CONFIG_DEBUG_OBJECTS_FREE=y
> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> CONFIG_DEBUG_OBJECTS_WORK=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> CONFIG_DEBUG_SLAB=y
> # CONFIG_DEBUG_SLAB_LEAK is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_DEBUG_HIGHMEM=y
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Lockups and Hangs
> #
> # CONFIG_SOFTLOCKUP_DETECTOR is not set
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> # CONFIG_DETECT_HUNG_TASK is not set
> # CONFIG_WQ_WATCHDOG is not set
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # CONFIG_SCHED_STACK_END_CHECK is not set
> # CONFIG_DEBUG_TIMEKEEPING is not set
> CONFIG_DEBUG_PREEMPT=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> CONFIG_LOCK_STAT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PI_LIST=y
> CONFIG_DEBUG_SG=y
> CONFIG_DEBUG_NOTIFIERS=y
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_PERF_TEST=y
> CONFIG_RCU_TORTURE_TEST=m
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_TRACE=y
> CONFIG_RCU_EQS_DEBUG=y
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=m
> CONFIG_PM_NOTIFIER_ERROR_INJECT=m
> CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
> CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> # CONFIG_MEMTEST is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> CONFIG_X86_VERBOSE_BOOTUP=y
> # CONFIG_EARLY_PRINTK is not set
> CONFIG_X86_PTDUMP_CORE=y
> CONFIG_X86_PTDUMP=y
> # CONFIG_DEBUG_WX is not set
> # CONFIG_DOUBLEFAULT is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_TYPE_0X80=0
> CONFIG_IO_DELAY_TYPE_0XED=1
> CONFIG_IO_DELAY_TYPE_UDELAY=2
> CONFIG_IO_DELAY_TYPE_NONE=3
> # CONFIG_IO_DELAY_0X80 is not set
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> CONFIG_IO_DELAY_NONE=y
> CONFIG_DEFAULT_IO_DELAY_TYPE=3
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_OPTIMIZE_INLINING is not set
> # CONFIG_DEBUG_ENTRY is not set
> CONFIG_DEBUG_NMI_SELFTEST=y
> # CONFIG_X86_DEBUG_FPU is not set
> CONFIG_PUNIT_ATOM_DEBUG=y
> CONFIG_UNWINDER_FRAME_POINTER=y
> # CONFIG_UNWINDER_GUESS is not set
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_BIG_KEYS=y
> # CONFIG_TRUSTED_KEYS is not set
> CONFIG_ENCRYPTED_KEYS=y
> # CONFIG_KEY_DH_OPERATIONS is not set
> CONFIG_SECURITY_DMESG_RESTRICT=y
> # CONFIG_SECURITY is not set
> CONFIG_SECURITYFS=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
> # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
> # CONFIG_FORTIFY_SOURCE is not set
> CONFIG_STATIC_USERMODEHELPER=y
> CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_XOR_BLOCKS=m
> CONFIG_ASYNC_CORE=m
> CONFIG_ASYNC_MEMCPY=m
> CONFIG_ASYNC_XOR=m
> CONFIG_ASYNC_PQ=m
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=m
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_RSA=y
> # CONFIG_CRYPTO_DH is not set
> CONFIG_CRYPTO_ECDH=m
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_WORKQUEUE=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_MCRYPTD=m
> CONFIG_CRYPTO_AUTHENC=m
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_SIMD=y
> CONFIG_CRYPTO_GLUE_HELPER_X86=y
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=m
> CONFIG_CRYPTO_AEGIS128=m
> CONFIG_CRYPTO_AEGIS128L=m
> CONFIG_CRYPTO_AEGIS256=y
> CONFIG_CRYPTO_MORUS640=y
> # CONFIG_CRYPTO_MORUS1280 is not set
> CONFIG_CRYPTO_SEQIV=y
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=m
> CONFIG_CRYPTO_PCBC=m
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_KEYWRAP=m
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=m
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRC32_PCLMUL=y
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=m
> CONFIG_CRYPTO_MD4=m
> # CONFIG_CRYPTO_MD5 is not set
> CONFIG_CRYPTO_MICHAEL_MIC=y
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_RMD256=m
> CONFIG_CRYPTO_RMD320=y
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_SHA3=m
> # CONFIG_CRYPTO_SM3 is not set
> CONFIG_CRYPTO_TGR192=m
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> CONFIG_CRYPTO_AES_586=m
> # CONFIG_CRYPTO_AES_NI_INTEL is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> # CONFIG_CRYPTO_CAST6 is not set
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_SALSA20=y
> CONFIG_CRYPTO_CHACHA20=m
> CONFIG_CRYPTO_SEED=m
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SERPENT_SSE2_586=y
> CONFIG_CRYPTO_SM4=m
> # CONFIG_CRYPTO_SPECK is not set
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_TWOFISH_COMMON=m
> # CONFIG_CRYPTO_TWOFISH_586 is not set
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=m
> # CONFIG_CRYPTO_LZ4HC is not set
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=m
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> CONFIG_CRYPTO_USER_API_RNG=m
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> CONFIG_HAVE_KVM=y
> CONFIG_VIRTUALIZATION=y
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_BITREVERSE=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_CRC_CCITT=m
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=m
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=y
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC4=y
> CONFIG_CRC7=m
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=m
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=m
> CONFIG_XZ_DEC_X86=y
> # CONFIG_XZ_DEC_POWERPC is not set
> # CONFIG_XZ_DEC_IA64 is not set
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_RADIX_TREE_MULTIORDER=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> CONFIG_DMA_DIRECT_OPS=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_CORDIC=m
> # CONFIG_DDR is not set
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_SG_CHAIN=y
> CONFIG_SBITMAP=y
> CONFIG_PRIME_NUMBERS=m
> CONFIG_STRING_SELFTEST=y

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='boot'
> 	export testcase='boot'
> 	export timeout='10m'
> 	export job_origin='/lkp/lkp/src/jobs/boot.yaml'
> 	export queue='bisect'
> 	export testbox='vm-vp-quantal-i386-52'
> 	export tbox_group='vm-vp-quantal-i386'
> 	export branch='linux-next/master'
> 	export commit='063b8b31719dbe80c0f4acd914d10794bfb83f1d'
> 	export kconfig='i386-randconfig-sb0-07272051'
> 	export submit_id='5b5b642b0b9a9352e9507e88'
> 	export job_file='/lkp/scheduled/vm-vp-quantal-i386-52/boot-1-quantal-core-i386.cgz-063b8b31719dbe80c0f4acd914d10794bfb83f1d-20180728-21225-1nsgyko-0.yaml'
> 	export id='2b8b643acde86d0fbb2a46bbe6a4841e6fc1f081'
> 	export model='qemu-system-i386 -enable-kvm -cpu Haswell,+smep,+smap'
> 	export nr_vm=64
> 	export nr_cpu=1
> 	export memory='360M'
> 	export rootfs='quantal-core-i386.cgz'
> 	export need_kconfig='CONFIG_KVM_GUEST=y'
> 	export compiler='gcc-4.9'
> 	export enqueue_time='2018-07-28 02:27:55 +0800'
> 	export _id='5b5b642b0b9a9352e9507e88'
> 	export _rt='/result/boot/1/vm-vp-quantal-i386/quantal-core-i386.cgz/i386-randconfig-sb0-07272051/gcc-4.9/063b8b31719dbe80c0f4acd914d10794bfb83f1d'
> 	export user='lkp'
> 	export result_root='/result/boot/1/vm-vp-quantal-i386/quantal-core-i386.cgz/i386-randconfig-sb0-07272051/gcc-4.9/063b8b31719dbe80c0f4acd914d10794bfb83f1d/0'
> 	export LKP_SERVER='inn'
> 	export max_uptime=600
> 	export initrd='/osimage/quantal/quantal-core-i386.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/scheduled/vm-vp-quantal-i386-52/boot-1-quantal-core-i386.cgz-063b8b31719dbe80c0f4acd914d10794bfb83f1d-20180728-21225-1nsgyko-0.yaml
> ARCH=i386
> kconfig=i386-randconfig-sb0-07272051
> branch=linux-next/master
> commit=063b8b31719dbe80c0f4acd914d10794bfb83f1d
> BOOT_IMAGE=/pkg/linux/i386-randconfig-sb0-07272051/gcc-4.9/063b8b31719dbe80c0f4acd914d10794bfb83f1d/vmlinuz-4.18.0-rc6-00311-g063b8b3
> max_uptime=600
> RESULT_ROOT=/result/boot/1/vm-vp-quantal-i386/quantal-core-i386.cgz/i386-randconfig-sb0-07272051/gcc-4.9/063b8b31719dbe80c0f4acd914d10794bfb83f1d/0
> LKP_SERVER=inn
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/i386-randconfig-sb0-07272051/gcc-4.9/063b8b31719dbe80c0f4acd914d10794bfb83f1d/modules.cgz'
> 	export lkp_initrd='/lkp/lkp/lkp-i386.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export kernel='/pkg/linux/i386-randconfig-sb0-07272051/gcc-4.9/063b8b31719dbe80c0f4acd914d10794bfb83f1d/vmlinuz-4.18.0-rc6-00311-g063b8b3'
> 	export dequeue_time='2018-07-28 02:38:00 +0800'
> 	export job_initrd='/lkp/scheduled/vm-vp-quantal-i386-52/boot-1-quantal-core-i386.cgz-063b8b31719dbe80c0f4acd914d10794bfb83f1d-20180728-21225-1nsgyko-0.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper sleep 1
> }
> 
> extract_stats()
> {
> 	$LKP_SRC/stats/wrapper boot-slabinfo
> 	$LKP_SRC/stats/wrapper boot-meminfo
> 	$LKP_SRC/stats/wrapper memmap
> 	$LKP_SRC/stats/wrapper boot-memory
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper kernel-size
> 	$LKP_SRC/stats/wrapper kmsg
> 
> 	$LKP_SRC/stats/wrapper time sleep.time
> 	$LKP_SRC/stats/wrapper time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper last_state
> }
> 
> "$@"



-- 
Michal Hocko
SUSE Labs
