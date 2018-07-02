Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA66C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BEC25C57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BEC25C57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965510AbeGBKWW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:22:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965264AbeGBKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:22:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B04EA289A8F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, Guenter Roeck <groeck@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] platform/chrome: Move cros-ec transport drivers to drivers/platform.
Date:   Mon,  2 Jul 2018 12:21:59 +0200
Message-Id: <20180702102201.13461-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702102201.13461-1-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some cros-ec transport drivers (I2C, SPI) living in MFD, while
others (LPC) living in drivers/platform. The transport drivers are more
platform specific. So, move the I2C and SPI transport drivers to the
platform/chrome directory. The patch also removes the MFD_ prefix of
their Kconfig symbols.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/Kconfig                           | 20 -------------------
 drivers/mfd/Makefile                          |  2 --
 drivers/platform/chrome/Kconfig               | 20 +++++++++++++++++++
 drivers/platform/chrome/Makefile              |  2 ++
 .../{mfd => platform/chrome}/cros_ec_i2c.c    |  0
 .../{mfd => platform/chrome}/cros_ec_spi.c    |  0
 6 files changed, 22 insertions(+), 22 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
 rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..013458e728dc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -202,26 +202,6 @@ config MFD_CROS_EC
 	  You also need to enable the driver for the bus you are using. The
 	  protocol for talking to the EC is defined by the bus driver.
 
-config MFD_CROS_EC_I2C
-	tristate "ChromeOS Embedded Controller (I2C)"
-	depends on MFD_CROS_EC && I2C
-
-	help
-	  If you say Y here, you get support for talking to the ChromeOS
-	  EC through an I2C bus. This uses a simple byte-level protocol with
-	  a checksum. Failing accesses will be retried three times to
-	  improve reliability.
-
-config MFD_CROS_EC_SPI
-	tristate "ChromeOS Embedded Controller (SPI)"
-	depends on MFD_CROS_EC && SPI
-
-	---help---
-	  If you say Y here, you get support for talking to the ChromeOS EC
-	  through a SPI bus, using a byte-level protocol. Since the EC's
-	  response time cannot be guaranteed, we support ignoring
-	  'pre-amble' bytes before the response actually starts.
-
 config MFD_CROS_EC_CHARDEV
         tristate "Chrome OS Embedded Controller userspace device interface"
         depends on MFD_CROS_EC
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e9fd20dba18d..d13e859d7c1e 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -14,8 +14,6 @@ obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
 cros_ec_core-objs		:= cros_ec.o
 obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
-obj-$(CONFIG_MFD_CROS_EC_I2C)	+= cros_ec_i2c.o
-obj-$(CONFIG_MFD_CROS_EC_SPI)	+= cros_ec_spi.o
 obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index cb0df9eb3e0f..16b1615958aa 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -52,6 +52,26 @@ config CHROMEOS_TBMC
 config CROS_EC_CTL
         tristate
 
+config CROS_EC_I2C
+	tristate "ChromeOS Embedded Controller (I2C)"
+	depends on MFD_CROS_EC && I2C
+
+	help
+	  If you say Y here, you get support for talking to the ChromeOS
+	  EC through an I2C bus. This uses a simple byte-level protocol with
+	  a checksum. Failing accesses will be retried three times to
+	  improve reliability.
+
+config CROS_EC_SPI
+	tristate "ChromeOS Embedded Controller (SPI)"
+	depends on MFD_CROS_EC && SPI
+
+	---help---
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  through a SPI bus, using a byte-level protocol. Since the EC's
+	  response time cannot be guaranteed, we support ignoring
+	  'pre-amble' bytes before the response actually starts.
+
 config CROS_EC_LPC
         tristate "ChromeOS Embedded Controller (LPC)"
         depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index e44c37a63fa9..cd591bf872bb 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -6,6 +6,8 @@ obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
 cros_ec_ctl-objs			:= cros_ec_sysfs.o cros_ec_lightbar.o \
 					   cros_ec_vbc.o cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
+obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
+obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
 cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
similarity index 100%
rename from drivers/mfd/cros_ec_i2c.c
rename to drivers/platform/chrome/cros_ec_i2c.c
diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
similarity index 100%
rename from drivers/mfd/cros_ec_spi.c
rename to drivers/platform/chrome/cros_ec_spi.c
-- 
2.18.0

