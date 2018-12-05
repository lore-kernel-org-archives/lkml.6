Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED863C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0984213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDJUPMcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0984213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeLEJtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbeLEJtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:49:53 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FD2213A2;
        Wed,  5 Dec 2018 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003392;
        bh=AIYCJcFrBGFFi5kLaFV+FKNx8eKjqz68akWmt1JUeeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDJUPMcZfZV4NMEwKUgy+JSZYSLfr7NhQVE8gbSJKqgOqTyVosnDjQiebJRjtpFE+
         bpZ1a8HYcR6TwAOXusVcNvxq3cGyt5cTUusIgqhMBYl0gy4iLcu3fzZYzJ2qJ2iSVQ
         JqRbL0mjesd/rHMo+w1826uf69BUPSUs5IqtQKxU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 18/45] ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE
Date:   Wed,  5 Dec 2018 04:46:39 -0500
Message-Id: <20181205094706.7225-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

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
2.17.1

