Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA302C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534692178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVwZFp8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534692178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeHDSqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:46:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39636 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDSqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:46:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so15220436oib.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bImFTE7v22jiBX2rRzfosXl4Vf9/I1d1wG0XVTAiiaY=;
        b=lVwZFp8uNyxkEuGPidFh6//piYK5D81ifRKYV/QjulBX6eVI3UUiDWmcEzhULrfPJf
         sbW2rWu6jMJiDu8bsIG6wecphOHL9X2LxbQnI8pH/pMeYwP39XT28yYmhMBxdooQ6bb2
         mHgeQDa+dYH8RnMjUGySZAGqstB0QkT8HWJmMl7dcomtl8XZJFPSFEvEzMtn//xqrRsU
         wRSCqH3vjyTCPreApwA6xkig+n0U71Tm2+lcFEFYVTkVLvdxAPYgsNcuVE0bx6uHByLr
         kHgjwJ+9jRAEGzggEFjLI9ZSx3TPyow6rYNzhundHtyHshyHLmUgk2KUE5C1/81Qq7lK
         IuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bImFTE7v22jiBX2rRzfosXl4Vf9/I1d1wG0XVTAiiaY=;
        b=I9esYq9TFV39VOoqm5gwynNbiOMlCxNtyM1EvZkFrN4Ekj0AUGNK9rdbBnaRJRClou
         LSVC8lBgzv3wfpOdYJNRPwnlfsmjQYqsk4rX/w2wc5hn1XuP4CtZ69o0KGOD3IgEXJze
         IglMl9+QoRlt8pCMC0B2HdWC9RHm1oZ9puwmPI+k0a079FLxrmf7wRbT8ZrXDrBoog5a
         s1FtF1xJEnVpU6Ck/7+ihzUR/1Vg5aQsUF1rxrKgn6qSbx6zPfG1sQI4cAZ2VbAn8Jxb
         7SoYcGuBHD5LBflT4eUfTbjH/2TC/lUAym77qipfEHCrfe6zcUhac+vbLZ3RTFhdICRH
         vgag==
X-Gm-Message-State: AOUpUlGiPw0DTTqIamZCCpNDHGGF9RJY+eIhxa5PWUI4OA3rnv2iOu1l
        fn4XrIKYnfHBVkwjiVuHyMhf11sShjM=
X-Google-Smtp-Source: AAOMgpc/oNfg5sWtLzyyXOn+ZJyQY9JerKjtwK6VgsAckGFsCGjiM6EKJEi6pq1WkaZv5Px/jfLHmQ==
X-Received: by 2002:aca:ceca:: with SMTP id e193-v6mr7487456oig.37.1533401098289;
        Sat, 04 Aug 2018 09:44:58 -0700 (PDT)
Received: from nukespec.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id r81-v6sm6136208oih.28.2018.08.04.09.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 09:44:57 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, Peisen <pshou@realtek.com>,
        Tom Briden <tom@decompile.me.uk>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Add mute LED quirk for HP Spectre x360
Date:   Sat,  4 Aug 2018 11:44:44 -0500
Message-Id: <20180804164448.7152-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device has the same issues as the HP x360 wrt the MUTE LED and
the front speakers not working. This patch fixes the MUTE LED issue,
but doesn't touch the HDA verbs. The fix for the x360 does not work
on the Spectre.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f6af3e1c2b93..d14b05f68d6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6530,6 +6530,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.17.1

