Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAB0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218152064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqX4u16o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218152064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbeJEX0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbeJEXOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C31821477;
        Fri,  5 Oct 2018 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756078;
        bh=7VzB2tM95rDS2xKkK198W+zlgfIGvpkmPFJYQq1fXpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqX4u16oAU/iclKd1AA90OLt/flbj6d6Sfxe3U5Pk8/mf55+eI/BJ6TO18gv0A+ee
         /O3eiy/L9Mf2Fw0w3Ei/X2ThPuoZ3EkHZGMeYWM20Kp4AU+nDg6laONW5Q75lhTpve
         QrwPUq3w6MBJ4xWrKHbGbses+a85D6a0nLhWz8/c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 14/48] ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER
Date:   Fri,  5 Oct 2018 12:13:50 -0400
Message-Id: <20181005161424.20521-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 6c92d5a2744e27619a8fcc9d74b91ee9f1cdebd1 ]

Current rsnd driver will fallback to PIO mode if it can't get DMA
handler. But, DMA might return -EPROBE_DEFER when probe timing.
This driver always fallback to PIO mode especially from
commit ac6bbf0cdf4206c ("iommu: Remove IOMMU_OF_DECLARE") because
of this reason.

The DMA driver will be probed later, but sound driver might be
probed as PIO mode in such case. This patch fixup this issue.
Then, -EPROBE_DEFER is not error. Thus, let's don't indicate error
message in such case.
And it needs to call rsnd_adg_remove() individually if probe failed,
because it registers clk which should be unregister.

Maybe PIO fallback feature itself is not needed,
but let's keep it so far.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/sh/rcar/core.c | 10 +++++++++-
 sound/soc/sh/rcar/dma.c  |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index ff13189a7ee4..982a72e73ea9 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -482,7 +482,7 @@ static int rsnd_status_update(u32 *status,
 			(func_call && (mod)->ops->fn) ? #fn : "");	\
 		if (func_call && (mod)->ops->fn)			\
 			tmp = (mod)->ops->fn(mod, io, param);		\
-		if (tmp)						\
+		if (tmp && (tmp != -EPROBE_DEFER))			\
 			dev_err(dev, "%s[%d] : %s error %d\n",		\
 				rsnd_mod_name(mod), rsnd_mod_id(mod),	\
 						     #fn, tmp);		\
@@ -1550,6 +1550,14 @@ static int rsnd_probe(struct platform_device *pdev)
 		rsnd_dai_call(remove, &rdai->capture, priv);
 	}
 
+	/*
+	 * adg is very special mod which can't use rsnd_dai_call(remove),
+	 * and it registers ADG clock on probe.
+	 * It should be unregister if probe failed.
+	 * Mainly it is assuming -EPROBE_DEFER case
+	 */
+	rsnd_adg_remove(priv);
+
 	return ret;
 }
 
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index ef82b94d038b..2f3f4108fda5 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -244,6 +244,10 @@ static int rsnd_dmaen_attach(struct rsnd_dai_stream *io,
 	/* try to get DMAEngine channel */
 	chan = rsnd_dmaen_request_channel(io, mod_from, mod_to);
 	if (IS_ERR_OR_NULL(chan)) {
+		/* Let's follow when -EPROBE_DEFER case */
+		if (PTR_ERR(chan) == -EPROBE_DEFER)
+			return PTR_ERR(chan);
+
 		/*
 		 * DMA failed. try to PIO mode
 		 * see
-- 
2.17.1

