Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27085C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3A1218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfAECEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:04:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:23587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfAECE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:04:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634832"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:04:25 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 18/21] ASoC: da7219: fix endianness issues
Date:   Fri,  4 Jan 2019 20:02:46 -0600
Message-Id: <20190105020249.8639-19-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Sparse.

da7219.c:440:44: warning: cast to restricted __le16
da7219.c:461:13: warning: incorrect type in assignment (different base types)
da7219.c:461:13:    expected unsigned short [unsigned] [usertype] val
da7219.c:461:13:    got restricted __le16 [usertype] <noident>
da7219.c:1451:16: warning: incorrect type in assignment (different base types)
da7219.c:1451:16:    expected unsigned short [unsigned] [usertype] offset
da7219.c:1451:16:    got restricted __le16 [usertype] <noident>

da7219-aad.c:150:37: warning: incorrect type in assignment (different base types)
da7219-aad.c:150:37:    expected unsigned short [unsigned] [usertype] tonegen_freq_hptest
da7219-aad.c:150:37:    got restricted __le16 [usertype] <noident>
da7219-aad.c:157:37: warning: incorrect type in assignment (different base types)
da7219-aad.c:157:37:    expected unsigned short [unsigned] [usertype] tonegen_freq_hptest
da7219-aad.c:157:37:    got restricted __le16 [usertype] <noident>

Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/da7219-aad.c | 2 +-
 sound/soc/codecs/da7219.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 2c7d5088e6f2..e0964b20a389 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -117,7 +117,7 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 
-	u16 tonegen_freq_hptest;
+	__le16 tonegen_freq_hptest;
 	u8 pll_srm_sts, pll_ctrl, gain_ramp_ctrl, accdet_cfg8;
 	int report = 0, ret = 0;
 
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index e46e9f4bc994..ce165047b9f9 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -423,7 +423,7 @@ static int da7219_tonegen_freq_get(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mixer_ctrl =
 		(struct soc_mixer_control *) kcontrol->private_value;
 	unsigned int reg = mixer_ctrl->reg;
-	u16 val;
+	__le16 val;
 	int ret;
 
 	mutex_lock(&da7219->ctrl_lock);
@@ -450,7 +450,7 @@ static int da7219_tonegen_freq_put(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mixer_ctrl =
 		(struct soc_mixer_control *) kcontrol->private_value;
 	unsigned int reg = mixer_ctrl->reg;
-	u16 val;
+	__le16 val;
 	int ret;
 
 	/*
@@ -1396,7 +1396,7 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	struct snd_soc_component *component = dai->component;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 dai_bclks_per_wclk;
-	u16 offset;
+	__le16 offset;
 	u32 frame_size;
 
 	/* No channels enabled so disable TDM, revert to 64-bit frames */
-- 
2.17.1

