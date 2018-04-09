Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754929AbeDIUKS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:10:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37928 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754680AbeDIUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:07:38 -0400
X-Google-Smtp-Source: AIpwx48xx5weCCdS9WALoogwz861dQ1/rn5K/qFPhI7U7OI6WPhXXZWIxSS2o4NkPAtRTJEEqTdEkA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] iommu/tegra: gart: Fix gart_iommu_unmap()
Date: Mon,  9 Apr 2018 23:07:20 +0300
Message-Id: <dd25a9ff7bad7c92b345c0c0ce2bf235c4c3b6e8.1523304324.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
In-Reply-To: <cover.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It must return the number of unmapped bytes on success, returning 0 means
that unmapping failed and in result only one page is unmapped.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 4c0abdcd1ad2..89ec24c6952c 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -313,7 +313,7 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	gart_set_pte(gart, iova, 0);
 	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
-	return 0;
+	return bytes;
 }
 
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.16.3
