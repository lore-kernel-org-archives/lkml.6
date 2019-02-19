Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE15A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MRTuwdl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbfBSBeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:34:18 -0500
Received: from m12-12.163.com ([220.181.12.12]:38987 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbfBSBeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vJOxl
        iD3ylQNF+bK3c+e1E/IPoF2RmPsUHSYa4f68G4=; b=MRTuwdl5hca/5724t3b7h
        Dr4LnqeBtUejGLE3FLMPjrnSDFE6WlxYKdmkKEBXyDrzZ9jcRIA4oPda3nQqtHIk
        QxTdlSzkMwEIxZtXJ7j0abGg+7jzZXdI7OshAkJaP6+Lzssht9u8AcVH1ngs3FoR
        ggyP35j3nDDxE0Prw/iT4w=
Received: from localhost.localdomain (unknown [117.36.119.220])
        by smtp8 (Coremail) with SMTP id DMCowAC3NM4CXWtcMmt4GQ--.10745S3;
        Tue, 19 Feb 2019 09:33:55 +0800 (CST)
From:   Shikai Wang <sxauwsk@163.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shikai Wang <sxauwsk@163.com>
Subject: [PATCH v2] i2c: cadence: try reset when master receive arbitration lost
Date:   Tue, 19 Feb 2019 09:24:47 +0800
Message-Id: <20190219012447.5900-1-sxauwsk@163.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAC3NM4CXWtcMmt4GQ--.10745S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1xGw4UZr1DAw17CryUKFg_yoW8Gw1Upa
        1DG39IkrW0qr4IqFs7Ar17ZF98uwsYga4UKF4Fk34q9F15CrWDtFy3tF95XF4xCry5Xw1a
        qrZ0y39rG3W2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgTmDUUUUU=
X-Originating-IP: [117.36.119.220]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/1tbiQBRgJlSIZQ4tnwABsW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the adapter receive arbitration lost error interrupts,
cdns_i2c_master_xfer return to the caller directly instead of resetting
the adapter which resulted in the adapter being out of control.

So when driver detect err_status such as arbitration lost,
then try to repair and fix it.

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Shikai Wang <sxauwsk@163.com>
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


