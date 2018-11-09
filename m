Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEDDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DD72081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFf8nQUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DD72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeKJJ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:28:40 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35709 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJJ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:28:40 -0500
Received: by mail-vs1-f66.google.com with SMTP id e7so2062209vsc.2;
        Fri, 09 Nov 2018 15:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7EQF8aiVp4wCM6g9rpSc/ejfi5n9RkugfYkCozhrrA4=;
        b=NFf8nQUUw/Z337jkMOUIYf9dpcoa2TEL7t+3snk8MolZ6xTF4+3rb3+Zul7MCjOInv
         IKKVIP9/SDXP4990dBSkAaHK0vfVyIu1oD52J21vbiXg9kDvADhpfQ4sLzIBdDIwNFZq
         icqrohpNYnebinb0i+Zc/WGwV6Y9gH4UmqSCjyD8ouKdP/jsVnXwctVu8LD6u4/TpNd3
         LMZknDIaSlRwDLSEjPBS8pXTNCnMolnkH97UDuSFumFNngTFZFsbwotFgHvK6N1xZtpF
         xFIp/kHnBG4bOKnL7Ur64EDUMWENuDgpEmt1TcG/r/0uC2sqMqb82HdUuK51fxWPcSX/
         1V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7EQF8aiVp4wCM6g9rpSc/ejfi5n9RkugfYkCozhrrA4=;
        b=Uk07qww5KKVZ4e3KzSsQkx94B2fhjw21MM5q8IS6hVf+L3p8egkNr/abRKTh1IjAxv
         glFfCLDVrjGpbPaElXaFfpo/MURPlkcLxH+NXBbdqbwFBBBIeoNLPx7Bm7cRXiVP0ZQV
         nsAHk3JF+Oh1QAYSxW85yiN7awbEHdTyFi4gkIzNj52u2BgKx554T0HrovfJFmt78iRV
         joCxgZ+KjU23DLr/v4OMfTkOiy4ORExuzNIMQ0bARS7oOnWzZdIk/li4j48bBjn4+jCy
         LNSPzN9vnFOImdwhVmY5lb2VmqNdLkJ1DeXN0imQHZevn4AHN7xJMHrg89Z29bfsdjqy
         7T1Q==
X-Gm-Message-State: AGRZ1gJOuuo5Xajmr/gIbpAQ5+C8ojhwEPT1oYjvpFxOXsC+neeIQKbm
        vyAs99tghzQDDT6xR1CLcA==
X-Google-Smtp-Source: AJdET5c2R30MGT4MyN3+rz6s8cuZWb9LGkunYyfMT9rkr1Mw6BTcHd8NjTgGzo8Gq2VipvEjgIE+Xw==
X-Received: by 2002:a67:34c4:: with SMTP id m65mr4693258vsi.192.1541807146838;
        Fri, 09 Nov 2018 15:45:46 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id c71sm2395689vsd.9.2018.11.09.15.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 15:45:46 -0800 (PST)
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
Subject: [PATCH v4 2/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Fri,  9 Nov 2018 18:45:20 -0500
Message-Id: <20181109234526.4280-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181109234526.4280-1-ayman.bagabas@gmail.com>
References: <20181109234526.4280-1-ayman.bagabas@gmail.com>
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

