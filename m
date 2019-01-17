Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C6CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D42C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtrzdInK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfAQXNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:13:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39722 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfAQXNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:13:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so5113899pgl.6;
        Thu, 17 Jan 2019 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJMnlmYLBuk03P9TWs3W8STiQv0s7iCS3HSfOUGuGh0=;
        b=rtrzdInKfoEHBq0KA4QCrsU4STZsBsFvHnimV38Ul/sWOudJy9IY1KSvi6TmPAXoD9
         YYj1OG7sDaXHLWDdn8wrCCsG4sC3cUYIvNZztTHR5ZLUJ1tK3lvpi4uhZ2k2TpsOaDwT
         ZQajFIQXSEl9aVrdo2KZ+O0rkVTmJZu38BPk5zQVUeOVuyHHbgyQL3jh1IvK6+89ls9d
         ayvLUHxLePXc9Sn+/mBUteuELcG0EXftd4OPsKKziHovejvyWSglVqKI6XBcVBgfQ3Wh
         bZ/vBq2vcWrzrqTthD4CpFJHxmArl7nUMJ7Q3RIT5KXt+S0fINCFi83ulXA4Ij02eEnu
         mg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJMnlmYLBuk03P9TWs3W8STiQv0s7iCS3HSfOUGuGh0=;
        b=n4C/eu1rgAcc/z4XnlE051p1J7LIXx1+9SSMBLAcc0m1THbKoc+hyUWBw7NV2wdUms
         UoQSJQuAGvuhzwah5xXtNxvt/OrnyQQNimwSS7cbPrRQO+xYPOOMbOQ16fZ7dSX80T3O
         BouZAAjzMtLywqbrLJAKPPBbzrkRpITdr12g/0Trck0uLprDscc8fMEu4NCAv6QjobkU
         iJHMCVXIKivFDb7jrCZQrtB2nLX1P/oFp7yi1F18IGC7rBYMxGUXTXVdONUYcXmh0AX5
         UJBSf4LcDoRpbqI8O0dbUp3UZS5Ge7Vdm7WcuAmiFlb3JsRglDpgo9uCK/FrhEiyqgQt
         XIyA==
X-Gm-Message-State: AJcUukdjKJvx7+BBmvcHaNxB6Mxyrpk3uG2r7zdbLdE7DE9o9ScsKv3n
        g95EXCqpwdC80/7KlQitp64=
X-Google-Smtp-Source: ALg8bN4BFQh2FvsAAE5SLYUpKSeZAuOIfgntehUEH15ho3B7M59DbbiqwLflUzFmzRfucf4ppphT1w==
X-Received: by 2002:a63:f717:: with SMTP id x23mr15457539pgh.317.1547766789003;
        Thu, 17 Jan 2019 15:13:09 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b27sm4125145pfh.113.2019.01.17.15.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:13:08 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] hwmon: (ina3221) Implement ti,single-shot DT property
Date:   Thu, 17 Jan 2019 15:12:53 -0800
Message-Id: <20190117231253.8828-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117231253.8828-1-nicoleotsuka@gmail.com>
References: <20190117231253.8828-1-nicoleotsuka@gmail.com>
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
Changelog
v2->v3:
 * Dropped useless if condition by using the return value directly.
v1->v2:
 * Replaced the useless mode defines with a boolean variable.

 drivers/hwmon/ina3221.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e90ccac8bebb..a1e94d5d1e41 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -111,6 +111,7 @@ struct ina3221_input {
  * @inputs: Array of channel input source specific structures
  * @lock: mutex lock to serialize sysfs attribute accesses
  * @reg_config: Register value of INA3221_CONFIG
+ * @single_shot: running in single-shot operating mode
  */
 struct ina3221_data {
 	struct device *pm_dev;
@@ -119,6 +120,8 @@ struct ina3221_data {
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 	struct mutex lock;
 	u32 reg_config;
+
+	bool single_shot;
 };
 
 static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
@@ -188,6 +191,11 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina->single_shot)
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -232,6 +240,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina->single_shot)
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -617,6 +630,8 @@ static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
 	if (!np)
 		return 0;
 
+	ina->single_shot = of_property_read_bool(np, "ti,single-shot");
+
 	for_each_child_of_node(np, child) {
 		ret = ina3221_probe_child_from_dt(dev, child, ina);
 		if (ret)
@@ -666,6 +681,10 @@ static int ina3221_probe(struct i2c_client *client,
 	/* The driver will be reset, so use reset value */
 	ina->reg_config = INA3221_CONFIG_DEFAULT;
 
+	/* Clear continuous bit to use single-shot mode */
+	if (ina->single_shot)
+		ina->reg_config &= ~INA3221_CONFIG_MODE_CONTINUOUS;
+
 	/* Disable channels if their inputs are disconnected */
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
 		if (ina->inputs[i].disconnected)
-- 
2.17.1

