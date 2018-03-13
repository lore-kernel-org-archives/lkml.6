Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvKCDexOhR3X0K82Gzl01NMpAwVkU4GuKTeT4jHQs/DL4tlkGH8Z++ruLgRC7jhzyPcK4R/
ARC-Seal: i=1; a=rsa-sha256; t=1520955596; cv=none;
        d=google.com; s=arc-20160816;
        b=GFRSrIXfM+gv/JzUa0Pf4ZSU/T0KS4ve+U8ye/rO2+l1iL2WeGa53CMHWmmLuIYyDh
         v9dCJ3QCdZO5pg0TFY/C2F3QQXy1MVRwBeyOsengR7DawlaVNbASYVk87paBgmVfaU9+
         aHIiasGfbkqzRNLmJmLWcP/cStC7N70X8u3lME/6Q6yrhIfUyMvTxS9RE/QSbkv/BTSL
         7XvB5uAs7tyH16vDuNQabP+Dgn+LdNnuIsZLuERDO65mz3geVWcgYjBzToRlHbuw5rj8
         2ekX2szX89cSjMkuubr7TdUjMJedp2rHS7HRzJzfQd3k2cBC+Tde5sW/HOmvrsO2C+6U
         foRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EViT7BJIcNkz6P/zp8OyML6ofNzjC4PZyjReA8d+JCk=;
        b=NoMoKcX2y4SnQDMAbeopqVi9B3+uCYBq+jZvl7VKONOgFlOv1REjvTi2UphjgMeodl
         ePsW7c6AdQBpTyFK8btbwHADDptbtqI6oP1URBi9pecR9A4gn7KHdM3NSmrxFPoIm7FV
         jRd6wqN8xmyWHX7G3leS+uodOwYhWwp1yMlJQ7WnKRQ9sx5OI1w2hWTK+9pWmtZjrw2v
         VnxzDNVhEXKC/dNKq587V28B5f68xG5HZZ5MOAVW/cX5vfZiUqAVKHF2dFwVrD8JSaLQ
         eKCuROYdqU+XnGRwyLipWw8PtaQmzpxVciRZUHHzhwv+/FnENf1PH4Pfu3OgZP1VFUgI
         GDYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 104/140] ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
Date: Tue, 13 Mar 2018 16:25:07 +0100
Message-Id: <20180313152505.138979979@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836979266801098?=
X-GMAIL-MSGID: =?utf-8?q?1594837535685347230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5129,6 +5129,16 @@ static void alc298_fixup_speaker_volume(
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
@@ -5321,6 +5331,7 @@ enum {
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
 	ALC255_FIXUP_DELL_SPK_NOISE,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC295_FIXUP_DISABLE_DAC3,
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
@@ -6055,6 +6066,10 @@ static const struct hda_fixup alc269_fix
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
@@ -6245,6 +6260,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x1028, 0x07b0, "Dell Precision 7520", ALC295_FIXUP_DISABLE_DAC3),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x080c, "Dell WYSE", ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
