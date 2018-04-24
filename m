Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx49QIEsJOoLm/SstDZnfUvUf7dFOmGdkPsGqEkn11raoE++dwQ75+t+l+49zWsYt2gV62vnP
ARC-Seal: i=1; a=rsa-sha256; t=1524590698; cv=none;
        d=google.com; s=arc-20160816;
        b=qfSRsAuh/ADauLQJR//sjM83IV0uw83Z5x0gxDGs/UmjniGw4tGtdMjcgg7XGB/mdr
         K1v4IwNxTZK2d1cnWCtl/clUOJG3eoPVD3xwq6h9yq5vfbdjWYsGntx8RUBEuAJwNB2O
         9cGpdYBT9aprKX6u0Laa+WUxOX6Yi0xfS4Utued1+MNKn+FJg6SUD2LKDwvCnKmiyp+U
         Os/tLg2bygdO5ES3rcBDC6HX5X2+/xhTqIgK3a3dZ35pNGIfWiUUyQzrqarCWvKtKlRN
         o5B4OHLJQgFetoMOnbvXBvnSl03/pgG6P7h7CIzaYbrzcZbOY1ZfPKra9+idLDO3ZtMx
         Iv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ShQzqDcsHIGhHN/x3t70qMX14Fx+I1CLl8H7JFxXGYE=;
        b=Zu3cg5H6TpP96L8dQCSxSA33MtQCS99pA8WlSc5NI26chqyLopqqjeIHIVrTxZqk1s
         LOgcUgvaLTJdQ2d3qFPtmuo4wlLGOho2h5J+Sr05MR2AKAWcJnJtpNZaMU8OR42sJZ4m
         LbMX4WhC3faymY0bq14DNsZSqXNcHnQu7vvKApEsBh1vQ4nWmJYFm2FXuqzENYgMCbHg
         bkHRupjL1WX6h93VGF79aqOgzskPtGo2EmwU1fsygQynDsusFWYyWD3gS2SoqXvGYoxN
         j3zMBzYjbLd+OnR03IqO/rBEgaCAnl/maTWtol9APsj29avA51buhrFo1MAUwes8XvN7
         Hstg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 3/4] ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
Date: Tue, 24 Apr 2018 18:24:44 +0100
Message-Id: <20180424172445.31928-4-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285489825871167?=
X-GMAIL-MSGID: =?utf-8?q?1598649216156918452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
Hence, checking for pitch control as if it was UAC2 doesn't make
any sense. Use the defined UAC3 offsets instead.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/stream.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 956be9f7c72a..5ed334575fc7 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -576,7 +576,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 
 	if (protocol == UAC_VERSION_1) {
 		attributes = csep->bmAttributes;
-	} else {
+	} else if (protocol == UAC_VERSION_2) {
 		struct uac2_iso_endpoint_descriptor *csep2 =
 			(struct uac2_iso_endpoint_descriptor *) csep;
 
@@ -585,6 +585,13 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 		/* emulate the endpoint attributes of a v1 device */
 		if (csep2->bmControls & UAC2_CONTROL_PITCH)
 			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
+	} else { /* UAC_VERSION_3 */
+		struct uac3_iso_endpoint_descriptor *csep3 =
+			(struct uac3_iso_endpoint_descriptor *) csep;
+
+		/* emulate the endpoint attributes of a v1 device */
+		if (le32_to_cpu(csep3->bmControls) & UAC2_CONTROL_PITCH)
+			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
 	}
 
 	return attributes;
-- 
2.11.0
