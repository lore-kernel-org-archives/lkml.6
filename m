Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A7C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7318214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789528;
	bh=snNygx0yQ4b/98PL0fu68+xXvJMYFsJg/QzyRsnBhSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ECNqb6cwNwzg7+S5zCvGS8JO9UXlHlJDhG2YDVPwrlq3+aQ66pVuiD4CDfReg+CrM
	 yceKtQkkQUpk3TzEgtA8vMnRENlY0v7kRZ0DX39CKy4TZH9Vmtu+YcmdmQKPUYZcNr
	 4MNcvB13nEyNDsllEtyNiEkl/8NTF+7cXviKGkQM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7318214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbeLNMMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731873AbeLNMMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A579F21473;
        Fri, 14 Dec 2018 12:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789523;
        bh=snNygx0yQ4b/98PL0fu68+xXvJMYFsJg/QzyRsnBhSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9oerIbPSQStfDD4bb71gmCY+FT7KbY1mR4YbBGn+Eny2k6chSZ8MifNHt+NZx5C9
         sX+V4xFn/t+LpcaeyfIeSuJVDAvO3oJCiLjgUUV9jKaKyOocwRowghqDshE47geRFa
         ifolYZEYoC5GNgnRBPDwvZidF8Nxn1WtEk5U0Rsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/51] ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE
Date:   Fri, 14 Dec 2018 13:00:28 +0100
Message-Id: <20181214115715.721357954@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ffdcc3638c58d55a6fa68b6e5dfd4fb4109652eb ]

We need to block sleep states which would require longer time to leave than
the time the DMA must react to the DMA request in order to keep the FIFO
serviced without overrun.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/omap/omap-dmic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 09db2aec12a3..776e809a8aab 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -48,6 +48,8 @@ struct omap_dmic {
 	struct device *dev;
 	void __iomem *io_base;
 	struct clk *fclk;
+	struct pm_qos_request pm_qos_req;
+	int latency;
 	int fclk_freq;
 	int out_freq;
 	int clk_div;
@@ -124,6 +126,8 @@ static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 
 	mutex_lock(&dmic->mutex);
 
+	pm_qos_remove_request(&dmic->pm_qos_req);
+
 	if (!dai->active)
 		dmic->active = 0;
 
@@ -226,6 +230,8 @@ static int omap_dmic_dai_hw_params(struct snd_pcm_substream *substream,
 	/* packet size is threshold * channels */
 	dma_data = snd_soc_dai_get_dma_data(dai, substream);
 	dma_data->maxburst = dmic->threshold * channels;
+	dmic->latency = (OMAP_DMIC_THRES_MAX - dmic->threshold) * USEC_PER_SEC /
+			params_rate(params);
 
 	return 0;
 }
@@ -236,6 +242,9 @@ static int omap_dmic_dai_prepare(struct snd_pcm_substream *substream,
 	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
 	u32 ctrl;
 
+	if (pm_qos_request_active(&dmic->pm_qos_req))
+		pm_qos_update_request(&dmic->pm_qos_req, dmic->latency);
+
 	/* Configure uplink threshold */
 	omap_dmic_write(dmic, OMAP_DMIC_FIFO_CTRL_REG, dmic->threshold);
 
-- 
2.19.1



