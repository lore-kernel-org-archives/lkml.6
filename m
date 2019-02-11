Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F13C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2172521B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899189;
	bh=XnDwgtogK5FyD2lkzMWK+WLy7f603dt/6uuDjoJz2rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H8+h6Rr5zQmS3lqMEnUoK+hWlvYXUWrol0FaPgs14lbtMIp2H02V8VPofGxK3pgkh
	 pHntMhN6HGMUGpNDequMK6hP/Kegs5o0LyT5J9nO8LIqjZ3q053J9iByYaoKjvrPv0
	 fgx1PIlw7XROoPMN9YmHcCUVy23Qm7PW+YjMjXN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbfBKPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388762AbfBKOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:54:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3355D20855;
        Mon, 11 Feb 2019 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896846;
        bh=XnDwgtogK5FyD2lkzMWK+WLy7f603dt/6uuDjoJz2rQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BakYRvJWQzkdD+MxZcAhf3NI2kgkyR2LuZlESBDm71Rbovul4sEzae3kn8dBZAfsG
         74iFH9deZkUz3swWcW+tpEbG84fxbW8Ng9Dkn/Q3Z+2muXzBjgBFZtF3GLNrvki6Nr
         1dLFcXNc3tG/Brm8oiMDkvPdPyRof/ztUnP3ImBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Soller <jeremy@system76.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 283/313] ALSA: hda/realtek - Headset microphone support for System76 darp5
Date:   Mon, 11 Feb 2019 15:19:23 +0100
Message-Id: <20190211141912.120357613@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

commit 89e3a5682edaa4e5bb334719afb180256ac7bf78 upstream.

On the System76 Darter Pro (darp5), there is a headset microphone
input attached to 0x1a that does not have a jack detect.  In order to
get it working, the pin configuration needs to be set correctly, and
the ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC fixup needs to be applied.
This is similar to the MIC_NO_PRESENCE fixups for some Dell laptops,
except we have a separate microphone jack that is already configured
correctly.

Signed-off-by: Jeremy Soller <jeremy@system76.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5572,6 +5572,7 @@ enum {
 	ALC294_FIXUP_ASUS_MIC,
 	ALC294_FIXUP_ASUS_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_SPK,
+	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6496,6 +6497,15 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
+	[ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6674,6 +6684,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1558, 0x1325, "System76 Darter Pro (darp5)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC233_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),


