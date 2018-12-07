Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE5AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04ED22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="g+WxL+XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ED22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLGTAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:00:46 -0500
Received: from host.euro-space.net ([87.117.239.2]:56374 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGTAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uVUpPEZW5BkJN1T2C0CWbVujzwtS4c9KjO3mw86LoAg=; b=g+WxL+XDpvZ7AOHGmXkKe/+zmT
        LpAALzW6cqsOCoL+U19KFZEeg35NZZUOinEGC0w08dNLowpkhqVn3X+Pt2z/kIigxYZ3Oyt7zDVjL
        QGGodHGMiOTlsT6OnhBwHvfbC7MrwB0QenoRhUvRUj8zQMir75lZ64uwvz83lIFHBqTvO62LSB31u
        FJoP94b2vFd7MlYkAKsLx6S/TL2Q+Gjn5SSJO1F7o7EV4wd0rmR3VDQNDsFVl2sCmo9fmlBnkqZRR
        52PAwJv5P8EOQxHZoaC+CueOmQo0LRPj3mS4im0x7lSm51CWt5Swog+q3h1unCds/NEeVK6oMVnIe
        beY4BBaA==;
Received: from x2f18067.dyn.telefonica.de ([2.241.128.103]:34262 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gVLLf-0007ce-14; Fri, 07 Dec 2018 18:59:39 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH] ASoC: pcm3060: Add powersaving widgets for DAC and ADC
Date:   Fri,  7 Dec 2018 20:02:34 +0100
Message-Id: <20181207190234.12040-1-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DAC/ADC only when playing/capturing

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 14 ++++++++++----
 sound/soc/codecs/pcm3060.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 1dd851a7b43b..6714aa8d9026 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -198,19 +198,25 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_DAPSV, 1),
+
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
+
+	SND_SOC_DAPM_ADC("ADC", "Capture", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_ADPSV, 1),
 };
 
 static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
-	{ "OUTL", NULL, "Playback" },
-	{ "OUTR", NULL, "Playback" },
+	{ "OUTL", NULL, "DAC" },
+	{ "OUTR", NULL, "DAC" },
 
-	{ "Capture", NULL, "INL" },
-	{ "Capture", NULL, "INR" },
+	{ "ADC", NULL, "INL" },
+	{ "ADC", NULL, "INR" },
 };
 
 /* soc component */
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index c895cf40ee10..6a027b4a845d 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -37,7 +37,9 @@ int pcm3060_remove(struct device *dev);
 #define PCM3060_REG_MRST		0x80
 #define PCM3060_REG_SRST		0x40
 #define PCM3060_REG_ADPSV		0x20
+#define PCM3060_REG_SHIFT_ADPSV	0x05
 #define PCM3060_REG_DAPSV		0x10
+#define PCM3060_REG_SHIFT_DAPSV	0x04
 #define PCM3060_REG_SE			0x01
 
 #define PCM3060_REG65			0x41
-- 
2.13.6

