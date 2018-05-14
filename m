Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeENDQE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:16:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44131 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeENDQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:16:01 -0400
X-Google-Smtp-Source: AB8JxZojvrRE0g9tHGhV4eenU/bSCs6XfI8S6P7kyAtoJqhlz8i7SNFIZWG8LPZL4P1nXr4plD5u5A==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 2/8] rcu: Clarify usage of cond_resched for tasks-RCU
Date: Sun, 13 May 2018 20:15:35 -0700
Message-Id: <20180514031541.67247-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514031541.67247-1-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we had a discussion about cond_resched unconditionally
recording a voluntary context switch [1].

Lets add a comment clarifying that how this API is to be used.

[1] https://lkml.kernel.org/r/1526027434-21237-1-git-send-email-byungchul.park@lge.com

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 743226176350..a9881007ece6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -159,8 +159,12 @@ static inline void rcu_init_nohz(void) { }
 	} while (0)
 
 /*
- * Note a voluntary context switch for RCU-tasks benefit.  This is a
- * macro rather than an inline function to avoid #include hell.
+ * Note an attempt to perform a voluntary context switch for RCU-tasks benefit.
+ *
+ * This is called even in situations where a context switch didn't really
+ * happen even though it was requested. The caller uses it to indicate
+ * traversal of an RCU-tasks quiescent state. This is a macro rather than an
+ * inline function to avoid #include hell.
  */
 #ifdef CONFIG_TASKS_RCU
 #define rcu_note_voluntary_context_switch_lite(t) \
@@ -187,7 +191,8 @@ static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 /**
- * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
+ * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU.
+ * The quiescent state report is made even if cond_resched() did nothing.
  *
  * This macro resembles cond_resched(), except that it is defined to
  * report potential quiescent states to RCU-tasks even if the cond_resched()
-- 
2.17.0.441.gb46fe60e1d-goog
