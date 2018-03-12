Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCLPwU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:52:20 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:52080 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932326AbeCLPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:52:17 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v5 1/2] mfd: arizona: Update reset pin to use GPIOD
Date: Mon, 12 Mar 2018 15:52:00 +0000
Message-ID: <20180312155201.30108-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=995 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803120180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now GPIOD has support for both pdata systems and for non-standard DT
bindings the Arizona reset GPIO can be converted to use it. Worth
noting gpiod_set_raw_value_cansleep is used to match the behaviour
of the old GPIOs. This is because the part is fairly widely used and
it is unknown how many DTs are correctly setting active low through
device tree, so to avoid breaking any existing users it is best to
match the previous behaviour.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v4:
 - Don't use a switch statement for handling return values
 - Add some comments to the handling for the older binding
 - Use gpiod_set_raw_value_cansleep to avoid potential breakage

I have also removed Linus's reviewed-by was a bit border line but
I felt there have probably been enough code changes since he gave
it that it was probably safer to remove it.

Thanks,
Charles

 drivers/mfd/arizona-core.c        | 53 ++++++++++++++++++++++++++-------------
 include/linux/mfd/arizona/pdata.h |  3 ++-
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 77875250abe59..83f1c5a516d99 100644
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
+		gpiod_set_raw_value_cansleep(arizona->pdata.reset, 0);
 }
 
 static void arizona_disable_reset(struct arizona *arizona)
@@ -295,7 +294,7 @@ static void arizona_disable_reset(struct arizona *arizona)
 			break;
 		}
 
-		gpio_set_value_cansleep(arizona->pdata.reset, 1);
+		gpiod_set_raw_value_cansleep(arizona->pdata.reset, 1);
 		usleep_range(1000, 5000);
 	}
 }
@@ -799,14 +798,27 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 	struct arizona_pdata *pdata = &arizona->pdata;
 	int ret, i;
 
-	pdata->reset = of_get_named_gpio(arizona->dev->of_node, "wlf,reset", 0);
-	if (pdata->reset == -EPROBE_DEFER) {
-		return pdata->reset;
-	} else if (pdata->reset < 0) {
-		dev_err(arizona->dev, "Reset GPIO missing/malformed: %d\n",
-			pdata->reset);
+	/* Handle old non-standard DT binding */
+	pdata->reset = devm_gpiod_get_from_of_node(arizona->dev,
+						   arizona->dev->of_node,
+						   "wlf,reset", 0,
+						   GPIOD_OUT_LOW,
+						   "arizona /RESET");
+	if (IS_ERR(pdata->reset)) {
+		ret = PTR_ERR(pdata->reset);
 
-		pdata->reset = 0;
+		/*
+		 * Reset missing will be caught when other binding is read
+		 * but all other errors imply this binding is in use but has
+		 * encountered a problem so should be handled.
+		 */
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		else if (ret != -ENOENT && ret != -ENOSYS)
+			dev_err(arizona->dev, "Reset GPIO malformed: %d\n",
+				ret);
+
+		pdata->reset = NULL;
 	}
 
 	ret = of_property_read_u32_array(arizona->dev->of_node,
@@ -1050,14 +1062,19 @@ int arizona_dev_init(struct arizona *arizona)
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
+
+			dev_err(arizona->dev,
+				"Reset GPIO missing/malformed: %d\n", ret);
+
+			arizona->pdata.reset = NULL;
 		}
 	}
 
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index f72dc53848d70..0013075d4cda0 100644
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
