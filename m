Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE39C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71FA2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789065;
	bh=mPNew83he/VHo8LDupx7cG26CXoN/BhuAM7dQcgU4xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NzEGAVL8+tkSNLGMvq4kwPRgmAXnPSuhyTLHB6mFleQKxVK3I9zgniSV2zZGTQvEf
	 0Cb3mXtb/XQfZDzLJh9e06bcVZQ9baC3vmvoCnnw0bHKVWIrKugEmh3LtbPKY9nSyY
	 X/kAQ908MnOtYZF7WPXTl6XzFalgCl/GUkGi+hsI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71FA2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeLNMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbeLNMEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EF302145D;
        Fri, 14 Dec 2018 12:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789060;
        bh=mPNew83he/VHo8LDupx7cG26CXoN/BhuAM7dQcgU4xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4pIBzPxGx5iSAzlr+SsZE+YhZI8JwIzgSRgr7nSS7np7B9pdE2PSjuYSu0Q1jgq6
         DcU/D1tNUZZq+s39z3C9L25RYQWnQ7opMkdvDDJ/k7izWOYuGAyklbPeNXXx2Wv6Sw
         xCNtggFUUjaHGUWnuFsEL3HNbarI7HQJd/64QwYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/142] ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE
Date:   Fri, 14 Dec 2018 12:59:24 +0100
Message-Id: <20181214115750.227346629@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index fe966272bd0c..cba9645b6487 100644
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
 
@@ -228,6 +232,8 @@ static int omap_dmic_dai_hw_params(struct snd_pcm_substream *substream,
 	/* packet size is threshold * channels */
 	dma_data = snd_soc_dai_get_dma_data(dai, substream);
 	dma_data->maxburst = dmic->threshold * channels;
+	dmic->latency = (OMAP_DMIC_THRES_MAX - dmic->threshold) * USEC_PER_SEC /
+			params_rate(params);
 
 	return 0;
 }
@@ -238,6 +244,9 @@ static int omap_dmic_dai_prepare(struct snd_pcm_substream *substream,
 	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
 	u32 ctrl;
 
+	if (pm_qos_request_active(&dmic->pm_qos_req))
+		pm_qos_update_request(&dmic->pm_qos_req, dmic->latency);
+
 	/* Configure uplink threshold */
 	omap_dmic_write(dmic, OMAP_DMIC_FIFO_CTRL_REG, dmic->threshold);
 
-- 
2.19.1



