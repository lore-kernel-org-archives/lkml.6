Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeDQEIz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:08:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36471 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeDQEIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:08:14 -0400
X-Google-Smtp-Source: AIpwx48Ew8FiWr0Kel7cwPj1si3GZeBNeThoYv2EDY/iN41BP/m/0L4T5BaWrUVRBTmnRp6+CKE1Iw==
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
Subject: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
Date: Mon, 16 Apr 2018 21:07:47 -0700
Message-Id: <20180417040748.212236-4-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180417040748.212236-1-joelaf@google.com>
References: <20180417040748.212236-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With TRACE_IRQFLAGS, we call trace_ API too many times. We don't need
to if local_irq_restore or local_irq_save didn't actually do anything.

This gives around a 4% improvement in performance when doing the
following command: "time find / > /dev/null"

Also its best to avoid these calls where possible, since in this series,
the RCU code in tracepoint.h seems to be call these quite a bit and I'd
like to keep this overhead low.

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
 include/linux/irqflags.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 9700f00bbc04..ea8df0ac57d3 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -104,19 +104,20 @@ do {						\
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		if (!raw_irqs_disabled_flags(flags))	\
+			trace_hardirqs_off();		\
 	} while (0)
 
 
-#define local_irq_restore(flags)			\
-	do {						\
-		if (raw_irqs_disabled_flags(flags)) {	\
-			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
-		} else {				\
-			trace_hardirqs_on();		\
-			raw_local_irq_restore(flags);	\
-		}					\
+#define local_irq_restore(flags)						\
+	do {									\
+		if (raw_irqs_disabled_flags(flags) && !irqs_disabled()) {	\
+			raw_local_irq_restore(flags);				\
+			trace_hardirqs_off();					\
+		} else if (!raw_irqs_disabled_flags(flags) && irqs_disabled()) {\
+			trace_hardirqs_on();					\
+			raw_local_irq_restore(flags);				\
+		}								\
 	} while (0)
 
 #define safe_halt()				\
-- 
2.17.0.484.g0c8726318c-goog
