Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933559AbeEHSRi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:17:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46400 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933316AbeEHSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:30 -0400
X-Google-Smtp-Source: AB8JxZrs286w4Y/66mAhIDIdnDmg3qkism56JPnH1Pta5ViY42yVPNd5NxslKzhJFtSQ4xATo7hvuw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/9] iommu/tegra: gart: Provide access to Memory Controller driver
Date: Tue,  8 May 2018 21:16:53 +0300
Message-Id: <20180508181700.5169-3-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181700.5169-1-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART contains registers needed by the Memory Controller driver. Provide
access to the MC driver by utilizing its GART-integration facility.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 89ec24c6952c..de48943bf843 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -31,6 +31,8 @@
 #include <linux/iommu.h>
 #include <linux/of.h>
 
+#include <soc/tegra/mc.h>
+
 #include <asm/cacheflush.h>
 
 /* bitmap of the page sizes currently supported */
@@ -41,6 +43,8 @@
 #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
 #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
 #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
+#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
+#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
 
 #define GART_PAGE_SHIFT		12
 #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
@@ -63,6 +67,8 @@ struct gart_device {
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
+
+	struct tegra_mc_gart_handle mc_gart_handle;
 };
 
 struct gart_domain {
@@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
 	return 0;
 }
 
+static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
+{
+	struct gart_device *gart = container_of(handle, struct gart_device,
+						mc_gart_handle);
+	return readl(gart->regs + GART_ERROR_ADDR);
+}
+
+static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
+{
+	struct gart_device *gart = container_of(handle, struct gart_device,
+						mc_gart_handle);
+	return readl(gart->regs + GART_ERROR_REQ);
+}
+
 static int tegra_gart_probe(struct platform_device *pdev)
 {
 	struct gart_device *gart;
@@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->regs = gart_regs;
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
 	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
+	gart->mc_gart_handle.error_addr = tegra_gart_error_addr;
+	gart->mc_gart_handle.error_req = tegra_gart_error_req;
 
 	gart->savedata = vmalloc(sizeof(u32) * gart->page_count);
 	if (!gart->savedata) {
@@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	do_gart_setup(gart, NULL);
 
 	gart_handle = gart;
+	tegra_mc_register_gart(&gart->mc_gart_handle);
 
 	return 0;
 }
-- 
2.17.0
