Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934039AbeE1UnK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:43:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932451AbeE1UnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:43:05 -0400
From: Samarth Parikh <samarth.parikh@arm.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, Sudipto.Paul@arm.com,
        Arvind.Chauhan@arm.com, Deepak.Pandey@arm.com, samarthp@ymail.com,
        Sudeep.Holla@arm.com, Samarth Parikh <samarth.parikh@arm.com>
Subject: [PATCH v3] mailbox: arm_mhu: add support for mhuv2
Date: Tue, 29 May 2018 02:12:34 +0530
Message-Id: <1527540154-25179-1-git-send-email-samarth.parikh@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM has launched a next version of MHU i.e. MHUv2 with its latest
subsystems. The main change is that the MHUv2 is now a distributed IP
with different peripheral views (registers) for the sender and receiver.
Also, the peripheral views (registers) for Secure & Non-Secure have been
separated out into two different register map where there is only one
Secure channel but two Non-Secure channels viz. High Priority & Low
Priority. The Specification doesn't limit the number of channels that a
Secure/Non-Secure register map can host but for now it has been limited
to 1 channel for Secure & 2 for Non-Secure.

Another difference is that MHUv1 duplex channels are now split into
simplex/half duplex in MHUv2. MHUv2 has a configurable number of
communication channels. There is a capability register (MSG_NO_CAP) to
find out how many channels are available in a system for a specific
register map (secure/non-secure).

The register offsets have also changed for STAT, SET & CLEAR registers
from 0x0, 0x8 & 0x10 in MHUv1 to 0x0, 0xC & 0x8 in MHUv2 respectively.

0x0    0x4  0x8  0xC             0x1F
------------------------....-----
| STAT |    |    | SET |    |   |
------------------------....-----
      Transmit Channel

0x0    0x4  0x8   0xC            0x1F
------------------------....-----
| STAT |    | CLR |    |    |   |
------------------------....-----
        Receive Channel

The MHU controller can request the receiver to wake-up and once the
request is removed, the receiver may go back to sleep, but the MHU
itself does not actively puts a receiver to sleep.

So, in order to wake-up the receiver when the sender wants to send data,
the sender has to set ACCESS_REQUEST register first in order to wake-up
receiver, state of which can be detected using ACCESS_READY register.
ACCESS_REQUEST has an offset of 0xF88 & ACCESS_READY has an offset
of 0xF8C and are accessible only on any sender channel.

This patch adds necessary changes in a new file required to support the
latest MHUv2 controller. This patch also need an update in DT binding for
ARM MHUv2 as we need a second register base (tx base) which would be used
as the send channel base.

Signed-off-by: Samarth Parikh <samarth.parikh@arm.com>
---
 .../devicetree/bindings/mailbox/arm-mhu.txt        |  35 +++-
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu_v2.c                       | 219 +++++++++++++++++++++
 4 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mailbox/arm_mhu_v2.c

diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
index 4971f03..1633535 100644
--- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
+++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
@@ -3,13 +3,25 @@ ARM MHU Mailbox Driver
 
 The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
 3 independent channels/links to communicate with remote processor(s).
- MHU links are hardwired on a platform. A link raises interrupt for any
+MHU links are hardwired on a platform. A link raises interrupt for any
 received data. However, there is no specified way of knowing if the sent
 data has been read by the remote. This driver assumes the sender polls
 STAT register and the remote clears it after having read the data.
 The last channel is specified to be a 'Secure' resource, hence can't be
 used by Linux running NS.
 
+The latest MHUv2 is now a distributed IP with different peripheral views
+(registers) for the sender and receiver. Also, the peripheral views
+(registers) for Secure & Non-Secure have been separated out into two
+different register map where there is only one Secure channel but two
+Non-Secure channels viz. High Priority & Low Priority.
+
+Another difference is that MHUv1 duplex channels are now split into
+simplex/half duplex in MHUv2. MHUv2 has a configurable number of
+communication channels. There is a capability register (MSG_NO_CAP) to
+find out how many channels are available in a system for a specific
+register map (secure/non-secure).
+
 Mailbox Device Node:
 ====================
 
@@ -18,6 +30,10 @@ Required properties:
 - compatible:		Shall be "arm,mhu" & "arm,primecell"
 - reg:			Contains the mailbox register address range (base
 			address and length)
+			Shall have two set of register address range in
+			which case, the first one will be receive base
+			& second will be transmit base. (transmit base is
+			required for MHUv2)
 - #mbox-cells		Shall be 1 - the index of the channel needed.
 - interrupts:		Contains the interrupt information corresponding to
 			each of the 3 links of MHU.
@@ -25,6 +41,8 @@ Required properties:
 Example:
 --------
 
+1. Older controller which doesn't have different transmit & receive channel
+
 	mhu: mailbox@2b1f0000 {
 		#mbox-cells = <1>;
 		compatible = "arm,mhu", "arm,primecell";
@@ -41,3 +59,18 @@ Example:
 		reg = <0 0x2e000000 0x4000>;
 		mboxes = <&mhu 1>; /* HP-NonSecure */
 	};
+
+2. Latest MHUv2 controller which have different transmit & receive channel
+
+        mhuv2: mailbox@2b1c0000 {
+                #mbox-cells = <1>;
+                compatible = "arm,mhu", "arm,primecell";
+                reg = <0x0 0x2b1c0000 0x0 0x1000>,
+                      <0x0 0x2b1d0000 0x0 0x1000>;
+                interrupts = <0 36 4>, /* LP-NonSecure */
+                             <0 35 4>; /* HP-NonSecure */
+                interrupt-names = "mhu_lpri_rx",
+                                  "mhu_hpri_rx";
+                clocks = <&clock 0 2 1>;
+                clock-names = "apb_pclk";
+        };
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index a2bb274..416bc78 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -15,6 +15,15 @@ config ARM_MHU
 	  The controller has 3 mailbox channels, the last of which can be
 	  used in Secure mode only.
 
+config ARM_MHU_V2
+	tristate "ARM MHUv2 Mailbox"
+	depends on ARM_AMBA
+	help
+	  Say Y here if you want to build the ARM MHUv2 controller driver.
+	  The controller is a distributed IP with different peripheral
+	  views (registers) for the sender and receiver & has 3 mailbox
+	  channels, the last of which can be used in Secure mode only.
+
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index cc23c3a..ae899a9 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
 
 obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
 
+obj-$(CONFIG_ARM_MHU_V2)	+= arm_mhu_v2.o
+
 obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
 
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
diff --git a/drivers/mailbox/arm_mhu_v2.c b/drivers/mailbox/arm_mhu_v2.c
new file mode 100644
index 0000000..8d1726c
--- /dev/null
+++ b/drivers/mailbox/arm_mhu_v2.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 ARM Ltd.
+ * Author: Samarth Parikh <samarth.parikh@arm.com>
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/amba/bus.h>
+#include <linux/mailbox_controller.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+
+#define MHU_V2_REG_STAT_OFS		0x0
+#define MHU_V2_REG_CLR_OFS		0x8
+#define MHU_V2_REG_SET_OFS		0xC
+#define MHU_V2_REG_MSG_NO_CAP_OFS	0xF80
+#define MHU_V2_REG_ACC_REQ_OFS		0xF88
+#define MHU_V2_REG_ACC_RDY_OFS		0xF8C
+
+#define MHU_V2_LP_OFFSET		0x20
+#define MHU_V2_HP_OFFSET		0x0
+#define MHU_V2_CHANS			2
+
+#define mbox_to_arm_mhuv2(c) container_of(c, struct arm_mhuv2, mbox)
+
+struct mhuv2_link {
+	unsigned int irq;
+	void __iomem *tx_reg;
+	void __iomem *rx_reg;
+};
+
+struct arm_mhuv2 {
+	void __iomem *base;
+	struct mhuv2_link mlink[MHU_V2_CHANS];
+	struct mbox_chan chan[MHU_V2_CHANS];
+	struct mbox_controller mbox;
+};
+
+static irqreturn_t mhuv2_rx_interrupt(int irq, void *p)
+{
+	struct mbox_chan *chan = p;
+	struct mhuv2_link *mlink = chan->con_priv;
+	u32 val;
+
+	val = readl_relaxed(mlink->rx_reg + MHU_V2_REG_STAT_OFS);
+	if (!val)
+		return IRQ_NONE;
+
+	mbox_chan_received_data(chan, (void *)&val);
+
+	writel_relaxed(val, mlink->rx_reg + MHU_V2_REG_CLR_OFS);
+
+	return IRQ_HANDLED;
+}
+
+static bool mhuv2_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhuv2_link *mlink = chan->con_priv;
+	u32 val = readl_relaxed(mlink->tx_reg + MHU_V2_REG_STAT_OFS);
+
+	return (val == 0);
+}
+
+static int mhuv2_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mhuv2_link *mlink = chan->con_priv;
+	u32 *arg = data;
+
+	writel_relaxed(*arg, mlink->tx_reg + MHU_V2_REG_SET_OFS);
+
+	return 0;
+}
+
+static int mhuv2_startup(struct mbox_chan *chan)
+{
+	struct mhuv2_link *mlink = chan->con_priv;
+	u32 val;
+	int ret;
+	struct arm_mhuv2 *mhuv2 = mbox_to_arm_mhuv2(chan->mbox);
+
+	writel_relaxed(0x1, mhuv2->base + MHU_V2_REG_ACC_REQ_OFS);
+
+	val = readl_relaxed(mlink->tx_reg + MHU_V2_REG_STAT_OFS);
+	writel_relaxed(val, mlink->tx_reg + MHU_V2_REG_CLR_OFS);
+
+	ret = request_irq(mlink->irq, mhuv2_rx_interrupt,
+			  IRQF_SHARED, "mhuv2_link", chan);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"unable to acquire IRQ %d\n", mlink->irq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mhuv2_shutdown(struct mbox_chan *chan)
+{
+	struct mhuv2_link *mlink = chan->con_priv;
+	struct arm_mhuv2 *mhuv2 = mbox_to_arm_mhuv2(chan->mbox);
+
+	writel_relaxed(0x0, mhuv2->base + MHU_V2_REG_ACC_REQ_OFS);
+
+	free_irq(mlink->irq, chan);
+}
+
+static const struct mbox_chan_ops mhuv2_ops = {
+	.send_data = mhuv2_send_data,
+	.startup = mhuv2_startup,
+	.shutdown = mhuv2_shutdown,
+	.last_tx_done = mhuv2_last_tx_done,
+};
+
+static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int i, err;
+	struct arm_mhuv2 *mhuv2;
+	struct device *dev = &adev->dev;
+	void __iomem *rx_base, *tx_base;
+	const struct device_node *np = dev->of_node;
+	unsigned int pchans;
+	int mhuv2_reg[MHU_V2_CHANS] = {MHU_V2_LP_OFFSET, MHU_V2_HP_OFFSET};
+
+	/* Allocate memory for device */
+	mhuv2 = devm_kzalloc(dev, sizeof(*mhuv2), GFP_KERNEL);
+	if (!mhuv2)
+		return -ENOMEM;
+
+	rx_base = of_iomap((struct device_node *)np, 0);
+	if (!rx_base) {
+		dev_err(dev, "failed to map rx registers\n");
+		return -ENOMEM;
+	}
+
+	tx_base = of_iomap((struct device_node *)np, 1);
+	if (!tx_base) {
+		dev_err(dev, "failed to map tx registers\n");
+		iounmap(rx_base);
+		return -ENOMEM;
+	}
+
+	pchans = readl_relaxed(tx_base + MHU_V2_REG_MSG_NO_CAP_OFS);
+	if (pchans == 0 || pchans > MHU_V2_CHANS) {
+		dev_err(dev, "invalid number of channels %d\n", pchans);
+		iounmap(rx_base);
+		iounmap(tx_base);
+		return -EINVAL;
+	}
+	for (i = 0; i < pchans; i++) {
+		mhuv2->chan[i].con_priv = &mhuv2->mlink[i];
+		mhuv2->mlink[i].irq = adev->irq[i];
+		mhuv2->mlink[i].rx_reg = rx_base + mhuv2_reg[i];
+		mhuv2->mlink[i].tx_reg = tx_base + mhuv2_reg[i];
+	}
+
+	mhuv2->base = tx_base;
+	mhuv2->mbox.dev = dev;
+	mhuv2->mbox.chans = &mhuv2->chan[0];
+	mhuv2->mbox.num_chans = pchans;
+	mhuv2->mbox.ops = &mhuv2_ops;
+	mhuv2->mbox.txdone_irq = false;
+	mhuv2->mbox.txdone_poll = true;
+	mhuv2->mbox.txpoll_period = 1;
+
+	amba_set_drvdata(adev, mhuv2);
+
+	err = mbox_controller_register(&mhuv2->mbox);
+	if (err) {
+		dev_err(dev, "failed to register mailboxes %d\n", err);
+		iounmap(rx_base);
+		iounmap(tx_base);
+		return err;
+	}
+
+	dev_info(dev, "ARM MHUv2 Mailbox driver registered\n");
+	return 0;
+}
+
+static int mhuv2_remove(struct amba_device *adev)
+{
+	struct arm_mhuv2 *mhuv2 = amba_get_drvdata(adev);
+
+	mbox_controller_unregister(&mhuv2->mbox);
+
+	return 0;
+}
+
+static struct amba_id mhuv2_ids[] = {
+	{
+		.id     = 0x4b0d1,
+		.mask   = 0xfffff,
+	},
+	{
+		.id     = 0xbb0d1,
+		.mask   = 0xfffff,
+	},
+	{ 0, 0 },
+};
+MODULE_DEVICE_TABLE(amba, mhuv2_ids);
+
+static struct amba_driver arm_mhuv2_driver = {
+	.drv = {
+		.name	= "mhuv2",
+	},
+	.id_table	= mhuv2_ids,
+	.probe		= mhuv2_probe,
+	.remove		= mhuv2_remove,
+};
+module_amba_driver(arm_mhuv2_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ARM MHUv2 Driver");
+MODULE_AUTHOR("Samarth Parikh <samarthp@ymail.com>");
-- 
2.7.4
