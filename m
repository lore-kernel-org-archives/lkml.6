Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5F8214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=neverware.com header.i=@neverware.com header.b="kdKAl6nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5F8214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neverware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbeKVE0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:26:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38235 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeKVE0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:26:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so4755325qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverware.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zq2xK1vOBKyrKJQwfoSi8LCW6yBVFneB4NbMK7yY1C0=;
        b=kdKAl6nh5KD6IFV6iUMpqtyN31lUZc3AbZQ95R3z01Lemtb80/kYfn+JPmFUWMnRoq
         HQXVrKG6piELCmxvdZheP1tYNmAVltelHaT5MgPDvtbyVKic4nHX4G/RGytIw4fKpAzT
         YIC0rXPeIzKW5926eHXxla4VPf1BsWtbq0RyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zq2xK1vOBKyrKJQwfoSi8LCW6yBVFneB4NbMK7yY1C0=;
        b=gGaChc4LaAXFk9z7ZhQx6VahWDU2WIw/tw0EOadqg91/YkD4CtMWxCdD5TjdcDv8J0
         A9iyB2QVfSCgrneYydmE1/CGE7BBRBivxOUYQNMBsL0zUsBSdIqFuNyFwzawb96MwD5m
         +SmccjbRyx6XzfgJSA4XxGvMqox8rc4QmizjXEV++QtvjdLpqAMBm687gao1D8AleUjm
         LIU/wDQhAENLG1K2fMeRSxXcIxOOZvwLdv4YypIyNdH9Y5fqi2mo4kIsDK8thUyMlprj
         sLEdQreU3Luhbuj3RjxUeo/Ch5jKsFHixEyNmgZ2lYn/7hqtsz+gu7QJKxTTweWvp62N
         mI1w==
X-Gm-Message-State: AGRZ1gJOXjMEkdFUJbMKS14iXmbKDVa3j2H4wvae8JJ94MQTGCsS9MIr
        xhb/ujMMumP7dfVH8dkidyqpIQ==
X-Google-Smtp-Source: AJdET5emkIBdy3EXYmtk/2xkx3wrOQXSlNANileeCrfWA07hkxtg//xR+JPxuwDTwL6UlBaUK5Anxg==
X-Received: by 2002:ac8:593:: with SMTP id a19mr6656774qth.111.1542822678428;
        Wed, 21 Nov 2018 09:51:18 -0800 (PST)
Received: from Puget-178128.seaworld.local (rrcs-208-105-51-90.nyc.biz.rr.com. [208.105.51.90])
        by smtp.googlemail.com with ESMTPSA id t40sm28970625qth.46.2018.11.21.09.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 09:51:17 -0800 (PST)
From:   Girija Kumar Kasinadhuni <gkumar@neverware.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Girija Kumar Kasinadhuni <gkumar@neverware.com>
Subject: [PATCH v2] ALSA: hda/realtek - Add auto-mute quirk for HP Spectre x360 laptop
Date:   Wed, 21 Nov 2018 12:49:11 -0500
Message-Id: <1542822552-110314-1-git-send-email-gkumar@neverware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <s5hlg5mbch9.wl-tiwai@suse.de>
References: <s5hlg5mbch9.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device makes a loud buzzing sound when a headphone is inserted while
playing audio at full volume through the speaker.

Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
---
Changes in v2:
	- changed commit message
	- removed "disable" from description

 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fa61674..69bb005 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5495,6 +5495,7 @@ enum {
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
+	ALC295_FIXUP_HP_AUTO_MUTE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6362,6 +6363,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC295_FIXUP_HP_AUTO_MUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6486,6 +6491,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre X360 ", ALC295_FIXUP_HP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.7.4

