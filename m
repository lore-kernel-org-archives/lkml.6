Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8830B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfBFNgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfBFNgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:36:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4B7789ACD;
        Wed,  6 Feb 2019 13:36:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 111A061549;
        Wed,  6 Feb 2019 13:36:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  6 Feb 2019 14:36:05 +0100 (CET)
Date:   Wed, 6 Feb 2019 14:36:02 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sherry Yang <sherryy@android.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     srikar@linux.vnet.ibm.com, songliubraving@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com,
        syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
Subject: Re: [PATCH] Uprobes: Fix deadlock between delayed_uprobe_lock and
 fs_reclaim
Message-ID: <20190206133601.GA21522@redhat.com>
References: <20190204040614.20450-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204040614.20450-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 06 Feb 2019 13:36:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi, I am on vacation till the end of this week, can't read your patch
carefully.

I am not sure I fully understand the problem, but shouldn't we change
binder_alloc_free_page() to use mmput_async() ? Like it does if trylock
fails.

In any case, I don't think memalloc_nofs_save() is what we need, see below.

On 02/04, Ravi Bangoria wrote:
>
> There can be a deadlock between delayed_uprobe_lock and
> fs_reclaim like:
>
>    CPU0                         CPU1
>    ----                         ----
>    lock(fs_reclaim);
>                                 lock(delayed_uprobe_lock);
>                                 lock(fs_reclaim);
>    lock(delayed_uprobe_lock);
>
> Here CPU0 is a file system code path which results in
> mmput()->__mmput()->uprobe_clear_state() with fs_reclaim
> locked. And, CPU1 is a uprobe event creation path.

But this is false positive, right? if CPU1 calls update_ref_ctr() then
either ->mm_users is already zero so binder_alloc_free_page()->mmget_not_zero()
will fail, or the caller of update_ref_ctr() has a reference and thus
binder_alloc_free_page()->mmput() can't trigger __mmput() ?

>
> This was reported by syzbot at [1]. Though, the reproducer
> is nither available by syzbot nor I can reproduce it locally.
>
> Callchains from syzbot report:
>
>   -> #1 (fs_reclaim){+.+.}:
>      __fs_reclaim_acquire mm/page_alloc.c:3730 [inline]
>      fs_reclaim_acquire.part.97+0x24/0x30 mm/page_alloc.c:3741
>      fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3742
>      slab_pre_alloc_hook mm/slab.h:418 [inline]
>      slab_alloc mm/slab.c:3378 [inline]
>      kmem_cache_alloc_trace+0x2d/0x750 mm/slab.c:3618
>      kmalloc include/linux/slab.h:546 [inline]
>      kzalloc include/linux/slab.h:741 [inline]
>      delayed_uprobe_add kernel/events/uprobes.c:313 [inline]
>      update_ref_ctr+0x36f/0x590 kernel/events/uprobes.c:447
>      uprobe_write_opcode+0x94b/0xc50 kernel/events/uprobes.c:496
>      set_swbp+0x2a/0x40
>      install_breakpoint.isra.24+0x161/0x840 kernel/events/uprobes.c:885
>      register_for_each_vma+0xa38/0xee0 kernel/events/uprobes.c:1041
>      uprobe_apply+0xee/0x140 kernel/events/uprobes.c:1192
>      uprobe_perf_open kernel/trace/trace_uprobe.c:1087 [inline]
>      trace_uprobe_register+0x771/0xcf0 kernel/trace/trace_uprobe.c:1227
>      perf_trace_event_open kernel/trace/trace_event_perf.c:181 [inline]
>      perf_trace_event_init+0x1a5/0x990 kernel/trace/trace_event_perf.c:203
>      perf_uprobe_init+0x1f1/0x280 kernel/trace/trace_event_perf.c:329
>      perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8503
>      perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9770
>      perf_init_event kernel/events/core.c:9801 [inline]
>      perf_event_alloc.part.94+0x1d54/0x3740 kernel/events/core.c:10074
>      perf_event_alloc kernel/events/core.c:10430 [inline]
>      __do_sys_perf_event_open+0xada/0x3020 kernel/events/core.c:10531
>      __se_sys_perf_event_open kernel/events/core.c:10420 [inline]
>      __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10420
>      do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>   -> #0 (delayed_uprobe_lock){+.+.}:
>      lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
>      __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>      __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
>      mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>      uprobe_clear_state+0xb4/0x390 kernel/events/uprobes.c:1511
>      __mmput kernel/fork.c:1041 [inline]
>      mmput+0x1bc/0x610 kernel/fork.c:1066
>      binder_alloc_free_page+0x5ab/0x1520 drivers/android/binder_alloc.c:983
>      __list_lru_walk_one+0x29d/0x8c0 mm/list_lru.c:234
>      list_lru_walk_one+0xa5/0xe0 mm/list_lru.c:278
>      list_lru_walk_node+0x43/0x280 mm/list_lru.c:307
>      list_lru_walk include/linux/list_lru.h:214 [inline]
>      binder_shrink_scan+0x164/0x220 drivers/android/binder_alloc.c:1019
>      do_shrink_slab+0x501/0xd30 mm/vmscan.c:557
>      shrink_slab+0x389/0x8c0 mm/vmscan.c:706
>      shrink_node+0x431/0x16b0 mm/vmscan.c:2758
>      shrink_zones mm/vmscan.c:2987 [inline]
>      do_try_to_free_pages+0x3e7/0x1290 mm/vmscan.c:3049
>      try_to_free_pages+0x4d0/0xb90 mm/vmscan.c:3264
>      __perform_reclaim mm/page_alloc.c:3773 [inline]
>      __alloc_pages_direct_reclaim mm/page_alloc.c:3795 [inline]
>      __alloc_pages_slowpath+0xa48/0x2de0 mm/page_alloc.c:4185
>      __alloc_pages_nodemask+0xad8/0xea0 mm/page_alloc.c:4393
>      __alloc_pages include/linux/gfp.h:473 [inline]
>      __alloc_pages_node include/linux/gfp.h:486 [inline]
>      khugepaged_alloc_page+0x95/0x190 mm/khugepaged.c:773
>      collapse_huge_page mm/khugepaged.c:963 [inline]
>      khugepaged_scan_pmd+0x1715/0x3d60 mm/khugepaged.c:1216
>      khugepaged_scan_mm_slot mm/khugepaged.c:1725 [inline]
>      khugepaged_do_scan mm/khugepaged.c:1806 [inline]
>      khugepaged+0xf20/0x1750 mm/khugepaged.c:1851
>      kthread+0x35a/0x440 kernel/kthread.c:246
>      ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
>
> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1876397.html
>
> Reported-by: syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  kernel/events/uprobes.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 8aef47ee7bfa..8be39a83d83a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -95,6 +95,11 @@ struct delayed_uprobe {
>  	struct mm_struct *mm;
>  };
>
> +/*
> + * Any memory allocation happening within lock(delayed_uprobe_lock)
> + * must use memalloc_nofs_save()/memalloc_nofs_restore() to avoid
> + * calling file system code from memory allocation code.
> + */
>  static DEFINE_MUTEX(delayed_uprobe_lock);
>  static LIST_HEAD(delayed_uprobe_list);
>
> @@ -429,6 +434,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>  	struct vm_area_struct *rc_vma;
>  	unsigned long rc_vaddr;
>  	int ret = 0;
> +	unsigned int nofs_flags;
>
>  	rc_vma = find_ref_ctr_vma(uprobe, mm);
>
> @@ -442,12 +448,30 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>  			return ret;
>  	}
>
> +	/*
> +	 * There is a possibility of deadlock here:
> +	 *
> +	 *   CPU0                         CPU1
> +	 *   ----                         ----
> +	 *   lock(fs_reclaim);
> +	 *                                lock(delayed_uprobe_lock);
> +	 *                                lock(fs_reclaim);
> +	 *   lock(delayed_uprobe_lock);
> +	 *
> +	 * Here CPU0 is a file system code path which results in
> +	 * mmput()->__mmput()->uprobe_clear_state() with fs_reclaim locked.
> +	 * And, CPU1 is a uprobe event creation path.
> +	 *
> +	 * Avoid calling into filesystem code inside lock(delayed_uprobe_lock).
> +	 */
> +	nofs_flags = memalloc_nofs_save();
>  	mutex_lock(&delayed_uprobe_lock);
>  	if (d > 0)
>  		ret = delayed_uprobe_add(uprobe, mm);
>  	else
>  		delayed_uprobe_remove(uprobe, mm);
>  	mutex_unlock(&delayed_uprobe_lock);
> +	memalloc_nofs_restore(nofs_flags);

PF_MEMALLOC_NOFS is only needed when we are going to call delayed_uprobe_add()
which does kzalloc(GFP_KERNEL). Can't we simply change it tuse use use GFP_NOFS
instead?

Oleg.

