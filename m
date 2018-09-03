Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422F42086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422F42086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeICRF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:05:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:05:26 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.33.25]) by
 mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0Lm4C9-1fNTTi49th-00ZcMg; Mon, 03 Sep 2018 14:45:20 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2] net: qca_spi: Fix race condition in spi transfers
Date:   Mon,  3 Sep 2018 14:44:17 +0200
Message-Id: <1535978657-2880-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:PZOHuosOpeXDsTBFP/ebpcoP+tin6w1C317UFDvFJxGdpe7+K3W
 yAQlj19QXO5HScjXhbuhVH2UedbtfUtziWsuWxKGAGfUgcuBfX7oyAzZ4YPJYidCZN2fOXH
 9ttiJXTD8jqDaNKx7ZMkeI1NmfWSMNH++wgRWB0H2P+2au6bXjCnYPhON09PVcTXG+x4BXJ
 28z/PHS4fahzYyZCY271g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RNg0TbPilXU=:FD3QC0Xlefmxwdr4MJaLRT
 7i16wWDVQngP+YNuSb7lQrnY00Vg9hr2iax0EWpdvlMZ+cvTxqvVV8JZi0tP+6Ju/3IhnG9jY
 wmVc7bnuWJUfKGiPO03/PYmrtF8UkLUIA9j6x1737+cnzM2owAVnSKNEnqaGBRugWScbSNDc0
 z76TBBEjovKkBwVnUkfMF8YyoV5n/wcgApwOzrSNEjOVvjgaTgAKQaY1wi7xLtNJv+oTmMJic
 D/URwG1ujgBue8sLk7y83O0OqnAkKA9ITd0FheHNeSzOuHQzECs2nmmzulnYsEUHrrzo7Ljbb
 LB+6nNT6Fn7lCE6Xfr94trhz/U4oKbQ9O1RVz40bXSI8z/F97rVDYKxRME3JykKtt9RqXaVPP
 GrjzrQBd5BACMv0DSrvIA4yRLjh3IoOMscegKEha/6u1t4oStp8bqPic57p06CPypSj8k4NHu
 fuQZK2cRYUxUPtjRcPEn+YPLLPhi1dleOkaUxZmbznasU7TAv2VzlncxjvGAW9E0piM0fIsqR
 TbaGfGbTibkJsCNjMZQQVjdn/5PydVW7ZanF/F4Gi6ssgQ3bPWuo18iYcCNS09iK7+UOcqIiZ
 Rj3nsowMttDAYoKl8+1flGR7X/dmXjakfsXFsFtPshtQXR8FCd19/51MQD9TYmtQdbjg4MSju
 bdIQTE3O3ISOLdIoS94ID0ungj3ClNYacd+rxzqsvt8ZGy8uki1nKLIl4tK6RPGTiPsA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With performance optimization the spi transfer and messages from basic
register operations like qcaspi_read_register moved into the private
driver structure. But they weren't protected against mutual access
(e.g. between driver kthread and ethtool). So dumping the QCA7000
register via ethtool during network traffic could make spi_sync
hang forever, because the completion in spi_message is overwritten.

So revert the optimization completely.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/ethernet/qualcomm/qca_7k.c  |  84 ++++++++++++------------
 drivers/net/ethernet/qualcomm/qca_spi.c | 110 +++++++++++++++++---------------
 drivers/net/ethernet/qualcomm/qca_spi.h |   5 --
 3 files changed, 97 insertions(+), 102 deletions(-)

Changes in V2:
- explain race in commit log more in detail

diff --git a/drivers/net/ethernet/qualcomm/qca_7k.c b/drivers/net/ethernet/qualcomm/qca_7k.c
index ffe7a16..e9914b6 100644
--- a/drivers/net/ethernet/qualcomm/qca_7k.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k.c
@@ -43,41 +43,40 @@ qcaspi_spi_error(struct qcaspi *qca)
 int
 qcaspi_read_register(struct qcaspi *qca, u16 reg, u16 *result)
 {
-	__be16 rx_data;
 	__be16 tx_data;
-	struct spi_transfer *transfer;
-	struct spi_message *msg;
+	struct spi_transfer transfer[2];
+	struct spi_message msg;
 	int ret;
 
+	memset(transfer, 0, sizeof(transfer));
+
+	spi_message_init(&msg);
+
 	tx_data = cpu_to_be16(QCA7K_SPI_READ | QCA7K_SPI_INTERNAL | reg);
+	*result = 0;
+
+	transfer[0].tx_buf = &tx_data;
+	transfer[0].len = QCASPI_CMD_LEN;
+	transfer[1].rx_buf = result;
+	transfer[1].len = QCASPI_CMD_LEN;
+
+	spi_message_add_tail(&transfer[0], &msg);
 
 	if (qca->legacy_mode) {
-		msg = &qca->spi_msg1;
-		transfer = &qca->spi_xfer1;
-		transfer->tx_buf = &tx_data;
-		transfer->rx_buf = NULL;
-		transfer->len = QCASPI_CMD_LEN;
-		spi_sync(qca->spi_dev, msg);
-	} else {
-		msg = &qca->spi_msg2;
-		transfer = &qca->spi_xfer2[0];
-		transfer->tx_buf = &tx_data;
-		transfer->rx_buf = NULL;
-		transfer->len = QCASPI_CMD_LEN;
-		transfer = &qca->spi_xfer2[1];
+		spi_sync(qca->spi_dev, &msg);
+		spi_message_init(&msg);
 	}
-	transfer->tx_buf = NULL;
-	transfer->rx_buf = &rx_data;
-	transfer->len = QCASPI_CMD_LEN;
-	ret = spi_sync(qca->spi_dev, msg);
+	spi_message_add_tail(&transfer[1], &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
 	if (!ret)
-		ret = msg->status;
+		ret = msg.status;
 
-	if (ret)
+	if (ret) {
 		qcaspi_spi_error(qca);
-	else
-		*result = be16_to_cpu(rx_data);
+	} else {
+		*result = be16_to_cpu(*result);
+	}
 
 	return ret;
 }
@@ -86,35 +85,32 @@ int
 qcaspi_write_register(struct qcaspi *qca, u16 reg, u16 value)
 {
 	__be16 tx_data[2];
-	struct spi_transfer *transfer;
-	struct spi_message *msg;
+	struct spi_transfer transfer[2];
+	struct spi_message msg;
 	int ret;
 
+	memset(&transfer, 0, sizeof(transfer));
+
+	spi_message_init(&msg);
+
 	tx_data[0] = cpu_to_be16(QCA7K_SPI_WRITE | QCA7K_SPI_INTERNAL | reg);
 	tx_data[1] = cpu_to_be16(value);
 
+	transfer[0].tx_buf = &tx_data[0];
+	transfer[0].len = QCASPI_CMD_LEN;
+	transfer[1].tx_buf = &tx_data[1];
+	transfer[1].len = QCASPI_CMD_LEN;
+
+	spi_message_add_tail(&transfer[0], &msg);
 	if (qca->legacy_mode) {
-		msg = &qca->spi_msg1;
-		transfer = &qca->spi_xfer1;
-		transfer->tx_buf = &tx_data[0];
-		transfer->rx_buf = NULL;
-		transfer->len = QCASPI_CMD_LEN;
-		spi_sync(qca->spi_dev, msg);
-	} else {
-		msg = &qca->spi_msg2;
-		transfer = &qca->spi_xfer2[0];
-		transfer->tx_buf = &tx_data[0];
-		transfer->rx_buf = NULL;
-		transfer->len = QCASPI_CMD_LEN;
-		transfer = &qca->spi_xfer2[1];
+		spi_sync(qca->spi_dev, &msg);
+		spi_message_init(&msg);
 	}
-	transfer->tx_buf = &tx_data[1];
-	transfer->rx_buf = NULL;
-	transfer->len = QCASPI_CMD_LEN;
-	ret = spi_sync(qca->spi_dev, msg);
+	spi_message_add_tail(&transfer[1], &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
 	if (!ret)
-		ret = msg->status;
+		ret = msg.status;
 
 	if (ret)
 		qcaspi_spi_error(qca);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 206f026..66b775d 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -99,22 +99,24 @@ static u32
 qcaspi_write_burst(struct qcaspi *qca, u8 *src, u32 len)
 {
 	__be16 cmd;
-	struct spi_message *msg = &qca->spi_msg2;
-	struct spi_transfer *transfer = &qca->spi_xfer2[0];
+	struct spi_message msg;
+	struct spi_transfer transfer[2];
 	int ret;
 
+	memset(&transfer, 0, sizeof(transfer));
+	spi_message_init(&msg);
+
 	cmd = cpu_to_be16(QCA7K_SPI_WRITE | QCA7K_SPI_EXTERNAL);
-	transfer->tx_buf = &cmd;
-	transfer->rx_buf = NULL;
-	transfer->len = QCASPI_CMD_LEN;
-	transfer = &qca->spi_xfer2[1];
-	transfer->tx_buf = src;
-	transfer->rx_buf = NULL;
-	transfer->len = len;
+	transfer[0].tx_buf = &cmd;
+	transfer[0].len = QCASPI_CMD_LEN;
+	transfer[1].tx_buf = src;
+	transfer[1].len = len;
 
-	ret = spi_sync(qca->spi_dev, msg);
+	spi_message_add_tail(&transfer[0], &msg);
+	spi_message_add_tail(&transfer[1], &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
-	if (ret || (msg->actual_length != QCASPI_CMD_LEN + len)) {
+	if (ret || (msg.actual_length != QCASPI_CMD_LEN + len)) {
 		qcaspi_spi_error(qca);
 		return 0;
 	}
@@ -125,17 +127,20 @@ qcaspi_write_burst(struct qcaspi *qca, u8 *src, u32 len)
 static u32
 qcaspi_write_legacy(struct qcaspi *qca, u8 *src, u32 len)
 {
-	struct spi_message *msg = &qca->spi_msg1;
-	struct spi_transfer *transfer = &qca->spi_xfer1;
+	struct spi_message msg;
+	struct spi_transfer transfer;
 	int ret;
 
-	transfer->tx_buf = src;
-	transfer->rx_buf = NULL;
-	transfer->len = len;
+	memset(&transfer, 0, sizeof(transfer));
+	spi_message_init(&msg);
+
+	transfer.tx_buf = src;
+	transfer.len = len;
 
-	ret = spi_sync(qca->spi_dev, msg);
+	spi_message_add_tail(&transfer, &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
-	if (ret || (msg->actual_length != len)) {
+	if (ret || (msg.actual_length != len)) {
 		qcaspi_spi_error(qca);
 		return 0;
 	}
@@ -146,23 +151,25 @@ qcaspi_write_legacy(struct qcaspi *qca, u8 *src, u32 len)
 static u32
 qcaspi_read_burst(struct qcaspi *qca, u8 *dst, u32 len)
 {
-	struct spi_message *msg = &qca->spi_msg2;
+	struct spi_message msg;
 	__be16 cmd;
-	struct spi_transfer *transfer = &qca->spi_xfer2[0];
+	struct spi_transfer transfer[2];
 	int ret;
 
+	memset(&transfer, 0, sizeof(transfer));
+	spi_message_init(&msg);
+
 	cmd = cpu_to_be16(QCA7K_SPI_READ | QCA7K_SPI_EXTERNAL);
-	transfer->tx_buf = &cmd;
-	transfer->rx_buf = NULL;
-	transfer->len = QCASPI_CMD_LEN;
-	transfer = &qca->spi_xfer2[1];
-	transfer->tx_buf = NULL;
-	transfer->rx_buf = dst;
-	transfer->len = len;
+	transfer[0].tx_buf = &cmd;
+	transfer[0].len = QCASPI_CMD_LEN;
+	transfer[1].rx_buf = dst;
+	transfer[1].len = len;
 
-	ret = spi_sync(qca->spi_dev, msg);
+	spi_message_add_tail(&transfer[0], &msg);
+	spi_message_add_tail(&transfer[1], &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
-	if (ret || (msg->actual_length != QCASPI_CMD_LEN + len)) {
+	if (ret || (msg.actual_length != QCASPI_CMD_LEN + len)) {
 		qcaspi_spi_error(qca);
 		return 0;
 	}
@@ -173,17 +180,20 @@ qcaspi_read_burst(struct qcaspi *qca, u8 *dst, u32 len)
 static u32
 qcaspi_read_legacy(struct qcaspi *qca, u8 *dst, u32 len)
 {
-	struct spi_message *msg = &qca->spi_msg1;
-	struct spi_transfer *transfer = &qca->spi_xfer1;
+	struct spi_message msg;
+	struct spi_transfer transfer;
 	int ret;
 
-	transfer->tx_buf = NULL;
-	transfer->rx_buf = dst;
-	transfer->len = len;
+	memset(&transfer, 0, sizeof(transfer));
+	spi_message_init(&msg);
 
-	ret = spi_sync(qca->spi_dev, msg);
+	transfer.rx_buf = dst;
+	transfer.len = len;
 
-	if (ret || (msg->actual_length != len)) {
+	spi_message_add_tail(&transfer, &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
+
+	if (ret || (msg.actual_length != len)) {
 		qcaspi_spi_error(qca);
 		return 0;
 	}
@@ -195,19 +205,23 @@ static int
 qcaspi_tx_cmd(struct qcaspi *qca, u16 cmd)
 {
 	__be16 tx_data;
-	struct spi_message *msg = &qca->spi_msg1;
-	struct spi_transfer *transfer = &qca->spi_xfer1;
+	struct spi_message msg;
+	struct spi_transfer transfer;
 	int ret;
 
+	memset(&transfer, 0, sizeof(transfer));
+
+	spi_message_init(&msg);
+
 	tx_data = cpu_to_be16(cmd);
-	transfer->len = sizeof(tx_data);
-	transfer->tx_buf = &tx_data;
-	transfer->rx_buf = NULL;
+	transfer.len = sizeof(cmd);
+	transfer.tx_buf = &tx_data;
+	spi_message_add_tail(&transfer, &msg);
 
-	ret = spi_sync(qca->spi_dev, msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
 	if (!ret)
-		ret = msg->status;
+		ret = msg.status;
 
 	if (ret)
 		qcaspi_spi_error(qca);
@@ -835,16 +849,6 @@ qcaspi_netdev_setup(struct net_device *dev)
 	qca = netdev_priv(dev);
 	memset(qca, 0, sizeof(struct qcaspi));
 
-	memset(&qca->spi_xfer1, 0, sizeof(struct spi_transfer));
-	memset(&qca->spi_xfer2, 0, sizeof(struct spi_transfer) * 2);
-
-	spi_message_init(&qca->spi_msg1);
-	spi_message_add_tail(&qca->spi_xfer1, &qca->spi_msg1);
-
-	spi_message_init(&qca->spi_msg2);
-	spi_message_add_tail(&qca->spi_xfer2[0], &qca->spi_msg2);
-	spi_message_add_tail(&qca->spi_xfer2[1], &qca->spi_msg2);
-
 	memset(&qca->txr, 0, sizeof(qca->txr));
 	qca->txr.count = TX_RING_MAX_LEN;
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/ethernet/qualcomm/qca_spi.h
index fc4beb1..fc0e987 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -83,11 +83,6 @@ struct qcaspi {
 	struct tx_ring txr;
 	struct qcaspi_stats stats;
 
-	struct spi_message spi_msg1;
-	struct spi_message spi_msg2;
-	struct spi_transfer spi_xfer1;
-	struct spi_transfer spi_xfer2[2];
-
 	u8 *rx_buffer;
 	u32 buffer_size;
 	u8 sync;
-- 
2.7.4

