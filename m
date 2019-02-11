Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5889C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8A621479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBKKul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:50:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:50:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAoSGK3498742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:50:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAoRJq3498739;
        Mon, 11 Feb 2019 02:50:27 -0800
Date:   Mon, 11 Feb 2019 02:50:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-7edab78d7400ea0997f8e2e971004d824b5bb511@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, tglx@linutronix.de, valentin.schneider@arm.com
Reply-To: mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
          tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20190117153411.2390-2-valentin.schneider@arm.com>
References: <20190117153411.2390-2-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Simplify nohz_balancer_kick()
Git-Commit-ID: 7edab78d7400ea0997f8e2e971004d824b5bb511
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

Commit-ID:  7edab78d7400ea0997f8e2e971004d824b5bb511
Gitweb:     https://git.kernel.org/tip/7edab78d7400ea0997f8e2e971004d824b5bb511
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Thu, 17 Jan 2019 15:34:07 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:02:16 +0100

sched/fair: Simplify nohz_balancer_kick()

Calling 'nohz_balance_exit_idle(rq)' will always clear 'rq->cpu' from
'nohz.idle_cpus_mask' if it is set. Since it is called at the top of
'nohz_balancer_kick()', 'rq->cpu' will never be set in
'nohz.idle_cpus_mask' if it is accessed in the rest of the function.

Combine the 'sched_domain_span()' with 'nohz.idle_cpus_mask' and drop the
'(i == cpu)' check since 'rq->cpu' will never be iterated over.

While at it, clean up a condition alignment.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190117153411.2390-2-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58edbbdeb661..0692c8ff6ff6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9615,7 +9615,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
 		if ((rq->cfs.h_nr_running >= 1) &&
-				check_cpu_capacity(rq, sd)) {
+		    check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -9623,11 +9623,7 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
-			if (i == cpu ||
-			    !cpumask_test_cpu(i, nohz.idle_cpus_mask))
-				continue;
-
+		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_KICK_MASK;
 				goto unlock;
