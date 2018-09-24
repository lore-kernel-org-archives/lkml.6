Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69BB21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69BB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbeIXSmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:42:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbeIXSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:42:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ACA79109E;
        Mon, 24 Sep 2018 12:40:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 163/235] pinctrl: rza1: Fix selector use for groups and functions
Date:   Mon, 24 Sep 2018 13:52:29 +0200
Message-Id: <20180924113121.397382619@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit dc4003d260594aa300028c3c5d040c5719abd19b ]

We must use a mutex around the generic_add functions and save the
function and group selector in case we need to remove them. Otherwise
the selector use will be racy for deferred probe at least.

Fixes: 5a49b644b307 ("pinctrl: Renesas RZ/A1 pin and gpio controller")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Christ van Willegen <cvwillegen@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Acked-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-rza1.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -1006,6 +1006,7 @@ static int rza1_dt_node_to_map(struct pi
 	const char *grpname;
 	const char **fngrps;
 	int ret, npins;
+	int gsel, fsel;
 
 	npins = rza1_dt_node_pin_count(np);
 	if (npins < 0) {
@@ -1055,18 +1056,19 @@ static int rza1_dt_node_to_map(struct pi
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
@@ -1083,15 +1085,15 @@ static int rza1_dt_node_to_map(struct pi
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


