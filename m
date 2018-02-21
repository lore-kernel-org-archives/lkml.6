Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224msgVzU9YfMV3stj25cbPFsBCb4Tji+wO9bwPQ3XYAkIuQXm6aazikB31ub9VSoFvN2t+H
ARC-Seal: i=1; a=rsa-sha256; t=1519217164; cv=none;
        d=google.com; s=arc-20160816;
        b=0UDNorfH4D0X3Otc4nuSLw/OgqM1CiKOliRIeCcmZEWQdoRXd8EDhCr3hvKMahl4pw
         T/uFnTqhBUxXm1SULDEGxbeFVwAVZS76/jzzhbQmBg3ksJZ4sGO4dvWK/XIP8xhNzxiR
         Lc2RjKo/r0yyLRBTehKchuXz/ONZ3FdPDPhaq1tF6xxZsDMIt0L/4HoCu7R1xyOwqMgL
         ysJn8LEo7MemtBsFvZMiHvwAXlEVT7mcR8rZ40ZmswTf5tE0QLLKncPeBf7anSwu+WDI
         6CTMZjb3MDIeZ0tKtKrtakx157nVrXrpvK6FToJqdSR/7zDSJrd541mPxdYDt3NL3JM6
         d6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9K1+tGiTDsUdoNVK1zM+ZIqb5GjO9sPx87X4Ktkx750=;
        b=uAgb/AI/2RMAsyO3D2uH7sLMyEdjsT/o8Qv2Wh5re6nl5YiRzepxFb1uEx7lXFgFKZ
         qha1WZp+AXu+K9QggyOdysL4CiYoStnPo7IgEzvdXgXvYi6tA+gGcZ/CLWf8Uxa3uFip
         jmJSzT5NibZwCkbUDbPMZ7ems66hXhRSyYWzYoVQDMbOmSQE9g0Vtt1pBkCQ5skh5Xvb
         0oEHrxnXJprqgjBbkJ3QYQyiAxJ4sY3jOVt47MdaKlHlz9zi5drNz5/U4+8TbxieQ4Lg
         rcmVngjDzmjEhPVJtC0c5G139tfUptfq7tiA07PSRIpJlESXdcWo1G4fbNAYb9wXp5UI
         r8aw==
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
Subject: [PATCH 4.4 25/33] ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204
Date: Wed, 21 Feb 2018 13:45:08 +0100
Message-Id: <20180221124410.927366434@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014658063044518?=
X-GMAIL-MSGID: =?utf-8?q?1593014658063044518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -348,6 +348,15 @@ static int set_sync_ep_implicit_fb_quirk
 
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
 	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
