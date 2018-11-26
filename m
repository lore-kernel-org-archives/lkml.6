Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECCD20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=neverware.com header.i=@neverware.com header.b="eMoi2QUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECCD20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neverware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeK0FhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:37:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45953 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0FhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:37:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so18789839qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverware.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t2/5FvYtuEb4f2nnFC/GhUZEwC3cK2re0TjURP5G+rU=;
        b=eMoi2QUrbYYVOO7WcbrM15fbg+xpD5jS+WW8N8J45ObyKj3tEUILlbMAK2Br6v/hf2
         s0ntsPp3zrMqIiCf27iC9EPfS3bZi6H5Dpv1SNKgSbDdfJgpLspn0L2BJlbvnulH/qTY
         wUC017r6/+eK/3f9L2l9jRbl7YZIYOBCWOHlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t2/5FvYtuEb4f2nnFC/GhUZEwC3cK2re0TjURP5G+rU=;
        b=OMtw87dz8nqcbEkGq5TYCN/i6Og4CwW0G5Z9m0MJXTMtI5NVOGATEX5lQ2lR8m08/z
         dyIa7ppybGd6d1YaKHX3AMVAPfgni0xP6gQMTklYlWISms4biuw4/htawlJ1hY9gIb9c
         99S56qV+frz3ADJrl/ydDyFF75qyPOJL5BX52KGQuzdUibU1+H1+qzTY0OPF0uv6ALrz
         d/h0IzXeGvRFoqq+kl2eALqH99pfqipnT7Vq+wZPz63W+XfhSVOlBlZgcGyIof86W0fB
         tdH5zOTQ5Z8fxMN4fpKHfA9nbTJhFZAwD4Sm+B65RiCk4c4TM0dL6NluL8auwvXU5xNJ
         GCbg==
X-Gm-Message-State: AGRZ1gKzHN19x4e4BcaLm0pB+iNcP8KGWAzb2o7Pb7gjT69l+88bWNFN
        mXR+yRrmSDA5RiwNZB2ZHFyFMQ==
X-Google-Smtp-Source: AJdET5cWVmo0OYzAjNVfcA39na6ypxBiYUd184ulHFHnjt+ISeLs8FpR4EkLLgSQgFZyhdu9b1u8Bg==
X-Received: by 2002:ac8:3065:: with SMTP id g34mr28070250qte.136.1543257730303;
        Mon, 26 Nov 2018 10:42:10 -0800 (PST)
Received: from Puget-178128.seaworld.local (rrcs-208-105-51-90.nyc.biz.rr.com. [208.105.51.90])
        by smtp.googlemail.com with ESMTPSA id v53sm883440qtb.6.2018.11.26.10.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 10:42:09 -0800 (PST)
From:   Girija Kumar Kasinadhuni <gkumar@neverware.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Girija Kumar Kasinadhuni <gkumar@neverware.com>
Subject: [PATCH v3] ALSA: hda/realtek - Add auto-mute quirk for HP Spectre x360 laptop
Date:   Mon, 26 Nov 2018 13:40:46 -0500
Message-Id: <1543257648-105480-1-git-send-email-gkumar@neverware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <s5hefbeax39.wl-tiwai@suse.de>
References: <s5hefbeax39.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device makes a loud buzzing sound when a headphone is inserted while
playing audio at full volume through the speaker.

Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
---
Apologies for the earlier patch not being tested properly. Verified this
time, and on the actual hardware. Here' s the alsa-info output.
http://www.alsa-project.org/db/?f=16bc34d9bf8c9b2536969c125c1721fee570c9b0

 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 970bc44..c39f7f2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5495,6 +5495,7 @@ enum {
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
+	ALC295_FIXUP_HP_AUTO_MUTE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5659,6 +5660,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_HP_MUTE_LED_MIC3] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hp_mute_led_mic3,
+		.chained = true,
+		.chain_id = ALC295_FIXUP_HP_AUTO_MUTE
 	},
 	[ALC269_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6362,6 +6365,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC295_FIXUP_HP_AUTO_MUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
-- 
2.7.4

