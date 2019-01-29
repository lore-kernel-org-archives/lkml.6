Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C749C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC1B20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfA2FBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:01:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:53388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbfA2FBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:01:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D09FADFF;
        Tue, 29 Jan 2019 05:01:42 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        support@enocean.com,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 4/4] net: enocean: Prepare ESP2 support
Date:   Tue, 29 Jan 2019 06:01:30 +0100
Message-Id: <20190129050130.10932-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190129050130.10932-1-afaerber@suse.de>
References: <20190129050130.10932-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EnOcean Serial Protocol 2 used subtelegram frames different from ESP3.
It also uses ORG identifiers differing from RORG identifiers in ERP.

Only checksumming has been tested.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/enocean/Makefile       |   1 +
 drivers/net/enocean/enocean_esp.c  |  10 ++
 drivers/net/enocean/enocean_esp.h  |   8 ++
 drivers/net/enocean/enocean_esp2.c | 276 +++++++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)
 create mode 100644 drivers/net/enocean/enocean_esp2.c

diff --git a/drivers/net/enocean/Makefile b/drivers/net/enocean/Makefile
index 4492e3d48c0a..f34b098997e4 100644
--- a/drivers/net/enocean/Makefile
+++ b/drivers/net/enocean/Makefile
@@ -3,4 +3,5 @@ enocean-dev-y := enocean.o
 
 obj-m += enocean-esp.o
 enocean-esp-y := enocean_esp.o
+enocean-esp-y += enocean_esp2.o
 enocean-esp-y += enocean_esp3.o
diff --git a/drivers/net/enocean/enocean_esp.c b/drivers/net/enocean/enocean_esp.c
index 61bddb77762d..74720da49369 100644
--- a/drivers/net/enocean/enocean_esp.c
+++ b/drivers/net/enocean/enocean_esp.c
@@ -150,6 +150,15 @@ static void enocean_esp_cleanup(struct enocean_device *edev)
 		edev->version->cleanup(edev);
 }
 
+static const struct enocean_esp_version enocean_esp2 = {
+	.version = 2,
+	.baudrate = 9600,
+	.serdev_client_ops = &enocean_esp2_serdev_client_ops,
+	.init = enocean_esp2_init,
+	.send = enocean_esp2_send,
+	.cleanup = enocean_esp2_cleanup,
+};
+
 static const struct enocean_esp_version enocean_esp3 = {
 	.version = 3,
 	.baudrate = 57600,
@@ -160,6 +169,7 @@ static const struct enocean_esp_version enocean_esp3 = {
 };
 
 static const struct of_device_id enocean_of_match[] = {
+	{ .compatible = "enocean,esp2", .data = &enocean_esp2 },
 	{ .compatible = "enocean,esp3", .data = &enocean_esp3 },
 	{}
 };
diff --git a/drivers/net/enocean/enocean_esp.h b/drivers/net/enocean/enocean_esp.h
index e02bf5352d61..44660238043a 100644
--- a/drivers/net/enocean/enocean_esp.h
+++ b/drivers/net/enocean/enocean_esp.h
@@ -24,15 +24,23 @@ struct enocean_device {
 	void *priv;
 };
 
+extern const struct serdev_device_ops enocean_esp2_serdev_client_ops;
 extern const struct serdev_device_ops enocean_esp3_serdev_client_ops;
 
 void enocean_esp3_crc8_populate(void);
 
+int enocean_esp2_init(struct enocean_device *edev);
 int enocean_esp3_init(struct enocean_device *edev);
 
+int enocean_esp2_send(struct enocean_device *edev, u32 dest, const void *data, int data_len);
 int enocean_esp3_send(struct enocean_device *edev, u32 dest, const void *data, int data_len);
 void enocean_esp_tx_done(struct enocean_device *edev);
 
+void enocean_esp2_cleanup(struct enocean_device *edev);
 void enocean_esp3_cleanup(struct enocean_device *edev);
 
+#define ENOCEAN_RORG_RPS	0xF6
+#define ENOCEAN_RORG_1BS	0xD5
+#define ENOCEAN_RORG_4BS	0xA5
+
 #endif
diff --git a/drivers/net/enocean/enocean_esp2.c b/drivers/net/enocean/enocean_esp2.c
new file mode 100644
index 000000000000..d4cb787de22e
--- /dev/null
+++ b/drivers/net/enocean/enocean_esp2.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * EnOcean Serial Protocol 2
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+#include <linux/serdev.h>
+
+#include "enocean_esp.h"
+
+#define ESP2_SYNC_BYTE1 0xA5
+#define ESP2_SYNC_BYTE0 0x5A
+
+struct enocean_esp2_packet {
+	u8 sync[2];
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	u8 h_seq:3;
+	u8 length:5;
+#else
+	u8 length:5;
+	u8 h_seq:3;
+#endif
+	u8 org;
+	u8 data[4];
+	u8 id[4];
+	u8 status;
+	u8 checksum;
+} __packed;
+
+#define ESP2_H_SEQ_TRT	0x3
+#define ESP2_H_SEQ_RCT	0x4
+#define ESP2_H_SEQ_TCT	0x5
+
+#define ESP2_TELEGRAM_RESET	0x0A
+
+#define ENOCEAN_ORG_RPS		0x05
+#define ENOCEAN_ORG_1BS		0x06
+#define ENOCEAN_ORG_4BS		0x07
+
+/* Cf. EnOcean Equipment Profiles, Telegram Types (RORG) */
+static inline u8 enocean_org_to_rorg(u8 org)
+{
+	switch (org) {
+	case ENOCEAN_ORG_RPS:
+		return ENOCEAN_RORG_RPS;
+	case ENOCEAN_ORG_1BS:
+		return ENOCEAN_RORG_1BS;
+	case ENOCEAN_ORG_4BS:
+		return ENOCEAN_RORG_4BS;
+	default:
+		return org;
+	}
+}
+
+static u8 enocean_rorg_to_org(u8 rorg)
+{
+	switch (rorg) {
+	case ENOCEAN_RORG_RPS:
+		return ENOCEAN_ORG_RPS;
+	case ENOCEAN_RORG_1BS:
+		return ENOCEAN_ORG_1BS;
+	case ENOCEAN_RORG_4BS:
+		return ENOCEAN_ORG_4BS;
+	default:
+		return rorg;
+	}
+}
+
+struct enocean_esp2_dispatcher {
+	struct list_head list;
+	u8 h_seq;
+	void (*dispatch)(const u8 *data, u8 data_len, struct enocean_esp2_dispatcher *d);
+};
+
+static void enocean_add_esp2_dispatcher(struct enocean_device *edev,
+	struct enocean_esp2_dispatcher *entry)
+{
+	list_add_tail_rcu(&entry->list, &edev->esp_dispatchers);
+}
+
+static void enocean_remove_esp2_dispatcher(struct enocean_device *edev,
+	struct enocean_esp2_dispatcher *entry)
+{
+	list_del_rcu(&entry->list);
+}
+
+#define ESP2_RESPONSE_ERR_SYNTAX_H_SEQ	0x08
+#define ESP2_RESPONSE_ERR_SYNTAX_LENGTH	0x09
+#define ESP2_RESPONSE_ERR_SYNTAX_CHKSUM	0x0A
+#define ESP2_RESPONSE_ERR_SYNTAX_ORG	0x0B
+#define ESP2_RESPONSE_ERR		0x19
+#define ESP2_RESPONSE_ERR_IDRANGE	0x1A
+#define ESP2_RESPONSE_ERR_TX_IDRANGE	0x22
+#define ESP2_RESPONSE_OK		0x58
+
+struct enocean_esp2_priv {
+	struct enocean_device *edev;
+	struct enocean_esp2_dispatcher tx_telegram_response;
+};
+
+static u8 enocean_esp2_checksum(const u8 *data, int len)
+{
+	u8 chksum = 0;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		chksum += data[i];
+	}
+	return chksum;
+}
+
+static int enocean_esp2_send_telegram(struct enocean_device *edev, u8 h_seq, u8 org,
+	const u8 *data, int data_len, unsigned long timeout)
+{
+	struct enocean_esp2_packet pkt;
+	int ret;
+
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.sync[0] = ESP2_SYNC_BYTE1;
+	pkt.sync[1] = ESP2_SYNC_BYTE0;
+	pkt.h_seq = h_seq;
+	pkt.length = 11;
+	dev_dbg(&edev->serdev->dev, "H_SEQ | LENGTH = %02x\n", (unsigned int)(((u8*)&pkt)[2]));
+	pkt.org = org;
+	if (data_len > 0)
+		memcpy(pkt.data, data, min(data_len, 9));
+	pkt.checksum = enocean_esp2_checksum(((u8 *)&pkt) + 2, sizeof(pkt) - 2 - 1);
+	dev_dbg(&edev->serdev->dev, "checksum = %02x\n", (unsigned int)pkt.checksum);
+
+	ret = serdev_device_write(edev->serdev, (const u8 *)&pkt, sizeof(pkt), timeout);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && ret < sizeof(pkt))
+		return -EIO;
+	return 0;
+}
+
+static void enocean_esp2_tx_telegram_response_dispatch(const u8 *data, u8 data_len,
+	struct enocean_esp2_dispatcher *d)
+{
+	struct enocean_esp2_priv *priv = container_of(d, struct enocean_esp2_priv, tx_telegram_response);
+	struct enocean_device *edev = priv->edev;
+
+	enocean_remove_esp2_dispatcher(edev, d);
+
+	if (data_len < 1)
+		return;
+
+	switch (data[0]) {
+	case ESP2_RESPONSE_OK:
+		enocean_esp_tx_done(edev);
+		break;
+	case ESP2_RESPONSE_ERR:
+	case ESP2_RESPONSE_ERR_TX_IDRANGE:
+	default:
+		break;
+	}
+}
+
+static int enocean_esp2_tx_telegram(struct enocean_device *edev, u8 org,
+	const u8 *data, int data_len, unsigned long timeout)
+{
+	struct enocean_esp2_priv *priv = edev->priv;
+	int ret;
+
+	enocean_add_esp2_dispatcher(edev, &priv->tx_telegram_response);
+
+	ret = enocean_esp2_send_telegram(edev, ESP2_H_SEQ_TRT,
+		org, data, data_len, timeout);
+	if (ret) {
+		enocean_remove_esp2_dispatcher(edev, &priv->tx_telegram_response);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int enocean_esp2_reset(struct enocean_device *edev, unsigned long timeout)
+{
+	return enocean_esp2_send_telegram(edev, ESP2_H_SEQ_TCT, ESP2_TELEGRAM_RESET, NULL, 0, timeout);
+	/* no RCT */
+}
+
+static int enocean_esp2_receive_buf(struct serdev_device *sdev, const u8 *data, size_t count)
+{
+	struct enocean_device *edev = serdev_device_get_drvdata(sdev);
+	struct enocean_esp2_dispatcher *e;
+	u8 h_seq, length, chksum;
+
+	dev_dbg(&sdev->dev, "Receive (%zu)\n", count);
+
+	if (data[0] != ESP2_SYNC_BYTE1) {
+		dev_warn(&sdev->dev, "not first Sync Byte (found 0x%02x), skipping\n",
+			(unsigned int)data[0]);
+		return 1;
+	}
+
+	if (count < 2)
+		return 0;
+
+	if (data[1] != ESP2_SYNC_BYTE0) {
+		dev_warn(&sdev->dev, "not second Sync Byte (found 0x%02x 0x%02x), skipping\n",
+			ESP2_SYNC_BYTE1, (unsigned int)data[1]);
+		return 1;
+	}
+
+	if (count < 3)
+		return 0;
+
+	h_seq = data[2] >> 5;
+	length = data[2] & 0x1f;
+
+	if (count < 3 + length)
+		return 0;
+
+	chksum = enocean_esp2_checksum(data + 2, 1 + length - 1);
+	if (data[3 + length - 1] != chksum) {
+		dev_warn(&sdev->dev, "invalid checksum (expected 0x%02x, found %02x), skipping\n",
+			(unsigned int)chksum, (unsigned int)data[3 + length - 1]);
+		return 2; /* valid second Sync Byte is not a valid first Sync Byte */
+	}
+
+	print_hex_dump_bytes("received: ", DUMP_PREFIX_OFFSET, data, 3 + length);
+
+	list_for_each_entry_rcu(e, &edev->esp_dispatchers, list) {
+		if (e->h_seq == h_seq)
+			e->dispatch(data + 3, length, e);
+	}
+
+	return 3 + length;
+}
+
+const struct serdev_device_ops enocean_esp2_serdev_client_ops = {
+	.receive_buf = enocean_esp2_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+int enocean_esp2_send(struct enocean_device *edev, u32 dest, const void *data, int data_len)
+{
+	const u8 *buf = data;
+
+	return enocean_esp2_tx_telegram(edev,
+		enocean_rorg_to_org(buf[0]), buf + 1, data_len - 1, HZ);
+}
+
+int enocean_esp2_init(struct enocean_device *edev)
+{
+	struct enocean_esp2_priv *priv;
+	int ret;
+
+	ret = enocean_esp2_reset(edev, HZ);
+	if (ret)
+		return ret;
+
+	msleep(100); /* XXX */
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->edev = edev;
+	edev->priv = priv;
+
+	priv->tx_telegram_response.h_seq = ESP2_H_SEQ_RCT;
+	priv->tx_telegram_response.dispatch = enocean_esp2_tx_telegram_response_dispatch;
+
+	return 0;
+}
+
+void enocean_esp2_cleanup(struct enocean_device *edev)
+{
+	struct enocean_esp2_priv *priv = edev->priv;
+
+	kfree(priv);
+}
-- 
2.16.4

