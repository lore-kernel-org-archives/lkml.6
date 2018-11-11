Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA5BC04EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E6F2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcjG9kTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E6F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeKKSwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:52:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38083 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:52:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so2696670pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 01:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3drSXNEQad/j7zI+ID7YdbI6KhfStGY6vScO313iR4=;
        b=DcjG9kTDXB4SQ7VqcCMrX/L11oHaZNfPg9bG1SMflAXtx7Sdu1dqaoGyXOCoJ27tqZ
         TXk+rgHoUJbj9EsRYITf58Qh9ZhpgwOmxbxRHsI9hfkN3Wuw3up8qbfLy+xDMg7VZc+c
         e1b6fwI4rwon3DJdb6ZCA5AYTpsyukkQJdy20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3drSXNEQad/j7zI+ID7YdbI6KhfStGY6vScO313iR4=;
        b=NBXhWAPfawWEYRXJ64AYWU/WFbZVhth/1cxra6vZlf3ru/9t6lBebsYgRHIj0Schcz
         r+MfmYCaLdMCgTiEneLIz9dEPMPrcY3x13cKv5Wx47yoDvWAUvh50dxS36NMVINi/FAU
         8qeM7FcShrEvT/TVI6N10p9d9CzTpLawlaCBGzGv6NTxeyAxjD9b9NNzE5AHwN6ID7Hv
         CYJ9gt2k/NxrvOcgGaiswb1k8kv4C2MxK9SgmQJx1MJhQYrAHaVIciLj8j3QjBlJHuXf
         UzxVyl8erUZ7+sAglFHBXJE628fstSwEbEX91zJJnWJiT/3uZjGSW/sMbEzw0Pjx+/qD
         oBNw==
X-Gm-Message-State: AGRZ1gL+bKNxpdOI8muwnni4HU5c6wLIHwTducY+7Ky7q5Z0dAo9CEPy
        08gEjvSkUHPQlvK5NEUs6tZdwg==
X-Google-Smtp-Source: AJdET5d2kWGbhQDjOrVfaAjb6eaSaPcg2FtnCOnFt4V3Lsv/PQqo/3P8/Z+UfUKpHSPr81IYnMgzzw==
X-Received: by 2002:a63:f141:: with SMTP id o1mr13637587pgk.134.1541927054240;
        Sun, 11 Nov 2018 01:04:14 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id 69sm8107956pgg.86.2018.11.11.01.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 01:04:13 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
Date:   Sun, 11 Nov 2018 17:03:41 +0800
Message-Id: <20181111090341.120786-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181111090341.120786-1-drinkcat@chromium.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For level 1/2 pages, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
is defined (e.g. on arm64 platforms).

For level 2 pages, allocate a slab cache in SLAB_CACHE_DMA32.

Also, print an error when the physical address does not fit in
32-bit, to make debugging easier in the future.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v1:
 - Changed approach to use SLAB_CACHE_DMA32 added by the previous
   commit.
 - Use DMA or DMA32 depending on the architecture (DMA for arm,
   DMA32 for arm64).

drivers/iommu/io-pgtable-arm-v7s.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..996f7b6d00b44a 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -161,6 +161,14 @@
 
 #define ARM_V7S_TCR_PD1			BIT(5)
 
+#ifdef CONFIG_ZONE_DMA32
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
+#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
+#else
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
+#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
+#endif
+
 typedef u32 arm_v7s_iopte;
 
 static bool selftest_running;
@@ -198,13 +206,17 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	void *table = NULL;
 
 	if (lvl == 1)
-		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
+		table = (void *)__get_free_pages(
+			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+		table = kmem_cache_zalloc(data->l2_tables,
+					  gfp | ARM_V7S_TABLE_GFP_DMA);
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
@@ -737,7 +749,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
 					    ARM_V7S_TABLE_SIZE(2),
 					    ARM_V7S_TABLE_SIZE(2),
-					    SLAB_CACHE_DMA, NULL);
+					    ARM_V7S_TABLE_SLAB_CACHE, NULL);
 	if (!data->l2_tables)
 		goto out_free_data;
 
-- 
2.19.1.930.g4563a0d9d0-goog

