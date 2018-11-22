Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941DA20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U4BJB7bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941DA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394879AbeKVWTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:19:05 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42052 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391015AbeKVWTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:19:04 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBe16l022672;
        Thu, 22 Nov 2018 05:40:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886801;
        bh=XHNydlm9b1vORxwMNoF+q3/Zh9EOgYa5zG9zouBbcpI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U4BJB7bnLmTfQSwjS/Hx4f2Epzfb7ZNeBG4w5sZ2b5m2duEwEE5afJNOwe1TeCzbM
         /1/QCHJgaBLfQ5JYThd1heEaOANzHeDYwpCD9BqoDjcstKawK5RZg5IqgMmUzKSUdv
         rrJcCNW5yiCNvt1NO4ifhZEFX3AE6zH/hddoYb3A=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBe1ma107209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:40:01 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:39:58 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:39:59 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdwS9011429;
        Thu, 22 Nov 2018 05:39:58 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDf9013203;
        Thu, 22 Nov 2018 05:39:55 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 10/17] soc: ti: pruss_intc: Add API to trigger a PRU sysevent
Date:   Thu, 22 Nov 2018 13:39:06 +0200
Message-ID: <1542886753-17625-11-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRUSS INTC can generate an interrupt to various processor
subsystems on the SoC through a set of 64 possible PRU system
events. These system events can be used by PRU client drivers
or applications for event notifications/signalling between PRUs
and MPU or other processors. A new API, pruss_intc_trigger() is
provided to MPU-side PRU client drivers/applications to be able
to trigger an event/interrupt using IRQ numbers provided by the
PRUSS-INTC irqdomain chip.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/soc/ti/pruss_intc.c | 31 +++++++++++++++++++++++++++++++
 include/linux/pruss.h       |  7 +++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/soc/ti/pruss_intc.c b/drivers/soc/ti/pruss_intc.c
index df6b83b..6158b63 100644
--- a/drivers/soc/ti/pruss_intc.c
+++ b/drivers/soc/ti/pruss_intc.c
@@ -395,6 +395,37 @@ static void pruss_intc_irq_relres(struct irq_data *data)
 	module_put(THIS_MODULE);
 }
 
+/**
+ * pruss_intc_trigger() - trigger a PRU system event
+ * @irq: linux IRQ number associated with a PRU system event
+ *
+ * Trigger an interrupt by signalling a specific PRU system event.
+ * This can be used by PRUSS client users to raise/send an event to
+ * a PRU or any other core that is listening on the host interrupt
+ * mapped to that specific PRU system event. The @irq variable is the
+ * Linux IRQ number associated with a specific PRU system event that
+ * a client user/application uses. The interrupt mappings for this is
+ * provided by the PRUSS INTC irqchip instance.
+ *
+ * Returns 0 on success, or an error value upon failure.
+ */
+int pruss_intc_trigger(unsigned int irq)
+{
+	struct irq_desc *desc;
+
+	if (irq <= 0)
+		return -EINVAL;
+
+	desc = irq_to_desc(irq);
+	if (!desc)
+		return -EINVAL;
+
+	pruss_intc_irq_retrigger(&desc->irq_data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pruss_intc_trigger);
+
 static int pruss_intc_irq_domain_map(struct irq_domain *d, unsigned int virq,
 				     irq_hw_number_t hw)
 {
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 198ae25..768b698 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -41,6 +41,8 @@ int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
 int pruss_release_mem_region(struct pruss *pruss,
 			     struct pruss_mem_region *region);
 
+int pruss_intc_trigger(unsigned int irq);
+
 #else
 
 static inline int pruss_request_mem_region(struct pruss *pruss,
@@ -56,6 +58,11 @@ static inline int pruss_release_mem_region(struct pruss *pruss,
 	return -ENOTSUPP;
 }
 
+static inline int pruss_intc_trigger(unsigned int irq)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_TI_PRUSS */
 
 #endif /* __LINUX_PRUSS_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

