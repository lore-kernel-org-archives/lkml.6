Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1974C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C090E222C6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsKPvlBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfBLR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:57:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41861 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfBLR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:57:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id k15so1651436pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDU7hPspNg25hPl2OvBKS7YvtxIGkNRnjLg+s4xyhDM=;
        b=ZsKPvlBSND/BBli5ocsBaMaB7S8odXyIT8DmJfUMHKbU8LQFv8ZJBe6VkCGW6UXfxg
         5qYud7MxGIilXgI8DJUK9T6Oe6cONgQuIS3uwg+cl8HAjPSL5Il/zuHcV0SIkC927B1F
         EYlJdurDGZjozSxpH5mR5GIJwSwAyxU4Kc3pQTRycew3NMPW/pfNEm3Va1/jzTICbNm+
         ToWjMq8dtVE8BV84AjpIFM2XR9De2VX/FTdBKqO7NPLnb7313azhRYP9OFQWEgljFljU
         YIGeGSOY2Sqs+QsslDvU6Sdw+WQUw2wWFSaZKaVpfLTPlADbmPMQlFn4SnDiyoPCQpkP
         iCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDU7hPspNg25hPl2OvBKS7YvtxIGkNRnjLg+s4xyhDM=;
        b=JH/dbVI0TiX/rTaj9qSrsJUjZvdgC/mXrbeC9aKUyY9G5U2sk/pLD1KEzLAJHViqf+
         x9RBOm2scB7dG4HLaXNglgoC0Jvp6+5AYaDFALhfBoTHir2flRaZ7aZJ7u52fR0CX2gF
         URsWnc1XPwBWZ+xRga3khJF+nDFUjTDJUO9/tEAfZ6mTUQinh0JuU2nLPIHgqEUtiDpK
         sGj5vo6ECiS5xsT46UWqLkRRmqqzbvUHWVVXc90O+r3553vLiJHF/Elhhn6bASnoF+zI
         sTOaa5nzMIAt/4oInt4UD4ShQPSWnXZ//PbZt9MDX1B9ab49bT9T/f5VNdlwdcEg9DHO
         ykow==
X-Gm-Message-State: AHQUAuYCU7Uod0+hartV6ORi5UGRwMZYBYhuXmpvosOylGhz+2Uz6bRp
        zidHu6i+ijuQTRUh3uj7iSE=
X-Google-Smtp-Source: AHgI3IbIqG76F5iw/WVx3RtEmtdN8RqImuM6uM/rK60cWCtO/s3g+/3YiAcKucPyCDktEnwvUciCUw==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr5002457plu.122.1549994237645;
        Tue, 12 Feb 2019 09:57:17 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id z186sm18608427pfz.119.2019.02.12.09.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:57:16 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 2/3] mm: separate memory allocation and actual work in alloc_vmap_area()
Date:   Tue, 12 Feb 2019 09:56:47 -0800
Message-Id: <20190212175648.28738-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212175648.28738-1-guro@fb.com>
References: <20190212175648.28738-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_vmap_area() is allocating memory for the vmap_area, and
performing the actual lookup of the vm area and vmap_area
initialization.

This prevents us from using a pre-allocated memory for the map_area
structure, which can be used in some cases to minimize the number
of required memory allocations.

Let's keep the memory allocation part in alloc_vmap_area() and
separate everything else into init_vmap_area().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8f0179895fb5..f1f19d1105c4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -395,16 +395,10 @@ static void purge_vmap_area_lazy(void);
 
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 
-/*
- * Allocate a region of KVA of the specified size and alignment, within the
- * vstart and vend.
- */
-static struct vmap_area *alloc_vmap_area(unsigned long size,
-				unsigned long align,
-				unsigned long vstart, unsigned long vend,
-				int node, gfp_t gfp_mask)
+static int init_vmap_area(struct vmap_area *va, unsigned long size,
+			  unsigned long align, unsigned long vstart,
+			  unsigned long vend, int node, gfp_t gfp_mask)
 {
-	struct vmap_area *va;
 	struct rb_node *n;
 	unsigned long addr;
 	int purged = 0;
@@ -416,11 +410,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	might_sleep();
 
-	va = kmalloc_node(sizeof(struct vmap_area),
-			gfp_mask & GFP_RECLAIM_MASK, node);
-	if (unlikely(!va))
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * Only scan the relevant parts containing pointers to other objects
 	 * to avoid false negatives.
@@ -516,7 +505,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
-	return va;
+	return 0;
 
 overflow:
 	spin_unlock(&vmap_area_lock);
@@ -538,8 +527,35 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
 		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
 			size);
-	kfree(va);
-	return ERR_PTR(-EBUSY);
+
+	return -EBUSY;
+}
+
+/*
+ * Allocate a region of KVA of the specified size and alignment, within the
+ * vstart and vend.
+ */
+static struct vmap_area *alloc_vmap_area(unsigned long size,
+					 unsigned long align,
+					 unsigned long vstart,
+					 unsigned long vend,
+					 int node, gfp_t gfp_mask)
+{
+	struct vmap_area *va;
+	int ret;
+
+	va = kmalloc_node(sizeof(struct vmap_area),
+			gfp_mask & GFP_RECLAIM_MASK, node);
+	if (unlikely(!va))
+		return ERR_PTR(-ENOMEM);
+
+	ret = init_vmap_area(va, size, align, vstart, vend, node, gfp_mask);
+	if (ret) {
+		kfree(va);
+		return ERR_PTR(ret);
+	}
+
+	return va;
 }
 
 int register_vmap_purge_notifier(struct notifier_block *nb)
-- 
2.20.1

