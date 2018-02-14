Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966833AbeBNDue (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:50:34 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37933 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966671AbeBNDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:50:28 -0500
X-Google-Smtp-Source: AH8x226wWn47Triz5Rg8O76yrJJ2GK4UvvsiIYg0IcJFSRzqdlP2poafunMEFzXZ2oUDqW1qkK2MuA==
From: Leo Yan <leo.yan@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Ruyi Wang <wangruyi@huawei.com>
Subject: [PATCH RESEND v5 2/3] mailbox: Add support for Hi3660 mailbox
Date: Wed, 14 Feb 2018 11:49:50 +0800
Message-Id: <1518580191-26451-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518580191-26451-1-git-send-email-leo.yan@linaro.org>
References: <1518580191-26451-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Hi3660 mailbox controller is used to send message within multiple
processors, MCU, HIFI, etc.  It supports 32 mailbox channels and every
channel can only be used for single transferring direction.  Once the
channel is enabled, it needs to specify the destination interrupt and
acknowledge interrupt, these two interrupt vectors are used to create
the connection between the mailbox and interrupt controllers.

The data transferring supports two modes, one is named as "automatic
acknowledge" mode so after send message the kernel doesn't need to wait
for acknowledge from remote and directly return; there have another mode
is to rely on handling interrupt for acknowledge.

This commit is for initial version driver, which only supports
"automatic acknowledge" mode to support CPU clock, which is the only
one consumer to use mailbox and has been verified.  Later may enhance
this driver for interrupt mode (e.g. for supporting HIFI).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
---
 drivers/mailbox/Kconfig          |   8 +
 drivers/mailbox/Makefile         |   2 +
 drivers/mailbox/hi3660-mailbox.c | 316 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 326 insertions(+)
 create mode 100644 drivers/mailbox/hi3660-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ba2f152..de8390d4 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -108,6 +108,14 @@ config TI_MESSAGE_MANAGER
 	  multiple processors within the SoC. Select this driver if your
 	  platform has support for the hardware block.
 
+config HI3660_MBOX
+	tristate "Hi3660 Mailbox"
+	depends on ARCH_HISI && OF
+	help
+	  An implementation of the hi3660 mailbox. It is used to send message
+	  between application processors and other processors/MCU/DSP. Select
+	  Y here if you want to use Hi3660 mailbox controller.
+
 config HI6220_MBOX
 	tristate "Hi6220 Mailbox"
 	depends on ARCH_HISI
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 4896f8d..cc23c3a 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_TI_MESSAGE_MANAGER) += ti-msgmgr.o
 
 obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
 
+obj-$(CONFIG_HI3660_MBOX)	+= hi3660-mailbox.o
+
 obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
 
 obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
new file mode 100644
index 0000000..d6b1600
--- /dev/null
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Hisilicon Limited.
+// Copyright (c) 2017 Linaro Limited.
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "mailbox.h"
+
+#define MBOX_CHAN_MAX			32
+
+#define MBOX_RX				0x0
+#define MBOX_TX				0x1
+
+#define MBOX_BASE(mbox, ch)		((mbox)->base + ((ch) * 0x40))
+#define MBOX_SRC_REG			0x00
+#define MBOX_DST_REG			0x04
+#define MBOX_DCLR_REG			0x08
+#define MBOX_DSTAT_REG			0x0c
+#define MBOX_MODE_REG			0x10
+#define MBOX_IMASK_REG			0x14
+#define MBOX_ICLR_REG			0x18
+#define MBOX_SEND_REG			0x1c
+#define MBOX_DATA_REG			0x20
+
+#define MBOX_IPC_LOCK_REG		0xa00
+#define MBOX_IPC_UNLOCK			0x1acce551
+
+#define MBOX_AUTOMATIC_ACK		1
+
+#define MBOX_STATE_IDLE			BIT(4)
+#define MBOX_STATE_ACK			BIT(7)
+
+#define MBOX_MSG_LEN			8
+
+/**
+ * Hi3660 mailbox channel information
+ *
+ * A channel can be used for TX or RX, it can trigger remote
+ * processor interrupt to notify remote processor and can receive
+ * interrupt if has incoming message.
+ *
+ * @dst_irq:	Interrupt vector for remote processor
+ * @ack_irq:	Interrupt vector for local processor
+ */
+struct hi3660_chan_info {
+	unsigned int dst_irq;
+	unsigned int ack_irq;
+};
+
+/**
+ * Hi3660 mailbox controller data
+ *
+ * Mailbox controller includes 32 channels and can allocate
+ * channel for message transferring.
+ *
+ * @dev:	Device to which it is attached
+ * @base:	Base address of the register mapping region
+ * @chan:	Representation of channels in mailbox controller
+ * @mchan:	Representation of channel info
+ * @controller:	Representation of a communication channel controller
+ */
+struct hi3660_mbox {
+	struct device *dev;
+	void __iomem *base;
+	struct mbox_chan chan[MBOX_CHAN_MAX];
+	struct hi3660_chan_info mchan[MBOX_CHAN_MAX];
+	struct mbox_controller controller;
+};
+
+static struct hi3660_mbox *to_hi3660_mbox(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct hi3660_mbox, controller);
+}
+
+static int hi3660_mbox_check_state(struct mbox_chan *chan)
+{
+	unsigned long ch = (unsigned long)chan->con_priv;
+	struct hi3660_mbox *mbox = to_hi3660_mbox(chan->mbox);
+	struct hi3660_chan_info *mchan = &mbox->mchan[ch];
+	void __iomem *base = MBOX_BASE(mbox, ch);
+	unsigned long val;
+	unsigned int state, ret;
+
+	/* Mailbox is idle so directly bail out */
+	state = readl_relaxed(base + MBOX_MODE_REG);
+	if (state & MBOX_STATE_IDLE)
+		return 0;
+
+	/* Wait for acknowledge from remote */
+	ret = readx_poll_timeout_atomic(readl_relaxed, base + MBOX_MODE_REG,
+			val, (val & MBOX_STATE_ACK), 1000, 300000);
+	if (ret) {
+		dev_err(mbox->dev, "%s: timeout for receiving ack\n", __func__);
+		return ret;
+	}
+
+	/* Ensure channel is released */
+	writel_relaxed(0xffffffff, base + MBOX_IMASK_REG);
+	writel_relaxed(BIT(mchan->ack_irq), base + MBOX_SRC_REG);
+	return 0;
+}
+
+static int hi3660_mbox_unlock(struct mbox_chan *chan)
+{
+	struct hi3660_mbox *mbox = to_hi3660_mbox(chan->mbox);
+	unsigned int val, retry = 3;
+
+	do {
+		writel_relaxed(MBOX_IPC_UNLOCK, mbox->base + MBOX_IPC_LOCK_REG);
+
+		val = readl_relaxed(mbox->base + MBOX_IPC_LOCK_REG);
+		if (!val)
+			break;
+
+		udelay(10);
+	} while (retry--);
+
+	if (val)
+		dev_err(mbox->dev, "%s: failed to unlock mailbox\n", __func__);
+
+	return (!val) ? 0 : -ETIMEDOUT;
+}
+
+static int hi3660_mbox_acquire_channel(struct mbox_chan *chan)
+{
+	unsigned long ch = (unsigned long)chan->con_priv;
+	struct hi3660_mbox *mbox = to_hi3660_mbox(chan->mbox);
+	struct hi3660_chan_info *mchan = &mbox->mchan[ch];
+	void __iomem *base = MBOX_BASE(mbox, ch);
+	unsigned int val, retry;
+
+	for (retry = 10; retry; retry--) {
+
+		/* Check if channel is in idle state */
+		if (readl_relaxed(base + MBOX_MODE_REG) & MBOX_STATE_IDLE) {
+
+			val = BIT(mchan->ack_irq);
+			writel_relaxed(val, base + MBOX_SRC_REG);
+			val = readl_relaxed(base + MBOX_SRC_REG);
+
+			/* Check ack bit has been set successfully */
+			if (val & BIT(mchan->ack_irq))
+				break;
+		}
+	}
+
+	if (!retry)
+		dev_err(mbox->dev, "%s: failed to acquire channel\n", __func__);
+
+	return retry ? 0 : -ETIMEDOUT;
+}
+
+static int hi3660_mbox_startup(struct mbox_chan *chan)
+{
+	int ret;
+
+	ret = hi3660_mbox_check_state(chan);
+	if (ret)
+		return ret;
+
+	ret = hi3660_mbox_unlock(chan);
+	if (ret)
+		return ret;
+
+	ret = hi3660_mbox_acquire_channel(chan);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
+{
+	unsigned long ch = (unsigned long)chan->con_priv;
+	struct hi3660_mbox *mbox = to_hi3660_mbox(chan->mbox);
+	struct hi3660_chan_info *mchan = &mbox->mchan[ch];
+	void __iomem *base = MBOX_BASE(mbox, ch);
+	u32 *buf = msg;
+	unsigned int i;
+
+	/* Ensure channel is released */
+	writel_relaxed(0xffffffff, base + MBOX_IMASK_REG);
+	writel_relaxed(BIT(mchan->ack_irq), base + MBOX_SRC_REG);
+
+	/* Clear mask for destination interrupt */
+	writel_relaxed(~BIT(mchan->dst_irq), base + MBOX_IMASK_REG);
+
+	/* Config destination for interrupt vector */
+	writel_relaxed(BIT(mchan->dst_irq), base + MBOX_DST_REG);
+
+	/* Automatic acknowledge mode */
+	writel_relaxed(MBOX_AUTOMATIC_ACK, base + MBOX_MODE_REG);
+
+	/* Fill message data */
+	for (i = 0; i < MBOX_MSG_LEN; i++)
+		writel_relaxed(buf[i], base + MBOX_DATA_REG + i * 4);
+
+	/* Trigger data transferring */
+	writel_relaxed(BIT(mchan->ack_irq), base + MBOX_SEND_REG);
+	return 0;
+}
+
+static struct mbox_chan_ops hi3660_mbox_ops = {
+	.startup	= hi3660_mbox_startup,
+	.send_data	= hi3660_mbox_send_data,
+};
+
+static struct mbox_chan *hi3660_mbox_xlate(struct mbox_controller *controller,
+					   const struct of_phandle_args *spec)
+{
+	struct hi3660_mbox *mbox = to_hi3660_mbox(controller);
+	struct hi3660_chan_info *mchan;
+	unsigned int ch = spec->args[0];
+
+	if (ch >= MBOX_CHAN_MAX) {
+		dev_err(mbox->dev, "Invalid channel idx %d\n", ch);
+		return ERR_PTR(-EINVAL);
+	}
+
+	mchan = &mbox->mchan[ch];
+	mchan->dst_irq = spec->args[1];
+	mchan->ack_irq = spec->args[2];
+
+	return &mbox->chan[ch];
+}
+
+static const struct of_device_id hi3660_mbox_of_match[] = {
+	{ .compatible = "hisilicon,hi3660-mbox", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, hi3660_mbox_of_match);
+
+static int hi3660_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hi3660_mbox *mbox;
+	struct mbox_chan *chan;
+	struct resource *res;
+	unsigned long ch;
+	int err;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mbox->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mbox->base))
+		return PTR_ERR(mbox->base);
+
+	mbox->dev = dev;
+	mbox->controller.dev = dev;
+	mbox->controller.chans = mbox->chan;
+	mbox->controller.num_chans = MBOX_CHAN_MAX;
+	mbox->controller.ops = &hi3660_mbox_ops;
+	mbox->controller.of_xlate = hi3660_mbox_xlate;
+
+	/* Initialize mailbox channel data */
+	chan = mbox->chan;
+	for (ch = 0; ch < MBOX_CHAN_MAX; ch++)
+		chan[ch].con_priv = (void *)ch;
+
+	err = mbox_controller_register(&mbox->controller);
+	if (err) {
+		dev_err(dev, "Failed to register mailbox %d\n", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, mbox);
+	dev_info(dev, "Mailbox enabled\n");
+	return 0;
+}
+
+static int hi3660_mbox_remove(struct platform_device *pdev)
+{
+	struct hi3660_mbox *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&mbox->controller);
+	return 0;
+}
+
+static struct platform_driver hi3660_mbox_driver = {
+	.probe  = hi3660_mbox_probe,
+	.remove = hi3660_mbox_remove,
+	.driver = {
+		.name = "hi3660-mbox",
+		.of_match_table = hi3660_mbox_of_match,
+	},
+};
+
+static int __init hi3660_mbox_init(void)
+{
+	return platform_driver_register(&hi3660_mbox_driver);
+}
+core_initcall(hi3660_mbox_init);
+
+static void __exit hi3660_mbox_exit(void)
+{
+	platform_driver_unregister(&hi3660_mbox_driver);
+}
+module_exit(hi3660_mbox_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hisilicon Hi3660 Mailbox Controller");
+MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
-- 
1.9.1
