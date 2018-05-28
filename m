Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165630AbeE1OWZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161970AbeE1Kex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:34:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 193/329] dmaengine: mv_xor_v2: Fix clock resource by adding a register clock
Date: Mon, 28 May 2018 12:02:02 +0200
Message-Id: <20180528100258.391061404@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit 3cd2c313f1d618f92d1294addc6c685c17065761 ]

On the CP110 components which are present on the Armada 7K/8K SoC we need
to explicitly enable the clock for the registers. However it is not
needed for the AP8xx component, that's why this clock is optional.

With this patch both clock have now a name, but in order to be backward
compatible, the name of the first clock is not used. It allows to still
use this clock with a device tree using the old binding.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/dma/mv-xor-v2.txt |    6 ++++
 drivers/dma/mv_xor_v2.c                             |   25 ++++++++++++++++----
 2 files changed, 25 insertions(+), 6 deletions(-)

--- a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
+++ b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
@@ -11,7 +11,11 @@ Required properties:
   interrupts.
 
 Optional properties:
-- clocks: Optional reference to the clock used by the XOR engine.
+- clocks: Optional reference to the clocks used by the XOR engine.
+- clock-names: mandatory if there is a second clock, in this case the
+   name must be "core" for the first clock and "reg" for the second
+   one
+
 
 Example:
 
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -152,6 +152,7 @@ struct mv_xor_v2_device {
 	void __iomem *dma_base;
 	void __iomem *glob_base;
 	struct clk *clk;
+	struct clk *reg_clk;
 	struct tasklet_struct irq_tasklet;
 	struct list_head free_sw_desc;
 	struct dma_device dmadev;
@@ -697,13 +698,26 @@ static int mv_xor_v2_probe(struct platfo
 	if (ret)
 		return ret;
 
+	xor_dev->reg_clk = devm_clk_get(&pdev->dev, "reg");
+	if (PTR_ERR(xor_dev->reg_clk) != -ENOENT) {
+		if (!IS_ERR(xor_dev->reg_clk)) {
+			ret = clk_prepare_enable(xor_dev->reg_clk);
+			if (ret)
+				return ret;
+		} else {
+			return PTR_ERR(xor_dev->reg_clk);
+		}
+	}
+
 	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(xor_dev->clk) && PTR_ERR(xor_dev->clk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (IS_ERR(xor_dev->clk) && PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
+		ret = EPROBE_DEFER;
+		goto disable_reg_clk;
+	}
 	if (!IS_ERR(xor_dev->clk)) {
 		ret = clk_prepare_enable(xor_dev->clk);
 		if (ret)
-			return ret;
+			goto disable_reg_clk;
 	}
 
 	ret = platform_msi_domain_alloc_irqs(&pdev->dev, 1,
@@ -812,8 +826,9 @@ free_hw_desq:
 free_msi_irqs:
 	platform_msi_domain_free_irqs(&pdev->dev);
 disable_clk:
-	if (!IS_ERR(xor_dev->clk))
-		clk_disable_unprepare(xor_dev->clk);
+	clk_disable_unprepare(xor_dev->clk);
+disable_reg_clk:
+	clk_disable_unprepare(xor_dev->reg_clk);
 	return ret;
 }
 
