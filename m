Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55F220833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55F220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeIKSmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:42:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727782AbeIKSln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:41:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EA697721D;
        Tue, 11 Sep 2018 13:42:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1940D1CEE;
        Tue, 11 Sep 2018 13:42:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DFE479AF2; Tue, 11 Sep 2018 15:42:16 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/13] udmabuf: rework limits
Date:   Tue, 11 Sep 2018 15:42:10 +0200
Message-Id: <20180911134216.9760-8-kraxel@redhat.com>
In-Reply-To: <20180911134216.9760-1-kraxel@redhat.com>
References: <20180911134216.9760-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 13:42:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 13:42:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create variable for the list length limit.  Serves as documentation,
also allows to make it a module parameter if needed.

Also add a total size limit.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/dma-buf/udmabuf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 4167da8141..a01fcf6a66 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -12,6 +12,9 @@
 #include <linux/slab.h>
 #include <linux/udmabuf.h>
 
+static const u32    list_limit = 1024;  /* udmabuf_create_list->count limit */
+static const size_t size_limit_mb = 64; /* total dmabuf size, in megabytes  */
+
 struct udmabuf {
 	pgoff_t pagecount;
 	struct page **pages;
@@ -123,7 +126,7 @@ static long udmabuf_create(const struct udmabuf_create_list *head,
 	struct file *memfd = NULL;
 	struct udmabuf *ubuf;
 	struct dma_buf *buf;
-	pgoff_t pgoff, pgcnt, pgidx, pgbuf;
+	pgoff_t pgoff, pgcnt, pgidx, pgbuf, pglimit;
 	struct page *page;
 	int seals, ret = -EINVAL;
 	u32 i, flags;
@@ -132,12 +135,15 @@ static long udmabuf_create(const struct udmabuf_create_list *head,
 	if (!ubuf)
 		return -ENOMEM;
 
+	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
 	for (i = 0; i < head->count; i++) {
 		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
 			goto err_free_ubuf;
 		if (!IS_ALIGNED(list[i].size, PAGE_SIZE))
 			goto err_free_ubuf;
 		ubuf->pagecount += list[i].size >> PAGE_SHIFT;
+		if (ubuf->pagecount > pglimit)
+			goto err_free_ubuf;
 	}
 	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct page *),
 				    GFP_KERNEL);
@@ -227,7 +233,7 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 
 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
-	if (head.count > 1024)
+	if (head.count > list_limit)
 		return -EINVAL;
 	lsize = sizeof(struct udmabuf_create_item) * head.count;
 	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
-- 
2.9.3

