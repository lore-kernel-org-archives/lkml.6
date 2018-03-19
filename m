Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521423967; cv=none;
        d=google.com; s=arc-20160816;
        b=lNQ9yMP6ogc9l05cEmRZNvFhDV7LStnTQhTl9QTmdow85/cAjjWr/ubPD3T37S6kfE
         Xklwc3BZ/96LH45JLLQLw6OeaMl2CHlBzPPz2vB5tmzpiCfxb2RGlGfrK/tEnVAuN00X
         uQz4GtRqSLwlmg8SJfmdK2kV1Lfa9jaTjzzxmYbnlAfBdbkI9Ozfmaj8IqXv1a2Uyaqd
         N6c3+s+IcTHXk6jBu4XCQZjoAPsU0UJXjpQsBzG+oGV1ZdwfJ7Y0PJ+yPhO/OUfwBNS4
         ENWaNa2Uca4UN1cxkYQiCUxDAr2Br33yKXPYmWBEdCA7ux6D9+oJpQOC+MCGqYBb55ej
         fBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bUEcsY+4AX/pbDwfDIJh9wPTZGgEnXm6cgL4+GDmVys=;
        b=c8slpAjb/yIv3T3qp6UO4zRzkHQanxc66Scuznn9/b2AeDIToCtwclmxlAvZI379mI
         Hp8iLArtg5Da8eNfdfxvGVBWNeQZsBHJN59ocXvj05JDmqu/BPh45xKKTg99RtbO+Ze+
         MrMHZbyfcfkwbYqs64cnI0giXLxm9cwOokYUAjb1NRfcrtcQloEDSxbZQs3rgJBE/j6E
         zOfbUUuxdiRYR+/pplJQVX1lx1awOKgeKKoVbXBHPevjRbZhNNk+h8GVcR6WOx/DPTIM
         w1vsR+5vO3lRhG/EvhyCZ4IfyMGOHxQqdhWYic3bbxUgBboOpjUQr2BPhcJChclV0tss
         X6VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aKF1iLaw;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aKF1iLaw;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuqkJarhGrlj7fb6IZABEsy7RIg4Kk1MNFoIxwV5N/tdU40qzqfMHkc1XqMK3PhkSkzy9/pQA==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ALSA: usb-audio: move audioformat quirks to quirks.c
Date: Mon, 19 Mar 2018 03:46:02 +0200
Message-Id: <1521423963-24677-2-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595328658262670421?=
X-GMAIL-MSGID: =?utf-8?q?1595328658262670421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Offload USB audio interface parsing function by
moving quirks to a specially designed location (quirks.c)

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/quirks.c | 34 ++++++++++++++++++++++++++++++++++
 sound/usb/quirks.h |  4 ++++
 sound/usb/stream.c | 30 +-----------------------------
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ea8f3de..eeea8e1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1403,3 +1403,37 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 
 	return 0;
 }
+
+void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
+					  struct audioformat *fp,
+					  int stream)
+{
+	switch (chip->usb_id) {
+	case USB_ID(0x0a92, 0x0053): /* AudioTrak Optoplay */
+		/* Optoplay sets the sample rate attribute although
+		 * it seems not supporting it in fact.
+		 */
+		fp->attributes &= ~UAC_EP_CS_ATTR_SAMPLE_RATE;
+		break;
+	case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
+	case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
+		/* doesn't set the sample rate attribute, but supports it */
+		fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
+		break;
+	case USB_ID(0x0763, 0x2001):  /* M-Audio Quattro USB */
+	case USB_ID(0x0763, 0x2012):  /* M-Audio Fast Track Pro USB */
+	case USB_ID(0x047f, 0x0ca1): /* plantronics headset */
+	case USB_ID(0x077d, 0x07af): /* Griffin iMic (note that there is
+					an older model 77d:223) */
+	/*
+	 * plantronics headset and Griffin iMic have set adaptive-in
+	 * although it's really not...
+	 */
+		fp->ep_attr &= ~USB_ENDPOINT_SYNCTYPE;
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			fp->ep_attr |= USB_ENDPOINT_SYNC_ADAPTIVE;
+		else
+			fp->ep_attr |= USB_ENDPOINT_SYNC_SYNC;
+		break;
+	}
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index b90c8b7..a80e0dd 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -42,4 +42,8 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 					struct audioformat *fp,
 					unsigned int sample_bytes);
 
+void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
+					  struct audioformat *fp,
+					  int stream);
+
 #endif /* __USBAUDIO_QUIRKS_H */
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d1776e5..dbbe854 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -678,35 +678,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		INIT_LIST_HEAD(&fp->list);
 
 		/* some quirks for attributes here */
-
-		switch (chip->usb_id) {
-		case USB_ID(0x0a92, 0x0053): /* AudioTrak Optoplay */
-			/* Optoplay sets the sample rate attribute although
-			 * it seems not supporting it in fact.
-			 */
-			fp->attributes &= ~UAC_EP_CS_ATTR_SAMPLE_RATE;
-			break;
-		case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
-		case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
-			/* doesn't set the sample rate attribute, but supports it */
-			fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
-			break;
-		case USB_ID(0x0763, 0x2001):  /* M-Audio Quattro USB */
-		case USB_ID(0x0763, 0x2012):  /* M-Audio Fast Track Pro USB */
-		case USB_ID(0x047f, 0x0ca1): /* plantronics headset */
-		case USB_ID(0x077d, 0x07af): /* Griffin iMic (note that there is
-						an older model 77d:223) */
-		/*
-		 * plantronics headset and Griffin iMic have set adaptive-in
-		 * although it's really not...
-		 */
-			fp->ep_attr &= ~USB_ENDPOINT_SYNCTYPE;
-			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-				fp->ep_attr |= USB_ENDPOINT_SYNC_ADAPTIVE;
-			else
-				fp->ep_attr |= USB_ENDPOINT_SYNC_SYNC;
-			break;
-		}
+		snd_usb_audioformat_attributes_quirk(chip, fp, stream);
 
 		/* ok, let's parse further... */
 		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream) < 0) {
-- 
1.9.1
