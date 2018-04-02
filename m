Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeDBJ5k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:57:40 -0400
Received: from msr7.hinet.net ([168.95.4.107]:35305 "EHLO msr7.hinet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754196AbeDBJ5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:57:38 -0400
From: Jian-Hong Pan <jian-hong@endlessm.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Cc: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable audio line out on ASUS D640SA
Date: Mon,  2 Apr 2018 15:33:13 +0800
Message-Id: <20180402073313.13247-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGosTGxVL7eN4G3SN3DkYZtP5VsOjc1c9qseH7WkaLFd8vsVj8e3KY
        2eLKxUNMFpd3zWGz2HtG3+Lz9MuMDhwe+94uY/NYv+Uqi8fjt5vZPWY19LJ5bPjcxObxeZOc
        x6LvWQHsUayZeUn5FQmsGbv7XzAX/NesWDtxCXsD42elLkZODiGBaIkFD+ewg9hsAjoSS28s
        Ye1i5OIQEbjPKPHjXwcjSIJZQEviwOQbLCC2sICHxLGdG8BsFgFVifnn5wLZHBy8AtYS3zul
        QcISAvISu9ousoLYvAKCEidnPgErYRZQl1g/TwhiorxE89bZzBMYuWchqZqFUDULSdUCRuZV
        jCK5xRW6xbnFhrrGehmZeaklekC8iREYdCvi2Xl3MJ49aXiIkYmD8xCjAAejEg9v1s7ZUUKs
        iWXFlbkgce5DjJIcTEqivF2HDkYJ8SXlp1RmJBZnxBeV5qQWH2KU4OBREuHVvQ2U4y0uSMwt
        zkyHSclwcChJ8H66BZQSLEpNT61Iy8wpSS2CSJ9iNOboe9Hfw8xx7PK0HmYhlrz8vFQpcd5p
        IOUCIJMySvPgqmERfYlRVkqYdynINp6C1KLczBJU+VeM4kA/CPOaglVk5pXAnfMK6FImoEtf
        5B0AubQkESEFAPskVwlLAgAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ASUS D640SA desktop whose mother board is D640MB has
- two jacks which are a headphone and a mic on the front panel,
- three jacks which are a mic, a line out and a line in on the rear panel
- one internal speaker.

If I plug a headphone to the front headphone jack, there will be sound
through the headphone jack, and no sound through the internal speaker.
If I unplug the headphone from the the headphone jack, there will be
sound through the internal speaker.  And always no sound through rear
line out, when I plug a headphone or an externel speaker to the rear
line out jack.

Besides, I had checked and toggled the Auto-Mute Mode in alsamixer, but
the rear line out still was not working.  Then I checked the sound
settings in GUI, and found there was no "Line Out" could be chosen, only
the "Headphones" and "HDMI/DisplayPort".
However, system does know that there is an "Intel PCH Line Out".

[   10.089082] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   10.089083] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1
(0x1a/0x0/0x0/0x0/0x0)
[   10.089084] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[   10.089085] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   10.089086] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   10.089087] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   10.089088] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   10.089089] snd_hda_codec_realtek hdaudioC0D0:      Line=0x15
[   10.104387] input: HDA Intel PCH Rear Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[   10.104416] input: HDA Intel PCH Front Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[   10.104441] input: HDA Intel PCH Line as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[   10.104467] input: HDA Intel PCH Line Out as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[   10.104494] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input13

Consequently, I checked the pin widgets' default configuration values:
- Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
    Pin Default 0x01014010: [Jack] Line Out at Ext Rear

- Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
    Pin Default 0x02214030: [Jack] HP Out at Ext Front

Because the headphone jack (Node ID:0x1b) locates on the desktop's front
panel, not rear panel, I change the headphone jack's configuration from
primary chassis to separate chassis.  So, the configuration value of
Node ID:0x1b should be 0x22214030.
Additionally, I toggle the Auto-Mute Mode of Realtek codecs to “Speaker
Only” which makes signal outputs through line out jack when the "Line
Out" is chosen in the sound settings.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aef1f52db7d9..a066d84c6478 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1810,6 +1810,8 @@ enum {
 	ALC887_FIXUP_BASS_CHMAP,
 	ALC1220_FIXUP_GB_DUAL_CODECS,
 	ALC1220_FIXUP_CLEVO_P950,
+	ALC887_FIXUP_ASUS_AUTOMUTE_MODE,
+	ALC887_FIXUP_ASUS_FRONT_HP,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2044,6 +2046,24 @@ static void alc1220_fixup_clevo_p950(struct hda_codec *codec,
 	snd_hda_override_conn_list(codec, 0x1b, 1, conn1);
 }
 
+/* fix the default Auto-Mute Mode in mixer */
+static void alc887_fixup_asus_automute_mode(struct hda_codec *codec,
+					    const struct hda_fixup *fix, int action)
+{
+	struct snd_kcontrol *kctl;
+	struct snd_ctl_elem_value *uctl;
+
+	kctl = snd_hda_find_mixer_ctl(codec, "Auto-Mute Mode");
+	if (!kctl)
+		return;
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
+	if (!uctl)
+		return;
+	uctl->value.enumerated.item[0] = 1;
+	kctl->put(kctl, uctl);
+	kfree(uctl);
+}
+
 static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
 		.type = HDA_FIXUP_PINS,
@@ -2288,6 +2308,19 @@ static const struct hda_fixup alc882_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc1220_fixup_clevo_p950,
 	},
+	[ALC887_FIXUP_ASUS_AUTOMUTE_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc887_fixup_asus_automute_mode,
+	},
+	[ALC887_FIXUP_ASUS_FRONT_HP] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x1b, 0x22214030},
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC887_FIXUP_ASUS_AUTOMUTE_MODE,
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2321,6 +2354,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x13c2, "Asus A7M", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1043, 0x1873, "ASUS W90V", ALC882_FIXUP_ASUS_W90V),
 	SND_PCI_QUIRK(0x1043, 0x1971, "Asus W2JC", ALC882_FIXUP_ASUS_W2JC),
+	SND_PCI_QUIRK(0x1043, 0x2160, "ASUSPRO D640MB", ALC887_FIXUP_ASUS_FRONT_HP),
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE1601),
 	SND_PCI_QUIRK(0x1043, 0x84bc, "ASUS ET2700", ALC887_FIXUP_ASUS_BASS),
 	SND_PCI_QUIRK(0x1043, 0x8691, "ASUS ROG Ranger VIII", ALC882_FIXUP_GPIO3),
-- 
2.11.0
