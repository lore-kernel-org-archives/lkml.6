Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D830205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129620;
	bh=aw1bstVrd8IhvmHIOCDem8KZ0203m2iG69Tw1izAJ4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qki4n9JXrS+wowD7lkV6jx2qrR4V88BhldpjGqj4V1KIcMRyCH8UFs+InDx3t1vUz
	 YmeR94bNhAjclLKepnXpB/oSnajMOfGBPf+sCpmYWEVxcbgGVE0Pc0r+j91rTXfoS0
	 /s07cSNa/WIcdNdgGQ/zYBpaDM39jQODNtPLl0ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbfBYVUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfBYVUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9C0217F4;
        Mon, 25 Feb 2019 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129615;
        bh=aw1bstVrd8IhvmHIOCDem8KZ0203m2iG69Tw1izAJ4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7BsxAzkh7acyd6X/Ii4pN2ZstaArvXnbQYmTX/+MLKN+i602Q/b7eXcI4IV4Hxq7
         lNd+9Ev8fwyu38B5WfmQAdN9IT94q5LQCwV9f+5m4J9ly1ywfDryOpouGI9be06k0w
         ILy04Qk7IvVmUqLsSU5tJzAUaixwnW8q3QjJp/BI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Soller <jeremy@system76.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 013/152] ALSA: hda/realtek - Headset microphone and internal speaker support for System76 oryp5
Date:   Mon, 25 Feb 2019 22:10:05 +0100
Message-Id: <20190225195044.554727857@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Jeremy Soller <jeremy@system76.com>

commit 7f665b1c3283aae5b61843136d0a8ee808ba3199 upstream.

On the System76 Oryx Pro (oryp5), there is a headset microphone input
attached to 0x19 that does not have a jack detect. In order to get it
working, the pin configuration needs to be set correctly, and the
ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC fixup needs to be applied. This is
similar to the MIC_NO_PRESENCE fixups for some Dell laptops, except we
have a separate microphone jack that is already configured correctly.

Since the ALC1220 does not have a fixup similar to
ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC, I have exposed the fixup from the
ALC269 in a way that it can be accessed from the
alc1220_fixup_system76_oryp5 function. In addition, the
alc1220_fixup_clevo_p950 needs to be applied to gain speaker output.

Signed-off-by: Jeremy Soller <jeremy@system76.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1855,6 +1855,8 @@ enum {
 	ALC887_FIXUP_BASS_CHMAP,
 	ALC1220_FIXUP_GB_DUAL_CODECS,
 	ALC1220_FIXUP_CLEVO_P950,
+	ALC1220_FIXUP_SYSTEM76_ORYP5,
+	ALC1220_FIXUP_SYSTEM76_ORYP5_PINS,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2056,6 +2058,17 @@ static void alc1220_fixup_clevo_p950(str
 	snd_hda_override_conn_list(codec, 0x1b, 1, conn1);
 }
 
+static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action);
+
+static void alc1220_fixup_system76_oryp5(struct hda_codec *codec,
+				     const struct hda_fixup *fix,
+				     int action)
+{
+	alc1220_fixup_clevo_p950(codec, fix, action);
+	alc_fixup_headset_mode_no_hp_mic(codec, fix, action);
+}
+
 static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
 		.type = HDA_FIXUP_PINS,
@@ -2300,6 +2313,19 @@ static const struct hda_fixup alc882_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc1220_fixup_clevo_p950,
 	},
+	[ALC1220_FIXUP_SYSTEM76_ORYP5] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc1220_fixup_system76_oryp5,
+	},
+	[ALC1220_FIXUP_SYSTEM76_ORYP5_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC1220_FIXUP_SYSTEM76_ORYP5,
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2376,6 +2402,8 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1558, 0x9501, "Clevo P950HR", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e1, "Clevo P95xER", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e2, "Clevo P950ER", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1558, 0x96e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
+	SND_PCI_QUIRK(0x1558, 0x97e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Y530", ALC882_FIXUP_LENOVO_Y530),


