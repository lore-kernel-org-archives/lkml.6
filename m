Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74667ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCC820BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajnR8T6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCC820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeGPOAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:00:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43777 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeGPOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:00:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so29946484ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yShMAaA+3wrToiOuYhqJLwnCV7tYvrx9fUOx2YE4kSU=;
        b=ajnR8T6rt5JMTJPD3F3S501SEo5tVzodar6zcmqv9k1r3DXXlaUiqTKBJ8NRULC24S
         IV/gI8DdqKRkjQjKPANw5wbfQ/RaeePFjlgznhMQLzhti7m0hIcjuNUTukhkWOtWpNGu
         ezROY3o5iQM8tN0GltTKH/40Klq2qrJNY4auc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yShMAaA+3wrToiOuYhqJLwnCV7tYvrx9fUOx2YE4kSU=;
        b=gTDAV1slE7Dk9Y+SyfThLeO1vfd0bqldv24yUO67sFBT2rLHZ3IAJtj7lW2Jl31RsV
         9eROYY6Fn9ntikUtBh6UzWskKy9FveByirxbBiai8B0KfRK0AlueZSom2yCGVPsJfCHr
         LscnltDD5FIkIiOKq0ZK4ASXJQG1xl5bX0X14jJ+y8n0iXitmNUXxlgbvC7Q0evJSFF5
         DUubkXIysYDbNR8/qLHiwlI1ZtXMdQ6+3Xyk4e+fykU2Rj40L7nPuWGseTj+aCj41ElQ
         H7liQPjtmmKJINAR6flzrmFYo8IYmxo+OFRuP/FHMF3ML3xKDs3TonliWZKqlcWD8HQr
         ep0g==
X-Gm-Message-State: AOUpUlGORCXpY/dbIh/tFPWA07VitpFBvzFEQxHP9ZObVMpOd3k/zkT4
        wEhZmlkO9a0vPSBqo4ohi6szWw==
X-Google-Smtp-Source: AAOMgpeE+QRsEWexCOFR09NCLZc2Qj5UXl4Vhq70qfsxdcqkaaWaS6S+Gb1XY9Z5Jklcq/pVogUGzQ==
X-Received: by 2002:a2e:1b83:: with SMTP id c3-v6mr4016734ljf.0.1531747989459;
        Mon, 16 Jul 2018 06:33:09 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id a14-v6sm3820390ljb.49.2018.07.16.06.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:33:08 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, johan@kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] regulator: qcom_spmi: Fix warning Bad of_node_put()
Date:   Mon, 16 Jul 2018 15:32:51 +0200
Message-Id: <20180716133255.1506-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716133255.1506-1-niklas.cassel@linaro.org>
References: <20180716133255.1506-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For of_find_node_by_name(), you typically pass what the previous call
returned. Therefore, of_find_node_by_name() increases the refcount of
the returned node, and decreases the refcount of the node passed as the
first argument.

of_find_node_by_name() is incorrectly used, and produces a warning.
Fix the warning by using the more suitable function
of_get_child_by_name().

Also add a missing of_node_put() for the returned value, since this was
previously being leaked.

OF: ERROR: Bad of_node_put() on /soc/qcom,spmi@400f000/pmic@3/regulators
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         4.18.0-rc4-00223-gefd7b360b70e #12
Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
Call trace:
 dump_backtrace+0x0/0x1a8
 show_stack+0x14/0x20
 dump_stack+0x90/0xb4
 of_node_release+0x74/0x78
 kobject_put+0x90/0x1f0
 of_node_put+0x14/0x20
 of_find_node_by_name+0x80/0xd8
 qcom_spmi_regulator_probe+0x30c/0x508

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since v1:
-Use of_get_child_by_name() instead of of_find_node_by_name().

 drivers/regulator/qcom_spmi-regulator.c | 32 +++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 9817f1a75342..4cc14c65d86b 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1752,7 +1752,8 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	const char *name;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *syscon;
+	struct device_node *syscon, *reg_node;
+	struct property *reg_prop;
 	int ret, lenp;
 	struct list_head *vreg_list;
 
@@ -1780,10 +1781,13 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 
 	for (reg = match->data; reg->name; reg++) {
 
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-slave", &lenp)) {
-			continue;
+		if (saw_regmap) {
+			reg_node = of_get_child_by_name(node, reg->name);
+			reg_prop = of_find_property(reg_node, "qcom,saw-slave",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop)
+				continue;
 		}
 
 		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
@@ -1816,13 +1820,17 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		if (ret)
 			continue;
 
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-leader", &lenp)) {
-			spmi_saw_ops = *(vreg->desc.ops);
-			spmi_saw_ops.set_voltage_sel = \
-				spmi_regulator_saw_set_voltage;
-			vreg->desc.ops = &spmi_saw_ops;
+		if (saw_regmap) {
+			reg_node = of_get_child_by_name(node, reg->name);
+			reg_prop = of_find_property(reg_node, "qcom,saw-leader",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop) {
+				spmi_saw_ops = *(vreg->desc.ops);
+				spmi_saw_ops.set_voltage_sel =
+					spmi_regulator_saw_set_voltage;
+				vreg->desc.ops = &spmi_saw_ops;
+			}
 		}
 
 		config.dev = dev;
-- 
2.17.1

