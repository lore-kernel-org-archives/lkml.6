Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB605C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AEF224E6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o9HgF8Hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AEF224E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934014AbeFUWd7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:33:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45460 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933884AbeFUWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:33:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id a22-v6so2198190pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rP7eurICyIZQBfcjqQ2vzisdGfNYym2lsKWx2Zea9ds=;
        b=o9HgF8Hym68XgLXIXsHpDX8peXEgQ9LdAjZpL+RJXH/XJX0zKEAlW49mLNspjT4bI6
         wCAy0LNhsFj0Fngu0wG4GZI6kno9APaIyp6+HVfLOT5284PJhMTRRPWbp6LKGii+EgRR
         51Lx6T622b72UD4/xc3KXKgGiW323g8is5+kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rP7eurICyIZQBfcjqQ2vzisdGfNYym2lsKWx2Zea9ds=;
        b=LAMic21fdMXFYYf1fZtzDAHRFj/vmx6PRFQ2ijRSbermNDC3ROABRDr8CdMW+wZPAr
         eI3Nt02DP7epXZLRSzbKpp+S0IZcVGyot8S6XiPDq0Yszfp2wv6D/6s94kt6jUi2QYKR
         CrMVEV12WO67v5mvd4LHba3hoB2IEjgAaC48vYWquDa2UC+9EL4xrJj1N9Vt7hrQPX8x
         aX6wNAslNuy8+HPny1qxYvqIOqJSw5WNgMgPd9qemu9XeQmnZKQp974eu+JICPvgVwzJ
         LpWziHKxdmSvk1zOnNYvzIB/FCLUlHaWh/s+eypA7D/bUfmLRzfmLAYFD5NTqVC0t6BW
         TXgA==
X-Gm-Message-State: APt69E3TR4w1kIxLW0KSGPSPFXlsCpyhX8W9jBYRQSIRSdkUHGHD7BAc
        EhuAtnfUj4A+BBaVaEW6GQfCpgoOvqw=
X-Google-Smtp-Source: ADUXVKJFk24i14OBUp3U6rzpepE8F/HfzfI4cCu66IzDJ+lxVT9JMH2pH+a+avLrW0/dG5ev+wxj/Q==
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr29409110pff.199.1529620409743;
        Thu, 21 Jun 2018 15:33:29 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x19-v6sm11060824pfi.5.2018.06.21.15.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:33:29 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use SRCU
Date:   Thu, 21 Jun 2018 15:32:33 -0700
Message-Id: <20180621223236.211495-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621223236.211495-1-joel@joelfernandes.org>
References: <20180621223236.211495-1-joel@joelfernandes.org>
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

