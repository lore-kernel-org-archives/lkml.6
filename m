Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbeBVOY7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:24:59 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33696 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932816AbeBVOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:23:25 -0500
X-Google-Smtp-Source: AH8x227vvDU3F2uEUaK//9PrNGY/oju6vcE3crAQUPLjCKew3AgS9f3CUW6rin5u8Wdm8v5BJiD1OQ==
From: Rui Miguel Silva <rui.silva@linaro.org>
To: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Subject: [PATCH v4 2/4] crypto: caam - do not use mem and emi_slow clock for imx7x
Date: Thu, 22 Feb 2018 14:22:48 +0000
Message-Id: <20180222142250.31348-3-rui.silva@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222142250.31348-1-rui.silva@linaro.org>
References: <20180222142250.31348-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I.MX7x only use two clocks for the CAAM module, so make sure we do not try to
use the mem and the emi_slow clock when running in that imx7d and imx7s machine
type.

Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/crypto/caam/ctrl.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 361e750f9cba..e4cc636e1104 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -337,7 +337,8 @@ static int caam_remove(struct platform_device *pdev)
 
 	/* shut clocks off before finalizing shutdown */
 	clk_disable_unprepare(ctrlpriv->caam_ipg);
-	clk_disable_unprepare(ctrlpriv->caam_mem);
+	if (ctrlpriv->caam_mem)
+		clk_disable_unprepare(ctrlpriv->caam_mem);
 	clk_disable_unprepare(ctrlpriv->caam_aclk);
 	if (ctrlpriv->caam_emi_slow)
 		clk_disable_unprepare(ctrlpriv->caam_emi_slow);
@@ -466,14 +467,17 @@ static int caam_probe(struct platform_device *pdev)
 	}
 	ctrlpriv->caam_ipg = clk;
 
-	clk = caam_drv_identify_clk(&pdev->dev, "mem");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		dev_err(&pdev->dev,
-			"can't identify CAAM mem clk: %d\n", ret);
-		return ret;
+	if (!of_machine_is_compatible("fsl,imx7d") &&
+	    !of_machine_is_compatible("fsl,imx7s")) {
+		clk = caam_drv_identify_clk(&pdev->dev, "mem");
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err(&pdev->dev,
+				"can't identify CAAM mem clk: %d\n", ret);
+			return ret;
+		}
+		ctrlpriv->caam_mem = clk;
 	}
-	ctrlpriv->caam_mem = clk;
 
 	clk = caam_drv_identify_clk(&pdev->dev, "aclk");
 	if (IS_ERR(clk)) {
@@ -484,7 +488,9 @@ static int caam_probe(struct platform_device *pdev)
 	}
 	ctrlpriv->caam_aclk = clk;
 
-	if (!of_machine_is_compatible("fsl,imx6ul")) {
+	if (!of_machine_is_compatible("fsl,imx6ul") &&
+	    !of_machine_is_compatible("fsl,imx7d") &&
+	    !of_machine_is_compatible("fsl,imx7s")) {
 		clk = caam_drv_identify_clk(&pdev->dev, "emi_slow");
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
@@ -501,11 +507,13 @@ static int caam_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(ctrlpriv->caam_mem);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can't enable CAAM secure mem clock: %d\n",
-			ret);
-		goto disable_caam_ipg;
+	if (ctrlpriv->caam_mem) {
+		ret = clk_prepare_enable(ctrlpriv->caam_mem);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "can't enable CAAM secure mem clock: %d\n",
+				ret);
+			goto disable_caam_ipg;
+		}
 	}
 
 	ret = clk_prepare_enable(ctrlpriv->caam_aclk);
@@ -826,7 +834,8 @@ static int caam_probe(struct platform_device *pdev)
 disable_caam_aclk:
 	clk_disable_unprepare(ctrlpriv->caam_aclk);
 disable_caam_mem:
-	clk_disable_unprepare(ctrlpriv->caam_mem);
+	if (ctrlpriv->caam_mem)
+		clk_disable_unprepare(ctrlpriv->caam_mem);
 disable_caam_ipg:
 	clk_disable_unprepare(ctrlpriv->caam_ipg);
 	return ret;
-- 
2.16.2
