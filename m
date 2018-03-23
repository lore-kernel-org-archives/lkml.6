Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeCWJUj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:20:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9578 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751675AbeCWJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:30 -0400
X-UUID: 86c8a38a92a84437a8af2083e96be6cd-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 08/16] rtc: mediatek: remove unnecessary irq_dispose_mapping
Date: Fri, 23 Mar 2018 17:15:05 +0800
Message-ID: <96f39ce7f57a4dcd7653e049eebc87c83bcbdfc9.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-5.189400-8.000000-10
X-TMASE-MatchedRID: x6uIgBUWMEw3XjqZll6IQaDH6drx3JPVYoHH/gi0K9uHlDUCu0I+XIny
        HZfRmqmqTiQecD9aKoSRYJdMgDxPlhgEuFFWa742ypeMiaCPnxvGYnoF/CTeZclk/SMg0CpQo8W
        MkQWv6iXBcIE78YqRWo6HM5rqDwqtb3C5dDGXC8YVT2mlXIA04VcJ/KqDzE0u8UmmLQxSAiVc+f
        utAOX47EMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.189400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It's unnecessary doing irq_dispose_mapping as a reverse operation for
platform_get_irq.

Ususally, irq_dispose_mapping should be called in error path or module
removal to release the resources for irq_of_parse_and_map requested.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index b62eaa8..cefb83b 100644
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
