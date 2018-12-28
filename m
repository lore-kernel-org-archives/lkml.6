Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020AFC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28132148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeL1IKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:10:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55694 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728006AbeL1IKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:10:05 -0500
X-UUID: a37c10ae9a35430c84d7100f7fde0881-20181228
X-UUID: a37c10ae9a35430c84d7100f7fde0881-20181228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2001813503; Fri, 28 Dec 2018 16:09:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Dec 2018 16:09:54 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Dec 2018 16:09:54 +0800
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
Subject: [PATCH v5 1/6] irqchip/mtk-sysirq: support 4 interrupt parameters for sysirq
Date:   Fri, 28 Dec 2018 16:09:36 +0800
Message-ID: <1545984581-25843-2-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
References: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 485846AECE0DE1B2333DEA885EDD0ED1CCFA23A2F08E5A9DF62712A56D57871F2000:8
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

