Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8B208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfADLWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:22:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:52448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727690AbfADLVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:21:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C51C1AEB0;
        Fri,  4 Jan 2019 11:21:44 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH lora-next 3/5] net: lora: sx130x: Add PicoCell serdev driver
Date:   Fri,  4 Jan 2019 12:21:29 +0100
Message-Id: <20190104112131.14451-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104112131.14451-1-afaerber@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The picoGW reference MCU firmware implements a USB CDC or UART interface
with a set of serial commands. It can be found on multiple mPCIe cards
as well as USB adapters.

  https://github.com/Lora-net/picoGW_mcu

That MCU design superseded earlier attempts of using FTDI chips (MPSSE)
for controlling the SPI based chip directly from the host.

This commit adds a serdev driver implementing another regmap_bus to
abstract the register access and reuses our existing regmap driver on top.
Thereby we have an early proof of concept that we can drive both types
of modules/cards with a single driver core!

It assumes there is only one SX130x (with its radios) accessible, whereas
some new cards reportedly also have an SX127x on-board. So the DT/driver
design may need to be reconsidered once such a card or documentation
becomes available.
It also assumes SX1255/1258 are fully compatible with "semtech,sx1257".

Currently there's still some bugs to be investigated, with communication
stalling on one device and another reading the radio versions wrong
(07 / 1f instead of 21, also observed on spi once).

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/Makefile        |   2 +
 drivers/net/lora/sx130x_picogw.c | 466 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 468 insertions(+)
 create mode 100644 drivers/net/lora/sx130x_picogw.c

diff --git a/drivers/net/lora/Makefile b/drivers/net/lora/Makefile
index c6a0410f80ce..5fef38abf5ed 100644
--- a/drivers/net/lora/Makefile
+++ b/drivers/net/lora/Makefile
@@ -25,6 +25,8 @@ lora-sx127x-y := sx127x.o
 obj-$(CONFIG_LORA_SX130X) += lora-sx130x.o
 lora-sx130x-y := sx130x.o
 lora-sx130x-y += sx130x_radio.o
+obj-$(CONFIG_LORA_SX130X) += lora-sx130x-picogw.o
+lora-sx130x-picogw-y := sx130x_picogw.o
 
 obj-$(CONFIG_LORA_USI) += lora-usi.o
 lora-usi-y := usi.o
diff --git a/drivers/net/lora/sx130x_picogw.c b/drivers/net/lora/sx130x_picogw.c
new file mode 100644
index 000000000000..577f9fb71d46
--- /dev/null
+++ b/drivers/net/lora/sx130x_picogw.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Semtech SX1301/1308 PicoCell gateway serial MCU interface
+ *
+ * Copyright (c) 2018-2019 Andreas Färber
+ */
+#include <linux/completion.h>
+#include <linux/lora/sx130x.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/serdev.h>
+#include <linux/serial.h>
+#include <linux/slab.h>
+
+struct picogw_device {
+	struct serdev_device *serdev;
+
+	u8 rx_buf[1024];
+	int rx_len;
+
+	struct completion answer_comp;
+	struct completion answer_read_comp;
+};
+
+static inline struct picogw_device *picogw_get_drvdata(struct serdev_device *sdev)
+{
+	return sx130x_get_drvdata(&sdev->dev);
+}
+
+static bool picogw_valid_cmd(char ch)
+{
+	switch (ch) {
+	case 'k': /* invalid command error */
+	case 'r':
+	case 'w':
+	case 'l':
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int picogw_send_cmd(struct picogw_device *picodev, char cmd,
+	u8 addr, const void *data, u16 data_len)
+{
+	struct serdev_device *sdev = picodev->serdev;
+	u8 buf[4];
+	int i, ret;
+
+	buf[0] = cmd;
+	buf[1] = (data_len >> 8) & 0xff;
+	buf[2] = (data_len >> 0) & 0xff;
+	buf[3] = addr;
+
+	dev_dbg(&sdev->dev, "%s: %c %02x %02x %02x\n", __func__, buf[0],
+		(unsigned int)buf[1], (unsigned int)buf[2], (unsigned int)buf[3]);
+	for (i = 0; i < data_len; i++) {
+		dev_dbg(&sdev->dev, "%s: data %02x\n", __func__, (unsigned int)((const u8*)data)[i]);
+	}
+
+	ret = serdev_device_write_buf(sdev, buf, 4);
+	if (ret < 0)
+		return ret;
+	if (ret != 4)
+		return -EIO;
+
+	if (data_len) {
+		ret = serdev_device_write_buf(sdev, data, data_len);
+		if (ret < 0)
+			return ret;
+		if (ret != data_len)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int picogw_recv_answer(struct picogw_device *picodev,
+	char *cmd, bool *ack, void *buf, int buf_len,
+	unsigned long timeout)
+{
+	int len;
+
+	timeout = wait_for_completion_timeout(&picodev->answer_comp, timeout);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	if (cmd)
+		*cmd = picodev->rx_buf[0];
+
+	if (ack)
+		*ack = (picodev->rx_buf[3] == 1);
+
+	len = min(picodev->rx_len - 4, buf_len);
+	if (buf)
+		memcpy(buf, picodev->rx_buf + 4, len);
+
+	reinit_completion(&picodev->answer_comp);
+	complete(&picodev->answer_read_comp);
+
+	return len;
+}
+
+static int picogw_reg_read(struct picogw_device *picodev, u8 addr, u8 *val, unsigned long timeout)
+{
+	const u8 dummy = 0;
+	char cmd;
+	bool ack;
+	int ret;
+
+	ret = picogw_send_cmd(picodev, 'r', addr, &dummy, false ? 1 : 0);
+	if (ret)
+		return ret;
+
+	ret = picogw_recv_answer(picodev, &cmd, &ack, val, 1, timeout);
+	if (ret < 0)
+		return ret;
+	if (cmd != 'r')
+		return -EIO;
+	if (!ack || ret != 1)
+		return -EIO;
+
+	return 0;
+}
+
+static int picogw_reg_write(struct picogw_device *picodev, u8 addr, u8 val, unsigned long timeout)
+{
+	char cmd;
+	bool ack;
+	int ret;
+
+	ret = picogw_send_cmd(picodev, 'w', addr, &val, 1);
+	if (ret)
+		return ret;
+
+	ret = picogw_recv_answer(picodev, &cmd, &ack, NULL, 0, timeout);
+	if (ret < 0)
+		return ret;
+	if (cmd != 'w')
+		return -EIO;
+	if (!ack || ret != 0)
+		return -EIO;
+
+	return 0;
+}
+
+static int picogw_mcu_fw_check(struct picogw_device *picodev,
+	u32 fw_version, u8 *id, unsigned long timeout)
+{
+	char cmd;
+	bool ack;
+	int ret;
+
+	fw_version = cpu_to_be32(fw_version);
+	ret = picogw_send_cmd(picodev, 'l', 0, &fw_version, sizeof(fw_version));
+	if (ret)
+		return ret;
+
+	ret = picogw_recv_answer(picodev, &cmd, &ack, id, id ? 8 : 0, timeout);
+	if (ret < 0)
+		return ret;
+	if (cmd != 'l')
+		return -EIO;
+	if (id && ret != 8)
+		return -EIO;
+
+	return ack ? 0 : -ENOTSUPP;
+}
+
+static int picogw_regmap_gather_write(void *context,
+	const void *reg_buf, size_t reg_size, const void *val_buf, size_t val_size)
+{
+	struct picogw_device *picodev = context;
+	const u8 *addr_buf = reg_buf;
+	const u8 *val = val_buf;
+	u8 addr;
+	int ret;
+
+	//dev_dbg(&picodev->serdev->dev, "%s: 0x%x (reg_size %zu) 0x%x (val_size %zu)\n",
+	//	__func__, (unsigned int)addr_buf[0], reg_size, (unsigned int)val[0], val_size);
+
+	if (reg_size != 1 || val_size > 0xffff)
+		return -EINVAL;
+
+	addr = addr_buf[0] & ~BIT(7);
+	if (val_size == 1) {
+		ret = picogw_reg_write(picodev, addr, val[0], HZ);
+		if (ret)
+			return ret;
+		return 0;
+	} else {
+		/* TODO burst mode */
+		dev_err(&picodev->serdev->dev, "burst mode write not yet implemented\n");
+		return -ENOTSUPP;
+	}
+}
+
+static int picogw_regmap_write(void *context,
+	const void *data_buf, size_t count)
+{
+	const u8 *data = data_buf;
+	if (count < 1)
+		return -EINVAL;
+
+	return picogw_regmap_gather_write(context, data, 1, data + 1, count - 1);
+}
+
+static int picogw_regmap_read(void *context,
+	const void *reg_buf, size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct picogw_device *picodev = context;
+	const u8 *addr_buf = reg_buf;
+	u8 addr;
+	int ret;
+
+	//dev_dbg(&picodev->serdev->dev, "%s: 0x%x (reg_size %zu) (val_size %zu)\n", __func__, (unsigned int)addr_buf[0], reg_size, val_size);
+
+	if (reg_size != 1 || val_size > 0xffff)
+		return -EINVAL;
+
+	addr = addr_buf[0] & ~BIT(7);
+	if (val_size == 1) {
+		ret = picogw_reg_read(picodev, addr, val_buf, HZ);
+		if (ret)
+			return ret;
+		return 0;
+	} else {
+		/* TODO burst mode */
+		dev_err(&picodev->serdev->dev, "burst mode read not yet implemented\n");
+		return -ENOTSUPP;
+	}
+}
+
+static const struct regmap_bus picogw_regmap_bus = {
+	.write = picogw_regmap_write,
+	.gather_write = picogw_regmap_gather_write,
+	.read = picogw_regmap_read,
+
+	.max_raw_write = 0xffff,
+	.max_raw_read = 0xffff,
+};
+
+static int picogw_handle_answer(struct picogw_device *picodev)
+{
+	struct device *dev = &picodev->serdev->dev;
+	unsigned int data_len = ((u16)picodev->rx_buf[1] << 8) | picodev->rx_buf[2];
+	int cmd_len = 4 + data_len;
+	int i, ret;
+
+	if (picodev->rx_len < 4)
+		return 0;
+
+	if (cmd_len > sizeof(picodev->rx_buf)) {
+		dev_warn(dev, "answer too long (%u)\n", data_len);
+		return 0;
+	}
+
+	if (picodev->rx_len < cmd_len) {
+		dev_dbg(dev, "got %u, need %u bytes\n", picodev->rx_len, cmd_len);
+		return 0;
+	}
+
+	dev_dbg(dev, "Answer %c =%u %s (%u)\n", picodev->rx_buf[0],
+		(unsigned int)picodev->rx_buf[3],
+		(picodev->rx_buf[3] == 1) ? "OK" : "K0",
+		data_len);
+	for (i = 0; i < data_len; i++) {
+		//dev_dbg(dev, "%s: %02x\n", __func__, (unsigned int)picodev->rx_buf[4 + i]);
+	}
+
+	complete(&picodev->answer_comp);
+	ret = wait_for_completion_interruptible_timeout(&picodev->answer_read_comp, HZ / 2);
+	if (ret < 0)
+		return 0;
+
+	reinit_completion(&picodev->answer_read_comp);
+
+	return cmd_len;
+}
+
+static int picogw_receive_buf(struct serdev_device *sdev, const u8 *data, size_t count)
+{
+	struct picogw_device *picodev = picogw_get_drvdata(sdev);
+	size_t i;
+	int len = 0;
+
+	dev_dbg(&sdev->dev, "Receive (%zu)\n", count);
+
+	if (completion_done(&picodev->answer_comp)) {
+		dev_info(&sdev->dev, "RX waiting on completion\n");
+		return 0;
+	}
+	if (picodev->rx_len == sizeof(picodev->rx_buf)) {
+		dev_warn(&sdev->dev, "RX buffer full\n");
+		return 0;
+	}
+
+	i = min(count, sizeof(picodev->rx_buf) - picodev->rx_len);
+	if (i > 0) {
+		memcpy(&picodev->rx_buf[picodev->rx_len], data, i);
+		picodev->rx_len += i;
+		len += i;
+	}
+
+	while (picodev->rx_len > 0) {
+		/* search for valid beginning */
+		for (i = 0; i < picodev->rx_len; i++) {
+			if (picogw_valid_cmd(picodev->rx_buf[i]))
+				break;
+		}
+		if (i > 0) {
+			dev_dbg(&sdev->dev, "skipping %zu bytes of garbage\n", i);
+			if (i < picodev->rx_len) {
+				memmove(picodev->rx_buf, &picodev->rx_buf[i], picodev->rx_len - i);
+				picodev->rx_len -= i;
+			} else
+				picodev->rx_len = 0;
+		}
+
+		i = picogw_handle_answer(picodev);
+		if (i == 0)
+			break;
+
+		if (i % 64 == 0) {
+			dev_info(&sdev->dev, "skipping padding byte\n");
+			i++;
+		}
+		if (picodev->rx_len > i)
+			memmove(picodev->rx_buf, &picodev->rx_buf[i], picodev->rx_len - i);
+		if (picodev->rx_len >= i)
+			picodev->rx_len -= i;
+	}
+
+	return len;
+}
+
+static const struct serdev_device_ops picogw_serdev_client_ops = {
+	.receive_buf = picogw_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static int picogw_serdev_probe(struct serdev_device *sdev)
+{
+	struct picogw_device *picodev;
+	struct regmap *regmap;
+	u32 fw_version = 0x010a0006;
+	u8 mac[8];
+	int ret;
+
+	//dev_info(&sdev->dev, "Probing\n");
+
+	picodev = devm_kzalloc(&sdev->dev, sizeof(*picodev), GFP_KERNEL);
+	if (!picodev)
+		return -ENOMEM;
+
+	picodev->serdev = sdev;
+	init_completion(&picodev->answer_comp);
+	init_completion(&picodev->answer_read_comp);
+
+	ret = serdev_device_open(sdev);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to open (%d)\n", ret);
+		return ret;
+	}
+
+	serdev_device_set_baudrate(sdev, 115200);
+	serdev_device_set_parity(sdev, SERDEV_PARITY_NONE);
+	serdev_device_set_flow_control(sdev, true);
+
+	regmap = devm_regmap_init(&sdev->dev, &picogw_regmap_bus, picodev, &sx130x_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&sdev->dev, "error initializing regmap (%d)\n", ret);
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	ret = sx130x_early_probe(regmap, NULL);
+	if (ret) {
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	sx130x_set_drvdata(&sdev->dev, picodev);
+	serdev_device_set_client_ops(sdev, &picogw_serdev_client_ops);
+
+	//msleep(1000);
+	ret = picogw_mcu_fw_check(picodev, fw_version, mac, HZ);
+	if (!ret || ret == -ENOTSUPP)
+		dev_info(&sdev->dev, "ID = %02x%02x%02x%02x%02x%02x%02x%02x\n",
+			(unsigned int)mac[0],
+			(unsigned int)mac[1],
+			(unsigned int)mac[2],
+			(unsigned int)mac[3],
+			(unsigned int)mac[4],
+			(unsigned int)mac[5],
+			(unsigned int)mac[6],
+			(unsigned int)mac[7]);
+	while (ret == -ENOTSUPP && ((fw_version & 0xff) > 4)) {
+		ret = picogw_mcu_fw_check(picodev, --fw_version, NULL, HZ);
+	}
+	if (ret == -ENOTSUPP) {
+		dev_warn(&sdev->dev, "firmware check failed (%08x)\n", fw_version);
+	} else {
+		dev_err(&sdev->dev, "ID retrieval failed (%d)\n", ret);
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	ret = sx130x_probe(&sdev->dev);
+	if (ret) {
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	//dev_info(&sdev->dev, "Done.\n");
+
+	return 0;
+}
+
+static void picogw_serdev_remove(struct serdev_device *sdev)
+{
+	sx130x_remove(&sdev->dev);
+
+	serdev_device_close(sdev);
+
+	//dev_info(&sdev->dev, "Removed\n");
+}
+
+static const struct of_device_id picogw_serdev_of_match[] = {
+	{ .compatible = "semtech,lora-picocell" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, picogw_serdev_of_match);
+
+static struct serdev_device_driver picogw_serdev_driver = {
+	.probe = picogw_serdev_probe,
+	.remove = picogw_serdev_remove,
+	.driver = {
+		.name = "lora-picogw",
+		.of_match_table = picogw_serdev_of_match,
+	},
+};
+
+static int __init picogw_serdev_init(void)
+{
+	int ret;
+
+	ret = serdev_device_driver_register(&picogw_serdev_driver);
+	if (ret) {
+		pr_err("serdev_device_driver_register failed (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(picogw_serdev_init);
+
+static void __exit picogw_serdev_exit(void)
+{
+	serdev_device_driver_unregister(&picogw_serdev_driver);
+}
+module_exit(picogw_serdev_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.16.4

