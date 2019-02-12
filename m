Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7994F2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e4UQOorg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfBLHZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:25:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+Jj0P3OpYzmdsxWGOg0JUWIfg/9M8oR4H8vvONKpE2Y=; b=e4UQOorgaMeL2hNotWTeulf85d
        tQ45Lsg+FHMDh7wFbMtX/AxyAZxpibxzmddHm//JUFLpcT80gcCXxxQHD9QjqHmGo2CT74a65LXta
        stiUjAgkC+0OmklRfZ3+toIUuQc2eErbz0NIrRmdztzn5JTDZkadifFIhmheyVWWqFMgTGiEqmC94
        BLOkoCaAypnoqlZCWWAGo0lXl9s/NjfErN7dTKKbr5juutZAIq1JB4akZTqA4W0V4jXf2y83wBR1s
        JRINJWx1mU1AdXAlmRRsy76KTWXYxHxoUec849yRXTcuQm8JSAfZd0VJaZxQw4TYnU+IDRk7pr8JL
        5icTsR5w==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRh-0002OC-IA; Tue, 12 Feb 2019 07:25:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] scatterlist: add sg_kmap_atomic / sg_kunmap_atomic helpers
Date:   Tue, 12 Feb 2019 08:25:15 +0100
Message-Id: <20190212072528.13167-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids bug prone open coding of the sg offset handling and
also helps to document the limitations of mapping scatterlist
entries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/scatterlist.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b96f0d0b5b8f..524cd8448a48 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCATTERLIST_H
 #define _LINUX_SCATTERLIST_H
 
+#include <linux/highmem.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
@@ -239,6 +240,31 @@ static inline void *sg_virt(struct scatterlist *sg)
 	return page_address(sg_page(sg)) + sg->offset;
 }
 
+/**
+ * sg_kmap_atomic - map a S/G list entry to a kernel address
+ * @sg:		scatterlist entry
+ *
+ * Return a kernel address for scatterlist entry by kmapping it.  Note that
+ * this function must only be called on scatterlist entries that do not span
+ * multiple pages.
+ */
+static inline void *sg_kmap_atomic(struct scatterlist *sg)
+{
+	if (WARN_ON_ONCE(sg->offset + sg->length > PAGE_SIZE))
+		return NULL;
+	return kmap_atomic(sg_page(sg)) + sg->offset;
+}
+
+/**
+ * sg_kunmap_atomic - unmap a S/G list entry to a kernel address
+ * @sg:		scatterlist entry
+ * @ptr:	address returned from sg_kmap_atomic
+ */
+static inline void sg_kunmap_atomic(struct scatterlist *sg, void *ptr)
+{
+	kunmap_atomic(ptr - sg->offset);
+}
+
 /**
  * sg_init_marker - Initialize markers in sg table
  * @sgl:	   The SG table
-- 
2.20.1

