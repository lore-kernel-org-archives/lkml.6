Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1E4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56342223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqp7+zo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56342223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeKMAVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:21:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34470 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMAVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:21:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so7562118eds.1;
        Mon, 12 Nov 2018 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCU9lfgJ81mLH1AaSoFbMaXtD/p37b40M7N7F56qkZc=;
        b=tqp7+zo8KRsOBC8s/33JkyioagTvvxP6ql09SnTbDcpNEgerQBSn+brBCCDcslHzNW
         Jn2xukoaAHlkgVLcRuxix34feCScA9N3ILZQIAC9zS8aTOPWykXndyThYT/kGi9ErMzx
         KQmZUp1CH4bfG63k1BppeBExVJmdXT+3CxBcGitGF5gppiezpQmanHuLLESHLVV/2XN3
         Lesd5LUeDNUJwsTHekz8xW55djI4igG2jkqAveocrAjyyr32p57pdKITsUGVl9KYrgqy
         VblDbgup6laP8rVYexaV/e382naNqKLTJN/MLmX8hUnoTSoZdmRVaiD54ozuLdZCTcaA
         KN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SCU9lfgJ81mLH1AaSoFbMaXtD/p37b40M7N7F56qkZc=;
        b=XwtL/QGilWlM7uEXoujBDjlNGGjYgqf4EjAnhOsCpj1v575+oXST+Gez0ELwqL+9oG
         QEcDCMkSGhCdWZIJ7IOyuX+8scUTeLbrcK3zGVh6peGyPa3nflWeDJiK0uQJgATqCNjw
         OUCYbtln1POn0UEUTK8Bo0uMic+OlgFIVoD8p/LT2pbxGIWX27CRMHIWvIYzhXux+9Br
         BNO9J+DA7T6XfSL0NXcmcrIupD24ThsZAq8l4xPQ1Mf5P0wDTuyN9P84mXXtepzbAlm6
         iAI4ZJ3JC6Ew62zJs0Mw+KsCcnoKJiQzUP5xZxw9P/8KI3BC4K3IlOXYqal6bykOWn28
         1FPw==
X-Gm-Message-State: AGRZ1gKSj8rHXmulmCqtPwc+5e+ADbzzgXmnqMKQm/C8GalMh5TIeIRU
        nR/XtgY7NtXoNc9ZrsqPNtzWXl7dJfY=
X-Google-Smtp-Source: AJdET5eHgTnWDMn+9v1HLYnv2rYpLsYU7cSvoz0rg/0aGAW6tt3RbWX/GVGLRaQh4aQIsEpJ5XQk8A==
X-Received: by 2002:a17:906:4204:: with SMTP id z4-v6mr9767637ejk.13.1542032877847;
        Mon, 12 Nov 2018 06:27:57 -0800 (PST)
Received: from localhost.localdomain (0189600560.0.fullrate.ninja. [2.110.97.143])
        by smtp.gmail.com with ESMTPSA id h15-v6sm4630253edk.62.2018.11.12.06.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 06:27:56 -0800 (PST)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] spi: add driver for the SiFive SPI controller
Date:   Mon, 12 Nov 2018 15:27:36 +0100
Message-Id: <20181112142736.15009-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

Add driver for the SiFive SPI controller
on the HiFive Unleashed board.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../devicetree/bindings/spi/spi-sifive.txt    |  29 ++
 drivers/spi/Kconfig                           |   6 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-sifive.c                      | 442 ++++++++++++++++++
 4 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
 create mode 100644 drivers/spi/spi-sifive.c

Hi all,

I know the discussions about the sifive devicetree compatible
strings haven't come to a conclusion, so I'm sending this as
an RFC to get some feedback on the rest of the code.

Compared to the original[1] I've done the following:

- Update register names and bit fields to the ones in the
  FU540-C000 documentation.

- Change the optional devicetree property from "sifive,buffer-size"
  to "sifive,fifo-depth". The string "fifo-depth" seems to have more
  hits in the existing devicetree bindings and is IMHO a little more
  descriptive.

- Change the optional devicetree property from "sifive,bits-per-word"
  to "sifive,max-bits-per-word". For a long time I wondered why the
  SPI word size was a property on the controller and not the device.
  This change makes the meaning a little more clear.

- Be honest about only supporting 8bit SPI words in the driver.
  Without SPI_LSB_FIRST and bits_per_word < 8 we need some code
  to shift the bits in each byte which is not yet there.

- Program the csdef, csid and sckmode registers from prepare_message
  rather than transfer_one. This way we only do it once pr. message
  rather than every transfer.

- Drop the irq field from driver data. With devm_request_irq we
  don't need to remember it after requesting the irq.

- Drop hz = t->speed_hz ? t->speed_hz : device->max_speed_hz;
  The SPI framework handles this for us, so we can just always
  use t->speed_hz.

- Fix most checkpatch warnings.

[1]: https://github.com/riscv/riscv-linux/commit/801805694740ad0895e21d10b8f124d138beefbb

/Emil


diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.txt b/Documentation/devicetree/bindings/spi/spi-sifive.txt
new file mode 100644
index 000000000000..96339afcc74f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.txt
@@ -0,0 +1,29 @@
+SiFive SPI controller Device Tree Bindings
+------------------------------------------
+
+Required properties:
+- compatible		: Should be "sifive,spi0"
+- reg			: Physical base address and size of SPI registers map
+			  A second (optional) range can indicate memory mapped flash
+- interrupts		: Must contain one entry
+- interrupt-parent	: Must be core interrupt controller
+- clocks		: Must reference the frequency given to the controller
+- #address-cells	: Must be '1', indicating which CS to use
+- #size-cells		: Must be '0'
+
+Optional properties:
+- sifive,fifo-depth		: Depth of hardware queues; defaults to 8
+- sifive,max-bits-per-word	: Maximum bits per word; defaults to 8
+
+Example:
+	spi: spi@10040000 {
+		compatible = "sifive,spi0";
+		reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
+		interrupt-parent = <&plic>;
+		interrupts = <51>;
+		clocks = <&tlclk>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sifive,fifo-depth = <8>;
+		sifive,max-bits-per-word = <8>;
+	};
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7d3a5c94727e..50bfadd24c32 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -615,6 +615,12 @@ config SPI_SH_HSPI
 	help
 	  SPI driver for SuperH HSPI blocks.
 
+config SPI_SIFIVE
+	tristate "SiFive SPI controller"
+	depends on HAS_IOMEM
+	help
+	  This exposes the SPI controller IP from SiFive.
+
 config SPI_SIRF
 	tristate "CSR SiRFprimaII SPI controller"
 	depends on SIRF_DMA
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3575205c5c27..76216f1861df 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_SPI_SH)			+= spi-sh.o
 obj-$(CONFIG_SPI_SH_HSPI)		+= spi-sh-hspi.o
 obj-$(CONFIG_SPI_SH_MSIOF)		+= spi-sh-msiof.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
+obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
 obj-$(CONFIG_SPI_SIRF)		+= spi-sirf.o
 obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
 obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
new file mode 100644
index 000000000000..8df19d2b8b7f
--- /dev/null
+++ b/drivers/spi/spi-sifive.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive SPI controller driver (master mode only)
+ *
+ * Author: SiFive, Inc.
+ * sifive@sifive.com
+ *
+ * Copyright 2018 SiFive, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+
+/* for consistency we need this symbol */
+#ifdef REG_FMT
+#undef REG_FMT
+#endif
+
+#define SIFIVE_SPI_MAX_CS        32
+
+#define SIFIVE_SPI_NAME          "sifive_spi"
+
+#define SIFIVE_SPI_DEFAULT_DEPTH 8
+#define SIFIVE_SPI_DEFAULT_BITS  8
+
+/* register offsets */
+#define REG_SCKDIV               0x00 /* Serial clock divisor */
+#define REG_SCKMODE              0x04 /* Serial clock mode */
+#define REG_CSID                 0x10 /* Chip select ID */
+#define REG_CSDEF                0x14 /* Chip select default */
+#define REG_CSMODE               0x18 /* Chip select mode */
+#define REG_DELAY0               0x28 /* Delay control 0 */
+#define REG_DELAY1               0x2c /* Delay control 1 */
+#define REG_FMT                  0x40 /* Frame format */
+#define REG_TXDATA               0x48 /* Tx FIFO data */
+#define REG_RXDATA               0x4c /* Rx FIFO data */
+#define REG_TXMARK               0x50 /* Tx FIFO watermark */
+#define REG_RXMARK               0x54 /* Rx FIFO watermark */
+#define REG_FCTRL                0x60 /* SPI flash interface control */
+#define REG_FFMT                 0x64 /* SPI flash instruction format */
+#define REG_IE                   0x70 /* Interrupt Enable Register */
+#define REG_IP                   0x74 /* Interrupt Pendings Register */
+
+/* sckdiv bits */
+#define SCKDIV_DIV_MASK          0xfffU
+
+/* sckmode bits */
+#define SCKMODE_PHA              (1U << 0)
+#define SCKMODE_POL              (1U << 1)
+#define SCKMODE_MODE_MASK        (SCKMODE_PHA | SCKMODE_POL)
+
+/* csmode bits */
+#define CSMODE_MODE_AUTO         0U
+#define CSMODE_MODE_HOLD         2U
+#define CSMODE_MODE_OFF          3U
+
+/* delay0 bits */
+#define DELAY0_CSSCK_MASK        0xffU
+#define DELAY0_SCKCS_MASK        (0xffU << 16)
+
+/* delay1 bits */
+#define DELAY1_INTERCS_MASK      0xffU
+#define DELAY1_INTERXFR_MASK     (0xffU << 16)
+
+/* fmt bits */
+#define FMT_PROTO_SINGLE         0U
+#define FMT_PROTO_DUAL           1U
+#define FMT_PROTO_QUAD           2U
+#define FMT_PROTO_MASK           3U
+#define FMT_ENDIAN               (1U << 2)
+#define FMT_DIR                  (1U << 3)
+#define FMT_LEN(x)               ((u32)(x) << 16)
+#define FMT_LEN_MASK             (0xfU << 16)
+
+/* txdata bits */
+#define TXDATA_DATA_MASK         0xffU
+#define TXDATA_FULL              (1U << 31)
+
+/* rxdata bits */
+#define RXDATA_DATA_MASK         0xffU
+#define RXDATA_EMPTY             (1U << 31)
+
+/* ie and ip bits */
+#define IP_TXWM                  (1U << 0)
+#define IP_RXWM                  (1U << 1)
+
+struct sifive_spi {
+	void __iomem      *regs;        /* virt. address of control registers */
+	struct clk        *clk;         /* bus clock */
+	unsigned int      fifo_depth;   /* fifo depth in words */
+	u32               cs_inactive;  /* level of the CS pins when inactive */
+	struct completion done;         /* wake-up from interrupt */
+};
+
+static void sifive_spi_write(struct sifive_spi *spi, int offset, u32 value)
+{
+	iowrite32(value, spi->regs + offset);
+}
+
+static u32 sifive_spi_read(struct sifive_spi *spi, int offset)
+{
+	return ioread32(spi->regs + offset);
+}
+
+static void sifive_spi_init(struct sifive_spi *spi)
+{
+	/* Watermark interrupts are disabled by default */
+	sifive_spi_write(spi, REG_IE, 0);
+
+	/* Default watermark FIFO threshold values */
+	sifive_spi_write(spi, REG_TXMARK, 1);
+	sifive_spi_write(spi, REG_RXMARK, 0);
+
+	/* Set CS/SCK Delays and Inactive Time to defaults */
+
+	/* Exit specialized memory-mapped SPI flash mode */
+	sifive_spi_write(spi, REG_FCTRL, 0);
+}
+
+static int sifive_spi_prepare_message(struct spi_master *master,
+		struct spi_message *msg)
+{
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+	struct spi_device *device = msg->spi;
+
+	/* Update the chip select polarity */
+	if (device->mode & SPI_CS_HIGH)
+		spi->cs_inactive &= ~BIT(device->chip_select);
+	else
+		spi->cs_inactive |= BIT(device->chip_select);
+	sifive_spi_write(spi, REG_CSDEF, spi->cs_inactive);
+
+	/* Select the correct device */
+	sifive_spi_write(spi, REG_CSID, device->chip_select);
+
+	/* Set clock mode */
+	sifive_spi_write(spi, REG_SCKMODE, device->mode & SCKMODE_MODE_MASK);
+
+	return 0;
+}
+
+static int sifive_spi_prep_transfer(struct sifive_spi *spi,
+		struct spi_device *device, struct spi_transfer *t)
+{
+	u32 cr;
+	unsigned int mode;
+
+	/* Calculate and program the clock rate */
+	cr = DIV_ROUND_UP(clk_get_rate(spi->clk) >> 1, t->speed_hz) - 1;
+	cr &= SCKDIV_DIV_MASK;
+	sifive_spi_write(spi, REG_SCKDIV, cr);
+
+	mode = max_t(unsigned int, t->rx_nbits, t->tx_nbits);
+
+	/* Set frame format */
+	cr = FMT_LEN(t->bits_per_word);
+	switch (mode) {
+	case SPI_NBITS_QUAD:
+		cr |= FMT_PROTO_QUAD;
+		break;
+	case SPI_NBITS_DUAL:
+		cr |= FMT_PROTO_DUAL;
+		break;
+	default:
+		cr |= FMT_PROTO_SINGLE;
+		break;
+	}
+	if (device->mode & SPI_LSB_FIRST)
+		cr |= FMT_ENDIAN;
+	if (!t->rx_buf)
+		cr |= FMT_DIR;
+	sifive_spi_write(spi, REG_FMT, cr);
+
+	/* We will want to poll if the time we need to wait is
+	 * less than the context switching time.
+	 * Let's call that threshold 5us. The operation will take:
+	 *    (8/mode) * fifo_depth / hz <= 5 * 10^-6
+	 *    1600000 * fifo_depth <= hz * mode
+	 */
+	return 1600000 * spi->fifo_depth <= t->speed_hz * mode;
+}
+
+static void sifive_spi_tx(struct sifive_spi *spi, const u8 *tx_ptr)
+{
+	WARN_ON_ONCE((sifive_spi_read(spi, REG_TXDATA) & TXDATA_FULL) != 0);
+	sifive_spi_write(spi, REG_TXDATA, *tx_ptr & TXDATA_DATA_MASK);
+}
+
+static void sifive_spi_rx(struct sifive_spi *spi, u8 *rx_ptr)
+{
+	u32 data = sifive_spi_read(spi, REG_RXDATA);
+
+	WARN_ON_ONCE((data & RXDATA_EMPTY) != 0);
+	*rx_ptr = data & RXDATA_DATA_MASK;
+}
+
+static void sifive_spi_wait(struct sifive_spi *spi, u32 bit, int poll)
+{
+	if (poll) {
+		u32 cr;
+		do cr = sifive_spi_read(spi, REG_IP);
+		while (!(cr & bit));
+	} else {
+		reinit_completion(&spi->done);
+		sifive_spi_write(spi, REG_IE, bit);
+		wait_for_completion(&spi->done);
+	}
+}
+
+static void sifive_spi_execute(struct sifive_spi *spi,
+		struct spi_transfer *t, int poll)
+{
+	const u8 *tx_ptr = t->tx_buf;
+	u8 *rx_ptr = t->rx_buf;
+	unsigned int remaining_words = t->len;
+
+	while (remaining_words) {
+		unsigned int n_words = min(remaining_words, spi->fifo_depth);
+		unsigned int i;
+
+		/* Enqueue n_words for transmission */
+		for (i = 0; i < n_words; i++)
+			sifive_spi_tx(spi, tx_ptr++);
+
+		if (rx_ptr) {
+			/* Wait for transmission + reception to complete */
+			sifive_spi_write(spi, REG_RXMARK, n_words-1);
+			sifive_spi_wait(spi, IP_RXWM, poll);
+
+			/* Read out all the data from the RX FIFO */
+			for (i = 0; i < n_words; i++)
+				sifive_spi_rx(spi, rx_ptr++);
+		} else {
+			/* Wait for transmission to complete */
+			sifive_spi_wait(spi, IP_TXWM, poll);
+		}
+
+		remaining_words -= n_words;
+	}
+}
+
+static int sifive_spi_transfer_one(struct spi_master *master,
+		struct spi_device *device, struct spi_transfer *t)
+{
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+	int poll = sifive_spi_prep_transfer(spi, device, t);
+
+	sifive_spi_execute(spi, t, poll);
+
+	return 0;
+}
+
+static void sifive_spi_set_cs(struct spi_device *device, bool is_high)
+{
+	struct sifive_spi *spi = spi_master_get_devdata(device->master);
+
+	/* Reverse polarity is handled by SCMR/CPOL. Not inverted CS. */
+	if (device->mode & SPI_CS_HIGH)
+		is_high = !is_high;
+
+	sifive_spi_write(spi, REG_CSMODE,
+			is_high ? CSMODE_MODE_AUTO : CSMODE_MODE_HOLD);
+}
+
+static irqreturn_t sifive_spi_irq(int irq, void *dev_id)
+{
+	struct sifive_spi *spi = dev_id;
+	u32 ip = sifive_spi_read(spi, REG_IP);
+
+	if (ip & (IP_TXWM | IP_RXWM)) {
+		/* Disable interrupts until next transfer */
+		sifive_spi_write(spi, REG_IE, 0);
+		complete(&spi->done);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int sifive_spi_probe(struct platform_device *pdev)
+{
+	struct sifive_spi *spi;
+	struct resource *res;
+	int ret, irq, num_cs;
+	u32 cs_bits, max_bits_per_word;
+	struct spi_master *master;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct sifive_spi));
+	if (!master) {
+		dev_err(&pdev->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	spi = spi_master_get_devdata(master);
+	init_completion(&spi->done);
+	platform_set_drvdata(pdev, master);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	spi->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spi->regs)) {
+		dev_err(&pdev->dev, "Unable to map IO resources\n");
+		ret = PTR_ERR(spi->regs);
+		goto put_master;
+	}
+
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(spi->clk)) {
+		dev_err(&pdev->dev, "Unable to find bus clock\n");
+		ret = PTR_ERR(spi->clk);
+		goto put_master;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Unable to find interrupt\n");
+		ret = irq;
+		goto put_master;
+	}
+
+	/* Optional parameters */
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sifive,fifo-depth", &spi->fifo_depth);
+	if (ret < 0)
+		spi->fifo_depth = SIFIVE_SPI_DEFAULT_DEPTH;
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sifive,max-bits-per-word", &max_bits_per_word);
+	if (!ret && max_bits_per_word < 8) {
+		dev_err(&pdev->dev, "Only 8bit SPI words are supported by the driver\n");
+		ret = -EINVAL;
+		goto put_master;
+	}
+
+	/* Spin up the bus clock before hitting registers */
+	ret = clk_prepare_enable(spi->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable bus clock\n");
+		goto put_master;
+	}
+
+	/* probe the number of CS lines */
+	spi->cs_inactive = sifive_spi_read(spi, REG_CSDEF);
+	sifive_spi_write(spi, REG_CSDEF, 0xffffffffU);
+	cs_bits = sifive_spi_read(spi, REG_CSDEF);
+	sifive_spi_write(spi, REG_CSDEF, spi->cs_inactive);
+	if (!cs_bits) {
+		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
+		ret = -EINVAL;
+		goto put_master;
+	}
+
+	num_cs = ilog2(cs_bits) + 1;
+	if (num_cs > SIFIVE_SPI_MAX_CS) {
+		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
+		ret = -EINVAL;
+		goto put_master;
+	}
+
+	/* Define our master */
+	master->dev.of_node = pdev->dev.of_node;
+	master->bus_num = pdev->id;
+	master->num_chipselect = num_cs;
+	master->mode_bits = SPI_CPHA | SPI_CPOL
+	                  | SPI_CS_HIGH | SPI_LSB_FIRST
+	                  | SPI_TX_DUAL | SPI_TX_QUAD
+	                  | SPI_RX_DUAL | SPI_RX_QUAD;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->flags = SPI_CONTROLLER_MUST_TX | SPI_MASTER_GPIO_SS;
+	master->prepare_message = sifive_spi_prepare_message;
+	master->set_cs = sifive_spi_set_cs;
+	master->transfer_one = sifive_spi_transfer_one;
+
+	/* If mmc_spi sees a dma_mask, it starts using dma mapped buffers.
+	 * Probably it should rely on the SPI core auto mapping instead.
+	 */
+	pdev->dev.dma_mask = NULL;
+
+	/* Configure the SPI master hardware */
+	sifive_spi_init(spi);
+
+	/* Register for SPI Interrupt */
+	ret = devm_request_irq(&pdev->dev, irq, sifive_spi_irq, 0,
+				dev_name(&pdev->dev), spi);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
+		goto put_master;
+	}
+
+	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
+		irq, master->num_chipselect);
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_master failed\n");
+		goto put_master;
+	}
+
+	return 0;
+
+put_master:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int sifive_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+
+	/* Disable all the interrupts just in case */
+	sifive_spi_write(spi, REG_IE, 0);
+	spi_master_put(master);
+
+	return 0;
+}
+
+static const struct of_device_id sifive_spi_of_match[] = {
+	{ .compatible = "sifive,spi0", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sifive_spi_of_match);
+
+static struct platform_driver sifive_spi_driver = {
+	.probe = sifive_spi_probe,
+	.remove = sifive_spi_remove,
+	.driver = {
+		.name = SIFIVE_SPI_NAME,
+		.of_match_table = sifive_spi_of_match,
+	},
+};
+module_platform_driver(sifive_spi_driver);
+
+MODULE_AUTHOR("SiFive, Inc. <sifive@sifive.com>");
+MODULE_DESCRIPTION("SiFive SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.19.1

