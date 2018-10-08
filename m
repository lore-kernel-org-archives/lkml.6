Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B426EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F462089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVRpQnEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F462089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJICzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:55:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39338 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJICzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:55:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id e22-v6so15184572qto.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c8DXUNWY9voh42tJuVOp3lKwuUkPa74Oyq6nNSSHTGk=;
        b=GVRpQnEkc9IJZHseWBJFeuAv1Q2yguyvUiQYKr2QDkqMakEAVfzuJpaixeE5U8LpWT
         MKO2yntBoneb701MT0ea/G0caUHHhWW7alvQjeRBleEG9lThfTkTPtxi0bqbieClmD7G
         CyuurN9RBXARNvc/bmzeV6psbLf+cDoAiE9kVDW+8nulF3mgHRx58KK2ou4M74BWR81x
         IYGMXzClYLqzqyJCgHuSfDxdfm0NAaqMkb9geMpaK8Pegda+eGRrvDUDgmEDLgeydwcd
         3dyF76BT45aGKeG4hC5BwqRYN1Y7hmI5RETWJiayD8oEvWNUvXhS/sGqwooo6rjP5r7I
         /o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c8DXUNWY9voh42tJuVOp3lKwuUkPa74Oyq6nNSSHTGk=;
        b=N4clKFDW9lG2JCzCxO1PRKSkH8oG3HoV2gb2pF8RMDFnDf9m188pgHKF2sUHwIZh27
         djpUC1VaJsygyFiOFaJ0GttibJeR1FIKx6e9gsZzuK62XPXiMpj6VlQ3KWFMNqxdaePe
         EEKo2CEyLyJxbayginSEyYYt08LODPie8JtxA54DtUBaM0MbeqDkahAXinv0AGE4zWaF
         ZJNNvqvK4pbE8rcmoKlOf8UhsZt/lcEbA7wwzjEBTYP2fLz+1866RQX4HQPhgXbd+omv
         26syfQ32PmZSQ407PUVt8Is73QTIc9hr2ioO2FHQT7ji1+KF2LRSBYov8wPvrJjWUyt0
         F4Sw==
X-Gm-Message-State: ABuFfoiXTyRJlpuUhD834Xp3XdSCxxVtLJnaSA43t291xpzvVShlxNfX
        uopOCVql05hLWpFyCs4HPls=
X-Google-Smtp-Source: ACcGV61yqCvmySwUg8FOjIhBk7V4DnfY26VhJzQ7MUUiDPxur/3ft0vssPpA/FKz7N0X1DzXD+isjA==
X-Received: by 2002:a0c:f24c:: with SMTP id z12-v6mr20415809qvl.87.1539027730569;
        Mon, 08 Oct 2018 12:42:10 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:f812:c27a:7560:4d6a])
        by smtp.googlemail.com with ESMTPSA id 76-v6sm13220644qkc.41.2018.10.08.12.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 12:42:10 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ALSA: hda/ca0132 - Clean up patch_ca0132()
Date:   Mon,  8 Oct 2018 15:39:58 -0400
Message-Id: <1539027601-20910-3-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the patch_ca0132() function with suggestions from
Takashi Sakamoto.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 12a3581..07d50d6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8697,10 +8697,6 @@ static int patch_ca0132(struct hda_codec *codec)
 	codec->spec = spec;
 	spec->codec = codec;
 
-	codec->patch_ops = ca0132_patch_ops;
-	codec->pcm_format_first = 1;
-	codec->no_sticky_stream = 1;
-
 	/* Detect codec quirk */
 	quirk = snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
 	if (quirk)
@@ -8711,6 +8707,15 @@ static int patch_ca0132(struct hda_codec *codec)
 	if (spec->quirk == QUIRK_SBZ)
 		sbz_detect_quirk(codec);
 
+	if (spec->quirk == QUIRK_ZXR_DBPRO)
+		codec->patch_ops = dbpro_patch_ops;
+	else
+		codec->patch_ops = ca0132_patch_ops;
+
+	codec->pcm_format_first = 1;
+	codec->no_sticky_stream = 1;
+
+
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 
@@ -8725,7 +8730,6 @@ static int patch_ca0132(struct hda_codec *codec)
 		snd_hda_codec_set_name(codec, "Sound Blaster ZxR");
 		break;
 	case QUIRK_ZXR_DBPRO:
-		codec->patch_ops = dbpro_patch_ops;
 		break;
 	case QUIRK_R3D:
 		spec->mixers[0] = desktop_mixer;
-- 
2.7.4

