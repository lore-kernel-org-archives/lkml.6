Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093A214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F093A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeLFE7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:59:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:47109 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbeLFE7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:59:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 20:59:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,321,1539673200"; 
   d="scan'208";a="116431140"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2018 20:59:02 -0800
Date:   Thu, 6 Dec 2018 12:59:17 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, s.priebe@profihost.ag,
        lkp@01.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mhocko@kernel.org, alex.williamson@redhat.com,
        zi.yan@cs.rutgers.edu, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [patch v2 for-4.20] mm, thp: restore node-local hugepage
 allocations
Message-ID: <20181206045917.GG23332@shao2-debian>
References: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:46:50PM -0800, David Rientjes wrote:
> This is a full revert of ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
> MADV_HUGEPAGE mappings") and a partial revert of 89c83fb539f9 ("mm, thp:
> consolidate THP gfp handling into alloc_hugepage_direct_gfpmask").
> 
> By not setting __GFP_THISNODE, applications can allocate remote hugepages
> when the local node is fragmented or low on memory when either the thp
> defrag setting is "always" or the vma has been madvised with
> MADV_HUGEPAGE.
> 
> Remote access to hugepages often has much higher latency than local pages
> of the native page size.  On Haswell, ac5b2c18911f was shown to have a
> 13.9% access regression after this commit for binaries that remap their
> text segment to be backed by transparent hugepages.
> 
> The intent of ac5b2c18911f is to address an issue where a local node is
> low on memory or fragmented such that a hugepage cannot be allocated.  In
> every scenario where this was described as a fix, there is abundant and
> unfragmented remote memory available to allocate from, even with a greater
> access latency.
> 
> If remote memory is also low or fragmented, not setting __GFP_THISNODE was
> also measured on Haswell to have a 40% regression in allocation latency.
> 
> Restore __GFP_THISNODE for thp allocations.
> 
> Fixes: ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings")
> Fixes: 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask")
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  include/linux/mempolicy.h |  2 --
>  mm/huge_memory.c          | 42 +++++++++++++++------------------------
>  mm/mempolicy.c            |  2 +-
>  3 files changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -139,8 +139,6 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
>  struct mempolicy *get_task_policy(struct task_struct *p);
>  struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
>  		unsigned long addr);
> -struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
> -						unsigned long addr);
>  bool vma_policy_mof(struct vm_area_struct *vma);
>  
>  extern void numa_default_policy(void);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -632,37 +632,27 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
> -	gfp_t this_node = 0;
> -
> -#ifdef CONFIG_NUMA
> -	struct mempolicy *pol;
> -	/*
> -	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
> -	 * specified, to express a general desire to stay on the current
> -	 * node for optimistic allocation attempts. If the defrag mode
> -	 * and/or madvise hint requires the direct reclaim then we prefer
> -	 * to fallback to other node rather than node reclaim because that
> -	 * can lead to excessive reclaim even though there is free memory
> -	 * on other nodes. We expect that NUMA preferences are specified
> -	 * by memory policies.
> -	 */
> -	pol = get_vma_policy(vma, addr);
> -	if (pol->mode != MPOL_BIND)
> -		this_node = __GFP_THISNODE;
> -	mpol_cond_put(pol);
> -#endif
> +	const gfp_t gfp_mask = GFP_TRANSHUGE_LIGHT | __GFP_THISNODE;
>  
> +	/* Always do synchronous compaction */
>  	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
> -		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
> +		return GFP_TRANSHUGE | __GFP_THISNODE |
> +		       (vma_madvised ? 0 : __GFP_NORETRY);
> +
> +	/* Kick kcompactd and fail quickly */
>  	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
> -		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM | this_node;
> +		return gfp_mask | __GFP_KSWAPD_RECLAIM;
> +
> +	/* Synchronous compaction if madvised, otherwise kick kcompactd */
>  	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
> -		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
> -							     __GFP_KSWAPD_RECLAIM | this_node);
> +		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM :
> +						  __GFP_KSWAPD_RECLAIM);
> +
> +	/* Only do synchronous compaction if madvised */
>  	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
> -		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
> -							     this_node);
> -	return GFP_TRANSHUGE_LIGHT | this_node;
> +		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
> +
> +	return gfp_mask;
>  }
>  
>  /* Caller must hold page table lock. */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1662,7 +1662,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
>   * freeing by another task.  It is the caller's responsibility to free the
>   * extra reference for shared policies.
>   */
> -struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
> +static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  						unsigned long addr)
>  {
>  	struct mempolicy *pol = __get_vma_policy(vma, addr);
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp

Hi,

FYI, we noticed no regression of vm-scalability.throughput between the two commits.

tests: 1
testcase/path_params/tbox_group/run: vm-scalability/300-always-always-32-1-swap-w-seq-ucode=0x3d-performance/lkp-hsw-ep4

commit: 
  94e297c50b ("include/linux/notifier.h: SRCU: fix ctags")
  2f0799a0ff ("mm, thp: restore node-local hugepage allocations")

94e297c50b529f5d  2f0799a0ffc033bf3cc82d5032  
----------------  --------------------------  
         %stddev      change         %stddev
             \          |                \  
    425945 ±  9%        36%     578453 ± 18%  vm-scalability.time.minor_page_faults
       322                         313        vm-scalability.time.user_time
    905482 ±  5%        20%    1087102 ±  9%  perf-stat.page-faults
    901474 ±  5%        20%    1081707 ±  9%  perf-stat.minor-faults
    425945 ±  9%        36%     578453 ± 18%  time.minor_page_faults
       322                         313        time.user_time
      6792 ±  5%       -10%       6097        vmstat.system.cs
   1625177 ±  4%       -11%    1446045        vmstat.swap.so
   1625189 ±  4%       -11%    1446055        vmstat.io.bo
    171516 ±  5%       -24%     131111 ± 24%  vmstat.system.in
    157193 ± 15%        46%     230011 ± 20%  proc-vmstat.pgactivate
    559397 ±  8%        45%     809533 ± 12%  proc-vmstat.pgscan_direct
    207042 ±  8%        43%     295574 ± 10%  proc-vmstat.pgsteal_direct
   5852284 ± 12%        42%    8294341 ± 20%  proc-vmstat.slabs_scanned
    211428 ±  6%        39%     293175 ±  6%  proc-vmstat.pgrefill
    135763 ±  9%        39%     188155 ±  3%  proc-vmstat.nr_vmscan_write
    220023 ±  5%        38%     303404 ±  6%  proc-vmstat.nr_written
    219051 ±  5%        38%     301549 ±  6%  proc-vmstat.pgrotated
      1018 ± 10%        36%       1383 ±  4%  proc-vmstat.nr_zone_write_pending
      1017 ± 10%        36%       1379 ±  4%  proc-vmstat.nr_writeback
    919059 ±  4%        20%    1102507 ±  9%  proc-vmstat.pgfault
   1108142 ±  9%        16%    1285859 ±  5%  proc-vmstat.numa_local
   1122389 ±  9%        16%    1302063 ±  5%  proc-vmstat.numa_hit
    715724              -5%     682381 ±  4%  proc-vmstat.nr_file_pages
      5784 ±  6%        -5%       5482 ±  7%  proc-vmstat.nr_mapped
    266928             -16%     223157        proc-vmstat.nr_zone_unevictable
    266928             -16%     223157        proc-vmstat.nr_unevictable
         0            4e+05     428930 ±139%  latency_stats.avg.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled._copy_to_user.do_syslog.kmsg_read
     11973 ± 70%      3e+05     298302 ± 83%  latency_stats.avg.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_enhanced_fast_string._copy_to_user.do_syslog.kmsg_read
     17650 ± 35%      2e+05     265410 ± 84%  latency_stats.avg.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.strnlen_user.copy_strings.__do_execve_file.__x64_sys_execve
      9801 ± 42%      5e+04      61121 ±112%  latency_stats.avg.io_schedule.__lock_page.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__get_user_pages.get_user_pages_remote.__access_remote_vm.proc_pid_cmdline_read.__vfs_read.vfs_read
         0            3e+04      25998 ±141%  latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
         0            6e+03       6202 ±141%  latency_stats.avg.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.read_swap_cache_async.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_fault
         0            5e+03       5457 ±141%  latency_stats.avg.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.swapin_readahead.do_swap_page.__handle_mm_fault.handle_mm_fault.__get_user_pages
      4585 ±173%     -5e+03          0        latency_stats.avg.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_fault.__do_fault
      6229 ±173%     -6e+03          0        latency_stats.avg.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.read_swap_cache_async.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_write_begin
     37391 ±173%     -4e+04          0        latency_stats.avg.io_schedule.wait_on_page_bit.shmem_getpage_gfp.shmem_fault.__do_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
     52525 ±100%     -5e+04          0        latency_stats.avg.msleep.shrink_inactive_list.shrink_node_memcg.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.__do_page_fault
    141825 ±172%     -1e+05        590 ±126%  latency_stats.avg.io_schedule.__lock_page.shmem_getpage_gfp.shmem_file_read_iter.__vfs_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
    240110 ±124%     -2e+05       2543 ±141%  latency_stats.avg.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled._copy_to_user.perf_read.__vfs_read
    272115 ±171%     -3e+05       6043 ± 71%  latency_stats.avg.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled.core_sys_select.kern_select.__x64_sys_select
    538363 ± 77%     -4e+05     136003 ± 68%  latency_stats.avg.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_enhanced_fast_string.copyout._copy_to_iter.skb_copy_datagram_iter
     23857 ± 26%      1e+06    1035782 ± 71%  latency_stats.max.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.strnlen_user.copy_strings.__do_execve_file.__x64_sys_execve
     11973 ± 70%      8e+05     778555 ± 70%  latency_stats.max.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_enhanced_fast_string._copy_to_user.do_syslog.kmsg_read
         0            4e+05     428930 ±139%  latency_stats.max.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled._copy_to_user.do_syslog.kmsg_read
         0            3e+04      25998 ±141%  latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
         0            8e+03       7916 ±141%  latency_stats.max.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.read_swap_cache_async.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_fault
         0            7e+03       6751 ±141%  latency_stats.max.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.swapin_readahead.do_swap_page.__handle_mm_fault.handle_mm_fault.__get_user_pages
      4585 ±173%     -5e+03          0        latency_stats.max.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_fault.__do_fault
      6229 ±173%     -6e+03          0        latency_stats.max.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.read_swap_cache_async.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_write_begin
      7425 ±117%     -7e+03         68 ±  7%  latency_stats.max.smp_call_on_cpu.lockup_detector_reconfigure.proc_watchdog_common.proc_sys_call_handler.__vfs_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52680 ±100%     -5e+04          0        latency_stats.max.msleep.shrink_inactive_list.shrink_node_memcg.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.__do_page_fault
    107626 ±173%     -1e+05          0        latency_stats.max.io_schedule.wait_on_page_bit.shmem_getpage_gfp.shmem_fault.__do_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
    272938 ±170%     -3e+05      16767 ± 71%  latency_stats.max.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled.core_sys_select.kern_select.__x64_sys_select
    284952 ±170%     -3e+05        592 ±125%  latency_stats.max.io_schedule.__lock_page.shmem_getpage_gfp.shmem_file_read_iter.__vfs_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
    357768 ±136%     -4e+05       2543 ±141%  latency_stats.max.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled._copy_to_user.perf_read.__vfs_read
   1155510 ± 48%      9e+06    9751594 ±110%  latency_stats.sum.io_schedule.__lock_page.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__get_user_pages.get_user_pages_remote.__access_remote_vm.proc_pid_cmdline_read.__vfs_read.vfs_read
   4573026 ± 77%      8e+06   12847407 ±122%  latency_stats.sum.io_schedule.wait_on_page_bit.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.__vfs_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48641 ± 48%      2e+06    2342957 ± 71%  latency_stats.sum.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.strnlen_user.copy_strings.__do_execve_file.__x64_sys_execve
     11973 ± 70%      8e+05     788601 ± 70%  latency_stats.sum.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_enhanced_fast_string._copy_to_user.do_syslog.kmsg_read
         0            4e+05     428930 ±139%  latency_stats.sum.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled._copy_to_user.do_syslog.kmsg_read
         0            4e+04      38202 ±141%  latency_stats.sum.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.swapin_readahead.do_swap_page.__handle_mm_fault.handle_mm_fault.__get_user_pages
         0            3e+04      25998 ±141%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
         0            2e+04      18607 ±141%  latency_stats.sum.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.read_swap_cache_async.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_fault
      4585 ±173%     -5e+03          0        latency_stats.sum.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_fault.__do_fault
      8048 ± 99%     -5e+03       3141 ± 60%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      6229 ±173%     -6e+03          0        latency_stats.sum.io_schedule.blk_mq_get_tag.blk_mq_get_request.blk_mq_make_request.generic_make_request.submit_bio.swap_readpage.read_swap_cache_async.swap_cluster_readahead.shmem_swapin.shmem_getpage_gfp.shmem_write_begin
     10774 ± 82%     -7e+03       3648 ±  5%  latency_stats.sum.smp_call_on_cpu.lockup_detector_reconfigure.proc_watchdog_common.proc_sys_call_handler.__vfs_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    112174 ±173%     -1e+05          0        latency_stats.sum.io_schedule.wait_on_page_bit.shmem_getpage_gfp.shmem_fault.__do_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
    157878 ±137%     -2e+05          0        latency_stats.sum.msleep.shrink_inactive_list.shrink_node_memcg.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.__do_page_fault
    275908 ±168%     -3e+05      18129 ± 71%  latency_stats.sum.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled.core_sys_select.kern_select.__x64_sys_select
    285059 ±170%     -3e+05        633 ±113%  latency_stats.sum.io_schedule.__lock_page.shmem_getpage_gfp.shmem_file_read_iter.__vfs_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
    427767 ±141%     -4e+05       2543 ±141%  latency_stats.sum.io_schedule.__lock_page_or_retry.do_swap_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.copy_user_generic_unrolled._copy_to_user.perf_read.__vfs_read

Best Regards,
Rong Chen
