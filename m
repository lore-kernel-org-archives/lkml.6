Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523658285; cv=none;
        d=google.com; s=arc-20160816;
        b=QMVv3AkDoqUotpv03ubOeUqb0WRo7Hb4IHHlGeuzLvtUJTJiAMvL3ywZZcuWFpsOWR
         YQyqM9FpSkcL0LaXOgl4XfW8WPtzSRpN0ozIZUPwdu/FFwPPCrE00auDINtCGUYCQvZ0
         +dD1VQIrX8bACEQT1/mUPTj8e1GgKCVocrdQ5McQWiW/CFQv+JUoP7b3winusCmZf4c2
         qxZsGuknCYKts/M9iuXg/zMNRv/N47YFXi9dY+l/vwJOvhyRhITowzH+gJ/C3hEdgks8
         luEl2yS2a0Kg09SJOwysUkZznTUKOxXDHQsxVUj1YAAc4VrLxaoC7DoO+m7ez9BiDPy8
         0+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=7NoS2qPIT10HjdIf1i9AOYCOZQJ/0RemsaOpsXR8Swk=;
        b=Pjftk9cbA4AC2zavBRtjKt3krL25RAWWf49/Djvwcw1MW/xH1zSkPxWK2D8W8Zhx6B
         WH9X4yYCMFKbD2NJn19IYN8y3zlnQ6GQITxN+hcCxsSmkV3k4vK3FjNXitaHNua9VW67
         QkG9Ib1aX5VgCcjaxHue3PhY6N/Vn5ATf8Ow9AtVEtdZI9a+HpHBOXIL6P4aSOCiVCzE
         TVZmZh9DdcD1vywgQ2yTnAIlLmo9mu/XwmZrlDifxVUSkg7DgzkOX8+hHWaSwFOHoWrW
         QIu4eGXKE2hCl9Admj7Q/m2hvByfqau0WfovMLKLMncjjYz3xP61pk5ABTrdUYIGol/a
         CebA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M7vryjld;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M7vryjld;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+wcVB35nXy2CAejAvDV49Lh5A6OqAVJuOvOk83uA3G0XMhvr9Lmzpy5BJDtGpHTHf47bCcbg==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ALSA: usb: Only get AudioControl header for UAC1 class.
Date: Sat, 14 Apr 2018 01:24:25 +0300
Message-Id: <1523658266-2259-4-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671510128708966?=
X-GMAIL-MSGID: =?utf-8?q?1597671510128708966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>

The control header needs to be read from buffer at this point only
in the case of UAC1 protocol. Move it inside the switch case as other
protocols such as the Basic Audio Device spec will have an empty buffer
that is latter filled as inferred.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
[Ruslan: updated with recently added sanity checks]
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/card.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 4a1c6bb..4d866bd 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -221,32 +221,13 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 	struct usb_device *dev = chip->dev;
 	struct usb_host_interface *host_iface;
 	struct usb_interface_descriptor *altsd;
-	void *control_header;
 	int i, protocol;
-	int rest_bytes;
 
 	/* find audiocontrol interface */
 	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
-	control_header = snd_usb_find_csint_desc(host_iface->extra,
-						 host_iface->extralen,
-						 NULL, UAC_HEADER);
 	altsd = get_iface_desc(host_iface);
 	protocol = altsd->bInterfaceProtocol;
 
-	if (!control_header) {
-		dev_err(&dev->dev, "cannot find UAC_HEADER\n");
-		return -EINVAL;
-	}
-
-	rest_bytes = (void *)(host_iface->extra + host_iface->extralen) -
-		control_header;
-
-	/* just to be sure -- this shouldn't hit at all */
-	if (rest_bytes <= 0) {
-		dev_err(&dev->dev, "invalid control header\n");
-		return -EINVAL;
-	}
-
 	switch (protocol) {
 	default:
 		dev_warn(&dev->dev,
@@ -255,7 +236,25 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 		/* fall through */
 
 	case UAC_VERSION_1: {
-		struct uac1_ac_header_descriptor *h1 = control_header;
+		struct uac1_ac_header_descriptor *h1;
+		int rest_bytes;
+
+		h1 = snd_usb_find_csint_desc(host_iface->extra,
+							 host_iface->extralen,
+							 NULL, UAC_HEADER);
+		if (!h1) {
+			dev_err(&dev->dev, "cannot find UAC_HEADER\n");
+			return -EINVAL;
+		}
+
+		rest_bytes = (void *)(host_iface->extra +
+				host_iface->extralen) - (void *)h1;
+
+		/* just to be sure -- this shouldn't hit at all */
+		if (rest_bytes <= 0) {
+			dev_err(&dev->dev, "invalid control header\n");
+			return -EINVAL;
+		}
 
 		if (rest_bytes < sizeof(*h1)) {
 			dev_err(&dev->dev, "too short v1 buffer descriptor\n");
-- 
1.9.1
