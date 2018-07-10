Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DA320A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DA320A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbeGJSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:43:40 -0400
Received: from foss.arm.com ([217.140.101.70]:51808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389003AbeGJSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3549F16A3;
        Tue, 10 Jul 2018 10:17:36 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A66E93F589;
        Tue, 10 Jul 2018 10:17:33 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
Subject: [RFC PATCH 3/4] of/device: Set bus DMA mask as appropriate
Date:   Tue, 10 Jul 2018 18:17:18 +0100
Message-Id: <346c004b599fb77a2006a4eeb992b30feb06fce5.1531239284.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1.dirty
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an explicit DMA limit is described by firmware, we need to remember
it regardless of how drivers might subsequently update their devices'
masks. The new bus_dma_mask field does that.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 33d85511d790..0d39633e8545 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,6 +149,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
+	dev->bus_dma_mask = mask;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 
-- 
2.17.1.dirty

