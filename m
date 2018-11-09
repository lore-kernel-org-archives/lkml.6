Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484B220892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iur53HJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484B220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeKISEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:04:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38738 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeKISEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:04:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so553341pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRFndY2zWJb5bN9k8QGyB+00poAzGsSVjzJBS2+e7OE=;
        b=Iur53HJyqMem/YVgQlfnZkpmkDpU75IDHa1psWcirqFy2J7OUTJYecd2nH/Tm1VU4Y
         wHD0Wj4ikT4n1v9ophkIXv8eHbTkqamS77yub3whxQJ3ALJ5ShBRCmalyGimLeM0OTKZ
         KD55YMwDGgVT3dwjemx/XmpVCxgR0pphrkUVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRFndY2zWJb5bN9k8QGyB+00poAzGsSVjzJBS2+e7OE=;
        b=pb92zYKZeRhCvWKCr/xwW2ro4Fos5LK+YzjsNI2mtw3i9MPuOa94RmlDfLlUwQQMGh
         VsX4pSNcdrlom1d59yokTVS0KQrUhd6ns+HzmDfT0N+1hgUklQp3lMervjNCJNhpO7KM
         UEwRmR6D+bt4g6wp/80J/XUF3Kl7FiSw09AheawB6osaj11LzLbbbWRZ6WCCj14+Fh0E
         2sIVWGpgbXL5a3dCdDZEg4oilKSrAHBRkxo3L4/mJ6O7+pdxWIt/jZ4qz/QCnKviCVva
         28TmLWHRNeKYKWtMOLrcfYfwuZXIrG/fb2voBb7jTlWI62z6N5hQBYngaqo0vbpxs01M
         X3fQ==
X-Gm-Message-State: AGRZ1gKRWFR0YbseZbZ7g4NlT1sVyD6sdfL9L9R6W9jOP1wBsbXZyDbj
        +NNcZVIxDLqdtcAmXy12EssmcA==
X-Google-Smtp-Source: AJdET5dCO8mv60sae7fHIDtGCVEJeKFEfFmKIeaExlKA/10SNZoPYXI7O9H3owoxai+S1I+fmnLhmg==
X-Received: by 2002:a63:6984:: with SMTP id e126mr6756085pgc.143.1541751910462;
        Fri, 09 Nov 2018 00:25:10 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id u2-v6sm6415667pfn.50.2018.11.09.00.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:25:09 -0800 (PST)
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
        Levin Alexander <alexander.levin@verizon.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: [PATCH RFC 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
Date:   Fri,  9 Nov 2018 16:24:48 +0800
Message-Id: <20181109082448.150302-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181109082448.150302-1-drinkcat@chromium.org>
References: <20181109082448.150302-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For level 1 pages, use __get_dma32_pages to make sure physical
memory address is 32-bit.

For level 2 pages, kmem_cache_zalloc with GFP_DMA has been modified
in a previous patch to be allocated in DMA32 zone.

Also, print an error when the physical address does not fit in
32-bit, to make debugging easier in the future.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..862fd404de84d8 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -198,13 +198,15 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	void *table = NULL;
 
 	if (lvl == 1)
-		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
+		table = (void *)__get_dma32_pages(__GFP_ZERO, get_order(size));
 	else if (lvl == 2)
 		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
 	phys = virt_to_phys(table);
-	if (phys != (arm_v7s_iopte)phys)
+	if (phys != (arm_v7s_iopte)phys) {
 		/* Doesn't fit in PTE */
+		dev_err(dev, "Page table does not fit: %pa", &phys);
 		goto out_free;
+	}
 	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
-- 
2.19.1.930.g4563a0d9d0-goog

