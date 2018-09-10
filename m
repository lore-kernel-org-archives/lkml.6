Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D71C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C5920870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C5920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeIJPLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:11:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbeIJPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:11:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAIDlO1808607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:18:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAICio1808604;
        Mon, 10 Sep 2018 03:18:12 -0700
Date:   Mon, 10 Sep 2018 03:18:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chris Redpath <tipbot@zytor.com>
Message-ID: <tip-4ad3831a9d4af5e36da5d44a3b9c6522d0353cee@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        morten.rasmussen@arm.com, peterz@infradead.org, mingo@kernel.org,
        chris.redpath@arm.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: peterz@infradead.org, chris.redpath@arm.com, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, morten.rasmussen@arm.com
In-Reply-To: <1530699470-29808-11-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-11-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Don't move tasks to lower capacity
 CPUs unless necessary
Git-Commit-ID: 4ad3831a9d4af5e36da5d44a3b9c6522d0353cee
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

Commit-ID:  4ad3831a9d4af5e36da5d44a3b9c6522d0353cee
Gitweb:     https://git.kernel.org/tip/4ad3831a9d4af5e36da5d44a3b9c6522d0353cee
Author:     Chris Redpath <chris.redpath@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:48 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:53 +0200

sched/fair: Don't move tasks to lower capacity CPUs unless necessary

When lower capacity CPUs are load balancing and considering to pull
something from a higher capacity group, we should not pull tasks from a
CPU with only one task running as this is guaranteed to impede progress
for that task. If there is more than one task running, load balance in
the higher capacity group would have already made any possible moves to
resolve imbalance and we should make better use of system compute
capacity by moving a task if we still have more than one running.

Signed-off-by: Chris Redpath <chris.redpath@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-11-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8b228c5b3eb4..06ff75f4ac7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8423,6 +8423,17 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 		capacity = capacity_of(i);
 
+		/*
+		 * For ASYM_CPUCAPACITY domains, don't pick a CPU that could
+		 * eventually lead to active_balancing high->low capacity.
+		 * Higher per-CPU capacity is considered better than balancing
+		 * average load.
+		 */
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		    capacity_of(env->dst_cpu) < capacity &&
+		    rq->nr_running == 1)
+			continue;
+
 		wl = weighted_cpuload(rq);
 
 		/*
