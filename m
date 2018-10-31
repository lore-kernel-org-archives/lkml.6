Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4623BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CEC204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmIG9Eg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CEC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeKAIMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732395AbeKAIMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4727420843;
        Wed, 31 Oct 2018 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027547;
        bh=nHMmEdCyeYKqJqv4qNZqu092H45FL8rOEq7T/32ZSho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmIG9Eg9K0W80KlN1dRj6Jl+cAwzux4GtzzEKilWXu7vAyZ+lt9wwgP7Pxp8CscCh
         88XOb+yvBkWoEbr9R2WPg2Go++9BpCaxJvDRcD3ZX/rt/erw06iGAtVtI/5oDklxXk
         TYX3roGh34FU9hfwtRy780kRxKm2ZXev/rA+Mpr4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 22/22] mfd: menelaus: Fix possible race condition and leak
Date:   Wed, 31 Oct 2018 19:12:06 -0400
Message-Id: <20181031231206.29509-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231206.29509-1-sashal@kernel.org>
References: <20181031231206.29509-1-sashal@kernel.org>
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
index 9f01aef539dd..8fcb503daae1 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1121,6 +1121,7 @@ static void menelaus_rtc_alarm_work(struct menelaus_chip *m)
 static inline void menelaus_rtc_init(struct menelaus_chip *m)
 {
 	int	alarm = (m->client->irq > 0);
+	int	err;
 
 	/* assume 32KDETEN pin is pulled high */
 	if (!(menelaus_read_reg(MENELAUS_OSC_CTRL) & 0x80)) {
@@ -1128,6 +1129,12 @@ static inline void menelaus_rtc_init(struct menelaus_chip *m)
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
@@ -1152,10 +1159,8 @@ static inline void menelaus_rtc_init(struct menelaus_chip *m)
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

