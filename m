Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLw15sBtyVme316p5KS9Hz5uXkTxwoNZ/p/sGtrzpZuUtsXY+gqEfM8Ac7t28mOIbQBZPP
ARC-Seal: i=1; a=rsa-sha256; t=1520451591; cv=none;
        d=google.com; s=arc-20160816;
        b=v0Q5Ulb1Vn58LLb5a0mLb2Xk9pcW9NTcU1R4chUJcoVU7J3xcVDneeB95VjW2cWTBV
         P5yWaGj4Uy4A8dYlDrMbD/bHBmxlShyvtr6F9yZGZ22GnH0f/0Xp/BBlM/OWNrCwuQAJ
         bc/7w8fAe4evPiW4NEEeIJMHHADsHUBzNk8WQ37awSOI5Yf+I9Q5v2JxN+BsH+53Td0I
         VReLqX1Zb13hF1Tss/BFa2DTc6EisfYtfMKv2gL8lIQGMQPvXt5+dwU+U7axoDynhRiG
         FQnsJ+uSvZKedKKAGF7l2+zbreLRdDxcGpLtbA+ZNmJMhGJZ3kdxzSHODrIH7+VXlLWN
         GiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H9j9+t9aXueKryNkHsWQ13ZAiuEHLWK1Ctxm2lkV21o=;
        b=WeT/15cVNKKX1BiuBDycnWbS/PPgWhI4jozmiiN4yiSHhiMO1VYh8GJfLvlP/MnMeN
         CtYEUvqIufmORN63YP7tFCg7PckB4pMZ5CmN2eADFiuLtIOIPAw+GcWTG6LpaovwXpfx
         Y3qZ/mG5e+k0HAUszfXYPcv++uvDXgDpXEcH0GeRkTwQJ193tp6nxxeGk3efgAZhjZe8
         yH1txPc6b9NXexiAqGXRJEJBhyrMyLktBh4efRGA1W3S7G7reVzarsMM84k/VAR8F/mx
         PZm6ueRrZsoWqX7TPPjxysglmXSfSi7Av9d1o0UM9NY2CL9lknVUHe3U4COwm9h4amsw
         0Tqw==
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
Subject: [PATCH 4.15 013/122] ALSA: usb-audio: Add a quirck for B&W PX headphones
Date: Wed,  7 Mar 2018 11:37:05 -0800
Message-Id: <20180307191731.181870176@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309047915323810?=
X-GMAIL-MSGID: =?utf-8?q?1594309047915323810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
