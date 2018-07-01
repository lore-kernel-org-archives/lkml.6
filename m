Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B656C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54216251CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54216251CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeGALK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:10:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752332AbeGALJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:09:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44ED3AFA4;
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
Subject: [RFC net-next 12/15] net: lora: Add USI WM-SG-SM-42
Date:   Sun,  1 Jul 2018 13:08:01 +0200
Message-Id: <20180701110804.32415-13-afaerber@suse.de>
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

The USI WM-SG-SM-42 offers a UART based AT command interface.

Cc: Dollar Chen (陳義元) <dollar.chen@wtmec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/Kconfig  |   7 +
 drivers/net/lora/Makefile |   3 +
 drivers/net/lora/usi.c    | 411 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 421 insertions(+)
 create mode 100644 drivers/net/lora/usi.c

diff --git a/drivers/net/lora/Kconfig b/drivers/net/lora/Kconfig
index 2e05caef8645..72a9d2a0f2be 100644
--- a/drivers/net/lora/Kconfig
+++ b/drivers/net/lora/Kconfig
@@ -31,6 +31,13 @@ config LORA_SX1276
 	help
 	  Semtech SX1272/1276/1278
 
+config LORA_USI
+	tristate "USI WM-SG-SM-42 driver"
+	default y
+	depends on SERIAL_DEV_BUS
+	help
+	  USI WM-SG-SM-42
+
 config LORA_WIMOD
 	tristate "IMST WiMOD driver"
 	default y
diff --git a/drivers/net/lora/Makefile b/drivers/net/lora/Makefile
index ecb326c859a5..dfa9a43dcfb3 100644
--- a/drivers/net/lora/Makefile
+++ b/drivers/net/lora/Makefile
@@ -16,5 +16,8 @@ lora-rn2483-y += rn2483_cmd.o
 obj-$(CONFIG_LORA_SX1276) += lora-sx1276.o
 lora-sx1276-y := sx1276.o
 
+obj-$(CONFIG_LORA_USI) += lora-usi.o
+lora-usi-y := usi.o
+
 obj-$(CONFIG_LORA_WIMOD) += lora-wimod.o
 lora-wimod-y := wimod.o
diff --git a/drivers/net/lora/usi.c b/drivers/net/lora/usi.c
new file mode 100644
index 000000000000..f0c697e2cde2
--- /dev/null
+++ b/drivers/net/lora/usi.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * USI WM-SG-SM-42
+ *
+ * Copyright (c) 2017-2018 Andreas Färber
+ */
+
+#include <linux/lora.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+#include <linux/lora/dev.h>
+
+struct usi_device {
+	struct serdev_device *serdev;
+
+	int mode;
+
+	char rx_buf[4096];
+	int rx_len;
+
+	struct completion prompt_recv_comp;
+	struct completion tx_event_recv_comp;
+};
+
+static bool usi_cmd_ok(const char *resp)
+{
+	int len = strlen(resp);
+
+	return (len == 4 && !strcmp(resp, "OK\r\n")) ||
+	       (len >= 6 && !strcmp(resp + len - 6, "\r\nOK\r\n"));
+}
+
+static int usi_send_command(struct usi_device *usidev, const char *cmd, char **data, unsigned long timeout)
+{
+	struct serdev_device *sdev = usidev->serdev;
+	const char cr = '\r';
+	int cmd_len, resp_len;
+	char *resp;
+
+	cmd_len = strlen(cmd);
+	serdev_device_write_buf(sdev, cmd, cmd_len);
+	serdev_device_write_buf(sdev, &cr, 1);
+
+	timeout = wait_for_completion_timeout(&usidev->prompt_recv_comp, timeout);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	resp = usidev->rx_buf;
+	resp_len = usidev->rx_len;
+	if (!strncmp(resp, cmd, cmd_len) && resp[cmd_len] == '\r') {
+		dev_dbg(&sdev->dev, "Skipping echo\n");
+		resp += cmd_len + 1;
+		resp_len -= cmd_len + 1;
+	}
+	dev_dbg(&sdev->dev, "Received: '%s'\n", resp);
+	if (data)
+		*data = kstrdup(resp, GFP_KERNEL);
+
+	usidev->rx_len = 0;
+	reinit_completion(&usidev->prompt_recv_comp);
+
+	return 0;
+}
+
+static int usi_simple_cmd(struct usi_device *usidev, const char *cmd, unsigned long timeout)
+{
+	char *resp;
+	int ret;
+
+	ret = usi_send_command(usidev, cmd, &resp, timeout);
+	if (ret)
+		return ret;
+
+	if (strcmp(resp, "OK\r\n") == 0) {
+		kfree(resp);
+		return 0;
+	}
+
+	kfree(resp);
+
+	return -EINVAL;
+}
+
+static int usi_cmd_reset(struct usi_device *usidev)
+{
+	int ret;
+
+	ret = usi_send_command(usidev, "ATZ", NULL, HZ);
+	if (ret)
+		return ret;
+
+	mdelay(1000);
+
+	return 0;
+}
+
+static int usi_cmd_read_reg(struct usi_device *usidev, u8 addr, u8 *val)
+{
+	char *cmd;
+	char *resp;
+	char *sz;
+	int ret;
+
+	cmd = kasprintf(GFP_KERNEL, "AT+RREG=0x%02x", (int)addr);
+	if (!cmd)
+		return -ENOMEM;
+
+	ret = usi_send_command(usidev, cmd, &resp, HZ);
+	if (ret) {
+		kfree(cmd);
+		return ret;
+	}
+	if (!usi_cmd_ok(resp)) {
+		kfree(resp);
+		kfree(cmd);
+		return -EINVAL;
+	}
+	resp[strlen(resp) - 6] = '\0';
+	sz = resp;
+	if (strstarts(sz, "+Reg="))
+		sz += 5;
+	if (strncasecmp(sz, cmd + 8, 4) == 0 && strstarts(sz + 4, ", "))
+		sz += 6;
+
+	kfree(cmd);
+
+	dev_dbg(&usidev->serdev->dev, "Parsing '%s'\n", sz);
+	ret = kstrtou8(sz, 0, val);
+	if (ret) {
+		kfree(resp);
+		return ret;
+	}
+
+	kfree(resp);
+
+	return 0;
+}
+
+static int usi_receive_buf(struct serdev_device *sdev, const u8 *data, size_t count)
+{
+	struct usi_device *usidev = serdev_device_get_drvdata(sdev);
+	size_t i = 0;
+	int len = 0;
+
+	dev_dbg(&sdev->dev, "Receive (%d)\n", (int)count);
+
+	for (i = 0; i < count; i++) {
+		dev_dbg(&sdev->dev, "Receive: 0x%02x\n", (int)data[i]);
+	}
+	i = 0;
+
+	if (completion_done(&usidev->prompt_recv_comp) ||
+	    completion_done(&usidev->tx_event_recv_comp)) {
+		dev_info(&sdev->dev, "RX waiting on completion\n");
+		return 0;
+	}
+	if (usidev->rx_len == sizeof(usidev->rx_buf) - 1) {
+		dev_warn(&sdev->dev, "RX buffer full\n");
+		return 0;
+	}
+
+	i = min(count, sizeof(usidev->rx_buf) - 1 - usidev->rx_len);
+	if (i > 0) {
+		memcpy(&usidev->rx_buf[usidev->rx_len], data, i);
+		usidev->rx_len += i;
+		len += i;
+	}
+	if (usidev->rx_len >= 3 && strncmp(&usidev->rx_buf[usidev->rx_len - 3], "\r# ", 3) == 0) {
+		usidev->rx_len -= 3;
+		usidev->rx_buf[usidev->rx_len] = '\0';
+		complete(&usidev->prompt_recv_comp);
+	} else if (usidev->rx_len > 7 && strstarts(usidev->rx_buf, "+RCV") &&
+			strncmp(&usidev->rx_buf[usidev->rx_len - 2], "\r\n", 2) == 0) {
+		usidev->rx_buf[usidev->rx_len - 2] = '\0';
+		dev_info(&sdev->dev, "RCV event: '%s'\n", usidev->rx_buf + 4);
+		usidev->rx_len = 0;
+	} else if (usidev->rx_len > 6 && strstarts(usidev->rx_buf, "+TX: ") &&
+			strncmp(&usidev->rx_buf[usidev->rx_len - 2], "\r\n", 2) == 0) {
+		usidev->rx_buf[usidev->rx_len - 2] = '\0';
+		dev_info(&sdev->dev, "TX event: '%s'\n", usidev->rx_buf + 5);
+		complete(&usidev->tx_event_recv_comp);
+	}
+
+	return len;
+}
+
+static const struct serdev_device_ops usi_serdev_client_ops = {
+	.receive_buf = usi_receive_buf,
+};
+
+static int usi_probe(struct serdev_device *sdev)
+{
+	struct usi_device *usidev;
+	//unsigned long timeout;
+	char *resp;
+	u8 val;
+	int ret;
+
+	dev_info(&sdev->dev, "Probing");
+
+	usidev = devm_kzalloc(&sdev->dev, sizeof(struct usi_device), GFP_KERNEL);
+	if (!usidev)
+		return -ENOMEM;
+
+	usidev->serdev = sdev;
+	usidev->mode = -1;
+	init_completion(&usidev->prompt_recv_comp);
+	init_completion(&usidev->tx_event_recv_comp);
+	serdev_device_set_drvdata(sdev, usidev);
+
+	ret = serdev_device_open(sdev);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to open (%d)", ret);
+		return ret;
+	}
+
+	serdev_device_set_baudrate(sdev, 115200);
+	serdev_device_set_flow_control(sdev, false);
+	serdev_device_set_client_ops(sdev, &usi_serdev_client_ops);
+
+	ret = usi_cmd_reset(usidev);
+	if (ret)
+		dev_warn(&sdev->dev, "Reset failed\n");
+
+	ret = usi_send_command(usidev, "ATE=0", NULL, HZ);
+	if (ret)
+		dev_warn(&sdev->dev, "ATE failed\n");
+
+	/* Dropped in firmware 2.8 */
+	ret = usi_send_command(usidev, "ATI", &resp, HZ);
+	if (!ret) {
+		if (usi_cmd_ok(resp)) {
+			resp[strlen(resp) - 6] = '\0';
+			dev_info(&sdev->dev, "Firmware '%s'\n", resp);
+		}
+		kfree(resp);
+	}
+
+	ret = usi_send_command(usidev, "AT+DEFMODE", &resp, HZ);
+	if (ret) {
+		dev_err(&sdev->dev, "Checking DEFMODE failed (%d)\n", ret);
+		serdev_device_close(sdev);
+		return ret;
+	}
+	if (usi_cmd_ok(resp)) {
+		resp[strlen(resp) - 6] = '\0';
+		dev_info(&sdev->dev, "Default mode '%s'\n", resp);
+		if (!strcmp(resp, "MFG_WAN_MODE"))
+			usidev->mode = 6;
+		else if (!strcmp(resp, "MFG_TEST_IDLE"))
+			usidev->mode = 0;
+		else if (!strcmp(resp, "MFG_TX_TONE"))
+			usidev->mode = 1;
+		else if (!strcmp(resp, "MFG_TX_PACKET"))
+			usidev->mode = 2;
+		else if (!strcmp(resp, "MFG_ERROR_LESS_ARGUMENETS"))
+			usidev->mode = 3;
+		else if (!strcmp(resp, "MFG_TX_TEXT"))
+			usidev->mode = 4;
+		else if (!strcmp(resp, "MFG_TEST_STOP"))
+			usidev->mode = 5;
+	}
+	kfree(resp);
+
+	if (usidev->mode != 3) {
+		ret = usi_simple_cmd(usidev, "AT+DEFMODE=3", HZ);
+		if (ret) {
+			dev_err(&sdev->dev, "Setting DEFMODE failed (%d)\n", ret);
+			serdev_device_close(sdev);
+			return ret;
+		}
+
+#if 1
+		ret = usi_simple_cmd(usidev, "AT+WDCT", 5 * HZ);
+		if (ret) {
+			dev_err(&sdev->dev, "Writing DCT failed (%d)\n", ret);
+			serdev_device_close(sdev);
+			return ret;
+		}
+
+		ret = usi_cmd_reset(usidev);
+		if (ret) {
+			dev_err(&sdev->dev, "Reset failed\n");
+			serdev_device_close(sdev);
+			return ret;
+		}
+
+		ret = usi_send_command(usidev, "ATE=0", NULL, HZ);
+		if (ret)
+			dev_warn(&sdev->dev, "ATE failed\n");
+#endif
+
+		usidev->mode = -1;
+		ret = usi_send_command(usidev, "AT+DEFMODE", &resp, HZ);
+		if (ret) {
+			dev_err(&sdev->dev, "Checking DEFMODE failed (%d)\n", ret);
+			serdev_device_close(sdev);
+			return ret;
+		}
+		if (usi_cmd_ok(resp)) {
+			resp[strlen(resp) - 6] = '\0';
+			dev_info(&sdev->dev, "Default mode '%s'\n", resp);
+			if (!strcmp(resp, "MFG_WAN_MODE")) {
+				usidev->mode = 6;
+			}
+		}
+		kfree(resp);
+	}
+
+	ret = usi_send_command(usidev, "AT+VER", &resp, HZ);
+	if (!ret) {
+		if (usi_cmd_ok(resp)) {
+			resp[strlen(resp) - 6] = '\0';
+			dev_info(&sdev->dev, "LoRaWAN version '%s'\n",
+				(strstarts(resp, "+VER=")) ? (resp + 5) : resp);
+		}
+		kfree(resp);
+	}
+
+	ret = usi_simple_cmd(usidev, "AT+RF=20,868000000,7,0,1,0,8,0,0,0", HZ);
+	if (ret) {
+		dev_err(&sdev->dev, "AT+RF failed (%d)\n", ret);
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	/*ret = usi_simple_cmd(usidev, "AT+TXT=1,deadbeef", 2 * HZ);
+	if (ret) {
+		dev_err(&sdev->dev, "TX failed (%d)\n", ret);
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	timeout = wait_for_completion_timeout(&usidev->tx_event_recv_comp, 5 * HZ);
+	if (!timeout) {
+		serdev_device_close(sdev);
+		return -ETIMEDOUT;
+	}
+	usidev->rx_len = 0;
+	reinit_completion(&usidev->tx_event_recv_comp);*/
+
+	ret = usi_cmd_read_reg(usidev, 0x42, &val);
+	if (!ret) {
+		dev_info(&sdev->dev, "SX1272 VERSION 0x%02x\n", (int)val);
+	}
+
+	ret = usi_cmd_read_reg(usidev, 0x39, &val);
+	if (!ret) {
+		dev_info(&sdev->dev, "SX1272 SyncWord 0x%02x\n", (int)val);
+	}
+
+	ret = usi_cmd_read_reg(usidev, 0x01, &val);
+	if (!ret) {
+		dev_info(&sdev->dev, "SX1272 OpMode 0x%02x\n", (int)val);
+	}
+
+	dev_info(&sdev->dev, "Done.");
+
+	return 0;
+}
+
+static void usi_remove(struct serdev_device *sdev)
+{
+	struct usi_device *usidev = serdev_device_get_drvdata(sdev);
+
+	usi_send_command(usidev, "ATE=1\r", NULL, HZ);
+
+	serdev_device_close(sdev);
+
+	dev_info(&sdev->dev, "Removed\n");
+}
+
+static const struct of_device_id usi_of_match[] = {
+	{ .compatible = "usi,wm-sg-sm-42" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, usi_of_match);
+
+static struct serdev_device_driver usi_serdev_driver = {
+	.probe = usi_probe,
+	.remove = usi_remove,
+	.driver = {
+		.name = "usi",
+		.of_match_table = usi_of_match,
+	},
+};
+
+static int __init usi_init(void)
+{
+	int ret;
+
+	ret = serdev_device_driver_register(&usi_serdev_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit usi_exit(void)
+{
+	serdev_device_driver_unregister(&usi_serdev_driver);
+}
+
+module_init(usi_init);
+module_exit(usi_exit);
+
+MODULE_DESCRIPTION("USI WM-SG-SM-42 serdev driver");
+MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
+MODULE_LICENSE("GPL");
-- 
2.16.4

