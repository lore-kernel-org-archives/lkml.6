Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F6EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9862214FE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9862214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbeIXVIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:08:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733102AbeIXVIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:08:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 85D2C207CA; Mon, 24 Sep 2018 17:05:23 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 539B420723;
        Mon, 24 Sep 2018 17:05:13 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: rs5c348: remove forward declaration
Date:   Mon, 24 Sep 2018 17:05:08 +0200
Message-Id: <20180924150509.2082-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924150509.2082-1-alexandre.belloni@bootlin.com>
References: <20180924150509.2082-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name passed to devm_rtc_device_register is now unused. anyway, switch
to devm_rtc_allocate_device to avoid forward declaring rs5c348_driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rs5c348.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index aeb14fc0175d..7b9c7dc5b309 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -143,8 +143,6 @@ static const struct rtc_class_ops rs5c348_rtc_ops = {
 	.set_time	= rs5c348_rtc_set_time,
 };
 
-static struct spi_driver rs5c348_driver;
-
 static int rs5c348_probe(struct spi_device *spi)
 {
 	int ret;
@@ -195,15 +193,15 @@ static int rs5c348_probe(struct spi_device *spi)
 	if (ret & RS5C348_BIT_24H)
 		pdata->rtc_24h = 1;
 
-	rtc = devm_rtc_device_register(&spi->dev, rs5c348_driver.driver.name,
-				  &rs5c348_rtc_ops, THIS_MODULE);
-
+	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
 	pdata->rtc = rtc;
 
-	return 0;
+	rtc->ops = &rs5c348_rtc_ops;
+
+	return rtc_register_device(rtc);
 }
 
 static struct spi_driver rs5c348_driver = {
-- 
2.19.0

