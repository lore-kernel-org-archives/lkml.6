Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D34C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033AB206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033AB206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503571AbeKWViW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:38:22 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:9158 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503150AbeKWViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:38:22 -0500
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Nov 2018 19:54:32 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 21E184146021;
        Fri, 23 Nov 2018 19:54:30 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Date:   Fri, 23 Nov 2018 10:54:27 +0000
Message-Id: <20181123105428.13457-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the check for unused mdio bus setting and the following static
checker warning:
 drivers/pinctrl/pinctrl-rzn1.c:198 rzn1_pinctrl_mdio_select()
 warn: always true condition '(ipctl->mdio_func[mdio] >= 0) => (0-u32max >= 0)'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v3:
 - Split fixing the return var when calling of_get_child_count() into
   a separate patch.
v2:
 - Don't rely on rely on the implicit typecast from -1 to uint
---
 drivers/pinctrl/pinctrl-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rzn1.c b/drivers/pinctrl/pinctrl-rzn1.c
index 57886dcff53d..a04235e3bec4 100644
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
-- 
2.17.1

