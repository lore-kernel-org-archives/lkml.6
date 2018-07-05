Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D46AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C681824101
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C681824101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeGEJKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:10:34 -0400
Received: from muru.com ([72.249.23.125]:50334 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbeGEJKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:10:31 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id AAE58816D;
        Thu,  5 Jul 2018 09:13:28 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/5] pinctrl: pinmux: Return selector to the pinctrl driver
Date:   Thu,  5 Jul 2018 02:10:15 -0700
Message-Id: <20180705091018.60524-3-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705091018.60524-1-tony@atomide.com>
References: <20180705091018.60524-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must return the selector from pinmux_generic_add_function() so
pin controller device drivers can remove the right group if needed
for deferred probe for example. And we now must make sure that a
proper name is passed so we can use it to check if the entry already
exists.

Note that fixes are also needed for the pin controller drivers to
use the selector value.

Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions for
managing groups")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Christ van Willegen <cvwillegen@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinmux.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -307,7 +307,6 @@ static int pinmux_func_name_to_selector(struct pinctrl_dev *pctldev,
 		selector++;
 	}
 
-	dev_err(pctldev->dev, "function '%s' not supported\n", function);
 	return -EINVAL;
 }
 
@@ -774,6 +773,16 @@ int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 				void *data)
 {
 	struct function_desc *function;
+	int selector;
+
+	if (!name)
+		return -EINVAL;
+
+	selector = pinmux_func_name_to_selector(pctldev, name);
+	if (selector >= 0)
+		return selector;
+
+	selector = pctldev->num_functions;
 
 	function = devm_kzalloc(pctldev->dev, sizeof(*function), GFP_KERNEL);
 	if (!function)
@@ -784,12 +793,11 @@ int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 	function->num_group_names = num_groups;
 	function->data = data;
 
-	radix_tree_insert(&pctldev->pin_function_tree, pctldev->num_functions,
-			  function);
+	radix_tree_insert(&pctldev->pin_function_tree, selector, function);
 
 	pctldev->num_functions++;
 
-	return 0;
+	return selector;
 }
 EXPORT_SYMBOL_GPL(pinmux_generic_add_function);
 
-- 
2.17.1
