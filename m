Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224SCh00sVjuLvdT3s3OdYGse+D/3kaA2kxaInr30n6FK/nxwMU0zw2LOwxXIQGCTPoW3s9l
ARC-Seal: i=1; a=rsa-sha256; t=1519217162; cv=none;
        d=google.com; s=arc-20160816;
        b=Cdmx3j9nxscuApoxmC5zawyKIC2+tOvMH9StpLDKUiAkOfJ5bdppNoBq2pPANphDUp
         MMK6cmfc7aPEk3bSvOdOu0trDGswfJOZepEVna06rUnoEtiFiY2KkjRNQmHt1k2jZzmx
         1bxDVivPX6k0y/bYZBuo2fE9zDG91OXVWUwF0yI0qtdBjAsqiWjWGBvts6rBTsECoP65
         mG3tdg9ZLSpSl2rIuyX95VQsVkdkmBGj/eLw/hMD9vpJwYQ2hA8A2iV7MlMrgexJHnIT
         ojgpPyH2KNZLfXV1vYFAI/jzn/5E+0hAopnaq0b4GYAU4RlOfVTcRsjGT8tHgQUkduxV
         4MMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dcUC3Vue9sK+rDeLPJmJ6oLndkRzCGVJc6JYAb8zlLA=;
        b=ofjM3NMDiGpP+l8nwVMEls4kuwltHJSmyIpVKFT2hdMosLsXVTvdrbgUUEa+QojHcq
         c90fhCkjDVX403co8Xg6N3mfEE1iaIpCq6PTv02sBo4ELIXlu82KadRQQra5BeuLjarA
         q0VM69kMRoKb/RFLFFkTlpxgh1U0/0TXUjdrB5NBwlJHFJs4QMerIT1QxolZWiHqY712
         HLDzNshAGDMnheG/Gi+DO76eiAxnKtAh+L0C2FCQi0ASjtbbWoL96UsXObywEEvBySFg
         8+ctf/jQE/obSy+cL7C1Voy09jvkQoDwl8dwckj88zyKJyLnT1utv6gkaf+sSxNDYE5A
         mfCg==
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
Subject: [PATCH 4.4 24/33] ALSA: hda/realtek: PCI quirk for Fujitsu U7x7
Date: Wed, 21 Feb 2018 13:45:07 +0100
Message-Id: <20180221124410.885606546@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014654795810271?=
X-GMAIL-MSGID: =?utf-8?q?1593014654795810271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3130,6 +3130,19 @@ static void alc269_fixup_pincfg_no_hp_to
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
@@ -4782,6 +4795,7 @@ enum {
 	ALC269_FIXUP_LIFEBOOK_EXTMIC,
 	ALC269_FIXUP_LIFEBOOK_HP_PIN,
 	ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT,
+	ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC,
 	ALC269_FIXUP_AMIC,
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
@@ -4972,6 +4986,10 @@ static const struct hda_fixup alc269_fix
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
@@ -5687,6 +5705,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x10cf, 0x159f, "Lifebook E780", ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT),
 	SND_PCI_QUIRK(0x10cf, 0x15dc, "Lifebook T731", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
+	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_BXBT2807_MIC),
