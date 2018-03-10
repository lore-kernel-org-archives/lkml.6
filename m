Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvxKA78N3zw2H1ozn3iMzgPF3nR5fW6jfLGupi5c6cePP5O50BDA1C/1Xg6tBNxCpyvl+aX
ARC-Seal: i=1; a=rsa-sha256; t=1520641216; cv=none;
        d=google.com; s=arc-20160816;
        b=BoVgQZEOfZs2BWj+/7sNNVX+/j4RTug4OG0zTBRLH8TJ78vTt+naLT9a4zMJQHWiK0
         fwkVhi/VVhbmQpFA7E3rPSQuhRT3Bo5pz2p2Bko5cmUNiWldbA34S51A1bCixz/LT+hn
         9LOymBSXL4yJQjTcQaSiPAEEA+8R/Zbg8apVvaiF/Yhi64vpz/zMtEFBL1z6J9PzC4Q1
         5iwiusN5pewGB06d7un8F6wqO6ZgBW91Lzrk7ZpvpdbZLO/MniMm9pDrSIj65iG+rHEn
         gY5IChoAJyf/uLWTJzjdzDIMSjGxavX838oeO7cFj7UFKM2uqBsIlaf33PrTB3hHi0K9
         rOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hpa+03HJNnvVeZt4O7i7IqrrSJtJpCd1FOIJlC9ddPA=;
        b=vmHwsGdjhyY2xGJJpC6ivPbf8yJgI6GtW6rZl99WJNQvol71v4s36NXN7C8l60ZSZ4
         XMQfVZdxBiWLqIcC6Hp5ZvOtDnae6MivTliLT7ZWAe615Rg3PyPUMubcltVSSn9r6Gw3
         Z0USweahJDqgwuXcipuhvUjcG9ML/mnEwX1nJOrzqtZHwflJbe97966J5/jBols5SuQD
         u6qpK6R28H6BC9MBOfya69a5Cn+tvIlg4+gVVOi2OSzSc4Hy6ZoTrA7scOzxRt66Ktzn
         fowLdd1Wo+BUc0MoaxNNY/uR6zaqwlD6AECOsQmBPBZn1gjzeTA1GmlkuLiUPSYEXNOf
         CfUw==
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
Subject: [PATCH 4.4 04/36] ALSA: usb-audio: Add a quirck for B&W PX headphones
Date: Fri,  9 Mar 2018 16:18:20 -0800
Message-Id: <20180310001807.437629481@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507804511016917?=
X-GMAIL-MSGID: =?utf-8?q?1594507884007202960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
