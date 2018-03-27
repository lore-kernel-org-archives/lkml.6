Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ZQkn/RXZwnQ3AXkEsQWXOr33IkEGUUbfZ08ND8WIFDZxPwmw8+wSk7BgWKuUURY4gvJy6
ARC-Seal: i=1; a=rsa-sha256; t=1522168736; cv=none;
        d=google.com; s=arc-20160816;
        b=ypUZe+J/Yzg7hUAH6XJWNVrcJhxgfBzfkgKQoNQQGH/Q6Fu2FZ8+iePw7nQjbg3Lbf
         jGvOBZKkKoHf6hKG7mLUcFLhM+W8oN/YHrRcZynrqT98+MBmkhO+OHNa958vOEkFCFhQ
         5VPA2eS49lm6kG/NCwgKJ6LuBG3v0jdw8yo4KChnE2xXrhPLjuAmlwUk0/jGntYjAU9s
         0BnDIfkNkSB31iwYSj5ZaSMtRkxNVwO42UlTdIBucpdJO7ZmqxVVRXkH4U9x7zlgu2ZX
         kKWHSDoZPesG5zmSbRgaSeQ4ybLYELchtmUfkPaezvJzorEAGrjSo9+iOy4K1AGVHEQu
         NdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RJ6QdBm5T5Vk20DU3JTuk1exjVPz/4YeYZbd+zmvHN0=;
        b=0MJQf8K22nOj8QrU0S0oMTY0Xsbj85JAdzTNvFW1aULmfG0obcwkBt/K5Eky7k/9G+
         DPnBklntYLFDb0o94H8mOxr+GGNrUr1DPf9N+kTJfE/CU1iX2T3wyZSpNE6d4CmO1C0F
         9rYa4nSLfLua0RsAmfMcIGjIhZmuXokwhLi7IzmqeZ86BMwg0ZlAFq4Cm3JB2HzF+TBo
         lWyhTQ1bKOPb3KFgjs1h8kONehzwnY+8gxykSeUH4b1hMlxC5a87p9QHPPEcax0RzeNd
         mykPVD8XgIaQX4q11ij15UAfQT4wC1gRYkEsLRa8PXzhvpNeUPMlnOIHqEe5CRLFnd63
         jZhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 014/105] ALSA: hda/realtek - Fix Dell headset Mic cant record
Date: Tue, 27 Mar 2018 18:26:54 +0200
Message-Id: <20180327162758.445343517@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109296692074772?=
X-GMAIL-MSGID: =?utf-8?q?1596109604871896917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit f0ba9d699e5ca2bcd07f70185d18720c4f1b597c upstream.

This platform was hardware fixed type for CTIA type for headset port.
Assigned 0x19 verb will fix can't record issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5377,6 +5377,7 @@ enum {
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
+	ALC255_FIXUP_DELL_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6237,6 +6238,13 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
+	[ALC255_FIXUP_DELL_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6291,6 +6299,8 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x0871, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0872, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0873, "Dell Precision 3930", ALC255_FIXUP_DUMMY_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
