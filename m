Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D990C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF842145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c46N+e8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF842145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeJBEdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:33:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43814 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBEdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:33:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id p24-v6so1706786pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=howekSrmgG4AxgJ1rlVvouHPAbphA2MJoweP7iWhifY=;
        b=c46N+e8yNnU4KBxJxd8qFBNRlux5YZXfwc0kFlcNgy0V/OuJ5IEf3js3UudfkyM53I
         2U1XTe6HOYKHDwx8oT4C3YT6x9RLTujbyPjFxA1g9YOAzRZ7WjjGTBcPR1YqjbBCooXm
         xe8LBsWD7e6W+Pr/4I8iGmUxfmg8+Luui9f+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=howekSrmgG4AxgJ1rlVvouHPAbphA2MJoweP7iWhifY=;
        b=hRwFC3cGBggoPaUXA6AtsbEt/xo3Ymc8T2v+npeFXrynrAKaxD7hzc/kI6vX1tB7Jv
         y9cxtONTOm7m6nRD5qr8DVgjEBmIT6QdEsbaau9LeGumMahnVBvlK4jisX3m2/vH9oLE
         AVSHY2CjjNIM+j5a/Hpqfbog3XqQRPn7f8dw9TvpktcmBlfhMeaXANXpgzh++mNJuz/o
         X9Nrksljs0r/wMuIsPmW3ED4zn80337FxXoAnT5nqJ1sfB4Rumm3f5pBs3ztsww/+rCD
         ae7sQNOsCMms1kt3klhRewCmvxj/bs1aJ4Bkvg176VMR+LNM7DaC1OelJ9dwnf3AE3tr
         n6dA==
X-Gm-Message-State: ABuFfoiHM2UE/HtjYTrJAbjZzSCzS4qbW8zgSOUf9pMgG9aQchpC6HS+
        WZ+ZCjiAbnrL5A7Gzq4e8F1LvQ==
X-Google-Smtp-Source: ACcGV60MmIVKXAnT86A6qe+zYJkrCfC0tK1ek14YaoLQzupol9WOzPhJiR/eUtniQ9ix48JenSu1kg==
X-Received: by 2002:a17:902:ea:: with SMTP id a97-v6mr11747553pla.164.1538430818517;
        Mon, 01 Oct 2018 14:53:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id x17-v6sm6726949pfn.59.2018.10.01.14.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:53:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] dma-debug: Check for drivers mapping invalid addresses in dma_map_single()
Date:   Mon,  1 Oct 2018 14:53:37 -0700
Message-Id: <20181001215337.13358-1-swboyd@chromium.org>
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
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

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
index d23fc45c8208..99ccba66c06a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -231,6 +231,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_check_single(dev, ptr, size);
 	addr = ops->map_page(dev, virt_to_page(ptr),
 			     offset_in_page(ptr), size,
 			     dir, attrs);
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index c007d25bee09..0f34bce82a62 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1312,6 +1312,22 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 #endif
 }
 
+void debug_dma_check_single(struct device *dev, const void *addr,
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
+EXPORT_SYMBOL(debug_dma_check_single);
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
-- 
Sent by a computer through tubes

