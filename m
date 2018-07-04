Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E86C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19882098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19882098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934436AbeGDJPO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:15:14 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34964 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933831AbeGDJPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:15:10 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w649ETaB017182;
        Wed, 4 Jul 2018 12:14:29 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5AFBB6307D; Wed,  4 Jul 2018 12:14:29 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arnd.de,
        gregkh@linuxfoundation.org, avifishman70@gmail.com,
        yuenn@google.com, brendanhiggins@google.com, venture@google.com,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] misc: npcm7xx: add NPCM7xx LPC BPC driver
Date:   Wed,  4 Jul 2018 12:14:27 +0300
Message-Id: <20180704091427.409971-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180704091427.409971-1-tmaimon77@gmail.com>
References: <20180704091427.409971-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM7xx BIOS post code (BPC) driver.

The NPCM7xx BPC monitoring two I/O address written by
the host on the Low Pin Count (LPC) bus, the capure
data stored in 128-word FIFO.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/misc/Kconfig           |   8 +
 drivers/misc/Makefile          |   1 +
 drivers/misc/npcm7xx-lpc-bpc.c | 348 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)
 create mode 100644 drivers/misc/npcm7xx-lpc-bpc.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3726eacdf65d..15d160b06895 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -513,6 +513,14 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
+config NPCM7XX_LPC_BPC
+	tristate "NPCM7xx LPC BIOS Post Code support"
+	depends on (ARCH_NPCM7XX || COMPILE_TEST)
+	help
+	  Provides a NPCM7xx driver to control the LPC BIOS Post Code
+	  interface which allows the BMC to monitoring and save
+	  the data written by the host to an arbitrary LPC I/O port.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index af22bbc3d00c..5bcd540b1950 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-$(CONFIG_NPCM7XX_LPC_BPC)	+= npcm7xx-lpc-bpc.o
diff --git a/drivers/misc/npcm7xx-lpc-bpc.c b/drivers/misc/npcm7xx-lpc-bpc.c
new file mode 100644
index 000000000000..3d8623c5c335
--- /dev/null
+++ b/drivers/misc/npcm7xx-lpc-bpc.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2014-2018 Nuvoton Technology corporation.
+
+#include <linux/fs.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/kfifo.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/miscdevice.h>
+#include <linux/poll.h>
+
+#define DEVICE_NAME	"npcm7xx-lpc-bpc"
+
+#define NUM_BPC_CHANNELS		2
+
+/* BIOS POST Code FIFO Registers */
+#define NPCM7XX_BPCFA2L_REG	0x2 //BIOS POST Code FIFO Address 2 LSB
+#define NPCM7XX_BPCFA2M_REG	0x4 //BIOS POST Code FIFO Address 2 MSB
+#define NPCM7XX_BPCFEN_REG	0x6 //BIOS POST Code FIFO Enable
+#define NPCM7XX_BPCFSTAT_REG	0x8 //BIOS POST Code FIFO Status
+#define NPCM7XX_BPCFDATA_REG	0xA //BIOS POST Code FIFO Data
+#define NPCM7XX_BPCFMSTAT_REG	0xC //BIOS POST Code FIFO Miscellaneous Status
+#define NPCM7XX_BPCFA1L_REG	0x10 //BIOS POST Code FIFO Address 1 LSB
+#define NPCM7XX_BPCFA1M_REG	0x12 //BIOS POST Code FIFO Address 1 MSB
+
+/*BIOS regiser data*/
+#define FIFO_IOADDR1_ENABLE		0x80
+#define FIFO_IOADDR2_ENABLE		0x40
+
+/* BPC interface package and structure definition */
+#define BPC_KFIFO_SIZE			0x400
+
+/*BPC regiser data*/
+#define FIFO_DATA_VALID			0x80
+#define FIFO_OVERFLOW			0x20
+#define FIFO_READY_INT_ENABLE		0x8
+#define FIFO_DWCAPTURE			0x4
+#define FIFO_ADDR_DECODE		0x1
+
+struct npcm7xx_bpc_channel {
+	struct npcm7xx_bpc	*data;
+	struct kfifo		fifo;
+	wait_queue_head_t	wq;
+	struct miscdevice	miscdev;
+};
+
+struct npcm7xx_bpc {
+	void __iomem			*base;
+	int				irq;
+	bool				en_dwcap;
+	struct npcm7xx_bpc_channel	ch[NUM_BPC_CHANNELS];
+};
+
+static struct npcm7xx_bpc_channel *npcm7xx_file_to_ch(struct file *file)
+{
+	return container_of(file->private_data,
+			    struct npcm7xx_bpc_channel,
+			    miscdev);
+}
+
+static ssize_t npcm7xx_bpc_read(struct file *file, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct npcm7xx_bpc_channel *chan = npcm7xx_file_to_ch(file);
+	struct npcm7xx_bpc *lpc_bpc = chan->data;
+	unsigned int copied;
+	int ret = 0;
+	int cond_size = 1;
+
+	if (lpc_bpc->en_dwcap)
+		cond_size = 3;
+
+	if (kfifo_len(&chan->fifo) < cond_size) {
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible
+			(chan->wq, kfifo_len(&chan->fifo) > cond_size);
+		if (ret == -ERESTARTSYS)
+			return -EINTR;
+	}
+
+	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
+
+	return ret ? ret : copied;
+}
+
+static unsigned int npcm7xx_bpc_poll(struct file *file,
+				     struct poll_table_struct *pt)
+{
+	struct npcm7xx_bpc_channel *chan = npcm7xx_file_to_ch(file);
+
+	poll_wait(file, &chan->wq, pt);
+	return !kfifo_is_empty(&chan->fifo) ? POLLIN : 0;
+}
+
+static const struct file_operations npcm7xx_bpc_fops = {
+	.owner		= THIS_MODULE,
+	.read		= npcm7xx_bpc_read,
+	.poll		= npcm7xx_bpc_poll,
+	.llseek		= noop_llseek,
+};
+
+static irqreturn_t npcm7xx_bpc_irq(int irq, void *arg)
+{
+	struct npcm7xx_bpc *lpc_bpc = arg;
+	u8 fifo_st;
+	u8 addr_index = 0;
+	u8 Data;
+	bool isr_flag = false;
+
+	fifo_st = ioread8(lpc_bpc->base + NPCM7XX_BPCFSTAT_REG);
+	while (FIFO_DATA_VALID & fifo_st) {
+		 /* If dwcapture enabled only channel 0 (FIFO 0) used */
+		if (!lpc_bpc->en_dwcap)
+			addr_index = fifo_st & FIFO_ADDR_DECODE;
+
+		/*Read data from FIFO to clear interrupt*/
+		Data = ioread8(lpc_bpc->base + NPCM7XX_BPCFDATA_REG);
+
+		if (kfifo_is_full(&lpc_bpc->ch[addr_index].fifo))
+			kfifo_skip(&lpc_bpc->ch[addr_index].fifo);
+		kfifo_put(&lpc_bpc->ch[addr_index].fifo, Data);
+		wake_up_interruptible(&lpc_bpc->ch[addr_index].wq);
+		if (fifo_st & FIFO_OVERFLOW)
+			pr_info("BIOS Post Codes FIFO Overflow!!!\n");
+
+		fifo_st = ioread8(lpc_bpc->base + NPCM7XX_BPCFSTAT_REG);
+		isr_flag = true;
+	}
+
+	if (isr_flag)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
+static int npcm7xx_bpc_config_irq(struct npcm7xx_bpc *lpc_bpc,
+				  struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	lpc_bpc->irq = platform_get_irq(pdev, 0);
+	if (lpc_bpc->irq < 0) {
+		dev_err(dev, "get IRQ failed\n");
+		return lpc_bpc->irq;
+	}
+
+	rc = devm_request_irq(dev, lpc_bpc->irq,
+			      npcm7xx_bpc_irq, IRQF_SHARED,
+			      DEVICE_NAME, lpc_bpc);
+	if (rc < 0) {
+		dev_warn(dev, "Unable to request IRQ %d\n", lpc_bpc->irq);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int npcm7xx_enable_bpc(struct npcm7xx_bpc *lpc_bpc, struct device *dev,
+			      int channel, u16 lpc_port)
+{
+	int rc;
+	u8 addr_en, reg_en;
+
+	init_waitqueue_head(&lpc_bpc->ch[channel].wq);
+
+	rc = kfifo_alloc(&lpc_bpc->ch[channel].fifo,
+			 BPC_KFIFO_SIZE, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	lpc_bpc->ch[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
+	lpc_bpc->ch[channel].miscdev.name =
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	lpc_bpc->ch[channel].miscdev.fops = &npcm7xx_bpc_fops;
+	lpc_bpc->ch[channel].miscdev.parent = dev;
+	rc = misc_register(&lpc_bpc->ch[channel].miscdev);
+	if (rc)
+		return rc;
+
+	lpc_bpc->ch[channel].data = lpc_bpc;
+
+	/* Enable LPC snoop channel at requested port */
+	switch (channel) {
+	case 0:
+		addr_en = FIFO_IOADDR1_ENABLE;
+		iowrite8((u8)lpc_port & 0xFF,
+			 lpc_bpc->base + NPCM7XX_BPCFA1L_REG);
+		iowrite8((u8)lpc_port >> 8,
+			 lpc_bpc->base + NPCM7XX_BPCFA1M_REG);
+		break;
+	case 1:
+		addr_en = FIFO_IOADDR2_ENABLE;
+		iowrite8((u8)lpc_port & 0xFF,
+			 lpc_bpc->base + NPCM7XX_BPCFA2L_REG);
+		iowrite8((u8)lpc_port >> 8,
+			 lpc_bpc->base + NPCM7XX_BPCFA2M_REG);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lpc_bpc->en_dwcap)
+		addr_en = FIFO_DWCAPTURE;
+
+	/* Enable FIFO Ready Interrupt and FIFO Capture of I/O address */
+	reg_en = ioread8(lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+	iowrite8(reg_en | addr_en | FIFO_READY_INT_ENABLE,
+		 lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+
+	return 0;
+}
+
+static void npcm7xx_disable_bpc(struct npcm7xx_bpc *lpc_bpc, int channel)
+{
+	u8 reg_en;
+
+	switch (channel) {
+	case 0:
+		reg_en = ioread8(lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+		if (lpc_bpc->en_dwcap)
+			iowrite8(reg_en & ~FIFO_DWCAPTURE,
+				 lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+		else
+			iowrite8(reg_en & ~FIFO_IOADDR1_ENABLE,
+				 lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+		break;
+	case 1:
+		reg_en = ioread8(lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+		iowrite8(reg_en & ~FIFO_IOADDR2_ENABLE,
+			 lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+		break;
+	default:
+		return;
+	}
+
+	if (!(reg_en & (FIFO_IOADDR1_ENABLE | FIFO_IOADDR2_ENABLE)))
+		iowrite8(reg_en & ~FIFO_READY_INT_ENABLE,
+			 lpc_bpc->base + NPCM7XX_BPCFEN_REG);
+
+	kfifo_free(&lpc_bpc->ch[channel].fifo);
+	misc_deregister(&lpc_bpc->ch[channel].miscdev);
+}
+
+static int npcm7xx_bpc_probe(struct platform_device *pdev)
+{
+	struct npcm7xx_bpc *lpc_bpc;
+	struct resource *res;
+	struct device *dev;
+	u32 port;
+	int rc;
+
+	dev = &pdev->dev;
+
+	lpc_bpc = devm_kzalloc(dev, sizeof(*lpc_bpc), GFP_KERNEL);
+	if (!lpc_bpc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "BIOS post code reg resource not found\n");
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "BIOS post code base resource is %pR\n", res);
+	lpc_bpc->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(lpc_bpc->base))
+		return PTR_ERR(lpc_bpc->base);
+
+	dev_set_drvdata(&pdev->dev, lpc_bpc);
+
+	rc = of_property_read_u32_index(dev->of_node, "monitor-ports", 0,
+					&port);
+	if (rc) {
+		dev_err(dev, "no monitor ports configured\n");
+		return -ENODEV;
+	}
+
+	lpc_bpc->en_dwcap =
+		of_property_read_bool(dev->of_node, "bpc-en-dwcapture");
+
+	rc = npcm7xx_bpc_config_irq(lpc_bpc, pdev);
+	if (rc)
+		return rc;
+
+	rc = npcm7xx_enable_bpc(lpc_bpc, dev, 0, port);
+	if (rc) {
+		dev_err(dev, "Enable BIOS post code I/O port 0 failed\n");
+		return rc;
+	}
+
+	/*
+	 * Configuration of second BPC channel port is optional
+	 * Double-Word Capture ignoring address 2
+	 */
+	if (!lpc_bpc->en_dwcap) {
+		if (of_property_read_u32_index(dev->of_node, "monitor-ports",
+					       1, &port) == 0) {
+			rc = npcm7xx_enable_bpc(lpc_bpc, dev, 1, port);
+			if (rc) {
+				dev_err(dev, "Enable BIOS post code I/O port 1 failed, disable I/O port 0\n");
+				npcm7xx_disable_bpc(lpc_bpc, 0);
+				return rc;
+			}
+		}
+	}
+
+	pr_info("npcm7xx BIOS post code probe\n");
+
+	return rc;
+}
+
+static int npcm7xx_bpc_remove(struct platform_device *pdev)
+{
+	struct npcm7xx_bpc *lpc_bpc = dev_get_drvdata(&pdev->dev);
+
+	npcm7xx_disable_bpc(lpc_bpc, 0);
+	npcm7xx_disable_bpc(lpc_bpc, 1);
+
+	return 0;
+}
+
+static const struct of_device_id npcm7xx_bpc_match[] = {
+	{ .compatible = "nuvoton,npcm750-lpc-bpc" },
+	{ },
+};
+
+static struct platform_driver npcm7xx_bpc_driver = {
+	.driver = {
+		.name		= DEVICE_NAME,
+		.of_match_table = npcm7xx_bpc_match,
+	},
+	.probe = npcm7xx_bpc_probe,
+	.remove = npcm7xx_bpc_remove,
+};
+
+module_platform_driver(npcm7xx_bpc_driver);
+
+MODULE_DEVICE_TABLE(of, npcm7xx_bpc_match);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_DESCRIPTION("Linux driver to control NPCM7XX LPC BIOS post code monitoring");
-- 
2.14.1

