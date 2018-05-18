Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeERHuS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:50:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45648 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeERHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:50:13 -0400
X-Google-Smtp-Source: AB8JxZq9dqvbBDLomlU366NHViMs3S+rQvtHhi5CStY02e08nJm9T3y6msyrRZwzf+j5Cm3rDeUdmw==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 07/10] bcache: optimize continue_at_nobarrier()
Date: Fri, 18 May 2018 03:49:11 -0400
Message-Id: <20180518074918.13816-14-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/bcache/closure.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index 3b9dfc9962..2392a46bcd 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -244,7 +244,7 @@ static inline void closure_queue(struct closure *cl)
 		     != offsetof(struct work_struct, func));
 	if (wq) {
 		INIT_WORK(&cl->work, cl->work.func);
-		BUG_ON(!queue_work(wq, &cl->work));
+		queue_work(wq, &cl->work);
 	} else
 		cl->fn(cl);
 }
@@ -337,8 +337,13 @@ do {									\
  */
 #define continue_at_nobarrier(_cl, _fn, _wq)				\
 do {									\
-	set_closure_fn(_cl, _fn, _wq);					\
-	closure_queue(_cl);						\
+	closure_set_ip(_cl);						\
+	if (_wq) {							\
+		INIT_WORK(&(_cl)->work, (void *) _fn);			\
+		queue_work((_wq), &(_cl)->work);			\
+	} else {							\
+		(_fn)(_cl);						\
+	}								\
 } while (0)
 
 /**
-- 
2.17.0
