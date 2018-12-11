Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1FA20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544522;
	bh=cfxshft87bTfge+GcU/hlGmYk7yiR3iUaLO6QQPAUXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k3G3KXAKBYnsqRt8gUldBin1NhmCI5iRkI0r9xWLMCxxRGy0iFhjvmeZEO10cWhb3
	 f24YC235Enl4TJz3/6VpY4nW6jN2bl4TsDk2QoW7sNbx2uynwxcxiYD1obGyEfyh4B
	 s2d1ixTFaf8RJnmGscSQT6hi+MHyVofSXuwIRVD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1FA20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeLKQIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbeLKPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C622146D;
        Tue, 11 Dec 2018 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543573;
        bh=cfxshft87bTfge+GcU/hlGmYk7yiR3iUaLO6QQPAUXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuLSR7zbQen9/3uPxGl4dzNRVNiR5htgmNLBZNESWt1QstkraOnedKsNNFvC481n1
         YPV7Ny9nef8szAfk4KfM/Gme1Wy++R648cxDroI07gIoRHWefEjYesE4s0VOx/q+B8
         iWDHH2hEosdRS+nv/l2OzcAPhA0K/wINtTI2jmUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 50/67] swiotlb: clean up reporting
Date:   Tue, 11 Dec 2018 16:41:50 +0100
Message-Id: <20181211151632.920510827@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 7d63fb3af87aa67aa7d24466e792f9d7c57d8e79 upstream.

This removes needless use of '%p', and refactors the printk calls to
use pr_*() helpers instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[bwh: Backported to 4.14:
 - Adjust filename
 - Remove "swiotlb: " prefix from an additional log message]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/swiotlb.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 20df2fd9b150..b4c768de3344 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -17,6 +17,8 @@
  * 08/12/11 beckyb	Add highmem support
  */
 
+#define pr_fmt(fmt) "software IO TLB: " fmt
+
 #include <linux/cache.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
@@ -177,20 +179,16 @@ static bool no_iotlb_memory;
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
@@ -290,7 +288,7 @@ swiotlb_init(int verbose)
 	if (io_tlb_start)
 		memblock_free_early(io_tlb_start,
 				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
-	pr_warn("Cannot allocate SWIOTLB buffer");
+	pr_warn("Cannot allocate buffer");
 	no_iotlb_memory = true;
 }
 
@@ -332,8 +330,8 @@ swiotlb_late_init_with_default_size(size_t default_size)
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
@@ -770,7 +768,7 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 
 err_warn:
 	if (warn && printk_ratelimit()) {
-		pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
+		pr_warn("coherent allocation failed for device %s size=%zu\n",
 			dev_name(hwdev), size);
 		dump_stack();
 	}
-- 
2.19.1



