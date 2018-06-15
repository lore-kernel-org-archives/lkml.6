Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6E863C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E96220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E96220896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965832AbeFOLMq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:12:46 -0400
Received: from muru.com ([72.249.23.125]:47338 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965626AbeFOLLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:11:51 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2CD4F8076;
        Fri, 15 Jun 2018 11:14:29 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/5] pinctrl: pinmux: Return selector to the pinctrl driver
Date:   Fri, 15 Jun 2018 04:11:38 -0700
Message-Id: <20180615111141.37184-3-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615111141.37184-1-tony@atomide.com>
References: <20180615111141.37184-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must return the selector from pinmux_generic_add_function() so
pin controller device drivers can remove the right group if needed
for deferred probe for example.

Note that fixes are also needed for the pin controller drivers to
use the selector value.

Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions for
managing groups")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinmux.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -775,6 +775,7 @@ int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 				void *data)
 {
 	struct function_desc *function;
+	int selector = pctldev->num_functions;
 
 	function = devm_kzalloc(pctldev->dev, sizeof(*function), GFP_KERNEL);
 	if (!function)
@@ -785,12 +786,12 @@ int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 	function->num_group_names = num_groups;
 	function->data = data;
 
-	radix_tree_insert(&pctldev->pin_function_tree, pctldev->num_functions,
+	radix_tree_insert(&pctldev->pin_function_tree, selector,
 			  function);
 
 	pctldev->num_functions++;
 
-	return 0;
+	return selector;
 }
 EXPORT_SYMBOL_GPL(pinmux_generic_add_function);
 
-- 
2.17.1
