Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELthrVHgGaYi59vjEsmNt7CPWFZI9eJK3gsdEa7AtCU+Rc0TR89VXykZ2tXvsUu+tyvTDXIO
ARC-Seal: i=1; a=rsa-sha256; t=1520955590; cv=none;
        d=google.com; s=arc-20160816;
        b=KYsn0UIqPMmxfgYWW4v477L6ZIFZ71jYb0MT5kGITBvosMZKLMLNeCJdfFG+Zrnsw+
         KvxWNjbvao7wQ9CqYny8nl0RPMxVxloC9sbZWodHiH+1KiHKU7uGDASNZtxUPbOjMpCz
         YtzqamnirpTWd8IyOs9BXK1dVyft+sXQy6xHsiy0XNx4iXL5cC6EbYbGLOTUxnEgfk75
         Pobw9PsOGf33QB0vzAmbK/bcmsNaKTjL1cfyMiTIxRAYfPI91Vk7j4C6ThcEl5A1r8PH
         v7pJojwumTwpA3dvdVNtF9oIlbotzK2A3r4NAl+R2IJpC8SDvDdQVDbOk7t3VDx1zpZ+
         SUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YOjl0fm+GRRGKdJojoVqvBGbY3i2KoYpls1GZ4pIkss=;
        b=eFGKdxtQC6ogy1/zQm69TXYQvDhGH2lUgFeHYcmFp9x+hiUZrR62VokWku6oFsms2k
         oPLKTauG1B30xBH7mtQUu7d5tHEDg3/2hMUEtLyB1Z1TEkhuNDci0LlizokB3wm3OYZn
         +Hfz3EPhmeTJZDZtB0q+lX0po6IfJL/suXlPKCREFdF9PiGMr3Al4t2hafwOeBsTC5X2
         i9TcAbt2sRwXhkkgQ28fGA3EA/rUAp30rzUoYGh85FffY0iNh5g12MmBbOTLrHtmyD4C
         z78fI6zKiuaDaGZLM+jSEL2hksaYc/gOXNHEM7wffWCH0QrX/edw0svQnrl31YDbcD1u
         n0Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 102/140] ALSA: hda/realtek - Add headset mode support for Dell laptop
Date: Tue, 13 Mar 2018 16:25:05 +0100
Message-Id: <20180313152505.002561006@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836950945436949?=
X-GMAIL-MSGID: =?utf-8?q?1594837528960620766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit ae104a21e52b1f9aab342cf6924405177b720069 upstream.

This platform was only one phone Jack.
Add dummy lineout verb to fix automute mode disable.
This just the workaround.

[ More background information:
  since the platform has only a headphone jack without speaker, the
  driver doesn't create the auto-mute control.  Meanwhile we do update
  the headset mode via the automute hook in the driver, thus with this
  setup, the headset won't be updated any longer.

  By adding a dummy line-out pin here, the auto-mute is added by the
  driver, and the headset update is triggered properly.

  Note that this is different from the other
  ALC274_FIXUP_DELL_AIO_LINEOUT_VERB, which has the real line-out pin,
  while this quirk adds a dummy line-out pin.  -- tiwai ]

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5340,6 +5340,7 @@ enum {
 	ALC274_FIXUP_DELL_BIND_DACS,
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
 	ALC298_FIXUP_TPT470_DOCK,
+	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6187,6 +6188,15 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC293_FIXUP_LENOVO_SPK_NOISE
 	},
+	[ALC255_FIXUP_DUMMY_LINEOUT_VERB] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x0201101f },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6240,6 +6250,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x0873, "Dell Precision 3930", ALC255_FIXUP_DUMMY_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
