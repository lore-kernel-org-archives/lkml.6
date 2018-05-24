Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo66ZMnAprGSjI2IoZpFayEZ5q6NxNKfc4PkmTjyob94tm9z2IeaoPARcDgucNhMT47F7eH
ARC-Seal: i=1; a=rsa-sha256; t=1527156201; cv=none;
        d=google.com; s=arc-20160816;
        b=wPeR3raY2LIAbDHCceeWa+RiRXBrxUTeZaMJ+rrsz/HjjFfelR3JMLT3XWb0IrRauv
         59kQ9ApOAriubhSdgAlFGVG7l6YKsPD+UdNtFCT5plQCrfl6s+ulsMdxuAC7CoeJzWZD
         59m8q+sGXoo63rngtuluY3NJ2rovLWLaGi0k297RfrcP8x/f+T+Qu7bkFHQn1DzYI1AZ
         kDme+tWg1mnuF5vWA9kF10XEilA51aBsmNPo0/aWFb22D4+mgFGqxxXTdO/uOBUOiTKg
         qAwo0jhHhgyuWyZjtXXn5Ce3M/20wvs2gfFqXKiOtq1TS1qAXVfx8/X7MHuM5pudZmOc
         TMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=goknbT0x9FXz9fFHgmful1npY6YVd4HP09CTOe63GZg=;
        b=V63+sH3L1nkjDVLXfOfhBCKUgKUqkEQArx8TK+15qhZYcTF3+9CYgl0EGMkh1R7Y0M
         HzH7sMjEaBcC98kd2ykFx+q8fOOlpZtrEn5BiZrdeFWZytiCWxDqHcSXwxh6W2Dv05+a
         16K9jG35UjmVbIODJdF6iSIM9bwXfofZukXGe8g+ozIOC/bMYbwXoxsk/JUDLeUZ5/FK
         Mf1BJLnA4FhdCfUrNBMxhImh/Qh54lakkxBXyX86ATt7RNb3/WWwBk8XPDHj2FbxbBj3
         Mqy/ko5q7sCyHsGKJZOJhe0GI3jMcObS2wwrOJGyDcPiv+OMrr86Ijgq5HZfpYJ2aZL8
         +xmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eHZFOU20;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eHZFOU20;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nobutaka Okabe <nob77413@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 067/161] ALSA: usb-audio: Add native DSD support for Luxman DA-06
Date: Thu, 24 May 2018 11:38:12 +0200
Message-Id: <20180524093026.525201453@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338392140395852?=
X-GMAIL-MSGID: =?utf-8?q?1601339340674360811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nobutaka Okabe <nob77413@gmail.com>

[ Upstream commit 71426535f49fe6034d0e0db77608b91a0c1a022d ]

Add native DSD support quirk for Luxman DA-06 DAC, by adding the
PID/VID 1852:5065.

Rename "is_marantz_denon_dac()" function to "is_itf_usb_dsd_2alts_dac()"
to cover broader device family sharing the same USB audio
implementation(*).
For the same reason, rename "is_teac_dsd_dac()" function to
"is_itf_usb_dsd_3alts_dac()".

(*)
These devices have the same USB controller "ITF-USB DSD", supplied by
INTERFACE Co., Ltd.
"ITF-USB DSD" USB controller has two patterns,

Pattern 1. (2 altsets version)
- Altset 0: for control
- Altset 1: for stream (S32)
- Altset 2: for stream (S32, DSD_U32)

Pattern 2. (3 altsets version)
- Altset 0: for control
- Altset 1: for stream (S16)
- Altset 2: for stream (S32)
- Altset 3: for stream (S32, DSD_U32)

"is_itf_usb_dsd_2alts_dac()" returns true, if the DAC has "Pattern 1"
USB controller, and "is_itf_usb_dsd_3alts_dac()" returns true, if
"Pattern2".

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1149,24 +1149,27 @@ bool snd_usb_get_sample_rate_quirk(struc
 	return false;
 }
 
-/* Marantz/Denon USB DACs need a vendor cmd to switch
+/* ITF-USB DSD based DACs need a vendor cmd to switch
  * between PCM and native DSD mode
+ * (2 altsets version)
  */
-static bool is_marantz_denon_dac(unsigned int id)
+static bool is_itf_usb_dsd_2alts_dac(unsigned int id)
 {
 	switch (id) {
 	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
+	case USB_ID(0x1852, 0x5065): /* Luxman DA-06 */
 		return true;
 	}
 	return false;
 }
 
-/* TEAC UD-501/UD-503/NT-503 USB DACs need a vendor cmd to switch
- * between PCM/DOP and native DSD mode
+/* ITF-USB DSD based DACs need a vendor cmd to switch
+ * between PCM and native DSD mode
+ * (3 altsets version)
  */
-static bool is_teac_dsd_dac(unsigned int id)
+static bool is_itf_usb_dsd_3alts_dac(unsigned int id)
 {
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
@@ -1183,7 +1186,7 @@ int snd_usb_select_mode_quirk(struct snd
 	struct usb_device *dev = subs->dev;
 	int err;
 
-	if (is_marantz_denon_dac(subs->stream->chip->usb_id)) {
+	if (is_itf_usb_dsd_2alts_dac(subs->stream->chip->usb_id)) {
 		/* First switch to alt set 0, otherwise the mode switch cmd
 		 * will not be accepted by the DAC
 		 */
@@ -1204,7 +1207,7 @@ int snd_usb_select_mode_quirk(struct snd
 			break;
 		}
 		mdelay(20);
-	} else if (is_teac_dsd_dac(subs->stream->chip->usb_id)) {
+	} else if (is_itf_usb_dsd_3alts_dac(subs->stream->chip->usb_id)) {
 		/* Vendor mode switch cmd is required. */
 		switch (fmt->altsetting) {
 		case 3: /* DSD mode (DSD_U32) requested */
@@ -1300,10 +1303,10 @@ void snd_usb_ctl_msg_quirk(struct usb_de
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
-	/* Marantz/Denon devices with USB DAC functionality need a delay
+	/* ITF-USB DSD based DACs functionality need a delay
 	 * after each class compliant request
 	 */
-	if (is_marantz_denon_dac(chip->usb_id)
+	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
@@ -1390,14 +1393,14 @@ u64 snd_usb_interface_dsd_format_quirks(
 		break;
 	}
 
-	/* Denon/Marantz devices with USB DAC functionality */
-	if (is_marantz_denon_dac(chip->usb_id)) {
+	/* ITF-USB DSD based DACs (2 altsets version) */
+	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)) {
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
-	/* TEAC devices with USB DAC functionality */
-	if (is_teac_dsd_dac(chip->usb_id)) {
+	/* ITF-USB DSD based DACs (3 altsets version) */
+	if (is_itf_usb_dsd_3alts_dac(chip->usb_id)) {
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
