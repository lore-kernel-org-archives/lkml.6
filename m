Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E3FC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851CF20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfAUOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:52:24 -0500
Received: from foss.arm.com ([217.140.101.70]:35810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfAUOwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:52:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E438DEBD;
        Mon, 21 Jan 2019 06:52:23 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21C913F5C1;
        Mon, 21 Jan 2019 06:52:21 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, hch@lst.de, treding@nvidia.com,
        rmk+kernel@armlinux.org.uk, bskeggs@redhat.com,
        tjakobi@math.uni-bielefeld.de, b.zolnierkie@samsung.com
Subject: [PATCH] ARM: dma-mapping: Clear DMA ops on teardown
Date:   Mon, 21 Jan 2019 14:52:16 +0000
Message-Id: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Installing the appropriate non-IOMMU DMA ops in arm_iommu_detch_device()
serves the case where IOMMU-aware drivers choose to control their own
mapping but still make DMA API calls, however it also affects the case
when the arch code itself tears down the mapping upon driver unbinding,
where the ops now get left in place and can inhibit arch_setup_dma_ops()
on subsequent re-probe attempts.

Fix the latter case by making sure that arch_teardown_dma_ops() cleans
up whenever the ops were automatically installed by its counterpart.

Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Sorry for the delay - there was a giant email infrastructure cock-up just
at the point I wanted to go back through my archive and double-check the
discussion around the original commit...

Robin.

 arch/arm/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922e447c..1e3e08a1c456 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
 		return;
 
 	arm_teardown_iommu_dma_ops(dev);
+	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
+	set_dma_ops(dev, NULL);
 }
-- 
2.20.1.dirty

