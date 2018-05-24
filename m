Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935448AbeEXBWi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:22:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42478 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935388AbeEXBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:22:30 -0400
X-Google-Smtp-Source: AB8JxZowrWs+ZQuqKjJojfYqLXUe/Aka0UdPGSAVoYqYQnFASP1tv2oENUM1aBG+BYryxDer0HBm5w==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>, Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v7 2/8] srcu: Add notrace variants of srcu_read_{lock,unlock}
Date: Wed, 23 May 2018 18:21:51 -0700
Message-Id: <20180524012157.181277-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180524012157.181277-1-joel@joelfernandes.org>
References: <20180524012157.181277-1-joel@joelfernandes.org>
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
