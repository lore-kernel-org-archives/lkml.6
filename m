Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeEHDQs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:16:48 -0400
Received: from mx.socionext.com ([202.248.49.38]:7140 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753529AbeEHDQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:16:47 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: add digital output volume for UniPhier sound system
Date: Tue,  8 May 2018 12:16:39 +0900
Message-Id: <20180508031639.24648-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds controllers for digital volume of PCM output. Volume
effects simply linear, not dB scale as follows:
  Gained PCM = Original * 0x4000 / Volume

The value range of volume is from 0x0001 to 0xffff. 0x0000 works as
mute. Initial value is 0x4000 (+0dB).

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/aio-core.c |  58 ++++++++++++++
 sound/soc/uniphier/aio-cpu.c  | 140 ++++++++++++++++++++++++++++++++++
 sound/soc/uniphier/aio-reg.h  |  33 ++++++--
 sound/soc/uniphier/aio.h      |   7 ++
 4 files changed, 233 insertions(+), 5 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index e37b80921abb..638cb3fc5f7b 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -659,6 +659,64 @@ void aio_port_set_enable(struct uniphier_aio_sub *sub, int enable)
 	}
 }
 
+/**
+ * aio_port_get_volume - get volume of AIO port block
+ * @sub: the AIO substream pointer
+ *
+ * Return: current volume, range is 0x0000 - 0xffff
+ */
+int aio_port_get_volume(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	regmap_read(r, OPORTMXTYVOLGAINSTATUS(sub->swm->oport.map, 0), &v);
+
+	return FIELD_GET(OPORTMXTYVOLGAINSTATUS_CUR_MASK, v);
+}
+
+/**
+ * aio_port_set_volume - set volume of AIO port block
+ * @sub: the AIO substream pointer
+ * @vol: target volume, range is 0x0000 - 0xffff.
+ *
+ * Change digital volume and perfome fade-out/fade-in effect for specified
+ * output slot of port. Gained PCM value can calculate as the following:
+ *   Gained = Original * vol / 0x4000
+ */
+void aio_port_set_volume(struct uniphier_aio_sub *sub, int vol)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	int oport_map = sub->swm->oport.map;
+	int cur, diff, slope = 0, fs;
+
+	if (sub->swm->dir == PORT_DIR_INPUT)
+		return;
+
+	cur = aio_port_get_volume(sub);
+	diff = abs(vol - cur);
+	fs = params_rate(&sub->params);
+	if (fs)
+		slope = diff / AUD_VOL_FADE_TIME * 1000 / fs;
+	slope = max(1, slope);
+
+	regmap_update_bits(r, OPORTMXTYVOLPARA1(oport_map, 0),
+			   OPORTMXTYVOLPARA1_SLOPEU_MASK, slope << 16);
+	regmap_update_bits(r, OPORTMXTYVOLPARA2(oport_map, 0),
+			   OPORTMXTYVOLPARA2_TARGET_MASK, vol);
+
+	if (cur < vol)
+		regmap_update_bits(r, OPORTMXTYVOLPARA2(oport_map, 0),
+				   OPORTMXTYVOLPARA2_FADE_MASK,
+				   OPORTMXTYVOLPARA2_FADE_FADEIN);
+	else
+		regmap_update_bits(r, OPORTMXTYVOLPARA2(oport_map, 0),
+				   OPORTMXTYVOLPARA2_FADE_MASK,
+				   OPORTMXTYVOLPARA2_FADE_FADEOUT);
+
+	regmap_write(r, AOUTFADECTR0, BIT(oport_map));
+}
+
 /**
  * aio_if_set_param - set parameters of AIO DMA I/F block
  * @sub: the AIO substream pointer
diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 00b6441bf195..80daec17be25 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -32,6 +32,35 @@ static bool is_valid_pll(struct uniphier_aio_chip *chip, int pll_id)
 	return chip->plls[pll_id].enable;
 }
 
+/**
+ * find_volume - find volume supported HW port by HW port number
+ * @chip: the AIO chip pointer
+ * @oport_hw: HW port number, one of AUD_HW_XXXX
+ *
+ * Find AIO device from device list by HW port number. Volume feature is
+ * available only in Output and PCM ports, this limitation comes from HW
+ * specifications.
+ *
+ * Return: The pointer of AIO substream if successful, otherwise NULL on error.
+ */
+static struct uniphier_aio_sub *find_volume(struct uniphier_aio_chip *chip,
+					    int oport_hw)
+{
+	int i;
+
+	for (i = 0; i < chip->num_aios; i++) {
+		struct uniphier_aio_sub *sub = &chip->aios[i].sub[0];
+
+		if (!sub->swm)
+			continue;
+
+		if (sub->swm->oport.hw == oport_hw)
+			return sub;
+	}
+
+	return NULL;
+}
+
 static bool match_spec(const struct uniphier_aio_spec *spec,
 		       const char *name, int dir)
 {
@@ -287,6 +316,7 @@ static int uniphier_aio_hw_params(struct snd_pcm_substream *substream,
 	sub->setting = 1;
 
 	aio_port_reset(sub);
+	aio_port_set_volume(sub, sub->vol);
 	aio_src_reset(sub);
 
 	return 0;
@@ -373,6 +403,8 @@ int uniphier_aio_dai_probe(struct snd_soc_dai *dai)
 
 		sub->swm = &spec->swm;
 		sub->spec = spec;
+
+		sub->vol = AUD_VOL_INIT;
 	}
 
 	aio_iecout_set_enable(aio->chip, true);
@@ -449,8 +481,116 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 }
 EXPORT_SYMBOL_GPL(uniphier_aio_dai_resume);
 
+static int uniphier_aio_vol_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = AUD_VOL_MAX;
+
+	return 0;
+}
+
+static int uniphier_aio_vol_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct uniphier_aio_chip *chip = snd_soc_component_get_drvdata(comp);
+	struct uniphier_aio_sub *sub;
+	int oport_hw = kcontrol->private_value;
+
+	sub = find_volume(chip, oport_hw);
+	if (!sub)
+		return 0;
+
+	ucontrol->value.integer.value[0] = sub->vol;
+
+	return 0;
+}
+
+static int uniphier_aio_vol_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct uniphier_aio_chip *chip = snd_soc_component_get_drvdata(comp);
+	struct uniphier_aio_sub *sub;
+	int oport_hw = kcontrol->private_value;
+
+	sub = find_volume(chip, oport_hw);
+	if (!sub)
+		return 0;
+
+	if (sub->vol == ucontrol->value.integer.value[0])
+		return 0;
+	sub->vol = ucontrol->value.integer.value[0];
+
+	aio_port_set_volume(sub, sub->vol);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new uniphier_aio_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "HPCMOUT1 Volume",
+		.info = uniphier_aio_vol_info,
+		.get = uniphier_aio_vol_get,
+		.put = uniphier_aio_vol_put,
+		.private_value = AUD_HW_HPCMOUT1,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "PCMOUT1 Volume",
+		.info = uniphier_aio_vol_info,
+		.get = uniphier_aio_vol_get,
+		.put = uniphier_aio_vol_put,
+		.private_value = AUD_HW_PCMOUT1,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "PCMOUT2 Volume",
+		.info = uniphier_aio_vol_info,
+		.get = uniphier_aio_vol_get,
+		.put = uniphier_aio_vol_put,
+		.private_value = AUD_HW_PCMOUT2,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "PCMOUT3 Volume",
+		.info = uniphier_aio_vol_info,
+		.get = uniphier_aio_vol_get,
+		.put = uniphier_aio_vol_put,
+		.private_value = AUD_HW_PCMOUT3,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "HIECOUT1 Volume",
+		.info = uniphier_aio_vol_info,
+		.get = uniphier_aio_vol_get,
+		.put = uniphier_aio_vol_put,
+		.private_value = AUD_HW_HIECOUT1,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "IECOUT1 Volume",
+		.info = uniphier_aio_vol_info,
+		.get = uniphier_aio_vol_get,
+		.put = uniphier_aio_vol_put,
+		.private_value = AUD_HW_IECOUT1,
+	},
+};
+
 static const struct snd_soc_component_driver uniphier_aio_component = {
 	.name = "uniphier-aio",
+	.controls = uniphier_aio_controls,
+	.num_controls = ARRAY_SIZE(uniphier_aio_controls),
 };
 
 int uniphier_aio_probe(struct platform_device *pdev)
diff --git a/sound/soc/uniphier/aio-reg.h b/sound/soc/uniphier/aio-reg.h
index 511ea3c01847..45fdc6ae358a 100644
--- a/sound/soc/uniphier/aio-reg.h
+++ b/sound/soc/uniphier/aio-reg.h
@@ -169,6 +169,7 @@
 #define PBINMXPAUSECTR1(n)               (0x20208 + 0x40 * (n))
 
 /* AOUT */
+#define AOUTFADECTR0                     0x40020
 #define AOUTENCTR0                       0x40040
 #define AOUTENCTR1                       0x40044
 #define AOUTENCTR2                       0x40048
@@ -179,6 +180,9 @@
 #define AOUTSRCRSTCTR1                   0x400c4
 #define AOUTSRCRSTCTR2                   0x400c8
 
+/* AOUT PCMOUT has 5 slots, slot0-3: D0-3, slot4: DMIX */
+#define OPORT_SLOT_MAX                     5
+
 /* AOUT(PCMOUTN) */
 #define OPORTMXCTR1(n)                   (0x42000 + 0x400 * (n))
 #define   OPORTMXCTR1_I2SLRSEL_MASK        (0x11 << 10)
@@ -359,11 +363,30 @@
 #define   OPORTMXMASK_XCKMSK_ON            (0x0 << 0)
 #define   OPORTMXMASK_XCKMSK_OFF           (0x7 << 0)
 #define OPORTMXDEBUG(n)                  (0x420fc + 0x400 * (n))
-#define OPORTMXT0RSTCTR(n)               (0x4211c + 0x400 * (n))
-#define OPORTMXT1RSTCTR(n)               (0x4213c + 0x400 * (n))
-#define OPORTMXT2RSTCTR(n)               (0x4215c + 0x400 * (n))
-#define OPORTMXT3RSTCTR(n)               (0x4217c + 0x400 * (n))
-#define OPORTMXT4RSTCTR(n)               (0x4219c + 0x400 * (n))
+#define OPORTMXTYVOLPARA1(n, m)          (0x42100 + 0x400 * (n) + 0x20 * (m))
+#define   OPORTMXTYVOLPARA1_SLOPEU_MASK    GENMASK(31, 16)
+#define OPORTMXTYVOLPARA2(n, m)          (0x42104 + 0x400 * (n) + 0x20 * (m))
+#define   OPORTMXTYVOLPARA2_FADE_MASK      GENMASK(17, 16)
+#define   OPORTMXTYVOLPARA2_FADE_NOOP      (0x0 << 16)
+#define   OPORTMXTYVOLPARA2_FADE_FADEOUT   (0x1 << 16)
+#define   OPORTMXTYVOLPARA2_FADE_FADEIN    (0x2 << 16)
+#define   OPORTMXTYVOLPARA2_TARGET_MASK    GENMASK(15, 0)
+#define OPORTMXTYVOLGAINSTATUS(n, m)     (0x42108 + 0x400 * (n) + 0x20 * (m))
+#define   OPORTMXTYVOLGAINSTATUS_CUR_MASK  GENMASK(15, 0)
+#define OPORTMXTYSLOTCTR(n, m)           (0x42114 + 0x400 * (n) + 0x20 * (m))
+#define   OPORTMXTYSLOTCTR_SLOTSEL_MASK    GENMASK(11, 8)
+#define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT0   (0x8 << 8)
+#define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT1   (0x9 << 8)
+#define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT2   (0xa << 8)
+#define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT3   (0xb << 8)
+#define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT4   (0xc << 8)
+#define   OPORTMXT0SLOTCTR_MUTEOFF_MASK    BIT(1)
+#define   OPORTMXT0SLOTCTR_MUTEOFF_MUTE    (0x0 << 1)
+#define   OPORTMXT0SLOTCTR_MUTEOFF_UNMUTE  (0x1 << 1)
+#define OPORTMXTYRSTCTR(n, m)            (0x4211c + 0x400 * (n) + 0x20 * (m))
+#define   OPORTMXT0RSTCTR_RST_MASK         BIT(1)
+#define   OPORTMXT0RSTCTR_RST_OFF          (0x0 << 1)
+#define   OPORTMXT0RSTCTR_RST_ON           (0x1 << 1)
 
 #define SBF_(frame, shift)    (((frame) * 2 - 1) << shift)
 
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 52670126084f..aa89c2f6fa24 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -130,6 +130,10 @@ enum IEC61937_PC {
 #define AUD_PLLDIV_1_1    2
 #define AUD_PLLDIV_2_3    3
 
+#define AUD_VOL_INIT         0x4000 /* +0dB */
+#define AUD_VOL_MAX          0xffff /* +6dB */
+#define AUD_VOL_FADE_TIME    20 /* 20ms */
+
 #define AUD_RING_SIZE            (128 * 1024)
 
 #define AUD_MIN_FRAGMENT         4
@@ -231,6 +235,7 @@ struct uniphier_aio_sub {
 	/* For PCM audio */
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_hw_params params;
+	int vol;
 
 	/* For compress audio */
 	struct snd_compr_stream *cstream;
@@ -323,6 +328,8 @@ int aio_port_set_clk(struct uniphier_aio_sub *sub);
 int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
 		       const struct snd_pcm_hw_params *params);
 void aio_port_set_enable(struct uniphier_aio_sub *sub, int enable);
+int aio_port_get_volume(struct uniphier_aio_sub *sub);
+void aio_port_set_volume(struct uniphier_aio_sub *sub, int vol);
 int aio_if_set_param(struct uniphier_aio_sub *sub, int pass_through);
 int aio_oport_set_stream_type(struct uniphier_aio_sub *sub,
 			      enum IEC61937_PC pc);
-- 
2.17.0
