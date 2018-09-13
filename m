Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32202C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E904920869
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E904920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeIMU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:27:25 -0400
Received: from sauhun.de ([88.99.104.3]:38928 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbeIMU1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:27:24 -0400
Received: from localhost (p54B3335A.dip0.t-ipconnect.de [84.179.51.90])
        by pokefinder.org (Postfix) with ESMTPSA id 8D4D62CF689;
        Thu, 13 Sep 2018 17:17:25 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/3] dma-mapping: clear dma_ops pointer also on ARM
Date:   Thu, 13 Sep 2018 17:17:15 +0200
Message-Id: <20180913151716.6333-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic fallback of arch_teardown_dma_ops() clears the dma_ops
pointer but the ARM specific version does not. Rename the generic one,
so it can be called from ARM specific one, too. This will ensure
consistent behaviour.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mm/dma-mapping.c   | 6 +++---
 include/linux/dma-mapping.h | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e3b04786838f..466b0242e8af 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2396,8 +2396,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 void arch_teardown_dma_ops(struct device *dev)
 {
-	if (!dev->archdata.dma_ops_setup)
-		return;
+	if (dev->archdata.dma_ops_setup)
+		arm_teardown_iommu_dma_ops(dev);
 
-	arm_teardown_iommu_dma_ops(dev);
+	generic_teardown_dma_ops(dev);
 }
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eafd6f318e78..020512cb7f0e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -663,11 +663,12 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 				      bool coherent) { }
 #endif
 
-#ifndef arch_teardown_dma_ops
-static inline void arch_teardown_dma_ops(struct device *dev)
+static inline void generic_teardown_dma_ops(struct device *dev)
 {
 	dev->dma_ops = NULL;
 }
+#ifndef arch_teardown_dma_ops
+#define arch_teardown_dma_ops generic_teardown_dma_ops
 #endif
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
-- 
2.18.0

