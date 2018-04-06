Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeDFMjR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:39:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35046 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDFMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:39:14 -0400
X-Google-Smtp-Source: AIpwx4/qPFd4eD9ImQlqzpYOkbfKqMX7kpHiy59dLwmudJ1TXxzM53HmCLL46rUiSo2tteNMIcH2BQ==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: netdev@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Claudiu Manoil <claudiu.manoil@freescale.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net/fsl_pq_mdio: Allow explicit speficition of TBIPA address
Date: Fri,  6 Apr 2018 14:38:34 +0200
Message-Id: <20180406123836.12019-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This introduces a simpler and generic method for for finding (and mapping)
the TBIPA register.

Instead of relying of complicated logic for finding the TBIPA register
address based on the MDIO or MII register block base
address, which even in some cases relies on undocumented shadow registers,
a second "reg" entry for the mdio bus devicetree node specifies the TBIPA
register.

Backwards compatibility is kept, as the existing logic is applied when
only a single "reg" mapping is specified.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  6 ++-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       | 50 +++++++++++++++-------
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 594982c6b9f9..79bf352e659c 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -6,7 +6,11 @@ the definition of the PHY node in booting-without-of.txt for an example
 of how to define a PHY.
 
 Required properties:
-  - reg : Offset and length of the register set for the device
+  - reg : Offset and length of the register set for the device, and optionally
+          the offset and length of the TBIPA register (TBI PHY address
+	  register).  If TBIPA register is not specified, the driver will
+	  attempt to infer it from the register set specified (your mileage may
+	  vary).
   - compatible : Should define the compatible device type for the
     mdio. Currently supported strings/devices are:
 	- "fsl,gianfar-tbi"
diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 80ad16acf0f1..ac2c3f6a12bc 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -377,6 +377,38 @@ static const struct of_device_id fsl_pq_mdio_match[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_pq_mdio_match);
 
+static void set_tbipa(const u32 tbipa_val, struct platform_device *pdev,
+		      uint32_t __iomem * (*get_tbipa)(void __iomem *),
+		      void __iomem *reg_map, struct resource *reg_res)
+{
+	struct device_node *np = pdev->dev.of_node;
+	uint32_t __iomem *tbipa;
+	bool tbipa_mapped;
+
+	tbipa = of_iomap(np, 1);
+	if (tbipa) {
+		tbipa_mapped = true;
+	} else {
+		tbipa_mapped = false;
+		tbipa = (*get_tbipa)(reg_map);
+
+		/*
+		 * Add consistency check to make sure TBI is contained within
+		 * the mapped range (not because we would get a segfault,
+		 * rather to catch bugs in computing TBI address). Print error
+		 * message but continue anyway.
+		 */
+		if ((void *)tbipa > reg_map + resource_size(reg_res) - 4)
+			dev_err(&pdev->dev, "invalid register map (should be at least 0x%04zx to contain TBI address)\n",
+				((void *)tbipa - reg_map) + 4);
+	}
+
+	iowrite32be(be32_to_cpu(tbipa_val), tbipa);
+
+	if (tbipa_mapped)
+		iounmap(tbipa);
+}
+
 static int fsl_pq_mdio_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id =
@@ -450,8 +482,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 
 		if (tbi) {
 			const u32 *prop = of_get_property(tbi, "reg", NULL);
-			uint32_t __iomem *tbipa;
-
 			if (!prop) {
 				dev_err(&pdev->dev,
 					"missing 'reg' property in node %pOF\n",
@@ -459,20 +489,8 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 				err = -EBUSY;
 				goto error;
 			}
-
-			tbipa = data->get_tbipa(priv->map);
-
-			/*
-			 * Add consistency check to make sure TBI is contained
-			 * within the mapped range (not because we would get a
-			 * segfault, rather to catch bugs in computing TBI
-			 * address). Print error message but continue anyway.
-			 */
-			if ((void *)tbipa > priv->map + resource_size(&res) - 4)
-				dev_err(&pdev->dev, "invalid register map (should be at least 0x%04zx to contain TBI address)\n",
-					((void *)tbipa - priv->map) + 4);
-
-			iowrite32be(be32_to_cpup(prop), tbipa);
+			set_tbipa(*prop, pdev,
+				  data->get_tbipa, priv->map, &res);
 		}
 	}
 
-- 
2.16.3
