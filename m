Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BCAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78872083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78872083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbeIXSn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:43:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbeIXSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:43:26 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EA70109E;
        Mon, 24 Sep 2018 12:41:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 176/235] ASoC: hdmi-codec: fix routing
Date:   Mon, 24 Sep 2018 13:52:42 +0200
Message-Id: <20180924113122.374413423@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit d30e23d69981a4b665f5ce8711335df986576389 ]

Commit 943fa0228252 ("ASoC: hdmi-codec: Use different name for playback
streams") broke hdmi-codec's routing between it's output "TX" widget
and the S/PDIF or I2S streams by renaming the streams.

Whether an error occurs or not is dependent on whether there is another
widget called "Playback" registered by some other component - if there
is, that widget will be (incorrectly) bound to the HDMI codec's "TX"
output widget.  If we end up connecting "TX" incorrectly, it can result
in components not being started, causing no audio output.

Since the I2S and S/PDIF streams now have different names, we can't
use a static route at component level to describe the relationship, so
arrange to dynamically create the route when the DAI driver is probed.

Fixes: 943fa0228252 ("ASoC: hdmi-codec: Use different name for playback streams")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/hdmi-codec.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -291,10 +291,6 @@ static const struct snd_soc_dapm_widget
 	SND_SOC_DAPM_OUTPUT("TX"),
 };
 
-static const struct snd_soc_dapm_route hdmi_routes[] = {
-	{ "TX", NULL, "Playback" },
-};
-
 enum {
 	DAI_ID_I2S = 0,
 	DAI_ID_SPDIF,
@@ -689,9 +685,23 @@ static int hdmi_codec_pcm_new(struct snd
 	return snd_ctl_add(rtd->card->snd_card, kctl);
 }
 
+static int hdmi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_dapm_route route = {
+		.sink = "TX",
+		.source = dai->driver->playback.stream_name,
+	};
+
+	dapm = snd_soc_component_get_dapm(dai->component);
+
+	return snd_soc_dapm_add_routes(dapm, &route, 1);
+}
+
 static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
+	.probe = hdmi_dai_probe,
 	.playback = {
 		.stream_name = "I2S Playback",
 		.channels_min = 2,
@@ -707,6 +717,7 @@ static const struct snd_soc_dai_driver h
 static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 	.name = "spdif-hifi",
 	.id = DAI_ID_SPDIF,
+	.probe = hdmi_dai_probe,
 	.playback = {
 		.stream_name = "SPDIF Playback",
 		.channels_min = 2,
@@ -733,8 +744,6 @@ static int hdmi_of_xlate_dai_id(struct s
 static const struct snd_soc_component_driver hdmi_driver = {
 	.dapm_widgets		= hdmi_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
-	.dapm_routes		= hdmi_routes,
-	.num_dapm_routes	= ARRAY_SIZE(hdmi_routes),
 	.of_xlate_dai_id	= hdmi_of_xlate_dai_id,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,


