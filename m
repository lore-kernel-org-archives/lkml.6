Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeDYJfK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:35:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56217 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751573AbeDYJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:33:04 -0400
X-UUID: 71d33eacd3c04aa183b88cd6320d69dc-20180425
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 10/17] rtc: mt6397: remove unnecessary irq_dispose_mapping
Date: Wed, 25 Apr 2018 17:32:36 +0800
Message-ID: <6354082fb42b560b4f0a7d8ed32e7ae274d624a9.1524646231.git.sean.wang@mediatek.com>
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

With the patch [1], the job irq_create_mapping had been moved from the
rtc driver to mfd core, so it should be unnecessary to keep
irq_dispose_mapping in all paths of the leaf driver.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2017-September/010455.html

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index efb9370..398bae5 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/irqdomain.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
@@ -336,7 +335,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
-		goto out_dispose_irq;
+		return ret;
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
@@ -353,8 +352,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 out_free_irq:
 	free_irq(rtc->irq, rtc->rtc_dev);
-out_dispose_irq:
-	irq_dispose_mapping(rtc->irq);
+
 	return ret;
 }
 
@@ -364,7 +362,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
 
 	rtc_device_unregister(rtc->rtc_dev);
 	free_irq(rtc->irq, rtc->rtc_dev);
-	irq_dispose_mapping(rtc->irq);
 
 	return 0;
 }
-- 
2.7.4
