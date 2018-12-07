Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06085C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09F520837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gkfg+veq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09F520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeLGGQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:16:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36811 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeLGGQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:16:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so1345008plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJoswCrlfo65GP7YSjDD5Dxde1TEKzOE1bHdE5k2YXA=;
        b=Gkfg+veq3tFoCNjzTVVK4MzF1+VxmDDREWTh7F/H38sptZ3jt6fe3ndCmar2DUe88M
         oshVn2q+niIJDMUfWeFJfKyH74cwlJzUYMUI+jek4GUAaKZJrUA5/Wt8W8OCBlnE+JYt
         uX3zOPZH8Nwsy5ulmVaJycpdrDUdwiSAerjcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJoswCrlfo65GP7YSjDD5Dxde1TEKzOE1bHdE5k2YXA=;
        b=EzYXqDoeOQBf9xl7No38VHnSf+0/vxJ9b5D0iDVnnYQrY+8T8xcY0McmmflZ+/Y/xT
         vQAIqyxX+U3h9lvj5SSUqQzwVkXV/r4gJD4aC02cGVZsrrJQYm0sgv/rnpOwxrfp0p1c
         0+p9u2qOzNufw7qxGQeDep24SsbgCzxZiDW+GkIeEl8hOvtiMaXNo80WhdzVkkNJp8li
         Prl3MOu0oJXLVbZCAclckFM3BYNYU+iHEvjOvTYRXjaFPVwJp0vPailLE+XTHhUT2vBt
         pjJLUQmok86iEP1AayGx3gSdn87DLf2tJ7MIPjG1JiBk554tpYve0fa2sQfCg4DPixal
         we1A==
X-Gm-Message-State: AA+aEWY0TqOLhozGiBL7TdB1cHJvGlSrtcP+a8Wt5xkwy3vVvELK8ZbF
        H8zboq28Rvve2QphwmwDQjGERQ==
X-Google-Smtp-Source: AFSGD/XZa6HFUd/c5IPU8LIhweh/OmveFRXhgV1EPw5ux8VC+DfGZoBXt4ZppI0AFEFQOSUKgZ7anw==
X-Received: by 2002:a17:902:74c1:: with SMTP id f1mr928632plt.273.1544163411694;
        Thu, 06 Dec 2018 22:16:51 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id z30-v6sm2995944pfg.41.2018.12.06.22.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 22:16:51 -0800 (PST)
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
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
Date:   Fri,  7 Dec 2018 14:16:19 +0800
Message-Id: <20181207061620.107881-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181207061620.107881-1-drinkcat@chromium.org>
References: <20181207061620.107881-1-drinkcat@chromium.org>
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

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v2:
 - Commit message

(v3 used the page_frag approach)

Changes since v4:
 - Do not pass ARM_V7S_TABLE_GFP_DMA to kmem_cache_zalloc, as this
   is unnecessary, and would trigger a warning.

 drivers/iommu/io-pgtable-arm-v7s.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..f311fe1dfa47b7 100644
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
+					    ARM_V7S_TABLE_SLAB_CACHE, NULL);
 	if (!data->l2_tables)
 		goto out_free_data;
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

