Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3753BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3FA223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vsrNAnJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3FA223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeKNE1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:27:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33440 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKNE1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6j/hBfulpabeWbzrEHZUNfsZyjxTAMwDhWDM/y0TrDw=; b=vsrNAnJnPZVW
        HdBco2qm8CC3GuxcWqoV4h4mBt3nesyawGPmBr0NFGxKAj7nnCyTPl8aVLNLh3Em5GN33w8KHIETh
        Wr0BAqRZd+UF4And3aczZZ7SwoVh4v2EPa5Yk9i5k7m3DxPhoocvnQURQsJMpBCzoYaQ8XQcXpzn8
        lwdY0=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMdQ8-0002Nv-T3; Tue, 13 Nov 2018 18:28:17 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id ED4F5440078; Tue, 13 Nov 2018 18:28:10 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm_adsp: Fix dma-unsafe read of scratch registers" to the asoc tree
In-Reply-To:  <20181112133639.13444-1-rf@opensource.cirrus.com>
Message-Id: <20181113182810.ED4F5440078@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 18:28:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm_adsp: Fix dma-unsafe read of scratch registers

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

From 20e00db2f59bdddf8a8e241473ef8be94631d3ae Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Mon, 12 Nov 2018 13:36:38 +0000
Subject: [PATCH] ASoC: wm_adsp: Fix dma-unsafe read of scratch registers

Stack memory isn't DMA-safe so it isn't safe to use either
regmap_raw_read or regmap_bulk_read to read into stack memory.

The two functions to read the scratch registers were using
stack memory and regmap_raw_read. It's not worth allocating
memory just for this trivial read, and it isn't time-critical.
A simple regmap_read for each register is sufficient.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a53dc174bbf0..66501b8dc46f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -765,38 +765,41 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 
 static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
 {
-	u16 scratch[4];
+	unsigned int scratch[4];
+	unsigned int addr = dsp->base + ADSP2_SCRATCH0;
+	unsigned int i;
 	int ret;
 
-	ret = regmap_raw_read(dsp->regmap, dsp->base + ADSP2_SCRATCH0,
-				scratch, sizeof(scratch));
-	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH regs: %d\n", ret);
-		return;
+	for (i = 0; i < ARRAY_SIZE(scratch); ++i) {
+		ret = regmap_read(dsp->regmap, addr + i, &scratch[i]);
+		if (ret) {
+			adsp_err(dsp, "Failed to read SCRATCH%u: %d\n", i, ret);
+			return;
+		}
 	}
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
-		 be16_to_cpu(scratch[0]),
-		 be16_to_cpu(scratch[1]),
-		 be16_to_cpu(scratch[2]),
-		 be16_to_cpu(scratch[3]));
+		 scratch[0], scratch[1], scratch[2], scratch[3]);
 }
 
 static void wm_adsp2v2_show_fw_status(struct wm_adsp *dsp)
 {
-	u32 scratch[2];
+	unsigned int scratch[2];
 	int ret;
 
-	ret = regmap_raw_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH0_1,
-			      scratch, sizeof(scratch));
-
+	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH0_1,
+			  &scratch[0]);
 	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH regs: %d\n", ret);
+		adsp_err(dsp, "Failed to read SCRATCH0_1: %d\n", ret);
 		return;
 	}
 
-	scratch[0] = be32_to_cpu(scratch[0]);
-	scratch[1] = be32_to_cpu(scratch[1]);
+	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH2_3,
+			  &scratch[1]);
+	if (ret) {
+		adsp_err(dsp, "Failed to read SCRATCH2_3: %d\n", ret);
+		return;
+	}
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
 		 scratch[0] & 0xFFFF,
-- 
2.19.1

