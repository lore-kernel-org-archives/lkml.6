Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A71ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BAA2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BAA2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeIREip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:38:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIREio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:38:44 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C2FA707;
        Mon, 17 Sep 2018 23:09:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 050/158] pinctrl: berlin: fix pctrl->functions allocation in berlin_pinctrl_build_state
Date:   Tue, 18 Sep 2018 00:41:20 +0200
Message-Id: <20180917211713.540846104@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit b5031b7db77dc47f474f0efc2b2552c32b7bb59d ]

fixes following Smatch static check warning:

 drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
 warn: passing devm_ allocated variable to kfree. 'pctrl->functions'

As we will be calling krealloc() on pointer 'pctrl->functions', which means
kfree() will be called in there, devm_kzalloc() shouldn't be used with
the allocation in the first place.  Fix the warning by calling kcalloc()
and managing the free procedure in error path on our own.

Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marvell Berlin SoCs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/berlin/berlin.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -216,10 +216,8 @@ static int berlin_pinctrl_build_state(st
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
 
@@ -257,8 +255,10 @@ static int berlin_pinctrl_build_state(st
 				function++;
 			}
 
-			if (!found)
+			if (!found) {
+				kfree(pctrl->functions);
 				return -EINVAL;
+			}
 
 			if (!function->groups) {
 				function->groups =
@@ -267,8 +267,10 @@ static int berlin_pinctrl_build_state(st
 						     sizeof(char *),
 						     GFP_KERNEL);
 
-				if (!function->groups)
+				if (!function->groups) {
+					kfree(pctrl->functions);
 					return -ENOMEM;
+				}
 			}
 
 			groups = function->groups;


