Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EAF20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571492;
	bh=lhFk4Fw1Rl32wtgS4zsBFFgS4N9VU9SFIT1Wn6Mal+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uSyw94Ll5ZRMRMYqMgdymNIESv1+pF/RcpBqCoynUd3B5IvNlQMI2J+v+OcQOgm6z
	 plWxGi/cxJoD/XztsycRQRBnOCewvyiav531sUc1BQaCcR8HKtWBZAfpku5Ypj/GzE
	 3nax4mhoaosA8YtJ2TsBj2tjIlzrxvO6q0ZkAj9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbfAOQ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732541AbfAOQkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0AF20989;
        Tue, 15 Jan 2019 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570410;
        bh=lhFk4Fw1Rl32wtgS4zsBFFgS4N9VU9SFIT1Wn6Mal+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ji7rIL5T2LD04Sck3CGWdHG096yK3YFBJO3foXib8DX6tsOtL/6GPMct0ehngQcX2
         U/ZsfdswhI/0mWZ92e8sLfeM6CS64UMlmAGrb/QE5Qi9lJX6q0jbRzkCzFvM8jikHi
         ujBVVhPCr0VFxheCytrW4MJSAn4d54Ut8twGT71o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 05/27] ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC225
Date:   Tue, 15 Jan 2019 17:35:54 +0100
Message-Id: <20190115154901.516708275@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5253,6 +5253,13 @@ static void alc274_fixup_bind_dacs(struc
 	spec->gen.preferred_dacs = preferred_pairs;
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
 
@@ -5362,6 +5369,7 @@ enum {
 	ALC293_FIXUP_LENOVO_SPK_NOISE,
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
 	ALC255_FIXUP_DELL_SPK_NOISE,
+	ALC225_FIXUP_DISABLE_MIC_VREF,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC295_FIXUP_DISABLE_DAC3,
 	ALC280_FIXUP_HP_HEADSET_MIC,
@@ -6063,6 +6071,12 @@ static const struct hda_fixup alc269_fix
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
@@ -6072,7 +6086,7 @@ static const struct hda_fixup alc269_fix
 			{}
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE
+		.chain_id = ALC225_FIXUP_DISABLE_MIC_VREF
 	},
 	[ALC280_FIXUP_HP_HEADSET_MIC] = {
 		.type = HDA_FIXUP_FUNC,


