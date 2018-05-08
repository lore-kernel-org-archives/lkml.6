Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbeEHRUz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:20:55 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37573 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeEHRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:20:51 -0400
X-Google-Smtp-Source: AB8JxZpgfKvFbKRL+RGGTniB5rumiOn4Wdj+hFLQSPjcoQJQI2mCLwNGlcYqMcZUorz80YHW6DvWaQ==
From: Connor McAdams <conmanx360@gmail.com>
Cc: o-takashi@sakamocchi.jp, Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/13] ALSA: hda/ca0132: Add PCI region2 iomap for SBZ
Date: Tue,  8 May 2018 13:20:03 -0400
Message-Id: <1525800015-2920-4-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525800015-2920-1-git-send-email-conmanx360@gmail.com>
References: <1525800015-2920-1-git-send-email-conmanx360@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds iomapping for the region2 section of memory on the SBZ.
This memory region is used in later patches for setting inputs and
outputs. If the mapping fails, the quirk is changed back to QUIRK_NONE
to avoid attempts to write to uninitialized memory.

It also adds a new exit sequence to unmap the iomem for the SBZ.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 02238fe..78d2c26 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -29,6 +29,9 @@
 #include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <sound/core.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/pci.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_auto_parser.h"
@@ -760,6 +763,11 @@ struct ca0132_spec {
 #ifdef ENABLE_TUNING_CONTROLS
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
 #endif
+	/*
+	 * Sound Blaster Z PCI region 2 iomem, used for input and output
+	 * switching, and other unknown commands.
+	 */
+	void __iomem *mem_base;
 };
 
 /*
@@ -4696,6 +4704,8 @@ static void ca0132_free(struct hda_codec *codec)
 	snd_hda_sequence_write(codec, spec->base_exit_verbs);
 	ca0132_exit_chip(codec);
 	snd_hda_power_down(codec);
+	if (spec->mem_base)
+		iounmap(spec->mem_base);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
 }
@@ -4911,6 +4921,15 @@ static int patch_ca0132(struct hda_codec *codec)
 	else
 		spec->quirk = QUIRK_NONE;
 
+	/* Setup BAR Region 2 for Sound Blaster Z */
+	if (spec->quirk == QUIRK_SBZ) {
+		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
+		if (spec->mem_base == NULL) {
+			codec_warn(codec, "pci_iomap failed!");
+			codec_info(codec, "perhaps this is not an SBZ?");
+			spec->quirk = QUIRK_NONE;
+		}
+	}
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 	spec->mixers[0] = ca0132_mixer;
-- 
2.7.4
