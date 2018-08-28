Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E049C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DC4208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G7tEdrT/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="knypuHw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DC4208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeH1KpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:45:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeH1KpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:45:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6850460159; Tue, 28 Aug 2018 06:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535439304;
        bh=Kc12Ub6HL4r6hwWD8QO/fMnv81Dlaik6oLw7c43M2nw=;
        h=From:To:Cc:Subject:Date:From;
        b=G7tEdrT/+WPVIabjWfNAGJHvsjUF2YvPkG8FvhhzGng4XW/onAXL6PcsXkB33+uR4
         Y/ZgnJACrBLH3AaonBBGhPmWPqbjelLqYRJ6SfsPgHgJrg8t5Chai9IEAnS0ZsuTNh
         DQvZ0w0/hU6mwR4ItgnyadZZ4A7xyr0wN76kqxnQ=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE8D360159;
        Tue, 28 Aug 2018 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535439303;
        bh=Kc12Ub6HL4r6hwWD8QO/fMnv81Dlaik6oLw7c43M2nw=;
        h=From:To:Cc:Subject:Date:From;
        b=knypuHw0hZ+UjRMt9ZqvrsryFHMxte+s/fX0HurMFEg94MO1JJ9R7PgOhtku+S+fz
         4cvTv6kaac/1CW+dTV6AVFdrAt05EhzxOdK5Y/TPs2yt9cJcQNtSzAwUEg2Z3scT/4
         Maz9ghAPzoDa/php57wXiN6dx79AvAcv4zuq69UI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE8D360159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] cpu/hotplug: Remove skip_onerr field from cpuhp_step structure
Date:   Tue, 28 Aug 2018 12:24:54 +0530
Message-Id: <1535439294-31426-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When notifiers were there, we were using `skip_onerr` to avoid
calling particular step startup/teardown callback in CPU up/down
rollback path, which made the hotplug a bit asymmetric.

As notifiers are gone now after state machine introduction. So,
`skip_onerr` field is no longer valid.

Remove it from the structure and its usage.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>

---
 kernel/cpu.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index ed44d7d..c544baf 100644
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
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

