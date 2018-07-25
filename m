Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26658C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA0620671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA0620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeGYIqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:46:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54114 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbeGYIqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:46:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B86B207B0; Wed, 25 Jul 2018 09:36:26 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id E5A1620618;
        Wed, 25 Jul 2018 09:36:25 +0200 (CEST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com
Subject: [PATCH v4 2/3] Input: edt-ft5x06 - Set wake/reset values on resume/suspend
Date:   Wed, 25 Jul 2018 09:34:09 +0200
Message-Id: <20180725073410.730-3-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180725073410.730-1-mylene.josserand@bootlin.com>
References: <20180725073410.730-1-mylene.josserand@bootlin.com>
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
index dcde719094f7..dad2f1f8bf89 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1158,6 +1158,12 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 	else
 		regulator_disable(tsdata->vcc);
 
+	if (tsdata->wake_gpio)
+		gpiod_set_value(tsdata->wake_gpio, 0);
+
+	if (tsdata->reset_gpio)
+		gpiod_set_value(tsdata->reset_gpio, 1);
+
 	return 0;
 }
 
@@ -1177,6 +1183,12 @@ static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
 		}
 	}
 
+	if (tsdata->wake_gpio)
+		gpiod_set_value(tsdata->wake_gpio, 1);
+
+	if (tsdata->reset_gpio)
+		gpiod_set_value(tsdata->reset_gpio, 0);
+
 	return 0;
 }
 
-- 
2.11.0

