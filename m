Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC5AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2543820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2543820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeICWAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:00:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeICWAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:00:12 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C962BAE;
        Mon,  3 Sep 2018 17:39:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ajit Pandey <ajit.pandey@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 075/123] ASoC: wm_adsp: Correct DSP pointer for preloader control
Date:   Mon,  3 Sep 2018 18:56:59 +0200
Message-Id: <20180903165722.716601737@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ajit Pandey <ajit.pandey@cirrus.com>

commit b1470d4ce77c2d60661c7d5325d4fb8063e15ff8 upstream.

The offset of the DSP core needs to be taken into account for the DSP
preloader control get and put. Currently the dsp->preloaded variable
will only ever be read/updated on the first DSP, whilst this doesn't
affect the operation of the control the readback will be incorrect.

Signed-off-by: Ajit Pandey <ajit.pandey@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/wm_adsp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2642,7 +2642,10 @@ int wm_adsp2_preloader_get(struct snd_kc
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wm_adsp *dsp = snd_soc_component_get_drvdata(component);
+	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct wm_adsp *dsp = &dsps[mc->shift - 1];
 
 	ucontrol->value.integer.value[0] = dsp->preloaded;
 
@@ -2654,10 +2657,11 @@ int wm_adsp2_preloader_put(struct snd_kc
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wm_adsp *dsp = snd_soc_component_get_drvdata(component);
+	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	struct wm_adsp *dsp = &dsps[mc->shift - 1];
 	char preload[32];
 
 	snprintf(preload, ARRAY_SIZE(preload), "DSP%u Preload", mc->shift);


