Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCECC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196A208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790695;
	bh=N6xNbPJkHGiE+BXDBvqhihdOFrAA4H76g/r9l4KMMCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZwMr0SayiaQd/uuB1cb9mwi+XUtUg4752xfCvMLCZjg7GbRws+Amv49bYzJaM9aY
	 zFPrNVzlnmoxo3vcQSZg3F9jqWdLjcEjSw3lze7++BeA97CjTMVC/KFGY34Rx4LlMz
	 goteefUkow009Et6vQhcWuZNOsHJOCnpQI29efzA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbeLNMbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730321AbeLNMJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55C5214AE;
        Fri, 14 Dec 2018 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789377;
        bh=N6xNbPJkHGiE+BXDBvqhihdOFrAA4H76g/r9l4KMMCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpNTEn/sQxODp1Ke1Nkhjy9mRaDGs61r8G/+Q84qvanMeFlzm3qgw1i4GOMCWeXX+
         0CVvpxLFtPzyhOOOk3/yTnBCrlKCqCF8shxR0tPOTRuohl+GqHFl8RcNYkWcTlRXVo
         vG0MUlOblv0SDAkHrKyg5vsCro1Mpw8FZ5tW/TJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 41/89] ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
Date:   Fri, 14 Dec 2018 12:59:54 +0100
Message-Id: <20181214115731.705664076@linuxfoundation.org>
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
index 6b40bdbef336..47c2ed5ca492 100644
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



