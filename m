Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9ADC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26B52087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26B52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeIXRWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:22:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41643 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeIXRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:22:17 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.131]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYLqs-1gI8SP3bSk-00VTzi; Mon, 24 Sep 2018 13:20:35 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Michael Heimpold <michael.heimpold@i2se.com>
Subject: [PATCH] net: qca_spi: Introduce write register verification
Date:   Mon, 24 Sep 2018 13:20:10 +0200
Message-Id: <1537788010-6766-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:g+zwHqPjhUhYSXSlgenb+MuHzHrNs+nHt0jna3hKh8djuRJi2WD
 v1RnNnmE6WPNTDkYSBpNkcWq787r2luuo6IbEL0VmM0js6dz68I8M4InGoNBfuRvj0X7JJK
 4zLWohxHcxrMjnqh5Mqdt7zbj+Y9PEHZkhA5qjVENOEVv0KFQ/DeAGyKTpYlG7tBEBrI/Io
 ww/iX1effxKCRgKYACptw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9LHabaOCFng=:v62Wl+t8yuUI21+KQCr8Cy
 fAj5nzYGhlRYAYw8rUyOJfwzUMpscnXQmy1qdVnJKIMZEh6/w9VRaqflzINFmFAXn8TtwCRBD
 kluNjonVKOHGGD7Y8JXkoTBHEJ2T1xq42KcyOmC+3If529S+S1rdSz2BUg38RWEXMb/+OyMPc
 IfYQMThQV2DLgZpXj2o/yf+dnu44EXsc90iBN8GBDXhK5dsdGHp8dyU/jgG6iVFAICHJGRXN9
 T9JwPiaeD/CZ1s5aZt0KhFY6RsHgmhlof3kiXpN58pVCfGHKIEngUCYJlc+j7LQdlLlotLsHZ
 JTKqhZ/YzvVt+oaC6lQe1gntqaT7WGND5lsp3k8ongwSRyor6ptqNB5Tz2zGe0FgNoDWMFUe+
 cvjlGf34dPS6uP/9PcFzJ0xOMFnaKsG5nrNtp4/WyW8gCrmGN7w7yHUqHPfrUviT+yvBEKyHo
 Q9oGlnMUwVXQn7QkWDv0kDNI6eDIgmINS6oFjuEObrDzAfHuVJrSKdne68QLNEJUuO0HVGhUs
 E4KtnjTOz6WpbUJBYHt2MKv6I2XHXzzCpesN6PlWSlK1qP+/GEw6lTYnpzUS/iNCG3m9TF5WP
 ZVVOUr72NIeAJ1FnFxrBPIIGENYXpJMz2yfvwiEIPGyrFBCI1KebyUVCo93+rnNS4anHznypA
 cTbFRqdGU2QHcFQRVvmPp3Cms1HyNB1E3qXnmJ53QMRi92INHIjZ7ED+GpEo+50KAL2g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI protocol for the QCA7000 doesn't have any fault detection.
In order to increase the drivers reliability in noisy environments,
we could implement a write verification inspired by the enc28j60.
This should avoid situations were the driver wrongly assumes the
receive interrupt is enabled and miss all incoming packets.

This function is disabled per default and can be controlled via module
parameter wr_verify.

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/ethernet/qualcomm/qca_7k.c    | 34 +++++++++++++++++++++++++++++--
 drivers/net/ethernet/qualcomm/qca_7k.h    |  2 +-
 drivers/net/ethernet/qualcomm/qca_debug.c |  1 +
 drivers/net/ethernet/qualcomm/qca_spi.c   | 28 ++++++++++++++++++-------
 drivers/net/ethernet/qualcomm/qca_spi.h   |  1 +
 5 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k.c b/drivers/net/ethernet/qualcomm/qca_7k.c
index 6c8543f..4292c89 100644
--- a/drivers/net/ethernet/qualcomm/qca_7k.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k.c
@@ -81,8 +81,8 @@ qcaspi_read_register(struct qcaspi *qca, u16 reg, u16 *result)
 	return ret;
 }
 
-int
-qcaspi_write_register(struct qcaspi *qca, u16 reg, u16 value)
+static int
+__qcaspi_write_register(struct qcaspi *qca, u16 reg, u16 value)
 {
 	__be16 tx_data[2];
 	struct spi_transfer transfer[2];
@@ -117,3 +117,33 @@ qcaspi_write_register(struct qcaspi *qca, u16 reg, u16 value)
 
 	return ret;
 }
+
+int
+qcaspi_write_register(struct qcaspi *qca, u16 reg, u16 value, int retry)
+{
+	int ret, i = 0;
+	u16 confirmed;
+
+	do {
+		ret = __qcaspi_write_register(qca, reg, value);
+		if (ret)
+			return ret;
+
+		if (!retry)
+			return 0;
+
+		ret = qcaspi_read_register(qca, reg, &confirmed);
+		if (ret)
+			return ret;
+
+		ret = confirmed != value;
+		if (!ret)
+			return 0;
+
+		i++;
+		qca->stats.write_verify_failed++;
+
+	} while (i <= retry);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/qualcomm/qca_7k.h b/drivers/net/ethernet/qualcomm/qca_7k.h
index 27124c2..356de8e 100644
--- a/drivers/net/ethernet/qualcomm/qca_7k.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k.h
@@ -66,6 +66,6 @@
 
 void qcaspi_spi_error(struct qcaspi *qca);
 int qcaspi_read_register(struct qcaspi *qca, u16 reg, u16 *result);
-int qcaspi_write_register(struct qcaspi *qca, u16 reg, u16 value);
+int qcaspi_write_register(struct qcaspi *qca, u16 reg, u16 value, int retry);
 
 #endif /* _QCA_7K_H */
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index 51d89c8..a9f1bc0 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -60,6 +60,7 @@ static const char qcaspi_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"Write buffer misses",
 	"Transmit ring full",
 	"SPI errors",
+	"Write verify errors",
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 66b775d..d531050 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -69,6 +69,12 @@ static int qcaspi_pluggable = QCASPI_PLUGGABLE_MIN;
 module_param(qcaspi_pluggable, int, 0);
 MODULE_PARM_DESC(qcaspi_pluggable, "Pluggable SPI connection (yes/no).");
 
+#define QCASPI_WRITE_VERIFY_MIN 0
+#define QCASPI_WRITE_VERIFY_MAX 3
+static int wr_verify = QCASPI_WRITE_VERIFY_MIN;
+module_param(wr_verify, int, 0);
+MODULE_PARM_DESC(wr_verify, "SPI register write verify trails. Use 0-3.");
+
 #define QCASPI_TX_TIMEOUT (1 * HZ)
 #define QCASPI_QCA7K_REBOOT_TIME_MS 1000
 
@@ -77,7 +83,7 @@ start_spi_intr_handling(struct qcaspi *qca, u16 *intr_cause)
 {
 	*intr_cause = 0;
 
-	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0);
+	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
 	qcaspi_read_register(qca, SPI_REG_INTR_CAUSE, intr_cause);
 	netdev_dbg(qca->net_dev, "interrupts: 0x%04x\n", *intr_cause);
 }
@@ -90,8 +96,8 @@ end_spi_intr_handling(struct qcaspi *qca, u16 intr_cause)
 			   SPI_INT_RDBUF_ERR |
 			   SPI_INT_WRBUF_ERR);
 
-	qcaspi_write_register(qca, SPI_REG_INTR_CAUSE, intr_cause);
-	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, intr_enable);
+	qcaspi_write_register(qca, SPI_REG_INTR_CAUSE, intr_cause, 0);
+	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, intr_enable, wr_verify);
 	netdev_dbg(qca->net_dev, "acking int: 0x%04x\n", intr_cause);
 }
 
@@ -239,7 +245,7 @@ qcaspi_tx_frame(struct qcaspi *qca, struct sk_buff *skb)
 
 	len = skb->len;
 
-	qcaspi_write_register(qca, SPI_REG_BFR_SIZE, len);
+	qcaspi_write_register(qca, SPI_REG_BFR_SIZE, len, wr_verify);
 	if (qca->legacy_mode)
 		qcaspi_tx_cmd(qca, QCA7K_SPI_WRITE | QCA7K_SPI_EXTERNAL);
 
@@ -345,6 +351,7 @@ qcaspi_receive(struct qcaspi *qca)
 
 	/* Read the packet size. */
 	qcaspi_read_register(qca, SPI_REG_RDBUF_BYTE_AVA, &available);
+
 	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %08x\n",
 		   available);
 
@@ -353,7 +360,7 @@ qcaspi_receive(struct qcaspi *qca)
 		return -1;
 	}
 
-	qcaspi_write_register(qca, SPI_REG_BFR_SIZE, available);
+	qcaspi_write_register(qca, SPI_REG_BFR_SIZE, available, wr_verify);
 
 	if (qca->legacy_mode)
 		qcaspi_tx_cmd(qca, QCA7K_SPI_READ | QCA7K_SPI_EXTERNAL);
@@ -524,7 +531,7 @@ qcaspi_qca7k_sync(struct qcaspi *qca, int event)
 		netdev_dbg(qca->net_dev, "sync: resetting device.\n");
 		qcaspi_read_register(qca, SPI_REG_SPI_CONFIG, &spi_config);
 		spi_config |= QCASPI_SLAVE_RESET_BIT;
-		qcaspi_write_register(qca, SPI_REG_SPI_CONFIG, spi_config);
+		qcaspi_write_register(qca, SPI_REG_SPI_CONFIG, spi_config, 0);
 
 		qca->sync = QCASPI_SYNC_RESET;
 		qca->stats.trig_reset++;
@@ -684,7 +691,7 @@ qcaspi_netdev_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0);
+	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
 	free_irq(qca->spi_dev->irq, qca);
 
 	kthread_stop(qca->spi_thread);
@@ -904,6 +911,13 @@ qca_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	if (wr_verify < QCASPI_WRITE_VERIFY_MIN ||
+	    wr_verify > QCASPI_WRITE_VERIFY_MAX) {
+		dev_err(&spi->dev, "Invalid write verify: %d\n",
+			wr_verify);
+		return -EINVAL;
+	}
+
 	dev_info(&spi->dev, "ver=%s, clkspeed=%d, burst_len=%d, pluggable=%d\n",
 		 QCASPI_DRV_VERSION,
 		 qcaspi_clkspeed,
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/ethernet/qualcomm/qca_spi.h
index fc0e987..2d2c497 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -73,6 +73,7 @@ struct qcaspi_stats {
 	u64 write_buf_miss;
 	u64 ring_full;
 	u64 spi_err;
+	u64 write_verify_failed;
 };
 
 struct qcaspi {
-- 
2.7.4

