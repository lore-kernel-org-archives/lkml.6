Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3283C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98B920700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfBVJUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:20:47 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34184 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfBVJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:20:47 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 6E21D3C00C6;
        Fri, 22 Feb 2019 10:20:43 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OcSGmsKGNbGv; Fri, 22 Feb 2019 10:20:36 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A9E053C00C2;
        Fri, 22 Feb 2019 10:20:36 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 22 Feb
 2019 10:20:36 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH] ASoC: rsnd: gen: fix SSI9 4/5/6/7 busif related register address
Date:   Fri, 22 Feb 2019 10:20:26 +0100
Message-ID: <1550827226-1750-1-git-send-email-twischer@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Currently each SSI unit 's busif mode/adinr/dalign address is
registered by: (in busif4 case)
RSND_GEN_M_REG(SSI_BUSIF4_MODE, 0x500, 0x80)
RSND_GEN_M_REG(SSI_BUSIF4_ADINR,0x504, 0x80)
RSND_GEN_M_REG(SSI_BUSIF4_DALIGN, 0x508, 0x80)

But according to user manual 41.1.4 Register Configuration
ssi9 4/5/6/7 busif mode/adinr/dalign register address
( SSI9-[4/5/6/7]_BUSIF_[MODE/ADINR/DALIGN] )
are out of this rule.

This patch registers ssi9 4/5/6/7 mode/adinr/dalign register
as single register, and access these these registers in case
of SSI9 BUSIF 4/5/6/7.

Fixes: commit 8c9d75033340 ("ASoC: rsnd: ssiu: Support BUSIF other than BUSIF0")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/soc/sh/rcar/gen.c  | 24 ++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h | 27 +++++++++++++++++++++++++++
 sound/soc/sh/rcar/ssiu.c | 36 ++++++++++++++++--------------------
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 7cda601..af19010 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -255,6 +255,30 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SSI_MODE,		0xc,	0x80),
 		RSND_GEN_M_REG(SSI_CTRL,		0x10,	0x80),
 		RSND_GEN_M_REG(SSI_INT_ENABLE,		0x18,	0x80),
+		RSND_GEN_S_REG(SSI9_BUSIF0_MODE,	0x48c),
+		RSND_GEN_S_REG(SSI9_BUSIF0_ADINR,	0x484),
+		RSND_GEN_S_REG(SSI9_BUSIF0_DALIGN,	0x488),
+		RSND_GEN_S_REG(SSI9_BUSIF1_MODE,	0x4a0),
+		RSND_GEN_S_REG(SSI9_BUSIF1_ADINR,	0x4a4),
+		RSND_GEN_S_REG(SSI9_BUSIF1_DALIGN,	0x4a8),
+		RSND_GEN_S_REG(SSI9_BUSIF2_MODE,	0x4c0),
+		RSND_GEN_S_REG(SSI9_BUSIF2_ADINR,	0x4c4),
+		RSND_GEN_S_REG(SSI9_BUSIF2_DALIGN,	0x4c8),
+		RSND_GEN_S_REG(SSI9_BUSIF3_MODE,	0x4e0),
+		RSND_GEN_S_REG(SSI9_BUSIF3_ADINR,	0x4e4),
+		RSND_GEN_S_REG(SSI9_BUSIF3_DALIGN,	0x4e8),
+		RSND_GEN_S_REG(SSI9_BUSIF4_MODE,	0xd80),
+		RSND_GEN_S_REG(SSI9_BUSIF4_ADINR,	0xd84),
+		RSND_GEN_S_REG(SSI9_BUSIF4_DALIGN,	0xd88),
+		RSND_GEN_S_REG(SSI9_BUSIF5_MODE,	0xda0),
+		RSND_GEN_S_REG(SSI9_BUSIF5_ADINR,	0xda4),
+		RSND_GEN_S_REG(SSI9_BUSIF5_DALIGN,	0xda8),
+		RSND_GEN_S_REG(SSI9_BUSIF6_MODE,	0xdc0),
+		RSND_GEN_S_REG(SSI9_BUSIF6_ADINR,	0xdc4),
+		RSND_GEN_S_REG(SSI9_BUSIF6_DALIGN,	0xdc8),
+		RSND_GEN_S_REG(SSI9_BUSIF7_MODE,	0xde0),
+		RSND_GEN_S_REG(SSI9_BUSIF7_ADINR,	0xde4),
+		RSND_GEN_S_REG(SSI9_BUSIF7_DALIGN,	0xde8),
 	};
 
 	static const struct rsnd_regmap_field_conf conf_scu[] = {
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 605e4b9..90625c5 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -191,6 +191,30 @@ enum rsnd_reg {
 	SSI_SYS_STATUS7,
 	HDMI0_SEL,
 	HDMI1_SEL,
+	SSI9_BUSIF0_MODE,
+	SSI9_BUSIF1_MODE,
+	SSI9_BUSIF2_MODE,
+	SSI9_BUSIF3_MODE,
+	SSI9_BUSIF4_MODE,
+	SSI9_BUSIF5_MODE,
+	SSI9_BUSIF6_MODE,
+	SSI9_BUSIF7_MODE,
+	SSI9_BUSIF0_ADINR,
+	SSI9_BUSIF1_ADINR,
+	SSI9_BUSIF2_ADINR,
+	SSI9_BUSIF3_ADINR,
+	SSI9_BUSIF4_ADINR,
+	SSI9_BUSIF5_ADINR,
+	SSI9_BUSIF6_ADINR,
+	SSI9_BUSIF7_ADINR,
+	SSI9_BUSIF0_DALIGN,
+	SSI9_BUSIF1_DALIGN,
+	SSI9_BUSIF2_DALIGN,
+	SSI9_BUSIF3_DALIGN,
+	SSI9_BUSIF4_DALIGN,
+	SSI9_BUSIF5_DALIGN,
+	SSI9_BUSIF6_DALIGN,
+	SSI9_BUSIF7_DALIGN,
 
 	/* SSI */
 	SSICR,
@@ -209,6 +233,9 @@ enum rsnd_reg {
 #define SSI_BUSIF_MODE(i)	(SSI_BUSIF0_MODE + (i))
 #define SSI_BUSIF_ADINR(i)	(SSI_BUSIF0_ADINR + (i))
 #define SSI_BUSIF_DALIGN(i)	(SSI_BUSIF0_DALIGN + (i))
+#define SSI9_BUSIF_MODE(i)	(SSI9_BUSIF0_MODE + (i))
+#define SSI9_BUSIF_ADINR(i)	(SSI9_BUSIF0_ADINR + (i))
+#define SSI9_BUSIF_DALIGN(i)	(SSI9_BUSIF0_DALIGN + (i))
 #define SSI_SYS_STATUS(i)	(SSI_SYS_STATUS0 + (i))
 
 
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index c74991d..c036654 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -181,29 +181,25 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (rsnd_ssi_use_busif(io)) {
 		int id = rsnd_mod_id(mod);
 		int busif = rsnd_mod_id_sub(mod);
+		int chnl = rsnd_io_is_play(io) ?
+				rsnd_runtime_channel_after_ctu(io) :
+				rsnd_runtime_channel_original(io);
 
-		/*
-		 * FIXME
-		 *
-		 * We can't support SSI9-4/5/6/7, because its address is
-		 * out of calculation rule
-		 */
 		if ((id == 9) && (busif >= 4)) {
-			struct device *dev = rsnd_priv_to_dev(priv);
-
-			dev_err(dev, "This driver doesn't support SSI%d-%d, so far",
-				id, busif);
+			rsnd_mod_write(mod, SSI9_BUSIF_ADINR(busif),
+				       rsnd_get_adinr_bit(mod, io) | chnl);
+			rsnd_mod_write(mod, SSI9_BUSIF_MODE(busif),
+				       rsnd_get_busif_shift(io, mod) | 1);
+			rsnd_mod_write(mod, SSI9_BUSIF_DALIGN(busif),
+				       rsnd_get_dalign(mod, io));
+		} else {
+			rsnd_mod_write(mod, SSI_BUSIF_ADINR(busif),
+				       rsnd_get_adinr_bit(mod, io) | chnl);
+			rsnd_mod_write(mod, SSI_BUSIF_MODE(busif),
+				       rsnd_get_busif_shift(io, mod) | 1);
+			rsnd_mod_write(mod, SSI_BUSIF_DALIGN(busif),
+				       rsnd_get_dalign(mod, io));
 		}
-
-		rsnd_mod_write(mod, SSI_BUSIF_ADINR(busif),
-			       rsnd_get_adinr_bit(mod, io) |
-			       (rsnd_io_is_play(io) ?
-				rsnd_runtime_channel_after_ctu(io) :
-				rsnd_runtime_channel_original(io)));
-		rsnd_mod_write(mod, SSI_BUSIF_MODE(busif),
-			       rsnd_get_busif_shift(io, mod) | 1);
-		rsnd_mod_write(mod, SSI_BUSIF_DALIGN(busif),
-			       rsnd_get_dalign(mod, io));
 	}
 
 	if (has_hdmi0 || has_hdmi1) {
-- 
2.7.4

