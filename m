Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51680C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78B520880
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78B520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeIHBmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeIHBmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:13 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC5220844;
        Fri,  7 Sep 2018 20:59:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNqk-0001hn-0E; Fri, 07 Sep 2018 16:59:30 -0400
Message-Id: <20180907205929.901024799@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:58:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH RT 01/24] sched/fair: Fix CFS bandwidth control lockdep DEADLOCK report
References: <20180907205857.262840394@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

[ Upstream commit df7e8acc0c9a84979a448d215b8ef889efe4ac5a ]

CFS bandwidth control yields the inversion gripe below, moving
handling quells it.

|========================================================
|WARNING: possible irq lock inversion dependency detected
|4.16.7-rt1-rt #2 Tainted: G            E
|--------------------------------------------------------
|sirq-hrtimer/0/15 just changed the state of lock:
| (&cfs_b->lock){+...}, at: [<000000009adb5cf7>] sched_cfs_period_timer+0x28/0x140
|but this lock was taken by another, HARDIRQ-safe lock in the past: (&rq->lock){-...}
|and interrupts could create inverse lock ordering between them.
|other info that might help us debug this:
| Possible interrupt unsafe locking scenario:
|       CPU0                    CPU1
|       ----                    ----
|  lock(&cfs_b->lock);
|                               local_irq_disable();
|                               lock(&rq->lock);
|                               lock(&cfs_b->lock);
|  <Interrupt>
|    lock(&rq->lock);

Cc: stable-rt@vger.kernel.org
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 36ef77839be4..51ecea4f5d16 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4684,9 +4684,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 }
 
-- 
2.18.0


