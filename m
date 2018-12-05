Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB71214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3uWyqyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB71214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeLEKJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbeLEJjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:22 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CBC2084C;
        Wed,  5 Dec 2018 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002761;
        bh=iJ0QUcNc8sooKP1qf8ciQ8Ee88g9vq9YGY+eczv6zAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3uWyqyCvgPoAgomOML9fQGBTx2qxlxFvdb+4hsoc2//5d67lj4CbRnwL5t08AyDO
         CVL8WL1TGWKClKc1Ig+jpFwNReyANF97rO6UYYKscX1HLRHuKNa9O2Sbc8Vzi+6EBB
         1QshNo8uOjv9BF3AN/uIXVEKtJyJzfNUQ7xnGcuc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 060/123] ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
Date:   Wed,  5 Dec 2018 04:34:52 -0500
Message-Id: <20181205093555.5386-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

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
2.17.1

