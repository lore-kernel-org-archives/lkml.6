Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3322121473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3322121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeHPVnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:43:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56246 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeHPVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:43:13 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3FACDCE8;
        Thu, 16 Aug 2018 18:43:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.4 10/13] ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization
Date:   Thu, 16 Aug 2018 20:41:57 +0200
Message-Id: <20180816171629.069531707@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171628.554317013@linuxfoundation.org>
References: <20180816171628.554317013@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Escande <thierry.escande@collabora.com>

commit 3bbda5a38601f7675a214be2044e41d7749e6c7b upstream.

If the ts3a227e audio accessory detection hardware is present and its
driver probed, the jack needs to be created before enabling jack
detection in the ts3a227e driver. With this patch, the jack is
instantiated in the max98090 headset init function if the ts3a227e is
present. This fixes a null pointer dereference as the jack detection
enabling function in the ts3a driver was called before the jack is
created.

[minor correction to keep error handling on jack creation the same
as before by Pierre Bossart]

Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |   45 ++++++++++++++++++---------
 1 file changed, 31 insertions(+), 14 deletions(-)

--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -131,23 +131,19 @@ static int cht_codec_init(struct snd_soc
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 	struct snd_soc_jack *jack = &ctx->jack;
 
-	/**
-	* TI supports 4 butons headset detection
-	* KEY_MEDIA
-	* KEY_VOICECOMMAND
-	* KEY_VOLUMEUP
-	* KEY_VOLUMEDOWN
-	*/
-	if (ctx->ts3a227e_present)
-		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-					SND_JACK_BTN_2 | SND_JACK_BTN_3;
-	else
-		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
+	if (ctx->ts3a227e_present) {
+		/*
+		 * The jack has already been created in the
+		 * cht_max98090_headset_init() function.
+		 */
+		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
+		return 0;
+	}
+
+	jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
 	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
 					jack_type, jack, NULL, 0);
-
 	if (ret) {
 		dev_err(runtime->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
@@ -203,6 +199,27 @@ static int cht_max98090_headset_init(str
 {
 	struct snd_soc_card *card = component->card;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct snd_soc_jack *jack = &ctx->jack;
+	int jack_type;
+	int ret;
+
+	/*
+	 * TI supports 4 butons headset detection
+	 * KEY_MEDIA
+	 * KEY_VOICECOMMAND
+	 * KEY_VOLUMEUP
+	 * KEY_VOLUMEDOWN
+	 */
+	jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+		    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+		    SND_JACK_BTN_2 | SND_JACK_BTN_3;
+
+	ret = snd_soc_card_jack_new(card, "Headset Jack", jack_type,
+				    jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Headset Jack creation failed %d\n", ret);
+		return ret;
+	}
 
 	return ts3a227e_enable_jack_detect(component, &ctx->jack);
 }


