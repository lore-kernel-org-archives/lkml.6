Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeBEJqg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:46:36 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16378 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752510AbeBEJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:46:08 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v1 2/2] drm/panel: otm8009a: Add support for the optional power-supply
Date: Mon, 5 Feb 2018 10:45:32 +0100
Message-ID: <20180205094532.23547-3-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180205094532.23547-1-philippe.cornu@st.com>
References: <20180205094532.23547-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the optional power-supply.

Note: A "dummy regulator" is returned by devm_regulator_get()
if the optional regulator is not present in the device tree,
simplifying the source code when enabling/disabling the regulator.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 72530983d55d..90f1ae4af93c 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -11,6 +11,7 @@
 #include <drm/drm_panel.h>
 #include <linux/backlight.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <video/mipi_display.h>
 
 #define DRV_NAME "orisetech_otm8009a"
@@ -62,6 +63,7 @@ struct otm8009a {
 	struct drm_panel panel;
 	struct backlight_device *bl_dev;
 	struct gpio_desc *reset_gpio;
+	struct regulator *supply;
 	bool prepared;
 	bool enabled;
 };
@@ -279,6 +281,8 @@ static int otm8009a_unprepare(struct drm_panel *panel)
 		msleep(20);
 	}
 
+	regulator_disable(ctx->supply);
+
 	ctx->prepared = false;
 
 	return 0;
@@ -292,6 +296,12 @@ static int otm8009a_prepare(struct drm_panel *panel)
 	if (ctx->prepared)
 		return 0;
 
+	ret = regulator_enable(ctx->supply);
+	if (ret < 0) {
+		DRM_ERROR("failed to enable supply: %d\n", ret);
+		return ret;
+	}
+
 	if (ctx->reset_gpio) {
 		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
@@ -414,6 +424,13 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
+	ctx->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(ctx->supply)) {
+		ret = PTR_ERR(ctx->supply);
+		dev_err(dev, "failed to request regulator: %d\n", ret);
+		return ret;
+	}
+
 	mipi_dsi_set_drvdata(dsi, ctx);
 
 	ctx->dev = dev;
-- 
2.15.1
