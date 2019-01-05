Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E834CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55ED21872
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4MrvZ3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAEAtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:49:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAEAth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:49:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so18134520pgc.12;
        Fri, 04 Jan 2019 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRyz/HR84h+9xFMDIsLC9tkNv9M+Rza3hD69+HSr11M=;
        b=M4MrvZ3sCvhCpDgU9LtuXO0lvgdBdZgQDj8fQ9WVWDAEdZbyQLORJ+ABC94FlpH2zZ
         w7fhoJvy/nICBfDRqX6/l+/3v+vMA2Q50+jrYf/xHpUH68LTB3pqOmiHAFB7coApD57e
         OGe5wYCtcmK0YmIEdsL9xxNQcBcdCOHk7hiFr93N3jST+VY9+zZfc6ysUqv+3qFxZV8p
         4h1bvjzGHjrJkO36DbVg+Qq3dlha1J7+3Xy5er/rXu6ZQBikXw2vHy1M6RWAF7pnqL3J
         wGSF3OezQGcoloCpcb03qw6l87zUW2/Ec4NNK/BO9vB1XM4NWPAqkXXpJCk/23MOkn7J
         RXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRyz/HR84h+9xFMDIsLC9tkNv9M+Rza3hD69+HSr11M=;
        b=iNT5ZO2tTKNzZA0452Wm7GyWANyOBkSIKpfQMkofuHSDc6TwnnnSPgGB2tXkkWWgok
         kZ2iHXXfqKuC8ZvdbUTVoF+ASAeDF1bGISsURlbjEzrM+S160Rjkc8WfKySuWF/Bl5qp
         6ZX5srlJRbTi9R2DvDOSCgfZjt55ZGtDFyHZBGfbz843h+EsaszBoBDO/9/V1YS9u9ub
         k2/K/YxWep7To2y4Ja2AZffDtTgWrEfKrq/baUzh6jM4BDNucoF5N+Vo7A7Lv+14Ix2b
         XghNVvw9NIFyOnmUlyovQKRa8Op1VZRNEfogmW5+esHQYx2BzV30RybBNXwUxnpGGLg7
         KYUw==
X-Gm-Message-State: AJcUukdudpjhY58qeAd459l+24MQmznK56KTtVPmmN4pS4AXNXDBWFAj
        m7pthqrr91R/Nuscts3M9Ev1Rgh6
X-Google-Smtp-Source: ALg8bN6NN4iqCTw5ka542Jfntd7uFuIoLJkFFCd7AUS4JsQYZg3XEUCxzeiILRikZLGqR/Rfouwk8Q==
X-Received: by 2002:a63:d157:: with SMTP id c23mr22262583pgj.170.1546649376728;
        Fri, 04 Jan 2019 16:49:36 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n68sm101525495pfb.62.2019.01.04.16.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 16:49:36 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (ina3221) Implement ti,single-shot DT property
Date:   Fri,  4 Jan 2019 16:49:04 -0800
Message-Id: <20190105004904.17947-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105004904.17947-1-nicoleotsuka@gmail.com>
References: <20190105004904.17947-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, ina3221, as a hardware monitor, continuously measures
the inputs and generates corresponding data. However, for battery
powered devices, this mode might be power consuming.

The DT binding doc is updated with a new boolean type property to
allow changing the default operating mode from consuming mode to
single-shot mode, which will measure input on demand and then shut
down to save power.

So this patch implements the DT property accordingly.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e90ccac8bebb..152735659e19 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -91,6 +91,12 @@ enum ina3221_channels {
 	INA3221_NUM_CHANNELS
 };
 
+enum ina3221_modes {
+	INA3221_MODE_SINGLE_SHOT,
+	INA3221_MODE_CONTINUOUS,
+	INA3221_NUM_MODES,
+};
+
 /**
  * struct ina3221_input - channel input source specific information
  * @label: label of channel input source
@@ -111,6 +117,7 @@ struct ina3221_input {
  * @inputs: Array of channel input source specific structures
  * @lock: mutex lock to serialize sysfs attribute accesses
  * @reg_config: Register value of INA3221_CONFIG
+ * @mode: Operating mode -- continuous or single-shot
  */
 struct ina3221_data {
 	struct device *pm_dev;
@@ -119,6 +126,7 @@ struct ina3221_data {
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 	struct mutex lock;
 	u32 reg_config;
+	enum ina3221_modes mode;
 };
 
 static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
@@ -188,6 +196,11 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina->mode == INA3221_MODE_SINGLE_SHOT)
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -232,6 +245,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina->mode == INA3221_MODE_SINGLE_SHOT)
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -617,6 +635,9 @@ static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
 	if (!np)
 		return 0;
 
+	if (of_property_read_bool(np, "ti,single-shot"))
+		ina->mode = INA3221_MODE_SINGLE_SHOT;
+
 	for_each_child_of_node(np, child) {
 		ret = ina3221_probe_child_from_dt(dev, child, ina);
 		if (ret)
@@ -654,6 +675,9 @@ static int ina3221_probe(struct i2c_client *client,
 		}
 	}
 
+	/* Hardware default uses the continuous mode */
+	ina->mode = INA3221_MODE_CONTINUOUS;
+
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
 		ina->inputs[i].shunt_resistor = INA3221_RSHUNT_DEFAULT;
 
@@ -666,6 +690,10 @@ static int ina3221_probe(struct i2c_client *client,
 	/* The driver will be reset, so use reset value */
 	ina->reg_config = INA3221_CONFIG_DEFAULT;
 
+	/* Clear continuous bit to use single-shot mode */
+	if (ina->mode == INA3221_MODE_SINGLE_SHOT)
+		ina->reg_config &= ~INA3221_CONFIG_MODE_CONTINUOUS;
+
 	/* Disable channels if their inputs are disconnected */
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
 		if (ina->inputs[i].disconnected)
-- 
2.17.1

