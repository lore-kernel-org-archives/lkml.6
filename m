Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692D5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247F620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYcRAOOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247F620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbeKAILF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731389AbeKAILC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C87E208E3;
        Wed, 31 Oct 2018 23:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027450;
        bh=mI4rkwRfpdXnDl9oWOd9suwcjunbLincP2B5YfZGY+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYcRAOOf6w1ABGKc3iNDiS0k839mCAefbh2DxpD2zt05GEHgjU9DSmFmgTxVB+Trk
         H+tgOBUarpzBRKUhsFuXSQmjhOQivJVsI2Cv9QDvsoURf4XojPgS01OATbcyQb+Zbx
         MO3oYwXQn/zgBfjF+RnVeLuIEwk+9ysxTLBbrTLQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 70/73] mfd: menelaus: Fix possible race condition and leak
Date:   Wed, 31 Oct 2018 19:09:45 -0400
Message-Id: <20181031230948.29203-70-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 9612f8f503804d2fd2f63aa6ba1e58bba4612d96 ]

The IRQ work is added before the struct rtc is allocated and registered,
but this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before calling menelaus_add_irq_work.

Also, this solves a possible leak as the RTC is never released.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/menelaus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 29b7164a823b..d28ebe7ecd21 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1094,6 +1094,7 @@ static void menelaus_rtc_alarm_work(struct menelaus_chip *m)
 static inline void menelaus_rtc_init(struct menelaus_chip *m)
 {
 	int	alarm = (m->client->irq > 0);
+	int	err;
 
 	/* assume 32KDETEN pin is pulled high */
 	if (!(menelaus_read_reg(MENELAUS_OSC_CTRL) & 0x80)) {
@@ -1101,6 +1102,12 @@ static inline void menelaus_rtc_init(struct menelaus_chip *m)
 		return;
 	}
 
+	m->rtc = devm_rtc_allocate_device(&m->client->dev);
+	if (IS_ERR(m->rtc))
+		return;
+
+	m->rtc->ops = &menelaus_rtc_ops;
+
 	/* support RTC alarm; it can issue wakeups */
 	if (alarm) {
 		if (menelaus_add_irq_work(MENELAUS_RTCALM_IRQ,
@@ -1125,10 +1132,8 @@ static inline void menelaus_rtc_init(struct menelaus_chip *m)
 		menelaus_write_reg(MENELAUS_RTC_CTRL, m->rtc_control);
 	}
 
-	m->rtc = rtc_device_register(DRIVER_NAME,
-			&m->client->dev,
-			&menelaus_rtc_ops, THIS_MODULE);
-	if (IS_ERR(m->rtc)) {
+	err = rtc_register_device(m->rtc);
+	if (err) {
 		if (alarm) {
 			menelaus_remove_irq_work(MENELAUS_RTCALM_IRQ);
 			device_init_wakeup(&m->client->dev, 0);
-- 
2.17.1

