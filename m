Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7DEC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEEB20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2DSpdQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfA3FXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:23:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37687 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfA3FXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:23:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so20151331wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 21:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=06OAt3prsZG+l6s8Qp99Ip2RXja0vs/0PYt5i3Pia90=;
        b=c2DSpdQmUlLR81QkXCFHNXdgRPMSjz81amSQYYD8St+ys1TXQCgXTgUUlntRvJ0TD0
         a6haEOcV89f+0tWif/MIO6fFcUXP5EmaopZUlaSjGMaAdZkgOUVq08TbQKaRIbcjtfwW
         XhtKUlXF9HMaiXkWWFKP3W6VhfKICfDT/myqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=06OAt3prsZG+l6s8Qp99Ip2RXja0vs/0PYt5i3Pia90=;
        b=WW0dQkwGFmmMvQuhucheDbLaPDfJndlHUKpCOehbJ5UETNofcAAQLj+B9Kci/24pCl
         6cd243tsY/PFLJ4de/w5tXU9QJ7KdIu3rWBUOLc3IwhT2K41yUvRy3yxFOBSfArO/TnO
         1JbWBVQiYg2z7TTVhi+yjOsXFSGg19rGBzfAI34AeiYjGXTGeRXfDbiSGx+Kp5E4AMoh
         Ozs7QCqVArgC3d95Nak9EIn0dfN3EQM+GSC61vVxq9ffSAfL9rHBrO6ADtwunKTrUBnV
         rggpfc5fFHLsi8PloilPIDEuPuugIoyu/IfnTo9Bm4wZ9NUqWHeiz+zlmzwUALdl1VIX
         ouFA==
X-Gm-Message-State: AJcUukcWJH/Iv4QJ7C7ZrybHvuAsTBflmpXy0uNJwW4yy9bev02FgG+0
        Bt/v3SLAN8NS6SMVR2RoqK7ttorLzZmHaw==
X-Google-Smtp-Source: ALg8bN4x1e5f/mLWu9to+rJOk1OiwZuAKqjzpBBhCZqqDsT4zxbmBMjPrdw4DCvAiSyQHHrDRSqo4g==
X-Received: by 2002:a1c:8484:: with SMTP id g126mr24823375wmd.117.1548825782794;
        Tue, 29 Jan 2019 21:23:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a13d:e482:c90f:2b78])
        by smtp.gmail.com with ESMTPSA id c21sm731809wre.71.2019.01.29.21.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 21:23:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     tj@kernel.org, sargun@sargun.me,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Date:   Wed, 30 Jan 2019 06:22:47 +0100
Message-Id: <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sargun reported a crash:
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
Because a cfs_rq can be throttled even if it has never been used but other CPUs
of the cgroup have already used all the bandwdith, we are not sure to go down to
the root and add all cfs_rq in the list.

Ensure that all cfs_rq will be added in the list even if they are throttled.

Reported-by: Sargun Dhillon <sargun@sargun.me>
Fixes: 9c2791f936ef ("Fix hierarchical order in rq->leaf_cfs_rq_list")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

v2:
- Added dummy function for !CONFIG_FAIR_GROUP_SCHED

This patch doesn't fix:
  a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
which has been reverted in v5.0-rc1. I'm working on an additonal patch
that should be similar to this one to fix a9e7f6544b9c.

 kernel/sched/fair.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2ff4b6..826fbe5 100644
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
@@ -446,6 +460,10 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 }
 
+static inline void list_add_branch_cfs_rq(struct sched_entity *se, struct rq *rq)
+{
+}
+
 #define for_each_leaf_cfs_rq(rq, cfs_rq)	\
 		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
 
@@ -5179,6 +5197,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
+	/* Ensure that all cfs_rq have been added to the list */
+	list_add_branch_cfs_rq(se, rq);
+
 	hrtick_update(rq);
 }
 
-- 
2.7.4

