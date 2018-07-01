Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5588CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15902251CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15902251CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeGALKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:10:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752339AbeGALJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:09:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD20FAFB3;
        Sun,  1 Jul 2018 11:09:03 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC net-next 14/15] net: lora: Prepare Semtech SX1257
Date:   Sun,  1 Jul 2018 13:08:03 +0200
Message-Id: <20180701110804.32415-15-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Semtech SX1257 and Sx1255 are usually used for radios A/B of SX1301.
This will not implement a netdev itself, but rather needs to interface
with SX130x somehow.

Cc: Ben Whitten <ben.whitten@lairdtech.com>
Cc: Steve deRosier <derosier@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Michael Röder <michael.roeder@avnet.eu>
Cc: Ken Yu (禹凯) <ken.yu@rakwireless.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/Kconfig  |  7 ++++
 drivers/net/lora/Makefile |  3 ++
 drivers/net/lora/sx1257.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/net/lora/sx1257.c

diff --git a/drivers/net/lora/Kconfig b/drivers/net/lora/Kconfig
index 3e384493cbdd..68c7480d7812 100644
--- a/drivers/net/lora/Kconfig
+++ b/drivers/net/lora/Kconfig
@@ -31,6 +31,13 @@ config LORA_RN2483
 	help
 	  Microchip RN2483/2903
 
+config LORA_SX1257
+	tristate "Semtech SX125x SPI driver"
+	default y
+	depends on SPI
+	help
+	  Semtech SX1255/1257
+
 config LORA_SX1276
 	tristate "Semtech SX127x SPI driver"
 	default y
diff --git a/drivers/net/lora/Makefile b/drivers/net/lora/Makefile
index 6b6870ffbfd8..44c578bde7d5 100644
--- a/drivers/net/lora/Makefile
+++ b/drivers/net/lora/Makefile
@@ -16,6 +16,9 @@ obj-$(CONFIG_LORA_RN2483) += lora-rn2483.o
 lora-rn2483-y := rn2483.o
 lora-rn2483-y += rn2483_cmd.o
 
+obj-$(CONFIG_LORA_SX1257) += lora-sx1257.o
+lora-sx1257-y := sx1257.o
+
 obj-$(CONFIG_LORA_SX1276) += lora-sx1276.o
 lora-sx1276-y := sx1276.o
 
diff --git a/drivers/net/lora/sx1257.c b/drivers/net/lora/sx1257.c
new file mode 100644
index 000000000000..c4e04ee3ec4b
--- /dev/null
+++ b/drivers/net/lora/sx1257.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Semtech SX1255/SX1257 LoRa transceiver
+ *
+ * Copyright (c) 2018 Andreas Färber
+ *
+ * Based on SX1301 HAL code:
+ * Copyright (c) 2013 Semtech-Cycleo
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+static int sx1257_write(struct spi_device *spi, u8 reg, u8 val)
+{
+	u8 buf[2];
+
+	buf[0] = reg | BIT(7);
+	buf[1] = val;
+	return spi_write(spi, buf, 2);
+}
+
+static int sx1257_read(struct spi_device *spi, u8 reg, u8 *val)
+{
+	u8 addr = reg & 0x7f;
+	return spi_write_then_read(spi, &addr, 1, val, 1);
+}
+
+static int sx1257_probe(struct spi_device *spi)
+{
+	u8 val;
+	int ret;
+
+	if (true) {
+		ret = sx1257_read(spi, 0x07, &val);
+		if (ret) {
+			dev_err(&spi->dev, "version read failed\n");
+			return ret;
+		}
+
+		dev_info(&spi->dev, "SX125x version: %02x\n", (unsigned)val);
+	}
+
+	ret = sx1257_write(spi, 0x10, 1 /* + 2 */);
+	if (ret) {
+		dev_err(&spi->dev, "clk write failed\n");
+		return ret;
+	}
+
+	dev_info(&spi->dev, "clk written\n");
+
+	if (true) {
+		ret = sx1257_write(spi, 0x26, 13 + 2 * 16);
+		if (ret) {
+			dev_err(&spi->dev, "xosc write failed\n");
+			return ret;
+		}
+	}
+
+	dev_info(&spi->dev, "SX1257 module probed\n");
+
+	return 0;
+}
+
+static int sx1257_remove(struct spi_device *spi)
+{
+	dev_info(&spi->dev, "SX1257 module removed\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id sx1257_dt_ids[] = {
+	{ .compatible = "semtech,sx1255" },
+	{ .compatible = "semtech,sx1257" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sx1257_dt_ids);
+#endif
+
+static struct spi_driver sx1257_spi_driver = {
+	.driver = {
+		.name = "sx1257",
+		.of_match_table = of_match_ptr(sx1257_dt_ids),
+	},
+	.probe = sx1257_probe,
+	.remove = sx1257_remove,
+};
+
+module_spi_driver(sx1257_spi_driver);
+
+MODULE_DESCRIPTION("SX1257 SPI driver");
+MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
+MODULE_LICENSE("GPL");
-- 
2.16.4

