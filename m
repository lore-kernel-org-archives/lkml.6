Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10783C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34DF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hm0uYdfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfA2RS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:18:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44861 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2RS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:18:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so22938604wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bOjQszdiXiJL/fJroUex0a3tZRSKXR3lbPIDzGKz6dY=;
        b=hm0uYdfUAsjCU6FQ/w5UYUPg0eoT3+X9LWXR8KmkKg3GzbOriYDv/JAfS41pjVQ2ED
         RjtiJGac9TjizjBJeYiEM1G97hew/v5mFgwtQ4AGZzJO+L1mzjUDaV0D6bB1M1U9VMAc
         7WQ6SxVdEXQfrCMyamvOW6mOJ3GQgfMRKCu1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bOjQszdiXiJL/fJroUex0a3tZRSKXR3lbPIDzGKz6dY=;
        b=Wk2tKwSEVt3ubM+iSywyBaBopOh97UU4m1CqwZMW1BFf4XXfTQFiJ8CaQG9CdmNEp4
         OZZFoMNZjk9uieot/cQ5Rp6cI+D8JxojVkTKmuQxBlnIJXpj11weLlJCX0+euEkkLniP
         VX6dToPggWNxxqoGpkEckoy+mWWuS9Og68WWI6AhKHpicYDqOCi3C+xGStCWYlEEgqpN
         0owPfay5ARZFbPoozcoIFHZGRDdvCHKKZ4Ayd7OxqzHPNBp2VYprWMp2XOWUvqslLpJp
         y+GpEVgXrub80C5RwPW2X3tw0ZvBatx6GPqLaMV4Bqd7jtYw6OzCSoxCzqS4N2Enug4J
         6vjg==
X-Gm-Message-State: AHQUAuY7nVBdVJKG0vjP481yBB07SeThv9Ijo+JY8Q3plfkotibpP12B
        nWR0auuga6T4PJV76ID1rtVeiSwKBgBbNA==
X-Google-Smtp-Source: AHgI3IYGF3piTZyKLK4DwZAvkdu5eP7gDUOq9d7Dde9nbu4PbYBjPrHyBdMy8192HgaAOffoiL4AIA==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr5597972wru.28.1548782335864;
        Tue, 29 Jan 2019 09:18:55 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a13d:e482:c90f:2b78])
        by smtp.gmail.com with ESMTPSA id x3sm116048550wrd.19.2019.01.29.09.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 09:18:55 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     tj@kernel.org, sargun@sargun.me,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Date:   Tue, 29 Jan 2019 18:18:52 +0100
Message-Id: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sargu reported a crash:
  "I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
   infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
   and put it on top of 4.19.13. In addition to this, I uninlined
   list_add_leaf_cfs_rq for debugging.

   This revealed a new bug that we didn't get to because we kept getting
   crashes from the previous issue. When we are running with cgroups that
   are rapidly changing, with CFS bandwidth control, and in addition
   using the cpusets cgroup, we see this crash. Specifically, it seems to
   occur with cgroups that are throttled and we change the allowed
   cpuset."

The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
it will walk down to root the 1st time a cfs_rq is used and we will finish
to add either a cfs_rq without parent or a cfs_rq with a parent that is
already on the list. But this is not always true in presence of throttling.
Because a cfs_rq can be throttled even if it has never been used but other CPUS
of the cgroup have already used all the bandwdith, we are not sure to go down to
the root and add all cfs_rq in the list.

Ensure that all cfs_rq will be added in the list even if they are throttled.

Reported-by: Sargun Dhillon <sargun@sargun.me>
Fixes: 9c2791f936ef ("Fix hierarchical order in rq->leaf_cfs_rq_list")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

This patch doesn't fix:
  a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
which has been reverted in v5.0-rc1. I'm working on an additonal patch
that should be similar to this one to fix a9e7f6544b9c.

 kernel/sched/fair.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2ff4b6..bf6b6c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -352,6 +352,20 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 }
 
+static inline void list_add_branch_cfs_rq(struct sched_entity *se, struct rq *rq)
+{
+	struct cfs_rq *cfs_rq;
+
+	for_each_sched_entity(se) {
+		cfs_rq = cfs_rq_of(se);
+		list_add_leaf_cfs_rq(cfs_rq);
+
+		/* If parent is already in the list, we can stop */
+		if (rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
+			break;
+	}
+}
+
 /* Iterate through all leaf cfs_rq's on a runqueue: */
 #define for_each_leaf_cfs_rq(rq, cfs_rq) \
 	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
@@ -5179,6 +5193,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
+	/* Ensure that all cfs_rq have been added to the list */
+	list_add_branch_cfs_rq(se, rq);
+
 	hrtick_update(rq);
 }
 
-- 
2.7.4

