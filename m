Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB72C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FF3208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FF3208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeH1FoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:14 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42884 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeH1FoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:12 -0400
Received: by mail-oi0-f67.google.com with SMTP id q204-v6so1730890oig.9;
        Mon, 27 Aug 2018 18:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9YcZbeg+WYUk986xRWCNCrhYteFstLsyRmzNlykhF40=;
        b=qbBzy/AArGwseWRnPKq5z5C6gNSke+8ge73tb9DnMzDQ5ZXl6fCVx3xjJFLdEgH82f
         o7em417q4zj9rW9sUPKcA1TRvflxMkGvO55JJKabpLl297RQ5DjfOp/t9FO6oxe+crUZ
         jrY4XJuaI64wgNu9UVIVxWsP898/F3cno7J8/+kzaMStIisq6quvND18VQCExLOuCm5R
         zRS6BczbiGFME2JGVZVRuj+k5HZKB9oeZGsnhF1DxhM5qSfBnF1NzWcNgoImPY4JakNH
         3mZrRBi5lCAi31M8fapzbZmQ4RIEwe9Ghm6Y+HwtlOb7/R19RxfPgi6iGvVkpUZ0u1f8
         u/Dw==
X-Gm-Message-State: APzg51AKfbMlK1hHO5nXhBCx//QGzZQDonI86uaQCR1GHNhpH25T40tV
        BFvkGhPCE/Tb1eMQvqb+DLcZxT4=
X-Google-Smtp-Source: ANB0VdbZ0AWmeAGlAwHusarTqJvGNoJtFvgYdxW0DdaYeuhMWbCQS06dGW+myMsl11VwskmGdzPEgw==
X-Received: by 2002:aca:2c02:: with SMTP id s2-v6mr1025066ois.305.1535421295988;
        Mon, 27 Aug 2018 18:54:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] memory: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:30 -0500
Message-Id: <20180828015252.28511-29-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/memory/omap-gpmc.c           | 18 +++++++-----------
 drivers/memory/samsung/exynos-srom.c |  4 ++--
 drivers/memory/tegra/mc.c            |  6 +++---
 drivers/memory/tegra/tegra124-emc.c  | 12 ++++++------
 4 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c215287e80cf..8abb9e94916a 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2145,8 +2145,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 			gpmc_s.device_width = GPMC_DEVWIDTH_16BIT;
 			break;
 		default:
-			dev_err(&pdev->dev, "%s: invalid 'nand-bus-width'\n",
-				child->name);
+			dev_err(&pdev->dev, "%pOFn: invalid 'nand-bus-width'\n",
+				child);
 			ret = -EINVAL;
 			goto err;
 		}
@@ -2186,8 +2186,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 
 	ret = gpmc_cs_set_timings(cs, &gpmc_t, &gpmc_s);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to set gpmc timings for: %s\n",
-			child->name);
+		dev_err(&pdev->dev, "failed to set gpmc timings for: %pOFn\n",
+			child);
 		goto err_cs;
 	}
 
@@ -2215,7 +2215,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 
 err_child_fail:
 
-	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
+	dev_err(&pdev->dev, "failed to create gpmc child %pOFn\n", child);
 	ret = -ENODEV;
 
 err_cs:
@@ -2265,14 +2265,10 @@ static void gpmc_probe_dt_children(struct platform_device *pdev)
 	struct device_node *child;
 
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
-
-		if (!child->name)
-			continue;
-
 		ret = gpmc_probe_generic_child(pdev, child);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to probe DT child '%s': %d\n",
-				child->name, ret);
+			dev_err(&pdev->dev, "failed to probe DT child '%pOFn': %d\n",
+				child, ret);
 		}
 	}
 }
diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 7edd7fb540f2..c27c6105c66d 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -139,8 +139,8 @@ static int exynos_srom_probe(struct platform_device *pdev)
 	for_each_child_of_node(np, child) {
 		if (exynos_srom_configure_bank(srom, child)) {
 			dev_err(dev,
-				"Could not decode bank configuration for %s\n",
-				child->name);
+				"Could not decode bank configuration for %pOFn\n",
+				child);
 			bad_bank_config = true;
 		}
 	}
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bd25faf6d13d..24afc36833bf 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -345,7 +345,7 @@ static int load_one_timing(struct tegra_mc *mc,
 	err = of_property_read_u32(node, "clock-frequency", &tmp);
 	if (err) {
 		dev_err(mc->dev,
-			"timing %s: failed to read rate\n", node->name);
+			"timing %pOFn: failed to read rate\n", node);
 		return err;
 	}
 
@@ -360,8 +360,8 @@ static int load_one_timing(struct tegra_mc *mc,
 					 mc->soc->num_emem_regs);
 	if (err) {
 		dev_err(mc->dev,
-			"timing %s: failed to read EMEM configuration\n",
-			node->name);
+			"timing %pOFn: failed to read EMEM configuration\n",
+			node);
 		return err;
 	}
 
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 392dc8dd481f..eedb7d48e2ea 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -888,8 +888,8 @@ static int load_one_timing_from_dt(struct tegra_emc *emc,
 
 	err = of_property_read_u32(node, "clock-frequency", &value);
 	if (err) {
-		dev_err(emc->dev, "timing %s: failed to read rate: %d\n",
-			node->name, err);
+		dev_err(emc->dev, "timing %pOFn: failed to read rate: %d\n",
+			node, err);
 		return err;
 	}
 
@@ -900,16 +900,16 @@ static int load_one_timing_from_dt(struct tegra_emc *emc,
 					 ARRAY_SIZE(timing->emc_burst_data));
 	if (err) {
 		dev_err(emc->dev,
-			"timing %s: failed to read emc burst data: %d\n",
-			node->name, err);
+			"timing %pOFn: failed to read emc burst data: %d\n",
+			node, err);
 		return err;
 	}
 
 #define EMC_READ_PROP(prop, dtprop) { \
 	err = of_property_read_u32(node, dtprop, &timing->prop); \
 	if (err) { \
-		dev_err(emc->dev, "timing %s: failed to read " #prop ": %d\n", \
-			node->name, err); \
+		dev_err(emc->dev, "timing %pOFn: failed to read " #prop ": %d\n", \
+			node, err); \
 		return err; \
 	} \
 }
-- 
2.17.1

