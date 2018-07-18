Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0269AECDFBC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C7E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QtEiuqPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C7E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeGRNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:04:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeGRNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hRW0eRTOtm2mXZvm6NPc7uVpi/IeMqREjYn+YQqTDpo=; b=QtEiuqPsNfnd
        GaT8E7Rs0f44bODV5iPHZlO4OTVG6+isIlMmc9oVjGs8SY9uOZAN8BjqXrZ7+q/5HTzGiP+pIFAtv
        WJ0JY77K+tzbt7WYRCVq/E0Zfw+92qT1CQsBr+GGRcNr9ipLSik4RIWeuV4WbunWK128w4D5IaXMj
        5QsX8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflXM-0003V3-13; Wed, 18 Jul 2018 12:26:32 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflXL-0007FF-Fe; Wed, 18 Jul 2018 13:26:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add axg fifo base driver" to the asoc tree
In-Reply-To:  <20180717153643.8806-3-jbrunet@baylibre.com>
Message-Id: <E1fflXL-0007FF-Fe@debutante>
Date:   Wed, 18 Jul 2018 13:26:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add axg fifo base driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 6dc4fa179fb86d2c986b2bc8a8377fe4d8c0428d Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:42:51 +0200
Subject: [PATCH] ASoC: meson: add axg fifo base driver

Amlogic's axg SoCs have two types of fifos which are the memory
interfaces of the audio subsystem. FRDDR provides the playback
interface while TODDR provides the capture interface.

The way these fifos operate is very similar. Only a few settings
are specific to each.

They implement the same pcm driver here and the specifics of each
will be dealt with the related DAI driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig          |   1 +
 sound/soc/Makefile         |   1 +
 sound/soc/meson/Kconfig    |   8 +
 sound/soc/meson/Makefile   |   5 +
 sound/soc/meson/axg-fifo.c | 341 +++++++++++++++++++++++++++++++++++++
 sound/soc/meson/axg-fifo.h |  80 +++++++++
 6 files changed, 436 insertions(+)
 create mode 100644 sound/soc/meson/Kconfig
 create mode 100644 sound/soc/meson/Makefile
 create mode 100644 sound/soc/meson/axg-fifo.c
 create mode 100644 sound/soc/meson/axg-fifo.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 41af6b9cc350..1cf11cf51e1d 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -57,6 +57,7 @@ source "sound/soc/kirkwood/Kconfig"
 source "sound/soc/img/Kconfig"
 source "sound/soc/intel/Kconfig"
 source "sound/soc/mediatek/Kconfig"
+source "sound/soc/meson/Kconfig"
 source "sound/soc/mxs/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/qcom/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 06389a5385d7..62a5f87c3cfc 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SND_SOC)	+= jz4740/
 obj-$(CONFIG_SND_SOC)	+= img/
 obj-$(CONFIG_SND_SOC)	+= intel/
 obj-$(CONFIG_SND_SOC)	+= mediatek/
+obj-$(CONFIG_SND_SOC)	+= meson/
 obj-$(CONFIG_SND_SOC)	+= mxs/
 obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
new file mode 100644
index 000000000000..c3eb5e050308
--- /dev/null
+++ b/sound/soc/meson/Kconfig
@@ -0,0 +1,8 @@
+menu "ASoC support for Amlogic platforms"
+	depends on ARCH_MESON || COMPILE_TEST
+
+config SND_MESON_AXG_FIFO
+	tristate
+	select REGMAP_MMIO
+
+endmenu
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
new file mode 100644
index 000000000000..75289b6b3ade
--- /dev/null
+++ b/sound/soc/meson/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+snd-soc-meson-axg-fifo-objs := axg-fifo.o
+
+obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
new file mode 100644
index 000000000000..db367d85290f
--- /dev/null
+++ b/sound/soc/meson/axg-fifo.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/clk.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "axg-fifo.h"
+
+/*
+ * This file implements the platform operations common to the playback and
+ * capture frontend DAI. The logic behind this two types of fifo is very
+ * similar but some difference exist.
+ * These differences the respective DAI drivers
+ */
+
+static struct snd_pcm_hardware axg_fifo_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_PAUSE),
+
+	.formats = AXG_FIFO_FORMATS,
+	.rate_min = 5512,
+	.rate_max = 192000,
+	.channels_min = 1,
+	.channels_max = AXG_FIFO_CH_MAX,
+	.period_bytes_min = AXG_FIFO_MIN_DEPTH,
+	.period_bytes_max = UINT_MAX,
+	.periods_min = 2,
+	.periods_max = UINT_MAX,
+
+	/* No real justification for this */
+	.buffer_bytes_max = 1 * 1024 * 1024,
+};
+
+static struct snd_soc_dai *axg_fifo_dai(struct snd_pcm_substream *ss)
+{
+	struct snd_soc_pcm_runtime *rtd = ss->private_data;
+
+	return rtd->cpu_dai;
+}
+
+static struct axg_fifo *axg_fifo_data(struct snd_pcm_substream *ss)
+{
+	struct snd_soc_dai *dai = axg_fifo_dai(ss);
+
+	return snd_soc_dai_get_drvdata(dai);
+}
+
+static struct device *axg_fifo_dev(struct snd_pcm_substream *ss)
+{
+	struct snd_soc_dai *dai = axg_fifo_dai(ss);
+
+	return dai->dev;
+}
+
+static void __dma_enable(struct axg_fifo *fifo,  bool enable)
+{
+	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_DMA_EN,
+			   enable ? CTRL0_DMA_EN : 0);
+}
+
+static int axg_fifo_pcm_trigger(struct snd_pcm_substream *ss, int cmd)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		__dma_enable(fifo, true);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+		__dma_enable(fifo, false);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t axg_fifo_pcm_pointer(struct snd_pcm_substream *ss)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	struct snd_pcm_runtime *runtime = ss->runtime;
+	unsigned int addr;
+
+	regmap_read(fifo->map, FIFO_STATUS2, &addr);
+
+	return bytes_to_frames(runtime, addr - (unsigned int)runtime->dma_addr);
+}
+
+static int axg_fifo_pcm_hw_params(struct snd_pcm_substream *ss,
+				  struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = ss->runtime;
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	dma_addr_t end_ptr;
+	unsigned int burst_num;
+	int ret;
+
+	ret = snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(params));
+	if (ret < 0)
+		return ret;
+
+	/* Setup dma memory pointers */
+	end_ptr = runtime->dma_addr + runtime->dma_bytes - AXG_FIFO_BURST;
+	regmap_write(fifo->map, FIFO_START_ADDR, runtime->dma_addr);
+	regmap_write(fifo->map, FIFO_FINISH_ADDR, end_ptr);
+
+	/* Setup interrupt periodicity */
+	burst_num = params_period_bytes(params) / AXG_FIFO_BURST;
+	regmap_write(fifo->map, FIFO_INT_ADDR, burst_num);
+
+	/* Enable block count irq */
+	regmap_update_bits(fifo->map, FIFO_CTRL0,
+			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT),
+			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT));
+
+	return 0;
+}
+
+static int axg_fifo_pcm_hw_free(struct snd_pcm_substream *ss)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+
+	/* Disable the block count irq */
+	regmap_update_bits(fifo->map, FIFO_CTRL0,
+			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT), 0);
+
+	return snd_pcm_lib_free_pages(ss);
+}
+
+static void axg_fifo_ack_irq(struct axg_fifo *fifo, u8 mask)
+{
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_INT_CLR(FIFO_INT_MASK),
+			   CTRL1_INT_CLR(mask));
+
+	/* Clear must also be cleared */
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_INT_CLR(FIFO_INT_MASK),
+			   0);
+}
+
+static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
+{
+	struct snd_pcm_substream *ss = dev_id;
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	unsigned int status;
+
+	regmap_read(fifo->map, FIFO_STATUS1, &status);
+
+	status = STATUS1_INT_STS(status) & FIFO_INT_MASK;
+	if (status & FIFO_INT_COUNT_REPEAT)
+		snd_pcm_period_elapsed(ss);
+	else
+		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
+			status);
+
+	/* Ack irqs */
+	axg_fifo_ack_irq(fifo, status);
+
+	return !status ? IRQ_NONE : IRQ_HANDLED;
+}
+
+static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	struct device *dev = axg_fifo_dev(ss);
+	int ret;
+
+	snd_soc_set_runtime_hwparams(ss, &axg_fifo_hw);
+
+	/*
+	 * Make sure the buffer and period size are multiple of the FIFO
+	 * minimum depth size
+	 */
+	ret = snd_pcm_hw_constraint_step(ss->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+					 AXG_FIFO_MIN_DEPTH);
+	if (ret)
+		return ret;
+
+	ret = snd_pcm_hw_constraint_step(ss->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+					 AXG_FIFO_MIN_DEPTH);
+	if (ret)
+		return ret;
+
+	ret = request_irq(fifo->irq, axg_fifo_pcm_irq_block, 0,
+			  dev_name(dev), ss);
+
+	/* Enable pclk to access registers and clock the fifo ip */
+	ret = clk_prepare_enable(fifo->pclk);
+	if (ret)
+		return ret;
+
+	/* Setup status2 so it reports the memory pointer */
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_STATUS2_SEL_MASK,
+			   CTRL1_STATUS2_SEL(STATUS2_SEL_DDR_READ));
+
+	/* Make sure the dma is initially disabled */
+	__dma_enable(fifo, false);
+
+	/* Disable irqs until params are ready */
+	regmap_update_bits(fifo->map, FIFO_CTRL0,
+			   CTRL0_INT_EN(FIFO_INT_MASK), 0);
+
+	/* Clear any pending interrupt */
+	axg_fifo_ack_irq(fifo, FIFO_INT_MASK);
+
+	/* Take memory arbitror out of reset */
+	ret = reset_control_deassert(fifo->arb);
+	if (ret)
+		clk_disable_unprepare(fifo->pclk);
+
+	return ret;
+}
+
+static int axg_fifo_pcm_close(struct snd_pcm_substream *ss)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	int ret;
+
+	/* Put the memory arbitror back in reset */
+	ret = reset_control_assert(fifo->arb);
+
+	/* Disable fifo ip and register access */
+	clk_disable_unprepare(fifo->pclk);
+
+	/* remove IRQ */
+	free_irq(fifo->irq, ss);
+
+	return ret;
+}
+
+const struct snd_pcm_ops axg_fifo_pcm_ops = {
+	.open =		axg_fifo_pcm_open,
+	.close =        axg_fifo_pcm_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	axg_fifo_pcm_hw_params,
+	.hw_free =      axg_fifo_pcm_hw_free,
+	.pointer =	axg_fifo_pcm_pointer,
+	.trigger =	axg_fifo_pcm_trigger,
+};
+EXPORT_SYMBOL_GPL(axg_fifo_pcm_ops);
+
+int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	size_t size = axg_fifo_hw.buffer_bytes_max;
+
+	return snd_pcm_lib_preallocate_pages(rtd->pcm->streams[type].substream,
+					     SNDRV_DMA_TYPE_DEV, card->dev,
+					     size, size);
+}
+EXPORT_SYMBOL_GPL(axg_fifo_pcm_new);
+
+static const struct regmap_config axg_fifo_regmap_cfg = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= FIFO_STATUS2,
+};
+
+int axg_fifo_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct axg_fifo_match_data *data;
+	struct axg_fifo *fifo;
+	struct resource *res;
+	void __iomem *regs;
+
+	data = of_device_get_match_data(dev);
+	if (!data) {
+		dev_err(dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
+	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
+	if (!fifo)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, fifo);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	fifo->map = devm_regmap_init_mmio(dev, regs, &axg_fifo_regmap_cfg);
+	if (IS_ERR(fifo->map)) {
+		dev_err(dev, "failed to init regmap: %ld\n",
+			PTR_ERR(fifo->map));
+		return PTR_ERR(fifo->map);
+	}
+
+	fifo->pclk = devm_clk_get(dev, NULL);
+	if (IS_ERR(fifo->pclk)) {
+		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get pclk: %ld\n",
+				PTR_ERR(fifo->pclk));
+		return PTR_ERR(fifo->pclk);
+	}
+
+	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(fifo->arb)) {
+		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get arb reset: %ld\n",
+				PTR_ERR(fifo->arb));
+		return PTR_ERR(fifo->arb);
+	}
+
+	fifo->irq = of_irq_get(dev->of_node, 0);
+	if (fifo->irq <= 0) {
+		dev_err(dev, "failed to get irq: %d\n", fifo->irq);
+		return fifo->irq;
+	}
+
+	return devm_snd_soc_register_component(dev, data->component_drv,
+					       data->dai_drv, 1);
+}
+EXPORT_SYMBOL_GPL(axg_fifo_probe);
+
+MODULE_DESCRIPTION("Amlogic AXG fifo driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
new file mode 100644
index 000000000000..cb6c4013ca33
--- /dev/null
+++ b/sound/soc/meson/axg-fifo.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef _MESON_AXG_FIFO_H
+#define _MESON_AXG_FIFO_H
+
+struct clk;
+struct platform_device;
+struct regmap;
+struct reset_control;
+
+struct snd_soc_component_driver;
+struct snd_soc_dai;
+struct snd_soc_dai_driver;
+struct snd_pcm_ops;
+struct snd_soc_pcm_runtime;
+
+#define AXG_FIFO_CH_MAX			128
+#define AXG_FIFO_RATES			(SNDRV_PCM_RATE_5512 |		\
+					 SNDRV_PCM_RATE_8000_192000)
+#define AXG_FIFO_FORMATS		(SNDRV_PCM_FMTBIT_S8 |		\
+					 SNDRV_PCM_FMTBIT_S16_LE |	\
+					 SNDRV_PCM_FMTBIT_S20_LE |	\
+					 SNDRV_PCM_FMTBIT_S24_LE |	\
+					 SNDRV_PCM_FMTBIT_S32_LE)
+
+#define AXG_FIFO_BURST			8
+#define AXG_FIFO_MIN_CNT		64
+#define AXG_FIFO_MIN_DEPTH		(AXG_FIFO_BURST * AXG_FIFO_MIN_CNT)
+
+#define FIFO_INT_ADDR_FINISH		BIT(0)
+#define FIFO_INT_ADDR_INT		BIT(1)
+#define FIFO_INT_COUNT_REPEAT		BIT(2)
+#define FIFO_INT_COUNT_ONCE		BIT(3)
+#define FIFO_INT_FIFO_ZERO		BIT(4)
+#define FIFO_INT_FIFO_DEPTH		BIT(5)
+#define FIFO_INT_MASK			GENMASK(7, 0)
+
+#define FIFO_CTRL0			0x00
+#define  CTRL0_DMA_EN			BIT(31)
+#define  CTRL0_INT_EN(x)		((x) << 16)
+#define  CTRL0_SEL_MASK			GENMASK(2, 0)
+#define  CTRL0_SEL_SHIFT		0
+#define FIFO_CTRL1			0x04
+#define  CTRL1_INT_CLR(x)		((x) << 0)
+#define  CTRL1_STATUS2_SEL_MASK		GENMASK(11, 8)
+#define  CTRL1_STATUS2_SEL(x)		((x) << 8)
+#define   STATUS2_SEL_DDR_READ		0
+#define  CTRL1_THRESHOLD_MASK		GENMASK(23, 16)
+#define  CTRL1_THRESHOLD(x)		((x) << 16)
+#define  CTRL1_FRDDR_DEPTH_MASK		GENMASK(31, 24)
+#define  CTRL1_FRDDR_DEPTH(x)		((x) << 24)
+#define FIFO_START_ADDR			0x08
+#define FIFO_FINISH_ADDR		0x0c
+#define FIFO_INT_ADDR			0x10
+#define FIFO_STATUS1			0x14
+#define  STATUS1_INT_STS(x)		((x) << 0)
+#define FIFO_STATUS2			0x18
+
+struct axg_fifo {
+	struct regmap *map;
+	struct clk *pclk;
+	struct reset_control *arb;
+	int irq;
+};
+
+struct axg_fifo_match_data {
+	const struct snd_soc_component_driver *component_drv;
+	struct snd_soc_dai_driver *dai_drv;
+};
+
+extern const struct snd_pcm_ops axg_fifo_pcm_ops;
+
+int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type);
+int axg_fifo_probe(struct platform_device *pdev);
+
+#endif /* _MESON_AXG_FIFO_H */
-- 
2.18.0

