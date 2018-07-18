Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACC82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACC82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeGRTGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:06:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36602 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeGRTGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:06:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7072B20876; Wed, 18 Jul 2018 20:27:37 +0200 (CEST)
Received: from dell-desktop.home (176-137-37-244.abo.bbox.fr [176.137.37.244])
        by mail.bootlin.com (Postfix) with ESMTPSA id C6718206A6;
        Wed, 18 Jul 2018 20:27:36 +0200 (CEST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mylene.josserand@bootlin.com, thomas.petazzoni@bootlin.com
Subject: [PATCH v3 2/3] Input: edt-ft5x06 - Set wake/reset values on resume/suspend
Date:   Wed, 18 Jul 2018 20:27:18 +0200
Message-Id: <20180718182719.29663-3-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180718182719.29663-1-mylene.josserand@bootlin.com>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On resume and suspend, set the value of wake and reset gpios
to be sure that we are in a know state after suspending/resuming.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index aa94494b06b5..b013d97006e6 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1143,6 +1143,12 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 	if (device_may_wakeup(dev))
 		enable_irq_wake(client->irq);
 
+	if (tsdata->wake_gpio)
+		gpiod_set_value(tsdata->wake_gpio, 0);
+
+	if (tsdata->reset_gpio)
+		gpiod_set_value(tsdata->reset_gpio, 1);
+
 	regulator_disable(tsdata->vcc);
 
 	return 0;
@@ -1157,6 +1163,12 @@ static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		disable_irq_wake(client->irq);
 
+	if (tsdata->wake_gpio)
+		gpiod_set_value(tsdata->wake_gpio, 1);
+
+	if (tsdata->reset_gpio)
+		gpiod_set_value(tsdata->reset_gpio, 0);
+
 	ret = regulator_enable(tsdata->vcc);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable vcc: %d\n", ret);
-- 
2.11.0

