Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D946FC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F2B2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F4dSAwLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F2B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLJBPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:15:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35798 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeLJBP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:15:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so4179553pgs.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 17:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zyI5zxZwGodfMTrNuDET37rIHixML6NRWv3fhvncg0=;
        b=F4dSAwLagRa3eNfp8xVsBcj5GpG/ybNbaaAygiLhss+vwu7nAPzQ6u6tFw1OlDVwdk
         OGFjnIPRhzQSnsSC+yj3pYAIYoaIzKv8E3NvGpEVdV3OjzxbwUzEHIbS0NOPFgvoefvT
         TIA08R0lL8xmw8DW6FTHsu5otufjdV5lXsirc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zyI5zxZwGodfMTrNuDET37rIHixML6NRWv3fhvncg0=;
        b=fzyw1AttU+5W/8SoYqp28TP2tzxiX3RmJwP1z0sXO0uoB5U8N8b6Z5VE5IO/Nz4h7I
         de1vdLT8wnEasqwiSoi/96t8MkJBm64NyykkMW27WeVn991TwotrBvrFqW9cRaMsPHBu
         Z04GC3O+r6rW3nR26DBEYLcF7iYZnl7a7ZElo3LpSI1CcURSYGQ085g6gbDQXABO3wnK
         hegl+aSx2NZBveJmXAJSOWsRZjTo/Oe2dagSza9670SD6GCdekAfYh8p8l7prGF8P111
         cQ782BAbkRqKctyutl3WdA3gbEx95F2iFCPnrU+g6gmJRu4GarblUPb/PVbnoqZx5CA8
         Bpcg==
X-Gm-Message-State: AA+aEWZKcNeVHVvAOTBf5WoMdg+mhuQVpJmrNQW+vZBZMYMfSXIEcEQg
        HsoiBeEUNaYfYNSTxfLQRsI5TQ==
X-Google-Smtp-Source: AFSGD/UweY//RlIzHQzR4czsV/CUhCbYkqwlM4MbLxoZIZ/Pxxkz5U+J4ofgZQwt5fWHP6ylViFjDQ==
X-Received: by 2002:a63:4187:: with SMTP id o129mr8507789pga.370.1544404528270;
        Sun, 09 Dec 2018 17:15:28 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id b10sm16516336pfj.183.2018.12.09.17.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 17:15:27 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>,
        hsinyi@chromium.org, stable@vger.kernel.org
Subject: [PATCH v6 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
Date:   Mon, 10 Dec 2018 09:15:03 +0800
Message-Id: <20181210011504.122604-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181210011504.122604-1-drinkcat@chromium.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMUs using ARMv7 short-descriptor format require page tables
(level 1 and 2) to be allocated within the first 4GB of RAM, even
on 64-bit systems.

For level 1/2 pages, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
is defined (e.g. on arm64 platforms).

For level 2 pages, allocate a slab cache in SLAB_CACHE_DMA32. Note
that we do not explicitly pass GFP_DMA[32] to kmem_cache_zalloc,
as this is not strictly necessary, and would cause a warning
in mm/sl*b.c, as we did not update GFP_SLAB_BUG_MASK.

Also, print an error when the physical address does not fit in
32-bit, to make debugging easier in the future.

Cc: stable@vger.kernel.org
Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v2:
 - Commit message

(v3 used the page_frag approach)

Changes since v4:
 - Do not pass ARM_V7S_TABLE_GFP_DMA to kmem_cache_zalloc, as this
   is unnecessary, and would trigger a warning.

Changes since v5:
 - Rename ARM_V7S_TABLE_SLAB_CACHE to ARM_V7S_TABLE_SLAB_FLAGS.

 drivers/iommu/io-pgtable-arm-v7s.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..d2fdb192f7610f 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -161,6 +161,14 @@
 
 #define ARM_V7S_TCR_PD1			BIT(5)
 
+#ifdef CONFIG_ZONE_DMA32
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
+#define ARM_V7S_TABLE_SLAB_FLAGS SLAB_CACHE_DMA32
+#else
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
+#define ARM_V7S_TABLE_SLAB_FLAGS SLAB_CACHE_DMA
+#endif
+
 typedef u32 arm_v7s_iopte;
 
 static bool selftest_running;
@@ -198,13 +206,16 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	void *table = NULL;
 
 	if (lvl == 1)
-		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
+		table = (void *)__get_free_pages(
+			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+		table = kmem_cache_zalloc(data->l2_tables, gfp);
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
@@ -737,7 +748,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
 					    ARM_V7S_TABLE_SIZE(2),
 					    ARM_V7S_TABLE_SIZE(2),
-					    SLAB_CACHE_DMA, NULL);
+					    ARM_V7S_TABLE_SLAB_FLAGS, NULL);
 	if (!data->l2_tables)
 		goto out_free_data;
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

