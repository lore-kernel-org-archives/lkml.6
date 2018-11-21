Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F11C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73A22145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73A22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeKVCgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:36:00 -0500
Received: from foss.arm.com ([217.140.101.70]:53628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbeKVCf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:35:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33BA53610;
        Wed, 21 Nov 2018 08:00:58 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE97A3F5CF;
        Wed, 21 Nov 2018 08:00:56 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad.wilk@oracle.com
Cc:     m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sstabellini@kernel.org
Subject: [PATCH v2 1/2] dma-direct: Make DIRECT_MAPPING_ERROR viable for SWIOTLB
Date:   Wed, 21 Nov 2018 16:00:50 +0000
Message-Id: <0b969e82ff750c50587550c55cb46c4025d35f39.1542812807.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1542812807.git.robin.murphy@arm.com>
References: <cover.1542812807.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the overflow buffer removed, we no longer have a unique address
which is guaranteed not to be a valid DMA target to use as an error
token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
an unlikely DMA target, but unfortunately there are already SWIOTLB
users with DMA-able memory at physical address 0 which now gets falsely
treated as a mapping failure and leads to all manner of misbehaviour.

The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
other commonly-used error value of all-bits-set, since the last single
byte of memory is by far the least-likely-valid DMA target.

Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")
Reported-by: John Stultz <john.stultz@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Add parentheses, tweak commit message, collect tags

 include/linux/dma-direct.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index bd73e7a91410..9e66bfe369aa 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -5,7 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mem_encrypt.h>
 
-#define DIRECT_MAPPING_ERROR		0
+#define DIRECT_MAPPING_ERROR		(~(dma_addr_t)0)
 
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
-- 
2.19.1.dirty

