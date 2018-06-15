Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1AD14C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEE320896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEE320896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965752AbeFOLLw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:11:52 -0400
Received: from muru.com ([72.249.23.125]:47326 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965689AbeFOLLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:11:50 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D59608109;
        Fri, 15 Jun 2018 11:14:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/5] pinctrl: core: Return selector to the pinctrl driver
Date:   Fri, 15 Jun 2018 04:11:37 -0700
Message-Id: <20180615111141.37184-2-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615111141.37184-1-tony@atomide.com>
References: <20180615111141.37184-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must return the selector from pinctrl_generic_add_group() so
pin controller device drivers can remove the right group if needed
for deferred probe for example.

Note that fixes are also needed for the pin controller drivers to
use the selector value.

Fixes: c7059c5ac70a ("pinctrl: core: Add generic pinctrl functions
for managing groups")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -631,6 +631,7 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
 			      int *pins, int num_pins, void *data)
 {
 	struct group_desc *group;
+	int selector = pctldev->num_groups;
 
 	group = devm_kzalloc(pctldev->dev, sizeof(*group), GFP_KERNEL);
 	if (!group)
@@ -641,12 +642,12 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
 	group->num_pins = num_pins;
 	group->data = data;
 
-	radix_tree_insert(&pctldev->pin_group_tree, pctldev->num_groups,
+	radix_tree_insert(&pctldev->pin_group_tree, selector,
 			  group);
 
 	pctldev->num_groups++;
 
-	return 0;
+	return selector;
 }
 EXPORT_SYMBOL_GPL(pinctrl_generic_add_group);
 
-- 
2.17.1
