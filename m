Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6F4A7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6FB20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6FB20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965817AbeFOLM0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:12:26 -0400
Received: from muru.com ([72.249.23.125]:47356 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965757AbeFOLLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:11:55 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BE189813D;
        Fri, 15 Jun 2018 11:14:32 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4/5] pinctrl: rza1: Fix selector use for groups and functions
Date:   Fri, 15 Jun 2018 04:11:40 -0700
Message-Id: <20180615111141.37184-5-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615111141.37184-1-tony@atomide.com>
References: <20180615111141.37184-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must use a mutex around the generic_add functions and save the
function and group selector in case we need to remove them. Otherwise
the selector use will be racy for deferred probe at least.

Fixes: 5a49b644b307 ("pinctrl: Renesas RZ/A1 pin and gpio controller")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-rza1.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rza1.c b/drivers/pinctrl/pinctrl-rza1.c
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -1005,7 +1005,7 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	struct device_node *child;
 	const char *grpname;
 	const char **fngrps;
-	int ret, npins;
+	int ret, npins, gsel, fsel;
 
 	npins = rza1_dt_node_pin_count(np);
 	if (npins < 0) {
@@ -1055,18 +1055,19 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	fngrps[0] = grpname;
 
 	mutex_lock(&rza1_pctl->mutex);
-	ret = pinctrl_generic_add_group(pctldev, grpname, grpins, npins,
-					NULL);
-	if (ret) {
+	gsel = pinctrl_generic_add_group(pctldev, grpname, grpins, npins,
+					 NULL);
+	if (gsel < 0) {
 		mutex_unlock(&rza1_pctl->mutex);
-		return ret;
+		return gsel;
 	}
 
-	ret = pinmux_generic_add_function(pctldev, grpname, fngrps, 1,
-					  mux_confs);
-	if (ret)
+	fsel = pinmux_generic_add_function(pctldev, grpname, fngrps, 1,
+					   mux_confs);
+	if (fsel < 0) {
+		ret = fsel;
 		goto remove_group;
-	mutex_unlock(&rza1_pctl->mutex);
+	}
 
 	dev_info(rza1_pctl->dev, "Parsed function and group %s with %d pins\n",
 				 grpname, npins);
@@ -1083,15 +1084,15 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	(*map)->data.mux.group = np->name;
 	(*map)->data.mux.function = np->name;
 	*num_maps = 1;
+	mutex_unlock(&rza1_pctl->mutex);
 
 	return 0;
 
 remove_function:
-	mutex_lock(&rza1_pctl->mutex);
-	pinmux_generic_remove_last_function(pctldev);
+	pinmux_generic_remove_function(pctldev, fsel);
 
 remove_group:
-	pinctrl_generic_remove_last_group(pctldev);
+	pinctrl_generic_remove_group(pctldev, gsel);
 	mutex_unlock(&rza1_pctl->mutex);
 
 	dev_info(rza1_pctl->dev, "Unable to parse function and group %s\n",
-- 
2.17.1
