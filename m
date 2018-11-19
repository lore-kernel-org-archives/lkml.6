Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C2AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6652148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYpBMdyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6652148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436471AbeKTDgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:36:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32984 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406379AbeKTDgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:36:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so15162615pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjfTWF5ho9hOW+H8fAwrXTF7zQ1PXYNRyB/MMyM6ljs=;
        b=OYpBMdyVWA9L6I8iK6wWAg/eUV9b3ccDfStZOExLX6Yf4wTxEfBgo1SIPZvXvhB+EK
         fbmAE0HS6LGSPYTMZ5Bm3p8xmVSyLOZOnLocF8hdytD5WsJksc2duLLBieXV0wat77nb
         wHoLfNISF8izqGmH3kseBJYJwsFZFDYtJR+h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjfTWF5ho9hOW+H8fAwrXTF7zQ1PXYNRyB/MMyM6ljs=;
        b=jfqEVXcQOABIVk6eygzCzWvPj1HKHR+7qddWznU+2pU/Xn6Rd8AGT7O37mfyQld8nD
         dWoQo+2LUvSSAyD8nJseCl50VDJH3zfiXq7la98T1+NHRyKwgrVmPpzaWiDV3Rbizmcs
         oijYypEzJNmqkG+gxmxlM0d0HpReiGbK6c30anhMkoda7TdsrsK11vynRtriGKjmK9t/
         HoxqA4FmNFa2H4B+1m8GUXO8iZ3AhQji9jP9mQgfgYUg0UO9PoIiawki6dPQBxfw4JGX
         FVJUEhmP4aMCp3yn2+A6BTUUq3MPCKbi1Ic19G2VB/bJ1poM28T6nHbd08q/DS806Uf/
         NVBA==
X-Gm-Message-State: AGRZ1gLuvW3Jl9PEUBIvCq5jiIqlXyxuisSujai/KvKclY805RziJFlQ
        sM/tyj8rI1EiigQvCxov3Pay
X-Google-Smtp-Source: AJdET5eW3lvmdi0apRs2ZJlfqPcyipsZQBhJfAHtDsKm4p/bbTygzPOX6GXt6VWCZN8M3MKBGWg0YA==
X-Received: by 2002:a62:9683:: with SMTP id s3mr16521558pfk.60.1542647522027;
        Mon, 19 Nov 2018 09:12:02 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:12:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 09/16] irqchip: Add RDA8810PL interrupt driver
Date:   Mon, 19 Nov 2018 22:39:32 +0530
Message-Id: <20181119170939.19153-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
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
 drivers/irqchip/irq-rda-intc.c | 116 +++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)
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
index 000000000000..89be55a11823
--- /dev/null
+++ b/drivers/irqchip/irq-rda-intc.c
@@ -0,0 +1,116 @@
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
+void __iomem *base;
+
+static void rda_intc_mask_irq(struct irq_data *d)
+{
+	void __iomem *base = (void __iomem *)irq_data_get_irq_chip_data(d);
+
+	writel(BIT(d->hwirq), base + RDA_INTC_MASK_CLR);
+}
+
+static void rda_intc_unmask_irq(struct irq_data *d)
+{
+	void __iomem *base = (void __iomem *)irq_data_get_irq_chip_data(d);
+
+	writel(BIT(d->hwirq), base + RDA_INTC_MASK_SET);
+}
+
+static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
+		irq_set_handler(data->irq, handle_edge_irq);
+	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
+		irq_set_handler(data->irq, handle_level_irq);
+
+	return 0;
+}
+
+struct irq_domain *rda_irq_domain;
+
+static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
+{
+	u32 stat = readl(base + RDA_INTC_FINALSTATUS);
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
+	.irq_ack	= rda_intc_mask_irq,
+	.irq_mask	= rda_intc_mask_irq,
+	.irq_unmask	= rda_intc_unmask_irq,
+	.irq_set_type	= rda_intc_set_type,
+	.irq_disable	= rda_intc_mask_irq,
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
+	/*
+	 * Mask, and invalid all interrupt sources
+	 */
+	writel(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
+
+	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
+						  &rda_irq_domain_ops, base);
+	WARN_ON(!rda_irq_domain);
+
+	set_handle_irq(rda_handle_irq);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(rda_intc, "rda,8810pl-intc", rda8810_intc_init);
-- 
2.17.1

