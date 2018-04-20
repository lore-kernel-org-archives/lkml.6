Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx49ly0G7j257Y7FZDJYz2UhBGQM8cw/mXEIckyG7DktKeROScxap1Jpbnfk83AojM/2YeRFZ
ARC-Seal: i=1; a=rsa-sha256; t=1524243821; cv=none;
        d=google.com; s=arc-20160816;
        b=iIrwyf6mhPCYrsTfVcIn0Zq0m4x1fFuDG5/TprPjlrTeueBvSN0gw0hPKoGI964F1U
         hzNa7riNC3G87WwCm9OWzxlqwIhNGLXOoRoGSqXuF5S+6Sr7oL1+Xmv6hP1j+jQ6yNd4
         8u4JJ2AtZLKcGIs53QjGyqtHdHQYmLfqg2le3aPQJsT/ASGbqdLsFhMPAv8AVm/G6pJw
         XaNJ9oT7q/lXdw35vRrakMNdO5/cE4gcka0g1ZZIEgPG88+1U/JrNyyc83RYapQX65rO
         +N/BM4B+McDBn17443Vg2ALI2+AQ+DyG+kNmYom2oiowqitYA0CEsO2oeB8HRR4C1uZq
         1j2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=whiZIEUf1kRw5JeK1tZey3jJLLn4nIU9xRX59d7bezc=;
        b=E5yDnON7dRM7KbMv7wYHWTd7fL0NroGGZy7bSy+iFXhw/izSboOxa+bPET4ie6MtEG
         O+LExlU23r8Ql23WQsEfdl2fTFUBTxSoanuFWqwVAKiDnpD3xUE93zDl2xJ55aHgOmMe
         Gluv1dIShF/AfPgn7n8F3cQ9wLp14rB8DpOMnBkr5yx/Q/ItVNXysHQ4fFa4AAq9YeNx
         A0XcWxAp2vFwAc3rYm+dgnJLRtRDd0K8GmKgaLcZHM7bLotBcDox/JxTfGisd9XBqs8D
         fXSdmuhSd671TbRiKBQbzleAE+VCj2tzc9Lm5JthpfQ6v7PwBgaH5T9/Dj9teuStOSmP
         3NcQ==
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
Subject: [PATCH 3/4] ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
Date: Fri, 20 Apr 2018 18:03:26 +0100
Message-Id: <20180420170327.31569-4-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285489825871167?=
X-GMAIL-MSGID: =?utf-8?q?1598285489825871167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
Hence, checking for pitch control as if it was UAC2 doesn't make
any sense. Use the defined UAC3 offsets instead.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/stream.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 956be9f7c72a..344e0ecf6d59 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -574,9 +574,11 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 		return 0;
 	}
 
-	if (protocol == UAC_VERSION_1) {
+	switch (protocol) {
+	case UAC_VERSION_1:
 		attributes = csep->bmAttributes;
-	} else {
+		break;
+	case UAC_VERSION_2: {
 		struct uac2_iso_endpoint_descriptor *csep2 =
 			(struct uac2_iso_endpoint_descriptor *) csep;
 
@@ -585,6 +587,17 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 		/* emulate the endpoint attributes of a v1 device */
 		if (csep2->bmControls & UAC2_CONTROL_PITCH)
 			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
+	}
+	case UAC_VERSION_3: {
+		struct uac3_iso_endpoint_descriptor *csep3 =
+			(struct uac3_iso_endpoint_descriptor *) csep;
+
+		/* emulate the endpoint attributes of a v1 device */
+		if (csep3->bmControls & UAC2_CONTROL_PITCH)
+			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
+	}
 	}
 
 	return attributes;
-- 
2.11.0
