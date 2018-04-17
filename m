Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDQEIS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:08:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33727 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeDQEIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:08:13 -0400
X-Google-Smtp-Source: AIpwx4+5YTeDK24ziZvmYfgAPdyE6Xnp2BrgE1PL1wwNCIkY1JDaVa+w0RaUBems4R+RAr8AIRYv+Q==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>
Subject: [RFC v4 2/4] softirq: reorder trace_softirqs_on to prevent lockdep splat
Date: Mon, 16 Apr 2018 21:07:46 -0700
Message-Id: <20180417040748.212236-3-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180417040748.212236-1-joelaf@google.com>
References: <20180417040748.212236-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there's an issue which is not always reproducible, where the
softirqs annotation in lockdep goes out of sync with the reality of the
world and causes a lockdep splat. This is because the preemptoff tracer
calls into lockdep which can cause a softirqs invalid annotation splat.

The same issue was fixed in local_bh_disable_ip.
/*
 * The preempt tracer hooks into preempt_count_add and will break
 * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
 * is set and before current->softirq_enabled is cleared.
 * We must manually increment preempt_count here and manually
 * call the trace_preempt_off later.
 */

I am not fully sure why the issue is reproducible with my patches easily,
but it seems like the same ordering issue can exist so we ought to fix
it.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Fenguang Wu <fengguang.wu@intel.com>
Cc: Baohong Liu <baohong.liu@intel.com>
Cc: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/softirq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 177de3640c78..8a040bcaa033 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
 
+	if (preempt_count() == cnt)
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_on(_RET_IP_);
-	preempt_count_sub(cnt);
+
+	__preempt_count_sub(cnt);
 }
 
 /*
-- 
2.17.0.484.g0c8726318c-goog
