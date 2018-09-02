Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D9EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798452077C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798452077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeIBNoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:44:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeIBNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:44:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwOgh-0008MN-7l; Sun, 02 Sep 2018 11:28:55 +0200
Subject: [GIT pull] smp/hotplug updates for 4.19
Message-ID: <153588048102.6192.6508499255634186747.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <153588048102.6192.18075264253310979408.tglx@nanos.tec.linutronix.de>
Date:   Sun, 02 Sep 2018 11:28:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

Remove the stale skip_onerr member from the hotplug states.

Thanks,

	tglx

------------------>
Mukesh Ojha (1):
      cpu/hotplug: Remove skip_onerr field from cpuhp_step structure


 kernel/cpu.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index ed44d7d34c2d..aa7fe85ad62e 100644
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
@@ -673,7 +660,6 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		st->should_run = false;
 	}
 
-next:
 	cpuhp_lock_release(bringup);
 
 	if (!st->should_run)
@@ -916,12 +902,8 @@ void cpuhp_report_idle_dead(void)
 
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

