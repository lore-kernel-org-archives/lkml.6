Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A3CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FF021871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfAECEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:04:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfAECEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:04:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634802"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:04:08 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 14/21] ASoC: rt5651: fix boolean assignments
Date:   Fri,  4 Jan 2019 20:02:42 -0600
Message-Id: <20190105020249.8639-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Coccinelle:
sound/soc/codecs/rt5651.c:750:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5651.c:754:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5651.c:2192:1-16: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index b7ba64350a07..3882e238ff99 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -747,11 +747,11 @@ static int rt5651_hp_event(struct snd_soc_dapm_widget *w,
 			RT5651_HP_CP_PD | RT5651_HP_SG_EN);
 		regmap_update_bits(rt5651->regmap, RT5651_PR_BASE +
 			RT5651_CHPUMP_INT_REG1, 0x0700, 0x0400);
-		rt5651->hp_mute = 0;
+		rt5651->hp_mute = false;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		rt5651->hp_mute = 1;
+		rt5651->hp_mute = true;
 		usleep_range(70000, 75000);
 		break;
 
@@ -2189,7 +2189,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
 	rt5651->irq = i2c->irq;
-	rt5651->hp_mute = 1;
+	rt5651->hp_mute = true;
 
 	INIT_DELAYED_WORK(&rt5651->bp_work, rt5651_button_press_work);
 	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
-- 
2.17.1

