Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB728C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FC92151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FC92151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeHXSma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:42:30 -0400
Received: from foss.arm.com ([217.140.101.70]:60068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeHXSm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:42:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15E071682;
        Fri, 24 Aug 2018 08:07:26 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.emea.arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91CA03F5BC;
        Fri, 24 Aug 2018 08:07:24 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
Subject: [PATCH v2 3/4] iommu/rockchip: Handle errors returned from PM framework
Date:   Fri, 24 Aug 2018 16:06:36 +0100
Message-Id: <20180824150637.15316-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824150637.15316-1-marc.zyngier@arm.com>
References: <20180824150637.15316-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_if_in_use can fail: either PM has been disabled
altogether (-EINVAL), or the device hasn't been enabled yet (0).
Sadly, the Rockchip IOMMU driver tends to conflate the two things
by considering a non-zero return value as successful.

This has the consequence of hiding other bugs, so let's handle this
case throughout the driver, with a WARN_ON_ONCE so that we can try
and work out what happened.

Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 054cd2c8e9c8..4e0f9b61cd7f 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -521,10 +521,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	u32 int_status;
 	dma_addr_t iova;
 	irqreturn_t ret = IRQ_NONE;
-	int i;
+	int i, err;
 
-	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
-		return 0;
+	err = pm_runtime_get_if_in_use(iommu->dev);
+	if (WARN_ON_ONCE(err <= 0))
+		return ret;
 
 	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
 		goto out;
@@ -620,11 +621,15 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_for_each(pos, &rk_domain->iommus) {
 		struct rk_iommu *iommu;
+		int ret;
 
 		iommu = list_entry(pos, struct rk_iommu, node);
 
 		/* Only zap TLBs of IOMMUs that are powered on. */
-		if (pm_runtime_get_if_in_use(iommu->dev)) {
+		ret = pm_runtime_get_if_in_use(iommu->dev);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+		if (ret) {
 			WARN_ON(clk_bulk_enable(iommu->num_clocks,
 						iommu->clocks));
 			rk_iommu_zap_lines(iommu, iova, size);
@@ -891,6 +896,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
+	int ret;
 
 	/* Allow 'virtual devices' (eg drm) to detach from domain */
 	iommu = rk_iommu_from_dev(dev);
@@ -909,7 +915,9 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	list_del_init(&iommu->node);
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
-	if (pm_runtime_get_if_in_use(iommu->dev)) {
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	WARN_ON_ONCE(ret < 0);
+	if (ret > 0) {
 		rk_iommu_disable(iommu);
 		pm_runtime_put(iommu->dev);
 	}
@@ -946,7 +954,8 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	list_add_tail(&iommu->node, &rk_domain->iommus);
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
-	if (!pm_runtime_get_if_in_use(iommu->dev))
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	if (!ret || WARN_ON_ONCE(ret < 0))
 		return 0;
 
 	ret = rk_iommu_enable(iommu);
-- 
2.18.0

