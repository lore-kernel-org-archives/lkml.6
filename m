Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C40C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7882098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7882098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeHWT4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:56:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbeHWT4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:56:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E90F97DAC9;
        Thu, 23 Aug 2018 16:26:19 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD29A10CD7D5;
        Thu, 23 Aug 2018 16:26:19 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] sched/core: Export wake_q functions to kernel modules
Date:   Thu, 23 Aug 2018 12:26:09 -0400
Message-Id: <1535041570-24102-2-git-send-email-longman@redhat.com>
In-Reply-To: <1535041570-24102-1-git-send-email-longman@redhat.com>
References: <1535041570-24102-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 16:26:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 16:26:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of wake_q_add() and wake_up_q() functions help to do task wakeup
without holding lock can help to reduce lock hold time. They should be
available to kernel modules as well.

A new wake_q_empty() inline function is also added.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/wake_q.h | 5 +++++
 kernel/sched/core.c          | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 10b19a1..b1895a7 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -47,6 +47,11 @@ static inline void wake_q_init(struct wake_q_head *head)
 	head->lastp = &head->first;
 }
 
+static inline bool wake_q_empty(struct wake_q_head *head)
+{
+	return head->first == WAKE_Q_TAIL;
+}
+
 extern void wake_q_add(struct wake_q_head *head,
 		       struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 63a6462..4b3c8e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -456,6 +456,7 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	*head->lastp = node;
 	head->lastp = &node->next;
 }
+EXPORT_SYMBOL_GPL(wake_q_add);
 
 void wake_up_q(struct wake_q_head *head)
 {
@@ -478,6 +479,7 @@ void wake_up_q(struct wake_q_head *head)
 		put_task_struct(task);
 	}
 }
+EXPORT_SYMBOL_GPL(wake_up_q);
 
 /*
  * resched_curr - mark rq's current task 'to be rescheduled now'.
-- 
1.8.3.1

