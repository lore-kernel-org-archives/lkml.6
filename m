Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeDYHyX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:54:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62679 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751069AbeDYHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:54:14 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 2/2] drm/bridge: sii902x: add optional power supplies
Date: Wed, 25 Apr 2018 09:53:14 +0200
Message-ID: <20180425075314.19137-3-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425075314.19137-1-philippe.cornu@st.com>
References: <20180425075314.19137-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.5.66]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the optional power supplies using the description found in
"SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".

The sii902x input IOs are not "io safe" so it is important to
enable/disable voltage regulators during probe/remove phases to
avoid damages.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 60373d7eb220..c367d7b91ade 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
@@ -86,6 +87,7 @@ struct sii902x {
 	struct drm_bridge bridge;
 	struct drm_connector connector;
 	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[2];
 };
 
 static inline struct sii902x *bridge_to_sii902x(struct drm_bridge *bridge)
@@ -392,23 +394,42 @@ static int sii902x_probe(struct i2c_client *client,
 		return PTR_ERR(sii902x->reset_gpio);
 	}
 
+	sii902x->supplies[0].supply = "iovcc";
+	sii902x->supplies[1].supply = "vcc12";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
+				      sii902x->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to get power supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
+				    sii902x->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable power supplies: %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(10000, 20000);
+
 	sii902x_reset(sii902x);
 
 	ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
 	if (ret)
-		return ret;
+		goto err_disable_regulator;
 
 	ret = regmap_bulk_read(sii902x->regmap, SII902X_REG_CHIPID(0),
 			       &chipid, 4);
 	if (ret) {
 		dev_err(dev, "regmap_read failed %d\n", ret);
-		return ret;
+		goto err_disable_regulator;
 	}
 
 	if (chipid[0] != 0xb0) {
 		dev_err(dev, "Invalid chipid: %02x (expecting 0xb0)\n",
 			chipid[0]);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_disable_regulator;
 	}
 
 	/* Clear all pending interrupts */
@@ -424,7 +445,7 @@ static int sii902x_probe(struct i2c_client *client,
 						IRQF_ONESHOT, dev_name(dev),
 						sii902x);
 		if (ret)
-			return ret;
+			goto err_disable_regulator;
 	}
 
 	sii902x->bridge.funcs = &sii902x_bridge_funcs;
@@ -434,6 +455,12 @@ static int sii902x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, sii902x);
 
 	return 0;
+
+err_disable_regulator:
+	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
+			       sii902x->supplies);
+
+	return ret;
 }
 
 static int sii902x_remove(struct i2c_client *client)
@@ -443,6 +470,9 @@ static int sii902x_remove(struct i2c_client *client)
 
 	drm_bridge_remove(&sii902x->bridge);
 
+	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
+			       sii902x->supplies);
+
 	return 0;
 }
 
-- 
2.15.1
