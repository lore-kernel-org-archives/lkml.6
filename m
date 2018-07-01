Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEC9C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D6E2587D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D6E2587D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeGASH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:07:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965716AbeGAQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:28:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D25E192B;
        Sun,  1 Jul 2018 16:28:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 097/101] ALSA: hda/realtek - Fix pop noise on Lenovo P50 & co
Date:   Sun,  1 Jul 2018 18:22:23 +0200
Message-Id: <20180701160801.036082559@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit d5a6cabf02210b896a60eee7c04c670ee9ba6dca upstream.

Some Lenovo laptops, e.g. Lenovo P50, showed the pop noise at resume
or runtime resume.  It turned out to be reduced by applying
alc_no_shutup() just like TPT440 quirk does.

Since there are many Lenovo models showing the same behavior, put this
workaround in ALC269_FIXUP_THINKPAD_ACPI entry so that it's applied
commonly to all such Lenovo machines.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Benjamin Berg <bberg@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4473,7 +4473,6 @@ static void alc_fixup_tpt440_dock(struct
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->shutup = alc_no_shutup; /* reduce click noise */
 		spec->reboot_notify = alc_d3_at_reboot; /* reduce noise */
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 		codec->power_save_node = 0; /* avoid click noises */
@@ -4835,6 +4834,13 @@ static void alc280_fixup_hp_9480m(struct
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
+static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	alc_fixup_no_shutup(codec, fix, action); /* reduce click noise */
+	hda_fixup_thinkpad_acpi(codec, fix, action);
+}
+
 /* for dell wmi mic mute led */
 #include "dell_wmi_helper.c"
 
@@ -5350,7 +5356,7 @@ static const struct hda_fixup alc269_fix
 	},
 	[ALC269_FIXUP_THINKPAD_ACPI] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = hda_fixup_thinkpad_acpi,
+		.v.func = alc_fixup_thinkpad_acpi,
 		.chained = true,
 		.chain_id = ALC269_FIXUP_SKU_IGNORE,
 	},


