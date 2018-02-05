Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBEXTe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:19:34 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36739 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752058AbeBEXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:19:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SxlA7uj_1517872711;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: tglx@linutronix.de, longman@redhat.com
Cc: yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4 v6] lib: debugobjects: use global free list in free_object()
Date: Tue,  6 Feb 2018 07:18:27 +0800
Message-Id: <1517872708-24207-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pool list is already full, just put the free objects on the
global free list, then schedule a work to move them to pool list or free
the memory later.

If the pool list is not full, just put the objects back to the pool
list.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index c15fb5f..09f2469 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -266,27 +266,34 @@ static void free_obj_work(struct work_struct *work)
 	}
 }
 
-/*
- * Put the object back into the pool and schedule work to free objects
- * if necessary.
- */
-static void free_object(struct debug_obj *obj)
+static bool __free_object(struct debug_obj *obj)
 {
 	unsigned long flags;
-	int sched = 0;
+	bool work;
 
 	raw_spin_lock_irqsave(&pool_lock, flags);
-	/*
-	 * schedule work when the pool is filled and the cache is
-	 * initialized:
-	 */
-	if (obj_pool_free > debug_objects_pool_size && obj_cache)
-		sched = 1;
-	hlist_add_head(&obj->node, &obj_pool);
-	obj_pool_free++;
+	work = (obj_pool_free > debug_objects_pool_size) && obj_cache ?
+		true : false;
 	obj_pool_used--;
+
+	if (work) {
+		obj_nr_tofree++;
+		hlist_add_head(&obj->node, &obj_to_free);
+	} else {
+		obj_pool_free++;
+		hlist_add_head(&obj->node, &obj_pool);
+	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-	if (sched)
+	return work;
+}
+
+/*
+ * Put the object back into the pool and schedule work to free objects
+ * if necessary.
+ */
+static void free_object(struct debug_obj *obj)
+{
+	if (__free_object(obj))
 		schedule_work(&debug_obj_work);
 }
 
-- 
1.8.3.1
