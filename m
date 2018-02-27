Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519740586; cv=none;
        d=google.com; s=arc-20160816;
        b=tfbgGgXJvDtzUpqORYF+Sd5uX/fBEhxZ1ZK8V7BJC6ixVF0WgYZeoPRRYvZXu+S8Vk
         wqd1o5IvDbI+U0XkM7CE/5wVtYmgkOzARpkbzF2+ZWxzSYMsWE+RILgW2hQLMvPj+KTX
         7yPUm1fsStn8VLxqHAvFIPseGJXyLlhaYJjkuTknWk56Api4q3O+nJrn9Qgozkw6Qngl
         K0lqmCjcTcvyX8yXk0g1FBUD53OushWbyusAt8pkzeCHU534Iof+uw7WQDQA173XInzC
         yD0aBl/NWWnxMoJfejMJ4saLGONYprwuummoxGNP6lm9h5YRdZiZjMf/DhihEnOb6JWA
         4zIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gc6NNO1syOIXlGo1WCmvPm40tqGPqmW1inEbZr6mIQk=;
        b=ds8y5IAThvA83lAXj5WLd9k1f8qQUpbSa5L1JrR5Cc12eMwZM7RY+ExMd9RCYwYdK8
         GQQBl+0vAbvV9DR9C5fpRZ6FIrEStedyZU/0mJNCKpUaB0Ouv8uGUCtFM0oxnUt60Vax
         iw7SnKfqle3rGa6qIawpzpBCuMlLYcPX4uXvhBhDYnkuHEyob4OAir6//9sqwxjNs98h
         Vckx81Ut4RYKGAUmw2G3KnfCB82h8/5Q7BxjEHidl9KzfIBwT9VXTqWol5Ve2IkW1l1Q
         c0iIgodQuwIhwx9GMXKcffZxi371wG4HkNFTXI5i0bpBRcA/yxZ/mSsLaYhLccKImqVT
         1rrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HDJDhm+A;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HDJDhm+A;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225bE9EwIo9/OVaYeCPDhcfc/yp23yJsoUPL9uM+BsZQumRfgbGPIJYd+UsT+2IYD2822OyGXA==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/3] ARM: mach-stm32: Add Extended TrustZone Protection driver
Date: Tue, 27 Feb 2018 15:09:26 +0100
Message-Id: <20180227140926.22996-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180227140926.22996-1-benjamin.gaignard@st.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563504713995835?=
X-GMAIL-MSGID: =?utf-8?q?1593563504713995835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Before binding a driver Extended TrustZone Protection (ETZPC) driver
checks that the hardware block is accessible to non-secure world.
Hardware blocks split between secure and non-secure is done at early
boot stage so the driver only needs to read the status (2 bits) for each
of the block.

Hardware blocks status bits location in the registers is computed
from device address index in the array.

To avoid to bind a device which will not be accessible ETZPC driver
must be probed early, at least before platform driver, so just after
core initialisation.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/mach-stm32/Kconfig       |   7 ++
 arch/arm/mach-stm32/Makefile      |   1 +
 arch/arm/mach-stm32/stm32-etzpc.c | 252 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 5bc7f5ab61cd..a3ef308642be 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -44,6 +44,13 @@ config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
 	default y
 
+config STM32_ETZPC
+	bool "STM32 Extended TrustZone Protection"
+	depends on MACH_STM32MP157
+	help
+	  Select y to enable STM32 Extended TrustZone Protection
+	  Controller (ETZPC)
+
 endif # ARMv7-A
 
 endif
diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
index bd0b7b5d6e9d..2e1e729a68c9 100644
--- a/arch/arm/mach-stm32/Makefile
+++ b/arch/arm/mach-stm32/Makefile
@@ -1 +1,2 @@
 obj-y += board-dt.o
+obj-$(CONFIG_STM32_ETZPC) += stm32-etzpc.o
diff --git a/arch/arm/mach-stm32/stm32-etzpc.c b/arch/arm/mach-stm32/stm32-etzpc.c
new file mode 100644
index 000000000000..b338d219d5a8
--- /dev/null
+++ b/arch/arm/mach-stm32/stm32-etzpc.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define ETZPC_DECPROT0		0x10
+#define ETZPC_IP_VER		0x3F4
+
+#define IP_VER_MP1		0x00000020
+
+#define DECPROT_MASK		0x03
+#define NB_PROT_PER_REG		0x10
+#define DECPROT_NB_BITS		2
+
+struct stm32_etzpc_cfg {
+	const u32 *addr;
+	const int size;
+	const int version;
+};
+
+struct stm32_etzpc {
+	void __iomem *base;
+	const struct stm32_etzpc_cfg *cfg;
+	struct notifier_block nb;
+};
+
+static inline struct stm32_etzpc *to_stm32_etzpc(struct notifier_block *nb)
+{
+	return container_of(nb, struct stm32_etzpc, nb);
+}
+
+static const u32 stm32mp1_ip_addr[] = {
+	0x5c008000,	/* 00 stgenc */
+	0x54000000,	/* 01 bkpsram */
+	0x5c003000,	/* 02 iwdg1 */
+	0x5c000000,	/* 03 usart1 */
+	0x5c001000,	/* 04 spi6 */
+	0x5c002000,	/* 05 i2c4 */
+	0xffffffff,	/* 06 reserved */
+	0x54003000,	/* 07 rng1 */
+	0x54002000,	/* 08 hash1 */
+	0x54001000,	/* 09 cryp1 */
+	0x5a003000,	/* 0A ddrctrl */
+	0x5a004000,	/* 0B ddrphyc */
+	0x5c009000,	/* 0C i2c6 */
+	0xffffffff,	/* 0D reserved */
+	0xffffffff,	/* 0E reserved */
+	0xffffffff,	/* 0F reserved */
+	0x40000000,	/* 10 tim2 */
+	0x40001000,	/* 11 tim3 */
+	0x40002000,	/* 12 tim4 */
+	0x40003000,	/* 13 tim5 */
+	0x40004000,	/* 14 tim6 */
+	0x40005000,	/* 15 tim7 */
+	0x40006000,	/* 16 tim12 */
+	0x40007000,	/* 17 tim13 */
+	0x40008000,	/* 18 tim14 */
+	0x40009000,	/* 19 lptim1 */
+	0x4000a000,	/* 1A wwdg1 */
+	0x4000b000,	/* 1B spi2 */
+	0x4000c000,	/* 1C spi3 */
+	0x4000d000,	/* 1D spdifrx */
+	0x4000e000,	/* 1E usart2 */
+	0x4000f000,	/* 1F usart3 */
+	0x40010000,	/* 20 uart4 */
+	0x40011000,	/* 21 uart5 */
+	0x40012000,	/* 22 i2c1 */
+	0x40013000,	/* 23 i2c2 */
+	0x40014000,	/* 24 i2c3 */
+	0x40015000,	/* 25 i2c5 */
+	0x40016000,	/* 26 cec */
+	0x40017000,	/* 27 dac */
+	0x40018000,	/* 28 uart7 */
+	0x40019000,	/* 29 uart8 */
+	0xffffffff,	/* 2A reserved */
+	0xffffffff,	/* 2B reserved */
+	0x4001c000,	/* 2C mdios */
+	0xffffffff,	/* 2D reserved */
+	0xffffffff,	/* 2E reserved */
+	0xffffffff,	/* 2F reserved */
+	0x44000000,	/* 30 tim1 */
+	0x44001000,	/* 31 tim8 */
+	0xffffffff,	/* 32 reserved */
+	0x44003000,	/* 33 usart6 */
+	0x44004000,	/* 34 spi1 */
+	0x44005000,	/* 35 spi4 */
+	0x44006000,	/* 36 tim15 */
+	0x44007000,	/* 37 tim16 */
+	0x44008000,	/* 38 tim17 */
+	0x44009000,	/* 39 spi5 */
+	0x4400a000,	/* 3A sai1 */
+	0x4400b000,	/* 3B sai2 */
+	0x4400c000,	/* 3C sai3 */
+	0x4400d000,	/* 3D dfsdm */
+	0x4400e000,	/* 3E tt_fdcan */
+	0xffffffff,	/* 3F reserved */
+	0x50021000,	/* 40 lptim2 */
+	0x50022000,	/* 41 lptim3 */
+	0x50023000,	/* 42 lptim4 */
+	0x50024000,	/* 43 lptim5 */
+	0x50027000,	/* 44 sai4 */
+	0x50025000,	/* 45 vrefbuf */
+	0x4c006000,	/* 46 dcmi */
+	0x4c004000,	/* 47 crc2 */
+	0x48003000,	/* 48 adc */
+	0x4c002000,	/* 49 hash2 */
+	0x4c003000,	/* 4A rng2 */
+	0x4c005000,	/* 4B cryp2 */
+	0xffffffff,	/* 4C reserved */
+	0xffffffff,	/* 4D reserved */
+	0xffffffff,	/* 4E reserved */
+	0xffffffff,	/* 4F reserved */
+	0xffffffff,	/* 50 sram1 */
+	0xffffffff,	/* 51 sram2 */
+	0xffffffff,	/* 52 sram3 */
+	0xffffffff,	/* 53 sram4 */
+	0xffffffff,	/* 54 retram */
+	0x49000000,	/* 55 otg */
+	0x48004000,	/* 56 sdmmc3 */
+	0x48005000,	/* 57 dlybsd3 */
+	0x48000000,	/* 58 dma1 */
+	0x48001000,	/* 59 dma2 */
+	0x48002000,	/* 5A dmamux */
+	0x58002000,	/* 5B fmc */
+	0x58003000,	/* 5C qspi */
+	0x58004000,	/* 5D dlybq */
+	0x5800a000,	/* 5E eth */
+	0xffffffff,	/* 5F reserved */
+};
+
+static const struct stm32_etzpc_cfg stm32_etzpc_mp1_cfg = {
+	.addr = stm32mp1_ip_addr,
+	.size = ARRAY_SIZE(stm32mp1_ip_addr),
+	.version = IP_VER_MP1
+};
+
+static const struct of_device_id stm32_etzpc_of_match[] = {
+	{
+		.compatible = "st,stm32mp1-etzpc",
+		.data = (void *)&stm32_etzpc_mp1_cfg,
+	},
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_etzpc_of_match);
+
+static int stm32_etzpc_notifier_call(struct notifier_block *nb,
+				     unsigned long event, void *data)
+{
+	struct stm32_etzpc *etzpc = to_stm32_etzpc(nb);
+	struct device *dev = data;
+	struct resource res;
+	int i;
+
+	if (event != BUS_NOTIFY_BIND_DRIVER)
+		return NOTIFY_DONE;
+
+	if (of_address_to_resource(dev->of_node, 0, &res))
+		return NOTIFY_DONE;
+
+	for (i = 0; i < etzpc->cfg->size; i++) {
+		if (etzpc->cfg->addr[i] == res.start) {
+			/*
+			 * Each hardware block protection status is defined by
+			 * a 2 bits field and all of them are packed into
+			 * 32 bits registers. Do some computation to get
+			 * register offset and the shift.
+			 */
+			u32 status;
+			int offset = (i / NB_PROT_PER_REG) * sizeof(u32);
+			int shift = (i % NB_PROT_PER_REG) * DECPROT_NB_BITS;
+
+			status = readl(etzpc->base + ETZPC_DECPROT0 + offset);
+			status &= DECPROT_MASK << shift;
+
+			return (status == DECPROT_MASK << shift) ?
+				NOTIFY_DONE : NOTIFY_BAD;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int stm32_etzpc_probe(struct device_node *np,
+			     const struct of_device_id *match)
+{
+	struct stm32_etzpc *etzpc;
+	int version, ret;
+
+	etzpc = kzalloc(sizeof(*etzpc), GFP_KERNEL);
+	if (!etzpc)
+		return -ENOMEM;
+
+	etzpc->base = of_iomap(np, 0);
+	if (IS_ERR(etzpc->base)) {
+		ret = PTR_ERR(etzpc->base);
+		goto failed;
+	}
+
+	etzpc->cfg = (const struct stm32_etzpc_cfg *)match->data;
+
+	version = readl(etzpc->base + ETZPC_IP_VER);
+	if (version != etzpc->cfg->version) {
+		pr_err("Wrong ETZPC version\n");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	etzpc->nb.notifier_call = stm32_etzpc_notifier_call,
+	ret = bus_register_notifier(&platform_bus_type, &etzpc->nb);
+	if (!ret)
+		return 0;
+
+failed:
+	kfree(etzpc);
+	return ret;
+}
+
+/*
+ * stm32_etzpc_init needs to be called before starting to probe
+ * platform drivers to be able to catch all bind notifications
+ * that's why it is tagged as postcore_initcall
+ */
+static int __init stm32_etzpc_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *m;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, stm32_etzpc_of_match, &m);
+
+	if (!np)
+		return -ENODEV;
+
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	ret = stm32_etzpc_probe(np, m);
+
+	of_node_put(np);
+
+	return ret;
+}
+postcore_initcall(stm32_etzpc_init);
-- 
2.15.0
