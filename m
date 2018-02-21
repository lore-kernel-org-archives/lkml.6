Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224BiXqKOo0pTwqJhUC4xGt7ulMLTiADP5vSZFsp4EACHorIScnxwqT267Bhpx+mWEVWCq4q
ARC-Seal: i=1; a=rsa-sha256; t=1519218736; cv=none;
        d=google.com; s=arc-20160816;
        b=eP7fz7iPBCp0JMC86Xcf/19yMRQQnd/lbl1g14MgIyZi9ezLlSt8lGZZDkQON2bcav
         aNTtVo71DGmXmVpJIb0jgTpm4tOit+xfBWQ1VKWrNNkFbFDgq5OBLasJ0znH1XCcS9mW
         GHq8COaME6riCJNdYwaDyQLopjS8yuZNuC9ZB+CblmyrB9byo0/MGj0Zi+I2mz4su7gh
         rpPuN3aE1n6xRzyn/rXsQ0Jhust6/v5zpUjAl3ILLJmQ13pxz/H4EONIUaB/eo3/1E4A
         SXEbgMPZlhXic2Hlj5ZS4TXwNtoCCa9OqwPTqCb8iiCkwIUe/KXKCqQAQWM4qHFIJ+II
         7NWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=srCxAjr6YOpKPWRSoH2dBLdEr5ViU6Y7+GmKnerE6tQ=;
        b=QB1+YAhbEaH5AwvpJ1uwQeDwA3+yQb6oEXom3z6Al4xmyiXEDNFO5r+wlABnlvjjkq
         3Dqqh7PnBJbRDV4f9XEV/AbV9/Upi8Dks43FFxT1p2hfDp/wq+itABH02DxEFt1sOHtr
         fVSA02Pchpf/egXK3dHbRSk8AALIuleWS4Q4IuzAGRH7EM8CnN4Ar0Ti3D2j8VxWsD3g
         MQ+sLBuvL8qkRfQMDIZqt9tKocvH1YJ793TbOjzufOyXeUgPwVZeKP9AEQLXsxo06jsL
         ZKvw4UVpJcwjUoMiSjeeIGbKAhqvSS7ijjP95anLVett1mOa9wScSkIQRmhqaryXLXP1
         3mxA==
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
Subject: [PATCH 4.15 146/163] ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform
Date: Wed, 21 Feb 2018 13:49:35 +0100
Message-Id: <20180221124538.141492175@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015231097340128?=
X-GMAIL-MSGID: =?utf-8?q?1593016305183096951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 61fcf8ece9b6b09450250c4ca40cc3b81a96a68d upstream.

Thinkpad Dock device support for ALC298 platform.
It need to use SSID for the quirk table.
Because IdeaPad also has ALC298 platform.
Use verb for the quirk table will confuse.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4850,6 +4850,28 @@ static void alc_fixup_tpt440_dock(struct
 	}
 }
 
+static void alc_fixup_tpt470_dock(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x17, 0x21211010 }, /* dock headphone */
+		{ 0x19, 0x21a11010 }, /* dock mic */
+		{ }
+	};
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
+		/* Enable DOCK device */
+		snd_hda_codec_write(codec, 0x17, 0,
+			    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0);
+		/* Enable DOCK device */
+		snd_hda_codec_write(codec, 0x19, 0,
+			    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0);
+		snd_hda_apply_pincfgs(codec, pincfgs);
+	}
+}
+
 static void alc_shutup_dell_xps13(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -5324,6 +5346,7 @@ enum {
 	ALC700_FIXUP_INTEL_REFERENCE,
 	ALC274_FIXUP_DELL_BIND_DACS,
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
+	ALC298_FIXUP_TPT470_DOCK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6149,6 +6172,12 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC274_FIXUP_DELL_BIND_DACS
 	},
+	[ALC298_FIXUP_TPT470_DOCK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_tpt470_dock,
+		.chained = true,
+		.chain_id = ALC293_FIXUP_LENOVO_SPK_NOISE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6330,8 +6359,16 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x2218, "Thinkpad X1 Carbon 2nd", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2223, "ThinkPad T550", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2226, "ThinkPad X250", ALC292_FIXUP_TPT440_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x222d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x222e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2231, "Thinkpad T560", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC292_FIXUP_TPT460),
+	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
@@ -6352,7 +6389,12 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x5050, "Thinkpad T560p", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x5051, "Thinkpad L460", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x5053, "Thinkpad T460", ALC292_FIXUP_TPT460),
+	SND_PCI_QUIRK(0x17aa, 0x505d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x505f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x5062, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
