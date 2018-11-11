Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616BEC04EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3053C20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3053C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeKLGas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:30:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49386 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729848AbeKLFsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0000lK-Gw; Sun, 11 Nov 2018 19:58:34 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001OQ-82; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Mark Brown" <broonie@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.324892339@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 030/366] ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

commit 5d302ed3cc80564fb835bed5fdba1e1250ecc9e5 upstream.

According to "EP93xx User’s Guide", I2STXLinCtrlData and I2SRXLinCtrlData
registers actually have different format. The only currently used bit
(Left_Right_Justify) has different position. Fix this and simplify the
whole setup taking into account the fact that both registers have zero
default value.

The practical effect of the above is repaired SND_SOC_DAIFMT_RIGHT_J
support (currently unused).

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/cirrus/ep93xx-i2s.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -51,7 +51,9 @@
 #define EP93XX_I2S_WRDLEN_24		(1 << 0)
 #define EP93XX_I2S_WRDLEN_32		(2 << 0)
 
-#define EP93XX_I2S_LINCTRLDATA_R_JUST	(1 << 2) /* Right justify */
+#define EP93XX_I2S_RXLINCTRLDATA_R_JUST	BIT(1) /* Right justify */
+
+#define EP93XX_I2S_TXLINCTRLDATA_R_JUST	BIT(2) /* Right justify */
 
 #define EP93XX_I2S_CLKCFG_LRS		(1 << 0) /* lrclk polarity */
 #define EP93XX_I2S_CLKCFG_CKP		(1 << 1) /* Bit clock polarity */
@@ -170,25 +172,25 @@ static int ep93xx_i2s_set_dai_fmt(struct
 				  unsigned int fmt)
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int clk_cfg, lin_ctrl;
+	unsigned int clk_cfg;
+	unsigned int txlin_ctrl = 0;
+	unsigned int rxlin_ctrl = 0;
 
 	clk_cfg  = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXCLKCFG);
-	lin_ctrl = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXLINCTRLDATA);
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl |= EP93XX_I2S_LINCTRLDATA_R_JUST;
+		rxlin_ctrl |= EP93XX_I2S_RXLINCTRLDATA_R_JUST;
+		txlin_ctrl |= EP93XX_I2S_TXLINCTRLDATA_R_JUST;
 		break;
 
 	default:
@@ -237,8 +239,8 @@ static int ep93xx_i2s_set_dai_fmt(struct
 	/* Write new register values */
 	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXCLKCFG, clk_cfg);
 	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCLKCFG, clk_cfg);
-	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, lin_ctrl);
-	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, lin_ctrl);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, rxlin_ctrl);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, txlin_ctrl);
 	return 0;
 }
 

