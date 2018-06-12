Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB984C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE98208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIwEjXFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE98208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933134AbeFLD3D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:29:03 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42023 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbeFLD26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:28:58 -0400
Received: by mail-pg0-f67.google.com with SMTP id c10-v6so5135723pgu.9;
        Mon, 11 Jun 2018 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XDsOuC7ulHg9Wv2Ux27pCpf+hWW9Afk1tzp7e9qxsig=;
        b=ZIwEjXFgCsbRfkHqZMyapFGrtJVuaHGvF8hJnYSHeB5dISP0g3/z2UIifEwNoCZa8v
         jIINbLl2QaTTvnJMdrBi5ATysBzU6kvfzcC1SODXYFrrN/5iM7owiw9AkQSZIepMB6gp
         N8UjrIluP//Cp5N/BRvHs4xuAun6hUcZDfnHNT5F7IhP7RMwrjvtIbDD+RezD5oi/vwj
         uYrNT/KRh7RmyDSQKRNM6ADx6/qaMyqTTCk56IS0EdlOljdrsIW2FDBaW9SoBO6981HF
         sdYGOEs017Kv9fkVcMoj5udIqxxgi4a7s9ts/BsII8fUqgmAS+rGb/SDboBRVJRSllXd
         4c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XDsOuC7ulHg9Wv2Ux27pCpf+hWW9Afk1tzp7e9qxsig=;
        b=Gh6GsatM6vvlTNze+K4LrHFf8yPaCHxJTyfOXs0h+Dotb0Z+m0tPUSccE7654e13kr
         hC3TtX8+Zj/KKnN0+Y6qsFez6w1drekuCWcLmEwKJ0R1T25/1Y5AjWxeNPe3hwoWAAaO
         d3ncsWW8fi8OYKf/McB81dqdkKpaG/gySNXGmQ0o2HywSvLqFExIAS8qcjJ5xGFemKAw
         VkWXUDRSLtx+e4x7cGHDVv9dbDxxswGgORmjwwkYwbIODiiXn1PV0vFDbg6Sp7DGIFaI
         5nzo4TUAfdeaep2xztlyKmGXq5Z0btVO2q/p5ANoUggAvwVGumqgjnAyQ5GMcRcJ7mtS
         J7jQ==
X-Gm-Message-State: APt69E0YOZYUG4t8nQF5JMzLlT3bSWIos1LX/UVUX6VLcE3B6Kvx1EXf
        muu4qfFO0pSuq/g5k8OHS+I=
X-Google-Smtp-Source: ADUXVKL/CClaYbkQQgEumBBWshm5yU/2BpoEkRfXfdIH8Bpa6gv5mfXOpLnTC27fM2JUY8x3WRIFZw==
X-Received: by 2002:a62:c45a:: with SMTP id y87-v6mr1956283pff.190.1528774138233;
        Mon, 11 Jun 2018 20:28:58 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id k10-v6sm61081447pfj.29.2018.06.11.20.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:28:57 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: max732x: add error handling for i2c_new_dummy
Date:   Tue, 12 Jun 2018 11:28:52 +0800
Message-Id: <1528774132-38287-1-git-send-email-jiazhouyang09@gmail.com>
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
 drivers/gpio/gpio-max732x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 9d8bcc6..f03cb0b 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -653,6 +653,12 @@ static int max732x_probe(struct i2c_client *client,
 		chip->client_group_a = client;
 		if (nr_port > 8) {
 			c = i2c_new_dummy(client->adapter, addr_b);
+			if (!c) {
+				dev_err(&client->dev,
+					"Failed to allocate I2C device\n");
+				ret = -ENODEV;
+				goto out_failed;
+			}
 			chip->client_group_b = chip->client_dummy = c;
 		}
 		break;
@@ -660,6 +666,12 @@ static int max732x_probe(struct i2c_client *client,
 		chip->client_group_b = client;
 		if (nr_port > 8) {
 			c = i2c_new_dummy(client->adapter, addr_a);
+			if (!c) {
+				dev_err(&client->dev,
+					"Failed to allocate I2C device\n");
+				ret = -ENODEV;
+				goto out_failed;
+			}
 			chip->client_group_a = chip->client_dummy = c;
 		}
 		break;
-- 
2.7.4

