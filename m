Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6108C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830592086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="HrkWhBYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfASUoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:44:04 -0500
Received: from onstation.org ([52.200.56.107]:35202 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbfASUnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 15:43:39 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 83021503;
        Sat, 19 Jan 2019 20:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547930619;
        bh=9/ZgB2rAElIHFwQnk7Noa7Re6R+SEpAAMBAzdo67szY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrkWhBYRQIyglQe2Y+oPD5eG2B+sAt9epJw+8S+zZFzAkyP2iUSRWYKCmNqbDqTCf
         XMyf1Aap5Jpo+LgHQ83JRhzmY1TymJQwNCU1kFMSEuO4XJF2Ja48qI+hy5NqzahEse
         Vs9sNHoev04eGt4BXirNfoA6SNc+qf1sU3W8zdsM=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com
Cc:     shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 14/15] spmi: pmic-arb: validate type when mapping IRQ
Date:   Sat, 19 Jan 2019 15:42:51 -0500
Message-Id: <20190119204252.18370-15-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190119204252.18370-1-masneyb@onstation.org>
References: <20190119204252.18370-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qpnpint_irq_domain_map did not validate the IRQ type and this can cause
IRQs to not work as expected if an unsupported type (such as
IRQ_TYPE_NONE) is passed in. Now that spmi-gpio is a hierarchical IRQ
controller, and all device tree bindings have been updated, add
additional validation to the type field.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Patch introduced in v6

 drivers/spmi/spmi-pmic-arb.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index bc7dc1d6e4b2..5666b99c9a92 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -740,9 +740,9 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 }
 
 
-static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
-				   struct irq_domain *domain, unsigned int virq,
-				   irq_hw_number_t hwirq, unsigned int type)
+static int qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
+				  struct irq_domain *domain, unsigned int virq,
+				  irq_hw_number_t hwirq, unsigned int type)
 {
 	irq_flow_handler_t handler;
 	unsigned int old_virq;
@@ -756,11 +756,15 @@ static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		handler = handle_edge_irq;
-	else
+	else if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		handler = handle_level_irq;
+	else
+		return -EINVAL;
 
 	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
 			    handler, NULL, NULL);
+
+	return 0;
 }
 
 static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
@@ -777,9 +781,12 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nr_irqs; i++)
-		qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq + i,
-				       type);
+	for (i = 0; i < nr_irqs; i++) {
+		ret = qpnpint_irq_domain_map(pmic_arb, domain, virq + i,
+					     hwirq + i, type);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.17.2

