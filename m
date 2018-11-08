Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9775ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B742208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0JNGsumu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B742208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeKIHgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbeKIHgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:00 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806F120818;
        Thu,  8 Nov 2018 21:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714311;
        bh=pU3bcGPafiFiE6CAYEQF5OPrUeLAkKXEcaePp/4J+fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JNGsumu9gvjNOAEkoANTWw9oIDXm8nCzGI1fH79gLTMMCOpdQNCKEplnWXogRgg0
         7WEAkvkv/RyfjY6OR21zO+wIQ9ayHj7Xeo9mN3GMheoohMf9zSE5x3WoV2gK2FXB9t
         RmHJygspjdYPIv1fQ4Pa0QsvM/qh1FR1sWR50edw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3.18 144/144] sched/fair: Fix throttle_list starvation with low CFS quota
Date:   Thu,  8 Nov 2018 13:51:55 -0800
Message-Id: <20181108215108.639467582@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Auld <pauld@redhat.com>

commit baa9be4ffb55876923dc9716abc0a448e510ba30 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/fair.c  |   23 ++++++++++++++++++++---
 kernel/sched/sched.h |    2 ++
 2 files changed, 22 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3416,9 +3416,14 @@ static void throttle_cfs_rq(struct cfs_r
 	raw_spin_lock(&cfs_b->lock);
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
+
 	if (!cfs_b->timer_active)
 		__start_cfs_bandwidth(cfs_b, false);
 	raw_spin_unlock(&cfs_b->lock);
@@ -3562,14 +3567,16 @@ static int do_sched_cfs_period_timer(str
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
@@ -3680,6 +3687,11 @@ static void do_sched_cfs_slack_timer(str
 
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
@@ -3689,6 +3701,9 @@ static void do_sched_cfs_slack_timer(str
 		runtime = cfs_b->runtime;
 
 	expires = cfs_b->runtime_expires;
+	if (runtime)
+		cfs_b->distribute_running = 1;
+
 	raw_spin_unlock(&cfs_b->lock);
 
 	if (!runtime)
@@ -3699,6 +3714,7 @@ static void do_sched_cfs_slack_timer(str
 	raw_spin_lock(&cfs_b->lock);
 	if (expires == cfs_b->runtime_expires)
 		cfs_b->runtime -= min(runtime, cfs_b->runtime);
+	cfs_b->distribute_running = 0;
 	raw_spin_unlock(&cfs_b->lock);
 }
 
@@ -3790,6 +3806,7 @@ void init_cfs_bandwidth(struct cfs_bandw
 	cfs_b->period_timer.function = sched_cfs_period_timer;
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
+	cfs_b->distribute_running = 0;
 }
 
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -202,6 +202,8 @@ struct cfs_bandwidth {
 	/* statistics */
 	int nr_periods, nr_throttled;
 	u64 throttled_time;
+
+	bool distribute_running;
 #endif
 };
 


