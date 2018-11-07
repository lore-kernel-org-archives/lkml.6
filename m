Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58BC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FEC20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FEC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbeKGMIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:08:34 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:41150 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389296AbeKGMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:08:34 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992820AbeKGCjvVMmyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Wed, 7 Nov 2018 03:39:51 +0100
Date:   Wed, 7 Nov 2018 02:39:51 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Matt Turner <mattst88@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: m41t80: Complete error propagation from SMBus calls
Message-ID: <alpine.LFD.2.21.1811070142240.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complement commit 85d77047c4ea ("drivers/rtc/rtc-m41t80.c: propagate 
error value from smbus functions") and correct the remaining places that 
fail to propagate the error code from SMBus calls.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
References: 85d77047c4ea ("drivers/rtc/rtc-m41t80.c: propagate error value from smbus functions")
---
Hi,

 I think this does not qualify for backporting, but please feel free to 
decide otherwise.

 This change I did verify at run time to the extent I was able to, but I 
didn't try to trigger artificial errors.  Also the M41T81, which is the 
device I've been using this driver with, does not have battery failure 
indication implemented, so I could not execute the procfs handling path 
(again without making some artificial changes).  These changes should be 
obvious regardless.

 I'll be posting further patches over the coming weeks, based on my 
original effort as archived here: <https://lkml.org/lkml/2008/5/12/385>,
<https://lore.kernel.org/patchwork/project/lkml/list/?series=73524&archive=both> 
However I have just realised they'll need another iteration before I post 
them.  So for now just these two obvious fixes.

 Please apply.

  Maciej
---
 drivers/rtc/rtc-m41t80.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

linux-rtc-m41t80-err.diff
Index: linux-20181008-swarm64-eb/drivers/rtc/rtc-m41t80.c
===================================================================
--- linux-20181008-swarm64-eb.orig/drivers/rtc/rtc-m41t80.c
+++ linux-20181008-swarm64-eb/drivers/rtc/rtc-m41t80.c
@@ -217,7 +217,7 @@ static int m41t80_rtc_read_time(struct d
 					    sizeof(buf), buf);
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to read date\n");
-		return -EIO;
+		return err;
 	}
 
 	tm->tm_sec = bcd2bin(buf[M41T80_REG_SEC] & 0x7f);
@@ -274,10 +274,11 @@ static int m41t80_rtc_set_time(struct de
 	if (flags < 0)
 		return flags;
 
-	if (i2c_smbus_write_byte_data(client, M41T80_REG_FLAGS,
-				      flags & ~M41T80_FLAGS_OF)) {
+	err = i2c_smbus_write_byte_data(client, M41T80_REG_FLAGS,
+					flags & ~M41T80_FLAGS_OF);
+	if (err < 0) {
 		dev_err(&client->dev, "Unable to write flags register\n");
-		return -EIO;
+		return err;
 	}
 
 	return err;
@@ -287,10 +288,12 @@ static int m41t80_rtc_proc(struct device
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct m41t80_data *clientdata = i2c_get_clientdata(client);
-	u8 reg;
+	int reg;
 
 	if (clientdata->features & M41T80_FEATURE_BL) {
 		reg = i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
+		if (reg < 0)
+			return reg;
 		seq_printf(seq, "battery\t\t: %s\n",
 			   (reg & M41T80_FLAGS_BATT_LOW) ? "exhausted" : "ok");
 	}
