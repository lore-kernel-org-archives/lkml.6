Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F770C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D0C20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D0C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeILVt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:49:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbeILVt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:49:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DC2087916;
        Wed, 12 Sep 2018 16:33:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 809562157F49;
        Wed, 12 Sep 2018 16:33:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 Sep 2018 18:33:59 +0200 (CEST)
Date:   Wed, 12 Sep 2018 18:33:57 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hung_task: change check_hung_uninterruptible_tasks() to
 use for_each_process_thread_break/continue
Message-ID: <20180912163357.GB18748@redhat.com>
References: <20180912163312.GA18739@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912163312.GA18739@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 16:33:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 16:33:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change check_hung_uninterruptible_tasks() to use the new helpers and remove
the "can_cont" logic from rcu_lock_break().

We could add for_each_process_thread_break/continue right into rcu_lock_break()
but see the next patch.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/hung_task.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b9132d1..13af558 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -148,20 +148,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
  * For preemptible RCU it is sufficient to call rcu_read_unlock in order
  * to exit the grace period. For classic RCU, a reschedule is required.
  */
-static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
+static void rcu_lock_break(void)
 {
-	bool can_cont;
-
-	get_task_struct(g);
-	get_task_struct(t);
 	rcu_read_unlock();
 	cond_resched();
 	rcu_read_lock();
-	can_cont = pid_alive(g) && pid_alive(t);
-	put_task_struct(t);
-	put_task_struct(g);
-
-	return can_cont;
 }
 
 /*
@@ -185,16 +176,18 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
-		if (!max_count--)
+		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
+		if (t->state == TASK_UNINTERRUPTIBLE)
+			check_hung_task(t, timeout);
+
+		if (!--max_count)
 			goto unlock;
 		if (!--batch_count) {
 			batch_count = HUNG_TASK_BATCHING;
-			if (!rcu_lock_break(g, t))
-				goto unlock;
+			for_each_process_thread_break(g, t);
+			rcu_lock_break();
+			for_each_process_thread_continue(&g, &t);
 		}
-		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
-		if (t->state == TASK_UNINTERRUPTIBLE)
-			check_hung_task(t, timeout);
 	}
  unlock:
 	rcu_read_unlock();
-- 
2.5.0


