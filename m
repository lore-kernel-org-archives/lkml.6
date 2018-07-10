Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD45C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63738208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PIqsDSQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63738208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbeGJXXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:23:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42882 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbeGJXXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:23:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id f4-v6so4082680plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=I2kUohMk8SFcBQufu6jJcr21DeEh/t+g5PZT04KotRw=;
        b=PIqsDSQwYw0Ra/HDW4FCCHnWxHni96gMMDxl4PHssU6z58ERevdVl8L7LlyKU2uZlf
         epd+Y52xhTELxp96tImGL5ccUq8vJiY9lMiW0fHF73jxmmvQaJpk//rhbMYfx7p+ZTqU
         tOKsdiBjU+H27aUemvOuEIX78j9ccgXlCbljg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I2kUohMk8SFcBQufu6jJcr21DeEh/t+g5PZT04KotRw=;
        b=jbyXnuE63aDeNSwuoI8rF1ksvPnLc3o9IPMI9toqLRlra4oai4f2DsSo1OKa/931BF
         rQZOViWRZJmm16/JEyYLSbvqDJFZj8ryUINm/KWf3xNPtlwgwb/bLlMsSUsXutq3unci
         3mk8t8BzepXtfd+xUE97jRkiBAq07M/ikp4yVLb96T4jw1HpSOPbzBUdXk8FrJSyWmLg
         DpVXY2ST5EO20OsJhA0HcK99Tme0CwwNeJcMJ2ZXIKwx99knjd2qgljT655YLMFSJO+j
         W6NoChC35a9KXx0+YxwR2jsNTXddMZItj/zaGTreYKDk3cF05mRtSlfh4IHIyRuI+UYj
         enBA==
X-Gm-Message-State: APt69E2aSenMDxh5FyutjyR/WiSZUx62J7xVDHXs9tbhjPKNX85LkmEJ
        p19jzwDBeKQvFoBfC8xsCN47qQ==
X-Google-Smtp-Source: AAOMgpe/iIt3hSQf2sqd3lZXZupPODgC14GIhmFm6o3Hl9dGjaVu31DGspIR3rJJY4iPkJ1Vz/Md7g==
X-Received: by 2002:a17:902:bf0b:: with SMTP id bi11-v6mr25898638plb.25.1531264945328;
        Tue, 10 Jul 2018 16:22:25 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p11-v6sm24172648pfj.72.2018.07.10.16.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 16:22:23 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:22:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH] swiotlb: Clean up reporting
Message-ID: <20180710232222.GA32002@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes needless use of '%p', and refactors the printk calls to
use pr_*() helpers instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/dma/swiotlb.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 904541055792..4f8a6dbf0b60 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -17,6 +17,8 @@
  * 08/12/11 beckyb	Add highmem support
  */
 
+#define pr_fmt(fmt) "software IO TLB: " fmt
+
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
 #include <linux/mm.h>
@@ -162,20 +164,16 @@ static bool no_iotlb_memory;
 void swiotlb_print_info(void)
 {
 	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
-	unsigned char *vstart, *vend;
 
 	if (no_iotlb_memory) {
-		pr_warn("software IO TLB: No low mem\n");
+		pr_warn("No low mem\n");
 		return;
 	}
 
-	vstart = phys_to_virt(io_tlb_start);
-	vend = phys_to_virt(io_tlb_end);
-
-	printk(KERN_INFO "software IO TLB [mem %#010llx-%#010llx] (%luMB) mapped at [%p-%p]\n",
+	pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
 	       (unsigned long long)io_tlb_start,
 	       (unsigned long long)io_tlb_end,
-	       bytes >> 20, vstart, vend - 1);
+	       bytes >> 20);
 }
 
 /*
@@ -275,7 +273,7 @@ swiotlb_init(int verbose)
 	if (io_tlb_start)
 		memblock_free_early(io_tlb_start,
 				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
-	pr_warn("Cannot allocate SWIOTLB buffer");
+	pr_warn("Cannot allocate buffer");
 	no_iotlb_memory = true;
 }
 
@@ -317,8 +315,8 @@ swiotlb_late_init_with_default_size(size_t default_size)
 		return -ENOMEM;
 	}
 	if (order != get_order(bytes)) {
-		printk(KERN_WARNING "Warning: only able to allocate %ld MB "
-		       "for software IO TLB\n", (PAGE_SIZE << order) >> 20);
+		pr_warn("only able to allocate %ld MB\n",
+			(PAGE_SIZE << order) >> 20);
 		io_tlb_nslabs = SLABS_PER_PAGE << order;
 	}
 	rc = swiotlb_late_init_with_tbl(vstart, io_tlb_nslabs);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
