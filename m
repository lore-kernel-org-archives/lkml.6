Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E60AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1852C20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjC3Gl6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1852C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbeKLJxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732127AbeKLIRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:52 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422AE2154B;
        Sun, 11 Nov 2018 22:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975276;
        bh=N3HqR7bTz75v+OdvrPAsmKVQxyyPQn07p17lQ/4JefQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjC3Gl6GKq/0qOpff1u50PgcGLwkQqlsW3k+rafhbuHvE86ThEFWpXVOVupF7+5zN
         XrEskQX+UtytpVICiXKqlT7GnxLn0a0DQKfSUTNDeyqzPxp7bjmj2P0TWugFxQKNzu
         5k+yQX1OEDvK72W6+ZNFrqHafE+jZX/GeyuCT10c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 187/361] mfd: menelaus: Fix possible race condition and leak
Date:   Sun, 11 Nov 2018 14:18:54 -0800
Message-Id: <20181111221646.583892531@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/menelaus.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1094,6 +1094,7 @@ static void menelaus_rtc_alarm_work(stru
 static inline void menelaus_rtc_init(struct menelaus_chip *m)
 {
 	int	alarm = (m->client->irq > 0);
+	int	err;
 
 	/* assume 32KDETEN pin is pulled high */
 	if (!(menelaus_read_reg(MENELAUS_OSC_CTRL) & 0x80)) {
@@ -1101,6 +1102,12 @@ static inline void menelaus_rtc_init(str
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
@@ -1125,10 +1132,8 @@ static inline void menelaus_rtc_init(str
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


