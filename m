Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeCaC2s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 22:28:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33832 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeCaC2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 22:28:47 -0400
X-Google-Smtp-Source: AIpwx49YVSVS3T8OR/qjWFptnaljOA4BLmrEUNKSJR4R5R4+36h5DLQhnmsqj2T3bZRrn8G+ImJzuQ==
From: Andrei Vagin <avagin@openvz.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] autofs4: use wake_up() instead of wake_up_interruptible
Date: Fri, 30 Mar 2018 19:28:39 -0700
Message-Id: <20180331022839.21277-1-avagin@openvz.org>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "autofs4: use wait_event_killable",  wait_event_interruptible() was
replaced by wait_event_killable(), but in this case we have to use
wake_up() instead of wake_up_interruptible().

Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
---
 fs/autofs4/waitq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index c160e9b3aa0f..be9c3dc048ab 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -549,7 +549,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
 	kfree(wq->name.name);
 	wq->name.name = NULL;	/* Do not wait on this queue */
 	wq->status = status;
-	wake_up_interruptible(&wq->queue);
+	wake_up(&wq->queue);
 	if (!--wq->wait_ctr)
 		kfree(wq);
 	mutex_unlock(&sbi->wq_mutex);
-- 
2.13.6
