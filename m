Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3887208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3887208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbeIXSOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeIXSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A3BF107D;
        Mon, 24 Sep 2018 12:12:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 003/173] net: qca_spi: Fix race condition in spi transfers
Date:   Mon, 24 Sep 2018 13:50:37 +0200
Message-Id: <20180924113114.726382770@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit e65a9e480e91ddf9e15155454d370cead64689c8 ]

With performance optimization the spi transfer and messages of basic
register operations like qcaspi_read_register moved into the private
driver structure. But they weren't protected against mutual access
(e.g. between driver kthread and ethtool). So dumping the QCA7000
registers via ethtool during network traffic could make spi_sync
hang forever, because the completion in spi_message is overwritten.

So revert the optimization completely.

Fixes: 291ab06ecf676 ("net: qualcomm: new Ethernet over SPI driver for QCA700")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/qca_7k.c  |   76 ++++++++++-----------
 drivers/net/ethernet/qualcomm/qca_spi.c |  114 ++++++++++++++++----------------
 drivers/net/ethernet/qualcomm/qca_spi.h |    5 -
 3 files changed, 95 insertions(+), 100 deletions(-)

--- a/drivers/net/ethernet/qualcomm/qca_7k.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k.c
@@ -45,34 +45,33 @@ qcaspi_read_register(struct qcaspi *qca,
 {
 	__be16 rx_data;
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
+	transfer[1].rx_buf = &rx_data;
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
 
 	if (ret)
 		qcaspi_spi_error(qca);
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
 
-	cmd = cpu_to_be16(QCA7K_SPI_WRITE | QCA7K_SPI_EXTERNAL);
-	transfer->tx_buf = &cmd;
-	transfer->rx_buf = NULL;
-	transfer->len = QCASPI_CMD_LEN;
-	transfer = &qca->spi_xfer2[1];
-	transfer->tx_buf = src;
-	transfer->rx_buf = NULL;
-	transfer->len = len;
+	memset(&transfer, 0, sizeof(transfer));
+	spi_message_init(&msg);
 
-	ret = spi_sync(qca->spi_dev, msg);
+	cmd = cpu_to_be16(QCA7K_SPI_WRITE | QCA7K_SPI_EXTERNAL);
+	transfer[0].tx_buf = &cmd;
+	transfer[0].len = QCASPI_CMD_LEN;
+	transfer[1].tx_buf = src;
+	transfer[1].len = len;
+
+	spi_message_add_tail(&transfer[0], &msg);
+	spi_message_add_tail(&transfer[1], &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
-	if (ret || (msg->actual_length != QCASPI_CMD_LEN + len)) {
+	if (ret || (msg.actual_length != QCASPI_CMD_LEN + len)) {
 		qcaspi_spi_error(qca);
 		return 0;
 	}
@@ -125,17 +127,20 @@ qcaspi_write_burst(struct qcaspi *qca, u
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
@@ -146,23 +151,25 @@ qcaspi_write_legacy(struct qcaspi *qca,
 static u32
 qcaspi_read_burst(struct qcaspi *qca, u8 *dst, u32 len)
 {
-	struct spi_message *msg = &qca->spi_msg2;
+	struct spi_message msg;
 	__be16 cmd;
-	struct spi_transfer *transfer = &qca->spi_xfer2[0];
+	struct spi_transfer transfer[2];
 	int ret;
 
-	cmd = cpu_to_be16(QCA7K_SPI_READ | QCA7K_SPI_EXTERNAL);
-	transfer->tx_buf = &cmd;
-	transfer->rx_buf = NULL;
-	transfer->len = QCASPI_CMD_LEN;
-	transfer = &qca->spi_xfer2[1];
-	transfer->tx_buf = NULL;
-	transfer->rx_buf = dst;
-	transfer->len = len;
+	memset(&transfer, 0, sizeof(transfer));
+	spi_message_init(&msg);
 
-	ret = spi_sync(qca->spi_dev, msg);
+	cmd = cpu_to_be16(QCA7K_SPI_READ | QCA7K_SPI_EXTERNAL);
+	transfer[0].tx_buf = &cmd;
+	transfer[0].len = QCASPI_CMD_LEN;
+	transfer[1].rx_buf = dst;
+	transfer[1].len = len;
+
+	spi_message_add_tail(&transfer[0], &msg);
+	spi_message_add_tail(&transfer[1], &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
-	if (ret || (msg->actual_length != QCASPI_CMD_LEN + len)) {
+	if (ret || (msg.actual_length != QCASPI_CMD_LEN + len)) {
 		qcaspi_spi_error(qca);
 		return 0;
 	}
@@ -173,17 +180,20 @@ qcaspi_read_burst(struct qcaspi *qca, u8
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
+
+	transfer.rx_buf = dst;
+	transfer.len = len;
 
-	ret = spi_sync(qca->spi_dev, msg);
+	spi_message_add_tail(&transfer, &msg);
+	ret = spi_sync(qca->spi_dev, &msg);
 
-	if (ret || (msg->actual_length != len)) {
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
@@ -836,16 +850,6 @@ qcaspi_netdev_setup(struct net_device *d
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


