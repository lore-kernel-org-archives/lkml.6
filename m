Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A83BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F200B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F200B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeIKSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:42:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727659AbeIKSlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 377A4814FDD2;
        Tue, 11 Sep 2018 13:42:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E79322026D6B;
        Tue, 11 Sep 2018 13:42:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 63A999B1B; Tue, 11 Sep 2018 15:42:16 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/13] udmabuf: improve map_udmabuf error handling
Date:   Tue, 11 Sep 2018 15:42:05 +0200
Message-Id: <20180911134216.9760-3-kraxel@redhat.com>
In-Reply-To: <20180911134216.9760-1-kraxel@redhat.com>
References: <20180911134216.9760-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 13:42:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 13:42:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/dma-buf/udmabuf.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 155050c741..0d03367c57 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -51,25 +51,24 @@ static struct sg_table *map_udmabuf(struct dma_buf_attachment *at,
 {
 	struct udmabuf *ubuf = at->dmabuf->priv;
 	struct sg_table *sg;
+	int ret;
 
 	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
 	if (!sg)
-		goto err1;
-	if (sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount,
-				      0, ubuf->pagecount << PAGE_SHIFT,
-				      GFP_KERNEL) < 0)
-		goto err2;
+		return ERR_PTR(-ENOMEM);
+	ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount,
+					0, ubuf->pagecount << PAGE_SHIFT,
+					GFP_KERNEL);
+	if (ret < 0)
+		goto err;
 	if (!dma_map_sg(at->dev, sg->sgl, sg->nents, direction))
-		goto err3;
-
+		goto err;
 	return sg;
 
-err3:
+err:
 	sg_free_table(sg);
-err2:
 	kfree(sg);
-err1:
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 
 static void unmap_udmabuf(struct dma_buf_attachment *at,
-- 
2.9.3

