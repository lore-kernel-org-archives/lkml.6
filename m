Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7291FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F8020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F8020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeLIWZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:25:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34926 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbeLIVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:16 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002iq-JJ; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003LI-Uo; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Jisheng Zhang" <Jisheng.Zhang@synaptics.com>,
        "YueHaibing" <yuehaibing@huawei.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.904390123@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 101/328] pinctrl: berlin: fix 'pctrl->functions'
 allocation in berlin_pinctrl_build_state
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

commit b5031b7db77dc47f474f0efc2b2552c32b7bb59d upstream.

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
[bwh: Backported to 3.16: berlin_pinctrl_state() was not yet converted
 to devm_kcalloc()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pinctrl/berlin/berlin.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -237,9 +237,8 @@ static int berlin_pinctrl_build_state(st
 	}
 
 	/* we will reallocate later */
-	pctrl->functions = devm_kzalloc(&pdev->dev,
-					max_functions * sizeof(*pctrl->functions),
-					GFP_KERNEL);
+	pctrl->functions = kcalloc(max_functions,
+				   sizeof(*pctrl->functions), GFP_KERNEL);
 	if (!pctrl->functions)
 		return -ENOMEM;
 
@@ -277,8 +276,10 @@ static int berlin_pinctrl_build_state(st
 				function++;
 			}
 
-			if (!found)
+			if (!found) {
+				kfree(pctrl->functions);
 				return -EINVAL;
+			}
 
 			if (!function->groups) {
 				function->groups =
@@ -286,8 +287,10 @@ static int berlin_pinctrl_build_state(st
 						     function->ngroups * sizeof(char *),
 						     GFP_KERNEL);
 
-				if (!function->groups)
+				if (!function->groups) {
+					kfree(pctrl->functions);
 					return -ENOMEM;
+				}
 			}
 
 			groups = function->groups;

