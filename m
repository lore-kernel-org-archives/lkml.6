Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19D9C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7082150C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Raq6Yhu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7082150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeJTQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:55:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeJTQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:55:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so39715311wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TGrXcP3Zr3cb+7qRqbYFbDys8ajQgKHa3SirSYLCcDk=;
        b=Raq6Yhu429nVzo4kfdgUSt0On5QsvbiADsrao4OuxW2ycHwevZdsNcuLIbuEi5DZWX
         pNaavoS9Stk0dyUsYiJZLs3vHDM9j9wAEJz1FxnKE425pwFWnuu/AyIN4gCVnEVadPoe
         x5uABcLhod3ogg4DCroeh4ERgBF2NzQ8YDfoTTVcrAE8+ob/JaTbf+mVE+MSGN08FMFl
         6fc6OOPHeDCzw4RlmwLxF/s35dKKHzcak3W74DE2V/PJ1CYUfPmG2L46SIil1+beU42v
         1vj9duNA2Szec15XDSDbmULIdGeErGuXzphlG6+/oVU5vEqGB67L9cgnkF+Z2eKmNZtK
         sydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=TGrXcP3Zr3cb+7qRqbYFbDys8ajQgKHa3SirSYLCcDk=;
        b=JMJPd+s/VcxqcAxBDZwlSZ4RzHXBnm+hr6HmHJmaQwdaySo+zjk8Sxgmm0gKfqkZFS
         YnNOykGpFnQiTNhk8LSBSLYHpsjXQKrwyxRaqCBfToxOZxplOHUPSFDrRYVtXb4QHlkd
         x42b5mKFfCGACTjujoaHQ75cHi2+9Mo8VQvG1DHAjoXoXuxjzMObhUEiJbpGMXkWaYDw
         hYlBW+Y3JtsjBIjDrruIIl4JmP20Sqn73LxTJT6LhejhQDr31uzjGGDPhoH2mW5rkmv6
         IApryh6L5N3AlzhLBTOy53lEpJwuXzBoR4hReHg1GfheoVQHxC6NcqUV6q3yotfTi87S
         9kEw==
X-Gm-Message-State: ABuFfohPEigwTOTLP/i3FvTk7P4ETeKiwFyU3LP09yNuD7s+Mwprt4VR
        4Y/RfXy2eHiICYjuUgOn7rI=
X-Google-Smtp-Source: ACcGV61MJ2K6fqL9Bm1n5rT26HQmiYOm3XlFsh1GQCtmAdD1JOIH3UPMKm5J+h5oc38DPRCNXOwSvg==
X-Received: by 2002:adf:e0c9:: with SMTP id e9-v6mr38177470wri.199.1540025119816;
        Sat, 20 Oct 2018 01:45:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j203-v6sm6945194wmd.46.2018.10.20.01.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 01:45:19 -0700 (PDT)
Date:   Sat, 20 Oct 2018 10:45:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20181020084516.GA4270@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 9845c49cc9bbb317a0bc9e9cf78d8e09d54c9af0 sched/fair: Fix the min_vruntime update logic in dequeue_entity()

Two fixes: a CFS-throttling bug fix, and an interactivity fix.

 Thanks,

	Ingo

------------------>
Phil Auld (1):
      sched/fair: Fix throttle_list starvation with low CFS quota

Song Muchun (1):
      sched/fair: Fix the min_vruntime update logic in dequeue_entity()


 kernel/sched/fair.c  | 24 ++++++++++++++++++++----
 kernel/sched/sched.h |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7fc4a371bdd2..908c9cdae2f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4001,7 +4001,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * put back on, and if we advance min_vruntime, we'll be placed back
 	 * further than we started -- ie. we'll be penalized.
 	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
+	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 }
 
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
 
