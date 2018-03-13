Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLGWKWFnB0xTELDJjOTcLz9kmTlxDO7QP8wRJPkisxYSXpaEb/1xdhI07vbBRtqfu0hoNw
ARC-Seal: i=1; a=rsa-sha256; t=1520955036; cv=none;
        d=google.com; s=arc-20160816;
        b=goQBA7Dn1tXXoGEq+aZi3ztVu5566IJHjoQgEb6UB/2GAU5Iu5PCfv+jo0yJlkNZaK
         IbhdR1pEAZqT39HMEIEduZMLptnzpkYTKpiAqW+sNMAGTk8+2AUgYVRGdPyfwpjnRrKR
         yZQr1pBsrofearN3JEWiEb84Jgz/LijXr35Nethq8MnnE5SS8scni9D0UMEVCPK/0H2W
         QCC/Btg+uJpvO8c3/Ex/wApWL8MMPu4QTSg3L++TZqBz2ug76wZgaf2hIiy67J41lDR7
         WAEQGdawyDYOMKPFq74utZUD00PuxQ+OQw2soOLoXNEbzexIpAeyzDpM1SR0bMqjeBnv
         iPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6y8tqE74KMeB6mSNQRfx7RGeGq6qOETN3HKll+KcmiU=;
        b=JjlAIzCOUDdHDG+AeDALXMZd7ZL/UrUgdkCjU061baZm6r2s6844Ht6Dc+xcZnr2Z/
         W7qRQUc0/tbiWgeUSnaGJZsI9IGXZr5BIwYyqIxmAKm1GYjQOLjNXamU4wRuQgToclGA
         04hofEtjTSj1zkLjRTv9qCTjlP8sYNusSsdf//yH9g4ESN84r82NN7HyHzkU6+/fsIIG
         cpEZXir1IX6nRFDx+Ilxntmj0fmbtLWptFHWmdZVYjDg1Kyv7ZixiB8K1SVIZt6B8rQz
         2mhuRVqCyvM2oLOi9HYgfUb3GnyIYn7+XZiNZXWXcVfnOl2BjGmbZVEahQsSQKbQX7Xh
         V3Qw==
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
Subject: [PATCH 4.15 066/146] ALSA: hda/realtek - Add support headset mode for DELL WYSE
Date: Tue, 13 Mar 2018 16:23:53 +0100
Message-Id: <20180313152325.781477915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836948109180933?=
X-GMAIL-MSGID: =?utf-8?q?1594836948109180933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5358,6 +5358,7 @@ enum {
 	ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE,
 	ALC233_FIXUP_LENOVO_MULTI_CODECS,
 	ALC294_FIXUP_LENOVO_MIC_LOCATION,
+	ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE,
 	ALC700_FIXUP_INTEL_REFERENCE,
 	ALC274_FIXUP_DELL_BIND_DACS,
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
@@ -6161,6 +6162,18 @@ static const struct hda_fixup alc269_fix
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
@@ -6246,6 +6259,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
+	SND_PCI_QUIRK(0x1028, 0x080c, "Dell WYSE", ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
