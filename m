Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B782C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E0721855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfAXIO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:14:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:63839 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbfAXIO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:14:26 -0500
X-UUID: 53999c8901b54bdb886103c546aa059a-20190124
X-UUID: 53999c8901b54bdb886103c546aa059a-20190124
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 801944606; Thu, 24 Jan 2019 16:14:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 16:14:14 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 16:14:14 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        <linux-clk@vger.kernel.org>, Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH v6 1/6] irqchip/mtk-sysirq: support 4 interrupt parameters for sysirq
Date:   Thu, 24 Jan 2019 16:07:15 +0800
Message-ID: <1548317240-44682-2-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seiya Wang <seiya.wang@mediatek.com>

To support partitioned PPIs, 4 interrupt parameters should be valid
for sysirq.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 90aaf19..282736a 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -81,7 +81,7 @@ static int mtk_sysirq_domain_translate(struct irq_domain *d,
 				       unsigned int *type)
 {
 	if (is_of_node(fwspec->fwnode)) {
-		if (fwspec->param_count != 3)
+		if (fwspec->param_count != 3 && fwspec->param_count != 4)
 			return -EINVAL;
 
 		/* No PPI should point to this domain */
@@ -104,7 +104,7 @@ static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_fwspec *fwspec = arg;
 	struct irq_fwspec gic_fwspec = *fwspec;
 
-	if (fwspec->param_count != 3)
+	if (fwspec->param_count != 3 && fwspec->param_count != 4)
 		return -EINVAL;
 
 	/* sysirq doesn't support PPI */
-- 
1.9.1

