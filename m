Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E841C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0614B20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791220;
	bh=RZnFNtdNTeexfCxuachR9pmsCk7+cs89Psly2Xirs+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L0zFapg+We9iUGCV9xnWCG6frqdFRF9ZVPwskAym6FxhBnAhRnsw9hiNSEGba/VVU
	 KW8fEQ0Ekms93G//5DfrjQKOgkjEyUIGX8wKI4WKhrzUp9fWdwSfWj8P0p0ashlmzr
	 IJlUVPhg6XaNc8B1awgqAY5Hf4NFCqV/8bbAYjsA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0614B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeLNMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbeLNMEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822262146F;
        Fri, 14 Dec 2018 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789055;
        bh=RZnFNtdNTeexfCxuachR9pmsCk7+cs89Psly2Xirs+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AyNd8zkHmJQnkkJtVKes/Hzix43M5cnVjbUAnXmqc/FjURv3l6BaOcNqznSnjaCT
         nvmYX5jWiYzsZczlR+xa28QuOziBTfKXmRz6rQ3iBJav7l7wGAWWl+E6NJKeR2yj1H
         C5PqC+evw9isDFkqSceZ8dsYhIPa4qn9P9LxAHYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/142] ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
Date:   Fri, 14 Dec 2018 12:59:22 +0100
Message-Id: <20181214115750.145092847@linuxfoundation.org>
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

[ Upstream commit dd2f52d8991af9fe0928d59ec502ba52be7bc38d ]

The latency number is in usec for the pm_qos. Correct the calculation to
give us the time in usec

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/omap/omap-mcbsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d0ebb6b9bfac..2d6decbfc99e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -308,9 +308,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 			pkt_size = channels;
 		}
 
-		latency = ((((buffer_size - pkt_size) / channels) * 1000)
-				 / (params->rate_num / params->rate_den));
-
+		latency = (buffer_size - pkt_size) / channels;
+		latency = latency * USEC_PER_SEC /
+			  (params->rate_num / params->rate_den);
 		mcbsp->latency[substream->stream] = latency;
 
 		omap_mcbsp_set_threshold(substream, pkt_size);
-- 
2.19.1



