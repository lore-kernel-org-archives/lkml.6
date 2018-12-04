Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84493C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0E92087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIjArO+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0E92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLDIX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:23:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44683 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:23:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so7824096pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BC2yXIgwrgbb+vp2SoDp3a5EYKg+hZ4W2JytOoK4K4A=;
        b=TIjArO+kHpXg+DvsilBuxqhzyDTY0F589DL9ubB2vO/d22duhswOs4v1PKAYnn3RID
         QDXhFfuefgwzAaYIO51TU+12aJAh7kSt/oge38mwE2FktiwNt6CouZE9kec7ZQpDkong
         P/9qkf/AYCBd5sZFs/zAZWHRF2jL4PgO8ZF2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BC2yXIgwrgbb+vp2SoDp3a5EYKg+hZ4W2JytOoK4K4A=;
        b=f5gbg3Z9L2ke6IpD8uZDucGqFnHHiaXi1scZWVP35Vw86wFZq+VSlglGBhNF1HNXfp
         xXOnA9+hrA/1yloGWM4FFFGrY96soOJ0CMDuA8uZtp/GS4Exafr5uBGxMm/h6B5QQNEh
         UuQLNWYD5muZ608wAqk8d73HMuXpszAuDjtIZ94DstxSZqadCL1NyULCZWQxRPCNOF0B
         +w+riIDQrz6UJU7UyXcb3Sivd907o/pOLyiE0L404E6EBDC/RbmFksjNqHfGLSqsB+V4
         ol4OWuqLoFLHuHAlInfNss31W5PbKJXNYne7wHZK3rNSz5urklvak3BTcnoIoRoG6ExP
         kabQ==
X-Gm-Message-State: AA+aEWbBLQIDWCv2PGLYwRkVJ+0BwVLukFJ5eaAAgUCS2030d5BuDvN7
        42uFR1f2D5WrZbPKSZA9Rr3osw==
X-Google-Smtp-Source: AFSGD/VpTQsU4DiTZ31xNf7o/qoPM2bSEhhvzRB/WoSeJt9tmOMRs+2XyBTMAtmWqbQpg1/GbsZAbw==
X-Received: by 2002:a62:c613:: with SMTP id m19mr19435575pfg.207.1543911807270;
        Tue, 04 Dec 2018 00:23:27 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id y6sm44911418pfd.104.2018.12.04.00.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 00:23:26 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3, RFC] iommu/io-pgtable-arm-v7s: Use page_frag to request DMA32 memory
Date:   Tue,  4 Dec 2018 16:23:00 +0800
Message-Id: <20181204082300.95106-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMUs using ARMv7 short-descriptor format require page tables
(level 1 and 2) to be allocated within the first 4GB of RAM, even
on 64-bit systems.

For level 1/2 tables, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
is defined (e.g. on arm64 platforms).

For level 2 tables (1 KB), we use page_frag to allocate these pages,
as we cannot directly use kmalloc (no slab cache for GFP_DMA32) or
kmem_cache (mm/ code treats GFP_DMA32 as an invalid flag).

One downside is that we only free the allocated page if all the
4 fragments (4 IOMMU L2 tables) are freed, but given that we
usually only allocate limited number of IOMMU L2 tables, this
should not have too much impact on memory usage: In the absolute
worst case (4096 L2 page tables, each on their own 4K page),
we would use 16 MB of memory for 4 MB of L2 tables.

Also, print an error when the physical address does not fit in
32-bit, to make debugging easier in the future.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

As an alternative to the series [1], which adds support for GFP_DMA32
to kmem_cache in mm/. IMHO the solution in [1] is cleaner and more
efficient, as it allows freed fragments (L2 tables) to be reused, but
this approach does not require any core change.

[1] https://patchwork.kernel.org/cover/10677529/, 3 patches

 drivers/iommu/io-pgtable-arm-v7s.c | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..0de6a51eb6755f 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -161,6 +161,12 @@
 
 #define ARM_V7S_TCR_PD1			BIT(5)
 
+#ifdef CONFIG_ZONE_DMA32
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
+#else
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
+#endif
+
 typedef u32 arm_v7s_iopte;
 
 static bool selftest_running;
@@ -169,7 +175,7 @@ struct arm_v7s_io_pgtable {
 	struct io_pgtable	iop;
 
 	arm_v7s_iopte		*pgd;
-	struct kmem_cache	*l2_tables;
+	struct page_frag_cache	l2_tables;
 	spinlock_t		split_lock;
 };
 
@@ -198,13 +204,17 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	void *table = NULL;
 
 	if (lvl == 1)
-		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
+		table = (void *)__get_free_pages(
+			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+		table = page_frag_alloc(&data->l2_tables, size,
+				gfp | __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA);
 	phys = virt_to_phys(table);
-	if (phys != (arm_v7s_iopte)phys)
+	if (phys != (arm_v7s_iopte)phys) {
 		/* Doesn't fit in PTE */
+		dev_err(dev, "Page table does not fit in PTE: %pa", &phys);
 		goto out_free;
+	}
 	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
@@ -227,7 +237,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	if (lvl == 1)
 		free_pages((unsigned long)table, get_order(size));
 	else
-		kmem_cache_free(data->l2_tables, table);
+		page_frag_free(table);
 	return NULL;
 }
 
@@ -244,7 +254,7 @@ static void __arm_v7s_free_table(void *table, int lvl,
 	if (lvl == 1)
 		free_pages((unsigned long)table, get_order(size));
 	else
-		kmem_cache_free(data->l2_tables, table);
+		page_frag_free(table);
 }
 
 static void __arm_v7s_pte_sync(arm_v7s_iopte *ptep, int num_entries,
@@ -515,7 +525,6 @@ static void arm_v7s_free_pgtable(struct io_pgtable *iop)
 			__arm_v7s_free_table(iopte_deref(pte, 1), 2, data);
 	}
 	__arm_v7s_free_table(data->pgd, 1, data);
-	kmem_cache_destroy(data->l2_tables);
 	kfree(data);
 }
 
@@ -729,17 +738,11 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))
 			return NULL;
 
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
 
 	spin_lock_init(&data->split_lock);
-	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
-					    ARM_V7S_TABLE_SIZE(2),
-					    ARM_V7S_TABLE_SIZE(2),
-					    SLAB_CACHE_DMA, NULL);
-	if (!data->l2_tables)
-		goto out_free_data;
 
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_v7s_map,
@@ -789,7 +792,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	return &data->iop;
 
 out_free_data:
-	kmem_cache_destroy(data->l2_tables);
 	kfree(data);
 	return NULL;
 }
-- 
2.20.0.rc1.387.gf8505762e3-goog

