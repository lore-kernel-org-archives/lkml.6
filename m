Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32208C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5753217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="O1ZeaXYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5753217CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeHDTpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 15:45:22 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:47420 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHDTpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 15:45:22 -0400
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 41jWVh0VTjz4f3kky;
        Sat,  4 Aug 2018 19:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1533404636;
        bh=rNreBz9tcS3Q2kVTNLarcOTT5RXq5VFV0bGKMsjq8CU=; l=10;
        h=From:From:Reply-To:Sender;
        b=O1ZeaXYqdLmhOObkLAA6cpu75WDxf22J+xYLdiffsdjR1NkbWr5b9pQiEo63TLz+9
         303Ik1IpV+uoKOLiAry9jsdylH6xrkixTzQm9WF9iEn22YQo1fMDYLSTcIpzovJ110
         zRGfrZGKJtRGBt3q8hPjiC44b2laMW5JZdD0/T7s=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTP id 41jWVg75gMz6CjQSR;
        Sat,  4 Aug 2018 19:43:55 +0200 (CEST)
X-AuditID: 0a3aad14-86fff70000000cae-a7-5b65e5dc7729
Received: from fe0vm1651.rbesz01.com (Unknown_Domain [10.58.173.29])
        (using TLS with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 34.6D.03246.CD5E56B5; Sat,  4 Aug 2018 19:43:56 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (si-hub1000.de.bosch.com [10.4.103.106])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 41jWVg4vVzzhdYX;
        Sat,  4 Aug 2018 19:43:55 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB1000.de.bosch.com (10.4.103.106) with Microsoft SMTP Server id
 14.3.408.0; Sat, 4 Aug 2018 19:43:55 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Xin <xin.wang7@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Date:   Sat, 4 Aug 2018 19:43:40 +0200
Message-ID: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22SfUwTdxzG+d315Vo4Oa5FvitgshM0IZmCQqxvxGTZ5A9ZdMlMGMnGYX+0
        jX0hvUIE/xCdipAotUMDteALmDnE6MhmKtMYupcwY2ChiCBYFZF1xMX5UiMU5q4UbP/wv7vn
        +X2e5+65o0j2rFxDGS12bLPwJk6mlCg3XEr/aOwJLs6e/DNRO+f8Xa7tfnhVpv2m7bJMe2Tu
        FdL6ut2yLdKC0IwTFbQNjUoLbrZ0ygtedi3bLvlSuUmHTcZKbFudX6I0/PZyhigfTdszFJol
        alBzSj1SUMDkgq/rrrQeKSmWOUFA8NQPROTmBoL2yZ4F5yoCz48jZBiRMVkw0uuZv1YzVdDS
        4kDhQyRTj8D/bFwSNlTMJ3DHd1BWjyhKwmRA3duSsEwzW+HJ+V9kkeplMNJXR0b0JPijeWIe
        JRmAnkCAdCDaFWO5YqwziOhAyWU4u9Kcsy43e5WtFAvV2TmrdlnNXSiymtqDQt4yL2IoxCXQ
        h4dwMSvlK4UqsxflUQSXTOf5dMXsklKrrsrAC4avbRUmLHAaGsXFxbGqd7JQUWo2CoLRavEi
        oEhOTb+tEaNoHV9VjW3WCOZFqZSES6EtO8RIRs/b8W6My7Ft0d1IURzQKvErskk2rMd7yowm
        +6LNpUc6l8Y6sbUEpfCitVSC2L08HEEL5bxZMOoX8A8iOLuoRtFb6GNq9tkJJ8lKLFYL1qTQ
        FydEngmfNFRY3j2BJo2eHt9VzCbHGNGUKXQXiRuq6LxweYL4c0a7gfao3EVs0oIYhda0iQzj
        ToDW4QwIXNgCrZ4gAnfjaQLqAj8RMNDtkkPj8145NAV/VkDA36+Awe9CCmg96VDCcPtjJbQf
        PU7D9b7ORGj6u4mBByOvGXBeO6kCZ8elZJg+3ZAK3879mwqzD7rS4NVAbTqEekbTxbzGD6E3
        cH05+Bs6M8FxeyATeu/dWAHt06EVcK7j2Ep403lhJQyPfZ81Jc5KiLPuzZ2f1c7b3zPrghp9
        N00N6v9L56kNHsrfWKS8llFCWCY3H/5n4OaVeOete03/Ndw/sDsTu9SeKT5xprBadVTuGzzX
        cWc8JPdNufz6yyE1E3Ts/7TwUPnz7V8scce/WKrf1PjZwc+HdjY/Cm5bP/FU2u9/9NU+B/ur
        1ji8QVX4dOz15qJThaO1pviM8xfHbufTPCcRDHxOFmkT+P8BqI+ZuTQEAAA=
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

Signed-off-by: Wang Xin <xin.wang7@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/misc/eeprom/at24.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f5cc517..6d8c294 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -112,16 +112,26 @@ MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
  * write to work while making sure that at least one iteration is run before
  * checking the break condition.
  *
+ * By recording current time at the beginning of one iteration, the timeout
+ * is actually checked against the time in previous iteration. It makes sure,
+ * even the timeout is reached, there is still one more chance to try I2C
+ * transfer in case EEPROM is ready.
+ *
  * It takes two parameters: a variable in which the future timeout in jiffies
  * will be stored and a temporary variable holding the time of the last
  * iteration of processing the request. Both should be unsigned integers
  * holding at least 32 bits.
  */
-#define at24_loop_until_timeout(tout, op_time)				\
-	for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),	\
-	     op_time = 0;						\
-	     op_time ? time_before(op_time, tout) : true;		\
-	     usleep_range(1000, 1500), op_time = jiffies)
+#define at24_loop_until_timeout_begin(tout, op_time)		\
+	tout = jiffies + msecs_to_jiffies(at24_write_timeout);	\
+	while (true) {						\
+		op_time = jiffies;
+
+#define at24_loop_until_timeout_end(tout, op_time)		\
+		if (time_before(tout, op_time))			\
+			break;					\
+		usleep_range(1000, 1500);			\
+	}
 
 struct at24_chip_data {
 	/*
@@ -308,13 +318,14 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 	/* adjust offset for mac and serial read ops */
 	offset += at24->offset_adj;
 
-	at24_loop_until_timeout(timeout, read_time) {
+	at24_loop_until_timeout_begin(timeout, read_time) {
 		ret = regmap_bulk_read(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
 		if (!ret)
 			return count;
 	}
+	at24_loop_until_timeout_end(timeout, read_time)
 
 	return -ETIMEDOUT;
 }
@@ -359,13 +370,14 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 	client = at24_client->client;
 	count = at24_adjust_write_count(at24, offset, count);
 
-	at24_loop_until_timeout(timeout, write_time) {
+	at24_loop_until_timeout_begin(timeout, write_time) {
 		ret = regmap_bulk_write(regmap, offset, buf, count);
 		dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
 			count, offset, ret, jiffies);
 		if (!ret)
 			return count;
 	}
+	at24_loop_until_timeout_end(timeout, write_time)
 
 	return -ETIMEDOUT;
 }
-- 
2.7.4

