Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90715C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8EE27444
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJG/ALOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8EE27444
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966131AbeF1N1K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:27:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbeF1N1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=91NAsJd7DaoqlWs9LgdsT2gfbs0mOntScXL4SoPGGFY=; b=CJG/ALOg3mbk9m8GDF83wB948
        +7sluGxBowxDzzClhdnIM/Uqtn4m6c3XBSwtNMEJGcYXKxQfiNPraBIl37qva1FA3pcsKVIore21n
        D6X1WCGLSqP9UsNHKAEjicfsgGq6H1gI61aO+UD8GwnjcQwMfEP39QMQ/faP8pCV9HX2DZrDyR0eb
        fIX7BgbaRcGanN2N/6ez3EQHf2zSkiZ5zh7v5GNBxncBY2tngy8f9qSQ42WMUoGXcFDYTmnaeYyEW
        bBne/j6Vg4nRwZ262CuJpIK+WpoxA3oPzrMyinuR3QP7DJ/dQr+pEzzRk/9p2PIAHP1E7Y8+DpZ+3
        uCv+XNzIg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYWwt-0000s7-Vv; Thu, 28 Jun 2018 13:26:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 6/6] 9p: Remove p9_idpool
Date:   Thu, 28 Jun 2018 06:26:29 -0700
Message-Id: <20180628132629.3148-7-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628132629.3148-1-willy@infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users left of the p9_idpool; delete it.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/net/9p/9p.h |   8 ---
 net/9p/Makefile     |   1 -
 net/9p/util.c       | 141 --------------------------------------------
 3 files changed, 150 deletions(-)
 delete mode 100644 net/9p/util.c

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index b8eb51a661e5..e23896116d9a 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -561,16 +561,8 @@ struct p9_fcall {
 	u8 *sdata;
 };
 
-struct p9_idpool;
-
 int p9_errstr2errno(char *errstr, int len);
 
-struct p9_idpool *p9_idpool_create(void);
-void p9_idpool_destroy(struct p9_idpool *);
-int p9_idpool_get(struct p9_idpool *p);
-void p9_idpool_put(int id, struct p9_idpool *p);
-int p9_idpool_check(int id, struct p9_idpool *p);
-
 int p9_error_init(void);
 int p9_trans_fd_init(void);
 void p9_trans_fd_exit(void);
diff --git a/net/9p/Makefile b/net/9p/Makefile
index c0486cfc85d9..aa0a5641e5d0 100644
--- a/net/9p/Makefile
+++ b/net/9p/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_NET_9P_RDMA) += 9pnet_rdma.o
 	mod.o \
 	client.o \
 	error.o \
-	util.o \
 	protocol.o \
 	trans_fd.o \
 	trans_common.o \
diff --git a/net/9p/util.c b/net/9p/util.c
deleted file mode 100644
index 59f278e64f58..000000000000
--- a/net/9p/util.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- *  net/9p/util.c
- *
- *  This file contains some helper functions
- *
- *  Copyright (C) 2007 by Latchesar Ionkov <lucho@ionkov.net>
- *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
- *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to:
- *  Free Software Foundation
- *  51 Franklin Street, Fifth Floor
- *  Boston, MA  02111-1301  USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/sched.h>
-#include <linux/parser.h>
-#include <linux/idr.h>
-#include <linux/slab.h>
-#include <net/9p/9p.h>
-
-/**
- * struct p9_idpool - per-connection accounting for tag idpool
- * @lock: protects the pool
- * @pool: idr to allocate tag id from
- *
- */
-
-struct p9_idpool {
-	spinlock_t lock;
-	struct idr pool;
-};
-
-/**
- * p9_idpool_create - create a new per-connection id pool
- *
- */
-
-struct p9_idpool *p9_idpool_create(void)
-{
-	struct p9_idpool *p;
-
-	p = kmalloc(sizeof(struct p9_idpool), GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
-	spin_lock_init(&p->lock);
-	idr_init(&p->pool);
-
-	return p;
-}
-EXPORT_SYMBOL(p9_idpool_create);
-
-/**
- * p9_idpool_destroy - create a new per-connection id pool
- * @p: idpool to destroy
- */
-
-void p9_idpool_destroy(struct p9_idpool *p)
-{
-	idr_destroy(&p->pool);
-	kfree(p);
-}
-EXPORT_SYMBOL(p9_idpool_destroy);
-
-/**
- * p9_idpool_get - allocate numeric id from pool
- * @p: pool to allocate from
- *
- * Bugs: This seems to be an awful generic function, should it be in idr.c with
- *            the lock included in struct idr?
- */
-
-int p9_idpool_get(struct p9_idpool *p)
-{
-	int i;
-	unsigned long flags;
-
-	idr_preload(GFP_NOFS);
-	spin_lock_irqsave(&p->lock, flags);
-
-	/* no need to store exactly p, we just need something non-null */
-	i = idr_alloc(&p->pool, p, 0, 0, GFP_NOWAIT);
-
-	spin_unlock_irqrestore(&p->lock, flags);
-	idr_preload_end();
-	if (i < 0)
-		return -1;
-
-	p9_debug(P9_DEBUG_MUX, " id %d pool %p\n", i, p);
-	return i;
-}
-EXPORT_SYMBOL(p9_idpool_get);
-
-/**
- * p9_idpool_put - release numeric id from pool
- * @id: numeric id which is being released
- * @p: pool to release id into
- *
- * Bugs: This seems to be an awful generic function, should it be in idr.c with
- *            the lock included in struct idr?
- */
-
-void p9_idpool_put(int id, struct p9_idpool *p)
-{
-	unsigned long flags;
-
-	p9_debug(P9_DEBUG_MUX, " id %d pool %p\n", id, p);
-
-	spin_lock_irqsave(&p->lock, flags);
-	idr_remove(&p->pool, id);
-	spin_unlock_irqrestore(&p->lock, flags);
-}
-EXPORT_SYMBOL(p9_idpool_put);
-
-/**
- * p9_idpool_check - check if the specified id is available
- * @id: id to check
- * @p: pool to check
- */
-
-int p9_idpool_check(int id, struct p9_idpool *p)
-{
-	return idr_find(&p->pool, id) != NULL;
-}
-EXPORT_SYMBOL(p9_idpool_check);
-
-- 
2.18.0

