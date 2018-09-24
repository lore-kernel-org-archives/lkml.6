Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04682C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90432086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90432086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbeIXVID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:08:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43352 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733208AbeIXVIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:08:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BBDF020723; Mon, 24 Sep 2018 17:05:24 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7856320731;
        Mon, 24 Sep 2018 17:05:14 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: rs5c348: report error when time is invalid
Date:   Mon, 24 Sep 2018 17:05:09 +0200
Message-Id: <20180924150509.2082-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924150509.2082-1-alexandre.belloni@bootlin.com>
References: <20180924150509.2082-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of resetting the RTC to an bogus valid time, let userspace know
that the time is invalid when XSTP is set. Reset XSTP when setting the time
again.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rs5c348.c | 43 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 7b9c7dc5b309..6582be707bd0 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -66,6 +66,17 @@ rs5c348_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u8 txbuf[5+7], *txp;
 	int ret;
 
+	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL2));
+	if (ret < 0)
+		return ret;
+	if (ret & RS5C348_BIT_XSTP) {
+		txbuf[0] = RS5C348_CMD_W(RS5C348_REG_CTL2);
+		txbuf[1] = 0;
+		ret = spi_write_then_read(spi, txbuf, 2, NULL, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* Transfer 5 bytes before writing SEC.  This gives 31us for carry. */
 	txp = txbuf;
 	txbuf[0] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
@@ -102,6 +113,16 @@ rs5c348_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	u8 txbuf[5], rxbuf[7];
 	int ret;
 
+	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL2));
+	if (ret < 0)
+		return ret;
+	if (ret & RS5C348_BIT_VDET)
+		dev_warn(&spi->dev, "voltage-low detected.\n");
+	if (ret & RS5C348_BIT_XSTP) {
+		dev_warn(&spi->dev, "oscillator-stop detected.\n");
+		return -EINVAL;
+	}
+
 	/* Transfer 5 byte befores reading SEC.  This gives 31us for carry. */
 	txbuf[0] = RS5C348_CMD_R(RS5C348_REG_CTL2); /* cmd, ctl2 */
 	txbuf[1] = 0;	/* dummy */
@@ -165,28 +186,6 @@ static int rs5c348_probe(struct spi_device *spi)
 	dev_info(&spi->dev, "spiclk %u KHz.\n",
 		 (spi->max_speed_hz + 500) / 1000);
 
-	/* turn RTC on if it was not on */
-	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL2));
-	if (ret < 0)
-		return ret;
-	if (ret & (RS5C348_BIT_XSTP | RS5C348_BIT_VDET)) {
-		u8 buf[2];
-		struct rtc_time tm;
-		if (ret & RS5C348_BIT_VDET)
-			dev_warn(&spi->dev, "voltage-low detected.\n");
-		if (ret & RS5C348_BIT_XSTP)
-			dev_warn(&spi->dev, "oscillator-stop detected.\n");
-		rtc_time_to_tm(0, &tm);	/* 1970/1/1 */
-		ret = rs5c348_rtc_set_time(&spi->dev, &tm);
-		if (ret < 0)
-			return ret;
-		buf[0] = RS5C348_CMD_W(RS5C348_REG_CTL2);
-		buf[1] = 0;
-		ret = spi_write_then_read(spi, buf, sizeof(buf), NULL, 0);
-		if (ret < 0)
-			return ret;
-	}
-
 	ret = spi_w8r8(spi, RS5C348_CMD_R(RS5C348_REG_CTL1));
 	if (ret < 0)
 		return ret;
-- 
2.19.0

