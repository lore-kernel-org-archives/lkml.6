Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D8BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C502086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C502086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJPRFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:05:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeJPRE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:04:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC0A3E32A711F;
        Tue, 16 Oct 2018 17:15:27 +0800 (CST)
Received: from localhost (10.177.19.219) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 17:15:21 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangyingliang@huawei.com>, <marc.zyngier@arm.com>,
        <tglx@linutronix.de>, <guohanjun@huawei.com>
Subject: [PATCH 3/4] irqchip/mbigen: add support for a MBIGEN generating SPIs
Date:   Tue, 16 Oct 2018 17:15:15 +0800
Message-ID: <1539681316-19300-4-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
In-Reply-To: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
References: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with
5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
we can support MBIGEN to generate message based SPIs by writing GICD_SETSPIR.

The first 64-pins of each MBIGEN chip is used to generate SPIs, and each
MBIGEN chip has several MBIGEN nodes, every node has 128 pins for generating
LPIs. The total pins are: 64(SPIs) + 128 * node_nr(LPIs). So we can translate
the pin index in a unified way in mbigen_domain_translate().

Also Add TYPE and VEC registers that used by generating SPIs, the driver can
access them when MBIGEN is used to generate SPIs.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f05998f..37c1932 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -48,6 +48,7 @@
 #define MBIGEN_NODE_OFFSET		0x1000
 
 /* offset of vector register in mbigen node */
+#define REG_MBIGEN_SPI_VEC_OFFSET	0x500
 #define REG_MBIGEN_LPI_VEC_OFFSET	0x200
 
 /**
@@ -62,6 +63,7 @@
  * This register is used to configure interrupt
  * trigger type
  */
+#define REG_MBIGEN_SPI_TYPE_OFFSET	0x400
 #define REG_MBIGEN_LPI_TYPE_OFFSET	0x0
 
 /**
@@ -79,6 +81,9 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
 
+	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP)
+		return (hwirq * 4 + REG_MBIGEN_SPI_VEC_OFFSET);
+
 	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
@@ -92,6 +97,13 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 {
 	unsigned int nid, irq_ofst, ofst;
 
+	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
+		*mask = 1 << (hwirq % 32);
+		ofst = hwirq / 32 * 4;
+		*addr = ofst + REG_MBIGEN_SPI_TYPE_OFFSET;
+		return;
+	}
+
 	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	irq_ofst = hwirq % IRQS_PER_MBIGEN_NODE;
@@ -162,6 +174,12 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	u32 val;
 
 	base += get_mbigen_vec_reg(d->hwirq);
+
+	if (d->hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
+		writel_relaxed(msg->data, base);
+		return;
+	}
+
 	val = readl_relaxed(base);
 
 	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
@@ -182,8 +200,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
 		if (fwspec->param_count != 2)
 			return -EINVAL;
 
-		if ((fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM) ||
-			(fwspec->param[0] < SPI_NUM_PER_MBIGEN_CHIP))
+		if (fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM)
 			return -EINVAL;
 		else
 			*hwirq = fwspec->param[0];
-- 
1.8.3


