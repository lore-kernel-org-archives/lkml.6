Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967485AbeCAKJy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:09:54 -0500
Received: from regular1.263xmail.com ([211.150.99.135]:40062 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967458AbeCAKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:09:44 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <1d32aac5d6e0eda2fef5ec46d1bc1463>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 06/14] iommu/rockchip: Fix TLB flush of secondary IOMMUs
Date: Thu,  1 Mar 2018 18:08:16 +0800
Message-Id: <20180301100824.14887-7-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180301100824.14887-1-jeffy.chen@rock-chips.com>
References: <20180301100824.14887-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

Due to the bug in current code, only first IOMMU has the TLB lines
flushed in rk_iommu_zap_lines. This patch fixes the inner loop to
execute for all IOMMUs and properly flush the TLB.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index baba283ccdf9..c4131ca792e0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -274,19 +274,21 @@ static void rk_iommu_base_command(void __iomem *base, u32 command)
 {
 	writel(command, base + RK_MMU_COMMAND);
 }
-static void rk_iommu_zap_lines(struct rk_iommu *iommu, dma_addr_t iova,
+static void rk_iommu_zap_lines(struct rk_iommu *iommu, dma_addr_t iova_start,
 			       size_t size)
 {
 	int i;
-
-	dma_addr_t iova_end = iova + size;
+	dma_addr_t iova_end = iova_start + size;
 	/*
 	 * TODO(djkurtz): Figure out when it is more efficient to shootdown the
 	 * entire iotlb rather than iterate over individual iovas.
 	 */
-	for (i = 0; i < iommu->num_mmu; i++)
-		for (; iova < iova_end; iova += SPAGE_SIZE)
+	for (i = 0; i < iommu->num_mmu; i++) {
+		dma_addr_t iova;
+
+		for (iova = iova_start; iova < iova_end; iova += SPAGE_SIZE)
 			rk_iommu_write(iommu->bases[i], RK_MMU_ZAP_ONE_LINE, iova);
+	}
 }
 
 static bool rk_iommu_is_stall_active(struct rk_iommu *iommu)
-- 
2.11.0
