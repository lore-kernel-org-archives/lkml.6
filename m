Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2695C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1388213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ldy/r4Cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1388213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeKUOLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:11:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37757 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUOLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:11:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so3387161plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z5MAsdKFcai4UXx4/yK6UISTrk8OVTQoys01PtcxnI=;
        b=Ldy/r4CyLlqWiQEOQe40jvqOZsrTRgEo5fCiXYU6f1kvPoRcFFBCfkjeXAHf52ENq2
         J+uw/WoUCDJUaqr60w5UpLkN6dMqCqSmPpygRSU+nAhMHOJqH78WyMlWBaAYIUD3p0K6
         qvuMYsNRFCdbkd52Q6RA8Am5qgy+j8+SccCps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z5MAsdKFcai4UXx4/yK6UISTrk8OVTQoys01PtcxnI=;
        b=KzOTu1KrcDHuUPhxhf2fNPTjJmtX9/wUdKCBTzAgnZIpYtgYc1H/7QUNareYtnrJpl
         tYfue0j4XhJE46GT9p/Z4k2udxo6rfE7he8NQCpWNYA6EGPMQ8aI4cCQkyeMEAKieBRo
         qkDDOglk4oUXKbZbmBA8BCCEJevggn/XTMHYgC70Py7kPocxSmVvLsehuLiWKZkrvtyd
         VV2P5qKybROlaHmwkj0A7yGLKFqzzjCQRELRvP47xzYsEz7g1rz/MVoZChnQnsBov+bR
         Hkfou5OSTj7iVct35wec4T1zPxsbI0Drs6TSWr19V+Agv5J/7K5yOFvxmP4YMq5ZrBpi
         DPgg==
X-Gm-Message-State: AA+aEWbb2BA95JMD9pf7rfcNlQEykIvn4c/OiXdxRj/nni24QXaaLCZ+
        EdWtAsvnmlb6UT2s6YNxBAmZ
X-Google-Smtp-Source: AFSGD/W6jImfa0s43YNcEUcvDuFc2m2yBcGjzUIA2+8kgHTkGt5CWyY6GMGQV+62+QzmRCtE1N8RIA==
X-Received: by 2002:a17:902:3341:: with SMTP id a59-v6mr4986711plc.220.1542771511789;
        Tue, 20 Nov 2018 19:38:31 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:38:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/15] irqchip: Add RDA8810PL interrupt driver
Date:   Wed, 21 Nov 2018 09:06:45 +0530
Message-Id: <20181121033652.12247-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
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
---
 arch/arm/mach-rda/Kconfig      |   1 +
 drivers/irqchip/Kconfig        |   4 ++
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-rda-intc.c | 113 +++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 drivers/irqchip/irq-rda-intc.c

diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
index dafab78d7aab..29012bc68ca4 100644
--- a/arch/arm/mach-rda/Kconfig
+++ b/arch/arm/mach-rda/Kconfig
@@ -3,5 +3,6 @@ menuconfig ARCH_RDA
 	depends on ARCH_MULTI_V7
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
+	select RDA_INTC
 	help
 	  This enables support for the RDA Micro 8810PL SoC family.
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
index 000000000000..1b372bdb23bc
--- /dev/null
+++ b/drivers/irqchip/irq-rda-intc.c
@@ -0,0 +1,113 @@
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
+#include <asm/irq.h>
+#include <asm/exception.h>
+
+#define RDA_INTC_FINALSTATUS	0x00
+#define RDA_INTC_STATUS		0x04
+#define RDA_INTC_MASK_SET	0x08
+#define RDA_INTC_MASK_CLR	0x0c
+#define RDA_INTC_WAKEUP_MASK	0x18
+#define RDA_INTC_CPU_SLEEP	0x1c
+
+#define RDA_IRQ_MASK_ALL	0xFFFFFFFF
+
+#define RDA_NR_IRQS 32
+
+static void __iomem *base;
+
+static void rda_intc_mask_irq(struct irq_data *d)
+{
+	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_CLR);
+}
+
+static void rda_intc_unmask_irq(struct irq_data *d)
+{
+	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_SET);
+}
+
+static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	/* Hardware supports only level triggered interrupts */
+	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
+		irq_set_handler(data->irq, handle_level_irq);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct irq_domain *rda_irq_domain;
+
+static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
+{
+	u32 stat = readl_relaxed(base + RDA_INTC_FINALSTATUS);
+	u32 hwirq;
+
+	while (stat) {
+		hwirq = __fls(stat);
+		handle_domain_irq(rda_irq_domain, hwirq, regs);
+		stat &= ~(1 << hwirq);
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
+	base = of_io_request_and_map(node, 0, "rda-intc");
+	if (!base)
+		return -ENXIO;
+
+	/* Mask, and invalidate all interrupt sources */
+	writel_relaxed(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
+
+	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
+						  &rda_irq_domain_ops, base);
+	if (WARN_ON(!rda_irq_domain)) {
+		iounmap(base);
+		return -ENODEV;
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

