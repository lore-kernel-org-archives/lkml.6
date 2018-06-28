Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45292779C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="K7eZspCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45292779C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967821AbeF1SXE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:23:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37699 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030437AbeF1SWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:22:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id h20-v6so1052806pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rP7eurICyIZQBfcjqQ2vzisdGfNYym2lsKWx2Zea9ds=;
        b=K7eZspCbcWqZ1JicZsv0pU9sTd5mETSHou+0xsvZpY6PfINbK3/SJL4rjVXbYx6pby
         xNRdhs71FkrrzA1Ub1mzChDpP9Fp1Eip5sEZP+Idh4VoRVR9nAj+u7hFQZiPYXnpnVef
         xVAXUiAPW7J4M1oAB48tQTVbacrAtcp8MGx2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rP7eurICyIZQBfcjqQ2vzisdGfNYym2lsKWx2Zea9ds=;
        b=NpLDUxdtzLlaMBMblrNKuCs9iVweVJEpPuMhzQ7JCLGXX/F0F5s0JLoCYpMtScaME4
         WIJPhbdgjUmn1bMn8W2sJWIQA4UEnVZlGabp/k1UTlT8Y0f384ysCpYkd3nNw2WFTT2e
         wrpMpKwvKdA4etV4KC4/jvHNR6SMhbDquuOiLupeJySQQVmombooOPa2ecMce32fRFWN
         ktBzzHPO5qZ+na77O6wmniMzBcBpQ+C/8OwWYbrfvfYegi2W4d1gsghMnVo5QlOkVR+7
         voqKdcpyJE4K6/Jdh3Y5vNz7/8kfQGzU/pNLuQ3w6fscGSLNDOiqqM/DPRGseJHqVckp
         NYog==
X-Gm-Message-State: APt69E2HSaDoyEljYDm6AUXuOkcMhZH0K1tI1cTgFAF/6YoOWatg0p0R
        VUVkP8FR6WKkS7EYzwMyGLcFFMmhWo8=
X-Google-Smtp-Source: ADUXVKJyv09NMNy+evR1Vrd42SJSDtxrU5WPye6lptoX8QzwZyQdlxlcv7lQR0dWYvZKTkkqCzuJ0A==
X-Received: by 2002:a63:686:: with SMTP id 128-v6mr9634689pgg.338.1530210120858;
        Thu, 28 Jun 2018 11:22:00 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id q10-v6sm13686027pfj.7.2018.06.28.11.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:22:00 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use SRCU
Date:   Thu, 28 Jun 2018 11:21:46 -0700
Message-Id: <20180628182149.226164-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180628182149.226164-1-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In recent tests with IRQ on/off tracepoints, a large performance
overhead ~10% is noticed when running hackbench. This is root caused to
calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
tracepoint code. Following a long discussion on the list [1] about this,
we concluded that srcu is a better alternative for use during rcu idle.
Although it does involve extra barriers, its lighter than the sched-rcu
version which has to do additional RCU calls to notify RCU idle about
entry into RCU sections.

In this patch, we change the underlying implementation of the
trace_*_rcuidle API to use SRCU. This has shown to improve performance
alot for the high frequency irq enable/disable tracepoints.

Test: Tested idle and preempt/irq tracepoints.

Here are some performance numbers:

With a run of the following 30 times on a single core x86 Qemu instance
with 1GB memory:
hackbench -g 4 -f 2 -l 3000

Completion times in seconds. CONFIG_PROVE_LOCKING=y.

No patches (without this series)
Mean: 3.048
Median: 3.025
Std Dev: 0.064

With Lockdep using irq tracepoints with RCU implementation:
Mean: 3.451   (-11.66 %)
Median: 3.447 (-12.22%)
Std Dev: 0.049

With Lockdep using irq tracepoints with SRCU implementation (this series):
Mean: 3.020   (I would consider the improvement against the "without
	       this series" case as just noise).
Median: 3.013
Std Dev: 0.033

[1] https://patchwork.kernel.org/patch/10344297/

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/tracepoint.h | 49 +++++++++++++++++++++++++++++++-------
 kernel/tracepoint.c        | 16 ++++++++++++-
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 19a690b559ca..beeb01e147f8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -15,6 +15,7 @@
  */
 
 #include <linux/smp.h>
+#include <linux/srcu.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -33,6 +34,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -75,10 +78,16 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
  * probe unregistration and the end of module exit to make sure there is no
  * caller executing a probe when it is freed.
  */
+#ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_srcu(&tracepoint_srcu);
 	synchronize_sched();
 }
+#else
+static inline void tracepoint_synchronize_unregister(void)
+{ }
+#endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 extern int syscall_regfunc(void);
@@ -129,18 +138,38 @@ extern void syscall_unregfunc(void);
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
+#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
+		int __maybe_unused idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
-		if (rcucheck)						\
-			rcu_irq_enter_irqson();				\
-		rcu_read_lock_sched_notrace();				\
-		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
+									\
+		/*							\
+		 * For rcuidle callers, use srcu since sched-rcu	\
+		 * doesn't work from the idle path.			\
+		 */							\
+		if (rcuidle) {						\
+			if (in_nmi()) {					\
+				WARN_ON_ONCE(1);			\
+				return; /* no srcu from nmi */		\
+			}						\
+									\
+			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
+			it_func_ptr =					\
+				srcu_dereference_notrace((tp)->funcs,	\
+						&tracepoint_srcu);	\
+			/* To keep it consistent with !rcuidle path */	\
+			preempt_disable_notrace();			\
+		} else {						\
+			rcu_read_lock_sched_notrace();			\
+			it_func_ptr =					\
+				rcu_dereference_sched((tp)->funcs);	\
+		}							\
+									\
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = (it_func_ptr)->func;		\
@@ -148,9 +177,13 @@ extern void syscall_unregfunc(void);
 				((void(*)(proto))(it_func))(args);	\
 			} while ((++it_func_ptr)->func);		\
 		}							\
-		rcu_read_unlock_sched_notrace();			\
-		if (rcucheck)						\
-			rcu_irq_exit_irqson();				\
+									\
+		if (rcuidle) {						\
+			preempt_enable_notrace();			\
+			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
+		} else {						\
+			rcu_read_unlock_sched_notrace();		\
+		}							\
 	} while (0)
 
 #ifndef MODULE
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 6dc6356c3327..955148d91b74 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -31,6 +31,9 @@
 extern struct tracepoint * const __start___tracepoints_ptrs[];
 extern struct tracepoint * const __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
 
@@ -67,16 +70,27 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
+		/*
+		 * Tracepoint probes are protected by both sched RCU and SRCU,
+		 * by calling the SRCU callback in the sched RCU callback we
+		 * cover both cases. So let us chain the SRCU and sched RCU
+		 * callbacks to wait for both grace periods.
+		 */
 		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
 	}
 }
-- 
2.18.0.rc2.346.g013aa6912e-goog

