Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0848CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC6E2082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC6E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeH3PFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:05:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeH3PFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:05:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UB3wbU1729174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 04:03:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UB3w051729168;
        Thu, 30 Aug 2018 04:03:58 -0700
Date:   Thu, 30 Aug 2018 04:03:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mukesh Ojha <tipbot@zytor.com>
Message-ID: <tip-935aad3015fb4afc0b7ef6e6c18175b95461de47@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mojha@codeaurora.org
Reply-To: mojha@codeaurora.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
          mingo@kernel.org
In-Reply-To: <1535439294-31426-1-git-send-email-mojha@codeaurora.org>
References: <1535439294-31426-1-git-send-email-mojha@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/hotplug: Remove skip_onerr field from
 cpuhp_step structure
Git-Commit-ID: 935aad3015fb4afc0b7ef6e6c18175b95461de47
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

Commit-ID:  935aad3015fb4afc0b7ef6e6c18175b95461de47
Gitweb:     https://git.kernel.org/tip/935aad3015fb4afc0b7ef6e6c18175b95461de47
Author:     Mukesh Ojha <mojha@codeaurora.org>
AuthorDate: Tue, 28 Aug 2018 12:24:54 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 12:59:30 +0200

cpu/hotplug: Remove skip_onerr field from cpuhp_step structure

When notifiers were there, `skip_onerr` was used to avoid calling
particular step startup/teardown callbacks in the CPU up/down rollback
path, which made the hotplug asymmetric.

As notifiers are gone now after the full state machine conversion, the
`skip_onerr` field is no longer required.

Remove it from the structure and its usage.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1535439294-31426-1-git-send-email-mojha@codeaurora.org


---
 kernel/cpu.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index ed44d7d34c2d..c544baf75e77 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -102,8 +102,6 @@ static inline void cpuhp_lock_release(bool bringup) { }
  * @name:	Name of the step
  * @startup:	Startup function of the step
  * @teardown:	Teardown function of the step
- * @skip_onerr:	Do not invoke the functions on error rollback
- *		Will go away once the notifiers	are gone
  * @cant_stop:	Bringup/teardown can't be stopped at this step
  */
 struct cpuhp_step {
@@ -119,7 +117,6 @@ struct cpuhp_step {
 					 struct hlist_node *node);
 	} teardown;
 	struct hlist_head	list;
-	bool			skip_onerr;
 	bool			cant_stop;
 	bool			multi_instance;
 };
@@ -550,12 +547,8 @@ static int bringup_cpu(unsigned int cpu)
 
 static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
 {
-	for (st->state--; st->state > st->target; st->state--) {
-		struct cpuhp_step *step = cpuhp_get_step(st->state);
-
-		if (!step->skip_onerr)
-			cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
-	}
+	for (st->state--; st->state > st->target; st->state--)
+		cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
 }
 
 static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
@@ -644,12 +637,6 @@ static void cpuhp_thread_fun(unsigned int cpu)
 
 	WARN_ON_ONCE(!cpuhp_is_ap_state(state));
 
-	if (st->rollback) {
-		struct cpuhp_step *step = cpuhp_get_step(state);
-		if (step->skip_onerr)
-			goto next;
-	}
-
 	if (cpuhp_is_atomic_state(state)) {
 		local_irq_disable();
 		st->result = cpuhp_invoke_callback(cpu, state, bringup, st->node, &st->last);
@@ -916,12 +903,8 @@ void cpuhp_report_idle_dead(void)
 
 static void undo_cpu_down(unsigned int cpu, struct cpuhp_cpu_state *st)
 {
-	for (st->state++; st->state < st->target; st->state++) {
-		struct cpuhp_step *step = cpuhp_get_step(st->state);
-
-		if (!step->skip_onerr)
-			cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-	}
+	for (st->state++; st->state < st->target; st->state++)
+		cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
 }
 
 static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
