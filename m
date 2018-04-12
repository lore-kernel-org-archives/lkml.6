Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeDLGsn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:48:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28704 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752591AbeDLGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:48:22 -0400
From: Fabien Dessenne <fabien.dessenne@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Ludovic Barre" <ludovic.barre@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v4 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
Date: Thu, 12 Apr 2018 08:47:41 +0200
Message-ID: <1523515661-8318-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523515661-8318-1-git-send-email-fabien.dessenne@st.com>
References: <1523515661-8318-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.5.235]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STMicroelectronics STM32 Inter-Processor Communication Controller
(IPCC) is used for communicating data between two processors.
It provides a non blocking signaling mechanism to post and retrieve
communication data in an atomic way.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mailbox/Kconfig      |   8 +
 drivers/mailbox/Makefile     |   2 +
 drivers/mailbox/stm32-ipcc.c | 402 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 412 insertions(+)
 create mode 100644 drivers/mailbox/stm32-ipcc.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ba2f152..d7581f0 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -171,4 +171,12 @@ config BCM_FLEXRM_MBOX
 	  Mailbox implementation of the Broadcom FlexRM ring manager,
 	  which provides access to various offload engines on Broadcom
 	  SoCs. Say Y here if you want to use the Broadcom FlexRM.
+
+config STM32_IPCC
+	tristate "STM32 IPCC Mailbox"
+	depends on MACH_STM32MP157
+	help
+	  Mailbox implementation for STMicroelectonics STM32 family chips
+	  with hardware for Inter-Processor Communication Controller (IPCC)
+	  between processors. Say Y here if you want to have this support.
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 4896f8d..7ea9654 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -36,3 +36,5 @@ obj-$(CONFIG_BCM_FLEXRM_MBOX)	+= bcm-flexrm-mailbox.o
 obj-$(CONFIG_QCOM_APCS_IPC)	+= qcom-apcs-ipc-mailbox.o
 
 obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
+
+obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
new file mode 100644
index 0000000..533b0da
--- /dev/null
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Authors: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
+ *          Fabien Dessenne <fabien.dessenne@st.com> for STMicroelectronics.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+
+#define IPCC_XCR		0x000
+#define XCR_RXOIE		BIT(0)
+#define XCR_TXOIE		BIT(16)
+
+#define IPCC_XMR		0x004
+#define IPCC_XSCR		0x008
+#define IPCC_XTOYSR		0x00c
+
+#define IPCC_PROC_OFFST		0x010
+
+#define IPCC_HWCFGR		0x3f0
+#define IPCFGR_CHAN_MASK	GENMASK(7, 0)
+
+#define IPCC_VER		0x3f4
+#define VER_MINREV_MASK		GENMASK(3, 0)
+#define VER_MAJREV_MASK		GENMASK(7, 4)
+
+#define RX_BIT_MASK		GENMASK(15, 0)
+#define RX_BIT_CHAN(chan)	BIT(chan)
+#define TX_BIT_SHIFT		16
+#define TX_BIT_MASK		GENMASK(31, 16)
+#define TX_BIT_CHAN(chan)	BIT(TX_BIT_SHIFT + (chan))
+
+#define STM32_MAX_PROCS		2
+
+enum {
+	IPCC_IRQ_RX,
+	IPCC_IRQ_TX,
+	IPCC_IRQ_NUM,
+};
+
+struct stm32_ipcc {
+	struct mbox_controller controller;
+	void __iomem *reg_base;
+	void __iomem *reg_proc;
+	struct clk *clk;
+	int irqs[IPCC_IRQ_NUM];
+	int wkp;
+	u32 proc_id;
+	u32 n_chans;
+	u32 xcr;
+	u32 xmr;
+};
+
+static inline void stm32_ipcc_set_bits(void __iomem *reg, u32 mask)
+{
+	writel_relaxed(readl_relaxed(reg) | mask, reg);
+}
+
+static inline void stm32_ipcc_clr_bits(void __iomem *reg, u32 mask)
+{
+	writel_relaxed(readl_relaxed(reg) & ~mask, reg);
+}
+
+static irqreturn_t stm32_ipcc_rx_irq(int irq, void *data)
+{
+	struct stm32_ipcc *ipcc = data;
+	struct device *dev = ipcc->controller.dev;
+	u32 status, mr, tosr, chan;
+	irqreturn_t ret = IRQ_NONE;
+	int proc_offset;
+
+	/* read 'channel occupied' status from other proc */
+	proc_offset = ipcc->proc_id ? -IPCC_PROC_OFFST : IPCC_PROC_OFFST;
+	tosr = readl_relaxed(ipcc->reg_proc + proc_offset + IPCC_XTOYSR);
+	mr = readl_relaxed(ipcc->reg_proc + IPCC_XMR);
+
+	/* search for unmasked 'channel occupied' */
+	status = tosr & FIELD_GET(RX_BIT_MASK, ~mr);
+
+	for (chan = 0; chan < ipcc->n_chans; chan++) {
+		if (!(status & (1 << chan)))
+			continue;
+
+		dev_dbg(dev, "%s: chan:%d rx\n", __func__, chan);
+
+		mbox_chan_received_data(&ipcc->controller.chans[chan], NULL);
+
+		stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XSCR,
+				    RX_BIT_CHAN(chan));
+
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static irqreturn_t stm32_ipcc_tx_irq(int irq, void *data)
+{
+	struct stm32_ipcc *ipcc = data;
+	struct device *dev = ipcc->controller.dev;
+	u32 status, mr, tosr, chan;
+	irqreturn_t ret = IRQ_NONE;
+
+	tosr = readl_relaxed(ipcc->reg_proc + IPCC_XTOYSR);
+	mr = readl_relaxed(ipcc->reg_proc + IPCC_XMR);
+
+	/* search for unmasked 'channel free' */
+	status = ~tosr & FIELD_GET(TX_BIT_MASK, ~mr);
+
+	for (chan = 0; chan < ipcc->n_chans ; chan++) {
+		if (!(status & (1 << chan)))
+			continue;
+
+		dev_dbg(dev, "%s: chan:%d tx\n", __func__, chan);
+
+		/* mask 'tx channel free' interrupt */
+		stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XMR,
+				    TX_BIT_CHAN(chan));
+
+		mbox_chan_txdone(&ipcc->controller.chans[chan], 0);
+
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static int stm32_ipcc_send_data(struct mbox_chan *link, void *data)
+{
+	unsigned int chan = (unsigned int)link->con_priv;
+	struct stm32_ipcc *ipcc = container_of(link->mbox, struct stm32_ipcc,
+					       controller);
+
+	dev_dbg(ipcc->controller.dev, "%s: chan:%d\n", __func__, chan);
+
+	/* set channel n occupied */
+	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XSCR, TX_BIT_CHAN(chan));
+
+	/* unmask 'tx channel free' interrupt */
+	stm32_ipcc_clr_bits(ipcc->reg_proc + IPCC_XMR, TX_BIT_CHAN(chan));
+
+	return 0;
+}
+
+static int stm32_ipcc_startup(struct mbox_chan *link)
+{
+	unsigned int chan = (unsigned int)link->con_priv;
+	struct stm32_ipcc *ipcc = container_of(link->mbox, struct stm32_ipcc,
+					       controller);
+	int ret;
+
+	ret = clk_prepare_enable(ipcc->clk);
+	if (ret) {
+		dev_err(ipcc->controller.dev, "can not enable the clock\n");
+		return ret;
+	}
+
+	/* unmask 'rx channel occupied' interrupt */
+	stm32_ipcc_clr_bits(ipcc->reg_proc + IPCC_XMR, RX_BIT_CHAN(chan));
+
+	return 0;
+}
+
+static void stm32_ipcc_shutdown(struct mbox_chan *link)
+{
+	unsigned int chan = (unsigned int)link->con_priv;
+	struct stm32_ipcc *ipcc = container_of(link->mbox, struct stm32_ipcc,
+					       controller);
+
+	/* mask rx/tx interrupt */
+	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XMR,
+			    RX_BIT_CHAN(chan) | TX_BIT_CHAN(chan));
+
+	clk_disable_unprepare(ipcc->clk);
+}
+
+static const struct mbox_chan_ops stm32_ipcc_ops = {
+	.send_data	= stm32_ipcc_send_data,
+	.startup	= stm32_ipcc_startup,
+	.shutdown	= stm32_ipcc_shutdown,
+};
+
+static int stm32_ipcc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct stm32_ipcc *ipcc;
+	struct resource *res;
+	unsigned int i;
+	int ret;
+	u32 ip_ver;
+	static const char * const irq_name[] = {"rx", "tx"};
+	irq_handler_t irq_thread[] = {stm32_ipcc_rx_irq, stm32_ipcc_tx_irq};
+
+	if (!np) {
+		dev_err(dev, "No DT found\n");
+		return -ENODEV;
+	}
+
+	ipcc = devm_kzalloc(dev, sizeof(*ipcc), GFP_KERNEL);
+	if (!ipcc)
+		return -ENOMEM;
+
+	/* proc_id */
+	if (of_property_read_u32(np, "st,proc-id", &ipcc->proc_id)) {
+		dev_err(dev, "Missing st,proc-id\n");
+		return -ENODEV;
+	}
+
+	if (ipcc->proc_id >= STM32_MAX_PROCS) {
+		dev_err(dev, "Invalid proc_id (%d)\n", ipcc->proc_id);
+		return -EINVAL;
+	}
+
+	/* regs */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ipcc->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ipcc->reg_base))
+		return PTR_ERR(ipcc->reg_base);
+
+	ipcc->reg_proc = ipcc->reg_base + ipcc->proc_id * IPCC_PROC_OFFST;
+
+	/* clock */
+	ipcc->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ipcc->clk))
+		return PTR_ERR(ipcc->clk);
+
+	ret = clk_prepare_enable(ipcc->clk);
+	if (ret) {
+		dev_err(dev, "can not enable the clock\n");
+		return ret;
+	}
+
+	/* irq */
+	for (i = 0; i < IPCC_IRQ_NUM; i++) {
+		ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
+		if (ipcc->irqs[i] < 0) {
+			dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
+			ret = ipcc->irqs[i];
+			goto err_clk;
+		}
+
+		ret = devm_request_threaded_irq(dev, ipcc->irqs[i], NULL,
+						irq_thread[i], IRQF_ONESHOT,
+						dev_name(dev), ipcc);
+		if (ret) {
+			dev_err(dev, "failed to request irq %d (%d)\n", i, ret);
+			goto err_clk;
+		}
+	}
+
+	/* mask and enable rx/tx irq */
+	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XMR,
+			    RX_BIT_MASK | TX_BIT_MASK);
+	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XCR, XCR_RXOIE | XCR_TXOIE);
+
+	/* wakeup */
+	if (of_property_read_bool(np, "wakeup-source")) {
+		ipcc->wkp = of_irq_get_byname(dev->of_node, "wakeup");
+		if (ipcc->wkp < 0) {
+			dev_err(dev, "could not get wakeup IRQ\n");
+			ret = ipcc->wkp;
+			goto err_clk;
+		}
+
+		device_init_wakeup(dev, true);
+		ret = dev_pm_set_dedicated_wake_irq(dev, ipcc->wkp);
+		if (ret) {
+			dev_err(dev, "Failed to set wake up irq\n");
+			goto err_init_wkp;
+		}
+	} else {
+		device_init_wakeup(dev, false);
+	}
+
+	/* mailbox controller */
+	ipcc->n_chans = readl_relaxed(ipcc->reg_base + IPCC_HWCFGR);
+	ipcc->n_chans &= IPCFGR_CHAN_MASK;
+
+	ipcc->controller.dev = dev;
+	ipcc->controller.txdone_irq = true;
+	ipcc->controller.ops = &stm32_ipcc_ops;
+	ipcc->controller.num_chans = ipcc->n_chans;
+	ipcc->controller.chans = devm_kcalloc(dev, ipcc->controller.num_chans,
+					      sizeof(*ipcc->controller.chans),
+					      GFP_KERNEL);
+	if (!ipcc->controller.chans) {
+		ret = -ENOMEM;
+		goto err_irq_wkp;
+	}
+
+	for (i = 0; i < ipcc->controller.num_chans; i++)
+		ipcc->controller.chans[i].con_priv = (void *)i;
+
+	ret = mbox_controller_register(&ipcc->controller);
+	if (ret)
+		goto err_irq_wkp;
+
+	platform_set_drvdata(pdev, ipcc);
+
+	ip_ver = readl_relaxed(ipcc->reg_base + IPCC_VER);
+
+	dev_info(dev, "ipcc rev:%ld.%ld enabled, %d chans, proc %d\n",
+		 FIELD_GET(VER_MAJREV_MASK, ip_ver),
+		 FIELD_GET(VER_MINREV_MASK, ip_ver),
+		 ipcc->controller.num_chans, ipcc->proc_id);
+
+	clk_disable_unprepare(ipcc->clk);
+	return 0;
+
+err_irq_wkp:
+	if (ipcc->wkp)
+		dev_pm_clear_wake_irq(dev);
+err_init_wkp:
+	device_init_wakeup(dev, false);
+err_clk:
+	clk_disable_unprepare(ipcc->clk);
+	return ret;
+}
+
+static int stm32_ipcc_remove(struct platform_device *pdev)
+{
+	struct stm32_ipcc *ipcc = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&ipcc->controller);
+
+	if (ipcc->wkp)
+		dev_pm_clear_wake_irq(&pdev->dev);
+
+	device_init_wakeup(&pdev->dev, false);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void stm32_ipcc_set_irq_wake(struct device *dev, bool enable)
+{
+	struct stm32_ipcc *ipcc = dev_get_drvdata(dev);
+	unsigned int i;
+
+	if (device_may_wakeup(dev))
+		for (i = 0; i < IPCC_IRQ_NUM; i++)
+			irq_set_irq_wake(ipcc->irqs[i], enable);
+}
+
+static int stm32_ipcc_suspend(struct device *dev)
+{
+	struct stm32_ipcc *ipcc = dev_get_drvdata(dev);
+
+	ipcc->xmr = readl_relaxed(ipcc->reg_proc + IPCC_XMR);
+	ipcc->xcr = readl_relaxed(ipcc->reg_proc + IPCC_XCR);
+
+	stm32_ipcc_set_irq_wake(dev, true);
+
+	return 0;
+}
+
+static int stm32_ipcc_resume(struct device *dev)
+{
+	struct stm32_ipcc *ipcc = dev_get_drvdata(dev);
+
+	stm32_ipcc_set_irq_wake(dev, false);
+
+	writel_relaxed(ipcc->xmr, ipcc->reg_proc + IPCC_XMR);
+	writel_relaxed(ipcc->xcr, ipcc->reg_proc + IPCC_XCR);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_ipcc_pm_ops,
+			 stm32_ipcc_suspend, stm32_ipcc_resume);
+
+static const struct of_device_id stm32_ipcc_of_match[] = {
+	{ .compatible = "st,stm32mp1-ipcc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_ipcc_of_match);
+
+static struct platform_driver stm32_ipcc_driver = {
+	.driver = {
+		.name = "stm32-ipcc",
+		.pm = &stm32_ipcc_pm_ops,
+		.of_match_table = stm32_ipcc_of_match,
+	},
+	.probe		= stm32_ipcc_probe,
+	.remove		= stm32_ipcc_remove,
+};
+
+module_platform_driver(stm32_ipcc_driver);
+
+MODULE_AUTHOR("Ludovic Barre <ludovic.barre@st.com>");
+MODULE_AUTHOR("Fabien Dessenne <fabien.dessenne@st.com>");
+MODULE_DESCRIPTION("STM32 IPCC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
