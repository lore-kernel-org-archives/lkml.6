Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeFCUPo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 16:15:44 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:51930 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCUPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 16:15:43 -0400
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 03 Jun 2018 22:15:42 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: add the missing AC97 clocks
Date: Sun,  3 Jun 2018 22:15:39 +0200
Message-Id: <20180603201539.15704-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AC97 bit clock is added as the pxa internally generated 13MHz
clock. This is a consequence of the new ac97 framework.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/devices.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 5a16ea74e28a..a24783a03827 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/spi/pxa2xx_spi.h>
@@ -477,6 +478,18 @@ struct platform_device pxa_device_ac97 = {
 
 void __init pxa_set_ac97_info(pxa2xx_audio_ops_t *ops)
 {
+	int ret;
+
+	ret = clk_add_alias("ac97_clk", "pxa2xx-ac97:0", "AC97CLK",
+			   &pxa_device_ac97.dev);
+	if (ret)
+		pr_err("PXA AC97 clock1 alias error: %d\n", ret);
+
+	ret = clk_add_alias("ac97_clk", "pxa2xx-ac97:1", "AC97CLK",
+			    &pxa_device_ac97.dev);
+	if (ret)
+		pr_err("PXA AC97 clock2 alias error: %d\n", ret);
+
 	pxa_register_device(&pxa_device_ac97, ops);
 }
 
-- 
2.11.0
