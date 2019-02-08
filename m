Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5920C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702872177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="lfXbiGgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBHMgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:36:50 -0500
Received: from onstation.org ([52.200.56.107]:36118 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfBHMgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:36:47 -0500
Received: from xilitla.corp.homestore.net (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 5B8CF167;
        Fri,  8 Feb 2019 12:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549629406;
        bh=NQAgLIkej0qo4K7KZhSM4e805UeNbxIJ95v1NUnfvg0=;
        h=From:To:Cc:Subject:Date:From;
        b=lfXbiGgz9wfP+1clODanCTXXv0Ur5UM7vRXN9oj8fQkrGPq/mkbkdWWRJrnWsQXm6
         vWALCX8gQlMfNxmMNEN//+2V4E1zOGAMAYsMjL3SBxLDLh5gRHayqRoB4kd8pkbI56
         NMv/yOt9/qi30f+rBbeN/jfWQGprC6xg84Jzjg7s=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org
Cc:     sboyd@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH -next] spmi: pmic-arb: revert "validate type when mapping IRQ"
Date:   Fri,  8 Feb 2019 07:36:35 -0500
Message-Id: <20190208123635.26755-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validation of the IRQ type was added to spmi pmic-arb, however spmi-mpp
in device tree still uses IRQ_TYPE_NONE. This commit caused the
spmi-mpp probe to fail since platform_irq_count() would return 0.
Correct this by backing out the previous patch.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Fixes: 135ef21ab064 ("spmi: pmic-arb: validate type when mapping IRQ")
---
Linus: I think that the better longer-term approach is to just embed the
IRQ counts similar to what is now in spmi-gpio. Since we are getting
close to the end of the dev cycle, I think it is safer to just drop
the old patch for the time being. I'll commit to doing that work for the
next dev cycle, although I can send you that change this weekend if you
prefer that we go that route instead.

My ssbi-gpio series does not have this issue.

 drivers/spmi/spmi-pmic-arb.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 316e2708f3ba..928759242e42 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -740,9 +740,9 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 }
 
 
-static int qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
-				  struct irq_domain *domain, unsigned int virq,
-				  irq_hw_number_t hwirq, unsigned int type)
+static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
+				   struct irq_domain *domain, unsigned int virq,
+				   irq_hw_number_t hwirq, unsigned int type)
 {
 	irq_flow_handler_t handler;
 
@@ -751,15 +751,11 @@ static int qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		handler = handle_edge_irq;
-	else if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
-		handler = handle_level_irq;
 	else
-		return -EINVAL;
+		handler = handle_level_irq;
 
 	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
 			    handler, NULL, NULL);
-
-	return 0;
 }
 
 static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
@@ -776,12 +772,9 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nr_irqs; i++) {
-		ret = qpnpint_irq_domain_map(pmic_arb, domain, virq + i,
-					     hwirq + i, type);
-		if (ret)
-			return ret;
-	}
+	for (i = 0; i < nr_irqs; i++)
+		qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq + i,
+				       type);
 
 	return 0;
 }
-- 
2.17.2

