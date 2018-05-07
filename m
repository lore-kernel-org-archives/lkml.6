Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeEGUm6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:42:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37132 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeEGUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:42:01 -0400
X-Google-Smtp-Source: AB8JxZp00+qzO8Jzo++fIQLOWtnFnOUcieshBXOC96bJLFQGUNpSFgotbwefMfOUxau5KvKpfOTKdw==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: [PATCH RFC v6 3/5] trace/irqsoff: Split reset into separate functions
Date: Mon,  7 May 2018 13:41:41 -0700
Message-Id: <20180507204143.13061-4-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180507204143.13061-1-joelaf@google.com>
References: <20180507204143.13061-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Split reset functions into seperate functions in preparation
of future patches that need to do tracer specific reset.

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
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace_irqsoff.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 03ecb4465ee4..f8daa754cce2 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -634,7 +634,7 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	return 0;
 }
 
-static void irqsoff_tracer_reset(struct trace_array *tr)
+static void __irqsoff_tracer_reset(struct trace_array *tr)
 {
 	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
 	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
@@ -665,6 +665,12 @@ static int irqsoff_tracer_init(struct trace_array *tr)
 
 	return __irqsoff_tracer_init(tr);
 }
+
+static void irqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer irqsoff_tracer __read_mostly =
 {
 	.name		= "irqsoff",
@@ -697,11 +703,16 @@ static int preemptoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptoff_tracer __read_mostly =
 {
 	.name		= "preemptoff",
 	.init		= preemptoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
@@ -731,11 +742,16 @@ static int preemptirqsoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptirqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptirqsoff_tracer __read_mostly =
 {
 	.name		= "preemptirqsoff",
 	.init		= preemptirqsoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptirqsoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
-- 
2.17.0.441.gb46fe60e1d-goog
