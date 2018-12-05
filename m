Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8513FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B21920878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXrE80LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B21920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeLEJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEJgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:44 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1441E20850;
        Wed,  5 Dec 2018 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002603;
        bh=fCA4+t78wqOCQ3rhe25pnwRHbrwCPyOGQ3vmJuL6lzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXrE80LXEj9t7wtnT7ra2BeD4pZ7ULkSrgEV+CuBwlkNPJoOJHznyOhgXS3pWcVTn
         +GSJbaDl4a+GxHqCKNiqv9RhDMEofjgREW6QtxXYFsHuNFAvm09sPrIJ5ROL//1Q1D
         XPEu4Ak5+sZL+KxwNpVJSMM8mPrNbFx//EkcJqOA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 014/123] ASoC: sun8i-codec: fix crash on module removal
Date:   Wed,  5 Dec 2018 04:34:06 -0500
Message-Id: <20181205093555.5386-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

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
2.17.1

