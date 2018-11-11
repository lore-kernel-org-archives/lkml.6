Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA13C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D32214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwsYmS2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D32214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeKLEwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:52:39 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44267 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbeKLEwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:52:39 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so3873569vsd.11;
        Sun, 11 Nov 2018 11:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7EQF8aiVp4wCM6g9rpSc/ejfi5n9RkugfYkCozhrrA4=;
        b=rwsYmS2XIPfEJ91jANC0bZpLHs4s8BL/tvgqmIcQsoY+2OrTav7bnlwHBMhdbCpAX0
         GFu3+haiTl7K3ArWhXynbIyWy9+qgbnZqTVPJp9TWX9pnjCgnPmu/P9HA47uenMaF4mV
         mGpi64lO/1JG0adsRgnyz8VaDoaoigHpQ7wTAEEYCfsT0qtLXttplr0ppRUPjNDP/lq7
         QiEe3tYbfvi2czVHotUJHDTyb7kgwueiPx5urZM9ja8a5WpO2ZMFdro1YlYHJvOdUw8e
         5+iPZgSNbly+qOgkqyuwUSz0lA93kBV/vBtOy9fcYDha7EmgMvY57nTRI8nbp9XLJ/Uz
         Kp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EQF8aiVp4wCM6g9rpSc/ejfi5n9RkugfYkCozhrrA4=;
        b=oneNvNa0aDunMaCZKiaSckqlzopqUVAF6+yHsZSZw8rYdxc/Wga84GIgv61RsI7CHI
         X6jcsEbsungAWMpKKYlA+d9fTET6dvffZRJPAMra55FfqvG+iIR0bda7dfhISzFzL2F2
         DaZpP12jTE1GJZhrINDAwmcmd79aahqiGN4kGW7Ul54RtsZ/gIBKLtDqRVMtaJ86bTF+
         gSxYf7Ls1qcnFsJrxfJDfuWkN1/zOahsVwg97wn8Xd/BE4kgrYz/JfLCdE8hsvK1AF8i
         duBAWZsDfmj2JReuwsXWQWzdhCGA/inoqdQOXj3xWU97Ve3rcRtC5ipcQRAUvjuZSCcS
         smlg==
X-Gm-Message-State: AGRZ1gKhlKlsuUDm8Edgp3P2rRB5bSiTJd42wlVu8cZIsemJv7e2DOqi
        WdhXStFbBNMq+88orvKAyQ==
X-Google-Smtp-Source: AJdET5ds1bS7Rto4k6U4lXPO46+dDiix9FXxGT1OsC2yJ8H4NA6Sp7WobipKkUcRrkjHN7Vu32tgJQ==
X-Received: by 2002:a67:6849:: with SMTP id d70mr7163460vsc.199.1541962998187;
        Sun, 11 Nov 2018 11:03:18 -0800 (PST)
Received: from localhost.localdomain (c-71-226-66-69.hsd1.ga.comcast.net. [71.226.66.69])
        by smtp.gmail.com with ESMTPSA id o8sm4048168vkf.4.2018.11.11.11.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 11:03:17 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v5 2/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Sun, 11 Nov 2018 14:02:44 -0500
Message-Id: <20181111190250.6055-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111190250.6055-1-ayman.bagabas@gmail.com>
References: <20181111190250.6055-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves bug 200501 'Only 2 of 4 speakers playing sound.'
https://bugzilla.kernel.org/show_bug.cgi?id=200501
It enables the front speakers on Huawei Matebook X Pro laptops.
These laptops come with Dolby Atmos sound system and these pins
configuration enables the front speakers.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fa61674a5605..135c0826859b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5493,6 +5493,7 @@ enum {
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
+	ALC256_FIXUP_HUAWEI_MBXP_PINS,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 };
@@ -5764,6 +5765,22 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60130},
+			{0x13, 0x40000000},
+			{0x14, 0x90170110},
+			{0x18, 0x411111f0},
+			{0x19, 0x04a11040},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x90170112},
+			{0x1d, 0x40759a05},
+			{0x1e, 0x411111f0},
+			{0x21, 0x04211020},
+			{ }
+		}
+	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_x101_headset_mic,
@@ -6594,6 +6611,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
 #if 0
-- 
2.17.2

