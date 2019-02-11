Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ECC20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBKKwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:52:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:52:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BApviH3499077
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:51:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BApvYO3499074;
        Mon, 11 Feb 2019 02:51:57 -0800
Date:   Mon, 11 Feb 2019 02:51:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-9f132742d5c4146397fef0c5b09fe220576a5bb2@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        valentin.schneider@arm.com, torvalds@linux-foundation.org
Reply-To: valentin.schneider@arm.com, torvalds@linux-foundation.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190117153411.2390-4-valentin.schneider@arm.com>
References: <20190117153411.2390-4-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Prune, fix and simplify the
 nohz_balancer_kick() comment block
Git-Commit-ID: 9f132742d5c4146397fef0c5b09fe220576a5bb2
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

Commit-ID:  9f132742d5c4146397fef0c5b09fe220576a5bb2
Gitweb:     https://git.kernel.org/tip/9f132742d5c4146397fef0c5b09fe220576a5bb2
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Thu, 17 Jan 2019 15:34:09 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:02:18 +0100

sched/fair: Prune, fix and simplify the nohz_balancer_kick() comment block

The comment block for that function lists the heuristics for
triggering a nohz kick, but the most recent ones (blocked load
updates, misfit) aren't included, and some of them (LLC nohz logic,
asym packing) are no longer in sync with the code.

The conditions are either simple enough or properly commented, so get
rid of that list instead of letting it grow.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190117153411.2390-4-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac6b52d8c79e..f44da9b491ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9551,15 +9551,8 @@ static void kick_ilb(unsigned int flags)
 }
 
 /*
- * Current heuristic for kicking the idle load balancer in the presence
- * of an idle cpu in the system.
- *   - This rq has more than one task.
- *   - This rq has at least one CFS task and the capacity of the CPU is
- *     significantly reduced because of RT tasks or IRQs.
- *   - At parent of LLC scheduler domain level, this cpu's scheduler group has
- *     multiple busy cpu.
- *   - For SD_ASYM_PACKING, if the lower numbered cpu's in the scheduler
- *     domain span are idle.
+ * Current decision point for kicking the idle load balancer in the presence
+ * of idle CPUs in the system.
  */
 static void nohz_balancer_kick(struct rq *rq)
 {
