Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC015C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F23B2250F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="npsFT8sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F23B2250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeKNMsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeKNMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:59 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0D3223CB;
        Wed, 14 Nov 2018 02:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163608;
        bh=LXncx3we7Z2VOO4mA8aqgsFzf+eMw/kL2W6g3aA2Ivs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npsFT8sbBmm3dis6HnEBDMhwVH4wl3/0cAkFnaWlfsx3F9VroqIksxvbtXfG/3632
         ZFzZrC8j62VuG/jXp5WoC9t09NIl26sfnKz9hvZpVxvIaJYw80rfsub1iKXXjStp7b
         buama2CxD3O5ZtUabR8k3hNAMP1zKnjFc0Y2Fqf0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 14/25] sched/vtime: Rename vtime_accounting_cpu_enabled() to vtime_accounting_enabled_this_cpu()
Date:   Wed, 14 Nov 2018 03:45:58 +0100
Message-Id: <1542163569-20047-15-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the naming on top of the vtime_accounting_enabled_*() base.
Also make it clear we are checking the vtime state of the
*current* CPU with this function. We'll need to add an API to check that
state on remote CPUs as well, so we must disambiguate the naming.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking.h |  4 ++--
 include/linux/vtime.h            | 10 +++++-----
 kernel/sched/cputime.c           |  2 +-
 kernel/time/tick-sched.c         |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index c9065ad..64ec828 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -103,7 +103,7 @@ static inline void context_tracking_init(void) { }
 /* must be called with irqs disabled */
 static inline void guest_enter_irqoff(void)
 {
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_enter(current);
 	else
 		current->flags |= PF_VCPU;
@@ -127,7 +127,7 @@ static inline void guest_exit_irqoff(void)
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_exit(current);
 	else
 		current->flags &= ~PF_VCPU;
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index df03b37..82fed7a 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -11,11 +11,11 @@
 struct task_struct;
 
 /*
- * vtime_accounting_cpu_enabled() definitions/declarations
+ * vtime_accounting_enabled_this_cpu() definitions/declarations
  */
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
 
-static inline bool vtime_accounting_cpu_enabled(void) { return true; }
+static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
 extern void vtime_task_switch(struct task_struct *prev);
 
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
@@ -31,7 +31,7 @@ static inline bool vtime_accounting_enabled(void)
 	return context_tracking_enabled();
 }
 
-static inline bool vtime_accounting_cpu_enabled(void)
+static inline bool vtime_accounting_enabled_this_cpu(void)
 {
 	if (vtime_accounting_enabled()) {
 		if (context_tracking_enabled_this_cpu())
@@ -45,13 +45,13 @@ extern void vtime_task_switch_generic(struct task_struct *prev);
 
 static inline void vtime_task_switch(struct task_struct *prev)
 {
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_task_switch_generic(prev);
 }
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
-static inline bool vtime_accounting_cpu_enabled(void) { return false; }
+static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
 static inline void vtime_task_switch(struct task_struct *prev) { }
 
 #endif
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2eb313a..61aa7ba 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -474,7 +474,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	u64 cputime, steal;
 	struct rq *rq = this_rq();
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		return;
 
 	if (sched_clock_irqtime) {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 69e673b..482da8e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1094,7 +1094,7 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	unsigned long ticks;
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
 	 * We stopped the tick in idle. Update process times would miss the
-- 
2.7.4

