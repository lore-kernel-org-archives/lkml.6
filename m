Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62628C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BE220891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BE220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbeG0D5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:57:13 -0400
Received: from mx.socionext.com ([202.248.49.38]:23194 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbeG0D5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:57:12 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Jul 2018 11:37:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 4641560034;
        Fri, 27 Jul 2018 11:37:35 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 27 Jul 2018 11:37:35 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 1354740176;
        Fri, 27 Jul 2018 11:37:35 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E1B36120448;
        Fri, 27 Jul 2018 11:37:34 +0900 (JST)
From:   Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: add support for multichannel output
Date:   Fri, 27 Jul 2018 11:37:28 +0900
Message-Id: <20180727023728.7810-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds multichannel PCM output support for LD11/LD20.
Currently driver tested and supported only 2ch, 6ch, and 8ch.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/aio-core.c | 78 ++++++++++++++++++++++++++++++++---
 sound/soc/uniphier/aio-ld11.c |  2 +-
 sound/soc/uniphier/aio-reg.h  |  1 +
 sound/soc/uniphier/aio.h      |  3 ++
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 638cb3fc5f7b..8b09bbb0f8d0 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -264,6 +264,57 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
 	}
 }
 
+/**
+ * aio_port_set_ch - set channels of LPCM
+ * @sub: the AIO substream pointer, PCM substream only
+ * @ch : count of channels
+ *
+ * Set suitable slot selecting to input/output port block of AIO.
+ *
+ * This function may return error if non-PCM substream.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+static int aio_port_set_ch(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 slotsel_2ch[] = {
+		0, 0, 0, 0, 0,
+	};
+	u32 slotsel_multi[] = {
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT0,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT1,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT2,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT3,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT4,
+	};
+	u32 mode, *slotsel;
+	int i;
+
+	switch (params_channels(&sub->params)) {
+	case 8:
+	case 6:
+		mode = OPORTMXTYSLOTCTR_MODE;
+		slotsel = slotsel_multi;
+		break;
+	case 2:
+		mode = 0;
+		slotsel = slotsel_2ch;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < AUD_MAX_SLOTSEL; i++) {
+		regmap_update_bits(r, OPORTMXTYSLOTCTR(sub->swm->oport.map, i),
+				   OPORTMXTYSLOTCTR_MODE, mode);
+		regmap_update_bits(r, OPORTMXTYSLOTCTR(sub->swm->oport.map, i),
+				   OPORTMXTYSLOTCTR_SLOTSEL_MASK, slotsel[i]);
+	}
+
+	return 0;
+}
+
 /**
  * aio_port_set_rate - set sampling rate of LPCM
  * @sub: the AIO substream pointer, PCM substream only
@@ -575,6 +626,10 @@ int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
 			rate = params_rate(params);
 		}
 
+		ret = aio_port_set_ch(sub);
+		if (ret)
+			return ret;
+
 		ret = aio_port_set_rate(sub, rate);
 		if (ret)
 			return ret;
@@ -731,15 +786,28 @@ void aio_port_set_volume(struct uniphier_aio_sub *sub, int vol)
 int aio_if_set_param(struct uniphier_aio_sub *sub, int pass_through)
 {
 	struct regmap *r = sub->aio->chip->regmap;
-	u32 v;
+	u32 memfmt, v;
 
 	if (sub->swm->dir == PORT_DIR_OUTPUT) {
-		if (pass_through)
+		if (pass_through) {
 			v = PBOUTMXCTR0_ENDIAN_0123 |
 				PBOUTMXCTR0_MEMFMT_STREAM;
-		else
-			v = PBOUTMXCTR0_ENDIAN_3210 |
-				PBOUTMXCTR0_MEMFMT_2CH;
+		} else {
+			switch (params_channels(&sub->params)) {
+			case 2:
+				memfmt = PBOUTMXCTR0_MEMFMT_2CH;
+				break;
+			case 6:
+				memfmt = PBOUTMXCTR0_MEMFMT_6CH;
+				break;
+			case 8:
+				memfmt = PBOUTMXCTR0_MEMFMT_8CH;
+				break;
+			default:
+				return -EINVAL;
+			}
+			v = PBOUTMXCTR0_ENDIAN_3210 | memfmt;
+		}
 
 		regmap_write(r, PBOUTMXCTR0(sub->swm->oif.map), v);
 		regmap_write(r, PBOUTMXCTR1(sub->swm->oif.map), 0);
diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index ab04d3331be9..de962df245ba 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -286,7 +286,7 @@ static struct snd_soc_dai_driver uniphier_aio_dai_ld11[] = {
 			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
 			.rates       = SNDRV_PCM_RATE_48000,
 			.channels_min = 2,
-			.channels_max = 2,
+			.channels_max = 8,
 		},
 		.ops = &uniphier_aio_i2s_ops,
 	},
diff --git a/sound/soc/uniphier/aio-reg.h b/sound/soc/uniphier/aio-reg.h
index 45fdc6ae358a..734395dbcffb 100644
--- a/sound/soc/uniphier/aio-reg.h
+++ b/sound/soc/uniphier/aio-reg.h
@@ -374,6 +374,7 @@
 #define OPORTMXTYVOLGAINSTATUS(n, m)     (0x42108 + 0x400 * (n) + 0x20 * (m))
 #define   OPORTMXTYVOLGAINSTATUS_CUR_MASK  GENMASK(15, 0)
 #define OPORTMXTYSLOTCTR(n, m)           (0x42114 + 0x400 * (n) + 0x20 * (m))
+#define   OPORTMXTYSLOTCTR_MODE            BIT(15)
 #define   OPORTMXTYSLOTCTR_SLOTSEL_MASK    GENMASK(11, 8)
 #define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT0   (0x8 << 8)
 #define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT1   (0x9 << 8)
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index aa89c2f6fa24..23a5c3c68658 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -141,6 +141,9 @@ enum IEC61937_PC {
 #define AUD_MIN_FRAGMENT_SIZE    (4 * 1024)
 #define AUD_MAX_FRAGMENT_SIZE    (16 * 1024)
 
+/* max 5 slots, 10 channels, 2 channel in 1 slot */
+#define AUD_MAX_SLOTSEL    5
+
 /*
  * This is a selector for virtual register map of AIO.
  *
-- 
2.18.0

