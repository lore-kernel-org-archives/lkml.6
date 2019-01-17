Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24875C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA83E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="YJBlp04B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfAQAdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:33:38 -0500
Received: from onstation.org ([52.200.56.107]:54530 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbfAQAdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:33:36 -0500
Received: from localhost.localdomain (mobile-166-171-186-103.mycingular.net [166.171.186.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id C0F0432F;
        Thu, 17 Jan 2019 00:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547685215;
        bh=0RifQ7h7FBX98vkO3CYV71hNlgC4sjROBdcVPNUB0nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJBlp04B4MzkgRuP3H7h8X57UVoam++R2SEpTjb3d9BA0hDr17tCl3FmRuoGi3TIV
         y2fHJN4PxljSuZeX4MQUT/bOELv9+Sfj/xSSPOx47oXU++dLheXB+GkD3F34foXDBA
         VZv8dale56xLkVHRtTuM9w/fv/mEbxlKD01GHnSg=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 14/14] spmi: pmic-arb: revert "disassociate old virq if hwirq mapping already exists"
Date:   Wed, 16 Jan 2019 19:32:34 -0500
Message-Id: <20190117003234.22127-15-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117003234.22127-1-masneyb@onstation.org>
References: <20190117003234.22127-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that spmi-gpio is a proper hierarchical IRQ chip, and all in-tree
users of device tree have been updated, we can now drop the hack that
was introduced to disassociate the old Linux virq if a hwirq mapping
already exists. That patch was introduced to not break git bisect for
any existing boards.

Driver was tested using gpio-keys and iadc/vadc on the LG Nexus 5
(hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v4:
- None

Patch introduced in v4.

 drivers/spmi/spmi-pmic-arb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index b7cfee831417..356bc3f66e22 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -744,14 +744,8 @@ static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
 				   struct irq_domain *domain, unsigned int virq,
 				   irq_hw_number_t hwirq)
 {
-	unsigned int old_virq;
-
 	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu\n", virq, hwirq);
 
-	old_virq = irq_find_mapping(domain, hwirq);
-	if (old_virq)
-		irq_domain_disassociate(domain, old_virq);
-
 	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
 			    handle_level_irq, NULL, NULL);
 }
-- 
2.17.2

