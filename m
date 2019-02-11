Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5007C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E6E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBKKv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:51:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51123 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:51:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BApDTr3499004
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:51:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BApCpa3499000;
        Mon, 11 Feb 2019 02:51:12 -0800
Date:   Mon, 11 Feb 2019 02:51:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-892d59c22208be820a5463b5f74eb7f0b7f2b03a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        valentin.schneider@arm.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          torvalds@linux-foundation.org, valentin.schneider@arm.com
In-Reply-To: <20190117153411.2390-3-valentin.schneider@arm.com>
References: <20190117153411.2390-3-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Explain LLC nohz kick condition
Git-Commit-ID: 892d59c22208be820a5463b5f74eb7f0b7f2b03a
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

Commit-ID:  892d59c22208be820a5463b5f74eb7f0b7f2b03a
Gitweb:     https://git.kernel.org/tip/892d59c22208be820a5463b5f74eb7f0b7f2b03a
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Thu, 17 Jan 2019 15:34:08 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:02:17 +0100

sched/fair: Explain LLC nohz kick condition

Provide a comment explaining the LLC related nohz kick in
nohz_balancer_kick().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190117153411.2390-3-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0692c8ff6ff6..ac6b52d8c79e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9601,8 +9601,13 @@ static void nohz_balancer_kick(struct rq *rq)
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
 	if (sds) {
 		/*
-		 * XXX: write a coherent comment on why we do this.
-		 * See also: http://lkml.kernel.org/r/20111202010832.602203411@sbsiddha-desk.sc.intel.com
+		 * If there is an imbalance between LLC domains (IOW we could
+		 * increase the overall cache use), we need some less-loaded LLC
+		 * domain to pull some load. Likewise, we may need to spread
+		 * load within the current LLC domain (e.g. packed SMT cores but
+		 * other CPUs are idle). We can't really know from here how busy
+		 * the others are - so just get a nohz balance going if it looks
+		 * like this LLC domain has tasks we could move.
 		 */
 		nr_busy = atomic_read(&sds->nr_busy_cpus);
 		if (nr_busy > 1) {
