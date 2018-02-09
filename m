Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBIMH7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:07:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:46031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeBIMHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:07:53 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
Date: Fri,  9 Feb 2018 13:07:29 +0100
Message-Id: <20180209120732.17863-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209120732.17863-1-j.neuschaefer@gmx.net>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:c6NO3Chnnr/pmEI2zRQ2mxjDoyh12y4hvV/kB1q8CGVRcOh4Gnh
 Ym46e6TKo+r2RlsB8bzX9euihF1RZNhfuGqPitIZcQu4vEjQV+h0zcD5BzEhqINSTHCskL5
 AA+WuzIYDTjhRHd9FWvvpDgefLCbFdRwPkg7qn+8qHXLC9Fo9Nx0O4gJXAXaxHDLaFUiIv5
 R1bSAeaA0ZDSWRB92aGfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HiPR79U88+I=:NpvPSRkWRs+p7896pR5zWP
 iAZdYwFJwKPR+QwHdJwSR9yicQjvDTm9qkZ2HN4LNAv0MP70I1j+f3blkMytScPNYDtrT5iqX
 9kTdh7ODLNgf8F3Nsqygx4A69OBFhRFxgcOwGnDbuwK76654P8cXA4AQzTCu/I35By2MVSi4E
 CJustnciLtu7r5dfPcnXvZJ2egQiyeIAAbtwnXG7wmIvzFAXDIVJsmbUKsP3omSFNheaWrK6a
 d9vA4+028r/sUi9k71Ux38gkHssw0U3O+m2l16cgnzLvHIt3j+ZPYfhR/T7fumiJGvP0PfN5v
 trCQErN+1bYqF/yRBLoxnT5EfHQ+d48EH+Id+H/pcm4rcmBMc5k6sO+QBn5O4e0tr0TJrCzbu
 4bfhYBRJiCJXAXbFMQWVkpnMqne41fDovDJFAAk990vohyURsTzw4qGTxBqIwrtXJREH081MS
 1rN5BOaI3m039basV35kUgUwc6DhqDbky7MModCjE82cE0bLK3iOtgaV4LRMIFTD6kmIC5aBQ
 VC+UXvW5UXOfTvpH0Q1FJ3ubCYhLXhijIzqemJD2z/8x0LVhTacPfCavD7Qc8rArZaCJHCFJD
 bcq1i/pXevPBSup5f/TGWk8MOA+UyyAVgMEFiprScGvn41iNAiz+m2BmsQtHveibeSaWKjEvJ
 Gg58KL/8EZoWFXr6osewugsl8axyJrdHDQBPzxN5Nxo1aFI1/6FRfAQo8WJymkSV8X7erpwEO
 KdNAmafwx0RAMlhgG2BvK+eRYlb2BRyQw+v1jqRYQMy9t1WfHgHxMtWONyN2gLsPaJJw9euPP
 1Pge2L6+WzZZV7ws0LZGRgm3VHLQ9WRpXlp3lYl5NEWLO494jk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
that supports a configurable number of pins (up to 32), interrupts, and
some special mechanisms to share the controller between the system's
security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
not supported.

This patch adds a basic driver for this GPIO controller. Interrupt
support will come in a later patch.

This patch is based on code developed by Albert Herranz and the GameCube
Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
has grown quite dissimilar.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: Albert Herranz <albert_herranz@yahoo.es>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
<---

v3:
- Do some style cleanups, as suggest by Andy Shevchenko

v2:
- Change hlwd_gpio_driver.driver.name to "gpio-hlwd" to match the
  filename (was "hlwd_gpio")
- Remove unnecessary include of linux/of_gpio.h, as suggested by Linus
  Walleij.
- Add struct device pointer to context struct to make it possible to use
  dev_info(hlwd->dev, "..."), as suggested by Linus Walleij
- Use the GPIO_GENERIC library to reduce code size, as suggested by
  Linus Walleij
- Use iowrite32be instead of __raw_writel for big-endian MMIO access, as
  suggested by Linus Walleij
- Remove commit message paragraph suggesting to diff against the
  original driver, because it's so different now
---
 drivers/gpio/Kconfig     |   9 ++++
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio-hlwd.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/gpio/gpio-hlwd.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d6a8e851ad13..47606dfe06cc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -229,6 +229,15 @@ config GPIO_GRGPIO
 	  Select this to support Aeroflex Gaisler GRGPIO cores from the GRLIB
 	  VHDL IP core library.
 
+config GPIO_HLWD
+	tristate "Nintendo Wii (Hollywood) GPIO"
+	depends on OF_GPIO
+	select GPIO_GENERIC
+	help
+	  Select this to support the GPIO controller of the Nintendo Wii.
+
+	  If unsure, say N.
+
 config GPIO_ICH
 	tristate "Intel ICH GPIO"
 	depends on PCI && X86
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4bc24febb889..492f62d0eb59 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_GPIO_FTGPIO010)	+= gpio-ftgpio010.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
+obj-$(CONFIG_GPIO_HLWD)		+= gpio-hlwd.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
 obj-$(CONFIG_GPIO_INGENIC)	+= gpio-ingenic.o
diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
new file mode 100644
index 000000000000..a63136a68ba3
--- /dev/null
+++ b/drivers/gpio/gpio-hlwd.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2008-2009 The GameCube Linux Team
+// Copyright (C) 2008,2009 Albert Herranz
+// Copyright (C) 2017-2018 Jonathan Neuschäfer
+//
+// Nintendo Wii (Hollywood) GPIO driver
+
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+
+/*
+ * Register names and offsets courtesy of WiiBrew:
+ * https://wiibrew.org/wiki/Hardware/Hollywood_GPIOs
+ *
+ * Note that for most registers, there are two versions:
+ * - HW_GPIOB_* Is always accessible by the Broadway PowerPC core, but does
+ *   always give access to all GPIO lines
+ * - HW_GPIO_* Is only accessible by the Broadway PowerPC code if the memory
+ *   firewall (AHBPROT) in the Hollywood chipset has been configured to allow
+ *   such access.
+ *
+ * The ownership of each GPIO line can be configured in the HW_GPIO_OWNER
+ * register: A one bit configures the line for access via the HW_GPIOB_*
+ * registers, a zero bit indicates access via HW_GPIO_*. This driver uses
+ * HW_GPIOB_*.
+ */
+#define HW_GPIOB_OUT		0x00
+#define HW_GPIOB_DIR		0x04
+#define HW_GPIOB_IN		0x08
+#define HW_GPIOB_INTLVL		0x0c
+#define HW_GPIOB_INTFLAG	0x10
+#define HW_GPIOB_INTMASK	0x14
+#define HW_GPIOB_INMIR		0x18
+#define HW_GPIO_ENABLE		0x1c
+#define HW_GPIO_OUT		0x20
+#define HW_GPIO_DIR		0x24
+#define HW_GPIO_IN		0x28
+#define HW_GPIO_INTLVL		0x2c
+#define HW_GPIO_INTFLAG		0x30
+#define HW_GPIO_INTMASK		0x34
+#define HW_GPIO_INMIR		0x38
+#define HW_GPIO_OWNER		0x3c
+
+struct hlwd_gpio {
+	struct gpio_chip gpioc;
+	void __iomem *regs;
+};
+
+static int hlwd_gpio_probe(struct platform_device *pdev)
+{
+	struct hlwd_gpio *hlwd;
+	struct resource *regs_resource;
+	u32 ngpios;
+	int res;
+
+	hlwd = devm_kzalloc(&pdev->dev, sizeof(*hlwd), GFP_KERNEL);
+	if (!hlwd)
+		return -ENOMEM;
+
+	regs_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hlwd->regs = devm_ioremap_resource(&pdev->dev, regs_resource);
+	if (IS_ERR(hlwd->regs))
+		return PTR_ERR(hlwd->regs);
+
+	/*
+	 * Claim all GPIOs using the OWNER register. This will not work on
+	 * systems where the AHBPROT memory firewall hasn't been configured to
+	 * permit PPC access to HW_GPIO_*.
+	 *
+	 * Note that this has to happen before bgpio_init reads the
+	 * HW_GPIOB_OUT and HW_GPIOB_DIR, because otherwise it reads the wrong
+	 * values.
+	 */
+	iowrite32be(0xffffffff, hlwd->regs + HW_GPIO_OWNER);
+
+	res = bgpio_init(&hlwd->gpioc, &pdev->dev, 4,
+			hlwd->regs + HW_GPIOB_IN, hlwd->regs + HW_GPIOB_OUT,
+			NULL, hlwd->regs + HW_GPIOB_DIR, NULL,
+			BGPIOF_BIG_ENDIAN_BYTE_ORDER);
+	if (res < 0) {
+		dev_warn(&pdev->dev, "bgpio_init failed: %d\n", res);
+		return res;
+	}
+
+	res = of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios);
+	if (res)
+		ngpios = 32;
+	hlwd->gpioc.ngpio = ngpios;
+
+	return devm_gpiochip_add_data(&pdev->dev, &hlwd->gpioc, hlwd);
+}
+
+static const struct of_device_id hlwd_gpio_match[] = {
+	{ .compatible = "nintendo,hollywood-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hlwd_gpio_match);
+
+static struct platform_driver hlwd_gpio_driver = {
+	.driver	= {
+		.name		= "gpio-hlwd",
+		.of_match_table	= hlwd_gpio_match,
+	},
+	.probe	= hlwd_gpio_probe,
+};
+module_platform_driver(hlwd_gpio_driver);
+
+MODULE_AUTHOR("Jonathan Neuschäfer <j.neuschaefer@gmx.net>");
+MODULE_DESCRIPTION("Nintendo Wii GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.15.1
