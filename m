Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELun6lFUziNGnJGc8momqrsTDfh38G83SRBxGbwi1gbRMiUc2tmaUnbRsxbyUAr1Lry9K+y9
ARC-Seal: i=1; a=rsa-sha256; t=1520641298; cv=none;
        d=google.com; s=arc-20160816;
        b=a6hPMoWf1X9UCZqLTIKoP1cL4fVEd9tfW2UiT1RNFj1/PwviXgplm3zAiWJEx8RZqh
         VjjaqTBBHA6rgWl130iugvxVUj2VmvvaXwM0jgyWKYpW5rySNeny8CRU3L2KXfHtOO8V
         5TkvJGWWC88X3I6+CNWnHVXaD2NiTs+JrACcXyledYkKwgCD1qubJJyd0sIYB/KsnnuE
         hCZTM9PLOS6QhoO+/HzTgjtIne0uRDDlSwwiR3qnlSRRMboEb+QrnEowLQ0Hm9GBA4xF
         80VGFOoRoCU9slOiOLYA8V/m1QBZ/LzMx88euio0Ecr7e+huc0vuy2NridLuBtPNxCh7
         yvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MqZt78qu28qEJ1tIK8DB9SpgqglGRYnKsTakrMQBWw4=;
        b=fESpqmWcWyi+pqHh+DiMe+gUSf2dsbpLNro2b6aQ60/MoCaSRy8SN0ktXXElpqovIp
         Wf6i/Xk9EYOFEr5AX+gg1qmgdyo7juOGAm1t1FLWA92f912rCdMHljDp6emLUykvOGFW
         u39RH1decxK4+Hi3/Ds3p4iECmU4/tTFgNTtxjYyMnxONkkVy7pzZ8ZhSxir59Lg1/wl
         q8r2MackX9htr5bmu7zImXPpCM8dh7ytsIH6K5DAqvM47xAMNeit9vU7rJmu+Z8W+5eI
         uhGVIryzWeKUX8io6Sa/GkOuJrxt9txKFepQM+uYpynHz4hLRuEVUjieEYqIDWyIF53b
         LhzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Erik Veijola <erik.veijola@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 08/65] ALSA: usb-audio: Add a quirck for B&W PX headphones
Date: Fri,  9 Mar 2018 16:18:08 -0800
Message-Id: <20180310001825.591385700@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507804511016917?=
X-GMAIL-MSGID: =?utf-8?q?1594507970676730183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Veijola <erik.veijola@gmail.com>

commit 240a8af929c7c57dcde28682725b29cf8474e8e5 upstream.

The capture interface doesn't work and the playback interface only
supports 48 kHz sampling rate even though it advertises more rates.

Signed-off-by: Erik Veijola <erik.veijola@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3277,4 +3277,51 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 	}
 },
 
+{
+	/*
+	 * Bower's & Wilkins PX headphones only support the 48 kHz sample rate
+	 * even though it advertises more. The capture interface doesn't work
+	 * even on windows.
+	 */
+	USB_DEVICE(0x19b5, 0x0021),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			/* Capture */
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			/* Playback */
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 2,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_FILL_MAX |
+						UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x03,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
+					}
+				}
+			},
+		}
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC
