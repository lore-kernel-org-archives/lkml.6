Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsHWQIcWbKL0hgwriU9QQt6pla1c6EcoXeg8z7dnB+//zKC4cP9BuQ2ojwVivzJqTAU+bpl
ARC-Seal: i=1; a=rsa-sha256; t=1520451873; cv=none;
        d=google.com; s=arc-20160816;
        b=u9JemBs6oROSx2jh7CdQypXkrMXrslBN7QiXQ0fL6jeOxJTWtVHC4hgqAqy2XjmunU
         iN9kCnrAQJjETXgCxianwgLvKdLn6BgtUFHOUqirYTGiAJ8q9Ssm65o26g0LyEFN8+5H
         64wKzdcGvFLh8kLFKM1SnXW1OT2AdvuBkdUK2HErSkZUP3voUcmrws9mnTnXP1W2Ffhn
         2S1S87G97uELc0+EmXAvdrpRRTgxurGQ1gpFWLXOrEpqZAQ5LPcjizjSZBhO2cU/uBA2
         oJi3gJTOT18dQ7/zbPFe8a5pjjzrsZStN+59bXp7rqeYO7Nc6A9As9GSImnrYntEvyGI
         vJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/QgoGylc0WyA/QYL+oKqwZecEDphpBhP2hIcGDbxQb0=;
        b=xMCDYONWTNbCy2+lt4d01pxi77qr5tdqj3kkGRfy5+EVGicnxJDtf0UI50V4w7eniY
         OUM05mHY+tQqT/mkYVGIBTCT//BD+WkS4OUuNljZWhXaxGHRRcPB3Ap0k3qws72GgvVH
         GhIWoLe9M5h7yK0Mg3jl3h7T+f4iczNafgOE5J6Q5f/Sl6DGQCij0i8UmJDuWQ5CCNP6
         H8KgXKvrDSX2p4wWqFKfvNpN2JF2Rq40QGBcPA+I6/EaxPYY5MRyqmrwqzMVpkYQtkTF
         oe/GJLz5K/xrOIMQ3rn6kTN8aZw96PNGCJqOMDNo7BdwVGCOXBZSMPSX8l4ufTZXbbYH
         bNBg==
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
Subject: [PATCH 4.14 010/110] ALSA: usb-audio: Add a quirck for B&W PX headphones
Date: Wed,  7 Mar 2018 11:37:53 -0800
Message-Id: <20180307191041.068515722@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309047915323810?=
X-GMAIL-MSGID: =?utf-8?q?1594309343548143395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
