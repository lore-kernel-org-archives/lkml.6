Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937727AbeE2B6a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:58:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:48437 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935149AbeE2B63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:58:29 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 14/15] fsi: scom: Remove PIB reset during probe
Date: Tue, 29 May 2018 11:30:43 +1000
Message-Id: <20180529013044.23815-15-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.vnet.ibm.com>

The PIB reset causes problems for the running P9 chip. The reset
shouldn't be performed by this driver.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
Reviewed-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-scom.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index e13353a2fd7c..c8eb5e5b94a7 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -26,15 +26,11 @@
 
 #define FSI_ENGID_SCOM		0x5
 
-#define SCOM_FSI2PIB_DELAY	50
-
 /* SCOM engine register set */
 #define SCOM_DATA0_REG		0x00
 #define SCOM_DATA1_REG		0x04
 #define SCOM_CMD_REG		0x08
-#define SCOM_RESET_REG		0x1C
 
-#define SCOM_RESET_CMD		0x80000000
 #define SCOM_WRITE_CMD		0x80000000
 
 struct scom_device {
@@ -180,7 +176,6 @@ static const struct file_operations scom_fops = {
 
 static int scom_probe(struct device *dev)
 {
-	uint32_t data;
 	struct fsi_device *fsi_dev = to_fsi_dev(dev);
 	struct scom_device *scom;
 
@@ -197,9 +192,6 @@ static int scom_probe(struct device *dev)
 	scom->mdev.parent = dev;
 	list_add(&scom->link, &scom_devices);
 
-	data = cpu_to_be32(SCOM_RESET_CMD);
-	fsi_device_write(fsi_dev, SCOM_RESET_REG, &data, sizeof(uint32_t));
-
 	return misc_register(&scom->mdev);
 }
 
-- 
2.17.0
