Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755613AbeEABmY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 21:42:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33331 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbeEABmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 21:42:22 -0400
X-Google-Smtp-Source: AB8JxZpzBw26tEHsOGZ3nXzBDKQpGRSjIUHBbSTgVCPY7SPi9+JCTQl8ArO8vAvrx3S5yVuG5pwm4Q==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
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
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: [PATCH RFC v5 1/6] softirq: reorder trace_softirqs_on to prevent lockdep splat
Date: Mon, 30 Apr 2018 18:41:59 -0700
Message-Id: <20180501014204.67548-2-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501014204.67548-1-joelaf@google.com>
References: <20180501014204.67548-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm able to reproduce a lockdep splat when CONFIG_PROVE_LOCKING=y and
CONFIG_PREEMPTIRQ_EVENTS=y.

$ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable

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
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/softirq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 24d243ef8e71..47e2f61938c0 100644
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
2.17.0.441.gb46fe60e1d-goog
