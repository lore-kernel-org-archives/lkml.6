Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148192082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZpnl14W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148192082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeLJRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:37:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38741 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeLJRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:37:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so5728837pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paserLSWvruKGRH0unlQrwzFxeUOtATxgj85HiPjRLo=;
        b=iZpnl14WwP9SdRZH4erTHT7deFkt2RjnMbDpJ7WRsJGa7rMQkb+o/6r/P5nMTerDzC
         bIwCSSHOQ8gbZz16ld5veLJRKT/8bA5cKyHQRKt0FV8E0YtEqSw0ESufDCNPiv7sReCO
         Z+m5eurMsOQzdDc/+/7R/tzFThc/fhDfspPwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paserLSWvruKGRH0unlQrwzFxeUOtATxgj85HiPjRLo=;
        b=EqU2mmtDLHCfODwtezJg9mwHlI2owU5v/vpAhBlmKmdlqoZz20aR6bn12ioBCul3+p
         rj0CR0IX9xkS0CMoTB5kaa6Pj8nJIgDMVw38CPjZBCoUttKONXWTnUS7bIr/2c7Eodw6
         wJZy3S4laYX6S6sbRnB5yxjgeeC3CKedtFU9wpYeU+5EhIq5QJJDD4HjYS2afRpmKssI
         ZXYhmG3oPCJmjVVxp/sWijttThHtgHXRh8L3THxb4IR2TQr7zJlxTf4at4k9/F9jLRPx
         ckdfX7zcwWZJ0BDDZCJeSyw+SVTqB8eEkbgZ9HpDRmPNHYUZ5ZFga4QfDvCFq2qnn/sv
         woaQ==
X-Gm-Message-State: AA+aEWY5UAZE/89zYkRJ+sULho1k+Dpdj8WT01Esy8l9BWKaM5bWiYly
        oDYM+k94o6TMb+Dk9Qo1GlKo
X-Google-Smtp-Source: AFSGD/UROBxdoupf/IuJWOaFU1FsAxKl3uAkVSiSR5qVY3DTkEXCRUtUZu4cFWjdPlkkSAwLEbrTsw==
X-Received: by 2002:a62:435a:: with SMTP id q87mr12968140pfa.109.1544463432829;
        Mon, 10 Dec 2018 09:37:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:37:12 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 08/15] irqchip: Add RDA8810PL interrupt driver
Date:   Mon, 10 Dec 2018 23:05:43 +0530
Message-Id: <20181210173550.29643-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt driver for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/Kconfig        |   4 ++
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-rda-intc.c | 107 +++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/irqchip/irq-rda-intc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 51a5ef0e96ed..9d54645870ad 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -195,6 +195,10 @@ config JCORE_AIC
 	help
 	  Support for the J-Core integrated AIC.
 
+config RDA_INTC
+	bool
+	select IRQ_DOMAIN
+
 config RENESAS_INTC_IRQPIN
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 794c13d3ac3d..417108027e40 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
 obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
 obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
 obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
+obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
new file mode 100644
index 000000000000..1176291fdef8
--- /dev/null
+++ b/drivers/irqchip/irq-rda-intc.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RDA8810PL SoC irqchip driver
+ *
+ * Copyright RDA Microelectronics Company Limited
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+
+#include <asm/exception.h>
+
+#define RDA_INTC_FINALSTATUS	0x00
+#define RDA_INTC_MASK_SET	0x08
+#define RDA_INTC_MASK_CLR	0x0c
+
+#define RDA_IRQ_MASK_ALL	0xFFFFFFFF
+
+#define RDA_NR_IRQS 32
+
+static void __iomem *rda_intc_base;
+static struct irq_domain *rda_irq_domain;
+
+static void rda_intc_mask_irq(struct irq_data *d)
+{
+	writel_relaxed(BIT(d->hwirq), rda_intc_base + RDA_INTC_MASK_CLR);
+}
+
+static void rda_intc_unmask_irq(struct irq_data *d)
+{
+	writel_relaxed(BIT(d->hwirq), rda_intc_base + RDA_INTC_MASK_SET);
+}
+
+static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	/* Hardware supports only level triggered interrupts */
+	if ((flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) == flow_type)
+		return 0;
+
+	return -EINVAL;
+}
+
+static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
+{
+	u32 stat = readl_relaxed(rda_intc_base + RDA_INTC_FINALSTATUS);
+	u32 hwirq;
+
+	while (stat) {
+		hwirq = __fls(stat);
+		handle_domain_irq(rda_irq_domain, hwirq, regs);
+		stat &= ~BIT(hwirq);
+	}
+}
+
+static struct irq_chip rda_irq_chip = {
+	.name		= "rda-intc",
+	.irq_mask	= rda_intc_mask_irq,
+	.irq_unmask	= rda_intc_unmask_irq,
+	.irq_set_type	= rda_intc_set_type,
+};
+
+static int rda_irq_map(struct irq_domain *d,
+		       unsigned int virq, irq_hw_number_t hw)
+{
+	irq_set_status_flags(virq, IRQ_LEVEL);
+	irq_set_chip_and_handler(virq, &rda_irq_chip, handle_level_irq);
+	irq_set_chip_data(virq, d->host_data);
+	irq_set_probe(virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rda_irq_domain_ops = {
+	.map = rda_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init rda8810_intc_init(struct device_node *node,
+				    struct device_node *parent)
+{
+	rda_intc_base = of_io_request_and_map(node, 0, "rda-intc");
+	if (!rda_intc_base)
+		return -ENXIO;
+
+	/* Mask all interrupt sources */
+	writel_relaxed(RDA_IRQ_MASK_ALL, rda_intc_base + RDA_INTC_MASK_CLR);
+
+	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
+						  &rda_irq_domain_ops,
+						  rda_intc_base);
+	if (!rda_irq_domain) {
+		iounmap(rda_intc_base);
+		return -ENOMEM;
+	}
+
+	set_handle_irq(rda_handle_irq);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(rda_intc, "rda,8810pl-intc", rda8810_intc_init);
-- 
2.17.1

