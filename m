Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeBTQ7o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:59:44 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45442 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752997AbeBTQ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:59:39 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v4 1/2] mfd: arizona: Update reset pin to use GPIOD
Date: Tue, 20 Feb 2018 16:59:30 +0000
Message-ID: <20180220165931.8809-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=965 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802200209
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now GPIOD has support for both pdata systems and for non-standard DT
bindings the Arizona reset GPIO can be converted to use it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v3:
 - Update header includes

Thanks,
Charles

 drivers/mfd/arizona-core.c        | 53 ++++++++++++++++++++++++++-------------
 include/linux/mfd/arizona/pdata.h |  3 ++-
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 8d46e3ad9529..ad7d1a7c411c 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -13,13 +13,12 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -279,7 +278,7 @@ static int arizona_wait_for_boot(struct arizona *arizona)
 static inline void arizona_enable_reset(struct arizona *arizona)
 {
 	if (arizona->pdata.reset)
-		gpio_set_value_cansleep(arizona->pdata.reset, 0);
+		gpiod_set_value_cansleep(arizona->pdata.reset, 0);
 }
 
 static void arizona_disable_reset(struct arizona *arizona)
@@ -295,7 +294,7 @@ static void arizona_disable_reset(struct arizona *arizona)
 			break;
 		}
 
-		gpio_set_value_cansleep(arizona->pdata.reset, 1);
+		gpiod_set_value_cansleep(arizona->pdata.reset, 1);
 		usleep_range(1000, 5000);
 	}
 }
@@ -804,14 +803,26 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 	int ret, i;
 	int count = 0;
 
-	pdata->reset = of_get_named_gpio(arizona->dev->of_node, "wlf,reset", 0);
-	if (pdata->reset == -EPROBE_DEFER) {
-		return pdata->reset;
-	} else if (pdata->reset < 0) {
-		dev_err(arizona->dev, "Reset GPIO missing/malformed: %d\n",
-			pdata->reset);
+	pdata->reset = devm_gpiod_get_from_of_node(arizona->dev,
+						   arizona->dev->of_node,
+						   "wlf,reset", 0,
+						   GPIOD_OUT_LOW,
+						   "arizona /RESET");
+	if (IS_ERR(pdata->reset)) {
+		ret = PTR_ERR(pdata->reset);
+		switch (ret) {
+		case -ENOENT:
+		case -ENOSYS:
+			break;
+		case -EPROBE_DEFER:
+			return ret;
+		default:
+			dev_err(arizona->dev, "Reset GPIO malformed: %d\n",
+				ret);
+			break;
+		}
 
-		pdata->reset = 0;
+		pdata->reset = NULL;
 	}
 
 	ret = of_property_read_u32_array(arizona->dev->of_node,
@@ -1113,14 +1124,20 @@ int arizona_dev_init(struct arizona *arizona)
 		goto err_early;
 	}
 
-	if (arizona->pdata.reset) {
+	if (!arizona->pdata.reset) {
 		/* Start out with /RESET low to put the chip into reset */
-		ret = devm_gpio_request_one(arizona->dev, arizona->pdata.reset,
-					    GPIOF_DIR_OUT | GPIOF_INIT_LOW,
-					    "arizona /RESET");
-		if (ret != 0) {
-			dev_err(dev, "Failed to request /RESET: %d\n", ret);
-			goto err_dcvdd;
+		arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset",
+						      GPIOD_OUT_LOW);
+		if (IS_ERR(arizona->pdata.reset)) {
+			ret = PTR_ERR(arizona->pdata.reset);
+			if (ret == -EPROBE_DEFER)
+				goto err_dcvdd;
+			else
+				dev_err(arizona->dev,
+					"Reset GPIO missing/malformed: %d\n",
+					ret);
+
+			arizona->pdata.reset = NULL;
 		}
 	}
 
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index bfeecf179895..fdba6f3a286a 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -56,6 +56,7 @@
 #define ARIZONA_MAX_PDM_SPK 2
 
 struct regulator_init_data;
+struct gpio_desc;
 
 struct arizona_micbias {
 	int mV;                    /** Regulated voltage */
@@ -77,7 +78,7 @@ struct arizona_micd_range {
 };
 
 struct arizona_pdata {
-	int reset;      /** GPIO controlling /RESET, if any */
+	struct gpio_desc *reset;      /** GPIO controlling /RESET, if any */
 
 	/** Regulator configuration for MICVDD */
 	struct arizona_micsupp_pdata micvdd;
-- 
2.11.0
