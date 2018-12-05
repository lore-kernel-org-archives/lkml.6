Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A884CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD93208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4twbLvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD93208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeLEJhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbeLEJhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:37:39 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F0720878;
        Wed,  5 Dec 2018 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002659;
        bh=sj83SshNRjrhKtw/4YBVXsu3ASwQ+06t8BEDt3FcX4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4twbLvYf/HKLT6M1fLWO5HzvRIUqgqwh6Vkqj18tgfRfAXa57goO4XgvK6xuSK5g
         SfK8y2wvzMUKusRugJztUDh4BMzU/mVkAlcPuRwY8MIGPOV1JtwPZ39LeDuT6VvZt3
         u+0sJLXHIMSHZEiP88nc8DZAB74DzBplf1rAGpUo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.19 030/123] ASoC: wm_adsp: Fix dma-unsafe read of scratch registers
Date:   Wed,  5 Dec 2018 04:34:22 -0500
Message-Id: <20181205093555.5386-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 20e00db2f59bdddf8a8e241473ef8be94631d3ae ]

Stack memory isn't DMA-safe so it isn't safe to use either
regmap_raw_read or regmap_bulk_read to read into stack memory.

The two functions to read the scratch registers were using
stack memory and regmap_raw_read. It's not worth allocating
memory just for this trivial read, and it isn't time-critical.
A simple regmap_read for each register is sufficient.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f61656070225..4d3ec295679d 100644
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
2.17.1

