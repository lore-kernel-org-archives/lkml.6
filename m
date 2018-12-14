Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD54C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43355208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790847;
	bh=HTlKL/VmjP7yJYYvsMnPaUxdkOfNU2kC9Pa8PLhiHac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lz0s1WcvkZBf+Xp6VXMGTkNL5QgG72bEVQX8Ufqcmj6PrdPHOem9Ey8HI74/TxHDv
	 Jml8DKj5PxbV+PiruTo1oSaMR08pbMZ4yMEA9xs9nw4MOp8SItARIwMJIuEqvCQ1Em
	 Mw8/hiF0emTXBM46xAa1EIaRrO9rHm2sQdCjj0gU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43355208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbeLNMeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbeLNMIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C8321486;
        Fri, 14 Dec 2018 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789289;
        bh=HTlKL/VmjP7yJYYvsMnPaUxdkOfNU2kC9Pa8PLhiHac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4PMohSR/yfri9su/YJzwsv3BZVpzg9v3ovsg7CRg2bPZ97lekDbM3+U/3FdAOwgY
         HwtXjc7wIFh+Sp+k5MDWkPXBdPU6eH2ugJU2SWPUVE1o8SpNy1Q3Rx5EnQSUBc787n
         +LQJHg70Rtl0WB5vmClMXGhsX2JsHBOXU/IXCfYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/89] ASoC: wm_adsp: Fix dma-unsafe read of scratch registers
Date:   Fri, 14 Dec 2018 12:59:38 +0100
Message-Id: <20181214115730.922488187@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 989d093abda7..67330b6ab204 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -787,38 +787,41 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 
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



