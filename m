Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3082081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5dqLRB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3082081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeK2AyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:54:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38180 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeK2AyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:54:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so9548040pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipl/Aeuyj0hY3JqUyjxodwF3khWSWc9r89gdL6ISlr0=;
        b=A5dqLRB9vKBRW4eNzqt8FmmIp0y6NJ9NRuDM/4eTO3l3dxi75ijY0PVW2YEMLwe+ut
         1pl0IHdBLR5O7+P/e5l0F8tSMuy0IvI40aq+JJNitfs8o0A09o2EvsRjiLWmfj8RpO0U
         fQbGI9nmuLBRd5383Z6mI/7UTxC59n4coPDEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipl/Aeuyj0hY3JqUyjxodwF3khWSWc9r89gdL6ISlr0=;
        b=ZxcQOEgBsZWRYDsiCxfLsTw44ix3LJMB0ZKG/GpmHZ522qetVqi6l/TKE+f7ThTHQ7
         Ij7CalllI+jstBrh37bi+DQ9B43hY6zIDhkgzNbFvr2wKKy+WQdGFxD9hWWp5tflGiA4
         js2t3IbhTOK2m2shBIxVwJFmxTrVvlFASKdGJVYUWKBS06Ndxz3fcm4TET+GrmHjTHOZ
         5NG7CcnAn2gSBrpZ/oRXI3v/yZ7u9SIQg5HgeZ7nkevue2pKwCKPdh5siZvAaqdkSv7w
         raKGbwR8HmOYvj4hgzQGuxpyafqxxt6S2b4PC2G5uLeVGrf4TQnSgk2uZFjce39c0gOh
         LU4A==
X-Gm-Message-State: AGRZ1gJxn4dtV7zuNiqYGqHm6/hbyq1dVYasa/9dCM8IxG6o9GHagprl
        OBsJewsFw/ltCCjg4SVi7CjcEztLLw==
X-Google-Smtp-Source: AJdET5fNs1ZuFMECW7yxJ0eZu0GNskCR5G3G41us1+PGzi7O4S/id3dxi50kxR5gzEQkymMUe/U+eQ==
X-Received: by 2002:a62:1289:: with SMTP id 9mr38039276pfs.102.1543413159692;
        Wed, 28 Nov 2018 05:52:39 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:52:39 -0800 (PST)
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
Subject: [PATCH v3 08/15] irqchip: Add RDA8810PL interrupt driver
Date:   Wed, 28 Nov 2018 19:20:59 +0530
Message-Id: <20181128135106.9255-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
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
 drivers/irqchip/irq-rda-intc.c | 107 +++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)
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

