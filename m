Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A0B2064D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A0B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeIJBkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:40:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeIJBkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:40:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 74C6A2071D; Sun,  9 Sep 2018 22:49:04 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4BB02203DC;
        Sun,  9 Sep 2018 22:49:04 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] mfd: menelaus: fix possible race condition and leak
Date:   Sun,  9 Sep 2018 22:48:58 +0200
Message-Id: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ work is added before the struct rtc is allocated and registered,
but this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before calling menelaus_add_irq_work.

Also, this solves a possible leak as the RTC is never released.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Lee,

If that is ok with you, I would like to take this patch through the RTC
tree. So I can have a follow up patch removing rtc_device_register().

Thanks

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
2.19.0.rc2

