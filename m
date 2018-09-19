Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFB7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29219214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="EsOfSMZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29219214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbeISHAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:00:07 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47124 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeISHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:00:07 -0400
Received: from localhost.localdomain (unknown [209.82.80.116])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 89B435C232A;
        Wed, 19 Sep 2018 03:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537320285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Oa3bJs3ohET2avD6aGxAJQ/3eCQJ8nvq4iaP3qwN8s=;
        b=EsOfSMZVRYoFHJbFG6JtARWsz64VfGIJS2wWMN+4AfA15NYZ+yc4gDySpmt+6dPZLYjvSW
        36fkrVQY6uNyDtqgeOkvIqpYBZ1GJLUXt6n0XfJW3aWZZMiZjRe9dReajneSF66NjrF/21
        NuP8DBJOvgr/cOuqlFzHEpAU3q0zeq8=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] pinctrl: tegra: move probe to __init section
Date:   Tue, 18 Sep 2018 18:24:27 -0700
Message-Id: <20180919012427.12439-2-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919012427.12439-1-stefan@agner.ch>
References: <20180919012427.12439-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra pinctrl drivers are always built-in. This allows to use
platform_driver_probe() and mark several functions as __init.
This allows the kernel to free about 1KiB of memory if Tegra
pinctrl drivers are not used.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c    | 6 +++---
 drivers/pinctrl/tegra/pinctrl-tegra114.c | 6 +++---
 drivers/pinctrl/tegra/pinctrl-tegra124.c | 6 +++---
 drivers/pinctrl/tegra/pinctrl-tegra20.c  | 6 +++---
 drivers/pinctrl/tegra/pinctrl-tegra30.c  | 6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index a5008c066bac2..c263cb66a0287 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -613,7 +613,7 @@ static struct pinctrl_desc tegra_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
-static void tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
+static void __init tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
 {
 	int i = 0;
 	const struct tegra_pingroup *g;
@@ -629,7 +629,7 @@ static void tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
 	}
 }
 
-static bool gpio_node_has_range(const char *compatible)
+static bool __init gpio_node_has_range(const char *compatible)
 {
 	struct device_node *np;
 	bool has_prop = false;
@@ -645,7 +645,7 @@ static bool gpio_node_has_range(const char *compatible)
 	return has_prop;
 }
 
-int tegra_pinctrl_probe(struct platform_device *pdev,
+int __init tegra_pinctrl_probe(struct platform_device *pdev,
 			const struct tegra_pinctrl_soc_data *soc_data)
 {
 	struct tegra_pmx *pmx;
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c b/drivers/pinctrl/tegra/pinctrl-tegra114.c
index d43c209e9c30b..db1b970478146 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
@@ -1851,7 +1851,7 @@ static const struct tegra_pinctrl_soc_data tegra114_pinctrl = {
 	.drvtype_in_mux = false,
 };
 
-static int tegra114_pinctrl_probe(struct platform_device *pdev)
+static int __init tegra114_pinctrl_probe(struct platform_device *pdev)
 {
 	return tegra_pinctrl_probe(pdev, &tegra114_pinctrl);
 }
@@ -1866,11 +1866,11 @@ static struct platform_driver tegra114_pinctrl_driver = {
 		.name = "tegra114-pinctrl",
 		.of_match_table = tegra114_pinctrl_of_match,
 	},
-	.probe = tegra114_pinctrl_probe,
 };
 
 static int __init tegra114_pinctrl_init(void)
 {
-	return platform_driver_register(&tegra114_pinctrl_driver);
+	return platform_driver_probe(&tegra114_pinctrl_driver,
+				     tegra114_pinctrl_probe);
 }
 arch_initcall(tegra114_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c b/drivers/pinctrl/tegra/pinctrl-tegra124.c
index 5b07a5834d155..38c08cbbd90aa 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
@@ -2063,7 +2063,7 @@ static const struct tegra_pinctrl_soc_data tegra124_pinctrl = {
 	.drvtype_in_mux = false,
 };
 
-static int tegra124_pinctrl_probe(struct platform_device *pdev)
+static int __init tegra124_pinctrl_probe(struct platform_device *pdev)
 {
 	return tegra_pinctrl_probe(pdev, &tegra124_pinctrl);
 }
@@ -2078,11 +2078,11 @@ static struct platform_driver tegra124_pinctrl_driver = {
 		.name = "tegra124-pinctrl",
 		.of_match_table = tegra124_pinctrl_of_match,
 	},
-	.probe = tegra124_pinctrl_probe,
 };
 
 static int __init tegra124_pinctrl_init(void)
 {
-	return platform_driver_register(&tegra124_pinctrl_driver);
+	return platform_driver_probe(&tegra124_pinctrl_driver,
+				     tegra124_pinctrl_probe);
 }
 arch_initcall(tegra124_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index 1fc82a9576e06..205857b6ba256 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -2252,7 +2252,7 @@ static void tegra20_pinctrl_register_clock_muxes(struct platform_device *pdev)
 			 pmx->regs[1] + 0x8, 4, 2, CLK_MUX_READ_ONLY, NULL);
 }
 
-static int tegra20_pinctrl_probe(struct platform_device *pdev)
+static int __init tegra20_pinctrl_probe(struct platform_device *pdev)
 {
 	int err;
 
@@ -2275,11 +2275,11 @@ static struct platform_driver tegra20_pinctrl_driver = {
 		.name = "tegra20-pinctrl",
 		.of_match_table = tegra20_pinctrl_of_match,
 	},
-	.probe = tegra20_pinctrl_probe,
 };
 
 static int __init tegra20_pinctrl_init(void)
 {
-	return platform_driver_register(&tegra20_pinctrl_driver);
+	return platform_driver_probe(&tegra20_pinctrl_driver,
+				     tegra20_pinctrl_probe);
 }
 arch_initcall(tegra20_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c b/drivers/pinctrl/tegra/pinctrl-tegra30.c
index 10e617003e9ce..5996cb7241134 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
@@ -2486,7 +2486,7 @@ static const struct tegra_pinctrl_soc_data tegra30_pinctrl = {
 	.drvtype_in_mux = false,
 };
 
-static int tegra30_pinctrl_probe(struct platform_device *pdev)
+static int __init tegra30_pinctrl_probe(struct platform_device *pdev)
 {
 	return tegra_pinctrl_probe(pdev, &tegra30_pinctrl);
 }
@@ -2501,11 +2501,11 @@ static struct platform_driver tegra30_pinctrl_driver = {
 		.name = "tegra30-pinctrl",
 		.of_match_table = tegra30_pinctrl_of_match,
 	},
-	.probe = tegra30_pinctrl_probe,
 };
 
 static int __init tegra30_pinctrl_init(void)
 {
-	return platform_driver_register(&tegra30_pinctrl_driver);
+	return platform_driver_probe(&tegra30_pinctrl_driver,
+				     tegra30_pinctrl_probe);
 }
 arch_initcall(tegra30_pinctrl_init);
-- 
2.19.0

