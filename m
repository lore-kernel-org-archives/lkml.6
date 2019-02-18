Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7ACC10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E636217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HoXJ+lXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfBRJur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:50:47 -0500
Received: from m12-14.163.com ([220.181.12.14]:57787 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBRJur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=P2vcV
        6f8loVaf/ZIiX2dpDXisvZU04xacdx/G8A6NQo=; b=HoXJ+lXF3jE+cgyInkc8G
        GC/NTw6YVxqDMdPLEt3vzoSAaMvSL04q8gBvDZ0n8qR4wzS3wJzmrvM19VLqs+4H
        GhU0Iq0xiklmAImmaw+LTX0YNVMAZ0t+C3HWRoz4dXHqEqj6pFNqIrf00kx0Nusk
        Q2u2yl4bJtbviuES75Iu9I=
Received: from localhost.localdomain (unknown [202.100.35.16])
        by smtp10 (Coremail) with SMTP id DsCowADnYA_vf2pcFKt1GQ--.1550S3;
        Mon, 18 Feb 2019 17:50:40 +0800 (CST)
From:   Shikai Wang <sxauwsk@163.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, sxauwsk@163.com
Subject: [PATCH] i2c: cadence: try reset when master receive arbitration lost
Date:   Mon, 18 Feb 2019 17:41:32 +0800
Message-Id: <20190218094132.5226-1-sxauwsk@163.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowADnYA_vf2pcFKt1GQ--.1550S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1xGw4UZr1DAr4rKFy7trb_yoW8Gw15pa
        1DGrZIkrW0qr4IqFs7Ar17ZF98uwsYga4jkF4Fk34q9F15CrWDtFy3tF98XF4xCryrX34a
        qrZ0y39rG3W2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jc_-PUUUUU=
X-Originating-IP: [202.100.35.16]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBzxBfJlaD1XcVlAAAsQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the adapter receive arbitration lost error interrupts,
cdns_i2c_master_xfer return to the caller directly instead of resetting
the adapter which resulted in the adapter being out of control.

So when driver detect err_status such as arbitration lost,
then try to repair and fix it.

Signed-off-by: Shikai Wang <sxauwsk@163.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..595b0d56ff1a 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 	cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
 			  CDNS_I2C_IDR_OFFSET);
 
-	/* If it is bus arbitration error, try again */
-	if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
-		return -EAGAIN;
-
 	return 0;
 }
 
@@ -624,6 +620,12 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		if (id->err_status) {
 			cdns_i2c_master_reset(adap);
 
+			/* If it is bus arbitration error, try again */
+			if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
+				ret = -EAGAIN;
+				goto out;
+			}
+
 			if (id->err_status & CDNS_I2C_IXR_NACK) {
 				ret = -ENXIO;
 				goto out;
-- 
2.19.2


