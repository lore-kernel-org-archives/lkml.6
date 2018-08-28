Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD38C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB3220658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB3220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeH1Fo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37807 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeH1Fo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:26 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so28116oic.4;
        Mon, 27 Aug 2018 18:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DmIttiORlUh/qJx9dz1cqkSPSCkCQukBxH4dsDJyEp4=;
        b=WXWwmlHr54QGDkJY5GggIpH5mauuPWjXd5oFagt59C6dkVYsqNSunuIba5R30XX1Ko
         6YwQHt01I/AAMxr/617DGc0Q7LgMGcpSoUJCXR3sn0I7cJRvcz1bcDrYInlrim2CKlR+
         D9HXIF03A38TANCo4y61jLAU8yDWtmop4RDPgg/mEJnAYyBnSg5byiVBUqHZSPNVqAsc
         CAJwqe4bz3GaxFhpKtBun2PE6tELG0d9kowt+4gQ7wlF3CI/4lrwLsLQ2BxkBd2cIy6Z
         +6VDWo711HBvdaQh8vWdi9pIjRgZjan7OvKiG0bfm4CbFzstegh8FJ33O1Fsvxr2li53
         6IJg==
X-Gm-Message-State: APzg51D0/u3P/wJO8j6IcUxzpf3GidlcSpH55yfWq0GMoVVrvVhuy6GX
        +AXl8fSIwz5vx5ScQZMPLijA6s0=
X-Google-Smtp-Source: ANB0VdbXPL0PWmho3nGFbv/jhLE8m0NGEef7+vaj9x7OP5frtDZWUXxTNsI9PU7gIhJR4JSFo56OHA==
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr1137329oih.161.1535421309739;
        Mon, 27 Aug 2018 18:55:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] regulator: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:42 -0500
Message-Id: <20180828015252.28511-41-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/max8997-regulator.c      |  4 +-
 drivers/regulator/mc13xxx-regulator-core.c |  2 +-
 drivers/regulator/of_regulator.c           | 44 +++++++++++-----------
 drivers/regulator/qcom-rpmh-regulator.c    | 14 +++----
 drivers/regulator/s5m8767.c                | 12 +++---
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index ad0c806b0737..3bf5ddfaaea8 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -929,8 +929,8 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 				break;
 
 		if (i == ARRAY_SIZE(regulators)) {
-			dev_warn(&pdev->dev, "don't know how to configure regulator %s\n",
-				 reg_np->name);
+			dev_warn(&pdev->dev, "don't know how to configure regulator %pOFn\n",
+				 reg_np);
 			continue;
 		}
 
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index da4fb9824757..65eb1e0350cf 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -203,7 +203,7 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 
 		if (!found)
 			dev_warn(&pdev->dev,
-				 "Unknown regulator: %s\n", child->name);
+				 "Unknown regulator: %pOFn\n", child);
 	}
 	of_node_put(parent);
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 638f17d4c848..92a516b959a7 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -95,8 +95,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!ret)
 		constraints->settling_time_up = pval;
 	if (constraints->settling_time_up && constraints->settling_time) {
-		pr_warn("%s: ambiguous configuration for settling time, ignoring 'regulator-settling-time-up-us'\n",
-			np->name);
+		pr_warn("%pOFn: ambiguous configuration for settling time, ignoring 'regulator-settling-time-up-us'\n",
+			np);
 		constraints->settling_time_up = 0;
 	}
 
@@ -105,8 +105,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!ret)
 		constraints->settling_time_down = pval;
 	if (constraints->settling_time_down && constraints->settling_time) {
-		pr_warn("%s: ambiguous configuration for settling time, ignoring 'regulator-settling-time-down-us'\n",
-			np->name);
+		pr_warn("%pOFn: ambiguous configuration for settling time, ignoring 'regulator-settling-time-down-us'\n",
+			np);
 		constraints->settling_time_down = 0;
 	}
 
@@ -127,12 +127,12 @@ static void of_get_regulation_constraints(struct device_node *np,
 		if (desc && desc->of_map_mode) {
 			mode = desc->of_map_mode(pval);
 			if (mode == REGULATOR_MODE_INVALID)
-				pr_err("%s: invalid mode %u\n", np->name, pval);
+				pr_err("%pOFn: invalid mode %u\n", np, pval);
 			else
 				constraints->initial_mode = mode;
 		} else {
-			pr_warn("%s: mapping for mode %d not defined\n",
-				np->name, pval);
+			pr_warn("%pOFn: mapping for mode %d not defined\n",
+				np, pval);
 		}
 	}
 
@@ -144,14 +144,14 @@ static void of_get_regulation_constraints(struct device_node *np,
 				ret = of_property_read_u32_index(np,
 					"regulator-allowed-modes", i, &pval);
 				if (ret) {
-					pr_err("%s: couldn't read allowed modes index %d, ret=%d\n",
-						np->name, i, ret);
+					pr_err("%pOFn: couldn't read allowed modes index %d, ret=%d\n",
+						np, i, ret);
 					break;
 				}
 				mode = desc->of_map_mode(pval);
 				if (mode == REGULATOR_MODE_INVALID)
-					pr_err("%s: invalid regulator-allowed-modes element %u\n",
-						np->name, pval);
+					pr_err("%pOFn: invalid regulator-allowed-modes element %u\n",
+						np, pval);
 				else
 					constraints->valid_modes_mask |= mode;
 			}
@@ -159,7 +159,7 @@ static void of_get_regulation_constraints(struct device_node *np,
 				constraints->valid_ops_mask
 					|= REGULATOR_CHANGE_MODE;
 		} else {
-			pr_warn("%s: mode mapping not defined\n", np->name);
+			pr_warn("%pOFn: mode mapping not defined\n", np);
 		}
 	}
 
@@ -197,13 +197,13 @@ static void of_get_regulation_constraints(struct device_node *np,
 			if (desc && desc->of_map_mode) {
 				mode = desc->of_map_mode(pval);
 				if (mode == REGULATOR_MODE_INVALID)
-					pr_err("%s: invalid mode %u\n",
-					       np->name, pval);
+					pr_err("%pOFn: invalid mode %u\n",
+					       np, pval);
 				else
 					suspend_state->mode = mode;
 			} else {
-				pr_warn("%s: mapping for mode %d not defined\n",
-					np->name, pval);
+				pr_warn("%pOFn: mapping for mode %d not defined\n",
+					np, pval);
 			}
 		}
 
@@ -351,8 +351,8 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 							   match->desc);
 			if (!match->init_data) {
 				dev_err(dev,
-					"failed to parse DT for regulator %s\n",
-					child->name);
+					"failed to parse DT for regulator %pOFn\n",
+					child);
 				of_node_put(child);
 				return -EINVAL;
 			}
@@ -401,16 +401,16 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		init_data = of_get_regulator_init_data(dev, child, desc);
 		if (!init_data) {
 			dev_err(dev,
-				"failed to parse DT for regulator %s\n",
-				child->name);
+				"failed to parse DT for regulator %pOFn\n",
+				child);
 			break;
 		}
 
 		if (desc->of_parse_cb) {
 			if (desc->of_parse_cb(child, desc, config)) {
 				dev_err(dev,
-					"driver callback failed to parse DT for regulator %s\n",
-					child->name);
+					"driver callback failed to parse DT for regulator %pOFn\n",
+					child);
 				init_data = NULL;
 				break;
 			}
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 9f27daebd8c8..301e7f695374 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -414,7 +414,7 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 			break;
 
 	if (!rpmh_data->name) {
-		dev_err(dev, "Unknown regulator %s\n", node->name);
+		dev_err(dev, "Unknown regulator %pOFn\n", node);
 		return -EINVAL;
 	}
 
@@ -423,8 +423,8 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 
 	vreg->addr = cmd_db_read_addr(rpmh_resource_name);
 	if (!vreg->addr) {
-		dev_err(dev, "%s: could not find RPMh address for resource %s\n",
-			node->name, rpmh_resource_name);
+		dev_err(dev, "%pOFn: could not find RPMh address for resource %s\n",
+			node, rpmh_resource_name);
 		return -ENODEV;
 	}
 
@@ -469,13 +469,13 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 	rdev = devm_regulator_register(dev, &vreg->rdesc, &reg_config);
 	if (IS_ERR(rdev)) {
 		ret = PTR_ERR(rdev);
-		dev_err(dev, "%s: devm_regulator_register() failed, ret=%d\n",
-			node->name, ret);
+		dev_err(dev, "%pOFn: devm_regulator_register() failed, ret=%d\n",
+			node, ret);
 		return ret;
 	}
 
-	dev_dbg(dev, "%s regulator registered for RPMh resource %s @ 0x%05X\n",
-		node->name, rpmh_resource_name, vreg->addr);
+	dev_dbg(dev, "%pOFn regulator registered for RPMh resource %s @ 0x%05X\n",
+		node, rpmh_resource_name, vreg->addr);
 
 	return 0;
 }
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 667d16dc83ce..09a97a7093e8 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -447,15 +447,15 @@ static void s5m8767_regulator_config_ext_control(struct s5m8767_info *s5m8767,
 	}
 	if (mode != S5M8767_ENCTRL_USE_GPIO) {
 		dev_warn(s5m8767->dev,
-				"ext-control for %s: mismatched op_mode (%x), ignoring\n",
-				rdata->reg_node->name, mode);
+				"ext-control for %pOFn: mismatched op_mode (%x), ignoring\n",
+				rdata->reg_node, mode);
 		return;
 	}
 
 	if (!rdata->ext_control_gpiod) {
 		dev_warn(s5m8767->dev,
-				"ext-control for %s: GPIO not valid, ignoring\n",
-			 rdata->reg_node->name);
+				"ext-control for %pOFn: GPIO not valid, ignoring\n",
+			 rdata->reg_node);
 		return;
 	}
 
@@ -566,8 +566,8 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 
 		if (i == ARRAY_SIZE(regulators)) {
 			dev_warn(iodev->dev,
-			"don't know how to configure regulator %s\n",
-			reg_np->name);
+			"don't know how to configure regulator %pOFn\n",
+			reg_np);
 			continue;
 		}
 
-- 
2.17.1

