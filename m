Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A332C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350CE20873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Zfq4RP+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeL1IkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:40:21 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:45982 "EHLO owa.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeL1IkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:40:20 -0500
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1545986414; h=from:subject:to:date:message-id;
        bh=hPGTggK5mBzVng4X/eY1ndyLBHEXD2yxkrrkNdSjxi0=;
        b=Zfq4RP+jdHrA0A51NQKdLp5tsQsTocr4Or1dwH/oIl6/cFk/15xI33rESQpgeKkf542rE/7olws
        o3jnXO+UK7b2HiDiXH2CvnBZJUWEkARdP0Wym+B9sLFz1seKactB8dyfqDrOEXjqk6TNDVb9CyACa
        BYV3hS8K0Jnd3zi7h70=
Received: from localhost.localdomain (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Fri, 28 Dec 2018 16:40:13 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <sfr@canb.auug.org.au>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <shijie8@gmail.com>, Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to gen_pool_has_addr
Date:   Fri, 28 Dec 2018 16:39:50 +0800
Message-ID: <20181228083950.20398-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the kernel conventions, rename addr_in_gen_pool to
gen_pool_has_addr.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 drivers/misc/sram-exec.c  | 2 +-
 include/linux/genalloc.h  | 2 +-
 kernel/dma/remap.c        | 2 +-
 lib/genalloc.c            | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922e447c..a876101a0f82 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -563,7 +563,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 
 static bool __in_atomic_pool(void *start, size_t size)
 {
-	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
+	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
 }
 
 static int __free_from_pool(void *start, size_t size)
diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index 426ad912b441..d054e2842a5f 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -96,7 +96,7 @@ void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	if (!part)
 		return NULL;
 
-	if (!addr_in_gen_pool(pool, (unsigned long)dst, size))
+	if (!gen_pool_has_addr(pool, (unsigned long)dst, size))
 		return NULL;
 
 	base = (unsigned long)part->base;
diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index dd0a452373e7..c5e5bed82fbc 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -156,7 +156,7 @@ extern struct gen_pool *devm_gen_pool_create(struct device *dev,
 		int min_alloc_order, int nid, const char *name);
 extern struct gen_pool *gen_pool_get(struct device *dev, const char *name);
 
-bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
+extern bool gen_pool_has_addr(struct gen_pool *pool, unsigned long start,
 			size_t size);
 
 #ifdef CONFIG_OF
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 18cc09fc27b9..5022b904d7bc 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -158,7 +158,7 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 
 bool dma_in_atomic_pool(void *start, size_t size)
 {
-	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
+	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
 }
 
 void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 96b6f478d275..946bbeefec81 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -423,7 +423,7 @@ void gen_pool_for_each_chunk(struct gen_pool *pool,
 EXPORT_SYMBOL(gen_pool_for_each_chunk);
 
 /**
- * addr_in_gen_pool - checks if an address falls within the range of a pool
+ * gen_pool_has_addr - checks if an address falls within the range of a pool
  * @pool:	the generic memory pool
  * @start:	start address
  * @size:	size of the region
@@ -431,7 +431,7 @@ EXPORT_SYMBOL(gen_pool_for_each_chunk);
  * Check if the range of addresses falls within the specified pool. Returns
  * true if the entire range is contained in the pool and false otherwise.
  */
-bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
+bool gen_pool_has_addr(struct gen_pool *pool, unsigned long start,
 			size_t size)
 {
 	bool found = false;
@@ -450,7 +450,7 @@ bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
 	rcu_read_unlock();
 	return found;
 }
-EXPORT_SYMBOL(addr_in_gen_pool);
+EXPORT_SYMBOL(gen_pool_has_addr);
 
 /**
  * gen_pool_avail - get available free space of the pool
-- 
2.17.1

