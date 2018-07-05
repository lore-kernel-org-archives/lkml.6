Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45460C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9FA24103
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9FA24103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeGEJL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:11:26 -0400
Received: from muru.com ([72.249.23.125]:50312 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753068AbeGEJK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:10:29 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 1F816813A;
        Thu,  5 Jul 2018 09:13:27 +0000 (UTC)
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
Subject: [PATCH 1/5] pinctrl: core: Return selector to the pinctrl driver
Date:   Thu,  5 Jul 2018 02:10:14 -0700
Message-Id: <20180705091018.60524-2-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705091018.60524-1-tony@atomide.com>
References: <20180705091018.60524-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must return the selector from pinctrl_generic_add_group() so
pin controller device drivers can remove the right group if needed
for deferred probe for example. And we now must make sure that a
proper name is passed so we can use it to check if the entry already
exists.

Note that fixes are also needed for the pin controller drivers to
use the selector value.

Fixes: c7059c5ac70a ("pinctrl: core: Add generic pinctrl functions
for managing groups")
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
 drivers/pinctrl/core.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -616,6 +616,26 @@ struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
 }
 EXPORT_SYMBOL_GPL(pinctrl_generic_get_group);
 
+static int pinctrl_generic_group_name_to_selector(struct pinctrl_dev *pctldev,
+						  const char *function)
+{
+	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
+	int ngroups = ops->get_groups_count(pctldev);
+	int selector = 0;
+
+	/* See if this pctldev has this group */
+	while (selector < ngroups) {
+		const char *gname = ops->get_group_name(pctldev, selector);
+
+		if (!strcmp(function, gname))
+			return selector;
+
+		selector++;
+	}
+
+	return -EINVAL;
+}
+
 /**
  * pinctrl_generic_add_group() - adds a new pin group
  * @pctldev: pin controller device
@@ -630,6 +650,16 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
 			      int *pins, int num_pins, void *data)
 {
 	struct group_desc *group;
+	int selector;
+
+	if (!name)
+		return -EINVAL;
+
+	selector = pinctrl_generic_group_name_to_selector(pctldev, name);
+	if (selector >= 0)
+		return selector;
+
+	selector = pctldev->num_groups;
 
 	group = devm_kzalloc(pctldev->dev, sizeof(*group), GFP_KERNEL);
 	if (!group)
@@ -640,12 +670,11 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
 	group->num_pins = num_pins;
 	group->data = data;
 
-	radix_tree_insert(&pctldev->pin_group_tree, pctldev->num_groups,
-			  group);
+	radix_tree_insert(&pctldev->pin_group_tree, selector, group);
 
 	pctldev->num_groups++;
 
-	return 0;
+	return selector;
 }
 EXPORT_SYMBOL_GPL(pinctrl_generic_add_group);
 
-- 
2.17.1
