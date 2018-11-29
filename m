Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D251C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F312081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F312081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeK2VKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:10:45 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:59886 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2VKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:10:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 0F75E185A7;
        Thu, 29 Nov 2018 11:05:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 90sJfrhjrjyD; Thu, 29 Nov 2018 11:05:54 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 18951185AB;
        Thu, 29 Nov 2018 11:05:53 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C16D21E076;
        Thu, 29 Nov 2018 11:05:53 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4C821E074;
        Thu, 29 Nov 2018 11:05:53 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Thu, 29 Nov 2018 11:05:53 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
        by thoth.se.axis.com (Postfix) with ESMTP id A74DD237C;
        Thu, 29 Nov 2018 11:05:53 +0100 (CET)
Received: from lnxsofieka1.se.axis.com (10.0.5.60) by XBOX04.axis.com
 (10.0.5.18) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Thu, 29 Nov 2018
 11:05:53 +0100
From:   Niklas Carlsson <niklas.carlsson@axis.com>
CC:     <niklasc@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: adau1761: Ensure DSP_RUN and DSP_ENABLE are disabled
Date:   Thu, 29 Nov 2018 11:05:30 +0100
Message-ID: <20181129100530.9043-1-niklasc@axis.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: XBOX04.axis.com (10.0.5.18) To XBOX04.axis.com (10.0.5.18)
X-TM-AS-GCONF: 00
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSP_RUN and DSP_ENABLE needs to be disabled during FW load. This is not
a problem after power-cycling but for soft reboots.

Signed-off-by: Niklas Carlsson <niklasc@axis.com>
---
 sound/soc/codecs/adau1761.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index bef3e9e74c26..3075c13bcbbc 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -460,8 +460,35 @@ static int adau1761_set_bias_level(struct snd_soc_component *component,
 		regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN);
-		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) ==
+		    SND_SOC_BIAS_OFF) {
+			/*
+			 * When going OFF -> STANDBY, the device can be in two
+			 * states:
+			 * 1) Power-cycled and reset
+			 * 2) Soft reboot
+			 * In the case of soft reboot, we need to sync the HW
+			 * registers even if our regmap reports default values.
+			 * Marking the cache as dirty ensures that both cases
+			 * are handled.
+			 */
+			regcache_mark_dirty(adau->regmap);
 			regcache_sync(adau->regmap);
+			/*
+			 * In order for FW to load correctly, the device needs
+			 * DSP_RUN and DSP_ENABLE to be 0. This might not be the
+			 * case for soft reboots. Ensure that DSP_RUN and
+			 * DSP_ENABLE is 0 by bypassing the cache and write
+			 * directly to HW when going OFF -> STANDBY.
+			 */
+			if (adau17x1_has_dsp(adau)) {
+				regcache_cache_bypass(adau->regmap, true);
+				regmap_write(adau->regmap, ADAU17X1_DSP_RUN, 0);
+				regmap_write(adau->regmap,
+					ADAU17X1_DSP_ENABLE, 0);
+				regcache_cache_bypass(adau->regmap, false);
+			}
+		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
-- 
2.11.0

