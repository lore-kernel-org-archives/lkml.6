Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934915AbeBLMy2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:54:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55124 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934886AbeBLMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:54:24 -0500
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: add support for UniPhier AIO compress audio" to the asoc tree
In-Reply-To: <20180119092536.22501-6-suzuki.katsuhiro@socionext.com>
Message-Id: <E1elDch-00079T-Mh@debutante>
Date: Mon, 12 Feb 2018 12:54:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: add support for UniPhier AIO compress audio

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

>From e98131222ff931a670739cede00d1fb9d6f83763 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 19 Jan 2018 18:25:32 +0900
Subject: [PATCH] ASoC: uniphier: add support for UniPhier AIO compress audio

This patch adds support of UniPhier AIO compress audio.
For passing through compress audio to S/PDIF.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/Kconfig        |   1 +
 sound/soc/uniphier/Makefile       |   2 +-
 sound/soc/uniphier/aio-compress.c | 440 ++++++++++++++++++++++++++++++++++++++
 sound/soc/uniphier/aio-dma.c      |   1 +
 sound/soc/uniphier/aio.h          |   1 +
 5 files changed, 444 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/uniphier/aio-compress.c

diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
index 78ce101d2cc2..1a55ccebd8f5 100644
--- a/sound/soc/uniphier/Kconfig
+++ b/sound/soc/uniphier/Kconfig
@@ -11,6 +11,7 @@ config SND_SOC_UNIPHIER
 config SND_SOC_UNIPHIER_AIO
 	tristate "UniPhier AIO DAI Driver"
 	select REGMAP_MMIO
+	select SND_SOC_COMPRESS
 	depends on SND_SOC_UNIPHIER
 	help
 	  This adds ASoC driver support for Socionext UniPhier
diff --git a/sound/soc/uniphier/Makefile b/sound/soc/uniphier/Makefile
index 3ef2784b2383..4448175c70ab 100644
--- a/sound/soc/uniphier/Makefile
+++ b/sound/soc/uniphier/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-snd-soc-uniphier-aio-cpu-objs := aio-core.o aio-dma.o aio-cpu.o
+snd-soc-uniphier-aio-cpu-objs := aio-core.o aio-dma.o aio-cpu.o aio-compress.o
 
 obj-$(CONFIG_SND_SOC_UNIPHIER_AIO) += snd-soc-uniphier-aio-cpu.o
 
diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
new file mode 100644
index 000000000000..7f7abe3ae99d
--- /dev/null
+++ b/sound/soc/uniphier/aio-compress.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Socionext UniPhier AIO Compress Audio driver.
+//
+// Copyright (c) 2017-2018 Socionext Inc.
+//
+// This program is free software; you can redistribute it and/or
+// modify it under the terms of the GNU General Public License
+// as published by the Free Software Foundation; version 2
+// of the License.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License
+// along with this program; if not, see <http://www.gnu.org/licenses/>.
+
+#include <linux/bitfield.h>
+#include <linux/circ_buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include "aio.h"
+
+static int uniphier_aio_compr_prepare(struct snd_compr_stream *cstream);
+static int uniphier_aio_compr_hw_free(struct snd_compr_stream *cstream);
+
+static int uniphier_aio_comprdma_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_compr *compr = rtd->compr;
+	struct device *dev = compr->card->dev;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[compr->direction];
+	size_t size = AUD_RING_SIZE;
+	int dma_dir = DMA_FROM_DEVICE, ret;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));
+	if (ret)
+		return ret;
+
+	sub->compr_area = kzalloc(size, GFP_KERNEL);
+	if (!sub->compr_area)
+		return -ENOMEM;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT)
+		dma_dir = DMA_TO_DEVICE;
+
+	sub->compr_addr = dma_map_single(dev, sub->compr_area, size, dma_dir);
+	ret = dma_mapping_error(dev, sub->compr_addr);
+	if (ret) {
+		kfree(sub->compr_area);
+		sub->compr_area = NULL;
+
+		return ret;
+	}
+
+	sub->compr_bytes = size;
+
+	return 0;
+}
+
+static int uniphier_aio_comprdma_free(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_compr *compr = rtd->compr;
+	struct device *dev = compr->card->dev;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[compr->direction];
+	int dma_dir = DMA_FROM_DEVICE;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT)
+		dma_dir = DMA_TO_DEVICE;
+
+	dma_unmap_single(dev, sub->compr_addr, sub->compr_bytes, dma_dir);
+	kfree(sub->compr_area);
+	sub->compr_area = NULL;
+
+	return 0;
+}
+
+static int uniphier_aio_compr_open(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+	int ret;
+
+	if (sub->cstream)
+		return -EBUSY;
+
+	sub->cstream = cstream;
+	sub->pass_through = 1;
+	sub->use_mmap = false;
+
+	ret = uniphier_aio_comprdma_new(rtd);
+	if (ret)
+		return ret;
+
+	ret = aio_init(sub);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int uniphier_aio_compr_free(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+	int ret;
+
+	ret = uniphier_aio_compr_hw_free(cstream);
+	if (ret)
+		return ret;
+	ret = uniphier_aio_comprdma_free(rtd);
+	if (ret)
+		return ret;
+
+	sub->cstream = NULL;
+
+	return 0;
+}
+
+static int uniphier_aio_compr_get_params(struct snd_compr_stream *cstream,
+					 struct snd_codec *params)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+
+	*params = sub->cparams.codec;
+
+	return 0;
+}
+
+static int uniphier_aio_compr_set_params(struct snd_compr_stream *cstream,
+					 struct snd_compr_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+	struct device *dev = &aio->chip->pdev->dev;
+	int ret;
+
+	if (params->codec.id != SND_AUDIOCODEC_IEC61937) {
+		dev_err(dev, "Codec ID is not supported(%d)\n",
+			params->codec.id);
+		return -EINVAL;
+	}
+	if (params->codec.profile != SND_AUDIOPROFILE_IEC61937_SPDIF) {
+		dev_err(dev, "Codec profile is not supported(%d)\n",
+			params->codec.profile);
+		return -EINVAL;
+	}
+
+	/* IEC frame type will be changed after received valid data */
+	sub->iec_pc = IEC61937_PC_AAC;
+
+	sub->cparams = *params;
+	sub->setting = 1;
+
+	aio_port_reset(sub);
+	aio_src_reset(sub);
+
+	ret = uniphier_aio_compr_prepare(cstream);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int uniphier_aio_compr_hw_free(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+
+	sub->setting = 0;
+
+	return 0;
+}
+
+static int uniphier_aio_compr_prepare(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+	int bytes = runtime->fragment_size;
+	unsigned long flags;
+	int ret;
+
+	ret = aiodma_ch_set_param(sub);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&sub->lock, flags);
+	ret = aiodma_rb_set_buffer(sub, sub->compr_addr,
+				   sub->compr_addr + sub->compr_bytes,
+				   bytes);
+	spin_unlock_irqrestore(&sub->lock, flags);
+	if (ret)
+		return ret;
+
+	ret = aio_port_set_param(sub, sub->pass_through, &sub->params);
+	if (ret)
+		return ret;
+	ret = aio_oport_set_stream_type(sub, sub->iec_pc);
+	if (ret)
+		return ret;
+	aio_port_set_enable(sub, 1);
+
+	ret = aio_if_set_param(sub, sub->pass_through);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int uniphier_aio_compr_trigger(struct snd_compr_stream *cstream,
+				      int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+	struct device *dev = &aio->chip->pdev->dev;
+	int bytes = runtime->fragment_size, ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sub->lock, flags);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		aiodma_rb_sync(sub, sub->compr_addr, sub->compr_bytes, bytes);
+		aiodma_ch_set_enable(sub, 1);
+		sub->running = 1;
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		sub->running = 0;
+		aiodma_ch_set_enable(sub, 0);
+
+		break;
+	default:
+		dev_warn(dev, "Unknown trigger(%d)\n", cmd);
+		ret = -EINVAL;
+	}
+	spin_unlock_irqrestore(&sub->lock, flags);
+
+	return ret;
+}
+
+static int uniphier_aio_compr_pointer(struct snd_compr_stream *cstream,
+				      struct snd_compr_tstamp *tstamp)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+	int bytes = runtime->fragment_size;
+	unsigned long flags;
+	u32 pos;
+
+	spin_lock_irqsave(&sub->lock, flags);
+
+	aiodma_rb_sync(sub, sub->compr_addr, sub->compr_bytes, bytes);
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		pos = sub->rd_offs;
+		/* Size of AIO output format is double of IEC61937 */
+		tstamp->copied_total = sub->rd_total / 2;
+	} else {
+		pos = sub->wr_offs;
+		tstamp->copied_total = sub->rd_total;
+	}
+	tstamp->byte_offset = pos;
+
+	spin_unlock_irqrestore(&sub->lock, flags);
+
+	return 0;
+}
+
+static int aio_compr_send_to_hw(struct uniphier_aio_sub *sub,
+				char __user *buf, size_t dstsize)
+{
+	u32 __user *srcbuf = (u32 __user *)buf;
+	u32 *dstbuf = (u32 *)(sub->compr_area + sub->wr_offs);
+	int src = 0, dst = 0, ret;
+	u32 frm, frm_a, frm_b;
+
+	while (dstsize > 0) {
+		ret = get_user(frm, srcbuf + src);
+		if (ret)
+			return ret;
+		src++;
+
+		frm_a = frm & 0xffff;
+		frm_b = (frm >> 16) & 0xffff;
+
+		if (frm == IEC61937_HEADER_SIGN) {
+			frm_a |= 0x01000000;
+
+			/* Next data is Pc and Pd */
+			sub->iec_header = true;
+		} else {
+			u16 pc = be16_to_cpu((__be16)frm_a);
+
+			if (sub->iec_header && sub->iec_pc != pc) {
+				/* Force overwrite IEC frame type */
+				sub->iec_pc = pc;
+				ret = aio_oport_set_stream_type(sub, pc);
+				if (ret)
+					return ret;
+			}
+			sub->iec_header = false;
+		}
+		dstbuf[dst++] = frm_a;
+		dstbuf[dst++] = frm_b;
+
+		dstsize -= sizeof(u32) * 2;
+	}
+
+	return 0;
+}
+
+static int uniphier_aio_compr_copy(struct snd_compr_stream *cstream,
+				   char __user *buf, size_t count)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct device *carddev = rtd->compr->card->dev;
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
+	size_t cnt = min_t(size_t, count, aio_rb_space_to_end(sub) / 2);
+	int bytes = runtime->fragment_size;
+	unsigned long flags;
+	size_t s;
+	int ret;
+
+	if (cnt < sizeof(u32))
+		return 0;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		dma_addr_t dmapos = sub->compr_addr + sub->wr_offs;
+
+		/* Size of AIO output format is double of IEC61937 */
+		s = cnt * 2;
+
+		dma_sync_single_for_cpu(carddev, dmapos, s, DMA_TO_DEVICE);
+		ret = aio_compr_send_to_hw(sub, buf, s);
+		dma_sync_single_for_device(carddev, dmapos, s, DMA_TO_DEVICE);
+	} else {
+		dma_addr_t dmapos = sub->compr_addr + sub->rd_offs;
+
+		s = cnt;
+
+		dma_sync_single_for_cpu(carddev, dmapos, s, DMA_FROM_DEVICE);
+		ret = copy_to_user(buf, sub->compr_area + sub->rd_offs, s);
+		dma_sync_single_for_device(carddev, dmapos, s, DMA_FROM_DEVICE);
+	}
+	if (ret)
+		return -EFAULT;
+
+	spin_lock_irqsave(&sub->lock, flags);
+
+	sub->threshold = 2 * bytes;
+	aiodma_rb_set_threshold(sub, sub->compr_bytes, 2 * bytes);
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		sub->wr_offs += s;
+		if (sub->wr_offs >= sub->compr_bytes)
+			sub->wr_offs -= sub->compr_bytes;
+	} else {
+		sub->rd_offs += s;
+		if (sub->rd_offs >= sub->compr_bytes)
+			sub->rd_offs -= sub->compr_bytes;
+	}
+	aiodma_rb_sync(sub, sub->compr_addr, sub->compr_bytes, bytes);
+
+	spin_unlock_irqrestore(&sub->lock, flags);
+
+	return cnt;
+}
+
+static int uniphier_aio_compr_get_caps(struct snd_compr_stream *cstream,
+				       struct snd_compr_caps *caps)
+{
+	caps->num_codecs = 1;
+	caps->min_fragment_size = AUD_MIN_FRAGMENT_SIZE;
+	caps->max_fragment_size = AUD_MAX_FRAGMENT_SIZE;
+	caps->min_fragments = AUD_MIN_FRAGMENT;
+	caps->max_fragments = AUD_MAX_FRAGMENT;
+	caps->codecs[0] = SND_AUDIOCODEC_IEC61937;
+
+	return 0;
+}
+
+static const struct snd_compr_codec_caps caps_iec = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 8,
+	.descriptor[0].num_sample_rates = 0,
+	.descriptor[0].num_bitrates = 0,
+	.descriptor[0].profiles = SND_AUDIOPROFILE_IEC61937_SPDIF,
+	.descriptor[0].modes = SND_AUDIOMODE_IEC_AC3 |
+				SND_AUDIOMODE_IEC_MPEG1 |
+				SND_AUDIOMODE_IEC_MP3 |
+				SND_AUDIOMODE_IEC_DTS,
+	.descriptor[0].formats = 0,
+};
+
+static int uniphier_aio_compr_get_codec_caps(struct snd_compr_stream *stream,
+					     struct snd_compr_codec_caps *codec)
+{
+	if (codec->codec == SND_AUDIOCODEC_IEC61937)
+		*codec = caps_iec;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+const struct snd_compr_ops uniphier_aio_compr_ops = {
+	.open           = uniphier_aio_compr_open,
+	.free           = uniphier_aio_compr_free,
+	.get_params     = uniphier_aio_compr_get_params,
+	.set_params     = uniphier_aio_compr_set_params,
+	.trigger        = uniphier_aio_compr_trigger,
+	.pointer        = uniphier_aio_compr_pointer,
+	.copy           = uniphier_aio_compr_copy,
+	.get_caps       = uniphier_aio_compr_get_caps,
+	.get_codec_caps = uniphier_aio_compr_get_codec_caps,
+};
diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index 6d0ca6dde913..22f122a42442 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -263,6 +263,7 @@ static const struct snd_soc_platform_driver uniphier_soc_platform = {
 	.pcm_new   = uniphier_aiodma_new,
 	.pcm_free  = uniphier_aiodma_free,
 	.ops       = &uniphier_aiodma_ops,
+	.compr_ops = &uniphier_aio_compr_ops,
 };
 
 static const struct regmap_config aiodma_regmap_config = {
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index b12e2e3d7699..2cd64273fb5b 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -305,6 +305,7 @@ static inline struct uniphier_aio *uniphier_priv(struct snd_soc_dai *dai)
 }
 
 int uniphier_aiodma_soc_register_platform(struct platform_device *pdev);
+extern const struct snd_compr_ops uniphier_aio_compr_ops;
 
 int uniphier_aio_dai_probe(struct snd_soc_dai *dai);
 int uniphier_aio_dai_remove(struct snd_soc_dai *dai);
-- 
2.16.1
