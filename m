Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755415AbeE1NvV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:51:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53501 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755266AbeE1Nth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:37 -0400
X-Google-Smtp-Source: ADUXVKKmzgi+cWmaNiwfwaZZxxltkNx7kisN0ddu9T5KPUj0wUowjbcMa0NmPFurbc6Fgy3sn/rXxQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 4/8] signal: add copy_pending() helper
Date: Mon, 28 May 2018 15:49:12 +0200
Message-Id: <20180528134916.7568-5-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528134916.7568-1-christian@brauner.io>
References: <20180528134916.7568-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a goto for this let's add a simple helper copy_pending()
which can be called in both places.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/signal.c | 54 +++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 6c2e7b45cba1..821b54e3328b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -515,6 +515,19 @@ int unhandled_signal(struct task_struct *tsk, int sig)
 	return !tsk->ptrace;
 }
 
+static void copy_pending(siginfo_t *info, struct sigqueue *first,
+			 bool *resched_timer)
+{
+	list_del_init(&first->list);
+	copy_siginfo(info, &first->info);
+
+	*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
+			 (info->si_code == SI_TIMER) &&
+			 (info->si_sys_private);
+
+	__sigqueue_free(first);
+}
+
 static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
 			   bool *resched_timer)
 {
@@ -526,8 +539,10 @@ static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
 	*/
 	list_for_each_entry(q, &list->list, list) {
 		if (q->info.si_signo == sig) {
-			if (first)
-				goto still_pending;
+			if (first) {
+				copy_pending(info, first, resched_timer);
+				return;
+			}
 			first = q;
 		}
 	}
@@ -535,29 +550,20 @@ static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
 	sigdelset(&list->signal, sig);
 
 	if (first) {
-still_pending:
-		list_del_init(&first->list);
-		copy_siginfo(info, &first->info);
-
-		*resched_timer =
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code == SI_TIMER) &&
-			(info->si_sys_private);
-
-		__sigqueue_free(first);
-	} else {
-		/*
-		 * Ok, it wasn't in the queue.  This must be
-		 * a fast-pathed signal or we must have been
-		 * out of queue space.  So zero out the info.
-		 */
-		clear_siginfo(info);
-		info->si_signo = sig;
-		info->si_errno = 0;
-		info->si_code = SI_USER;
-		info->si_pid = 0;
-		info->si_uid = 0;
+		copy_pending(info, first, resched_timer);
+		return;
 	}
+
+	/*
+	 * Ok, it wasn't in the queue. This must be a fast-pathed signal or we
+	 * must have been out of queue space. So zero out the info.
+	 */
+	clear_siginfo(info);
+	info->si_signo = sig;
+	info->si_errno = 0;
+	info->si_code = SI_USER;
+	info->si_pid = 0;
+	info->si_uid = 0;
 }
 
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-- 
2.17.0
