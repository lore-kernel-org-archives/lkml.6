Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF12C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6F520859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NdwgKuRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfAGJwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:52:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35146 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAGJwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3irFOLD/RGLCA8VlcpjIfrS0z0daUKn0uxedVDzoOZc=; b=NdwgKuRmrMbs1SAYtBuTB9PtB
        kjeU73j1pQFxyfqCaAbqVMQwFIHjqxs8Vzo6to2zV1TKhVpmHdbCgVihyQpe4GNInhOAgi7VrhWc6
        ah9/YnIy3DRTtBgDaiO0Qi8b134PtONFyXeTNGgXNh0JlU66slzRSrHGf6VB88fpdnviygdF0f6uZ
        ulpRsZV3CLtCGkLaK8cIDY36FGAv0rEB+lqhrEnr+fN4YwV4JeWeNylR5rP+9+7VUuZ/hsnNzg2wS
        cNpoYVWFUKsYCGxklIZWUuPpenJiSLvlQGaWcufBzXNaLOJcJ60q+Vlk3giHqx8VQ8+7CjBKWxBN5
        OclOoUF8A==;
Received: from [185.88.64.153] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggRZz-00031y-El; Mon, 07 Jan 2019 09:52:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACAF3983877; Mon,  7 Jan 2019 10:52:17 +0100 (CET)
Date:   Mon, 7 Jan 2019 10:52:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>, hannes@cmpxchg.org
Subject: Re: possible deadlock in __wake_up_common_lock
Message-ID: <20190107095217.GB2861@worktop.programming.kicks-ass.net>
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
> > -> #3 (&base->lock){-.-.}:
> >         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >         _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
> >         lock_timer_base+0xbb/0x2b0 kernel/time/timer.c:937
> >         __mod_timer kernel/time/timer.c:1009 [inline]
> >         mod_timer kernel/time/timer.c:1101 [inline]
> >         add_timer+0x895/0x1490 kernel/time/timer.c:1137
> >         __queue_delayed_work+0x249/0x380 kernel/workqueue.c:1533
> >         queue_delayed_work_on+0x1a2/0x1f0 kernel/workqueue.c:1558
> >         queue_delayed_work include/linux/workqueue.h:527 [inline]
> >         schedule_delayed_work include/linux/workqueue.h:628 [inline]
> >         psi_group_change kernel/sched/psi.c:485 [inline]
> >         psi_task_change+0x3f1/0x5f0 kernel/sched/psi.c:534
> >         psi_enqueue kernel/sched/stats.h:82 [inline]
> >         enqueue_task kernel/sched/core.c:727 [inline]
> >         activate_task+0x21a/0x430 kernel/sched/core.c:751
> >         wake_up_new_task+0x527/0xd20 kernel/sched/core.c:2423
> >         _do_fork+0x33b/0x11d0 kernel/fork.c:2247
> >         kernel_thread+0x34/0x40 kernel/fork.c:2281
> >         rest_init+0x28/0x372 init/main.c:409
> >         arch_call_rest_init+0xe/0x1b
> >         start_kernel+0x873/0x8ae init/main.c:741
> >         x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
> >         x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
> >         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

That thing is fairly new; I don't think we used to have this dependency
prior to PSI.

Johannes, can we move that mod_timer out from under rq->lock? At worst
we can use an irq_work to self-ipi.
