Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932090AbeAaCgo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:36:44 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44583 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753451AbeAaCgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:36:35 -0500
X-Google-Smtp-Source: AH8x2244b9bBt4BF/WfErbm7j7SvSmySw8gH6Ix+DlpOdsW4xgzSyJuIvYvLzVBRHJkh38KljVHY5w==
From: Stephen Boyd <stephen.boyd@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        devicetree-spec@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 4/4] gpio: Support gpio nexus dt bindings
Date: Tue, 30 Jan 2018 18:36:18 -0800
Message-Id: <20180131023618.14292-5-stephen.boyd@linaro.org>
X-Mailer: git-send-email 2.14.GIT
In-Reply-To: <20180131023618.14292-1-stephen.boyd@linaro.org>
References: <20180131023618.14292-1-stephen.boyd@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms like 96boards have a standardized connector/expansion
slot that exposes signals like GPIOs to expansion boards in an
SoC agnostic way. We'd like the DT overlays for the expansion
boards to be written once without knowledge of the SoC on the
other side of the connector. This avoids the unscalable
combinatorial explosion of a different DT overlay for each
expansion board and SoC pair.

Now that we have nexus support in the OF core let's change the
function call here that parses the phandle lists of gpios to use
the nexus variant. This allows us to remap phandles and their
arguments through any number of nexus nodes and end up with the
actual gpio provider being used.

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 72a0695d2ac3..09217a87e7ff 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -75,8 +75,8 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 	struct gpio_desc *desc;
 	int ret;
 
-	ret = of_parse_phandle_with_args(np, propname, "#gpio-cells", index,
-					 &gpiospec);
+	ret = of_parse_phandle_with_args_map(np, propname, "gpio", index,
+					     &gpiospec);
 	if (ret) {
 		pr_debug("%s: can't parse '%s' property of node '%pOF[%d]'\n",
 			__func__, propname, np, index);
-- 
2.14.GIT
