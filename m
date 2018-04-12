Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDLDzq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 23:55:46 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:16735 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeDLDza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 23:55:30 -0400
From: Keerthy <j-keerthy@ti.com>
To: <linus.walleij@linaro.org>, <grygorii.strashko@ti.com>,
        <tony@atomide.com>
CC: <j-keerthy@ti.com>, <t-kristo@ti.com>, <Russ.Dill@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ssantosh@kernel.org>, <haojian.zhuang@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <d-gerlach@ti.com>
Subject: [PATCH 11/14] gpio: omap: Restore power_mode configuration at resume time
Date: Thu, 12 Apr 2018 09:23:56 +0530
Message-ID: <1523505239-16229-12-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Commit 2dc983c565e0 ("gpio/omap: cleanup prepare_for_idle and
resume_after_idle") introduces omap2_gpio_prepare_for_idle and
omap2_gpio_resume_after_idle to properly configure gpios that are used
as wake sources. When entering off mode, omap2_gpio_prepare_for_idle
can set a flag indicating off-mode entry is desired, however once this
flag is set it is never cleared, so any additional calls to this
function, regardless of the mode, have this flag set.

This patch restores the pwr_mode flag to 0 in
omap2_gpio_resume_after_idle to ensure the flag is not misconfigured
during non off-mode operation.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/gpio-omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 34fde30..84d664b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1476,6 +1476,8 @@ void omap2_gpio_resume_after_idle(void)
 			continue;
 
 		pm_runtime_get_sync(bank->chip.parent);
+
+		bank->power_mode = 0;
 	}
 }
 #endif
-- 
1.9.1
