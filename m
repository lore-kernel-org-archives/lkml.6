Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A962C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCDA208B9
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCDA208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeH0Ah0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:37:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbeH0Ah0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:37:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 562AFDFDD;
        Sun, 26 Aug 2018 20:53:46 +0000 (UTC)
Received: from llong.com (ovpn-121-41.rdu2.redhat.com [10.10.121.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAC002026D76;
        Sun, 26 Aug 2018 20:53:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/3] sched/core: Export wake_q functions to kernel modules
Date:   Sun, 26 Aug 2018 16:53:13 -0400
Message-Id: <1535316795-21560-2-git-send-email-longman@redhat.com>
In-Reply-To: <1535316795-21560-1-git-send-email-longman@redhat.com>
References: <1535316795-21560-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 26 Aug 2018 20:53:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 26 Aug 2018 20:53:46 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of wake_q_add() and wake_up_q() functions help to do task wakeup
without holding lock can help to reduce lock hold time. They should be
available to kernel modules as well.

A new task_in_wake_q() inline function is also added to check if the
given task is in a wake_q.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/wake_q.h | 5 +++++
 kernel/sched/core.c          | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 10b19a192b2d..902bf1228d32 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -47,6 +47,11 @@ static inline void wake_q_init(struct wake_q_head *head)
 	head->lastp = &head->first;
 }
 
+static inline bool task_in_wake_q(struct task_struct *task)
+{
+	return READ_ONCE(task->wake_q.next) != NULL;
+}
+
 extern void wake_q_add(struct wake_q_head *head,
 		       struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..d90a2930b8ce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -420,6 +420,7 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	*head->lastp = node;
 	head->lastp = &node->next;
 }
+EXPORT_SYMBOL_GPL(wake_q_add);
 
 void wake_up_q(struct wake_q_head *head)
 {
@@ -442,6 +443,7 @@ void wake_up_q(struct wake_q_head *head)
 		put_task_struct(task);
 	}
 }
+EXPORT_SYMBOL_GPL(wake_up_q);
 
 /*
  * resched_curr - mark rq's current task 'to be rescheduled now'.
-- 
2.18.0

