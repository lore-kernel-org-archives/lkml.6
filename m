Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFAN0Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:26:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47019 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeFANWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:22:50 -0400
X-Google-Smtp-Source: ADUXVKI6qz3wNwVjoDPOZ9hI5inVa4T99W/ZDlRsQ6uOklpNzy84NSZgpgLQP88B8U2y3iWSTyg5ZQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 03/17] signal: make may_ptrace_stop() return bool
Date: Fri,  1 Jun 2018 15:22:25 +0200
Message-Id: <20180601132239.4421-4-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

may_ptrace_stop() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* unchanged
---
 kernel/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 6c71d6b8d2b8..bc750fb4ddcc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1889,10 +1889,10 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
-static inline int may_ptrace_stop(void)
+static inline bool may_ptrace_stop(void)
 {
 	if (!likely(current->ptrace))
-		return 0;
+		return false;
 	/*
 	 * Are we in the middle of do_coredump?
 	 * If so and our tracer is also part of the coredump stopping
@@ -1906,11 +1906,11 @@ static inline int may_ptrace_stop(void)
 	 * block in TASK_TRACED. But PTRACE_EVENT_EXIT can be reported
 	 * after SIGKILL was already dequeued.
 	 */
-	if (unlikely(current->mm->core_state) &&
-	    unlikely(current->mm == current->parent->mm))
-		return 0;
+	if (likely(!current->mm->core_state ||
+		   current->mm != current->parent->mm))
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
-- 
2.17.0
