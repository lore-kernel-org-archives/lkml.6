Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDB3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E0F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E0F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJPRFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:05:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbeJPRE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:04:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93576A1DDF2E6;
        Tue, 16 Oct 2018 17:15:24 +0800 (CST)
Received: from localhost (10.177.19.219) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 17:15:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangyingliang@huawei.com>, <marc.zyngier@arm.com>,
        <tglx@linutronix.de>, <guohanjun@huawei.com>
Subject: [PATCH 2/4] irqchip/mbigen: rename register marcros
Date:   Tue, 16 Oct 2018 17:15:14 +0800
Message-ID: <1539681316-19300-3-git-send-email-yangyingliang@huawei.com>
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

A MBIGEN can also be used for generating SPIs, so let's
rename register macros to make them more resonable.

The first 64-pins of MBIGEN is used by SPIs, so rename
RESERVED_IRQ_PER_MBIGEN_CHIP to SPI_NUM_PER_MBIGEN_CHIP
and change the comment for this marcro.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 567b29c..f05998f 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -30,14 +30,14 @@
 /* Interrupt numbers per mbigen node supported */
 #define IRQS_PER_MBIGEN_NODE		128
 
-/* 64 irqs (Pin0-pin63) are reserved for each mbigen chip */
-#define RESERVED_IRQ_PER_MBIGEN_CHIP	64
+/* 64 irqs (Pin0-pin63) are used for SPIs on each mbigen chip */
+#define SPI_NUM_PER_MBIGEN_CHIP	64
 
 /* The maximum IRQ pin number of mbigen chip(start from 0) */
 #define MAXIMUM_IRQ_PIN_NUM		1407
 
 /**
- * In mbigen vector register
+ * In mbigen lpi vector register
  * bit[21:12]:	event id value
  * bit[11:0]:	device id
  */
@@ -48,7 +48,7 @@
 #define MBIGEN_NODE_OFFSET		0x1000
 
 /* offset of vector register in mbigen node */
-#define REG_MBIGEN_VEC_OFFSET		0x200
+#define REG_MBIGEN_LPI_VEC_OFFSET	0x200
 
 /**
  * offset of clear register in mbigen node
@@ -62,7 +62,7 @@
  * This register is used to configure interrupt
  * trigger type
  */
-#define REG_MBIGEN_TYPE_OFFSET		0x0
+#define REG_MBIGEN_LPI_TYPE_OFFSET	0x0
 
 /**
  * struct mbigen_device - holds the information of mbigen device.
@@ -79,12 +79,12 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
 
-	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
+	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
 
 	return pin * 4 + nid * MBIGEN_NODE_OFFSET
-			+ REG_MBIGEN_VEC_OFFSET;
+			+ REG_MBIGEN_LPI_VEC_OFFSET;
 }
 
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -92,7 +92,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 {
 	unsigned int nid, irq_ofst, ofst;
 
-	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
+	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	irq_ofst = hwirq % IRQS_PER_MBIGEN_NODE;
 
@@ -100,7 +100,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 	ofst = irq_ofst / 32 * 4;
 
 	*addr = ofst + nid * MBIGEN_NODE_OFFSET
-		+ REG_MBIGEN_TYPE_OFFSET;
+		+ REG_MBIGEN_LPI_TYPE_OFFSET;
 }
 
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
@@ -183,7 +183,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
 			return -EINVAL;
 
 		if ((fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM) ||
-			(fwspec->param[0] < RESERVED_IRQ_PER_MBIGEN_CHIP))
+			(fwspec->param[0] < SPI_NUM_PER_MBIGEN_CHIP))
 			return -EINVAL;
 		else
 			*hwirq = fwspec->param[0];
-- 
1.8.3


