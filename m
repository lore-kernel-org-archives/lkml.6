Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeCaMxf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 08:53:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeCaMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 08:53:34 -0400
Date: Sat, 31 Mar 2018 05:53:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] ida: Remove simple_ida_lock
Message-ID: <20180331125332.GF13332@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Improve the scalability of the IDA by using the per-IDA xa_lock rather
than the global simple_ida_lock.  IDAs are not typically used in
performance-sensitive locations, but since we have this lock anyway,
we can use it.  It is also a step towards converting the IDA from the
radix tree to the XArray.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 lib/idr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index b2f7ab31ce55..e80da084117c 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -7,7 +7,6 @@
 #include <linux/xarray.h>
 
 DEFINE_PER_CPU(struct ida_bitmap *, ida_bitmap);
-static DEFINE_SPINLOCK(simple_ida_lock);
 
 /**
  * idr_alloc_u32() - Allocate an ID.
@@ -572,7 +571,7 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 	if (!ida_pre_get(ida, gfp_mask))
 		return -ENOMEM;
 
-	spin_lock_irqsave(&simple_ida_lock, flags);
+	xa_lock_irqsave(&ida->ida_rt, flags);
 	ret = ida_get_new_above(ida, start, &id);
 	if (!ret) {
 		if (id > max) {
@@ -582,7 +581,7 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 			ret = id;
 		}
 	}
-	spin_unlock_irqrestore(&simple_ida_lock, flags);
+	xa_unlock_irqrestore(&ida->ida_rt, flags);
 
 	if (unlikely(ret == -EAGAIN))
 		goto again;
@@ -606,8 +605,8 @@ void ida_simple_remove(struct ida *ida, unsigned int id)
 	unsigned long flags;
 
 	BUG_ON((int)id < 0);
-	spin_lock_irqsave(&simple_ida_lock, flags);
+	xa_lock_irqsave(&ida->ida_rt, flags);
 	ida_remove(ida, id);
-	spin_unlock_irqrestore(&simple_ida_lock, flags);
+	xa_unlock_irqrestore(&ida->ida_rt, flags);
 }
 EXPORT_SYMBOL(ida_simple_remove);
-- 
2.16.2
