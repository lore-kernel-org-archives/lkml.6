Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568DEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2627020851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2627020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeKTCmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:42:47 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:36798 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729825AbeKTCmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:42:47 -0500
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2018 01:18:42 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 4A815403CE;
        Tue, 20 Nov 2018 01:18:42 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.56,253,1539615600"; 
   d="scan'208";a="297864257"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 20 Nov 2018 01:18:40 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Date:   Mon, 19 Nov 2018 16:18:38 +0000
Message-Id: <20181119161838.10610-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the check for unused mdio bus setting and the following static
checker warning:
 drivers/pinctrl/pinctrl-rzn1.c:198 rzn1_pinctrl_mdio_select()
 warn: always true condition '(ipctl->mdio_func[mdio] >= 0) => (0-u32max >= 0)'

It also fixes the return var when calling of_get_child_count()

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
 - Don't rely on rely on the implicit typecast from -1 to uint
---
 drivers/pinctrl/pinctrl-rzn1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rzn1.c b/drivers/pinctrl/pinctrl-rzn1.c
index 57886dcff53d..cc0e5aa9128a 100644
--- a/drivers/pinctrl/pinctrl-rzn1.c
+++ b/drivers/pinctrl/pinctrl-rzn1.c
@@ -112,7 +112,7 @@ struct rzn1_pinctrl {
 	struct rzn1_pinctrl_regs __iomem *lev2;
 	u32 lev1_protect_phys;
 	u32 lev2_protect_phys;
-	u32 mdio_func[2];
+	int mdio_func[2];
 
 	struct rzn1_pin_group *groups;
 	unsigned int ngroups;
@@ -810,8 +810,8 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
 	unsigned int maxgroups = 0;
-	unsigned int nfuncs = 0;
 	unsigned int i = 0;
+	int nfuncs = 0;
 	int ret;
 
 	nfuncs = of_get_child_count(np);
-- 
2.17.1

