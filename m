Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF7C20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="RiRIesVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF7C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbeJ2S5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:57:05 -0400
Received: from host.euro-space.net ([87.117.239.2]:54869 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbeJ2S5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:57:05 -0400
X-Greylist: delayed 4296 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 14:57:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u7GSEFzvsFyt1WpkRcW2kttuaIiR+oQT3hU2YfpZyuM=; b=RiRIesVlPsvLO7vrl7+8O3PzVh
        o8fYqoqYxH/apQCKbmPekJbPEDqyJyslbcYfualtTS92g65wYKT4Sqr4pxXw062Xz14/zP/Ayn1pz
        epbS3pAwCO/3gdX3Vx28sKRXQy+lZYQk6HulG/M6SSBi4YHaQH4sdgXY3oh6D0IL+TLoTfafUd8Mv
        qxngYmlS/QyRSVs52uSEbvN21OzSkKF+J+nBlXz5iiIaYENA5/ETFoi0b+Y4NL/hS87hcR2Lvl/0z
        IW7j5IjFHRUt93ubJuwbUFWLI8VOZAVx9ftC0/cecMZ7seL5oAKpThpJHth1+isZ1Gqm4PgB2QTGB
        uK16tIxA==;
Received: from x4dbc7335.dyn.telefonica.de ([77.188.115.53]:52812 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gH3Ml-0007KB-Fh; Mon, 29 Oct 2018 08:57:43 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 1/2] ASoC: pcm3060: Add control for differential output
Date:   Mon, 29 Oct 2018 09:59:12 +0100
Message-Id: <20181029085913.17298-1-kmarinushkin@birdec.tech>
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

DAC may be switched between differential and single-ended output.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 9 +++++++++
 sound/soc/codecs/pcm3060.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 494d9d662be8..f792ad637ae4 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -179,6 +179,13 @@ static struct snd_soc_dai_driver pcm3060_dai[] = {
 
 /* dapm */
 
+static const char * const pcm3060_dapm_out_dif_txt[] = {
+	"Differential", "Single-Ended"
+};
+
+static SOC_ENUM_SINGLE_DECL(pcm3060_dapm_out_dif_enum, PCM3060_REG64,
+			    PCM3060_REG_SHIFT_SE, pcm3060_dapm_out_dif_txt);
+
 static DECLARE_TLV_DB_SCALE(pcm3060_dapm_tlv, -10050, 50, 1);
 
 static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
@@ -195,6 +202,8 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 			       0, pcm3060_dapm_tlv),
 	SOC_DOUBLE("Master Capture Switch", PCM3060_REG73,
 		   PCM3060_REG_SHIFT_MUT11, PCM3060_REG_SHIFT_MUT12, 1, 1),
+
+	SOC_ENUM("DAC Out Differential", pcm3060_dapm_out_dif_enum),
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index fd89a68aa8a7..32080ff00166 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -38,6 +38,7 @@ int pcm3060_remove(struct device *dev);
 #define PCM3060_REG_ADPSV		0x20
 #define PCM3060_REG_DAPSV		0x10
 #define PCM3060_REG_SE			0x01
+#define PCM3060_REG_SHIFT_SE		0x00
 
 #define PCM3060_REG65			0x41
 #define PCM3060_REG66			0x42
-- 
2.13.6

