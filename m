Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7F221904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKH8LSPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbeLTX0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:26:04 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48918 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbeLTX0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:26:03 -0500
Received: by mail-qk1-f201.google.com with SMTP id p79so3622433qki.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J3WTI2+dwa9VExHmDbL37aPkrrNpdM27lnLlso5BrOc=;
        b=sKH8LSPBUix+11ZgYH08L8o9rFdgfqPiLS50LMeQBRO0riEMXB+XMmjAtGaltRFWsW
         lDO7p47Wd2FieFJuoDZq3NLSSFarFYQ098HRNOjyYr7cLTLhDfcnzZWyd6LpPtVY4JIr
         u5LaaBUOi5aSEG6nRLaDGpLJVqdvKW2Fqha4m+vnSzexy337Kpjsw7HmMuMVnVc4yf4X
         Abuoxi4h6S7wgZW+Qh3THpiWB1X2Nu3p5lFz+FIAOipe7KJgc9XvXlprvHs+bRVIfb2Y
         LmgVnJG7ejYVYDJyam8sP2izVbFFj+7P/mIF3Zz9/nh70uGRN+fdaW8rvlSY+r2F4ljx
         FW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J3WTI2+dwa9VExHmDbL37aPkrrNpdM27lnLlso5BrOc=;
        b=nbFpFb3JViUz/0qny7tfsuGfCpAaDFMcASg6vq+lYev16YISFgUvFAaPjWNjfm7QjZ
         apau0fmLqBZT6KFtwqM/n1RtoqgWM4lR/wCPV+DRB2f+V1vp3Wsc3uPv9BChPEfbcu+N
         Qlwk1j8fSQREKqw55f45MReilwDFKeIdcmY/xbApd2YWPB3561P1+ts8AGzjjqS7R7Ph
         euRBWGAbsS+RpagY9VvwpQtr2wHg/C6kixDoc80S7iK1rwES1q3gf8xYk8TDe4fPYx+t
         cony5hcqA4khQ5AV0vVnXAeH5+jgoIFpc8Szuci+tQa9tUWgX49XqAMLwc/vbws2vLh/
         If9g==
X-Gm-Message-State: AJcUukd7gYLGgqo6ToIDSJ9nG6ND1zzokPIQe83OGOlRmDBWj6uwh5Zw
        K3OhftyPiMAlb9pnlc1ntOVqNcSt+Yd+sr+Ud06s91SEQejv2cp4v/OqWijs5TZRo0eM3r/wuzP
        lewEqbySgCpXaVC6G0vnEeg5627V/p/bSfK6YE609ZnFGZzNwgIDSwh5AdUKdm3WCSMZQhRS5
X-Google-Smtp-Source: ALg8bN4rMfFOwAU+Vx3auXSS3KI6ZOX8COi1/tKEuX8pc3D8rmu/1qJtw2mKaeCyOwivol73rSG2/wDYnXsT
X-Received: by 2002:a0c:d11a:: with SMTP id a26mr163388qvh.10.1545348362199;
 Thu, 20 Dec 2018 15:26:02 -0800 (PST)
Date:   Thu, 20 Dec 2018 16:25:55 -0700
Message-Id: <20181220232555.90030-1-zwisler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] ASoC: rt5677: use more of the volume range from DACs
From:   Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dylan Reid <dgreid@chromium.org>, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Hsinyu Chao <hychao@chromium.org>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dylan Reid <dgreid@chromium.org>

The DACs volume can go over 0, both according to the data sheet and
real world testing.  The control can go up to +30dB.

This was tested by playing audio at full volume on a samus chromebook.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
Reviewed-by: Hsinyu Chao <hychao@chromium.org>
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 sound/soc/codecs/rt5677.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9b7a1833d3316..513fec86301e8 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -832,13 +832,13 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5677_DAC1_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC2 Playback Volume", RT5677_DAC2_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC3 Playback Volume", RT5677_DAC3_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC4 Playback Volume", RT5677_DAC4_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 
 	/* IN1/IN2 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5677_IN1, RT5677_BST_SFT1, 8, 0, bst_tlv),
-- 
2.20.1.415.g653613c723-goog

