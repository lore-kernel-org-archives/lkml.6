Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BC1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7C21470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C7C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeGQJmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:42:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeGQJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:42:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9BBaN1458641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:11:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9BAA21458638;
        Tue, 17 Jul 2018 02:11:10 -0700
Date:   Tue, 17 Jul 2018 02:11:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-c03be752d39dc64dcfda0ac8ce87fb10b1ee5621@git.kernel.org>
Cc:     hpa@zytor.com, rostedt@goodmis.org, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, joel@joelfernandes.org,
          tglx@linutronix.de, paulmck@linux.vnet.ibm.com, mingo@kernel.org,
          rostedt@goodmis.org, hpa@zytor.com
In-Reply-To: <20180523063815.198302-2-joel@joelfernandes.org>
References: <20180523063815.198302-2-joel@joelfernandes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] rcu: Speed up calling of RCU tasks callbacks
Git-Commit-ID: c03be752d39dc64dcfda0ac8ce87fb10b1ee5621
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

Commit-ID:  c03be752d39dc64dcfda0ac8ce87fb10b1ee5621
Gitweb:     https://git.kernel.org/tip/c03be752d39dc64dcfda0ac8ce87fb10b1ee5621
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Thu, 24 May 2018 18:49:46 -0400
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Thu, 12 Jul 2018 15:39:21 -0700

rcu: Speed up calling of RCU tasks callbacks

Joel Fernandes found that the synchronize_rcu_tasks() was taking a
significant amount of time. He demonstrated it with the following test:

 # cd /sys/kernel/tracing
 # while [ 1 ]; do x=1; done &
 # echo '__schedule_bug:traceon' > set_ftrace_filter
 # time echo '!__schedule_bug:traceon' > set_ftrace_filter;

real	0m1.064s
user	0m0.000s
sys	0m0.004s

Where it takes a little over a second to perform the synchronize,
because there's a loop that waits 1 second at a time for tasks to get
through their quiescent points when there's a task that must be waited
for.

After discussion we came up with a simple way to wait for holdouts but
increase the time for each iteration of the loop but no more than a
full second.

With the new patch we have:

 # time echo '!__schedule_bug:traceon' > set_ftrace_filter;

real	0m0.131s
user	0m0.000s
sys	0m0.004s

Which drops it down to 13% of what the original wait time was.

Link: http://lkml.kernel.org/r/20180523063815.198302-2-joel@joelfernandes.org
Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/update.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 5783bdf86e5a..4c7c49c106ee 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -668,6 +668,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	struct rcu_head *list;
 	struct rcu_head *next;
 	LIST_HEAD(rcu_tasks_holdouts);
+	int fract;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
 	housekeeping_affine(current, HK_FLAG_RCU);
@@ -749,13 +750,25 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 * holdouts.  When the list is empty, we are done.
 		 */
 		lastreport = jiffies;
-		while (!list_empty(&rcu_tasks_holdouts)) {
+
+		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
+		fract = 10;
+
+		for (;;) {
 			bool firstreport;
 			bool needreport;
 			int rtst;
 			struct task_struct *t1;
 
-			schedule_timeout_interruptible(HZ);
+			if (list_empty(&rcu_tasks_holdouts))
+				break;
+
+			/* Slowly back off waiting for holdouts */
+			schedule_timeout_interruptible(HZ/fract);
+
+			if (fract > 1)
+				fract--;
+
 			rtst = READ_ONCE(rcu_task_stall_timeout);
 			needreport = rtst > 0 &&
 				     time_after(jiffies, lastreport + rtst);
