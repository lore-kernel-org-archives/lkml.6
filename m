Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38796C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F8B21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzcBHWud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeL0KVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 05:21:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38786 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeL0KVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 05:21:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so17160023wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 02:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OIq3cV+apneK0boi08B+zcNNsK9xgkU/QQgmVTl0B1M=;
        b=AzcBHWudwRTjXyq2hVZ9elJQTIdpV6UcRBk70ksPCDTri8DPBnSYTYwR+DD469vn+z
         QiCOZV/mtrslcKReKTq894h5Fq4yTDU3oqPS1/HZdS50KHTzRLU5n6SHuDzosEJ2gx1y
         HTKcq5NhMgPXbCchKQpzhBn5oU3kM/SNmt5eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OIq3cV+apneK0boi08B+zcNNsK9xgkU/QQgmVTl0B1M=;
        b=OuiKB7nvhk7hlxtxqlDMT4U7hvWOfEYPbLBw8ecct1axht7TM/Xyv8F1gkZ1zkfK+/
         uKaccOW7nNf3/X8Be6Be4G7L91malsQuBJxa1FTvxs8fHqxPdVYNWsjUb7VTP8U4C26y
         IBuxCA6leslqJrvdcVQz4tJfWV7ol8Iz4ogjb7WvALKLhEK9Vi+PwsqOeXMejgzFas0D
         CUfDMg5nd5iQj0WZtd6jyuyTsM6nwL53YtwAoB6UXLPiwclE5HThf+KhrWKaz3sYyuLR
         LVEJDFfOCrzGnOcSDwbaU0FWF9wumdkb7N/H3IEaIPPiQ6ndWfZGBevAFP5zzlpKr0/m
         cDDQ==
X-Gm-Message-State: AA+aEWbNDsCbkxKRh38G7h5OkkDKuEK8jDKQV0PU97kPjqTEAHc9zpIa
        WPiICZibTZx/NvveBl70H3nmZg==
X-Google-Smtp-Source: AFSGD/X/lps3p/OsJ7wuoyR1KXpX81Ak2obZAMb5yPbQp9nDaPAwc/eL0iVqM9+5Az5z9UowkX0mCg==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr20277056wma.90.1545906069517;
        Thu, 27 Dec 2018 02:21:09 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:8402:1ede:9634:cf])
        by smtp.gmail.com with ESMTPSA id e27sm33483965wra.67.2018.12.27.02.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 02:21:08 -0800 (PST)
Date:   Thu, 27 Dec 2018 11:21:07 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
Message-ID: <20181227102107.GA21156@linaro.org>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thursday 27 Dec 2018 à 10:21:53 (+0100), Vincent Guittot a écrit :
> Hi Xie,
> 
> On Thu, 27 Dec 2018 at 03:57, Xie XiuQi <xiexiuqi@huawei.com> wrote:
> >
> > Zhepeng Xie report a bug, there is a infinity loop in
> > update_blocked_averages().
> >
> > PID: 14233  TASK: ffff800b2de08fc0  CPU: 1   COMMAND: "docker"
> >  #0 [ffff00002213b9d0] update_blocked_averages at ffff00000811e4a8
> >  #1 [ffff00002213ba60] pick_next_task_fair at ffff00000812a3b4
> >  #2 [ffff00002213baf0] __schedule at ffff000008deaa88
> >  #3 [ffff00002213bb70] schedule at ffff000008deb1b8
> >  #4 [ffff00002213bb80] futex_wait_queue_me at ffff000008180754
> >  #5 [ffff00002213bbd0] futex_wait at ffff00000818192c
> >  #6 [ffff00002213bd00] do_futex at ffff000008183ee4
> >  #7 [ffff00002213bde0] __arm64_sys_futex at ffff000008184398
> >  #8 [ffff00002213be60] el0_svc_common at ffff0000080979ac
> >  #9 [ffff00002213bea0] el0_svc_handler at ffff000008097a6c
> >  #10 [ffff00002213bff0] el0_svc at ffff000008084044
> >
> > rq->tmp_alone_branch introduced in 4.10, used to point to
> > the new beg of the list. If this cfs_rq is deleted somewhere
> > else, then the tmp_alone_branch will be illegal and cause
> > a list_add corruption.
> 
> shouldn't all the sequence  be protected by rq_lock ?
> 
> 
> >
> > (When enabled DEBUG_LIST, we fould this list_add corruption)
> >
> > [ 2546.741103] list_add corruption. next->prev should be prev
> > (ffff800b4d61ad40), but was ffff800ba434fa38. (next=ffff800b6a95e740).
> > [ 2546.741130] ------------[ cut here ]------------
> > [ 2546.741132] kernel BUG at lib/list_debug.c:25!
> > [ 2546.741136] Internal error: Oops - BUG: 0 [#1] SMP
> > [ 2546.742870] CPU: 1 PID: 29428 Comm: docker-runc Kdump: loaded Tainted: G E  4.19.5-1.aarch64 #1
> > [ 2546.745415] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> > [ 2546.747402] pstate: 40000085 (nZcv daIf -PAN -UAO)
> > [ 2546.749015] pc : __list_add_valid+0x50/0x90
> > [ 2546.750485] lr : __list_add_valid+0x50/0x90
> > [ 2546.751975] sp : ffff00001b5eb910
> > [ 2546.753286] x29: ffff00001b5eb910 x28: ffff800abacf0000
> > [ 2546.754976] x27: ffff00001b5ebbb0 x26: ffff000009570000
> > [ 2546.756665] x25: ffff00000960d000 x24: 00000250f41ca8f8
> > [ 2546.758366] x23: ffff800b6a95e740 x22: ffff800b4d61ad40
> > [ 2546.760066] x21: ffff800b4d61ad40 x20: ffff800ba434f080
> > [ 2546.761742] x19: ffff800b4d61ac00 x18: ffffffffffffffff
> > [ 2546.763425] x17: 0000000000000000 x16: 0000000000000000
> > [ 2546.765089] x15: ffff000009570748 x14: 6666662073617720
> > [ 2546.766755] x13: 747562202c293034 x12: 6461313664346230
> > [ 2546.768429] x11: 3038666666662820 x10: 0000000000000000
> > [ 2546.770124] x9 : 0000000000000001 x8 : ffff000009f34a0f
> > [ 2546.771831] x7 : 0000000000000000 x6 : 000000000000250d
> > [ 2546.773525] x5 : 0000000000000000 x4 : 0000000000000000
> > [ 2546.775227] x3 : 0000000000000000 x2 : 70ef7f624013ca00
> > [ 2546.776929] x1 : 0000000000000000 x0 : 0000000000000075
> > [ 2546.778623] Process docker-runc (pid: 29428, stack limit = 0x00000000293494a2)
> > [ 2546.780742] Call trace:
> > [ 2546.781955]  __list_add_valid+0x50/0x90
> > [ 2546.783469]  enqueue_entity+0x4a0/0x6e8
> > [ 2546.784957]  enqueue_task_fair+0xac/0x610
> > [ 2546.786502]  sched_move_task+0x134/0x178
> > [ 2546.787993]  cpu_cgroup_attach+0x40/0x78
> > [ 2546.789540]  cgroup_migrate_execute+0x378/0x3a8
> > [ 2546.791169]  cgroup_migrate+0x6c/0x90
> > [ 2546.792663]  cgroup_attach_task+0x148/0x238
> > [ 2546.794211]  __cgroup1_procs_write.isra.2+0xf8/0x160
> > [ 2546.795935]  cgroup1_procs_write+0x38/0x48
> > [ 2546.797492]  cgroup_file_write+0xa0/0x170
> > [ 2546.799010]  kernfs_fop_write+0x114/0x1e0
> > [ 2546.800558]  __vfs_write+0x60/0x190
> > [ 2546.801977]  vfs_write+0xac/0x1c0
> > [ 2546.803341]  ksys_write+0x6c/0xd8
> > [ 2546.804674]  __arm64_sys_write+0x24/0x30
> > [ 2546.806146]  el0_svc_common+0x78/0x100
> > [ 2546.807584]  el0_svc_handler+0x38/0x88
> > [ 2546.809017]  el0_svc+0x8/0xc
> >
> 
> Have you got more details about the sequence that generates this bug ?
> Is it easily reproducible ?
> 
> > In this patch, we move rq->tmp_alone_branch point to its prev before delete it
> > from list.
> >
> > Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > Cc: Bin Li <huawei.libin@huawei.com>
> > Cc: <stable@vger.kernel.org>        [4.10+]
> > Fixes: 9c2791f936ef (sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list)
> 
> If it only happens in update_blocked_averages(), the del leaf has been added by:
> a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance path)
> 
> > Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> > Tested-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > ---
> >  kernel/sched/fair.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ac855b2..7a72702 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >         if (cfs_rq->on_list) {
> > +               struct rq *rq = rq_of(cfs_rq);
> > +
> > +               if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
> > +                       rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
> > +

I'm afraid that your patch will break the ordering of leaf_cfs_rq_list

Can you tried the patch below:

---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ca46964..4d51b2d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7694,13 +7694,6 @@ static void update_blocked_averages(int cpu)
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
-		/*
-		 * There can be a lot of idle CPU cgroups.  Don't let fully
-		 * decayed cfs_rqs linger on the list.
-		 */
-		if (cfs_rq_is_decayed(cfs_rq))
-			list_del_leaf_cfs_rq(cfs_rq);
-
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
-- 
2.7.4




> >                 list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> >                 cfs_rq->on_list = 0;
> >         }
> > --
> > 1.8.3.1
> >
