Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A242082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A242082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeLEMlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:41:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeLEMlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:41:42 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AAA7CDF9C0495;
        Wed,  5 Dec 2018 20:41:38 +0800 (CST)
Received: from [10.177.98.84] (10.177.98.84) by smtp.huawei.com (10.3.19.202)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 5 Dec 2018 20:41:39
 +0800
To:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
From:   "weiqi (C)" <weiqi4@huawei.com>
Subject: [RFC] sched/fair: Align vruntime to last_se when curr_se's timeslice
 run out
Message-ID: <f4f56ab5-8f9e-9ee4-4db8-370bc4aa2556@huawei.com>
Date:   Wed, 5 Dec 2018 20:41:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.98.84]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I measuring the cfs scheduling delay, and found that
when a cfs_rq contains multiple tasks, it does not guarantee
every se of this cfs_rq can get a changce to run within
  one sched_latency period. Assume that there are three se
  A, B, and C in cfs_rq, and the default sched_latency=24ms.
In ideal state, A, B, and C take turns to get 8ms, The timing is:
  A(8ms) -> B(8ms) -> C(8ms) -> A(8ms) -> B(8ms) -> C(8ms) ....
So, the delay for each task is approximately 16ms.

However, check_preempt_tick() is the clock interrupt granularity,
and the clock interrupt may also have an indeterminate fine delay,
so the time slice actually expires relative
  to the ideal expiration time delay uncertain time.
This may result in a timing of :
      A -> B -> C -> B -> C -> A
which increases the scheduling delay of A to 32ms.


The more extreme scenario is wakeup sleepers. If a sleeper task
  wakes up to a cpu, its vruntime will be sched_latency/2 less
  than cfs_rq->min_vruntime /* place_entity() function do this */
In the scene of the above A, B, C cycle time slice,
a sleeper thread D woken up
D->vruntime = cfs_rq->min_vruntime - sched_latency/2
then the timing of the pick_task may be:

A(8ms)->B(8ms)->C(8ms)->D(6ms)->D(6ms)->D(6ms,then dequeue)->C(8ms)-> 
B(8ms)->A

causing A's scheduling delay to reach 50ms
so, I make changes to check_preempt_tick()：

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb..1f61b9c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4020,7 +4020,23 @@ static void clear_buddies(struct cfs_rq *cfs_rq, 
struct sched_entity *se)
         ideal_runtime = sched_slice(cfs_rq, curr);
         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
         if (delta_exec > ideal_runtime) {
+               struct rb_node *next = NULL;
+               struct rb_node *right_most = NULL;
+               struct sched_entity *last;
                 resched_curr(rq_of(cfs_rq));
+
+                /* always set to max vruntime */
+                if (cfs_rq->nr_running > 1) {
+                        next = &curr->run_node;
+                        do {
+                                right_most = next;
+                                next = rb_next(next);
+                        } while (next);
+
+                        last = rb_entry(right_most,
+                                         struct sched_entity, run_node);
+                        curr->vruntime = last->vruntime + 1; // maybe 
+1 is not needed
+                }
+
                 /*
                  * The current task ran long enough, ensure it doesn't get
                  * re-elected due to buddy favours.


In this way, time sliced task in one sched_latency period will not get 
runtime again,
And for wake sleeper, it can meet the needs of wake-up preemption, and 
this will not let it
take too much time in a scheduling period.

I wrote a small press program, bind it to 12 cpus, this program wake up 
36 sub-processes
  every second and each sub-process work 120ms, looping all the time..
I‘ve tested on linux-stable 4.20-rc1 kernel, the maximum delay of press 
program is about 80ms.
After applying the above modifications, the maximum delay is stable at 27ms.
