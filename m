Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CDBC46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672A0208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672A0208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeHAMdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:33:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39187 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbeHAMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:33:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkofS-0006Wd-H7; Wed, 01 Aug 2018 10:47:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jaya Kumar <jayakumar.alsa@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] ASoC: stm32: remove redundant pointers 'priv' and 'rtd'
Date:   Wed,  1 Aug 2018 11:47:40 +0100
Message-Id: <20180801104742.4328-8-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'priv' is assigned and not used, removing this allows
the removal of pointer 'rtd'.

Cleans up clang warning:
warning: variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/stm/stm32_adfsdm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 0e9373064032..706ff005234f 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -269,16 +269,10 @@ static int stm32_adfsdm_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static void stm32_adfsdm_pcm_free(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
-	struct snd_soc_pcm_runtime *rtd;
-	struct stm32_adfsdm_priv *priv;
 
 	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-	if (substream) {
-		rtd = substream->private_data;
-		priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-
+	if (substream)
 		snd_pcm_lib_preallocate_free_for_all(pcm);
-	}
 }
 
 static struct snd_soc_component_driver stm32_adfsdm_soc_platform = {
-- 
2.17.1

