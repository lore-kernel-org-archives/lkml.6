Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C14C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA77120651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571290;
	bh=HbRdwNzhI2kooD0z4HgkvG0RwAj21jxM/gVZSimULH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZ5KdYI21DDzDQM5Vk+5Dg7upoAK7e3jPClJuTdzSYepUtpwIlEV7zmxgMRMhlZxI
	 U5s16XBdNANkl7FgviYftsYZ8Lch7a3GfWOP094Mk1XcrPYIphnkZTojVkB6Q+/zdG
	 4B94XyCIIyIL+37yAwvvJUIl8V2aDrhlRNFj2ZTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfAOQmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733057AbfAOQmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB5F2087E;
        Tue, 15 Jan 2019 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570564;
        bh=HbRdwNzhI2kooD0z4HgkvG0RwAj21jxM/gVZSimULH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjnRqACKVCV10KIssv09qjlUEloe5MfsWB45uZdqcZ0uYMqOUx09dl5RAjdLhFZAm
         s2KXAfl0X+mlGvM37gdZIU81vW5Ygv5ousEA9LrbcehDRW605KxdMDz/LI7W1Ei5Yb
         cIG7t39brKm8pQXbr32IB33G+pRwkG1bBb7C0feM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 08/50] ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC225
Date:   Tue, 15 Jan 2019 17:35:44 +0100
Message-Id: <20190115154910.476229703@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit d1dd42110d2727e81b9265841a62bc84c454c3a2 upstream.

Disable Headset Mic VREF for headset mode of ALC225.
This will be controlled by coef bits of headset mode functions.

[ Fixed a compile warning and code simplification -- tiwai ]

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5381,6 +5381,13 @@ static void alc285_fixup_invalidate_dacs
 	snd_hda_override_wcaps(codec, 0x03, 0);
 }
 
+static void alc_fixup_disable_mic_vref(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -5493,6 +5500,7 @@ enum {
 	ALC293_FIXUP_LENOVO_SPK_NOISE,
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
 	ALC255_FIXUP_DELL_SPK_NOISE,
+	ALC225_FIXUP_DISABLE_MIC_VREF,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC295_FIXUP_DISABLE_DAC3,
 	ALC280_FIXUP_HP_HEADSET_MIC,
@@ -6192,6 +6200,12 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
+	[ALC225_FIXUP_DISABLE_MIC_VREF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_disable_mic_vref,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC225_FIXUP_DELL1_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -6201,7 +6215,7 @@ static const struct hda_fixup alc269_fix
 			{}
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE
+		.chain_id = ALC225_FIXUP_DISABLE_MIC_VREF
 	},
 	[ALC280_FIXUP_HP_HEADSET_MIC] = {
 		.type = HDA_FIXUP_FUNC,


