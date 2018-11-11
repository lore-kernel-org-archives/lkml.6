Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9412BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510D120817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNtKXfwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510D120817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbeKLIV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390159AbeKLIV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:58 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3AD21508;
        Sun, 11 Nov 2018 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975521;
        bh=jazk8uFbJyiXdDD7GiTr28MI+1FZBoCx3p6v8GaEjTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNtKXfwQ+Hxqi/I1X+/gxHq5nmxxkXKpR0UdGPWxtnaLGvCCjJ6RCWmLz9IiLw6R3
         afxnZt23wUAk/RsvzcaOGVDufj3aYHwoJv084syk7Kb+YDSV9dFCf0SjUte8JuNl9B
         t5pC9DkaNOHz+bHyNrFu4tPLAyTGQYPQFaWQS18o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 014/222] ALSA: hda - Add quirk for ASUS G751 laptop
Date:   Sun, 11 Nov 2018 14:21:51 -0800
Message-Id: <20181111221649.377450200@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 11ba6111160290ccd35562f4e05cec08942a6c4c upstream.

ASUS G751 requires the extra COEF initialization to make it microphone
working properly.

Reported-and-tested-by: Håvard <hovardslill@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7515,6 +7515,7 @@ enum {
 	ALC662_FIXUP_ASUS_Nx50,
 	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
+	ALC668_FIXUP_ASUS_G751,
 	ALC891_FIXUP_HEADSET_MODE,
 	ALC891_FIXUP_DELL_MIC_NO_PRESENCE,
 	ALC662_FIXUP_ACER_VERITON,
@@ -7784,6 +7785,14 @@ static const struct hda_fixup alc662_fix
 		.chained = true,
 		.chain_id = ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	},
+	[ALC668_FIXUP_ASUS_G751] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0xc3 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x4000 },
+			{}
+		},
+	},
 	[ALC891_FIXUP_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode,
@@ -7857,6 +7866,7 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x13df, "Asus N550JX", ALC662_FIXUP_BASS_1A),
 	SND_PCI_QUIRK(0x1043, 0x129d, "Asus N750", ALC662_FIXUP_ASUS_Nx50),
+	SND_PCI_QUIRK(0x1043, 0x12ff, "ASUS G751", ALC668_FIXUP_ASUS_G751),
 	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x15a7, "ASUS UX51VZH", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x177d, "ASUS N551", ALC668_FIXUP_ASUS_Nx51),


