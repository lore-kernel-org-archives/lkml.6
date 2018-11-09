Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0216C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB27E2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIMN0JNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB27E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeKJJ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:28:49 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37985 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:28:48 -0500
Received: by mail-vk1-f193.google.com with SMTP id w72so811587vkd.5;
        Fri, 09 Nov 2018 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LYvSmhAETFxPgi5qIGtqVjz3X3AlDxnMgfh/bGnPQ94=;
        b=mIMN0JNQrQgl7K4HQ5+EyNTQyZ8HZ1RSFFpvxvs5ov7V0ah9Gze4GfR5bNQJXd4Pl7
         rDmWkw/bApYimZ+MtckL0nKn++yiTZe+FOXWKF4XMCYr+CX1h4FyjzDry4h52eRIEbHe
         7fAEYJMNjDkJyPJJcGmbnaec0BKADmZTqWdEp3lzm9Ka8hNogyVaBp4k+tkhhogzrk7g
         If9zOHVpQu2Yvv3TJaxJq4OJpN6KdmGDJeOfhoNtzmxh/vwGPmbjBecaLCudysWWfdBE
         uokl2u1shYYjlWDKOivqgWXKgZq9ctJcOdAnVe8lA5cWPvM5oGiFVp03zYTPvEAs9SZR
         VNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=LYvSmhAETFxPgi5qIGtqVjz3X3AlDxnMgfh/bGnPQ94=;
        b=BPvV5pgUyhTXpxePPSc+e79zYrYWsY3bwP3Bbimvgr8BcZDvVfKRIcXxsoIZRd82YB
         YKX4qsQywL6kXx/4FiGOSzjl+fBgy8PlkoPeguVnG+Q2V9V8eaztJdtXS7iH24w8e0Rd
         i1JQujvu4fkbUXoJgBsia5wWWwKHsNf/BfZLWE0LT3Eqsmsq+/RfG8kYmgX53PaO3QE/
         v+OMWGWbOIj8LCT3A7q3d3CLHRNC/HHqtFCxWdq3gvQtvC7MwJw8kYdlyaYgsqPnADL0
         6q/oEzWJaJKEsgLHDApGWS99s3Qr2EdzV4y7JcDNt7zW+byJXD/Cz6qcJdCFUC5Ufv/r
         CBPA==
X-Gm-Message-State: AGRZ1gJaiJHevJlhhPDHdtBzu7bjphrHHH8OCexoyoLvsCCxYxj0Kov0
        C3b2EdjoA0tFqsKVDCrAQA==
X-Google-Smtp-Source: AJdET5fysr5aC6zpZl7l6PC8YrJBcAwXDr8FQddovOp/GEow2THO95+j+Ck7KVkQD6CsoL4NUOdzhA==
X-Received: by 2002:a1f:9042:: with SMTP id s63mr4734227vkd.17.1541807155089;
        Fri, 09 Nov 2018 15:45:55 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id c71sm2395689vsd.9.2018.11.09.15.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 15:45:54 -0800 (PST)
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
Subject: [PATCH v4 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Fri,  9 Nov 2018 18:45:21 -0500
Message-Id: <20181109234526.4280-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181109234526.4280-1-ayman.bagabas@gmail.com>
References: <20181109234526.4280-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Huawei laptops come with a LED in the micmute key. This patch
enables and disable this LED accordingly.
This enables micmute LED for:
1. Matebook X (19e5:3200), (19e5:3201)
2. Matebook X Pro (19e5:3204)

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/huawei_wmi_helper.c | 47 +++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     | 14 ++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 sound/pci/hda/huawei_wmi_helper.c

diff --git a/sound/pci/hda/huawei_wmi_helper.c b/sound/pci/hda/huawei_wmi_helper.c
new file mode 100644
index 000000000000..7c91f914ffba
--- /dev/null
+++ b/sound/pci/hda/huawei_wmi_helper.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Helper functions for Huawei WMI micmute LED;
+ * to be included from codec driver
+ */
+
+#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
+#include <linux/platform_data/x86/huawei_wmi.h>
+
+static int (*huawei_wmi_micmute_led_set_func)(bool);
+
+static void update_huawei_wmi_micmute_led(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	huawei_wmi_micmute_led_set_func(spec->micmute_led.led_value);
+}
+
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	bool removefunc = false;
+
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!huawei_wmi_micmute_led_set_func)
+			huawei_wmi_micmute_led_set_func = symbol_request(huawei_wmi_micmute_led_set);
+		if (!huawei_wmi_micmute_led_set_func) {
+			codec_warn(codec, "Failed to find huawei_wmi symbol huawei_wmi_micmute_led_set\n");
+			return;
+		}
+
+		removefunc = (huawei_wmi_micmute_led_set_func(false) < 0)
+			|| (snd_hda_gen_add_micmute_led(codec, update_huawei_wmi_micmute_led) < 0);
+	}
+
+	if (huawei_wmi_micmute_led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
+		symbol_put(huawei_wmi_micmute_led_set);
+		huawei_wmi_micmute_led_set_func = NULL;
+	}
+}
+
+#else
+
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+}
+
+#endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 135c0826859b..5431dee40f4f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5374,6 +5374,9 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
+/* for alc_fixup_huawei_micmute_led */
+#include "huawei_wmi_helper.c"
+
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
@@ -5494,6 +5497,7 @@ enum {
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 };
@@ -5765,6 +5769,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_huawei_wmi
+	},
 	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5779,7 +5787,9 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x1e, 0x411111f0},
 			{0x21, 0x04211020},
 			{ }
-		}
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED
 	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6611,6 +6621,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED),
+	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
-- 
2.17.2

