Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68123C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A29321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="NOSEXRqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfA2KYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:24:06 -0500
Received: from mout02.posteo.de ([185.67.36.66]:35579 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbfA2KYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:24:04 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B33E92400FD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548757440; bh=Z9t6EZyxo16c6vcFyes+GmXGLWU/TBpT2YHjRl36LhU=;
        h=From:To:Cc:Subject:Date:From;
        b=NOSEXRqJdWATgByLLunzk0rsV0hsCUzCdmSC570r9uwqyBkfINtLOiQnBPf+qQW2x
         HnA8X0dl8qP707FU6QV4oVhnG/93iz0IgiZZFg29SPDAIG+wD/4/CHLUa88wu5NXkG
         99G9a9kER7eqtRsjXM1TEC1dyaD8tKIxJfLImvoKkx8jrXFjPUP/ftlDAW7XFs+d1G
         y0nQNRMx+yjL4dhdpT1DF7qIvoSHOBds/s984L6aRQrXDG6nJgMVCeajUgMslvJBBh
         S/CW1Hd1ePlivxqk4gDYBgTELSgbKug8j0BWJVPZ5Gzvjy7SrtrcYjuY+fw8m8gdgJ
         qmbzPV8+cEofA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pjJv71nWz9rxg;
        Tue, 29 Jan 2019 11:23:59 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 2/2] Input: st1232 - switch to gpiod API
Date:   Tue, 29 Jan 2019 11:23:47 +0100
Message-Id: <20190129102347.27754-2-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129102347.27754-1-martink@posteo.de>
References: <20190129102347.27754-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Use devm_gpiod_get_optional() and gpiod_set_value_cansleep() instead
of the old API. The st1232_ts_power() now passes on the inverted "poweron"
value to reflect the correct logical value.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

Tested and works. thanks for your help Dmitry,

                          martin



 drivers/input/touchscreen/st1232.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 777df903605d..04d75b08be44 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -45,7 +45,7 @@ struct st1232_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
 	struct dev_pm_qos_request low_latency_req;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
@@ -142,8 +142,8 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 
 static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
 {
-	if (gpio_is_valid(ts->reset_gpio))
-		gpio_direction_output(ts->reset_gpio, poweron);
+	if (ts->reset_gpio)
+		gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
 }
 
 static const struct st_chip_info st1232_chip_info = {
@@ -215,15 +215,13 @@ static int st1232_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	ts->input_dev = input_dev;
 
-	ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
-	if (gpio_is_valid(ts->reset_gpio)) {
-		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
-		if (error) {
-			dev_err(&client->dev,
-				"Unable to request GPIO pin %d.\n",
-				ts->reset_gpio);
-				return error;
-		}
+	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->reset_gpio)) {
+		error = PTR_ERR(ts->reset_gpio);
+		dev_err(&client->dev, "Unable to request GPIO pin: %d.\n",
+			error);
+		return error;
 	}
 
 	st1232_ts_power(ts, true);
-- 
2.20.1

