Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeDJSe5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:34:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38823 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeDJSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:34:51 -0400
X-Google-Smtp-Source: AIpwx48RlA73ghD0ytL+uqLq+7pwIB1dU8/l3iYPDBtv1u3fWGuwDly4OFkR9yj9/TEd+oWHjktt3w==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] soc: imx: gpc: Do not pass static memory as platform data
Date: Tue, 10 Apr 2018 11:32:10 -0700
Message-Id: <20180410183210.28052-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180410183210.28052-1-andrew.smirnov@gmail.com>
References: <20180410183210.28052-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform device core assumes the ownership of dev.platform_data as
well as that it is dynamically allocated and it will try to kfree it
as a part of platform_device_release(). Change the code to use
platform_device_add_data() instead of a pointer to a static memory to
avoid causing a BUG() when calling platform_device_put().

The problem can be reproduced by artificially enabling the error path
of platform_device_add() call (around line 452).

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

[v1] lkml.kernel.org/r/20180110161608.13015-2-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20180122150748.1742-2-andrew.smirnov@gmail.com

 drivers/soc/imx/gpc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index c4d35f32af8d..32f0748fd067 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -443,17 +443,25 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			if (domain_index >= of_id_data->num_domains)
 				continue;
 
-			domain = &imx_gpc_domains[domain_index];
-			domain->regmap = regmap;
-			domain->ipg_rate_mhz = ipg_rate_mhz;
-
 			pd_pdev = platform_device_alloc("imx-pgc-power-domain",
 							domain_index);
 			if (!pd_pdev) {
 				of_node_put(np);
 				return -ENOMEM;
 			}
-			pd_pdev->dev.platform_data = domain;
+
+			ret = platform_device_add_data(pd_pdev,
+						       &imx_gpc_domains[domain_index],
+						       sizeof(imx_gpc_domains[domain_index]));
+			if (ret) {
+				platform_device_put(pd_pdev);
+				of_node_put(np);
+				return ret;
+			}
+			domain = pd_pdev->dev.platform_data;
+			domain->regmap = regmap;
+			domain->ipg_rate_mhz = ipg_rate_mhz;
+
 			pd_pdev->dev.parent = &pdev->dev;
 			pd_pdev->dev.of_node = np;
 
-- 
2.14.3
