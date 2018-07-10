Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A349C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76D620A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76D620A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbeGJSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:42 -0400
Received: from foss.arm.com ([217.140.101.70]:51800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732681AbeGJSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 044811713;
        Tue, 10 Jul 2018 10:17:39 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 751F63F589;
        Tue, 10 Jul 2018 10:17:36 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
Subject: [RFC PATCH 4/4] iommu/dma: Respect bus DMA limit for IOVAs
Date:   Tue, 10 Jul 2018 18:17:19 +0100
Message-Id: <2c0d7437ee7ccdd58da25faa283bd3c3148b961b.1531239284.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1.dirty
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the new bus limit into account (when present) for IOVA allocations,
to accommodate those SoCs which integrate off-the-shelf IP blocks with
narrower interconnects such that the link between a device output and an
IOMMU input can truncate DMA addresses to even fewer bits than the
native size of either block's interface would imply.

Eventually it might make sense for the DMA core to apply this constraint
up-front in dma_set_mask() and friends, but for now this seems like the
least risky approach.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ddcbbdb5d658..511ff9a1d6d9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -367,6 +367,9 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
+	if (dev->bus_dma_mask)
+		dma_limit &= dev->bus_dma_mask;
+
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
 
-- 
2.17.1.dirty

