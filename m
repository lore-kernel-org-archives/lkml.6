Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42583C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F5020851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqjxS+Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeLDL1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:27:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeLDK7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2AE820878;
        Tue,  4 Dec 2018 10:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921140;
        bh=RMqPb0/uLSaMd3RqDPGy7ypNKVCnuNFx2P/MfFax3fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqjxS+Jy9NnaPvbvgMozHBfGAxVKBN1X7zSp3x8wig+mdeKTodiU/2xIz5779tPFO
         500VyrmlysMIna5p/noGRPkoVCs5eMVmqH9/wDK8XKgYwcHab2DWnlbz+g50NJrj1x
         vR3Uk/1/1aUKGb7I7dTZN8f81UvH26SkpIL3jVdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 096/139] ALSA: hda/realtek - fix the pop noise on headphone for lenovo laptops
Date:   Tue,  4 Dec 2018 11:49:37 +0100
Message-Id: <20181204103654.341269777@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Hui Wang <hui.wang@canonical.com>

commit c4cfcf6f4297c9256b53790bacbbbd6901fef468 upstream.

We have several Lenovo laptops with the codec alc285, when playing
sound via headphone, we can hear click/pop noise in the headphone,
if we let the headphone share the DAC of NID 0x2 with the speaker,
the noise disappears.

The Lenovo laptops here include P52, P72, X1 yoda2 and X1 carbon.

I have tried to set preferred_dacs and override_conn, but neither of
them worked. Thanks for Kailang, he told me to invalidate the NID 0x3
through override_wcaps.

BugLink: https://bugs.launchpad.net/bugs/1805079
Cc: <stable@vger.kernel.org>
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5361,6 +5361,16 @@ static void alc274_fixup_bind_dacs(struc
 	spec->gen.preferred_dacs = preferred_pairs;
 }
 
+/* The DAC of NID 0x3 will introduce click/pop noise on headphones, so invalidate it */
+static void alc285_fixup_invalidate_dacs(struct hda_codec *codec,
+			      const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_override_wcaps(codec, 0x03, 0);
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -5498,6 +5508,7 @@ enum {
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
+	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6365,6 +6376,10 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC285_FIXUP_LENOVO_HEADPHONE_NOISE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_invalidate_dacs,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7038,6 +7053,11 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60130},
 		{0x19, 0x03a11020},
 		{0x21, 0x0321101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0285, 0x17aa, "Lenovo", ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x19, 0x04a11040},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0288, 0x1028, "Dell", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},


