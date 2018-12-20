Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29BAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A962176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299160;
	bh=PFSuxZ/dUvg2vkSJLYRcvarR/JM3wIZaHk8UJIS7dcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MihTE0v2Gz1U3PBVM8lbtbq4Y1sZUY4GdgriG6kvnOwRK2sT/ZlJQeuSTtmmMZSEn
	 +Mx8PRQ4ioaXsgPRG48AiqT/vVs6NcnrL9mYby+Wkx6zezKhpQrG7nW0MTtOLe4JFY
	 MkssGLVAD6PjeNcI40hSZdOx+XVw8dwrJa9kM98Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbeLTJp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbeLTJUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A221621773;
        Thu, 20 Dec 2018 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297631;
        bh=PFSuxZ/dUvg2vkSJLYRcvarR/JM3wIZaHk8UJIS7dcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dChE50/IBwxwOc0z/z6VQlsReKjV+xXcnS894f4697QYL2w5EOVOdcMWKdW32s4tz
         KEqWMT0rZw0ZaTzsuHoeCt0ldn3kWcfClSmSxqp3MtIW0KQy9UkybaUPjNfxySYdGO
         HItpbbXydsd+Dwts+BAgFij+rvklu17LBPhmFg38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 30/31] swiotlb: clean up reporting
Date:   Thu, 20 Dec 2018 10:18:42 +0100
Message-Id: <20181220085743.786731250@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 7d63fb3af87aa67aa7d24466e792f9d7c57d8e79 upstream.

This removes needless use of '%p', and refactors the printk calls to
use pr_*() helpers instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[bwh: Backported to 4.4:
 - Adjust filename
 - Remove "swiotlb: " prefix from an additional log message]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/swiotlb.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

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
@@ -143,20 +145,16 @@ static bool no_iotlb_memory;
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
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
@@ -230,7 +228,7 @@ swiotlb_init(int verbose)
 	if (io_tlb_start)
 		memblock_free_early(io_tlb_start,
 				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
-	pr_warn("Cannot allocate SWIOTLB buffer");
+	pr_warn("Cannot allocate buffer");
 	no_iotlb_memory = true;
 }
 
@@ -272,8 +270,8 @@ swiotlb_late_init_with_default_size(size
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


