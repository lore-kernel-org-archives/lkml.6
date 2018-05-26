Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031769AbeEZOVF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 10:21:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42330 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeEZOVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 10:21:04 -0400
X-Google-Smtp-Source: AB8JxZpjy9KxOXlKqKc03dRa4wWAeISS4FlYYCn0YnAEm/3ln1t6qQ4AR6Hs07zP00pUcA5U00nh+Q==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] memory: tegra: Correct driver probe order
Date: Sat, 26 May 2018 17:20:35 +0300
Message-Id: <20180526142035.21741-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Reset Controller should be registered in the end of probe, otherwise
Memory Controller device goes away if IRQ requesting fails and the Reset
Controller stays registered. To avoid having to unwind the MC probing in
a case of SMMU probe failure, let's simply print the error message without
failing the MC probe. This allows us to just move the Reset Controller
registering before the SMMU registration, reducing code churning. Also
let's not fail MC probe in a case of Reset Controller registration failure
as it doesn't prevent the MC driver to work.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 22ec959db7d3..8ef95e34b5c7 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -692,13 +692,6 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = tegra_mc_reset_setup(mc);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to register reset controller: %d\n",
-			err);
-		return err;
-	}
-
 	mc->irq = platform_get_irq(pdev, 0);
 	if (mc->irq < 0) {
 		dev_err(&pdev->dev, "interrupt not specified\n");
@@ -717,13 +710,16 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = tegra_mc_reset_setup(mc);
+	if (err < 0)
+		dev_err(&pdev->dev, "failed to register reset controller: %d\n",
+			err);
+
 	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
 		mc->smmu = tegra_smmu_probe(&pdev->dev, mc->soc->smmu, mc);
-		if (IS_ERR(mc->smmu)) {
+		if (IS_ERR(mc->smmu))
 			dev_err(&pdev->dev, "failed to probe SMMU: %ld\n",
 				PTR_ERR(mc->smmu));
-			return PTR_ERR(mc->smmu);
-		}
 	}
 
 	return 0;
-- 
2.17.0
