Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF2C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BAD214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BAD214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJKAd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:33:29 -0400
Received: from shell.v3.sk ([90.176.6.54]:54216 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbeJKAd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:33:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 079AABCFAB;
        Wed, 10 Oct 2018 19:10:22 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iPKXEnoiMOUj; Wed, 10 Oct 2018 19:10:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B906DBCF87;
        Wed, 10 Oct 2018 19:09:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9ONrfz8IE68r; Wed, 10 Oct 2018 19:09:53 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B3824B8064;
        Wed, 10 Oct 2018 19:09:52 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 04/11] spi: pxa2xx: Add devicetree support
Date:   Wed, 10 Oct 2018 19:09:29 +0200
Message-Id: <20181010170936.316862-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMP2 platform, that uses device tree, has this controller. Let's add
devicetree alongside platform & PCI.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c   | 73 +++++++++++++++++++++++---------------
 include/linux/pxa2xx_ssp.h |  1 +
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f674541675bb..58554c765a87 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -33,6 +33,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/acpi.h>
+#include <linux/of_device.h>
=20
 #include "spi-pxa2xx.h"
=20
@@ -1333,9 +1334,6 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
=20
-#ifdef CONFIG_PCI
-#ifdef CONFIG_ACPI
-
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] =3D {
 	{ "INT33C0", LPSS_LPT_SSP },
 	{ "INT33C1", LPSS_LPT_SSP },
@@ -1347,23 +1345,6 @@ static const struct acpi_device_id pxa2xx_spi_acpi=
_match[] =3D {
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
=20
-static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
-{
-	unsigned int devid;
-	int port_id =3D -1;
-
-	if (adev && adev->pnp.unique_id &&
-	    !kstrtouint(adev->pnp.unique_id, 0, &devid))
-		port_id =3D devid;
-	return port_id;
-}
-#else /* !CONFIG_ACPI */
-static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
-{
-	return -1;
-}
-#endif
-
 /*
  * PCI IDs of compound devices that integrate both host controller and p=
rivate
  * integrated DMA engine. Please note these are not used in module
@@ -1410,6 +1391,37 @@ static const struct pci_device_id pxa2xx_spi_pci_c=
ompound_match[] =3D {
 	{ },
 };
=20
+static const struct of_device_id pxa2xx_spi_of_match[] =3D {
+	{ .compatible =3D "marvell,mmp2-ssp", .data =3D (void *)MMP2_SSP },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
+
+#ifdef CONFIG_ACPI
+
+static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+{
+	unsigned int devid;
+	int port_id =3D -1;
+
+	if (adev && adev->pnp.unique_id &&
+	    !kstrtouint(adev->pnp.unique_id, 0, &devid))
+		port_id =3D devid;
+	return port_id;
+}
+
+#else /* !CONFIG_ACPI */
+
+static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+{
+	return -1;
+}
+
+#endif /* CONFIG_ACPI */
+
+
+#ifdef CONFIG_PCI
+
 static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 {
 	struct device *dev =3D param;
@@ -1420,6 +1432,8 @@ static bool pxa2xx_spi_idma_filter(struct dma_chan =
*chan, void *param)
 	return true;
 }
=20
+#endif /* CONFIG_PCI */
+
 static struct pxa2xx_spi_master *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
@@ -1429,11 +1443,15 @@ pxa2xx_spi_init_pdata(struct platform_device *pde=
v)
 	struct resource *res;
 	const struct acpi_device_id *adev_id =3D NULL;
 	const struct pci_device_id *pcidev_id =3D NULL;
+	const struct of_device_id *of_id =3D NULL;
 	enum pxa_ssp_type type;
=20
 	adev =3D ACPI_COMPANION(&pdev->dev);
=20
-	if (dev_is_pci(pdev->dev.parent))
+	if (pdev->dev.of_node)
+		of_id =3D of_match_device(pdev->dev.driver->of_match_table,
+					&pdev->dev);
+	else if (dev_is_pci(pdev->dev.parent))
 		pcidev_id =3D pci_match_id(pxa2xx_spi_pci_compound_match,
 					 to_pci_dev(pdev->dev.parent));
 	else if (adev)
@@ -1446,6 +1464,8 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		type =3D (enum pxa_ssp_type)adev_id->driver_data;
 	else if (pcidev_id)
 		type =3D (enum pxa_ssp_type)pcidev_id->driver_data;
+	else if (of_id)
+		type =3D (enum pxa_ssp_type)of_id->data;
 	else
 		return NULL;
=20
@@ -1464,11 +1484,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pde=
v)
 	if (IS_ERR(ssp->mmio_base))
 		return NULL;
=20
+#ifdef CONFIG_PCI
 	if (pcidev_id) {
 		pdata->tx_param =3D pdev->dev.parent;
 		pdata->rx_param =3D pdev->dev.parent;
 		pdata->dma_filter =3D pxa2xx_spi_idma_filter;
 	}
+#endif
=20
 	ssp->clk =3D devm_clk_get(&pdev->dev, NULL);
 	ssp->irq =3D platform_get_irq(pdev, 0);
@@ -1482,14 +1504,6 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev=
)
 	return pdata;
 }
=20
-#else /* !CONFIG_PCI */
-static inline struct pxa2xx_spi_master *
-pxa2xx_spi_init_pdata(struct platform_device *pdev)
-{
-	return NULL;
-}
-#endif
-
 static int pxa2xx_spi_fw_translate_cs(struct spi_controller *master,
 				      unsigned int cs)
 {
@@ -1848,6 +1862,7 @@ static struct platform_driver driver =3D {
 		.name	=3D "pxa2xx-spi",
 		.pm	=3D &pxa2xx_spi_pm_ops,
 		.acpi_match_table =3D ACPI_PTR(pxa2xx_spi_acpi_match),
+		.of_match_table =3D of_match_ptr(pxa2xx_spi_of_match),
 	},
 	.probe =3D pxa2xx_spi_probe,
 	.remove =3D pxa2xx_spi_remove,
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 262e1f318836..979087e021f3 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -196,6 +196,7 @@ enum pxa_ssp_type {
 	PXA27x_SSP,
 	PXA3xx_SSP,
 	PXA168_SSP,
+	MMP2_SSP,
 	PXA910_SSP,
 	CE4100_SSP,
 	QUARK_X1000_SSP,
--=20
2.19.0

