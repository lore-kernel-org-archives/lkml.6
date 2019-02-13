Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFC9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A87222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbfBMIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:30:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbfBMIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:30:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D8Ulic189339
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 00:30:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D8UlRX189336;
        Wed, 13 Feb 2019 00:30:47 -0800
Date:   Wed, 13 Feb 2019 00:30:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Zhang, Jun" <tipbot@zytor.com>
Message-ID: <tip-1d1f898df6586c5ea9aeaf349f13089c6fa37903@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bo.he@intel.com,
        hpa@zytor.com, tglx@linutronix.de, jun.zhang@intel.com,
        jin.xiao@intel.com, paulmck@linux.ibm.com, jie.a.bai@intel.com
Reply-To: paulmck@linux.ibm.com, jie.a.bai@intel.com, jin.xiao@intel.com,
          hpa@zytor.com, tglx@linutronix.de, jun.zhang@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, bo.he@intel.com
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] rcu: Do RCU GP kthread self-wakeup from softirq and
 interrupt
Git-Commit-ID: 1d1f898df6586c5ea9aeaf349f13089c6fa37903
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

Commit-ID:  1d1f898df6586c5ea9aeaf349f13089c6fa37903
Gitweb:     https://git.kernel.org/tip/1d1f898df6586c5ea9aeaf349f13089c6fa37903
Author:     Zhang, Jun <jun.zhang@intel.com>
AuthorDate: Tue, 18 Dec 2018 06:55:01 -0800
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Fri, 25 Jan 2019 15:29:59 -0800

rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

The rcu_gp_kthread_wake() function is invoked when it might be necessary
to wake the RCU grace-period kthread.  Because self-wakeups are normally
a useless waste of CPU cycles, if rcu_gp_kthread_wake() is invoked from
this kthread, it naturally refuses to do the wakeup.

Unfortunately, natural though it might be, this heuristic fails when
rcu_gp_kthread_wake() is invoked from an interrupt or softirq handler
that interrupted the grace-period kthread just after the final check of
the wait-event condition but just before the schedule() call.  In this
case, a wakeup is required, even though the call to rcu_gp_kthread_wake()
is within the RCU grace-period kthread's context.  Failing to provide
this wakeup can result in grace periods failing to start, which in turn
results in out-of-memory conditions.

This race window is quite narrow, but it actually did happen during real
testing.  It would of course need to be fixed even if it was strictly
theoretical in nature.

This patch does not Cc stable because it does not apply cleanly to
earlier kernel versions.

Fixes: 48a7639ce80c ("rcu: Make callers awaken grace-period kthread")
Reported-by: "He, Bo" <bo.he@intel.com>
Co-developed-by: "Zhang, Jun" <jun.zhang@intel.com>
Co-developed-by: "He, Bo" <bo.he@intel.com>
Co-developed-by: "xiao, jin" <jin.xiao@intel.com>
Co-developed-by: Bai, Jie A <jie.a.bai@intel.com>
Signed-off: "Zhang, Jun" <jun.zhang@intel.com>
Signed-off: "He, Bo" <bo.he@intel.com>
Signed-off: "xiao, jin" <jin.xiao@intel.com>
Signed-off: Bai, Jie A <jie.a.bai@intel.com>
Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>
[ paulmck: Switch from !in_softirq() to "!in_interrupt() &&
  !in_serving_softirq() to avoid redundant wakeups and to also handle the
  interrupt-handler scenario as well as the softirq-handler scenario that
  actually occurred in testing. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Link: https://lkml.kernel.org/r/CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com
---
 kernel/rcu/tree.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9ceb93f848cd..21775eebb8f0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1593,15 +1593,23 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 }
 
 /*
- * Awaken the grace-period kthread.  Don't do a self-awaken, and don't
- * bother awakening when there is nothing for the grace-period kthread
- * to do (as in several CPUs raced to awaken, and we lost), and finally
- * don't try to awaken a kthread that has not yet been created.  If
- * all those checks are passed, track some debug information and awaken.
+ * Awaken the grace-period kthread.  Don't do a self-awaken (unless in
+ * an interrupt or softirq handler), and don't bother awakening when there
+ * is nothing for the grace-period kthread to do (as in several CPUs raced
+ * to awaken, and we lost), and finally don't try to awaken a kthread that
+ * has not yet been created.  If all those checks are passed, track some
+ * debug information and awaken.
+ *
+ * So why do the self-wakeup when in an interrupt or softirq handler
+ * in the grace-period kthread's context?  Because the kthread might have
+ * been interrupted just as it was going to sleep, and just after the final
+ * pre-sleep check of the awaken condition.  In this case, a wakeup really
+ * is required, and is therefore supplied.
  */
 static void rcu_gp_kthread_wake(void)
 {
-	if (current == rcu_state.gp_kthread ||
+	if ((current == rcu_state.gp_kthread &&
+	     !in_interrupt() && !in_serving_softirq()) ||
 	    !READ_ONCE(rcu_state.gp_flags) ||
 	    !rcu_state.gp_kthread)
 		return;
