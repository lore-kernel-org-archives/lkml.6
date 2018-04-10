Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeDJINk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:13:40 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34666 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeDJINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:13:38 -0400
X-Google-Smtp-Source: AIpwx4/DPxjmMuQ3aQijQE5f5E2lK9NmDrAiR3sgGng1V/t0Wq6OKeDvGnqttRzlL6Dn8TkxgwAzMA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/3] thermal: armada_thermal: Replace mdelay with usleep_range in armada380_init_sensor
Date: Tue, 10 Apr 2018 16:13:28 +0800
Message-Id: <1523348008-29461-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

armada380_init_sensor() is never called in atomic context.

armada380_init_sensor() is set as ".init_sensor" in
struct armada_thermal_data.
".init_sensor" is called armada_thermal_probe().
armada_thermal_probe() is set as ".probe" in struct platform_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, armada380_init_sensor()
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
index ae75328..c289ae4 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -143,7 +143,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	if (!(reg & A380_HW_RESET)) {
 		reg |= A380_HW_RESET;
 		writel(reg, priv->control);
-		mdelay(10);
+		usleep_range(10000, 11000);
 	}
 }
 
-- 
1.9.1
