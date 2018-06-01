Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeFALF7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:05:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38452 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeFALFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:05:53 -0400
From: Mark Brown <broonie@kernel.org>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: TSCS454: Add Support" to the asoc tree
In-Reply-To: <20180531202359.GA25353@t7-ThinkPad-E560>
Message-Id: <E1fOhsR-0000Rq-NV@debutante>
Date: Fri, 01 Jun 2018 12:05:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: TSCS454: Add Support

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

>From 0e725b483bbed3c6178c3928fd9b62dadc2eb240 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Thu, 31 May 2018 15:24:07 -0500
Subject: [PATCH] ASoC: TSCS454: Add Support

Currently there is no support for Tempo Semiconductor's TSCS454 CODEC.

Add support for it.

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tscs454.txt     |   23 +
 sound/soc/codecs/Kconfig                      |    8 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/tscs454.c                    | 3497 +++++++++++++++++
 sound/soc/codecs/tscs454.h                    | 2323 +++++++++++
 5 files changed, 5853 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tscs454.txt
 create mode 100644 sound/soc/codecs/tscs454.c
 create mode 100644 sound/soc/codecs/tscs454.h

diff --git a/Documentation/devicetree/bindings/sound/tscs454.txt b/Documentation/devicetree/bindings/sound/tscs454.txt
new file mode 100644
index 000000000000..3ba3e2d2c206
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tscs454.txt
@@ -0,0 +1,23 @@
+TSCS454 Audio CODEC
+
+Required Properties:
+
+	- compatible :	"tempo,tscs454"
+
+	- reg : 	<0x69>
+
+	- clock-names:	Must one of  the following "xtal", "mclk1", "mclk2"
+
+	- clocks:	phandle of the clock that provides the codec sysclk
+
+	Note: If clock is not provided then bit clock is assumed
+
+Example:
+
+redwood: codec@69 {
+	#sound-dai-cells = <1>;
+	compatible = "tempo,tscs454";
+	reg = <0x69>;
+	clock-names = "mclk1";
+	clocks = <&audio_mclk>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 55a989d15b46..63cf62e9c9aa 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -172,6 +172,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TSCS42XX if I2C
+	select SND_SOC_TSCS454 if I2C
 	select SND_SOC_TS3A227E if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_TWL6040 if TWL6040_CORE
@@ -1031,6 +1032,13 @@ config SND_SOC_TSCS42XX
 	help
 	  Add support for Tempo Semiconductor's TSCS42xx audio CODEC.
 
+config SND_SOC_TSCS454
+	tristate "Tempo Semiconductor TSCS454 CODEC"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Add support for Tempo Semiconductor's TSCS454 audio CODEC.
+
 config SND_SOC_TWL4030
 	select MFD_TWL4030_AUDIO
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4c85f3391705..e023fdf85221 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -184,6 +184,7 @@ snd-soc-tlv320aic32x4-spi-objs := tlv320aic32x4-spi.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
 snd-soc-tscs42xx-objs := tscs42xx.o
+snd-soc-tscs454-objs := tscs454.o
 snd-soc-ts3a227e-objs := ts3a227e.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
@@ -440,6 +441,7 @@ obj-$(CONFIG_SND_SOC_TLV320AIC32X4_SPI)	+= snd-soc-tlv320aic32x4-spi.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TSCS42XX)	+= snd-soc-tscs42xx.o
+obj-$(CONFIG_SND_SOC_TSCS454)	+= snd-soc-tscs454.o
 obj-$(CONFIG_SND_SOC_TS3A227E)	+= snd-soc-ts3a227e.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
new file mode 100644
index 000000000000..ff85a0bf6170
--- /dev/null
+++ b/sound/soc/codecs/tscs454.c
@@ -0,0 +1,3497 @@
+// SPDX-License-Identifier: GPL-2.0
+// tscs454.c -- TSCS454 ALSA SoC Audio driver
+// Copyright 2018 Tempo Semiconductor, Inc.
+// Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+
+#include <sound/tlv.h>
+#include <sound/pcm_params.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "tscs454.h"
+
+static const unsigned int PLL_48K_RATE = (48000 * 256);
+static const unsigned int PLL_44_1K_RATE = (44100 * 256);
+
+#define COEFF_SIZE 3
+#define BIQUAD_COEFF_COUNT 5
+#define BIQUAD_SIZE (COEFF_SIZE * BIQUAD_COEFF_COUNT)
+
+#define COEFF_RAM_MAX_ADDR 0xcd
+#define COEFF_RAM_COEFF_COUNT (COEFF_RAM_MAX_ADDR + 1)
+#define COEFF_RAM_SIZE (COEFF_SIZE * COEFF_RAM_COEFF_COUNT)
+
+enum {
+	TSCS454_DAI1_ID,
+	TSCS454_DAI2_ID,
+	TSCS454_DAI3_ID,
+	TSCS454_DAI_COUNT,
+};
+
+struct pll {
+	int id;
+	unsigned int users;
+	struct mutex lock;
+};
+
+static inline void pll_init(struct pll *pll, int id)
+{
+	pll->id = id;
+	mutex_init(&pll->lock);
+}
+
+struct internal_rate {
+	struct pll *pll;
+};
+
+struct aif {
+	unsigned int id;
+	bool master;
+	struct pll *pll;
+};
+
+static inline void aif_init(struct aif *aif, unsigned int id)
+{
+	aif->id = id;
+}
+
+struct coeff_ram {
+	u8 cache[COEFF_RAM_SIZE];
+	bool synced;
+	struct mutex lock;
+};
+
+static inline void init_coeff_ram_cache(u8 *cache)
+{
+	static const u8 norm_addrs[] = { 0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19,
+		0x1f, 0x20, 0x25, 0x2a, 0x2f, 0x34, 0x39, 0x3f, 0x40, 0x45,
+		0x4a, 0x4f, 0x54, 0x59, 0x5f, 0x60, 0x65, 0x6a, 0x6f, 0x74,
+		0x79, 0x7f, 0x80, 0x85, 0x8c, 0x91, 0x96, 0x97, 0x9c, 0xa3,
+		0xa8, 0xad, 0xaf, 0xb0, 0xb5, 0xba, 0xbf, 0xc4, 0xc9};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(norm_addrs); i++)
+		cache[((norm_addrs[i] + 1) * COEFF_SIZE) - 1] = 0x40;
+}
+
+static inline void coeff_ram_init(struct coeff_ram *ram)
+{
+	init_coeff_ram_cache(ram->cache);
+	mutex_init(&ram->lock);
+}
+
+struct aifs_status {
+	u8 streams;
+};
+
+static inline void set_aif_status_active(struct aifs_status *status,
+		int aif_id, bool playback)
+{
+	u8 mask = 0x01 << (aif_id * 2 + !playback);
+
+	status->streams |= mask;
+}
+
+static inline void set_aif_status_inactive(struct aifs_status *status,
+		int aif_id, bool playback)
+{
+	u8 mask = ~(0x01 << (aif_id * 2 + !playback));
+
+	status->streams &= mask;
+}
+
+static bool aifs_active(struct aifs_status *status)
+{
+	return status->streams;
+}
+
+static bool aif_active(struct aifs_status *status, int aif_id)
+{
+	return (0x03 << aif_id * 2) & status->streams;
+}
+
+struct tscs454 {
+	struct regmap *regmap;
+	struct aif aifs[TSCS454_DAI_COUNT];
+
+	struct aifs_status aifs_status;
+	struct mutex aifs_status_lock;
+
+	struct pll pll1;
+	struct pll pll2;
+	struct internal_rate internal_rate;
+
+	struct coeff_ram dac_ram;
+	struct coeff_ram spk_ram;
+	struct coeff_ram sub_ram;
+
+	struct clk *sysclk;
+	int sysclk_src_id;
+	unsigned int bclk_freq;
+};
+
+struct coeff_ram_ctl {
+	unsigned int addr;
+	struct soc_bytes_ext bytes_ext;
+};
+
+static const struct reg_sequence tscs454_patch[] = {
+	/* Assign ASRC out of the box so DAI 1 just works */
+	{ R_AUDIOMUX1, FV_ASRCIMUX_I2S1 | FV_I2S2MUX_I2S2 },
+	{ R_AUDIOMUX2, FV_ASRCOMUX_I2S1 | FV_DACMUX_I2S1 | FV_I2S3MUX_I2S3 },
+	{ R_AUDIOMUX3, FV_CLSSDMUX_I2S1 | FV_SUBMUX_I2S1_LR },
+	{ R_TDMCTL0, FV_TDMMD_256 },
+	{ VIRT_ADDR(0x0A, 0x13), 1 << 3 },
+};
+
+static bool tscs454_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case R_PLLSTAT:
+
+	case R_SPKCRRDL:
+	case R_SPKCRRDM:
+	case R_SPKCRRDH:
+	case R_SPKCRS:
+
+	case R_DACCRRDL:
+	case R_DACCRRDM:
+	case R_DACCRRDH:
+	case R_DACCRS:
+
+	case R_SUBCRRDL:
+	case R_SUBCRRDM:
+	case R_SUBCRRDH:
+	case R_SUBCRS:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool tscs454_writable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case R_SPKCRRDL:
+	case R_SPKCRRDM:
+	case R_SPKCRRDH:
+
+	case R_DACCRRDL:
+	case R_DACCRRDM:
+	case R_DACCRRDH:
+
+	case R_SUBCRRDL:
+	case R_SUBCRRDM:
+	case R_SUBCRRDH:
+		return false;
+	default:
+		return true;
+	};
+}
+
+static bool tscs454_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case R_SPKCRWDL:
+	case R_SPKCRWDM:
+	case R_SPKCRWDH:
+
+	case R_DACCRWDL:
+	case R_DACCRWDM:
+	case R_DACCRWDH:
+
+	case R_SUBCRWDL:
+	case R_SUBCRWDM:
+	case R_SUBCRWDH:
+		return false;
+	default:
+		return true;
+	};
+}
+
+static bool tscs454_precious(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case R_SPKCRWDL:
+	case R_SPKCRWDM:
+	case R_SPKCRWDH:
+	case R_SPKCRRDL:
+	case R_SPKCRRDM:
+	case R_SPKCRRDH:
+
+	case R_DACCRWDL:
+	case R_DACCRWDM:
+	case R_DACCRWDH:
+	case R_DACCRRDL:
+	case R_DACCRRDM:
+	case R_DACCRRDH:
+
+	case R_SUBCRWDL:
+	case R_SUBCRWDM:
+	case R_SUBCRWDH:
+	case R_SUBCRRDL:
+	case R_SUBCRRDM:
+	case R_SUBCRRDH:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_range_cfg tscs454_regmap_range_cfg = {
+	.name = "Pages",
+	.range_min = VIRT_BASE,
+	.range_max = VIRT_ADDR(0xFE, 0x02),
+	.selector_reg = R_PAGESEL,
+	.selector_mask = 0xff,
+	.selector_shift = 0,
+	.window_start = 0,
+	.window_len = 0x100,
+};
+
+static struct regmap_config const tscs454_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = tscs454_writable,
+	.readable_reg = tscs454_readable,
+	.volatile_reg = tscs454_volatile,
+	.precious_reg = tscs454_precious,
+	.ranges = &tscs454_regmap_range_cfg,
+	.num_ranges = 1,
+	.max_register = VIRT_ADDR(0xFE, 0x02),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static inline int tscs454_data_init(struct tscs454 *tscs454,
+		struct i2c_client *i2c)
+{
+	int i;
+	int ret;
+
+	tscs454->regmap = devm_regmap_init_i2c(i2c, &tscs454_regmap_cfg);
+	if (IS_ERR(tscs454->regmap)) {
+		ret = PTR_ERR(tscs454->regmap);
+		return ret;
+	}
+
+	for (i = 0; i < TSCS454_DAI_COUNT; i++)
+		aif_init(&tscs454->aifs[i], i);
+
+	mutex_init(&tscs454->aifs_status_lock);
+	pll_init(&tscs454->pll1, 1);
+	pll_init(&tscs454->pll2, 2);
+
+	coeff_ram_init(&tscs454->dac_ram);
+	coeff_ram_init(&tscs454->spk_ram);
+	coeff_ram_init(&tscs454->sub_ram);
+
+	return 0;
+}
+
+struct reg_setting {
+	unsigned int addr;
+	unsigned int val;
+};
+
+static int coeff_ram_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	struct coeff_ram_ctl *ctl =
+		(struct coeff_ram_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	u8 *coeff_ram;
+	struct mutex *coeff_ram_lock;
+
+	if (strstr(kcontrol->id.name, "DAC")) {
+		coeff_ram = tscs454->dac_ram.cache;
+		coeff_ram_lock = &tscs454->dac_ram.lock;
+	} else if (strstr(kcontrol->id.name, "Speaker")) {
+		coeff_ram = tscs454->spk_ram.cache;
+		coeff_ram_lock = &tscs454->spk_ram.lock;
+	} else if (strstr(kcontrol->id.name, "Sub")) {
+		coeff_ram = tscs454->sub_ram.cache;
+		coeff_ram_lock = &tscs454->sub_ram.lock;
+	} else {
+		return -EINVAL;
+	}
+
+	mutex_lock(coeff_ram_lock);
+
+	memcpy(ucontrol->value.bytes.data,
+		&coeff_ram[ctl->addr * COEFF_SIZE], params->max);
+
+	mutex_unlock(coeff_ram_lock);
+
+	return 0;
+}
+
+#define DACCRSTAT_MAX_TRYS 10
+static int write_coeff_ram(struct snd_soc_component *component, u8 *coeff_ram,
+		unsigned int r_stat, unsigned int r_addr, unsigned int r_wr,
+		unsigned int coeff_addr, unsigned int coeff_cnt)
+{
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	unsigned int val;
+	int cnt;
+	int trys;
+	int ret;
+
+	for (cnt = 0; cnt < coeff_cnt; cnt++, coeff_addr++) {
+
+		for (trys = 0; trys < DACCRSTAT_MAX_TRYS; trys++) {
+			ret = snd_soc_component_read(component, r_stat, &val);
+			if (ret < 0) {
+				dev_err(component->dev,
+					"Failed to read stat (%d)\n", ret);
+				return ret;
+			}
+			if (!val)
+				break;
+		}
+
+		if (trys == DACCRSTAT_MAX_TRYS) {
+			ret = -EIO;
+			dev_err(component->dev,
+				"Coefficient write error (%d)\n", ret);
+			return ret;
+		}
+
+		ret = regmap_write(tscs454->regmap, r_addr, coeff_addr);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to write dac ram address (%d)\n", ret);
+			return ret;
+		}
+
+		ret = regmap_bulk_write(tscs454->regmap, r_wr,
+			&coeff_ram[coeff_addr * COEFF_SIZE],
+			COEFF_SIZE);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to write dac ram (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int coeff_ram_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	struct coeff_ram_ctl *ctl =
+		(struct coeff_ram_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	unsigned int coeff_cnt = params->max / COEFF_SIZE;
+	u8 *coeff_ram;
+	struct mutex *coeff_ram_lock;
+	bool *coeff_ram_synced;
+	unsigned int r_stat;
+	unsigned int r_addr;
+	unsigned int r_wr;
+	unsigned int val;
+	int ret;
+
+	if (strstr(kcontrol->id.name, "DAC")) {
+		coeff_ram = tscs454->dac_ram.cache;
+		coeff_ram_lock = &tscs454->dac_ram.lock;
+		coeff_ram_synced = &tscs454->dac_ram.synced;
+		r_stat = R_DACCRS;
+		r_addr = R_DACCRADD;
+		r_wr = R_DACCRWDL;
+	} else if (strstr(kcontrol->id.name, "Speaker")) {
+		coeff_ram = tscs454->spk_ram.cache;
+		coeff_ram_lock = &tscs454->spk_ram.lock;
+		coeff_ram_synced = &tscs454->spk_ram.synced;
+		r_stat = R_SPKCRS;
+		r_addr = R_SPKCRADD;
+		r_wr = R_SPKCRWDL;
+	} else if (strstr(kcontrol->id.name, "Sub")) {
+		coeff_ram = tscs454->sub_ram.cache;
+		coeff_ram_lock = &tscs454->sub_ram.lock;
+		coeff_ram_synced = &tscs454->sub_ram.synced;
+		r_stat = R_SUBCRS;
+		r_addr = R_SUBCRADD;
+		r_wr = R_SUBCRWDL;
+	} else {
+		return -EINVAL;
+	}
+
+	mutex_lock(coeff_ram_lock);
+
+	*coeff_ram_synced = false;
+
+	memcpy(&coeff_ram[ctl->addr * COEFF_SIZE],
+		ucontrol->value.bytes.data, params->max);
+
+	mutex_lock(&tscs454->pll1.lock);
+	mutex_lock(&tscs454->pll2.lock);
+
+	ret = snd_soc_component_read(component, R_PLLSTAT, &val);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to read PLL status (%d)\n",
+				ret);
+		goto exit;
+	}
+	if (val) { /* PLLs locked */
+		ret = write_coeff_ram(component, coeff_ram,
+			r_stat, r_addr, r_wr,
+			ctl->addr, coeff_cnt);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to flush coeff ram cache (%d)\n", ret);
+			goto exit;
+		}
+		*coeff_ram_synced = true;
+	}
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs454->pll2.lock);
+	mutex_unlock(&tscs454->pll1.lock);
+	mutex_unlock(coeff_ram_lock);
+
+	return ret;
+}
+
+static inline int coeff_ram_sync(struct snd_soc_component *component,
+		struct tscs454 *tscs454)
+{
+	int ret;
+
+	mutex_lock(&tscs454->dac_ram.lock);
+	if (!tscs454->dac_ram.synced) {
+		ret = write_coeff_ram(component, tscs454->dac_ram.cache,
+				R_DACCRS, R_DACCRADD, R_DACCRWDL,
+				0x00, COEFF_RAM_COEFF_COUNT);
+		if (ret < 0) {
+			mutex_unlock(&tscs454->dac_ram.lock);
+			return ret;
+		}
+	}
+	mutex_unlock(&tscs454->dac_ram.lock);
+
+	mutex_lock(&tscs454->spk_ram.lock);
+	if (!tscs454->spk_ram.synced) {
+		ret = write_coeff_ram(component, tscs454->spk_ram.cache,
+				R_SPKCRS, R_SPKCRADD, R_SPKCRWDL,
+				0x00, COEFF_RAM_COEFF_COUNT);
+		if (ret < 0) {
+			mutex_unlock(&tscs454->spk_ram.lock);
+			return ret;
+		}
+	}
+	mutex_unlock(&tscs454->spk_ram.lock);
+
+	mutex_lock(&tscs454->sub_ram.lock);
+	if (!tscs454->sub_ram.synced) {
+		ret = write_coeff_ram(component, tscs454->sub_ram.cache,
+				R_SUBCRS, R_SUBCRADD, R_SUBCRWDL,
+				0x00, COEFF_RAM_COEFF_COUNT);
+		if (ret < 0) {
+			mutex_unlock(&tscs454->sub_ram.lock);
+			return ret;
+		}
+	}
+	mutex_unlock(&tscs454->sub_ram.lock);
+
+	return 0;
+}
+
+#define PLL_REG_SETTINGS_COUNT 11
+struct pll_ctl {
+	int freq_in;
+	struct reg_setting settings[PLL_REG_SETTINGS_COUNT];
+};
+
+#define PLL_CTL(f, t, c1, r1, o1, f1l, f1h, c2, r2, o2, f2l, f2h)	\
+	{								\
+		.freq_in = f,						\
+		.settings = {						\
+			{R_PLL1CTL,	c1},				\
+			{R_PLL1RDIV,	r1},				\
+			{R_PLL1ODIV,	o1},				\
+			{R_PLL1FDIVL,	f1l},				\
+			{R_PLL1FDIVH,	f1h},				\
+			{R_PLL2CTL,	c2},				\
+			{R_PLL2RDIV,	r2},				\
+			{R_PLL2ODIV,	o2},				\
+			{R_PLL2FDIVL,	f2l},				\
+			{R_PLL2FDIVH,	f2h},				\
+			{R_TIMEBASE,	t},				\
+		},							\
+	}
+
+static const struct pll_ctl pll_ctls[] = {
+	PLL_CTL(1411200, 0x05,
+		0xB9, 0x07, 0x02, 0xC3, 0x04,
+		0x5A, 0x02, 0x03, 0xE0, 0x01),
+	PLL_CTL(1536000, 0x05,
+		0x5A, 0x02, 0x03, 0xE0, 0x01,
+		0x5A, 0x02, 0x03, 0xB9, 0x01),
+	PLL_CTL(2822400, 0x0A,
+		0x63, 0x07, 0x04, 0xC3, 0x04,
+		0x62, 0x07, 0x03, 0x48, 0x03),
+	PLL_CTL(3072000, 0x0B,
+		0x62, 0x07, 0x03, 0x48, 0x03,
+		0x5A, 0x04, 0x03, 0xB9, 0x01),
+	PLL_CTL(5644800, 0x15,
+		0x63, 0x0E, 0x04, 0xC3, 0x04,
+		0x5A, 0x08, 0x03, 0xE0, 0x01),
+	PLL_CTL(6144000, 0x17,
+		0x5A, 0x08, 0x03, 0xE0, 0x01,
+		0x5A, 0x08, 0x03, 0xB9, 0x01),
+	PLL_CTL(12000000, 0x2E,
+		0x5B, 0x19, 0x03, 0x00, 0x03,
+		0x6A, 0x19, 0x05, 0x98, 0x04),
+	PLL_CTL(19200000, 0x4A,
+		0x53, 0x14, 0x03, 0x80, 0x01,
+		0x5A, 0x19, 0x03, 0xB9, 0x01),
+	PLL_CTL(22000000, 0x55,
+		0x6A, 0x37, 0x05, 0x00, 0x06,
+		0x62, 0x26, 0x03, 0x49, 0x02),
+	PLL_CTL(22579200, 0x57,
+		0x62, 0x31, 0x03, 0x20, 0x03,
+		0x53, 0x1D, 0x03, 0xB3, 0x01),
+	PLL_CTL(24000000, 0x5D,
+		0x53, 0x19, 0x03, 0x80, 0x01,
+		0x5B, 0x19, 0x05, 0x4C, 0x02),
+	PLL_CTL(24576000, 0x5F,
+		0x53, 0x1D, 0x03, 0xB3, 0x01,
+		0x62, 0x40, 0x03, 0x72, 0x03),
+	PLL_CTL(27000000, 0x68,
+		0x62, 0x4B, 0x03, 0x00, 0x04,
+		0x6A, 0x7D, 0x03, 0x20, 0x06),
+	PLL_CTL(36000000, 0x8C,
+		0x5B, 0x4B, 0x03, 0x00, 0x03,
+		0x6A, 0x7D, 0x03, 0x98, 0x04),
+	PLL_CTL(11289600, 0x2B,
+		0x6A, 0x31, 0x03, 0x40, 0x06,
+		0x5A, 0x12, 0x03, 0x1C, 0x02),
+	PLL_CTL(26000000, 0x65,
+		0x63, 0x41, 0x05, 0x00, 0x06,
+		0x5A, 0x26, 0x03, 0xEF, 0x01),
+	PLL_CTL(12288000, 0x2F,
+		0x5A, 0x12, 0x03, 0x1C, 0x02,
+		0x62, 0x20, 0x03, 0x72, 0x03),
+	PLL_CTL(40000000, 0x9B,
+		0xA2, 0x7D, 0x03, 0x80, 0x04,
+		0x63, 0x7D, 0x05, 0xE4, 0x06),
+	PLL_CTL(512000, 0x01,
+		0x62, 0x01, 0x03, 0xD0, 0x02,
+		0x5B, 0x01, 0x04, 0x72, 0x03),
+	PLL_CTL(705600, 0x02,
+		0x62, 0x02, 0x03, 0x15, 0x04,
+		0x62, 0x01, 0x04, 0x80, 0x02),
+	PLL_CTL(1024000, 0x03,
+		0x62, 0x02, 0x03, 0xD0, 0x02,
+		0x5B, 0x02, 0x04, 0x72, 0x03),
+	PLL_CTL(2048000, 0x07,
+		0x62, 0x04, 0x03, 0xD0, 0x02,
+		0x5B, 0x04, 0x04, 0x72, 0x03),
+	PLL_CTL(2400000, 0x08,
+		0x62, 0x05, 0x03, 0x00, 0x03,
+		0x63, 0x05, 0x05, 0x98, 0x04),
+};
+
+static inline const struct pll_ctl *get_pll_ctl(unsigned long freq_in)
+{
+	int i;
+	struct pll_ctl const *pll_ctl = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(pll_ctls); ++i)
+		if (pll_ctls[i].freq_in == freq_in) {
+			pll_ctl = &pll_ctls[i];
+			break;
+		}
+
+	return pll_ctl;
+}
+
+enum {
+	PLL_INPUT_XTAL = 0,
+	PLL_INPUT_MCLK1,
+	PLL_INPUT_MCLK2,
+	PLL_INPUT_BCLK,
+};
+
+static int set_sysclk(struct snd_soc_component *component)
+{
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	struct pll_ctl const *pll_ctl;
+	unsigned long freq;
+	int i;
+	int ret;
+
+	if (tscs454->sysclk_src_id < PLL_INPUT_BCLK)
+		freq = clk_get_rate(tscs454->sysclk);
+	else
+		freq = tscs454->bclk_freq;
+	pll_ctl = get_pll_ctl(freq);
+	if (!pll_ctl) {
+		ret = -EINVAL;
+		dev_err(component->dev,
+				"Invalid PLL input %lu (%d)\n", freq, ret);
+		return ret;
+	}
+
+	for (i = 0; i < PLL_REG_SETTINGS_COUNT; ++i) {
+		ret = snd_soc_component_write(component,
+				pll_ctl->settings[i].addr,
+				pll_ctl->settings[i].val);
+		if (ret < 0) {
+			dev_err(component->dev,
+					"Failed to set pll setting (%d)\n",
+					ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static inline void reserve_pll(struct pll *pll)
+{
+	mutex_lock(&pll->lock);
+	pll->users++;
+	mutex_unlock(&pll->lock);
+}
+
+static inline void free_pll(struct pll *pll)
+{
+	mutex_lock(&pll->lock);
+	pll->users--;
+	mutex_unlock(&pll->lock);
+}
+
+static int pll_connected(struct snd_soc_dapm_widget *source,
+		struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(source->dapm);
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	int users;
+
+	if (strstr(source->name, "PLL 1")) {
+		mutex_lock(&tscs454->pll1.lock);
+		users = tscs454->pll1.users;
+		mutex_unlock(&tscs454->pll1.lock);
+		dev_dbg(component->dev, "%s(): PLL 1 users = %d\n", __func__,
+				users);
+	} else {
+		mutex_lock(&tscs454->pll2.lock);
+		users = tscs454->pll2.users;
+		mutex_unlock(&tscs454->pll2.lock);
+		dev_dbg(component->dev, "%s(): PLL 2 users = %d\n", __func__,
+				users);
+	}
+
+	return users;
+}
+
+/*
+ * PLL must be enabled after power up and must be disabled before power down
+ * for proper clock switching.
+ */
+static int pll_power_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	bool enable;
+	bool pll1;
+	unsigned int msk;
+	unsigned int val;
+	int ret;
+
+	if (strstr(w->name, "PLL 1"))
+		pll1 = true;
+	else
+		pll1 = false;
+
+	msk = pll1 ? FM_PLLCTL_PLL1CLKEN : FM_PLLCTL_PLL2CLKEN;
+
+	if (event == SND_SOC_DAPM_POST_PMU)
+		enable = true;
+	else
+		enable = false;
+
+	if (enable)
+		val = pll1 ? FV_PLL1CLKEN_ENABLE : FV_PLL2CLKEN_ENABLE;
+	else
+		val = pll1 ? FV_PLL1CLKEN_DISABLE : FV_PLL2CLKEN_DISABLE;
+
+	ret = snd_soc_component_update_bits(component, R_PLLCTL, msk, val);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to %s PLL %d  (%d)\n",
+				enable ? "enable" : "disable",
+				pll1 ? 1 : 2,
+				ret);
+		return ret;
+	}
+
+	if (enable) {
+		msleep(20); // Wait for lock
+		ret = coeff_ram_sync(component, tscs454);
+		if (ret < 0) {
+			dev_err(component->dev,
+					"Failed to sync coeff ram (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static inline int aif_set_master(struct snd_soc_component *component,
+		unsigned int aif_id, bool master)
+{
+	unsigned int reg;
+	unsigned int mask;
+	unsigned int val;
+	int ret;
+
+	switch (aif_id) {
+	case TSCS454_DAI1_ID:
+		reg = R_I2SP1CTL;
+		break;
+	case TSCS454_DAI2_ID:
+		reg = R_I2SP2CTL;
+		break;
+	case TSCS454_DAI3_ID:
+		reg = R_I2SP3CTL;
+		break;
+	default:
+		ret = -ENODEV;
+		dev_err(component->dev, "Unknown DAI %d (%d)\n", aif_id, ret);
+		return ret;
+	}
+	mask = FM_I2SPCTL_PORTMS;
+	val = master ? FV_PORTMS_MASTER : FV_PORTMS_SLAVE;
+
+	ret = snd_soc_component_update_bits(component, reg, mask, val);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to set DAI %d to %s (%d)\n",
+			aif_id, master ? "master" : "slave", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline
+int aif_prepare(struct snd_soc_component *component, struct aif *aif)
+{
+	int ret;
+
+	ret = aif_set_master(component, aif->id, aif->master);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static inline int aif_free(struct snd_soc_component *component,
+		struct aif *aif, bool playback)
+{
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&tscs454->aifs_status_lock);
+
+	dev_dbg(component->dev, "%s(): aif %d\n", __func__, aif->id);
+
+	set_aif_status_inactive(&tscs454->aifs_status, aif->id, playback);
+
+	dev_dbg(component->dev, "Set aif %d inactive. Streams status is 0x%x\n",
+		aif->id, tscs454->aifs_status.streams);
+
+	if (!aif_active(&tscs454->aifs_status, aif->id)) {
+		/* Do config in slave mode */
+		aif_set_master(component, aif->id, false);
+		dev_dbg(component->dev, "Freeing pll %d from aif %d\n",
+				aif->pll->id, aif->id);
+		free_pll(aif->pll);
+	}
+
+	if (!aifs_active(&tscs454->aifs_status)) {
+		dev_dbg(component->dev, "Freeing pll %d from ir\n",
+				tscs454->internal_rate.pll->id);
+		free_pll(tscs454->internal_rate.pll);
+	}
+
+	mutex_unlock(&tscs454->aifs_status_lock);
+
+	return 0;
+}
+
+/* R_PLLCTL PG 0 ADDR 0x15 */
+static char const * const bclk_sel_txt[] = {
+		"BCLK 1", "BCLK 2", "BCLK 3"};
+
+static struct soc_enum const bclk_sel_enum =
+		SOC_ENUM_SINGLE(R_PLLCTL, FB_PLLCTL_BCLKSEL,
+				ARRAY_SIZE(bclk_sel_txt), bclk_sel_txt);
+
+/* R_ISRC PG 0 ADDR 0x16 */
+static char const * const isrc_br_txt[] = {
+		"44.1kHz", "48kHz"};
+
+static struct soc_enum const isrc_br_enum =
+		SOC_ENUM_SINGLE(R_ISRC, FB_ISRC_IBR,
+				ARRAY_SIZE(isrc_br_txt), isrc_br_txt);
+
+static char const * const isrc_bm_txt[] = {
+		"0.25x", "0.5x", "1.0x", "2.0x"};
+
+static struct soc_enum const isrc_bm_enum =
+		SOC_ENUM_SINGLE(R_ISRC, FB_ISRC_IBM,
+				ARRAY_SIZE(isrc_bm_txt), isrc_bm_txt);
+
+/* R_SCLKCTL PG 0 ADDR 0x18 */
+static char const * const modular_rate_txt[] = {
+	"Reserved", "Half", "Full", "Auto",};
+
+static struct soc_enum const adc_modular_rate_enum =
+	SOC_ENUM_SINGLE(R_SCLKCTL, FB_SCLKCTL_ASDM,
+			ARRAY_SIZE(modular_rate_txt), modular_rate_txt);
+
+static struct soc_enum const dac_modular_rate_enum =
+	SOC_ENUM_SINGLE(R_SCLKCTL, FB_SCLKCTL_DSDM,
+			ARRAY_SIZE(modular_rate_txt), modular_rate_txt);
+
+/* R_I2SIDCTL PG 0 ADDR 0x38 */
+static char const * const data_ctrl_txt[] = {
+	"L/R", "L/L", "R/R", "R/L"};
+
+static struct soc_enum const data_in_ctrl_enums[] = {
+	SOC_ENUM_SINGLE(R_I2SIDCTL, FB_I2SIDCTL_I2SI1DCTL,
+			ARRAY_SIZE(data_ctrl_txt), data_ctrl_txt),
+	SOC_ENUM_SINGLE(R_I2SIDCTL, FB_I2SIDCTL_I2SI2DCTL,
+			ARRAY_SIZE(data_ctrl_txt), data_ctrl_txt),
+	SOC_ENUM_SINGLE(R_I2SIDCTL, FB_I2SIDCTL_I2SI3DCTL,
+			ARRAY_SIZE(data_ctrl_txt), data_ctrl_txt),
+};
+
+/* R_I2SODCTL PG 0 ADDR 0x39 */
+static struct soc_enum const data_out_ctrl_enums[] = {
+	SOC_ENUM_SINGLE(R_I2SODCTL, FB_I2SODCTL_I2SO1DCTL,
+			ARRAY_SIZE(data_ctrl_txt), data_ctrl_txt),
+	SOC_ENUM_SINGLE(R_I2SODCTL, FB_I2SODCTL_I2SO2DCTL,
+			ARRAY_SIZE(data_ctrl_txt), data_ctrl_txt),
+	SOC_ENUM_SINGLE(R_I2SODCTL, FB_I2SODCTL_I2SO3DCTL,
+			ARRAY_SIZE(data_ctrl_txt), data_ctrl_txt),
+};
+
+/* R_AUDIOMUX1 PG 0 ADDR 0x3A */
+static char const * const asrc_mux_txt[] = {
+		"None", "DAI 1", "DAI 2", "DAI 3"};
+
+static struct soc_enum const asrc_in_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX1, FB_AUDIOMUX1_ASRCIMUX,
+				ARRAY_SIZE(asrc_mux_txt), asrc_mux_txt);
+
+static char const * const dai_mux_txt[] = {
+		"CH 0_1", "CH 2_3", "CH 4_5", "ADC/DMic 1",
+		"DMic 2", "ClassD", "DAC", "Sub"};
+
+static struct soc_enum const dai2_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX1, FB_AUDIOMUX1_I2S2MUX,
+				ARRAY_SIZE(dai_mux_txt), dai_mux_txt);
+
+static struct snd_kcontrol_new const dai2_mux_dapm_enum =
+		SOC_DAPM_ENUM("DAI 2 Mux",  dai2_mux_enum);
+
+static struct soc_enum const dai1_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX1, FB_AUDIOMUX1_I2S1MUX,
+				ARRAY_SIZE(dai_mux_txt), dai_mux_txt);
+
+static struct snd_kcontrol_new const dai1_mux_dapm_enum =
+		SOC_DAPM_ENUM("DAI 1 Mux", dai1_mux_enum);
+
+/* R_AUDIOMUX2 PG 0 ADDR 0x3B */
+static struct soc_enum const asrc_out_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX2, FB_AUDIOMUX2_ASRCOMUX,
+				ARRAY_SIZE(asrc_mux_txt), asrc_mux_txt);
+
+static struct soc_enum const dac_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX2, FB_AUDIOMUX2_DACMUX,
+				ARRAY_SIZE(dai_mux_txt), dai_mux_txt);
+
+static struct snd_kcontrol_new const dac_mux_dapm_enum =
+		SOC_DAPM_ENUM("DAC Mux", dac_mux_enum);
+
+static struct soc_enum const dai3_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX2, FB_AUDIOMUX2_I2S3MUX,
+				ARRAY_SIZE(dai_mux_txt), dai_mux_txt);
+
+static struct snd_kcontrol_new const dai3_mux_dapm_enum =
+		SOC_DAPM_ENUM("DAI 3 Mux", dai3_mux_enum);
+
+/* R_AUDIOMUX3 PG 0 ADDR 0x3C */
+static char const * const sub_mux_txt[] = {
+		"CH 0", "CH 1", "CH 0 + 1",
+		"CH 2", "CH 3", "CH 2 + 3",
+		"CH 4", "CH 5", "CH 4 + 5",
+		"ADC/DMic 1 Left", "ADC/DMic 1 Right",
+		"ADC/DMic 1 Left Plus Right",
+		"DMic 2 Left", "DMic 2 Right", "DMic 2 Left Plus Right",
+		"ClassD Left", "ClassD Right", "ClassD Left Plus Right"};
+
+static struct soc_enum const sub_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX3, FB_AUDIOMUX3_SUBMUX,
+				ARRAY_SIZE(sub_mux_txt), sub_mux_txt);
+
+static struct snd_kcontrol_new const sub_mux_dapm_enum =
+		SOC_DAPM_ENUM("Sub Mux", sub_mux_enum);
+
+static struct soc_enum const classd_mux_enum =
+		SOC_ENUM_SINGLE(R_AUDIOMUX3, FB_AUDIOMUX3_CLSSDMUX,
+				ARRAY_SIZE(dai_mux_txt), dai_mux_txt);
+
+static struct snd_kcontrol_new const classd_mux_dapm_enum =
+		SOC_DAPM_ENUM("ClassD Mux", classd_mux_enum);
+
+/* R_HSDCTL1 PG 1 ADDR 0x01 */
+static char const * const jack_type_txt[] = {
+		"3 Terminal", "4 Terminal"};
+
+static struct soc_enum const hp_jack_type_enum =
+		SOC_ENUM_SINGLE(R_HSDCTL1, FB_HSDCTL1_HPJKTYPE,
+				ARRAY_SIZE(jack_type_txt), jack_type_txt);
+
+static char const * const hs_det_pol_txt[] = {
+		"Rising", "Falling"};
+
+static struct soc_enum const hs_det_pol_enum =
+		SOC_ENUM_SINGLE(R_HSDCTL1, FB_HSDCTL1_HSDETPOL,
+				ARRAY_SIZE(hs_det_pol_txt), hs_det_pol_txt);
+
+/* R_HSDCTL1 PG 1 ADDR 0x02 */
+static char const * const hs_mic_bias_force_txt[] = {
+		"Off", "Ring", "Sleeve"};
+
+static struct soc_enum const hs_mic_bias_force_enum =
+		SOC_ENUM_SINGLE(R_HSDCTL2, FB_HSDCTL2_FMICBIAS1,
+				ARRAY_SIZE(hs_mic_bias_force_txt),
+				hs_mic_bias_force_txt);
+
+static char const * const plug_type_txt[] = {
+		"OMTP", "CTIA", "Reserved", "Headphone"};
+
+static struct soc_enum const plug_type_force_enum =
+		SOC_ENUM_SINGLE(R_HSDCTL2, FB_HSDCTL2_FPLUGTYPE,
+		ARRAY_SIZE(plug_type_txt), plug_type_txt);
+
+
+/* R_CH0AIC PG 1 ADDR 0x06 */
+static char const * const in_bst_mux_txt[] = {
+		"Input 1", "Input 2", "Input 3", "D2S"};
+
+static struct soc_enum const in_bst_mux_ch0_enum =
+		SOC_ENUM_SINGLE(R_CH0AIC, FB_CH0AIC_INSELL,
+				ARRAY_SIZE(in_bst_mux_txt),
+				in_bst_mux_txt);
+static struct snd_kcontrol_new const in_bst_mux_ch0_dapm_enum =
+		SOC_DAPM_ENUM("Input Boost Channel 0 Enum",
+				in_bst_mux_ch0_enum);
+
+static DECLARE_TLV_DB_SCALE(in_bst_vol_tlv_arr, 0, 1000, 0);
+
+static char const * const adc_mux_txt[] = {
+		"Input 1 Boost Bypass", "Input 2 Boost Bypass",
+		"Input 3 Boost Bypass", "Input Boost"};
+
+static struct soc_enum const adc_mux_ch0_enum =
+		SOC_ENUM_SINGLE(R_CH0AIC, FB_CH0AIC_LADCIN,
+				ARRAY_SIZE(adc_mux_txt), adc_mux_txt);
+static struct snd_kcontrol_new const adc_mux_ch0_dapm_enum =
+		SOC_DAPM_ENUM("ADC Channel 0 Enum", adc_mux_ch0_enum);
+
+static char const * const in_proc_mux_txt[] = {
+		"ADC", "DMic"};
+
+static struct soc_enum const in_proc_ch0_enum =
+		SOC_ENUM_SINGLE(R_CH0AIC, FB_CH0AIC_IPCH0S,
+				ARRAY_SIZE(in_proc_mux_txt), in_proc_mux_txt);
+static struct snd_kcontrol_new const in_proc_mux_ch0_dapm_enum =
+		SOC_DAPM_ENUM("Input Processor Channel 0 Enum",
+				in_proc_ch0_enum);
+
+/* R_CH1AIC PG 1 ADDR 0x07 */
+static struct soc_enum const in_bst_mux_ch1_enum =
+		SOC_ENUM_SINGLE(R_CH1AIC, FB_CH1AIC_INSELR,
+				ARRAY_SIZE(in_bst_mux_txt),
+				in_bst_mux_txt);
+static struct snd_kcontrol_new const in_bst_mux_ch1_dapm_enum =
+		SOC_DAPM_ENUM("Input Boost Channel 1 Enum",
+				in_bst_mux_ch1_enum);
+
+static struct soc_enum const adc_mux_ch1_enum =
+		SOC_ENUM_SINGLE(R_CH1AIC, FB_CH1AIC_RADCIN,
+				ARRAY_SIZE(adc_mux_txt), adc_mux_txt);
+static struct snd_kcontrol_new const adc_mux_ch1_dapm_enum =
+		SOC_DAPM_ENUM("ADC Channel 1 Enum", adc_mux_ch1_enum);
+
+static struct soc_enum const in_proc_ch1_enum =
+		SOC_ENUM_SINGLE(R_CH1AIC, FB_CH1AIC_IPCH1S,
+				ARRAY_SIZE(in_proc_mux_txt), in_proc_mux_txt);
+static struct snd_kcontrol_new const in_proc_mux_ch1_dapm_enum =
+		SOC_DAPM_ENUM("Input Processor Channel 1 Enum",
+				in_proc_ch1_enum);
+
+/* R_ICTL0 PG 1 ADDR 0x0A */
+static char const * const pol_txt[] = {
+		"Normal", "Invert"};
+
+static struct soc_enum const in_pol_ch1_enum =
+		SOC_ENUM_SINGLE(R_ICTL0, FB_ICTL0_IN0POL,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+static struct soc_enum const in_pol_ch0_enum =
+		SOC_ENUM_SINGLE(R_ICTL0, FB_ICTL0_IN1POL,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+static char const * const in_proc_ch_sel_txt[] = {
+		"Normal", "Mono Mix to Channel 0",
+		"Mono Mix to Channel 1", "Add"};
+
+static struct soc_enum const in_proc_ch01_sel_enum =
+		SOC_ENUM_SINGLE(R_ICTL0, FB_ICTL0_INPCH10SEL,
+				ARRAY_SIZE(in_proc_ch_sel_txt),
+				in_proc_ch_sel_txt);
+
+/* R_ICTL1 PG 1 ADDR 0x0B */
+static struct soc_enum const in_pol_ch3_enum =
+		SOC_ENUM_SINGLE(R_ICTL1, FB_ICTL1_IN2POL,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+static struct soc_enum const in_pol_ch2_enum =
+		SOC_ENUM_SINGLE(R_ICTL1, FB_ICTL1_IN3POL,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+static struct soc_enum const in_proc_ch23_sel_enum =
+		SOC_ENUM_SINGLE(R_ICTL1, FB_ICTL1_INPCH32SEL,
+				ARRAY_SIZE(in_proc_ch_sel_txt),
+				in_proc_ch_sel_txt);
+
+/* R_MICBIAS PG 1 ADDR 0x0C */
+static char const * const mic_bias_txt[] = {
+		"2.5V", "2.1V", "1.8V", "Vdd"};
+
+static struct soc_enum const mic_bias_2_enum =
+		SOC_ENUM_SINGLE(R_MICBIAS, FB_MICBIAS_MICBOV2,
+				ARRAY_SIZE(mic_bias_txt), mic_bias_txt);
+
+static struct soc_enum const mic_bias_1_enum =
+		SOC_ENUM_SINGLE(R_MICBIAS, FB_MICBIAS_MICBOV1,
+				ARRAY_SIZE(mic_bias_txt), mic_bias_txt);
+
+/* R_PGACTL0 PG 1 ADDR 0x0D */
+/* R_PGACTL1 PG 1 ADDR 0x0E */
+/* R_PGACTL2 PG 1 ADDR 0x0F */
+/* R_PGACTL3 PG 1 ADDR 0x10 */
+static DECLARE_TLV_DB_SCALE(in_pga_vol_tlv_arr, -1725, 75, 0);
+
+/* R_ICH0VOL PG1 ADDR 0x12 */
+/* R_ICH1VOL PG1 ADDR 0x13 */
+/* R_ICH2VOL PG1 ADDR 0x14 */
+/* R_ICH3VOL PG1 ADDR 0x15 */
+static DECLARE_TLV_DB_MINMAX(in_vol_tlv_arr, -7125, 2400);
+
+/* R_ASRCILVOL PG1 ADDR 0x16 */
+/* R_ASRCIRVOL PG1 ADDR 0x17 */
+/* R_ASRCOLVOL PG1 ADDR 0x18 */
+/* R_ASRCORVOL PG1 ADDR 0x19 */
+static DECLARE_TLV_DB_MINMAX(asrc_vol_tlv_arr, -9562, 600);
+
+/* R_ALCCTL0 PG1 ADDR 0x1D */
+static char const * const alc_mode_txt[] = {
+		"ALC", "Limiter"};
+
+static struct soc_enum const alc_mode_enum =
+		SOC_ENUM_SINGLE(R_ALCCTL0, FB_ALCCTL0_ALCMODE,
+				ARRAY_SIZE(alc_mode_txt), alc_mode_txt);
+
+static char const * const alc_ref_text[] = {
+		"Channel 0", "Channel 1", "Channel 2", "Channel 3", "Peak"};
+
+static struct soc_enum const alc_ref_enum =
+		SOC_ENUM_SINGLE(R_ALCCTL0, FB_ALCCTL0_ALCREF,
+				ARRAY_SIZE(alc_ref_text), alc_ref_text);
+
+/* R_ALCCTL1 PG 1 ADDR 0x1E */
+static DECLARE_TLV_DB_SCALE(alc_max_gain_tlv_arr, -1200, 600, 0);
+static DECLARE_TLV_DB_SCALE(alc_target_tlv_arr, -2850, 150, 0);
+
+/* R_ALCCTL2 PG 1 ADDR 0x1F */
+static DECLARE_TLV_DB_SCALE(alc_min_gain_tlv_arr, -1725, 600, 0);
+
+/* R_NGATE PG 1 ADDR 0x21 */
+static DECLARE_TLV_DB_SCALE(ngth_tlv_arr, -7650, 150, 0);
+
+static char const * const ngate_type_txt[] = {
+		"PGA Constant", "ADC Mute"};
+
+static struct soc_enum const ngate_type_enum =
+		SOC_ENUM_SINGLE(R_NGATE, FB_NGATE_NGG,
+				ARRAY_SIZE(ngate_type_txt), ngate_type_txt);
+
+/* R_DMICCTL PG 1 ADDR 0x22 */
+static char const * const dmic_mono_sel_txt[] = {
+		"Stereo", "Mono"};
+
+static struct soc_enum const dmic_mono_sel_enum =
+		SOC_ENUM_SINGLE(R_DMICCTL, FB_DMICCTL_DMONO,
+			ARRAY_SIZE(dmic_mono_sel_txt), dmic_mono_sel_txt);
+
+/* R_DACCTL PG 2 ADDR 0x01 */
+static struct soc_enum const dac_pol_r_enum =
+		SOC_ENUM_SINGLE(R_DACCTL, FB_DACCTL_DACPOLR,
+			ARRAY_SIZE(pol_txt), pol_txt);
+
+static struct soc_enum const dac_pol_l_enum =
+		SOC_ENUM_SINGLE(R_DACCTL, FB_DACCTL_DACPOLL,
+			ARRAY_SIZE(pol_txt), pol_txt);
+
+static char const * const dac_dith_txt[] = {
+		"Half", "Full", "Disabled", "Static"};
+
+static struct soc_enum const dac_dith_enum =
+		SOC_ENUM_SINGLE(R_DACCTL, FB_DACCTL_DACDITH,
+			ARRAY_SIZE(dac_dith_txt), dac_dith_txt);
+
+/* R_SPKCTL PG 2 ADDR 0x02 */
+static struct soc_enum const spk_pol_r_enum =
+		SOC_ENUM_SINGLE(R_SPKCTL, FB_SPKCTL_SPKPOLR,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+static struct soc_enum const spk_pol_l_enum =
+		SOC_ENUM_SINGLE(R_SPKCTL, FB_SPKCTL_SPKPOLL,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_SUBCTL PG 2 ADDR 0x03 */
+static struct soc_enum const sub_pol_enum =
+		SOC_ENUM_SINGLE(R_SUBCTL, FB_SUBCTL_SUBPOL,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_MVOLL PG 2 ADDR 0x08 */
+/* R_MVOLR PG 2 ADDR 0x09 */
+static DECLARE_TLV_DB_MINMAX(mvol_tlv_arr, -9562, 0);
+
+/* R_HPVOLL PG 2 ADDR 0x0A */
+/* R_HPVOLR PG 2 ADDR 0x0B */
+static DECLARE_TLV_DB_SCALE(hp_vol_tlv_arr, -8850, 75, 0);
+
+/* R_SPKVOLL PG 2 ADDR 0x0C */
+/* R_SPKVOLR PG 2 ADDR 0x0D */
+static DECLARE_TLV_DB_SCALE(spk_vol_tlv_arr, -7725, 75, 0);
+
+/* R_SPKEQFILT PG 3 ADDR 0x01 */
+static char const * const eq_txt[] = {
+	"Pre Scale",
+	"Pre Scale + EQ Band 0",
+	"Pre Scale + EQ Band 0 - 1",
+	"Pre Scale + EQ Band 0 - 2",
+	"Pre Scale + EQ Band 0 - 3",
+	"Pre Scale + EQ Band 0 - 4",
+	"Pre Scale + EQ Band 0 - 5",
+};
+
+static struct soc_enum const spk_eq_enums[] = {
+	SOC_ENUM_SINGLE(R_SPKEQFILT, FB_SPKEQFILT_EQ2BE,
+		ARRAY_SIZE(eq_txt), eq_txt),
+	SOC_ENUM_SINGLE(R_SPKEQFILT, FB_SPKEQFILT_EQ1BE,
+		ARRAY_SIZE(eq_txt), eq_txt),
+};
+
+/* R_SPKMBCCTL PG 3 ADDR 0x0B */
+static char const * const lvl_mode_txt[] = {
+		"Average", "Peak"};
+
+static struct soc_enum const spk_mbc3_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCCTL, FB_SPKMBCCTL_LVLMODE3,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static char const * const win_sel_txt[] = {
+		"512", "64"};
+
+static struct soc_enum const spk_mbc3_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCCTL, FB_SPKMBCCTL_WINSEL3,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+static struct soc_enum const spk_mbc2_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCCTL, FB_SPKMBCCTL_LVLMODE2,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const spk_mbc2_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCCTL, FB_SPKMBCCTL_WINSEL2,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+static struct soc_enum const spk_mbc1_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCCTL, FB_SPKMBCCTL_LVLMODE1,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const spk_mbc1_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCCTL, FB_SPKMBCCTL_WINSEL1,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+/* R_SPKMBCMUG1 PG 3 ADDR 0x0C */
+static struct soc_enum const spk_mbc1_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCMUG1, FB_SPKMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+static DECLARE_TLV_DB_MINMAX(mbc_mug_tlv_arr, -4650, 0);
+
+/* R_SPKMBCTHR1 PG 3 ADDR 0x0D */
+static DECLARE_TLV_DB_MINMAX(thr_tlv_arr, -9562, 0);
+
+/* R_SPKMBCRAT1 PG 3 ADDR 0x0E */
+static char const * const comp_rat_txt[] = {
+		"Reserved", "1.5:1", "2:1", "3:1", "4:1", "5:1", "6:1",
+		"7:1", "8:1", "9:1", "10:1", "11:1", "12:1", "13:1", "14:1",
+		"15:1", "16:1", "17:1", "18:1", "19:1", "20:1"};
+
+static struct soc_enum const spk_mbc1_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCRAT1, FB_SPKMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SPKMBCMUG2 PG 3 ADDR 0x13 */
+static struct soc_enum const spk_mbc2_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCMUG2, FB_SPKMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_SPKMBCRAT2 PG 3 ADDR 0x15 */
+static struct soc_enum const spk_mbc2_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCRAT2, FB_SPKMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SPKMBCMUG3 PG 3 ADDR 0x1A */
+static struct soc_enum const spk_mbc3_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCMUG3, FB_SPKMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_SPKMBCRAT3 PG 3 ADDR 0x1C */
+static struct soc_enum const spk_mbc3_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SPKMBCRAT3, FB_SPKMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SPKCLECTL PG 3 ADDR 0x21 */
+static struct soc_enum const spk_cle_lvl_mode_enum =
+		SOC_ENUM_SINGLE(R_SPKCLECTL, FB_SPKCLECTL_LVLMODE,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const spk_cle_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SPKCLECTL, FB_SPKCLECTL_WINSEL,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+/* R_SPKCLEMUG PG 3 ADDR 0x22 */
+static DECLARE_TLV_DB_MINMAX(cle_mug_tlv_arr, 0, 4650);
+
+/* R_SPKCOMPRAT PG 3 ADDR 0x24 */
+static struct soc_enum const spk_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SPKCOMPRAT, FB_SPKCOMPRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SPKEXPTHR PG 3 ADDR 0x2F */
+static char const * const exp_rat_txt[] = {
+		"Reserved", "Reserved", "1:2", "1:3",
+		"1:4", "1:5", "1:6", "1:7"};
+
+static struct soc_enum const spk_exp_rat_enum =
+		SOC_ENUM_SINGLE(R_SPKEXPRAT, FB_SPKEXPRAT_RATIO,
+				ARRAY_SIZE(exp_rat_txt), exp_rat_txt);
+
+/* R_DACEQFILT PG 4 ADDR 0x01 */
+static struct soc_enum const dac_eq_enums[] = {
+	SOC_ENUM_SINGLE(R_DACEQFILT, FB_DACEQFILT_EQ2BE,
+		ARRAY_SIZE(eq_txt), eq_txt),
+	SOC_ENUM_SINGLE(R_DACEQFILT, FB_DACEQFILT_EQ1BE,
+		ARRAY_SIZE(eq_txt), eq_txt),
+};
+
+/* R_DACMBCCTL PG 4 ADDR 0x0B */
+static struct soc_enum const dac_mbc3_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_LVLMODE3,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const dac_mbc3_win_sel_enum =
+		SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_WINSEL3,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+static struct soc_enum const dac_mbc2_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_LVLMODE2,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const dac_mbc2_win_sel_enum =
+		SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_WINSEL2,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+static struct soc_enum const dac_mbc1_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_LVLMODE1,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const dac_mbc1_win_sel_enum =
+		SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_WINSEL1,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+/* R_DACMBCMUG1 PG 4 ADDR 0x0C */
+static struct soc_enum const dac_mbc1_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_DACMBCMUG1, FB_DACMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_DACMBCRAT1 PG 4 ADDR 0x0E */
+static struct soc_enum const dac_mbc1_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_DACMBCRAT1, FB_DACMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_DACMBCMUG2 PG 4 ADDR 0x13 */
+static struct soc_enum const dac_mbc2_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_DACMBCMUG2, FB_DACMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_DACMBCRAT2 PG 4 ADDR 0x15 */
+static struct soc_enum const dac_mbc2_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_DACMBCRAT2, FB_DACMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_DACMBCMUG3 PG 4 ADDR 0x1A */
+static struct soc_enum const dac_mbc3_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_DACMBCMUG3, FB_DACMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_DACMBCRAT3 PG 4 ADDR 0x1C */
+static struct soc_enum const dac_mbc3_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_DACMBCRAT3, FB_DACMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_DACCLECTL PG 4 ADDR 0x21 */
+static struct soc_enum const dac_cle_lvl_mode_enum =
+		SOC_ENUM_SINGLE(R_DACCLECTL, FB_DACCLECTL_LVLMODE,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const dac_cle_win_sel_enum =
+		SOC_ENUM_SINGLE(R_DACCLECTL, FB_DACCLECTL_WINSEL,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+/* R_DACCOMPRAT PG 4 ADDR 0x24 */
+static struct soc_enum const dac_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_DACCOMPRAT, FB_DACCOMPRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_DACEXPRAT PG 4 ADDR 0x30 */
+static struct soc_enum const dac_exp_rat_enum =
+		SOC_ENUM_SINGLE(R_DACEXPRAT, FB_DACEXPRAT_RATIO,
+				ARRAY_SIZE(exp_rat_txt), exp_rat_txt);
+
+/* R_SUBEQFILT PG 5 ADDR 0x01 */
+static struct soc_enum const sub_eq_enums[] = {
+	SOC_ENUM_SINGLE(R_SUBEQFILT, FB_SUBEQFILT_EQ2BE,
+		ARRAY_SIZE(eq_txt), eq_txt),
+	SOC_ENUM_SINGLE(R_SUBEQFILT, FB_SUBEQFILT_EQ1BE,
+		ARRAY_SIZE(eq_txt), eq_txt),
+};
+
+/* R_SUBMBCCTL PG 5 ADDR 0x0B */
+static struct soc_enum const sub_mbc3_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCCTL, FB_SUBMBCCTL_LVLMODE3,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const sub_mbc3_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCCTL, FB_SUBMBCCTL_WINSEL3,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+static struct soc_enum const sub_mbc2_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCCTL, FB_SUBMBCCTL_LVLMODE2,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const sub_mbc2_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCCTL, FB_SUBMBCCTL_WINSEL2,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+static struct soc_enum const sub_mbc1_lvl_det_mode_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCCTL, FB_SUBMBCCTL_LVLMODE1,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+
+static struct soc_enum const sub_mbc1_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCCTL, FB_SUBMBCCTL_WINSEL1,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+/* R_SUBMBCMUG1 PG 5 ADDR 0x0C */
+static struct soc_enum const sub_mbc1_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCMUG1, FB_SUBMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_SUBMBCRAT1 PG 5 ADDR 0x0E */
+static struct soc_enum const sub_mbc1_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCRAT1, FB_SUBMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SUBMBCMUG2 PG 5 ADDR 0x13 */
+static struct soc_enum const sub_mbc2_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCMUG2, FB_SUBMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_SUBMBCRAT2 PG 5 ADDR 0x15 */
+static struct soc_enum const sub_mbc2_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCRAT2, FB_SUBMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SUBMBCMUG3 PG 5 ADDR 0x1A */
+static struct soc_enum const sub_mbc3_phase_pol_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCMUG3, FB_SUBMBCMUG_PHASE,
+				ARRAY_SIZE(pol_txt), pol_txt);
+
+/* R_SUBMBCRAT3 PG 5 ADDR 0x1C */
+static struct soc_enum const sub_mbc3_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SUBMBCRAT3, FB_SUBMBCRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SUBCLECTL PG 5 ADDR 0x21 */
+static struct soc_enum const sub_cle_lvl_mode_enum =
+		SOC_ENUM_SINGLE(R_SUBCLECTL, FB_SUBCLECTL_LVLMODE,
+				ARRAY_SIZE(lvl_mode_txt), lvl_mode_txt);
+static struct soc_enum const sub_cle_win_sel_enum =
+		SOC_ENUM_SINGLE(R_SUBCLECTL, FB_SUBCLECTL_WINSEL,
+				ARRAY_SIZE(win_sel_txt), win_sel_txt);
+
+/* R_SUBCOMPRAT PG 5 ADDR 0x24 */
+static struct soc_enum const sub_comp_rat_enum =
+		SOC_ENUM_SINGLE(R_SUBCOMPRAT, FB_SUBCOMPRAT_RATIO,
+				ARRAY_SIZE(comp_rat_txt), comp_rat_txt);
+
+/* R_SUBEXPRAT PG 5 ADDR 0x30 */
+static struct soc_enum const sub_exp_rat_enum =
+		SOC_ENUM_SINGLE(R_SUBEXPRAT, FB_SUBEXPRAT_RATIO,
+				ARRAY_SIZE(exp_rat_txt), exp_rat_txt);
+
+static int bytes_info_ext(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *ucontrol)
+{
+	struct coeff_ram_ctl *ctl =
+		(struct coeff_ram_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+
+	ucontrol->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	ucontrol->count = params->max;
+
+	return 0;
+}
+
+/* CH 0_1 Input Mux */
+static char const * const ch_0_1_mux_txt[] = {"DAI 1", "TDM 0_1"};
+
+static struct soc_enum const ch_0_1_mux_enum =
+		SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
+				ARRAY_SIZE(ch_0_1_mux_txt), ch_0_1_mux_txt);
+
+static struct snd_kcontrol_new const ch_0_1_mux_dapm_enum =
+		SOC_DAPM_ENUM("CH 0_1 Input Mux", ch_0_1_mux_enum);
+
+/* CH 2_3 Input Mux */
+static char const * const ch_2_3_mux_txt[] = {"DAI 2", "TDM 2_3"};
+
+static struct soc_enum const ch_2_3_mux_enum =
+		SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
+				ARRAY_SIZE(ch_2_3_mux_txt), ch_2_3_mux_txt);
+
+static struct snd_kcontrol_new const ch_2_3_mux_dapm_enum =
+		SOC_DAPM_ENUM("CH 2_3 Input Mux", ch_2_3_mux_enum);
+
+/* CH 4_5 Input Mux */
+static char const * const ch_4_5_mux_txt[] = {"DAI 3", "TDM 4_5"};
+
+static struct soc_enum const ch_4_5_mux_enum =
+		SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
+				ARRAY_SIZE(ch_4_5_mux_txt), ch_4_5_mux_txt);
+
+static struct snd_kcontrol_new const ch_4_5_mux_dapm_enum =
+		SOC_DAPM_ENUM("CH 4_5 Input Mux", ch_4_5_mux_enum);
+
+#define COEFF_RAM_CTL(xname, xcount, xaddr) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = bytes_info_ext, \
+	.get = coeff_ram_get, .put = coeff_ram_put, \
+	.private_value = (unsigned long)&(struct coeff_ram_ctl) { \
+		.addr = xaddr, \
+		.bytes_ext = {.max = xcount, }, \
+	} \
+}
+
+static struct snd_kcontrol_new const tscs454_snd_controls[] = {
+	/* R_PLLCTL PG 0 ADDR 0x15 */
+	SOC_ENUM("PLL BCLK Input", bclk_sel_enum),
+	/* R_ISRC PG 0 ADDR 0x16 */
+	SOC_ENUM("Internal Rate", isrc_br_enum),
+	SOC_ENUM("Internal Rate Multiple", isrc_bm_enum),
+	/* R_SCLKCTL PG 0 ADDR 0x18 */
+	SOC_ENUM("ADC Modular Rate", adc_modular_rate_enum),
+	SOC_ENUM("DAC Modular Rate", dac_modular_rate_enum),
+	/* R_ASRC PG 0 ADDR 0x28 */
+	SOC_SINGLE("ASRC Out High Bandwidth Switch",
+			R_ASRC, FB_ASRC_ASRCOBW, 1, 0),
+	SOC_SINGLE("ASRC In High Bandwidth Switch",
+			R_ASRC, FB_ASRC_ASRCIBW, 1, 0),
+	/* R_I2SIDCTL PG 0 ADDR 0x38 */
+	SOC_ENUM("I2S 1 Data In Control", data_in_ctrl_enums[0]),
+	SOC_ENUM("I2S 2 Data In Control", data_in_ctrl_enums[1]),
+	SOC_ENUM("I2S 3 Data In Control", data_in_ctrl_enums[2]),
+	/* R_I2SODCTL PG 0 ADDR 0x39 */
+	SOC_ENUM("I2S 1 Data Out Control", data_out_ctrl_enums[0]),
+	SOC_ENUM("I2S 2 Data Out Control", data_out_ctrl_enums[1]),
+	SOC_ENUM("I2S 3 Data Out Control", data_out_ctrl_enums[2]),
+	/* R_AUDIOMUX1 PG 0 ADDR 0x3A */
+	SOC_ENUM("ASRC In", asrc_in_mux_enum),
+	/* R_AUDIOMUX2 PG 0 ADDR 0x3B */
+	SOC_ENUM("ASRC Out", asrc_out_mux_enum),
+	/* R_HSDCTL1 PG 1 ADDR 0x01 */
+	SOC_ENUM("Headphone Jack Type", hp_jack_type_enum),
+	SOC_ENUM("Headset Detection Polarity", hs_det_pol_enum),
+	SOC_SINGLE("Headphone Detection Switch",
+			R_HSDCTL1, FB_HSDCTL1_HPID_EN, 1, 0),
+	SOC_SINGLE("Headset OMTP/CTIA Switch",
+			R_HSDCTL1, FB_HSDCTL1_GBLHS_EN, 1, 0),
+	/* R_HSDCTL1 PG 1 ADDR 0x02 */
+	SOC_ENUM("Headset Mic Bias Force", hs_mic_bias_force_enum),
+	SOC_SINGLE("Manual Mic Bias Switch",
+			R_HSDCTL2, FB_HSDCTL2_MB1MODE, 1, 0),
+	SOC_SINGLE("Ring/Sleeve Auto Switch",
+			R_HSDCTL2, FB_HSDCTL2_SWMODE, 1, 0),
+	SOC_ENUM("Manual Mode Plug Type", plug_type_force_enum),
+	/* R_CH0AIC PG 1 ADDR 0x06 */
+	SOC_SINGLE_TLV("Input Boost Channel 0 Volume", R_CH0AIC,
+			FB_CHAIC_MICBST, 0x3, 0, in_bst_vol_tlv_arr),
+	/* R_CH1AIC PG 1 ADDR 0x07 */
+	SOC_SINGLE_TLV("Input Boost Channel 1 Volume", R_CH1AIC,
+			FB_CHAIC_MICBST, 0x3, 0, in_bst_vol_tlv_arr),
+	/* R_CH2AIC PG 1 ADDR 0x08 */
+	SOC_SINGLE_TLV("Input Boost Channel 2 Volume", R_CH2AIC,
+			FB_CHAIC_MICBST, 0x3, 0, in_bst_vol_tlv_arr),
+	/* R_CH3AIC PG 1 ADDR 0x09 */
+	SOC_SINGLE_TLV("Input Boost Channel 3 Volume", R_CH3AIC,
+			FB_CHAIC_MICBST, 0x3, 0, in_bst_vol_tlv_arr),
+	/* R_ICTL0 PG 1 ADDR 0x0A */
+	SOC_ENUM("Input Channel 1 Polarity", in_pol_ch1_enum),
+	SOC_ENUM("Input Channel 0 Polarity", in_pol_ch0_enum),
+	SOC_ENUM("Input Processor Channel 0/1 Operation",
+			in_proc_ch01_sel_enum),
+	SOC_SINGLE("Input Channel 1 Mute Switch",
+			R_ICTL0, FB_ICTL0_IN1MUTE, 1, 0),
+	SOC_SINGLE("Input Channel 0 Mute Switch",
+			R_ICTL0, FB_ICTL0_IN0MUTE, 1, 0),
+	SOC_SINGLE("Input Channel 1 HPF Disable Switch",
+			R_ICTL0, FB_ICTL0_IN1HP, 1, 0),
+	SOC_SINGLE("Input Channel 0 HPF Disable Switch",
+			R_ICTL0, FB_ICTL0_IN0HP, 1, 0),
+	/* R_ICTL1 PG 1 ADDR 0x0B */
+	SOC_ENUM("Input Channel 3 Polarity", in_pol_ch3_enum),
+	SOC_ENUM("Input Channel 2 Polarity", in_pol_ch2_enum),
+	SOC_ENUM("Input Processor Channel 2/3 Operation",
+			in_proc_ch23_sel_enum),
+	SOC_SINGLE("Input Channel 3 Mute Switch",
+			R_ICTL1, FB_ICTL1_IN3MUTE, 1, 0),
+	SOC_SINGLE("Input Channel 2 Mute Switch",
+			R_ICTL1, FB_ICTL1_IN2MUTE, 1, 0),
+	SOC_SINGLE("Input Channel 3 HPF Disable Switch",
+			R_ICTL1, FB_ICTL1_IN3HP, 1, 0),
+	SOC_SINGLE("Input Channel 2 HPF Disable Switch",
+			R_ICTL1, FB_ICTL1_IN2HP, 1, 0),
+	/* R_MICBIAS PG 1 ADDR 0x0C */
+	SOC_ENUM("Mic Bias 2 Voltage", mic_bias_2_enum),
+	SOC_ENUM("Mic Bias 1 Voltage", mic_bias_1_enum),
+	/* R_PGACTL0 PG 1 ADDR 0x0D */
+	SOC_SINGLE("Input Channel 0 PGA Mute Switch",
+			R_PGACTL0, FB_PGACTL_PGAMUTE, 1, 0),
+	SOC_SINGLE_TLV("Input Channel 0 PGA Volume", R_PGACTL0,
+			FB_PGACTL_PGAVOL,
+			FM_PGACTL_PGAVOL, 0, in_pga_vol_tlv_arr),
+	/* R_PGACTL1 PG 1 ADDR 0x0E */
+	SOC_SINGLE("Input Channel 1 PGA Mute Switch",
+			R_PGACTL1, FB_PGACTL_PGAMUTE, 1, 0),
+	SOC_SINGLE_TLV("Input Channel 1 PGA Volume", R_PGACTL1,
+			FB_PGACTL_PGAVOL,
+			FM_PGACTL_PGAVOL, 0, in_pga_vol_tlv_arr),
+	/* R_PGACTL2 PG 1 ADDR 0x0F */
+	SOC_SINGLE("Input Channel 2 PGA Mute Switch",
+			R_PGACTL2, FB_PGACTL_PGAMUTE, 1, 0),
+	SOC_SINGLE_TLV("Input Channel 2 PGA Volume", R_PGACTL2,
+			FB_PGACTL_PGAVOL,
+			FM_PGACTL_PGAVOL, 0, in_pga_vol_tlv_arr),
+	/* R_PGACTL3 PG 1 ADDR 0x10 */
+	SOC_SINGLE("Input Channel 3 PGA Mute Switch",
+			R_PGACTL3, FB_PGACTL_PGAMUTE, 1, 0),
+	SOC_SINGLE_TLV("Input Channel 3 PGA Volume", R_PGACTL3,
+			FB_PGACTL_PGAVOL,
+			FM_PGACTL_PGAVOL, 0, in_pga_vol_tlv_arr),
+	/* R_ICH0VOL PG 1 ADDR 0x12 */
+	SOC_SINGLE_TLV("Input Channel 0 Volume", R_ICH0VOL,
+			FB_ICHVOL_ICHVOL, FM_ICHVOL_ICHVOL, 0, in_vol_tlv_arr),
+	/* R_ICH1VOL PG 1 ADDR 0x13 */
+	SOC_SINGLE_TLV("Input Channel 1 Volume", R_ICH1VOL,
+			FB_ICHVOL_ICHVOL, FM_ICHVOL_ICHVOL, 0, in_vol_tlv_arr),
+	/* R_ICH2VOL PG 1 ADDR 0x14 */
+	SOC_SINGLE_TLV("Input Channel 2 Volume", R_ICH2VOL,
+			FB_ICHVOL_ICHVOL, FM_ICHVOL_ICHVOL, 0, in_vol_tlv_arr),
+	/* R_ICH3VOL PG 1 ADDR 0x15 */
+	SOC_SINGLE_TLV("Input Channel 3 Volume", R_ICH3VOL,
+			FB_ICHVOL_ICHVOL, FM_ICHVOL_ICHVOL, 0, in_vol_tlv_arr),
+	/* R_ASRCILVOL PG 1 ADDR 0x16 */
+	SOC_SINGLE_TLV("ASRC Input Left Volume", R_ASRCILVOL,
+			FB_ASRCILVOL_ASRCILVOL, FM_ASRCILVOL_ASRCILVOL,
+			0, asrc_vol_tlv_arr),
+	/* R_ASRCIRVOL PG 1 ADDR 0x17 */
+	SOC_SINGLE_TLV("ASRC Input Right Volume", R_ASRCIRVOL,
+			FB_ASRCIRVOL_ASRCIRVOL, FM_ASRCIRVOL_ASRCIRVOL,
+			0, asrc_vol_tlv_arr),
+	/* R_ASRCOLVOL PG 1 ADDR 0x18 */
+	SOC_SINGLE_TLV("ASRC Output Left Volume", R_ASRCOLVOL,
+			FB_ASRCOLVOL_ASRCOLVOL, FM_ASRCOLVOL_ASRCOLVOL,
+			0, asrc_vol_tlv_arr),
+	/* R_ASRCORVOL PG 1 ADDR 0x19 */
+	SOC_SINGLE_TLV("ASRC Output Right Volume", R_ASRCORVOL,
+			FB_ASRCORVOL_ASRCOLVOL, FM_ASRCORVOL_ASRCOLVOL,
+			0, asrc_vol_tlv_arr),
+	/* R_IVOLCTLU PG 1 ADDR 0x1C */
+	/* R_ALCCTL0 PG 1 ADDR 0x1D */
+	SOC_ENUM("ALC Mode", alc_mode_enum),
+	SOC_ENUM("ALC Reference", alc_ref_enum),
+	SOC_SINGLE("Input Channel 3 ALC Switch",
+			R_ALCCTL0, FB_ALCCTL0_ALCEN3, 1, 0),
+	SOC_SINGLE("Input Channel 2 ALC Switch",
+			R_ALCCTL0, FB_ALCCTL0_ALCEN2, 1, 0),
+	SOC_SINGLE("Input Channel 1 ALC Switch",
+			R_ALCCTL0, FB_ALCCTL0_ALCEN1, 1, 0),
+	SOC_SINGLE("Input Channel 0 ALC Switch",
+			R_ALCCTL0, FB_ALCCTL0_ALCEN0, 1, 0),
+	/* R_ALCCTL1 PG 1 ADDR 0x1E */
+	SOC_SINGLE_TLV("ALC Max Gain Volume", R_ALCCTL1,
+			FB_ALCCTL1_MAXGAIN, FM_ALCCTL1_MAXGAIN,
+			0, alc_max_gain_tlv_arr),
+	SOC_SINGLE_TLV("ALC Target Volume", R_ALCCTL1,
+			FB_ALCCTL1_ALCL, FM_ALCCTL1_ALCL,
+			0, alc_target_tlv_arr),
+	/* R_ALCCTL2 PG 1 ADDR 0x1F */
+	SOC_SINGLE("ALC Zero Cross Switch",
+			R_ALCCTL2, FB_ALCCTL2_ALCZC, 1, 0),
+	SOC_SINGLE_TLV("ALC Min Gain Volume", R_ALCCTL2,
+			FB_ALCCTL2_MINGAIN, FM_ALCCTL2_MINGAIN,
+			0, alc_min_gain_tlv_arr),
+	SOC_SINGLE_RANGE("ALC Hold", R_ALCCTL2,
+			FB_ALCCTL2_HLD, 0, FM_ALCCTL2_HLD, 0),
+	/* R_ALCCTL3 PG 1 ADDR 0x20 */
+	SOC_SINGLE_RANGE("ALC Decay", R_ALCCTL3,
+			FB_ALCCTL3_DCY, 0, FM_ALCCTL3_DCY, 0),
+	SOC_SINGLE_RANGE("ALC Attack", R_ALCCTL3,
+			FB_ALCCTL3_ATK, 0, FM_ALCCTL3_ATK, 0),
+	/* R_NGATE PG 1 ADDR 0x21 */
+	SOC_SINGLE_TLV("Noise Gate Threshold Volume", R_NGATE,
+			FB_NGATE_NGTH, FM_NGATE_NGTH, 0, ngth_tlv_arr),
+	SOC_ENUM("Noise Gate Type", ngate_type_enum),
+	SOC_SINGLE("Noise Gate Switch", R_NGATE, FB_NGATE_NGAT, 1, 0),
+	/* R_DMICCTL PG 1 ADDR 0x22 */
+	SOC_SINGLE("Digital Mic 2 Switch", R_DMICCTL, FB_DMICCTL_DMIC2EN, 1, 0),
+	SOC_SINGLE("Digital Mic 1 Switch", R_DMICCTL, FB_DMICCTL_DMIC1EN, 1, 0),
+	SOC_ENUM("Digital Mic Mono Select", dmic_mono_sel_enum),
+	/* R_DACCTL PG 2 ADDR 0x01 */
+	SOC_ENUM("DAC Polarity Left", dac_pol_r_enum),
+	SOC_ENUM("DAC Polarity Right", dac_pol_l_enum),
+	SOC_ENUM("DAC Dither", dac_dith_enum),
+	SOC_SINGLE("DAC Mute Switch", R_DACCTL, FB_DACCTL_DACMUTE, 1, 0),
+	SOC_SINGLE("DAC De-Emphasis Switch", R_DACCTL, FB_DACCTL_DACDEM, 1, 0),
+	/* R_SPKCTL PG 2 ADDR 0x02 */
+	SOC_ENUM("Speaker Polarity Right", spk_pol_r_enum),
+	SOC_ENUM("Speaker Polarity Left", spk_pol_l_enum),
+	SOC_SINGLE("Speaker Mute Switch", R_SPKCTL, FB_SPKCTL_SPKMUTE, 1, 0),
+	SOC_SINGLE("Speaker De-Emphasis Switch",
+			R_SPKCTL, FB_SPKCTL_SPKDEM, 1, 0),
+	/* R_SUBCTL PG 2 ADDR 0x03 */
+	SOC_ENUM("Sub Polarity", sub_pol_enum),
+	SOC_SINGLE("SUB Mute Switch", R_SUBCTL, FB_SUBCTL_SUBMUTE, 1, 0),
+	SOC_SINGLE("Sub De-Emphasis Switch", R_SUBCTL, FB_SUBCTL_SUBDEM, 1, 0),
+	/* R_DCCTL PG 2 ADDR 0x04 */
+	SOC_SINGLE("Sub DC Removal Switch", R_DCCTL, FB_DCCTL_SUBDCBYP, 1, 1),
+	SOC_SINGLE("DAC DC Removal Switch", R_DCCTL, FB_DCCTL_DACDCBYP, 1, 1),
+	SOC_SINGLE("Speaker DC Removal Switch",
+			R_DCCTL, FB_DCCTL_SPKDCBYP, 1, 1),
+	SOC_SINGLE("DC Removal Coefficient Switch", R_DCCTL, FB_DCCTL_DCCOEFSEL,
+			FM_DCCTL_DCCOEFSEL, 0),
+	/* R_OVOLCTLU PG 2 ADDR 0x06 */
+	SOC_SINGLE("Output Fade Switch", R_OVOLCTLU, FB_OVOLCTLU_OFADE, 1, 0),
+	/* R_MVOLL PG 2 ADDR 0x08 */
+	/* R_MVOLR PG 2 ADDR 0x09 */
+	SOC_DOUBLE_R_TLV("Master Volume", R_MVOLL, R_MVOLR,
+			FB_MVOLL_MVOL_L, FM_MVOLL_MVOL_L, 0, mvol_tlv_arr),
+	/* R_HPVOLL PG 2 ADDR 0x0A */
+	/* R_HPVOLR PG 2 ADDR 0x0B */
+	SOC_DOUBLE_R_TLV("Headphone Volume", R_HPVOLL, R_HPVOLR,
+			FB_HPVOLL_HPVOL_L, FM_HPVOLL_HPVOL_L, 0,
+			hp_vol_tlv_arr),
+	/* R_SPKVOLL PG 2 ADDR 0x0C */
+	/* R_SPKVOLR PG 2 ADDR 0x0D */
+	SOC_DOUBLE_R_TLV("Speaker Volume", R_SPKVOLL, R_SPKVOLR,
+			FB_SPKVOLL_SPKVOL_L, FM_SPKVOLL_SPKVOL_L, 0,
+			spk_vol_tlv_arr),
+	/* R_SUBVOL PG 2 ADDR 0x10 */
+	SOC_SINGLE_TLV("Sub Volume", R_SUBVOL,
+			FB_SUBVOL_SUBVOL, FM_SUBVOL_SUBVOL, 0, spk_vol_tlv_arr),
+	/* R_SPKEQFILT PG 3 ADDR 0x01 */
+	SOC_SINGLE("Speaker EQ 2 Switch",
+			R_SPKEQFILT, FB_SPKEQFILT_EQ2EN, 1, 0),
+	SOC_ENUM("Speaker EQ 2 Band", spk_eq_enums[0]),
+	SOC_SINGLE("Speaker EQ 1 Switch",
+			R_SPKEQFILT, FB_SPKEQFILT_EQ1EN, 1, 0),
+	SOC_ENUM("Speaker EQ 1 Band", spk_eq_enums[1]),
+	/* R_SPKMBCEN PG 3 ADDR 0x0A */
+	SOC_SINGLE("Speaker MBC 3 Switch",
+			R_SPKMBCEN, FB_SPKMBCEN_MBCEN3, 1, 0),
+	SOC_SINGLE("Speaker MBC 2 Switch",
+			R_SPKMBCEN, FB_SPKMBCEN_MBCEN2, 1, 0),
+	SOC_SINGLE("Speaker MBC 1 Switch",
+			R_SPKMBCEN, FB_SPKMBCEN_MBCEN1, 1, 0),
+	/* R_SPKMBCCTL PG 3 ADDR 0x0B */
+	SOC_ENUM("Speaker MBC 3 Mode", spk_mbc3_lvl_det_mode_enum),
+	SOC_ENUM("Speaker MBC 3 Window", spk_mbc3_win_sel_enum),
+	SOC_ENUM("Speaker MBC 2 Mode", spk_mbc2_lvl_det_mode_enum),
+	SOC_ENUM("Speaker MBC 2 Window", spk_mbc2_win_sel_enum),
+	SOC_ENUM("Speaker MBC 1 Mode", spk_mbc1_lvl_det_mode_enum),
+	SOC_ENUM("Speaker MBC 1 Window", spk_mbc1_win_sel_enum),
+	/* R_SPKMBCMUG1 PG 3 ADDR 0x0C */
+	SOC_ENUM("Speaker MBC 1 Phase Polarity", spk_mbc1_phase_pol_enum),
+	SOC_SINGLE_TLV("Speaker MBC1 Make-Up Gain Volume", R_SPKMBCMUG1,
+			FB_SPKMBCMUG_MUGAIN, FM_SPKMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_SPKMBCTHR1 PG 3 ADDR 0x0D */
+	SOC_SINGLE_TLV("Speaker MBC 1 Compressor Threshold Volume",
+			R_SPKMBCTHR1, FB_SPKMBCTHR_THRESH, FM_SPKMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SPKMBCRAT1 PG 3 ADDR 0x0E */
+	SOC_ENUM("Speaker MBC 1 Compressor Ratio", spk_mbc1_comp_rat_enum),
+	/* R_SPKMBCATK1L PG 3 ADDR 0x0F */
+	/* R_SPKMBCATK1H PG 3 ADDR 0x10 */
+	SND_SOC_BYTES("Speaker MBC 1 Attack", R_SPKMBCATK1L, 2),
+	/* R_SPKMBCREL1L PG 3 ADDR 0x11 */
+	/* R_SPKMBCREL1H PG 3 ADDR 0x12 */
+	SND_SOC_BYTES("Speaker MBC 1 Release", R_SPKMBCREL1L, 2),
+	/* R_SPKMBCMUG2 PG 3 ADDR 0x13 */
+	SOC_ENUM("Speaker MBC 2 Phase Polarity", spk_mbc2_phase_pol_enum),
+	SOC_SINGLE_TLV("Speaker MBC2 Make-Up Gain Volume", R_SPKMBCMUG2,
+			FB_SPKMBCMUG_MUGAIN, FM_SPKMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_SPKMBCTHR2 PG 3 ADDR 0x14 */
+	SOC_SINGLE_TLV("Speaker MBC 2 Compressor Threshold Volume",
+			R_SPKMBCTHR2, FB_SPKMBCTHR_THRESH, FM_SPKMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SPKMBCRAT2 PG 3 ADDR 0x15 */
+	SOC_ENUM("Speaker MBC 2 Compressor Ratio", spk_mbc2_comp_rat_enum),
+	/* R_SPKMBCATK2L PG 3 ADDR 0x16 */
+	/* R_SPKMBCATK2H PG 3 ADDR 0x17 */
+	SND_SOC_BYTES("Speaker MBC 2 Attack", R_SPKMBCATK2L, 2),
+	/* R_SPKMBCREL2L PG 3 ADDR 0x18 */
+	/* R_SPKMBCREL2H PG 3 ADDR 0x19 */
+	SND_SOC_BYTES("Speaker MBC 2 Release", R_SPKMBCREL2L, 2),
+	/* R_SPKMBCMUG3 PG 3 ADDR 0x1A */
+	SOC_ENUM("Speaker MBC 3 Phase Polarity", spk_mbc3_phase_pol_enum),
+	SOC_SINGLE_TLV("Speaker MBC 3 Make-Up Gain Volume", R_SPKMBCMUG3,
+			FB_SPKMBCMUG_MUGAIN, FM_SPKMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_SPKMBCTHR3 PG 3 ADDR 0x1B */
+	SOC_SINGLE_TLV("Speaker MBC 3 Threshold Volume", R_SPKMBCTHR3,
+			FB_SPKMBCTHR_THRESH, FM_SPKMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SPKMBCRAT3 PG 3 ADDR 0x1C */
+	SOC_ENUM("Speaker MBC 3 Compressor Ratio", spk_mbc3_comp_rat_enum),
+	/* R_SPKMBCATK3L PG 3 ADDR 0x1D */
+	/* R_SPKMBCATK3H PG 3 ADDR 0x1E */
+	SND_SOC_BYTES("Speaker MBC 3 Attack", R_SPKMBCATK3L, 3),
+	/* R_SPKMBCREL3L PG 3 ADDR 0x1F */
+	/* R_SPKMBCREL3H PG 3 ADDR 0x20 */
+	SND_SOC_BYTES("Speaker MBC 3 Release", R_SPKMBCREL3L, 3),
+	/* R_SPKCLECTL PG 3 ADDR 0x21 */
+	SOC_ENUM("Speaker CLE Level Mode", spk_cle_lvl_mode_enum),
+	SOC_ENUM("Speaker CLE Window", spk_cle_win_sel_enum),
+	SOC_SINGLE("Speaker CLE Expander Switch",
+			R_SPKCLECTL, FB_SPKCLECTL_EXPEN, 1, 0),
+	SOC_SINGLE("Speaker CLE Limiter Switch",
+			R_SPKCLECTL, FB_SPKCLECTL_LIMEN, 1, 0),
+	SOC_SINGLE("Speaker CLE Compressor Switch",
+			R_SPKCLECTL, FB_SPKCLECTL_COMPEN, 1, 0),
+	/* R_SPKCLEMUG PG 3 ADDR 0x22 */
+	SOC_SINGLE_TLV("Speaker CLE Make-Up Gain Volume", R_SPKCLEMUG,
+			FB_SPKCLEMUG_MUGAIN, FM_SPKCLEMUG_MUGAIN,
+			0, cle_mug_tlv_arr),
+	/* R_SPKCOMPTHR PG 3 ADDR 0x23 */
+	SOC_SINGLE_TLV("Speaker Compressor Threshold Volume", R_SPKCOMPTHR,
+			FB_SPKCOMPTHR_THRESH, FM_SPKCOMPTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SPKCOMPRAT PG 3 ADDR 0x24 */
+	SOC_ENUM("Speaker Compressor Ratio", spk_comp_rat_enum),
+	/* R_SPKCOMPATKL PG 3 ADDR 0x25 */
+	/* R_SPKCOMPATKH PG 3 ADDR 0x26 */
+	SND_SOC_BYTES("Speaker Compressor Attack", R_SPKCOMPATKL, 2),
+	/* R_SPKCOMPRELL PG 3 ADDR 0x27 */
+	/* R_SPKCOMPRELH PG 3 ADDR 0x28 */
+	SND_SOC_BYTES("Speaker Compressor Release", R_SPKCOMPRELL, 2),
+	/* R_SPKLIMTHR PG 3 ADDR 0x29 */
+	SOC_SINGLE_TLV("Speaker Limiter Threshold Volume", R_SPKLIMTHR,
+			FB_SPKLIMTHR_THRESH, FM_SPKLIMTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SPKLIMTGT PG 3 ADDR 0x2A */
+	SOC_SINGLE_TLV("Speaker Limiter Target Volume", R_SPKLIMTGT,
+			FB_SPKLIMTGT_TARGET, FM_SPKLIMTGT_TARGET,
+			0, thr_tlv_arr),
+	/* R_SPKLIMATKL PG 3 ADDR 0x2B */
+	/* R_SPKLIMATKH PG 3 ADDR 0x2C */
+	SND_SOC_BYTES("Speaker Limiter Attack", R_SPKLIMATKL, 2),
+	/* R_SPKLIMRELL PG 3 ADDR 0x2D */
+	/* R_SPKLIMRELR PG 3 ADDR 0x2E */
+	SND_SOC_BYTES("Speaker Limiter Release", R_SPKLIMRELL, 2),
+	/* R_SPKEXPTHR PG 3 ADDR 0x2F */
+	SOC_SINGLE_TLV("Speaker Expander Threshold Volume", R_SPKEXPTHR,
+			FB_SPKEXPTHR_THRESH, FM_SPKEXPTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SPKEXPRAT PG 3 ADDR 0x30 */
+	SOC_ENUM("Speaker Expander Ratio", spk_exp_rat_enum),
+	/* R_SPKEXPATKL PG 3 ADDR 0x31 */
+	/* R_SPKEXPATKR PG 3 ADDR 0x32 */
+	SND_SOC_BYTES("Speaker Expander Attack", R_SPKEXPATKL, 2),
+	/* R_SPKEXPRELL PG 3 ADDR 0x33 */
+	/* R_SPKEXPRELR PG 3 ADDR 0x34 */
+	SND_SOC_BYTES("Speaker Expander Release", R_SPKEXPRELL, 2),
+	/* R_SPKFXCTL PG 3 ADDR 0x35 */
+	SOC_SINGLE("Speaker 3D Switch", R_SPKFXCTL, FB_SPKFXCTL_3DEN, 1, 0),
+	SOC_SINGLE("Speaker Treble Enhancement Switch",
+			R_SPKFXCTL, FB_SPKFXCTL_TEEN, 1, 0),
+	SOC_SINGLE("Speaker Treble NLF Switch",
+			R_SPKFXCTL, FB_SPKFXCTL_TNLFBYP, 1, 1),
+	SOC_SINGLE("Speaker Bass Enhancement Switch",
+			R_SPKFXCTL, FB_SPKFXCTL_BEEN, 1, 0),
+	SOC_SINGLE("Speaker Bass NLF Switch",
+			R_SPKFXCTL, FB_SPKFXCTL_BNLFBYP, 1, 1),
+	/* R_DACEQFILT PG 4 ADDR 0x01 */
+	SOC_SINGLE("DAC EQ 2 Switch",
+			R_DACEQFILT, FB_DACEQFILT_EQ2EN, 1, 0),
+	SOC_ENUM("DAC EQ 2 Band", dac_eq_enums[0]),
+	SOC_SINGLE("DAC EQ 1 Switch", R_DACEQFILT, FB_DACEQFILT_EQ1EN, 1, 0),
+	SOC_ENUM("DAC EQ 1 Band", dac_eq_enums[1]),
+	/* R_DACMBCEN PG 4 ADDR 0x0A */
+	SOC_SINGLE("DAC MBC 3 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN3, 1, 0),
+	SOC_SINGLE("DAC MBC 2 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN2, 1, 0),
+	SOC_SINGLE("DAC MBC 1 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN1, 1, 0),
+	/* R_DACMBCCTL PG 4 ADDR 0x0B */
+	SOC_ENUM("DAC MBC 3 Mode", dac_mbc3_lvl_det_mode_enum),
+	SOC_ENUM("DAC MBC 3 Window", dac_mbc3_win_sel_enum),
+	SOC_ENUM("DAC MBC 2 Mode", dac_mbc2_lvl_det_mode_enum),
+	SOC_ENUM("DAC MBC 2 Window", dac_mbc2_win_sel_enum),
+	SOC_ENUM("DAC MBC 1 Mode", dac_mbc1_lvl_det_mode_enum),
+	SOC_ENUM("DAC MBC 1 Window", dac_mbc1_win_sel_enum),
+	/* R_DACMBCMUG1 PG 4 ADDR 0x0C */
+	SOC_ENUM("DAC MBC 1 Phase Polarity", dac_mbc1_phase_pol_enum),
+	SOC_SINGLE_TLV("DAC MBC 1 Make-Up Gain Volume", R_DACMBCMUG1,
+			FB_DACMBCMUG_MUGAIN, FM_DACMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_DACMBCTHR1 PG 4 ADDR 0x0D */
+	SOC_SINGLE_TLV("DAC MBC 1 Compressor Threshold Volume", R_DACMBCTHR1,
+			FB_DACMBCTHR_THRESH, FM_DACMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_DACMBCRAT1 PG 4 ADDR 0x0E */
+	SOC_ENUM("DAC MBC 1 Compressor Ratio", dac_mbc1_comp_rat_enum),
+	/* R_DACMBCATK1L PG 4 ADDR 0x0F */
+	/* R_DACMBCATK1H PG 4 ADDR 0x10 */
+	SND_SOC_BYTES("DAC MBC 1 Attack", R_DACMBCATK1L, 2),
+	/* R_DACMBCREL1L PG 4 ADDR 0x11 */
+	/* R_DACMBCREL1H PG 4 ADDR 0x12 */
+	SND_SOC_BYTES("DAC MBC 1 Release", R_DACMBCREL1L, 2),
+	/* R_DACMBCMUG2 PG 4 ADDR 0x13 */
+	SOC_ENUM("DAC MBC 2 Phase Polarity", dac_mbc2_phase_pol_enum),
+	SOC_SINGLE_TLV("DAC MBC 2 Make-Up Gain Volume", R_DACMBCMUG2,
+			FB_DACMBCMUG_MUGAIN, FM_DACMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_DACMBCTHR2 PG 4 ADDR 0x14 */
+	SOC_SINGLE_TLV("DAC MBC 2 Compressor Threshold Volume", R_DACMBCTHR2,
+			FB_DACMBCTHR_THRESH, FM_DACMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_DACMBCRAT2 PG 4 ADDR 0x15 */
+	SOC_ENUM("DAC MBC 2 Compressor Ratio", dac_mbc2_comp_rat_enum),
+	/* R_DACMBCATK2L PG 4 ADDR 0x16 */
+	/* R_DACMBCATK2H PG 4 ADDR 0x17 */
+	SND_SOC_BYTES("DAC MBC 2 Attack", R_DACMBCATK2L, 2),
+	/* R_DACMBCREL2L PG 4 ADDR 0x18 */
+	/* R_DACMBCREL2H PG 4 ADDR 0x19 */
+	SND_SOC_BYTES("DAC MBC 2 Release", R_DACMBCREL2L, 2),
+	/* R_DACMBCMUG3 PG 4 ADDR 0x1A */
+	SOC_ENUM("DAC MBC 3 Phase Polarity", dac_mbc3_phase_pol_enum),
+	SOC_SINGLE_TLV("DAC MBC 3 Make-Up Gain Volume", R_DACMBCMUG3,
+			FB_DACMBCMUG_MUGAIN, FM_DACMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_DACMBCTHR3 PG 4 ADDR 0x1B */
+	SOC_SINGLE_TLV("DAC MBC 3 Threshold Volume", R_DACMBCTHR3,
+			FB_DACMBCTHR_THRESH, FM_DACMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_DACMBCRAT3 PG 4 ADDR 0x1C */
+	SOC_ENUM("DAC MBC 3 Compressor Ratio", dac_mbc3_comp_rat_enum),
+	/* R_DACMBCATK3L PG 4 ADDR 0x1D */
+	/* R_DACMBCATK3H PG 4 ADDR 0x1E */
+	SND_SOC_BYTES("DAC MBC 3 Attack", R_DACMBCATK3L, 3),
+	/* R_DACMBCREL3L PG 4 ADDR 0x1F */
+	/* R_DACMBCREL3H PG 4 ADDR 0x20 */
+	SND_SOC_BYTES("DAC MBC 3 Release", R_DACMBCREL3L, 3),
+	/* R_DACCLECTL PG 4 ADDR 0x21 */
+	SOC_ENUM("DAC CLE Level Mode", dac_cle_lvl_mode_enum),
+	SOC_ENUM("DAC CLE Window", dac_cle_win_sel_enum),
+	SOC_SINGLE("DAC CLE Expander Switch",
+			R_DACCLECTL, FB_DACCLECTL_EXPEN, 1, 0),
+	SOC_SINGLE("DAC CLE Limiter Switch",
+			R_DACCLECTL, FB_DACCLECTL_LIMEN, 1, 0),
+	SOC_SINGLE("DAC CLE Compressor Switch",
+			R_DACCLECTL, FB_DACCLECTL_COMPEN, 1, 0),
+	/* R_DACCLEMUG PG 4 ADDR 0x22 */
+	SOC_SINGLE_TLV("DAC CLE Make-Up Gain Volume", R_DACCLEMUG,
+			FB_DACCLEMUG_MUGAIN, FM_DACCLEMUG_MUGAIN,
+			0, cle_mug_tlv_arr),
+	/* R_DACCOMPTHR PG 4 ADDR 0x23 */
+	SOC_SINGLE_TLV("DAC Compressor Threshold Volume", R_DACCOMPTHR,
+			FB_DACCOMPTHR_THRESH, FM_DACCOMPTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_DACCOMPRAT PG 4 ADDR 0x24 */
+	SOC_ENUM("DAC Compressor Ratio", dac_comp_rat_enum),
+	/* R_DACCOMPATKL PG 4 ADDR 0x25 */
+	/* R_DACCOMPATKH PG 4 ADDR 0x26 */
+	SND_SOC_BYTES("DAC Compressor Attack", R_DACCOMPATKL, 2),
+	/* R_DACCOMPRELL PG 4 ADDR 0x27 */
+	/* R_DACCOMPRELH PG 4 ADDR 0x28 */
+	SND_SOC_BYTES("DAC Compressor Release", R_DACCOMPRELL, 2),
+	/* R_DACLIMTHR PG 4 ADDR 0x29 */
+	SOC_SINGLE_TLV("DAC Limiter Threshold Volume", R_DACLIMTHR,
+			FB_DACLIMTHR_THRESH, FM_DACLIMTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_DACLIMTGT PG 4 ADDR 0x2A */
+	SOC_SINGLE_TLV("DAC Limiter Target Volume", R_DACLIMTGT,
+			FB_DACLIMTGT_TARGET, FM_DACLIMTGT_TARGET,
+			0, thr_tlv_arr),
+	/* R_DACLIMATKL PG 4 ADDR 0x2B */
+	/* R_DACLIMATKH PG 4 ADDR 0x2C */
+	SND_SOC_BYTES("DAC Limiter Attack", R_DACLIMATKL, 2),
+	/* R_DACLIMRELL PG 4 ADDR 0x2D */
+	/* R_DACLIMRELR PG 4 ADDR 0x2E */
+	SND_SOC_BYTES("DAC Limiter Release", R_DACLIMRELL, 2),
+	/* R_DACEXPTHR PG 4 ADDR 0x2F */
+	SOC_SINGLE_TLV("DAC Expander Threshold Volume", R_DACEXPTHR,
+			FB_DACEXPTHR_THRESH, FM_DACEXPTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_DACEXPRAT PG 4 ADDR 0x30 */
+	SOC_ENUM("DAC Expander Ratio", dac_exp_rat_enum),
+	/* R_DACEXPATKL PG 4 ADDR 0x31 */
+	/* R_DACEXPATKR PG 4 ADDR 0x32 */
+	SND_SOC_BYTES("DAC Expander Attack", R_DACEXPATKL, 2),
+	/* R_DACEXPRELL PG 4 ADDR 0x33 */
+	/* R_DACEXPRELR PG 4 ADDR 0x34 */
+	SND_SOC_BYTES("DAC Expander Release", R_DACEXPRELL, 2),
+	/* R_DACFXCTL PG 4 ADDR 0x35 */
+	SOC_SINGLE("DAC 3D Switch", R_DACFXCTL, FB_DACFXCTL_3DEN, 1, 0),
+	SOC_SINGLE("DAC Treble Enhancement Switch",
+			R_DACFXCTL, FB_DACFXCTL_TEEN, 1, 0),
+	SOC_SINGLE("DAC Treble NLF Switch",
+			R_DACFXCTL, FB_DACFXCTL_TNLFBYP, 1, 1),
+	SOC_SINGLE("DAC Bass Enhancement Switch",
+			R_DACFXCTL, FB_DACFXCTL_BEEN, 1, 0),
+	SOC_SINGLE("DAC Bass NLF Switch",
+			R_DACFXCTL, FB_DACFXCTL_BNLFBYP, 1, 1),
+	/* R_SUBEQFILT PG 5 ADDR 0x01 */
+	SOC_SINGLE("Sub EQ 2 Switch",
+			R_SUBEQFILT, FB_SUBEQFILT_EQ2EN, 1, 0),
+	SOC_ENUM("Sub EQ 2 Band", sub_eq_enums[0]),
+	SOC_SINGLE("Sub EQ 1 Switch", R_SUBEQFILT, FB_SUBEQFILT_EQ1EN, 1, 0),
+	SOC_ENUM("Sub EQ 1 Band", sub_eq_enums[1]),
+	/* R_SUBMBCEN PG 5 ADDR 0x0A */
+	SOC_SINGLE("Sub MBC 3 Switch", R_SUBMBCEN, FB_SUBMBCEN_MBCEN3, 1, 0),
+	SOC_SINGLE("Sub MBC 2 Switch", R_SUBMBCEN, FB_SUBMBCEN_MBCEN2, 1, 0),
+	SOC_SINGLE("Sub MBC 1 Switch", R_SUBMBCEN, FB_SUBMBCEN_MBCEN1, 1, 0),
+	/* R_SUBMBCCTL PG 5 ADDR 0x0B */
+	SOC_ENUM("Sub MBC 3 Mode", sub_mbc3_lvl_det_mode_enum),
+	SOC_ENUM("Sub MBC 3 Window", sub_mbc3_win_sel_enum),
+	SOC_ENUM("Sub MBC 2 Mode", sub_mbc2_lvl_det_mode_enum),
+	SOC_ENUM("Sub MBC 2 Window", sub_mbc2_win_sel_enum),
+	SOC_ENUM("Sub MBC 1 Mode", sub_mbc1_lvl_det_mode_enum),
+	SOC_ENUM("Sub MBC 1 Window", sub_mbc1_win_sel_enum),
+	/* R_SUBMBCMUG1 PG 5 ADDR 0x0C */
+	SOC_ENUM("Sub MBC 1 Phase Polarity", sub_mbc1_phase_pol_enum),
+	SOC_SINGLE_TLV("Sub MBC 1 Make-Up Gain Volume", R_SUBMBCMUG1,
+			FB_SUBMBCMUG_MUGAIN, FM_SUBMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_SUBMBCTHR1 PG 5 ADDR 0x0D */
+	SOC_SINGLE_TLV("Sub MBC 1 Compressor Threshold Volume", R_SUBMBCTHR1,
+			FB_SUBMBCTHR_THRESH, FM_SUBMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SUBMBCRAT1 PG 5 ADDR 0x0E */
+	SOC_ENUM("Sub MBC 1 Compressor Ratio", sub_mbc1_comp_rat_enum),
+	/* R_SUBMBCATK1L PG 5 ADDR 0x0F */
+	/* R_SUBMBCATK1H PG 5 ADDR 0x10 */
+	SND_SOC_BYTES("Sub MBC 1 Attack", R_SUBMBCATK1L, 2),
+	/* R_SUBMBCREL1L PG 5 ADDR 0x11 */
+	/* R_SUBMBCREL1H PG 5 ADDR 0x12 */
+	SND_SOC_BYTES("Sub MBC 1 Release", R_SUBMBCREL1L, 2),
+	/* R_SUBMBCMUG2 PG 5 ADDR 0x13 */
+	SOC_ENUM("Sub MBC 2 Phase Polarity", sub_mbc2_phase_pol_enum),
+	SOC_SINGLE_TLV("Sub MBC 2 Make-Up Gain Volume", R_SUBMBCMUG2,
+			FB_SUBMBCMUG_MUGAIN, FM_SUBMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_SUBMBCTHR2 PG 5 ADDR 0x14 */
+	SOC_SINGLE_TLV("Sub MBC 2 Compressor Threshold Volume", R_SUBMBCTHR2,
+			FB_SUBMBCTHR_THRESH, FM_SUBMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SUBMBCRAT2 PG 5 ADDR 0x15 */
+	SOC_ENUM("Sub MBC 2 Compressor Ratio", sub_mbc2_comp_rat_enum),
+	/* R_SUBMBCATK2L PG 5 ADDR 0x16 */
+	/* R_SUBMBCATK2H PG 5 ADDR 0x17 */
+	SND_SOC_BYTES("Sub MBC 2 Attack", R_SUBMBCATK2L, 2),
+	/* R_SUBMBCREL2L PG 5 ADDR 0x18 */
+	/* R_SUBMBCREL2H PG 5 ADDR 0x19 */
+	SND_SOC_BYTES("Sub MBC 2 Release", R_SUBMBCREL2L, 2),
+	/* R_SUBMBCMUG3 PG 5 ADDR 0x1A */
+	SOC_ENUM("Sub MBC 3 Phase Polarity", sub_mbc3_phase_pol_enum),
+	SOC_SINGLE_TLV("Sub MBC 3 Make-Up Gain Volume", R_SUBMBCMUG3,
+			FB_SUBMBCMUG_MUGAIN, FM_SUBMBCMUG_MUGAIN,
+			0, mbc_mug_tlv_arr),
+	/* R_SUBMBCTHR3 PG 5 ADDR 0x1B */
+	SOC_SINGLE_TLV("Sub MBC 3 Threshold Volume", R_SUBMBCTHR3,
+			FB_SUBMBCTHR_THRESH, FM_SUBMBCTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SUBMBCRAT3 PG 5 ADDR 0x1C */
+	SOC_ENUM("Sub MBC 3 Compressor Ratio", sub_mbc3_comp_rat_enum),
+	/* R_SUBMBCATK3L PG 5 ADDR 0x1D */
+	/* R_SUBMBCATK3H PG 5 ADDR 0x1E */
+	SND_SOC_BYTES("Sub MBC 3 Attack", R_SUBMBCATK3L, 3),
+	/* R_SUBMBCREL3L PG 5 ADDR 0x1F */
+	/* R_SUBMBCREL3H PG 5 ADDR 0x20 */
+	SND_SOC_BYTES("Sub MBC 3 Release", R_SUBMBCREL3L, 3),
+	/* R_SUBCLECTL PG 5 ADDR 0x21 */
+	SOC_ENUM("Sub CLE Level Mode", sub_cle_lvl_mode_enum),
+	SOC_ENUM("Sub CLE Window", sub_cle_win_sel_enum),
+	SOC_SINGLE("Sub CLE Expander Switch",
+			R_SUBCLECTL, FB_SUBCLECTL_EXPEN, 1, 0),
+	SOC_SINGLE("Sub CLE Limiter Switch",
+			R_SUBCLECTL, FB_SUBCLECTL_LIMEN, 1, 0),
+	SOC_SINGLE("Sub CLE Compressor Switch",
+			R_SUBCLECTL, FB_SUBCLECTL_COMPEN, 1, 0),
+	/* R_SUBCLEMUG PG 5 ADDR 0x22 */
+	SOC_SINGLE_TLV("Sub CLE Make-Up Gain Volume", R_SUBCLEMUG,
+			FB_SUBCLEMUG_MUGAIN, FM_SUBCLEMUG_MUGAIN,
+			0, cle_mug_tlv_arr),
+	/* R_SUBCOMPTHR PG 5 ADDR 0x23 */
+	SOC_SINGLE_TLV("Sub Compressor Threshold Volume", R_SUBCOMPTHR,
+			FB_SUBCOMPTHR_THRESH, FM_SUBCOMPTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SUBCOMPRAT PG 5 ADDR 0x24 */
+	SOC_ENUM("Sub Compressor Ratio", sub_comp_rat_enum),
+	/* R_SUBCOMPATKL PG 5 ADDR 0x25 */
+	/* R_SUBCOMPATKH PG 5 ADDR 0x26 */
+	SND_SOC_BYTES("Sub Compressor Attack", R_SUBCOMPATKL, 2),
+	/* R_SUBCOMPRELL PG 5 ADDR 0x27 */
+	/* R_SUBCOMPRELH PG 5 ADDR 0x28 */
+	SND_SOC_BYTES("Sub Compressor Release", R_SUBCOMPRELL, 2),
+	/* R_SUBLIMTHR PG 5 ADDR 0x29 */
+	SOC_SINGLE_TLV("Sub Limiter Threshold Volume", R_SUBLIMTHR,
+			FB_SUBLIMTHR_THRESH, FM_SUBLIMTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SUBLIMTGT PG 5 ADDR 0x2A */
+	SOC_SINGLE_TLV("Sub Limiter Target Volume", R_SUBLIMTGT,
+			FB_SUBLIMTGT_TARGET, FM_SUBLIMTGT_TARGET,
+			0, thr_tlv_arr),
+	/* R_SUBLIMATKL PG 5 ADDR 0x2B */
+	/* R_SUBLIMATKH PG 5 ADDR 0x2C */
+	SND_SOC_BYTES("Sub Limiter Attack", R_SUBLIMATKL, 2),
+	/* R_SUBLIMRELL PG 5 ADDR 0x2D */
+	/* R_SUBLIMRELR PG 5 ADDR 0x2E */
+	SND_SOC_BYTES("Sub Limiter Release", R_SUBLIMRELL, 2),
+	/* R_SUBEXPTHR PG 5 ADDR 0x2F */
+	SOC_SINGLE_TLV("Sub Expander Threshold Volume", R_SUBEXPTHR,
+			FB_SUBEXPTHR_THRESH, FM_SUBEXPTHR_THRESH,
+			0, thr_tlv_arr),
+	/* R_SUBEXPRAT PG 5 ADDR 0x30 */
+	SOC_ENUM("Sub Expander Ratio", sub_exp_rat_enum),
+	/* R_SUBEXPATKL PG 5 ADDR 0x31 */
+	/* R_SUBEXPATKR PG 5 ADDR 0x32 */
+	SND_SOC_BYTES("Sub Expander Attack", R_SUBEXPATKL, 2),
+	/* R_SUBEXPRELL PG 5 ADDR 0x33 */
+	/* R_SUBEXPRELR PG 5 ADDR 0x34 */
+	SND_SOC_BYTES("Sub Expander Release", R_SUBEXPRELL, 2),
+	/* R_SUBFXCTL PG 5 ADDR 0x35 */
+	SOC_SINGLE("Sub Treble Enhancement Switch",
+			R_SUBFXCTL, FB_SUBFXCTL_TEEN, 1, 0),
+	SOC_SINGLE("Sub Treble NLF Switch",
+			R_SUBFXCTL, FB_SUBFXCTL_TNLFBYP, 1, 1),
+	SOC_SINGLE("Sub Bass Enhancement Switch",
+			R_SUBFXCTL, FB_SUBFXCTL_BEEN, 1, 0),
+	SOC_SINGLE("Sub Bass NLF Switch",
+			R_SUBFXCTL, FB_SUBFXCTL_BNLFBYP, 1, 1),
+	COEFF_RAM_CTL("DAC Cascade 1 Left BiQuad 1", BIQUAD_SIZE, 0x00),
+	COEFF_RAM_CTL("DAC Cascade 1 Left BiQuad 2", BIQUAD_SIZE, 0x05),
+	COEFF_RAM_CTL("DAC Cascade 1 Left BiQuad 3", BIQUAD_SIZE, 0x0a),
+	COEFF_RAM_CTL("DAC Cascade 1 Left BiQuad 4", BIQUAD_SIZE, 0x0f),
+	COEFF_RAM_CTL("DAC Cascade 1 Left BiQuad 5", BIQUAD_SIZE, 0x14),
+	COEFF_RAM_CTL("DAC Cascade 1 Left BiQuad 6", BIQUAD_SIZE, 0x19),
+
+	COEFF_RAM_CTL("DAC Cascade 1 Right BiQuad 1", BIQUAD_SIZE, 0x20),
+	COEFF_RAM_CTL("DAC Cascade 1 Right BiQuad 2", BIQUAD_SIZE, 0x25),
+	COEFF_RAM_CTL("DAC Cascade 1 Right BiQuad 3", BIQUAD_SIZE, 0x2a),
+	COEFF_RAM_CTL("DAC Cascade 1 Right BiQuad 4", BIQUAD_SIZE, 0x2f),
+	COEFF_RAM_CTL("DAC Cascade 1 Right BiQuad 5", BIQUAD_SIZE, 0x34),
+	COEFF_RAM_CTL("DAC Cascade 1 Right BiQuad 6", BIQUAD_SIZE, 0x39),
+
+	COEFF_RAM_CTL("DAC Cascade 1 Left Prescale", COEFF_SIZE, 0x1f),
+	COEFF_RAM_CTL("DAC Cascade 1 Right Prescale", COEFF_SIZE, 0x3f),
+
+	COEFF_RAM_CTL("DAC Cascade 2 Left BiQuad 1", BIQUAD_SIZE, 0x40),
+	COEFF_RAM_CTL("DAC Cascade 2 Left BiQuad 2", BIQUAD_SIZE, 0x45),
+	COEFF_RAM_CTL("DAC Cascade 2 Left BiQuad 3", BIQUAD_SIZE, 0x4a),
+	COEFF_RAM_CTL("DAC Cascade 2 Left BiQuad 4", BIQUAD_SIZE, 0x4f),
+	COEFF_RAM_CTL("DAC Cascade 2 Left BiQuad 5", BIQUAD_SIZE, 0x54),
+	COEFF_RAM_CTL("DAC Cascade 2 Left BiQuad 6", BIQUAD_SIZE, 0x59),
+
+	COEFF_RAM_CTL("DAC Cascade 2 Right BiQuad 1", BIQUAD_SIZE, 0x60),
+	COEFF_RAM_CTL("DAC Cascade 2 Right BiQuad 2", BIQUAD_SIZE, 0x65),
+	COEFF_RAM_CTL("DAC Cascade 2 Right BiQuad 3", BIQUAD_SIZE, 0x6a),
+	COEFF_RAM_CTL("DAC Cascade 2 Right BiQuad 4", BIQUAD_SIZE, 0x6f),
+	COEFF_RAM_CTL("DAC Cascade 2 Right BiQuad 5", BIQUAD_SIZE, 0x74),
+	COEFF_RAM_CTL("DAC Cascade 2 Right BiQuad 6", BIQUAD_SIZE, 0x79),
+
+	COEFF_RAM_CTL("DAC Cascade 2 Left Prescale", COEFF_SIZE, 0x5f),
+	COEFF_RAM_CTL("DAC Cascade 2 Right Prescale", COEFF_SIZE, 0x7f),
+
+	COEFF_RAM_CTL("DAC Bass Extraction BiQuad 1", BIQUAD_SIZE, 0x80),
+	COEFF_RAM_CTL("DAC Bass Extraction BiQuad 2", BIQUAD_SIZE, 0x85),
+
+	COEFF_RAM_CTL("DAC Bass Non Linear Function 1", COEFF_SIZE, 0x8a),
+	COEFF_RAM_CTL("DAC Bass Non Linear Function 2", COEFF_SIZE, 0x8b),
+
+	COEFF_RAM_CTL("DAC Bass Limiter BiQuad", BIQUAD_SIZE, 0x8c),
+
+	COEFF_RAM_CTL("DAC Bass Cut Off BiQuad", BIQUAD_SIZE, 0x91),
+
+	COEFF_RAM_CTL("DAC Bass Mix", COEFF_SIZE, 0x96),
+
+	COEFF_RAM_CTL("DAC Treb Extraction BiQuad 1", BIQUAD_SIZE, 0x97),
+	COEFF_RAM_CTL("DAC Treb Extraction BiQuad 2", BIQUAD_SIZE, 0x9c),
+
+	COEFF_RAM_CTL("DAC Treb Non Linear Function 1", COEFF_SIZE, 0xa1),
+	COEFF_RAM_CTL("DAC Treb Non Linear Function 2", COEFF_SIZE, 0xa2),
+
+	COEFF_RAM_CTL("DAC Treb Limiter BiQuad", BIQUAD_SIZE, 0xa3),
+
+	COEFF_RAM_CTL("DAC Treb Cut Off BiQuad", BIQUAD_SIZE, 0xa8),
+
+	COEFF_RAM_CTL("DAC Treb Mix", COEFF_SIZE, 0xad),
+
+	COEFF_RAM_CTL("DAC 3D", COEFF_SIZE, 0xae),
+
+	COEFF_RAM_CTL("DAC 3D Mix", COEFF_SIZE, 0xaf),
+
+	COEFF_RAM_CTL("DAC MBC 1 BiQuad 1", BIQUAD_SIZE, 0xb0),
+	COEFF_RAM_CTL("DAC MBC 1 BiQuad 2", BIQUAD_SIZE, 0xb5),
+
+	COEFF_RAM_CTL("DAC MBC 2 BiQuad 1", BIQUAD_SIZE, 0xba),
+	COEFF_RAM_CTL("DAC MBC 2 BiQuad 2", BIQUAD_SIZE, 0xbf),
+
+	COEFF_RAM_CTL("DAC MBC 3 BiQuad 1", BIQUAD_SIZE, 0xc4),
+	COEFF_RAM_CTL("DAC MBC 3 BiQuad 2", BIQUAD_SIZE, 0xc9),
+
+	COEFF_RAM_CTL("Speaker Cascade 1 Left BiQuad 1", BIQUAD_SIZE, 0x00),
+	COEFF_RAM_CTL("Speaker Cascade 1 Left BiQuad 2", BIQUAD_SIZE, 0x05),
+	COEFF_RAM_CTL("Speaker Cascade 1 Left BiQuad 3", BIQUAD_SIZE, 0x0a),
+	COEFF_RAM_CTL("Speaker Cascade 1 Left BiQuad 4", BIQUAD_SIZE, 0x0f),
+	COEFF_RAM_CTL("Speaker Cascade 1 Left BiQuad 5", BIQUAD_SIZE, 0x14),
+	COEFF_RAM_CTL("Speaker Cascade 1 Left BiQuad 6", BIQUAD_SIZE, 0x19),
+
+	COEFF_RAM_CTL("Speaker Cascade 1 Right BiQuad 1", BIQUAD_SIZE, 0x20),
+	COEFF_RAM_CTL("Speaker Cascade 1 Right BiQuad 2", BIQUAD_SIZE, 0x25),
+	COEFF_RAM_CTL("Speaker Cascade 1 Right BiQuad 3", BIQUAD_SIZE, 0x2a),
+	COEFF_RAM_CTL("Speaker Cascade 1 Right BiQuad 4", BIQUAD_SIZE, 0x2f),
+	COEFF_RAM_CTL("Speaker Cascade 1 Right BiQuad 5", BIQUAD_SIZE, 0x34),
+	COEFF_RAM_CTL("Speaker Cascade 1 Right BiQuad 6", BIQUAD_SIZE, 0x39),
+
+	COEFF_RAM_CTL("Speaker Cascade 1 Left Prescale", COEFF_SIZE, 0x1f),
+	COEFF_RAM_CTL("Speaker Cascade 1 Right Prescale", COEFF_SIZE, 0x3f),
+
+	COEFF_RAM_CTL("Speaker Cascade 2 Left BiQuad 1", BIQUAD_SIZE, 0x40),
+	COEFF_RAM_CTL("Speaker Cascade 2 Left BiQuad 2", BIQUAD_SIZE, 0x45),
+	COEFF_RAM_CTL("Speaker Cascade 2 Left BiQuad 3", BIQUAD_SIZE, 0x4a),
+	COEFF_RAM_CTL("Speaker Cascade 2 Left BiQuad 4", BIQUAD_SIZE, 0x4f),
+	COEFF_RAM_CTL("Speaker Cascade 2 Left BiQuad 5", BIQUAD_SIZE, 0x54),
+	COEFF_RAM_CTL("Speaker Cascade 2 Left BiQuad 6", BIQUAD_SIZE, 0x59),
+
+	COEFF_RAM_CTL("Speaker Cascade 2 Right BiQuad 1", BIQUAD_SIZE, 0x60),
+	COEFF_RAM_CTL("Speaker Cascade 2 Right BiQuad 2", BIQUAD_SIZE, 0x65),
+	COEFF_RAM_CTL("Speaker Cascade 2 Right BiQuad 3", BIQUAD_SIZE, 0x6a),
+	COEFF_RAM_CTL("Speaker Cascade 2 Right BiQuad 4", BIQUAD_SIZE, 0x6f),
+	COEFF_RAM_CTL("Speaker Cascade 2 Right BiQuad 5", BIQUAD_SIZE, 0x74),
+	COEFF_RAM_CTL("Speaker Cascade 2 Right BiQuad 6", BIQUAD_SIZE, 0x79),
+
+	COEFF_RAM_CTL("Speaker Cascade 2 Left Prescale", COEFF_SIZE, 0x5f),
+	COEFF_RAM_CTL("Speaker Cascade 2 Right Prescale", COEFF_SIZE, 0x7f),
+
+	COEFF_RAM_CTL("Speaker Bass Extraction BiQuad 1", BIQUAD_SIZE, 0x80),
+	COEFF_RAM_CTL("Speaker Bass Extraction BiQuad 2", BIQUAD_SIZE, 0x85),
+
+	COEFF_RAM_CTL("Speaker Bass Non Linear Function 1", COEFF_SIZE, 0x8a),
+	COEFF_RAM_CTL("Speaker Bass Non Linear Function 2", COEFF_SIZE, 0x8b),
+
+	COEFF_RAM_CTL("Speaker Bass Limiter BiQuad", BIQUAD_SIZE, 0x8c),
+
+	COEFF_RAM_CTL("Speaker Bass Cut Off BiQuad", BIQUAD_SIZE, 0x91),
+
+	COEFF_RAM_CTL("Speaker Bass Mix", COEFF_SIZE, 0x96),
+
+	COEFF_RAM_CTL("Speaker Treb Extraction BiQuad 1", BIQUAD_SIZE, 0x97),
+	COEFF_RAM_CTL("Speaker Treb Extraction BiQuad 2", BIQUAD_SIZE, 0x9c),
+
+	COEFF_RAM_CTL("Speaker Treb Non Linear Function 1", COEFF_SIZE, 0xa1),
+	COEFF_RAM_CTL("Speaker Treb Non Linear Function 2", COEFF_SIZE, 0xa2),
+
+	COEFF_RAM_CTL("Speaker Treb Limiter BiQuad", BIQUAD_SIZE, 0xa3),
+
+	COEFF_RAM_CTL("Speaker Treb Cut Off BiQuad", BIQUAD_SIZE, 0xa8),
+
+	COEFF_RAM_CTL("Speaker Treb Mix", COEFF_SIZE, 0xad),
+
+	COEFF_RAM_CTL("Speaker 3D", COEFF_SIZE, 0xae),
+
+	COEFF_RAM_CTL("Speaker 3D Mix", COEFF_SIZE, 0xaf),
+
+	COEFF_RAM_CTL("Speaker MBC 1 BiQuad 1", BIQUAD_SIZE, 0xb0),
+	COEFF_RAM_CTL("Speaker MBC 1 BiQuad 2", BIQUAD_SIZE, 0xb5),
+
+	COEFF_RAM_CTL("Speaker MBC 2 BiQuad 1", BIQUAD_SIZE, 0xba),
+	COEFF_RAM_CTL("Speaker MBC 2 BiQuad 2", BIQUAD_SIZE, 0xbf),
+
+	COEFF_RAM_CTL("Speaker MBC 3 BiQuad 1", BIQUAD_SIZE, 0xc4),
+	COEFF_RAM_CTL("Speaker MBC 3 BiQuad 2", BIQUAD_SIZE, 0xc9),
+
+	COEFF_RAM_CTL("Sub Cascade 1 Left BiQuad 1", BIQUAD_SIZE, 0x00),
+	COEFF_RAM_CTL("Sub Cascade 1 Left BiQuad 2", BIQUAD_SIZE, 0x05),
+	COEFF_RAM_CTL("Sub Cascade 1 Left BiQuad 3", BIQUAD_SIZE, 0x0a),
+	COEFF_RAM_CTL("Sub Cascade 1 Left BiQuad 4", BIQUAD_SIZE, 0x0f),
+	COEFF_RAM_CTL("Sub Cascade 1 Left BiQuad 5", BIQUAD_SIZE, 0x14),
+	COEFF_RAM_CTL("Sub Cascade 1 Left BiQuad 6", BIQUAD_SIZE, 0x19),
+
+	COEFF_RAM_CTL("Sub Cascade 1 Right BiQuad 1", BIQUAD_SIZE, 0x20),
+	COEFF_RAM_CTL("Sub Cascade 1 Right BiQuad 2", BIQUAD_SIZE, 0x25),
+	COEFF_RAM_CTL("Sub Cascade 1 Right BiQuad 3", BIQUAD_SIZE, 0x2a),
+	COEFF_RAM_CTL("Sub Cascade 1 Right BiQuad 4", BIQUAD_SIZE, 0x2f),
+	COEFF_RAM_CTL("Sub Cascade 1 Right BiQuad 5", BIQUAD_SIZE, 0x34),
+	COEFF_RAM_CTL("Sub Cascade 1 Right BiQuad 6", BIQUAD_SIZE, 0x39),
+
+	COEFF_RAM_CTL("Sub Cascade 1 Left Prescale", COEFF_SIZE, 0x1f),
+	COEFF_RAM_CTL("Sub Cascade 1 Right Prescale", COEFF_SIZE, 0x3f),
+
+	COEFF_RAM_CTL("Sub Cascade 2 Left BiQuad 1", BIQUAD_SIZE, 0x40),
+	COEFF_RAM_CTL("Sub Cascade 2 Left BiQuad 2", BIQUAD_SIZE, 0x45),
+	COEFF_RAM_CTL("Sub Cascade 2 Left BiQuad 3", BIQUAD_SIZE, 0x4a),
+	COEFF_RAM_CTL("Sub Cascade 2 Left BiQuad 4", BIQUAD_SIZE, 0x4f),
+	COEFF_RAM_CTL("Sub Cascade 2 Left BiQuad 5", BIQUAD_SIZE, 0x54),
+	COEFF_RAM_CTL("Sub Cascade 2 Left BiQuad 6", BIQUAD_SIZE, 0x59),
+
+	COEFF_RAM_CTL("Sub Cascade 2 Right BiQuad 1", BIQUAD_SIZE, 0x60),
+	COEFF_RAM_CTL("Sub Cascade 2 Right BiQuad 2", BIQUAD_SIZE, 0x65),
+	COEFF_RAM_CTL("Sub Cascade 2 Right BiQuad 3", BIQUAD_SIZE, 0x6a),
+	COEFF_RAM_CTL("Sub Cascade 2 Right BiQuad 4", BIQUAD_SIZE, 0x6f),
+	COEFF_RAM_CTL("Sub Cascade 2 Right BiQuad 5", BIQUAD_SIZE, 0x74),
+	COEFF_RAM_CTL("Sub Cascade 2 Right BiQuad 6", BIQUAD_SIZE, 0x79),
+
+	COEFF_RAM_CTL("Sub Cascade 2 Left Prescale", COEFF_SIZE, 0x5f),
+	COEFF_RAM_CTL("Sub Cascade 2 Right Prescale", COEFF_SIZE, 0x7f),
+
+	COEFF_RAM_CTL("Sub Bass Extraction BiQuad 1", BIQUAD_SIZE, 0x80),
+	COEFF_RAM_CTL("Sub Bass Extraction BiQuad 2", BIQUAD_SIZE, 0x85),
+
+	COEFF_RAM_CTL("Sub Bass Non Linear Function 1", COEFF_SIZE, 0x8a),
+	COEFF_RAM_CTL("Sub Bass Non Linear Function 2", COEFF_SIZE, 0x8b),
+
+	COEFF_RAM_CTL("Sub Bass Limiter BiQuad", BIQUAD_SIZE, 0x8c),
+
+	COEFF_RAM_CTL("Sub Bass Cut Off BiQuad", BIQUAD_SIZE, 0x91),
+
+	COEFF_RAM_CTL("Sub Bass Mix", COEFF_SIZE, 0x96),
+
+	COEFF_RAM_CTL("Sub Treb Extraction BiQuad 1", BIQUAD_SIZE, 0x97),
+	COEFF_RAM_CTL("Sub Treb Extraction BiQuad 2", BIQUAD_SIZE, 0x9c),
+
+	COEFF_RAM_CTL("Sub Treb Non Linear Function 1", COEFF_SIZE, 0xa1),
+	COEFF_RAM_CTL("Sub Treb Non Linear Function 2", COEFF_SIZE, 0xa2),
+
+	COEFF_RAM_CTL("Sub Treb Limiter BiQuad", BIQUAD_SIZE, 0xa3),
+
+	COEFF_RAM_CTL("Sub Treb Cut Off BiQuad", BIQUAD_SIZE, 0xa8),
+
+	COEFF_RAM_CTL("Sub Treb Mix", COEFF_SIZE, 0xad),
+
+	COEFF_RAM_CTL("Sub 3D", COEFF_SIZE, 0xae),
+
+	COEFF_RAM_CTL("Sub 3D Mix", COEFF_SIZE, 0xaf),
+
+	COEFF_RAM_CTL("Sub MBC 1 BiQuad 1", BIQUAD_SIZE, 0xb0),
+	COEFF_RAM_CTL("Sub MBC 1 BiQuad 2", BIQUAD_SIZE, 0xb5),
+
+	COEFF_RAM_CTL("Sub MBC 2 BiQuad 1", BIQUAD_SIZE, 0xba),
+	COEFF_RAM_CTL("Sub MBC 2 BiQuad 2", BIQUAD_SIZE, 0xbf),
+
+	COEFF_RAM_CTL("Sub MBC 3 BiQuad 1", BIQUAD_SIZE, 0xc4),
+	COEFF_RAM_CTL("Sub MBC 3 BiQuad 2", BIQUAD_SIZE, 0xc9),
+};
+
+static struct snd_soc_dapm_widget const tscs454_dapm_widgets[] = {
+	/* R_PLLCTL PG 0 ADDR 0x15 */
+	SND_SOC_DAPM_SUPPLY("PLL 1 Power", R_PLLCTL, FB_PLLCTL_PU_PLL1, 0,
+			pll_power_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SUPPLY("PLL 2 Power", R_PLLCTL, FB_PLLCTL_PU_PLL2, 0,
+			pll_power_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
+	/* R_I2SPINC0 PG 0 ADDR 0x22 */
+	SND_SOC_DAPM_AIF_OUT("DAI 3 Out", "DAI 3 Capture", 0,
+			R_I2SPINC0, FB_I2SPINC0_SDO3TRI, 1),
+	SND_SOC_DAPM_AIF_OUT("DAI 2 Out", "DAI 2 Capture", 0,
+			R_I2SPINC0, FB_I2SPINC0_SDO2TRI, 1),
+	SND_SOC_DAPM_AIF_OUT("DAI 1 Out", "DAI 1 Capture", 0,
+			R_I2SPINC0, FB_I2SPINC0_SDO1TRI, 1),
+	/* R_PWRM0 PG 0 ADDR 0x33 */
+	SND_SOC_DAPM_ADC("Input Processor Channel 3", NULL,
+			R_PWRM0, FB_PWRM0_INPROC3PU, 0),
+	SND_SOC_DAPM_ADC("Input Processor Channel 2", NULL,
+			R_PWRM0, FB_PWRM0_INPROC2PU, 0),
+	SND_SOC_DAPM_ADC("Input Processor Channel 1", NULL,
+			R_PWRM0, FB_PWRM0_INPROC1PU, 0),
+	SND_SOC_DAPM_ADC("Input Processor Channel 0", NULL,
+			R_PWRM0, FB_PWRM0_INPROC0PU, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias 2",
+			R_PWRM0, FB_PWRM0_MICB2PU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias 1", R_PWRM0,
+			FB_PWRM0_MICB1PU, 0, NULL, 0),
+	/* R_PWRM1 PG 0 ADDR 0x34 */
+	SND_SOC_DAPM_SUPPLY("Sub Power", R_PWRM1, FB_PWRM1_SUBPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Headphone Left Power",
+			R_PWRM1, FB_PWRM1_HPLPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Headphone Right Power",
+			R_PWRM1, FB_PWRM1_HPRPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Speaker Left Power",
+			R_PWRM1, FB_PWRM1_SPKLPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Speaker Right Power",
+			R_PWRM1, FB_PWRM1_SPKRPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Differential Input 2 Power",
+			R_PWRM1, FB_PWRM1_D2S2PU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Differential Input 1 Power",
+			R_PWRM1, FB_PWRM1_D2S1PU, 0, NULL, 0),
+	/* R_PWRM2 PG 0 ADDR 0x35 */
+	SND_SOC_DAPM_SUPPLY("DAI 3 Out Power",
+			R_PWRM2, FB_PWRM2_I2S3OPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAI 2 Out Power",
+			R_PWRM2, FB_PWRM2_I2S2OPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAI 1 Out Power",
+			R_PWRM2, FB_PWRM2_I2S1OPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAI 3 In Power",
+			R_PWRM2, FB_PWRM2_I2S3IPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAI 2 In Power",
+			R_PWRM2, FB_PWRM2_I2S2IPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAI 1 In Power",
+			R_PWRM2, FB_PWRM2_I2S1IPU, 0, NULL, 0),
+	/* R_PWRM3 PG 0 ADDR 0x36 */
+	SND_SOC_DAPM_SUPPLY("Line Out Left Power",
+			R_PWRM3, FB_PWRM3_LLINEPU, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Line Out Right Power",
+			R_PWRM3, FB_PWRM3_RLINEPU, 0, NULL, 0),
+	/* R_PWRM4 PG 0 ADDR 0x37 */
+	SND_SOC_DAPM_DAC("Sub", NULL, R_PWRM4, FB_PWRM4_OPSUBPU, 0),
+	SND_SOC_DAPM_DAC("DAC Left", NULL, R_PWRM4, FB_PWRM4_OPDACLPU, 0),
+	SND_SOC_DAPM_DAC("DAC Right", NULL, R_PWRM4, FB_PWRM4_OPDACRPU, 0),
+	SND_SOC_DAPM_DAC("ClassD Left", NULL, R_PWRM4, FB_PWRM4_OPSPKLPU, 0),
+	SND_SOC_DAPM_DAC("ClassD Right", NULL, R_PWRM4, FB_PWRM4_OPSPKRPU, 0),
+	/* R_AUDIOMUX1  PG 0 ADDR 0x3A */
+	SND_SOC_DAPM_MUX("DAI 2 Out Mux", SND_SOC_NOPM, 0, 0,
+			&dai2_mux_dapm_enum),
+	SND_SOC_DAPM_MUX("DAI 1 Out Mux", SND_SOC_NOPM, 0, 0,
+			&dai1_mux_dapm_enum),
+	/* R_AUDIOMUX2 PG 0 ADDR 0x3B */
+	SND_SOC_DAPM_MUX("DAC Mux", SND_SOC_NOPM, 0, 0,
+			&dac_mux_dapm_enum),
+	SND_SOC_DAPM_MUX("DAI 3 Out Mux", SND_SOC_NOPM, 0, 0,
+			&dai3_mux_dapm_enum),
+	/* R_AUDIOMUX3 PG 0 ADDR 0x3C */
+	SND_SOC_DAPM_MUX("Sub Mux", SND_SOC_NOPM, 0, 0,
+			&sub_mux_dapm_enum),
+	SND_SOC_DAPM_MUX("Speaker Mux", SND_SOC_NOPM, 0, 0,
+			&classd_mux_dapm_enum),
+	/* R_HSDCTL1 PG 1 ADDR 0x01 */
+	SND_SOC_DAPM_SUPPLY("GHS Detect Power", R_HSDCTL1,
+			FB_HSDCTL1_CON_DET_PWD, 1, NULL, 0),
+	/* R_CH0AIC PG 1 ADDR 0x06 */
+	SND_SOC_DAPM_MUX("Input Boost Channel 0 Mux", SND_SOC_NOPM, 0, 0,
+			&in_bst_mux_ch0_dapm_enum),
+	SND_SOC_DAPM_MUX("ADC Channel 0 Mux", SND_SOC_NOPM, 0, 0,
+			&adc_mux_ch0_dapm_enum),
+	SND_SOC_DAPM_MUX("Input Processor Channel 0 Mux", SND_SOC_NOPM, 0, 0,
+			&in_proc_mux_ch0_dapm_enum),
+	/* R_CH1AIC PG 1 ADDR 0x07 */
+	SND_SOC_DAPM_MUX("Input Boost Channel 1 Mux", SND_SOC_NOPM, 0, 0,
+			&in_bst_mux_ch1_dapm_enum),
+	SND_SOC_DAPM_MUX("ADC Channel 1 Mux", SND_SOC_NOPM, 0, 0,
+			&adc_mux_ch1_dapm_enum),
+	SND_SOC_DAPM_MUX("Input Processor Channel 1 Mux", SND_SOC_NOPM, 0, 0,
+			&in_proc_mux_ch1_dapm_enum),
+	/* Virtual */
+	SND_SOC_DAPM_AIF_IN("DAI 3 In", "DAI 3 Playback", 0,
+			SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DAI 2 In", "DAI 2 Playback", 0,
+			SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DAI 1 In", "DAI 1 Playback", 0,
+			SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("PLLs", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("Sub Out"),
+	SND_SOC_DAPM_OUTPUT("Headphone Left"),
+	SND_SOC_DAPM_OUTPUT("Headphone Right"),
+	SND_SOC_DAPM_OUTPUT("Speaker Left"),
+	SND_SOC_DAPM_OUTPUT("Speaker Right"),
+	SND_SOC_DAPM_OUTPUT("Line Out Left"),
+	SND_SOC_DAPM_OUTPUT("Line Out Right"),
+	SND_SOC_DAPM_INPUT("D2S 2"),
+	SND_SOC_DAPM_INPUT("D2S 1"),
+	SND_SOC_DAPM_INPUT("Line In 1 Left"),
+	SND_SOC_DAPM_INPUT("Line In 1 Right"),
+	SND_SOC_DAPM_INPUT("Line In 2 Left"),
+	SND_SOC_DAPM_INPUT("Line In 2 Right"),
+	SND_SOC_DAPM_INPUT("Line In 3 Left"),
+	SND_SOC_DAPM_INPUT("Line In 3 Right"),
+	SND_SOC_DAPM_INPUT("DMic 1"),
+	SND_SOC_DAPM_INPUT("DMic 2"),
+
+	SND_SOC_DAPM_MUX("CH 0_1 Mux", SND_SOC_NOPM, 0, 0,
+			&ch_0_1_mux_dapm_enum),
+	SND_SOC_DAPM_MUX("CH 2_3 Mux", SND_SOC_NOPM, 0, 0,
+			&ch_2_3_mux_dapm_enum),
+	SND_SOC_DAPM_MUX("CH 4_5 Mux", SND_SOC_NOPM, 0, 0,
+			&ch_4_5_mux_dapm_enum),
+};
+
+static struct snd_soc_dapm_route const tscs454_intercon[] = {
+	/* PLLs */
+	{"PLLs", NULL, "PLL 1 Power", pll_connected},
+	{"PLLs", NULL, "PLL 2 Power", pll_connected},
+	/* Inputs */
+	{"DAI 3 In", NULL, "DAI 3 In Power"},
+	{"DAI 2 In", NULL, "DAI 2 In Power"},
+	{"DAI 1 In", NULL, "DAI 1 In Power"},
+	/* Outputs */
+	{"DAI 3 Out", NULL, "DAI 3 Out Power"},
+	{"DAI 2 Out", NULL, "DAI 2 Out Power"},
+	{"DAI 1 Out", NULL, "DAI 1 Out Power"},
+	/* Ch Muxing */
+	{"CH 0_1 Mux", "DAI 1", "DAI 1 In"},
+	{"CH 0_1 Mux", "TDM 0_1", "DAI 1 In"},
+	{"CH 2_3 Mux", "DAI 2", "DAI 2 In"},
+	{"CH 2_3 Mux", "TDM 2_3", "DAI 1 In"},
+	{"CH 4_5 Mux", "DAI 3", "DAI 2 In"},
+	{"CH 4_5 Mux", "TDM 4_5", "DAI 1 In"},
+	/* In/Out Muxing */
+	{"DAI 1 Out Mux", "CH 0_1", "CH 0_1 Mux"},
+	{"DAI 1 Out Mux", "CH 2_3", "CH 2_3 Mux"},
+	{"DAI 1 Out Mux", "CH 4_5", "CH 4_5 Mux"},
+	{"DAI 2 Out Mux", "CH 0_1", "CH 0_1 Mux"},
+	{"DAI 2 Out Mux", "CH 2_3", "CH 2_3 Mux"},
+	{"DAI 2 Out Mux", "CH 4_5", "CH 4_5 Mux"},
+	{"DAI 3 Out Mux", "CH 0_1", "CH 0_1 Mux"},
+	{"DAI 3 Out Mux", "CH 2_3", "CH 2_3 Mux"},
+	{"DAI 3 Out Mux", "CH 4_5", "CH 4_5 Mux"},
+	/******************
+	 * Playback Paths *
+	 ******************/
+	/* DAC Path */
+	{"DAC Mux", "CH 4_5", "CH 4_5 Mux"},
+	{"DAC Mux", "CH 2_3", "CH 2_3 Mux"},
+	{"DAC Mux", "CH 0_1", "CH 0_1 Mux"},
+	{"DAC Left", NULL, "DAC Mux"},
+	{"DAC Right", NULL, "DAC Mux"},
+	{"DAC Left", NULL, "PLLs"},
+	{"DAC Right", NULL, "PLLs"},
+	{"Headphone Left", NULL, "Headphone Left Power"},
+	{"Headphone Right", NULL, "Headphone Right Power"},
+	{"Headphone Left", NULL, "DAC Left"},
+	{"Headphone Right", NULL, "DAC Right"},
+	/* Line Out */
+	{"Line Out Left", NULL, "Line Out Left Power"},
+	{"Line Out Right", NULL, "Line Out Right Power"},
+	{"Line Out Left", NULL, "DAC Left"},
+	{"Line Out Right", NULL, "DAC Right"},
+	/* ClassD Path */
+	{"Speaker Mux", "CH 4_5", "CH 4_5 Mux"},
+	{"Speaker Mux", "CH 2_3", "CH 2_3 Mux"},
+	{"Speaker Mux", "CH 0_1", "CH 0_1 Mux"},
+	{"ClassD Left", NULL, "Speaker Mux"},
+	{"ClassD Right", NULL, "Speaker Mux"},
+	{"ClassD Left", NULL, "PLLs"},
+	{"ClassD Right", NULL, "PLLs"},
+	{"Speaker Left", NULL, "Speaker Left Power"},
+	{"Speaker Right", NULL, "Speaker Right Power"},
+	{"Speaker Left", NULL, "ClassD Left"},
+	{"Speaker Right", NULL, "ClassD Right"},
+	/* Sub Path */
+	{"Sub Mux", "CH 4", "CH 4_5 Mux"},
+	{"Sub Mux", "CH 5", "CH 4_5 Mux"},
+	{"Sub Mux", "CH 4 + 5", "CH 4_5 Mux"},
+	{"Sub Mux", "CH 2", "CH 2_3 Mux"},
+	{"Sub Mux", "CH 3", "CH 2_3 Mux"},
+	{"Sub Mux", "CH 2 + 3", "CH 2_3 Mux"},
+	{"Sub Mux", "CH 0", "CH 0_1 Mux"},
+	{"Sub Mux", "CH 1", "CH 0_1 Mux"},
+	{"Sub Mux", "CH 0 + 1", "CH 0_1 Mux"},
+	{"Sub Mux", "ADC/DMic 1 Left", "Input Processor Channel 0"},
+	{"Sub Mux", "ADC/DMic 1 Right", "Input Processor Channel 1"},
+	{"Sub Mux", "ADC/DMic 1 Left Plus Right", "Input Processor Channel 0"},
+	{"Sub Mux", "ADC/DMic 1 Left Plus Right", "Input Processor Channel 1"},
+	{"Sub Mux", "DMic 2 Left", "DMic 2"},
+	{"Sub Mux", "DMic 2 Right", "DMic 2"},
+	{"Sub Mux", "DMic 2 Left Plus Right", "DMic 2"},
+	{"Sub Mux", "ClassD Left", "ClassD Left"},
+	{"Sub Mux", "ClassD Right", "ClassD Right"},
+	{"Sub Mux", "ClassD Left Plus Right", "ClassD Left"},
+	{"Sub Mux", "ClassD Left Plus Right", "ClassD Right"},
+	{"Sub", NULL, "Sub Mux"},
+	{"Sub", NULL, "PLLs"},
+	{"Sub Out", NULL, "Sub Power"},
+	{"Sub Out", NULL, "Sub"},
+	/*****************
+	 * Capture Paths *
+	 *****************/
+	{"Input Boost Channel 0 Mux", "Input 3", "Line In 3 Left"},
+	{"Input Boost Channel 0 Mux", "Input 2", "Line In 2 Left"},
+	{"Input Boost Channel 0 Mux", "Input 1", "Line In 1 Left"},
+	{"Input Boost Channel 0 Mux", "D2S", "D2S 1"},
+
+	{"Input Boost Channel 1 Mux", "Input 3", "Line In 3 Right"},
+	{"Input Boost Channel 1 Mux", "Input 2", "Line In 2 Right"},
+	{"Input Boost Channel 1 Mux", "Input 1", "Line In 1 Right"},
+	{"Input Boost Channel 1 Mux", "D2S", "D2S 2"},
+
+	{"ADC Channel 0 Mux", "Input 3 Boost Bypass", "Line In 3 Left"},
+	{"ADC Channel 0 Mux", "Input 2 Boost Bypass", "Line In 2 Left"},
+	{"ADC Channel 0 Mux", "Input 1 Boost Bypass", "Line In 1 Left"},
+	{"ADC Channel 0 Mux", "Input Boost", "Input Boost Channel 0 Mux"},
+
+	{"ADC Channel 1 Mux", "Input 3 Boost Bypass", "Line In 3 Right"},
+	{"ADC Channel 1 Mux", "Input 2 Boost Bypass", "Line In 2 Right"},
+	{"ADC Channel 1 Mux", "Input 1 Boost Bypass", "Line In 1 Right"},
+	{"ADC Channel 1 Mux", "Input Boost", "Input Boost Channel 1 Mux"},
+
+	{"Input Processor Channel 0 Mux", "ADC", "ADC Channel 0 Mux"},
+	{"Input Processor Channel 0 Mux", "DMic", "DMic 1"},
+
+	{"Input Processor Channel 0", NULL, "PLLs"},
+	{"Input Processor Channel 0", NULL, "Input Processor Channel 0 Mux"},
+
+	{"Input Processor Channel 1 Mux", "ADC", "ADC Channel 1 Mux"},
+	{"Input Processor Channel 1 Mux", "DMic", "DMic 1"},
+
+	{"Input Processor Channel 1", NULL, "PLLs"},
+	{"Input Processor Channel 1", NULL, "Input Processor Channel 1 Mux"},
+
+	{"Input Processor Channel 2", NULL, "PLLs"},
+	{"Input Processor Channel 2", NULL, "DMic 2"},
+
+	{"Input Processor Channel 3", NULL, "PLLs"},
+	{"Input Processor Channel 3", NULL, "DMic 2"},
+
+	{"DAI 1 Out Mux", "ADC/DMic 1", "Input Processor Channel 0"},
+	{"DAI 1 Out Mux", "ADC/DMic 1", "Input Processor Channel 1"},
+	{"DAI 1 Out Mux", "DMic 2", "Input Processor Channel 2"},
+	{"DAI 1 Out Mux", "DMic 2", "Input Processor Channel 3"},
+
+	{"DAI 2 Out Mux", "ADC/DMic 1", "Input Processor Channel 0"},
+	{"DAI 2 Out Mux", "ADC/DMic 1", "Input Processor Channel 1"},
+	{"DAI 2 Out Mux", "DMic 2", "Input Processor Channel 2"},
+	{"DAI 2 Out Mux", "DMic 2", "Input Processor Channel 3"},
+
+	{"DAI 3 Out Mux", "ADC/DMic 1", "Input Processor Channel 0"},
+	{"DAI 3 Out Mux", "ADC/DMic 1", "Input Processor Channel 1"},
+	{"DAI 3 Out Mux", "DMic 2", "Input Processor Channel 2"},
+	{"DAI 3 Out Mux", "DMic 2", "Input Processor Channel 3"},
+
+	{"DAI 1 Out", NULL, "DAI 1 Out Mux"},
+	{"DAI 2 Out", NULL, "DAI 2 Out Mux"},
+	{"DAI 3 Out", NULL, "DAI 3 Out Mux"},
+};
+
+/* This is used when BCLK is sourcing the PLLs */
+static int tscs454_set_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	unsigned int val;
+	int bclk_dai;
+	int ret;
+
+	dev_dbg(component->dev, "%s(): freq = %u\n", __func__, freq);
+
+	ret = snd_soc_component_read(component, R_PLLCTL, &val);
+	if (ret < 0)
+		return ret;
+
+	bclk_dai = (val & FM_PLLCTL_BCLKSEL) >> FB_PLLCTL_BCLKSEL;
+	if (bclk_dai != dai->id)
+		return 0;
+
+	tscs454->bclk_freq = freq;
+	return set_sysclk(component);
+}
+
+static int tscs454_set_bclk_ratio(struct snd_soc_dai *dai,
+		unsigned int ratio)
+{
+	unsigned int mask;
+	int ret;
+	struct snd_soc_component *component = dai->component;
+	unsigned int val;
+	int shift;
+
+	dev_dbg(component->dev, "set_bclk_ratio() id = %d ratio = %u\n",
+			dai->id, ratio);
+
+	switch (dai->id) {
+	case TSCS454_DAI1_ID:
+		mask = FM_I2SCMC_BCMP1;
+		shift = FB_I2SCMC_BCMP1;
+		break;
+	case TSCS454_DAI2_ID:
+		mask = FM_I2SCMC_BCMP2;
+		shift = FB_I2SCMC_BCMP2;
+		break;
+	case TSCS454_DAI3_ID:
+		mask = FM_I2SCMC_BCMP3;
+		shift = FB_I2SCMC_BCMP3;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Unknown audio interface (%d)\n", ret);
+		return ret;
+	}
+
+	switch (ratio) {
+	case 32:
+		val = I2SCMC_BCMP_32X;
+		break;
+	case 40:
+		val = I2SCMC_BCMP_40X;
+		break;
+	case 64:
+		val = I2SCMC_BCMP_64X;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Unsupported bclk ratio (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component,
+			R_I2SCMC, mask, val << shift);
+	if (ret < 0) {
+		dev_err(component->dev,
+				"Failed to set DAI BCLK ratio (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int set_aif_master_from_fmt(struct snd_soc_component *component,
+		struct aif *aif, unsigned int fmt)
+{
+	int ret;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		aif->master = true;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		aif->master = false;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Unsupported format (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int set_aif_tdm_delay(struct snd_soc_component *component,
+		unsigned int dai_id, bool delay)
+{
+	unsigned int reg;
+	int ret;
+
+	switch (dai_id) {
+	case TSCS454_DAI1_ID:
+		reg = R_TDMCTL0;
+		break;
+	case TSCS454_DAI2_ID:
+		reg = R_PCMP2CTL0;
+		break;
+	case TSCS454_DAI3_ID:
+		reg = R_PCMP3CTL0;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev,
+				"DAI %d unknown (%d)\n", dai_id + 1, ret);
+		return ret;
+	}
+	ret = snd_soc_component_update_bits(component,
+			reg, FM_TDMCTL0_BDELAY, delay);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to setup tdm format (%d)\n",
+				ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int set_aif_format_from_fmt(struct snd_soc_component *component,
+		unsigned int dai_id, unsigned int fmt)
+{
+	unsigned int reg;
+	unsigned int val;
+	int ret;
+
+	switch (dai_id) {
+	case TSCS454_DAI1_ID:
+		reg = R_I2SP1CTL;
+		break;
+	case TSCS454_DAI2_ID:
+		reg = R_I2SP2CTL;
+		break;
+	case TSCS454_DAI3_ID:
+		reg = R_I2SP3CTL;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev,
+				"DAI %d unknown (%d)\n", dai_id + 1, ret);
+		return ret;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		val = FV_FORMAT_RIGHT;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		val = FV_FORMAT_LEFT;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		val = FV_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ret = set_aif_tdm_delay(component, dai_id, true);
+		if (ret < 0)
+			return ret;
+		val = FV_FORMAT_TDM;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ret = set_aif_tdm_delay(component, dai_id, false);
+		if (ret < 0)
+			return ret;
+		val = FV_FORMAT_TDM;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Format unsupported (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component,
+			reg, FM_I2SPCTL_FORMAT, val);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to set DAI %d format (%d)\n",
+				dai_id + 1, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int
+set_aif_clock_format_from_fmt(struct snd_soc_component *component,
+		unsigned int dai_id, unsigned int fmt)
+{
+	unsigned int reg;
+	unsigned int val;
+	int ret;
+
+	switch (dai_id) {
+	case TSCS454_DAI1_ID:
+		reg = R_I2SP1CTL;
+		break;
+	case TSCS454_DAI2_ID:
+		reg = R_I2SP2CTL;
+		break;
+	case TSCS454_DAI3_ID:
+		reg = R_I2SP3CTL;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev,
+				"DAI %d unknown (%d)\n", dai_id + 1, ret);
+		return ret;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		val = FV_BCLKP_NOT_INVERTED | FV_LRCLKP_NOT_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		val = FV_BCLKP_NOT_INVERTED | FV_LRCLKP_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		val = FV_BCLKP_INVERTED | FV_LRCLKP_NOT_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		val = FV_BCLKP_INVERTED | FV_LRCLKP_INVERTED;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Format unknown (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component, reg,
+			FM_I2SPCTL_BCLKP | FM_I2SPCTL_LRCLKP, val);
+	if (ret < 0) {
+		dev_err(component->dev,
+				"Failed to set clock polarity for DAI%d (%d)\n",
+				dai_id + 1, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tscs454_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	struct aif *aif = &tscs454->aifs[dai->id];
+	int ret;
+
+	ret = set_aif_master_from_fmt(component, aif, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = set_aif_format_from_fmt(component, dai->id, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = set_aif_clock_format_from_fmt(component, dai->id, fmt);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tscs454_dai1_set_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int tx_mask, unsigned int rx_mask, int slots,
+		int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	unsigned int val;
+	int ret;
+
+	if (!slots)
+		return 0;
+
+	if (tx_mask >= (1 << slots) || rx_mask >= (1 << slots)) {
+		ret = -EINVAL;
+		dev_err(component->dev, "Invalid TDM slot mask (%d)\n", ret);
+		return ret;
+	}
+
+	switch (slots) {
+	case 2:
+		val = FV_TDMSO_2 | FV_TDMSI_2;
+		break;
+	case 4:
+		val = FV_TDMSO_4 | FV_TDMSI_4;
+		break;
+	case 6:
+		val = FV_TDMSO_6 | FV_TDMSI_6;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Invalid number of slots (%d)\n", ret);
+		return ret;
+	}
+
+	switch (slot_width) {
+	case 16:
+		val = val | FV_TDMDSS_16;
+		break;
+	case 24:
+		val = val | FV_TDMDSS_24;
+		break;
+	case 32:
+		val = val | FV_TDMDSS_32;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Invalid TDM slot width (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_component_write(component, R_TDMCTL1, val);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to set slots (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tscs454_dai23_set_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int tx_mask, unsigned int rx_mask, int slots,
+		int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	unsigned int reg;
+	unsigned int val;
+	int ret;
+
+	if (!slots)
+		return 0;
+
+	if (tx_mask >= (1 << slots) || rx_mask >= (1 << slots)) {
+		ret = -EINVAL;
+		dev_err(component->dev, "Invalid TDM slot mask (%d)\n", ret);
+		return ret;
+	}
+
+	switch (dai->id) {
+	case TSCS454_DAI2_ID:
+		reg = R_PCMP2CTL1;
+		break;
+	case TSCS454_DAI3_ID:
+		reg = R_PCMP3CTL1;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Unrecognized interface %d (%d)\n",
+				dai->id, ret);
+		return ret;
+	}
+
+	switch (slots) {
+	case 1:
+		val = FV_PCMSOP_1 | FV_PCMSIP_1;
+		break;
+	case 2:
+		val = FV_PCMSOP_2 | FV_PCMSIP_2;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Invalid number of slots (%d)\n", ret);
+		return ret;
+	}
+
+	switch (slot_width) {
+	case 16:
+		val = val | FV_PCMDSSP_16;
+		break;
+	case 24:
+		val = val | FV_PCMDSSP_24;
+		break;
+	case 32:
+		val = val | FV_PCMDSSP_32;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Invalid TDM slot width (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_component_write(component, reg, val);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to set slots (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int set_aif_fs(struct snd_soc_component *component,
+		unsigned int id,
+		unsigned int rate)
+{
+	unsigned int reg;
+	unsigned int br;
+	unsigned int bm;
+	int ret;
+
+	switch (rate) {
+	case 8000:
+		br = FV_I2SMBR_32;
+		bm = FV_I2SMBM_0PT25;
+		break;
+	case 16000:
+		br = FV_I2SMBR_32;
+		bm = FV_I2SMBM_0PT5;
+		break;
+	case 24000:
+		br = FV_I2SMBR_48;
+		bm = FV_I2SMBM_0PT5;
+		break;
+	case 32000:
+		br = FV_I2SMBR_32;
+		bm = FV_I2SMBM_1;
+		break;
+	case 48000:
+		br = FV_I2SMBR_48;
+		bm = FV_I2SMBM_1;
+		break;
+	case 96000:
+		br = FV_I2SMBR_48;
+		bm = FV_I2SMBM_2;
+		break;
+	case 11025:
+		br = FV_I2SMBR_44PT1;
+		bm = FV_I2SMBM_0PT25;
+		break;
+	case 22050:
+		br = FV_I2SMBR_44PT1;
+		bm = FV_I2SMBM_0PT5;
+		break;
+	case 44100:
+		br = FV_I2SMBR_44PT1;
+		bm = FV_I2SMBM_1;
+		break;
+	case 88200:
+		br = FV_I2SMBR_44PT1;
+		bm = FV_I2SMBM_2;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Unsupported sample rate (%d)\n", ret);
+		return ret;
+	}
+
+	switch (id) {
+	case TSCS454_DAI1_ID:
+		reg = R_I2S1MRATE;
+		break;
+	case TSCS454_DAI2_ID:
+		reg = R_I2S2MRATE;
+		break;
+	case TSCS454_DAI3_ID:
+		reg = R_I2S3MRATE;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "DAI ID not recognized (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component, reg,
+			FM_I2SMRATE_I2SMBR | FM_I2SMRATE_I2SMBM, br|bm);
+	if (ret < 0) {
+		dev_err(component->dev,
+				"Failed to update register (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int set_aif_sample_format(struct snd_soc_component *component,
+		snd_pcm_format_t format,
+		int aif_id)
+{
+	unsigned int reg;
+	unsigned int width;
+	int ret;
+
+	switch (format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		width = FV_WL_16;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		width = FV_WL_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		width = FV_WL_24;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
+		width = FV_WL_32;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Unsupported format width (%d)\n", ret);
+		return ret;
+	}
+
+	switch (aif_id) {
+	case TSCS454_DAI1_ID:
+		reg = R_I2SP1CTL;
+		break;
+	case TSCS454_DAI2_ID:
+		reg = R_I2SP2CTL;
+		break;
+	case TSCS454_DAI3_ID:
+		reg = R_I2SP3CTL;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "AIF ID not recognized (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component,
+			reg, FM_I2SPCTL_WL, width);
+	if (ret < 0) {
+		dev_err(component->dev,
+				"Failed to set sample width (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tscs454_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	unsigned int fs = params_rate(params);
+	struct aif *aif = &tscs454->aifs[dai->id];
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&tscs454->aifs_status_lock);
+
+	dev_dbg(component->dev, "%s(): aif %d fs = %u\n", __func__,
+			aif->id, fs);
+
+	if (!aif_active(&tscs454->aifs_status, aif->id)) {
+		if (PLL_44_1K_RATE % fs)
+			aif->pll = &tscs454->pll1;
+		else
+			aif->pll = &tscs454->pll2;
+
+		dev_dbg(component->dev, "Reserving pll %d for aif %d\n",
+				aif->pll->id, aif->id);
+
+		reserve_pll(aif->pll);
+	}
+
+	if (!aifs_active(&tscs454->aifs_status)) { /* First active aif */
+		ret = snd_soc_component_read(component, R_ISRC, &val);
+		if (ret < 0)
+			goto exit;
+
+		if ((val & FM_ISRC_IBR) == FV_IBR_48)
+			tscs454->internal_rate.pll = &tscs454->pll1;
+		else
+			tscs454->internal_rate.pll = &tscs454->pll2;
+
+		dev_dbg(component->dev, "Reserving pll %d for ir\n",
+				tscs454->internal_rate.pll->id);
+
+		reserve_pll(tscs454->internal_rate.pll);
+	}
+
+	ret = set_aif_fs(component, aif->id, fs);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to set aif fs (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = set_aif_sample_format(component, params_format(params), aif->id);
+	if (ret < 0) {
+		dev_err(component->dev,
+				"Failed to set aif sample format (%d)\n", ret);
+		goto exit;
+	}
+
+	set_aif_status_active(&tscs454->aifs_status, aif->id,
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	dev_dbg(component->dev, "Set aif %d active. Streams status is 0x%x\n",
+		aif->id, tscs454->aifs_status.streams);
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs454->aifs_status_lock);
+
+	return ret;
+}
+
+static int tscs454_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	struct aif *aif = &tscs454->aifs[dai->id];
+
+	return aif_free(component, aif,
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+}
+
+static int tscs454_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	int ret;
+	struct snd_soc_component *component = dai->component;
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	struct aif *aif = &tscs454->aifs[dai->id];
+
+	ret = aif_prepare(component, aif);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops const tscs454_dai1_ops = {
+	.set_sysclk	= tscs454_set_sysclk,
+	.set_bclk_ratio = tscs454_set_bclk_ratio,
+	.set_fmt	= tscs454_set_dai_fmt,
+	.set_tdm_slot	= tscs454_dai1_set_tdm_slot,
+	.hw_params	= tscs454_hw_params,
+	.hw_free	= tscs454_hw_free,
+	.prepare	= tscs454_prepare,
+};
+
+static struct snd_soc_dai_ops const tscs454_dai23_ops = {
+	.set_sysclk	= tscs454_set_sysclk,
+	.set_bclk_ratio = tscs454_set_bclk_ratio,
+	.set_fmt	= tscs454_set_dai_fmt,
+	.set_tdm_slot	= tscs454_dai23_set_tdm_slot,
+	.hw_params	= tscs454_hw_params,
+	.hw_free	= tscs454_hw_free,
+	.prepare	= tscs454_prepare,
+};
+
+static int tscs454_probe(struct snd_soc_component *component)
+{
+	struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
+	unsigned int val;
+	int ret = 0;
+
+	switch (tscs454->sysclk_src_id) {
+	case PLL_INPUT_XTAL:
+		val = FV_PLLISEL_XTAL;
+		break;
+	case PLL_INPUT_MCLK1:
+		val = FV_PLLISEL_MCLK1;
+		break;
+	case PLL_INPUT_MCLK2:
+		val = FV_PLLISEL_MCLK2;
+		break;
+	case PLL_INPUT_BCLK:
+		val = FV_PLLISEL_BCLK;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(component->dev, "Invalid sysclk src id (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component, R_PLLCTL,
+			FM_PLLCTL_PLLISEL, val);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to set PLL input (%d)\n", ret);
+		return ret;
+	}
+
+	if (tscs454->sysclk_src_id < PLL_INPUT_BCLK)
+		ret = set_sysclk(component);
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver soc_component_dev_tscs454 = {
+	.probe =	tscs454_probe,
+	.dapm_widgets = tscs454_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tscs454_dapm_widgets),
+	.dapm_routes = tscs454_intercon,
+	.num_dapm_routes = ARRAY_SIZE(tscs454_intercon),
+	.controls =	tscs454_snd_controls,
+	.num_controls = ARRAY_SIZE(tscs454_snd_controls),
+};
+
+#define TSCS454_RATES SNDRV_PCM_RATE_8000_96000
+
+#define TSCS454_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+	| SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE \
+	| SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver tscs454_dais[] = {
+	{
+		.name = "tscs454-dai1",
+		.id = TSCS454_DAI1_ID,
+		.playback = {
+			.stream_name = "DAI 1 Playback",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = TSCS454_RATES,
+			.formats = TSCS454_FORMATS,},
+		.capture = {
+			.stream_name = "DAI 1 Capture",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = TSCS454_RATES,
+			.formats = TSCS454_FORMATS,},
+		.ops = &tscs454_dai1_ops,
+		.symmetric_rates = 1,
+		.symmetric_channels = 1,
+		.symmetric_samplebits = 1,
+	},
+	{
+		.name = "tscs454-dai2",
+		.id = TSCS454_DAI2_ID,
+		.playback = {
+			.stream_name = "DAI 2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = TSCS454_RATES,
+			.formats = TSCS454_FORMATS,},
+		.capture = {
+			.stream_name = "DAI 2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = TSCS454_RATES,
+			.formats = TSCS454_FORMATS,},
+		.ops = &tscs454_dai23_ops,
+		.symmetric_rates = 1,
+		.symmetric_channels = 1,
+		.symmetric_samplebits = 1,
+	},
+	{
+		.name = "tscs454-dai3",
+		.id = TSCS454_DAI3_ID,
+		.playback = {
+			.stream_name = "DAI 3 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = TSCS454_RATES,
+			.formats = TSCS454_FORMATS,},
+		.capture = {
+			.stream_name = "DAI 3 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = TSCS454_RATES,
+			.formats = TSCS454_FORMATS,},
+		.ops = &tscs454_dai23_ops,
+		.symmetric_rates = 1,
+		.symmetric_channels = 1,
+		.symmetric_samplebits = 1,
+	},
+};
+
+static char const * const src_names[] = {
+	"xtal", "mclk1", "mclk2", "bclk"};
+
+static int tscs454_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct tscs454 *tscs454;
+	int src;
+	int ret;
+
+	tscs454 = devm_kzalloc(&i2c->dev, sizeof(*tscs454), GFP_KERNEL);
+	if (!tscs454)
+		return -ENOMEM;
+
+	ret = tscs454_data_init(tscs454, i2c);
+	if (ret < 0)
+		return ret;
+
+	i2c_set_clientdata(i2c, tscs454);
+
+	for (src = PLL_INPUT_XTAL; src < PLL_INPUT_BCLK; src++) {
+		tscs454->sysclk = devm_clk_get(&i2c->dev, src_names[src]);
+		if (!IS_ERR(tscs454->sysclk)) {
+			break;
+		} else if (PTR_ERR(tscs454->sysclk) != -ENOENT) {
+			ret = PTR_ERR(tscs454->sysclk);
+			dev_err(&i2c->dev, "Failed to get sysclk (%d)\n", ret);
+			return ret;
+		}
+	}
+	dev_dbg(&i2c->dev, "PLL input is %s\n", src_names[src]);
+	tscs454->sysclk_src_id = src;
+
+	ret = regmap_write(tscs454->regmap,
+			R_RESET, FV_RESET_PWR_ON_DEFAULTS);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to reset the component (%d)\n", ret);
+		return ret;
+	}
+	regcache_mark_dirty(tscs454->regmap);
+
+	ret = regmap_register_patch(tscs454->regmap, tscs454_patch,
+			ARRAY_SIZE(tscs454_patch));
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to apply patch (%d)\n", ret);
+		return ret;
+	}
+	/* Sync pg sel reg with cache */
+	regmap_write(tscs454->regmap, R_PAGESEL, 0x00);
+
+	ret = snd_soc_register_component(&i2c->dev, &soc_component_dev_tscs454,
+			tscs454_dais, ARRAY_SIZE(tscs454_dais));
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to register component (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id tscs454_i2c_id[] = {
+	{ "tscs454", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tscs454_i2c_id);
+
+static const struct of_device_id tscs454_of_match[] = {
+	{ .compatible = "tempo,tscs454", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tscs454_of_match);
+
+static struct i2c_driver tscs454_i2c_driver = {
+	.driver = {
+		.name = "tscs454",
+		.of_match_table = tscs454_of_match,
+	},
+	.probe =    tscs454_i2c_probe,
+	.id_table = tscs454_i2c_id,
+};
+
+module_i2c_driver(tscs454_i2c_driver);
+
+MODULE_AUTHOR("Tempo Semiconductor <steven.eckhoff.opensource@gmail.com");
+MODULE_DESCRIPTION("ASoC TSCS454 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/tscs454.h b/sound/soc/codecs/tscs454.h
new file mode 100644
index 000000000000..1142d73d3168
--- /dev/null
+++ b/sound/soc/codecs/tscs454.h
@@ -0,0 +1,2323 @@
+// SPDX-License-Identifier: GPL-2.0
+// tscs454.h -- TSCS454 ALSA SoC Audio driver
+// Copyright 2018 Tempo Semiconductor, Inc.
+// Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+
+#ifndef __REDWOODPUBLIC_H__
+#define __REDWOODPUBLIC_H__
+
+#define VIRT_BASE 0x00
+#define PAGE_LEN 0x100
+#define VIRT_PAGE_BASE(page) (VIRT_BASE + (PAGE_LEN * page))
+#define VIRT_ADDR(page, address) (VIRT_PAGE_BASE(page) + address)
+#define ADDR(page, virt_address) (virt_address - VIRT_PAGE_BASE(page))
+
+#define R_PAGESEL                       0x0
+#define R_RESET                         VIRT_ADDR(0x0, 0x1)
+#define R_IRQEN                         VIRT_ADDR(0x0, 0x2)
+#define R_IRQMASK                       VIRT_ADDR(0x0, 0x3)
+#define R_IRQSTAT                       VIRT_ADDR(0x0, 0x4)
+#define R_DEVADD0                       VIRT_ADDR(0x0, 0x6)
+#define R_DEVID                         VIRT_ADDR(0x0, 0x8)
+#define R_DEVREV                        VIRT_ADDR(0x0, 0x9)
+#define R_PLLSTAT                       VIRT_ADDR(0x0, 0x0A)
+#define R_PLL1CTL                       VIRT_ADDR(0x0, 0x0B)
+#define R_PLL1RDIV                      VIRT_ADDR(0x0, 0x0C)
+#define R_PLL1ODIV                      VIRT_ADDR(0x0, 0x0D)
+#define R_PLL1FDIVL                     VIRT_ADDR(0x0, 0x0E)
+#define R_PLL1FDIVH                     VIRT_ADDR(0x0, 0x0F)
+#define R_PLL2CTL                       VIRT_ADDR(0x0, 0x10)
+#define R_PLL2RDIV                      VIRT_ADDR(0x0, 0x11)
+#define R_PLL2ODIV                      VIRT_ADDR(0x0, 0x12)
+#define R_PLL2FDIVL                     VIRT_ADDR(0x0, 0x13)
+#define R_PLL2FDIVH                     VIRT_ADDR(0x0, 0x14)
+#define R_PLLCTL                        VIRT_ADDR(0x0, 0x15)
+#define R_ISRC                          VIRT_ADDR(0x0, 0x16)
+#define R_SCLKCTL                       VIRT_ADDR(0x0, 0x18)
+#define R_TIMEBASE                      VIRT_ADDR(0x0, 0x19)
+#define R_I2SP1CTL                      VIRT_ADDR(0x0, 0x1A)
+#define R_I2SP2CTL                      VIRT_ADDR(0x0, 0x1B)
+#define R_I2SP3CTL                      VIRT_ADDR(0x0, 0x1C)
+#define R_I2S1MRATE                     VIRT_ADDR(0x0, 0x1D)
+#define R_I2S2MRATE                     VIRT_ADDR(0x0, 0x1E)
+#define R_I2S3MRATE                     VIRT_ADDR(0x0, 0x1F)
+#define R_I2SCMC                        VIRT_ADDR(0x0, 0x20)
+#define R_MCLK2PINC                     VIRT_ADDR(0x0, 0x21)
+#define R_I2SPINC0                      VIRT_ADDR(0x0, 0x22)
+#define R_I2SPINC1                      VIRT_ADDR(0x0, 0x23)
+#define R_I2SPINC2                      VIRT_ADDR(0x0, 0x24)
+#define R_GPIOCTL0                      VIRT_ADDR(0x0, 0x25)
+#define R_GPIOCTL1                      VIRT_ADDR(0x0, 0x26)
+#define R_ASRC                          VIRT_ADDR(0x0, 0x28)
+#define R_TDMCTL0                       VIRT_ADDR(0x0, 0x2D)
+#define R_TDMCTL1                       VIRT_ADDR(0x0, 0x2E)
+#define R_PCMP2CTL0                     VIRT_ADDR(0x0, 0x2F)
+#define R_PCMP2CTL1                     VIRT_ADDR(0x0, 0x30)
+#define R_PCMP3CTL0                     VIRT_ADDR(0x0, 0x31)
+#define R_PCMP3CTL1                     VIRT_ADDR(0x0, 0x32)
+#define R_PWRM0                         VIRT_ADDR(0x0, 0x33)
+#define R_PWRM1                         VIRT_ADDR(0x0, 0x34)
+#define R_PWRM2                         VIRT_ADDR(0x0, 0x35)
+#define R_PWRM3                         VIRT_ADDR(0x0, 0x36)
+#define R_PWRM4                         VIRT_ADDR(0x0, 0x37)
+#define R_I2SIDCTL                      VIRT_ADDR(0x0, 0x38)
+#define R_I2SODCTL                      VIRT_ADDR(0x0, 0x39)
+#define R_AUDIOMUX1                     VIRT_ADDR(0x0, 0x3A)
+#define R_AUDIOMUX2                     VIRT_ADDR(0x0, 0x3B)
+#define R_AUDIOMUX3                     VIRT_ADDR(0x0, 0x3C)
+#define R_HSDCTL1                       VIRT_ADDR(0x1, 0x1)
+#define R_HSDCTL2                       VIRT_ADDR(0x1, 0x2)
+#define R_HSDSTAT                       VIRT_ADDR(0x1, 0x3)
+#define R_HSDDELAY                      VIRT_ADDR(0x1, 0x4)
+#define R_BUTCTL                        VIRT_ADDR(0x1, 0x5)
+#define R_CH0AIC                        VIRT_ADDR(0x1, 0x6)
+#define R_CH1AIC                        VIRT_ADDR(0x1, 0x7)
+#define R_CH2AIC                        VIRT_ADDR(0x1, 0x8)
+#define R_CH3AIC                        VIRT_ADDR(0x1, 0x9)
+#define R_ICTL0                         VIRT_ADDR(0x1, 0x0A)
+#define R_ICTL1                         VIRT_ADDR(0x1, 0x0B)
+#define R_MICBIAS                       VIRT_ADDR(0x1, 0x0C)
+#define R_PGACTL0                       VIRT_ADDR(0x1, 0x0D)
+#define R_PGACTL1                       VIRT_ADDR(0x1, 0x0E)
+#define R_PGACTL2                       VIRT_ADDR(0x1, 0x0F)
+#define R_PGACTL3                       VIRT_ADDR(0x1, 0x10)
+#define R_PGAZ                          VIRT_ADDR(0x1, 0x11)
+#define R_ICH0VOL                       VIRT_ADDR(0x1, 0x12)
+#define R_ICH1VOL                       VIRT_ADDR(0x1, 0x13)
+#define R_ICH2VOL                       VIRT_ADDR(0x1, 0x14)
+#define R_ICH3VOL                       VIRT_ADDR(0x1, 0x15)
+#define R_ASRCILVOL                     VIRT_ADDR(0x1, 0x16)
+#define R_ASRCIRVOL                     VIRT_ADDR(0x1, 0x17)
+#define R_ASRCOLVOL                     VIRT_ADDR(0x1, 0x18)
+#define R_ASRCORVOL                     VIRT_ADDR(0x1, 0x19)
+#define R_IVOLCTLU                      VIRT_ADDR(0x1, 0x1C)
+#define R_ALCCTL0                       VIRT_ADDR(0x1, 0x1D)
+#define R_ALCCTL1                       VIRT_ADDR(0x1, 0x1E)
+#define R_ALCCTL2                       VIRT_ADDR(0x1, 0x1F)
+#define R_ALCCTL3                       VIRT_ADDR(0x1, 0x20)
+#define R_NGATE                         VIRT_ADDR(0x1, 0x21)
+#define R_DMICCTL                       VIRT_ADDR(0x1, 0x22)
+#define R_DACCTL                        VIRT_ADDR(0x2, 0x1)
+#define R_SPKCTL                        VIRT_ADDR(0x2, 0x2)
+#define R_SUBCTL                        VIRT_ADDR(0x2, 0x3)
+#define R_DCCTL                         VIRT_ADDR(0x2, 0x4)
+#define R_OVOLCTLU                      VIRT_ADDR(0x2, 0x6)
+#define R_MUTEC                         VIRT_ADDR(0x2, 0x7)
+#define R_MVOLL                         VIRT_ADDR(0x2, 0x8)
+#define R_MVOLR                         VIRT_ADDR(0x2, 0x9)
+#define R_HPVOLL                        VIRT_ADDR(0x2, 0x0A)
+#define R_HPVOLR                        VIRT_ADDR(0x2, 0x0B)
+#define R_SPKVOLL                       VIRT_ADDR(0x2, 0x0C)
+#define R_SPKVOLR                       VIRT_ADDR(0x2, 0x0D)
+#define R_SUBVOL                        VIRT_ADDR(0x2, 0x10)
+#define R_COP0                          VIRT_ADDR(0x2, 0x11)
+#define R_COP1                          VIRT_ADDR(0x2, 0x12)
+#define R_COPSTAT                       VIRT_ADDR(0x2, 0x13)
+#define R_PWM0                          VIRT_ADDR(0x2, 0x14)
+#define R_PWM1                          VIRT_ADDR(0x2, 0x15)
+#define R_PWM2                          VIRT_ADDR(0x2, 0x16)
+#define R_PWM3                          VIRT_ADDR(0x2, 0x17)
+#define R_HPSW                          VIRT_ADDR(0x2, 0x18)
+#define R_THERMTS                       VIRT_ADDR(0x2, 0x19)
+#define R_THERMSPK1                     VIRT_ADDR(0x2, 0x1A)
+#define R_THERMSTAT                     VIRT_ADDR(0x2, 0x1B)
+#define R_SCSTAT                        VIRT_ADDR(0x2, 0x1C)
+#define R_SDMON                         VIRT_ADDR(0x2, 0x1D)
+#define R_SPKEQFILT                     VIRT_ADDR(0x3, 0x1)
+#define R_SPKCRWDL                      VIRT_ADDR(0x3, 0x2)
+#define R_SPKCRWDM                      VIRT_ADDR(0x3, 0x3)
+#define R_SPKCRWDH                      VIRT_ADDR(0x3, 0x4)
+#define R_SPKCRRDL                      VIRT_ADDR(0x3, 0x5)
+#define R_SPKCRRDM                      VIRT_ADDR(0x3, 0x6)
+#define R_SPKCRRDH                      VIRT_ADDR(0x3, 0x7)
+#define R_SPKCRADD                      VIRT_ADDR(0x3, 0x8)
+#define R_SPKCRS                        VIRT_ADDR(0x3, 0x9)
+#define R_SPKMBCEN                      VIRT_ADDR(0x3, 0x0A)
+#define R_SPKMBCCTL                     VIRT_ADDR(0x3, 0x0B)
+#define R_SPKMBCMUG1                    VIRT_ADDR(0x3, 0x0C)
+#define R_SPKMBCTHR1                    VIRT_ADDR(0x3, 0x0D)
+#define R_SPKMBCRAT1                    VIRT_ADDR(0x3, 0x0E)
+#define R_SPKMBCATK1L                   VIRT_ADDR(0x3, 0x0F)
+#define R_SPKMBCATK1H                   VIRT_ADDR(0x3, 0x10)
+#define R_SPKMBCREL1L                   VIRT_ADDR(0x3, 0x11)
+#define R_SPKMBCREL1H                   VIRT_ADDR(0x3, 0x12)
+#define R_SPKMBCMUG2                    VIRT_ADDR(0x3, 0x13)
+#define R_SPKMBCTHR2                    VIRT_ADDR(0x3, 0x14)
+#define R_SPKMBCRAT2                    VIRT_ADDR(0x3, 0x15)
+#define R_SPKMBCATK2L                   VIRT_ADDR(0x3, 0x16)
+#define R_SPKMBCATK2H                   VIRT_ADDR(0x3, 0x17)
+#define R_SPKMBCREL2L                   VIRT_ADDR(0x3, 0x18)
+#define R_SPKMBCREL2H                   VIRT_ADDR(0x3, 0x19)
+#define R_SPKMBCMUG3                    VIRT_ADDR(0x3, 0x1A)
+#define R_SPKMBCTHR3                    VIRT_ADDR(0x3, 0x1B)
+#define R_SPKMBCRAT3                    VIRT_ADDR(0x3, 0x1C)
+#define R_SPKMBCATK3L                   VIRT_ADDR(0x3, 0x1D)
+#define R_SPKMBCATK3H                   VIRT_ADDR(0x3, 0x1E)
+#define R_SPKMBCREL3L                   VIRT_ADDR(0x3, 0x1F)
+#define R_SPKMBCREL3H                   VIRT_ADDR(0x3, 0x20)
+#define R_SPKCLECTL                     VIRT_ADDR(0x3, 0x21)
+#define R_SPKCLEMUG                     VIRT_ADDR(0x3, 0x22)
+#define R_SPKCOMPTHR                    VIRT_ADDR(0x3, 0x23)
+#define R_SPKCOMPRAT                    VIRT_ADDR(0x3, 0x24)
+#define R_SPKCOMPATKL                   VIRT_ADDR(0x3, 0x25)
+#define R_SPKCOMPATKH                   VIRT_ADDR(0x3, 0x26)
+#define R_SPKCOMPRELL                   VIRT_ADDR(0x3, 0x27)
+#define R_SPKCOMPRELH                   VIRT_ADDR(0x3, 0x28)
+#define R_SPKLIMTHR                     VIRT_ADDR(0x3, 0x29)
+#define R_SPKLIMTGT                     VIRT_ADDR(0x3, 0x2A)
+#define R_SPKLIMATKL                    VIRT_ADDR(0x3, 0x2B)
+#define R_SPKLIMATKH                    VIRT_ADDR(0x3, 0x2C)
+#define R_SPKLIMRELL                    VIRT_ADDR(0x3, 0x2D)
+#define R_SPKLIMRELH                    VIRT_ADDR(0x3, 0x2E)
+#define R_SPKEXPTHR                     VIRT_ADDR(0x3, 0x2F)
+#define R_SPKEXPRAT                     VIRT_ADDR(0x3, 0x30)
+#define R_SPKEXPATKL                    VIRT_ADDR(0x3, 0x31)
+#define R_SPKEXPATKH                    VIRT_ADDR(0x3, 0x32)
+#define R_SPKEXPRELL                    VIRT_ADDR(0x3, 0x33)
+#define R_SPKEXPRELH                    VIRT_ADDR(0x3, 0x34)
+#define R_SPKFXCTL                      VIRT_ADDR(0x3, 0x35)
+#define R_DACEQFILT                     VIRT_ADDR(0x4, 0x1)
+#define R_DACCRWDL                      VIRT_ADDR(0x4, 0x2)
+#define R_DACCRWDM                      VIRT_ADDR(0x4, 0x3)
+#define R_DACCRWDH                      VIRT_ADDR(0x4, 0x4)
+#define R_DACCRRDL                      VIRT_ADDR(0x4, 0x5)
+#define R_DACCRRDM                      VIRT_ADDR(0x4, 0x6)
+#define R_DACCRRDH                      VIRT_ADDR(0x4, 0x7)
+#define R_DACCRADD                      VIRT_ADDR(0x4, 0x8)
+#define R_DACCRS                        VIRT_ADDR(0x4, 0x9)
+#define R_DACMBCEN                      VIRT_ADDR(0x4, 0x0A)
+#define R_DACMBCCTL                     VIRT_ADDR(0x4, 0x0B)
+#define R_DACMBCMUG1                    VIRT_ADDR(0x4, 0x0C)
+#define R_DACMBCTHR1                    VIRT_ADDR(0x4, 0x0D)
+#define R_DACMBCRAT1                    VIRT_ADDR(0x4, 0x0E)
+#define R_DACMBCATK1L                   VIRT_ADDR(0x4, 0x0F)
+#define R_DACMBCATK1H                   VIRT_ADDR(0x4, 0x10)
+#define R_DACMBCREL1L                   VIRT_ADDR(0x4, 0x11)
+#define R_DACMBCREL1H                   VIRT_ADDR(0x4, 0x12)
+#define R_DACMBCMUG2                    VIRT_ADDR(0x4, 0x13)
+#define R_DACMBCTHR2                    VIRT_ADDR(0x4, 0x14)
+#define R_DACMBCRAT2                    VIRT_ADDR(0x4, 0x15)
+#define R_DACMBCATK2L                   VIRT_ADDR(0x4, 0x16)
+#define R_DACMBCATK2H                   VIRT_ADDR(0x4, 0x17)
+#define R_DACMBCREL2L                   VIRT_ADDR(0x4, 0x18)
+#define R_DACMBCREL2H                   VIRT_ADDR(0x4, 0x19)
+#define R_DACMBCMUG3                    VIRT_ADDR(0x4, 0x1A)
+#define R_DACMBCTHR3                    VIRT_ADDR(0x4, 0x1B)
+#define R_DACMBCRAT3                    VIRT_ADDR(0x4, 0x1C)
+#define R_DACMBCATK3L                   VIRT_ADDR(0x4, 0x1D)
+#define R_DACMBCATK3H                   VIRT_ADDR(0x4, 0x1E)
+#define R_DACMBCREL3L                   VIRT_ADDR(0x4, 0x1F)
+#define R_DACMBCREL3H                   VIRT_ADDR(0x4, 0x20)
+#define R_DACCLECTL                     VIRT_ADDR(0x4, 0x21)
+#define R_DACCLEMUG                     VIRT_ADDR(0x4, 0x22)
+#define R_DACCOMPTHR                    VIRT_ADDR(0x4, 0x23)
+#define R_DACCOMPRAT                    VIRT_ADDR(0x4, 0x24)
+#define R_DACCOMPATKL                   VIRT_ADDR(0x4, 0x25)
+#define R_DACCOMPATKH                   VIRT_ADDR(0x4, 0x26)
+#define R_DACCOMPRELL                   VIRT_ADDR(0x4, 0x27)
+#define R_DACCOMPRELH                   VIRT_ADDR(0x4, 0x28)
+#define R_DACLIMTHR                     VIRT_ADDR(0x4, 0x29)
+#define R_DACLIMTGT                     VIRT_ADDR(0x4, 0x2A)
+#define R_DACLIMATKL                    VIRT_ADDR(0x4, 0x2B)
+#define R_DACLIMATKH                    VIRT_ADDR(0x4, 0x2C)
+#define R_DACLIMRELL                    VIRT_ADDR(0x4, 0x2D)
+#define R_DACLIMRELH                    VIRT_ADDR(0x4, 0x2E)
+#define R_DACEXPTHR                     VIRT_ADDR(0x4, 0x2F)
+#define R_DACEXPRAT                     VIRT_ADDR(0x4, 0x30)
+#define R_DACEXPATKL                    VIRT_ADDR(0x4, 0x31)
+#define R_DACEXPATKH                    VIRT_ADDR(0x4, 0x32)
+#define R_DACEXPRELL                    VIRT_ADDR(0x4, 0x33)
+#define R_DACEXPRELH                    VIRT_ADDR(0x4, 0x34)
+#define R_DACFXCTL                      VIRT_ADDR(0x4, 0x35)
+#define R_SUBEQFILT                     VIRT_ADDR(0x5, 0x1)
+#define R_SUBCRWDL                      VIRT_ADDR(0x5, 0x2)
+#define R_SUBCRWDM                      VIRT_ADDR(0x5, 0x3)
+#define R_SUBCRWDH                      VIRT_ADDR(0x5, 0x4)
+#define R_SUBCRRDL                      VIRT_ADDR(0x5, 0x5)
+#define R_SUBCRRDM                      VIRT_ADDR(0x5, 0x6)
+#define R_SUBCRRDH                      VIRT_ADDR(0x5, 0x7)
+#define R_SUBCRADD                      VIRT_ADDR(0x5, 0x8)
+#define R_SUBCRS                        VIRT_ADDR(0x5, 0x9)
+#define R_SUBMBCEN                      VIRT_ADDR(0x5, 0x0A)
+#define R_SUBMBCCTL                     VIRT_ADDR(0x5, 0x0B)
+#define R_SUBMBCMUG1                    VIRT_ADDR(0x5, 0x0C)
+#define R_SUBMBCTHR1                    VIRT_ADDR(0x5, 0x0D)
+#define R_SUBMBCRAT1                    VIRT_ADDR(0x5, 0x0E)
+#define R_SUBMBCATK1L                   VIRT_ADDR(0x5, 0x0F)
+#define R_SUBMBCATK1H                   VIRT_ADDR(0x5, 0x10)
+#define R_SUBMBCREL1L                   VIRT_ADDR(0x5, 0x11)
+#define R_SUBMBCREL1H                   VIRT_ADDR(0x5, 0x12)
+#define R_SUBMBCMUG2                    VIRT_ADDR(0x5, 0x13)
+#define R_SUBMBCTHR2                    VIRT_ADDR(0x5, 0x14)
+#define R_SUBMBCRAT2                    VIRT_ADDR(0x5, 0x15)
+#define R_SUBMBCATK2L                   VIRT_ADDR(0x5, 0x16)
+#define R_SUBMBCATK2H                   VIRT_ADDR(0x5, 0x17)
+#define R_SUBMBCREL2L                   VIRT_ADDR(0x5, 0x18)
+#define R_SUBMBCREL2H                   VIRT_ADDR(0x5, 0x19)
+#define R_SUBMBCMUG3                    VIRT_ADDR(0x5, 0x1A)
+#define R_SUBMBCTHR3                    VIRT_ADDR(0x5, 0x1B)
+#define R_SUBMBCRAT3                    VIRT_ADDR(0x5, 0x1C)
+#define R_SUBMBCATK3L                   VIRT_ADDR(0x5, 0x1D)
+#define R_SUBMBCATK3H                   VIRT_ADDR(0x5, 0x1E)
+#define R_SUBMBCREL3L                   VIRT_ADDR(0x5, 0x1F)
+#define R_SUBMBCREL3H                   VIRT_ADDR(0x5, 0x20)
+#define R_SUBCLECTL                     VIRT_ADDR(0x5, 0x21)
+#define R_SUBCLEMUG                     VIRT_ADDR(0x5, 0x22)
+#define R_SUBCOMPTHR                    VIRT_ADDR(0x5, 0x23)
+#define R_SUBCOMPRAT                    VIRT_ADDR(0x5, 0x24)
+#define R_SUBCOMPATKL                   VIRT_ADDR(0x5, 0x25)
+#define R_SUBCOMPATKH                   VIRT_ADDR(0x5, 0x26)
+#define R_SUBCOMPRELL                   VIRT_ADDR(0x5, 0x27)
+#define R_SUBCOMPRELH                   VIRT_ADDR(0x5, 0x28)
+#define R_SUBLIMTHR                     VIRT_ADDR(0x5, 0x29)
+#define R_SUBLIMTGT                     VIRT_ADDR(0x5, 0x2A)
+#define R_SUBLIMATKL                    VIRT_ADDR(0x5, 0x2B)
+#define R_SUBLIMATKH                    VIRT_ADDR(0x5, 0x2C)
+#define R_SUBLIMRELL                    VIRT_ADDR(0x5, 0x2D)
+#define R_SUBLIMRELH                    VIRT_ADDR(0x5, 0x2E)
+#define R_SUBEXPTHR                     VIRT_ADDR(0x5, 0x2F)
+#define R_SUBEXPRAT                     VIRT_ADDR(0x5, 0x30)
+#define R_SUBEXPATKL                    VIRT_ADDR(0x5, 0x31)
+#define R_SUBEXPATKH                    VIRT_ADDR(0x5, 0x32)
+#define R_SUBEXPRELL                    VIRT_ADDR(0x5, 0x33)
+#define R_SUBEXPRELH                    VIRT_ADDR(0x5, 0x34)
+#define R_SUBFXCTL                      VIRT_ADDR(0x5, 0x35)
+
+// *** PLLCTL ***
+#define FB_PLLCTL_VCCI_PLL                                  6
+#define FM_PLLCTL_VCCI_PLL                                  0xC0
+
+#define FB_PLLCTL_RZ_PLL                                    3
+#define FM_PLLCTL_RZ_PLL                                    0x38
+
+#define FB_PLLCTL_CP_PLL                                    0
+#define FM_PLLCTL_CP_PLL                                    0x7
+
+// *** PLLRDIV ***
+#define FB_PLLRDIV_REFDIV_PLL                               0
+#define FM_PLLRDIV_REFDIV_PLL                               0xFF
+
+// *** PLLODIV ***
+#define FB_PLLODIV_OUTDIV_PLL                               0
+#define FM_PLLODIV_OUTDIV_PLL                               0xFF
+
+// *** PLLFDIVL ***
+#define FB_PLLFDIVL_FBDIVL_PLL                              0
+#define FM_PLLFDIVL_FBDIVL_PLL                              0xFF
+
+// *** PLLFDIVH ***
+#define FB_PLLFDIVH_FBDIVH_PLL                              0
+#define FM_PLLFDIVH_FBDIVH_PLL                              0xF
+
+// *** I2SPCTL ***
+#define FB_I2SPCTL_BCLKSTAT                                 7
+#define FM_I2SPCTL_BCLKSTAT                                 0x80
+#define FV_BCLKSTAT_LOST                                    0x80
+#define FV_BCLKSTAT_NOT_LOST                                0x0
+
+#define FB_I2SPCTL_BCLKP                                    6
+#define FM_I2SPCTL_BCLKP                                    0x40
+#define FV_BCLKP_NOT_INVERTED                               0x0
+#define FV_BCLKP_INVERTED                                   0x40
+
+#define FB_I2SPCTL_PORTMS                                   5
+#define FM_I2SPCTL_PORTMS                                   0x20
+#define FV_PORTMS_SLAVE                                     0x0
+#define FV_PORTMS_MASTER                                    0x20
+
+#define FB_I2SPCTL_LRCLKP                                   4
+#define FM_I2SPCTL_LRCLKP                                   0x10
+#define FV_LRCLKP_NOT_INVERTED                              0x0
+#define FV_LRCLKP_INVERTED                                  0x10
+
+#define FB_I2SPCTL_WL                                       2
+#define FM_I2SPCTL_WL                                       0xC
+#define FV_WL_16                                            0x0
+#define FV_WL_20                                            0x4
+#define FV_WL_24                                            0x8
+#define FV_WL_32                                            0xC
+
+#define FB_I2SPCTL_FORMAT                                   0
+#define FM_I2SPCTL_FORMAT                                   0x3
+#define FV_FORMAT_RIGHT                                     0x0
+#define FV_FORMAT_LEFT                                      0x1
+#define FV_FORMAT_I2S                                       0x2
+#define FV_FORMAT_TDM                                       0x3
+
+// *** I2SMRATE ***
+#define FB_I2SMRATE_I2SMCLKHALF                             7
+#define FM_I2SMRATE_I2SMCLKHALF                             0x80
+#define FV_I2SMCLKHALF_I2S1MCLKDIV_DIV_2                    0x0
+#define FV_I2SMCLKHALF_I2S1MCLKDIV_ONLY                     0x80
+
+#define FB_I2SMRATE_I2SMCLKDIV                              5
+#define FM_I2SMRATE_I2SMCLKDIV                              0x60
+#define FV_I2SMCLKDIV_125                                   0x0
+#define FV_I2SMCLKDIV_128                                   0x20
+#define FV_I2SMCLKDIV_136                                   0x40
+#define FV_I2SMCLKDIV_192                                   0x60
+
+#define FB_I2SMRATE_I2SMBR                                  3
+#define FM_I2SMRATE_I2SMBR                                  0x18
+#define FV_I2SMBR_32                                        0x0
+#define FV_I2SMBR_44PT1                                     0x8
+#define FV_I2SMBR_48                                        0x10
+#define FV_I2SMBR_MCLK_MODE                                 0x18
+
+#define FB_I2SMRATE_I2SMBM                                  0
+#define FM_I2SMRATE_I2SMBM                                  0x3
+#define FV_I2SMBM_0PT25                                     0x0
+#define FV_I2SMBM_0PT5                                      0x1
+#define FV_I2SMBM_1                                         0x2
+#define FV_I2SMBM_2                                         0x3
+
+// *** PCMPCTL0 ***
+#define FB_PCMPCTL0_PCMFLENP                                2
+#define FM_PCMPCTL0_PCMFLENP                                0x4
+#define FV_PCMFLENP_128                                     0x0
+#define FV_PCMFLENP_256                                     0x4
+
+#define FB_PCMPCTL0_SLSYNCP                                 1
+#define FM_PCMPCTL0_SLSYNCP                                 0x2
+#define FV_SLSYNCP_SHORT                                    0x0
+#define FV_SLSYNCP_LONG                                     0x2
+
+#define FB_PCMPCTL0_BDELAYP                                 0
+#define FM_PCMPCTL0_BDELAYP                                 0x1
+#define FV_BDELAYP_NO_DELAY                                 0x0
+#define FV_BDELAYP_1BCLK_DELAY                              0x1
+
+// *** PCMPCTL1 ***
+#define FB_PCMPCTL1_PCMMOMP                                 6
+#define FM_PCMPCTL1_PCMMOMP                                 0x40
+
+#define FB_PCMPCTL1_PCMSOP                                  5
+#define FM_PCMPCTL1_PCMSOP                                  0x20
+#define FV_PCMSOP_1                                         0x0
+#define FV_PCMSOP_2                                         0x20
+
+#define FB_PCMPCTL1_PCMDSSP                                 3
+#define FM_PCMPCTL1_PCMDSSP                                 0x18
+#define FV_PCMDSSP_16                                       0x0
+#define FV_PCMDSSP_24                                       0x8
+#define FV_PCMDSSP_32                                       0x10
+
+#define FB_PCMPCTL1_PCMMIMP                                 1
+#define FM_PCMPCTL1_PCMMIMP                                 0x2
+
+#define FB_PCMPCTL1_PCMSIP                                  0
+#define FM_PCMPCTL1_PCMSIP                                  0x1
+#define FV_PCMSIP_1                                         0x0
+#define FV_PCMSIP_2                                         0x1
+
+// *** CHAIC ***
+#define FB_CHAIC_MICBST                                     4
+#define FM_CHAIC_MICBST                                     0x30
+
+// *** PGACTL ***
+#define FB_PGACTL_PGAMUTE                                   7
+#define FM_PGACTL_PGAMUTE                                   0x80
+
+#define FB_PGACTL_PGAVOL                                    0
+#define FM_PGACTL_PGAVOL                                    0x3F
+
+// *** ICHVOL ***
+#define FB_ICHVOL_ICHVOL                                    0
+#define FM_ICHVOL_ICHVOL                                    0xFF
+
+// *** SPKMBCMUG ***
+#define FB_SPKMBCMUG_PHASE                                  5
+#define FM_SPKMBCMUG_PHASE                                  0x20
+
+#define FB_SPKMBCMUG_MUGAIN                                 0
+#define FM_SPKMBCMUG_MUGAIN                                 0x1F
+
+// *** SPKMBCTHR ***
+#define FB_SPKMBCTHR_THRESH                                 0
+#define FM_SPKMBCTHR_THRESH                                 0xFF
+
+// *** SPKMBCRAT ***
+#define FB_SPKMBCRAT_RATIO                                  0
+#define FM_SPKMBCRAT_RATIO                                  0x1F
+
+// *** SPKMBCATKL ***
+#define FB_SPKMBCATKL_TCATKL                                0
+#define FM_SPKMBCATKL_TCATKL                                0xFF
+
+// *** SPKMBCATKH ***
+#define FB_SPKMBCATKH_TCATKH                                0
+#define FM_SPKMBCATKH_TCATKH                                0xFF
+
+// *** SPKMBCRELL ***
+#define FB_SPKMBCRELL_TCRELL                                0
+#define FM_SPKMBCRELL_TCRELL                                0xFF
+
+// *** SPKMBCRELH ***
+#define FB_SPKMBCRELH_TCRELH                                0
+#define FM_SPKMBCRELH_TCRELH                                0xFF
+
+// *** DACMBCMUG ***
+#define FB_DACMBCMUG_PHASE                                  5
+#define FM_DACMBCMUG_PHASE                                  0x20
+
+#define FB_DACMBCMUG_MUGAIN                                 0
+#define FM_DACMBCMUG_MUGAIN                                 0x1F
+
+// *** DACMBCTHR ***
+#define FB_DACMBCTHR_THRESH                                 0
+#define FM_DACMBCTHR_THRESH                                 0xFF
+
+// *** DACMBCRAT ***
+#define FB_DACMBCRAT_RATIO                                  0
+#define FM_DACMBCRAT_RATIO                                  0x1F
+
+// *** DACMBCATKL ***
+#define FB_DACMBCATKL_TCATKL                                0
+#define FM_DACMBCATKL_TCATKL                                0xFF
+
+// *** DACMBCATKH ***
+#define FB_DACMBCATKH_TCATKH                                0
+#define FM_DACMBCATKH_TCATKH                                0xFF
+
+// *** DACMBCRELL ***
+#define FB_DACMBCRELL_TCRELL                                0
+#define FM_DACMBCRELL_TCRELL                                0xFF
+
+// *** DACMBCRELH ***
+#define FB_DACMBCRELH_TCRELH                                0
+#define FM_DACMBCRELH_TCRELH                                0xFF
+
+// *** SUBMBCMUG ***
+#define FB_SUBMBCMUG_PHASE                                  5
+#define FM_SUBMBCMUG_PHASE                                  0x20
+
+#define FB_SUBMBCMUG_MUGAIN                                 0
+#define FM_SUBMBCMUG_MUGAIN                                 0x1F
+
+// *** SUBMBCTHR ***
+#define FB_SUBMBCTHR_THRESH                                 0
+#define FM_SUBMBCTHR_THRESH                                 0xFF
+
+// *** SUBMBCRAT ***
+#define FB_SUBMBCRAT_RATIO                                  0
+#define FM_SUBMBCRAT_RATIO                                  0x1F
+
+// *** SUBMBCATKL ***
+#define FB_SUBMBCATKL_TCATKL                                0
+#define FM_SUBMBCATKL_TCATKL                                0xFF
+
+// *** SUBMBCATKH ***
+#define FB_SUBMBCATKH_TCATKH                                0
+#define FM_SUBMBCATKH_TCATKH                                0xFF
+
+// *** SUBMBCRELL ***
+#define FB_SUBMBCRELL_TCRELL                                0
+#define FM_SUBMBCRELL_TCRELL                                0xFF
+
+// *** SUBMBCRELH ***
+#define FB_SUBMBCRELH_TCRELH                                0
+#define FM_SUBMBCRELH_TCRELH                                0xFF
+
+// *** PAGESEL ***
+#define FB_PAGESEL_PAGESEL                                  0
+#define FM_PAGESEL_PAGESEL                                  0xFF
+
+// *** RESET ***
+#define FB_RESET_RESET                                      0
+#define FM_RESET_RESET                                      0xFF
+#define FV_RESET_PWR_ON_DEFAULTS                            0x85
+
+// *** IRQEN ***
+#define FB_IRQEN_THRMINTEN                                  6
+#define FM_IRQEN_THRMINTEN                                  0x40
+#define FV_THRMINTEN_ENABLED                                0x40
+#define FV_THRMINTEN_DISABLED                               0x0
+
+#define FB_IRQEN_HBPINTEN                                   5
+#define FM_IRQEN_HBPINTEN                                   0x20
+#define FV_HBPINTEN_ENABLED                                 0x20
+#define FV_HBPINTEN_DISABLED                                0x0
+
+#define FB_IRQEN_HSDINTEN                                   4
+#define FM_IRQEN_HSDINTEN                                   0x10
+#define FV_HSDINTEN_ENABLED                                 0x10
+#define FV_HSDINTEN_DISABLED                                0x0
+
+#define FB_IRQEN_HPDINTEN                                   3
+#define FM_IRQEN_HPDINTEN                                   0x8
+#define FV_HPDINTEN_ENABLED                                 0x8
+#define FV_HPDINTEN_DISABLED                                0x0
+
+#define FB_IRQEN_GPIO3INTEN                                 1
+#define FM_IRQEN_GPIO3INTEN                                 0x2
+#define FV_GPIO3INTEN_ENABLED                               0x2
+#define FV_GPIO3INTEN_DISABLED                              0x0
+
+#define FB_IRQEN_GPIO2INTEN                                 0
+#define FM_IRQEN_GPIO2INTEN                                 0x1
+#define FV_GPIO2INTEN_ENABLED                               0x1
+#define FV_GPIO2INTEN_DISABLED                              0x0
+
+#define IRQEN_GPIOINTEN_ENABLED                             0x1
+#define IRQEN_GPIOINTEN_DISABLED                            0x0
+
+// *** IRQMASK ***
+#define FB_IRQMASK_THRMIM                                   6
+#define FM_IRQMASK_THRMIM                                   0x40
+#define FV_THRMIM_MASKED                                    0x0
+#define FV_THRMIM_NOT_MASKED                                0x40
+
+#define FB_IRQMASK_HBPIM                                    5
+#define FM_IRQMASK_HBPIM                                    0x20
+#define FV_HBPIM_MASKED                                     0x0
+#define FV_HBPIM_NOT_MASKED                                 0x20
+
+#define FB_IRQMASK_HSDIM                                    4
+#define FM_IRQMASK_HSDIM                                    0x10
+#define FV_HSDIM_MASKED                                     0x0
+#define FV_HSDIM_NOT_MASKED                                 0x10
+
+#define FB_IRQMASK_HPDIM                                    3
+#define FM_IRQMASK_HPDIM                                    0x8
+#define FV_HPDIM_MASKED                                     0x0
+#define FV_HPDIM_NOT_MASKED                                 0x8
+
+#define FB_IRQMASK_GPIO3M                                   1
+#define FM_IRQMASK_GPIO3M                                   0x2
+#define FV_GPIO3M_MASKED                                    0x0
+#define FV_GPIO3M_NOT_MASKED                                0x2
+
+#define FB_IRQMASK_GPIO2M                                   0
+#define FM_IRQMASK_GPIO2M                                   0x1
+#define FV_GPIO2M_MASKED                                    0x0
+#define FV_GPIO2M_NOT_MASKED                                0x1
+
+#define IRQMASK_GPIOM_MASKED                                0x0
+#define IRQMASK_GPIOM_NOT_MASKED                            0x1
+
+// *** IRQSTAT ***
+#define FB_IRQSTAT_THRMINT                                  6
+#define FM_IRQSTAT_THRMINT                                  0x40
+#define FV_THRMINT_INTERRUPTED                              0x40
+#define FV_THRMINT_NOT_INTERRUPTED                          0x0
+
+#define FB_IRQSTAT_HBPINT                                   5
+#define FM_IRQSTAT_HBPINT                                   0x20
+#define FV_HBPINT_INTERRUPTED                               0x20
+#define FV_HBPINT_NOT_INTERRUPTED                           0x0
+
+#define FB_IRQSTAT_HSDINT                                   4
+#define FM_IRQSTAT_HSDINT                                   0x10
+#define FV_HSDINT_INTERRUPTED                               0x10
+#define FV_HSDINT_NOT_INTERRUPTED                           0x0
+
+#define FB_IRQSTAT_HPDINT                                   3
+#define FM_IRQSTAT_HPDINT                                   0x8
+#define FV_HPDINT_INTERRUPTED                               0x8
+#define FV_HPDINT_NOT_INTERRUPTED                           0x0
+
+#define FB_IRQSTAT_GPIO3INT                                 1
+#define FM_IRQSTAT_GPIO3INT                                 0x2
+#define FV_GPIO3INT_INTERRUPTED                             0x2
+#define FV_GPIO3INT_NOT_INTERRUPTED                         0x0
+
+#define FB_IRQSTAT_GPIO2INT                                 0
+#define FM_IRQSTAT_GPIO2INT                                 0x1
+#define FV_GPIO2INT_INTERRUPTED                             0x1
+#define FV_GPIO2INT_NOT_INTERRUPTED                         0x0
+
+#define IRQSTAT_GPIOINT_INTERRUPTED                         0x1
+#define IRQSTAT_GPIOINT_NOT_INTERRUPTED                     0x0
+
+// *** DEVADD0 ***
+#define FB_DEVADD0_DEVADD0                                  1
+#define FM_DEVADD0_DEVADD0                                  0xFE
+
+#define FB_DEVADD0_I2C_ADDRLK                               0
+#define FM_DEVADD0_I2C_ADDRLK                               0x1
+#define FV_I2C_ADDRLK_LOCK                                  0x1
+
+// *** DEVID ***
+#define FB_DEVID_DEV_ID                                     0
+#define FM_DEVID_DEV_ID                                     0xFF
+
+// *** DEVREV ***
+#define FB_DEVREV_MAJ_REV                                   4
+#define FM_DEVREV_MAJ_REV                                   0xF0
+
+#define FB_DEVREV_MIN_REV                                   0
+#define FM_DEVREV_MIN_REV                                   0xF
+
+// *** PLLSTAT ***
+#define FB_PLLSTAT_PLL2LK                                   1
+#define FM_PLLSTAT_PLL2LK                                   0x2
+#define FV_PLL2LK_LOCKED                                    0x2
+#define FV_PLL2LK_UNLOCKED                                  0x0
+
+#define FB_PLLSTAT_PLL1LK                                   0
+#define FM_PLLSTAT_PLL1LK                                   0x1
+#define FV_PLL1LK_LOCKED                                    0x1
+#define FV_PLL1LK_UNLOCKED                                  0x0
+
+#define PLLSTAT_PLLLK_LOCKED                                0x1
+#define PLLSTAT_PLLLK_UNLOCKED                              0x0
+
+// *** PLLCTL ***
+#define FB_PLLCTL_PU_PLL2                                   7
+#define FM_PLLCTL_PU_PLL2                                   0x80
+#define FV_PU_PLL2_PWR_UP                                   0x80
+#define FV_PU_PLL2_PWR_DWN                                  0x0
+
+#define FB_PLLCTL_PU_PLL1                                   6
+#define FM_PLLCTL_PU_PLL1                                   0x40
+#define FV_PU_PLL1_PWR_UP                                   0x40
+#define FV_PU_PLL1_PWR_DWN                                  0x0
+
+#define FB_PLLCTL_PLL2CLKEN                                 5
+#define FM_PLLCTL_PLL2CLKEN                                 0x20
+#define FV_PLL2CLKEN_ENABLE                                 0x20
+#define FV_PLL2CLKEN_DISABLE                                0x0
+
+#define FB_PLLCTL_PLL1CLKEN                                 4
+#define FM_PLLCTL_PLL1CLKEN                                 0x10
+#define FV_PLL1CLKEN_ENABLE                                 0x10
+#define FV_PLL1CLKEN_DISABLE                                0x0
+
+#define FB_PLLCTL_BCLKSEL                                   2
+#define FM_PLLCTL_BCLKSEL                                   0xC
+#define FV_BCLKSEL_BCLK1                                    0x0
+#define FV_BCLKSEL_BCLK2                                    0x4
+#define FV_BCLKSEL_BCLK3                                    0x8
+
+#define FB_PLLCTL_PLLISEL                                   0
+#define FM_PLLCTL_PLLISEL                                   0x3
+#define FV_PLLISEL_XTAL                                     0x0
+#define FV_PLLISEL_MCLK1                                    0x1
+#define FV_PLLISEL_MCLK2                                    0x2
+#define FV_PLLISEL_BCLK                                     0x3
+
+#define PLLCTL_PU_PLL_PWR_UP                                0x1
+#define PLLCTL_PU_PLL_PWR_DWN                               0x0
+#define PLLCTL_PLLCLKEN_ENABLE                              0x1
+#define PLLCTL_PLLCLKEN_DISABLE                             0x0
+
+// *** ISRC ***
+#define FB_ISRC_IBR                                         2
+#define FM_ISRC_IBR                                         0x4
+#define FV_IBR_44PT1                                        0x0
+#define FV_IBR_48                                           0x4
+
+#define FB_ISRC_IBM                                         0
+#define FM_ISRC_IBM                                         0x3
+#define FV_IBM_0PT25                                        0x0
+#define FV_IBM_0PT5                                         0x1
+#define FV_IBM_1                                            0x2
+#define FV_IBM_2                                            0x3
+
+// *** SCLKCTL ***
+#define FB_SCLKCTL_ASDM                                     6
+#define FM_SCLKCTL_ASDM                                     0xC0
+#define FV_ASDM_HALF                                        0x40
+#define FV_ASDM_FULL                                        0x80
+#define FV_ASDM_AUTO                                        0xC0
+
+#define FB_SCLKCTL_DSDM                                     4
+#define FM_SCLKCTL_DSDM                                     0x30
+#define FV_DSDM_HALF                                        0x10
+#define FV_DSDM_FULL                                        0x20
+#define FV_DSDM_AUTO                                        0x30
+
+// *** TIMEBASE ***
+#define FB_TIMEBASE_TIMEBASE                                0
+#define FM_TIMEBASE_TIMEBASE                                0xFF
+
+// *** I2SCMC ***
+#define FB_I2SCMC_BCMP3                                     4
+#define FM_I2SCMC_BCMP3                                     0x30
+#define FV_BCMP3_AUTO                                       0x0
+#define FV_BCMP3_32X                                        0x10
+#define FV_BCMP3_40X                                        0x20
+#define FV_BCMP3_64X                                        0x30
+
+#define FB_I2SCMC_BCMP2                                     2
+#define FM_I2SCMC_BCMP2                                     0xC
+#define FV_BCMP2_AUTO                                       0x0
+#define FV_BCMP2_32X                                        0x4
+#define FV_BCMP2_40X                                        0x8
+#define FV_BCMP2_64X                                        0xC
+
+#define FB_I2SCMC_BCMP1                                     0
+#define FM_I2SCMC_BCMP1                                     0x3
+#define FV_BCMP1_AUTO                                       0x0
+#define FV_BCMP1_32X                                        0x1
+#define FV_BCMP1_40X                                        0x2
+#define FV_BCMP1_64X                                        0x3
+
+#define I2SCMC_BCMP_AUTO                                    0x0
+#define I2SCMC_BCMP_32X                                     0x1
+#define I2SCMC_BCMP_40X                                     0x2
+#define I2SCMC_BCMP_64X                                     0x3
+
+// *** MCLK2PINC ***
+#define FB_MCLK2PINC_SLEWOUT                                4
+#define FM_MCLK2PINC_SLEWOUT                                0xF0
+
+#define FB_MCLK2PINC_MCLK2IO                                2
+#define FM_MCLK2PINC_MCLK2IO                                0x4
+#define FV_MCLK2IO_INPUT                                    0x0
+#define FV_MCLK2IO_OUTPUT                                   0x4
+
+#define FB_MCLK2PINC_MCLK2OS                                0
+#define FM_MCLK2PINC_MCLK2OS                                0x3
+#define FV_MCLK2OS_24PT576                                  0x0
+#define FV_MCLK2OS_22PT5792                                 0x1
+#define FV_MCLK2OS_PLL2                                     0x2
+
+// *** I2SPINC0 ***
+#define FB_I2SPINC0_SDO3TRI                                 7
+#define FM_I2SPINC0_SDO3TRI                                 0x80
+
+#define FB_I2SPINC0_SDO2TRI                                 6
+#define FM_I2SPINC0_SDO2TRI                                 0x40
+
+#define FB_I2SPINC0_SDO1TRI                                 5
+#define FM_I2SPINC0_SDO1TRI                                 0x20
+
+#define FB_I2SPINC0_PCM3TRI                                 2
+#define FM_I2SPINC0_PCM3TRI                                 0x4
+
+#define FB_I2SPINC0_PCM2TRI                                 1
+#define FM_I2SPINC0_PCM2TRI                                 0x2
+
+#define FB_I2SPINC0_PCM1TRI                                 0
+#define FM_I2SPINC0_PCM1TRI                                 0x1
+
+// *** I2SPINC1 ***
+#define FB_I2SPINC1_SDO3PDD                                 2
+#define FM_I2SPINC1_SDO3PDD                                 0x4
+
+#define FB_I2SPINC1_SDO2PDD                                 1
+#define FM_I2SPINC1_SDO2PDD                                 0x2
+
+#define FB_I2SPINC1_SDO1PDD                                 0
+#define FM_I2SPINC1_SDO1PDD                                 0x1
+
+// *** I2SPINC2 ***
+#define FB_I2SPINC2_LR3PDD                                  5
+#define FM_I2SPINC2_LR3PDD                                  0x20
+
+#define FB_I2SPINC2_BC3PDD                                  4
+#define FM_I2SPINC2_BC3PDD                                  0x10
+
+#define FB_I2SPINC2_LR2PDD                                  3
+#define FM_I2SPINC2_LR2PDD                                  0x8
+
+#define FB_I2SPINC2_BC2PDD                                  2
+#define FM_I2SPINC2_BC2PDD                                  0x4
+
+#define FB_I2SPINC2_LR1PDD                                  1
+#define FM_I2SPINC2_LR1PDD                                  0x2
+
+#define FB_I2SPINC2_BC1PDD                                  0
+#define FM_I2SPINC2_BC1PDD                                  0x1
+
+// *** GPIOCTL0 ***
+#define FB_GPIOCTL0_GPIO3INTP                               7
+#define FM_GPIOCTL0_GPIO3INTP                               0x80
+
+#define FB_GPIOCTL0_GPIO2INTP                               6
+#define FM_GPIOCTL0_GPIO2INTP                               0x40
+
+#define FB_GPIOCTL0_GPIO3CFG                                5
+#define FM_GPIOCTL0_GPIO3CFG                                0x20
+
+#define FB_GPIOCTL0_GPIO2CFG                                4
+#define FM_GPIOCTL0_GPIO2CFG                                0x10
+
+#define FB_GPIOCTL0_GPIO3IO                                 3
+#define FM_GPIOCTL0_GPIO3IO                                 0x8
+
+#define FB_GPIOCTL0_GPIO2IO                                 2
+#define FM_GPIOCTL0_GPIO2IO                                 0x4
+
+#define FB_GPIOCTL0_GPIO1IO                                 1
+#define FM_GPIOCTL0_GPIO1IO                                 0x2
+
+#define FB_GPIOCTL0_GPIO0IO                                 0
+#define FM_GPIOCTL0_GPIO0IO                                 0x1
+
+// *** GPIOCTL1 ***
+#define FB_GPIOCTL1_GPIO3                                   7
+#define FM_GPIOCTL1_GPIO3                                   0x80
+
+#define FB_GPIOCTL1_GPIO2                                   6
+#define FM_GPIOCTL1_GPIO2                                   0x40
+
+#define FB_GPIOCTL1_GPIO1                                   5
+#define FM_GPIOCTL1_GPIO1                                   0x20
+
+#define FB_GPIOCTL1_GPIO0                                   4
+#define FM_GPIOCTL1_GPIO0                                   0x10
+
+#define FB_GPIOCTL1_GPIO3RD                                 3
+#define FM_GPIOCTL1_GPIO3RD                                 0x8
+
+#define FB_GPIOCTL1_GPIO2RD                                 2
+#define FM_GPIOCTL1_GPIO2RD                                 0x4
+
+#define FB_GPIOCTL1_GPIO1RD                                 1
+#define FM_GPIOCTL1_GPIO1RD                                 0x2
+
+#define FB_GPIOCTL1_GPIO0RD                                 0
+#define FM_GPIOCTL1_GPIO0RD                                 0x1
+
+// *** ASRC ***
+#define FB_ASRC_ASRCOBW                                     7
+#define FM_ASRC_ASRCOBW                                     0x80
+
+#define FB_ASRC_ASRCIBW                                     6
+#define FM_ASRC_ASRCIBW                                     0x40
+
+#define FB_ASRC_ASRCOB                                      5
+#define FM_ASRC_ASRCOB                                      0x20
+#define FV_ASRCOB_ACTIVE                                    0x0
+#define FV_ASRCOB_BYPASSED                                  0x20
+
+#define FB_ASRC_ASRCIB                                      4
+#define FM_ASRC_ASRCIB                                      0x10
+#define FV_ASRCIB_ACTIVE                                    0x0
+#define FV_ASRCIB_BYPASSED                                  0x10
+
+#define FB_ASRC_ASRCOL                                      3
+#define FM_ASRC_ASRCOL                                      0x8
+
+#define FB_ASRC_ASRCIL                                      2
+#define FM_ASRC_ASRCIL                                      0x4
+
+// *** TDMCTL0 ***
+#define FB_TDMCTL0_TDMMD                                    2
+#define FM_TDMCTL0_TDMMD                                    0x4
+#define FV_TDMMD_200                                        0x0
+#define FV_TDMMD_256                                        0x4
+
+#define FB_TDMCTL0_SLSYNC                                   1
+#define FM_TDMCTL0_SLSYNC                                   0x2
+#define FV_SLSYNC_SHORT                                     0x0
+#define FV_SLSYNC_LONG                                      0x2
+
+#define FB_TDMCTL0_BDELAY                                   0
+#define FM_TDMCTL0_BDELAY                                   0x1
+#define FV_BDELAY_NO_DELAY                                  0x0
+#define FV_BDELAY_1BCLK_DELAY                               0x1
+
+// *** TDMCTL1 ***
+#define FB_TDMCTL1_TDMSO                                    5
+#define FM_TDMCTL1_TDMSO                                    0x60
+#define FV_TDMSO_2                                          0x0
+#define FV_TDMSO_4                                          0x20
+#define FV_TDMSO_6                                          0x40
+
+#define FB_TDMCTL1_TDMDSS                                   3
+#define FM_TDMCTL1_TDMDSS                                   0x18
+#define FV_TDMDSS_16                                        0x0
+#define FV_TDMDSS_24                                        0x10
+#define FV_TDMDSS_32                                        0x18
+
+#define FB_TDMCTL1_TDMSI                                    0
+#define FM_TDMCTL1_TDMSI                                    0x3
+#define FV_TDMSI_2                                          0x0
+#define FV_TDMSI_4                                          0x1
+#define FV_TDMSI_6                                          0x2
+
+// *** PWRM0 ***
+#define FB_PWRM0_INPROC3PU                                  6
+#define FM_PWRM0_INPROC3PU                                  0x40
+
+#define FB_PWRM0_INPROC2PU                                  5
+#define FM_PWRM0_INPROC2PU                                  0x20
+
+#define FB_PWRM0_INPROC1PU                                  4
+#define FM_PWRM0_INPROC1PU                                  0x10
+
+#define FB_PWRM0_INPROC0PU                                  3
+#define FM_PWRM0_INPROC0PU                                  0x8
+
+#define FB_PWRM0_MICB2PU                                    2
+#define FM_PWRM0_MICB2PU                                    0x4
+
+#define FB_PWRM0_MICB1PU                                    1
+#define FM_PWRM0_MICB1PU                                    0x2
+
+#define FB_PWRM0_MCLKPEN                                    0
+#define FM_PWRM0_MCLKPEN                                    0x1
+
+// *** PWRM1 ***
+#define FB_PWRM1_SUBPU                                      7
+#define FM_PWRM1_SUBPU                                      0x80
+
+#define FB_PWRM1_HPLPU                                      6
+#define FM_PWRM1_HPLPU                                      0x40
+
+#define FB_PWRM1_HPRPU                                      5
+#define FM_PWRM1_HPRPU                                      0x20
+
+#define FB_PWRM1_SPKLPU                                     4
+#define FM_PWRM1_SPKLPU                                     0x10
+
+#define FB_PWRM1_SPKRPU                                     3
+#define FM_PWRM1_SPKRPU                                     0x8
+
+#define FB_PWRM1_D2S2PU                                     2
+#define FM_PWRM1_D2S2PU                                     0x4
+
+#define FB_PWRM1_D2S1PU                                     1
+#define FM_PWRM1_D2S1PU                                     0x2
+
+#define FB_PWRM1_VREFPU                                     0
+#define FM_PWRM1_VREFPU                                     0x1
+
+// *** PWRM2 ***
+#define FB_PWRM2_I2S3OPU                                    5
+#define FM_PWRM2_I2S3OPU                                    0x20
+#define FV_I2S3OPU_PWR_DOWN                                 0x0
+#define FV_I2S3OPU_PWR_UP                                   0x20
+
+#define FB_PWRM2_I2S2OPU                                    4
+#define FM_PWRM2_I2S2OPU                                    0x10
+#define FV_I2S2OPU_PWR_DOWN                                 0x0
+#define FV_I2S2OPU_PWR_UP                                   0x10
+
+#define FB_PWRM2_I2S1OPU                                    3
+#define FM_PWRM2_I2S1OPU                                    0x8
+#define FV_I2S1OPU_PWR_DOWN                                 0x0
+#define FV_I2S1OPU_PWR_UP                                   0x8
+
+#define FB_PWRM2_I2S3IPU                                    2
+#define FM_PWRM2_I2S3IPU                                    0x4
+#define FV_I2S3IPU_PWR_DOWN                                 0x0
+#define FV_I2S3IPU_PWR_UP                                   0x4
+
+#define FB_PWRM2_I2S2IPU                                    1
+#define FM_PWRM2_I2S2IPU                                    0x2
+#define FV_I2S2IPU_PWR_DOWN                                 0x0
+#define FV_I2S2IPU_PWR_UP                                   0x2
+
+#define FB_PWRM2_I2S1IPU                                    0
+#define FM_PWRM2_I2S1IPU                                    0x1
+#define FV_I2S1IPU_PWR_DOWN                                 0x0
+#define FV_I2S1IPU_PWR_UP                                   0x1
+
+#define PWRM2_I2SOPU_PWR_DOWN                               0x0
+#define PWRM2_I2SOPU_PWR_UP                                 0x1
+#define PWRM2_I2SIPU_PWR_DOWN                               0x0
+#define PWRM2_I2SIPU_PWR_UP                                 0x1
+
+// *** PWRM3 ***
+#define FB_PWRM3_BGSBUP                                     6
+#define FM_PWRM3_BGSBUP                                     0x40
+#define FV_BGSBUP_ON                                        0x0
+#define FV_BGSBUP_OFF                                       0x40
+
+#define FB_PWRM3_VGBAPU                                     5
+#define FM_PWRM3_VGBAPU                                     0x20
+#define FV_VGBAPU_ON                                        0x0
+#define FV_VGBAPU_OFF                                       0x20
+
+#define FB_PWRM3_LLINEPU                                    4
+#define FM_PWRM3_LLINEPU                                    0x10
+
+#define FB_PWRM3_RLINEPU                                    3
+#define FM_PWRM3_RLINEPU                                    0x8
+
+// *** PWRM4 ***
+#define FB_PWRM4_OPSUBPU                                    4
+#define FM_PWRM4_OPSUBPU                                    0x10
+
+#define FB_PWRM4_OPDACLPU                                   3
+#define FM_PWRM4_OPDACLPU                                   0x8
+
+#define FB_PWRM4_OPDACRPU                                   2
+#define FM_PWRM4_OPDACRPU                                   0x4
+
+#define FB_PWRM4_OPSPKLPU                                   1
+#define FM_PWRM4_OPSPKLPU                                   0x2
+
+#define FB_PWRM4_OPSPKRPU                                   0
+#define FM_PWRM4_OPSPKRPU                                   0x1
+
+// *** I2SIDCTL ***
+#define FB_I2SIDCTL_I2SI3DCTL                               4
+#define FM_I2SIDCTL_I2SI3DCTL                               0x30
+
+#define FB_I2SIDCTL_I2SI2DCTL                               2
+#define FM_I2SIDCTL_I2SI2DCTL                               0xC
+
+#define FB_I2SIDCTL_I2SI1DCTL                               0
+#define FM_I2SIDCTL_I2SI1DCTL                               0x3
+
+// *** I2SODCTL ***
+#define FB_I2SODCTL_I2SO3DCTL                               4
+#define FM_I2SODCTL_I2SO3DCTL                               0x30
+
+#define FB_I2SODCTL_I2SO2DCTL                               2
+#define FM_I2SODCTL_I2SO2DCTL                               0xC
+
+#define FB_I2SODCTL_I2SO1DCTL                               0
+#define FM_I2SODCTL_I2SO1DCTL                               0x3
+
+// *** AUDIOMUX1 ***
+#define FB_AUDIOMUX1_ASRCIMUX                               6
+#define FM_AUDIOMUX1_ASRCIMUX                               0xC0
+#define FV_ASRCIMUX_NONE                                    0x0
+#define FV_ASRCIMUX_I2S1                                    0x40
+#define FV_ASRCIMUX_I2S2                                    0x80
+#define FV_ASRCIMUX_I2S3                                    0xC0
+
+#define FB_AUDIOMUX1_I2S2MUX                                3
+#define FM_AUDIOMUX1_I2S2MUX                                0x38
+#define FV_I2S2MUX_I2S1                                     0x0
+#define FV_I2S2MUX_I2S2                                     0x8
+#define FV_I2S2MUX_I2S3                                     0x10
+#define FV_I2S2MUX_ADC_DMIC                                 0x18
+#define FV_I2S2MUX_DMIC2                                    0x20
+#define FV_I2S2MUX_CLASSD_DSP                               0x28
+#define FV_I2S2MUX_DAC_DSP                                  0x30
+#define FV_I2S2MUX_SUB_DSP                                  0x38
+
+#define FB_AUDIOMUX1_I2S1MUX                                0
+#define FM_AUDIOMUX1_I2S1MUX                                0x7
+#define FV_I2S1MUX_I2S1                                     0x0
+#define FV_I2S1MUX_I2S2                                     0x1
+#define FV_I2S1MUX_I2S3                                     0x2
+#define FV_I2S1MUX_ADC_DMIC                                 0x3
+#define FV_I2S1MUX_DMIC2                                    0x4
+#define FV_I2S1MUX_CLASSD_DSP                               0x5
+#define FV_I2S1MUX_DAC_DSP                                  0x6
+#define FV_I2S1MUX_SUB_DSP                                  0x7
+
+#define AUDIOMUX1_I2SMUX_I2S1                               0x0
+#define AUDIOMUX1_I2SMUX_I2S2                               0x1
+#define AUDIOMUX1_I2SMUX_I2S3                               0x2
+#define AUDIOMUX1_I2SMUX_ADC_DMIC                           0x3
+#define AUDIOMUX1_I2SMUX_DMIC2                              0x4
+#define AUDIOMUX1_I2SMUX_CLASSD_DSP                         0x5
+#define AUDIOMUX1_I2SMUX_DAC_DSP                            0x6
+#define AUDIOMUX1_I2SMUX_SUB_DSP                            0x7
+
+// *** AUDIOMUX2 ***
+#define FB_AUDIOMUX2_ASRCOMUX                               6
+#define FM_AUDIOMUX2_ASRCOMUX                               0xC0
+#define FV_ASRCOMUX_NONE                                    0x0
+#define FV_ASRCOMUX_I2S1                                    0x40
+#define FV_ASRCOMUX_I2S2                                    0x80
+#define FV_ASRCOMUX_I2S3                                    0xC0
+
+#define FB_AUDIOMUX2_DACMUX                                 3
+#define FM_AUDIOMUX2_DACMUX                                 0x38
+#define FV_DACMUX_I2S1                                      0x0
+#define FV_DACMUX_I2S2                                      0x8
+#define FV_DACMUX_I2S3                                      0x10
+#define FV_DACMUX_ADC_DMIC                                  0x18
+#define FV_DACMUX_DMIC2                                     0x20
+#define FV_DACMUX_CLASSD_DSP                                0x28
+#define FV_DACMUX_DAC_DSP                                   0x30
+#define FV_DACMUX_SUB_DSP                                   0x38
+
+#define FB_AUDIOMUX2_I2S3MUX                                0
+#define FM_AUDIOMUX2_I2S3MUX                                0x7
+#define FV_I2S3MUX_I2S1                                     0x0
+#define FV_I2S3MUX_I2S2                                     0x1
+#define FV_I2S3MUX_I2S3                                     0x2
+#define FV_I2S3MUX_ADC_DMIC                                 0x3
+#define FV_I2S3MUX_DMIC2                                    0x4
+#define FV_I2S3MUX_CLASSD_DSP                               0x5
+#define FV_I2S3MUX_DAC_DSP                                  0x6
+#define FV_I2S3MUX_SUB_DSP                                  0x7
+
+// *** AUDIOMUX3 ***
+#define FB_AUDIOMUX3_SUBMUX                                 3
+#define FM_AUDIOMUX3_SUBMUX                                 0xF8
+#define FV_SUBMUX_I2S1_L                                    0x0
+#define FV_SUBMUX_I2S1_R                                    0x8
+#define FV_SUBMUX_I2S1_LR                                   0x10
+#define FV_SUBMUX_I2S2_L                                    0x18
+#define FV_SUBMUX_I2S2_R                                    0x20
+#define FV_SUBMUX_I2S2_LR                                   0x28
+#define FV_SUBMUX_I2S3_L                                    0x30
+#define FV_SUBMUX_I2S3_R                                    0x38
+#define FV_SUBMUX_I2S3_LR                                   0x40
+#define FV_SUBMUX_ADC_DMIC_L                                0x48
+#define FV_SUBMUX_ADC_DMIC_R                                0x50
+#define FV_SUBMUX_ADC_DMIC_LR                               0x58
+#define FV_SUBMUX_DMIC_L                                    0x60
+#define FV_SUBMUX_DMIC_R                                    0x68
+#define FV_SUBMUX_DMIC_LR                                   0x70
+#define FV_SUBMUX_CLASSD_DSP_L                              0x78
+#define FV_SUBMUX_CLASSD_DSP_R                              0x80
+#define FV_SUBMUX_CLASSD_DSP_LR                             0x88
+
+#define FB_AUDIOMUX3_CLSSDMUX                               0
+#define FM_AUDIOMUX3_CLSSDMUX                               0x7
+#define FV_CLSSDMUX_I2S1                                    0x0
+#define FV_CLSSDMUX_I2S2                                    0x1
+#define FV_CLSSDMUX_I2S3                                    0x2
+#define FV_CLSSDMUX_ADC_DMIC                                0x3
+#define FV_CLSSDMUX_DMIC2                                   0x4
+#define FV_CLSSDMUX_CLASSD_DSP                              0x5
+#define FV_CLSSDMUX_DAC_DSP                                 0x6
+#define FV_CLSSDMUX_SUB_DSP                                 0x7
+
+// *** HSDCTL1 ***
+#define FB_HSDCTL1_HPJKTYPE                                 7
+#define FM_HSDCTL1_HPJKTYPE                                 0x80
+
+#define FB_HSDCTL1_CON_DET_PWD                              6
+#define FM_HSDCTL1_CON_DET_PWD                              0x40
+
+#define FB_HSDCTL1_DETCYC                                   4
+#define FM_HSDCTL1_DETCYC                                   0x30
+
+#define FB_HSDCTL1_HPDLYBYP                                 3
+#define FM_HSDCTL1_HPDLYBYP                                 0x8
+
+#define FB_HSDCTL1_HSDETPOL                                 2
+#define FM_HSDCTL1_HSDETPOL                                 0x4
+
+#define FB_HSDCTL1_HPID_EN                                  1
+#define FM_HSDCTL1_HPID_EN                                  0x2
+
+#define FB_HSDCTL1_GBLHS_EN                                 0
+#define FM_HSDCTL1_GBLHS_EN                                 0x1
+
+// *** HSDCTL2 ***
+#define FB_HSDCTL2_FMICBIAS1                                6
+#define FM_HSDCTL2_FMICBIAS1                                0xC0
+
+#define FB_HSDCTL2_MB1MODE                                  5
+#define FM_HSDCTL2_MB1MODE                                  0x20
+#define FV_MB1MODE_AUTO                                     0x0
+#define FV_MB1MODE_MANUAL                                   0x20
+
+#define FB_HSDCTL2_FORCETRG                                 4
+#define FM_HSDCTL2_FORCETRG                                 0x10
+
+#define FB_HSDCTL2_SWMODE                                   3
+#define FM_HSDCTL2_SWMODE                                   0x8
+
+#define FB_HSDCTL2_GHSHIZ                                   2
+#define FM_HSDCTL2_GHSHIZ                                   0x4
+
+#define FB_HSDCTL2_FPLUGTYPE                                0
+#define FM_HSDCTL2_FPLUGTYPE                                0x3
+
+// *** HSDSTAT ***
+#define FB_HSDSTAT_MBIAS1DRV                                5
+#define FM_HSDSTAT_MBIAS1DRV                                0x60
+
+#define FB_HSDSTAT_HSDETSTAT                                3
+#define FM_HSDSTAT_HSDETSTAT                                0x8
+
+#define FB_HSDSTAT_PLUGTYPE                                 1
+#define FM_HSDSTAT_PLUGTYPE                                 0x6
+
+#define FB_HSDSTAT_HSDETDONE                                0
+#define FM_HSDSTAT_HSDETDONE                                0x1
+
+// *** HSDDELAY ***
+#define FB_HSDDELAY_T_STABLE                                0
+#define FM_HSDDELAY_T_STABLE                                0x7
+
+// *** BUTCTL ***
+#define FB_BUTCTL_BPUSHSTAT                                 7
+#define FM_BUTCTL_BPUSHSTAT                                 0x80
+
+#define FB_BUTCTL_BPUSHDET                                  6
+#define FM_BUTCTL_BPUSHDET                                  0x40
+
+#define FB_BUTCTL_BPUSHEN                                   5
+#define FM_BUTCTL_BPUSHEN                                   0x20
+
+#define FB_BUTCTL_BSTABLE_L                                 3
+#define FM_BUTCTL_BSTABLE_L                                 0x18
+
+#define FB_BUTCTL_BSTABLE_S                                 0
+#define FM_BUTCTL_BSTABLE_S                                 0x7
+
+// *** CH0AIC ***
+#define FB_CH0AIC_INSELL                                    6
+#define FM_CH0AIC_INSELL                                    0xC0
+
+#define FB_CH0AIC_MICBST0                                   4
+#define FM_CH0AIC_MICBST0                                   0x30
+
+#define FB_CH0AIC_LADCIN                                    2
+#define FM_CH0AIC_LADCIN                                    0xC
+
+#define FB_CH0AIC_IN_BYPS_L_SEL                             1
+#define FM_CH0AIC_IN_BYPS_L_SEL                             0x2
+
+#define FB_CH0AIC_IPCH0S                                    0
+#define FM_CH0AIC_IPCH0S                                    0x1
+
+// *** CH1AIC ***
+#define FB_CH1AIC_INSELR                                    6
+#define FM_CH1AIC_INSELR                                    0xC0
+
+#define FB_CH1AIC_MICBST1                                   4
+#define FM_CH1AIC_MICBST1                                   0x30
+
+#define FB_CH1AIC_RADCIN                                    2
+#define FM_CH1AIC_RADCIN                                    0xC
+
+#define FB_CH1AIC_IN_BYPS_R_SEL                             1
+#define FM_CH1AIC_IN_BYPS_R_SEL                             0x2
+
+#define FB_CH1AIC_IPCH1S                                    0
+#define FM_CH1AIC_IPCH1S                                    0x1
+
+// *** ICTL0 ***
+#define FB_ICTL0_IN1POL                                     7
+#define FM_ICTL0_IN1POL                                     0x80
+
+#define FB_ICTL0_IN0POL                                     6
+#define FM_ICTL0_IN0POL                                     0x40
+
+#define FB_ICTL0_INPCH10SEL                                 4
+#define FM_ICTL0_INPCH10SEL                                 0x30
+
+#define FB_ICTL0_IN1MUTE                                    3
+#define FM_ICTL0_IN1MUTE                                    0x8
+
+#define FB_ICTL0_IN0MUTE                                    2
+#define FM_ICTL0_IN0MUTE                                    0x4
+
+#define FB_ICTL0_IN1HP                                      1
+#define FM_ICTL0_IN1HP                                      0x2
+
+#define FB_ICTL0_IN0HP                                      0
+#define FM_ICTL0_IN0HP                                      0x1
+
+// *** ICTL1 ***
+#define FB_ICTL1_IN3POL                                     7
+#define FM_ICTL1_IN3POL                                     0x80
+
+#define FB_ICTL1_IN2POL                                     6
+#define FM_ICTL1_IN2POL                                     0x40
+
+#define FB_ICTL1_INPCH32SEL                                 4
+#define FM_ICTL1_INPCH32SEL                                 0x30
+
+#define FB_ICTL1_IN3MUTE                                    3
+#define FM_ICTL1_IN3MUTE                                    0x8
+
+#define FB_ICTL1_IN2MUTE                                    2
+#define FM_ICTL1_IN2MUTE                                    0x4
+
+#define FB_ICTL1_IN3HP                                      1
+#define FM_ICTL1_IN3HP                                      0x2
+
+#define FB_ICTL1_IN2HP                                      0
+#define FM_ICTL1_IN2HP                                      0x1
+
+// *** MICBIAS ***
+#define FB_MICBIAS_MICBOV2                                  4
+#define FM_MICBIAS_MICBOV2                                  0x30
+
+#define FB_MICBIAS_MICBOV1                                  6
+#define FM_MICBIAS_MICBOV1                                  0xC0
+
+#define FB_MICBIAS_SPARE1                                   2
+#define FM_MICBIAS_SPARE1                                   0xC
+
+#define FB_MICBIAS_SPARE2                                   0
+#define FM_MICBIAS_SPARE2                                   0x3
+
+// *** PGAZ ***
+#define FB_PGAZ_INHPOR                                      1
+#define FM_PGAZ_INHPOR                                      0x2
+
+#define FB_PGAZ_TOEN                                        0
+#define FM_PGAZ_TOEN                                        0x1
+
+// *** ASRCILVOL ***
+#define FB_ASRCILVOL_ASRCILVOL                              0
+#define FM_ASRCILVOL_ASRCILVOL                              0xFF
+
+// *** ASRCIRVOL ***
+#define FB_ASRCIRVOL_ASRCIRVOL                              0
+#define FM_ASRCIRVOL_ASRCIRVOL                              0xFF
+
+// *** ASRCOLVOL ***
+#define FB_ASRCOLVOL_ASRCOLVOL                              0
+#define FM_ASRCOLVOL_ASRCOLVOL                              0xFF
+
+// *** ASRCORVOL ***
+#define FB_ASRCORVOL_ASRCOLVOL                              0
+#define FM_ASRCORVOL_ASRCOLVOL                              0xFF
+
+// *** IVOLCTLU ***
+#define FB_IVOLCTLU_IFADE                                   3
+#define FM_IVOLCTLU_IFADE                                   0x8
+
+#define FB_IVOLCTLU_INPVOLU                                 2
+#define FM_IVOLCTLU_INPVOLU                                 0x4
+
+#define FB_IVOLCTLU_PGAVOLU                                 1
+#define FM_IVOLCTLU_PGAVOLU                                 0x2
+
+#define FB_IVOLCTLU_ASRCVOLU                                0
+#define FM_IVOLCTLU_ASRCVOLU                                0x1
+
+// *** ALCCTL0 ***
+#define FB_ALCCTL0_ALCMODE                                  7
+#define FM_ALCCTL0_ALCMODE                                  0x80
+
+#define FB_ALCCTL0_ALCREF                                   4
+#define FM_ALCCTL0_ALCREF                                   0x70
+
+#define FB_ALCCTL0_ALCEN3                                   3
+#define FM_ALCCTL0_ALCEN3                                   0x8
+
+#define FB_ALCCTL0_ALCEN2                                   2
+#define FM_ALCCTL0_ALCEN2                                   0x4
+
+#define FB_ALCCTL0_ALCEN1                                   1
+#define FM_ALCCTL0_ALCEN1                                   0x2
+
+#define FB_ALCCTL0_ALCEN0                                   0
+#define FM_ALCCTL0_ALCEN0                                   0x1
+
+// *** ALCCTL1 ***
+#define FB_ALCCTL1_MAXGAIN                                  4
+#define FM_ALCCTL1_MAXGAIN                                  0x70
+
+#define FB_ALCCTL1_ALCL                                     0
+#define FM_ALCCTL1_ALCL                                     0xF
+
+// *** ALCCTL2 ***
+#define FB_ALCCTL2_ALCZC                                    7
+#define FM_ALCCTL2_ALCZC                                    0x80
+
+#define FB_ALCCTL2_MINGAIN                                  4
+#define FM_ALCCTL2_MINGAIN                                  0x70
+
+#define FB_ALCCTL2_HLD                                      0
+#define FM_ALCCTL2_HLD                                      0xF
+
+// *** ALCCTL3 ***
+#define FB_ALCCTL3_DCY                                      4
+#define FM_ALCCTL3_DCY                                      0xF0
+
+#define FB_ALCCTL3_ATK                                      0
+#define FM_ALCCTL3_ATK                                      0xF
+
+// *** NGATE ***
+#define FB_NGATE_NGTH                                       3
+#define FM_NGATE_NGTH                                       0xF8
+
+#define FB_NGATE_NGG                                        1
+#define FM_NGATE_NGG                                        0x6
+
+#define FB_NGATE_NGAT                                       0
+#define FM_NGATE_NGAT                                       0x1
+
+// *** DMICCTL ***
+#define FB_DMICCTL_DMIC2EN                                  7
+#define FM_DMICCTL_DMIC2EN                                  0x80
+
+#define FB_DMICCTL_DMIC1EN                                  6
+#define FM_DMICCTL_DMIC1EN                                  0x40
+
+#define FB_DMICCTL_DMONO                                    4
+#define FM_DMICCTL_DMONO                                    0x10
+
+#define FB_DMICCTL_DMDCLK                                   2
+#define FM_DMICCTL_DMDCLK                                   0xC
+
+#define FB_DMICCTL_DMRATE                                   0
+#define FM_DMICCTL_DMRATE                                   0x3
+
+// *** DACCTL ***
+#define FB_DACCTL_DACPOLR                                   7
+#define FM_DACCTL_DACPOLR                                   0x80
+#define FV_DACPOLR_NORMAL                                   0x0
+#define FV_DACPOLR_INVERTED                                 0x80
+
+#define FB_DACCTL_DACPOLL                                   6
+#define FM_DACCTL_DACPOLL                                   0x40
+#define FV_DACPOLL_NORMAL                                   0x0
+#define FV_DACPOLL_INVERTED                                 0x40
+
+#define FB_DACCTL_DACDITH                                   4
+#define FM_DACCTL_DACDITH                                   0x30
+#define FV_DACDITH_DYNAMIC_HALF                             0x0
+#define FV_DACDITH_DYNAMIC_FULL                             0x10
+#define FV_DACDITH_DISABLED                                 0x20
+#define FV_DACDITH_STATIC                                   0x30
+
+#define FB_DACCTL_DACMUTE                                   3
+#define FM_DACCTL_DACMUTE                                   0x8
+#define FV_DACMUTE_ENABLE                                   0x8
+#define FV_DACMUTE_DISABLE                                  0x0
+
+#define FB_DACCTL_DACDEM                                    2
+#define FM_DACCTL_DACDEM                                    0x4
+#define FV_DACDEM_ENABLE                                    0x4
+#define FV_DACDEM_DISABLE                                   0x0
+
+#define FB_DACCTL_ABYPASS                                   0
+#define FM_DACCTL_ABYPASS                                   0x1
+
+// *** SPKCTL ***
+#define FB_SPKCTL_SPKPOLR                                   7
+#define FM_SPKCTL_SPKPOLR                                   0x80
+#define FV_SPKPOLR_NORMAL                                   0x0
+#define FV_SPKPOLR_INVERTED                                 0x80
+
+#define FB_SPKCTL_SPKPOLL                                   6
+#define FM_SPKCTL_SPKPOLL                                   0x40
+#define FV_SPKPOLL_NORMAL                                   0x0
+#define FV_SPKPOLL_INVERTED                                 0x40
+
+#define FB_SPKCTL_SPKMUTE                                   3
+#define FM_SPKCTL_SPKMUTE                                   0x8
+#define FV_SPKMUTE_ENABLE                                   0x8
+#define FV_SPKMUTE_DISABLE                                  0x0
+
+#define FB_SPKCTL_SPKDEM                                    2
+#define FM_SPKCTL_SPKDEM                                    0x4
+#define FV_SPKDEM_ENABLE                                    0x4
+#define FV_SPKDEM_DISABLE                                   0x0
+
+// *** SUBCTL ***
+#define FB_SUBCTL_SUBPOL                                    7
+#define FM_SUBCTL_SUBPOL                                    0x80
+
+#define FB_SUBCTL_SUBMUTE                                   3
+#define FM_SUBCTL_SUBMUTE                                   0x8
+
+#define FB_SUBCTL_SUBDEM                                    2
+#define FM_SUBCTL_SUBDEM                                    0x4
+
+#define FB_SUBCTL_SUBMUX                                    1
+#define FM_SUBCTL_SUBMUX                                    0x2
+
+#define FB_SUBCTL_SUBILMDIS                                 0
+#define FM_SUBCTL_SUBILMDIS                                 0x1
+
+// *** DCCTL ***
+#define FB_DCCTL_SUBDCBYP                                   7
+#define FM_DCCTL_SUBDCBYP                                   0x80
+
+#define FB_DCCTL_DACDCBYP                                   6
+#define FM_DCCTL_DACDCBYP                                   0x40
+
+#define FB_DCCTL_SPKDCBYP                                   5
+#define FM_DCCTL_SPKDCBYP                                   0x20
+
+#define FB_DCCTL_DCCOEFSEL                                  0
+#define FM_DCCTL_DCCOEFSEL                                  0x7
+
+// *** OVOLCTLU ***
+#define FB_OVOLCTLU_OFADE                                   4
+#define FM_OVOLCTLU_OFADE                                   0x10
+
+#define FB_OVOLCTLU_SUBVOLU                                 3
+#define FM_OVOLCTLU_SUBVOLU                                 0x8
+
+#define FB_OVOLCTLU_MVOLU                                   2
+#define FM_OVOLCTLU_MVOLU                                   0x4
+
+#define FB_OVOLCTLU_SPKVOLU                                 1
+#define FM_OVOLCTLU_SPKVOLU                                 0x2
+
+#define FB_OVOLCTLU_HPVOLU                                  0
+#define FM_OVOLCTLU_HPVOLU                                  0x1
+
+// *** MUTEC ***
+#define FB_MUTEC_ZDSTAT                                     7
+#define FM_MUTEC_ZDSTAT                                     0x80
+
+#define FB_MUTEC_ZDLEN                                      4
+#define FM_MUTEC_ZDLEN                                      0x30
+
+#define FB_MUTEC_APWD                                       3
+#define FM_MUTEC_APWD                                       0x8
+
+#define FB_MUTEC_AMUTE                                      2
+#define FM_MUTEC_AMUTE                                      0x4
+
+// *** MVOLL ***
+#define FB_MVOLL_MVOL_L                                     0
+#define FM_MVOLL_MVOL_L                                     0xFF
+
+// *** MVOLR ***
+#define FB_MVOLR_MVOL_R                                     0
+#define FM_MVOLR_MVOL_R                                     0xFF
+
+// *** HPVOLL ***
+#define FB_HPVOLL_HPVOL_L                                   0
+#define FM_HPVOLL_HPVOL_L                                   0x7F
+
+// *** HPVOLR ***
+#define FB_HPVOLR_HPVOL_R                                   0
+#define FM_HPVOLR_HPVOL_R                                   0x7F
+
+// *** SPKVOLL ***
+#define FB_SPKVOLL_SPKVOL_L                                 0
+#define FM_SPKVOLL_SPKVOL_L                                 0x7F
+
+// *** SPKVOLR ***
+#define FB_SPKVOLR_SPKVOL_R                                 0
+#define FM_SPKVOLR_SPKVOL_R                                 0x7F
+
+// *** SUBVOL ***
+#define FB_SUBVOL_SUBVOL                                    0
+#define FM_SUBVOL_SUBVOL                                    0x7F
+
+// *** COP0 ***
+#define FB_COP0_COPATTEN                                    7
+#define FM_COP0_COPATTEN                                    0x80
+
+#define FB_COP0_COPGAIN                                     6
+#define FM_COP0_COPGAIN                                     0x40
+
+#define FB_COP0_HDELTAEN                                    5
+#define FM_COP0_HDELTAEN                                    0x20
+
+#define FB_COP0_COPTARGET                                   0
+#define FM_COP0_COPTARGET                                   0x1F
+
+// *** COP1 ***
+#define FB_COP1_HDCOMPMODE                                  6
+#define FM_COP1_HDCOMPMODE                                  0x40
+
+#define FB_COP1_AVGLENGTH                                   2
+#define FM_COP1_AVGLENGTH                                   0x3C
+
+#define FB_COP1_MONRATE                                     0
+#define FM_COP1_MONRATE                                     0x3
+
+// *** COPSTAT ***
+#define FB_COPSTAT_HDELTADET                                7
+#define FM_COPSTAT_HDELTADET                                0x80
+
+#define FB_COPSTAT_UV                                       6
+#define FM_COPSTAT_UV                                       0x40
+
+#define FB_COPSTAT_COPADJ                                   0
+#define FM_COPSTAT_COPADJ                                   0x3F
+
+// *** PWM0 ***
+#define FB_PWM0_SCTO                                        6
+#define FM_PWM0_SCTO                                        0xC0
+
+#define FB_PWM0_UVLO                                        5
+#define FM_PWM0_UVLO                                        0x20
+
+#define FB_PWM0_BFDIS                                       3
+#define FM_PWM0_BFDIS                                       0x8
+
+#define FB_PWM0_PWMMODE                                     2
+#define FM_PWM0_PWMMODE                                     0x4
+
+#define FB_PWM0_NOOFFSET                                    0
+#define FM_PWM0_NOOFFSET                                    0x1
+
+// *** PWM1 ***
+#define FB_PWM1_DITHPOS                                     4
+#define FM_PWM1_DITHPOS                                     0x70
+
+#define FB_PWM1_DYNDITH                                     1
+#define FM_PWM1_DYNDITH                                     0x2
+
+#define FB_PWM1_DITHDIS                                     0
+#define FM_PWM1_DITHDIS                                     0x1
+
+// *** PWM2 ***
+// *** PWM3 ***
+#define FB_PWM3_PWMMUX                                      6
+#define FM_PWM3_PWMMUX                                      0xC0
+
+#define FB_PWM3_CVALUE                                      0
+#define FM_PWM3_CVALUE                                      0x7
+
+// *** HPSW ***
+#define FB_HPSW_HPDETSTATE                                  4
+#define FM_HPSW_HPDETSTATE                                  0x10
+
+#define FB_HPSW_HPSWEN                                      2
+#define FM_HPSW_HPSWEN                                      0xC
+
+#define FB_HPSW_HPSWPOL                                     1
+#define FM_HPSW_HPSWPOL                                     0x2
+
+#define FB_HPSW_TSDEN                                       0
+#define FM_HPSW_TSDEN                                       0x1
+
+// *** THERMTS ***
+#define FB_THERMTS_TRIPHS                                   7
+#define FM_THERMTS_TRIPHS                                   0x80
+
+#define FB_THERMTS_TRIPLS                                   6
+#define FM_THERMTS_TRIPLS                                   0x40
+
+#define FB_THERMTS_TRIPSPLIT                                4
+#define FM_THERMTS_TRIPSPLIT                                0x30
+
+#define FB_THERMTS_TRIPSHIFT                                2
+#define FM_THERMTS_TRIPSHIFT                                0xC
+
+#define FB_THERMTS_TSPOLL                                   0
+#define FM_THERMTS_TSPOLL                                   0x3
+
+// *** THERMSPK1 ***
+#define FB_THERMSPK1_FORCEPWD                               7
+#define FM_THERMSPK1_FORCEPWD                               0x80
+
+#define FB_THERMSPK1_INSTCUTMODE                            6
+#define FM_THERMSPK1_INSTCUTMODE                            0x40
+
+#define FB_THERMSPK1_INCRATIO                               4
+#define FM_THERMSPK1_INCRATIO                               0x30
+
+#define FB_THERMSPK1_INCSTEP                                2
+#define FM_THERMSPK1_INCSTEP                                0xC
+
+#define FB_THERMSPK1_DECSTEP                                0
+#define FM_THERMSPK1_DECSTEP                                0x3
+
+// *** THERMSTAT ***
+#define FB_THERMSTAT_FPWDS                                  7
+#define FM_THERMSTAT_FPWDS                                  0x80
+
+#define FB_THERMSTAT_VOLSTAT                                0
+#define FM_THERMSTAT_VOLSTAT                                0x7F
+
+// *** SCSTAT ***
+#define FB_SCSTAT_ESDF                                      3
+#define FM_SCSTAT_ESDF                                      0x18
+
+#define FB_SCSTAT_CPF                                       2
+#define FM_SCSTAT_CPF                                       0x4
+
+#define FB_SCSTAT_CLSDF                                     0
+#define FM_SCSTAT_CLSDF                                     0x3
+
+// *** SDMON ***
+#define FB_SDMON_SDFORCE                                    7
+#define FM_SDMON_SDFORCE                                    0x80
+
+#define FB_SDMON_SDVALUE                                    0
+#define FM_SDMON_SDVALUE                                    0x1F
+
+// *** SPKEQFILT ***
+#define FB_SPKEQFILT_EQ2EN                                  7
+#define FM_SPKEQFILT_EQ2EN                                  0x80
+#define FV_EQ2EN_ENABLE                                     0x80
+#define FV_EQ2EN_DISABLE                                    0x0
+
+#define FB_SPKEQFILT_EQ2BE                                  4
+#define FM_SPKEQFILT_EQ2BE                                  0x70
+
+#define FB_SPKEQFILT_EQ1EN                                  3
+#define FM_SPKEQFILT_EQ1EN                                  0x8
+#define FV_EQ1EN_ENABLE                                     0x8
+#define FV_EQ1EN_DISABLE                                    0x0
+
+#define FB_SPKEQFILT_EQ1BE                                  0
+#define FM_SPKEQFILT_EQ1BE                                  0x7
+
+#define SPKEQFILT_EQEN_ENABLE                               0x1
+#define SPKEQFILT_EQEN_DISABLE                              0x0
+
+// *** SPKCRWDL ***
+#define FB_SPKCRWDL_WDATA_L                                 0
+#define FM_SPKCRWDL_WDATA_L                                 0xFF
+
+// *** SPKCRWDM ***
+#define FB_SPKCRWDM_WDATA_M                                 0
+#define FM_SPKCRWDM_WDATA_M                                 0xFF
+
+// *** SPKCRWDH ***
+#define FB_SPKCRWDH_WDATA_H                                 0
+#define FM_SPKCRWDH_WDATA_H                                 0xFF
+
+// *** SPKCRRDL ***
+#define FB_SPKCRRDL_RDATA_L                                 0
+#define FM_SPKCRRDL_RDATA_L                                 0xFF
+
+// *** SPKCRRDM ***
+#define FB_SPKCRRDM_RDATA_M                                 0
+#define FM_SPKCRRDM_RDATA_M                                 0xFF
+
+// *** SPKCRRDH ***
+#define FB_SPKCRRDH_RDATA_H                                 0
+#define FM_SPKCRRDH_RDATA_H                                 0xFF
+
+// *** SPKCRADD ***
+#define FB_SPKCRADD_ADDRESS                                 0
+#define FM_SPKCRADD_ADDRESS                                 0xFF
+
+// *** SPKCRS ***
+#define FB_SPKCRS_ACCSTAT                                   7
+#define FM_SPKCRS_ACCSTAT                                   0x80
+
+// *** SPKMBCEN ***
+#define FB_SPKMBCEN_MBCEN3                                  2
+#define FM_SPKMBCEN_MBCEN3                                  0x4
+#define FV_MBCEN3_ENABLE                                    0x4
+#define FV_MBCEN3_DISABLE                                   0x0
+
+#define FB_SPKMBCEN_MBCEN2                                  1
+#define FM_SPKMBCEN_MBCEN2                                  0x2
+#define FV_MBCEN2_ENABLE                                    0x2
+#define FV_MBCEN2_DISABLE                                   0x0
+
+#define FB_SPKMBCEN_MBCEN1                                  0
+#define FM_SPKMBCEN_MBCEN1                                  0x1
+#define FV_MBCEN1_ENABLE                                    0x1
+#define FV_MBCEN1_DISABLE                                   0x0
+
+#define SPKMBCEN_MBCEN_ENABLE                               0x1
+#define SPKMBCEN_MBCEN_DISABLE                              0x0
+
+// *** SPKMBCCTL ***
+#define FB_SPKMBCCTL_LVLMODE3                               5
+#define FM_SPKMBCCTL_LVLMODE3                               0x20
+
+#define FB_SPKMBCCTL_WINSEL3                                4
+#define FM_SPKMBCCTL_WINSEL3                                0x10
+
+#define FB_SPKMBCCTL_LVLMODE2                               3
+#define FM_SPKMBCCTL_LVLMODE2                               0x8
+
+#define FB_SPKMBCCTL_WINSEL2                                2
+#define FM_SPKMBCCTL_WINSEL2                                0x4
+
+#define FB_SPKMBCCTL_LVLMODE1                               1
+#define FM_SPKMBCCTL_LVLMODE1                               0x2
+
+#define FB_SPKMBCCTL_WINSEL1                                0
+#define FM_SPKMBCCTL_WINSEL1                                0x1
+
+// *** SPKCLECTL ***
+#define FB_SPKCLECTL_LVLMODE                                4
+#define FM_SPKCLECTL_LVLMODE                                0x10
+
+#define FB_SPKCLECTL_WINSEL                                 3
+#define FM_SPKCLECTL_WINSEL                                 0x8
+
+#define FB_SPKCLECTL_EXPEN                                  2
+#define FM_SPKCLECTL_EXPEN                                  0x4
+#define FV_EXPEN_ENABLE                                     0x4
+#define FV_EXPEN_DISABLE                                    0x0
+
+#define FB_SPKCLECTL_LIMEN                                  1
+#define FM_SPKCLECTL_LIMEN                                  0x2
+#define FV_LIMEN_ENABLE                                     0x2
+#define FV_LIMEN_DISABLE                                    0x0
+
+#define FB_SPKCLECTL_COMPEN                                 0
+#define FM_SPKCLECTL_COMPEN                                 0x1
+#define FV_COMPEN_ENABLE                                    0x1
+#define FV_COMPEN_DISABLE                                   0x0
+
+// *** SPKCLEMUG ***
+#define FB_SPKCLEMUG_MUGAIN                                 0
+#define FM_SPKCLEMUG_MUGAIN                                 0x1F
+
+// *** SPKCOMPTHR ***
+#define FB_SPKCOMPTHR_THRESH                                0
+#define FM_SPKCOMPTHR_THRESH                                0xFF
+
+// *** SPKCOMPRAT ***
+#define FB_SPKCOMPRAT_RATIO                                 0
+#define FM_SPKCOMPRAT_RATIO                                 0x1F
+
+// *** SPKCOMPATKL ***
+#define FB_SPKCOMPATKL_TCATKL                               0
+#define FM_SPKCOMPATKL_TCATKL                               0xFF
+
+// *** SPKCOMPATKH ***
+#define FB_SPKCOMPATKH_TCATKH                               0
+#define FM_SPKCOMPATKH_TCATKH                               0xFF
+
+// *** SPKCOMPRELL ***
+#define FB_SPKCOMPRELL_TCRELL                               0
+#define FM_SPKCOMPRELL_TCRELL                               0xFF
+
+// *** SPKCOMPRELH ***
+#define FB_SPKCOMPRELH_TCRELH                               0
+#define FM_SPKCOMPRELH_TCRELH                               0xFF
+
+// *** SPKLIMTHR ***
+#define FB_SPKLIMTHR_THRESH                                 0
+#define FM_SPKLIMTHR_THRESH                                 0xFF
+
+// *** SPKLIMTGT ***
+#define FB_SPKLIMTGT_TARGET                                 0
+#define FM_SPKLIMTGT_TARGET                                 0xFF
+
+// *** SPKLIMATKL ***
+#define FB_SPKLIMATKL_TCATKL                                0
+#define FM_SPKLIMATKL_TCATKL                                0xFF
+
+// *** SPKLIMATKH ***
+#define FB_SPKLIMATKH_TCATKH                                0
+#define FM_SPKLIMATKH_TCATKH                                0xFF
+
+// *** SPKLIMRELL ***
+#define FB_SPKLIMRELL_TCRELL                                0
+#define FM_SPKLIMRELL_TCRELL                                0xFF
+
+// *** SPKLIMRELH ***
+#define FB_SPKLIMRELH_TCRELH                                0
+#define FM_SPKLIMRELH_TCRELH                                0xFF
+
+// *** SPKEXPTHR ***
+#define FB_SPKEXPTHR_THRESH                                 0
+#define FM_SPKEXPTHR_THRESH                                 0xFF
+
+// *** SPKEXPRAT ***
+#define FB_SPKEXPRAT_RATIO                                  0
+#define FM_SPKEXPRAT_RATIO                                  0x7
+
+// *** SPKEXPATKL ***
+#define FB_SPKEXPATKL_TCATKL                                0
+#define FM_SPKEXPATKL_TCATKL                                0xFF
+
+// *** SPKEXPATKH ***
+#define FB_SPKEXPATKH_TCATKH                                0
+#define FM_SPKEXPATKH_TCATKH                                0xFF
+
+// *** SPKEXPRELL ***
+#define FB_SPKEXPRELL_TCRELL                                0
+#define FM_SPKEXPRELL_TCRELL                                0xFF
+
+// *** SPKEXPRELH ***
+#define FB_SPKEXPRELH_TCRELH                                0
+#define FM_SPKEXPRELH_TCRELH                                0xFF
+
+// *** SPKFXCTL ***
+#define FB_SPKFXCTL_3DEN                                    4
+#define FM_SPKFXCTL_3DEN                                    0x10
+
+#define FB_SPKFXCTL_TEEN                                    3
+#define FM_SPKFXCTL_TEEN                                    0x8
+
+#define FB_SPKFXCTL_TNLFBYP                                 2
+#define FM_SPKFXCTL_TNLFBYP                                 0x4
+
+#define FB_SPKFXCTL_BEEN                                    1
+#define FM_SPKFXCTL_BEEN                                    0x2
+
+#define FB_SPKFXCTL_BNLFBYP                                 0
+#define FM_SPKFXCTL_BNLFBYP                                 0x1
+
+// *** DACEQFILT ***
+#define FB_DACEQFILT_EQ2EN                                  7
+#define FM_DACEQFILT_EQ2EN                                  0x80
+#define FV_EQ2EN_ENABLE                                     0x80
+#define FV_EQ2EN_DISABLE                                    0x0
+
+#define FB_DACEQFILT_EQ2BE                                  4
+#define FM_DACEQFILT_EQ2BE                                  0x70
+
+#define FB_DACEQFILT_EQ1EN                                  3
+#define FM_DACEQFILT_EQ1EN                                  0x8
+#define FV_EQ1EN_ENABLE                                     0x8
+#define FV_EQ1EN_DISABLE                                    0x0
+
+#define FB_DACEQFILT_EQ1BE                                  0
+#define FM_DACEQFILT_EQ1BE                                  0x7
+
+#define DACEQFILT_EQEN_ENABLE                               0x1
+#define DACEQFILT_EQEN_DISABLE                              0x0
+
+// *** DACCRWDL ***
+#define FB_DACCRWDL_WDATA_L                                 0
+#define FM_DACCRWDL_WDATA_L                                 0xFF
+
+// *** DACCRWDM ***
+#define FB_DACCRWDM_WDATA_M                                 0
+#define FM_DACCRWDM_WDATA_M                                 0xFF
+
+// *** DACCRWDH ***
+#define FB_DACCRWDH_WDATA_H                                 0
+#define FM_DACCRWDH_WDATA_H                                 0xFF
+
+// *** DACCRRDL ***
+#define FB_DACCRRDL_RDATA_L                                 0
+#define FM_DACCRRDL_RDATA_L                                 0xFF
+
+// *** DACCRRDM ***
+#define FB_DACCRRDM_RDATA_M                                 0
+#define FM_DACCRRDM_RDATA_M                                 0xFF
+
+// *** DACCRRDH ***
+#define FB_DACCRRDH_RDATA_H                                 0
+#define FM_DACCRRDH_RDATA_H                                 0xFF
+
+// *** DACCRADD ***
+#define FB_DACCRADD_ADDRESS                                 0
+#define FM_DACCRADD_ADDRESS                                 0xFF
+
+// *** DACCRS ***
+#define FB_DACCRS_ACCSTAT                                   7
+#define FM_DACCRS_ACCSTAT                                   0x80
+
+// *** DACMBCEN ***
+#define FB_DACMBCEN_MBCEN3                                  2
+#define FM_DACMBCEN_MBCEN3                                  0x4
+#define FV_MBCEN3_ENABLE                                    0x4
+#define FV_MBCEN3_DISABLE                                   0x0
+
+#define FB_DACMBCEN_MBCEN2                                  1
+#define FM_DACMBCEN_MBCEN2                                  0x2
+#define FV_MBCEN2_ENABLE                                    0x2
+#define FV_MBCEN2_DISABLE                                   0x0
+
+#define FB_DACMBCEN_MBCEN1                                  0
+#define FM_DACMBCEN_MBCEN1                                  0x1
+#define FV_MBCEN1_ENABLE                                    0x1
+#define FV_MBCEN1_DISABLE                                   0x0
+
+#define DACMBCEN_MBCEN_ENABLE                               0x1
+#define DACMBCEN_MBCEN_DISABLE                              0x0
+
+// *** DACMBCCTL ***
+#define FB_DACMBCCTL_LVLMODE3                               5
+#define FM_DACMBCCTL_LVLMODE3                               0x20
+
+#define FB_DACMBCCTL_WINSEL3                                4
+#define FM_DACMBCCTL_WINSEL3                                0x10
+
+#define FB_DACMBCCTL_LVLMODE2                               3
+#define FM_DACMBCCTL_LVLMODE2                               0x8
+
+#define FB_DACMBCCTL_WINSEL2                                2
+#define FM_DACMBCCTL_WINSEL2                                0x4
+
+#define FB_DACMBCCTL_LVLMODE1                               1
+#define FM_DACMBCCTL_LVLMODE1                               0x2
+
+#define FB_DACMBCCTL_WINSEL1                                0
+#define FM_DACMBCCTL_WINSEL1                                0x1
+
+// *** DACCLECTL ***
+#define FB_DACCLECTL_LVLMODE                                4
+#define FM_DACCLECTL_LVLMODE                                0x10
+
+#define FB_DACCLECTL_WINSEL                                 3
+#define FM_DACCLECTL_WINSEL                                 0x8
+
+#define FB_DACCLECTL_EXPEN                                  2
+#define FM_DACCLECTL_EXPEN                                  0x4
+#define FV_EXPEN_ENABLE                                     0x4
+#define FV_EXPEN_DISABLE                                    0x0
+
+#define FB_DACCLECTL_LIMEN                                  1
+#define FM_DACCLECTL_LIMEN                                  0x2
+#define FV_LIMEN_ENABLE                                     0x2
+#define FV_LIMEN_DISABLE                                    0x0
+
+#define FB_DACCLECTL_COMPEN                                 0
+#define FM_DACCLECTL_COMPEN                                 0x1
+#define FV_COMPEN_ENABLE                                    0x1
+#define FV_COMPEN_DISABLE                                   0x0
+
+// *** DACCLEMUG ***
+#define FB_DACCLEMUG_MUGAIN                                 0
+#define FM_DACCLEMUG_MUGAIN                                 0x1F
+
+// *** DACCOMPTHR ***
+#define FB_DACCOMPTHR_THRESH                                0
+#define FM_DACCOMPTHR_THRESH                                0xFF
+
+// *** DACCOMPRAT ***
+#define FB_DACCOMPRAT_RATIO                                 0
+#define FM_DACCOMPRAT_RATIO                                 0x1F
+
+// *** DACCOMPATKL ***
+#define FB_DACCOMPATKL_TCATKL                               0
+#define FM_DACCOMPATKL_TCATKL                               0xFF
+
+// *** DACCOMPATKH ***
+#define FB_DACCOMPATKH_TCATKH                               0
+#define FM_DACCOMPATKH_TCATKH                               0xFF
+
+// *** DACCOMPRELL ***
+#define FB_DACCOMPRELL_TCRELL                               0
+#define FM_DACCOMPRELL_TCRELL                               0xFF
+
+// *** DACCOMPRELH ***
+#define FB_DACCOMPRELH_TCRELH                               0
+#define FM_DACCOMPRELH_TCRELH                               0xFF
+
+// *** DACLIMTHR ***
+#define FB_DACLIMTHR_THRESH                                 0
+#define FM_DACLIMTHR_THRESH                                 0xFF
+
+// *** DACLIMTGT ***
+#define FB_DACLIMTGT_TARGET                                 0
+#define FM_DACLIMTGT_TARGET                                 0xFF
+
+// *** DACLIMATKL ***
+#define FB_DACLIMATKL_TCATKL                                0
+#define FM_DACLIMATKL_TCATKL                                0xFF
+
+// *** DACLIMATKH ***
+#define FB_DACLIMATKH_TCATKH                                0
+#define FM_DACLIMATKH_TCATKH                                0xFF
+
+// *** DACLIMRELL ***
+#define FB_DACLIMRELL_TCRELL                                0
+#define FM_DACLIMRELL_TCRELL                                0xFF
+
+// *** DACLIMRELH ***
+#define FB_DACLIMRELH_TCRELH                                0
+#define FM_DACLIMRELH_TCRELH                                0xFF
+
+// *** DACEXPTHR ***
+#define FB_DACEXPTHR_THRESH                                 0
+#define FM_DACEXPTHR_THRESH                                 0xFF
+
+// *** DACEXPRAT ***
+#define FB_DACEXPRAT_RATIO                                  0
+#define FM_DACEXPRAT_RATIO                                  0x7
+
+// *** DACEXPATKL ***
+#define FB_DACEXPATKL_TCATKL                                0
+#define FM_DACEXPATKL_TCATKL                                0xFF
+
+// *** DACEXPATKH ***
+#define FB_DACEXPATKH_TCATKH                                0
+#define FM_DACEXPATKH_TCATKH                                0xFF
+
+// *** DACEXPRELL ***
+#define FB_DACEXPRELL_TCRELL                                0
+#define FM_DACEXPRELL_TCRELL                                0xFF
+
+// *** DACEXPRELH ***
+#define FB_DACEXPRELH_TCRELH                                0
+#define FM_DACEXPRELH_TCRELH                                0xFF
+
+// *** DACFXCTL ***
+#define FB_DACFXCTL_3DEN                                    4
+#define FM_DACFXCTL_3DEN                                    0x10
+
+#define FB_DACFXCTL_TEEN                                    3
+#define FM_DACFXCTL_TEEN                                    0x8
+
+#define FB_DACFXCTL_TNLFBYP                                 2
+#define FM_DACFXCTL_TNLFBYP                                 0x4
+
+#define FB_DACFXCTL_BEEN                                    1
+#define FM_DACFXCTL_BEEN                                    0x2
+
+#define FB_DACFXCTL_BNLFBYP                                 0
+#define FM_DACFXCTL_BNLFBYP                                 0x1
+
+// *** SUBEQFILT ***
+#define FB_SUBEQFILT_EQ2EN                                  7
+#define FM_SUBEQFILT_EQ2EN                                  0x80
+#define FV_EQ2EN_ENABLE                                     0x80
+#define FV_EQ2EN_DISABLE                                    0x0
+
+#define FB_SUBEQFILT_EQ2BE                                  4
+#define FM_SUBEQFILT_EQ2BE                                  0x70
+
+#define FB_SUBEQFILT_EQ1EN                                  3
+#define FM_SUBEQFILT_EQ1EN                                  0x8
+#define FV_EQ1EN_ENABLE                                     0x8
+#define FV_EQ1EN_DISABLE                                    0x0
+
+#define FB_SUBEQFILT_EQ1BE                                  0
+#define FM_SUBEQFILT_EQ1BE                                  0x7
+
+#define SUBEQFILT_EQEN_ENABLE                               0x1
+#define SUBEQFILT_EQEN_DISABLE                              0x0
+
+// *** SUBCRWDL ***
+#define FB_SUBCRWDL_WDATA_L                                 0
+#define FM_SUBCRWDL_WDATA_L                                 0xFF
+
+// *** SUBCRWDM ***
+#define FB_SUBCRWDM_WDATA_M                                 0
+#define FM_SUBCRWDM_WDATA_M                                 0xFF
+
+// *** SUBCRWDH ***
+#define FB_SUBCRWDH_WDATA_H                                 0
+#define FM_SUBCRWDH_WDATA_H                                 0xFF
+
+// *** SUBCRRDL ***
+#define FB_SUBCRRDL_RDATA_L                                 0
+#define FM_SUBCRRDL_RDATA_L                                 0xFF
+
+// *** SUBCRRDM ***
+#define FB_SUBCRRDM_RDATA_M                                 0
+#define FM_SUBCRRDM_RDATA_M                                 0xFF
+
+// *** SUBCRRDH ***
+#define FB_SUBCRRDH_RDATA_H                                 0
+#define FM_SUBCRRDH_RDATA_H                                 0xFF
+
+// *** SUBCRADD ***
+#define FB_SUBCRADD_ADDRESS                                 0
+#define FM_SUBCRADD_ADDRESS                                 0xFF
+
+// *** SUBCRS ***
+#define FB_SUBCRS_ACCSTAT                                   7
+#define FM_SUBCRS_ACCSTAT                                   0x80
+
+// *** SUBMBCEN ***
+#define FB_SUBMBCEN_MBCEN3                                  2
+#define FM_SUBMBCEN_MBCEN3                                  0x4
+#define FV_MBCEN3_ENABLE                                    0x4
+#define FV_MBCEN3_DISABLE                                   0x0
+
+#define FB_SUBMBCEN_MBCEN2                                  1
+#define FM_SUBMBCEN_MBCEN2                                  0x2
+#define FV_MBCEN2_ENABLE                                    0x2
+#define FV_MBCEN2_DISABLE                                   0x0
+
+#define FB_SUBMBCEN_MBCEN1                                  0
+#define FM_SUBMBCEN_MBCEN1                                  0x1
+#define FV_MBCEN1_ENABLE                                    0x1
+#define FV_MBCEN1_DISABLE                                   0x0
+
+#define SUBMBCEN_MBCEN_ENABLE                               0x1
+#define SUBMBCEN_MBCEN_DISABLE                              0x0
+
+// *** SUBMBCCTL ***
+#define FB_SUBMBCCTL_LVLMODE3                               5
+#define FM_SUBMBCCTL_LVLMODE3                               0x20
+
+#define FB_SUBMBCCTL_WINSEL3                                4
+#define FM_SUBMBCCTL_WINSEL3                                0x10
+
+#define FB_SUBMBCCTL_LVLMODE2                               3
+#define FM_SUBMBCCTL_LVLMODE2                               0x8
+
+#define FB_SUBMBCCTL_WINSEL2                                2
+#define FM_SUBMBCCTL_WINSEL2                                0x4
+
+#define FB_SUBMBCCTL_LVLMODE1                               1
+#define FM_SUBMBCCTL_LVLMODE1                               0x2
+
+#define FB_SUBMBCCTL_WINSEL1                                0
+#define FM_SUBMBCCTL_WINSEL1                                0x1
+
+// *** SUBCLECTL ***
+#define FB_SUBCLECTL_LVLMODE                                4
+#define FM_SUBCLECTL_LVLMODE                                0x10
+
+#define FB_SUBCLECTL_WINSEL                                 3
+#define FM_SUBCLECTL_WINSEL                                 0x8
+
+#define FB_SUBCLECTL_EXPEN                                  2
+#define FM_SUBCLECTL_EXPEN                                  0x4
+#define FV_EXPEN_ENABLE                                     0x4
+#define FV_EXPEN_DISABLE                                    0x0
+
+#define FB_SUBCLECTL_LIMEN                                  1
+#define FM_SUBCLECTL_LIMEN                                  0x2
+#define FV_LIMEN_ENABLE                                     0x2
+#define FV_LIMEN_DISABLE                                    0x0
+
+#define FB_SUBCLECTL_COMPEN                                 0
+#define FM_SUBCLECTL_COMPEN                                 0x1
+#define FV_COMPEN_ENABLE                                    0x1
+#define FV_COMPEN_DISABLE                                   0x0
+
+// *** SUBCLEMUG ***
+#define FB_SUBCLEMUG_MUGAIN                                 0
+#define FM_SUBCLEMUG_MUGAIN                                 0x1F
+
+// *** SUBCOMPTHR ***
+#define FB_SUBCOMPTHR_THRESH                                0
+#define FM_SUBCOMPTHR_THRESH                                0xFF
+
+// *** SUBCOMPRAT ***
+#define FB_SUBCOMPRAT_RATIO                                 0
+#define FM_SUBCOMPRAT_RATIO                                 0x1F
+
+// *** SUBCOMPATKL ***
+#define FB_SUBCOMPATKL_TCATKL                               0
+#define FM_SUBCOMPATKL_TCATKL                               0xFF
+
+// *** SUBCOMPATKH ***
+#define FB_SUBCOMPATKH_TCATKH                               0
+#define FM_SUBCOMPATKH_TCATKH                               0xFF
+
+// *** SUBCOMPRELL ***
+#define FB_SUBCOMPRELL_TCRELL                               0
+#define FM_SUBCOMPRELL_TCRELL                               0xFF
+
+// *** SUBCOMPRELH ***
+#define FB_SUBCOMPRELH_TCRELH                               0
+#define FM_SUBCOMPRELH_TCRELH                               0xFF
+
+// *** SUBLIMTHR ***
+#define FB_SUBLIMTHR_THRESH                                 0
+#define FM_SUBLIMTHR_THRESH                                 0xFF
+
+// *** SUBLIMTGT ***
+#define FB_SUBLIMTGT_TARGET                                 0
+#define FM_SUBLIMTGT_TARGET                                 0xFF
+
+// *** SUBLIMATKL ***
+#define FB_SUBLIMATKL_TCATKL                                0
+#define FM_SUBLIMATKL_TCATKL                                0xFF
+
+// *** SUBLIMATKH ***
+#define FB_SUBLIMATKH_TCATKH                                0
+#define FM_SUBLIMATKH_TCATKH                                0xFF
+
+// *** SUBLIMRELL ***
+#define FB_SUBLIMRELL_TCRELL                                0
+#define FM_SUBLIMRELL_TCRELL                                0xFF
+
+// *** SUBLIMRELH ***
+#define FB_SUBLIMRELH_TCRELH                                0
+#define FM_SUBLIMRELH_TCRELH                                0xFF
+
+// *** SUBEXPTHR ***
+#define FB_SUBEXPTHR_THRESH                                 0
+#define FM_SUBEXPTHR_THRESH                                 0xFF
+
+// *** SUBEXPRAT ***
+#define FB_SUBEXPRAT_RATIO                                  0
+#define FM_SUBEXPRAT_RATIO                                  0x7
+
+// *** SUBEXPATKL ***
+#define FB_SUBEXPATKL_TCATKL                                0
+#define FM_SUBEXPATKL_TCATKL                                0xFF
+
+// *** SUBEXPATKH ***
+#define FB_SUBEXPATKH_TCATKH                                0
+#define FM_SUBEXPATKH_TCATKH                                0xFF
+
+// *** SUBEXPRELL ***
+#define FB_SUBEXPRELL_TCRELL                                0
+#define FM_SUBEXPRELL_TCRELL                                0xFF
+
+// *** SUBEXPRELH ***
+#define FB_SUBEXPRELH_TCRELH                                0
+#define FM_SUBEXPRELH_TCRELH                                0xFF
+
+// *** SUBFXCTL ***
+#define FB_SUBFXCTL_TEEN                                    3
+#define FM_SUBFXCTL_TEEN                                    0x8
+
+#define FB_SUBFXCTL_TNLFBYP                                 2
+#define FM_SUBFXCTL_TNLFBYP                                 0x4
+
+#define FB_SUBFXCTL_BEEN                                    1
+#define FM_SUBFXCTL_BEEN                                    0x2
+
+#define FB_SUBFXCTL_BNLFBYP                                 0
+#define FM_SUBFXCTL_BNLFBYP                                 0x1
+
+#endif /* __REDWOODPUBLIC_H__ */
-- 
2.17.0
