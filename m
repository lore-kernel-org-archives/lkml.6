Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A26C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEA520862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEA520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbeHAUAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:00:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389737AbeHATIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC2F510F4;
        Wed,  1 Aug 2018 17:04:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 161/336] rtc: tps65910: fix possible race condition
Date:   Wed,  1 Aug 2018 18:48:16 +0200
Message-Id: <20180801165035.279070847@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit e6000a438e534ee0afd9e83b67f4e23a26dd1067 ]

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-tps65910.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -380,6 +380,10 @@ static int tps65910_rtc_probe(struct pla
 	if (!tps_rtc)
 		return -ENOMEM;
 
+	tps_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(tps_rtc->rtc))
+		return PTR_ERR(tps_rtc->rtc);
+
 	/* Clear pending interrupts */
 	ret = regmap_read(tps65910->regmap, TPS65910_RTC_STATUS, &rtc_reg);
 	if (ret < 0)
@@ -421,10 +425,10 @@ static int tps65910_rtc_probe(struct pla
 	tps_rtc->irq = irq;
 	device_set_wakeup_capable(&pdev->dev, 1);
 
-	tps_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-		&tps65910_rtc_ops, THIS_MODULE);
-	if (IS_ERR(tps_rtc->rtc)) {
-		ret = PTR_ERR(tps_rtc->rtc);
+	tps_rtc->rtc->ops = &tps65910_rtc_ops;
+
+	ret = rtc_register_device(tps_rtc->rtc);
+	if (ret) {
 		dev_err(&pdev->dev, "RTC device register: err %d\n", ret);
 		return ret;
 	}


