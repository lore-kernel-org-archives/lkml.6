Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EC220855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXRqBVeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EC220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKISEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:04:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44807 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeKISEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:04:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so541993pgs.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LemySw+6VGiamWvqm4d+lqoRj+4VmarF9XYWRMSCiY0=;
        b=kXRqBVeNEZdfgT3ytQbgbNo0uRTe3Xsc6d3oPkkEZhjcWlI18sIckVu6vbliNO90tc
         olUj5T/CnTthMuYB9ChqlAk12gsPARZ7DmsTtDZXCLYlzQAffFO20/PQnFgJJl2kYV6j
         5FpNkBRpuQUMncbBrRoIectbjBfuwZzMPWSr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LemySw+6VGiamWvqm4d+lqoRj+4VmarF9XYWRMSCiY0=;
        b=oUxcsI+KmWEq7xTeq8p/XjvIOpU85WqFkdqFlwzBQ0IoMwNJ9E7NuU0Ab2RIAsP1nA
         nGNqqP8L9dl2wxXBSL+9AvDUQgIoxA1qIKamEyATwDsqyL1Mpj+BOVNTz0k0lPG1ScWr
         6Way69CCYSQzPHfrDXbETRa7MpI8wVn6J/fKa9AqDxwAWqLJEqN3PqBvG1rfz/S8pZsm
         xCsKLjAPAeDJxma82SoC5K1bDCuh3NvCauUl0oKRtTOLHEy2AHI0aFSVx/u1n4J1x4Gs
         cJzoDbzssCAeQcp8ldmSWTcGSRJFFutUzh3qSpW1ZcgvKHvLYonlJNOAP0Igy4CASqNW
         oXrQ==
X-Gm-Message-State: AGRZ1gJGlK8C9UuEjtmWgxSKonRc1LMc8zbFHoSXyTf5wKcY6ml+U2gT
        MFzLCT5weJzZLUdc10EROSEnvQ==
X-Google-Smtp-Source: AJdET5eNDtelDWete20VE7bb/tq+ntm0saZaFjUUpOGpXNsrDwjhGsWR0JG3+RHsaoUhprmNgBhOCQ==
X-Received: by 2002:a62:7514:: with SMTP id q20-v6mr8165586pfc.8.1541751906702;
        Fri, 09 Nov 2018 00:25:06 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id u2-v6sm6415667pfn.50.2018.11.09.00.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:25:06 -0800 (PST)
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
Subject: [PATCH RFC 2/3] include/linux/gfp.h: Add __get_dma32_pages macro
Date:   Fri,  9 Nov 2018 16:24:47 +0800
Message-Id: <20181109082448.150302-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181109082448.150302-1-drinkcat@chromium.org>
References: <20181109082448.150302-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some callers (e.g. iommu/io-pgtable-arm-v7s) require DMA32 memory
when calling __get_dma_pages. Add a new macro for that purpose.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 include/linux/gfp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 76f8db0b0e715c..50e04896b78017 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -535,6 +535,8 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
 
 #define __get_dma_pages(gfp_mask, order) \
 		__get_free_pages((gfp_mask) | GFP_DMA, (order))
+#define __get_dma32_pages(gfp_mask, order) \
+		__get_free_pages((gfp_mask) | GFP_DMA32, (order))
 
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
-- 
2.19.1.930.g4563a0d9d0-goog

