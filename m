Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E47DC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A722086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="HlvjzTVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfASUn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:43:57 -0500
Received: from onstation.org ([52.200.56.107]:35178 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbfASUnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 15:43:40 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 22C7B35F;
        Sat, 19 Jan 2019 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547930619;
        bh=gmbhuXFpMLE2hjInrT/aPjWKUTsmtRZ1zUneD892RnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlvjzTVNDhQR1jM0cxHYTA4DewWZC8X7KXdO5Lj3lGvHFahmcQtx45b71NWgjegvM
         EWZrXrKz4n5MZGyCg1Y0Gp8OJht/GwW1pBDY348F4YHRd24kf5luYUWYEB5ljMT2eV
         Ci9L6rrmD1oj885cczvsxLPGk/+uv85kEhqZGfEY=
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
Subject: [PATCH v6 15/15] spmi: pmic-arb: revert "disassociate old virq if hwirq mapping already exists"
Date:   Sat, 19 Jan 2019 15:42:52 -0500
Message-Id: <20190119204252.18370-16-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190119204252.18370-1-masneyb@onstation.org>
References: <20190119204252.18370-1-masneyb@onstation.org>
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
Changes since v5:
- None

Changes since v4:
- None

Patch introduced in v4.

 drivers/spmi/spmi-pmic-arb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 5666b99c9a92..316e2708f3ba 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -745,15 +745,10 @@ static int qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
 				  irq_hw_number_t hwirq, unsigned int type)
 {
 	irq_flow_handler_t handler;
-	unsigned int old_virq;
 
 	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu, type = %u\n",
 		virq, hwirq, type);
 
-	old_virq = irq_find_mapping(domain, hwirq);
-	if (old_virq)
-		irq_domain_disassociate(domain, old_virq);
-
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		handler = handle_edge_irq;
 	else if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
-- 
2.17.2

