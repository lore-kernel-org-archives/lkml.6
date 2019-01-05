Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB2C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380121871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfAECEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:04:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:23587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfAECEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:04:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634843"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:04:30 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bardliao@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 20/21] ASoC: rt5645: store eq kcontrol byte in __be
Date:   Fri,  4 Jan 2019 20:02:48 -0600
Message-Id: <20190105020249.8639-21-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

The eq parameters binary is stored in __be. However, it is unsigned short
in rt5645_eq_param_s{} which will cause incorrect type assignment. So add
struct rt5645_eq_param_s_be16{} to store the eq binary and convert it to
unsigned short in rt5645->eq_param.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 52ce380c8f3a..9a0751978090 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -401,6 +401,11 @@ struct rt5645_eq_param_s {
 	unsigned short val;
 };
 
+struct rt5645_eq_param_s_be16 {
+	__be16 reg;
+	__be16 val;
+};
+
 static const char *const rt5645_supply_names[] = {
 	"avdd",
 	"cpvdd",
@@ -672,8 +677,8 @@ static int rt5645_hweq_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
-	struct rt5645_eq_param_s *eq_param =
-		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	struct rt5645_eq_param_s_be16 *eq_param =
+		(struct rt5645_eq_param_s_be16 *)ucontrol->value.bytes.data;
 	int i;
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
@@ -698,36 +703,33 @@ static int rt5645_hweq_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
-	struct rt5645_eq_param_s *eq_param =
-		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	struct rt5645_eq_param_s_be16 *eq_param =
+		(struct rt5645_eq_param_s_be16 *)ucontrol->value.bytes.data;
 	int i;
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
-		eq_param[i].reg = be16_to_cpu(eq_param[i].reg);
-		eq_param[i].val = be16_to_cpu(eq_param[i].val);
+		rt5645->eq_param[i].reg = be16_to_cpu(eq_param[i].reg);
+		rt5645->eq_param[i].val = be16_to_cpu(eq_param[i].val);
 	}
 
 	/* The final setting of the table should be RT5645_EQ_CTRL2 */
 	for (i = RT5645_HWEQ_NUM - 1; i >= 0; i--) {
-		if (eq_param[i].reg == 0)
+		if (rt5645->eq_param[i].reg == 0)
 			continue;
-		else if (eq_param[i].reg != RT5645_EQ_CTRL2)
+		else if (rt5645->eq_param[i].reg != RT5645_EQ_CTRL2)
 			return 0;
 		else
 			break;
 	}
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
-		if (!rt5645_validate_hweq(eq_param[i].reg) &&
-			eq_param[i].reg != 0)
+		if (!rt5645_validate_hweq(rt5645->eq_param[i].reg) &&
+		    rt5645->eq_param[i].reg != 0)
 			return 0;
-		else if (eq_param[i].reg == 0)
+		else if (rt5645->eq_param[i].reg == 0)
 			break;
 	}
 
-	memcpy(rt5645->eq_param, eq_param,
-		RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s));
-
 	return 0;
 }
 
-- 
2.17.1

