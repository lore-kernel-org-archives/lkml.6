Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B10208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791389;
	bh=Ghq8b6xlWC3YQ7cMoSOayWPI1mHvjcB4xFWISwED8ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zMlZVxwI3nthuqtu1WYSzEG/GvA2/PJLF4krRQ8iMrGKGFJAu+az0SaB2uCQXwSfH
	 NHkPVwadEKIfbWULtJVmvV0ZdgJIjxAMM6jTDIOZdggMMGn4gdQIvXn7JvTjBmnYLi
	 pKELxDWbFF/VzofvOKA0itY3oXgXHUApqg3yoM4o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B10208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbeLNMC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbeLNMCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6528C2146F;
        Fri, 14 Dec 2018 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788942;
        bh=Ghq8b6xlWC3YQ7cMoSOayWPI1mHvjcB4xFWISwED8ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8xA+YEATRRKRd9ancLODqsfBpQPEoSg/SVpyQBvjcFO/5ynUORVTaMkbeuTRJksv
         EUsuBXJYSAe6QM7+5j+dhVvN+sJP3qWSYNh9b2EyPiu6ECu1crtcSLpEN3aT/89YzS
         x1UILIcaft1HtnyYoCagukidK4XbUWkSBGoAmqyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/142] ASoC: sun8i-codec: fix crash on module removal
Date:   Fri, 14 Dec 2018 12:58:38 +0100
Message-Id: <20181214115748.375536656@linuxfoundation.org>
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

[ Upstream commit 278df5e5527b633f4882f1680ad58b62a7c07bfe ]

drvdata is actually sun8i_codec, not snd_soc_card, so it crashes
when calling snd_soc_card_get_drvdata().

Drop card and scodec vars anyway since we don't need to
disable/unprepare clocks - it's already done by calling
runtime_suspend()

Drop clk_disable_unprepare() calls for the same reason.

Fixes: 36c684936fae7 ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index fb37dd927e33..bf615fa16dc8 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -589,16 +589,10 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 
 static int sun8i_codec_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct sun8i_codec *scodec = snd_soc_card_get_drvdata(card);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun8i_codec_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(scodec->clk_module);
-	clk_disable_unprepare(scodec->clk_bus);
-
 	return 0;
 }
 
-- 
2.19.1



