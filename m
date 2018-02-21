Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ffHNpiVL9qCkifcJJM7VTXt800sw7Ph4gwc2MPBe4AUOjyrXsDKd2Ue7MxXDkNs2Z2IPE
ARC-Seal: i=1; a=rsa-sha256; t=1519218330; cv=none;
        d=google.com; s=arc-20160816;
        b=uJIF8mHvYLzamhSLgOotgTgt1fmphDZ98z2IFB8KRaUF+qaSLMoATYRH1Ij4NRjClz
         agjZbKmBs8RW3zVgey7mIRT4+JymXjJMPSn27hoA+CvgMJd6kum8Kg42BVP+eNysOk//
         ERRQwTA94z/nOByhdKJQRFLrzHIQt0UfYoRr7KN+yDQcQtys9uS0hfU+m8G/7m+OskVR
         DTLHGk1Vw/cyz3ILe8Q0T1C3NlY2wBbyoqxefrPD/HbebxDUJ4A7lkU6zJdFZYk5gK3y
         RKeW7m0uJNSGcp2lYwF3iOkTskf8lVVOzcjS+mVEWs8Eabsg3waGH10dGwhTbQWjprdf
         IFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AMQjcLSz70PbfXpD7YIuqeu3XsCvL1jqDObnkBBuGG8=;
        b=LTmITp1ivAec+6iXhWlrYJ9kNSO70/GMlpH5f4KcpGZIjPv2zKbNm+3f3WJjWcdlqh
         gsfql1T4gDd8DjYvbmvteT+R9ju+w63ESvL2Fn96hWK17H8MWnKY9qvfULYSNSp5KuC0
         v98EdVn2rewOGlrs+JrVRlTHmXSFJ4iPSqrvztEAeYQgaLbZo09nbRu+jQ9NG4JEmNka
         57ylwTXdgPbjjh35+EOhvE1s0e6VO+6yFGsS2VLEdkXxXkNsXPkIFmKNAmbKt5gQJHvF
         akWx0yzubk6RDmgEvjQ+KnpzYlGHENDBvBoMy+C6xoPWULJMdjuWcjKjYKsZGMIYS6CC
         mrRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan-Marek Glogowski <glogow@fbihome.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 146/167] ALSA: hda/realtek: PCI quirk for Fujitsu U7x7
Date: Wed, 21 Feb 2018 13:49:17 +0100
Message-Id: <20180221124532.747878165@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014654795810271?=
X-GMAIL-MSGID: =?utf-8?q?1593015880162674824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan-Marek Glogowski <glogow@fbihome.de>

commit fdcc968a3b290407bcba9d4c90e2fba6d8d928f1 upstream.

These laptops have a combined jack to attach headsets, the U727 on
the left, the U757 on the right, but a headsets microphone doesn't
work. Using hdajacksensetest I found that pin 0x19 changed the
present state when plugging the headset, in addition to 0x21, but
didn't have the correct configuration (shown as "Not connected").

So this sets the configuration to the same values as the headphone
pin 0x21 except for the device type microphone, which makes it
work correctly. With the patch the configured pins for U727 are

Pin 0x12 (Internal Mic, Mobile-In): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x19 (Black Mic, Left side): present = No
Pin 0x1d (Internal Aux): present = No
Pin 0x21 (Black Headphone, Left side): present = No

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3355,6 +3355,19 @@ static void alc269_fixup_pincfg_no_hp_to
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 }
 
+static void alc269_fixup_pincfg_U7x7_headset_mic(struct hda_codec *codec,
+						 const struct hda_fixup *fix,
+						 int action)
+{
+	unsigned int cfg_headphone = snd_hda_codec_get_pincfg(codec, 0x21);
+	unsigned int cfg_headset_mic = snd_hda_codec_get_pincfg(codec, 0x19);
+
+	if (cfg_headphone && cfg_headset_mic == 0x411111f0)
+		snd_hda_codec_set_pincfg(codec, 0x19,
+			(cfg_headphone & ~AC_DEFCFG_DEVICE) |
+			(AC_JACK_MIC_IN << AC_DEFCFG_DEVICE_SHIFT));
+}
+
 static void alc269_fixup_hweq(struct hda_codec *codec,
 			       const struct hda_fixup *fix, int action)
 {
@@ -5228,6 +5241,7 @@ enum {
 	ALC269_FIXUP_LIFEBOOK_EXTMIC,
 	ALC269_FIXUP_LIFEBOOK_HP_PIN,
 	ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT,
+	ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC,
 	ALC269_FIXUP_AMIC,
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
@@ -5434,6 +5448,10 @@ static const struct hda_fixup alc269_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
+	[ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
+	},
 	[ALC269_FIXUP_AMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6308,6 +6326,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x10cf, 0x159f, "Lifebook E780", ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT),
 	SND_PCI_QUIRK(0x10cf, 0x15dc, "Lifebook T731", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
+	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
