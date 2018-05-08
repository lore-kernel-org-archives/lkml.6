Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933144AbeEHQ4g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:56:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41925 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeEHQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:56:34 -0400
X-Google-Smtp-Source: AB8JxZoLcNb1pneSVulpgxmP8t6FPMKcOiO7cZAGP+eX/1DFcx0tBU+YAxqvprLCBKHzVuPHBLCiHw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] memory: tegra: Register SMMU after MC driver became ready
Date: Tue,  8 May 2018 19:55:30 +0300
Message-Id: <20180508165530.12746-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Controller driver invokes SMMU driver registration and MC's
registers mapping is shared with SMMU. This mapping goes away if MC
driver probing fails after SMMU registration.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 49dd7ad1459f..22ec959db7d3 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -692,15 +692,6 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
-		mc->smmu = tegra_smmu_probe(&pdev->dev, mc->soc->smmu, mc);
-		if (IS_ERR(mc->smmu)) {
-			dev_err(&pdev->dev, "failed to probe SMMU: %ld\n",
-				PTR_ERR(mc->smmu));
-			return PTR_ERR(mc->smmu);
-		}
-	}
-
 	err = tegra_mc_reset_setup(mc);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register reset controller: %d\n",
@@ -726,6 +717,15 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
+		mc->smmu = tegra_smmu_probe(&pdev->dev, mc->soc->smmu, mc);
+		if (IS_ERR(mc->smmu)) {
+			dev_err(&pdev->dev, "failed to probe SMMU: %ld\n",
+				PTR_ERR(mc->smmu));
+			return PTR_ERR(mc->smmu);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.0
