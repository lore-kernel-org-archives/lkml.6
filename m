Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172BE20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ceYErFMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfAHNHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:07:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfAHNHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=30fPNqiJhNB/fhrijdhBItayyeau+8kMnT8NwCIPPZg=; b=ceYErFMcqnrJOphUi34zx7MAW5
        VJquzHKZRHHWlwyKZBoOiv1tUBXW8oDifhQr95lvTblJ6FtgYXyVtafPg/fRchOPyzzwmsgJGbFgz
        S9IJfZ/72HXnMe5Sd7swCzmbvktVFFT11hAt20e/z1xgFdNp6Tl4iw0dSaI7oMhOndXoiu+1gydDH
        lmL7JeAHK3PmQaYNxkPOyBwcyaI2Sv8ILuwrJdYtq9Va9kzF4l4k3LRzONIFg/bJLkk05ortMDdZU
        V9PrNIcZwkbEcwWdRA76NLwb/M3MwzBBib6OD9GiG4fCBG4/IHxmlYFRk3Qp7G2T1JIvAAulm7Ea2
        Tc7+TDCg==;
Received: from rrcs-24-103-175-221.nys.biz.rr.com ([24.103.175.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggr64-0005bn-MA; Tue, 08 Jan 2019 13:07:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dma-mapping: remove dma_zalloc_coherent()
Date:   Tue,  8 Jan 2019 08:07:01 -0500
Message-Id: <20190108130701.14161-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108130701.14161-1-hch@lst.de>
References: <20190108130701.14161-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

dma_zalloc_coherent() is no longer needed as it has no users because
dma_alloc_coherent() already zeroes out memory for us.

The Coccinelle grammar rule that used to check for dma_alloc_coherent()
+ memset() is modified so that it just tells the user that the memset is
not needed anymore.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h                      |  9 ---------
 scripts/coccinelle/api/alloc/alloc_cast.cocci    |  8 ++++----
 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 11 +----------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index cef2127e1d70..f6ded992c183 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -717,15 +717,6 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #endif
 
-/*
- * Please always use dma_alloc_coherent instead as it already zeroes the memory!
- */
-static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flag)
-{
-	return dma_alloc_coherent(dev, size, dma_handle, flag);
-}
-
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
index 408ee3879f9b..18fedf7c60ed 100644
--- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
+++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
@@ -32,7 +32,7 @@ type T;
   (T *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
@@ -55,7 +55,7 @@ type r1.T;
 * (T *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
@@ -78,7 +78,7 @@ type r1.T;
 - (T *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
@@ -95,7 +95,7 @@ position p;
  (T@p *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
index d819275b7fde..5cd1991c582e 100644
--- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -69,15 +69,6 @@ statement S;
 - x = (T)vmalloc(E1);
 + x = (T)vzalloc(E1);
 |
-- x = dma_alloc_coherent(E2,E1,E3,E4);
-+ x = dma_zalloc_coherent(E2,E1,E3,E4);
-|
-- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
-+ x = dma_zalloc_coherent(E2,E1,E3,E4);
-|
-- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
-+ x = (T)dma_zalloc_coherent(E2,E1,E3,E4);
-|
 - x = kmalloc_node(E1,E2,E3);
 + x = kzalloc_node(E1,E2,E3);
 |
@@ -225,7 +216,7 @@ p << r2.p;
 x << r2.x;
 @@
 
-msg="WARNING: dma_zalloc_coherent should be used for %s, instead of dma_alloc_coherent/memset" % (x)
+msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
 coccilib.report.print_report(p[0], msg)
 
 //-----------------------------------------------------------------
-- 
2.20.1

