Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 15A20C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C654A208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeFLFT7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:19:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:51955 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeFLFT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:19:57 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C5JDa3008698;
        Tue, 12 Jun 2018 00:19:17 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 1/5] fsi/scom: Add mutex around FSI2PIB accesses
Date:   Tue, 12 Jun 2018 15:19:07 +1000
Message-Id: <20180612051911.20690-2-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612051911.20690-1-benh@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, multiple clients can open the driver and attempt
to access the PIB at the same time, thus clobbering each other
in the process.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-scom.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index c8eb5e5b94a7..3cba0eb645e1 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -37,6 +37,7 @@ struct scom_device {
 	struct list_head link;
 	struct fsi_device *fsi_dev;
 	struct miscdevice mdev;
+	struct mutex lock;
 	char	name[32];
 	int idx;
 };
@@ -53,21 +54,26 @@ static int put_scom(struct scom_device *scom_dev, uint64_t value,
 	int rc;
 	uint32_t data;
 
+	mutex_lock(&scom_dev->lock);
+
 	data = cpu_to_be32((value >> 32) & 0xffffffff);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_DATA0_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		return rc;
+		goto bail;
 
 	data = cpu_to_be32(value & 0xffffffff);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_DATA1_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		return rc;
+		goto bail;
 
 	data = cpu_to_be32(SCOM_WRITE_CMD | addr);
-	return fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
+	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
 				sizeof(uint32_t));
+ bail:
+	mutex_unlock(&scom_dev->lock);
+	return rc;
 }
 
 static int get_scom(struct scom_device *scom_dev, uint64_t *value,
@@ -76,27 +82,31 @@ static int get_scom(struct scom_device *scom_dev, uint64_t *value,
 	uint32_t result, data;
 	int rc;
 
+
+	mutex_lock(&scom_dev->lock);
 	*value = 0ULL;
 	data = cpu_to_be32(addr);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		return rc;
+		goto bail;
 
 	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA0_REG, &result,
 				sizeof(uint32_t));
 	if (rc)
-		return rc;
+		goto bail;
 
 	*value |= (uint64_t)cpu_to_be32(result) << 32;
 	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA1_REG, &result,
 				sizeof(uint32_t));
 	if (rc)
-		return rc;
+		goto bail;
 
 	*value |= cpu_to_be32(result);
 
-	return 0;
+ bail:
+	mutex_unlock(&scom_dev->lock);
+	return rc;
 }
 
 static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
@@ -183,6 +193,7 @@ static int scom_probe(struct device *dev)
 	if (!scom)
 		return -ENOMEM;
 
+	mutex_init(&scom->lock);
 	scom->idx = ida_simple_get(&scom_ida, 1, INT_MAX, GFP_KERNEL);
 	snprintf(scom->name, sizeof(scom->name), "scom%d", scom->idx);
 	scom->fsi_dev = fsi_dev;
-- 
2.17.0

