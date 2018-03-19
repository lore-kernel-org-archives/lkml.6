Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeCSPdj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:33:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37281 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeCSPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:33:34 -0400
X-Google-Smtp-Source: AG47ELsMBbSOSWxvYmoJzFFZ7YOoPeRyqqi9r0BzxKV1Fqjo/rUUAKpmCD+RkV6127Uksx8X9iaaXw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/4] memory: aemif: add support for board files
Date: Mon, 19 Mar 2018 16:33:12 +0100
Message-Id: <20180319153314.26120-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319153314.26120-1-brgl@bgdev.pl>
References: <20180319153314.26120-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently aemif is supported in two places separately. By the platform
driver in drivers/memory and by a hand crafted driver in mach-davinci.

We want to drop the latter but also keep the legacy mode. Add support
for board files to the aemif driver.

The new structure in platform data currently only contains the chip
select number, since currently existing users don't require anything
else, but it can be extended in the future.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/memory/ti-aemif.c              | 57 ++++++++++++++++++++++------------
 include/linux/platform_data/ti-aemif.h |  9 ++++++
 2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 588e58d40d1b..27d2b076f465 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -339,9 +339,6 @@ static int aemif_probe(struct platform_device *pdev)
 	struct aemif_platform_data *pdata;
 	struct of_dev_auxdata *dev_lookup;
 
-	if (np == NULL)
-		return 0;
-
 	aemif = devm_kzalloc(dev, sizeof(*aemif), GFP_KERNEL);
 	if (!aemif)
 		return -ENOMEM;
@@ -363,8 +360,10 @@ static int aemif_probe(struct platform_device *pdev)
 
 	aemif->clk_rate = clk_get_rate(aemif->clk) / MSEC_PER_SEC;
 
-	if (of_device_is_compatible(np, "ti,da850-aemif"))
+	if (np && of_device_is_compatible(np, "ti,da850-aemif"))
 		aemif->cs_offset = 2;
+	else if (pdata)
+		aemif->cs_offset = pdata->cs_offset;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	aemif->base = devm_ioremap_resource(dev, res);
@@ -373,15 +372,23 @@ static int aemif_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	/*
-	 * For every controller device node, there is a cs device node that
-	 * describe the bus configuration parameters. This functions iterate
-	 * over these nodes and update the cs data array.
-	 */
-	for_each_available_child_of_node(np, child_np) {
-		ret = of_aemif_parse_abus_config(pdev, child_np);
-		if (ret < 0)
-			goto error;
+	if (np) {
+		/*
+		 * For every controller device node, there is a cs device node
+		 * that describe the bus configuration parameters. This
+		 * functions iterate over these nodes and update the cs data
+		 * array.
+		 */
+		for_each_available_child_of_node(np, child_np) {
+			ret = of_aemif_parse_abus_config(pdev, child_np);
+			if (ret < 0)
+				goto error;
+		}
+	} else if (pdata && pdata->num_abus_data > 0) {
+		for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
+			aemif->cs_data[i].cs = pdata->abus_data->cs;
+			aemif_get_hw_params(pdev, i);
+		}
 	}
 
 	for (i = 0; i < aemif->num_cs; i++) {
@@ -394,14 +401,24 @@ static int aemif_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Create a child devices explicitly from here to
-	 * guarantee that the child will be probed after the AEMIF timing
-	 * parameters are set.
+	 * Create a child devices explicitly from here to guarantee that the
+	 * child will be probed after the AEMIF timing parameters are set.
 	 */
-	for_each_available_child_of_node(np, child_np) {
-		ret = of_platform_populate(child_np, NULL, dev_lookup, dev);
-		if (ret < 0)
-			goto error;
+	if (np) {
+		for_each_available_child_of_node(np, child_np) {
+			ret = of_platform_populate(child_np, NULL,
+						   dev_lookup, dev);
+			if (ret < 0)
+				goto error;
+		}
+	} else {
+		for (i = 0; i < pdata->num_sub_devices; i++) {
+			ret = platform_device_register(&pdata->sub_devices[i]);
+			if (ret) {
+				dev_warn(dev, "Error register sub device %s\n",
+					 pdata->sub_devices[i].name);
+			}
+		}
 	}
 
 	return 0;
diff --git a/include/linux/platform_data/ti-aemif.h b/include/linux/platform_data/ti-aemif.h
index ac72e115093c..dfe8901128c9 100644
--- a/include/linux/platform_data/ti-aemif.h
+++ b/include/linux/platform_data/ti-aemif.h
@@ -16,8 +16,17 @@
 
 #include <linux/of_platform.h>
 
+struct aemif_abus_data {
+	u32 cs;
+};
+
 struct aemif_platform_data {
 	struct of_dev_auxdata *dev_lookup;
+	u32 cs_offset;
+	struct aemif_abus_data *abus_data;
+	size_t num_abus_data;
+	struct platform_device *sub_devices;
+	size_t num_sub_devices;
 };
 
 #endif /* __TI_DAVINCI_AEMIF_DATA_H__ */
-- 
2.16.1
