Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3150C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A49218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wf9CoRoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfA3Jmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:42:52 -0500
Received: from m12-11.163.com ([220.181.12.11]:54395 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfA3Jmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hBdMe
        YqWOgwoCMrt5lUW7Gyey2VQfeeIjvvw5BlxhRw=; b=Wf9CoRoADJFNPfxz+Gar+
        wodcD1wPp40pjrZLquHUpiBzxSE23+KeuMu5dq06AFG90KZfkZC0MiRHPyhw62SB
        FYWmh66kuDbeYdhhbUL0d0LLq6sURGQJh+Bg+ie5Toy6E9pZ5J0lGnvWiCObW94J
        t3N6jCgFfbkKNSEhfHgBxk=
Received: from localhost.localdomain (unknown [117.36.119.152])
        by smtp7 (Coremail) with SMTP id C8CowACnVnuOcVFc23h4Dg--.63966S3;
        Wed, 30 Jan 2019 17:42:39 +0800 (CST)
From:   sxauwsk <sxauwsk@163.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, sxauwsk@163.com
Subject: [PATCH] i2c: cadence: try reset when master receive error interrupts
Date:   Wed, 30 Jan 2019 03:52:14 +0800
Message-Id: <20190129195214.30272-1-sxauwsk@163.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowACnVnuOcVFc23h4Dg--.63966S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1rXrW5AFy5Jr1UZryfXrb_yoW8XrWkpa
        1UG39IkrWIqF4IvFs7Zr17ZFy5uwsYga4jkr4Fk3sruF15Crn8Ka43tF98WF4xCry5X342
        qrZ8t39rG3W2vF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uoc_hUUUUU=
X-Originating-IP: [117.36.119.152]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBZA9MJlQHDeqMrgAAsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the adapter receive error interrupts, such as NACK, arbitration lost,
cdns_i2c_master_xfer return to the caller directly instead of resuming 
the adapter which resulted in the adapter being out of control.

So when driver detect err_status then try to repair and fix it.

Signed-off-by: sxauwsk <sxauwsk@163.com>
---
 drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..e10048d7524a 100644
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
 
@@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			id->bus_hold_flag = 0;
 
 		ret = cdns_i2c_process_msg(id, msgs, adap);
-		if (ret)
+		if (!ret)
 			goto out;
 
 		/* Report the other error interrupts to application */
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


