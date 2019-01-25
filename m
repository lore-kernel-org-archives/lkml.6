Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F0DC282C8
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D611218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="PcYXO1vJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfAYQXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:23:30 -0500
Received: from onstation.org ([52.200.56.107]:55010 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbfAYQXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:23:14 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D4AD2194A;
        Fri, 25 Jan 2019 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1548433393;
        bh=t5ZdxbcGrp0a2WscsnqNCmFM2tK4G8DCb3YyumEQjg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcYXO1vJ9U/+Ap34KxvzztZpYsY7mbrzkZ+J/HWwDKgF8C6JL4sjgFrqv6VOPyw9u
         zZUh76932xsXKRfsRx5t3EVPEr0i0DtxTKrL9Nqv/vaZwUJHaAZ3XoGnCbURxNeGWR
         ax8tuZEBZZboG/2v17zSTHotw+YPyMNnZlcpBAko=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 9/9] mfd: pm8xxx: revert "disassociate old virq if hwirq mapping already exists"
Date:   Fri, 25 Jan 2019 11:23:02 -0500
Message-Id: <20190125162302.14036-10-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125162302.14036-1-masneyb@onstation.org>
References: <20190125162302.14036-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ssbi-gpio is a proper hierarchical IRQ chip, and all in-tree
users of device tree have been updated, we can now drop the hack that
was introduced to disassociate the old Linux virq if a hwirq mapping
already exists. That patch was introduced to not break git bisect for
any existing boards.

This change was not tested on any actual hardware, however the same
change was made to spmi-pmic-arb.c and tested on a LG Nexus 5
(hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/mfd/qcom-pm8xxx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 97b931465601..a976890c4019 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -387,11 +387,6 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
 				  irq_hw_number_t hwirq, unsigned int type)
 {
 	irq_flow_handler_t handler;
-	unsigned int old_virq;
-
-	old_virq = irq_find_mapping(domain, hwirq);
-	if (old_virq)
-		irq_domain_disassociate(domain, old_virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		handler = handle_edge_irq;
-- 
2.17.2

