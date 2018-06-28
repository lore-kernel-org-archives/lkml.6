Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FDAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A99B244FF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A99B244FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeF1PYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:24:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53331 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966713AbeF1PUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:20:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7FFD920A36; Thu, 28 Jun 2018 17:20:02 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id 548F5203EC;
        Thu, 28 Jun 2018 17:20:02 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: [PATCH 01/14] crypto: inside-secure - move the firmware to a better location
Date:   Thu, 28 Jun 2018 17:15:31 +0200
Message-Id: <20180628151544.22134-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628151544.22134-1-antoine.tenart@bootlin.com>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the firmware loaded by the Inside Secure SafeXcel
driver from /lib/firmware/ to /lib/firmware/inside-secure/eip197b/. This
prepares the driver for future patches which will support other
revisions of the EIP197 crypto engine as they'll have their own
firmwares.

To keep the compatibility of what was done, the old path is still
supported as a fallback for the EIP197b (currently the only one
supported by the driver that loads a firmware).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index c39d2d7c9917..a04d39231aaf 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -132,18 +132,24 @@ static int eip197_load_firmwares(struct safexcel_crypto_priv *priv)
 {
 	const char *fw_name[] = {"ifpp.bin", "ipue.bin"};
 	const struct firmware *fw[FW_NB];
+	char fw_path[31];
 	int i, j, ret = 0;
 	u32 val;
 
 	for (i = 0; i < FW_NB; i++) {
-		ret = request_firmware(&fw[i], fw_name[i], priv->dev);
+		snprintf(fw_path, 31, "inside-secure/eip197b/%s", fw_name[i]);
+		ret = request_firmware(&fw[i], fw_path, priv->dev);
 		if (ret) {
-			dev_err(priv->dev,
-				"Failed to request firmware %s (%d)\n",
-				fw_name[i], ret);
-			goto release_fw;
+			/* Fallback to the old firmware location. */
+			ret = request_firmware(&fw[i], fw_name[i], priv->dev);
+			if (ret) {
+				dev_err(priv->dev,
+					"Failed to request firmware %s (%d)\n",
+					fw_name[i], ret);
+				goto release_fw;
+			}
 		}
-	 }
+	}
 
 	/* Clear the scratchpad memory */
 	val = readl(EIP197_PE(priv) + EIP197_PE_ICE_SCRATCH_CTRL);
-- 
2.17.1

