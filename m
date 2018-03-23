Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeCWHjr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:39:47 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:40214 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeCWHjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:39:44 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <f6b0b05c998eae6d1fb44c3808d0e36e>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 06/14] iommu/rockchip: Fix TLB flush of secondary IOMMUs
Date: Fri, 23 Mar 2018 15:38:06 +0800
Message-Id: <20180323073814.5802-7-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
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

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 7130d92ff79c..c3df53e480ea 100644
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
