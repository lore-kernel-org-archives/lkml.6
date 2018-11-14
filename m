Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D44EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDADC223CB
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNLK4jR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDADC223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbeKNMrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeKNMrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:52 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF2EA2250E;
        Wed, 14 Nov 2018 02:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163601;
        bh=PG0cmboZy6WlamEWQJiGgHf2JCcyoac1MZkRSbeIx14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNLK4jR1Oqh6+piK6mjdugDxki3laMp3OTgjxuB36SBMogxAD5WMaMKDNno1cEbyd
         pZnpH/wKEqYTlnnNF4aQCUO3+qcsj14eOgVVQZB7jUBJ8zxbtn0K0u/Ff1+yA+JBsa
         yL49gT/yroiglO1lGLxVy4dclAJd3MrcOc/B0oew=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 11/25] context_tracking: s/context_tracking_is_enabled/context_tracking_enabled()
Date:   Wed, 14 Nov 2018 03:45:55 +0100
Message-Id: <1542163569-20047-12-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the superfluous "is" in the middle of the name. We want to
standardize the naming so that it can be expanded through suffixes:

	context_tracking_enabled()
	context_tracking_enabled_cpu()
	context_tracking_enabled_this_cpu()

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h               |  2 +-
 include/linux/context_tracking.h       | 20 ++++++++++----------
 include/linux/context_tracking_state.h |  8 ++++----
 include/linux/tick.h                   |  2 +-
 include/linux/vtime.h                  |  2 +-
 kernel/context_tracking.c              |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 25e5a6b..9fe7ed3 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -352,7 +352,7 @@ For 32-bit we have the following conventions - kernel is built with
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef HAVE_JUMP_LABEL
-	STATIC_BRANCH_JMP l_yes=.Lafter_call_\@, key=context_tracking_enabled, branch=1
+	STATIC_BRANCH_JMP l_yes=.Lafter_call_\@, key=context_tracking_key, branch=1
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 558a209..f1601ba 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -22,26 +22,26 @@ extern void context_tracking_user_exit(void);
 
 static inline void user_enter(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		context_tracking_enter(CONTEXT_USER);
 
 }
 static inline void user_exit(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		context_tracking_exit(CONTEXT_USER);
 }
 
 /* Called with interrupts disabled.  */
 static inline void user_enter_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_USER);
 
 }
 static inline void user_exit_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_USER);
 }
 
@@ -49,7 +49,7 @@ static inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (!context_tracking_is_enabled())
+	if (!context_tracking_enabled())
 		return 0;
 
 	prev_ctx = this_cpu_read(context_tracking.state);
@@ -61,7 +61,7 @@ static inline enum ctx_state exception_enter(void)
 
 static inline void exception_exit(enum ctx_state prev_ctx)
 {
-	if (context_tracking_is_enabled()) {
+	if (context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
 			context_tracking_enter(prev_ctx);
 	}
@@ -77,7 +77,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
  */
 static inline enum ctx_state ct_state(void)
 {
-	return context_tracking_is_enabled() ?
+	return context_tracking_enabled() ?
 		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
 }
 #else
@@ -90,7 +90,7 @@ static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
 #endif /* !CONFIG_CONTEXT_TRACKING */
 
-#define CT_WARN_ON(cond) WARN_ON(context_tracking_is_enabled() && (cond))
+#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
 
 #ifdef CONFIG_CONTEXT_TRACKING_FORCE
 extern void context_tracking_init(void);
@@ -108,7 +108,7 @@ static inline void guest_enter_irqoff(void)
 	else
 		current->flags |= PF_VCPU;
 
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_GUEST);
 
 	/* KVM does not hold any references to rcu protected data when it
@@ -124,7 +124,7 @@ static inline void guest_enter_irqoff(void)
 
 static inline void guest_exit_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
 	if (vtime_accounting_cpu_enabled())
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index f4633c2..91250bd 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -23,12 +23,12 @@ struct context_tracking {
 };
 
 #ifdef CONFIG_CONTEXT_TRACKING
-extern struct static_key_false context_tracking_enabled;
+extern struct static_key_false context_tracking_key;
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
-static inline bool context_tracking_is_enabled(void)
+static inline bool context_tracking_enabled(void)
 {
-	return static_branch_unlikely(&context_tracking_enabled);
+	return static_branch_unlikely(&context_tracking_key);
 }
 
 static inline bool context_tracking_cpu_is_enabled(void)
@@ -42,7 +42,7 @@ static inline bool context_tracking_in_user(void)
 }
 #else
 static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_is_enabled(void) { return false; }
+static inline bool context_tracking_enabled(void) { return false; }
 static inline bool context_tracking_cpu_is_enabled(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab..67fb467 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -163,7 +163,7 @@ extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
 {
-	if (!context_tracking_is_enabled())
+	if (!context_tracking_enabled())
 		return false;
 
 	return tick_nohz_full_running;
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 8350a0b..01f09ca 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -28,7 +28,7 @@ extern void vtime_task_switch(struct task_struct *prev);
  */
 static inline bool vtime_accounting_enabled(void)
 {
-	return context_tracking_is_enabled();
+	return context_tracking_enabled();
 }
 
 static inline bool vtime_accounting_cpu_enabled(void)
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 9ad37b9..1533862 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -24,8 +24,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE(context_tracking_enabled);
-EXPORT_SYMBOL_GPL(context_tracking_enabled);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
+EXPORT_SYMBOL_GPL(context_tracking_key);
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking);
 EXPORT_SYMBOL_GPL(context_tracking);
@@ -191,7 +191,7 @@ void __init context_tracking_cpu_set(int cpu)
 
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
-		static_branch_inc(&context_tracking_enabled);
+		static_branch_inc(&context_tracking_key);
 	}
 
 	if (initialized)
-- 
2.7.4

