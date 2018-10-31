Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C8ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4111420664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="huMKa5Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4111420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeKAIHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbeKAIHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4290220847;
        Wed, 31 Oct 2018 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027260;
        bh=tcoRiYmjAZfeRl0GAiTVtRoXj59w79nkV7wvusDboCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huMKa5Da0rzk/j5vFAR8/7t5IepF94SQ6WBZxgyyHIKBKS57a8RwSNILZEqJKIPJz
         m0CKGRlKSijZ6RlyUm/c1JkrozrpcFtM23AIyFqNykN5tJl4LlVcyhpHO8zqS0RM3N
         Gs9h2kpJPZsMbSkYOhNyyt1faIhtOFSkwCu8vmgg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 132/146] ASoC: AMD: Fix capture unstable in beginning for some runs
Date:   Wed, 31 Oct 2018 19:05:27 -0400
Message-Id: <20181031230541.28822-132-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

[ Upstream commit c50535ed6a10fcae1b64ae83c0f6b1eeb5535afc ]

alsa_conformance_test -C hw:0,4 -p 1024 --debug
would sometime show:
TIME_DIFF(s)    HW_LEVEL       READ              RATE
0.000095970         1024       1024    10670001.041992
0.042609555         1024       2048       24032.168372
0.021330364         1024       3072       48006.681930
0.021339559         1024       4096       47985.996337
The issue is that in dma pointer function we can have stale value
of the register for current descriptor of channel.
The register retains the number of the last descriptor that
was transferred.

Fix ensures that we report position, 0, till the one period worth of
data is transferred.  After one period of data, in handler of period
completion interrupt we update the config and correct value of descriptor
starts reflecting.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 77b265bd0505..3135e9eafd18 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1036,16 +1036,22 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
-		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
-		if (dscr == rtd->dma_dscr_idx_1)
-			pos = period_bytes;
-		else
-			pos = 0;
 		bytescount = acp_get_byte_count(rtd);
-		if (bytescount > rtd->bytescount)
+		if (bytescount >= rtd->bytescount)
 			bytescount -= rtd->bytescount;
-		delay = do_div(bytescount, period_bytes);
-		runtime->delay = bytes_to_frames(runtime, delay);
+		if (bytescount < period_bytes) {
+			pos = 0;
+		} else {
+			dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+			if (dscr == rtd->dma_dscr_idx_1)
+				pos = period_bytes;
+			else
+				pos = 0;
+		}
+		if (bytescount > 0) {
+			delay = do_div(bytescount, period_bytes);
+			runtime->delay = bytes_to_frames(runtime, delay);
+		}
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
2.17.1

