Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90AFC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D9920821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZCxSRCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfBFQOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:14:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37357 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfBFQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:14:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so1397982wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EDVSHHteQjKl2FGFeIJNZ1MeClUNp/quRGzytDHcfMk=;
        b=xZCxSRCmUHLA5Pn7p3HteWgmDp/pBeQkOToANCesPf7qRj0nqnUASHBqao9AMFneWb
         zDqUU0PsOoKpTxfO92k1ITV16A68cAsXMJgCU1s2c8W7goNGmsbT5Q47ao1xfZLOb3lU
         CH07ysVe7hVMpRHlQeQxFccCttcTPANJNq6OcMOgPYT66jYyqbGPyUDhB74EVi7yyqWE
         swAWHKKrtP4MTPCtJNuOH5A+EXutiYbVRS5EuCd0B+1G4Odfa0IkKdYldTI2I6h1WCBd
         ebZhrIKLGmT2g37//8OFeX4n8MACv9Y9XTnaEmn9bms66kpUFYzkjlyapPxPAkWVcM/y
         6vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EDVSHHteQjKl2FGFeIJNZ1MeClUNp/quRGzytDHcfMk=;
        b=RUp8whJV5vPOzfnosTR+/a3TJ7x4J/V0YLWDN81gT5XkAH1oq+RNcB5a05/9sk7m4p
         8UcroiiNvVjShGzzqJDDEKR9wP+bvKxwqkn7hMkktdnhozmCm+M0N1lIGqddGNrQxynA
         /jIsg2HXyTpy6p20W3Nu6ukzB2M/q5WNPfnmKXP6hik6oQViYjYhWMvoCzkc8exOCWbJ
         QBJbD3cDRCgz8Ye/gOiK/rrxy7YezK77j5LZuzVpDMC24sBkgsFTeCGys0As75hxfSA/
         iOCF4tsYgp5ev2MToTr24A0ykbjG1V+pVWM4x8HyvH+K+ouvCQaTMCF+HIZH+9l9sII8
         iERA==
X-Gm-Message-State: AHQUAuY2wP1E723jDIDZrbh7P6EWqRk+HioJgZVfrpcOCpzLIdLdB77l
        /DmDoxX8f9KsqXV4Yv66OBWBkKUVMhA=
X-Google-Smtp-Source: AHgI3IbpWFs4PzZCJ5XJVx8zOnye89Kg6g6efNsmjp6cappZr5zAJwjLYHi0WbTs80vSYCNxUO7q7Q==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr8829307wrn.264.1549469669652;
        Wed, 06 Feb 2019 08:14:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e4a1:3fb3:af18:c98a])
        by smtp.gmail.com with ESMTPSA id y20sm27492328wra.51.2019.02.06.08.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 08:14:28 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     tj@kernel.org, sargun@sargun.me, xiexiuqi@huawei.com,
        xiezhipeng1@huawei.com, torvalds@linux-foundation.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] sched/fair: optimization of update_blocked_averages()
Date:   Wed,  6 Feb 2019 17:14:21 +0100
Message-Id: <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing a cfs_rq from rq->leaf_cfs_rq_list can break the parent/child
ordering of the list when it will be added back. In order to remove an
empty and fully decayed cfs_rq, we must remove its children too so they
will be added back in the right order next time.

With a normal decay of pelt, a parent will be empty and fully decayed
if all children are empty and fully decayed too. In such a case, we just
have to ensure that the whole branch will be added when a new task is
enqueued. This is default behavior since :
  commit f6783319737f ("sched/fair: Fix insertion in rq->leaf_cfs_rq_list")

In case of throttling, the pelt of throttled cfs_rq will not be updated
whereas the parent will. This breaks the assumption made above unless we
remove the children of a cfs_rq that is throttled. Then, they will be
added back when unthrottled and a sched_entity will be enqueued.

As throttled cfs_rq are now removed from the list, we can remove the
associated test in update_blocked_averages().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ffd1ae7..badf8173 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -346,6 +346,18 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->on_list) {
+		struct rq *rq = rq_of(cfs_rq);
+
+		/*
+		 * With cfs_rq being unthrottled/throttled during an enqueue,
+		 * it can happen the tmp_alone_branch points the a leaf that
+		 * we finally want to del. In this case, tmp_alone_branch moves
+		 * to the prev element but it will point to rq->leaf_cfs_rq_list
+		 * at the end of the enqueue.
+		 */
+		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
+			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
+
 		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
 		cfs_rq->on_list = 0;
 	}
@@ -4438,6 +4450,10 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		/* adjust cfs_rq_clock_task() */
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
+
+		/* Add cfs_rq with already running entity in the list */
+		if (cfs_rq->nr_running >= 1)
+			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 	return 0;
@@ -4449,8 +4465,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
 
 	/* group is entering throttled state, stop time */
-	if (!cfs_rq->throttle_count)
+	if (!cfs_rq->throttle_count) {
 		cfs_rq->throttled_clock_task = rq_clock_task(rq);
+		list_del_leaf_cfs_rq(cfs_rq);
+	}
 	cfs_rq->throttle_count++;
 
 	return 0;
@@ -7699,10 +7717,6 @@ static void update_blocked_averages(int cpu)
 	for_each_leaf_cfs_rq(rq, cfs_rq) {
 		struct sched_entity *se;
 
-		/* throttled entities do not contribute to load */
-		if (throttled_hierarchy(cfs_rq))
-			continue;
-
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
 			update_tg_load_avg(cfs_rq, 0);
 
-- 
2.7.4

