Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E0C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FA6251BF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FA6251BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeGALKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:10:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752334AbeGALJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:09:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2471AFA5;
        Sun,  1 Jul 2018 11:09:02 +0000 (UTC)
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
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 13/15] net: lora: Prepare RAK RAK811
Date:   Sun,  1 Jul 2018 13:08:02 +0200
Message-Id: <20180701110804.32415-14-afaerber@suse.de>
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

The RAK811 and RAK812 offer a UART based AT command interface.
It allows both LoRaWAN and LoRa modes.

Cc: Ken Yu (禹凯) <ken.yu@rakwireless.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/Kconfig  |   7 ++
 drivers/net/lora/Makefile |   3 +
 drivers/net/lora/rak811.c | 219 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/net/lora/rak811.c

diff --git a/drivers/net/lora/Kconfig b/drivers/net/lora/Kconfig
index 72a9d2a0f2be..3e384493cbdd 100644
--- a/drivers/net/lora/Kconfig
+++ b/drivers/net/lora/Kconfig
@@ -17,6 +17,13 @@ config LORA_DEV
 
 if LORA_DEV
 
+config LORA_RAK811
+	tristate "RAK RAK811 driver"
+	default y
+	depends on SERIAL_DEV_BUS
+	help
+	  RAK RAK811/RAK812
+
 config LORA_RN2483
 	tristate "Microchip RN2483/RN2903 driver"
 	default y
diff --git a/drivers/net/lora/Makefile b/drivers/net/lora/Makefile
index dfa9a43dcfb3..6b6870ffbfd8 100644
--- a/drivers/net/lora/Makefile
+++ b/drivers/net/lora/Makefile
@@ -9,6 +9,9 @@ lora-dev-y := dev.o
 # Alphabetically sorted.
 #
 
+obj-$(CONFIG_LORA_RAK811) += lora-rak811.o
+lora-rak811-y := rak811.o
+
 obj-$(CONFIG_LORA_RN2483) += lora-rn2483.o
 lora-rn2483-y := rn2483.o
 lora-rn2483-y += rn2483_cmd.o
diff --git a/drivers/net/lora/rak811.c b/drivers/net/lora/rak811.c
new file mode 100644
index 000000000000..ad3d0980c489
--- /dev/null
+++ b/drivers/net/lora/rak811.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RAK RAK811
+ *
+ * Copyright (c) 2017-2018 Andreas Färber
+ */
+
+#include <linux/delay.h>
+#include <linux/lora.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+#include <linux/lora/dev.h>
+
+struct rak811_device {
+	struct serdev_device *serdev;
+
+	char rx_buf[4096];
+	int rx_len;
+
+	struct completion line_recv_comp;
+};
+
+static int rak811_send_command(struct rak811_device *rakdev, const char *cmd, char **data, unsigned long timeout)
+{
+	struct serdev_device *sdev = rakdev->serdev;
+	const char *crlf = "\r\n";
+	char *resp;
+
+	serdev_device_write_buf(sdev, cmd, strlen(cmd));
+	serdev_device_write_buf(sdev, crlf, 2);
+
+	timeout = wait_for_completion_timeout(&rakdev->line_recv_comp, timeout);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	resp = rakdev->rx_buf;
+	dev_dbg(&sdev->dev, "Received: '%s'\n", resp);
+	if (data)
+		*data = kstrdup(resp, GFP_KERNEL);
+
+	rakdev->rx_len = 0;
+	reinit_completion(&rakdev->line_recv_comp);
+
+	return 0;
+}
+
+static int rak811_simple_cmd(struct rak811_device *rakdev, const char *cmd, unsigned long timeout)
+{
+	char *resp;
+	int ret;
+
+	ret = rak811_send_command(rakdev, cmd, &resp, timeout);
+	if (ret)
+		return ret;
+
+	if (strncmp(resp, "OK", 2) == 0) {
+		kfree(resp);
+		return 0;
+	}
+
+	kfree(resp);
+
+	return -EINVAL;
+}
+
+static int rak811_get_version(struct rak811_device *rakdev, char **version, unsigned long timeout)
+{
+	char *resp;
+	int ret;
+
+	ret = rak811_send_command(rakdev, "at+version", &resp, timeout);
+	if (ret)
+		return ret;
+
+	if (strncmp(resp, "OK", 2) == 0) {
+		*version = kstrdup(resp + 2, GFP_KERNEL);
+		kfree(resp);
+		return 0;
+	}
+
+	kfree(resp);
+
+	return -EINVAL;
+}
+
+static int rak811_receive_buf(struct serdev_device *sdev, const u8 *data, size_t count)
+{
+	struct rak811_device *rakdev = serdev_device_get_drvdata(sdev);
+	size_t i = 0;
+	int len = 0;
+
+	dev_dbg(&sdev->dev, "Receive (%d)\n", (int)count);
+
+	for (i = 0; i < count; i++) {
+		dev_dbg(&sdev->dev, "Receive: 0x%02x\n", (int)data[i]);
+	}
+
+	if (completion_done(&rakdev->line_recv_comp)) {
+		dev_info(&sdev->dev, "RX waiting on completion\n");
+		return 0;
+	}
+	if (rakdev->rx_len == sizeof(rakdev->rx_buf) - 1) {
+		dev_warn(&sdev->dev, "RX buffer full\n");
+		return 0;
+	}
+
+	i = min(count, sizeof(rakdev->rx_buf) - 1 - rakdev->rx_len);
+	if (i > 0) {
+		memcpy(&rakdev->rx_buf[rakdev->rx_len], data, i);
+		rakdev->rx_len += i;
+		len += i;
+	}
+	if (rakdev->rx_len >= 2 && strncmp(&rakdev->rx_buf[rakdev->rx_len - 2], "\r\n", 2) == 0) {
+		rakdev->rx_len -= 2;
+		rakdev->rx_buf[rakdev->rx_len] = '\0';
+		complete(&rakdev->line_recv_comp);
+	}
+
+	return len;
+}
+
+static const struct serdev_device_ops rak811_serdev_client_ops = {
+	.receive_buf = rak811_receive_buf,
+};
+
+static int rak811_probe(struct serdev_device *sdev)
+{
+	struct rak811_device *rakdev;
+	char *sz;
+	int ret;
+
+	dev_info(&sdev->dev, "Probing\n");
+
+	rakdev = devm_kzalloc(&sdev->dev, sizeof(struct rak811_device), GFP_KERNEL);
+	if (!rakdev)
+		return -ENOMEM;
+
+	rakdev->serdev = sdev;
+	init_completion(&rakdev->line_recv_comp);
+	serdev_device_set_drvdata(sdev, rakdev);
+
+	ret = serdev_device_open(sdev);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to open (%d)\n", ret);
+		return ret;
+	}
+
+	serdev_device_set_baudrate(sdev, 115200);
+	serdev_device_set_flow_control(sdev, false);
+	serdev_device_set_client_ops(sdev, &rak811_serdev_client_ops);
+
+	ret = rak811_get_version(rakdev, &sz, HZ);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to get version (%d)\n", ret);
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	dev_info(&sdev->dev, "firmware version: %s\n", sz);
+	kfree(sz);
+
+	ret = rak811_simple_cmd(rakdev, "at+mode=1", 2 * HZ);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to set mode to P2P (%d)\n", ret);
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	dev_info(&sdev->dev, "Done.\n");
+
+	return 0;
+}
+
+static void rak811_remove(struct serdev_device *sdev)
+{
+	serdev_device_close(sdev);
+
+	dev_info(&sdev->dev, "Removed\n");
+}
+
+static const struct of_device_id rak811_of_match[] = {
+	{ .compatible = "rakwireless,rak811" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rak811_of_match);
+
+static struct serdev_device_driver rak811_serdev_driver = {
+	.probe = rak811_probe,
+	.remove = rak811_remove,
+	.driver = {
+		.name = "rak811",
+		.of_match_table = rak811_of_match,
+	},
+};
+
+static int __init rak811_init(void)
+{
+	int ret;
+
+	ret = serdev_device_driver_register(&rak811_serdev_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit rak811_exit(void)
+{
+	serdev_device_driver_unregister(&rak811_serdev_driver);
+}
+
+module_init(rak811_init);
+module_exit(rak811_exit);
+
+MODULE_DESCRIPTION("RAK811 serdev driver");
+MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
+MODULE_LICENSE("GPL");
-- 
2.16.4

