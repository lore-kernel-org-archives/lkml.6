Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA73ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7328621533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YkFt4jlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7328621533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeIUEVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:21:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34247 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeIUEVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:21:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so5100967pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoOEUWeRVPHs3MeL0Ayx/Ozq2NR2V3uIeTrMEEIQGk4=;
        b=YkFt4jlUqHNgagOPU+/6e303ZRkMIlOxPdjSdqDNZtb9OQ/Kgg7Nh1/IYYkIKEU47i
         pb+Qq7NKmuT0tVbIAoUtz2WzLKJEKVRrH9jvai2fEQSRktt+M+FXx2Ryn3RKqwHUF9MS
         ExWc36ZpSOGr7F2G9+wCQ+3JUgm+ouRAJR/pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoOEUWeRVPHs3MeL0Ayx/Ozq2NR2V3uIeTrMEEIQGk4=;
        b=nRFIeC+QSl5hTUMlUaNPORiYM3C9S82AvzPfvmbCB9J1BQFTdOlKkwKfpYtWj0aXZf
         QvWrVrle748uz7zdnS/KZHdDO4kNW/jLc6Ygrd+9gFOM00uqTxItt87kUkWkdeKrCjbH
         kM7THYvO7TeQAVi39to/XxWBz3iM/3+CovWniSO/Th28IX9zntMH+AyXgd2u4zGTJwAh
         jU4mjg922uvi7GQTynjI7Q6u1OPoEOeC/RAxCBrx7E69GETYAS1pNNavJrxB3u/eSilT
         sYnfxvMun8vSFlHWbRedC7FbeBswWllp2JsqEAiVoXYDEv+vduVOUK+keuY8TKG161eb
         nr4Q==
X-Gm-Message-State: APzg51DovLrikBssevu0O70ZiTLUrH6peFWfw86iiEg2rilXM65P6G43
        LOXjeX06H9DuGYorCRp+HOXBjA==
X-Google-Smtp-Source: ANB0VdabfL1Nu3RZayCABpUj6h3mXbUkddYQ391uYIYDW/SScWP4EAsqxD5O2M1fN/7NyJWUvzjNOw==
X-Received: by 2002:a63:9809:: with SMTP id q9-v6mr38047883pgd.58.1537482961822;
        Thu, 20 Sep 2018 15:36:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id f87-v6sm61430740pfh.168.2018.09.20.15.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:36:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date:   Thu, 20 Sep 2018 15:35:59 -0700
Message-Id: <20180920223559.136915-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently debugged a DMA mapping oops where a driver was trying to map
a buffer returned from request_firmware() with dma_map_single(). Memory
returned from request_firmware() is mapped into the vmalloc region and
this isn't a valid region to map with dma_map_single() per the DMA
documentation's "What memory is DMA'able?" section.

Unfortunately, we don't really check that in the DMA debugging code, so
enabling DMA debugging doesn't help catch this problem. Let's add a new
DMA debug function to check for a vmalloc address and print a warning if
this happens. This makes it a little easier to debug these sorts of
problems, instead of seeing odd behavior or crashes when drivers attempt
to map the vmalloc space for DMA.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/dma-debug.h   |  8 ++++++++
 include/linux/dma-mapping.h |  1 +
 kernel/dma/debug.c          | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index a785f2507159..5aec2ca8a426 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -32,6 +32,9 @@ extern void dma_debug_add_bus(struct bus_type *bus);
 
 extern int dma_debug_resize_entries(u32 num_entries);
 
+extern void debug_dma_check_vmalloc(struct device *dev, const void *addr,
+				    unsigned long len);
+
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr,
@@ -103,6 +106,11 @@ static inline int dma_debug_resize_entries(u32 num_entries)
 	return 0;
 }
 
+static inline void debug_dma_check_vmalloc(struct device *dev, const void *addr,
+					   unsigned long len)
+{
+}
+
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eafd6f318e78..a0e67fd5433c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -232,6 +232,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_check_vmalloc(dev, ptr, size);
 	addr = ops->map_page(dev, virt_to_page(ptr),
 			     offset_in_page(ptr), size,
 			     dir, attrs);
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index c007d25bee09..7ee7978868d4 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1312,6 +1312,18 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 #endif
 }
 
+void debug_dma_check_vmalloc(struct device *dev, const void *addr,
+		unsigned long len)
+{
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	if (is_vmalloc_addr(addr))
+		err_printk(dev, NULL, "DMA-API: device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
+			   addr, len);
+}
+EXPORT_SYMBOL(debug_dma_check_vmalloc);
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
-- 
Sent by a computer through tubes

