Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224GVRij3cCp//hdDjOu0GB29IOIG7y5b0+5qKhIhdQgXviNlv66/cG8LtFxaub53KKiKAti
ARC-Seal: i=1; a=rsa-sha256; t=1519218332; cv=none;
        d=google.com; s=arc-20160816;
        b=H0fYLytqfZP3f3dzIT7b+Ym5wRkSj6R+KSGVnrO/CZmsGltuuOsJy8N0etRycb6o/j
         cSazHUpSnmbJn+GxNyl1slo6fTXkdbQ99vCas9590fXo31B5OYxGdMUjiEd1za0tn8zE
         kU8zsxHxxqc6YwidhbJ5yJGjSiZINo13zu5oIOSQcl+Vj6ZnEiUe00WOAeJZ9FlC11kq
         /6v9DlpGc+TWMmkiAg4TLB/bqBaH+CAX4qh6Z5nTyW1nP6VLmtNVKytDXvppMxzRUk8u
         gIF59Zl7MJP/7J/pTT5Ntrd4Wp700oW1IMkXGsOHEO9F2UJe4etqJtKJUsLvuR2LZ/gx
         NO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PmMD4Rmi7Nkd8nQ+hq8UpR+MUU2sSBr3bJoGdOgrRTs=;
        b=Yd2y/uI0V6/+s79F4BXKGGcjZwD63vBBZmiV1H8KBGZeN76bNpY8IV/tCpxWjCHbvb
         Ui6/OjHE9b42H2AX2dZ/Y64MI0zq3TRqCablSey30oFliaWQfuYf7Av3zYULuS1L30Ay
         wicsn/mYUFr388/D+lNpL3f0xPA0uNIMfXZoraFmLB/VvcqToHPwKHgA+7vadpcpmefI
         zSXAd5BBf01i5fB43VmG2yvfPrGkCNuJttHw3MDCF331pHpHut7Sd4LBAJZZvs4yA/Bp
         U/S2h8hembyl7zrxVCNpqMFjCccEg2rsooyC1+JX7INzNe5LBsmBRWLuGjyYKbJzCOO7
         MHUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lassi Ylikojola <lassi.ylikojola@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 147/167] ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204
Date: Wed, 21 Feb 2018 13:49:18 +0100
Message-Id: <20180221124532.800858600@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014658063044518?=
X-GMAIL-MSGID: =?utf-8?q?1593015882438515785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lassi Ylikojola <lassi.ylikojola@gmail.com>

commit 5e35dc0338d85ccebacf3f77eca1e5dea73155e8 upstream.

Add quirk to ensure a sync endpoint is properly configured.
This patch is a fix for same symptoms on Behringer UFX1204 as patch
from Albertto Aquirre on Dec 8 2016 for Axe-Fx II.

Signed-off-by: Lassi Ylikojola <lassi.ylikojola@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/pcm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -357,6 +357,15 @@ static int set_sync_ep_implicit_fb_quirk
 
 		alts = &iface->altsetting[1];
 		goto add_sync_ep;
+	case USB_ID(0x1397, 0x0002):
+		ep = 0x81;
+		iface = usb_ifnum_to_if(dev, 1);
+
+		if (!iface || iface->num_altsetting == 0)
+			return -EINVAL;
+
+		alts = &iface->altsetting[1];
+		goto add_sync_ep;
 
 	}
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
