Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525397097; cv=none;
        d=google.com; s=arc-20160816;
        b=wCRTCXhtp2nU8N9lMFriX8uqg5nbCT0uv2pSbDmh0sPXCJ3iN/ir/JRJ3FcL/AoH5o
         +9XS0ofgzrTCtw7suicizWZH8UTOS2oATjWKuD4opH8sn4MD3tBh4BVWsjGieZB964gP
         b2Xizze8IMmkB90a7ny2NoltAESfmHVTuLh3H9q3ZR+Ih0kyzyPjL+msIhKmfUN5J7KM
         RIxgOtTfNvfDJdm85tsd8UfVhBZ+gmAFnvF5CSS8AN3Mre/1Zi/jXsSCCuI071h8uKoq
         OjqB/JVYgf+b2DYp9YJDiUNwd2jgpBMPCVQ6hPO2RSiMxln0MJD4dg8cUBjhqKxDsCxY
         CJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=S0iJGDvmIG5DKhYEeA4VXS0xb3kgpHs042UOGEPEzAE=;
        b=vV5rDsAE8E6qj4eW5foq+qpLXkQXp4UfZljEkF5E4w4z77S3r8Uxu2eLoQNombRlvC
         EW3VdSpf8IS9NsNsrh8Cixnj3gp2b4lTUe1yeO7fywHRfBMI1bDHiQHau3y3QzkWbnLE
         b5IQzsIWMCCHEZ4CG4g3oanBpw8zlQUdwD80T+oQwUavj3BvtI5kA+gFPpxURwtFkOiI
         EIGSV8khKRNXZBSZEddD6zSHYhGonRCFA0HHqqCAv80GcFaOczB+Oz5OcLSWxNbNdqhn
         smIS8XJjWgI7AO9kletFbfFqHDpMR3bnlL3npQGDv8OyPZMntAqWUI5aeA/Cc0j6dD84
         I78Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kegHWC3g;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kegHWC3g;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqHRqLzPRa9+YDuHSazWMtbdEsSr0Ki8Mwz/GvANm/cA8s0LGTyEFHL8LFwOZJvYjqEIfEJdw==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Andrew Chant <achant@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] ALSA: usb: Only get AudioControl header for UAC1 class.
Date: Fri,  4 May 2018 04:24:01 +0300
Message-Id: <1525397044-15080-5-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599494786710378649?=
X-GMAIL-MSGID: =?utf-8?q?1599494786710378649?=
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
index 36c289b..0d7a5d7 100644
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
