Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754B620872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfAKN7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:59:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13019 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728616AbfAKN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:59:24 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BDuFAU028516;
        Fri, 11 Jan 2019 14:59:08 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pxpw9hqjh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 11 Jan 2019 14:59:08 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 092F73A;
        Fri, 11 Jan 2019 13:59:06 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D525F4E99;
        Fri, 11 Jan 2019 13:59:06 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 11 Jan
 2019 14:59:06 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 11 Jan 2019 14:59:05
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 1/1] irqchip: stm32-exti: add domain translate function
Date:   Fri, 11 Jan 2019 14:58:52 +0100
Message-ID: <1547215132-85612-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Domain translate function is needed to recover irq
configuration parameters from DT node

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6edfd4bfa169..717879028cc4 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -819,9 +819,27 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	return ret;
 }
 
+static int stm32_exti_h_translate(struct irq_domain *d,
+				  struct irq_fwspec *fwspec,
+				  unsigned long *out_hwirq,
+				  unsigned int *out_type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+
+		*out_hwirq = fwspec->param[0];
+		*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static const struct irq_domain_ops stm32_exti_h_domain_ops = {
 	.alloc	= stm32_exti_h_domain_alloc,
 	.free	= irq_domain_free_irqs_common,
+	.translate = stm32_exti_h_translate,
 };
 
 static int
-- 
2.7.4

