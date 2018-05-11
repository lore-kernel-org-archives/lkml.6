Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZq9XDZ6YL6jDAHGUTv/L9uvNDULHRgxENpaaE7n4XgJdGuAPVGiLl2TePI5/TGhgXU31QgL
ARC-Seal: i=1; a=rsa-sha256; t=1526052347; cv=none;
        d=google.com; s=arc-20160816;
        b=hTbKeyyXp5ocVKM/hf6AovXW7yCfMng6flW1fJkwZ5JDVAFwwouH1Fn+2pHWzCfaXh
         QOIiWgaJh4R/TXwT9qHOfxTRhOCYt/B4m1xdhwFwJNkJGxyPCG8yHBVfFtXTu6upwwIE
         NzHZqWip/GIQG8/VM2AiCzYIkWopM1B+etm8NGAPOQNPR84zEq77DR8K+esvXQhEGU0x
         BxoQ5mIX2BziWqJjz02egngSYuVq54WUM32lmSc0kBBfgQh+ttaKx6aRaCbhCGtciV4S
         DaPD0OSBEoN1/xsBvFQf4fHURfpSzq+HOWMSUz59Xoyu55Xs0JsjHalzdg/aN7x4+18c
         mMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UV09o4I1Pfl2MPUzeWYmlKy0qqTQq1s7b2GMoxWINrs=;
        b=sgHBzMAQq7DbNnFA4J8RNrCf/HaOi1N+cazncpQwKvDI1r7yC9HTOdpnhr+cKrsDaS
         HxJl9ClWUrYq9Ti8OaQjR7yvJHseFjkwiZU9GWER8O3qEhuKXzu1bCpB56yeKQdnvqlW
         o5mhhvLl6DUeKZt/CoO8mbsWGu2L8uO1il0Am5Bu/1vXdroyBhCAUfz5SY5hmM+pGtPe
         4Sa79srFNhdHw1ybGEesJV4Px9sqMs5F1rXjf1wOZ0sLSe/2Gm53giCyEPoXt2BlOPx+
         9ciLwhm+CY5TjR37VSh0im9ft+ulg8IPESNWS7SGjH9MYWhRZznMtQRK+/OO9S6Xgzlo
         oQdw==
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
	ruslan.bilovol@gmail.com,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v4 2/4] ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
Date: Fri, 11 May 2018 16:25:35 +0100
Message-Id: <20180511152537.32267-3-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285489825871167?=
X-GMAIL-MSGID: =?utf-8?q?1600181867182043786?=
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
index 764be07474a8..6b2924533d8d 100644
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
