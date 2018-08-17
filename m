Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E19C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B931218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B931218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHQPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:53:21 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:42170 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeHQPxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:53:21 -0400
X-Greylist: delayed 2298 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 11:53:20 EDT
Received: from dslb-084-059-008-117.084.059.pools.vodafone-ip.de ([84.59.8.117] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1fqdbP-0007QM-7k; Fri, 17 Aug 2018 14:11:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH resend] irqchip/tango: Set irq handler and data in one go
Date:   Fri, 17 Aug 2018 14:10:27 +0200
Message-Id: <1534507827-7230-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1532282533-26507-1-git-send-email-martin@kaiser.cx>
References: <1532282533-26507-1-git-send-email-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the two separate calls for setting the irq handler and data with
a single irq_set_chained_handler_and_data() call.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Resending this, it seems this got lost along the way. Not a major change,
of course. But should also be simple to review.

Thanks & Best regards,
Martin

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

