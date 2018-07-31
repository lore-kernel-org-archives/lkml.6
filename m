Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A729DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FC920841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FC920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeGaQGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:06:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732222AbeGaQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:06:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 759B0F78F04A0;
        Tue, 31 Jul 2018 22:25:55 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Tue, 31 Jul 2018
 22:25:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <yamada.masahiro@socionext.com>,
        <keescook@chromium.org>, <Jisheng.Zhang@synaptics.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] pinctrl: berlin: fix 'pctrl->functions' allocation in berlin_pinctrl_build_state
Date:   Tue, 31 Jul 2018 22:25:01 +0800
Message-ID: <20180731142501.21888-1-yuehaibing@huawei.com>
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

 drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
 warn: passing devm_ allocated variable to kfree. 'pctrl->functions'

As we will be calling krealloc() on pointer 'pctrl->functions', which means
kfree() will be called in there, devm_kzalloc() shouldn't be used with
the allocation in the first place.  Fix the warning by calling kcalloc()
and managing the free procedure in error path on our own.

Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marvell Berlin SoCs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/berlin/berlin.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index d6d183e..db2afb2 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -216,10 +216,8 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 	}
 
 	/* we will reallocate later */
-	pctrl->functions = devm_kcalloc(&pdev->dev,
-					max_functions,
-					sizeof(*pctrl->functions),
-					GFP_KERNEL);
+	pctrl->functions = kcalloc(max_functions,
+				   sizeof(*pctrl->functions), GFP_KERNEL);
 	if (!pctrl->functions)
 		return -ENOMEM;
 
@@ -257,8 +255,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 				function++;
 			}
 
-			if (!found)
+			if (!found) {
+				kfree(function);
 				return -EINVAL;
+			}
 
 			if (!function->groups) {
 				function->groups =
@@ -267,8 +267,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 						     sizeof(char *),
 						     GFP_KERNEL);
 
-				if (!function->groups)
+				if (!function->groups) {
+					kfree(function);
 					return -ENOMEM;
+				}
 			}
 
 			groups = function->groups;
-- 
2.7.0


