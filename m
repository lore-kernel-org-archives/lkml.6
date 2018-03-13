Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuGW8gPySc92S3Fbw14cyDGNEisPOYkIKpgULnEx0hCQHrHvzS1cgae5945UP1F13+ne0ZN
ARC-Seal: i=1; a=rsa-sha256; t=1520955039; cv=none;
        d=google.com; s=arc-20160816;
        b=tuW9+eMscRkzzRgA2vYleExgXnoOVZo0agwiMVcc0RxcAtocJSU63hFKp4t/JNMg4w
         MBTeRgmfG0C/rYAzKZ0RZeaSlf8qbgZM5rwYJeGS85D9XbMKuwqZd6Y2O1DcmCnt7w7d
         NHxJVKoVfx/kfDyqKuy3U/nIdfBgWJ/SR8rPjgeOzPOsz0AOCXq5uHYfOWtq+MB9FmXt
         M6L/5lo22yH5UBaLEcc/lX2I/Z6iHnplSRBjxKGuc3yDJ7wzVXj4XxcqJJdwnWkhzCEQ
         rbejw570pnN11UfaGmeOVjzTuBsyTU+ygMR0SU06cMm+pMubq8z+LQK4N72wVCmVK2ZW
         Yd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YIc4XwpZyneC72dAn5Sfb7PqTF4iJ4wAJ7YxOUg8NWU=;
        b=oozsJ9hYPnV3f0f6IrYHZev1nDoIu47NTKTrZW9O4tFvzlxQ3EV9Wy27qR4/SWtzsx
         TPMfQOAQ2rvry5n/KnXDLkvfuUATVuwB7hzb/r65e7VYdoA1BiaCljdOswRC+8XyMoug
         32LvVzbEmcGSrRLHb1/ZbG4L2tn+95oPz0KRizRkpnMX1TRXfAFavI8YUEPBgvhYwQ3s
         Um0XFCnEFo0w+K5NDRU2LKWc5eaPpidND2OD6iZDm53b71EfJmCae21xxcZ3e94eBXFL
         faPreqVWy1yTfXlMaxtnGZhW4VvZ0VJfNa3gIqlVxbAml3Lu+1kOAD60ttoyUKAD1xBT
         ln7Q==
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
Subject: [PATCH 4.15 067/146] ALSA: hda/realtek - Add headset mode support for Dell laptop
Date: Tue, 13 Mar 2018 16:23:54 +0100
Message-Id: <20180313152325.905795457@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836950945436949?=
X-GMAIL-MSGID: =?utf-8?q?1594836950945436949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5363,6 +5363,7 @@ enum {
 	ALC274_FIXUP_DELL_BIND_DACS,
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
 	ALC298_FIXUP_TPT470_DOCK,
+	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6210,6 +6211,15 @@ static const struct hda_fixup alc269_fix
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
@@ -6263,6 +6273,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x0873, "Dell Precision 3930", ALC255_FIXUP_DUMMY_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
