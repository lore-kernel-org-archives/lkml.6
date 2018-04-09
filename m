Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeDITau (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:30:50 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40539 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeDIT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:29:56 -0400
X-Google-Smtp-Source: AIpwx48tewIS0Hqx+/hZluiOMex0YimNMKzJQPBj6qUS9u1BkjrW9884xaLI0UgvfLn+d9TDYZgwNg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/15] memory: tegra: Setup interrupts mask before requesting IRQ
Date: Mon,  9 Apr 2018 22:28:28 +0300
Message-Id: <dd3f80ce5a74c04b170303bceb4e0682de145678.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids unwanted interrupt during MC driver probe.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index d2005b995821..e55b9733bd83 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -407,14 +407,6 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return mc->irq;
 	}
 
-	err = devm_request_irq(&pdev->dev, mc->irq, tegra_mc_irq, IRQF_SHARED,
-			       dev_name(&pdev->dev), mc);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", mc->irq,
-			err);
-		return err;
-	}
-
 	WARN(!mc->soc->client_id_mask, "Missing client ID mask for this SoC\n");
 
 	value = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
@@ -423,6 +415,14 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 	mc_writel(mc, value, MC_INTMASK);
 
+	err = devm_request_irq(&pdev->dev, mc->irq, tegra_mc_irq, IRQF_SHARED,
+			       dev_name(&pdev->dev), mc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", mc->irq,
+			err);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.16.3
