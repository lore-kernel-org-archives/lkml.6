Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0320ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B463D214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B463D214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbeIUHqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:46:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36027 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbeIUHqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:46:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E9F6A710D5C5;
        Fri, 21 Sep 2018 10:00:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 10:00:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <maxime.ripard@bootlin.com>, <wens@csie.org>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pinctrl: sunxi: fix 'pctrl->functions' allocation in sunxi_pinctrl_build_state
Date:   Fri, 21 Sep 2018 09:59:41 +0800
Message-ID: <20180921015941.28468-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes following Smatch static check warning:

 ./drivers/pinctrl/sunxi/pinctrl-sunxi.c:1112 sunxi_pinctrl_build_state()
 warn: passing devm_ allocated variable to kfree. 'pctrl->functions'

As we will be calling krealloc() on pointer 'pctrl->functions', which means
kfree() will be called in there, devm_kzalloc() shouldn't be used with
the allocation in the first place.  Fix the warning by calling kcalloc()
and managing the free procedure in error path on our own.

Fixes: 0e37f88d9ad8 ("ARM: sunxi: Add pinctrl driver for Allwinner SoCs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 3ccbe22..213a5d5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1079,10 +1079,9 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 	 * We suppose that we won't have any more functions than pins,
 	 * we'll reallocate that later anyway
 	 */
-	pctl->functions = devm_kcalloc(&pdev->dev,
-				       pctl->ngroups,
-				       sizeof(*pctl->functions),
-				       GFP_KERNEL);
+	pctl->functions = kcalloc(pctl->ngroups,
+				  sizeof(*pctl->functions),
+				  GFP_KERNEL);
 	if (!pctl->functions)
 		return -ENOMEM;
 
@@ -1133,8 +1132,10 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 
 			func_item = sunxi_pinctrl_find_function_by_name(pctl,
 									func->name);
-			if (!func_item)
+			if (!func_item) {
+				kfree(pctl->functions);
 				return -EINVAL;
+			}
 
 			if (!func_item->groups) {
 				func_item->groups =
@@ -1142,8 +1143,10 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 						     func_item->ngroups,
 						     sizeof(*func_item->groups),
 						     GFP_KERNEL);
-				if (!func_item->groups)
+				if (!func_item->groups) {
+					kfree(pctl->functions);
 					return -ENOMEM;
+				}
 			}
 
 			func_grp = func_item->groups;
-- 
2.7.0


