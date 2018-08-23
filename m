Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B88AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E215B2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E215B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeHWMLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:11:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbeHWMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:11:00 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E71637F6;
        Thu, 23 Aug 2018 08:42:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 063/324] arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag
Date:   Thu, 23 Aug 2018 09:52:09 +0200
Message-Id: <20180823074959.037695585@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit dd65a941f6ba473a5cb9d013d57fa43b48450a04 ]

dma_alloc_*() buffers might be exposed to userspace via mmap() call, so
they should be cleared on allocation. In case of IOMMU-based dma-mapping
implementation such buffer clearing was missing in the code path for
DMA_ATTR_FORCE_CONTIGUOUS flag handling, because dma_alloc_from_contiguous()
doesn't honor __GFP_ZERO flag. This patch fixes this issue. For more
information on clearing buffers allocated by dma_alloc_* functions,
see commit 6829e274a623 ("arm64: dma-mapping: always clear allocated
buffers").

Fixes: 44176bb38fa4 ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/dma-mapping.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -588,13 +588,14 @@ static void *__iommu_alloc_attrs(struct
 						    size >> PAGE_SHIFT);
 			return NULL;
 		}
-		if (!coherent)
-			__dma_flush_area(page_to_virt(page), iosize);
-
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
 						   prot,
 						   __builtin_return_address(0));
-		if (!addr) {
+		if (addr) {
+			memset(addr, 0, size);
+			if (!coherent)
+				__dma_flush_area(page_to_virt(page), iosize);
+		} else {
 			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
 			dma_release_from_contiguous(dev, page,
 						    size >> PAGE_SHIFT);


