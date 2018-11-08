Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF00ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8721B20817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNJBhSMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8721B20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeKICyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:54:03 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33062 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:54:03 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so12059727vsc.0;
        Thu, 08 Nov 2018 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AMw79WFDGo/up7GIOLU1VAUkcjaGvL1OiVLYSaic0QQ=;
        b=NNJBhSMiyvjH6JqapwYt5yJ5wO09MqHjO4QfASzKLfh6e3Q9ap5tPcH4uNbDyreze8
         acCq0pcFO47yN3PxwRCcZDHuxhYrFFpPl4/Tbh8cjk/x2UnscxZwgmXSnJYOVENy0Ive
         BgGIAWuFxSi111Pdw5t3AQ1N+FhF8DkYMA37I7RTMMCXJW56jjb2J8xUaZ3ue92aNRk7
         PaJ4V0uPLiNLxj/sOUZ1QiKbBftGusYt+i2QkXWC8k+PHgvdvwCxyHS/oyf4Q4r0iWhz
         uaKxSGyM1wW7GLjgalCeW8+eJtq1hFs5xrCs5hnZhBG7C80UkrMESHO/ZStLrhok2Ozu
         JaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AMw79WFDGo/up7GIOLU1VAUkcjaGvL1OiVLYSaic0QQ=;
        b=kXw8UkTCkAobVHY9cWkpEHWqRUsoOZJzC6T7udzeyVq/KM7wJXfHyDI9tuOfDFH3eu
         exP0FN3QmI7YY9GmmNqsYIU4rJdhQehEpb1JQbDQT6cWYd21Gi7Ixq+a7WvZYNgW53ih
         xfwGj9eHkwXlutGKVwm9vwSV9RhRuEvlT/cbh/Mzb6rCbBfj1fOz3nRZld7YlQEAxyOW
         E0WlqCParJVlCwvMBmkQeIWbycoWAjFUepmiUVmAvzdF77tWOegxrQ4UyNK2dBBT3ko5
         7Hxk9LSdmk9/oIkpB/ha7EK4HST4VwAiHUG8IAL1YDKA6lZR7R2iQ/0gSoPW/6Vz4Vk/
         n3cQ==
X-Gm-Message-State: AGRZ1gLLkA6sZ4B6e2d+IBg76ryW2CTvMAePC8cNWvLn54s66GAWbcSV
        NiJJJ4HOQ7yuq4kpiUmKxw==
X-Google-Smtp-Source: AJdET5eMD/qZYzGYWDImLpF/phzPQ9le0wYT6R3nRO1YiFQM9RGd704kLymliXkQDWW7EufFr1D7NA==
X-Received: by 2002:a67:c29c:: with SMTP id k28mr2360321vsj.130.1541697454935;
        Thu, 08 Nov 2018 09:17:34 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id y195sm1792776vkd.0.2018.11.08.09.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 09:17:34 -0800 (PST)
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
Subject: [PATCH v3 2/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Thu,  8 Nov 2018 12:16:54 -0500
Message-Id: <20181108171701.4444-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181108171701.4444-1-ayman.bagabas@gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
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
index fa61674a5605..ed6c9c79ce46 100644
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
@@ -6592,6 +6609,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
-- 
2.17.2

