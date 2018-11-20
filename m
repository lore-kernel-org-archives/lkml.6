Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B2C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A89213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A89213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbeKUDuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:20 -0500
Received: from anholt.net ([50.246.234.109]:50668 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbeKUDuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1CCC710A162F;
        Tue, 20 Nov 2018 09:20:06 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WOvex56wzHwU; Tue, 20 Nov 2018 09:20:04 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3E36B10A0B73;
        Tue, 20 Nov 2018 09:20:01 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 0B05D2FE1FE5; Tue, 20 Nov 2018 09:20:00 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/8] watchdog: bcm2835: Move the driver to the soc/ directory.
Date:   Tue, 20 Nov 2018 09:19:53 -0800
Message-Id: <20181120172000.15102-2-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120172000.15102-1-eric@anholt.net>
References: <20181120172000.15102-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding for the bcm2835 "wdt" actually covers a large range of the
PM block's register space.  The WDT is not a separate HW block from
the rest of power domain management, so move the driver to the soc/
directory in preparation for expanding its role to cover power
domains.

This move does result in the driver being made mandatory for the
BCM2835 platform, which is probably actually reasonable given that
it's necessary for reboot/halt support.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/soc/bcm/Makefile                              |  1 +
 .../{watchdog/bcm2835_wdt.c => soc/bcm/bcm2835-pm.c}  |  0
 drivers/watchdog/Kconfig                              | 11 -----------
 drivers/watchdog/Makefile                             |  1 -
 4 files changed, 1 insertion(+), 12 deletions(-)
 rename drivers/{watchdog/bcm2835_wdt.c => soc/bcm/bcm2835-pm.c} (100%)

diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
index dc4fced72d21..16504eb694b1 100644
--- a/drivers/soc/bcm/Makefile
+++ b/drivers/soc/bcm/Makefile
@@ -1,2 +1,3 @@
+obj-$(CONFIG_ARCH_BCM2835)      += bcm2835-pm.o
 obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
 obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/soc/bcm/bcm2835-pm.c
similarity index 100%
rename from drivers/watchdog/bcm2835_wdt.c
rename to drivers/soc/bcm/bcm2835-pm.c
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2d64333f4782..796e2a593056 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1573,17 +1573,6 @@ config BCM63XX_WDT
 	  To compile this driver as a loadable module, choose M here.
 	  The module will be called bcm63xx_wdt.
 
-config BCM2835_WDT
-	tristate "Broadcom BCM2835 hardware watchdog"
-	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
-	select WATCHDOG_CORE
-	help
-	  Watchdog driver for the built in watchdog hardware in Broadcom
-	  BCM2835 SoC.
-
-	  To compile this driver as a loadable module, choose M here.
-	  The module will be called bcm2835_wdt.
-
 config BCM_KONA_WDT
 	tristate "BCM Kona Watchdog"
 	depends on ARCH_BCM_MOBILE || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f69cdff5ad7f..1788537e85af 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -70,7 +70,6 @@ obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
 obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
-obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
 obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
 obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
 obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o
-- 
2.19.1

