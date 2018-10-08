Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCB4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEDF20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BvxLuz8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEDF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJHOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:30:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44883 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:30:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id p25-v6so9648273pli.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YzBFuo9bQ0yLc38yXCkV7E6WiCswAQqgt9wztWARtBg=;
        b=BvxLuz8oAM/55vygijBi4UVi+RwAlEDQYDEjcIfGz7Ehdz9kgYj1rMi7/QasdzM5lb
         JQjGB0C4kvA3fZaDni33b5U0Ji74LnfKYSVmZh0Ea/HZhehNP9AsJnk4pDEU7ZQ1yt2P
         om6mxMGP2CD3r+5r/I/GjB/y6UM+C3S/ehMPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YzBFuo9bQ0yLc38yXCkV7E6WiCswAQqgt9wztWARtBg=;
        b=d1m4rkuUCeVRiwDkkMuNPkXRQty8Sz87olf2L0msgFzRXlevaCz3XyxfQHOF4PL0jo
         wavq29gNoEYRGOyFLAXQuuDOnB2MKgeUJCNUNibGWF6sMy4Aq2h1dNULRrHsXca1eTjt
         AKtYC53PWn00x1oev5sRDHTGsD10MfdNEx8xim6DZUAge4mLGtXpkFqDjt9ItSEh4NNI
         ZQo/3C5RIl2FYj6mAAKTxZxpbttWqrSbRrF1DqCZLcgb2NQAobMtSnLG75TUYkex23Jw
         RCAprj60p1bk+CZRl96C9F220UuwWqYVADIRtvMJuvLK63cwsdfQpSGjweiEvwMAw9Zu
         QKTQ==
X-Gm-Message-State: ABuFfojMjgWEMkg7qbiBFAyoMf8zQbJKPp2/GVyXl7WrfyGVv8+FVICq
        cfY0pH2vG8ohCRhoLuvt217UuA==
X-Google-Smtp-Source: ACcGV63fez0iJaa8ZosXgd2OpO47lxMJPeEHq2b+XFTGWDNVIDvgkVaUZWPvodmRm+AUWM51K/3ASw==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4-v6mr22451308plp.247.1538983209354;
        Mon, 08 Oct 2018 00:20:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id z14-v6sm25204871pfi.4.2018.10.08.00.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 00:20:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] dma-debug: Check for drivers mapping invalid addresses in dma_map_single()
Date:   Mon,  8 Oct 2018 00:20:07 -0700
Message-Id: <20181008072007.26387-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
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
DMA debug function to check for a vmalloc address or an invalid virtual
address and print a warning if this happens. This makes it a little
easier to debug these sorts of problems, instead of seeing odd behavior
or crashes when drivers attempt to map the vmalloc space for DMA.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2:
 * Rename function properly and actually test it!
 * Add Robin's reviewed-by tag

Changes from v1:                                                                                                                    
 * Update code to check for invalid virtual address too                                                                             
 * Rename function to debug_dma_map_single()    

 include/linux/dma-debug.h   |  8 ++++++++
 include/linux/dma-mapping.h |  1 +
 kernel/dma/debug.c          | 16 ++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index a785f2507159..30213adbb6b9 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -32,6 +32,9 @@ extern void dma_debug_add_bus(struct bus_type *bus);
 
 extern int dma_debug_resize_entries(u32 num_entries);
 
+extern void debug_dma_map_single(struct device *dev, const void *addr,
+				 unsigned long len);
+
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr,
@@ -103,6 +106,11 @@ static inline int dma_debug_resize_entries(u32 num_entries)
 	return 0;
 }
 
+static inline void debug_dma_map_single(struct device *dev, const void *addr,
+					unsigned long len)
+{
+}
+
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 562af6b45f23..547a48bcfa3d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -229,6 +229,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_map_single(dev, ptr, size);
 	addr = ops->map_page(dev, virt_to_page(ptr),
 			     offset_in_page(ptr), size,
 			     dir, attrs);
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index c007d25bee09..231ca4628062 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1312,6 +1312,22 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 #endif
 }
 
+void debug_dma_map_single(struct device *dev, const void *addr,
+			    unsigned long len)
+{
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	if (!virt_addr_valid(addr))
+		err_printk(dev, NULL, "DMA-API: device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
+			   addr, len);
+
+	if (is_vmalloc_addr(addr))
+		err_printk(dev, NULL, "DMA-API: device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
+			   addr, len);
+}
+EXPORT_SYMBOL(debug_dma_map_single);
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
-- 
Sent by a computer through tubes

