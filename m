Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7306C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809D3222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfBMAdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:33:32 -0500
Received: from anholt.net ([50.246.234.109]:60732 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730482AbfBMAd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:33:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id BAEE610A2C5C;
        Tue, 12 Feb 2019 16:33:27 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id X_64UFM1AQ9E; Tue, 12 Feb 2019 16:33:25 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9223A10A02F6;
        Tue, 12 Feb 2019 16:33:25 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DEF2E2FE1FE6; Tue, 12 Feb 2019 16:33:24 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/2] soc: bcm: bcm2835-pm: Fix error paths of initialization.
Date:   Tue, 12 Feb 2019 16:33:24 -0800
Message-Id: <20190213003324.15224-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213003324.15224-1-eric@anholt.net>
References: <20190213003324.15224-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock driver may probe after ours and so we need to pass the
-EPROBE_DEFER out.  Fix the other error path while we're here.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
---
 drivers/soc/bcm/bcm2835-power.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 4a1b99b773c0..11f9469423f7 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -485,7 +485,7 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
 	}
 }
 
-static void
+static int
 bcm2835_init_power_domain(struct bcm2835_power *power,
 			  int pd_xlate_index, const char *name)
 {
@@ -493,6 +493,12 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
 	struct bcm2835_power_domain *dom = &power->domains[pd_xlate_index];
 
 	dom->clk = devm_clk_get(dev->parent, name);
+	if (IS_ERR(dom->clk)) {
+		int ret = PTR_ERR(dom->clk);
+
+		if (ret == -EPROBE_DEFER)
+			return ret;
+	}
 
 	dom->base.name = name;
 	dom->base.power_on = bcm2835_power_pd_power_on;
@@ -505,6 +511,8 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
 	pm_genpd_init(&dom->base, NULL, true);
 
 	power->pd_xlate.domains[pd_xlate_index] = &dom->base;
+
+	return 0;
 }
 
 /** bcm2835_reset_reset - Resets a block that has a reset line in the
@@ -602,7 +610,7 @@ static int bcm2835_power_probe(struct platform_device *pdev)
 		{ BCM2835_POWER_DOMAIN_IMAGE_PERI, BCM2835_POWER_DOMAIN_CAM0 },
 		{ BCM2835_POWER_DOMAIN_IMAGE_PERI, BCM2835_POWER_DOMAIN_CAM1 },
 	};
-	int ret, i;
+	int ret = 0, i;
 	u32 id;
 
 	power = devm_kzalloc(dev, sizeof(*power), GFP_KERNEL);
@@ -629,8 +637,11 @@ static int bcm2835_power_probe(struct platform_device *pdev)
 
 	power->pd_xlate.num_domains = ARRAY_SIZE(power_domain_names);
 
-	for (i = 0; i < ARRAY_SIZE(power_domain_names); i++)
-		bcm2835_init_power_domain(power, i, power_domain_names[i]);
+	for (i = 0; i < ARRAY_SIZE(power_domain_names); i++) {
+		ret = bcm2835_init_power_domain(power, i, power_domain_names[i]);
+		if (ret)
+			goto fail;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(domain_deps); i++) {
 		pm_genpd_add_subdomain(&power->domains[domain_deps[i].parent].base,
@@ -644,12 +655,21 @@ static int bcm2835_power_probe(struct platform_device *pdev)
 
 	ret = devm_reset_controller_register(dev, &power->reset);
 	if (ret)
-		return ret;
+		goto fail;
 
 	of_genpd_add_provider_onecell(dev->parent->of_node, &power->pd_xlate);
 
 	dev_info(dev, "Broadcom BCM2835 power domains driver");
 	return 0;
+
+fail:
+	for (i = 0; i < ARRAY_SIZE(power_domain_names); i++) {
+		struct generic_pm_domain *dom = &power->domains[i].base;
+
+		if (dom->gov)
+			pm_genpd_remove(dom);
+	}
+	return ret;
 }
 
 static int bcm2835_power_remove(struct platform_device *pdev)
-- 
2.20.1

