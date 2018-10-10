Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A069C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7B121479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvFheePZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7B121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJJLxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:53:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37128 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeJJLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:53:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so1885337pgq.4;
        Tue, 09 Oct 2018 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2pcZhfoBUj85c/KvZuz0NI6wWCc4PRH6zbLnyObSGY=;
        b=qvFheePZmOo1c7AqPxlNV9R98QKObxP8G3ckJk3CPR/jI3Yp0/ure+Dtx2qaZCX6aE
         LVcKCrMNbHd3vsKar3Tx4o2Bx4tu/QUn6U4aNthdieG7PTtezojehA8407dglutf7H5f
         4JKPaGYMXi+iOIlo/BUX/OEAEAoMaiXqU61UnCkB4yus+rNEI5swJTSNSuyaCokjtthD
         h76O7QBDKjWUW7Ja1wxj3V8f5qSb7tLCkjOThKMZuy+1iLmcJEhjhezEMQtrKL22Drol
         kNEKH73ZUoGpgDppZMW3dQMaFw6ECEQr89kW2fArCETT1mqI5fx0NS61Ba1s6UgWwD8Q
         avcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j2pcZhfoBUj85c/KvZuz0NI6wWCc4PRH6zbLnyObSGY=;
        b=e4TZDn+569maCzy0LP5OLva7Ipjh1edUL+Ue2/W7Kccqeip+H1cfszJCXp8q7aKSKj
         3HKnFWEpnDVlvpn64rhGblqr9D4qS7s5JfNoc73gUQ7Rqk9kpQNUxfRjIuYURkjqwx13
         wLC3ikcLggk+sJMSqBRWYuFsuXa7e7xTny1IAZfoqetWfcYcJPhQP/mJF6KuIpK0wuKA
         B73e63Iot9ZLOlCSPSwgB9Ixp6lqmD07GXxsuZVsseRmeQiH1baNUb+SlKNt8QrC8109
         cknL0SOVe1FepGxpTUAe8u0lB6OjN4Qfc+/cc8lBnWnYC0/OyvH2PT7AN1/TLz2DgJe+
         L7sA==
X-Gm-Message-State: ABuFfohOVRxoOLyfqWLxWB4vmWAYOvBx3Vugq8Ap3ofgfpZtXSTnIyEN
        dxBOcsWzejqEvoF0CLbuxrQ=
X-Google-Smtp-Source: ACcGV60XS8JFxkYCpCjUp1extw8A1BUDnNAUW+2CM81iKr9uV8mZ/hQH5NfqTow8kPiDXfNXEWY9oA==
X-Received: by 2002:a63:e70a:: with SMTP id b10-v6mr27348265pgi.363.1539145999431;
        Tue, 09 Oct 2018 21:33:19 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n63-v6sm21171025pfn.9.2018.10.09.21.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 21:33:18 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
Date:   Tue,  9 Oct 2018 21:33:10 -0700
Message-Id: <20181010043310.30873-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010043310.30873-1-nicoleotsuka@gmail.com>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwmon core now has a new optional mode interface. So this patch
just implements this mode support so that user space can check and
configure via sysfs node its operating modes: power-down, one-shot,
and continuous modes.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index d61688f04594..5218fd85506d 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -77,6 +77,28 @@ enum ina3221_channels {
 	INA3221_NUM_CHANNELS
 };
 
+enum ina3221_modes {
+	INA3221_MODE_POWERDOWN,
+	INA3221_MODE_ONESHOT,
+	INA3221_MODE_CONTINUOUS,
+	INA3221_NUM_MODES,
+};
+
+static const char *ina3221_mode_names[INA3221_NUM_MODES] = {
+	[INA3221_MODE_POWERDOWN] = "power-down",
+	[INA3221_MODE_ONESHOT] = "one-shot",
+	[INA3221_MODE_CONTINUOUS] = "continuous",
+};
+
+static const u16 ina3221_mode_val[] = {
+	[INA3221_MODE_POWERDOWN] = INA3221_CONFIG_MODE_POWERDOWN,
+	[INA3221_MODE_ONESHOT] = INA3221_CONFIG_MODE_SHUNT |
+				     INA3221_CONFIG_MODE_BUS,
+	[INA3221_MODE_CONTINUOUS] = INA3221_CONFIG_MODE_CONTINUOUS |
+				    INA3221_CONFIG_MODE_SHUNT |
+				    INA3221_CONFIG_MODE_BUS,
+};
+
 /**
  * struct ina3221_input - channel input source specific information
  * @label: label of channel input source
@@ -386,9 +408,51 @@ static const struct hwmon_ops ina3221_hwmon_ops = {
 	.write = ina3221_write,
 };
 
+static int ina3221_mode_get_index(struct device *dev, unsigned int *index)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	u16 mode = ina->reg_config & INA3221_CONFIG_MODE_MASK;
+
+	if (mode == INA3221_CONFIG_MODE_POWERDOWN)
+		*index = INA3221_MODE_POWERDOWN;
+	if (mode & INA3221_CONFIG_MODE_CONTINUOUS)
+		*index = INA3221_MODE_CONTINUOUS;
+	else
+		*index = INA3221_MODE_ONESHOT;
+
+	return 0;
+}
+
+static int ina3221_mode_set_index(struct device *dev, unsigned int index)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
+				 INA3221_CONFIG_MODE_MASK,
+				 ina3221_mode_val[index]);
+	if (ret)
+		return ret;
+
+	/* Cache the latest config register value */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct hwmon_mode ina3221_hwmon_mode = {
+	.names = ina3221_mode_names,
+	.list_size = INA3221_NUM_MODES,
+	.get_index = ina3221_mode_get_index,
+	.set_index = ina3221_mode_set_index,
+};
+
 static const struct hwmon_chip_info ina3221_chip_info = {
 	.ops = &ina3221_hwmon_ops,
 	.info = ina3221_info,
+	.mode = &ina3221_hwmon_mode,
 };
 
 /* Extra attribute groups */
-- 
2.17.1

