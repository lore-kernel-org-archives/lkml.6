Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeBGJNo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:13:44 -0500
Received: from mx.socionext.com ([202.248.49.38]:3337 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753653AbeBGJKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:10:40 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [RESEND PATCH v2 2/9] ASoC: uniphier: add support for UniPhier AIO common driver
Date: Wed,  7 Feb 2018 18:10:42 +0900
Message-Id: <20180207091049.24700-3-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
References: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds common functions for UniPhier AIO audio sound
system. This provides commonly used APIs for input/output control
registers for UniPhier AIO.

This module provides all sound devices for I2S, S/PDIF and so on.
Since the AIO has mixed register map for those I/Os, it is hard
to split register areas for each sound devices.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes in v2:
  - Change license comment style to C++ from C
  - Split DMA, DAI patches from large one
  - Fix bad name 'srcport' to 'src'
  - Add members to struct uniphier_aio_sub and add methods
    for compress audio
  - Change to void if function has no fail
---
 sound/soc/uniphier/Kconfig    |   10 +
 sound/soc/uniphier/Makefile   |    4 +
 sound/soc/uniphier/aio-core.c | 1104 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/uniphier/aio-reg.h  |  462 +++++++++++++++++
 sound/soc/uniphier/aio.h      |  343 +++++++++++++
 5 files changed, 1923 insertions(+)
 create mode 100644 sound/soc/uniphier/aio-core.c
 create mode 100644 sound/soc/uniphier/aio-reg.h
 create mode 100644 sound/soc/uniphier/aio.h

diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
index 02886a457eaf..78ce101d2cc2 100644
--- a/sound/soc/uniphier/Kconfig
+++ b/sound/soc/uniphier/Kconfig
@@ -8,6 +8,16 @@ config SND_SOC_UNIPHIER
 	  audio interfaces to support below.
 	  If unsure select "N".
 
+config SND_SOC_UNIPHIER_AIO
+	tristate "UniPhier AIO DAI Driver"
+	select REGMAP_MMIO
+	depends on SND_SOC_UNIPHIER
+	help
+	  This adds ASoC driver support for Socionext UniPhier
+	  'AIO' Audio Input/Output subsystem.
+	  Select Y if you use such device.
+	  If unsure select "N".
+
 config SND_SOC_UNIPHIER_EVEA_CODEC
 	tristate "UniPhier SoC internal audio codec"
 	depends on SND_SOC_UNIPHIER
diff --git a/sound/soc/uniphier/Makefile b/sound/soc/uniphier/Makefile
index 3be00d72f5e5..f3b36aba4879 100644
--- a/sound/soc/uniphier/Makefile
+++ b/sound/soc/uniphier/Makefile
@@ -1,3 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+snd-soc-uniphier-aio-cpu-objs := aio-core.o
+
+obj-$(CONFIG_SND_SOC_UNIPHIER_AIO) += snd-soc-uniphier-aio-cpu.o
+
 snd-soc-uniphier-evea-objs := evea.o
 obj-$(CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC) += snd-soc-uniphier-evea.o
diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
new file mode 100644
index 000000000000..7e9451ca24af
--- /dev/null
+++ b/sound/soc/uniphier/aio-core.c
@@ -0,0 +1,1104 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Socionext UniPhier AIO ALSA common driver.
+//
+// Copyright (c) 2016-2018 Socionext Inc.
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
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "aio.h"
+#include "aio-reg.h"
+
+static u64 rb_cnt(u64 wr, u64 rd, u64 len)
+{
+	if (rd <= wr)
+		return wr - rd;
+	else
+		return len - (rd - wr);
+}
+
+static u64 rb_cnt_to_end(u64 wr, u64 rd, u64 len)
+{
+	if (rd <= wr)
+		return wr - rd;
+	else
+		return len - rd;
+}
+
+static u64 rb_space(u64 wr, u64 rd, u64 len)
+{
+	if (rd <= wr)
+		return len - (wr - rd) - 8;
+	else
+		return rd - wr - 8;
+}
+
+static u64 rb_space_to_end(u64 wr, u64 rd, u64 len)
+{
+	if (rd > wr)
+		return rd - wr - 8;
+	else if (rd > 0)
+		return len - wr;
+	else
+		return len - wr - 8;
+}
+
+u64 aio_rb_cnt(struct uniphier_aio_sub *sub)
+{
+	return rb_cnt(sub->wr_offs, sub->rd_offs, sub->compr_bytes);
+}
+
+u64 aio_rbt_cnt_to_end(struct uniphier_aio_sub *sub)
+{
+	return rb_cnt_to_end(sub->wr_offs, sub->rd_offs, sub->compr_bytes);
+}
+
+u64 aio_rb_space(struct uniphier_aio_sub *sub)
+{
+	return rb_space(sub->wr_offs, sub->rd_offs, sub->compr_bytes);
+}
+
+u64 aio_rb_space_to_end(struct uniphier_aio_sub *sub)
+{
+	return rb_space_to_end(sub->wr_offs, sub->rd_offs, sub->compr_bytes);
+}
+
+/**
+ * aio_chip_set_pll - set frequency to audio PLL
+ * @chip  : the AIO chip pointer
+ * @source: PLL
+ * @freq  : frequency in Hz, 0 is ignored
+ *
+ * Sets frequency of audio PLL. This function can be called anytime,
+ * but it takes time till PLL is locked.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_chip_set_pll(struct uniphier_aio_chip *chip, int pll_id,
+		     unsigned int freq)
+{
+	struct device *dev = &chip->pdev->dev;
+	struct regmap *r = chip->regmap;
+	int shift;
+	u32 v;
+
+	/* Not change */
+	if (freq == 0)
+		return 0;
+
+	switch (pll_id) {
+	case AUD_PLL_A1:
+		shift = 0;
+		break;
+	case AUD_PLL_F1:
+		shift = 1;
+		break;
+	case AUD_PLL_A2:
+		shift = 2;
+		break;
+	case AUD_PLL_F2:
+		shift = 3;
+		break;
+	default:
+		dev_err(dev, "PLL(%d) not supported\n", pll_id);
+		return -EINVAL;
+	}
+
+	switch (freq) {
+	case 36864000:
+		v = A2APLLCTR1_APLLX_36MHZ;
+		break;
+	case 33868800:
+		v = A2APLLCTR1_APLLX_33MHZ;
+		break;
+	default:
+		dev_err(dev, "PLL frequency not supported(%d)\n", freq);
+		return -EINVAL;
+	}
+	chip->plls[pll_id].freq = freq;
+
+	regmap_update_bits(r, A2APLLCTR1, A2APLLCTR1_APLLX_MASK << shift,
+			   v << shift);
+
+	return 0;
+}
+
+/**
+ * aio_chip_init - initialize AIO whole settings
+ * @chip: the AIO chip pointer
+ *
+ * Sets AIO fixed and whole device settings to AIO.
+ * This function need to call once at driver startup.
+ *
+ * The register area that is changed by this function is shared by all
+ * modules of AIO. But there is not race condition since this function
+ * has always set the same initialize values.
+ */
+void aio_chip_init(struct uniphier_aio_chip *chip)
+{
+	struct regmap *r = chip->regmap;
+
+	regmap_update_bits(r, A2APLLCTR0,
+			   A2APLLCTR0_APLLXPOW_MASK,
+			   A2APLLCTR0_APLLXPOW_PWON);
+
+	regmap_update_bits(r, A2EXMCLKSEL0,
+			   A2EXMCLKSEL0_EXMCLK_MASK,
+			   A2EXMCLKSEL0_EXMCLK_OUTPUT);
+
+	regmap_update_bits(r, A2AIOINPUTSEL, A2AIOINPUTSEL_RXSEL_MASK,
+			   A2AIOINPUTSEL_RXSEL_PCMI1_HDMIRX1 |
+			   A2AIOINPUTSEL_RXSEL_PCMI2_SIF |
+			   A2AIOINPUTSEL_RXSEL_PCMI3_EVEA |
+			   A2AIOINPUTSEL_RXSEL_IECI1_HDMIRX1);
+
+	if (chip->chip_spec->addr_ext)
+		regmap_update_bits(r, CDA2D_TEST, CDA2D_TEST_DDR_MODE_MASK,
+				   CDA2D_TEST_DDR_MODE_EXTON0);
+	else
+		regmap_update_bits(r, CDA2D_TEST, CDA2D_TEST_DDR_MODE_MASK,
+				   CDA2D_TEST_DDR_MODE_EXTOFF1);
+}
+
+/**
+ * aio_init - initialize AIO substream
+ * @sub: the AIO substream pointer
+ *
+ * Sets fixed settings of each AIO substreams.
+ * This function need to call once at substream startup.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_init(struct uniphier_aio_sub *sub)
+{
+	struct device *dev = &sub->aio->chip->pdev->dev;
+	struct regmap *r = sub->aio->chip->regmap;
+
+	regmap_write(r, A2RBNMAPCTR0(sub->swm->rb.hw),
+		     MAPCTR0_EN | sub->swm->rb.map);
+	regmap_write(r, A2CHNMAPCTR0(sub->swm->ch.hw),
+		     MAPCTR0_EN | sub->swm->ch.map);
+
+	switch (sub->swm->type) {
+	case PORT_TYPE_I2S:
+	case PORT_TYPE_SPDIF:
+	case PORT_TYPE_EVE:
+		if (sub->swm->dir == PORT_DIR_INPUT) {
+			regmap_write(r, A2IIFNMAPCTR0(sub->swm->iif.hw),
+				     MAPCTR0_EN | sub->swm->iif.map);
+			regmap_write(r, A2IPORTNMAPCTR0(sub->swm->iport.hw),
+				     MAPCTR0_EN | sub->swm->iport.map);
+		} else {
+			regmap_write(r, A2OIFNMAPCTR0(sub->swm->oif.hw),
+				     MAPCTR0_EN | sub->swm->oif.map);
+			regmap_write(r, A2OPORTNMAPCTR0(sub->swm->oport.hw),
+				     MAPCTR0_EN | sub->swm->oport.map);
+		}
+		break;
+	case PORT_TYPE_CONV:
+		regmap_write(r, A2OIFNMAPCTR0(sub->swm->oif.hw),
+			     MAPCTR0_EN | sub->swm->oif.map);
+		regmap_write(r, A2OPORTNMAPCTR0(sub->swm->oport.hw),
+			     MAPCTR0_EN | sub->swm->oport.map);
+		regmap_write(r, A2CHNMAPCTR0(sub->swm->och.hw),
+			     MAPCTR0_EN | sub->swm->och.map);
+		regmap_write(r, A2IIFNMAPCTR0(sub->swm->iif.hw),
+			     MAPCTR0_EN | sub->swm->iif.map);
+		break;
+	default:
+		dev_err(dev, "Unknown port type %d.\n", sub->swm->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * aio_port_reset - reset AIO port block
+ * @sub: the AIO substream pointer
+ *
+ * Resets the digital signal input/output port block of AIO.
+ */
+void aio_port_reset(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		regmap_write(r, AOUTRSTCTR0, BIT(sub->swm->oport.map));
+		regmap_write(r, AOUTRSTCTR1, BIT(sub->swm->oport.map));
+	} else {
+		regmap_update_bits(r, IPORTMXRSTCTR(sub->swm->iport.map),
+				   IPORTMXRSTCTR_RSTPI_MASK,
+				   IPORTMXRSTCTR_RSTPI_RESET);
+		regmap_update_bits(r, IPORTMXRSTCTR(sub->swm->iport.map),
+				   IPORTMXRSTCTR_RSTPI_MASK,
+				   IPORTMXRSTCTR_RSTPI_RELEASE);
+	}
+}
+
+/**
+ * aio_port_set_rate - set sampling rate of LPCM
+ * @sub: the AIO substream pointer, PCM substream only
+ * @rate: Sampling rate in Hz.
+ *
+ * Set suitable I2S format settings to input/output port block of AIO.
+ * Parameter is specified by hw_params().
+ *
+ * This function may return error if non-PCM substream.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	struct device *dev = &sub->aio->chip->pdev->dev;
+	u32 v;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		switch (rate) {
+		case 8000:
+			v = OPORTMXCTR1_FSSEL_8;
+			break;
+		case 11025:
+			v = OPORTMXCTR1_FSSEL_11_025;
+			break;
+		case 12000:
+			v = OPORTMXCTR1_FSSEL_12;
+			break;
+		case 16000:
+			v = OPORTMXCTR1_FSSEL_16;
+			break;
+		case 22050:
+			v = OPORTMXCTR1_FSSEL_22_05;
+			break;
+		case 24000:
+			v = OPORTMXCTR1_FSSEL_24;
+			break;
+		case 32000:
+			v = OPORTMXCTR1_FSSEL_32;
+			break;
+		case 44100:
+			v = OPORTMXCTR1_FSSEL_44_1;
+			break;
+		case 48000:
+			v = OPORTMXCTR1_FSSEL_48;
+			break;
+		case 88200:
+			v = OPORTMXCTR1_FSSEL_88_2;
+			break;
+		case 96000:
+			v = OPORTMXCTR1_FSSEL_96;
+			break;
+		case 176400:
+			v = OPORTMXCTR1_FSSEL_176_4;
+			break;
+		case 192000:
+			v = OPORTMXCTR1_FSSEL_192;
+			break;
+		default:
+			dev_err(dev, "Rate not supported(%d)\n", rate);
+			return -EINVAL;
+		}
+
+		regmap_update_bits(r, OPORTMXCTR1(sub->swm->oport.map),
+				   OPORTMXCTR1_FSSEL_MASK, v);
+	} else {
+		switch (rate) {
+		case 8000:
+			v = IPORTMXCTR1_FSSEL_8;
+			break;
+		case 11025:
+			v = IPORTMXCTR1_FSSEL_11_025;
+			break;
+		case 12000:
+			v = IPORTMXCTR1_FSSEL_12;
+			break;
+		case 16000:
+			v = IPORTMXCTR1_FSSEL_16;
+			break;
+		case 22050:
+			v = IPORTMXCTR1_FSSEL_22_05;
+			break;
+		case 24000:
+			v = IPORTMXCTR1_FSSEL_24;
+			break;
+		case 32000:
+			v = IPORTMXCTR1_FSSEL_32;
+			break;
+		case 44100:
+			v = IPORTMXCTR1_FSSEL_44_1;
+			break;
+		case 48000:
+			v = IPORTMXCTR1_FSSEL_48;
+			break;
+		case 88200:
+			v = IPORTMXCTR1_FSSEL_88_2;
+			break;
+		case 96000:
+			v = IPORTMXCTR1_FSSEL_96;
+			break;
+		case 176400:
+			v = IPORTMXCTR1_FSSEL_176_4;
+			break;
+		case 192000:
+			v = IPORTMXCTR1_FSSEL_192;
+			break;
+		default:
+			dev_err(dev, "Rate not supported(%d)\n", rate);
+			return -EINVAL;
+		}
+
+		regmap_update_bits(r, IPORTMXCTR1(sub->swm->iport.map),
+				   IPORTMXCTR1_FSSEL_MASK, v);
+	}
+
+	return 0;
+}
+
+/**
+ * aio_port_set_fmt - set format of I2S data
+ * @sub: the AIO substream pointer, PCM substream only
+ * This parameter has no effect if substream is I2S or PCM.
+ *
+ * Set suitable I2S format settings to input/output port block of AIO.
+ * Parameter is specified by set_fmt().
+ *
+ * This function may return error if non-PCM substream.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_port_set_fmt(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	struct device *dev = &sub->aio->chip->pdev->dev;
+	u32 v;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		switch (sub->aio->fmt) {
+		case SND_SOC_DAIFMT_LEFT_J:
+			v = OPORTMXCTR1_I2SLRSEL_LEFT;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			v = OPORTMXCTR1_I2SLRSEL_RIGHT;
+			break;
+		case SND_SOC_DAIFMT_I2S:
+			v = OPORTMXCTR1_I2SLRSEL_I2S;
+			break;
+		default:
+			dev_err(dev, "Format is not supported(%d)\n",
+				sub->aio->fmt);
+			return -EINVAL;
+		}
+
+		v |= OPORTMXCTR1_OUTBITSEL_24;
+		regmap_update_bits(r, OPORTMXCTR1(sub->swm->oport.map),
+				   OPORTMXCTR1_I2SLRSEL_MASK |
+				   OPORTMXCTR1_OUTBITSEL_MASK, v);
+	} else {
+		switch (sub->aio->fmt) {
+		case SND_SOC_DAIFMT_LEFT_J:
+			v = IPORTMXCTR1_LRSEL_LEFT;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			v = IPORTMXCTR1_LRSEL_RIGHT;
+			break;
+		case SND_SOC_DAIFMT_I2S:
+			v = IPORTMXCTR1_LRSEL_I2S;
+			break;
+		default:
+			dev_err(dev, "Format is not supported(%d)\n",
+				sub->aio->fmt);
+			return -EINVAL;
+		}
+
+		v |= IPORTMXCTR1_OUTBITSEL_24 |
+			IPORTMXCTR1_CHSEL_ALL;
+		regmap_update_bits(r, IPORTMXCTR1(sub->swm->iport.map),
+				   IPORTMXCTR1_LRSEL_MASK |
+				   IPORTMXCTR1_OUTBITSEL_MASK |
+				   IPORTMXCTR1_CHSEL_MASK, v);
+	}
+
+	return 0;
+}
+
+/**
+ * aio_port_set_clk - set clock and divider of AIO port block
+ * @sub: the AIO substream pointer
+ *
+ * Set suitable PLL clock divider and relational settings to
+ * input/output port block of AIO. Parameters are specified by
+ * set_sysclk() and set_pll().
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_port_set_clk(struct uniphier_aio_sub *sub)
+{
+	struct uniphier_aio_chip *chip = sub->aio->chip;
+	struct device *dev = &sub->aio->chip->pdev->dev;
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v_pll[] = {
+		OPORTMXCTR2_ACLKSEL_A1, OPORTMXCTR2_ACLKSEL_F1,
+		OPORTMXCTR2_ACLKSEL_A2, OPORTMXCTR2_ACLKSEL_F2,
+		OPORTMXCTR2_ACLKSEL_A2PLL,
+		OPORTMXCTR2_ACLKSEL_RX1,
+	};
+	u32 v_div[] = {
+		OPORTMXCTR2_DACCKSEL_1_2, OPORTMXCTR2_DACCKSEL_1_3,
+		OPORTMXCTR2_DACCKSEL_1_1, OPORTMXCTR2_DACCKSEL_2_3,
+	};
+	u32 v;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		if (sub->swm->type == PORT_TYPE_I2S) {
+			if (sub->aio->pll_out >= ARRAY_SIZE(v_pll)) {
+				dev_err(dev, "PLL(%d) is invalid\n",
+					sub->aio->pll_out);
+				return -EINVAL;
+			}
+			if (sub->aio->plldiv >= ARRAY_SIZE(v_div)) {
+				dev_err(dev, "PLL divider(%d) is invalid\n",
+					sub->aio->plldiv);
+				return -EINVAL;
+			}
+
+			v = v_pll[sub->aio->pll_out] |
+				OPORTMXCTR2_MSSEL_MASTER |
+				v_div[sub->aio->plldiv];
+
+			switch (chip->plls[sub->aio->pll_out].freq) {
+			case 0:
+			case 36864000:
+			case 33868800:
+				v |= OPORTMXCTR2_EXTLSIFSSEL_36;
+				break;
+			default:
+				v |= OPORTMXCTR2_EXTLSIFSSEL_24;
+				break;
+			}
+		} else if (sub->swm->type == PORT_TYPE_EVE) {
+			v = OPORTMXCTR2_ACLKSEL_A2PLL |
+				OPORTMXCTR2_MSSEL_MASTER |
+				OPORTMXCTR2_EXTLSIFSSEL_36 |
+				OPORTMXCTR2_DACCKSEL_1_2;
+		} else {
+			if (sub->aio->pll_out >= ARRAY_SIZE(v_pll)) {
+				dev_err(dev, "PLL(%d) is invalid\n",
+					sub->aio->pll_out);
+				return -EINVAL;
+			}
+			v = v_pll[sub->aio->pll_out] |
+				OPORTMXCTR2_MSSEL_MASTER |
+				OPORTMXCTR2_DACCKSEL_1_2;
+
+			switch (chip->plls[sub->aio->pll_out].freq) {
+			case 0:
+			case 36864000:
+			case 33868800:
+				v |= OPORTMXCTR2_EXTLSIFSSEL_36;
+				break;
+			default:
+				v |= OPORTMXCTR2_EXTLSIFSSEL_24;
+				break;
+			}
+		}
+		regmap_write(r, OPORTMXCTR2(sub->swm->oport.map), v);
+	} else {
+		v = IPORTMXCTR2_ACLKSEL_A1 |
+			IPORTMXCTR2_MSSEL_SLAVE |
+			IPORTMXCTR2_EXTLSIFSSEL_36 |
+			IPORTMXCTR2_DACCKSEL_1_2;
+		regmap_write(r, IPORTMXCTR2(sub->swm->iport.map), v);
+	}
+
+	return 0;
+}
+
+/**
+ * aio_port_set_param - set parameters of AIO port block
+ * @sub: the AIO substream pointer
+ * @pass_through: Zero if sound data is LPCM, otherwise if data is not LPCM.
+ * This parameter has no effect if substream is I2S or PCM.
+ * @params: hardware parameters of ALSA
+ *
+ * Set suitable setting to input/output port block of AIO to process the
+ * specified in params.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
+		       const struct snd_pcm_hw_params *params)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+	int ret;
+
+	if (!pass_through) {
+		ret = aio_port_set_rate(sub, params_rate(params));
+		if (ret)
+			return ret;
+
+		ret = aio_port_set_fmt(sub);
+		if (ret)
+			return ret;
+	}
+
+	ret = aio_port_set_clk(sub);
+	if (ret)
+		return ret;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		if (pass_through)
+			v = OPORTMXCTR3_SRCSEL_STREAM |
+				OPORTMXCTR3_VALID_STREAM;
+		else
+			v = OPORTMXCTR3_SRCSEL_PCM |
+				OPORTMXCTR3_VALID_PCM;
+
+		v |= OPORTMXCTR3_IECTHUR_IECOUT |
+			OPORTMXCTR3_PMSEL_PAUSE |
+			OPORTMXCTR3_PMSW_MUTE_OFF;
+		regmap_write(r, OPORTMXCTR3(sub->swm->oport.map), v);
+	} else {
+		regmap_write(r, IPORTMXACLKSEL0EX(sub->swm->iport.map),
+			     IPORTMXACLKSEL0EX_ACLKSEL0EX_INTERNAL);
+		regmap_write(r, IPORTMXEXNOE(sub->swm->iport.map),
+			     IPORTMXEXNOE_PCMINOE_INPUT);
+	}
+
+	return 0;
+}
+
+/**
+ * aio_port_set_enable - start or stop of AIO port block
+ * @sub: the AIO substream pointer
+ * @enable: zero to stop the block, otherwise to start
+ *
+ * Start or stop the signal input/output port block of AIO.
+ */
+void aio_port_set_enable(struct uniphier_aio_sub *sub, int enable)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		regmap_write(r, OPORTMXPATH(sub->swm->oport.map),
+			     sub->swm->oif.map);
+
+		regmap_update_bits(r, OPORTMXMASK(sub->swm->oport.map),
+				   OPORTMXMASK_IUDXMSK_MASK |
+				   OPORTMXMASK_IUXCKMSK_MASK |
+				   OPORTMXMASK_DXMSK_MASK |
+				   OPORTMXMASK_XCKMSK_MASK,
+				   OPORTMXMASK_IUDXMSK_OFF |
+				   OPORTMXMASK_IUXCKMSK_OFF |
+				   OPORTMXMASK_DXMSK_OFF |
+				   OPORTMXMASK_XCKMSK_OFF);
+
+		if (enable)
+			regmap_write(r, AOUTENCTR0, BIT(sub->swm->oport.map));
+		else
+			regmap_write(r, AOUTENCTR1, BIT(sub->swm->oport.map));
+	} else {
+		regmap_update_bits(r, IPORTMXMASK(sub->swm->iport.map),
+				   IPORTMXMASK_IUXCKMSK_MASK |
+				   IPORTMXMASK_XCKMSK_MASK,
+				   IPORTMXMASK_IUXCKMSK_OFF |
+				   IPORTMXMASK_XCKMSK_OFF);
+
+		if (enable)
+			regmap_update_bits(r,
+					   IPORTMXCTR2(sub->swm->iport.map),
+					   IPORTMXCTR2_REQEN_MASK,
+					   IPORTMXCTR2_REQEN_ENABLE);
+		else
+			regmap_update_bits(r,
+					   IPORTMXCTR2(sub->swm->iport.map),
+					   IPORTMXCTR2_REQEN_MASK,
+					   IPORTMXCTR2_REQEN_DISABLE);
+	}
+}
+
+/**
+ * aio_if_set_param - set parameters of AIO DMA I/F block
+ * @sub: the AIO substream pointer
+ * @pass_through: Zero if sound data is LPCM, otherwise if data is not LPCM.
+ * This parameter has no effect if substream is I2S or PCM.
+ *
+ * Set suitable setting to DMA interface block of AIO to process the
+ * specified in settings.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_if_set_param(struct uniphier_aio_sub *sub, int pass_through)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		if (pass_through)
+			v = PBOUTMXCTR0_ENDIAN_0123 |
+				PBOUTMXCTR0_MEMFMT_STREAM;
+		else
+			v = PBOUTMXCTR0_ENDIAN_3210 |
+				PBOUTMXCTR0_MEMFMT_2CH;
+
+		regmap_write(r, PBOUTMXCTR0(sub->swm->oif.map), v);
+		regmap_write(r, PBOUTMXCTR1(sub->swm->oif.map), 0);
+	} else {
+		regmap_write(r, PBINMXCTR(sub->swm->iif.map),
+			     PBINMXCTR_NCONNECT_CONNECT |
+			     PBINMXCTR_INOUTSEL_IN |
+			     (sub->swm->iport.map << PBINMXCTR_PBINSEL_SHIFT) |
+			     PBINMXCTR_ENDIAN_3210 |
+			     PBINMXCTR_MEMFMT_D0);
+	}
+
+	return 0;
+}
+
+/**
+ * aio_oport_set_stream_type - set parameters of AIO playback port block
+ * @sub: the AIO substream pointer
+ * @pc: Pc type of IEC61937
+ *
+ * Set special setting to output port block of AIO to output the stream
+ * via S/PDIF.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_oport_set_stream_type(struct uniphier_aio_sub *sub,
+			      enum IEC61937_PC pc)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 repet = 0, pause = OPORTMXPAUDAT_PAUSEPC_CMN;
+
+	switch (pc) {
+	case IEC61937_PC_AC3:
+		repet = OPORTMXREPET_STRLENGTH_AC3 |
+			OPORTMXREPET_PMLENGTH_AC3;
+		pause |= OPORTMXPAUDAT_PAUSEPD_AC3;
+		break;
+	case IEC61937_PC_MPA:
+		repet = OPORTMXREPET_STRLENGTH_MPA |
+			OPORTMXREPET_PMLENGTH_MPA;
+		pause |= OPORTMXPAUDAT_PAUSEPD_MPA;
+		break;
+	case IEC61937_PC_MP3:
+		repet = OPORTMXREPET_STRLENGTH_MP3 |
+			OPORTMXREPET_PMLENGTH_MP3;
+		pause |= OPORTMXPAUDAT_PAUSEPD_MP3;
+		break;
+	case IEC61937_PC_DTS1:
+		repet = OPORTMXREPET_STRLENGTH_DTS1 |
+			OPORTMXREPET_PMLENGTH_DTS1;
+		pause |= OPORTMXPAUDAT_PAUSEPD_DTS1;
+		break;
+	case IEC61937_PC_DTS2:
+		repet = OPORTMXREPET_STRLENGTH_DTS2 |
+			OPORTMXREPET_PMLENGTH_DTS2;
+		pause |= OPORTMXPAUDAT_PAUSEPD_DTS2;
+		break;
+	case IEC61937_PC_DTS3:
+		repet = OPORTMXREPET_STRLENGTH_DTS3 |
+			OPORTMXREPET_PMLENGTH_DTS3;
+		pause |= OPORTMXPAUDAT_PAUSEPD_DTS3;
+		break;
+	case IEC61937_PC_AAC:
+		repet = OPORTMXREPET_STRLENGTH_AAC |
+			OPORTMXREPET_PMLENGTH_AAC;
+		pause |= OPORTMXPAUDAT_PAUSEPD_AAC;
+		break;
+	case IEC61937_PC_PAUSE:
+		/* Do nothing */
+		break;
+	}
+
+	regmap_write(r, OPORTMXREPET(sub->swm->oport.map), repet);
+	regmap_write(r, OPORTMXPAUDAT(sub->swm->oport.map), pause);
+
+	return 0;
+}
+
+/**
+ * aio_src_reset - reset AIO SRC block
+ * @sub: the AIO substream pointer
+ *
+ * Resets the digital signal input/output port with sampling rate converter
+ * block of AIO.
+ * This function has no effect if substream is not supported rate converter.
+ */
+void aio_src_reset(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->swm->dir != PORT_DIR_OUTPUT)
+		return;
+
+	regmap_write(r, AOUTSRCRSTCTR0, BIT(sub->swm->oport.map));
+	regmap_write(r, AOUTSRCRSTCTR1, BIT(sub->swm->oport.map));
+}
+
+/**
+ * aio_src_set_param - set parameters of AIO SRC block
+ * @sub: the AIO substream pointer
+ * @params: hardware parameters of ALSA
+ *
+ * Set suitable setting to input/output port with sampling rate converter
+ * block of AIO to process the specified in params.
+ * This function has no effect if substream is not supported rate converter.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int aio_src_set_param(struct uniphier_aio_sub *sub,
+		      const struct snd_pcm_hw_params *params)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	if (sub->swm->dir != PORT_DIR_OUTPUT)
+		return 0;
+
+	regmap_write(r, OPORTMXSRC1CTR(sub->swm->oport.map),
+		     OPORTMXSRC1CTR_THMODE_SRC |
+		     OPORTMXSRC1CTR_SRCPATH_CALC |
+		     OPORTMXSRC1CTR_SYNC_ASYNC |
+		     OPORTMXSRC1CTR_FSIIPSEL_INNER |
+		     OPORTMXSRC1CTR_FSISEL_ACLK);
+
+	switch (params_rate(params)) {
+	default:
+	case 48000:
+		v = OPORTMXRATE_I_ACLKSEL_APLLA1 |
+			OPORTMXRATE_I_MCKSEL_36 |
+			OPORTMXRATE_I_FSSEL_48;
+		break;
+	case 44100:
+		v = OPORTMXRATE_I_ACLKSEL_APLLA2 |
+			OPORTMXRATE_I_MCKSEL_33 |
+			OPORTMXRATE_I_FSSEL_44_1;
+		break;
+	case 32000:
+		v = OPORTMXRATE_I_ACLKSEL_APLLA1 |
+			OPORTMXRATE_I_MCKSEL_36 |
+			OPORTMXRATE_I_FSSEL_32;
+		break;
+	}
+
+	regmap_write(r, OPORTMXRATE_I(sub->swm->oport.map),
+		     v | OPORTMXRATE_I_ACLKSRC_APLL |
+		     OPORTMXRATE_I_LRCKSTP_STOP);
+	regmap_update_bits(r, OPORTMXRATE_I(sub->swm->oport.map),
+			   OPORTMXRATE_I_LRCKSTP_MASK,
+			   OPORTMXRATE_I_LRCKSTP_START);
+
+	return 0;
+}
+
+int aio_srcif_set_param(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	regmap_write(r, PBINMXCTR(sub->swm->iif.map),
+		     PBINMXCTR_NCONNECT_CONNECT |
+		     PBINMXCTR_INOUTSEL_OUT |
+		     (sub->swm->oport.map << PBINMXCTR_PBINSEL_SHIFT) |
+		     PBINMXCTR_ENDIAN_3210 |
+		     PBINMXCTR_MEMFMT_D0);
+
+	return 0;
+}
+
+int aio_srcch_set_param(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	regmap_write(r, CDA2D_CHMXCTRL1(sub->swm->och.map),
+		     CDA2D_CHMXCTRL1_INDSIZE_INFINITE);
+
+	regmap_write(r, CDA2D_CHMXSRCAMODE(sub->swm->och.map),
+		     CDA2D_CHMXAMODE_ENDIAN_3210 |
+		     CDA2D_CHMXAMODE_AUPDT_FIX |
+		     CDA2D_CHMXAMODE_TYPE_NORMAL);
+
+	regmap_write(r, CDA2D_CHMXDSTAMODE(sub->swm->och.map),
+		     CDA2D_CHMXAMODE_ENDIAN_3210 |
+		     CDA2D_CHMXAMODE_AUPDT_INC |
+		     CDA2D_CHMXAMODE_TYPE_RING |
+		     (sub->swm->och.map << CDA2D_CHMXAMODE_RSSEL_SHIFT));
+
+	return 0;
+}
+
+void aio_srcch_set_enable(struct uniphier_aio_sub *sub, int enable)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	if (enable)
+		v = CDA2D_STRT0_STOP_START;
+	else
+		v = CDA2D_STRT0_STOP_STOP;
+
+	regmap_write(r, CDA2D_STRT0,
+		     v | BIT(sub->swm->och.map));
+}
+
+int aiodma_ch_set_param(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	regmap_write(r, CDA2D_CHMXCTRL1(sub->swm->ch.map),
+		     CDA2D_CHMXCTRL1_INDSIZE_INFINITE);
+
+	v = CDA2D_CHMXAMODE_ENDIAN_3210 |
+		CDA2D_CHMXAMODE_AUPDT_INC |
+		CDA2D_CHMXAMODE_TYPE_NORMAL |
+		(sub->swm->rb.map << CDA2D_CHMXAMODE_RSSEL_SHIFT);
+	if (sub->swm->dir == PORT_DIR_OUTPUT)
+		regmap_write(r, CDA2D_CHMXSRCAMODE(sub->swm->ch.map), v);
+	else
+		regmap_write(r, CDA2D_CHMXDSTAMODE(sub->swm->ch.map), v);
+
+	return 0;
+}
+
+void aiodma_ch_set_enable(struct uniphier_aio_sub *sub, int enable)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (enable) {
+		regmap_write(r, CDA2D_STRT0,
+			     CDA2D_STRT0_STOP_START | BIT(sub->swm->ch.map));
+
+		regmap_update_bits(r, INTRBIM(0),
+				   BIT(sub->swm->rb.map),
+				   BIT(sub->swm->rb.map));
+	} else {
+		regmap_write(r, CDA2D_STRT0,
+			     CDA2D_STRT0_STOP_STOP | BIT(sub->swm->ch.map));
+
+		regmap_update_bits(r, INTRBIM(0),
+				   BIT(sub->swm->rb.map),
+				   0);
+	}
+}
+
+u64 aiodma_rb_get_rp(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 pos_u, pos_l;
+	int i;
+
+	regmap_write(r, CDA2D_RDPTRLOAD,
+		     CDA2D_RDPTRLOAD_LSFLAG_STORE | BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), &pos_l);
+
+	regmap_read(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), &pos_l);
+	regmap_read(r, CDA2D_RBMXRDPTRU(sub->swm->rb.map), &pos_u);
+	pos_u = FIELD_GET(CDA2D_RBMXPTRU_PTRU_MASK, pos_u);
+
+	return ((u64)pos_u << 32) | pos_l;
+}
+
+static void aiodma_rb_set_rp(struct uniphier_aio_sub *sub, u64 pos)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 tmp;
+	int i;
+
+	regmap_write(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), (u32)pos);
+	regmap_write(r, CDA2D_RBMXRDPTRU(sub->swm->rb.map), (u32)(pos >> 32));
+	regmap_write(r, CDA2D_RDPTRLOAD, BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), &tmp);
+}
+
+static u64 aiodma_rb_get_wp(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 pos_u, pos_l;
+	int i;
+
+	regmap_write(r, CDA2D_WRPTRLOAD,
+		     CDA2D_WRPTRLOAD_LSFLAG_STORE | BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXWRPTR(sub->swm->rb.map), &pos_l);
+
+	regmap_read(r, CDA2D_RBMXWRPTR(sub->swm->rb.map), &pos_l);
+	regmap_read(r, CDA2D_RBMXWRPTRU(sub->swm->rb.map), &pos_u);
+	pos_u = FIELD_GET(CDA2D_RBMXPTRU_PTRU_MASK, pos_u);
+
+	return ((u64)pos_u << 32) | pos_l;
+}
+
+static void aiodma_rb_set_wp(struct uniphier_aio_sub *sub, u64 pos)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 tmp;
+	int i;
+
+	regmap_write(r, CDA2D_RBMXWRPTR(sub->swm->rb.map),
+		     lower_32_bits(pos));
+	regmap_write(r, CDA2D_RBMXWRPTRU(sub->swm->rb.map),
+		     upper_32_bits(pos));
+	regmap_write(r, CDA2D_WRPTRLOAD, BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXWRPTR(sub->swm->rb.map), &tmp);
+}
+
+int aiodma_rb_set_threshold(struct uniphier_aio_sub *sub, u64 size, u32 th)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (size <= th)
+		return -EINVAL;
+
+	regmap_write(r, CDA2D_RBMXBTH(sub->swm->rb.map), th);
+	regmap_write(r, CDA2D_RBMXRTH(sub->swm->rb.map), th);
+
+	return 0;
+}
+
+int aiodma_rb_set_buffer(struct uniphier_aio_sub *sub, u64 start, u64 end,
+			 int period)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u64 size = end - start;
+	int ret;
+
+	if (end < start || period < 0)
+		return -EINVAL;
+
+	regmap_write(r, CDA2D_RBMXCNFG(sub->swm->rb.map), 0);
+	regmap_write(r, CDA2D_RBMXBGNADRS(sub->swm->rb.map),
+		     lower_32_bits(start));
+	regmap_write(r, CDA2D_RBMXBGNADRSU(sub->swm->rb.map),
+		     upper_32_bits(start));
+	regmap_write(r, CDA2D_RBMXENDADRS(sub->swm->rb.map),
+		     lower_32_bits(end));
+	regmap_write(r, CDA2D_RBMXENDADRSU(sub->swm->rb.map),
+		     upper_32_bits(end));
+
+	regmap_write(r, CDA2D_RBADRSLOAD, BIT(sub->swm->rb.map));
+
+	ret = aiodma_rb_set_threshold(sub, size, 2 * period);
+	if (ret)
+		return ret;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		aiodma_rb_set_rp(sub, start);
+		aiodma_rb_set_wp(sub, end - period);
+
+		regmap_update_bits(r, CDA2D_RBMXIE(sub->swm->rb.map),
+				   CDA2D_RBMXIX_SPACE,
+				   CDA2D_RBMXIX_SPACE);
+	} else {
+		aiodma_rb_set_rp(sub, end - period);
+		aiodma_rb_set_wp(sub, start);
+
+		regmap_update_bits(r, CDA2D_RBMXIE(sub->swm->rb.map),
+				   CDA2D_RBMXIX_REMAIN,
+				   CDA2D_RBMXIX_REMAIN);
+	}
+
+	sub->threshold = 2 * period;
+	sub->rd_offs = 0;
+	sub->wr_offs = 0;
+	sub->rd_org = 0;
+	sub->wr_org = 0;
+	sub->rd_total = 0;
+	sub->wr_total = 0;
+
+	return 0;
+}
+
+void aiodma_rb_sync(struct uniphier_aio_sub *sub, u64 start, u64 size,
+		    int period)
+{
+	if (sub->swm->dir == PORT_DIR_OUTPUT) {
+		sub->rd_offs = aiodma_rb_get_rp(sub) - start;
+
+		if (sub->use_mmap) {
+			sub->threshold = 2 * period;
+			aiodma_rb_set_threshold(sub, size, 2 * period);
+
+			sub->wr_offs = sub->rd_offs - period;
+			if (sub->rd_offs < period)
+				sub->wr_offs += size;
+		}
+		aiodma_rb_set_wp(sub, sub->wr_offs + start);
+	} else {
+		sub->wr_offs = aiodma_rb_get_wp(sub) - start;
+
+		if (sub->use_mmap) {
+			sub->threshold = 2 * period;
+			aiodma_rb_set_threshold(sub, size, 2 * period);
+
+			sub->rd_offs = sub->wr_offs - period;
+			if (sub->wr_offs < period)
+				sub->rd_offs += size;
+		}
+		aiodma_rb_set_rp(sub, sub->rd_offs + start);
+	}
+
+	sub->rd_total += sub->rd_offs - sub->rd_org;
+	if (sub->rd_offs < sub->rd_org)
+		sub->rd_total += size;
+	sub->wr_total += sub->wr_offs - sub->wr_org;
+	if (sub->wr_offs < sub->wr_org)
+		sub->wr_total += size;
+
+	sub->rd_org = sub->rd_offs;
+	sub->wr_org = sub->wr_offs;
+}
+
+bool aiodma_rb_is_irq(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 ir;
+
+	regmap_read(r, CDA2D_RBMXIR(sub->swm->rb.map), &ir);
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT)
+		return !!(ir & CDA2D_RBMXIX_SPACE);
+	else
+		return !!(ir & CDA2D_RBMXIX_REMAIN);
+}
+
+void aiodma_rb_clear_irq(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->swm->dir == PORT_DIR_OUTPUT)
+		regmap_write(r, CDA2D_RBMXIR(sub->swm->rb.map),
+			     CDA2D_RBMXIX_SPACE);
+	else
+		regmap_write(r, CDA2D_RBMXIR(sub->swm->rb.map),
+			     CDA2D_RBMXIX_REMAIN);
+}
diff --git a/sound/soc/uniphier/aio-reg.h b/sound/soc/uniphier/aio-reg.h
new file mode 100644
index 000000000000..eaf2c65acf14
--- /dev/null
+++ b/sound/soc/uniphier/aio-reg.h
@@ -0,0 +1,462 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Socionext UniPhier AIO ALSA driver.
+ *
+ * Copyright (c) 2016-2018 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SND_UNIPHIER_AIO_REG_H__
+#define SND_UNIPHIER_AIO_REG_H__
+
+#include <linux/bitops.h>
+
+/* SW view */
+#define A2CHNMAPCTR0(n)                 (0x00000 + 0x40 * (n))
+#define A2RBNMAPCTR0(n)                 (0x01000 + 0x40 * (n))
+#define A2IPORTNMAPCTR0(n)              (0x02000 + 0x40 * (n))
+#define A2IPORTNMAPCTR1(n)              (0x02004 + 0x40 * (n))
+#define A2IIFNMAPCTR0(n)                (0x03000 + 0x40 * (n))
+#define A2OPORTNMAPCTR0(n)              (0x04000 + 0x40 * (n))
+#define A2OPORTNMAPCTR1(n)              (0x04004 + 0x40 * (n))
+#define A2OPORTNMAPCTR2(n)              (0x04008 + 0x40 * (n))
+#define A2OIFNMAPCTR0(n)                (0x05000 + 0x40 * (n))
+#define A2ATNMAPCTR0(n)                 (0x06000 + 0x40 * (n))
+
+#define MAPCTR0_EN                      0x80000000
+
+/* CTL */
+#define A2APLLCTR0                      0x07000
+#define   A2APLLCTR0_APLLXPOW_MASK        GENMASK(3, 0)
+#define   A2APLLCTR0_APLLXPOW_PWOFF       (0x0 << 0)
+#define   A2APLLCTR0_APLLXPOW_PWON        (0xf << 0)
+#define A2APLLCTR1                      0x07004
+#define   A2APLLCTR1_APLLX_MASK           0x00010101
+#define   A2APLLCTR1_APLLX_36MHZ          0x00000000
+#define   A2APLLCTR1_APLLX_33MHZ          0x00000001
+#define A2EXMCLKSEL0                    0x07030
+#define   A2EXMCLKSEL0_EXMCLK_MASK        GENMASK(2, 0)
+#define   A2EXMCLKSEL0_EXMCLK_OUTPUT      (0x0 << 0)
+#define   A2EXMCLKSEL0_EXMCLK_INPUT       (0x7 << 0)
+#define A2SSIFSW                        0x07050
+#define A2CH22_2CTR                     0x07054
+#define A2AIOINPUTSEL                   0x070e0
+#define   A2AIOINPUTSEL_RXSEL_PCMI1_MASK      GENMASK(2, 0)
+#define   A2AIOINPUTSEL_RXSEL_PCMI1_HDMIRX1   (0x2 << 0)
+#define   A2AIOINPUTSEL_RXSEL_PCMI2_MASK      GENMASK(6, 4)
+#define   A2AIOINPUTSEL_RXSEL_PCMI2_SIF       (0x7 << 4)
+#define   A2AIOINPUTSEL_RXSEL_PCMI3_MASK      GENMASK(10, 8)
+#define   A2AIOINPUTSEL_RXSEL_PCMI3_EVEA      (0x1 << 8)
+#define   A2AIOINPUTSEL_RXSEL_IECI1_MASK      GENMASK(14, 12)
+#define   A2AIOINPUTSEL_RXSEL_IECI1_HDMIRX1   (0x2 << 12)
+#define   A2AIOINPUTSEL_RXSEL_MASK        (A2AIOINPUTSEL_RXSEL_PCMI1_MASK | \
+					   A2AIOINPUTSEL_RXSEL_PCMI2_MASK | \
+					   A2AIOINPUTSEL_RXSEL_PCMI3_MASK | \
+					   A2AIOINPUTSEL_RXSEL_IECI1_HDMIRX1)
+
+/* INTC */
+#define INTCHIM(m)                       (0x9028 + 0x80 * (m))
+#define INTRBIM(m)                       (0x9030 + 0x80 * (m))
+#define INTCHID(m)                       (0xa028 + 0x80 * (m))
+#define INTRBID(m)                       (0xa030 + 0x80 * (m))
+
+/* AIN(PCMINN) */
+#define IPORTMXCTR1(n)                   (0x22000 + 0x400 * (n))
+#define   IPORTMXCTR1_LRSEL_MASK           GENMASK(11, 10)
+#define   IPORTMXCTR1_LRSEL_RIGHT          (0x0 << 10)
+#define   IPORTMXCTR1_LRSEL_LEFT           (0x1 << 10)
+#define   IPORTMXCTR1_LRSEL_I2S            (0x2 << 10)
+#define   IPORTMXCTR1_OUTBITSEL_MASK       (0x800003U << 8)
+#define   IPORTMXCTR1_OUTBITSEL_32         (0x800000U << 8)
+#define   IPORTMXCTR1_OUTBITSEL_24         (0x000000U << 8)
+#define   IPORTMXCTR1_OUTBITSEL_20         (0x000001U << 8)
+#define   IPORTMXCTR1_OUTBITSEL_16         (0x000002U << 8)
+#define   IPORTMXCTR1_CHSEL_MASK           GENMASK(6, 4)
+#define   IPORTMXCTR1_CHSEL_ALL            (0x0 << 4)
+#define   IPORTMXCTR1_CHSEL_D0_D2          (0x1 << 4)
+#define   IPORTMXCTR1_CHSEL_D0             (0x2 << 4)
+#define   IPORTMXCTR1_CHSEL_D1             (0x3 << 4)
+#define   IPORTMXCTR1_CHSEL_D2             (0x4 << 4)
+#define   IPORTMXCTR1_CHSEL_DMIX           (0x5 << 4)
+#define   IPORTMXCTR1_FSSEL_MASK           GENMASK(3, 0)
+#define   IPORTMXCTR1_FSSEL_48             (0x0 << 0)
+#define   IPORTMXCTR1_FSSEL_96             (0x1 << 0)
+#define   IPORTMXCTR1_FSSEL_192            (0x2 << 0)
+#define   IPORTMXCTR1_FSSEL_32             (0x3 << 0)
+#define   IPORTMXCTR1_FSSEL_44_1           (0x4 << 0)
+#define   IPORTMXCTR1_FSSEL_88_2           (0x5 << 0)
+#define   IPORTMXCTR1_FSSEL_176_4          (0x6 << 0)
+#define   IPORTMXCTR1_FSSEL_16             (0x8 << 0)
+#define   IPORTMXCTR1_FSSEL_22_05          (0x9 << 0)
+#define   IPORTMXCTR1_FSSEL_24             (0xa << 0)
+#define   IPORTMXCTR1_FSSEL_8              (0xb << 0)
+#define   IPORTMXCTR1_FSSEL_11_025         (0xc << 0)
+#define   IPORTMXCTR1_FSSEL_12             (0xd << 0)
+#define IPORTMXCTR2(n)                   (0x22004 + 0x400 * (n))
+#define   IPORTMXCTR2_ACLKSEL_MASK         GENMASK(19, 16)
+#define   IPORTMXCTR2_ACLKSEL_A1           (0x0 << 16)
+#define   IPORTMXCTR2_ACLKSEL_F1           (0x1 << 16)
+#define   IPORTMXCTR2_ACLKSEL_A2           (0x2 << 16)
+#define   IPORTMXCTR2_ACLKSEL_F2           (0x3 << 16)
+#define   IPORTMXCTR2_ACLKSEL_A2PLL        (0x4 << 16)
+#define   IPORTMXCTR2_ACLKSEL_RX1          (0x5 << 16)
+#define   IPORTMXCTR2_ACLKSEL_RX2          (0x6 << 16)
+#define   IPORTMXCTR2_MSSEL_MASK           BIT(15)
+#define   IPORTMXCTR2_MSSEL_SLAVE          (0x0 << 15)
+#define   IPORTMXCTR2_MSSEL_MASTER         (0x1 << 15)
+#define   IPORTMXCTR2_EXTLSIFSSEL_MASK     BIT(14)
+#define   IPORTMXCTR2_EXTLSIFSSEL_36       (0x0 << 14)
+#define   IPORTMXCTR2_EXTLSIFSSEL_24       (0x1 << 14)
+#define   IPORTMXCTR2_DACCKSEL_MASK        GENMASK(9, 8)
+#define   IPORTMXCTR2_DACCKSEL_1_2         (0x0 << 8)
+#define   IPORTMXCTR2_DACCKSEL_1_3         (0x1 << 8)
+#define   IPORTMXCTR2_DACCKSEL_1_1         (0x2 << 8)
+#define   IPORTMXCTR2_DACCKSEL_2_3         (0x3 << 8)
+#define   IPORTMXCTR2_REQEN_MASK           BIT(0)
+#define   IPORTMXCTR2_REQEN_DISABLE        (0x0 << 0)
+#define   IPORTMXCTR2_REQEN_ENABLE         (0x1 << 0)
+#define IPORTMXCNTCTR(n)                 (0x22010 + 0x400 * (n))
+#define IPORTMXCOUNTER(n)                (0x22014 + 0x400 * (n))
+#define IPORTMXCNTMONI(n)                (0x22018 + 0x400 * (n))
+#define IPORTMXACLKSEL0EX(n)             (0x22020 + 0x400 * (n))
+#define   IPORTMXACLKSEL0EX_ACLKSEL0EX_MASK        GENMASK(3, 0)
+#define   IPORTMXACLKSEL0EX_ACLKSEL0EX_INTERNAL    (0x0 << 0)
+#define   IPORTMXACLKSEL0EX_ACLKSEL0EX_EXTERNAL    (0xf << 0)
+#define IPORTMXEXNOE(n)                  (0x22070 + 0x400 * (n))
+#define   IPORTMXEXNOE_PCMINOE_MASK        BIT(0)
+#define   IPORTMXEXNOE_PCMINOE_OUTPUT      (0x0 << 0)
+#define   IPORTMXEXNOE_PCMINOE_INPUT       (0x1 << 0)
+#define IPORTMXMASK(n)                   (0x22078 + 0x400 * (n))
+#define   IPORTMXMASK_IUXCKMSK_MASK        GENMASK(18, 16)
+#define   IPORTMXMASK_IUXCKMSK_ON          (0x0 << 16)
+#define   IPORTMXMASK_IUXCKMSK_OFF         (0x7 << 16)
+#define   IPORTMXMASK_XCKMSK_MASK          GENMASK(2, 0)
+#define   IPORTMXMASK_XCKMSK_ON            (0x0 << 0)
+#define   IPORTMXMASK_XCKMSK_OFF           (0x7 << 0)
+#define IPORTMXRSTCTR(n)                 (0x2207c + 0x400 * (n))
+#define   IPORTMXRSTCTR_RSTPI_MASK         BIT(7)
+#define   IPORTMXRSTCTR_RSTPI_RELEASE      (0x0 << 7)
+#define   IPORTMXRSTCTR_RSTPI_RESET        (0x1 << 7)
+
+/* AIN(PBinMX) */
+#define PBINMXCTR(n)                     (0x20200 + 0x40 * (n))
+#define   PBINMXCTR_NCONNECT_MASK          BIT(15)
+#define   PBINMXCTR_NCONNECT_CONNECT       (0x0 << 15)
+#define   PBINMXCTR_NCONNECT_DISCONNECT    (0x1 << 15)
+#define   PBINMXCTR_INOUTSEL_MASK          BIT(14)
+#define   PBINMXCTR_INOUTSEL_IN            (0x0 << 14)
+#define   PBINMXCTR_INOUTSEL_OUT           (0x1 << 14)
+#define   PBINMXCTR_PBINSEL_SHIFT          (8)
+#define   PBINMXCTR_ENDIAN_MASK            GENMASK(5, 4)
+#define   PBINMXCTR_ENDIAN_3210            (0x0 << 4)
+#define   PBINMXCTR_ENDIAN_0123            (0x1 << 4)
+#define   PBINMXCTR_ENDIAN_1032            (0x2 << 4)
+#define   PBINMXCTR_ENDIAN_2301            (0x3 << 4)
+#define   PBINMXCTR_MEMFMT_MASK            GENMASK(3, 0)
+#define   PBINMXCTR_MEMFMT_D0              (0x0 << 0)
+#define   PBINMXCTR_MEMFMT_5_1CH_DMIX      (0x1 << 0)
+#define   PBINMXCTR_MEMFMT_6CH             (0x2 << 0)
+#define   PBINMXCTR_MEMFMT_4CH             (0x3 << 0)
+#define   PBINMXCTR_MEMFMT_DMIX            (0x4 << 0)
+#define   PBINMXCTR_MEMFMT_1CH             (0x5 << 0)
+#define   PBINMXCTR_MEMFMT_16LR            (0x6 << 0)
+#define   PBINMXCTR_MEMFMT_7_1CH           (0x7 << 0)
+#define   PBINMXCTR_MEMFMT_7_1CH_DMIX      (0x8 << 0)
+#define   PBINMXCTR_MEMFMT_STREAM          (0xf << 0)
+#define PBINMXPAUSECTR0(n)               (0x20204 + 0x40 * (n))
+#define PBINMXPAUSECTR1(n)               (0x20208 + 0x40 * (n))
+
+/* AOUT */
+#define AOUTENCTR0                       0x40040
+#define AOUTENCTR1                       0x40044
+#define AOUTENCTR2                       0x40048
+#define AOUTRSTCTR0                      0x40060
+#define AOUTRSTCTR1                      0x40064
+#define AOUTRSTCTR2                      0x40068
+#define AOUTSRCRSTCTR0                   0x400c0
+#define AOUTSRCRSTCTR1                   0x400c4
+#define AOUTSRCRSTCTR2                   0x400c8
+
+/* AOUT(PCMOUTN) */
+#define OPORTMXCTR1(n)                   (0x42000 + 0x400 * (n))
+#define   OPORTMXCTR1_I2SLRSEL_MASK        (0x11 << 10)
+#define   OPORTMXCTR1_I2SLRSEL_RIGHT       (0x00 << 10)
+#define   OPORTMXCTR1_I2SLRSEL_LEFT        (0x01 << 10)
+#define   OPORTMXCTR1_I2SLRSEL_I2S         (0x11 << 10)
+#define   OPORTMXCTR1_OUTBITSEL_MASK       (0x800003U << 8)
+#define   OPORTMXCTR1_OUTBITSEL_32         (0x800000U << 8)
+#define   OPORTMXCTR1_OUTBITSEL_24         (0x000000U << 8)
+#define   OPORTMXCTR1_OUTBITSEL_20         (0x000001U << 8)
+#define   OPORTMXCTR1_OUTBITSEL_16         (0x000002U << 8)
+#define   OPORTMXCTR1_FSSEL_MASK           GENMASK(3, 0)
+#define   OPORTMXCTR1_FSSEL_48             (0x0 << 0)
+#define   OPORTMXCTR1_FSSEL_96             (0x1 << 0)
+#define   OPORTMXCTR1_FSSEL_192            (0x2 << 0)
+#define   OPORTMXCTR1_FSSEL_32             (0x3 << 0)
+#define   OPORTMXCTR1_FSSEL_44_1           (0x4 << 0)
+#define   OPORTMXCTR1_FSSEL_88_2           (0x5 << 0)
+#define   OPORTMXCTR1_FSSEL_176_4          (0x6 << 0)
+#define   OPORTMXCTR1_FSSEL_16             (0x8 << 0)
+#define   OPORTMXCTR1_FSSEL_22_05          (0x9 << 0)
+#define   OPORTMXCTR1_FSSEL_24             (0xa << 0)
+#define   OPORTMXCTR1_FSSEL_8              (0xb << 0)
+#define   OPORTMXCTR1_FSSEL_11_025         (0xc << 0)
+#define   OPORTMXCTR1_FSSEL_12             (0xd << 0)
+#define OPORTMXCTR2(n)                   (0x42004 + 0x400 * (n))
+#define   OPORTMXCTR2_ACLKSEL_MASK         GENMASK(19, 16)
+#define   OPORTMXCTR2_ACLKSEL_A1           (0x0 << 16)
+#define   OPORTMXCTR2_ACLKSEL_F1           (0x1 << 16)
+#define   OPORTMXCTR2_ACLKSEL_A2           (0x2 << 16)
+#define   OPORTMXCTR2_ACLKSEL_F2           (0x3 << 16)
+#define   OPORTMXCTR2_ACLKSEL_A2PLL        (0x4 << 16)
+#define   OPORTMXCTR2_ACLKSEL_RX1          (0x5 << 16)
+#define   OPORTMXCTR2_ACLKSEL_RX2          (0x6 << 16)
+#define   OPORTMXCTR2_MSSEL_MASK           BIT(15)
+#define   OPORTMXCTR2_MSSEL_SLAVE          (0x0 << 15)
+#define   OPORTMXCTR2_MSSEL_MASTER         (0x1 << 15)
+#define   OPORTMXCTR2_EXTLSIFSSEL_MASK     BIT(14)
+#define   OPORTMXCTR2_EXTLSIFSSEL_36       (0x0 << 14)
+#define   OPORTMXCTR2_EXTLSIFSSEL_24       (0x1 << 14)
+#define   OPORTMXCTR2_DACCKSEL_MASK        GENMASK(9, 8)
+#define   OPORTMXCTR2_DACCKSEL_1_2         (0x0 << 8)
+#define   OPORTMXCTR2_DACCKSEL_1_3         (0x1 << 8)
+#define   OPORTMXCTR2_DACCKSEL_1_1         (0x2 << 8)
+#define   OPORTMXCTR2_DACCKSEL_2_3         (0x3 << 8)
+#define OPORTMXCTR3(n)                   (0x42008 + 0x400 * (n))
+#define   OPORTMXCTR3_IECTHUR_MASK         BIT(19)
+#define   OPORTMXCTR3_IECTHUR_IECOUT       (0x0 << 19)
+#define   OPORTMXCTR3_IECTHUR_IECIN        (0x1 << 19)
+#define   OPORTMXCTR3_SRCSEL_MASK          GENMASK(18, 16)
+#define   OPORTMXCTR3_SRCSEL_PCM           (0x0 << 16)
+#define   OPORTMXCTR3_SRCSEL_STREAM        (0x1 << 16)
+#define   OPORTMXCTR3_SRCSEL_CDDTS         (0x2 << 16)
+#define   OPORTMXCTR3_VALID_MASK           BIT(12)
+#define   OPORTMXCTR3_VALID_PCM            (0x0 << 12)
+#define   OPORTMXCTR3_VALID_STREAM         (0x1 << 12)
+#define   OPORTMXCTR3_PMSEL_MASK           BIT(3)
+#define   OPORTMXCTR3_PMSEL_MUTE           (0x0 << 3)
+#define   OPORTMXCTR3_PMSEL_PAUSE          (0x1 << 3)
+#define   OPORTMXCTR3_PMSW_MASK            BIT(2)
+#define   OPORTMXCTR3_PMSW_MUTE_OFF        (0x0 << 2)
+#define   OPORTMXCTR3_PMSW_MUTE_ON         (0x1 << 2)
+#define OPORTMXSRC1CTR(n)                (0x4200c + 0x400 * (n))
+#define   OPORTMXSRC1CTR_FSIIPNUM_SHIFT    (24)
+#define   OPORTMXSRC1CTR_THMODE_MASK       BIT(23)
+#define   OPORTMXSRC1CTR_THMODE_SRC        (0x0 << 23)
+#define   OPORTMXSRC1CTR_THMODE_BYPASS     (0x1 << 23)
+#define   OPORTMXSRC1CTR_LOCK_MASK         BIT(16)
+#define   OPORTMXSRC1CTR_LOCK_UNLOCK       (0x0 << 16)
+#define   OPORTMXSRC1CTR_LOCK_LOCK         (0x1 << 16)
+#define   OPORTMXSRC1CTR_SRCPATH_MASK      BIT(15)
+#define   OPORTMXSRC1CTR_SRCPATH_BYPASS    (0x0 << 15)
+#define   OPORTMXSRC1CTR_SRCPATH_CALC      (0x1 << 15)
+#define   OPORTMXSRC1CTR_SYNC_MASK         BIT(14)
+#define   OPORTMXSRC1CTR_SYNC_ASYNC        (0x0 << 14)
+#define   OPORTMXSRC1CTR_SYNC_SYNC         (0x1 << 14)
+#define   OPORTMXSRC1CTR_FSOCK_MASK        GENMASK(11, 10)
+#define   OPORTMXSRC1CTR_FSOCK_44_1        (0x0 << 10)
+#define   OPORTMXSRC1CTR_FSOCK_48          (0x1 << 10)
+#define   OPORTMXSRC1CTR_FSOCK_32          (0x2 << 10)
+#define   OPORTMXSRC1CTR_FSICK_MASK        GENMASK(9, 8)
+#define   OPORTMXSRC1CTR_FSICK_44_1        (0x0 << 8)
+#define   OPORTMXSRC1CTR_FSICK_48          (0x1 << 8)
+#define   OPORTMXSRC1CTR_FSICK_32          (0x2 << 8)
+#define   OPORTMXSRC1CTR_FSIIPSEL_MASK     GENMASK(5, 4)
+#define   OPORTMXSRC1CTR_FSIIPSEL_INNER    (0x0 << 4)
+#define   OPORTMXSRC1CTR_FSIIPSEL_OUTER    (0x1 << 4)
+#define   OPORTMXSRC1CTR_FSISEL_MASK       GENMASK(3, 0)
+#define   OPORTMXSRC1CTR_FSISEL_ACLK       (0x0 << 0)
+#define   OPORTMXSRC1CTR_FSISEL_DD         (0x1 << 0)
+#define OPORTMXDSDMUTEDAT(n)             (0x42020 + 0x400 * (n))
+#define OPORTMXDXDFREQMODE(n)            (0x42024 + 0x400 * (n))
+#define OPORTMXDSDSEL(n)                 (0x42028 + 0x400 * (n))
+#define OPORTMXDSDPORT(n)                (0x4202c + 0x400 * (n))
+#define OPORTMXACLKSEL0EX(n)             (0x42030 + 0x400 * (n))
+#define OPORTMXPATH(n)                   (0x42040 + 0x400 * (n))
+#define OPORTMXSYNC(n)                   (0x42044 + 0x400 * (n))
+#define OPORTMXREPET(n)                  (0x42050 + 0x400 * (n))
+#define   OPORTMXREPET_STRLENGTH_AC3       SBF_(IEC61937_FRM_STR_AC3, 16)
+#define   OPORTMXREPET_STRLENGTH_MPA       SBF_(IEC61937_FRM_STR_MPA, 16)
+#define   OPORTMXREPET_STRLENGTH_MP3       SBF_(IEC61937_FRM_STR_MP3, 16)
+#define   OPORTMXREPET_STRLENGTH_DTS1      SBF_(IEC61937_FRM_STR_DTS1, 16)
+#define   OPORTMXREPET_STRLENGTH_DTS2      SBF_(IEC61937_FRM_STR_DTS2, 16)
+#define   OPORTMXREPET_STRLENGTH_DTS3      SBF_(IEC61937_FRM_STR_DTS3, 16)
+#define   OPORTMXREPET_STRLENGTH_AAC       SBF_(IEC61937_FRM_STR_AAC, 16)
+#define   OPORTMXREPET_PMLENGTH_AC3        SBF_(IEC61937_FRM_PAU_AC3, 0)
+#define   OPORTMXREPET_PMLENGTH_MPA        SBF_(IEC61937_FRM_PAU_MPA, 0)
+#define   OPORTMXREPET_PMLENGTH_MP3        SBF_(IEC61937_FRM_PAU_MP3, 0)
+#define   OPORTMXREPET_PMLENGTH_DTS1       SBF_(IEC61937_FRM_PAU_DTS1, 0)
+#define   OPORTMXREPET_PMLENGTH_DTS2       SBF_(IEC61937_FRM_PAU_DTS2, 0)
+#define   OPORTMXREPET_PMLENGTH_DTS3       SBF_(IEC61937_FRM_PAU_DTS3, 0)
+#define   OPORTMXREPET_PMLENGTH_AAC        SBF_(IEC61937_FRM_PAU_AAC, 0)
+#define OPORTMXPAUDAT(n)                 (0x42054 + 0x400 * (n))
+#define   OPORTMXPAUDAT_PAUSEPC_CMN        (IEC61937_PC_PAUSE << 16)
+#define   OPORTMXPAUDAT_PAUSEPD_AC3        (IEC61937_FRM_PAU_AC3 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_MPA        (IEC61937_FRM_PAU_MPA * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_MP3        (IEC61937_FRM_PAU_MP3 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_DTS1       (IEC61937_FRM_PAU_DTS1 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_DTS2       (IEC61937_FRM_PAU_DTS2 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_DTS3       (IEC61937_FRM_PAU_DTS3 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_AAC        (IEC61937_FRM_PAU_AAC * 4)
+#define OPORTMXRATE_I(n)                 (0x420e4 + 0x400 * (n))
+#define   OPORTMXRATE_I_EQU_MASK           BIT(31)
+#define   OPORTMXRATE_I_EQU_NOTEQUAL       (0x0 << 31)
+#define   OPORTMXRATE_I_EQU_EQUAL          (0x1 << 31)
+#define   OPORTMXRATE_I_SRCBPMD_MASK       BIT(29)
+#define   OPORTMXRATE_I_SRCBPMD_BYPASS     (0x0 << 29)
+#define   OPORTMXRATE_I_SRCBPMD_SRC        (0x1 << 29)
+#define   OPORTMXRATE_I_LRCKSTP_MASK       BIT(24)
+#define   OPORTMXRATE_I_LRCKSTP_START      (0x0 << 24)
+#define   OPORTMXRATE_I_LRCKSTP_STOP       (0x1 << 24)
+#define   OPORTMXRATE_I_ACLKSRC_MASK       GENMASK(15, 12)
+#define   OPORTMXRATE_I_ACLKSRC_APLL       (0x0 << 12)
+#define   OPORTMXRATE_I_ACLKSRC_USB        (0x1 << 12)
+#define   OPORTMXRATE_I_ACLKSRC_HSC        (0x3 << 12)
+/* if OPORTMXRATE_I_ACLKSRC_APLL */
+#define   OPORTMXRATE_I_ACLKSEL_MASK       GENMASK(11, 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLA1     (0x0 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLF1     (0x1 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLA2     (0x2 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLF2     (0x3 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLL       (0x4 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_HDMI1      (0x5 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_HDMI2      (0x6 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_AI1ADCCK   (0xc << 8)
+#define   OPORTMXRATE_I_ACLKSEL_AI2ADCCK   (0xd << 8)
+#define   OPORTMXRATE_I_ACLKSEL_AI3ADCCK   (0xe << 8)
+#define   OPORTMXRATE_I_MCKSEL_MASK        GENMASK(7, 4)
+#define   OPORTMXRATE_I_MCKSEL_36          (0x0 << 4)
+#define   OPORTMXRATE_I_MCKSEL_33          (0x1 << 4)
+#define   OPORTMXRATE_I_MCKSEL_HSC27       (0xb << 4)
+#define   OPORTMXRATE_I_FSSEL_MASK         GENMASK(3, 0)
+#define   OPORTMXRATE_I_FSSEL_48           (0x0 << 0)
+#define   OPORTMXRATE_I_FSSEL_96           (0x1 << 0)
+#define   OPORTMXRATE_I_FSSEL_192          (0x2 << 0)
+#define   OPORTMXRATE_I_FSSEL_32           (0x3 << 0)
+#define   OPORTMXRATE_I_FSSEL_44_1         (0x4 << 0)
+#define   OPORTMXRATE_I_FSSEL_88_2         (0x5 << 0)
+#define   OPORTMXRATE_I_FSSEL_176_4        (0x6 << 0)
+#define   OPORTMXRATE_I_FSSEL_16           (0x8 << 0)
+#define   OPORTMXRATE_I_FSSEL_22_05        (0x9 << 0)
+#define   OPORTMXRATE_I_FSSEL_24           (0xa << 0)
+#define   OPORTMXRATE_I_FSSEL_8            (0xb << 0)
+#define   OPORTMXRATE_I_FSSEL_11_025       (0xc << 0)
+#define   OPORTMXRATE_I_FSSEL_12           (0xd << 0)
+#define OPORTMXEXNOE(n)                  (0x420f0 + 0x400 * (n))
+#define OPORTMXMASK(n)                   (0x420f8 + 0x400 * (n))
+#define   OPORTMXMASK_IUDXMSK_MASK         GENMASK(28, 24)
+#define   OPORTMXMASK_IUDXMSK_ON           (0x00 << 24)
+#define   OPORTMXMASK_IUDXMSK_OFF          (0x1f << 24)
+#define   OPORTMXMASK_IUXCKMSK_MASK        GENMASK(18, 16)
+#define   OPORTMXMASK_IUXCKMSK_ON          (0x0 << 16)
+#define   OPORTMXMASK_IUXCKMSK_OFF         (0x7 << 16)
+#define   OPORTMXMASK_DXMSK_MASK           GENMASK(12, 8)
+#define   OPORTMXMASK_DXMSK_ON             (0x00 << 8)
+#define   OPORTMXMASK_DXMSK_OFF            (0x1f << 8)
+#define   OPORTMXMASK_XCKMSK_MASK          GENMASK(2, 0)
+#define   OPORTMXMASK_XCKMSK_ON            (0x0 << 0)
+#define   OPORTMXMASK_XCKMSK_OFF           (0x7 << 0)
+#define OPORTMXDEBUG(n)                  (0x420fc + 0x400 * (n))
+#define OPORTMXT0RSTCTR(n)               (0x4211c + 0x400 * (n))
+#define OPORTMXT1RSTCTR(n)               (0x4213c + 0x400 * (n))
+#define OPORTMXT2RSTCTR(n)               (0x4215c + 0x400 * (n))
+#define OPORTMXT3RSTCTR(n)               (0x4217c + 0x400 * (n))
+#define OPORTMXT4RSTCTR(n)               (0x4219c + 0x400 * (n))
+
+#define SBF_(frame, shift)    (((frame) * 2 - 1) << shift)
+
+/* AOUT(PBoutMX) */
+#define PBOUTMXCTR0(n)                   (0x40200 + 0x40 * (n))
+#define   PBOUTMXCTR0_ENDIAN_MASK         GENMASK(5, 4)
+#define   PBOUTMXCTR0_ENDIAN_3210         (0x0 << 4)
+#define   PBOUTMXCTR0_ENDIAN_0123         (0x1 << 4)
+#define   PBOUTMXCTR0_ENDIAN_1032         (0x2 << 4)
+#define   PBOUTMXCTR0_ENDIAN_2301         (0x3 << 4)
+#define   PBOUTMXCTR0_MEMFMT_MASK         GENMASK(3, 0)
+#define   PBOUTMXCTR0_MEMFMT_10CH         (0x0 << 0)
+#define   PBOUTMXCTR0_MEMFMT_8CH          (0x1 << 0)
+#define   PBOUTMXCTR0_MEMFMT_6CH          (0x2 << 0)
+#define   PBOUTMXCTR0_MEMFMT_4CH          (0x3 << 0)
+#define   PBOUTMXCTR0_MEMFMT_2CH          (0x4 << 0)
+#define   PBOUTMXCTR0_MEMFMT_STREAM       (0x5 << 0)
+#define   PBOUTMXCTR0_MEMFMT_1CH          (0x6 << 0)
+#define PBOUTMXCTR1(n)                   (0x40204 + 0x40 * (n))
+#define PBOUTMXINTCTR(n)                 (0x40208 + 0x40 * (n))
+
+/* A2D(subsystem) */
+#define CDA2D_STRT0                      0x10000
+#define   CDA2D_STRT0_STOP_MASK            BIT(31)
+#define   CDA2D_STRT0_STOP_START           (0x0 << 31)
+#define   CDA2D_STRT0_STOP_STOP            (0x1 << 31)
+#define CDA2D_STAT0                      0x10020
+#define CDA2D_TEST                       0x100a0
+#define   CDA2D_TEST_DDR_MODE_MASK         GENMASK(3, 2)
+#define   CDA2D_TEST_DDR_MODE_EXTON0       (0x0 << 2)
+#define   CDA2D_TEST_DDR_MODE_EXTOFF1      (0x3 << 2)
+#define CDA2D_STRTADRSLOAD               0x100b0
+
+#define CDA2D_CHMXCTRL1(n)               (0x12000 + 0x80 * (n))
+#define   CDA2D_CHMXCTRL1_INDSIZE_MASK     BIT(0)
+#define   CDA2D_CHMXCTRL1_INDSIZE_FINITE   (0x0 << 0)
+#define   CDA2D_CHMXCTRL1_INDSIZE_INFINITE (0x1 << 0)
+#define CDA2D_CHMXCTRL2(n)               (0x12004 + 0x80 * (n))
+#define CDA2D_CHMXSRCAMODE(n)            (0x12020 + 0x80 * (n))
+#define CDA2D_CHMXDSTAMODE(n)            (0x12024 + 0x80 * (n))
+#define   CDA2D_CHMXAMODE_ENDIAN_MASK      GENMASK(17, 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_3210      (0x0 << 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_0123      (0x1 << 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_1032      (0x2 << 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_2301      (0x3 << 16)
+#define   CDA2D_CHMXAMODE_RSSEL_SHIFT      (8)
+#define   CDA2D_CHMXAMODE_AUPDT_MASK       GENMASK(5, 4)
+#define   CDA2D_CHMXAMODE_AUPDT_INC        (0x0 << 4)
+#define   CDA2D_CHMXAMODE_AUPDT_FIX        (0x2 << 4)
+#define   CDA2D_CHMXAMODE_TYPE_MASK        GENMASK(3, 2)
+#define   CDA2D_CHMXAMODE_TYPE_NORMAL      (0x0 << 2)
+#define   CDA2D_CHMXAMODE_TYPE_RING        (0x1 << 2)
+#define CDA2D_CHMXSRCSTRTADRS(n)         (0x12030 + 0x80 * (n))
+#define CDA2D_CHMXSRCSTRTADRSU(n)        (0x12034 + 0x80 * (n))
+#define CDA2D_CHMXDSTSTRTADRS(n)         (0x12038 + 0x80 * (n))
+#define CDA2D_CHMXDSTSTRTADRSU(n)        (0x1203c + 0x80 * (n))
+
+/* A2D(ring buffer) */
+#define CDA2D_RBFLUSH0                   0x10040
+#define CDA2D_RBADRSLOAD                 0x100b4
+#define CDA2D_RDPTRLOAD                  0x100b8
+#define   CDA2D_RDPTRLOAD_LSFLAG_LOAD      (0x0 << 31)
+#define   CDA2D_RDPTRLOAD_LSFLAG_STORE     (0x1 << 31)
+#define CDA2D_WRPTRLOAD                  0x100bc
+#define   CDA2D_WRPTRLOAD_LSFLAG_LOAD      (0x0 << 31)
+#define   CDA2D_WRPTRLOAD_LSFLAG_STORE     (0x1 << 31)
+
+#define CDA2D_RBMXBGNADRS(n)             (0x14000 + 0x80 * (n))
+#define CDA2D_RBMXBGNADRSU(n)            (0x14004 + 0x80 * (n))
+#define CDA2D_RBMXENDADRS(n)             (0x14008 + 0x80 * (n))
+#define CDA2D_RBMXENDADRSU(n)            (0x1400c + 0x80 * (n))
+#define CDA2D_RBMXBTH(n)                 (0x14038 + 0x80 * (n))
+#define CDA2D_RBMXRTH(n)                 (0x1403c + 0x80 * (n))
+#define CDA2D_RBMXRDPTR(n)               (0x14020 + 0x80 * (n))
+#define CDA2D_RBMXRDPTRU(n)              (0x14024 + 0x80 * (n))
+#define CDA2D_RBMXWRPTR(n)               (0x14028 + 0x80 * (n))
+#define CDA2D_RBMXWRPTRU(n)              (0x1402c + 0x80 * (n))
+#define   CDA2D_RBMXPTRU_PTRU_MASK         GENMASK(1, 0)
+#define CDA2D_RBMXCNFG(n)                (0x14030 + 0x80 * (n))
+#define CDA2D_RBMXIR(n)                  (0x14014 + 0x80 * (n))
+#define CDA2D_RBMXIE(n)                  (0x14018 + 0x80 * (n))
+#define CDA2D_RBMXID(n)                  (0x1401c + 0x80 * (n))
+#define   CDA2D_RBMXIX_SPACE               BIT(3)
+#define   CDA2D_RBMXIX_REMAIN              BIT(4)
+
+#endif /* SND_UNIPHIER_AIO_REG_H__ */
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
new file mode 100644
index 000000000000..774abae28028
--- /dev/null
+++ b/sound/soc/uniphier/aio.h
@@ -0,0 +1,343 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Socionext UniPhier AIO ALSA driver.
+ *
+ * Copyright (c) 2016-2018 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SND_UNIPHIER_AIO_H__
+#define SND_UNIPHIER_AIO_H__
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+struct platform_device;
+
+enum ID_PORT_TYPE {
+	PORT_TYPE_UNKNOWN,
+	PORT_TYPE_I2S,
+	PORT_TYPE_SPDIF,
+	PORT_TYPE_EVE,
+	PORT_TYPE_CONV,
+};
+
+enum ID_PORT_DIR {
+	PORT_DIR_OUTPUT,
+	PORT_DIR_INPUT,
+};
+
+enum IEC61937_PC {
+	IEC61937_PC_AC3   = 0x0001,
+	IEC61937_PC_PAUSE = 0x0003,
+	IEC61937_PC_MPA   = 0x0004,
+	IEC61937_PC_MP3   = 0x0005,
+	IEC61937_PC_DTS1  = 0x000b,
+	IEC61937_PC_DTS2  = 0x000c,
+	IEC61937_PC_DTS3  = 0x000d,
+	IEC61937_PC_AAC   = 0x0007,
+};
+
+/* IEC61937 Repetition period of data-burst in IEC60958 frames */
+#define IEC61937_FRM_STR_AC3       1536
+#define IEC61937_FRM_STR_MPA       1152
+#define IEC61937_FRM_STR_MP3       1152
+#define IEC61937_FRM_STR_DTS1      512
+#define IEC61937_FRM_STR_DTS2      1024
+#define IEC61937_FRM_STR_DTS3      2048
+#define IEC61937_FRM_STR_AAC       1024
+
+/* IEC61937 Repetition period of Pause data-burst in IEC60958 frames */
+#define IEC61937_FRM_PAU_AC3       3
+#define IEC61937_FRM_PAU_MPA       32
+#define IEC61937_FRM_PAU_MP3       32
+#define IEC61937_FRM_PAU_DTS1      3
+#define IEC61937_FRM_PAU_DTS2      3
+#define IEC61937_FRM_PAU_DTS3      3
+#define IEC61937_FRM_PAU_AAC       32
+
+/* IEC61937 Pa and Pb */
+#define IEC61937_HEADER_SIGN       0x1f4e72f8
+
+#define AUD_HW_PCMIN1    0
+#define AUD_HW_PCMIN2    1
+#define AUD_HW_PCMIN3    2
+#define AUD_HW_IECIN1    3
+#define AUD_HW_DIECIN1   4
+
+#define AUD_NAME_PCMIN1     "aio-pcmin1"
+#define AUD_NAME_PCMIN2     "aio-pcmin2"
+#define AUD_NAME_PCMIN3     "aio-pcmin3"
+#define AUD_NAME_IECIN1     "aio-iecin1"
+#define AUD_NAME_DIECIN1    "aio-diecin1"
+
+#define AUD_HW_HPCMOUT1    0
+#define AUD_HW_PCMOUT1     1
+#define AUD_HW_PCMOUT2     2
+#define AUD_HW_PCMOUT3     3
+#define AUD_HW_EPCMOUT1    4
+#define AUD_HW_EPCMOUT2    5
+#define AUD_HW_EPCMOUT3    6
+#define AUD_HW_EPCMOUT6    9
+#define AUD_HW_HIECOUT1    10
+#define AUD_HW_IECOUT1     11
+#define AUD_HW_CMASTER     31
+
+#define AUD_NAME_HPCMOUT1        "aio-hpcmout1"
+#define AUD_NAME_PCMOUT1         "aio-pcmout1"
+#define AUD_NAME_PCMOUT2         "aio-pcmout2"
+#define AUD_NAME_PCMOUT3         "aio-pcmout3"
+#define AUD_NAME_EPCMOUT1        "aio-epcmout1"
+#define AUD_NAME_EPCMOUT2        "aio-epcmout2"
+#define AUD_NAME_EPCMOUT3        "aio-epcmout3"
+#define AUD_NAME_EPCMOUT6        "aio-epcmout6"
+#define AUD_NAME_HIECOUT1        "aio-hiecout1"
+#define AUD_NAME_IECOUT1         "aio-iecout1"
+#define AUD_NAME_CMASTER         "aio-cmaster"
+#define AUD_NAME_HIECCOMPOUT1    "aio-hieccompout1"
+
+#define AUD_GNAME_HDMI    "aio-hdmi"
+#define AUD_GNAME_LINE    "aio-line"
+#define AUD_GNAME_IEC     "aio-iec"
+
+#define AUD_CLK_IO        0
+#define AUD_CLK_A1        1
+#define AUD_CLK_F1        2
+#define AUD_CLK_A2        3
+#define AUD_CLK_F2        4
+#define AUD_CLK_A         5
+#define AUD_CLK_F         6
+#define AUD_CLK_APLL      7
+#define AUD_CLK_RX0       8
+#define AUD_CLK_USB0      9
+#define AUD_CLK_HSC0      10
+
+#define AUD_PLL_A1        0
+#define AUD_PLL_F1        1
+#define AUD_PLL_A2        2
+#define AUD_PLL_F2        3
+#define AUD_PLL_APLL      4
+#define AUD_PLL_RX0       5
+#define AUD_PLL_USB0      6
+#define AUD_PLL_HSC0      7
+
+#define AUD_PLLDIV_1_2    0
+#define AUD_PLLDIV_1_3    1
+#define AUD_PLLDIV_1_1    2
+#define AUD_PLLDIV_2_3    3
+
+#define AUD_RING_SIZE            (128 * 1024)
+
+#define AUD_MIN_FRAGMENT         4
+#define AUD_MAX_FRAGMENT         8
+#define AUD_MIN_FRAGMENT_SIZE    (4 * 1024)
+#define AUD_MAX_FRAGMENT_SIZE    (16 * 1024)
+
+/*
+ * This is a selector for virtual register map of AIO.
+ *
+ * map:  Specify the index of virtual register map.
+ * hw :  Specify the ID of real register map, selector uses this value.
+ *       A meaning of this value depends specification of SoC.
+ */
+struct uniphier_aio_selector {
+	int map;
+	int hw;
+};
+
+/**
+ * 'SoftWare MAPping' setting of UniPhier AIO registers.
+ *
+ * We have to setup 'virtual' register maps to access 'real' registers of AIO.
+ * This feature is legacy and meaningless but AIO needs this to work.
+ *
+ * Each hardware blocks have own virtual register maps as following:
+ *
+ * Address Virtual                      Real
+ * ------- ---------                    ---------------
+ * 0x12000 DMAC map0 --> [selector] --> DMAC hardware 3
+ * 0x12080 DMAC map1 --> [selector] --> DMAC hardware 1
+ * ...
+ * 0x42000 Port map0 --> [selector] --> Port hardware 1
+ * 0x42400 Port map1 --> [selector] --> Port hardware 2
+ * ...
+ *
+ * ch   : Input or output channel of DMAC
+ * rb   : Ring buffer
+ * iport: PCM input port
+ * iif  : Input interface
+ * oport: PCM output port
+ * oif  : Output interface
+ * och  : Output channel of DMAC for sampling rate converter
+ *
+ * These are examples for sound data paths:
+ *
+ * For caputure device:
+ *   (outer of AIO) -> iport -> iif -> ch -> rb -> (CPU)
+ * For playback device:
+ *   (CPU) -> rb -> ch -> oif -> oport -> (outer of AIO)
+ * For sampling rate converter device:
+ *   (CPU) -> rb -> ch -> oif -> (HW SRC) -> iif -> och -> orb -> (CPU)
+ */
+struct uniphier_aio_swmap {
+	int type;
+	int dir;
+
+	struct uniphier_aio_selector ch;
+	struct uniphier_aio_selector rb;
+	struct uniphier_aio_selector iport;
+	struct uniphier_aio_selector iif;
+	struct uniphier_aio_selector oport;
+	struct uniphier_aio_selector oif;
+	struct uniphier_aio_selector och;
+};
+
+struct uniphier_aio_spec {
+	const char *name;
+	const char *gname;
+	struct uniphier_aio_swmap swm;
+};
+
+struct uniphier_aio_pll {
+	bool enable;
+	unsigned int freq;
+};
+
+struct uniphier_aio_chip_spec {
+	const struct uniphier_aio_spec *specs;
+	int num_specs;
+	const struct uniphier_aio_pll *plls;
+	int num_plls;
+	struct snd_soc_dai_driver *dais;
+	int num_dais;
+
+	/* DMA access mode, this is workaround for DMA hungup */
+	int addr_ext;
+};
+
+struct uniphier_aio_sub {
+	struct uniphier_aio *aio;
+
+	/* Guard sub->rd_offs and wr_offs from IRQ handler. */
+	spinlock_t lock;
+
+	const struct uniphier_aio_swmap *swm;
+	const struct uniphier_aio_spec *spec;
+
+	/* For PCM audio */
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_hw_params params;
+
+	/* For compress audio */
+	struct snd_compr_stream *cstream;
+	struct snd_compr_params cparams;
+	unsigned char *compr_area;
+	dma_addr_t compr_addr;
+	size_t compr_bytes;
+	int pass_through;
+	enum IEC61937_PC iec_pc;
+	bool iec_header;
+
+	/* Both PCM and compress audio */
+	bool use_mmap;
+	int setting;
+	int running;
+	u64 rd_offs;
+	u64 wr_offs;
+	u32 threshold;
+	u64 rd_org;
+	u64 wr_org;
+	u64 rd_total;
+	u64 wr_total;
+};
+
+struct uniphier_aio {
+	struct uniphier_aio_chip *chip;
+
+	struct uniphier_aio_sub sub[2];
+
+	unsigned int fmt;
+	/* Set one of AUD_CLK_X */
+	int clk_in;
+	int clk_out;
+	/* Set one of AUD_PLL_X */
+	int pll_in;
+	int pll_out;
+	/* Set one of AUD_PLLDIV_X */
+	int plldiv;
+};
+
+struct uniphier_aio_chip {
+	struct platform_device *pdev;
+	const struct uniphier_aio_chip_spec *chip_spec;
+
+	struct uniphier_aio *aios;
+	int num_aios;
+	struct uniphier_aio_pll *plls;
+	int num_plls;
+
+	struct clk *clk;
+	struct reset_control *rst;
+	struct regmap *regmap;
+	int active;
+};
+
+static inline struct uniphier_aio *uniphier_priv(struct snd_soc_dai *dai)
+{
+	struct uniphier_aio_chip *chip = snd_soc_dai_get_drvdata(dai);
+
+	return &chip->aios[dai->id];
+}
+
+u64 aio_rb_cnt(struct uniphier_aio_sub *sub);
+u64 aio_rbt_cnt_to_end(struct uniphier_aio_sub *sub);
+u64 aio_rb_space(struct uniphier_aio_sub *sub);
+u64 aio_rb_space_to_end(struct uniphier_aio_sub *sub);
+
+int aio_chip_set_pll(struct uniphier_aio_chip *chip, int pll_id,
+		     unsigned int freq);
+void aio_chip_init(struct uniphier_aio_chip *chip);
+int aio_init(struct uniphier_aio_sub *sub);
+void aio_port_reset(struct uniphier_aio_sub *sub);
+int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate);
+int aio_port_set_fmt(struct uniphier_aio_sub *sub);
+int aio_port_set_clk(struct uniphier_aio_sub *sub);
+int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
+		       const struct snd_pcm_hw_params *params);
+void aio_port_set_enable(struct uniphier_aio_sub *sub, int enable);
+int aio_if_set_param(struct uniphier_aio_sub *sub, int pass_through);
+int aio_oport_set_stream_type(struct uniphier_aio_sub *sub,
+			      enum IEC61937_PC pc);
+void aio_src_reset(struct uniphier_aio_sub *sub);
+int aio_src_set_param(struct uniphier_aio_sub *sub,
+		      const struct snd_pcm_hw_params *params);
+int aio_srcif_set_param(struct uniphier_aio_sub *sub);
+int aio_srcch_set_param(struct uniphier_aio_sub *sub);
+void aio_srcch_set_enable(struct uniphier_aio_sub *sub, int enable);
+
+int aiodma_ch_set_param(struct uniphier_aio_sub *sub);
+void aiodma_ch_set_enable(struct uniphier_aio_sub *sub, int enable);
+int aiodma_rb_set_threshold(struct uniphier_aio_sub *sub, u64 size, u32 th);
+int aiodma_rb_set_buffer(struct uniphier_aio_sub *sub, u64 start, u64 end,
+			 int period);
+void aiodma_rb_sync(struct uniphier_aio_sub *sub, u64 start, u64 size,
+		    int period);
+bool aiodma_rb_is_irq(struct uniphier_aio_sub *sub);
+void aiodma_rb_clear_irq(struct uniphier_aio_sub *sub);
+
+#endif /* SND_UNIPHIER_AIO_H__ */
-- 
2.15.0
