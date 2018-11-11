Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7357C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C93520866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVwi7PFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C93520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbeKLJ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:26:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388234AbeKLIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:00 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C55F216FD;
        Sun, 11 Nov 2018 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975404;
        bh=yAxeAxW90gmxGSG+qFxYF7/ud5lVerPVLCJIFyxJWak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVwi7PFcUBKhCc7T31zqNkMQKoyz7FQ/C61hMFPIBsNVjIc0QugL4hnioWc5c5ElN
         EsdGm1FGjrTcfo5yJD2jS2t+b3fdTIv2E48dkdWc5qdxGC8CGFbY1sgL7zcOABoy82
         40v0WvAjMEUkuVP8yi3JJZhqhP4+JCjbc9TMtOC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 105/350] pinctrl: sunxi: fix pctrl->functions allocation in sunxi_pinctrl_build_state
Date:   Sun, 11 Nov 2018 14:19:29 -0800
Message-Id: <20181111221711.482417104@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

[ Upstream commit a4925311a5443126ecc90671a1604ea7b0f5b32e ]

fixes following Smatch static check warning:

 ./drivers/pinctrl/sunxi/pinctrl-sunxi.c:1112 sunxi_pinctrl_build_state()
 warn: passing devm_ allocated variable to kfree. 'pctrl->functions'

As we will be calling krealloc() on pointer 'pctrl->functions', which means
kfree() will be called in there, devm_kzalloc() shouldn't be used with
the allocation in the first place.  Fix the warning by calling kcalloc()
and managing the free procedure in error path on our own.

Fixes: 0e37f88d9ad8 ("ARM: sunxi: Add pinctrl driver for Allwinner SoCs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1079,10 +1079,9 @@ static int sunxi_pinctrl_build_state(str
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
 
@@ -1133,8 +1132,10 @@ static int sunxi_pinctrl_build_state(str
 
 			func_item = sunxi_pinctrl_find_function_by_name(pctl,
 									func->name);
-			if (!func_item)
+			if (!func_item) {
+				kfree(pctl->functions);
 				return -EINVAL;
+			}
 
 			if (!func_item->groups) {
 				func_item->groups =
@@ -1142,8 +1143,10 @@ static int sunxi_pinctrl_build_state(str
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


