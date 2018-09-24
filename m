Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9336C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE2A2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE2A2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbeIXVIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:08:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43350 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbeIXVIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:08:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6ED02207CF; Mon, 24 Sep 2018 17:05:22 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E3B89204AE;
        Mon, 24 Sep 2018 17:05:11 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: rs5c348: remove useless label
Date:   Mon, 24 Sep 2018 17:05:07 +0200
Message-Id: <20180924150509.2082-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8fb1ecb36f7e ("rtc: rtc-rs5c348: use devm_*() functions") the
kfree_exit label simply returns ret.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rs5c348.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index f2de8b17e7e3..aeb14fc0175d 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -161,7 +161,7 @@ static int rs5c348_probe(struct spi_device *spi)
 	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_SECS));
 	if (ret < 0 || (ret & 0x80)) {
 		dev_err(&spi->dev, "not found.\n");
-		goto kfree_exit;
+		return ret;
 	}
 
 	dev_info(&spi->dev, "spiclk %u KHz.\n",
@@ -170,7 +170,7 @@ static int rs5c348_probe(struct spi_device *spi)
 	/* turn RTC on if it was not on */
 	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL2));
 	if (ret < 0)
-		goto kfree_exit;
+		return ret;
 	if (ret & (RS5C348_BIT_XSTP | RS5C348_BIT_VDET)) {
 		u8 buf[2];
 		struct rtc_time tm;
@@ -181,33 +181,29 @@ static int rs5c348_probe(struct spi_device *spi)
 		rtc_time_to_tm(0, &tm);	/* 1970/1/1 */
 		ret = rs5c348_rtc_set_time(&spi->dev, &tm);
 		if (ret < 0)
-			goto kfree_exit;
+			return ret;
 		buf[0] = RS5C348_CMD_W(RS5C348_REG_CTL2);
 		buf[1] = 0;
 		ret = spi_write_then_read(spi, buf, sizeof(buf), NULL, 0);
 		if (ret < 0)
-			goto kfree_exit;
+			return ret;
 	}
 
 	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL1));
 	if (ret < 0)
-		goto kfree_exit;
+		return ret;
 	if (ret & RS5C348_BIT_24H)
 		pdata->rtc_24h = 1;
 
 	rtc = devm_rtc_device_register(&spi->dev, rs5c348_driver.driver.name,
 				  &rs5c348_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(rtc)) {
-		ret = PTR_ERR(rtc);
-		goto kfree_exit;
-	}
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
 	pdata->rtc = rtc;
 
 	return 0;
- kfree_exit:
-	return ret;
 }
 
 static struct spi_driver rs5c348_driver = {
-- 
2.19.0

