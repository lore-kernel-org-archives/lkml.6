Return-Path: <joyce.ooi@intel.com>
X-Google-Smtp-Source: AG47ELu/gJ09uk6ljyoM/HY0b0WaHYEPqlPEXCHZibohXKPDpH8MfDuWhSqwmMmqHMY6Og9lziNC
ARC-Seal: i=1; a=rsa-sha256; t=1521026745; cv=none;
        d=google.com; s=arc-20160816;
        b=Uxy+38zFhdWt6WgDFHDj5SWPUDwLoY2v6uBlXvztxGymunI2bVUiGNedEaQa5DfVnr
         +ahTNiLvLfouwbJETSLETfNgEmWfWbiPWDg7YiCfOFQRCERMQ9MV4Y8Xt6DR8vyoWa1W
         2fBgRT67Xs1PRlma7oKGKUnux8JkLdvphMCKPXBqhaBTQCQEomNLdszXwgK/RbBYD8eO
         wQ4Drk/VRTxlWkPdzcCYObF8sTzlGdaA5E9bxToqtbTAphi2obCHJaGYnvtJDGabQ3n6
         mkn1aKBJSFY9K5/DlioMG9bNEM/YJnceS9V5tP00DqtguYkgKZg82LDXPUUOq3UKfixJ
         PPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=BPkcw7/yBYB5F7ZTzk/px1hnL8eQ/bP0viehNZ6eOv8=;
        b=G/Kkg3rBxyjjUoBGnN23jMKDeLtO8LlzYXdJ8Rv26ecPQam6WaGDm7OfYOUDFmbjNH
         ZxBGHMgrbv6b6GqFf69+GsXt//V+S+SQYWk7on7WMj4zFQ5LBTlB9UtVWqTXlOJButC2
         nZ7HatotgO6tEOUuDMeSW5jNpEt17XdGPyFTfBuh/lul+fOOK3Bg/kgmD61xbY3OpGO+
         jFrx4KE6CQMtOy2zqFD6qJiCOJTIOW6V6mo98lGglA55+xa7Zu8DuDiyt2QNcYVN+7L+
         k7Tpn9AdazTopLO2P24aTZQg+76NcteEnR1G0gFUjtign8XUMPwnpSqKbIBLuJkBER6/
         99SA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of joyce.ooi@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=joyce.ooi@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of joyce.ooi@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=joyce.ooi@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="211200958"
From: "Ooi, Joyce" <joyce.ooi@intel.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Ong Hean Loong <hean.loong.ong@intel.com>,
	Yves Vandervennet <yves.vandervennet@intel.com>,
	Joyce Ooi <joyce.ooi@intel.com>
Subject: [PATCH] drivers/misc: Add Intel interrupt latency counter driver
Date: Wed, 14 Mar 2018 19:25:10 +0800
Message-Id: <1521026710-24811-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912140530622370?=
X-GMAIL-MSGID: =?utf-8?q?1594912140530622370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding Intel interrupt latency counter driver support. This driver works
together with the Intel interrupt latency driver soft IP to measure the
time from the interrupt being asserted to the execution of the interrupt
service routine. This driver and soft ip supports for both edge and level
interrupt.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 .../misc/intel-interrupt-latency-counter.txt       |   49 ++++
 drivers/misc/intel_ilc.c                           |  299 ++++++++++++++++++++
 2 files changed, 348 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt
 create mode 100644 drivers/misc/intel_ilc.c

diff --git a/Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt b/Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt
new file mode 100644
index 0000000..9955550
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel-interrupt-latency-counter.txt
@@ -0,0 +1,49 @@
+Intel Interrupt Latency Counter soft IP
+Intel Interrupt Latency Counter IP core driver provides a sysfs interface
+for user to obtain interrupt latency values from Intel Interrupt Latency
+Counter soft IP.
+
+The sysfs interface is located at path,
+/sys/bus/platform/devices/{addr}.ilc/ilc_data/{int_#}
+with
+- {addr}  = the base address of the soft ip
+- {int_#} = the interrupt number
+
+Example use case:
+# cat /sys/bus/platform/devices/c0010000.ilc/ilc_data/40
+
+Required properties:
+- compatible :
+  - "altr,ilc-1.0"
+- reg :
+  - physical base address of the soft ip and length of memory mapped region
+- interrupt-parent :
+  - interrupt source phandle similar to the interrupt source node
+- interrupts :
+  -interrupt number. The interrupt specifier format depends on the interrupt
+   controller parent
+
+Intel specific properties:
+- altr,sw-fifo-depth :
+  - define software fifo depth needed to record latency values
+
+Note:
+- For edge triggered interrupt, the order of loading the ILC driver relative
+ to driver of the actual interrupt source affects the meaning of the ILC
+ values. If the ILC driver is loaded first, then the count values represent
+ the time to the start of the interrupt handler of the of the interrupt source.
+ If the order is switched, then the counts represent the time to finish the
+ interrupt handler for the interrupt source.
+
+- The driver for the interrupt source must be changed to request a shared irq.
+
+Example:
+	interrupt_latency_counter_0: intc@0x10000000 {
+		compatible = "altr,ilc-1.0";
+		reg = <0x10000000 0x00000100>;
+		interrupt-parent = < &interrupt_parent >;
+		interrupts = < 0 1 4 >;
+		altr,sw-fifo-depth = < 32 >;
+	};
+
+
diff --git a/drivers/misc/intel_ilc.c b/drivers/misc/intel_ilc.c
new file mode 100644
index 0000000..fc09bf1
--- /dev/null
+++ b/drivers/misc/intel_ilc.c
@@ -0,0 +1,299 @@
+/*
+ * Copyright (C) 2018 Intel Corporation. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+
+#define DRV_NAME			"intel_ilc"
+#define	CTRL_REG			0x80
+#define FREQ_REG			0x84
+#define	STP_REG				0x88
+#define VLD_REG				0x8C
+#define	ILC_MAX_PORTS		32
+#define ILC_FIFO_DEFAULT	32
+#define ILC_ENABLE			0x01
+#define	CHAR_SIZE			10
+#define POLL_INTERVAL		1
+#define GET_PORT_COUNT(_val)		((_val & 0x7C) >> 2)
+#define GET_VLD_BIT(_val, _offset)	(((_val) >> _offset) & 0x1)
+
+struct intel_ilc {
+	struct platform_device	*pdev;
+	void __iomem			*regs;
+	unsigned int			port_count;
+	unsigned int			irq;
+	unsigned int			channel_offset;
+	unsigned int			interrupt_channels[ILC_MAX_PORTS];
+	struct kfifo			kfifos[ILC_MAX_PORTS];
+	struct device_attribute dev_attr[ILC_MAX_PORTS];
+	struct delayed_work     ilc_work;
+	char					sysfs[ILC_MAX_PORTS][CHAR_SIZE];
+	u32						fifo_depth;
+};
+
+static int ilc_irq_lookup(struct intel_ilc *ilc, int irq)
+{
+	int i;
+	for (i = 0; i < ilc->port_count; i++) {
+		if (irq == platform_get_irq(ilc->pdev, i))
+			return i;
+	}
+	return -EPERM;
+}
+
+static ssize_t ilc_show_counter(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int ret, i, id, fifo_len;
+	unsigned int fifo_buf[ILC_MAX_PORTS];
+	char	temp[10];
+	struct  intel_ilc *ilc = dev_get_drvdata(dev);
+
+	fifo_len = 0;
+	ret = kstrtouint(attr->attr.name, 0, &id);
+
+	for (i = 0; i < ilc->port_count; i++) {
+		if (id == (ilc->interrupt_channels[i])) {
+			/*Check for kfifo length*/
+			fifo_len = kfifo_len(&ilc->kfifos[i])
+				/sizeof(unsigned int);
+			if (fifo_len <= 0) {
+				dev_info(&ilc->pdev->dev, "Fifo for interrupt %s is empty\n",
+					attr->attr.name);
+			return 0;
+			}
+			/*Read from kfifo*/
+			ret = kfifo_out(&ilc->kfifos[i], &fifo_buf,
+				kfifo_len(&ilc->kfifos[i]));
+		}
+	}
+
+	for (i = 0; i < fifo_len; i++) {
+		sprintf(temp, "%u\n", fifo_buf[i]);
+		strcat(buf, temp);
+	}
+
+	strcat(buf, "\0");
+
+	return strlen(buf);
+}
+
+static struct attribute *intel_ilc_attrs[ILC_MAX_PORTS];
+
+struct attribute_group intel_ilc_attr_group = {
+	.name = "ilc_data",
+	.attrs = intel_ilc_attrs,
+};
+
+static void ilc_work(struct work_struct *work)
+{
+	unsigned int ilc_value, ret, offset, stp_reg;
+	struct intel_ilc *ilc =
+		container_of(work, struct intel_ilc, ilc_work.work);
+
+	offset = ilc_irq_lookup(ilc, ilc->irq);
+	if (offset < 0) {
+		dev_err(&ilc->pdev->dev, "Unable to lookup irq number\n");
+		return;
+	}
+
+	if (GET_VLD_BIT(readl(ilc->regs + VLD_REG), offset)) {
+		/*Read counter register*/
+		ilc_value = readl(ilc->regs + (offset) * 4);
+
+		/*Putting value into kfifo*/
+		ret = kfifo_in((&ilc->kfifos[offset]),
+			(unsigned int *)&ilc_value, sizeof(ilc_value));
+
+		/*Clearing stop register*/
+		stp_reg = readl(ilc->regs + STP_REG);
+		writel((!(0x1 << offset))&stp_reg, ilc->regs + STP_REG);
+
+		return;
+	}
+
+	/*Start workqueue to poll data valid*/
+	schedule_delayed_work(&ilc->ilc_work, msecs_to_jiffies(POLL_INTERVAL));
+}
+
+static irqreturn_t ilc_interrupt_handler(int irq, void *p)
+{
+	unsigned int offset, stp_reg;
+
+	struct intel_ilc *ilc = (struct intel_ilc *)p;
+
+	/*Update ILC struct*/
+	ilc->irq = irq;
+
+	dev_dbg(&ilc->pdev->dev, "Interrupt %u triggered\n",
+		ilc->irq);
+
+	offset = ilc_irq_lookup(ilc, irq);
+	if (offset < 0) {
+		dev_err(&ilc->pdev->dev, "Unable to lookup irq number\n");
+		return IRQ_RETVAL(IRQ_NONE);
+	}
+
+	/*Setting stop register*/
+	stp_reg = readl(ilc->regs + STP_REG);
+	writel((0x1 << offset)|stp_reg, ilc->regs + STP_REG);
+
+	/*Start workqueue to poll data valid*/
+	schedule_delayed_work(&ilc->ilc_work, 0);
+
+	return IRQ_RETVAL(IRQ_NONE);
+}
+
+static int intel_ilc_probe(struct platform_device *pdev)
+{
+	struct	intel_ilc	*ilc;
+	struct	resource	*regs;
+	struct	device_node *np = pdev->dev.of_node;
+	int		ret, i;
+
+	ilc = devm_kzalloc(&pdev->dev, sizeof(struct intel_ilc),
+		GFP_KERNEL);
+	if (!ilc)
+		return -ENOMEM;
+
+	ilc->pdev = pdev;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
+	ilc->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (!ilc->regs)
+		return -EADDRNOTAVAIL;
+
+	ilc->port_count = GET_PORT_COUNT(readl(ilc->regs + CTRL_REG));
+	if (ilc->port_count <= 0) {
+		dev_warn(&pdev->dev, "No interrupt connected to ILC\n");
+		return -EPERM;
+	}
+
+	/*Check for fifo depth*/
+	ret = of_property_read_u32(np, "altr,sw-fifo-depth",
+		&(ilc->fifo_depth));
+	if (ret) {
+		dev_warn(&pdev->dev, "Fifo depth undefined\n");
+		dev_warn(&pdev->dev, "Setting fifo depth to default value (32)\n");
+		ilc->fifo_depth = ILC_FIFO_DEFAULT;
+	}
+
+	/*Initialize Kfifo*/
+	for (i = 0; i < ilc->port_count; i++) {
+		ret = kfifo_alloc(&ilc->kfifos[i], (ilc->fifo_depth *
+			sizeof(unsigned int)), GFP_KERNEL);
+		if (ret) {
+			dev_err(&pdev->dev, "Kfifo failed to initialize\n");
+			return ret;
+		}
+	}
+
+	/*Register each of the IRQs*/
+	for (i = 0; i < ilc->port_count; i++) {
+		ilc->interrupt_channels[i] = platform_get_irq(pdev, i);
+
+		ret = devm_request_irq(&pdev->dev, (ilc->interrupt_channels[i]),
+			ilc_interrupt_handler, IRQF_SHARED, "ilc_0",
+			(void *)(ilc));
+
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Failed to register interrupt handler");
+	}
+
+	/*Setup sysfs interface*/
+	for (i = 0; (i < ilc->port_count); i++) {
+		sprintf(ilc->sysfs[i], "%d", (ilc->interrupt_channels[i]));
+		ilc->dev_attr[i].attr.name = ilc->sysfs[i];
+		ilc->dev_attr[i].attr.mode = S_IRUGO;
+		ilc->dev_attr[i].show = ilc_show_counter;
+		intel_ilc_attrs[i] = &ilc->dev_attr[i].attr;
+		intel_ilc_attrs[i + 1] = NULL;
+	}
+	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ilc_attr_group);
+
+	/*Initialize workqueue*/
+	INIT_DELAYED_WORK(&ilc->ilc_work, ilc_work);
+
+	/*Global enable ILC softIP*/
+	writel(ILC_ENABLE, ilc->regs + CTRL_REG);
+
+	platform_set_drvdata(pdev, ilc);
+
+	dev_info(&pdev->dev, "Driver successfully loaded\n");
+
+	return 0;
+}
+
+static int intel_ilc_remove(struct platform_device *pdev)
+{
+	int i;
+	struct intel_ilc *ilc = platform_get_drvdata(pdev);
+
+	/*Remove sysfs interface*/
+	sysfs_remove_group(&pdev->dev.kobj, &intel_ilc_attr_group);
+
+	/*Free up kfifo memory*/
+	for (i = 0; i < ilc->port_count; i++)
+		kfifo_free(&ilc->kfifos[i]);
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static const struct of_device_id intel_ilc_match[] = {
+	{ .compatible = "altr,ilc-1.0" },
+	{ /* Sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, intel_ilc_match);
+
+static struct platform_driver intel_ilc_platform_driver = {
+	.driver = {
+		.name		= DRV_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(intel_ilc_match),
+	},
+	.remove			= intel_ilc_remove,
+};
+
+static int __init intel_ilc_init(void)
+{
+	return platform_driver_probe(&intel_ilc_platform_driver,
+		intel_ilc_probe);
+}
+
+static void __exit intel_ilc_exit(void)
+{
+	platform_driver_unregister(&intel_ilc_platform_driver);
+}
+
+module_init(intel_ilc_init);
+module_exit(intel_ilc_exit);
+
+MODULE_AUTHOR("Chee Nouk Phoon <cnphoon@altera.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Interrupt Latency Counter Driver");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.1
