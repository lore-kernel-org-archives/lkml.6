Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D26C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA4320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBOplPaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA4320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLFTXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47001 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLFTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so599281ply.13;
        Thu, 06 Dec 2018 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bc7HBFWTKYYQqwxBR3WzBFLJipRI+rd3hDj3pkEYFaI=;
        b=HBOplPaRO6bJklISdoGOgf6k2LHgEheH3DRYPOyLprwe6/NpI1sdASotrYzKZQCXU3
         ykHxuqvjGfrsLy0HD+dJBmPVWF+a7V/nfAk7gKdwHaNBgvgcmbdSjs39NU9oy32vjMTg
         OIsDJzhdsT2p6/GSORrQNz1ubvL6jP3B8xxtugPB4IdYX+KZO2lch4LfqC1PhUJAUtOa
         v0f06wqmd/6ph+2nPBjOe6GEvwUaGkXp7r5iEt/dF+8hDhC5hn0p/5u/ozyL4yDgiaYI
         DmBTHbY6bBAPGIL/y/PkYeXQtTb++UFL9U5miPj9VBQijh1/myunweNGsPfbv53UeRKA
         lYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Bc7HBFWTKYYQqwxBR3WzBFLJipRI+rd3hDj3pkEYFaI=;
        b=jLErlvtF0qvg+NFqwfkSaPKfYlcME1DEHxhV8eB1FIRsc7rXHboFgwGr7UsTGqHRPn
         NigICNhepLYR2eX/6OX8x4SQNo0iP0xpkWjHtM1fZgvrew4oJqOv76Tx8RY7YamP4mPy
         lvaI92GOjTZhpkLEBlprkJ4dk+5bW8bsGhj/9gY1grq9mZ/mnMEQ6fnSl/VVqzmWCkVk
         e+bIAlsxMTwbJmgoysw4REPN8rMtDIv6tf5bEVl2rTdtgCf7Msk8L4Q0DQtg1i9z0kJi
         bOBxFL+833N4rzkUTUp8tIZMtG2rDPIVQiAlQa5bd+snB81ddoHGauN87GH/cVPZZqxG
         ShSA==
X-Gm-Message-State: AA+aEWYUBhdf5dElHiENR1V9x7y5rI5XhSIt8V7DZXLpnTBcIfBAgwH2
        cb1NbheavyCebMMse5PhYHK+5Nq+
X-Google-Smtp-Source: AFSGD/UqtoXNzxzNteAeF7mrF+slpeTrlZXoJsCMHCfHR3aScabIOLKYxYOffjvC+8NvUzPvlHBtDg==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr29490298pll.111.1544124172094;
        Thu, 06 Dec 2018 11:22:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1sm1327124pfe.9.2018.12.06.11.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:51 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/13] hwmon: (pwm-fan) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:29 -0800
Message-Id: <1544124153-23961-10-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
References: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion was done done using the coccinelle script at
https://github.com/groeck/coccinelle-patches/raw/master/hwmon/sensor-devattr-w6.cocci

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7da6a160d45a..2c944825026f 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -72,8 +72,8 @@ static void pwm_fan_update_state(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	ctx->pwm_fan_state = i;
 }
 
-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 	unsigned long pwm;
@@ -90,8 +90,8 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_pwm(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 
@@ -99,7 +99,7 @@ static ssize_t show_pwm(struct device *dev,
 }
 
 
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
 
 static struct attribute *pwm_fan_attrs[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
-- 
2.7.4

