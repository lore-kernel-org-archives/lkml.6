Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B3C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FC2214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA0O5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:57:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:33935 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0O5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:57:46 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0REvilp012274;
        Sun, 27 Jan 2019 23:57:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sun, 27 Jan 2019 23:57:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0REvhfx012270
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 27 Jan 2019 23:57:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v3] oom, oom_reaper: do not enqueue same task twice
To:     Michal Hocko <mhocko@kernel.org>
Cc:     =?UTF-8?Q?Arkadiusz_Mi=c5=9bkiewicz?= <a.miskiewicz@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
References: <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
 <480296c4-ed7a-3265-e84a-298e42a0f1d5@I-love.SAKURA.ne.jp>
 <6da6ca69-5a6e-a9f6-d091-f89a8488982a@gmail.com>
 <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
 <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
 <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
 <2b0c7d6c-c58a-da7d-6f0a-4900694ec2d3@gmail.com>
 <1d161137-55a5-126f-b47e-b2625bd798ca@i-love.sakura.ne.jp>
 <20190127083724.GA18811@dhcp22.suse.cz>
 <ec0d0580-a2dd-f329-9707-0cb91205a216@i-love.sakura.ne.jp>
 <20190127114021.GB18811@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
Date:   Sun, 27 Jan 2019 23:57:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190127114021.GB18811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/27 20:40, Michal Hocko wrote:
> On Sun 27-01-19 19:56:06, Tetsuo Handa wrote:
>> On 2019/01/27 17:37, Michal Hocko wrote:
>>> Thanks for the analysis and the patch. This should work, I believe but
>>> I am not really thrilled to overload the meaning of the MMF_UNSTABLE.
>>> The flag is meant to signal accessing address space is not stable and it
>>> is not aimed to synchronize oom reaper with the oom path.
>>>
>>> Can we make use mark_oom_victim directly? I didn't get to think that
>>> through right now so I might be missing something but this should
>>> prevent repeating queueing as well.
>>
>> Yes, TIF_MEMDIE would work. But you are planning to remove TIF_MEMDIE. Also,
>> TIF_MEMDIE can't avoid enqueuing many threads sharing mm_struct to the OOM
>> reaper. There is no need to enqueue many threads sharing mm_struct because
>> the OOM reaper acts on mm_struct rather than task_struct. Thus, enqueuing
>> based on per mm_struct flag sounds better, but MMF_OOM_VICTIM cannot be
>> set from wake_oom_reaper(victim) because victim's mm might be already inside
>> exit_mmap() when wake_oom_reaper(victim) is called after task_unlock(victim).
>>
>> We could reintroduce MMF_OOM_KILLED in commit 855b018325737f76
>> ("oom, oom_reaper: disable oom_reaper for oom_kill_allocating_task")
>> if you don't like overloading the meaning of the MMF_UNSTABLE. But since
>> MMF_UNSTABLE is available in Linux 4.9+ kernels (which covers all LTS stable
>> versions with the OOM reaper support), we can temporarily use MMF_UNSTABLE
>> for ease of backporting.
> 
> I agree that a per-mm state is more optimal but I would rather fix the
> issue in a clear way first and only then think about an optimization on
> top. Queueing based on mark_oom_victim (whatever that uses to guarantee
> the victim is marked atomically and only once) makes sense from the
> conceptual point of view and it makes a lot of sense to start from
> there. MMF_UNSTABLE has a completely different purpose. So unless you
> see a correctness issue with that then I would rather go that way.
> 

Then, adding a per mm_struct flag is better. I don't see the difference
between reusing MMF_UNSTABLE as a flag for whether wake_oom_reaper() for
that victim's memory was already called (what you think as an overload)
and reusing TIF_MEMDIE as a flag for whether wake_oom_reaper() for that
victim thread can be called (what I think as an overload). We want to
remove TIF_MEMDIE, and we can actually remove TIF_MEMDIE if you stop
whack-a-mole "can you observe it in real workload/program?" game.
I don't see a correctness issue with TIF_MEMDIE but I don't want to go
TIF_MEMDIE way.



From 9c9e935fc038342c48461aabca666f1b544e32b1 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 27 Jan 2019 23:51:37 +0900
Subject: [PATCH v3] oom, oom_reaper: do not enqueue same task twice

Arkadiusz reported that enabling memcg's group oom killing causes
strange memcg statistics where there is no task in a memcg despite
the number of tasks in that memcg is not 0. It turned out that there
is a bug in wake_oom_reaper() which allows enqueuing same task twice
which makes impossible to decrease the number of tasks in that memcg
due to a refcount leak.

This bug existed since the OOM reaper became invokable from
task_will_free_mem(current) path in out_of_memory() in Linux 4.7,
but memcg's group oom killing made it easier to trigger this bug by
calling wake_oom_reaper() on the same task from one out_of_memory()
request.

Fix this bug using an approach used by commit 855b018325737f76
("oom, oom_reaper: disable oom_reaper for oom_kill_allocating_task").
As a side effect of this patch, this patch also avoids enqueuing
multiple threads sharing memory via task_will_free_mem(current) path.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Arkadiusz Miśkiewicz <arekm@maven.pl>
Tested-by: Arkadiusz Miśkiewicz <arekm@maven.pl>
Fixes: af8e15cc85a25315 ("oom, oom_reaper: do not enqueue task if it is on the oom_reaper_list head")
---
 include/linux/sched/coredump.h | 1 +
 mm/oom_kill.c                  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index ec912d0..ecdc654 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -71,6 +71,7 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
 #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
 #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
+#define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f0e8cd9..059e617 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -647,8 +647,8 @@ static int oom_reaper(void *unused)
 
 static void wake_oom_reaper(struct task_struct *tsk)
 {
-	/* tsk is already queued? */
-	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
+	/* mm is already queued? */
+	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
 		return;
 
 	get_task_struct(tsk);
-- 
1.8.3.1

