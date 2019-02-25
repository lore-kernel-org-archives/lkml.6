Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85174C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524D920652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131023;
	bh=dIJR2nn057dslu2lzNU7MVlXDBA10qWhiqvO5TWxMIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KC7qupdw3fFFQ5k5rdWAv2X1C4uLpVJZulLZSx5Xwz4q3Mv4fgsjZwftVm0pABJ0E
	 RWHAYYexMh5snjZUhGFMvTdehG6O4SdQQo08eWRaZTCP7K3Ey6FA0YuI8+jeFGSnsb
	 S2/eiXTFApkDliTzf3nqTlEngEnB4Dg2gkoBFM2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfBYVbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731785AbfBYVbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA394217F5;
        Mon, 25 Feb 2019 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130262;
        bh=dIJR2nn057dslu2lzNU7MVlXDBA10qWhiqvO5TWxMIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wH0hoNWkk6LV0W3j57H4D44WpXrZr7pyOwPK1y0Fl/P0jYpwRseElmNoJXU8elHt3
         8DRkN9/hxLzrxykaZnmO33OEXNzOIK1XXcl2avzhZJkRHsmK6et19y32Dd89GWgGId
         yuKKJG+JcfzJa+77VNL0h08zbxxe9lPoAWT1USlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 017/183] ALSA: hda/realtek: Disable PC beep in passthrough on alc285
Date:   Mon, 25 Feb 2019 22:09:50 +0100
Message-Id: <20190225195057.609364492@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit c8c6ee611926685a7d753409e0a6e48b9e1b8748 upstream.

It is reported that there's a constant background "hum/whitenoise"
in the headset on the Lenovo X1 machines with the codec alc285, and it
is confirmed that if we run the command below, the noise will stop.
 sudo hda-verb /dev/snd/hwC0D0 0x1d SET_PIN_WIDGET_CONTROL 0x0

Then I consulted this issue with Kailang, he told me the pin 0x1d on
this codec is used for PC beep in, the noise probably comes from this
pin and we can also disable the PC beep in passthrough, then the PC
beep in will not affect other sound playback.

Fixes: c4cfcf6f4297 ("ALSA: hda/realtek - fix the pop noise on headphone for lenovo laptops")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1660581
Cc: <stable@vger.kernel.org>
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5601,6 +5601,7 @@ enum {
 	ALC294_FIXUP_ASUS_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_SPK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
+	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6534,6 +6535,17 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Disable PCBEEP-IN passthrough */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x36 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x57d7 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_LENOVO_HEADPHONE_NOISE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7215,7 +7227,7 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60130},
 		{0x19, 0x03a11020},
 		{0x21, 0x0321101f}),
-	SND_HDA_PIN_QUIRK(0x10ec0285, 0x17aa, "Lenovo", ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
+	SND_HDA_PIN_QUIRK(0x10ec0285, 0x17aa, "Lenovo", ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 		{0x12, 0x90a60130},
 		{0x14, 0x90170110},
 		{0x19, 0x04a11040},


