Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17F8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46762502F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46762502F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeGALJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752293AbeGALJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77AE8AF53;
        Sun,  1 Jul 2018 11:08:59 +0000 (UTC)
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
Subject: [RFC net-next 08/15] net: lora: sx1276: Add debugfs
Date:   Sun,  1 Jul 2018 13:07:57 +0200
Message-Id: <20180701110804.32415-9-afaerber@suse.de>
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

Allow some interactive inspection at runtime via debugfs.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx1276.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/net/lora/sx1276.c b/drivers/net/lora/sx1276.c
index d6732111247a..1072019cfcc1 100644
--- a/drivers/net/lora/sx1276.c
+++ b/drivers/net/lora/sx1276.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2016-2018 Andreas Färber
  */
 
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/lora.h>
 #include <linux/module.h>
@@ -61,6 +62,8 @@ struct sx1276_priv {
 
 	struct workqueue_struct *wq;
 	struct work_struct tx_work;
+
+	struct dentry *debugfs;
 };
 
 static int sx1276_read_single(struct spi_device *spi, u8 reg, u8 *val)
@@ -416,6 +419,128 @@ static const struct net_device_ops sx1276_netdev_ops =  {
 	.ndo_start_xmit = sx1276_loradev_start_xmit,
 };
 
+static ssize_t sx1276_freq_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct net_device *netdev = file->private_data;
+	struct sx1276_priv *priv = netdev_priv(netdev);
+	struct spi_device *spi = priv->spi;
+	ssize_t size;
+	char *buf;
+	int ret;
+	u8 msb, mid, lsb;
+	u32 freq_xosc;
+	unsigned long long frf;
+
+	ret = of_property_read_u32(spi->dev.of_node, "clock-frequency", &freq_xosc);
+	if (ret)
+		return 0;
+
+	mutex_lock(&priv->spi_lock);
+
+	ret = sx1276_read_single(spi, REG_FRF_MSB, &msb);
+	if (!ret)
+		ret = sx1276_read_single(spi, REG_FRF_MID, &mid);
+	if (!ret)
+		ret = sx1276_read_single(spi, REG_FRF_LSB, &lsb);
+
+	mutex_unlock(&priv->spi_lock);
+
+	if (ret)
+		return 0;
+
+	frf = freq_xosc;
+	frf *= ((ulong)msb << 16) | ((ulong)mid << 8) | lsb;
+	frf /= (1 << 19);
+
+	buf = kasprintf(GFP_KERNEL, "%llu\n", frf);
+	if (!buf)
+		return 0;
+
+	size = simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+	kfree(buf);
+
+	return size;
+}
+
+static const struct file_operations sx1276_freq_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = sx1276_freq_read,
+};
+
+static ssize_t sx1276_state_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct net_device *netdev = file->private_data;
+	struct sx1276_priv *priv = netdev_priv(netdev);
+	struct spi_device *spi = priv->spi;
+	ssize_t size;
+	char *buf;
+	int len = 0;
+	int ret;
+	u8 val;
+	bool lora_mode = true;
+	const int max_len = 4096;
+
+	buf = kzalloc(max_len, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	mutex_lock(&priv->spi_lock);
+
+	ret = sx1276_read_single(spi, REG_OPMODE, &val);
+	if (!ret) {
+		len += snprintf(buf + len, max_len - len, "RegOpMode = 0x%02x\n", val);
+		lora_mode = (val & REG_OPMODE_LONG_RANGE_MODE) != 0;
+	}
+
+	ret = sx1276_read_single(spi, REG_FRF_MSB, &val);
+	if (!ret)
+		len += snprintf(buf + len, max_len - len, "RegFrMsb = 0x%02x\n", val);
+	ret = sx1276_read_single(spi, REG_FRF_MID, &val);
+	if (!ret)
+		len += snprintf(buf + len, max_len - len, "RegFrMid = 0x%02x\n", val);
+	ret = sx1276_read_single(spi, REG_FRF_LSB, &val);
+	if (!ret)
+		len += snprintf(buf + len, max_len - len, "RegFrLsb = 0x%02x\n", val);
+
+	ret = sx1276_read_single(spi, REG_PA_CONFIG, &val);
+	if (!ret)
+		len += snprintf(buf + len, max_len - len, "RegPaConfig = 0x%02x\n", val);
+
+	if (lora_mode) {
+		ret = sx1276_read_single(spi, LORA_REG_IRQ_FLAGS_MASK, &val);
+		if (!ret)
+			len += snprintf(buf + len, max_len - len, "RegIrqFlagsMask = 0x%02x\n", val);
+
+		ret = sx1276_read_single(spi, LORA_REG_IRQ_FLAGS, &val);
+		if (!ret)
+			len += snprintf(buf + len, max_len - len, "RegIrqFlags = 0x%02x\n", val);
+
+		ret = sx1276_read_single(spi, LORA_REG_SYNC_WORD, &val);
+		if (!ret)
+			len += snprintf(buf + len, max_len - len, "RegSyncWord = 0x%02x\n", val);
+	}
+
+	ret = sx1276_read_single(spi, REG_PA_DAC, &val);
+	if (!ret)
+		len += snprintf(buf + len, max_len - len, "RegPaDac = 0x%02x\n", val);
+
+	mutex_unlock(&priv->spi_lock);
+
+	size = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	return size;
+}
+
+static const struct file_operations sx1276_state_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = sx1276_state_read,
+};
+
 static int sx1276_probe(struct spi_device *spi)
 {
 	struct net_device *netdev;
@@ -566,6 +691,10 @@ static int sx1276_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	priv->debugfs = debugfs_create_dir(dev_name(&spi->dev), NULL);
+	debugfs_create_file("state", S_IRUGO, priv->debugfs, netdev, &sx1276_state_fops);
+	debugfs_create_file("frequency", S_IRUGO, priv->debugfs, netdev, &sx1276_freq_fops);
+
 	dev_info(&spi->dev, "SX1276 module probed (SX%d)", model);
 
 	return 0;
@@ -574,6 +703,9 @@ static int sx1276_probe(struct spi_device *spi)
 static int sx1276_remove(struct spi_device *spi)
 {
 	struct net_device *netdev = spi_get_drvdata(spi);
+	struct sx1276_priv *priv = netdev_priv(netdev);
+
+	debugfs_remove_recursive(priv->debugfs);
 
 	unregister_loradev(netdev);
 	free_loradev(netdev);
-- 
2.16.4

