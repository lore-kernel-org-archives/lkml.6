Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeBTQfv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:35:51 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36076 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752022AbeBTQft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:35:49 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v3 1/2] mfd: arizona: Update reset pin to use GPIOD
Date: Tue, 20 Feb 2018 16:35:39 +0000
Message-ID: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802200204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now GPIOD has support for both pdata systems and for non-standard DT
bindings the Arizona reset GPIO can be converted to use it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Kept null check in arizona_enable_reset, although
   gpiod_set_value_cansleep does its own null check it will also issue
   a fat WARN we don't want if gpiolib is not built in.
 - Added a check for ENOSYS in arizona_of_get_core_pdata, just to
   silence the extra error that would be printed here if gpiolib is not
   built in.

Thanks,
Charles

 drivers/mfd/arizona-core.c        | 50 ++++++++++++++++++++++++++-------------
 include/linux/mfd/arizona/pdata.h |  3 ++-
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 77875250abe5..9558c4d9c8ca 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -279,7 +279,7 @@ static int arizona_wait_for_boot(struct arizona *arizona)
 static inline void arizona_enable_reset(struct arizona *arizona)
 {
 	if (arizona->pdata.reset)
-		gpio_set_value_cansleep(arizona->pdata.reset, 0);
+		gpiod_set_value_cansleep(arizona->pdata.reset, 0);
 }
 
 static void arizona_disable_reset(struct arizona *arizona)
@@ -295,7 +295,7 @@ static void arizona_disable_reset(struct arizona *arizona)
 			break;
 		}
 
-		gpio_set_value_cansleep(arizona->pdata.reset, 1);
+		gpiod_set_value_cansleep(arizona->pdata.reset, 1);
 		usleep_range(1000, 5000);
 	}
 }
@@ -799,14 +799,26 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 	struct arizona_pdata *pdata = &arizona->pdata;
 	int ret, i;
 
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
@@ -1050,14 +1062,20 @@ int arizona_dev_init(struct arizona *arizona)
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
index f72dc53848d7..0013075d4cda 100644
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
