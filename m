Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7049BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0350220858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0350220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbeGVTAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:00:15 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:37106 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbeGVTAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:00:15 -0400
Received: from dslb-084-059-250-189.084.059.pools.vodafone-ip.de ([84.59.250.189] helo=martin-debian-1.paytec.ch)
        by botnar.kaiser.cx with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <martin@kaiser.cx>)
        id 1fhIgr-0002Uu-9F; Sun, 22 Jul 2018 20:02:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] irqchip/tango: Set irq handler and data in one go
Date:   Sun, 22 Jul 2018 20:02:13 +0200
Message-Id: <1532282533-26507-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the two separate calls for setting the irq handler and data with
a single irq_set_chained_handler_and_data() call.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/irqchip/irq-tango.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index 0c085303a583..580e2d72b9ba 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -205,8 +205,7 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 
 	tangox_irq_domain_init(dom);
 
-	irq_set_chained_handler(irq, tangox_irq_handler);
-	irq_set_handler_data(irq, dom);
+	irq_set_chained_handler_and_data(irq, tangox_irq_handler, dom);
 
 	return 0;
 }
-- 
2.1.4

