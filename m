Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF30C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CFF20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=neverware.com header.i=@neverware.com header.b="OUSbKthQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CFF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neverware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLKWuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:50:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41016 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKWuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:50:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so18423513qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverware.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kCcVZCFcQP8h5Lw4sHSIAZ/fdHniF/n0Tl4rMUpKOyI=;
        b=OUSbKthQXOwHxc9obTikSr1JR8ZBaQCtvqq63IqwQtowjmI+xsV11H4tlhJGdV2HDa
         2GvvifhkHG/jZVtHWlFMvlBKOopJNkwWA0C9DnAKaOv8m2XAd6bT96GgzcSd+Mm/eTVr
         hlUzTxzrlrFahMzyGM6YtADiU/A+MbUfler4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kCcVZCFcQP8h5Lw4sHSIAZ/fdHniF/n0Tl4rMUpKOyI=;
        b=nwC9Q1WDPuqsrvvuX66XODVGHbzUKzaRtCeZLBJl1oD8AUqImPzwNEqGs7GisQc+UF
         hKPba2BiZIrdp/8zaL7GP/Jhz6vETfiAQLESP6bqiMZ5feF3fC/+oeW0YlpW+jNOClqH
         wvGs+Y/ZkbYI7Gp7vaOchZPvChoRojohsYjXrsIQ/WFx1smneZECAKye+F11tulzd1hp
         iqnwu69jmei1Zv73TkuoYXNb8ekNwbMy99apFdliskhqYn49wCEtoTA+TIYrBWrnlYjN
         f5woT1WiyYvER8VlXJlxrO+l5jAdkPaf+7cbX2nKxKKCuau/FZRn71yw7U2LLK2dVRiC
         dkZg==
X-Gm-Message-State: AA+aEWaGrIRMPPJscbuztW4ewyVslFgjm3il990K1iUE694zMJ5IoqOt
        mR/TqCYMdROvXKByuOLo07UtAQ==
X-Google-Smtp-Source: AFSGD/US2/4fR9ywxbuY3t+ofblPwZQ+fI9AsffBLwvwE1//mCl/eFjn8vf48TWFvdv0x1VYLuMkSg==
X-Received: by 2002:aed:23c5:: with SMTP id k5mr18090212qtc.39.1544568604861;
        Tue, 11 Dec 2018 14:50:04 -0800 (PST)
Received: from Puget-178128.seaworld.local (rrcs-208-105-51-90.nyc.biz.rr.com. [208.105.51.90])
        by smtp.googlemail.com with ESMTPSA id z23sm14509860qkg.50.2018.12.11.14.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 14:50:04 -0800 (PST)
From:   Girija Kumar Kasinadhuni <gkumar@neverware.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Girija Kumar Kasinadhuni <gkumar@neverware.com>
Subject: [PATCH] ALSA: hda/realtek - Add quirks for Dell Optiplex 5060, 7060 for audio out while using headphones
Date:   Tue, 11 Dec 2018 17:49:36 -0500
Message-Id: <20181211224937.28889-1-gkumar@neverware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two audio ports on these machines - headset and mic.
There' s no sound when hp is inserted into the headset port,
though the hp is detected. Without pulseaudio, this issue is
seen on both the Optiplex machines. The issue goes away with the
"options snd-hda-intel model=dell-headset-dock" quirk in the
/etc/modprobe.d/alsa-base.conf or /etc/modprobe.d/alsa.conf
Getting this fix into the kernel instead of fixing in an
application layer above, or in a .conf file. This is also helpful
for audio clients using the ALSA api like cras from ChromiumOS.

Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
---
alsa-info:

 Optiplex 5060 -
 - without fix:	http://www.alsa-project.org/db/?f=2cf3c4354e82bde4aa480612a914535982fa3f91
 - with fix: http://www.alsa-project.org/db/?f=7a928960400ec828b82632411284ad8a63727b92
 Optiplex 7060
 - without fix: http://www.alsa-project.org/db/?f=69fa554faa712e7cad1f188be4a5192353d64f2c
 - with fix: http://www.alsa-project.org/db/?f=80ce1fb178b377b27b0795ac1c55e8cbee1b5b96

 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8d75597028ee..581f6a288abf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6444,6 +6444,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0665, "Dell XPS 13", ALC288_FIXUP_DELL_XPS_13),
 	SND_PCI_QUIRK(0x1028, 0x0669, "Dell Optiplex 9020m", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x085b, "Dell Optiplex 5060", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x085a, "Dell Optiplex 7060", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x069a, "Dell Vostro 5480", ALC290_FIXUP_SUBWOOFER_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x06c7, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06d9, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-- 
2.17.1

