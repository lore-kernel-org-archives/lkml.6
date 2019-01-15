Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A956C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EAE20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbSRwjQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfAOKdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:33:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42412 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfAOKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:33:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so1068034pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=z+FEdKv7SOmZhEaX0R5BmbcCjlQ5jY9He3y4lwTJ11k=;
        b=fbSRwjQ/EGE0uRRDVnqryJ62/1KLUb9050Vx0WaPWP2IPPZzpgcicvYwGhus6ms83/
         vqYWn8nBZ+gzWOuID2hqv5KFzW4Y1f+twpifDBtDoNro7yv/Zq4ZL+SLk9eqsfDghryP
         b5VC9jSegvUeY5dgh731OrZL/5KfF1Lt7NzyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=z+FEdKv7SOmZhEaX0R5BmbcCjlQ5jY9He3y4lwTJ11k=;
        b=m55tsN9pxLzupQ5221KGd65jVYzs6/UfJBjyudOiNEg0kNn7NDTTBDsi/KtfybF5u+
         0CCHVR0FGrDb0sa9pBNdtjBd+2qEus3MGPuaXIp6dzPE8hglbHDelv4H0dXT3lEGI911
         oLCEIWhF4lxlJg6i2wjbkAl9dHlKG/tP/yNdpmwfwuRjf2g+wS0UQFzlfJlrrIaFgb61
         uSJWIyY3hIOHxHD5qPkGk1Fu1gaCztTMXsieY1p7W6cZCRGnFapUU/N3FS+ubdc/Zo9K
         U0iIZx0zaNe7jS7t+zsXjjmnD36gIa3ceDMHedsj+C9RAaIQ409OrDy3UvyUZaU5aWsr
         xdhA==
X-Gm-Message-State: AJcUukeNZEZNlkdGYco6gh82PGXASqewnH0tnmJzNKAjwdCN5ugP07tC
        XhZw/8ccXdXPYPZwAxv/uq1r4r0sfyjbZg==
X-Google-Smtp-Source: ALg8bN7aQ7UMWqARv8+lFsHSZ+pvlDvq9V5qRH0fxi7L1fUlCtn/k7M0UOlGvcrKwX/sPIAIICtHpw==
X-Received: by 2002:a62:7e13:: with SMTP id z19mr3316400pfc.94.1547548402337;
        Tue, 15 Jan 2019 02:33:22 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d13sm5073957pfd.58.2019.01.15.02.33.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 02:33:21 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com,
        orsonzhai@gmail.com
Subject: [PATCH 2/4] power: supply: sc27xx: Add one property to read charge voltage
Date:   Tue, 15 Jan 2019 18:32:35 +0800
Message-Id: <bb75e6c5c7bd89100c7c667c877b8c97b359ff8a.1547544142.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE property to get charge
voltage sampling by ADC controller, which is used to validate if the
charge voltage is in normal range or not in charger manager.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 76da189..4926b8a 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -72,6 +72,7 @@
  * @lock: protect the structure
  * @gpiod: GPIO for battery detection
  * @channel: IIO channel to get battery temperature
+ * @charge_chan: IIO channel to get charge voltage
  * @internal_resist: the battery internal resistance in mOhm
  * @total_cap: the total capacity of the battery in mAh
  * @init_cap: the initial capacity of the battery in mAh
@@ -92,6 +93,7 @@ struct sc27xx_fgu_data {
 	struct mutex lock;
 	struct gpio_desc *gpiod;
 	struct iio_channel *channel;
+	struct iio_channel *charge_chan;
 	bool bat_present;
 	int internal_resist;
 	int total_cap;
@@ -391,6 +393,18 @@ static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *val)
 	return 0;
 }
 
+static int sc27xx_fgu_get_charge_vol(struct sc27xx_fgu_data *data, int *val)
+{
+	int ret, vol;
+
+	ret = iio_read_channel_processed(data->charge_chan, &vol);
+	if (ret < 0)
+		return ret;
+
+	*val = vol * 1000;
+	return 0;
+}
+
 static int sc27xx_fgu_get_temp(struct sc27xx_fgu_data *data, int *temp)
 {
 	return iio_read_channel_processed(data->channel, temp);
@@ -502,6 +516,14 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = value;
 		break;
 
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = sc27xx_fgu_get_charge_vol(data, &value);
+		if (ret)
+			goto error;
+
+		val->intval = value;
+		break;
+
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		ret = sc27xx_fgu_get_current(data, &value);
@@ -567,6 +589,7 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 };
 
 static const struct power_supply_desc sc27xx_fgu_desc = {
@@ -907,6 +930,12 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->channel);
 	}
 
+	data->charge_chan = devm_iio_channel_get(&pdev->dev, "charge-vol");
+	if (IS_ERR(data->charge_chan)) {
+		dev_err(&pdev->dev, "failed to get charge IIO channel\n");
+		return PTR_ERR(data->charge_chan);
+	}
+
 	data->gpiod = devm_gpiod_get(&pdev->dev, "bat-detect", GPIOD_IN);
 	if (IS_ERR(data->gpiod)) {
 		dev_err(&pdev->dev, "failed to get battery detection GPIO\n");
-- 
1.7.9.5

