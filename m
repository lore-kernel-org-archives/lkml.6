Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeEGUmB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:42:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34991 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeEGUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:41:59 -0400
X-Google-Smtp-Source: AB8JxZoXGvChZiqxwicG01BlWjCJQMsb1Wt+ZFktsI4dystSxircmlnGemHPqfkarXsmzlBPY8lNNA==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH RFC v6 1/5] srcu: Add notrace variants of srcu_read_{lock,unlock}
Date: Mon,  7 May 2018 13:41:39 -0700
Message-Id: <20180507204143.13061-2-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180507204143.13061-1-joelaf@google.com>
References: <20180507204143.13061-1-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul McKenney <paulmck@linux.vnet.ibm.com>

This is needed for a future tracepoint patch that uses srcu, and to make
sure it doesn't call into lockdep.

tracepoint code already calls notrace variants for rcu_read_lock_sched
so this patch does the same for srcu which will be used in a later
patch. Keeps it consistent with rcu-sched.

[Joel: Added commit message]

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
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 33c1c698df09..2ec618979b20 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -161,6 +161,16 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 	return retval;
 }
 
+/* Used by tracing, cannot be traced and cannot invoke lockdep. */
+static inline notrace int
+srcu_read_lock_notrace(struct srcu_struct *sp) __acquires(sp)
+{
+	int retval;
+
+	retval = __srcu_read_lock(sp);
+	return retval;
+}
+
 /**
  * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
  * @sp: srcu_struct in which to unregister the old reader.
@@ -175,6 +185,13 @@ static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
 	__srcu_read_unlock(sp, idx);
 }
 
+/* Used by tracing, cannot be traced and cannot call lockdep. */
+static inline notrace void
+srcu_read_unlock_notrace(struct srcu_struct *sp, int idx) __releases(sp)
+{
+	__srcu_read_unlock(sp, idx);
+}
+
 /**
  * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
  *
-- 
2.17.0.441.gb46fe60e1d-goog
