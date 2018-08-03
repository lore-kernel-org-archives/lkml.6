Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301092172E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301092172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeHCKBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:01:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55966 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeHCKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:01:09 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.45.13]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MMaiY-1frYZo1Hiw-008JPk; Fri, 03 Aug 2018 10:05:54 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC] net: qca_spi: Fix race condition in spi transfers
Date:   Fri,  3 Aug 2018 10:05:04 +0200
Message-Id: <1533283504-11224-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:dJW15Wf1QMZ9DQhMCHsIOEuPFWCrwbE+tDqO7CBb/Lzg1Qe66jS
 YIVLZv3J2a3xZErb2JVIgxJqSmqFmmVoz29p9LXH/BXpIKrUaoFejwQud3N3zGFmdmy8iZS
 0Fr4qDdSJXitVfbVPqIjtS3MKfOi/SCU4z1tw6CKQdYTUSZLZQTjZrqfZx9qxoM1Ooc2iYn
 zQY7ITEN3FUxN/9tpfj5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E6adAcHl8JE=:piKk25dudWyfyeCr3xUEeg
 +LwBOHKYYjmsOWNP5h7OVeVp+cojMN3T+jCHWTUN7xyh/YU3RFr2bgLyLcP38KF3D6sZavCyH
 mAAX/pmwjKoK7Jqt6o/HX5bEFo7uYWZuOAPWV4Yx40Kv+gmd/7N6LT/bShST6hA7r8Tmo72EE
 y8JqFaRnX6Aox8sW5VsL/wyKOx6vQMDKWtDUOcU48wwrHJWZ/+oPb27o2YaXL86/CZnkyZ3va
 5TdiGTuce78sFJcbhVN2cfpcdWQpHllrSIkx1WynjFzQJ0InI7SyjvfNslVSThKnFieUr0c/n
 FjKQxKsahbvTVoDu9/yPG0A56k4sZqGcGASD4p6YEGA01XjV6zRwZEtXgTEbQ+U9utOypiK60
 s7BEFARkSgPuAIAvnIBd3G5Df2bn+3HlUSJR9kZ4AuLkq0Rv8iZ8CfSh5IoVUEffVR4LyZmaQ
 sq3ep2HPouYzqwQOOyQNLospVKTrKdNs8GJtEw/3kNX3L7MmtXEH4RbQOBSUfC4wJu3Hf0oJv
 nLg7M8qb8Ymu+IwlOlx12f+UIX4j/6YHKm9isn6rTS8+88CalgWIwEle8RlZxQMbogaMzJ9HZ
 6bOF5NWaAfQBnjHBv9Y/wzwwLSMoXchOwfHsEaxRn0tLcvFa6gUdzFQ1HIpexHbvSf0mDoJ1b
 e3Ep+7r2j+etbr90ZGICLmE/VlqpwUpVfLAJPgO21L4TFzQ3sbiDcGncuHY4jEdl0znM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance optimization with the prepared spi messages
also introduced a race condition between the kernel thread
and the register dump. This could make spi_sync hang forever.

So revert the optimization completely.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
---
 drivers/net/ethernet/qualcomm/qca_7k.c  |  84 ++++++++++++------------
 drivers/net/ethernet/qualcomm/qca_spi.c | 110 +++++++++++++++++---------------
 drivers/net/ethernet/qualcomm/qca_spi.h |   5 --
 3 files changed, 97 insertions(+), 102 deletions(-)

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

