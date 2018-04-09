Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeDIUHm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:07:42 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46342 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754664AbeDIUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:07:37 -0400
X-Google-Smtp-Source: AIpwx48uw1dF3Ku9krx/LUm/VUvwglcUnxgqUNirovinsq4sCXNbXm/JOlHfcu0tAys4xgzEV6afLQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] iommu/tegra: gart: Add debugging facility
Date: Mon,  9 Apr 2018 23:07:19 +0300
Message-Id: <fe55521bc6fb1c576fb532dd7fb64ede4904beb7.1523304324.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
In-Reply-To: <cover.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page mapping could overwritten by an accident (a bug). We can catch this
case by checking 'VALID' bit of GART's page entry prior to mapping of a
page. Since that check introduces a small performance impact, it should be
enabled explicitly using new GART's kernel module 'debug' parameter.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index b62f790ad1ba..4c0abdcd1ad2 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -72,6 +72,8 @@ struct gart_domain {
 
 static struct gart_device *gart_handle; /* unique for a system */
 
+static bool gart_debug;
+
 #define GART_PTE(_pfn)						\
 	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
 
@@ -271,6 +273,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	struct gart_device *gart = gart_domain->gart;
 	unsigned long flags;
 	unsigned long pfn;
+	unsigned long pte;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
 		return -EINVAL;
@@ -282,6 +285,14 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
+	if (gart_debug) {
+		pte = gart_read_pte(gart, iova);
+		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
+			spin_unlock_irqrestore(&gart->pte_lock, flags);
+			dev_err(gart->dev, "Page entry is in-use\n");
+			return -EBUSY;
+		}
+	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
 	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
@@ -515,7 +526,9 @@ static void __exit tegra_gart_exit(void)
 
 subsys_initcall(tegra_gart_init);
 module_exit(tegra_gart_exit);
+module_param(gart_debug, bool, 0644);
 
+MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
 MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
 MODULE_ALIAS("platform:tegra-gart");
-- 
2.16.3
