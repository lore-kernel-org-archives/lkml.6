Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeCWJR0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:17:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752062AbeCWJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:36 -0400
X-UUID: 148c29c07d9e4db487b37dfe2daa48b7-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 11/16] rtc: mediatek: move the declaration into a globally visible header file
Date: Fri, 23 Mar 2018 17:15:08 +0800
Message-ID: <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-6.737000-8.000000-10
X-TMASE-MatchedRID: lnFJRi0AOmx3emsqv77kMYSvKOGqLLPKK2i9pofGVSvvSbc8qoHu0dn7
        b/+Y15IvAEITvPJt4dRYk91062MLlyZ54WxtnrTDkDpLRKO9xhTt/okBLaEo+EUNHQAoZf5csFe
        531Fr7DScPcDHCp4L+uSWVqW5qzmOfdqC3iY1TXnhPQQVFw3HFH0tCKdnhB589yM15V5aWpj6C0
        ePs7A07SSyFhRNlxkT64eSBIFi5Rzn+nZ7rmgOTppWLOVgTsZFY8XmqB8E3tFWXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.737000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is in preparation for allowing other drivers can share the
declaration, so move the declaration into a globally visible header file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c   | 53 +---------------------------------
 include/linux/rtc/mt6397.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 52 deletions(-)
 create mode 100644 include/linux/rtc/mt6397.h

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index d133d1f..015609d 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -19,63 +19,12 @@
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/mfd/mt6397/core.h>
-
-#define RTC_BBPU		0x0000
-#define RTC_BBPU_CBUSY		BIT(6)
-
-#define RTC_WRTGR		0x003c
-
-#define RTC_IRQ_STA		0x0002
-#define RTC_IRQ_STA_AL		BIT(0)
-#define RTC_IRQ_STA_LP		BIT(3)
-
-#define RTC_IRQ_EN		0x0004
-#define RTC_IRQ_EN_AL		BIT(0)
-#define RTC_IRQ_EN_ONESHOT	BIT(2)
-#define RTC_IRQ_EN_LP		BIT(3)
-#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
-
-#define RTC_AL_MASK		0x0008
-#define RTC_AL_MASK_DOW		BIT(4)
-
-#define RTC_TC_SEC		0x000a
-/* Min, Hour, Dom... register offset to RTC_TC_SEC */
-#define RTC_OFFSET_SEC		0
-#define RTC_OFFSET_MIN		1
-#define RTC_OFFSET_HOUR		2
-#define RTC_OFFSET_DOM		3
-#define RTC_OFFSET_DOW		4
-#define RTC_OFFSET_MTH		5
-#define RTC_OFFSET_YEAR		6
-#define RTC_OFFSET_COUNT	7
-
-#define RTC_AL_SEC		0x0018
-
-#define RTC_PDN2		0x002e
-#define RTC_PDN2_PWRON_ALARM	BIT(4)
-
-#define RTC_MIN_YEAR		1968
-#define RTC_BASE_YEAR		1900
-#define RTC_NUM_YEARS		128
-#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
-
-#define MTK_RTC_POLL_DELAY_US	10
-#define MTK_RTC_POLL_TIMEOUT	(jiffies_to_usecs(HZ))
-
-struct mt6397_rtc {
-	struct device		*dev;
-	struct rtc_device	*rtc_dev;
-	struct mutex		lock;
-	struct regmap		*regmap;
-	int			irq;
-	u32			addr_base;
-};
+#include <linux/rtc/mt6397.h>
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 {
diff --git a/include/linux/rtc/mt6397.h b/include/linux/rtc/mt6397.h
new file mode 100644
index 0000000..4b19f51
--- /dev/null
+++ b/include/linux/rtc/mt6397.h
@@ -0,0 +1,72 @@
+
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2014-2018 MediaTek Inc.
+ *
+ * Author: Tianping.Fang <tianping.fang@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+
+#ifndef _LINUX_RTC_MT6397_H_
+#define _LINUX_RTC_MT6397_H_
+
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+#define RTC_BBPU		0x0000
+#define RTC_BBPU_CBUSY		BIT(6)
+
+#define RTC_WRTGR		0x003c
+
+#define RTC_IRQ_STA		0x0002
+#define RTC_IRQ_STA_AL		BIT(0)
+#define RTC_IRQ_STA_LP		BIT(3)
+
+#define RTC_IRQ_EN		0x0004
+#define RTC_IRQ_EN_AL		BIT(0)
+#define RTC_IRQ_EN_ONESHOT	BIT(2)
+#define RTC_IRQ_EN_LP		BIT(3)
+#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
+
+#define RTC_AL_MASK		0x0008
+#define RTC_AL_MASK_DOW		BIT(4)
+
+#define RTC_TC_SEC		0x000a
+/* Min, Hour, Dom... register offset to RTC_TC_SEC */
+#define RTC_OFFSET_SEC		0
+#define RTC_OFFSET_MIN		1
+#define RTC_OFFSET_HOUR		2
+#define RTC_OFFSET_DOM		3
+#define RTC_OFFSET_DOW		4
+#define RTC_OFFSET_MTH		5
+#define RTC_OFFSET_YEAR		6
+#define RTC_OFFSET_COUNT	7
+
+#define RTC_AL_SEC		0x0018
+
+#define RTC_PDN2		0x002e
+#define RTC_PDN2_PWRON_ALARM	BIT(4)
+
+#define RTC_MIN_YEAR		1968
+#define RTC_BASE_YEAR		1900
+#define RTC_NUM_YEARS		128
+#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
+
+#define MTK_RTC_POLL_DELAY_US	10
+#define MTK_RTC_POLL_TIMEOUT	(jiffies_to_usecs(HZ))
+
+struct mt6397_rtc {
+	struct device		*dev;
+	struct rtc_device	*rtc_dev;
+
+	/* protect registers accessing */
+	struct mutex		lock;
+	struct regmap		*regmap;
+	int			irq;
+	u32			addr_base;
+};
+
+#endif /* _LINUX_RTC_MT6397_H_ */
+
-- 
2.7.4
