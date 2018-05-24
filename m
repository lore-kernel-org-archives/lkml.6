Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935475AbeEXBWt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:22:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36842 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbeEXBWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:22:33 -0400
X-Google-Smtp-Source: AB8JxZrnE/F+S6kaEyQOZh/p/zDvdl9cCbNZbLktijstAEps/fT5m0Onr4X6gvIL/kGOz6nqytBLPg==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>, Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v7 4/8] trace/irqsoff: Split reset into separate functions
Date: Wed, 23 May 2018 18:21:53 -0700
Message-Id: <20180524012157.181277-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180524012157.181277-1-joel@joelfernandes.org>
References: <20180524012157.181277-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Split reset functions into seperate functions in preparation
of future patches that need to do tracer specific reset.

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
