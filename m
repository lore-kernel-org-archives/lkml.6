Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E44FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDB120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDB120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeIJPB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:01:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeIJPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:01:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA8N3Y1807088
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:08:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA8Mi31807085;
        Mon, 10 Sep 2018 03:08:22 -0700
Date:   Mon, 10 Sep 2018 03:08:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-bb3485c8ace6475c269b1aa2da674490f455f412@git.kernel.org>
Cc:     hpa@zytor.com, vincent.guittot@linaro.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, vincent.guittot@linaro.org, hpa@zytor.com
In-Reply-To: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
References: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix load_balance redo for !imbalance
Git-Commit-ID: bb3485c8ace6475c269b1aa2da674490f455f412
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

Commit-ID:  bb3485c8ace6475c269b1aa2da674490f455f412
Gitweb:     https://git.kernel.org/tip/bb3485c8ace6475c269b1aa2da674490f455f412
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Fri, 7 Sep 2018 09:51:04 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:13:49 +0200

sched/fair: Fix load_balance redo for !imbalance

It can happen that load_balance() finds a busiest group and then a
busiest rq but the calculated imbalance is in fact 0.

In such situation, detach_tasks() returns immediately and lets the
flag LBF_ALL_PINNED set. The busiest CPU is then wrongly assumed to
have pinned tasks and removed from the load balance mask. then, we
redo a load balance without the busiest CPU. This creates wrong load
balance situation and generates wrong task migration.

If the calculated imbalance is 0, it's useless to try to find a
busiest rq as no task will be migrated and we can return immediately.

This situation can happen with heterogeneous system or smp system when
RT tasks are decreasing the capacity of some CPUs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: jhugo@codeaurora.org
Link: http://lkml.kernel.org/r/1536306664-29827-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f12d004be6a1..fc9a484ef82b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8275,7 +8275,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
 	calculate_imbalance(env, &sds);
-	return sds.busiest;
+	return env->imbalance ? sds.busiest : NULL;
 
 out_balanced:
 	env->imbalance = 0;
