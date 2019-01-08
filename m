Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDE2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CF02087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c6uth8l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfAHNJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:09:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHNJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aJfETV2ZNSBh9jB8RrwtALjUNveVKHXuYpimJ/9KYFM=; b=c6uth8l7qWttsdU0f3E4rlHxk
        yHElvu6V5299Y2o3IJVRQ192cB8k/baHpoacj7HhjlrL2byYqzl6EBoL73ggzf5TuFzW26U7qp91e
        AxomtQTgdHJ+u+b1aWGyrn1/rnvTtBJLgT9CLY9KuU8eln1UwrZsbwKQ6YzmxrUmOCPhJ60HDfIMq
        A31TASkIMtfMPB2swwncLx97pc6mMqA6xU52LxlujIN+gxTAttweBuB/phgPZqShVJjn+puHdTbTc
        x82XFgM3o0gxkKo3eVLAYeUNbsa2iGc59D/0pqzZenXl+QzPwaXSPbys+izhnimLWMzaGYcdQcbaR
        e0VhiDBGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggr7k-00062P-21; Tue, 08 Jan 2019 13:08:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50D35201A04B8; Tue,  8 Jan 2019 14:08:49 +0100 (CET)
Date:   Tue, 8 Jan 2019 14:08:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, hannes@cmpxchg.org
Subject: Re: possible deadlock in __wake_up_common_lock
Message-ID: <20190108130849.GF6808@hirez.programming.kicks-ass.net>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 01:51:01PM +0100, Vlastimil Babka wrote:

> > syz-executor0/8529 is trying to acquire lock:
> > 000000005e7fb829 (&pgdat->kswapd_wait){....}, at:  
> > __wake_up_common_lock+0x19e/0x330 kernel/sched/wait.c:120
> 
> From the backtrace at the end of report I see it's coming from
> 
> >   wakeup_kswapd+0x5f0/0x930 mm/vmscan.c:3982
> >   steal_suitable_fallback+0x538/0x830 mm/page_alloc.c:2217
> 
> This wakeup_kswapd is new due to Mel's 1c30844d2dfe ("mm: reclaim small
> amounts of memory when an external fragmentation event occurs") so CC Mel.

Right; and I see Mel already has a fix for that.

> > the existing dependency chain (in reverse order) is:
> > 
> > -> #4 (&(&zone->lock)->rlock){-.-.}:
> >         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >         _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
> >         rmqueue mm/page_alloc.c:3082 [inline]
> >         get_page_from_freelist+0x9eb/0x52a0 mm/page_alloc.c:3491
> >         __alloc_pages_nodemask+0x4f3/0xde0 mm/page_alloc.c:4529
> >         __alloc_pages include/linux/gfp.h:473 [inline]
> >         alloc_page_interleave+0x25/0x1c0 mm/mempolicy.c:1988
> >         alloc_pages_current+0x1bf/0x210 mm/mempolicy.c:2104
> >         alloc_pages include/linux/gfp.h:509 [inline]
> >         depot_save_stack+0x3f1/0x470 lib/stackdepot.c:260
> >         save_stack+0xa9/0xd0 mm/kasan/common.c:79
> >         set_track mm/kasan/common.c:85 [inline]
> >         kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
> >         kasan_slab_alloc+0x12/0x20 mm/kasan/common.c:397
> >         kmem_cache_alloc+0x130/0x730 mm/slab.c:3541
> >         kmem_cache_zalloc include/linux/slab.h:731 [inline]
> >         fill_pool lib/debugobjects.c:134 [inline]
> >         __debug_object_init+0xbb8/0x1290 lib/debugobjects.c:379
> >         debug_object_init lib/debugobjects.c:431 [inline]
> >         debug_object_activate+0x323/0x600 lib/debugobjects.c:512
> >         debug_timer_activate kernel/time/timer.c:708 [inline]
> >         debug_activate kernel/time/timer.c:763 [inline]
> >         __mod_timer kernel/time/timer.c:1040 [inline]
> >         mod_timer kernel/time/timer.c:1101 [inline]
> >         add_timer+0x50e/0x1490 kernel/time/timer.c:1137
> >         __queue_delayed_work+0x249/0x380 kernel/workqueue.c:1533
> >         queue_delayed_work_on+0x1a2/0x1f0 kernel/workqueue.c:1558
> >         queue_delayed_work include/linux/workqueue.h:527 [inline]
> >         schedule_delayed_work include/linux/workqueue.h:628 [inline]
> >         start_dirtytime_writeback+0x4e/0x53 fs/fs-writeback.c:2043
> >         do_one_initcall+0x145/0x957 init/main.c:889
> >         do_initcall_level init/main.c:957 [inline]
> >         do_initcalls init/main.c:965 [inline]
> >         do_basic_setup init/main.c:983 [inline]
> >         kernel_init_freeable+0x4c1/0x5af init/main.c:1136
> >         kernel_init+0x11/0x1ae init/main.c:1056
> >         ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> > 
> > -> #3 (&base->lock){-.-.}:

However I really, _really_ hate that dependency. We really should not
get memory allocations under rq->lock.

We seem to avoid this for the existing hrtimer usage, because of
hrtimer_init() doing: debug_init() -> debug_hrtimer_init() ->
debug_object_init().

But that isn't done for the (PSI) schedule_delayed_work() thing for some
raisin; even though: group_init() does INIT_DELAYED_WORK() ->
__INIT_DELAYED_WORK() -> __init_timer() -> init_timer_key() ->
debug_init() -> debug_timer_init() -> debug_object_init().

But _somehow_ that isn't doing it.

Now debug_object_activate() has this case:

	if (descr->is_static_object && descr->is_static_object(addr)) {
		debug_object_init()

which does an debug_object_init() for static allocations, which brings
us to:

  static DEFINE_PER_CPU(struct psi_group_cpu, system_group_pcpu);
  static struct psi_group psi_system = {

But that _should_ get initialized by psi_init(), which is called from
sched_init() which _should_ be waaay before do_basic_setup().

Something goes wobbly.. but I'm not seeing it.
