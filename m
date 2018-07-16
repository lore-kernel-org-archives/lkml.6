Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57F0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0121473
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jF6fPI2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF0121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeGPMDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:03:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46010 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:03:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so29625452ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/tofPDhJxcM4c3JuRbs84i7HqZwJjey0utmlS/P9Ns=;
        b=jF6fPI2mWfgewcHPl3qO64dpAdR4BGrDCKdWxzJuU1uNbSWG4KmLZBdoaCsxth6dDl
         6kK43QgwQfTViLl7ExZZfLWaH5G0xwKCuXm1+deVDsAcxgW2ARDB5/tm4tla7k2PVdWJ
         L6YYgtOH5YES03v+RVsiAKxKHzFJwjJyzXtxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/tofPDhJxcM4c3JuRbs84i7HqZwJjey0utmlS/P9Ns=;
        b=DtQZA1kFNwrYYyrUndtzLAuqzKEdsid5CgZFDhXCDk2lrNgh2it2qLdJB1swPh7kdl
         NbxS7gCPEbfwOWkOiOIntrLVHs0Q0b0hds7YRMpGQ9IkvsK4usHwHpNSApFtV1lk/KGx
         34XFLRZObt/1SIBd8kQJVXkbMLBOP2gTPA0FX7GsytYIXMmWLAMVFDIeAXvw2jOwTu8E
         wvNbLNQ/XaA/kKAJmk3icHzMxVGTSXykU6Uz9qlW86vvR3sbxKQx64d3eVFE6AjfrvkU
         +ahnzcBlxFqHEEyC8wR0T04MZuAdc4GI8ayuADuWxOi1mdP6Ia4i7a1ydu/n+tF3Zuoa
         I7Kw==
X-Gm-Message-State: AOUpUlEx79nSm3xDe+BnFw+aWLpYED1koI70yefqhitkn/rh9Jl7aNUG
        Z9e4B8yy612Hi/phit2td3l7Vw==
X-Google-Smtp-Source: AAOMgpfitu31qSnhexO6rkYqa8qYSwn+xqBd4riJG0lnpdj8eeiWnDHNqlbHspCPLZqNOaE+VRX3+w==
X-Received: by 2002:a2e:557:: with SMTP id 84-v6mr10583839ljf.152.1531741003010;
        Mon, 16 Jul 2018 04:36:43 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id v136-v6sm8104913lfa.10.2018.07.16.04.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:36:42 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] regulator: qcom_spmi: Fix warning Bad of_node_put()
Date:   Mon, 16 Jul 2018 13:35:22 +0200
Message-Id: <20180716113525.9335-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716113525.9335-1-niklas.cassel@linaro.org>
References: <20180716113525.9335-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For of_find_node_by_name(), you typically pass what the previous call
returned. Therefore, of_find_node_by_name() increases the refcount of
the returned node, and decreases the refcount of the node passed as the
first argument.

However, in this case we don't pass what the previous call returned,
so we have to increase the refcount of the first argument to compensate.

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
 drivers/regulator/qcom_spmi-regulator.c | 42 ++++++++++++++++++-------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 9817f1a75342..8b921b1b1df5 100644
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
 
@@ -1780,10 +1781,18 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 
 	for (reg = match->data; reg->name; reg++) {
 
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-slave", &lenp)) {
-			continue;
+		if (saw_regmap) {
+			/*
+			 * Compensate for of_node_put() in
+			 * of_find_node_by_name()
+			 */
+			of_node_get(node);
+			reg_node = of_find_node_by_name(node, reg->name);
+			reg_prop = of_find_property(reg_node, "qcom,saw-slave",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop)
+				continue;
 		}
 
 		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
@@ -1816,13 +1825,22 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
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
+			/*
+			 * Compensate for of_node_put() in
+			 * of_find_node_by_name()
+			 */
+			of_node_get(node);
+			reg_node = of_find_node_by_name(node, reg->name);
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

