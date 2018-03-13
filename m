Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuiZYp5zIM5DDPX9jSzdSVKZKzevIxQMzr0UVasBYIJanqzPnxb3EvuXXmLL275IAnsDArH
ARC-Seal: i=1; a=rsa-sha256; t=1520955065; cv=none;
        d=google.com; s=arc-20160816;
        b=lanyaJfTIjf8GjhjthsQ5rClfOzQPTlgrgSDQtR8h7UchE2PE6SvpKPxdvncm7atKC
         9FgA6daA7AAyUn3iO2cfmsP/edTHkCRUaI3rfEf19eoSnoY6ID+MBpmaI2Fp0JVaHShD
         IFtJz+sS/HVM6o5mN5npfGjYM/YO0y+D6ZRQM5yi/uJHqZL6IsI9Cc+XrlwTpICHL+B0
         tdnCXpYTtoLub0YtJr3uAbZjMzf9QDuSNntq6i7juJPVT0KwHvVCWqFg2kzFvKHt7prt
         Dq0yUPljxg3usQUyYXEQkvtXPkNg/z12seBZCxpVBn637sZQp/vWrFCq5CI7f0xNIrBq
         WBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BOuzddrBKmraR4VIm6vUhBpdVSKvMkku8B6PoJZ9/1A=;
        b=e6Onb3tqDKSOHdizSU0oD1zWpLO1zjvdNBBWtKbTx+kEyvCqKGh6s3rEx2OiscVpds
         77JIWTTn9rhlZ7cYXCU8FR3ii0mhkFMEpaKsKWtZBYfTTezM3ImWXfj3fhizMJ5IuRRZ
         w9Cl+VEJAjFOF0A/myH+qn1UP1yYj868ODWVlYEiMgWsrTQNOnC/D0Vgqec4R2qNrPR4
         iKIduZNApdg4pEyWIaoQWF+BSzSuYjV0MmIqrmVxbCeKHb6g+O9dCs8heR0PDdEvqwPJ
         rHOGdLaNxTVrjJh+qRrjbF/os2AtPL7lxJc7jL7+cUD3vAZcY2Lb7wfNPkIkLqgQVRiA
         GA8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 069/146] ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
Date: Tue, 13 Mar 2018 16:23:56 +0100
Message-Id: <20180313152326.050379537@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836979266801098?=
X-GMAIL-MSGID: =?utf-8?q?1594836979266801098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e312a869cd726c698a75caca0d9e5c22fd3f1534 upstream.

The dock line-out pin (NID 0x17 of ALC3254 codec) on Dell Precision
7520 may route to three different DACs, 0x02, 0x03 and 0x06.  The
first two DACS have the volume amp controls while the last one
doesn't.  And unfortunately, the auto-parser assigns this pin to DAC3,
resulting in the non-working volume control for the line out.

Fix it by disabling the routing to DAC3 on the corresponding pin.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199029
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5152,6 +5152,16 @@ static void alc298_fixup_speaker_volume(
 	}
 }
 
+/* disable DAC3 (0x06) selection on NID 0x17 as it has no volume amp control */
+static void alc295_fixup_disable_dac3(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		hda_nid_t conn[2] = { 0x02, 0x03 };
+		snd_hda_override_conn_list(codec, 0x17, 2, conn);
+	}
+}
+
 /* Hook to update amp GPIO4 for automute */
 static void alc280_hp_gpio4_automute_hook(struct hda_codec *codec,
 					  struct hda_jack_callback *jack)
@@ -5344,6 +5354,7 @@ enum {
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
 	ALC255_FIXUP_DELL_SPK_NOISE,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC295_FIXUP_DISABLE_DAC3,
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
@@ -6078,6 +6089,10 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC298_FIXUP_DELL_AIO_MIC_NO_PRESENCE,
 	},
+	[ALC295_FIXUP_DISABLE_DAC3] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc295_fixup_disable_dac3,
+	},
 	[ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6268,6 +6283,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x1028, 0x07b0, "Dell Precision 7520", ALC295_FIXUP_DISABLE_DAC3),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x080c, "Dell WYSE", ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
