Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5BB57C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE3208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV5eA4ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFE3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933484AbeFLDfL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:35:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44262 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbeFLDfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:35:09 -0400
Received: by mail-pg0-f66.google.com with SMTP id p21-v6so10758987pgd.11;
        Mon, 11 Jun 2018 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MlqzkGgLdRmxIdvPNSMk5xtZQZeWnIihHFcDgT2MH5s=;
        b=YV5eA4ysnaoNWkuHvwFpW7ZJBBk+xMm3d8H87RsKgwKytt9pSnkX1siuq4OTFBc3mO
         87+ZwOlc1Ik4u3VoDCe/KuJTr1NGfjY+RI1LHuy96OCy8lCdZ9q0z70Ro2K4g6fb/scI
         Pb2CLWy3w3DJiNw3Gf52kOEnCaYGT3vYhOwAspKw8ScRreoR/lzAKkurubVCP7MyTtN4
         YAHqELF3lrWMmQSRYldmlwOy2bhaGTr4tXo6lMDAcMcrqRVV7cupRo12fN4+nBBGV9hK
         L2Qm2GiVPS38Ep3xNhC5QNsvSyXdZqct25tqldD/RGWtIz0O4lcAbrfL0zFPLCbcAQ/W
         WnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MlqzkGgLdRmxIdvPNSMk5xtZQZeWnIihHFcDgT2MH5s=;
        b=TH+zWvzdUatB65/nAh9mlZ5POSWq9/oYpqtsxQs4dDOSAabeLwc98a8fR0Tz615/i0
         xQtpPaxOTAPoDtr3Tctlek7Zfi9YSVqDgeyW99VQTicBOZ/3u/4c5EqHdELVgk3ShvZg
         0fPo9y/T39PGgIAwMRmMsTN5ERhEIkh67j9CqUaU1jRtlaQxMt4BgtBPsgBTZ6zb59TC
         p9fNwkj7lOiH/jexYb8fCWDWeARpQv5iE5hagVndVjRe2ivOgnZBg/1lRFzTGf1zJBnA
         5RCVm0R+2+eM28BOQWjyE7RQDC1iT9H87EfBgXf0BIiKOYUpD1wLx5bXEPoRmRM322yQ
         k4hQ==
X-Gm-Message-State: APt69E1cK72K6VxE9UTfO1R89UX6aXr0bfCiHGnh1PWUb0zaxG7qw7OV
        IRUbNP37ISxTNcMx/TS+R0U=
X-Google-Smtp-Source: ADUXVKIVoX/xgmuhb20ugakJMaHd5DKXMVGxn33dGggBCOhCIlJJNMS/oINAgjggC0Gd81By7dJkpA==
X-Received: by 2002:a65:5a88:: with SMTP id c8-v6mr1594289pgt.287.1528774509232;
        Mon, 11 Jun 2018 20:35:09 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id c12-v6sm41226425pfi.177.2018.06.11.20.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:35:08 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (w83791d) add error handling for i2c_new_dummy
Date:   Tue, 12 Jun 2018 11:35:03 +0800
Message-Id: <1528774504-38755-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i2c_new_dummy fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling i2c_new_dummy.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/hwmon/w83791d.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 28fa3bd..a183432 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1295,8 +1295,15 @@ static int w83791d_detect_subclients(struct i2c_client *client)
 	}
 
 	val = w83791d_read(client, W83791D_REG_I2C_SUBADDR);
-	if (!(val & 0x08))
+	if (!(val & 0x08)) {
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
+		if (data->lm75[0] == NULL) {
+			dev_err(&client->dev,
+				"Failed to allocate I2C device\n");
+			err = -ENODEV;
+			goto error_sc_1;
+		}
+	}
 	if (!(val & 0x80)) {
 		if ((data->lm75[0] != NULL) &&
 				((val & 0x7) == ((val >> 4) & 0x7))) {
@@ -1309,6 +1316,12 @@ static int w83791d_detect_subclients(struct i2c_client *client)
 		}
 		data->lm75[1] = i2c_new_dummy(adapter,
 					      0x48 + ((val >> 4) & 0x7));
+		if (data->lm75[1] == NULL) {
+			dev_err(&client->dev,
+				"Failed to allocate I2C device\n");
+			err = -ENODEV;
+			goto error_sc_1;
+		}
 	}
 
 	return 0;
-- 
2.7.4

