Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB927C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D1A2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D1A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407075AbeHATNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:13:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389883AbeHATNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:13:16 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93AF9CC3;
        Wed,  1 Aug 2018 17:26:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 043/144] ASoC: dpcm: fix BE dai not hw_free and shutdown
Date:   Wed,  1 Aug 2018 18:51:10 +0200
Message-Id: <20180801164952.151416797@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>

[ Upstream commit 9c0ac70ad24d76b873c1551e27790c7f6a815d5c ]

In case, one BE is used by two FE1/FE2
FE1--->BE-->
       |
FE2----]
when FE1/FE2 call dpcm_be_dai_hw_free() together
the BE users will be 2 (> 1), hence cannot be hw_free
the be state will leave at, ex. SND_SOC_DPCM_STATE_STOP

later FE1/FE2 call dpcm_be_dai_shutdown(),
will be skip due to wrong state.
leaving the BE not being hw_free and shutdown.

The BE dai will be hw_free later when calling
dpcm_be_dai_shutdown() if still in invalid state.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-pcm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1793,8 +1793,10 @@ int dpcm_be_dai_shutdown(struct snd_soc_
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN))
-			continue;
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN)) {
+			soc_pcm_hw_free(be_substream);
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
+		}
 
 		dev_dbg(be->dev, "ASoC: close BE %s\n",
 			be->dai_link->name);


