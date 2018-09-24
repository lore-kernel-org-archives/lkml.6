Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C3ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5103920C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5103920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeIXSXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:23:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732318AbeIXSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:23:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97D62108A;
        Mon, 24 Sep 2018 12:21:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 120/173] pinctrl: pinmux: Return selector to the pinctrl driver
Date:   Mon, 24 Sep 2018 13:52:34 +0200
Message-Id: <20180924113124.799928646@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit f913cfce4ee49a3382a9ff95696f49a46e56e974 ]

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
Cc: Christ van Willegen <cvwillegen@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinmux.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -308,7 +308,6 @@ static int pinmux_func_name_to_selector(
 		selector++;
 	}
 
-	dev_err(pctldev->dev, "function '%s' not supported\n", function);
 	return -EINVAL;
 }
 
@@ -777,6 +776,16 @@ int pinmux_generic_add_function(struct p
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
@@ -787,12 +796,11 @@ int pinmux_generic_add_function(struct p
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
 


