Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJZuQvWVMy4Q5NleEX3bXeXJWtt8JtNS1K6fekEDZKE9QuuqaRtRfy9xBfbz/2mr0Vl/Gh
ARC-Seal: i=1; a=rsa-sha256; t=1520641140; cv=none;
        d=google.com; s=arc-20160816;
        b=Sg6zvTmVUZmMn9UDSse0naq3EKQV2PWft/1y0Sn3caw9RrZG5R/NEAGAKsntV4gsRP
         t394ouCBkXt4eYWbuLcfJArB/Fmoa/HJLqf2iU6CfPPHQQxGSqndEIzFJ5f06V4PyDKG
         vOiO5CVVkAiKqG8mcWayRPP/Ul3wmgU9hSmGCVzsl6wllT6N5cE9hHrr/sgsE7ya7Y+M
         0iZJ6yV2bzaRkgJ+XTtaIRL9c7Un9sMniPZ6UtsyFKsoNj/57fUN3mSgyZGcOIedjF1X
         Prym5ZXE+DR//vhh/jYCFqJZtdaRjBJoXZEnDiso1GtgladChed1+ZartbwOlwMHBbYl
         47Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QvaLQFPyuwZYX8pVENityyM7MVbuDMgE3PZCkUuoJpk=;
        b=lzoRZAj3h4nX9a9Em0pm+weVYc1uvkWBOb4u5FEhrhxEo9DiqWvQUoIdG4P51ff532
         igArPGXDHXGP3y8u6VBArazpxdgaVy3ekYFkjYjT8GZfIimFOHcy7kRC01F4GedsQExy
         E216CLnBhT+tnB6OPZ8RXciIgZg5y+JC1D7QRmzSzb0JaEc9doF25AJRSt/MH0jwpZO7
         /KWKR4ZKspN+9vA4wMXUw8SWKxzmu87nSPPvACCSE6a+kDFro4tYM04qvBAlNtpmmczi
         2aS7wRECV1zJIej6nUPWV1YQ0iUSMNVhZHOO+AOds2dtea523zbOLk3QGT9WAjclySWI
         rbbA==
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
Subject: [PATCH 3.18 03/21] ALSA: usb-audio: Add a quirck for B&W PX headphones
Date: Fri,  9 Mar 2018 16:18:25 -0800
Message-Id: <20180310001801.251260680@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507804511016917?=
X-GMAIL-MSGID: =?utf-8?q?1594507804511016917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3312,4 +3312,51 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
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
