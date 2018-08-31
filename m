Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261CFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49B720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49B720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeHaRBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:01:37 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeHaRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:01:36 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.52.110]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LqDBo-1fR2wr0wds-00dm2Y; Fri, 31 Aug 2018 14:54:09 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] net: qca_spi: Fix race condition in spi transfers
Date:   Fri, 31 Aug 2018 14:53:01 +0200
Message-Id: <1535719981-20812-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:Jmr2SFlpsSow7i1XcPr9iWsF1c44eUESJ9XKo+y/eKbt/uBjtee
 Zj2h1FxV6IVEIS7S/eKnRfNUJ21Vz1bWev3L1nTbS9cMtuUEVHAR5aGn0cKUgfR9kOZoxaP
 3/kYG7tVucjeTAdWX0BNM6faVIw7ARGptSLD+SgcKeiEWhlWffHdn9TXOMZ7x/69VE+fQ+l
 6rVu5H/cFnUhW27NxUtig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yyQRAoYlIAs=:Xpq+OTcp+bttMeIFpI+Cxn
 KyIfNH8fjYwCQ3mo5MFlrwK8AgdwG/YQoiIhzQNp2xZ+rtcTipM6xoFepuh+OEpLimkXX57nR
 +u4AEZoUm+mgEXrTk+TOi06XwaiLoGlxBN5N1JsRhvyu6l0mxpXL05ezVr3exu0Fq86dBnFJe
 QAo+n2H8sefeGzlJWTa6qYEy7eDrkEGZyOrV0N2T7Uu8+Lz4qLm0b3jufDSvrOrT96wcB9tJs
 6ku1VW/MPdz+QvdSj5LgOTVISRMTZvg5G+Lo7TzTFa1BqYMS5WaoaW4lFeGj018Mu0LXRlTbC
 SQg2VMK/naetZHrpFsh+UQMJNjXMOMSCY4jR+p+s39x0/X+f47SeK65+mqVn687vZdReIgGoI
 tNbTEBzwpHuYjc27LiOZ2VaO83xDORWeSA/vR87gUgw8R9Rgr8dusahXPoLywc2oXpvE8c1pU
 7YZCu41gv6y0kRmQvhy8V80iIkUtz9Iwc0B5fOK2OG2cFadzHYtU/Xy2Nz5OWFHtcM2QmaFN9
 C4gb24Nv3a2BDUfhZ4N3V74LtonLCpB+KqcYOKtr6XGHh37X7CzmT9KmsQA3WzK5Bo/t/054g
 UuV8wVWbYL4Gma1N3+2eP154ADhtVGSrL/vQ352cOLGOQvjLPOuw4UevYID8iGB/a8nwgRz+R
 Tua5hiA2qbQ0xGw8Tm9HO1VAgaI0QFDQsGSdLenyzX80SVo+TIXNycf4eFeuGp7fV/+A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance optimization with the prepared spi messages
also introduced a race condition between the kernel thread
and the register dump. This could make spi_sync hang forever.

So revert the optimization completely.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
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

