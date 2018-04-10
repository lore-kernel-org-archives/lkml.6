Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeDJSew (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:34:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36636 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeDJSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:34:49 -0400
X-Google-Smtp-Source: AIpwx489lbNxzRLKUQqYqVQ4L2205lXAB6ghB9yWXwYmLeondq/i9oFlpKWdEVvMEnMjuTM6FPz6Mw==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] soc: imx: gpcv2: Do not pass static memory as platform data
Date: Tue, 10 Apr 2018 11:32:09 -0700
Message-Id: <20180410183210.28052-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform device core assumes the ownership of dev.platform_data as
well as that it is dynamically allocated and it will try to kfree it
as a part of platform_device_release(). Change the code to use
platform_device_add_data() n instead of a pointer to a static memory
to avoid causing a BUG() when calling platform_device_put().

The problem can be reproduced by artificially enabling the error path
of platform_device_add() call (around line 357).

Note that this change also allows us to constify imx7_pgc_domains,
since we no longer need to be able to modify it.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v2]:

    - Patch reworked to use platform_device_add_data() as per request from Shawn

Changes since [v1]:

    - Replaced devm_kzalloc() with devm_kmalloc() as per suggestion from Stefan

[v1] lkml.kernel.org/r/20180110161608.13015-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20180122150748.1742-1-andrew.smirnov@gmail.com

 drivers/soc/imx/gpcv2.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index afc7ecc3c187..f4e3bd40c72e 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -155,7 +155,7 @@ static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
 }
 
-static struct imx7_pgc_domain imx7_pgc_domains[] = {
+static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
 		.genpd = {
 			.name      = "mipi-phy",
@@ -321,11 +321,6 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		domain = &imx7_pgc_domains[domain_index];
-		domain->regmap = regmap;
-		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
-		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
-
 		pd_pdev = platform_device_alloc("imx7-pgc-domain",
 						domain_index);
 		if (!pd_pdev) {
@@ -334,7 +329,20 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
-		pd_pdev->dev.platform_data = domain;
+		ret = platform_device_add_data(pd_pdev,
+					       &imx7_pgc_domains[domain_index],
+					       sizeof(imx7_pgc_domains[domain_index]));
+		if (ret) {
+			platform_device_put(pd_pdev);
+			of_node_put(np);
+			return ret;
+		}
+
+		domain = pd_pdev->dev.platform_data;
+		domain->regmap = regmap;
+		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
+		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
+
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
 
-- 
2.14.3
