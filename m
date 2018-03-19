Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031645AbeCSTQU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:16:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935660AbeCSTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:16:13 -0400
From: Matthew Wilcox <willy@infradead.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH] autofs4: Use wait_event_killable
Date: Mon, 19 Mar 2018 12:16:09 -0700
Message-Id: <20180319191609.23880-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

This playing with signals to allow only fatal signals appears to predate
the introduction of wait_event_killable(), and I'm fairly sure that
wait_event_killable is what was meant to happen here.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/autofs4/waitq.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index a0c57c37fa21..c160e9b3aa0f 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -19,9 +19,6 @@
  */
 static autofs_wqt_t autofs4_next_wait_queue = 1;
 
-/* These are the signals we allow interrupting a pending mount */
-#define SHUTDOWN_SIGS	(sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT))
-
 void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
 {
 	struct autofs_wait_queue *wq, *nwq;
@@ -486,29 +483,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 	 * wq->name.name is NULL iff the lock is already released
 	 * or the mount has been made catatonic.
 	 */
-	if (wq->name.name) {
-		/* Block all but "shutdown" signals while waiting */
-		unsigned long shutdown_sigs_mask;
-		unsigned long irqflags;
-		sigset_t oldset;
-
-		spin_lock_irqsave(&current->sighand->siglock, irqflags);
-		oldset = current->blocked;
-		shutdown_sigs_mask = SHUTDOWN_SIGS & ~oldset.sig[0];
-		siginitsetinv(&current->blocked, shutdown_sigs_mask);
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
-
-		wait_event_interruptible(wq->queue, wq->name.name == NULL);
-
-		spin_lock_irqsave(&current->sighand->siglock, irqflags);
-		current->blocked = oldset;
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
-	} else {
-		pr_debug("skipped sleeping\n");
-	}
-
+	wait_event_killable(wq->queue, wq->name.name == NULL);
 	status = wq->status;
 
 	/*
-- 
2.16.2
