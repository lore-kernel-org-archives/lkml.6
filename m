Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeDJINM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:13:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56181 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbeDJINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:13:11 -0400
X-Google-Smtp-Source: AIpwx4963bb6BiXSJgP341HaJa9U9PZ9UeT4JVbfKhHsreu5qm0IT72r5SWukyWD8EPEPs1S8oFrzg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/3] thermal: armada_thermal: Replace mdelay with usleep_range in armada370_init_sensor
Date: Tue, 10 Apr 2018 16:13:02 +0800
Message-Id: <1523347982-29373-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

armada370_init_sensor() is never called in atomic context.

armada370_init_sensor() is set as ".init_sensor" in 
struct armada_thermal_data.
".init_sensor" is called armada_thermal_probe().
armada_thermal_probe() is set as ".probe" in struct platform_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, armada370_init_sensor()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/thermal/armada_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ae75328..807fe74 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -113,7 +113,7 @@ static void armada370_init_sensor(struct platform_device *pdev,
 	reg &= ~PMU_TDC0_START_CAL_MASK;
 	writel(reg, priv->control);
 
-	mdelay(10);
+	usleep_range(10000, 11000);
 }
 
 static void armada375_init_sensor(struct platform_device *pdev,
-- 
1.9.1
