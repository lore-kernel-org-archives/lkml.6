Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsuDfvkYPQPbC2VgpjoZY5GgtjB7XCOFbYMN9PRBVz9YCNa4EuW3ZTAJLoRXIz8m0zZpAsD
ARC-Seal: i=1; a=rsa-sha256; t=1520955602; cv=none;
        d=google.com; s=arc-20160816;
        b=WTS7oncALYFP+QfDwolhF9vmozLgmQiV62iSOZjGEc4XfttWwrG2sStEju8R/NQqyX
         eNvHzRjHH/Z/Seo5ghBNRKcdGEX/KkmpADwFLg/MFY7xrfM2c1uoFjNmSpFQpaWz0kLz
         hVjwKkoUYL4yJ9f4IygT5vu8I1YywAVtYXpgb2yaCY8Z1PnWRD+TNAH/DQ7atkLiRdjX
         MB1WUEPB9v/ZCHHhcK1MEhMXVmDnUPpUj6mvPQ6saNZ8YGUIXKxKeH7kio7dqYgwLNmA
         Mk1GCW/jHFfmblOa6V1jwLxBO2V7y9q+Q43yce/d+RiYoB/0eWegzUd09j4+S3XsaEHS
         LQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SO0Ca4DFVGYkqBt1m2uBR5IL9bqdM1ShvkIvMbZCKwo=;
        b=HxvBIC3Pzq8ukI6CnLYl1SX1A9/Sj0i9rNA+EQC7RiwVV3bz3aJE4yiK88FxKHgp9h
         b2etfVc162WUjV//FJYbujfFM1WxVqsk4OSMeYZcQM5Kielnnud9BTh2VFtoDbkh5/Be
         74y/tHmiVU8NrKeiytH1K7sQ55iEfJc3YS32dC9Z7x2HsLKwnNQHaKorKNUmA5qn5wVk
         kpsCEZ7t//ZriTeQoMcI8I+YNNyzyVaGhaGPaTXbk8JQHsg5nGzlv5hjHF9DOz3qqb2Q
         tTgyOjG36/ccyvkaoU4uaDGL6xn0FV6izBved0j3PedO9yoQiKz+BvE5P4UWrDlVfUNQ
         nBlQ==
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
Subject: [PATCH 4.14 101/140] ALSA: hda/realtek - Add support headset mode for DELL WYSE
Date: Tue, 13 Mar 2018 16:25:04 +0100
Message-Id: <20180313152504.951732213@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836948109180933?=
X-GMAIL-MSGID: =?utf-8?q?1594837541553306779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 5f36413526677b11d3226ebf064f471894ea2e5d upstream.

Enable headset mode support for WYSE platform.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5335,6 +5335,7 @@ enum {
 	ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE,
 	ALC233_FIXUP_LENOVO_MULTI_CODECS,
 	ALC294_FIXUP_LENOVO_MIC_LOCATION,
+	ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE,
 	ALC700_FIXUP_INTEL_REFERENCE,
 	ALC274_FIXUP_DELL_BIND_DACS,
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
@@ -6138,6 +6139,18 @@ static const struct hda_fixup alc269_fix
 			{ }
 		},
 	},
+	[ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x16, 0x0101102f }, /* Rear Headset HP */
+			{ 0x19, 0x02a1913c }, /* use as Front headset mic, without its own jack detect */
+			{ 0x1a, 0x01a19030 }, /* Rear Headset MIC */
+			{ 0x1b, 0x02011020 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 	[ALC700_FIXUP_INTEL_REFERENCE] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -6223,6 +6236,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
+	SND_PCI_QUIRK(0x1028, 0x080c, "Dell WYSE", ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
