Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AFDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D862147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="nilgzKaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D862147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbeHPUqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:46:05 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:56104 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbeHPUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:46:04 -0400
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 41rtzk00wTz1XLDQs;
        Thu, 16 Aug 2018 19:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1534441570;
        bh=rNreBz9tcS3Q2kVTNLarcOTT5RXq5VFV0bGKMsjq8CU=; l=10;
        h=From:From:Reply-To:Sender;
        b=nilgzKaE+Bhk8yGeMZvkxl0wwSwktsGfLVrAMOCqhJY9Ktz7KOe+xq9EmEUA22vD1
         39jWeWh7DDWWAvVMqwNQJZ3RYI/Ym6HN4hQWoWTXD75LjEwh951RkVQo8R7wm8V6tj
         5S6zIdMrdviv0/EKgqSmKauuzRaCsdH29FAlCsDc=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 41rtzj6gVMz6CjRQK;
        Thu, 16 Aug 2018 19:46:09 +0200 (CEST)
X-AuditID: 0a3aad10-16dff70000000c8a-e5-5b75b862ba2b
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id A4.9C.03210.268B57B5; Thu, 16 Aug 2018 19:46:10 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (fe-hub1000.de.bosch.com [10.4.103.107])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 41rtzj4zDvz6D6hgb;
        Thu, 16 Aug 2018 19:46:09 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 FE-HUB1000.de.bosch.com (10.4.103.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 16 Aug 2018 19:46:09 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <andy.shevchenko@gmail.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Xin <xin.wang7@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2] eeprom: at24: Fix unexpected timeout under high load
Date:   Thu, 16 Aug 2018 19:45:34 +0200
Message-ID: <1534441534-6357-1-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
References: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22SbUxbVRjHOff25bRy7eV2yEN50VyiH5YwqWJWx7IscdPO7MOyxCXaD/Ni
        L7RKW3Jvi4NkEbcob5lA6QgS1rFBYp1bFtgLBeZwdS4DN2Y0IrjYbnPrCuomQnFzsnkvhbUf
        /Pac5//8zv+cfx5MMufVBmx3unnByVWwKq1Cu+5YXmFp0GMpavosyzTd8jUyLXovqE1D106r
        THt7jqtM9YvzyPTDUJdqo8r84B8vMvdMXFWaBzt/UZtHDhxVm+f687cp39Kut/IV9ipeeH7D
        21rbnkB25Z2CXW0TcUUtiuQ2Ig0Guhja7p9QNyItZug6AkZPHlImDiMIRq+HicRhAIG/NYpk
        REWvhqmLQVIWVtHtCNoWppZ4km5EEL57QyFP6WkzTMxFJRxjBf0s9IeL5TZFvwoDp66rEt75
        MDXeQMq1Rhofm51dqhn6Nfh22q9MzGfA6Kc3l64kaYBzsRjZgnSdKVJnitSNiCMos4wvqnKs
        fdloWiOU8mJNkXHNOy5HP0rkSgfR4FhZCNEYsenUlYDHwii5KrHaEUIvYYLNpObrpNaTpS5r
        tY0TbTsFTwUvsgYKpaWlMfrHbdFT6rCLot3lDCHAJLuKGj8hcZSVq67hBVcCC6EcrGCzKOMW
        u4Whyzk3/x7PV/LCilqCMQvUhQEJzBD4cn5Xmb3CvSKzeQnPp1KVVFsCa0LoRZwuef91WvYW
        KzmHaC9fxrMTOLPSTaJj6BX87939XpJROF1O3pBFdctPoOVJm8f5+AWGXOrHYdHCZKYIyVtm
        0CSSMtRTzTKcLq1v0huooL7rTSZjuZmEXuiVGDqeAbHARpi8JK1V17mb0m4F41LlO0hAQ+wU
        AX0L9ST09HYo4dGhvSr4fqhTDb7Zi2r4aHgPhsnuZgz1D30YbvzxFYaO+LAGYuErGhj/aVoD
        /vYWLXibrmlhsvdXLfTua6XgzPhRHYxEAzREphZo+M5/mYH5Bz8z4B1s14P3yLFM6JuJZMHZ
        e6PZcP9gc86MlCsh5dpOL+Xq5tz/k+tyN/k5Qy3y79RHvoz+rTu+Ycu9129v1a3d3fCGa/0H
        TxcaP6z685HPEv089+G6HZsivvCZw8Sms4FvvL8Vf7K5cCS9u+Pj98ueK1l8FwmttdtLzl8u
        jFo7+vbHNm+tu0QcWMyP375Ve2cu9EWNf/vu3z0u78IzT8w19uyz7ijoM2zLu6rLuVXQ5GVO
        sgrRxhlXk4LI/QdC4Md/VwQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xin <xin.wang7@cn.bosch.com>

Within at24_loop_until_timeout the timestamp used for timeout checking
is recorded after the I2C transfer and sleep_range(). Under high CPU
load either the execution time for I2C transfer or sleep_range() could
actually be larger than the timeout value. Worst case the I2C transfer
is only tried once because the loop will exit due to the timeout
although the EEPROM is now ready.

To fix this issue the timestamp is recorded at the beginning of each
iteration. That is, before I2C transfer and sleep. Then the timeout
is actually checked against the timestamp of the previous iteration.
This makes sure that even if the timeout is reached, there is still one
more chance to try the I2C transfer in case the EEPROM is ready.

Example:

If you have a system which combines high CPU load with repeated EEPROM
writes you will run into the following scenario.

 - System makes a successful regmap_bulk_write() to EEPROM.
 - System wants to perform another write to EEPROM but EEPROM is still
   busy with the last write.
 - Because of high CPU load the usleep_range() will sleep more than
   25 ms (at24_write_timeout).
 - Within the over-long sleeping the EEPROM finished the previous write
   operation and is ready again.
 - at24_loop_until_timeout() will detect timeout and won't try to write.

Signed-off-by: Wang Xin <xin.wang7@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
Changes in v2:
 - Remove loop macro
 - Accept superfluous sleep in case of timeout
 - Add concrete example to commit message
---
 drivers/misc/eeprom/at24.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f5cc517..37a5c8b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -106,23 +106,6 @@ static unsigned int at24_write_timeout = 25;
 module_param_named(write_timeout, at24_write_timeout, uint, 0);
 MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
 
-/*
- * Both reads and writes fail if the previous write didn't complete yet. This
- * macro loops a few times waiting at least long enough for one entire page
- * write to work while making sure that at least one iteration is run before
- * checking the break condition.
- *
- * It takes two parameters: a variable in which the future timeout in jiffies
- * will be stored and a temporary variable holding the time of the last
- * iteration of processing the request. Both should be unsigned integers
- * holding at least 32 bits.
- */
-#define at24_loop_until_timeout(tout, op_time)				\
-	for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),	\
-	     op_time = 0;						\
-	     op_time ? time_before(op_time, tout) : true;		\
-	     usleep_range(1000, 1500), op_time = jiffies)
-
 struct at24_chip_data {
 	/*
 	 * these fields mirror their equivalents in
@@ -308,13 +291,22 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 	/* adjust offset for mac and serial read ops */
 	offset += at24->offset_adj;
 
-	at24_loop_until_timeout(timeout, read_time) {
+	timeout = jiffies + msecs_to_jiffies(at24_write_timeout);
+	do {
+		/*
+		 * The timestamp shall be taken before the actual operation
+		 * to avoid a premature timeout in case of high CPU load.
+		 */
+		read_time = jiffies;
+
 		ret = regmap_bulk_read(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
 		if (!ret)
 			return count;
-	}
+
+		usleep_range(1000, 1500);
+	} while (time_before(read_time, timeout));
 
 	return -ETIMEDOUT;
 }
@@ -358,14 +350,23 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 	regmap = at24_client->regmap;
 	client = at24_client->client;
 	count = at24_adjust_write_count(at24, offset, count);
+	timeout = jiffies + msecs_to_jiffies(at24_write_timeout);
+
+	do {
+		/*
+		 * The timestamp shall be taken before the actual operation
+		 * to avoid a premature timeout in case of high CPU load.
+		 */
+		write_time = jiffies;
 
-	at24_loop_until_timeout(timeout, write_time) {
 		ret = regmap_bulk_write(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
 		if (!ret)
 			return count;
-	}
+
+		usleep_range(1000, 1500);
+	} while (time_before(write_time, timeout));
 
 	return -ETIMEDOUT;
 }
-- 
2.7.4

