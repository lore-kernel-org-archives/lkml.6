Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F4DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F185E20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F185E20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeIJPKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:10:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40305 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:10:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAH4KZ1808323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:17:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAH41p1808320;
        Mon, 10 Sep 2018 03:17:04 -0700
Date:   Mon, 10 Sep 2018 03:17:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-e90c8fe15a3bf93a23088bcf1a56a0fa391d4e50@git.kernel.org>
Cc:     tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
        morten.rasmussen@arm.com, valentin.schneider@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: morten.rasmussen@arm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          valentin.schneider@arm.com, tglx@linutronix.de, hpa@zytor.com,
          torvalds@linux-foundation.org
In-Reply-To: <1530699470-29808-9-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-9-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Wrap rq->rd->overload accesses with
 READ/WRITE_ONCE()
Git-Commit-ID: e90c8fe15a3bf93a23088bcf1a56a0fa391d4e50
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

Commit-ID:  e90c8fe15a3bf93a23088bcf1a56a0fa391d4e50
Gitweb:     https://git.kernel.org/tip/e90c8fe15a3bf93a23088bcf1a56a0fa391d4e50
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:52 +0200

sched/fair: Wrap rq->rd->overload accesses with READ/WRITE_ONCE()

This variable can be read and set locklessly within update_sd_lb_stats().
As such, READ/WRITE_ONCE() are added to make sure nothing terribly wrong
can happen because of the compiler.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-9-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23017939ecab..d9c4e97bfebd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8058,8 +8058,8 @@ next_group:
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (env->dst_rq->rd->overload != overload)
-			env->dst_rq->rd->overload = overload;
+		if (READ_ONCE(env->dst_rq->rd->overload) != overload)
+			WRITE_ONCE(env->dst_rq->rd->overload, overload);
 	}
 }
 
@@ -9502,7 +9502,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rq_unpin_lock(this_rq, rf);
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	    !READ_ONCE(this_rq->rd->overload)) {
 
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4d181478c5b8..938063639793 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1697,8 +1697,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
-		if (!rq->rd->overload)
-			rq->rd->overload = 1;
+		if (!READ_ONCE(rq->rd->overload))
+			WRITE_ONCE(rq->rd->overload, 1);
 #endif
 	}
 
