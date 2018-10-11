Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F177BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20382077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20382077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeJKSkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:40:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJKSkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:40:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9BBCo8k1870909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Oct 2018 04:12:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9BBCnZk1870906;
        Thu, 11 Oct 2018 04:12:49 -0700
Date:   Thu, 11 Oct 2018 04:12:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Phil Auld <tipbot@zytor.com>
Message-ID: <tip-baa9be4ffb55876923dc9716abc0a448e510ba30@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bsegall@google.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, pauld@redhat.com, hpa@zytor.com
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          pauld@redhat.com, linux-kernel@vger.kernel.org,
          bsegall@google.com
In-Reply-To: <20181008143639.GA4019@pauld.bos.csb>
References: <20181008143639.GA4019@pauld.bos.csb>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Fix throttle_list starvation with
 low CFS quota
Git-Commit-ID: baa9be4ffb55876923dc9716abc0a448e510ba30
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  baa9be4ffb55876923dc9716abc0a448e510ba30
Gitweb:     https://git.kernel.org/tip/baa9be4ffb55876923dc9716abc0a448e510ba30
Author:     Phil Auld <pauld@redhat.com>
AuthorDate: Mon, 8 Oct 2018 10:36:40 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 11 Oct 2018 13:10:18 +0200

sched/fair: Fix throttle_list starvation with low CFS quota

With a very low cpu.cfs_quota_us setting, such as the minimum of 1000,
distribute_cfs_runtime may not empty the throttled_list before it runs
out of runtime to distribute. In that case, due to the change from
c06f04c7048 to put throttled entries at the head of the list, later entries
on the list will starve.  Essentially, the same X processes will get pulled
off the list, given CPU time and then, when expired, get put back on the
head of the list where distribute_cfs_runtime will give runtime to the same
set of processes leaving the rest.

Fix the issue by setting a bit in struct cfs_bandwidth when
distribute_cfs_runtime is running, so that the code in throttle_cfs_rq can
decide to put the throttled entry on the tail or the head of the list.  The
bit is set/cleared by the callers of distribute_cfs_runtime while they hold
cfs_bandwidth->lock.

This is easy to reproduce with a handful of CPU consumers. I use 'crash' on
the live system. In some cases you can simply look at the throttled list and
see the later entries are not changing:

  crash> list cfs_rq.throttled_list -H 0xffff90b54f6ade40 -s cfs_rq.runtime_remaining | paste - - | awk '{print $1"  "$4}' | pr -t -n3
    1     ffff90b56cb2d200  -976050
    2     ffff90b56cb2cc00  -484925
    3     ffff90b56cb2bc00  -658814
    4     ffff90b56cb2ba00  -275365
    5     ffff90b166a45600  -135138
    6     ffff90b56cb2da00  -282505
    7     ffff90b56cb2e000  -148065
    8     ffff90b56cb2fa00  -872591
    9     ffff90b56cb2c000  -84687
   10     ffff90b56cb2f000  -87237
   11     ffff90b166a40a00  -164582

  crash> list cfs_rq.throttled_list -H 0xffff90b54f6ade40 -s cfs_rq.runtime_remaining | paste - - | awk '{print $1"  "$4}' | pr -t -n3
    1     ffff90b56cb2d200  -994147
    2     ffff90b56cb2cc00  -306051
    3     ffff90b56cb2bc00  -961321
    4     ffff90b56cb2ba00  -24490
    5     ffff90b166a45600  -135138
    6     ffff90b56cb2da00  -282505
    7     ffff90b56cb2e000  -148065
    8     ffff90b56cb2fa00  -872591
    9     ffff90b56cb2c000  -84687
   10     ffff90b56cb2f000  -87237
   11     ffff90b166a40a00  -164582

Sometimes it is easier to see by finding a process getting starved and looking
at the sched_info:

  crash> task ffff8eb765994500 sched_info
  PID: 7800   TASK: ffff8eb765994500  CPU: 16  COMMAND: "cputest"
    sched_info = {
      pcount = 8,
      run_delay = 697094208,
      last_arrival = 240260125039,
      last_queued = 240260327513
    },
  crash> task ffff8eb765994500 sched_info
  PID: 7800   TASK: ffff8eb765994500  CPU: 16  COMMAND: "cputest"
    sched_info = {
      pcount = 8,
      run_delay = 697094208,
      last_arrival = 240260125039,
      last_queued = 240260327513
    },

Signed-off-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Ben Segall <bsegall@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: c06f04c70489 ("sched: Fix potential near-infinite distribute_cfs_runtime() loop")
Link: http://lkml.kernel.org/r/20181008143639.GA4019@pauld.bos.csb
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 22 +++++++++++++++++++---
 kernel/sched/sched.h |  2 ++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7fc4a371bdd2..f88e00705b55 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4476,9 +4476,13 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/*
 	 * Add to the _head_ of the list, so that an already-started
-	 * distribute_cfs_runtime will not see us
+	 * distribute_cfs_runtime will not see us. If disribute_cfs_runtime is
+	 * not running add to the tail so that later runqueues don't get starved.
 	 */
-	list_add_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
+	if (cfs_b->distribute_running)
+		list_add_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
+	else
+		list_add_tail_rcu(&cfs_rq->throttled_list, &cfs_b->throttled_cfs_rq);
 
 	/*
 	 * If we're the first throttled task, make sure the bandwidth
@@ -4622,14 +4626,16 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 	 * in us over-using our runtime if it is all used during this loop, but
 	 * only by limited amounts in that extreme case.
 	 */
-	while (throttled && cfs_b->runtime > 0) {
+	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
 		runtime = cfs_b->runtime;
+		cfs_b->distribute_running = 1;
 		raw_spin_unlock(&cfs_b->lock);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		runtime = distribute_cfs_runtime(cfs_b, runtime,
 						 runtime_expires);
 		raw_spin_lock(&cfs_b->lock);
 
+		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
 
 		cfs_b->runtime -= min(runtime, cfs_b->runtime);
@@ -4740,6 +4746,11 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 
 	/* confirm we're still not at a refresh boundary */
 	raw_spin_lock(&cfs_b->lock);
+	if (cfs_b->distribute_running) {
+		raw_spin_unlock(&cfs_b->lock);
+		return;
+	}
+
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
 		raw_spin_unlock(&cfs_b->lock);
 		return;
@@ -4749,6 +4760,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		runtime = cfs_b->runtime;
 
 	expires = cfs_b->runtime_expires;
+	if (runtime)
+		cfs_b->distribute_running = 1;
+
 	raw_spin_unlock(&cfs_b->lock);
 
 	if (!runtime)
@@ -4759,6 +4773,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	raw_spin_lock(&cfs_b->lock);
 	if (expires == cfs_b->runtime_expires)
 		cfs_b->runtime -= min(runtime, cfs_b->runtime);
+	cfs_b->distribute_running = 0;
 	raw_spin_unlock(&cfs_b->lock);
 }
 
@@ -4867,6 +4882,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period_timer.function = sched_cfs_period_timer;
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
+	cfs_b->distribute_running = 0;
 }
 
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 455fa330de04..9683f458aec7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -346,6 +346,8 @@ struct cfs_bandwidth {
 	int			nr_periods;
 	int			nr_throttled;
 	u64			throttled_time;
+
+	bool                    distribute_running;
 #endif
 };
 
