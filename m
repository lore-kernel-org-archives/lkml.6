Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76843C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9B420870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9B420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeGaDne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:43:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:38940 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeGaDnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:43:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 19:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,425,1526367600"; 
   d="scan'208";a="71881212"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2018 19:05:29 -0700
Subject: Re: [LKP] [mm, oom] c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
To:     Michal Hocko <mhocko@kernel.org>
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
References: <20180730090320.GD30690@shao2-debian>
 <20180730095635.GI24267@dhcp22.suse.cz>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <af9c6340-4989-9c0f-6160-25b7eb98bc20@intel.com>
Date:   Tue, 31 Jul 2018 10:06:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180730095635.GI24267@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/30/2018 05:56 PM, Michal Hocko wrote:
> On Mon 30-07-18 17:03:20, kernel test robot wrote:
> [...]
>> [    9.034310] BUG: KASAN: null-ptr-deref in dump_header+0x10c/0x448
> Could you faddr2line on the offset please?
The result is:

dump_header+0x10c/0x448:
__read_once_size at include/linux/compiler.h:188
  (inlined by) dump_header at mm/oom_kill.c:445


>
>> [    9.034310] Read of size 8 at addr 00000000000009b0 by task swapper/0/1
>> [    9.034310]
>> [    9.034310] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc5-00455-gc1e4c54 #1
>> [    9.034310] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [    9.034310] Call Trace:
>> [    9.034310]  dump_stack+0x8d/0xd3
>> [    9.034310]  kasan_report+0x222/0x252
>> [    9.034310]  dump_header+0x10c/0x448
>> [    9.034310]  out_of_memory+0x4c2/0x544
>> [    9.034310]  ? lock_acquire+0x9e/0xd9
>> [    9.034310]  ? oom_killer_disable+0x196/0x196
>> [    9.034310]  __alloc_pages_slowpath+0x9bb/0xaad
>> [    9.034310]  ? gfp_pfmemalloc_allowed+0xb/0xb
>> [    9.034310]  ? ___might_sleep+0xfa/0x29f
>> [    9.034310]  __alloc_pages_nodemask+0x1e3/0x211
>> [    9.034310]  ? __alloc_pages_slowpath+0xaad/0xaad
>> [    9.034310]  ? debug_show_all_locks+0x1b0/0x1b0
>> [    9.034310]  ? mark_held_locks+0x28/0x86
>> [    9.034310]  new_slab+0xf6/0x317
>> [    9.034310]  ? vfs_statx+0xab/0x111
>> [    9.034310]  ___slab_alloc+0x2ce/0x3c5
>> [    9.034310]  ? maybe_link+0x110/0x1b0
>> [    9.034310]  ? lock_release+0x1ee/0x2c4
>> [    9.034310]  ? lock_is_held_type+0x7e/0x8a
>> [    9.034310]  ? maybe_link+0x110/0x1b0
>> [    9.034310]  ? __slab_alloc+0x4b/0x7e
>> [    9.034310]  __slab_alloc+0x4b/0x7e
>> [    9.034310]  ? maybe_link+0x110/0x1b0
>> [    9.034310]  kmem_cache_alloc+0x59/0xf6
>> [    9.034310]  maybe_link+0x110/0x1b0
>> [    9.034310]  ? write_buffer+0x3e/0x3e
>> [    9.034310]  do_name+0xae/0x32b
>> [    9.034310]  write_buffer+0x2d/0x3e
>> [    9.034310]  flush_buffer+0x2e/0x96
>> [    9.034310]  ? md_run_setup+0x85/0x85
>> [    9.034310]  __gunzip+0x399/0x470
>> [    9.034310]  ? bunzip2+0x560/0x560
>> [    9.034310]  ? __gunzip+0x470/0x470
>> [    9.034310]  gunzip+0xe/0x11
>> [    9.034310]  ? md_run_setup+0x85/0x85
>> [    9.034310]  unpack_to_rootfs+0x1fe/0x393
>> [    9.034310]  ? md_run_setup+0x85/0x85
>> [    9.034310]  ? do_symlink+0xaf/0xaf
>> [    9.034310]  ? populate_rootfs+0x10/0x1b2
>> [    9.034310]  ? populate_rootfs+0x4b/0x1b2
>> [    9.034310]  ? parse_header+0x1c9/0x1c9
>> [    9.034310]  populate_rootfs+0x96/0x1b2
>> [    9.034310]  ? parse_header+0x1c9/0x1c9
>> [    9.034310]  do_one_initcall+0xc4/0x1ce
>> [    9.034310]  ? initcall_blacklisted+0x12f/0x12f
>> [    9.034310]  ? lock_downgrade+0x298/0x298
>> [    9.034310]  kernel_init_freeable+0x282/0x317
>> [    9.034310]  ? rest_init+0xc6/0xc6
>> [    9.034310]  kernel_init+0x7/0xfe
>> [    9.034310]  ? rest_init+0xc6/0xc6
>> [    9.034310]  ret_from_fork+0x24/0x30
>> [    9.034310] ==================================================================
>> [    9.034310] Disabling lock debugging due to kernel taint
>> [    9.086644] BUG: unable to handle kernel NULL pointer dereference at 00000000000009b0
>> [    9.087338] PGD 0 P4D 0
>> [    9.087338] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
>> [    9.087338] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             4.18.0-rc5-00455-gc1e4c54 #1
>> [    9.087338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [    9.087338] RIP: 0010:dump_header+0x10c/0x448
>> [    9.087338] Code: 85 ed 0f 95 c2 4c 89 e9 48 c7 c7 60 67 09 82 e8 32 cf f7 ff e8 03 f5 fc ff e8 ea e8 ff ff 48 8d bd b0 09 00 00 e8 90 ff 04 00 <4c> 8b ad b0 09 00 00 e8 1d ae f8 ff 85 c0 74 31 80 3d 58 36 d4 01
>> [    9.087338] RSP: 0000:ffff88000ad0f740 EFLAGS: 00010256
>> [    9.087338] RAX: 0000000000000296 RBX: ffff88000ad0f950 RCX: ffffffff810d5bf5
>> [    9.087338] RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffffff840d9480
>> [    9.087338] RBP: 0000000000000000 R08: dffffc0000000000 R09: 0000000000000001
>> [    9.087338] R10: fffffbfff055ee28 R11: fffffbfff055ee29 R12: ffff88000ad0f958
>> [    9.087338] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [    9.087338] FS:  0000000000000000(0000) GS:ffff88000b000000(0000) knlGS:0000000000000000
>> [    9.087338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    9.087338] CR2: 00000000000009b0 CR3: 000000000285c000 CR4: 00000000000006b0
>> [    9.087338] Call Trace:
>> [    9.087338]  out_of_memory+0x4c2/0x544
>> [    9.087338]  ? lock_acquire+0x9e/0xd9
>> [    9.087338]  ? oom_killer_disable+0x196/0x196
>> [    9.087338]  __alloc_pages_slowpath+0x9bb/0xaad
>> [    9.087338]  ? gfp_pfmemalloc_allowed+0xb/0xb
>> [    9.087338]  ? ___might_sleep+0xfa/0x29f
>> [    9.087338]  __alloc_pages_nodemask+0x1e3/0x211
>> [    9.087338]  ? __alloc_pages_slowpath+0xaad/0xaad
>> [    9.087338]  ? debug_show_all_locks+0x1b0/0x1b0
>> [    9.087338]  ? mark_held_locks+0x28/0x86
>> [    9.087338]  new_slab+0xf6/0x317
>> [    9.087338]  ? vfs_statx+0xab/0x111
>> [    9.087338]  ___slab_alloc+0x2ce/0x3c5
>> [    9.087338]  ? maybe_link+0x110/0x1b0
>> [    9.087338]  ? lock_release+0x1ee/0x2c4
>> [    9.087338]  ? lock_is_held_type+0x7e/0x8a
>> [    9.087338]  ? maybe_link+0x110/0x1b0
>> [    9.087338]  ? __slab_alloc+0x4b/0x7e
>> [    9.087338]  __slab_alloc+0x4b/0x7e
>> [    9.087338]  ? maybe_link+0x110/0x1b0
>> [    9.087338]  kmem_cache_alloc+0x59/0xf6
>> [    9.087338]  maybe_link+0x110/0x1b0
>> [    9.087338]  ? write_buffer+0x3e/0x3e
>> [    9.087338]  do_name+0xae/0x32b
>> [    9.087338]  write_buffer+0x2d/0x3e
>> [    9.087338]  flush_buffer+0x2e/0x96
>> [    9.087338]  ? md_run_setup+0x85/0x85
>> [    9.087338]  __gunzip+0x399/0x470
>> [    9.087338]  ? bunzip2+0x560/0x560
>> [    9.087338]  ? __gunzip+0x470/0x470
>> [    9.087338]  gunzip+0xe/0x11
>> [    9.087338]  ? md_run_setup+0x85/0x85
>> [    9.087338]  unpack_to_rootfs+0x1fe/0x393
>> [    9.087338]  ? md_run_setup+0x85/0x85
>> [    9.087338]  ? do_symlink+0xaf/0xaf
>> [    9.087338]  ? populate_rootfs+0x10/0x1b2
>> [    9.087338]  ? populate_rootfs+0x4b/0x1b2
>> [    9.087338]  ? parse_header+0x1c9/0x1c9
>> [    9.087338]  populate_rootfs+0x96/0x1b2
>> [    9.087338]  ? parse_header+0x1c9/0x1c9
>> [    9.087338]  do_one_initcall+0xc4/0x1ce
>> [    9.087338]  ? initcall_blacklisted+0x12f/0x12f
>> [    9.087338]  ? lock_downgrade+0x298/0x298
>> [    9.087338]  kernel_init_freeable+0x282/0x317
>> [    9.087338]  ? rest_init+0xc6/0xc6
>> [    9.087338]  kernel_init+0x7/0xfe
>> [    9.087338]  ? rest_init+0xc6/0xc6
>> [    9.087338]  ret_from_fork+0x24/0x30
>> [    9.087338] Modules linked in:
>> [    9.087338] CR2: 00000000000009b0
>> [    9.087338] ---[ end trace 17f361a4b4e30da1 ]---
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>>
>>
>>
>> Thanks,
>> Rong, Chen
>> #
>> # Automatically generated file; DO NOT EDIT.
>> # Linux/x86_64 4.18.0-rc5 Kernel Configuration
>> #
>>
>> #
>> # Compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
>> #
>> CONFIG_64BIT=y
>> CONFIG_X86_64=y
>> CONFIG_X86=y
>> CONFIG_INSTRUCTION_DECODER=y
>> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
>> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
>> CONFIG_LOCKDEP_SUPPORT=y
>> CONFIG_STACKTRACE_SUPPORT=y
>> CONFIG_MMU=y
>> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
>> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
>> CONFIG_GENERIC_ISA_DMA=y
>> CONFIG_GENERIC_BUG=y
>> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
>> CONFIG_GENERIC_HWEIGHT=y
>> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
>> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>> CONFIG_GENERIC_CALIBRATE_DELAY=y
>> CONFIG_ARCH_HAS_CPU_RELAX=y
>> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
>> CONFIG_ARCH_HAS_FILTER_PGPROT=y
>> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
>> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
>> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
>> CONFIG_ARCH_SUSPEND_POSSIBLE=y
>> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
>> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>> CONFIG_ZONE_DMA32=y
>> CONFIG_AUDIT_ARCH=y
>> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
>> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
>> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
>> CONFIG_X86_64_SMP=y
>> CONFIG_ARCH_SUPPORTS_UPROBES=y
>> CONFIG_FIX_EARLYCON_MEM=y
>> CONFIG_DYNAMIC_PHYSICAL_MASK=y
>> CONFIG_PGTABLE_LEVELS=4
>> CONFIG_CC_IS_GCC=y
>> CONFIG_GCC_VERSION=50401
>> CONFIG_CLANG_VERSION=0
>> CONFIG_CONSTRUCTORS=y
>> CONFIG_IRQ_WORK=y
>> CONFIG_BUILDTIME_EXTABLE_SORT=y
>> CONFIG_THREAD_INFO_IN_TASK=y
>>
>> #
>> # General setup
>> #
>> CONFIG_INIT_ENV_ARG_LIMIT=32
>> # CONFIG_COMPILE_TEST is not set
>> CONFIG_LOCALVERSION=""
>> CONFIG_LOCALVERSION_AUTO=y
>> CONFIG_HAVE_KERNEL_GZIP=y
>> CONFIG_HAVE_KERNEL_BZIP2=y
>> CONFIG_HAVE_KERNEL_LZMA=y
>> CONFIG_HAVE_KERNEL_XZ=y
>> CONFIG_HAVE_KERNEL_LZO=y
>> CONFIG_HAVE_KERNEL_LZ4=y
>> # CONFIG_KERNEL_GZIP is not set
>> # CONFIG_KERNEL_BZIP2 is not set
>> # CONFIG_KERNEL_LZMA is not set
>> # CONFIG_KERNEL_XZ is not set
>> CONFIG_KERNEL_LZO=y
>> # CONFIG_KERNEL_LZ4 is not set
>> CONFIG_DEFAULT_HOSTNAME="(none)"
>> # CONFIG_SWAP is not set
>> # CONFIG_SYSVIPC is not set
>> # CONFIG_POSIX_MQUEUE is not set
>> CONFIG_CROSS_MEMORY_ATTACH=y
>> CONFIG_USELIB=y
>> # CONFIG_AUDIT is not set
>> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>>
>> #
>> # IRQ subsystem
>> #
>> CONFIG_GENERIC_IRQ_PROBE=y
>> CONFIG_GENERIC_IRQ_SHOW=y
>> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
>> CONFIG_GENERIC_PENDING_IRQ=y
>> CONFIG_GENERIC_IRQ_MIGRATION=y
>> CONFIG_GENERIC_IRQ_CHIP=y
>> CONFIG_IRQ_DOMAIN=y
>> CONFIG_IRQ_SIM=y
>> CONFIG_IRQ_DOMAIN_HIERARCHY=y
>> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
>> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
>> CONFIG_IRQ_FORCED_THREADING=y
>> CONFIG_SPARSE_IRQ=y
>> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
>> CONFIG_CLOCKSOURCE_WATCHDOG=y
>> CONFIG_ARCH_CLOCKSOURCE_DATA=y
>> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
>> CONFIG_GENERIC_TIME_VSYSCALL=y
>> CONFIG_GENERIC_CLOCKEVENTS=y
>> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
>> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
>> CONFIG_GENERIC_CMOS_UPDATE=y
>>
>> #
>> # Timers subsystem
>> #
>> CONFIG_TICK_ONESHOT=y
>> CONFIG_NO_HZ_COMMON=y
>> # CONFIG_HZ_PERIODIC is not set
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ_FULL=y
>> # CONFIG_NO_HZ is not set
>> # CONFIG_HIGH_RES_TIMERS is not set
>>
>> #
>> # CPU/Task time and stats accounting
>> #
>> CONFIG_VIRT_CPU_ACCOUNTING=y
>> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_IRQ_TIME_ACCOUNTING=y
>> # CONFIG_BSD_PROCESS_ACCT is not set
>> # CONFIG_TASKSTATS is not set
>> CONFIG_CPU_ISOLATION=y
>>
>> #
>> # RCU Subsystem
>> #
>> CONFIG_PREEMPT_RCU=y
>> CONFIG_RCU_EXPERT=y
>> CONFIG_SRCU=y
>> CONFIG_TREE_SRCU=y
>> CONFIG_TASKS_RCU=y
>> CONFIG_RCU_STALL_COMMON=y
>> CONFIG_RCU_NEED_SEGCBLIST=y
>> CONFIG_CONTEXT_TRACKING=y
>> # CONFIG_CONTEXT_TRACKING_FORCE is not set
>> CONFIG_RCU_FANOUT=64
>> CONFIG_RCU_FANOUT_LEAF=16
>> CONFIG_RCU_FAST_NO_HZ=y
>> # CONFIG_RCU_BOOST is not set
>> CONFIG_RCU_NOCB_CPU=y
>> CONFIG_BUILD_BIN2C=y
>> CONFIG_IKCONFIG=y
>> CONFIG_IKCONFIG_PROC=y
>> CONFIG_LOG_BUF_SHIFT=20
>> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
>> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
>> CONFIG_ARCH_SUPPORTS_INT128=y
>> CONFIG_CGROUPS=y
>> CONFIG_PAGE_COUNTER=y
>> # CONFIG_MEMCG is not set
>> # CONFIG_BLK_CGROUP is not set
>> CONFIG_CGROUP_SCHED=y
>> CONFIG_FAIR_GROUP_SCHED=y
>> # CONFIG_CFS_BANDWIDTH is not set
>> # CONFIG_RT_GROUP_SCHED is not set
>> CONFIG_CGROUP_PIDS=y
>> # CONFIG_CGROUP_RDMA is not set
>> # CONFIG_CGROUP_FREEZER is not set
>> CONFIG_CGROUP_HUGETLB=y
>> CONFIG_CPUSETS=y
>> # CONFIG_PROC_PID_CPUSET is not set
>> CONFIG_CGROUP_DEVICE=y
>> # CONFIG_CGROUP_CPUACCT is not set
>> # CONFIG_CGROUP_PERF is not set
>> CONFIG_CGROUP_DEBUG=y
>> # CONFIG_NAMESPACES is not set
>> CONFIG_SCHED_AUTOGROUP=y
>> # CONFIG_SYSFS_DEPRECATED is not set
>> # CONFIG_RELAY is not set
>> CONFIG_BLK_DEV_INITRD=y
>> CONFIG_INITRAMFS_SOURCE=""
>> CONFIG_RD_GZIP=y
>> CONFIG_RD_BZIP2=y
>> CONFIG_RD_LZMA=y
>> CONFIG_RD_XZ=y
>> CONFIG_RD_LZO=y
>> CONFIG_RD_LZ4=y
>> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
>> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>> CONFIG_SYSCTL=y
>> CONFIG_ANON_INODES=y
>> CONFIG_SYSCTL_EXCEPTION_TRACE=y
>> CONFIG_HAVE_PCSPKR_PLATFORM=y
>> CONFIG_BPF=y
>> CONFIG_EXPERT=y
>> CONFIG_MULTIUSER=y
>> # CONFIG_SGETMASK_SYSCALL is not set
>> CONFIG_SYSFS_SYSCALL=y
>> # CONFIG_SYSCTL_SYSCALL is not set
>> CONFIG_FHANDLE=y
>> # CONFIG_POSIX_TIMERS is not set
>> CONFIG_PRINTK=y
>> CONFIG_PRINTK_NMI=y
>> CONFIG_BUG=y
>> CONFIG_PCSPKR_PLATFORM=y
>> # CONFIG_BASE_FULL is not set
>> CONFIG_FUTEX=y
>> CONFIG_FUTEX_PI=y
>> CONFIG_EPOLL=y
>> CONFIG_SIGNALFD=y
>> CONFIG_TIMERFD=y
>> CONFIG_EVENTFD=y
>> CONFIG_SHMEM=y
>> CONFIG_AIO=y
>> CONFIG_ADVISE_SYSCALLS=y
>> CONFIG_MEMBARRIER=y
>> CONFIG_CHECKPOINT_RESTORE=y
>> CONFIG_KALLSYMS=y
>> CONFIG_KALLSYMS_ALL=y
>> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
>> CONFIG_KALLSYMS_BASE_RELATIVE=y
>> # CONFIG_BPF_SYSCALL is not set
>> # CONFIG_USERFAULTFD is not set
>> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
>> CONFIG_RSEQ=y
>> # CONFIG_DEBUG_RSEQ is not set
>> # CONFIG_EMBEDDED is not set
>> CONFIG_HAVE_PERF_EVENTS=y
>> CONFIG_PERF_USE_VMALLOC=y
>> # CONFIG_PC104 is not set
>>
>> #
>> # Kernel Performance Events And Counters
>> #
>> CONFIG_PERF_EVENTS=y
>> CONFIG_DEBUG_PERF_USE_VMALLOC=y
>> # CONFIG_VM_EVENT_COUNTERS is not set
>> CONFIG_SLUB_DEBUG=y
>> CONFIG_COMPAT_BRK=y
>> # CONFIG_SLAB is not set
>> CONFIG_SLUB=y
>> # CONFIG_SLOB is not set
>> CONFIG_SLAB_MERGE_DEFAULT=y
>> # CONFIG_SLAB_FREELIST_RANDOM is not set
>> # CONFIG_SLAB_FREELIST_HARDENED is not set
>> CONFIG_SLUB_CPU_PARTIAL=y
>> CONFIG_PROFILING=y
>> CONFIG_CRASH_CORE=y
>> CONFIG_KEXEC_CORE=y
>> CONFIG_OPROFILE=y
>> CONFIG_OPROFILE_EVENT_MULTIPLEX=y
>> CONFIG_HAVE_OPROFILE=y
>> CONFIG_OPROFILE_NMI_TIMER=y
>> # CONFIG_KPROBES is not set
>> # CONFIG_JUMP_LABEL is not set
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
>> CONFIG_HAVE_IOREMAP_PROT=y
>> CONFIG_HAVE_KPROBES=y
>> CONFIG_HAVE_KRETPROBES=y
>> CONFIG_HAVE_OPTPROBES=y
>> CONFIG_HAVE_KPROBES_ON_FTRACE=y
>> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
>> CONFIG_HAVE_NMI=y
>> CONFIG_HAVE_ARCH_TRACEHOOK=y
>> CONFIG_HAVE_DMA_CONTIGUOUS=y
>> CONFIG_GENERIC_SMP_IDLE_THREAD=y
>> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
>> CONFIG_ARCH_HAS_SET_MEMORY=y
>> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
>> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>> CONFIG_HAVE_RSEQ=y
>> CONFIG_HAVE_CLK=y
>> CONFIG_HAVE_HW_BREAKPOINT=y
>> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
>> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
>> CONFIG_HAVE_PERF_EVENTS_NMI=y
>> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
>> CONFIG_HAVE_PERF_REGS=y
>> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL=y
>> CONFIG_HAVE_RCU_TABLE_FREE=y
>> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
>> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
>> CONFIG_HAVE_CMPXCHG_LOCAL=y
>> CONFIG_HAVE_CMPXCHG_DOUBLE=y
>> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
>> CONFIG_SECCOMP_FILTER=y
>> CONFIG_PLUGIN_HOSTCC="g++"
>> CONFIG_HAVE_GCC_PLUGINS=y
>> # CONFIG_GCC_PLUGINS is not set
>> CONFIG_HAVE_STACKPROTECTOR=y
>> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
>> CONFIG_STACKPROTECTOR=y
>> # CONFIG_STACKPROTECTOR_STRONG is not set
>> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
>> CONFIG_HAVE_CONTEXT_TRACKING=y
>> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
>> CONFIG_HAVE_ARCH_HUGE_VMAP=y
>> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
>> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
>> CONFIG_MODULES_USE_ELF_RELA=y
>> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
>> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
>> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
>> CONFIG_HAVE_EXIT_THREAD=y
>> CONFIG_ARCH_MMAP_RND_BITS=28
>> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
>> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
>> CONFIG_HAVE_COPY_THREAD_TLS=y
>> CONFIG_HAVE_STACK_VALIDATION=y
>> CONFIG_ISA_BUS_API=y
>> CONFIG_COMPAT_32BIT_TIME=y
>> CONFIG_HAVE_ARCH_VMAP_STACK=y
>> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
>> CONFIG_STRICT_KERNEL_RWX=y
>> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
>> CONFIG_STRICT_MODULE_RWX=y
>> CONFIG_ARCH_HAS_REFCOUNT=y
>> CONFIG_REFCOUNT_FULL=y
>>
>> #
>> # GCOV-based kernel profiling
>> #
>> # CONFIG_GCOV_KERNEL is not set
>> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
>> CONFIG_RT_MUTEXES=y
>> CONFIG_BASE_SMALL=1
>> CONFIG_MODULES=y
>> # CONFIG_MODULE_FORCE_LOAD is not set
>> CONFIG_MODULE_UNLOAD=y
>> CONFIG_MODULE_FORCE_UNLOAD=y
>> # CONFIG_MODVERSIONS is not set
>> # CONFIG_MODULE_SRCVERSION_ALL is not set
>> # CONFIG_MODULE_SIG is not set
>> # CONFIG_MODULE_COMPRESS is not set
>> CONFIG_MODULES_TREE_LOOKUP=y
>> CONFIG_BLOCK=y
>> CONFIG_BLK_SCSI_REQUEST=y
>> CONFIG_BLK_DEV_BSG=y
>> CONFIG_BLK_DEV_BSGLIB=y
>> CONFIG_BLK_DEV_INTEGRITY=y
>> # CONFIG_BLK_DEV_ZONED is not set
>> # CONFIG_BLK_CMDLINE_PARSER is not set
>> # CONFIG_BLK_WBT is not set
>> # CONFIG_BLK_DEBUG_FS is not set
>> CONFIG_BLK_SED_OPAL=y
>>
>> #
>> # Partition Types
>> #
>> # CONFIG_PARTITION_ADVANCED is not set
>> CONFIG_MSDOS_PARTITION=y
>> CONFIG_EFI_PARTITION=y
>> CONFIG_BLOCK_COMPAT=y
>> CONFIG_BLK_MQ_PCI=y
>> CONFIG_BLK_MQ_VIRTIO=y
>>
>> #
>> # IO Schedulers
>> #
>> CONFIG_IOSCHED_NOOP=y
>> CONFIG_IOSCHED_DEADLINE=m
>> # CONFIG_IOSCHED_CFQ is not set
>> CONFIG_DEFAULT_NOOP=y
>> CONFIG_DEFAULT_IOSCHED="noop"
>> CONFIG_MQ_IOSCHED_DEADLINE=y
>> # CONFIG_MQ_IOSCHED_KYBER is not set
>> # CONFIG_IOSCHED_BFQ is not set
>> CONFIG_PADATA=y
>> CONFIG_ASN1=y
>> CONFIG_UNINLINE_SPIN_UNLOCK=y
>> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
>> CONFIG_MUTEX_SPIN_ON_OWNER=y
>> CONFIG_RWSEM_SPIN_ON_OWNER=y
>> CONFIG_LOCK_SPIN_ON_OWNER=y
>> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
>> CONFIG_QUEUED_SPINLOCKS=y
>> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
>> CONFIG_QUEUED_RWLOCKS=y
>> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
>> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
>> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>>
>> #
>> # Processor type and features
>> #
>> CONFIG_ZONE_DMA=y
>> CONFIG_SMP=y
>> CONFIG_X86_FEATURE_NAMES=y
>> # CONFIG_X86_X2APIC is not set
>> # CONFIG_X86_MPPARSE is not set
>> # CONFIG_GOLDFISH is not set
>> # CONFIG_RETPOLINE is not set
>> # CONFIG_INTEL_RDT is not set
>> CONFIG_X86_EXTENDED_PLATFORM=y
>> # CONFIG_X86_VSMP is not set
>> # CONFIG_X86_GOLDFISH is not set
>> # CONFIG_X86_INTEL_LPSS is not set
>> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
>> # CONFIG_IOSF_MBI is not set
>> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>> CONFIG_HYPERVISOR_GUEST=y
>> CONFIG_PARAVIRT=y
>> # CONFIG_PARAVIRT_DEBUG is not set
>> # CONFIG_PARAVIRT_SPINLOCKS is not set
>> # CONFIG_XEN is not set
>> CONFIG_KVM_GUEST=y
>> # CONFIG_KVM_DEBUG_FS is not set
>> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
>> CONFIG_PARAVIRT_CLOCK=y
>> # CONFIG_JAILHOUSE_GUEST is not set
>> CONFIG_NO_BOOTMEM=y
>> # CONFIG_MK8 is not set
>> # CONFIG_MPSC is not set
>> CONFIG_MCORE2=y
>> # CONFIG_MATOM is not set
>> # CONFIG_GENERIC_CPU is not set
>> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
>> CONFIG_X86_L1_CACHE_SHIFT=6
>> CONFIG_X86_INTEL_USERCOPY=y
>> CONFIG_X86_USE_PPRO_CHECKSUM=y
>> CONFIG_X86_P6_NOP=y
>> CONFIG_X86_TSC=y
>> CONFIG_X86_CMPXCHG64=y
>> CONFIG_X86_CMOV=y
>> CONFIG_X86_MINIMUM_CPU_FAMILY=64
>> CONFIG_X86_DEBUGCTLMSR=y
>> # CONFIG_PROCESSOR_SELECT is not set
>> CONFIG_CPU_SUP_INTEL=y
>> CONFIG_CPU_SUP_AMD=y
>> CONFIG_CPU_SUP_CENTAUR=y
>> CONFIG_HPET_TIMER=y
>> CONFIG_DMI=y
>> # CONFIG_GART_IOMMU is not set
>> # CONFIG_CALGARY_IOMMU is not set
>> CONFIG_MAXSMP=y
>> CONFIG_NR_CPUS_RANGE_BEGIN=8192
>> CONFIG_NR_CPUS_RANGE_END=8192
>> CONFIG_NR_CPUS_DEFAULT=8192
>> CONFIG_NR_CPUS=8192
>> CONFIG_SCHED_SMT=y
>> # CONFIG_SCHED_MC is not set
>> # CONFIG_PREEMPT_NONE is not set
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> CONFIG_PREEMPT=y
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_X86_LOCAL_APIC=y
>> CONFIG_X86_IO_APIC=y
>> # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
>> # CONFIG_X86_MCE is not set
>>
>> #
>> # Performance monitoring
>> #
>> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
>> CONFIG_PERF_EVENTS_INTEL_RAPL=y
>> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
>> CONFIG_PERF_EVENTS_AMD_POWER=m
>> CONFIG_X86_VSYSCALL_EMULATION=y
>> CONFIG_I8K=m
>> CONFIG_MICROCODE=y
>> CONFIG_MICROCODE_INTEL=y
>> # CONFIG_MICROCODE_AMD is not set
>> CONFIG_MICROCODE_OLD_INTERFACE=y
>> CONFIG_X86_MSR=y
>> CONFIG_X86_CPUID=m
>> # CONFIG_X86_5LEVEL is not set
>> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
>> CONFIG_AMD_MEM_ENCRYPT=y
>> CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y
>> CONFIG_ARCH_USE_MEMREMAP_PROT=y
>> # CONFIG_NUMA is not set
>> CONFIG_ARCH_SPARSEMEM_ENABLE=y
>> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
>> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>> CONFIG_ARCH_MEMORY_PROBE=y
>> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
>> CONFIG_SELECT_MEMORY_MODEL=y
>> CONFIG_SPARSEMEM_MANUAL=y
>> CONFIG_SPARSEMEM=y
>> CONFIG_HAVE_MEMORY_PRESENT=y
>> CONFIG_SPARSEMEM_EXTREME=y
>> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
>> CONFIG_SPARSEMEM_VMEMMAP=y
>> CONFIG_HAVE_MEMBLOCK=y
>> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
>> CONFIG_HAVE_GENERIC_GUP=y
>> CONFIG_ARCH_DISCARD_MEMBLOCK=y
>> CONFIG_MEMORY_ISOLATION=y
>> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
>> CONFIG_MEMORY_HOTPLUG=y
>> CONFIG_MEMORY_HOTPLUG_SPARSE=y
>> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
>> CONFIG_MEMORY_HOTREMOVE=y
>> CONFIG_SPLIT_PTLOCK_CPUS=4
>> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
>> # CONFIG_COMPACTION is not set
>> CONFIG_MIGRATION=y
>> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
>> CONFIG_PHYS_ADDR_T_64BIT=y
>> # CONFIG_BOUNCE is not set
>> CONFIG_VIRT_TO_BUS=y
>> CONFIG_MMU_NOTIFIER=y
>> # CONFIG_KSM is not set
>> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>> # CONFIG_TRANSPARENT_HUGEPAGE is not set
>> CONFIG_ARCH_WANTS_THP_SWAP=y
>> # CONFIG_CLEANCACHE is not set
>> # CONFIG_CMA is not set
>> # CONFIG_MEM_SOFT_DIRTY is not set
>> # CONFIG_ZPOOL is not set
>> CONFIG_ZBUD=m
>> CONFIG_ZSMALLOC=m
>> CONFIG_PGTABLE_MAPPING=y
>> CONFIG_ZSMALLOC_STAT=y
>> CONFIG_GENERIC_EARLY_IOREMAP=y
>> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
>> CONFIG_IDLE_PAGE_TRACKING=y
>> CONFIG_ARCH_HAS_ZONE_DEVICE=y
>> CONFIG_ZONE_DEVICE=y
>> CONFIG_ARCH_HAS_HMM=y
>> CONFIG_MIGRATE_VMA_HELPER=y
>> CONFIG_DEV_PAGEMAP_OPS=y
>> CONFIG_HMM=y
>> CONFIG_HMM_MIRROR=y
>> CONFIG_DEVICE_PRIVATE=y
>> CONFIG_DEVICE_PUBLIC=y
>> CONFIG_FRAME_VECTOR=y
>> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
>> CONFIG_ARCH_HAS_PKEYS=y
>> # CONFIG_PERCPU_STATS is not set
>> CONFIG_GUP_BENCHMARK=y
>> CONFIG_ARCH_HAS_PTE_SPECIAL=y
>> # CONFIG_X86_PMEM_LEGACY is not set
>> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
>> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
>> CONFIG_X86_RESERVE_LOW=64
>> # CONFIG_MTRR is not set
>> CONFIG_ARCH_RANDOM=y
>> CONFIG_X86_SMAP=y
>> # CONFIG_X86_INTEL_UMIP is not set
>> # CONFIG_X86_INTEL_MPX is not set
>> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
>> # CONFIG_EFI is not set
>> CONFIG_SECCOMP=y
>> # CONFIG_HZ_100 is not set
>> # CONFIG_HZ_250 is not set
>> # CONFIG_HZ_300 is not set
>> CONFIG_HZ_1000=y
>> CONFIG_HZ=1000
>> CONFIG_KEXEC=y
>> # CONFIG_KEXEC_FILE is not set
>> CONFIG_CRASH_DUMP=y
>> CONFIG_PHYSICAL_START=0x1000000
>> # CONFIG_RELOCATABLE is not set
>> CONFIG_PHYSICAL_ALIGN=0x200000
>> CONFIG_HOTPLUG_CPU=y
>> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
>> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>> CONFIG_LEGACY_VSYSCALL_EMULATE=y
>> # CONFIG_LEGACY_VSYSCALL_NONE is not set
>> # CONFIG_CMDLINE_BOOL is not set
>> # CONFIG_MODIFY_LDT_SYSCALL is not set
>> CONFIG_HAVE_LIVEPATCH=y
>> CONFIG_ARCH_HAS_ADD_PAGES=y
>> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
>>
>> #
>> # Power management and ACPI options
>> #
>> # CONFIG_SUSPEND is not set
>> # CONFIG_PM is not set
>> CONFIG_ACPI=y
>> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
>> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
>> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
>> # CONFIG_ACPI_DEBUGGER is not set
>> CONFIG_ACPI_SPCR_TABLE=y
>> CONFIG_ACPI_LPIT=y
>> # CONFIG_ACPI_PROCFS_POWER is not set
>> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
>> # CONFIG_ACPI_EC_DEBUGFS is not set
>> CONFIG_ACPI_AC=y
>> CONFIG_ACPI_BATTERY=y
>> CONFIG_ACPI_BUTTON=y
>> # CONFIG_ACPI_VIDEO is not set
>> CONFIG_ACPI_FAN=y
>> # CONFIG_ACPI_DOCK is not set
>> CONFIG_ACPI_CPU_FREQ_PSS=y
>> CONFIG_ACPI_PROCESSOR_CSTATE=y
>> CONFIG_ACPI_PROCESSOR_IDLE=y
>> CONFIG_ACPI_PROCESSOR=y
>> # CONFIG_ACPI_IPMI is not set
>> CONFIG_ACPI_HOTPLUG_CPU=y
>> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
>> CONFIG_ACPI_THERMAL=y
>> CONFIG_ACPI_CUSTOM_DSDT_FILE=""
>> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
>> CONFIG_ACPI_TABLE_UPGRADE=y
>> # CONFIG_ACPI_DEBUG is not set
>> # CONFIG_ACPI_PCI_SLOT is not set
>> CONFIG_ACPI_CONTAINER=y
>> # CONFIG_ACPI_HOTPLUG_MEMORY is not set
>> CONFIG_ACPI_HOTPLUG_IOAPIC=y
>> # CONFIG_ACPI_SBS is not set
>> # CONFIG_ACPI_HED is not set
>> # CONFIG_ACPI_CUSTOM_METHOD is not set
>> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
>> # CONFIG_ACPI_NFIT is not set
>> CONFIG_HAVE_ACPI_APEI=y
>> CONFIG_HAVE_ACPI_APEI_NMI=y
>> # CONFIG_ACPI_APEI is not set
>> # CONFIG_DPTF_POWER is not set
>> # CONFIG_PMIC_OPREGION is not set
>> # CONFIG_ACPI_CONFIGFS is not set
>> CONFIG_X86_PM_TIMER=y
>> CONFIG_SFI=y
>>
>> #
>> # CPU Frequency scaling
>> #
>> CONFIG_CPU_FREQ=y
>> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
>> CONFIG_CPU_FREQ_GOV_COMMON=y
>> # CONFIG_CPU_FREQ_STAT is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
>> CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
>> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>> CONFIG_CPU_FREQ_GOV_USERSPACE=m
>> CONFIG_CPU_FREQ_GOV_ONDEMAND=m
>> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>>
>> #
>> # CPU frequency scaling drivers
>> #
>> # CONFIG_X86_INTEL_PSTATE is not set
>> # CONFIG_X86_PCC_CPUFREQ is not set
>> # CONFIG_X86_ACPI_CPUFREQ is not set
>> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
>> # CONFIG_X86_P4_CLOCKMOD is not set
>>
>> #
>> # shared options
>> #
>>
>> #
>> # CPU Idle
>> #
>> CONFIG_CPU_IDLE=y
>> CONFIG_CPU_IDLE_GOV_LADDER=y
>> # CONFIG_CPU_IDLE_GOV_MENU is not set
>> # CONFIG_INTEL_IDLE is not set
>>
>> #
>> # Bus options (PCI etc.)
>> #
>> CONFIG_PCI=y
>> CONFIG_PCI_DIRECT=y
>> CONFIG_PCI_MMCONFIG=y
>> CONFIG_PCI_DOMAINS=y
>> CONFIG_MMCONF_FAM10H=y
>> # CONFIG_PCI_CNB20LE_QUIRK is not set
>> # CONFIG_PCIEPORTBUS is not set
>> # CONFIG_PCI_MSI is not set
>> CONFIG_PCI_QUIRKS=y
>> # CONFIG_PCI_DEBUG is not set
>> # CONFIG_PCI_STUB is not set
>> CONFIG_PCI_LOCKLESS_CONFIG=y
>> # CONFIG_PCI_IOV is not set
>> # CONFIG_PCI_PRI is not set
>> # CONFIG_PCI_PASID is not set
>> CONFIG_PCI_LABEL=y
>> # CONFIG_HOTPLUG_PCI is not set
>>
>> #
>> # PCI controller drivers
>> #
>>
>> #
>> # Cadence PCIe controllers support
>> #
>>
>> #
>> # DesignWare PCI Core Support
>> #
>>
>> #
>> # PCI Endpoint
>> #
>> CONFIG_PCI_ENDPOINT=y
>> # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
>> CONFIG_PCI_EPF_TEST=m
>>
>> #
>> # PCI switch controller drivers
>> #
>> # CONFIG_PCI_SW_SWITCHTEC is not set
>> # CONFIG_ISA_BUS is not set
>> CONFIG_ISA_DMA_API=y
>> CONFIG_AMD_NB=y
>> CONFIG_PCCARD=y
>> CONFIG_PCMCIA=m
>> CONFIG_PCMCIA_LOAD_CIS=y
>> CONFIG_CARDBUS=y
>>
>> #
>> # PC-card bridges
>> #
>> # CONFIG_YENTA is not set
>> # CONFIG_PD6729 is not set
>> # CONFIG_I82092 is not set
>> # CONFIG_RAPIDIO is not set
>> # CONFIG_X86_SYSFB is not set
>>
>> #
>> # Executable file formats / Emulations
>> #
>> CONFIG_BINFMT_ELF=y
>> CONFIG_ELFCORE=y
>> CONFIG_BINFMT_SCRIPT=y
>> CONFIG_BINFMT_MISC=y
>> # CONFIG_COREDUMP is not set
>> # CONFIG_IA32_EMULATION is not set
>> CONFIG_X86_X32=y
>> CONFIG_COMPAT=y
>> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
>> CONFIG_X86_DEV_DMA_OPS=y
>> CONFIG_NET=y
>>
>> #
>> # Networking options
>> #
>> # CONFIG_PACKET is not set
>> CONFIG_UNIX=y
>> # CONFIG_UNIX_DIAG is not set
>> # CONFIG_TLS is not set
>> CONFIG_XFRM=y
>> # CONFIG_XFRM_USER is not set
>> # CONFIG_XFRM_SUB_POLICY is not set
>> # CONFIG_XFRM_MIGRATE is not set
>> # CONFIG_XFRM_STATISTICS is not set
>> # CONFIG_NET_KEY is not set
>> CONFIG_INET=y
>> # CONFIG_IP_MULTICAST is not set
>> # CONFIG_IP_ADVANCED_ROUTER is not set
>> CONFIG_IP_PNP=y
>> CONFIG_IP_PNP_DHCP=y
>> # CONFIG_IP_PNP_BOOTP is not set
>> # CONFIG_IP_PNP_RARP is not set
>> # CONFIG_NET_IPIP is not set
>> # CONFIG_NET_IPGRE_DEMUX is not set
>> CONFIG_NET_IP_TUNNEL=y
>> # CONFIG_SYN_COOKIES is not set
>> # CONFIG_NET_IPVTI is not set
>> # CONFIG_NET_FOU is not set
>> # CONFIG_NET_FOU_IP_TUNNELS is not set
>> # CONFIG_INET_AH is not set
>> # CONFIG_INET_ESP is not set
>> # CONFIG_INET_IPCOMP is not set
>> CONFIG_INET_TUNNEL=y
>> CONFIG_INET_XFRM_MODE_TRANSPORT=y
>> CONFIG_INET_XFRM_MODE_TUNNEL=y
>> CONFIG_INET_XFRM_MODE_BEET=y
>> CONFIG_INET_DIAG=y
>> CONFIG_INET_TCP_DIAG=y
>> # CONFIG_INET_UDP_DIAG is not set
>> # CONFIG_INET_RAW_DIAG is not set
>> # CONFIG_INET_DIAG_DESTROY is not set
>> # CONFIG_TCP_CONG_ADVANCED is not set
>> CONFIG_TCP_CONG_CUBIC=y
>> CONFIG_DEFAULT_TCP_CONG="cubic"
>> # CONFIG_TCP_MD5SIG is not set
>> CONFIG_IPV6=y
>> # CONFIG_IPV6_ROUTER_PREF is not set
>> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
>> # CONFIG_INET6_AH is not set
>> # CONFIG_INET6_ESP is not set
>> # CONFIG_INET6_IPCOMP is not set
>> # CONFIG_IPV6_MIP6 is not set
>> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
>> CONFIG_INET6_XFRM_MODE_TUNNEL=y
>> CONFIG_INET6_XFRM_MODE_BEET=y
>> # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
>> # CONFIG_IPV6_VTI is not set
>> CONFIG_IPV6_SIT=y
>> # CONFIG_IPV6_SIT_6RD is not set
>> CONFIG_IPV6_NDISC_NODETYPE=y
>> # CONFIG_IPV6_TUNNEL is not set
>> # CONFIG_IPV6_MULTIPLE_TABLES is not set
>> # CONFIG_IPV6_MROUTE is not set
>> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
>> # CONFIG_IPV6_SEG6_HMAC is not set
>> # CONFIG_NETWORK_SECMARK is not set
>> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
>> # CONFIG_NETFILTER is not set
>> # CONFIG_BPFILTER is not set
>> # CONFIG_IP_DCCP is not set
>> # CONFIG_IP_SCTP is not set
>> # CONFIG_RDS is not set
>> # CONFIG_TIPC is not set
>> # CONFIG_ATM is not set
>> # CONFIG_L2TP is not set
>> # CONFIG_BRIDGE is not set
>> CONFIG_HAVE_NET_DSA=y
>> # CONFIG_NET_DSA is not set
>> # CONFIG_VLAN_8021Q is not set
>> # CONFIG_DECNET is not set
>> # CONFIG_LLC2 is not set
>> # CONFIG_ATALK is not set
>> # CONFIG_X25 is not set
>> # CONFIG_LAPB is not set
>> # CONFIG_PHONET is not set
>> # CONFIG_6LOWPAN is not set
>> # CONFIG_IEEE802154 is not set
>> # CONFIG_NET_SCHED is not set
>> # CONFIG_DCB is not set
>> CONFIG_DNS_RESOLVER=m
>> # CONFIG_BATMAN_ADV is not set
>> # CONFIG_OPENVSWITCH is not set
>> # CONFIG_VSOCKETS is not set
>> # CONFIG_NETLINK_DIAG is not set
>> # CONFIG_MPLS is not set
>> # CONFIG_NET_NSH is not set
>> # CONFIG_HSR is not set
>> # CONFIG_NET_SWITCHDEV is not set
>> # CONFIG_NET_L3_MASTER_DEV is not set
>> # CONFIG_NET_NCSI is not set
>> CONFIG_RPS=y
>> CONFIG_RFS_ACCEL=y
>> CONFIG_XPS=y
>> # CONFIG_CGROUP_NET_PRIO is not set
>> # CONFIG_CGROUP_NET_CLASSID is not set
>> CONFIG_NET_RX_BUSY_POLL=y
>> CONFIG_BQL=y
>> # CONFIG_BPF_JIT is not set
>> CONFIG_NET_FLOW_LIMIT=y
>>
>> #
>> # Network testing
>> #
>> # CONFIG_NET_PKTGEN is not set
>> # CONFIG_HAMRADIO is not set
>> # CONFIG_CAN is not set
>> # CONFIG_BT is not set
>> # CONFIG_AF_RXRPC is not set
>> # CONFIG_AF_KCM is not set
>> CONFIG_WIRELESS=y
>> # CONFIG_CFG80211 is not set
>>
>> #
>> # CFG80211 needs to be enabled for MAC80211
>> #
>> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
>> # CONFIG_WIMAX is not set
>> # CONFIG_RFKILL is not set
>> # CONFIG_NET_9P is not set
>> # CONFIG_CAIF is not set
>> # CONFIG_CEPH_LIB is not set
>> # CONFIG_NFC is not set
>> # CONFIG_PSAMPLE is not set
>> # CONFIG_NET_IFE is not set
>> # CONFIG_LWTUNNEL is not set
>> CONFIG_DST_CACHE=y
>> CONFIG_GRO_CELLS=y
>> # CONFIG_NET_DEVLINK is not set
>> CONFIG_MAY_USE_DEVLINK=y
>> # CONFIG_FAILOVER is not set
>> CONFIG_HAVE_EBPF_JIT=y
>>
>> #
>> # Device Drivers
>> #
>>
>> #
>> # Generic Driver Options
>> #
>> # CONFIG_UEVENT_HELPER is not set
>> CONFIG_DEVTMPFS=y
>> CONFIG_DEVTMPFS_MOUNT=y
>> # CONFIG_STANDALONE is not set
>> CONFIG_PREVENT_FIRMWARE_BUILD=y
>>
>> #
>> # Firmware loader
>> #
>> CONFIG_FW_LOADER=y
>> CONFIG_EXTRA_FIRMWARE=""
>> CONFIG_FW_LOADER_USER_HELPER=y
>> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
>> CONFIG_ALLOW_DEV_COREDUMP=y
>> # CONFIG_DEBUG_DRIVER is not set
>> CONFIG_DEBUG_DEVRES=y
>> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
>> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
>> CONFIG_GENERIC_CPU_AUTOPROBE=y
>> CONFIG_GENERIC_CPU_VULNERABILITIES=y
>> CONFIG_REGMAP=y
>> CONFIG_REGMAP_I2C=y
>> CONFIG_REGMAP_SPI=y
>> CONFIG_REGMAP_SPMI=y
>> CONFIG_REGMAP_W1=y
>> CONFIG_REGMAP_MMIO=y
>> CONFIG_REGMAP_IRQ=y
>> CONFIG_DMA_SHARED_BUFFER=y
>> CONFIG_DMA_FENCE_TRACE=y
>>
>> #
>> # Bus devices
>> #
>> # CONFIG_CONNECTOR is not set
>> CONFIG_MTD=m
>> CONFIG_MTD_TESTS=m
>> CONFIG_MTD_REDBOOT_PARTS=m
>> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
>> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
>> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
>> # CONFIG_MTD_CMDLINE_PARTS is not set
>> CONFIG_MTD_AR7_PARTS=m
>>
>> #
>> # Partition parsers
>> #
>>
>> #
>> # User Modules And Translation Layers
>> #
>> CONFIG_MTD_BLKDEVS=m
>> # CONFIG_MTD_BLOCK is not set
>> # CONFIG_MTD_BLOCK_RO is not set
>> CONFIG_FTL=m
>> CONFIG_NFTL=m
>> # CONFIG_NFTL_RW is not set
>> # CONFIG_INFTL is not set
>> CONFIG_RFD_FTL=m
>> CONFIG_SSFDC=m
>> CONFIG_SM_FTL=m
>> # CONFIG_MTD_OOPS is not set
>> CONFIG_MTD_PARTITIONED_MASTER=y
>>
>> #
>> # RAM/ROM/Flash chip drivers
>> #
>> # CONFIG_MTD_CFI is not set
>> CONFIG_MTD_JEDECPROBE=m
>> CONFIG_MTD_GEN_PROBE=m
>> CONFIG_MTD_CFI_ADV_OPTIONS=y
>> # CONFIG_MTD_CFI_NOSWAP is not set
>> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
>> CONFIG_MTD_CFI_LE_BYTE_SWAP=y
>> # CONFIG_MTD_CFI_GEOMETRY is not set
>> CONFIG_MTD_MAP_BANK_WIDTH_1=y
>> CONFIG_MTD_MAP_BANK_WIDTH_2=y
>> CONFIG_MTD_MAP_BANK_WIDTH_4=y
>> CONFIG_MTD_CFI_I1=y
>> CONFIG_MTD_CFI_I2=y
>> # CONFIG_MTD_OTP is not set
>> CONFIG_MTD_CFI_INTELEXT=m
>> CONFIG_MTD_CFI_AMDSTD=m
>> # CONFIG_MTD_CFI_STAA is not set
>> CONFIG_MTD_CFI_UTIL=m
>> CONFIG_MTD_RAM=m
>> CONFIG_MTD_ROM=m
>> CONFIG_MTD_ABSENT=m
>>
>> #
>> # Mapping drivers for chip access
>> #
>> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
>> CONFIG_MTD_PHYSMAP=m
>> # CONFIG_MTD_PHYSMAP_COMPAT is not set
>> # CONFIG_MTD_AMD76XROM is not set
>> CONFIG_MTD_ICHXROM=m
>> # CONFIG_MTD_ESB2ROM is not set
>> # CONFIG_MTD_CK804XROM is not set
>> # CONFIG_MTD_SCB2_FLASH is not set
>> CONFIG_MTD_NETtel=m
>> CONFIG_MTD_L440GX=m
>> # CONFIG_MTD_INTEL_VR_NOR is not set
>> CONFIG_MTD_PLATRAM=m
>>
>> #
>> # Self-contained MTD device drivers
>> #
>> # CONFIG_MTD_PMC551 is not set
>> CONFIG_MTD_DATAFLASH=m
>> CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
>> CONFIG_MTD_DATAFLASH_OTP=y
>> CONFIG_MTD_M25P80=m
>> CONFIG_MTD_MCHP23K256=m
>> CONFIG_MTD_SST25L=m
>> # CONFIG_MTD_SLRAM is not set
>> CONFIG_MTD_PHRAM=m
>> CONFIG_MTD_MTDRAM=m
>> CONFIG_MTDRAM_TOTAL_SIZE=4096
>> CONFIG_MTDRAM_ERASE_SIZE=128
>> CONFIG_MTD_BLOCK2MTD=m
>>
>> #
>> # Disk-On-Chip Device Drivers
>> #
>> # CONFIG_MTD_DOCG3 is not set
>> CONFIG_MTD_ONENAND=m
>> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
>> CONFIG_MTD_ONENAND_GENERIC=m
>> # CONFIG_MTD_ONENAND_OTP is not set
>> CONFIG_MTD_ONENAND_2X_PROGRAM=y
>> CONFIG_MTD_NAND_ECC=m
>> CONFIG_MTD_NAND_ECC_SMC=y
>> # CONFIG_MTD_NAND is not set
>>
>> #
>> # LPDDR & LPDDR2 PCM memory drivers
>> #
>> CONFIG_MTD_LPDDR=m
>> CONFIG_MTD_QINFO_PROBE=m
>> CONFIG_MTD_SPI_NOR=m
>> CONFIG_MTD_MT81xx_NOR=m
>> # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
>> # CONFIG_SPI_INTEL_SPI_PCI is not set
>> # CONFIG_SPI_INTEL_SPI_PLATFORM is not set
>> CONFIG_MTD_UBI=m
>> CONFIG_MTD_UBI_WL_THRESHOLD=4096
>> CONFIG_MTD_UBI_BEB_LIMIT=20
>> CONFIG_MTD_UBI_FASTMAP=y
>> # CONFIG_MTD_UBI_GLUEBI is not set
>> # CONFIG_MTD_UBI_BLOCK is not set
>> # CONFIG_OF is not set
>> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
>> # CONFIG_PARPORT is not set
>> CONFIG_PNP=y
>> CONFIG_PNP_DEBUG_MESSAGES=y
>>
>> #
>> # Protocols
>> #
>> CONFIG_PNPACPI=y
>> CONFIG_BLK_DEV=y
>> # CONFIG_BLK_DEV_NULL_BLK is not set
>> # CONFIG_BLK_DEV_FD is not set
>> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
>> # CONFIG_ZRAM is not set
>> # CONFIG_BLK_DEV_DAC960 is not set
>> # CONFIG_BLK_DEV_UMEM is not set
>> # CONFIG_BLK_DEV_LOOP is not set
>> # CONFIG_BLK_DEV_DRBD is not set
>> # CONFIG_BLK_DEV_NBD is not set
>> # CONFIG_BLK_DEV_SKD is not set
>> # CONFIG_BLK_DEV_SX8 is not set
>> # CONFIG_BLK_DEV_RAM is not set
>> # CONFIG_CDROM_PKTCDVD is not set
>> # CONFIG_ATA_OVER_ETH is not set
>> # CONFIG_VIRTIO_BLK is not set
>> # CONFIG_BLK_DEV_RBD is not set
>> # CONFIG_BLK_DEV_RSXX is not set
>>
>> #
>> # NVME Support
>> #
>> CONFIG_NVME_CORE=y
>> # CONFIG_BLK_DEV_NVME is not set
>> CONFIG_NVME_MULTIPATH=y
>> CONFIG_NVME_FABRICS=y
>> # CONFIG_NVME_FC is not set
>> CONFIG_NVME_TARGET=y
>> CONFIG_NVME_TARGET_LOOP=y
>> CONFIG_NVME_TARGET_FC=m
>>
>> #
>> # Misc devices
>> #
>> # CONFIG_AD525X_DPOT is not set
>> CONFIG_DUMMY_IRQ=m
>> # CONFIG_IBM_ASM is not set
>> # CONFIG_PHANTOM is not set
>> # CONFIG_SGI_IOC4 is not set
>> # CONFIG_TIFM_CORE is not set
>> CONFIG_ICS932S401=m
>> CONFIG_ENCLOSURE_SERVICES=y
>> # CONFIG_HP_ILO is not set
>> # CONFIG_APDS9802ALS is not set
>> # CONFIG_ISL29003 is not set
>> # CONFIG_ISL29020 is not set
>> # CONFIG_SENSORS_TSL2550 is not set
>> CONFIG_SENSORS_BH1770=m
>> # CONFIG_SENSORS_APDS990X is not set
>> CONFIG_HMC6352=m
>> CONFIG_DS1682=y
>> CONFIG_USB_SWITCH_FSA9480=m
>> CONFIG_LATTICE_ECP3_CONFIG=y
>> # CONFIG_SRAM is not set
>> # CONFIG_PCI_ENDPOINT_TEST is not set
>> CONFIG_C2PORT=y
>> CONFIG_C2PORT_DURAMAR_2150=y
>>
>> #
>> # EEPROM support
>> #
>> CONFIG_EEPROM_AT24=m
>> CONFIG_EEPROM_AT25=m
>> CONFIG_EEPROM_LEGACY=m
>> CONFIG_EEPROM_MAX6875=m
>> CONFIG_EEPROM_93CX6=y
>> CONFIG_EEPROM_93XX46=m
>> CONFIG_EEPROM_IDT_89HPESX=y
>> # CONFIG_CB710_CORE is not set
>>
>> #
>> # Texas Instruments shared transport line discipline
>> #
>> # CONFIG_TI_ST is not set
>> # CONFIG_SENSORS_LIS3_I2C is not set
>> CONFIG_ALTERA_STAPL=y
>> # CONFIG_INTEL_MEI is not set
>> # CONFIG_INTEL_MEI_ME is not set
>> # CONFIG_INTEL_MEI_TXE is not set
>> # CONFIG_VMWARE_VMCI is not set
>>
>> #
>> # Intel MIC & related support
>> #
>>
>> #
>> # Intel MIC Bus Driver
>> #
>> # CONFIG_INTEL_MIC_BUS is not set
>>
>> #
>> # SCIF Bus Driver
>> #
>> # CONFIG_SCIF_BUS is not set
>>
>> #
>> # VOP Bus Driver
>> #
>> # CONFIG_VOP_BUS is not set
>>
>> #
>> # Intel MIC Host Driver
>> #
>>
>> #
>> # Intel MIC Card Driver
>> #
>>
>> #
>> # SCIF Driver
>> #
>>
>> #
>> # Intel MIC Coprocessor State Management (COSM) Drivers
>> #
>>
>> #
>> # VOP Driver
>> #
>> # CONFIG_GENWQE is not set
>> # CONFIG_ECHO is not set
>> # CONFIG_MISC_RTSX_PCI is not set
>> CONFIG_HAVE_IDE=y
>> CONFIG_IDE=m
>>
>> #
>> # Please see Documentation/ide/ide.txt for help/info on IDE drives
>> #
>> CONFIG_IDE_XFER_MODE=y
>> CONFIG_IDE_TIMINGS=y
>> CONFIG_IDE_ATAPI=y
>> CONFIG_BLK_DEV_IDE_SATA=y
>> CONFIG_IDE_GD=m
>> # CONFIG_IDE_GD_ATA is not set
>> # CONFIG_IDE_GD_ATAPI is not set
>> # CONFIG_BLK_DEV_IDECS is not set
>> # CONFIG_BLK_DEV_DELKIN is not set
>> # CONFIG_BLK_DEV_IDECD is not set
>> CONFIG_BLK_DEV_IDETAPE=m
>> # CONFIG_BLK_DEV_IDEACPI is not set
>> CONFIG_IDE_TASK_IOCTL=y
>> CONFIG_IDE_PROC_FS=y
>>
>> #
>> # IDE chipset support/bugfixes
>> #
>> CONFIG_IDE_GENERIC=m
>> # CONFIG_BLK_DEV_PLATFORM is not set
>> CONFIG_BLK_DEV_CMD640=m
>> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
>> # CONFIG_BLK_DEV_IDEPNP is not set
>>
>> #
>> # PCI IDE chipsets support
>> #
>> # CONFIG_BLK_DEV_GENERIC is not set
>> # CONFIG_BLK_DEV_OPTI621 is not set
>> # CONFIG_BLK_DEV_RZ1000 is not set
>> # CONFIG_BLK_DEV_AEC62XX is not set
>> # CONFIG_BLK_DEV_ALI15X3 is not set
>> # CONFIG_BLK_DEV_AMD74XX is not set
>> # CONFIG_BLK_DEV_ATIIXP is not set
>> # CONFIG_BLK_DEV_CMD64X is not set
>> # CONFIG_BLK_DEV_TRIFLEX is not set
>> # CONFIG_BLK_DEV_HPT366 is not set
>> # CONFIG_BLK_DEV_JMICRON is not set
>> # CONFIG_BLK_DEV_PIIX is not set
>> # CONFIG_BLK_DEV_IT8172 is not set
>> # CONFIG_BLK_DEV_IT8213 is not set
>> # CONFIG_BLK_DEV_IT821X is not set
>> # CONFIG_BLK_DEV_NS87415 is not set
>> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
>> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
>> # CONFIG_BLK_DEV_SVWKS is not set
>> # CONFIG_BLK_DEV_SIIMAGE is not set
>> # CONFIG_BLK_DEV_SIS5513 is not set
>> # CONFIG_BLK_DEV_SLC90E66 is not set
>> # CONFIG_BLK_DEV_TRM290 is not set
>> # CONFIG_BLK_DEV_VIA82CXXX is not set
>> # CONFIG_BLK_DEV_TC86C001 is not set
>>
>> #
>> # SCSI device support
>> #
>> CONFIG_SCSI_MOD=y
>> CONFIG_RAID_ATTRS=y
>> CONFIG_SCSI=y
>> CONFIG_SCSI_DMA=y
>> # CONFIG_SCSI_MQ_DEFAULT is not set
>> CONFIG_SCSI_PROC_FS=y
>>
>> #
>> # SCSI support type (disk, tape, CD-ROM)
>> #
>> CONFIG_BLK_DEV_SD=m
>> CONFIG_CHR_DEV_ST=y
>> CONFIG_CHR_DEV_OSST=m
>> # CONFIG_BLK_DEV_SR is not set
>> # CONFIG_CHR_DEV_SG is not set
>> CONFIG_CHR_DEV_SCH=m
>> CONFIG_SCSI_ENCLOSURE=m
>> CONFIG_SCSI_CONSTANTS=y
>> # CONFIG_SCSI_LOGGING is not set
>> # CONFIG_SCSI_SCAN_ASYNC is not set
>>
>> #
>> # SCSI Transports
>> #
>> # CONFIG_SCSI_SPI_ATTRS is not set
>> # CONFIG_SCSI_FC_ATTRS is not set
>> # CONFIG_SCSI_ISCSI_ATTRS is not set
>> CONFIG_SCSI_SAS_ATTRS=y
>> CONFIG_SCSI_SAS_LIBSAS=y
>> CONFIG_SCSI_SAS_ATA=y
>> # CONFIG_SCSI_SAS_HOST_SMP is not set
>> # CONFIG_SCSI_SRP_ATTRS is not set
>> CONFIG_SCSI_LOWLEVEL=y
>> # CONFIG_ISCSI_TCP is not set
>> # CONFIG_ISCSI_BOOT_SYSFS is not set
>> # CONFIG_SCSI_CXGB3_ISCSI is not set
>> # CONFIG_SCSI_CXGB4_ISCSI is not set
>> # CONFIG_SCSI_BNX2_ISCSI is not set
>> # CONFIG_BE2ISCSI is not set
>> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
>> # CONFIG_SCSI_HPSA is not set
>> # CONFIG_SCSI_3W_9XXX is not set
>> # CONFIG_SCSI_3W_SAS is not set
>> # CONFIG_SCSI_ACARD is not set
>> # CONFIG_SCSI_AACRAID is not set
>> # CONFIG_SCSI_AIC7XXX is not set
>> # CONFIG_SCSI_AIC79XX is not set
>> # CONFIG_SCSI_AIC94XX is not set
>> # CONFIG_SCSI_MVSAS is not set
>> # CONFIG_SCSI_MVUMI is not set
>> # CONFIG_SCSI_DPT_I2O is not set
>> # CONFIG_SCSI_ADVANSYS is not set
>> # CONFIG_SCSI_ARCMSR is not set
>> # CONFIG_SCSI_ESAS2R is not set
>> # CONFIG_MEGARAID_NEWGEN is not set
>> # CONFIG_MEGARAID_LEGACY is not set
>> # CONFIG_MEGARAID_SAS is not set
>> # CONFIG_SCSI_MPT3SAS is not set
>> # CONFIG_SCSI_MPT2SAS is not set
>> # CONFIG_SCSI_SMARTPQI is not set
>> CONFIG_SCSI_UFSHCD=m
>> # CONFIG_SCSI_UFSHCD_PCI is not set
>> CONFIG_SCSI_UFSHCD_PLATFORM=m
>> CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
>> # CONFIG_SCSI_HPTIOP is not set
>> # CONFIG_SCSI_BUSLOGIC is not set
>> # CONFIG_VMWARE_PVSCSI is not set
>> # CONFIG_SCSI_SNIC is not set
>> # CONFIG_SCSI_DMX3191D is not set
>> # CONFIG_SCSI_GDTH is not set
>> # CONFIG_SCSI_ISCI is not set
>> # CONFIG_SCSI_IPS is not set
>> # CONFIG_SCSI_INITIO is not set
>> # CONFIG_SCSI_INIA100 is not set
>> # CONFIG_SCSI_STEX is not set
>> # CONFIG_SCSI_SYM53C8XX_2 is not set
>> # CONFIG_SCSI_IPR is not set
>> # CONFIG_SCSI_QLOGIC_1280 is not set
>> # CONFIG_SCSI_QLA_ISCSI is not set
>> # CONFIG_SCSI_DC395x is not set
>> # CONFIG_SCSI_AM53C974 is not set
>> # CONFIG_SCSI_WD719X is not set
>> CONFIG_SCSI_DEBUG=m
>> # CONFIG_SCSI_PMCRAID is not set
>> # CONFIG_SCSI_PM8001 is not set
>> CONFIG_SCSI_VIRTIO=y
>> # CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
>> CONFIG_SCSI_DH=y
>> CONFIG_SCSI_DH_RDAC=m
>> CONFIG_SCSI_DH_HP_SW=y
>> CONFIG_SCSI_DH_EMC=y
>> CONFIG_SCSI_DH_ALUA=m
>> CONFIG_SCSI_OSD_INITIATOR=y
>> CONFIG_SCSI_OSD_ULD=y
>> CONFIG_SCSI_OSD_DPRINT_SENSE=1
>> # CONFIG_SCSI_OSD_DEBUG is not set
>> CONFIG_ATA=y
>> # CONFIG_ATA_VERBOSE_ERROR is not set
>> CONFIG_ATA_ACPI=y
>> CONFIG_SATA_PMP=y
>>
>> #
>> # Controllers with non-SFF native interface
>> #
>> # CONFIG_SATA_AHCI is not set
>> # CONFIG_SATA_AHCI_PLATFORM is not set
>> # CONFIG_SATA_INIC162X is not set
>> # CONFIG_SATA_ACARD_AHCI is not set
>> # CONFIG_SATA_SIL24 is not set
>> # CONFIG_ATA_SFF is not set
>> CONFIG_MD=y
>> CONFIG_BLK_DEV_MD=y
>> CONFIG_MD_AUTODETECT=y
>> # CONFIG_MD_LINEAR is not set
>> CONFIG_MD_RAID0=m
>> CONFIG_MD_RAID1=y
>> CONFIG_MD_RAID10=m
>> CONFIG_MD_RAID456=m
>> # CONFIG_MD_MULTIPATH is not set
>> CONFIG_MD_FAULTY=y
>> # CONFIG_BCACHE is not set
>> CONFIG_BLK_DEV_DM_BUILTIN=y
>> CONFIG_BLK_DEV_DM=m
>> # CONFIG_DM_MQ_DEFAULT is not set
>> # CONFIG_DM_DEBUG is not set
>> CONFIG_DM_BUFIO=m
>> CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
>> # CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
>> CONFIG_DM_BIO_PRISON=m
>> CONFIG_DM_PERSISTENT_DATA=m
>> # CONFIG_DM_UNSTRIPED is not set
>> # CONFIG_DM_CRYPT is not set
>> # CONFIG_DM_SNAPSHOT is not set
>> CONFIG_DM_THIN_PROVISIONING=m
>> CONFIG_DM_CACHE=m
>> # CONFIG_DM_CACHE_SMQ is not set
>> # CONFIG_DM_WRITECACHE is not set
>> CONFIG_DM_ERA=m
>> # CONFIG_DM_MIRROR is not set
>> CONFIG_DM_RAID=m
>> # CONFIG_DM_ZERO is not set
>> CONFIG_DM_MULTIPATH=m
>> # CONFIG_DM_MULTIPATH_QL is not set
>> CONFIG_DM_MULTIPATH_ST=m
>> # CONFIG_DM_DELAY is not set
>> CONFIG_DM_UEVENT=y
>> CONFIG_DM_FLAKEY=m
>> CONFIG_DM_VERITY=m
>> CONFIG_DM_VERITY_FEC=y
>> CONFIG_DM_SWITCH=m
>> # CONFIG_DM_LOG_WRITES is not set
>> CONFIG_DM_INTEGRITY=m
>> # CONFIG_TARGET_CORE is not set
>> # CONFIG_FUSION is not set
>>
>> #
>> # IEEE 1394 (FireWire) support
>> #
>> CONFIG_FIREWIRE=y
>> # CONFIG_FIREWIRE_OHCI is not set
>> CONFIG_FIREWIRE_SBP2=y
>> # CONFIG_FIREWIRE_NET is not set
>> # CONFIG_FIREWIRE_NOSY is not set
>> # CONFIG_MACINTOSH_DRIVERS is not set
>> CONFIG_NETDEVICES=y
>> CONFIG_NET_CORE=y
>> # CONFIG_BONDING is not set
>> # CONFIG_DUMMY is not set
>> # CONFIG_EQUALIZER is not set
>> # CONFIG_NET_FC is not set
>> # CONFIG_NET_TEAM is not set
>> # CONFIG_MACVLAN is not set
>> # CONFIG_VXLAN is not set
>> # CONFIG_MACSEC is not set
>> # CONFIG_NETCONSOLE is not set
>> # CONFIG_TUN is not set
>> # CONFIG_TUN_VNET_CROSS_LE is not set
>> # CONFIG_VETH is not set
>> # CONFIG_VIRTIO_NET is not set
>> # CONFIG_NLMON is not set
>> # CONFIG_ARCNET is not set
>>
>> #
>> # CAIF transport drivers
>> #
>>
>> #
>> # Distributed Switch Architecture drivers
>> #
>> CONFIG_ETHERNET=y
>> CONFIG_MDIO=m
>> CONFIG_NET_VENDOR_3COM=y
>> # CONFIG_PCMCIA_3C574 is not set
>> # CONFIG_PCMCIA_3C589 is not set
>> # CONFIG_VORTEX is not set
>> # CONFIG_TYPHOON is not set
>> CONFIG_NET_VENDOR_ADAPTEC=y
>> # CONFIG_ADAPTEC_STARFIRE is not set
>> CONFIG_NET_VENDOR_AGERE=y
>> # CONFIG_ET131X is not set
>> CONFIG_NET_VENDOR_ALACRITECH=y
>> # CONFIG_SLICOSS is not set
>> CONFIG_NET_VENDOR_ALTEON=y
>> # CONFIG_ACENIC is not set
>> # CONFIG_ALTERA_TSE is not set
>> CONFIG_NET_VENDOR_AMAZON=y
>> CONFIG_NET_VENDOR_AMD=y
>> # CONFIG_AMD8111_ETH is not set
>> # CONFIG_PCNET32 is not set
>> # CONFIG_PCMCIA_NMCLAN is not set
>> # CONFIG_AMD_XGBE is not set
>> CONFIG_NET_VENDOR_AQUANTIA=y
>> # CONFIG_AQTION is not set
>> CONFIG_NET_VENDOR_ARC=y
>> CONFIG_NET_VENDOR_ATHEROS=y
>> # CONFIG_ATL2 is not set
>> # CONFIG_ATL1 is not set
>> # CONFIG_ATL1E is not set
>> # CONFIG_ATL1C is not set
>> # CONFIG_ALX is not set
>> # CONFIG_NET_VENDOR_AURORA is not set
>> CONFIG_NET_VENDOR_BROADCOM=y
>> # CONFIG_B44 is not set
>> # CONFIG_BNX2 is not set
>> # CONFIG_CNIC is not set
>> # CONFIG_TIGON3 is not set
>> # CONFIG_BNX2X is not set
>> # CONFIG_BNXT is not set
>> CONFIG_NET_VENDOR_BROCADE=y
>> # CONFIG_BNA is not set
>> CONFIG_NET_CADENCE=y
>> # CONFIG_MACB is not set
>> CONFIG_NET_VENDOR_CAVIUM=y
>> # CONFIG_THUNDER_NIC_PF is not set
>> # CONFIG_THUNDER_NIC_VF is not set
>> # CONFIG_THUNDER_NIC_BGX is not set
>> # CONFIG_THUNDER_NIC_RGX is not set
>> CONFIG_CAVIUM_PTP=y
>> # CONFIG_LIQUIDIO is not set
>> CONFIG_NET_VENDOR_CHELSIO=y
>> # CONFIG_CHELSIO_T1 is not set
>> # CONFIG_CHELSIO_T3 is not set
>> # CONFIG_CHELSIO_T4 is not set
>> # CONFIG_CHELSIO_T4VF is not set
>> CONFIG_NET_VENDOR_CISCO=y
>> # CONFIG_ENIC is not set
>> CONFIG_NET_VENDOR_CORTINA=y
>> # CONFIG_CX_ECAT is not set
>> # CONFIG_DNET is not set
>> CONFIG_NET_VENDOR_DEC=y
>> # CONFIG_NET_TULIP is not set
>> CONFIG_NET_VENDOR_DLINK=y
>> # CONFIG_DL2K is not set
>> # CONFIG_SUNDANCE is not set
>> CONFIG_NET_VENDOR_EMULEX=y
>> # CONFIG_BE2NET is not set
>> CONFIG_NET_VENDOR_EZCHIP=y
>> CONFIG_NET_VENDOR_FUJITSU=y
>> # CONFIG_PCMCIA_FMVJ18X is not set
>> CONFIG_NET_VENDOR_HP=y
>> # CONFIG_HP100 is not set
>> CONFIG_NET_VENDOR_HUAWEI=y
>> CONFIG_NET_VENDOR_I825XX=y
>> CONFIG_NET_VENDOR_INTEL=y
>> # CONFIG_E100 is not set
>> CONFIG_E1000=y
>> CONFIG_E1000E=m
>> CONFIG_E1000E_HWTS=y
>> CONFIG_IGB=m
>> CONFIG_IGB_HWMON=y
>> # CONFIG_IGBVF is not set
>> # CONFIG_IXGB is not set
>> CONFIG_IXGBE=m
>> CONFIG_IXGBE_HWMON=y
>> # CONFIG_I40E is not set
>> CONFIG_NET_VENDOR_EXAR=y
>> # CONFIG_S2IO is not set
>> # CONFIG_VXGE is not set
>> # CONFIG_JME is not set
>> CONFIG_NET_VENDOR_MARVELL=y
>> # CONFIG_MVMDIO is not set
>> # CONFIG_SKGE is not set
>> # CONFIG_SKY2 is not set
>> CONFIG_NET_VENDOR_MELLANOX=y
>> # CONFIG_MLX4_EN is not set
>> # CONFIG_MLX5_CORE is not set
>> # CONFIG_MLXSW_CORE is not set
>> # CONFIG_MLXFW is not set
>> CONFIG_NET_VENDOR_MICREL=y
>> # CONFIG_KS8842 is not set
>> # CONFIG_KS8851 is not set
>> # CONFIG_KS8851_MLL is not set
>> # CONFIG_KSZ884X_PCI is not set
>> CONFIG_NET_VENDOR_MICROCHIP=y
>> # CONFIG_ENC28J60 is not set
>> # CONFIG_ENCX24J600 is not set
>> # CONFIG_LAN743X is not set
>> CONFIG_NET_VENDOR_MICROSEMI=y
>> CONFIG_NET_VENDOR_MYRI=y
>> # CONFIG_MYRI10GE is not set
>> # CONFIG_FEALNX is not set
>> CONFIG_NET_VENDOR_NATSEMI=y
>> # CONFIG_NATSEMI is not set
>> # CONFIG_NS83820 is not set
>> CONFIG_NET_VENDOR_NETRONOME=y
>> CONFIG_NET_VENDOR_NI=y
>> CONFIG_NET_VENDOR_8390=y
>> # CONFIG_PCMCIA_AXNET is not set
>> # CONFIG_NE2K_PCI is not set
>> # CONFIG_PCMCIA_PCNET is not set
>> CONFIG_NET_VENDOR_NVIDIA=y
>> # CONFIG_FORCEDETH is not set
>> CONFIG_NET_VENDOR_OKI=y
>> # CONFIG_ETHOC is not set
>> CONFIG_NET_PACKET_ENGINE=y
>> # CONFIG_HAMACHI is not set
>> # CONFIG_YELLOWFIN is not set
>> CONFIG_NET_VENDOR_QLOGIC=y
>> # CONFIG_QLA3XXX is not set
>> # CONFIG_QLCNIC is not set
>> # CONFIG_QLGE is not set
>> # CONFIG_NETXEN_NIC is not set
>> # CONFIG_QED is not set
>> CONFIG_NET_VENDOR_QUALCOMM=y
>> # CONFIG_QCOM_EMAC is not set
>> # CONFIG_RMNET is not set
>> CONFIG_NET_VENDOR_RDC=y
>> # CONFIG_R6040 is not set
>> CONFIG_NET_VENDOR_REALTEK=y
>> # CONFIG_8139CP is not set
>> # CONFIG_8139TOO is not set
>> # CONFIG_R8169 is not set
>> CONFIG_NET_VENDOR_RENESAS=y
>> CONFIG_NET_VENDOR_ROCKER=y
>> CONFIG_NET_VENDOR_SAMSUNG=y
>> # CONFIG_SXGBE_ETH is not set
>> CONFIG_NET_VENDOR_SEEQ=y
>> CONFIG_NET_VENDOR_SOLARFLARE=y
>> # CONFIG_SFC is not set
>> # CONFIG_SFC_FALCON is not set
>> CONFIG_NET_VENDOR_SILAN=y
>> # CONFIG_SC92031 is not set
>> CONFIG_NET_VENDOR_SIS=y
>> # CONFIG_SIS900 is not set
>> # CONFIG_SIS190 is not set
>> CONFIG_NET_VENDOR_SMSC=y
>> # CONFIG_PCMCIA_SMC91C92 is not set
>> # CONFIG_EPIC100 is not set
>> # CONFIG_SMSC911X is not set
>> # CONFIG_SMSC9420 is not set
>> CONFIG_NET_VENDOR_SOCIONEXT=y
>> CONFIG_NET_VENDOR_STMICRO=y
>> # CONFIG_STMMAC_ETH is not set
>> CONFIG_NET_VENDOR_SUN=y
>> # CONFIG_HAPPYMEAL is not set
>> # CONFIG_SUNGEM is not set
>> # CONFIG_CASSINI is not set
>> # CONFIG_NIU is not set
>> CONFIG_NET_VENDOR_SYNOPSYS=y
>> # CONFIG_DWC_XLGMAC is not set
>> CONFIG_NET_VENDOR_TEHUTI=y
>> # CONFIG_TEHUTI is not set
>> CONFIG_NET_VENDOR_TI=y
>> # CONFIG_TI_CPSW_ALE is not set
>> # CONFIG_TLAN is not set
>> CONFIG_NET_VENDOR_VIA=y
>> # CONFIG_VIA_RHINE is not set
>> # CONFIG_VIA_VELOCITY is not set
>> CONFIG_NET_VENDOR_WIZNET=y
>> # CONFIG_WIZNET_W5100 is not set
>> # CONFIG_WIZNET_W5300 is not set
>> CONFIG_NET_VENDOR_XIRCOM=y
>> # CONFIG_PCMCIA_XIRC2PS is not set
>> # CONFIG_FDDI is not set
>> # CONFIG_HIPPI is not set
>> # CONFIG_NET_SB1000 is not set
>> # CONFIG_MDIO_DEVICE is not set
>> # CONFIG_PHYLIB is not set
>> # CONFIG_MICREL_KS8995MA is not set
>> # CONFIG_PPP is not set
>> # CONFIG_SLIP is not set
>>
>> #
>> # Host-side USB support is needed for USB Network Adapter support
>> #
>> CONFIG_WLAN=y
>> # CONFIG_WIRELESS_WDS is not set
>> CONFIG_WLAN_VENDOR_ADMTEK=y
>> CONFIG_WLAN_VENDOR_ATH=y
>> # CONFIG_ATH_DEBUG is not set
>> # CONFIG_ATH5K_PCI is not set
>> CONFIG_WLAN_VENDOR_ATMEL=y
>> CONFIG_WLAN_VENDOR_BROADCOM=y
>> CONFIG_WLAN_VENDOR_CISCO=y
>> CONFIG_WLAN_VENDOR_INTEL=y
>> CONFIG_WLAN_VENDOR_INTERSIL=y
>> # CONFIG_HOSTAP is not set
>> # CONFIG_PRISM54 is not set
>> CONFIG_WLAN_VENDOR_MARVELL=y
>> CONFIG_WLAN_VENDOR_MEDIATEK=y
>> CONFIG_WLAN_VENDOR_RALINK=y
>> CONFIG_WLAN_VENDOR_REALTEK=y
>> CONFIG_WLAN_VENDOR_RSI=y
>> CONFIG_WLAN_VENDOR_ST=y
>> CONFIG_WLAN_VENDOR_TI=y
>> CONFIG_WLAN_VENDOR_ZYDAS=y
>> CONFIG_WLAN_VENDOR_QUANTENNA=y
>> # CONFIG_PCMCIA_RAYCS is not set
>>
>> #
>> # Enable WiMAX (Networking options) to see the WiMAX drivers
>> #
>> # CONFIG_WAN is not set
>> # CONFIG_VMXNET3 is not set
>> # CONFIG_FUJITSU_ES is not set
>> # CONFIG_NETDEVSIM is not set
>> # CONFIG_NET_FAILOVER is not set
>> # CONFIG_ISDN is not set
>> # CONFIG_NVM is not set
>>
>> #
>> # Input device support
>> #
>> CONFIG_INPUT=y
>> # CONFIG_INPUT_LEDS is not set
>> CONFIG_INPUT_FF_MEMLESS=m
>> CONFIG_INPUT_POLLDEV=m
>> CONFIG_INPUT_SPARSEKMAP=m
>> CONFIG_INPUT_MATRIXKMAP=m
>>
>> #
>> # Userland interfaces
>> #
>> CONFIG_INPUT_MOUSEDEV=m
>> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>> # CONFIG_INPUT_JOYDEV is not set
>> CONFIG_INPUT_EVDEV=m
>> # CONFIG_INPUT_EVBUG is not set
>>
>> #
>> # Input Device Drivers
>> #
>> CONFIG_INPUT_KEYBOARD=y
>> CONFIG_KEYBOARD_ADC=m
>> CONFIG_KEYBOARD_ADP5520=m
>> CONFIG_KEYBOARD_ADP5588=m
>> CONFIG_KEYBOARD_ADP5589=m
>> CONFIG_KEYBOARD_ATKBD=y
>> # CONFIG_KEYBOARD_QT1070 is not set
>> CONFIG_KEYBOARD_QT2160=m
>> CONFIG_KEYBOARD_DLINK_DIR685=m
>> CONFIG_KEYBOARD_LKKBD=m
>> # CONFIG_KEYBOARD_GPIO is not set
>> # CONFIG_KEYBOARD_GPIO_POLLED is not set
>> CONFIG_KEYBOARD_TCA6416=m
>> CONFIG_KEYBOARD_TCA8418=m
>> # CONFIG_KEYBOARD_MATRIX is not set
>> CONFIG_KEYBOARD_LM8323=m
>> CONFIG_KEYBOARD_LM8333=m
>> CONFIG_KEYBOARD_MAX7359=m
>> CONFIG_KEYBOARD_MCS=m
>> # CONFIG_KEYBOARD_MPR121 is not set
>> CONFIG_KEYBOARD_NEWTON=m
>> CONFIG_KEYBOARD_OPENCORES=m
>> # CONFIG_KEYBOARD_SAMSUNG is not set
>> CONFIG_KEYBOARD_STOWAWAY=m
>> CONFIG_KEYBOARD_SUNKBD=m
>> CONFIG_KEYBOARD_TM2_TOUCHKEY=m
>> CONFIG_KEYBOARD_TWL4030=m
>> CONFIG_KEYBOARD_XTKBD=m
>> CONFIG_KEYBOARD_MTK_PMIC=m
>> CONFIG_INPUT_MOUSE=y
>> CONFIG_MOUSE_PS2=m
>> # CONFIG_MOUSE_PS2_ALPS is not set
>> # CONFIG_MOUSE_PS2_BYD is not set
>> CONFIG_MOUSE_PS2_LOGIPS2PP=y
>> # CONFIG_MOUSE_PS2_SYNAPTICS is not set
>> # CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
>> CONFIG_MOUSE_PS2_CYPRESS=y
>> # CONFIG_MOUSE_PS2_LIFEBOOK is not set
>> # CONFIG_MOUSE_PS2_TRACKPOINT is not set
>> # CONFIG_MOUSE_PS2_ELANTECH is not set
>> CONFIG_MOUSE_PS2_SENTELIC=y
>> CONFIG_MOUSE_PS2_TOUCHKIT=y
>> CONFIG_MOUSE_PS2_FOCALTECH=y
>> # CONFIG_MOUSE_PS2_VMMOUSE is not set
>> CONFIG_MOUSE_SERIAL=m
>> # CONFIG_MOUSE_APPLETOUCH is not set
>> # CONFIG_MOUSE_BCM5974 is not set
>> # CONFIG_MOUSE_CYAPA is not set
>> # CONFIG_MOUSE_ELAN_I2C is not set
>> CONFIG_MOUSE_VSXXXAA=m
>> CONFIG_MOUSE_GPIO=m
>> CONFIG_MOUSE_SYNAPTICS_I2C=m
>> # CONFIG_MOUSE_SYNAPTICS_USB is not set
>> CONFIG_INPUT_JOYSTICK=y
>> CONFIG_JOYSTICK_ANALOG=m
>> # CONFIG_JOYSTICK_A3D is not set
>> CONFIG_JOYSTICK_ADI=m
>> CONFIG_JOYSTICK_COBRA=m
>> CONFIG_JOYSTICK_GF2K=m
>> CONFIG_JOYSTICK_GRIP=m
>> CONFIG_JOYSTICK_GRIP_MP=m
>> CONFIG_JOYSTICK_GUILLEMOT=m
>> CONFIG_JOYSTICK_INTERACT=m
>> CONFIG_JOYSTICK_SIDEWINDER=m
>> CONFIG_JOYSTICK_TMDC=m
>> CONFIG_JOYSTICK_IFORCE=m
>> # CONFIG_JOYSTICK_IFORCE_232 is not set
>> CONFIG_JOYSTICK_WARRIOR=m
>> CONFIG_JOYSTICK_MAGELLAN=m
>> CONFIG_JOYSTICK_SPACEORB=m
>> CONFIG_JOYSTICK_SPACEBALL=m
>> CONFIG_JOYSTICK_STINGER=m
>> CONFIG_JOYSTICK_TWIDJOY=m
>> # CONFIG_JOYSTICK_ZHENHUA is not set
>> CONFIG_JOYSTICK_AS5011=m
>> CONFIG_JOYSTICK_JOYDUMP=m
>> # CONFIG_JOYSTICK_XPAD is not set
>> CONFIG_JOYSTICK_PSXPAD_SPI=m
>> CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
>> # CONFIG_JOYSTICK_PXRC is not set
>> CONFIG_INPUT_TABLET=y
>> # CONFIG_TABLET_USB_ACECAD is not set
>> # CONFIG_TABLET_USB_AIPTEK is not set
>> # CONFIG_TABLET_USB_HANWANG is not set
>> # CONFIG_TABLET_USB_KBTAB is not set
>> # CONFIG_TABLET_USB_PEGASUS is not set
>> CONFIG_TABLET_SERIAL_WACOM4=m
>> CONFIG_INPUT_TOUCHSCREEN=y
>> CONFIG_TOUCHSCREEN_PROPERTIES=y
>> CONFIG_TOUCHSCREEN_88PM860X=m
>> CONFIG_TOUCHSCREEN_ADS7846=m
>> # CONFIG_TOUCHSCREEN_AD7877 is not set
>> CONFIG_TOUCHSCREEN_AD7879=m
>> CONFIG_TOUCHSCREEN_AD7879_I2C=m
>> CONFIG_TOUCHSCREEN_AD7879_SPI=m
>> CONFIG_TOUCHSCREEN_ATMEL_MXT=m
>> # CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
>> CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
>> CONFIG_TOUCHSCREEN_BU21013=m
>> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
>> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
>> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
>> CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
>> CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
>> # CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
>> CONFIG_TOUCHSCREEN_DA9052=m
>> CONFIG_TOUCHSCREEN_DYNAPRO=m
>> CONFIG_TOUCHSCREEN_HAMPSHIRE=m
>> CONFIG_TOUCHSCREEN_EETI=m
>> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
>> # CONFIG_TOUCHSCREEN_EXC3000 is not set
>> # CONFIG_TOUCHSCREEN_FUJITSU is not set
>> CONFIG_TOUCHSCREEN_GOODIX=m
>> CONFIG_TOUCHSCREEN_HIDEEP=m
>> CONFIG_TOUCHSCREEN_ILI210X=m
>> CONFIG_TOUCHSCREEN_S6SY761=m
>> # CONFIG_TOUCHSCREEN_GUNZE is not set
>> CONFIG_TOUCHSCREEN_EKTF2127=m
>> CONFIG_TOUCHSCREEN_ELAN=m
>> # CONFIG_TOUCHSCREEN_ELO is not set
>> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
>> CONFIG_TOUCHSCREEN_WACOM_I2C=m
>> CONFIG_TOUCHSCREEN_MAX11801=m
>> CONFIG_TOUCHSCREEN_MCS5000=m
>> CONFIG_TOUCHSCREEN_MMS114=m
>> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
>> CONFIG_TOUCHSCREEN_MTOUCH=m
>> CONFIG_TOUCHSCREEN_INEXIO=m
>> CONFIG_TOUCHSCREEN_MK712=m
>> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
>> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
>> CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
>> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
>> # CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
>> CONFIG_TOUCHSCREEN_UCB1400=m
>> # CONFIG_TOUCHSCREEN_PIXCIR is not set
>> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
>> # CONFIG_TOUCHSCREEN_WM831X is not set
>> CONFIG_TOUCHSCREEN_WM97XX=m
>> # CONFIG_TOUCHSCREEN_WM9705 is not set
>> CONFIG_TOUCHSCREEN_WM9712=y
>> CONFIG_TOUCHSCREEN_WM9713=y
>> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
>> CONFIG_TOUCHSCREEN_MC13783=m
>> CONFIG_TOUCHSCREEN_TOUCHIT213=m
>> CONFIG_TOUCHSCREEN_TSC_SERIO=m
>> CONFIG_TOUCHSCREEN_TSC200X_CORE=m
>> # CONFIG_TOUCHSCREEN_TSC2004 is not set
>> CONFIG_TOUCHSCREEN_TSC2005=m
>> CONFIG_TOUCHSCREEN_TSC2007=m
>> CONFIG_TOUCHSCREEN_TSC2007_IIO=y
>> CONFIG_TOUCHSCREEN_PCAP=m
>> # CONFIG_TOUCHSCREEN_RM_TS is not set
>> CONFIG_TOUCHSCREEN_SILEAD=m
>> CONFIG_TOUCHSCREEN_SIS_I2C=m
>> CONFIG_TOUCHSCREEN_ST1232=m
>> CONFIG_TOUCHSCREEN_STMFTS=m
>> CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
>> # CONFIG_TOUCHSCREEN_SX8654 is not set
>> CONFIG_TOUCHSCREEN_TPS6507X=m
>> CONFIG_TOUCHSCREEN_ZET6223=m
>> # CONFIG_TOUCHSCREEN_ZFORCE is not set
>> CONFIG_TOUCHSCREEN_ROHM_BU21023=m
>> # CONFIG_INPUT_MISC is not set
>> # CONFIG_RMI4_CORE is not set
>>
>> #
>> # Hardware I/O ports
>> #
>> CONFIG_SERIO=y
>> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
>> CONFIG_SERIO_I8042=y
>> CONFIG_SERIO_SERPORT=y
>> CONFIG_SERIO_CT82C710=m
>> # CONFIG_SERIO_PCIPS2 is not set
>> CONFIG_SERIO_LIBPS2=y
>> CONFIG_SERIO_RAW=m
>> CONFIG_SERIO_ALTERA_PS2=m
>> # CONFIG_SERIO_PS2MULT is not set
>> # CONFIG_SERIO_ARC_PS2 is not set
>> # CONFIG_SERIO_GPIO_PS2 is not set
>> CONFIG_USERIO=m
>> CONFIG_GAMEPORT=m
>> # CONFIG_GAMEPORT_NS558 is not set
>> # CONFIG_GAMEPORT_L4 is not set
>> # CONFIG_GAMEPORT_EMU10K1 is not set
>> # CONFIG_GAMEPORT_FM801 is not set
>>
>> #
>> # Character devices
>> #
>> CONFIG_TTY=y
>> # CONFIG_VT is not set
>> CONFIG_UNIX98_PTYS=y
>> CONFIG_LEGACY_PTYS=y
>> CONFIG_LEGACY_PTY_COUNT=256
>> # CONFIG_SERIAL_NONSTANDARD is not set
>> # CONFIG_NOZOMI is not set
>> # CONFIG_N_GSM is not set
>> # CONFIG_TRACE_SINK is not set
>> # CONFIG_DEVMEM is not set
>> # CONFIG_DEVKMEM is not set
>>
>> #
>> # Serial drivers
>> #
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_8250=y
>> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
>> CONFIG_SERIAL_8250_PNP=y
>> # CONFIG_SERIAL_8250_FINTEK is not set
>> CONFIG_SERIAL_8250_CONSOLE=y
>> CONFIG_SERIAL_8250_DMA=y
>> CONFIG_SERIAL_8250_PCI=y
>> CONFIG_SERIAL_8250_EXAR=y
>> # CONFIG_SERIAL_8250_CS is not set
>> # CONFIG_SERIAL_8250_MEN_MCB is not set
>> CONFIG_SERIAL_8250_NR_UARTS=4
>> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>> # CONFIG_SERIAL_8250_EXTENDED is not set
>> # CONFIG_SERIAL_8250_DW is not set
>> # CONFIG_SERIAL_8250_RT288X is not set
>> CONFIG_SERIAL_8250_LPSS=y
>> CONFIG_SERIAL_8250_MID=y
>> # CONFIG_SERIAL_8250_MOXA is not set
>>
>> #
>> # Non-8250 serial port support
>> #
>> # CONFIG_SERIAL_MAX3100 is not set
>> # CONFIG_SERIAL_MAX310X is not set
>> # CONFIG_SERIAL_UARTLITE is not set
>> CONFIG_SERIAL_CORE=y
>> CONFIG_SERIAL_CORE_CONSOLE=y
>> # CONFIG_SERIAL_JSM is not set
>> # CONFIG_SERIAL_SCCNXP is not set
>> # CONFIG_SERIAL_SC16IS7XX is not set
>> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
>> # CONFIG_SERIAL_ALTERA_UART is not set
>> # CONFIG_SERIAL_IFX6X60 is not set
>> # CONFIG_SERIAL_ARC is not set
>> # CONFIG_SERIAL_RP2 is not set
>> # CONFIG_SERIAL_FSL_LPUART is not set
>> # CONFIG_SERIAL_MEN_Z135 is not set
>> CONFIG_SERIAL_DEV_BUS=m
>> # CONFIG_TTY_PRINTK is not set
>> # CONFIG_VIRTIO_CONSOLE is not set
>> CONFIG_IPMI_HANDLER=m
>> CONFIG_IPMI_DMI_DECODE=y
>> CONFIG_IPMI_PANIC_EVENT=y
>> # CONFIG_IPMI_PANIC_STRING is not set
>> # CONFIG_IPMI_DEVICE_INTERFACE is not set
>> CONFIG_IPMI_SI=m
>> # CONFIG_IPMI_SSIF is not set
>> # CONFIG_IPMI_WATCHDOG is not set
>> CONFIG_IPMI_POWEROFF=m
>> # CONFIG_HW_RANDOM is not set
>> # CONFIG_NVRAM is not set
>> # CONFIG_R3964 is not set
>> # CONFIG_APPLICOM is not set
>>
>> #
>> # PCMCIA character devices
>> #
>> # CONFIG_SYNCLINK_CS is not set
>> CONFIG_CARDMAN_4000=m
>> CONFIG_CARDMAN_4040=m
>> CONFIG_SCR24X=m
>> # CONFIG_IPWIRELESS is not set
>> # CONFIG_MWAVE is not set
>> # CONFIG_RAW_DRIVER is not set
>> # CONFIG_HPET is not set
>> CONFIG_HANGCHECK_TIMER=y
>> CONFIG_TCG_TPM=y
>> CONFIG_TCG_TIS_CORE=y
>> CONFIG_TCG_TIS=y
>> CONFIG_TCG_TIS_SPI=m
>> CONFIG_TCG_TIS_I2C_ATMEL=y
>> CONFIG_TCG_TIS_I2C_INFINEON=m
>> CONFIG_TCG_TIS_I2C_NUVOTON=y
>> CONFIG_TCG_NSC=y
>> CONFIG_TCG_ATMEL=m
>> # CONFIG_TCG_INFINEON is not set
>> # CONFIG_TCG_CRB is not set
>> CONFIG_TCG_VTPM_PROXY=y
>> CONFIG_TCG_TIS_ST33ZP24=m
>> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
>> CONFIG_TCG_TIS_ST33ZP24_SPI=m
>> CONFIG_TELCLOCK=y
>> CONFIG_DEVPORT=y
>> # CONFIG_XILLYBUS is not set
>>
>> #
>> # I2C support
>> #
>> CONFIG_I2C=y
>> CONFIG_ACPI_I2C_OPREGION=y
>> CONFIG_I2C_BOARDINFO=y
>> CONFIG_I2C_COMPAT=y
>> CONFIG_I2C_CHARDEV=m
>> CONFIG_I2C_MUX=y
>>
>> #
>> # Multiplexer I2C Chip support
>> #
>> CONFIG_I2C_MUX_GPIO=m
>> CONFIG_I2C_MUX_LTC4306=m
>> # CONFIG_I2C_MUX_PCA9541 is not set
>> CONFIG_I2C_MUX_PCA954x=m
>> CONFIG_I2C_MUX_REG=m
>> CONFIG_I2C_MUX_MLXCPLD=y
>> CONFIG_I2C_HELPER_AUTO=y
>> CONFIG_I2C_ALGOBIT=y
>>
>> #
>> # I2C Hardware Bus support
>> #
>>
>> #
>> # PC SMBus host controller drivers
>> #
>> # CONFIG_I2C_ALI1535 is not set
>> # CONFIG_I2C_ALI1563 is not set
>> # CONFIG_I2C_ALI15X3 is not set
>> # CONFIG_I2C_AMD756 is not set
>> # CONFIG_I2C_AMD8111 is not set
>> # CONFIG_I2C_I801 is not set
>> # CONFIG_I2C_ISCH is not set
>> # CONFIG_I2C_ISMT is not set
>> # CONFIG_I2C_PIIX4 is not set
>> # CONFIG_I2C_NFORCE2 is not set
>> # CONFIG_I2C_SIS5595 is not set
>> # CONFIG_I2C_SIS630 is not set
>> # CONFIG_I2C_SIS96X is not set
>> # CONFIG_I2C_VIA is not set
>> # CONFIG_I2C_VIAPRO is not set
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_I2C_SCMI is not set
>>
>> #
>> # I2C system bus drivers (mostly embedded / system-on-chip)
>> #
>> # CONFIG_I2C_CBUS_GPIO is not set
>> CONFIG_I2C_DESIGNWARE_CORE=y
>> CONFIG_I2C_DESIGNWARE_PLATFORM=y
>> CONFIG_I2C_DESIGNWARE_SLAVE=y
>> # CONFIG_I2C_DESIGNWARE_PCI is not set
>> # CONFIG_I2C_EMEV2 is not set
>> CONFIG_I2C_GPIO=y
>> CONFIG_I2C_GPIO_FAULT_INJECTOR=y
>> # CONFIG_I2C_OCORES is not set
>> # CONFIG_I2C_PCA_PLATFORM is not set
>> # CONFIG_I2C_SIMTEC is not set
>> CONFIG_I2C_XILINX=m
>>
>> #
>> # External I2C/SMBus adapter drivers
>> #
>> # CONFIG_I2C_PARPORT_LIGHT is not set
>> # CONFIG_I2C_TAOS_EVM is not set
>>
>> #
>> # Other I2C/SMBus bus drivers
>> #
>> CONFIG_I2C_MLXCPLD=y
>> CONFIG_I2C_STUB=m
>> CONFIG_I2C_SLAVE=y
>> # CONFIG_I2C_SLAVE_EEPROM is not set
>> # CONFIG_I2C_DEBUG_CORE is not set
>> # CONFIG_I2C_DEBUG_ALGO is not set
>> # CONFIG_I2C_DEBUG_BUS is not set
>> CONFIG_SPI=y
>> # CONFIG_SPI_DEBUG is not set
>> CONFIG_SPI_MASTER=y
>> CONFIG_SPI_MEM=y
>>
>> #
>> # SPI Master Controller Drivers
>> #
>> # CONFIG_SPI_ALTERA is not set
>> CONFIG_SPI_AXI_SPI_ENGINE=m
>> CONFIG_SPI_BITBANG=y
>> CONFIG_SPI_CADENCE=y
>> # CONFIG_SPI_DESIGNWARE is not set
>> CONFIG_SPI_GPIO=y
>> CONFIG_SPI_OC_TINY=y
>> # CONFIG_SPI_PXA2XX is not set
>> CONFIG_SPI_ROCKCHIP=y
>> CONFIG_SPI_SC18IS602=y
>> # CONFIG_SPI_XCOMM is not set
>> CONFIG_SPI_XILINX=y
>> CONFIG_SPI_ZYNQMP_GQSPI=y
>>
>> #
>> # SPI Protocol Masters
>> #
>> CONFIG_SPI_SPIDEV=m
>> CONFIG_SPI_LOOPBACK_TEST=m
>> CONFIG_SPI_TLE62X0=m
>> # CONFIG_SPI_SLAVE is not set
>> CONFIG_SPMI=y
>> CONFIG_HSI=m
>> CONFIG_HSI_BOARDINFO=y
>>
>> #
>> # HSI controllers
>> #
>>
>> #
>> # HSI clients
>> #
>> CONFIG_HSI_CHAR=m
>> # CONFIG_PPS is not set
>>
>> #
>> # PTP clock support
>> #
>>
>> #
>> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
>> #
>> # CONFIG_PINCTRL is not set
>> CONFIG_GPIOLIB=y
>> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
>> CONFIG_GPIO_ACPI=y
>> CONFIG_GPIOLIB_IRQCHIP=y
>> # CONFIG_DEBUG_GPIO is not set
>> CONFIG_GPIO_SYSFS=y
>> CONFIG_GPIO_GENERIC=m
>> CONFIG_GPIO_MAX730X=y
>>
>> #
>> # Memory mapped GPIO drivers
>> #
>> # CONFIG_GPIO_AMDPT is not set
>> CONFIG_GPIO_DWAPB=m
>> # CONFIG_GPIO_EXAR is not set
>> CONFIG_GPIO_GENERIC_PLATFORM=m
>> # CONFIG_GPIO_ICH is not set
>> # CONFIG_GPIO_LYNXPOINT is not set
>> CONFIG_GPIO_MB86S7X=y
>> CONFIG_GPIO_MENZ127=m
>> CONFIG_GPIO_MOCKUP=y
>> # CONFIG_GPIO_VX855 is not set
>>
>> #
>> # Port-mapped I/O GPIO drivers
>> #
>> CONFIG_GPIO_F7188X=y
>> CONFIG_GPIO_IT87=m
>> # CONFIG_GPIO_SCH is not set
>> CONFIG_GPIO_SCH311X=y
>> CONFIG_GPIO_WINBOND=m
>> CONFIG_GPIO_WS16C48=y
>>
>> #
>> # I2C GPIO expanders
>> #
>> CONFIG_GPIO_ADP5588=y
>> CONFIG_GPIO_ADP5588_IRQ=y
>> # CONFIG_GPIO_MAX7300 is not set
>> CONFIG_GPIO_MAX732X=y
>> CONFIG_GPIO_MAX732X_IRQ=y
>> CONFIG_GPIO_PCA953X=y
>> # CONFIG_GPIO_PCA953X_IRQ is not set
>> CONFIG_GPIO_PCF857X=m
>> CONFIG_GPIO_TPIC2810=y
>>
>> #
>> # MFD GPIO expanders
>> #
>> CONFIG_GPIO_ADP5520=y
>> CONFIG_GPIO_ARIZONA=y
>> CONFIG_GPIO_BD9571MWV=m
>> CONFIG_GPIO_DA9052=y
>> CONFIG_GPIO_LP873X=m
>> CONFIG_GPIO_TPS65086=y
>> # CONFIG_GPIO_TWL4030 is not set
>> # CONFIG_GPIO_TWL6040 is not set
>> CONFIG_GPIO_UCB1400=y
>> CONFIG_GPIO_WM831X=m
>> CONFIG_GPIO_WM8994=y
>>
>> #
>> # PCI GPIO expanders
>> #
>> # CONFIG_GPIO_AMD8111 is not set
>> # CONFIG_GPIO_BT8XX is not set
>> # CONFIG_GPIO_ML_IOH is not set
>> # CONFIG_GPIO_PCI_IDIO_16 is not set
>> # CONFIG_GPIO_PCIE_IDIO_24 is not set
>> # CONFIG_GPIO_RDC321X is not set
>>
>> #
>> # SPI GPIO expanders
>> #
>> CONFIG_GPIO_MAX3191X=y
>> CONFIG_GPIO_MAX7301=y
>> CONFIG_GPIO_MC33880=y
>> CONFIG_GPIO_PISOSR=m
>> CONFIG_GPIO_XRA1403=y
>> CONFIG_W1=y
>>
>> #
>> # 1-wire Bus Masters
>> #
>> # CONFIG_W1_MASTER_MATROX is not set
>> # CONFIG_W1_MASTER_DS2482 is not set
>> # CONFIG_W1_MASTER_DS1WM is not set
>> CONFIG_W1_MASTER_GPIO=y
>>
>> #
>> # 1-wire Slaves
>> #
>> CONFIG_W1_SLAVE_THERM=y
>> CONFIG_W1_SLAVE_SMEM=y
>> # CONFIG_W1_SLAVE_DS2405 is not set
>> # CONFIG_W1_SLAVE_DS2408 is not set
>> CONFIG_W1_SLAVE_DS2413=m
>> CONFIG_W1_SLAVE_DS2406=m
>> CONFIG_W1_SLAVE_DS2423=y
>> CONFIG_W1_SLAVE_DS2805=m
>> # CONFIG_W1_SLAVE_DS2431 is not set
>> CONFIG_W1_SLAVE_DS2433=m
>> # CONFIG_W1_SLAVE_DS2433_CRC is not set
>> CONFIG_W1_SLAVE_DS2438=y
>> # CONFIG_W1_SLAVE_DS2760 is not set
>> CONFIG_W1_SLAVE_DS2780=y
>> CONFIG_W1_SLAVE_DS2781=y
>> CONFIG_W1_SLAVE_DS28E04=y
>> # CONFIG_W1_SLAVE_DS28E17 is not set
>> CONFIG_POWER_AVS=y
>> CONFIG_POWER_RESET=y
>> CONFIG_POWER_RESET_RESTART=y
>> CONFIG_POWER_SUPPLY=y
>> CONFIG_POWER_SUPPLY_DEBUG=y
>> # CONFIG_PDA_POWER is not set
>> # CONFIG_GENERIC_ADC_BATTERY is not set
>> CONFIG_MAX8925_POWER=m
>> # CONFIG_WM831X_BACKUP is not set
>> CONFIG_WM831X_POWER=m
>> # CONFIG_TEST_POWER is not set
>> CONFIG_BATTERY_88PM860X=y
>> CONFIG_BATTERY_DS2780=y
>> CONFIG_BATTERY_DS2781=y
>> CONFIG_BATTERY_DS2782=y
>> CONFIG_BATTERY_SBS=m
>> CONFIG_CHARGER_SBS=m
>> # CONFIG_MANAGER_SBS is not set
>> CONFIG_BATTERY_BQ27XXX=m
>> CONFIG_BATTERY_BQ27XXX_I2C=m
>> CONFIG_BATTERY_BQ27XXX_HDQ=m
>> CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
>> CONFIG_BATTERY_DA9052=y
>> CONFIG_BATTERY_MAX17040=y
>> # CONFIG_BATTERY_MAX17042 is not set
>> CONFIG_BATTERY_MAX1721X=y
>> # CONFIG_CHARGER_88PM860X is not set
>> CONFIG_CHARGER_MAX8903=y
>> CONFIG_CHARGER_TWL4030=m
>> CONFIG_CHARGER_LP8727=y
>> # CONFIG_CHARGER_GPIO is not set
>> CONFIG_CHARGER_MANAGER=y
>> CONFIG_CHARGER_LTC3651=m
>> # CONFIG_CHARGER_MAX14577 is not set
>> CONFIG_CHARGER_MAX77693=m
>> # CONFIG_CHARGER_MAX8997 is not set
>> CONFIG_CHARGER_MAX8998=y
>> CONFIG_CHARGER_BQ2415X=m
>> CONFIG_CHARGER_BQ24190=y
>> CONFIG_CHARGER_BQ24257=y
>> # CONFIG_CHARGER_BQ24735 is not set
>> CONFIG_CHARGER_BQ25890=m
>> # CONFIG_CHARGER_SMB347 is not set
>> # CONFIG_CHARGER_TPS65090 is not set
>> CONFIG_BATTERY_GAUGE_LTC2941=m
>> # CONFIG_BATTERY_RT5033 is not set
>> CONFIG_CHARGER_RT9455=y
>> CONFIG_HWMON=m
>> CONFIG_HWMON_VID=m
>> CONFIG_HWMON_DEBUG_CHIP=y
>>
>> #
>> # Native drivers
>> #
>> # CONFIG_SENSORS_ABITUGURU is not set
>> CONFIG_SENSORS_ABITUGURU3=m
>> CONFIG_SENSORS_AD7314=m
>> CONFIG_SENSORS_AD7414=m
>> CONFIG_SENSORS_AD7418=m
>> CONFIG_SENSORS_ADM1021=m
>> CONFIG_SENSORS_ADM1025=m
>> # CONFIG_SENSORS_ADM1026 is not set
>> # CONFIG_SENSORS_ADM1029 is not set
>> CONFIG_SENSORS_ADM1031=m
>> CONFIG_SENSORS_ADM9240=m
>> CONFIG_SENSORS_ADT7X10=m
>> CONFIG_SENSORS_ADT7310=m
>> CONFIG_SENSORS_ADT7410=m
>> CONFIG_SENSORS_ADT7411=m
>> CONFIG_SENSORS_ADT7462=m
>> CONFIG_SENSORS_ADT7470=m
>> # CONFIG_SENSORS_ADT7475 is not set
>> CONFIG_SENSORS_ASC7621=m
>> # CONFIG_SENSORS_K8TEMP is not set
>> # CONFIG_SENSORS_K10TEMP is not set
>> # CONFIG_SENSORS_FAM15H_POWER is not set
>> CONFIG_SENSORS_APPLESMC=m
>> CONFIG_SENSORS_ASB100=m
>> # CONFIG_SENSORS_ASPEED is not set
>> CONFIG_SENSORS_ATXP1=m
>> CONFIG_SENSORS_DS620=m
>> # CONFIG_SENSORS_DS1621 is not set
>> CONFIG_SENSORS_DELL_SMM=m
>> CONFIG_SENSORS_DA9052_ADC=m
>> # CONFIG_SENSORS_I5K_AMB is not set
>> CONFIG_SENSORS_F71805F=m
>> # CONFIG_SENSORS_F71882FG is not set
>> CONFIG_SENSORS_F75375S=m
>> CONFIG_SENSORS_MC13783_ADC=m
>> CONFIG_SENSORS_FSCHMD=m
>> # CONFIG_SENSORS_GL518SM is not set
>> CONFIG_SENSORS_GL520SM=m
>> CONFIG_SENSORS_G760A=m
>> # CONFIG_SENSORS_G762 is not set
>> CONFIG_SENSORS_HIH6130=m
>> CONFIG_SENSORS_IBMAEM=m
>> # CONFIG_SENSORS_IBMPEX is not set
>> # CONFIG_SENSORS_IIO_HWMON is not set
>> # CONFIG_SENSORS_I5500 is not set
>> # CONFIG_SENSORS_CORETEMP is not set
>> CONFIG_SENSORS_IT87=m
>> CONFIG_SENSORS_JC42=m
>> CONFIG_SENSORS_POWR1220=m
>> CONFIG_SENSORS_LINEAGE=m
>> # CONFIG_SENSORS_LTC2945 is not set
>> # CONFIG_SENSORS_LTC2990 is not set
>> # CONFIG_SENSORS_LTC4151 is not set
>> CONFIG_SENSORS_LTC4215=m
>> CONFIG_SENSORS_LTC4222=m
>> CONFIG_SENSORS_LTC4245=m
>> CONFIG_SENSORS_LTC4260=m
>> CONFIG_SENSORS_LTC4261=m
>> # CONFIG_SENSORS_MAX1111 is not set
>> CONFIG_SENSORS_MAX16065=m
>> CONFIG_SENSORS_MAX1619=m
>> # CONFIG_SENSORS_MAX1668 is not set
>> CONFIG_SENSORS_MAX197=m
>> # CONFIG_SENSORS_MAX31722 is not set
>> CONFIG_SENSORS_MAX6621=m
>> # CONFIG_SENSORS_MAX6639 is not set
>> CONFIG_SENSORS_MAX6642=m
>> CONFIG_SENSORS_MAX6650=m
>> # CONFIG_SENSORS_MAX6697 is not set
>> # CONFIG_SENSORS_MAX31790 is not set
>> CONFIG_SENSORS_MCP3021=m
>> CONFIG_SENSORS_TC654=m
>> CONFIG_SENSORS_MENF21BMC_HWMON=m
>> # CONFIG_SENSORS_ADCXX is not set
>> # CONFIG_SENSORS_LM63 is not set
>> CONFIG_SENSORS_LM70=m
>> CONFIG_SENSORS_LM73=m
>> # CONFIG_SENSORS_LM75 is not set
>> CONFIG_SENSORS_LM77=m
>> # CONFIG_SENSORS_LM78 is not set
>> # CONFIG_SENSORS_LM80 is not set
>> CONFIG_SENSORS_LM83=m
>> # CONFIG_SENSORS_LM85 is not set
>> CONFIG_SENSORS_LM87=m
>> CONFIG_SENSORS_LM90=m
>> CONFIG_SENSORS_LM92=m
>> CONFIG_SENSORS_LM93=m
>> CONFIG_SENSORS_LM95234=m
>> CONFIG_SENSORS_LM95241=m
>> # CONFIG_SENSORS_LM95245 is not set
>> CONFIG_SENSORS_PC87360=m
>> CONFIG_SENSORS_PC87427=m
>> CONFIG_SENSORS_NTC_THERMISTOR=m
>> # CONFIG_SENSORS_NCT6683 is not set
>> CONFIG_SENSORS_NCT6775=m
>> CONFIG_SENSORS_NCT7802=m
>> # CONFIG_SENSORS_NCT7904 is not set
>> CONFIG_SENSORS_PCF8591=m
>> CONFIG_PMBUS=m
>> CONFIG_SENSORS_PMBUS=m
>> CONFIG_SENSORS_ADM1275=m
>> # CONFIG_SENSORS_IBM_CFFPS is not set
>> CONFIG_SENSORS_IR35221=m
>> CONFIG_SENSORS_LM25066=m
>> CONFIG_SENSORS_LTC2978=m
>> CONFIG_SENSORS_LTC2978_REGULATOR=y
>> # CONFIG_SENSORS_LTC3815 is not set
>> # CONFIG_SENSORS_MAX16064 is not set
>> # CONFIG_SENSORS_MAX20751 is not set
>> # CONFIG_SENSORS_MAX31785 is not set
>> # CONFIG_SENSORS_MAX34440 is not set
>> CONFIG_SENSORS_MAX8688=m
>> CONFIG_SENSORS_TPS40422=m
>> CONFIG_SENSORS_TPS53679=m
>> # CONFIG_SENSORS_UCD9000 is not set
>> # CONFIG_SENSORS_UCD9200 is not set
>> # CONFIG_SENSORS_ZL6100 is not set
>> # CONFIG_SENSORS_SHT15 is not set
>> CONFIG_SENSORS_SHT21=m
>> # CONFIG_SENSORS_SHT3x is not set
>> # CONFIG_SENSORS_SHTC1 is not set
>> # CONFIG_SENSORS_SIS5595 is not set
>> CONFIG_SENSORS_DME1737=m
>> # CONFIG_SENSORS_EMC1403 is not set
>> CONFIG_SENSORS_EMC2103=m
>> CONFIG_SENSORS_EMC6W201=m
>> CONFIG_SENSORS_SMSC47M1=m
>> CONFIG_SENSORS_SMSC47M192=m
>> # CONFIG_SENSORS_SMSC47B397 is not set
>> CONFIG_SENSORS_STTS751=m
>> CONFIG_SENSORS_SMM665=m
>> CONFIG_SENSORS_ADC128D818=m
>> # CONFIG_SENSORS_ADS1015 is not set
>> # CONFIG_SENSORS_ADS7828 is not set
>> # CONFIG_SENSORS_ADS7871 is not set
>> # CONFIG_SENSORS_AMC6821 is not set
>> CONFIG_SENSORS_INA209=m
>> CONFIG_SENSORS_INA2XX=m
>> # CONFIG_SENSORS_INA3221 is not set
>> # CONFIG_SENSORS_TC74 is not set
>> # CONFIG_SENSORS_THMC50 is not set
>> CONFIG_SENSORS_TMP102=m
>> # CONFIG_SENSORS_TMP103 is not set
>> CONFIG_SENSORS_TMP108=m
>> CONFIG_SENSORS_TMP401=m
>> CONFIG_SENSORS_TMP421=m
>> # CONFIG_SENSORS_VIA_CPUTEMP is not set
>> # CONFIG_SENSORS_VIA686A is not set
>> CONFIG_SENSORS_VT1211=m
>> # CONFIG_SENSORS_VT8231 is not set
>> CONFIG_SENSORS_W83773G=m
>> CONFIG_SENSORS_W83781D=m
>> CONFIG_SENSORS_W83791D=m
>> CONFIG_SENSORS_W83792D=m
>> CONFIG_SENSORS_W83793=m
>> # CONFIG_SENSORS_W83795 is not set
>> CONFIG_SENSORS_W83L785TS=m
>> CONFIG_SENSORS_W83L786NG=m
>> # CONFIG_SENSORS_W83627HF is not set
>> CONFIG_SENSORS_W83627EHF=m
>> CONFIG_SENSORS_WM831X=m
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_SENSORS_ACPI_POWER is not set
>> # CONFIG_SENSORS_ATK0110 is not set
>> CONFIG_THERMAL=y
>> # CONFIG_THERMAL_STATISTICS is not set
>> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
>> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
>> CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
>> CONFIG_THERMAL_GOV_FAIR_SHARE=y
>> CONFIG_THERMAL_GOV_STEP_WISE=y
>> CONFIG_THERMAL_GOV_BANG_BANG=y
>> CONFIG_THERMAL_GOV_USER_SPACE=y
>> CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
>> # CONFIG_CLOCK_THERMAL is not set
>> # CONFIG_DEVFREQ_THERMAL is not set
>> CONFIG_THERMAL_EMULATION=y
>> CONFIG_INTEL_POWERCLAMP=m
>> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>>
>> #
>> # ACPI INT340X thermal drivers
>> #
>> # CONFIG_INT340X_THERMAL is not set
>> # CONFIG_INTEL_PCH_THERMAL is not set
>> CONFIG_GENERIC_ADC_THERMAL=m
>> # CONFIG_WATCHDOG is not set
>> CONFIG_SSB_POSSIBLE=y
>> # CONFIG_SSB is not set
>> CONFIG_BCMA_POSSIBLE=y
>> # CONFIG_BCMA is not set
>>
>> #
>> # Multifunction device drivers
>> #
>> CONFIG_MFD_CORE=y
>> # CONFIG_MFD_AS3711 is not set
>> CONFIG_PMIC_ADP5520=y
>> # CONFIG_MFD_AAT2870_CORE is not set
>> # CONFIG_MFD_BCM590XX is not set
>> CONFIG_MFD_BD9571MWV=m
>> # CONFIG_MFD_AXP20X_I2C is not set
>> # CONFIG_MFD_CROS_EC is not set
>> # CONFIG_PMIC_DA903X is not set
>> CONFIG_PMIC_DA9052=y
>> CONFIG_MFD_DA9052_SPI=y
>> CONFIG_MFD_DA9052_I2C=y
>> # CONFIG_MFD_DA9055 is not set
>> CONFIG_MFD_DA9062=m
>> CONFIG_MFD_DA9063=m
>> # CONFIG_MFD_DA9150 is not set
>> CONFIG_MFD_MC13XXX=y
>> CONFIG_MFD_MC13XXX_SPI=y
>> CONFIG_MFD_MC13XXX_I2C=y
>> CONFIG_HTC_PASIC3=y
>> # CONFIG_HTC_I2CPLD is not set
>> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
>> # CONFIG_LPC_ICH is not set
>> # CONFIG_LPC_SCH is not set
>> # CONFIG_INTEL_SOC_PMIC is not set
>> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
>> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
>> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
>> # CONFIG_MFD_INTEL_LPSS_PCI is not set
>> # CONFIG_MFD_JANZ_CMODIO is not set
>> # CONFIG_MFD_KEMPLD is not set
>> CONFIG_MFD_88PM800=m
>> # CONFIG_MFD_88PM805 is not set
>> CONFIG_MFD_88PM860X=y
>> CONFIG_MFD_MAX14577=y
>> CONFIG_MFD_MAX77693=m
>> # CONFIG_MFD_MAX77843 is not set
>> CONFIG_MFD_MAX8907=y
>> CONFIG_MFD_MAX8925=y
>> CONFIG_MFD_MAX8997=y
>> CONFIG_MFD_MAX8998=y
>> CONFIG_MFD_MT6397=y
>> CONFIG_MFD_MENF21BMC=m
>> CONFIG_EZX_PCAP=y
>> CONFIG_MFD_RETU=m
>> # CONFIG_MFD_PCF50633 is not set
>> CONFIG_UCB1400_CORE=y
>> # CONFIG_MFD_RDC321X is not set
>> CONFIG_MFD_RT5033=m
>> # CONFIG_MFD_RC5T583 is not set
>> CONFIG_MFD_SEC_CORE=y
>> CONFIG_MFD_SI476X_CORE=y
>> # CONFIG_MFD_SM501 is not set
>> CONFIG_MFD_SKY81452=y
>> CONFIG_MFD_SMSC=y
>> CONFIG_ABX500_CORE=y
>> # CONFIG_AB3100_CORE is not set
>> CONFIG_MFD_SYSCON=y
>> CONFIG_MFD_TI_AM335X_TSCADC=y
>> # CONFIG_MFD_LP3943 is not set
>> # CONFIG_MFD_LP8788 is not set
>> CONFIG_MFD_TI_LMU=m
>> # CONFIG_MFD_PALMAS is not set
>> CONFIG_TPS6105X=m
>> # CONFIG_TPS65010 is not set
>> CONFIG_TPS6507X=y
>> CONFIG_MFD_TPS65086=y
>> CONFIG_MFD_TPS65090=y
>> # CONFIG_MFD_TPS68470 is not set
>> CONFIG_MFD_TI_LP873X=y
>> # CONFIG_MFD_TPS6586X is not set
>> # CONFIG_MFD_TPS65910 is not set
>> # CONFIG_MFD_TPS65912_I2C is not set
>> # CONFIG_MFD_TPS65912_SPI is not set
>> CONFIG_MFD_TPS80031=y
>> CONFIG_TWL4030_CORE=y
>> CONFIG_MFD_TWL4030_AUDIO=y
>> CONFIG_TWL6040_CORE=y
>> CONFIG_MFD_WL1273_CORE=y
>> CONFIG_MFD_LM3533=y
>> # CONFIG_MFD_VX855 is not set
>> CONFIG_MFD_ARIZONA=y
>> CONFIG_MFD_ARIZONA_I2C=m
>> # CONFIG_MFD_ARIZONA_SPI is not set
>> CONFIG_MFD_CS47L24=y
>> CONFIG_MFD_WM5102=y
>> # CONFIG_MFD_WM5110 is not set
>> CONFIG_MFD_WM8997=y
>> # CONFIG_MFD_WM8998 is not set
>> # CONFIG_MFD_WM8400 is not set
>> CONFIG_MFD_WM831X=y
>> CONFIG_MFD_WM831X_I2C=y
>> CONFIG_MFD_WM831X_SPI=y
>> # CONFIG_MFD_WM8350_I2C is not set
>> CONFIG_MFD_WM8994=y
>> # CONFIG_RAVE_SP_CORE is not set
>> CONFIG_REGULATOR=y
>> CONFIG_REGULATOR_DEBUG=y
>> CONFIG_REGULATOR_FIXED_VOLTAGE=m
>> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
>> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
>> CONFIG_REGULATOR_88PG86X=m
>> # CONFIG_REGULATOR_88PM800 is not set
>> CONFIG_REGULATOR_88PM8607=y
>> CONFIG_REGULATOR_ACT8865=m
>> # CONFIG_REGULATOR_AD5398 is not set
>> # CONFIG_REGULATOR_ANATOP is not set
>> CONFIG_REGULATOR_ARIZONA_LDO1=y
>> CONFIG_REGULATOR_ARIZONA_MICSUPP=y
>> # CONFIG_REGULATOR_BD9571MWV is not set
>> CONFIG_REGULATOR_DA9052=m
>> # CONFIG_REGULATOR_DA9062 is not set
>> CONFIG_REGULATOR_DA9063=m
>> CONFIG_REGULATOR_DA9210=m
>> CONFIG_REGULATOR_DA9211=m
>> CONFIG_REGULATOR_FAN53555=m
>> CONFIG_REGULATOR_GPIO=y
>> CONFIG_REGULATOR_ISL9305=m
>> CONFIG_REGULATOR_ISL6271A=y
>> CONFIG_REGULATOR_LM363X=m
>> CONFIG_REGULATOR_LP3971=y
>> # CONFIG_REGULATOR_LP3972 is not set
>> CONFIG_REGULATOR_LP872X=m
>> # CONFIG_REGULATOR_LP8755 is not set
>> CONFIG_REGULATOR_LTC3589=m
>> # CONFIG_REGULATOR_LTC3676 is not set
>> CONFIG_REGULATOR_MAX14577=y
>> CONFIG_REGULATOR_MAX1586=y
>> # CONFIG_REGULATOR_MAX8649 is not set
>> CONFIG_REGULATOR_MAX8660=y
>> CONFIG_REGULATOR_MAX8907=y
>> CONFIG_REGULATOR_MAX8925=y
>> # CONFIG_REGULATOR_MAX8952 is not set
>> CONFIG_REGULATOR_MAX8997=m
>> CONFIG_REGULATOR_MAX8998=y
>> CONFIG_REGULATOR_MAX77693=m
>> CONFIG_REGULATOR_MC13XXX_CORE=y
>> CONFIG_REGULATOR_MC13783=y
>> CONFIG_REGULATOR_MC13892=y
>> CONFIG_REGULATOR_MT6311=y
>> CONFIG_REGULATOR_MT6323=y
>> CONFIG_REGULATOR_MT6397=m
>> # CONFIG_REGULATOR_PCAP is not set
>> CONFIG_REGULATOR_PFUZE100=m
>> # CONFIG_REGULATOR_PV88060 is not set
>> # CONFIG_REGULATOR_PV88080 is not set
>> CONFIG_REGULATOR_PV88090=y
>> # CONFIG_REGULATOR_PWM is not set
>> # CONFIG_REGULATOR_QCOM_SPMI is not set
>> CONFIG_REGULATOR_RT5033=m
>> CONFIG_REGULATOR_S2MPA01=m
>> CONFIG_REGULATOR_S2MPS11=y
>> # CONFIG_REGULATOR_S5M8767 is not set
>> # CONFIG_REGULATOR_SKY81452 is not set
>> CONFIG_REGULATOR_TPS51632=m
>> # CONFIG_REGULATOR_TPS6105X is not set
>> CONFIG_REGULATOR_TPS62360=m
>> CONFIG_REGULATOR_TPS65023=m
>> CONFIG_REGULATOR_TPS6507X=y
>> # CONFIG_REGULATOR_TPS65086 is not set
>> CONFIG_REGULATOR_TPS65090=m
>> CONFIG_REGULATOR_TPS65132=m
>> # CONFIG_REGULATOR_TPS6524X is not set
>> CONFIG_REGULATOR_TPS80031=m
>> CONFIG_REGULATOR_TWL4030=y
>> # CONFIG_REGULATOR_WM831X is not set
>> CONFIG_REGULATOR_WM8994=y
>> CONFIG_CEC_CORE=m
>> CONFIG_CEC_PIN=y
>> CONFIG_RC_CORE=m
>> CONFIG_RC_MAP=m
>> # CONFIG_LIRC is not set
>> # CONFIG_RC_DECODERS is not set
>> CONFIG_RC_DEVICES=y
>> # CONFIG_RC_ATI_REMOTE is not set
>> CONFIG_IR_ENE=m
>> # CONFIG_IR_IMON is not set
>> # CONFIG_IR_IMON_RAW is not set
>> # CONFIG_IR_MCEUSB is not set
>> CONFIG_IR_ITE_CIR=m
>> CONFIG_IR_FINTEK=m
>> # CONFIG_IR_NUVOTON is not set
>> # CONFIG_IR_REDRAT3 is not set
>> # CONFIG_IR_STREAMZAP is not set
>> CONFIG_IR_WINBOND_CIR=m
>> # CONFIG_IR_IGORPLUGUSB is not set
>> # CONFIG_IR_IGUANA is not set
>> # CONFIG_IR_TTUSBIR is not set
>> CONFIG_RC_LOOPBACK=m
>> CONFIG_IR_SERIAL=m
>> # CONFIG_IR_SERIAL_TRANSMITTER is not set
>> CONFIG_IR_SIR=m
>> CONFIG_MEDIA_SUPPORT=m
>>
>> #
>> # Multimedia core support
>> #
>> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
>> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
>> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
>> CONFIG_MEDIA_RADIO_SUPPORT=y
>> # CONFIG_MEDIA_SDR_SUPPORT is not set
>> CONFIG_MEDIA_CEC_SUPPORT=y
>> # CONFIG_MEDIA_CEC_RC is not set
>> # CONFIG_CEC_PIN_ERROR_INJ is not set
>> # CONFIG_MEDIA_CONTROLLER is not set
>> CONFIG_VIDEO_DEV=m
>> CONFIG_VIDEO_V4L2=m
>> # CONFIG_VIDEO_ADV_DEBUG is not set
>> CONFIG_VIDEO_FIXED_MINOR_RANGES=y
>> CONFIG_DVB_CORE=m
>> CONFIG_DVB_MMAP=y
>> CONFIG_DVB_NET=y
>> CONFIG_DVB_MAX_ADAPTERS=16
>> # CONFIG_DVB_DYNAMIC_MINORS is not set
>> CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
>> # CONFIG_DVB_ULE_DEBUG is not set
>>
>> #
>> # Media drivers
>> #
>> # CONFIG_MEDIA_PCI_SUPPORT is not set
>> # CONFIG_DVB_PLATFORM_DRIVERS is not set
>> CONFIG_CEC_PLATFORM_DRIVERS=y
>> CONFIG_CEC_GPIO=m
>>
>> #
>> # Supported MMC/SDIO adapters
>> #
>> CONFIG_SMS_SDIO_DRV=m
>> # CONFIG_RADIO_ADAPTERS is not set
>>
>> #
>> # Supported FireWire (IEEE 1394) Adapters
>> #
>> CONFIG_DVB_FIREDTV=m
>> CONFIG_DVB_FIREDTV_INPUT=y
>> CONFIG_MEDIA_COMMON_OPTIONS=y
>>
>> #
>> # common driver options
>> #
>> CONFIG_VIDEOBUF2_CORE=m
>> CONFIG_VIDEOBUF2_V4L2=m
>> CONFIG_VIDEOBUF2_MEMOPS=m
>> CONFIG_VIDEOBUF2_VMALLOC=m
>> CONFIG_SMS_SIANO_MDTV=m
>> CONFIG_SMS_SIANO_RC=y
>>
>> #
>> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
>> #
>> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
>> CONFIG_MEDIA_ATTACH=y
>> CONFIG_VIDEO_IR_I2C=m
>>
>> #
>> # Audio decoders, processors and mixers
>> #
>>
>> #
>> # RDS decoders
>> #
>>
>> #
>> # Video decoders
>> #
>>
>> #
>> # Video and audio decoders
>> #
>>
>> #
>> # Video encoders
>> #
>>
>> #
>> # Camera sensor devices
>> #
>>
>> #
>> # Flash devices
>> #
>>
>> #
>> # Video improvement chips
>> #
>>
>> #
>> # Audio/Video compression chips
>> #
>>
>> #
>> # SDR tuner chips
>> #
>>
>> #
>> # Miscellaneous helper chips
>> #
>>
>> #
>> # Sensors used on soc_camera driver
>> #
>>
>> #
>> # Media SPI Adapters
>> #
>> # CONFIG_CXD2880_SPI_DRV is not set
>> CONFIG_MEDIA_TUNER=m
>> CONFIG_MEDIA_TUNER_SIMPLE=m
>> CONFIG_MEDIA_TUNER_TDA8290=m
>> CONFIG_MEDIA_TUNER_TDA827X=m
>> CONFIG_MEDIA_TUNER_TDA18271=m
>> CONFIG_MEDIA_TUNER_TDA9887=m
>> CONFIG_MEDIA_TUNER_TEA5761=m
>> CONFIG_MEDIA_TUNER_TEA5767=m
>> CONFIG_MEDIA_TUNER_MT20XX=m
>> CONFIG_MEDIA_TUNER_XC2028=m
>> CONFIG_MEDIA_TUNER_XC5000=m
>> CONFIG_MEDIA_TUNER_XC4000=m
>> CONFIG_MEDIA_TUNER_MC44S803=m
>>
>> #
>> # Multistandard (satellite) frontends
>> #
>>
>> #
>> # Multistandard (cable + terrestrial) frontends
>> #
>>
>> #
>> # DVB-S (satellite) frontends
>> #
>>
>> #
>> # DVB-T (terrestrial) frontends
>> #
>>
>> #
>> # DVB-C (cable) frontends
>> #
>>
>> #
>> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
>> #
>>
>> #
>> # ISDB-T (terrestrial) frontends
>> #
>>
>> #
>> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
>> #
>>
>> #
>> # Digital terrestrial only tuners/PLL
>> #
>>
>> #
>> # SEC control devices for DVB-S
>> #
>>
>> #
>> # Common Interface (EN50221) controller drivers
>> #
>>
>> #
>> # Tools to develop new frontends
>> #
>>
>> #
>> # Graphics support
>> #
>> # CONFIG_AGP is not set
>> CONFIG_VGA_ARB=y
>> CONFIG_VGA_ARB_MAX_GPUS=16
>> # CONFIG_VGA_SWITCHEROO is not set
>> CONFIG_DRM=y
>> # CONFIG_DRM_DP_AUX_CHARDEV is not set
>> CONFIG_DRM_DEBUG_MM=y
>> # CONFIG_DRM_DEBUG_SELFTEST is not set
>> CONFIG_DRM_KMS_HELPER=y
>> CONFIG_DRM_KMS_FB_HELPER=y
>> # CONFIG_DRM_FBDEV_EMULATION is not set
>> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
>> CONFIG_DRM_TTM=m
>> CONFIG_DRM_GEM_CMA_HELPER=y
>> CONFIG_DRM_KMS_CMA_HELPER=y
>> CONFIG_DRM_VM=y
>>
>> #
>> # I2C encoder or helper chips
>> #
>> CONFIG_DRM_I2C_CH7006=y
>> # CONFIG_DRM_I2C_SIL164 is not set
>> CONFIG_DRM_I2C_NXP_TDA998X=y
>> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
>> # CONFIG_DRM_RADEON is not set
>> # CONFIG_DRM_AMDGPU is not set
>>
>> #
>> # ACP (Audio CoProcessor) Configuration
>> #
>>
>> #
>> # AMD Library routines
>> #
>> # CONFIG_DRM_NOUVEAU is not set
>> # CONFIG_DRM_I915 is not set
>> CONFIG_DRM_VGEM=y
>> # CONFIG_DRM_VMWGFX is not set
>> # CONFIG_DRM_GMA500 is not set
>> # CONFIG_DRM_UDL is not set
>> # CONFIG_DRM_AST is not set
>> # CONFIG_DRM_MGAG200 is not set
>> # CONFIG_DRM_CIRRUS_QEMU is not set
>> # CONFIG_DRM_QXL is not set
>> # CONFIG_DRM_BOCHS is not set
>> CONFIG_DRM_VIRTIO_GPU=m
>> CONFIG_DRM_PANEL=y
>>
>> #
>> # Display Panels
>> #
>> CONFIG_DRM_BRIDGE=y
>> CONFIG_DRM_PANEL_BRIDGE=y
>>
>> #
>> # Display Interface Bridges
>> #
>> CONFIG_DRM_ANALOGIX_ANX78XX=y
>> # CONFIG_DRM_HISI_HIBMC is not set
>> CONFIG_DRM_TINYDRM=m
>> CONFIG_TINYDRM_MIPI_DBI=m
>> # CONFIG_TINYDRM_ILI9225 is not set
>> CONFIG_TINYDRM_MI0283QT=m
>> CONFIG_TINYDRM_REPAPER=m
>> CONFIG_TINYDRM_ST7586=m
>> CONFIG_TINYDRM_ST7735R=m
>> CONFIG_DRM_LEGACY=y
>> # CONFIG_DRM_TDFX is not set
>> # CONFIG_DRM_R128 is not set
>> # CONFIG_DRM_MGA is not set
>> # CONFIG_DRM_VIA is not set
>> # CONFIG_DRM_SAVAGE is not set
>> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
>>
>> #
>> # Frame buffer Devices
>> #
>> CONFIG_FB=y
>> # CONFIG_FIRMWARE_EDID is not set
>> CONFIG_FB_CMDLINE=y
>> CONFIG_FB_NOTIFY=y
>> CONFIG_FB_CFB_FILLRECT=y
>> CONFIG_FB_CFB_COPYAREA=y
>> CONFIG_FB_CFB_IMAGEBLIT=y
>> CONFIG_FB_SYS_FILLRECT=y
>> CONFIG_FB_SYS_COPYAREA=y
>> CONFIG_FB_SYS_IMAGEBLIT=y
>> CONFIG_FB_FOREIGN_ENDIAN=y
>> CONFIG_FB_BOTH_ENDIAN=y
>> # CONFIG_FB_BIG_ENDIAN is not set
>> # CONFIG_FB_LITTLE_ENDIAN is not set
>> CONFIG_FB_SYS_FOPS=y
>> CONFIG_FB_DEFERRED_IO=y
>> CONFIG_FB_HECUBA=y
>> CONFIG_FB_MODE_HELPERS=y
>> CONFIG_FB_TILEBLITTING=y
>>
>> #
>> # Frame buffer hardware drivers
>> #
>> # CONFIG_FB_CIRRUS is not set
>> # CONFIG_FB_PM2 is not set
>> # CONFIG_FB_CYBER2000 is not set
>> CONFIG_FB_ARC=y
>> # CONFIG_FB_ASILIANT is not set
>> # CONFIG_FB_IMSTT is not set
>> # CONFIG_FB_VGA16 is not set
>> # CONFIG_FB_VESA is not set
>> CONFIG_FB_N411=y
>> CONFIG_FB_HGA=m
>> CONFIG_FB_OPENCORES=m
>> # CONFIG_FB_S1D13XXX is not set
>> # CONFIG_FB_NVIDIA is not set
>> # CONFIG_FB_RIVA is not set
>> # CONFIG_FB_I740 is not set
>> # CONFIG_FB_LE80578 is not set
>> # CONFIG_FB_MATROX is not set
>> # CONFIG_FB_RADEON is not set
>> # CONFIG_FB_ATY128 is not set
>> # CONFIG_FB_ATY is not set
>> # CONFIG_FB_S3 is not set
>> # CONFIG_FB_SAVAGE is not set
>> # CONFIG_FB_SIS is not set
>> # CONFIG_FB_VIA is not set
>> # CONFIG_FB_NEOMAGIC is not set
>> # CONFIG_FB_KYRO is not set
>> # CONFIG_FB_3DFX is not set
>> # CONFIG_FB_VOODOO1 is not set
>> # CONFIG_FB_VT8623 is not set
>> # CONFIG_FB_TRIDENT is not set
>> # CONFIG_FB_ARK is not set
>> # CONFIG_FB_PM3 is not set
>> # CONFIG_FB_CARMINE is not set
>> CONFIG_FB_IBM_GXT4500=m
>> CONFIG_FB_VIRTUAL=y
>> # CONFIG_FB_METRONOME is not set
>> # CONFIG_FB_MB862XX is not set
>> CONFIG_FB_BROADSHEET=m
>> # CONFIG_FB_SIMPLE is not set
>> # CONFIG_FB_SM712 is not set
>> CONFIG_BACKLIGHT_LCD_SUPPORT=y
>> CONFIG_LCD_CLASS_DEVICE=y
>> CONFIG_LCD_L4F00242T03=y
>> CONFIG_LCD_LMS283GF05=y
>> CONFIG_LCD_LTV350QV=m
>> # CONFIG_LCD_ILI922X is not set
>> CONFIG_LCD_ILI9320=y
>> CONFIG_LCD_TDO24M=m
>> CONFIG_LCD_VGG2432A4=y
>> CONFIG_LCD_PLATFORM=m
>> # CONFIG_LCD_S6E63M0 is not set
>> CONFIG_LCD_LD9040=m
>> CONFIG_LCD_AMS369FG06=m
>> CONFIG_LCD_LMS501KF03=m
>> # CONFIG_LCD_HX8357 is not set
>> CONFIG_LCD_OTM3225A=y
>> CONFIG_BACKLIGHT_CLASS_DEVICE=m
>> # CONFIG_BACKLIGHT_GENERIC is not set
>> CONFIG_BACKLIGHT_LM3533=m
>> # CONFIG_BACKLIGHT_PWM is not set
>> # CONFIG_BACKLIGHT_DA9052 is not set
>> # CONFIG_BACKLIGHT_MAX8925 is not set
>> # CONFIG_BACKLIGHT_APPLE is not set
>> CONFIG_BACKLIGHT_PM8941_WLED=m
>> CONFIG_BACKLIGHT_SAHARA=m
>> CONFIG_BACKLIGHT_WM831X=m
>> CONFIG_BACKLIGHT_ADP5520=m
>> CONFIG_BACKLIGHT_ADP8860=m
>> CONFIG_BACKLIGHT_ADP8870=m
>> CONFIG_BACKLIGHT_88PM860X=m
>> CONFIG_BACKLIGHT_LM3630A=m
>> CONFIG_BACKLIGHT_LM3639=m
>> CONFIG_BACKLIGHT_LP855X=m
>> CONFIG_BACKLIGHT_PANDORA=m
>> CONFIG_BACKLIGHT_SKY81452=m
>> # CONFIG_BACKLIGHT_GPIO is not set
>> CONFIG_BACKLIGHT_LV5207LP=m
>> CONFIG_BACKLIGHT_BD6107=m
>> CONFIG_BACKLIGHT_ARCXCNN=m
>> CONFIG_HDMI=y
>> CONFIG_LOGO=y
>> CONFIG_LOGO_LINUX_MONO=y
>> CONFIG_LOGO_LINUX_VGA16=y
>> CONFIG_LOGO_LINUX_CLUT224=y
>> CONFIG_SOUND=y
>> CONFIG_SND=y
>> CONFIG_SND_PCM=y
>> CONFIG_SND_PCM_ELD=y
>> CONFIG_SND_PCM_IEC958=y
>> CONFIG_SND_DMAENGINE_PCM=y
>> CONFIG_SND_HWDEP=m
>> CONFIG_SND_RAWMIDI=m
>> CONFIG_SND_JACK=y
>> CONFIG_SND_JACK_INPUT_DEV=y
>> # CONFIG_SND_OSSEMUL is not set
>> # CONFIG_SND_PCM_TIMER is not set
>> CONFIG_SND_DYNAMIC_MINORS=y
>> CONFIG_SND_MAX_CARDS=32
>> # CONFIG_SND_SUPPORT_OLD_API is not set
>> CONFIG_SND_PROC_FS=y
>> CONFIG_SND_VERBOSE_PROCFS=y
>> CONFIG_SND_VERBOSE_PRINTK=y
>> CONFIG_SND_DEBUG=y
>> CONFIG_SND_DEBUG_VERBOSE=y
>> # CONFIG_SND_PCM_XRUN_DEBUG is not set
>> CONFIG_SND_VMASTER=y
>> CONFIG_SND_DMA_SGBUF=y
>> # CONFIG_SND_SEQUENCER is not set
>> CONFIG_SND_VX_LIB=m
>> CONFIG_SND_AC97_CODEC=m
>> # CONFIG_SND_DRIVERS is not set
>> CONFIG_SND_PCI=y
>> # CONFIG_SND_AD1889 is not set
>> # CONFIG_SND_ALS300 is not set
>> # CONFIG_SND_ALS4000 is not set
>> # CONFIG_SND_ALI5451 is not set
>> # CONFIG_SND_ASIHPI is not set
>> # CONFIG_SND_ATIIXP is not set
>> # CONFIG_SND_ATIIXP_MODEM is not set
>> # CONFIG_SND_AU8810 is not set
>> # CONFIG_SND_AU8820 is not set
>> # CONFIG_SND_AU8830 is not set
>> # CONFIG_SND_AW2 is not set
>> # CONFIG_SND_AZT3328 is not set
>> # CONFIG_SND_BT87X is not set
>> # CONFIG_SND_CA0106 is not set
>> # CONFIG_SND_CMIPCI is not set
>> # CONFIG_SND_OXYGEN is not set
>> # CONFIG_SND_CS4281 is not set
>> # CONFIG_SND_CS46XX is not set
>> # CONFIG_SND_CTXFI is not set
>> # CONFIG_SND_DARLA20 is not set
>> # CONFIG_SND_GINA20 is not set
>> # CONFIG_SND_LAYLA20 is not set
>> # CONFIG_SND_DARLA24 is not set
>> # CONFIG_SND_GINA24 is not set
>> # CONFIG_SND_LAYLA24 is not set
>> # CONFIG_SND_MONA is not set
>> # CONFIG_SND_MIA is not set
>> # CONFIG_SND_ECHO3G is not set
>> # CONFIG_SND_INDIGO is not set
>> # CONFIG_SND_INDIGOIO is not set
>> # CONFIG_SND_INDIGODJ is not set
>> # CONFIG_SND_INDIGOIOX is not set
>> # CONFIG_SND_INDIGODJX is not set
>> # CONFIG_SND_EMU10K1 is not set
>> # CONFIG_SND_EMU10K1X is not set
>> # CONFIG_SND_ENS1370 is not set
>> # CONFIG_SND_ENS1371 is not set
>> # CONFIG_SND_ES1938 is not set
>> # CONFIG_SND_ES1968 is not set
>> # CONFIG_SND_FM801 is not set
>> # CONFIG_SND_HDSP is not set
>> # CONFIG_SND_HDSPM is not set
>> # CONFIG_SND_ICE1712 is not set
>> # CONFIG_SND_ICE1724 is not set
>> # CONFIG_SND_INTEL8X0 is not set
>> # CONFIG_SND_INTEL8X0M is not set
>> # CONFIG_SND_KORG1212 is not set
>> # CONFIG_SND_LOLA is not set
>> # CONFIG_SND_LX6464ES is not set
>> # CONFIG_SND_MAESTRO3 is not set
>> # CONFIG_SND_MIXART is not set
>> # CONFIG_SND_NM256 is not set
>> # CONFIG_SND_PCXHR is not set
>> # CONFIG_SND_RIPTIDE is not set
>> # CONFIG_SND_RME32 is not set
>> # CONFIG_SND_RME96 is not set
>> # CONFIG_SND_RME9652 is not set
>> # CONFIG_SND_SE6X is not set
>> # CONFIG_SND_SONICVIBES is not set
>> # CONFIG_SND_TRIDENT is not set
>> # CONFIG_SND_VIA82XX is not set
>> # CONFIG_SND_VIA82XX_MODEM is not set
>> # CONFIG_SND_VIRTUOSO is not set
>> # CONFIG_SND_VX222 is not set
>> # CONFIG_SND_YMFPCI is not set
>>
>> #
>> # HD-Audio
>> #
>> # CONFIG_SND_HDA_INTEL is not set
>> CONFIG_SND_HDA_PREALLOC_SIZE=64
>> CONFIG_SND_SPI=y
>> # CONFIG_SND_FIREWIRE is not set
>> CONFIG_SND_PCMCIA=y
>> CONFIG_SND_VXPOCKET=m
>> # CONFIG_SND_PDAUDIOCF is not set
>> CONFIG_SND_SOC=y
>> CONFIG_SND_SOC_AC97_BUS=y
>> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
>> # CONFIG_SND_SOC_AMD_ACP is not set
>> CONFIG_SND_ATMEL_SOC=y
>> # CONFIG_SND_DESIGNWARE_I2S is not set
>>
>> #
>> # SoC Audio for Freescale CPUs
>> #
>>
>> #
>> # Common SoC Audio options for Freescale CPUs:
>> #
>> # CONFIG_SND_SOC_FSL_ASRC is not set
>> CONFIG_SND_SOC_FSL_SAI=m
>> CONFIG_SND_SOC_FSL_SSI=m
>> CONFIG_SND_SOC_FSL_SPDIF=y
>> CONFIG_SND_SOC_FSL_ESAI=m
>> # CONFIG_SND_SOC_IMX_AUDMUX is not set
>> # CONFIG_SND_I2S_HI6210_I2S is not set
>> # CONFIG_SND_SOC_IMG is not set
>> # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
>>
>> #
>> # STMicroelectronics STM32 SOC audio support
>> #
>> CONFIG_SND_SOC_XTFPGA_I2S=m
>> # CONFIG_ZX_TDM is not set
>> CONFIG_SND_SOC_I2C_AND_SPI=y
>>
>> #
>> # CODEC drivers
>> #
>> CONFIG_SND_SOC_AC97_CODEC=m
>> CONFIG_SND_SOC_ADAU_UTILS=m
>> CONFIG_SND_SOC_ADAU1701=y
>> CONFIG_SND_SOC_ADAU17X1=m
>> CONFIG_SND_SOC_ADAU1761=m
>> CONFIG_SND_SOC_ADAU1761_I2C=m
>> CONFIG_SND_SOC_ADAU1761_SPI=m
>> CONFIG_SND_SOC_ADAU7002=m
>> CONFIG_SND_SOC_AK4104=m
>> CONFIG_SND_SOC_AK4458=m
>> CONFIG_SND_SOC_AK4554=m
>> CONFIG_SND_SOC_AK4613=m
>> CONFIG_SND_SOC_AK4642=m
>> CONFIG_SND_SOC_AK5386=m
>> CONFIG_SND_SOC_AK5558=m
>> CONFIG_SND_SOC_ALC5623=m
>> CONFIG_SND_SOC_BD28623=m
>> CONFIG_SND_SOC_BT_SCO=y
>> CONFIG_SND_SOC_CS35L32=m
>> CONFIG_SND_SOC_CS35L33=m
>> CONFIG_SND_SOC_CS35L34=m
>> CONFIG_SND_SOC_CS35L35=m
>> CONFIG_SND_SOC_CS42L42=y
>> CONFIG_SND_SOC_CS42L51=m
>> CONFIG_SND_SOC_CS42L51_I2C=m
>> CONFIG_SND_SOC_CS42L52=m
>> CONFIG_SND_SOC_CS42L56=m
>> CONFIG_SND_SOC_CS42L73=m
>> CONFIG_SND_SOC_CS4265=m
>> CONFIG_SND_SOC_CS4270=m
>> CONFIG_SND_SOC_CS4271=y
>> CONFIG_SND_SOC_CS4271_I2C=m
>> CONFIG_SND_SOC_CS4271_SPI=y
>> CONFIG_SND_SOC_CS42XX8=m
>> CONFIG_SND_SOC_CS42XX8_I2C=m
>> CONFIG_SND_SOC_CS43130=y
>> CONFIG_SND_SOC_CS4349=m
>> CONFIG_SND_SOC_CS53L30=m
>> CONFIG_SND_SOC_DIO2125=m
>> CONFIG_SND_SOC_HDMI_CODEC=y
>> CONFIG_SND_SOC_ES7134=m
>> CONFIG_SND_SOC_ES8316=y
>> CONFIG_SND_SOC_ES8328=m
>> CONFIG_SND_SOC_ES8328_I2C=m
>> CONFIG_SND_SOC_ES8328_SPI=m
>> CONFIG_SND_SOC_GTM601=m
>> CONFIG_SND_SOC_INNO_RK3036=y
>> CONFIG_SND_SOC_MAX98504=m
>> CONFIG_SND_SOC_MAX9867=m
>> CONFIG_SND_SOC_MAX98927=m
>> CONFIG_SND_SOC_MAX98373=m
>> CONFIG_SND_SOC_MAX9860=y
>> # CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
>> CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
>> CONFIG_SND_SOC_PCM1681=y
>> CONFIG_SND_SOC_PCM1789=m
>> CONFIG_SND_SOC_PCM1789_I2C=m
>> CONFIG_SND_SOC_PCM179X=m
>> CONFIG_SND_SOC_PCM179X_I2C=m
>> CONFIG_SND_SOC_PCM179X_SPI=m
>> CONFIG_SND_SOC_PCM186X=m
>> CONFIG_SND_SOC_PCM186X_I2C=m
>> CONFIG_SND_SOC_PCM186X_SPI=m
>> CONFIG_SND_SOC_PCM3168A=y
>> CONFIG_SND_SOC_PCM3168A_I2C=y
>> CONFIG_SND_SOC_PCM3168A_SPI=m
>> CONFIG_SND_SOC_PCM512x=y
>> CONFIG_SND_SOC_PCM512x_I2C=y
>> CONFIG_SND_SOC_PCM512x_SPI=m
>> CONFIG_SND_SOC_RL6231=m
>> CONFIG_SND_SOC_RT5616=m
>> CONFIG_SND_SOC_RT5631=m
>> CONFIG_SND_SOC_SGTL5000=m
>> CONFIG_SND_SOC_SIGMADSP=y
>> CONFIG_SND_SOC_SIGMADSP_I2C=y
>> CONFIG_SND_SOC_SIGMADSP_REGMAP=m
>> CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
>> CONFIG_SND_SOC_SPDIF=m
>> CONFIG_SND_SOC_SSM2305=y
>> CONFIG_SND_SOC_SSM2602=m
>> CONFIG_SND_SOC_SSM2602_SPI=m
>> CONFIG_SND_SOC_SSM2602_I2C=m
>> CONFIG_SND_SOC_SSM4567=m
>> CONFIG_SND_SOC_STA32X=m
>> CONFIG_SND_SOC_STA350=m
>> CONFIG_SND_SOC_STI_SAS=m
>> CONFIG_SND_SOC_TAS2552=m
>> CONFIG_SND_SOC_TAS5086=m
>> CONFIG_SND_SOC_TAS571X=m
>> CONFIG_SND_SOC_TAS5720=m
>> CONFIG_SND_SOC_TAS6424=m
>> CONFIG_SND_SOC_TDA7419=m
>> CONFIG_SND_SOC_TFA9879=y
>> CONFIG_SND_SOC_TLV320AIC23=y
>> CONFIG_SND_SOC_TLV320AIC23_I2C=y
>> CONFIG_SND_SOC_TLV320AIC23_SPI=m
>> CONFIG_SND_SOC_TLV320AIC31XX=y
>> CONFIG_SND_SOC_TLV320AIC32X4=y
>> CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
>> CONFIG_SND_SOC_TLV320AIC32X4_SPI=y
>> CONFIG_SND_SOC_TLV320AIC3X=m
>> CONFIG_SND_SOC_TS3A227E=y
>> CONFIG_SND_SOC_TSCS42XX=m
>> CONFIG_SND_SOC_TSCS454=m
>> CONFIG_SND_SOC_WM8510=m
>> CONFIG_SND_SOC_WM8523=m
>> CONFIG_SND_SOC_WM8524=m
>> CONFIG_SND_SOC_WM8580=y
>> CONFIG_SND_SOC_WM8711=y
>> CONFIG_SND_SOC_WM8728=m
>> CONFIG_SND_SOC_WM8731=m
>> CONFIG_SND_SOC_WM8737=m
>> CONFIG_SND_SOC_WM8741=m
>> CONFIG_SND_SOC_WM8750=m
>> CONFIG_SND_SOC_WM8753=m
>> CONFIG_SND_SOC_WM8770=m
>> CONFIG_SND_SOC_WM8776=m
>> CONFIG_SND_SOC_WM8782=m
>> CONFIG_SND_SOC_WM8804=y
>> CONFIG_SND_SOC_WM8804_I2C=m
>> CONFIG_SND_SOC_WM8804_SPI=y
>> CONFIG_SND_SOC_WM8903=y
>> CONFIG_SND_SOC_WM8960=m
>> CONFIG_SND_SOC_WM8962=m
>> CONFIG_SND_SOC_WM8974=m
>> CONFIG_SND_SOC_WM8978=m
>> CONFIG_SND_SOC_WM8985=y
>> CONFIG_SND_SOC_ZX_AUD96P22=m
>> CONFIG_SND_SOC_MAX9759=m
>> # CONFIG_SND_SOC_MT6351 is not set
>> CONFIG_SND_SOC_NAU8540=y
>> CONFIG_SND_SOC_NAU8810=y
>> CONFIG_SND_SOC_NAU8824=m
>> CONFIG_SND_SOC_TPA6130A2=y
>> CONFIG_SND_SIMPLE_CARD_UTILS=m
>> CONFIG_SND_SIMPLE_CARD=m
>> # CONFIG_SND_X86 is not set
>> CONFIG_AC97_BUS=y
>>
>> #
>> # HID support
>> #
>> CONFIG_HID=m
>> # CONFIG_HID_BATTERY_STRENGTH is not set
>> # CONFIG_HIDRAW is not set
>> CONFIG_UHID=m
>> CONFIG_HID_GENERIC=m
>>
>> #
>> # Special HID drivers
>> #
>> CONFIG_HID_A4TECH=m
>> CONFIG_HID_ACRUX=m
>> # CONFIG_HID_ACRUX_FF is not set
>> # CONFIG_HID_APPLE is not set
>> CONFIG_HID_ASUS=m
>> # CONFIG_HID_AUREAL is not set
>> # CONFIG_HID_BELKIN is not set
>> CONFIG_HID_CHERRY=m
>> CONFIG_HID_CHICONY=m
>> CONFIG_HID_PRODIKEYS=m
>> CONFIG_HID_CMEDIA=m
>> CONFIG_HID_CYPRESS=m
>> # CONFIG_HID_DRAGONRISE is not set
>> CONFIG_HID_EMS_FF=m
>> # CONFIG_HID_ELECOM is not set
>> CONFIG_HID_EZKEY=m
>> CONFIG_HID_GEMBIRD=m
>> CONFIG_HID_GFRM=m
>> # CONFIG_HID_KEYTOUCH is not set
>> # CONFIG_HID_KYE is not set
>> CONFIG_HID_WALTOP=m
>> CONFIG_HID_GYRATION=m
>> CONFIG_HID_ICADE=m
>> CONFIG_HID_ITE=m
>> CONFIG_HID_JABRA=m
>> CONFIG_HID_TWINHAN=m
>> CONFIG_HID_KENSINGTON=m
>> CONFIG_HID_LCPOWER=m
>> CONFIG_HID_LED=m
>> # CONFIG_HID_LENOVO is not set
>> CONFIG_HID_LOGITECH=m
>> CONFIG_HID_LOGITECH_HIDPP=m
>> CONFIG_LOGITECH_FF=y
>> # CONFIG_LOGIRUMBLEPAD2_FF is not set
>> CONFIG_LOGIG940_FF=y
>> CONFIG_LOGIWHEELS_FF=y
>> CONFIG_HID_MAGICMOUSE=m
>> CONFIG_HID_MAYFLASH=m
>> CONFIG_HID_REDRAGON=m
>> # CONFIG_HID_MICROSOFT is not set
>> # CONFIG_HID_MONTEREY is not set
>> # CONFIG_HID_MULTITOUCH is not set
>> CONFIG_HID_NTI=m
>> CONFIG_HID_ORTEK=m
>> CONFIG_HID_PANTHERLORD=m
>> # CONFIG_PANTHERLORD_FF is not set
>> # CONFIG_HID_PETALYNX is not set
>> # CONFIG_HID_PICOLCD is not set
>> CONFIG_HID_PLANTRONICS=m
>> CONFIG_HID_PRIMAX=m
>> CONFIG_HID_SAITEK=m
>> CONFIG_HID_SAMSUNG=m
>> CONFIG_HID_SPEEDLINK=m
>> CONFIG_HID_STEAM=m
>> # CONFIG_HID_STEELSERIES is not set
>> CONFIG_HID_SUNPLUS=m
>> # CONFIG_HID_RMI is not set
>> CONFIG_HID_GREENASIA=m
>> CONFIG_GREENASIA_FF=y
>> CONFIG_HID_SMARTJOYPLUS=m
>> CONFIG_SMARTJOYPLUS_FF=y
>> CONFIG_HID_TIVO=m
>> CONFIG_HID_TOPSEED=m
>> # CONFIG_HID_THINGM is not set
>> CONFIG_HID_THRUSTMASTER=m
>> # CONFIG_THRUSTMASTER_FF is not set
>> CONFIG_HID_UDRAW_PS3=m
>> CONFIG_HID_WIIMOTE=m
>> # CONFIG_HID_XINMO is not set
>> # CONFIG_HID_ZEROPLUS is not set
>> CONFIG_HID_ZYDACRON=m
>> # CONFIG_HID_SENSOR_HUB is not set
>> CONFIG_HID_ALPS=m
>>
>> #
>> # I2C HID support
>> #
>> CONFIG_I2C_HID=m
>>
>> #
>> # Intel ISH HID support
>> #
>> # CONFIG_INTEL_ISH_HID is not set
>> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
>> CONFIG_USB_SUPPORT=y
>> CONFIG_USB_ARCH_HAS_HCD=y
>> # CONFIG_USB is not set
>> CONFIG_USB_PCI=y
>>
>> #
>> # USB port drivers
>> #
>>
>> #
>> # USB Physical Layer drivers
>> #
>> # CONFIG_NOP_USB_XCEIV is not set
>> # CONFIG_USB_GPIO_VBUS is not set
>> # CONFIG_TAHVO_USB is not set
>> # CONFIG_USB_GADGET is not set
>> # CONFIG_TYPEC is not set
>> # CONFIG_USB_LED_TRIG is not set
>> # CONFIG_USB_ULPI_BUS is not set
>> CONFIG_UWB=m
>> # CONFIG_UWB_WHCI is not set
>> CONFIG_MMC=m
>> CONFIG_MMC_BLOCK=m
>> CONFIG_MMC_BLOCK_MINORS=8
>> # CONFIG_SDIO_UART is not set
>> CONFIG_MMC_TEST=m
>>
>> #
>> # MMC/SD/SDIO Host Controller Drivers
>> #
>> CONFIG_MMC_DEBUG=y
>> CONFIG_MMC_SDHCI=m
>> # CONFIG_MMC_SDHCI_PCI is not set
>> # CONFIG_MMC_SDHCI_ACPI is not set
>> # CONFIG_MMC_SDHCI_PLTFM is not set
>> CONFIG_MMC_WBSD=m
>> # CONFIG_MMC_TIFM_SD is not set
>> CONFIG_MMC_SPI=m
>> # CONFIG_MMC_SDRICOH_CS is not set
>> # CONFIG_MMC_CB710 is not set
>> # CONFIG_MMC_VIA_SDMMC is not set
>> CONFIG_MMC_USDHI6ROL0=m
>> CONFIG_MMC_CQHCI=m
>> # CONFIG_MMC_TOSHIBA_PCI is not set
>> # CONFIG_MMC_MTK is not set
>> CONFIG_MEMSTICK=y
>> CONFIG_MEMSTICK_DEBUG=y
>>
>> #
>> # MemoryStick drivers
>> #
>> CONFIG_MEMSTICK_UNSAFE_RESUME=y
>> # CONFIG_MSPRO_BLOCK is not set
>> CONFIG_MS_BLOCK=y
>>
>> #
>> # MemoryStick Host Controller Drivers
>> #
>> # CONFIG_MEMSTICK_TIFM_MS is not set
>> # CONFIG_MEMSTICK_JMICRON_38X is not set
>> # CONFIG_MEMSTICK_R592 is not set
>> CONFIG_NEW_LEDS=y
>> CONFIG_LEDS_CLASS=m
>> CONFIG_LEDS_CLASS_FLASH=m
>> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
>>
>> #
>> # LED drivers
>> #
>> # CONFIG_LEDS_88PM860X is not set
>> # CONFIG_LEDS_APU is not set
>> CONFIG_LEDS_AS3645A=m
>> # CONFIG_LEDS_LM3530 is not set
>> CONFIG_LEDS_LM3533=m
>> CONFIG_LEDS_LM3642=m
>> # CONFIG_LEDS_LM3601X is not set
>> CONFIG_LEDS_MT6323=m
>> CONFIG_LEDS_PCA9532=m
>> CONFIG_LEDS_PCA9532_GPIO=y
>> # CONFIG_LEDS_GPIO is not set
>> CONFIG_LEDS_LP3944=m
>> CONFIG_LEDS_LP3952=m
>> CONFIG_LEDS_LP55XX_COMMON=m
>> CONFIG_LEDS_LP5521=m
>> # CONFIG_LEDS_LP5523 is not set
>> # CONFIG_LEDS_LP5562 is not set
>> CONFIG_LEDS_LP8501=m
>> CONFIG_LEDS_CLEVO_MAIL=m
>> # CONFIG_LEDS_PCA955X is not set
>> CONFIG_LEDS_PCA963X=m
>> CONFIG_LEDS_WM831X_STATUS=m
>> CONFIG_LEDS_DA9052=m
>> CONFIG_LEDS_DAC124S085=m
>> CONFIG_LEDS_PWM=m
>> CONFIG_LEDS_REGULATOR=m
>> CONFIG_LEDS_BD2802=m
>> # CONFIG_LEDS_INTEL_SS4200 is not set
>> CONFIG_LEDS_LT3593=m
>> # CONFIG_LEDS_ADP5520 is not set
>> CONFIG_LEDS_MC13783=m
>> CONFIG_LEDS_TCA6507=m
>> # CONFIG_LEDS_TLC591XX is not set
>> CONFIG_LEDS_MAX8997=m
>> # CONFIG_LEDS_LM355x is not set
>> CONFIG_LEDS_MENF21BMC=m
>>
>> #
>> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
>> #
>> CONFIG_LEDS_BLINKM=m
>> # CONFIG_LEDS_MLXCPLD is not set
>> CONFIG_LEDS_MLXREG=m
>> # CONFIG_LEDS_USER is not set
>> # CONFIG_LEDS_NIC78BX is not set
>>
>> #
>> # LED Triggers
>> #
>> CONFIG_LEDS_TRIGGERS=y
>> CONFIG_LEDS_TRIGGER_TIMER=m
>> CONFIG_LEDS_TRIGGER_ONESHOT=y
>> CONFIG_LEDS_TRIGGER_DISK=y
>> # CONFIG_LEDS_TRIGGER_MTD is not set
>> CONFIG_LEDS_TRIGGER_HEARTBEAT=m
>> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>> CONFIG_LEDS_TRIGGER_CPU=y
>> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
>> CONFIG_LEDS_TRIGGER_GPIO=y
>> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>>
>> #
>> # iptables trigger is under Netfilter config (LED target)
>> #
>> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
>> # CONFIG_LEDS_TRIGGER_CAMERA is not set
>> CONFIG_LEDS_TRIGGER_PANIC=y
>> # CONFIG_LEDS_TRIGGER_NETDEV is not set
>> # CONFIG_ACCESSIBILITY is not set
>> # CONFIG_INFINIBAND is not set
>> CONFIG_EDAC_ATOMIC_SCRUB=y
>> CONFIG_EDAC_SUPPORT=y
>> CONFIG_EDAC=y
>> # CONFIG_EDAC_LEGACY_SYSFS is not set
>> CONFIG_EDAC_DEBUG=y
>> # CONFIG_EDAC_E752X is not set
>> # CONFIG_EDAC_I82975X is not set
>> # CONFIG_EDAC_I3000 is not set
>> # CONFIG_EDAC_I3200 is not set
>> # CONFIG_EDAC_IE31200 is not set
>> # CONFIG_EDAC_X38 is not set
>> # CONFIG_EDAC_I5400 is not set
>> # CONFIG_EDAC_I5000 is not set
>> # CONFIG_EDAC_I5100 is not set
>> # CONFIG_EDAC_I7300 is not set
>> CONFIG_RTC_LIB=y
>> CONFIG_RTC_MC146818_LIB=y
>> # CONFIG_RTC_CLASS is not set
>> CONFIG_DMADEVICES=y
>> # CONFIG_DMADEVICES_DEBUG is not set
>>
>> #
>> # DMA Devices
>> #
>> CONFIG_DMA_ENGINE=y
>> CONFIG_DMA_VIRTUAL_CHANNELS=y
>> CONFIG_DMA_ACPI=y
>> CONFIG_ALTERA_MSGDMA=m
>> # CONFIG_INTEL_IDMA64 is not set
>> # CONFIG_INTEL_IOATDMA is not set
>> CONFIG_QCOM_HIDMA_MGMT=y
>> CONFIG_QCOM_HIDMA=m
>> CONFIG_DW_DMAC_CORE=y
>> CONFIG_DW_DMAC=m
>> # CONFIG_DW_DMAC_PCI is not set
>> CONFIG_HSU_DMA=y
>>
>> #
>> # DMA Clients
>> #
>> # CONFIG_ASYNC_TX_DMA is not set
>> CONFIG_DMATEST=y
>> CONFIG_DMA_ENGINE_RAID=y
>>
>> #
>> # DMABUF options
>> #
>> CONFIG_SYNC_FILE=y
>> # CONFIG_SW_SYNC is not set
>> CONFIG_AUXDISPLAY=y
>> CONFIG_HD44780=y
>> CONFIG_IMG_ASCII_LCD=m
>> CONFIG_CHARLCD=y
>> # CONFIG_UIO is not set
>> # CONFIG_VIRT_DRIVERS is not set
>> CONFIG_VIRTIO=y
>> # CONFIG_VIRTIO_MENU is not set
>>
>> #
>> # Microsoft Hyper-V guest support
>> #
>> # CONFIG_HYPERV is not set
>> # CONFIG_STAGING is not set
>> # CONFIG_X86_PLATFORM_DEVICES is not set
>> CONFIG_PMC_ATOM=y
>> CONFIG_CHROME_PLATFORMS=y
>> # CONFIG_CHROMEOS_LAPTOP is not set
>> CONFIG_CHROMEOS_PSTORE=m
>> # CONFIG_CHROMEOS_TBMC is not set
>> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
>> CONFIG_MELLANOX_PLATFORM=y
>> CONFIG_MLXREG_HOTPLUG=m
>> CONFIG_CLKDEV_LOOKUP=y
>> CONFIG_HAVE_CLK_PREPARE=y
>> CONFIG_COMMON_CLK=y
>>
>> #
>> # Common Clock Framework
>> #
>> # CONFIG_COMMON_CLK_WM831X is not set
>> # CONFIG_COMMON_CLK_SI5351 is not set
>> # CONFIG_COMMON_CLK_SI544 is not set
>> # CONFIG_COMMON_CLK_CDCE706 is not set
>> # CONFIG_COMMON_CLK_CS2000_CP is not set
>> # CONFIG_COMMON_CLK_S2MPS11 is not set
>> # CONFIG_CLK_TWL6040 is not set
>> # CONFIG_COMMON_CLK_PWM is not set
>> # CONFIG_HWSPINLOCK is not set
>>
>> #
>> # Clock Source drivers
>> #
>> CONFIG_CLKEVT_I8253=y
>> CONFIG_I8253_LOCK=y
>> CONFIG_CLKBLD_I8253=y
>> # CONFIG_MAILBOX is not set
>> CONFIG_IOMMU_SUPPORT=y
>>
>> #
>> # Generic IOMMU Pagetable Support
>> #
>> # CONFIG_AMD_IOMMU is not set
>>
>> #
>> # Remoteproc drivers
>> #
>> # CONFIG_REMOTEPROC is not set
>>
>> #
>> # Rpmsg drivers
>> #
>> CONFIG_RPMSG=y
>> # CONFIG_RPMSG_CHAR is not set
>> CONFIG_RPMSG_VIRTIO=y
>> CONFIG_SOUNDWIRE=y
>>
>> #
>> # SoundWire Devices
>> #
>> # CONFIG_SOUNDWIRE_INTEL is not set
>>
>> #
>> # SOC (System On Chip) specific Drivers
>> #
>>
>> #
>> # Amlogic SoC drivers
>> #
>>
>> #
>> # Broadcom SoC drivers
>> #
>>
>> #
>> # i.MX SoC drivers
>> #
>>
>> #
>> # Qualcomm SoC drivers
>> #
>> CONFIG_SOC_TI=y
>>
>> #
>> # Xilinx SoC drivers
>> #
>> # CONFIG_XILINX_VCU is not set
>> CONFIG_PM_DEVFREQ=y
>>
>> #
>> # DEVFREQ Governors
>> #
>> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
>> CONFIG_DEVFREQ_GOV_POWERSAVE=y
>> CONFIG_DEVFREQ_GOV_USERSPACE=y
>> CONFIG_DEVFREQ_GOV_PASSIVE=y
>>
>> #
>> # DEVFREQ Drivers
>> #
>> CONFIG_PM_DEVFREQ_EVENT=y
>> CONFIG_EXTCON=y
>>
>> #
>> # Extcon Device Drivers
>> #
>> CONFIG_EXTCON_ADC_JACK=y
>> # CONFIG_EXTCON_ARIZONA is not set
>> CONFIG_EXTCON_GPIO=y
>> # CONFIG_EXTCON_INTEL_INT3496 is not set
>> CONFIG_EXTCON_MAX14577=y
>> CONFIG_EXTCON_MAX3355=y
>> # CONFIG_EXTCON_MAX77693 is not set
>> CONFIG_EXTCON_MAX8997=m
>> CONFIG_EXTCON_RT8973A=m
>> CONFIG_EXTCON_SM5502=m
>> # CONFIG_EXTCON_USB_GPIO is not set
>> # CONFIG_MEMORY is not set
>> CONFIG_IIO=y
>> CONFIG_IIO_BUFFER=y
>> CONFIG_IIO_BUFFER_CB=m
>> CONFIG_IIO_BUFFER_HW_CONSUMER=m
>> CONFIG_IIO_KFIFO_BUF=y
>> CONFIG_IIO_TRIGGERED_BUFFER=y
>> CONFIG_IIO_CONFIGFS=y
>> CONFIG_IIO_TRIGGER=y
>> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
>> CONFIG_IIO_SW_DEVICE=y
>> # CONFIG_IIO_SW_TRIGGER is not set
>>
>> #
>> # Accelerometers
>> #
>> # CONFIG_ADIS16201 is not set
>> # CONFIG_ADIS16209 is not set
>> # CONFIG_ADXL345_I2C is not set
>> # CONFIG_ADXL345_SPI is not set
>> CONFIG_BMA180=y
>> CONFIG_BMA220=m
>> # CONFIG_BMC150_ACCEL is not set
>> # CONFIG_DA280 is not set
>> CONFIG_DA311=y
>> # CONFIG_DMARD09 is not set
>> CONFIG_DMARD10=y
>> # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
>> CONFIG_IIO_ST_ACCEL_3AXIS=m
>> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
>> CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
>> CONFIG_KXSD9=y
>> CONFIG_KXSD9_SPI=y
>> # CONFIG_KXSD9_I2C is not set
>> # CONFIG_KXCJK1013 is not set
>> CONFIG_MC3230=y
>> CONFIG_MMA7455=m
>> CONFIG_MMA7455_I2C=m
>> CONFIG_MMA7455_SPI=m
>> CONFIG_MMA7660=m
>> CONFIG_MMA8452=m
>> CONFIG_MMA9551_CORE=m
>> CONFIG_MMA9551=m
>> # CONFIG_MMA9553 is not set
>> CONFIG_MXC4005=y
>> # CONFIG_MXC6255 is not set
>> # CONFIG_SCA3000 is not set
>> CONFIG_STK8312=y
>> CONFIG_STK8BA50=y
>>
>> #
>> # Analog to digital converters
>> #
>> CONFIG_AD_SIGMA_DELTA=y
>> CONFIG_AD7266=y
>> CONFIG_AD7291=m
>> CONFIG_AD7298=y
>> CONFIG_AD7476=m
>> CONFIG_AD7766=m
>> CONFIG_AD7791=y
>> CONFIG_AD7793=y
>> # CONFIG_AD7887 is not set
>> CONFIG_AD7923=y
>> # CONFIG_AD799X is not set
>> # CONFIG_CC10001_ADC is not set
>> # CONFIG_HI8435 is not set
>> CONFIG_HX711=m
>> CONFIG_INA2XX_ADC=m
>> # CONFIG_LTC2471 is not set
>> CONFIG_LTC2485=y
>> # CONFIG_LTC2497 is not set
>> # CONFIG_MAX1027 is not set
>> # CONFIG_MAX11100 is not set
>> # CONFIG_MAX1118 is not set
>> # CONFIG_MAX1363 is not set
>> CONFIG_MAX9611=y
>> CONFIG_MCP320X=y
>> CONFIG_MCP3422=m
>> CONFIG_MEN_Z188_ADC=m
>> # CONFIG_NAU7802 is not set
>> CONFIG_QCOM_VADC_COMMON=y
>> CONFIG_QCOM_SPMI_IADC=y
>> CONFIG_QCOM_SPMI_VADC=y
>> CONFIG_TI_ADC081C=m
>> # CONFIG_TI_ADC0832 is not set
>> # CONFIG_TI_ADC084S021 is not set
>> # CONFIG_TI_ADC12138 is not set
>> # CONFIG_TI_ADC108S102 is not set
>> CONFIG_TI_ADC128S052=y
>> CONFIG_TI_ADC161S626=y
>> CONFIG_TI_ADS1015=y
>> CONFIG_TI_ADS7950=y
>> CONFIG_TI_AM335X_ADC=y
>> CONFIG_TI_TLC4541=m
>> # CONFIG_TWL4030_MADC is not set
>> CONFIG_TWL6030_GPADC=y
>>
>> #
>> # Analog Front Ends
>> #
>>
>> #
>> # Amplifiers
>> #
>> CONFIG_AD8366=y
>>
>> #
>> # Chemical Sensors
>> #
>> # CONFIG_ATLAS_PH_SENSOR is not set
>> CONFIG_CCS811=y
>> CONFIG_IAQCORE=m
>> # CONFIG_VZ89X is not set
>>
>> #
>> # Hid Sensor IIO Common
>> #
>> CONFIG_IIO_MS_SENSORS_I2C=m
>>
>> #
>> # SSP Sensor Common
>> #
>> CONFIG_IIO_SSP_SENSORS_COMMONS=m
>> CONFIG_IIO_SSP_SENSORHUB=y
>> CONFIG_IIO_ST_SENSORS_I2C=y
>> CONFIG_IIO_ST_SENSORS_SPI=y
>> CONFIG_IIO_ST_SENSORS_CORE=y
>>
>> #
>> # Counters
>> #
>>
>> #
>> # Digital to analog converters
>> #
>> # CONFIG_AD5064 is not set
>> CONFIG_AD5360=m
>> CONFIG_AD5380=y
>> CONFIG_AD5421=y
>> # CONFIG_AD5446 is not set
>> CONFIG_AD5449=y
>> CONFIG_AD5592R_BASE=y
>> # CONFIG_AD5592R is not set
>> CONFIG_AD5593R=y
>> CONFIG_AD5504=y
>> CONFIG_AD5624R_SPI=m
>> CONFIG_LTC2632=y
>> CONFIG_AD5686=m
>> CONFIG_AD5686_SPI=m
>> # CONFIG_AD5696_I2C is not set
>> # CONFIG_AD5755 is not set
>> # CONFIG_AD5761 is not set
>> # CONFIG_AD5764 is not set
>> CONFIG_AD5791=y
>> # CONFIG_AD7303 is not set
>> CONFIG_AD8801=m
>> CONFIG_DS4424=y
>> CONFIG_M62332=m
>> CONFIG_MAX517=m
>> # CONFIG_MCP4725 is not set
>> CONFIG_MCP4922=m
>> CONFIG_TI_DAC082S085=m
>> # CONFIG_TI_DAC5571 is not set
>>
>> #
>> # IIO dummy driver
>> #
>> CONFIG_IIO_SIMPLE_DUMMY=y
>> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
>> CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
>>
>> #
>> # Frequency Synthesizers DDS/PLL
>> #
>>
>> #
>> # Clock Generator/Distribution
>> #
>> CONFIG_AD9523=y
>>
>> #
>> # Phase-Locked Loop (PLL) frequency synthesizers
>> #
>> CONFIG_ADF4350=y
>>
>> #
>> # Digital gyroscope sensors
>> #
>> CONFIG_ADIS16080=y
>> CONFIG_ADIS16130=y
>> # CONFIG_ADIS16136 is not set
>> # CONFIG_ADIS16260 is not set
>> CONFIG_ADXRS450=m
>> CONFIG_BMG160=y
>> CONFIG_BMG160_I2C=y
>> CONFIG_BMG160_SPI=y
>> CONFIG_MPU3050=y
>> CONFIG_MPU3050_I2C=y
>> CONFIG_IIO_ST_GYRO_3AXIS=y
>> CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
>> CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
>> CONFIG_ITG3200=m
>>
>> #
>> # Health Sensors
>> #
>>
>> #
>> # Heart Rate Monitors
>> #
>> CONFIG_AFE4403=m
>> # CONFIG_AFE4404 is not set
>> # CONFIG_MAX30100 is not set
>> # CONFIG_MAX30102 is not set
>>
>> #
>> # Humidity sensors
>> #
>> # CONFIG_AM2315 is not set
>> # CONFIG_DHT11 is not set
>> # CONFIG_HDC100X is not set
>> CONFIG_HTS221=m
>> CONFIG_HTS221_I2C=m
>> CONFIG_HTS221_SPI=m
>> CONFIG_HTU21=m
>> # CONFIG_SI7005 is not set
>> CONFIG_SI7020=m
>>
>> #
>> # Inertial measurement units
>> #
>> # CONFIG_ADIS16400 is not set
>> CONFIG_ADIS16480=m
>> CONFIG_BMI160=y
>> CONFIG_BMI160_I2C=y
>> # CONFIG_BMI160_SPI is not set
>> # CONFIG_KMX61 is not set
>> CONFIG_INV_MPU6050_IIO=y
>> CONFIG_INV_MPU6050_I2C=y
>> CONFIG_INV_MPU6050_SPI=m
>> CONFIG_IIO_ST_LSM6DSX=m
>> CONFIG_IIO_ST_LSM6DSX_I2C=m
>> CONFIG_IIO_ST_LSM6DSX_SPI=m
>> CONFIG_IIO_ADIS_LIB=m
>> CONFIG_IIO_ADIS_LIB_BUFFER=y
>>
>> #
>> # Light sensors
>> #
>> # CONFIG_ACPI_ALS is not set
>> # CONFIG_ADJD_S311 is not set
>> CONFIG_AL3320A=y
>> # CONFIG_APDS9300 is not set
>> CONFIG_APDS9960=y
>> CONFIG_BH1750=m
>> CONFIG_BH1780=y
>> CONFIG_CM32181=y
>> CONFIG_CM3232=y
>> # CONFIG_CM3323 is not set
>> # CONFIG_CM36651 is not set
>> CONFIG_GP2AP020A00F=m
>> # CONFIG_SENSORS_ISL29018 is not set
>> CONFIG_SENSORS_ISL29028=y
>> CONFIG_ISL29125=y
>> CONFIG_JSA1212=y
>> CONFIG_RPR0521=m
>> CONFIG_SENSORS_LM3533=y
>> CONFIG_LTR501=m
>> # CONFIG_LV0104CS is not set
>> CONFIG_MAX44000=m
>> CONFIG_OPT3001=m
>> # CONFIG_PA12203001 is not set
>> CONFIG_SI1145=y
>> # CONFIG_STK3310 is not set
>> # CONFIG_ST_UVIS25 is not set
>> CONFIG_TCS3414=m
>> CONFIG_TCS3472=m
>> CONFIG_SENSORS_TSL2563=m
>> CONFIG_TSL2583=m
>> CONFIG_TSL2772=m
>> # CONFIG_TSL4531 is not set
>> CONFIG_US5182D=y
>> CONFIG_VCNL4000=m
>> CONFIG_VEML6070=m
>> CONFIG_VL6180=m
>> CONFIG_ZOPT2201=y
>>
>> #
>> # Magnetometer sensors
>> #
>> CONFIG_AK8975=y
>> CONFIG_AK09911=m
>> CONFIG_BMC150_MAGN=m
>> # CONFIG_BMC150_MAGN_I2C is not set
>> CONFIG_BMC150_MAGN_SPI=m
>> # CONFIG_MAG3110 is not set
>> CONFIG_MMC35240=m
>> CONFIG_IIO_ST_MAGN_3AXIS=m
>> CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
>> CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
>> CONFIG_SENSORS_HMC5843=y
>> CONFIG_SENSORS_HMC5843_I2C=y
>> CONFIG_SENSORS_HMC5843_SPI=m
>>
>> #
>> # Multiplexers
>> #
>>
>> #
>> # Inclinometer sensors
>> #
>>
>> #
>> # Triggers - standalone
>> #
>> CONFIG_IIO_INTERRUPT_TRIGGER=m
>> CONFIG_IIO_SYSFS_TRIGGER=m
>>
>> #
>> # Digital potentiometers
>> #
>> # CONFIG_AD5272 is not set
>> CONFIG_DS1803=y
>> CONFIG_MAX5481=y
>> # CONFIG_MAX5487 is not set
>> CONFIG_MCP4018=y
>> # CONFIG_MCP4131 is not set
>> CONFIG_MCP4531=m
>> CONFIG_TPL0102=y
>>
>> #
>> # Digital potentiostats
>> #
>> # CONFIG_LMP91000 is not set
>>
>> #
>> # Pressure sensors
>> #
>> # CONFIG_ABP060MG is not set
>> CONFIG_BMP280=m
>> CONFIG_BMP280_I2C=m
>> CONFIG_BMP280_SPI=m
>> CONFIG_HP03=m
>> CONFIG_MPL115=y
>> # CONFIG_MPL115_I2C is not set
>> CONFIG_MPL115_SPI=y
>> CONFIG_MPL3115=y
>> CONFIG_MS5611=m
>> CONFIG_MS5611_I2C=m
>> CONFIG_MS5611_SPI=m
>> # CONFIG_MS5637 is not set
>> # CONFIG_IIO_ST_PRESS is not set
>> CONFIG_T5403=y
>> CONFIG_HP206C=m
>> CONFIG_ZPA2326=y
>> CONFIG_ZPA2326_I2C=y
>> CONFIG_ZPA2326_SPI=y
>>
>> #
>> # Lightning sensors
>> #
>> # CONFIG_AS3935 is not set
>>
>> #
>> # Proximity and distance sensors
>> #
>> CONFIG_LIDAR_LITE_V2=m
>> CONFIG_RFD77402=y
>> CONFIG_SRF04=m
>> CONFIG_SX9500=m
>> CONFIG_SRF08=y
>>
>> #
>> # Resolver to digital converters
>> #
>> CONFIG_AD2S1200=m
>>
>> #
>> # Temperature sensors
>> #
>> CONFIG_MAXIM_THERMOCOUPLE=y
>> CONFIG_MLX90614=y
>> # CONFIG_MLX90632 is not set
>> CONFIG_TMP006=m
>> CONFIG_TMP007=m
>> CONFIG_TSYS01=m
>> # CONFIG_TSYS02D is not set
>> # CONFIG_NTB is not set
>> # CONFIG_VME_BUS is not set
>> CONFIG_PWM=y
>> CONFIG_PWM_SYSFS=y
>> # CONFIG_PWM_LPSS_PCI is not set
>> # CONFIG_PWM_LPSS_PLATFORM is not set
>> CONFIG_PWM_PCA9685=y
>> CONFIG_PWM_TWL=m
>> # CONFIG_PWM_TWL_LED is not set
>>
>> #
>> # IRQ chip support
>> #
>> CONFIG_ARM_GIC_MAX_NR=1
>> CONFIG_IPACK_BUS=y
>> # CONFIG_BOARD_TPCI200 is not set
>> # CONFIG_SERIAL_IPOCTAL is not set
>> # CONFIG_RESET_CONTROLLER is not set
>> # CONFIG_FMC is not set
>>
>> #
>> # PHY Subsystem
>> #
>> CONFIG_GENERIC_PHY=y
>> # CONFIG_BCM_KONA_USB2_PHY is not set
>> CONFIG_PHY_PXA_28NM_HSIC=y
>> CONFIG_PHY_PXA_28NM_USB2=m
>> # CONFIG_PHY_CPCAP_USB is not set
>> CONFIG_POWERCAP=y
>> CONFIG_MCB=m
>> # CONFIG_MCB_PCI is not set
>> CONFIG_MCB_LPC=m
>>
>> #
>> # Performance monitor support
>> #
>> CONFIG_RAS=y
>> # CONFIG_THUNDERBOLT is not set
>>
>> #
>> # Android
>> #
>> CONFIG_ANDROID=y
>> CONFIG_ANDROID_BINDER_IPC=y
>> CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
>> # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
>> # CONFIG_LIBNVDIMM is not set
>> CONFIG_DAX=y
>> CONFIG_NVMEM=y
>>
>> #
>> # HW tracing support
>> #
>> # CONFIG_STM is not set
>> CONFIG_INTEL_TH=m
>> # CONFIG_INTEL_TH_PCI is not set
>> # CONFIG_INTEL_TH_ACPI is not set
>> CONFIG_INTEL_TH_GTH=m
>> CONFIG_INTEL_TH_MSU=m
>> # CONFIG_INTEL_TH_PTI is not set
>> CONFIG_INTEL_TH_DEBUG=y
>> CONFIG_FPGA=m
>> CONFIG_ALTERA_PR_IP_CORE=m
>> # CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
>> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
>> CONFIG_FPGA_MGR_XILINX_SPI=m
>> # CONFIG_FPGA_MGR_MACHXO2_SPI is not set
>> # CONFIG_FPGA_BRIDGE is not set
>> CONFIG_PM_OPP=y
>> # CONFIG_UNISYS_VISORBUS is not set
>> # CONFIG_SIOX is not set
>> # CONFIG_SLIMBUS is not set
>>
>> #
>> # Firmware Drivers
>> #
>> # CONFIG_EDD is not set
>> # CONFIG_FIRMWARE_MEMMAP is not set
>> CONFIG_DELL_RBU=m
>> CONFIG_DCDBAS=m
>> # CONFIG_DMIID is not set
>> CONFIG_DMI_SYSFS=m
>> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
>> # CONFIG_ISCSI_IBFT_FIND is not set
>> CONFIG_FW_CFG_SYSFS=m
>> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
>> # CONFIG_GOOGLE_FIRMWARE is not set
>>
>> #
>> # Tegra firmware driver
>> #
>>
>> #
>> # File systems
>> #
>> CONFIG_DCACHE_WORD_ACCESS=y
>> CONFIG_FS_IOMAP=y
>> CONFIG_EXT2_FS=y
>> CONFIG_EXT2_FS_XATTR=y
>> CONFIG_EXT2_FS_POSIX_ACL=y
>> # CONFIG_EXT2_FS_SECURITY is not set
>> # CONFIG_EXT3_FS is not set
>> CONFIG_EXT4_FS=m
>> # CONFIG_EXT4_FS_POSIX_ACL is not set
>> # CONFIG_EXT4_FS_SECURITY is not set
>> CONFIG_EXT4_ENCRYPTION=y
>> CONFIG_EXT4_FS_ENCRYPTION=y
>> CONFIG_EXT4_DEBUG=y
>> CONFIG_JBD2=m
>> CONFIG_JBD2_DEBUG=y
>> CONFIG_FS_MBCACHE=y
>> CONFIG_REISERFS_FS=y
>> CONFIG_REISERFS_CHECK=y
>> # CONFIG_REISERFS_PROC_INFO is not set
>> # CONFIG_REISERFS_FS_XATTR is not set
>> CONFIG_JFS_FS=y
>> CONFIG_JFS_POSIX_ACL=y
>> CONFIG_JFS_SECURITY=y
>> # CONFIG_JFS_DEBUG is not set
>> # CONFIG_JFS_STATISTICS is not set
>> CONFIG_XFS_FS=y
>> CONFIG_XFS_QUOTA=y
>> CONFIG_XFS_POSIX_ACL=y
>> CONFIG_XFS_RT=y
>> # CONFIG_XFS_ONLINE_SCRUB is not set
>> CONFIG_XFS_DEBUG=y
>> CONFIG_XFS_ASSERT_FATAL=y
>> CONFIG_GFS2_FS=y
>> # CONFIG_OCFS2_FS is not set
>> CONFIG_BTRFS_FS=m
>> CONFIG_BTRFS_FS_POSIX_ACL=y
>> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
>> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>> # CONFIG_BTRFS_DEBUG is not set
>> CONFIG_BTRFS_ASSERT=y
>> # CONFIG_BTRFS_FS_REF_VERIFY is not set
>> CONFIG_NILFS2_FS=y
>> # CONFIG_F2FS_FS is not set
>> CONFIG_FS_DAX=y
>> CONFIG_FS_POSIX_ACL=y
>> CONFIG_EXPORTFS=y
>> # CONFIG_EXPORTFS_BLOCK_OPS is not set
>> CONFIG_FILE_LOCKING=y
>> # CONFIG_MANDATORY_FILE_LOCKING is not set
>> CONFIG_FS_ENCRYPTION=m
>> CONFIG_FSNOTIFY=y
>> # CONFIG_DNOTIFY is not set
>> CONFIG_INOTIFY_USER=y
>> CONFIG_FANOTIFY=y
>> # CONFIG_QUOTA is not set
>> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
>> CONFIG_QUOTACTL=y
>> CONFIG_QUOTACTL_COMPAT=y
>> CONFIG_AUTOFS4_FS=y
>> CONFIG_AUTOFS_FS=y
>> CONFIG_FUSE_FS=y
>> # CONFIG_CUSE is not set
>> CONFIG_OVERLAY_FS=y
>> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
>> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
>> # CONFIG_OVERLAY_FS_INDEX is not set
>> CONFIG_OVERLAY_FS_XINO_AUTO=y
>>
>> #
>> # Caches
>> #
>> CONFIG_FSCACHE=m
>> # CONFIG_FSCACHE_STATS is not set
>> # CONFIG_FSCACHE_HISTOGRAM is not set
>> # CONFIG_FSCACHE_DEBUG is not set
>> # CONFIG_FSCACHE_OBJECT_LIST is not set
>> CONFIG_CACHEFILES=m
>> CONFIG_CACHEFILES_DEBUG=y
>> # CONFIG_CACHEFILES_HISTOGRAM is not set
>>
>> #
>> # CD-ROM/DVD Filesystems
>> #
>> CONFIG_ISO9660_FS=m
>> CONFIG_JOLIET=y
>> CONFIG_ZISOFS=y
>> CONFIG_UDF_FS=y
>>
>> #
>> # DOS/FAT/NT Filesystems
>> #
>> CONFIG_FAT_FS=y
>> # CONFIG_MSDOS_FS is not set
>> CONFIG_VFAT_FS=y
>> CONFIG_FAT_DEFAULT_CODEPAGE=437
>> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
>> CONFIG_FAT_DEFAULT_UTF8=y
>> CONFIG_NTFS_FS=m
>> # CONFIG_NTFS_DEBUG is not set
>> CONFIG_NTFS_RW=y
>>
>> #
>> # Pseudo filesystems
>> #
>> CONFIG_PROC_FS=y
>> # CONFIG_PROC_KCORE is not set
>> CONFIG_PROC_VMCORE=y
>> # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
>> CONFIG_PROC_SYSCTL=y
>> CONFIG_PROC_PAGE_MONITOR=y
>> CONFIG_PROC_CHILDREN=y
>> CONFIG_KERNFS=y
>> CONFIG_SYSFS=y
>> CONFIG_TMPFS=y
>> # CONFIG_TMPFS_POSIX_ACL is not set
>> # CONFIG_TMPFS_XATTR is not set
>> CONFIG_HUGETLBFS=y
>> CONFIG_HUGETLB_PAGE=y
>> CONFIG_MEMFD_CREATE=y
>> CONFIG_CONFIGFS_FS=y
>> CONFIG_MISC_FILESYSTEMS=y
>> CONFIG_ORANGEFS_FS=y
>> CONFIG_ADFS_FS=y
>> CONFIG_ADFS_FS_RW=y
>> # CONFIG_AFFS_FS is not set
>> CONFIG_ECRYPT_FS=m
>> CONFIG_ECRYPT_FS_MESSAGING=y
>> CONFIG_HFS_FS=y
>> CONFIG_HFSPLUS_FS=y
>> CONFIG_HFSPLUS_FS_POSIX_ACL=y
>> CONFIG_BEFS_FS=y
>> # CONFIG_BEFS_DEBUG is not set
>> CONFIG_BFS_FS=y
>> CONFIG_EFS_FS=m
>> CONFIG_JFFS2_FS=m
>> CONFIG_JFFS2_FS_DEBUG=0
>> CONFIG_JFFS2_FS_WRITEBUFFER=y
>> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
>> CONFIG_JFFS2_SUMMARY=y
>> CONFIG_JFFS2_FS_XATTR=y
>> # CONFIG_JFFS2_FS_POSIX_ACL is not set
>> # CONFIG_JFFS2_FS_SECURITY is not set
>> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
>> # CONFIG_JFFS2_ZLIB is not set
>> # CONFIG_JFFS2_LZO is not set
>> CONFIG_JFFS2_RTIME=y
>> CONFIG_JFFS2_RUBIN=y
>> CONFIG_JFFS2_CMODE_NONE=y
>> # CONFIG_JFFS2_CMODE_PRIORITY is not set
>> # CONFIG_JFFS2_CMODE_SIZE is not set
>> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
>> # CONFIG_UBIFS_FS is not set
>> # CONFIG_CRAMFS is not set
>> CONFIG_SQUASHFS=y
>> CONFIG_SQUASHFS_FILE_CACHE=y
>> # CONFIG_SQUASHFS_FILE_DIRECT is not set
>> CONFIG_SQUASHFS_DECOMP_SINGLE=y
>> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
>> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
>> # CONFIG_SQUASHFS_XATTR is not set
>> CONFIG_SQUASHFS_ZLIB=y
>> CONFIG_SQUASHFS_LZ4=y
>> CONFIG_SQUASHFS_LZO=y
>> CONFIG_SQUASHFS_XZ=y
>> # CONFIG_SQUASHFS_ZSTD is not set
>> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
>> # CONFIG_SQUASHFS_EMBEDDED is not set
>> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
>> CONFIG_VXFS_FS=m
>> CONFIG_MINIX_FS=y
>> CONFIG_OMFS_FS=m
>> CONFIG_HPFS_FS=m
>> CONFIG_QNX4FS_FS=y
>> CONFIG_QNX6FS_FS=y
>> # CONFIG_QNX6FS_DEBUG is not set
>> CONFIG_ROMFS_FS=y
>> CONFIG_ROMFS_BACKED_BY_BLOCK=y
>> CONFIG_ROMFS_ON_BLOCK=y
>> CONFIG_PSTORE=y
>> # CONFIG_PSTORE_DEFLATE_COMPRESS is not set
>> CONFIG_PSTORE_LZO_COMPRESS=y
>> # CONFIG_PSTORE_LZ4_COMPRESS is not set
>> CONFIG_PSTORE_LZ4HC_COMPRESS=y
>> # CONFIG_PSTORE_842_COMPRESS is not set
>> CONFIG_PSTORE_COMPRESS=y
>> CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
>> # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
>> CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
>> CONFIG_PSTORE_CONSOLE=y
>> CONFIG_PSTORE_PMSG=y
>> CONFIG_PSTORE_RAM=y
>> # CONFIG_SYSV_FS is not set
>> # CONFIG_UFS_FS is not set
>> # CONFIG_EXOFS_FS is not set
>> CONFIG_NETWORK_FILESYSTEMS=y
>> CONFIG_NFS_FS=y
>> CONFIG_NFS_V2=y
>> CONFIG_NFS_V3=y
>> # CONFIG_NFS_V3_ACL is not set
>> CONFIG_NFS_V4=m
>> # CONFIG_NFS_SWAP is not set
>> # CONFIG_NFS_V4_1 is not set
>> # CONFIG_ROOT_NFS is not set
>> # CONFIG_NFS_USE_LEGACY_DNS is not set
>> CONFIG_NFS_USE_KERNEL_DNS=y
>> # CONFIG_NFSD is not set
>> CONFIG_GRACE_PERIOD=y
>> CONFIG_LOCKD=y
>> CONFIG_LOCKD_V4=y
>> CONFIG_NFS_COMMON=y
>> CONFIG_SUNRPC=y
>> CONFIG_SUNRPC_GSS=m
>> CONFIG_RPCSEC_GSS_KRB5=m
>> # CONFIG_SUNRPC_DEBUG is not set
>> # CONFIG_CEPH_FS is not set
>> CONFIG_CIFS=m
>> # CONFIG_CIFS_STATS is not set
>> # CONFIG_CIFS_WEAK_PW_HASH is not set
>> # CONFIG_CIFS_UPCALL is not set
>> # CONFIG_CIFS_XATTR is not set
>> CONFIG_CIFS_DEBUG=y
>> # CONFIG_CIFS_DEBUG2 is not set
>> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
>> # CONFIG_CIFS_DFS_UPCALL is not set
>> # CONFIG_CIFS_SMB311 is not set
>> # CONFIG_CIFS_FSCACHE is not set
>> # CONFIG_CODA_FS is not set
>> # CONFIG_AFS_FS is not set
>> CONFIG_NLS=y
>> CONFIG_NLS_DEFAULT="iso8859-1"
>> CONFIG_NLS_CODEPAGE_437=m
>> # CONFIG_NLS_CODEPAGE_737 is not set
>> CONFIG_NLS_CODEPAGE_775=y
>> CONFIG_NLS_CODEPAGE_850=m
>> CONFIG_NLS_CODEPAGE_852=m
>> CONFIG_NLS_CODEPAGE_855=y
>> CONFIG_NLS_CODEPAGE_857=y
>> # CONFIG_NLS_CODEPAGE_860 is not set
>> # CONFIG_NLS_CODEPAGE_861 is not set
>> CONFIG_NLS_CODEPAGE_862=y
>> # CONFIG_NLS_CODEPAGE_863 is not set
>> CONFIG_NLS_CODEPAGE_864=m
>> CONFIG_NLS_CODEPAGE_865=y
>> CONFIG_NLS_CODEPAGE_866=y
>> # CONFIG_NLS_CODEPAGE_869 is not set
>> CONFIG_NLS_CODEPAGE_936=m
>> CONFIG_NLS_CODEPAGE_950=y
>> CONFIG_NLS_CODEPAGE_932=m
>> CONFIG_NLS_CODEPAGE_949=m
>> CONFIG_NLS_CODEPAGE_874=y
>> CONFIG_NLS_ISO8859_8=m
>> CONFIG_NLS_CODEPAGE_1250=y
>> CONFIG_NLS_CODEPAGE_1251=m
>> CONFIG_NLS_ASCII=y
>> CONFIG_NLS_ISO8859_1=m
>> CONFIG_NLS_ISO8859_2=y
>> CONFIG_NLS_ISO8859_3=m
>> CONFIG_NLS_ISO8859_4=m
>> # CONFIG_NLS_ISO8859_5 is not set
>> CONFIG_NLS_ISO8859_6=y
>> CONFIG_NLS_ISO8859_7=y
>> CONFIG_NLS_ISO8859_9=m
>> # CONFIG_NLS_ISO8859_13 is not set
>> # CONFIG_NLS_ISO8859_14 is not set
>> # CONFIG_NLS_ISO8859_15 is not set
>> # CONFIG_NLS_KOI8_R is not set
>> # CONFIG_NLS_KOI8_U is not set
>> CONFIG_NLS_MAC_ROMAN=m
>> CONFIG_NLS_MAC_CELTIC=y
>> CONFIG_NLS_MAC_CENTEURO=m
>> CONFIG_NLS_MAC_CROATIAN=y
>> CONFIG_NLS_MAC_CYRILLIC=m
>> # CONFIG_NLS_MAC_GAELIC is not set
>> CONFIG_NLS_MAC_GREEK=y
>> CONFIG_NLS_MAC_ICELAND=y
>> CONFIG_NLS_MAC_INUIT=m
>> CONFIG_NLS_MAC_ROMANIAN=y
>> CONFIG_NLS_MAC_TURKISH=m
>> CONFIG_NLS_UTF8=y
>> # CONFIG_DLM is not set
>>
>> #
>> # Kernel hacking
>> #
>> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>>
>> #
>> # printk and dmesg options
>> #
>> CONFIG_PRINTK_TIME=y
>> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
>> CONFIG_BOOT_PRINTK_DELAY=y
>> CONFIG_DYNAMIC_DEBUG=y
>>
>> #
>> # Compile-time checks and compiler options
>> #
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_INFO_REDUCED=y
>> # CONFIG_DEBUG_INFO_SPLIT is not set
>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>> # CONFIG_GDB_SCRIPTS is not set
>> # CONFIG_ENABLE_WARN_DEPRECATED is not set
>> CONFIG_ENABLE_MUST_CHECK=y
>> CONFIG_FRAME_WARN=8192
>> # CONFIG_STRIP_ASM_SYMS is not set
>> # CONFIG_READABLE_ASM is not set
>> CONFIG_UNUSED_SYMBOLS=y
>> # CONFIG_PAGE_OWNER is not set
>> CONFIG_DEBUG_FS=y
>> CONFIG_HEADERS_CHECK=y
>> CONFIG_DEBUG_SECTION_MISMATCH=y
>> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>> CONFIG_STACK_VALIDATION=y
>> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
>> CONFIG_MAGIC_SYSRQ=y
>> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
>> CONFIG_MAGIC_SYSRQ_SERIAL=y
>> CONFIG_DEBUG_KERNEL=y
>>
>> #
>> # Memory Debugging
>> #
>> CONFIG_PAGE_EXTENSION=y
>> CONFIG_DEBUG_PAGEALLOC=y
>> # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
>> # CONFIG_PAGE_POISONING is not set
>> CONFIG_DEBUG_RODATA_TEST=y
>> CONFIG_DEBUG_OBJECTS=y
>> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
>> # CONFIG_DEBUG_OBJECTS_FREE is not set
>> CONFIG_DEBUG_OBJECTS_TIMERS=y
>> # CONFIG_DEBUG_OBJECTS_WORK is not set
>> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
>> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
>> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
>> CONFIG_SLUB_DEBUG_ON=y
>> CONFIG_SLUB_STATS=y
>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>> # CONFIG_DEBUG_KMEMLEAK is not set
>> # CONFIG_DEBUG_STACK_USAGE is not set
>> CONFIG_DEBUG_VM=y
>> # CONFIG_DEBUG_VM_VMACACHE is not set
>> # CONFIG_DEBUG_VM_RB is not set
>> # CONFIG_DEBUG_VM_PGFLAGS is not set
>> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
>> CONFIG_DEBUG_VIRTUAL=y
>> CONFIG_DEBUG_MEMORY_INIT=y
>> # CONFIG_DEBUG_PER_CPU_MAPS is not set
>> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
>> CONFIG_DEBUG_STACKOVERFLOW=y
>> CONFIG_HAVE_ARCH_KASAN=y
>> CONFIG_KASAN=y
>> # CONFIG_KASAN_EXTRA is not set
>> CONFIG_KASAN_OUTLINE=y
>> # CONFIG_KASAN_INLINE is not set
>> CONFIG_TEST_KASAN=m
>> CONFIG_ARCH_HAS_KCOV=y
>> CONFIG_DEBUG_SHIRQ=y
>>
>> #
>> # Debug Lockups and Hangs
>> #
>> # CONFIG_SOFTLOCKUP_DETECTOR is not set
>> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
>> # CONFIG_HARDLOCKUP_DETECTOR is not set
>> # CONFIG_DETECT_HUNG_TASK is not set
>> # CONFIG_WQ_WATCHDOG is not set
>> CONFIG_PANIC_ON_OOPS=y
>> CONFIG_PANIC_ON_OOPS_VALUE=1
>> CONFIG_PANIC_TIMEOUT=0
>> CONFIG_SCHED_DEBUG=y
>> # CONFIG_SCHEDSTATS is not set
>> # CONFIG_SCHED_STACK_END_CHECK is not set
>> CONFIG_DEBUG_TIMEKEEPING=y
>> CONFIG_DEBUG_PREEMPT=y
>>
>> #
>> # Lock Debugging (spinlocks, mutexes, etc...)
>> #
>> CONFIG_LOCK_DEBUGGING_SUPPORT=y
>> CONFIG_PROVE_LOCKING=y
>> # CONFIG_LOCK_STAT is not set
>> CONFIG_DEBUG_RT_MUTEXES=y
>> CONFIG_DEBUG_SPINLOCK=y
>> CONFIG_DEBUG_MUTEXES=y
>> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
>> CONFIG_DEBUG_RWSEMS=y
>> CONFIG_DEBUG_LOCK_ALLOC=y
>> CONFIG_LOCKDEP=y
>> CONFIG_DEBUG_LOCKDEP=y
>> CONFIG_DEBUG_ATOMIC_SLEEP=y
>> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
>> # CONFIG_LOCK_TORTURE_TEST is not set
>> CONFIG_WW_MUTEX_SELFTEST=m
>> CONFIG_TRACE_IRQFLAGS=y
>> CONFIG_STACKTRACE=y
>> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
>> # CONFIG_DEBUG_KOBJECT is not set
>> # CONFIG_DEBUG_KOBJECT_RELEASE is not set
>> CONFIG_DEBUG_BUGVERBOSE=y
>> # CONFIG_DEBUG_LIST is not set
>> # CONFIG_DEBUG_PI_LIST is not set
>> CONFIG_DEBUG_SG=y
>> CONFIG_DEBUG_NOTIFIERS=y
>> CONFIG_DEBUG_CREDENTIALS=y
>>
>> #
>> # RCU Debugging
>> #
>> CONFIG_PROVE_RCU=y
>> CONFIG_TORTURE_TEST=m
>> CONFIG_RCU_PERF_TEST=m
>> CONFIG_RCU_TORTURE_TEST=m
>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
>> CONFIG_RCU_TRACE=y
>> # CONFIG_RCU_EQS_DEBUG is not set
>> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
>> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
>> CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
>> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
>> CONFIG_FAULT_INJECTION=y
>> # CONFIG_FAILSLAB is not set
>> CONFIG_FAIL_PAGE_ALLOC=y
>> # CONFIG_FAIL_MAKE_REQUEST is not set
>> # CONFIG_FAIL_IO_TIMEOUT is not set
>> # CONFIG_FAIL_FUTEX is not set
>> # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
>> # CONFIG_LATENCYTOP is not set
>> CONFIG_USER_STACKTRACE_SUPPORT=y
>> CONFIG_HAVE_FUNCTION_TRACER=y
>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
>> CONFIG_HAVE_DYNAMIC_FTRACE=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
>> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
>> CONFIG_HAVE_FENTRY=y
>> CONFIG_HAVE_C_RECORDMCOUNT=y
>> CONFIG_TRACE_CLOCK=y
>> CONFIG_RING_BUFFER=y
>> CONFIG_RING_BUFFER_ALLOW_SWAP=y
>> CONFIG_TRACING_SUPPORT=y
>> # CONFIG_FTRACE is not set
>> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
>> # CONFIG_DMA_API_DEBUG is not set
>> CONFIG_RUNTIME_TESTING_MENU=y
>> # CONFIG_LKDTM is not set
>> # CONFIG_TEST_LIST_SORT is not set
>> CONFIG_TEST_SORT=m
>> # CONFIG_BACKTRACE_SELF_TEST is not set
>> CONFIG_RBTREE_TEST=y
>> CONFIG_INTERVAL_TREE_TEST=y
>> # CONFIG_PERCPU_TEST is not set
>> CONFIG_ATOMIC64_SELFTEST=y
>> # CONFIG_ASYNC_RAID6_TEST is not set
>> CONFIG_TEST_HEXDUMP=m
>> CONFIG_TEST_STRING_HELPERS=y
>> CONFIG_TEST_KSTRTOX=m
>> CONFIG_TEST_PRINTF=m
>> CONFIG_TEST_BITMAP=y
>> # CONFIG_TEST_UUID is not set
>> CONFIG_TEST_OVERFLOW=m
>> # CONFIG_TEST_RHASHTABLE is not set
>> CONFIG_TEST_HASH=m
>> CONFIG_TEST_LKM=m
>> CONFIG_TEST_USER_COPY=m
>> # CONFIG_TEST_BPF is not set
>> CONFIG_FIND_BIT_BENCHMARK=y
>> CONFIG_TEST_FIRMWARE=y
>> # CONFIG_TEST_SYSCTL is not set
>> CONFIG_TEST_UDELAY=m
>> CONFIG_TEST_STATIC_KEYS=m
>> # CONFIG_TEST_KMOD is not set
>> # CONFIG_TEST_DEBUG_VIRTUAL is not set
>> # CONFIG_MEMTEST is not set
>> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
>> # CONFIG_SAMPLES is not set
>> CONFIG_HAVE_ARCH_KGDB=y
>> # CONFIG_KGDB is not set
>> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
>> # CONFIG_UBSAN is not set
>> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
>> CONFIG_X86_VERBOSE_BOOTUP=y
>> # CONFIG_EARLY_PRINTK is not set
>> CONFIG_X86_PTDUMP_CORE=y
>> CONFIG_X86_PTDUMP=y
>> # CONFIG_DEBUG_WX is not set
>> CONFIG_DOUBLEFAULT=y
>> CONFIG_DEBUG_TLBFLUSH=y
>> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
>> CONFIG_IO_DELAY_TYPE_0X80=0
>> CONFIG_IO_DELAY_TYPE_0XED=1
>> CONFIG_IO_DELAY_TYPE_UDELAY=2
>> CONFIG_IO_DELAY_TYPE_NONE=3
>> # CONFIG_IO_DELAY_0X80 is not set
>> # CONFIG_IO_DELAY_0XED is not set
>> CONFIG_IO_DELAY_UDELAY=y
>> # CONFIG_IO_DELAY_NONE is not set
>> CONFIG_DEFAULT_IO_DELAY_TYPE=2
>> CONFIG_DEBUG_BOOT_PARAMS=y
>> # CONFIG_CPA_DEBUG is not set
>> CONFIG_OPTIMIZE_INLINING=y
>> # CONFIG_DEBUG_ENTRY is not set
>> # CONFIG_DEBUG_NMI_SELFTEST is not set
>> # CONFIG_X86_DEBUG_FPU is not set
>> # CONFIG_PUNIT_ATOM_DEBUG is not set
>> CONFIG_UNWINDER_ORC=y
>> # CONFIG_UNWINDER_FRAME_POINTER is not set
>>
>> #
>> # Security options
>> #
>> CONFIG_KEYS=y
>> CONFIG_KEYS_COMPAT=y
>> CONFIG_PERSISTENT_KEYRINGS=y
>> # CONFIG_BIG_KEYS is not set
>> CONFIG_TRUSTED_KEYS=y
>> # CONFIG_ENCRYPTED_KEYS is not set
>> CONFIG_KEY_DH_OPERATIONS=y
>> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>> # CONFIG_SECURITY is not set
>> CONFIG_SECURITYFS=y
>> CONFIG_PAGE_TABLE_ISOLATION=y
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>> # CONFIG_HARDENED_USERCOPY is not set
>> CONFIG_FORTIFY_SOURCE=y
>> # CONFIG_STATIC_USERMODEHELPER is not set
>> CONFIG_DEFAULT_SECURITY_DAC=y
>> CONFIG_DEFAULT_SECURITY=""
>> CONFIG_XOR_BLOCKS=m
>> CONFIG_ASYNC_CORE=m
>> CONFIG_ASYNC_MEMCPY=m
>> CONFIG_ASYNC_XOR=m
>> CONFIG_ASYNC_PQ=m
>> CONFIG_ASYNC_RAID6_RECOV=m
>> CONFIG_CRYPTO=y
>>
>> #
>> # Crypto core or helper
>> #
>> CONFIG_CRYPTO_ALGAPI=y
>> CONFIG_CRYPTO_ALGAPI2=y
>> CONFIG_CRYPTO_AEAD=y
>> CONFIG_CRYPTO_AEAD2=y
>> CONFIG_CRYPTO_BLKCIPHER=y
>> CONFIG_CRYPTO_BLKCIPHER2=y
>> CONFIG_CRYPTO_HASH=y
>> CONFIG_CRYPTO_HASH2=y
>> CONFIG_CRYPTO_RNG=y
>> CONFIG_CRYPTO_RNG2=y
>> CONFIG_CRYPTO_RNG_DEFAULT=y
>> CONFIG_CRYPTO_AKCIPHER2=y
>> CONFIG_CRYPTO_AKCIPHER=y
>> CONFIG_CRYPTO_KPP2=y
>> CONFIG_CRYPTO_KPP=y
>> CONFIG_CRYPTO_ACOMP2=y
>> CONFIG_CRYPTO_RSA=y
>> CONFIG_CRYPTO_DH=y
>> # CONFIG_CRYPTO_ECDH is not set
>> CONFIG_CRYPTO_MANAGER=y
>> CONFIG_CRYPTO_MANAGER2=y
>> # CONFIG_CRYPTO_USER is not set
>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>> CONFIG_CRYPTO_GF128MUL=y
>> CONFIG_CRYPTO_NULL=y
>> CONFIG_CRYPTO_NULL2=y
>> CONFIG_CRYPTO_PCRYPT=m
>> CONFIG_CRYPTO_WORKQUEUE=y
>> CONFIG_CRYPTO_CRYPTD=y
>> CONFIG_CRYPTO_MCRYPTD=y
>> CONFIG_CRYPTO_AUTHENC=m
>> # CONFIG_CRYPTO_TEST is not set
>> CONFIG_CRYPTO_SIMD=y
>> CONFIG_CRYPTO_GLUE_HELPER_X86=y
>>
>> #
>> # Authenticated Encryption with Associated Data
>> #
>> CONFIG_CRYPTO_CCM=m
>> CONFIG_CRYPTO_GCM=y
>> CONFIG_CRYPTO_CHACHA20POLY1305=y
>> CONFIG_CRYPTO_AEGIS128=y
>> # CONFIG_CRYPTO_AEGIS128L is not set
>> CONFIG_CRYPTO_AEGIS256=m
>> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
>> CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=m
>> # CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
>> # CONFIG_CRYPTO_MORUS640 is not set
>> CONFIG_CRYPTO_MORUS640_GLUE=m
>> CONFIG_CRYPTO_MORUS640_SSE2=m
>> CONFIG_CRYPTO_MORUS1280=m
>> CONFIG_CRYPTO_MORUS1280_GLUE=m
>> CONFIG_CRYPTO_MORUS1280_SSE2=m
>> CONFIG_CRYPTO_MORUS1280_AVX2=m
>> CONFIG_CRYPTO_SEQIV=y
>> CONFIG_CRYPTO_ECHAINIV=m
>>
>> #
>> # Block modes
>> #
>> CONFIG_CRYPTO_CBC=m
>> CONFIG_CRYPTO_CFB=m
>> CONFIG_CRYPTO_CTR=y
>> CONFIG_CRYPTO_CTS=m
>> CONFIG_CRYPTO_ECB=y
>> CONFIG_CRYPTO_LRW=y
>> CONFIG_CRYPTO_PCBC=y
>> CONFIG_CRYPTO_XTS=y
>> CONFIG_CRYPTO_KEYWRAP=m
>>
>> #
>> # Hash modes
>> #
>> CONFIG_CRYPTO_CMAC=m
>> CONFIG_CRYPTO_HMAC=y
>> CONFIG_CRYPTO_XCBC=m
>> CONFIG_CRYPTO_VMAC=y
>>
>> #
>> # Digest
>> #
>> CONFIG_CRYPTO_CRC32C=y
>> CONFIG_CRYPTO_CRC32C_INTEL=y
>> # CONFIG_CRYPTO_CRC32 is not set
>> CONFIG_CRYPTO_CRC32_PCLMUL=y
>> CONFIG_CRYPTO_CRCT10DIF=y
>> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
>> CONFIG_CRYPTO_GHASH=y
>> CONFIG_CRYPTO_POLY1305=y
>> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
>> CONFIG_CRYPTO_MD4=y
>> CONFIG_CRYPTO_MD5=m
>> CONFIG_CRYPTO_MICHAEL_MIC=y
>> CONFIG_CRYPTO_RMD128=y
>> # CONFIG_CRYPTO_RMD160 is not set
>> CONFIG_CRYPTO_RMD256=m
>> CONFIG_CRYPTO_RMD320=m
>> CONFIG_CRYPTO_SHA1=y
>> # CONFIG_CRYPTO_SHA1_SSSE3 is not set
>> # CONFIG_CRYPTO_SHA256_SSSE3 is not set
>> CONFIG_CRYPTO_SHA512_SSSE3=y
>> CONFIG_CRYPTO_SHA1_MB=y
>> CONFIG_CRYPTO_SHA256_MB=y
>> # CONFIG_CRYPTO_SHA512_MB is not set
>> CONFIG_CRYPTO_SHA256=y
>> CONFIG_CRYPTO_SHA512=y
>> CONFIG_CRYPTO_SHA3=y
>> CONFIG_CRYPTO_SM3=y
>> CONFIG_CRYPTO_TGR192=y
>> # CONFIG_CRYPTO_WP512 is not set
>> # CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
>>
>> #
>> # Ciphers
>> #
>> CONFIG_CRYPTO_AES=y
>> CONFIG_CRYPTO_AES_TI=m
>> CONFIG_CRYPTO_AES_X86_64=y
>> CONFIG_CRYPTO_AES_NI_INTEL=y
>> CONFIG_CRYPTO_ANUBIS=m
>> CONFIG_CRYPTO_ARC4=m
>> CONFIG_CRYPTO_BLOWFISH=y
>> CONFIG_CRYPTO_BLOWFISH_COMMON=y
>> CONFIG_CRYPTO_BLOWFISH_X86_64=m
>> # CONFIG_CRYPTO_CAMELLIA is not set
>> CONFIG_CRYPTO_CAMELLIA_X86_64=y
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
>> CONFIG_CRYPTO_CAST_COMMON=m
>> CONFIG_CRYPTO_CAST5=m
>> CONFIG_CRYPTO_CAST5_AVX_X86_64=m
>> CONFIG_CRYPTO_CAST6=m
>> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
>> CONFIG_CRYPTO_DES=m
>> CONFIG_CRYPTO_DES3_EDE_X86_64=m
>> CONFIG_CRYPTO_FCRYPT=m
>> CONFIG_CRYPTO_KHAZAD=m
>> CONFIG_CRYPTO_SALSA20=m
>> CONFIG_CRYPTO_CHACHA20=y
>> CONFIG_CRYPTO_CHACHA20_X86_64=m
>> # CONFIG_CRYPTO_SEED is not set
>> CONFIG_CRYPTO_SERPENT=y
>> # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
>> CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
>> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
>> CONFIG_CRYPTO_SM4=m
>> CONFIG_CRYPTO_SPECK=y
>> # CONFIG_CRYPTO_TEA is not set
>> CONFIG_CRYPTO_TWOFISH=m
>> CONFIG_CRYPTO_TWOFISH_COMMON=m
>> CONFIG_CRYPTO_TWOFISH_X86_64=m
>> # CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
>> # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
>>
>> #
>> # Compression
>> #
>> CONFIG_CRYPTO_DEFLATE=m
>> CONFIG_CRYPTO_LZO=y
>> CONFIG_CRYPTO_842=m
>> # CONFIG_CRYPTO_LZ4 is not set
>> CONFIG_CRYPTO_LZ4HC=y
>> CONFIG_CRYPTO_ZSTD=y
>>
>> #
>> # Random Number Generation
>> #
>> # CONFIG_CRYPTO_ANSI_CPRNG is not set
>> CONFIG_CRYPTO_DRBG_MENU=y
>> CONFIG_CRYPTO_DRBG_HMAC=y
>> CONFIG_CRYPTO_DRBG_HASH=y
>> CONFIG_CRYPTO_DRBG_CTR=y
>> CONFIG_CRYPTO_DRBG=y
>> CONFIG_CRYPTO_JITTERENTROPY=y
>> # CONFIG_CRYPTO_USER_API_HASH is not set
>> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
>> # CONFIG_CRYPTO_USER_API_RNG is not set
>> # CONFIG_CRYPTO_USER_API_AEAD is not set
>> CONFIG_CRYPTO_HASH_INFO=y
>> # CONFIG_CRYPTO_HW is not set
>> CONFIG_ASYMMETRIC_KEY_TYPE=y
>> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
>> CONFIG_X509_CERTIFICATE_PARSER=y
>> CONFIG_PKCS7_MESSAGE_PARSER=y
>>
>> #
>> # Certificates for signature checking
>> #
>> CONFIG_SYSTEM_TRUSTED_KEYRING=y
>> CONFIG_SYSTEM_TRUSTED_KEYS=""
>> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
>> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
>> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
>> CONFIG_HAVE_KVM=y
>> # CONFIG_VIRTUALIZATION is not set
>>
>> #
>> # Library routines
>> #
>> CONFIG_RAID6_PQ=m
>> CONFIG_BITREVERSE=y
>> CONFIG_RATIONAL=y
>> CONFIG_GENERIC_STRNCPY_FROM_USER=y
>> CONFIG_GENERIC_STRNLEN_USER=y
>> CONFIG_GENERIC_NET_UTILS=y
>> CONFIG_GENERIC_FIND_FIRST_BIT=y
>> CONFIG_GENERIC_PCI_IOMAP=y
>> CONFIG_GENERIC_IOMAP=y
>> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
>> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
>> CONFIG_CRC_CCITT=m
>> CONFIG_CRC16=y
>> CONFIG_CRC_T10DIF=y
>> CONFIG_CRC_ITU_T=y
>> CONFIG_CRC32=y
>> # CONFIG_CRC32_SELFTEST is not set
>> # CONFIG_CRC32_SLICEBY8 is not set
>> CONFIG_CRC32_SLICEBY4=y
>> # CONFIG_CRC32_SARWATE is not set
>> # CONFIG_CRC32_BIT is not set
>> # CONFIG_CRC4 is not set
>> CONFIG_CRC7=y
>> CONFIG_LIBCRC32C=y
>> CONFIG_CRC8=y
>> CONFIG_XXHASH=y
>> # CONFIG_RANDOM32_SELFTEST is not set
>> CONFIG_842_COMPRESS=m
>> CONFIG_842_DECOMPRESS=m
>> CONFIG_ZLIB_INFLATE=y
>> CONFIG_ZLIB_DEFLATE=m
>> CONFIG_LZO_COMPRESS=y
>> CONFIG_LZO_DECOMPRESS=y
>> CONFIG_LZ4HC_COMPRESS=y
>> CONFIG_LZ4_DECOMPRESS=y
>> CONFIG_ZSTD_COMPRESS=y
>> CONFIG_ZSTD_DECOMPRESS=y
>> CONFIG_XZ_DEC=y
>> CONFIG_XZ_DEC_X86=y
>> # CONFIG_XZ_DEC_POWERPC is not set
>> CONFIG_XZ_DEC_IA64=y
>> CONFIG_XZ_DEC_ARM=y
>> # CONFIG_XZ_DEC_ARMTHUMB is not set
>> CONFIG_XZ_DEC_SPARC=y
>> CONFIG_XZ_DEC_BCJ=y
>> CONFIG_XZ_DEC_TEST=y
>> CONFIG_DECOMPRESS_GZIP=y
>> CONFIG_DECOMPRESS_BZIP2=y
>> CONFIG_DECOMPRESS_LZMA=y
>> CONFIG_DECOMPRESS_XZ=y
>> CONFIG_DECOMPRESS_LZO=y
>> CONFIG_DECOMPRESS_LZ4=y
>> CONFIG_REED_SOLOMON=y
>> CONFIG_REED_SOLOMON_ENC8=y
>> CONFIG_REED_SOLOMON_DEC8=y
>> CONFIG_INTERVAL_TREE=y
>> CONFIG_RADIX_TREE_MULTIORDER=y
>> CONFIG_ASSOCIATIVE_ARRAY=y
>> CONFIG_HAS_IOMEM=y
>> CONFIG_HAS_IOPORT_MAP=y
>> CONFIG_HAS_DMA=y
>> CONFIG_NEED_SG_DMA_LENGTH=y
>> CONFIG_NEED_DMA_MAP_STATE=y
>> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
>> CONFIG_DMA_DIRECT_OPS=y
>> CONFIG_SWIOTLB=y
>> CONFIG_SGL_ALLOC=y
>> CONFIG_CPUMASK_OFFSTACK=y
>> CONFIG_CPU_RMAP=y
>> CONFIG_DQL=y
>> CONFIG_GLOB=y
>> CONFIG_GLOB_SELFTEST=y
>> CONFIG_NLATTR=y
>> CONFIG_CLZ_TAB=y
>> CONFIG_CORDIC=y
>> CONFIG_DDR=y
>> # CONFIG_IRQ_POLL is not set
>> CONFIG_MPILIB=y
>> CONFIG_OID_REGISTRY=y
>> CONFIG_SG_POOL=y
>> CONFIG_ARCH_HAS_SG_CHAIN=y
>> CONFIG_ARCH_HAS_PMEM_API=y
>> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
>> CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
>> CONFIG_STACKDEPOT=y
>> CONFIG_SBITMAP=y
>> CONFIG_STRING_SELFTEST=y
>> #!/bin/sh
>>
>> export_top_env()
>> {
>> 	export suite='boot'
>> 	export testcase='boot'
>> 	export timeout='10m'
>> 	export job_origin='/lkp/lkp/src/jobs/boot.yaml'
>> 	export queue='bisect'
>> 	export testbox='vm-vp-quantal-x86_64-41'
>> 	export tbox_group='vm-vp-quantal-x86_64'
>> 	export branch='linux-next/master'
>> 	export commit='c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29'
>> 	export kconfig='x86_64-randconfig-u0-07260416'
>> 	export submit_id='5b5928350b9a934aac52e0f4'
>> 	export job_file='/lkp/scheduled/vm-vp-quantal-x86_64-41/boot-1-quantal-core-x86_64.cgz-c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29-20180726-84652-ljq6u5-0.yaml'
>> 	export id='fc13bd4c51afc9986d98447824ceff51ebf16828'
>> 	export model='qemu-system-x86_64 -enable-kvm'
>> 	export nr_vm=64
>> 	export nr_cpu=2
>> 	export memory='512M'
>> 	export rootfs='quantal-core-x86_64.cgz'
>> 	export need_kconfig='CONFIG_KVM_GUEST=y'
>> 	export compiler='gcc-5'
>> 	export enqueue_time='2018-07-26 09:47:33 +0800'
>> 	export _id='5b5928350b9a934aac52e0f4'
>> 	export _rt='/result/boot/1/vm-vp-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-u0-07260416/gcc-5/c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29'
>> 	export user='lkp'
>> 	export result_root='/result/boot/1/vm-vp-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-u0-07260416/gcc-5/c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29/0'
>> 	export LKP_SERVER='inn'
>> 	export max_uptime=600
>> 	export initrd='/osimage/quantal/quantal-core-x86_64.cgz'
>> 	export bootloader_append='root=/dev/ram0
>> user=lkp
>> job=/lkp/scheduled/vm-vp-quantal-x86_64-41/boot-1-quantal-core-x86_64.cgz-c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29-20180726-84652-ljq6u5-0.yaml
>> ARCH=x86_64
>> kconfig=x86_64-randconfig-u0-07260416
>> branch=linux-next/master
>> commit=c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29
>> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-u0-07260416/gcc-5/c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29/vmlinuz-4.18.0-rc5-00455-gc1e4c54
>> max_uptime=600
>> RESULT_ROOT=/result/boot/1/vm-vp-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-u0-07260416/gcc-5/c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29/0
>> LKP_SERVER=inn
>> debug
>> apic=debug
>> sysrq_always_enabled
>> rcupdate.rcu_cpu_stall_timeout=100
>> net.ifnames=0
>> printk.devkmsg=on
>> panic=-1
>> softlockup_panic=1
>> nmi_watchdog=panic
>> oops=panic
>> load_ramdisk=2
>> prompt_ramdisk=0
>> drbd.minor_count=8
>> systemd.log_level=err
>> ignore_loglevel
>> console=tty0
>> earlyprintk=ttyS0,115200
>> console=ttyS0,115200
>> vga=normal
>> rw'
>> 	export modules_initrd='/pkg/linux/x86_64-randconfig-u0-07260416/gcc-5/c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29/modules.cgz'
>> 	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
>> 	export site='inn'
>> 	export LKP_CGI_PORT=80
>> 	export LKP_CIFS_PORT=139
>> 	export kernel='/pkg/linux/x86_64-randconfig-u0-07260416/gcc-5/c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29/vmlinuz-4.18.0-rc5-00455-gc1e4c54'
>> 	export dequeue_time='2018-07-26 09:56:07 +0800'
>> 	export job_initrd='/lkp/scheduled/vm-vp-quantal-x86_64-41/boot-1-quantal-core-x86_64.cgz-c1e4c54f9c750fc3ea4715f5363b92ea4d4efb29-20180726-84652-ljq6u5-0.cgz'
>>
>> 	[ -n "$LKP_SRC" ] ||
>> 	export LKP_SRC=/lkp/${user:-lkp}/src
>> }
>>
>> run_job()
>> {
>> 	echo $$ > $TMP/run-job.pid
>>
>> 	. $LKP_SRC/lib/http.sh
>> 	. $LKP_SRC/lib/job.sh
>> 	. $LKP_SRC/lib/env.sh
>>
>> 	export_top_env
>>
>> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
>> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
>> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
>> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
>> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
>> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
>> 	run_monitor $LKP_SRC/monitors/plain/watchdog
>>
>> 	run_test $LKP_SRC/tests/wrapper sleep 1
>> }
>>
>> extract_stats()
>> {
>> 	$LKP_SRC/stats/wrapper boot-slabinfo
>> 	$LKP_SRC/stats/wrapper boot-meminfo
>> 	$LKP_SRC/stats/wrapper memmap
>> 	$LKP_SRC/stats/wrapper boot-memory
>> 	$LKP_SRC/stats/wrapper boot-time
>> 	$LKP_SRC/stats/wrapper kernel-size
>> 	$LKP_SRC/stats/wrapper kmsg
>>
>> 	$LKP_SRC/stats/wrapper time sleep.time
>> 	$LKP_SRC/stats/wrapper time
>> 	$LKP_SRC/stats/wrapper dmesg
>> 	$LKP_SRC/stats/wrapper kmsg
>> 	$LKP_SRC/stats/wrapper stderr
>> 	$LKP_SRC/stats/wrapper last_state
>> }
>>
>> "$@"
>
>

