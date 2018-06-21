Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30585C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72CF2241A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I7ToufNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72CF2241A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934011AbeFUVcK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:32:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933973AbeFUV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PPrchwmaNlTnEQhhgn+AO0lue+wNtufAdQcEveCghxQ=; b=I7ToufNFSsvJkHIjYXIo+EP9U
        KMpmQp1w251Wyzr5RorOE7EfyEdYEH3SnsFb62QpLiJz+WFEJuU2rPt8NOeUmIeVQhg+h1YuNBH8w
        rJKH2bU3AncP0IkagOdd5ENYxO3UzL49gYUAVICReelkIi/lZhn8AmXejQLjNucNSbc+iJx2FoTwd
        6ckR426C2vOvVJL5tIjeI1ThwFCYQCQtwb1C5Mykl0GSvHeH4Pb1zz8zC8rOiLS5+n8wco+ugYy3F
        28Gx31zbEFSu1mWwGiecu5PccwX1plIoCkcUzAwawvl58UIUVSj/4vSdkw8LRGqLgs+tWoHYHWv9/
        LkAl18yjA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78f-0001cD-Up; Thu, 21 Jun 2018 21:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/26] drm/vmwgfx: Convert to new IDA API
Date:   Thu, 21 Jun 2018 14:28:26 -0700
Message-Id: <20180621212835.5636-18-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder allocation to avoid an awkward lock/unlock/lock sequence.
Simpler code due to being able to use ida_alloc_max(), even if we can't
eliminate the driver's spinlock.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c | 41 ++++++-------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
index f2f9d88131f2..2d6291373efb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -51,51 +51,34 @@ static int vmw_gmrid_man_get_node(struct ttm_mem_type_manager *man,
 {
 	struct vmwgfx_gmrid_man *gman =
 		(struct vmwgfx_gmrid_man *)man->priv;
-	int ret = 0;
 	int id;
 
 	mem->mm_node = NULL;
 
+	id = ida_alloc_max(&gman->gmr_ida, gman->max_gmr_ids - 1, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
 	spin_lock(&gman->lock);
 
 	if (gman->max_gmr_pages > 0) {
 		gman->used_gmr_pages += bo->num_pages;
 		if (unlikely(gman->used_gmr_pages > gman->max_gmr_pages))
-			goto out_err_locked;
+			goto nospace;
 	}
 
-	do {
-		spin_unlock(&gman->lock);
-		if (unlikely(ida_pre_get(&gman->gmr_ida, GFP_KERNEL) == 0)) {
-			ret = -ENOMEM;
-			goto out_err;
-		}
-		spin_lock(&gman->lock);
-
-		ret = ida_get_new(&gman->gmr_ida, &id);
-		if (unlikely(ret == 0 && id >= gman->max_gmr_ids)) {
-			ida_remove(&gman->gmr_ida, id);
-			ret = 0;
-			goto out_err_locked;
-		}
-	} while (ret == -EAGAIN);
-
-	if (likely(ret == 0)) {
-		mem->mm_node = gman;
-		mem->start = id;
-		mem->num_pages = bo->num_pages;
-	} else
-		goto out_err_locked;
+	mem->mm_node = gman;
+	mem->start = id;
+	mem->num_pages = bo->num_pages;
 
 	spin_unlock(&gman->lock);
 	return 0;
 
-out_err:
-	spin_lock(&gman->lock);
-out_err_locked:
+nospace:
 	gman->used_gmr_pages -= bo->num_pages;
 	spin_unlock(&gman->lock);
-	return ret;
+	ida_free(&gman->gmr_ida, id);
+	return 0;
 }
 
 static void vmw_gmrid_man_put_node(struct ttm_mem_type_manager *man,
@@ -105,8 +88,8 @@ static void vmw_gmrid_man_put_node(struct ttm_mem_type_manager *man,
 		(struct vmwgfx_gmrid_man *)man->priv;
 
 	if (mem->mm_node) {
+		ida_free(&gman->gmr_ida, mem->start);
 		spin_lock(&gman->lock);
-		ida_remove(&gman->gmr_ida, mem->start);
 		gman->used_gmr_pages -= mem->num_pages;
 		spin_unlock(&gman->lock);
 		mem->mm_node = NULL;
-- 
2.17.1

