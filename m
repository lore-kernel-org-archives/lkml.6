Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeDYJgp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:36:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56217 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751324AbeDYJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:32:55 -0400
X-UUID: 140a1e50cf844f5c90496d612855efdd-20180425
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 09/17] rtc: mt6397: replace a poll with regmap_read_poll_timeout
Date: Wed, 25 Apr 2018 17:32:35 +0800
Message-ID: <de46e310a29fd63f66165e6f8296e949f392a370.1524646231.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Reuse the helper regmap_read_poll_timeout instead of an open-coding
handling to simpify the logic.

Furthermore, the time for a wait in each iteration changed from cpu_relax
to 20us is for matching the usage of the helper, but it wouldn't acctually
break any the existent functionality according to a good test on MT6323
PMIC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 0df7ccd..efb9370 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/irqdomain.h>
+#include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -63,6 +64,9 @@
 #define RTC_NUM_YEARS		128
 #define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
 
+#define MTK_RTC_POLL_DELAY_US	10
+#define MTK_RTC_POLL_TIMEOUT	(jiffies_to_usecs(HZ))
+
 struct mt6397_rtc {
 	struct device		*dev;
 	struct rtc_device	*rtc_dev;
@@ -74,7 +78,6 @@ struct mt6397_rtc {
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 {
-	unsigned long timeout = jiffies + HZ;
 	int ret;
 	u32 data;
 
@@ -82,19 +85,13 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 	if (ret < 0)
 		return ret;
 
-	while (1) {
-		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
-				  &data);
-		if (ret < 0)
-			break;
-		if (!(data & RTC_BBPU_CBUSY))
-			break;
-		if (time_after(jiffies, timeout)) {
-			ret = -ETIMEDOUT;
-			break;
-		}
-		cpu_relax();
-	}
+	ret = regmap_read_poll_timeout(rtc->regmap,
+				       rtc->addr_base + RTC_BBPU, data,
+				       !(data & RTC_BBPU_CBUSY),
+				       MTK_RTC_POLL_DELAY_US,
+				       MTK_RTC_POLL_TIMEOUT);
+	if (ret < 0)
+		dev_err(rtc->dev, "failed to write WRTGE: %d\n", ret);
 
 	return ret;
 }
-- 
2.7.4
