Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225PaQ6GiHv2F3M6OnFlXMAMrnmIDpVo9bCv65yr6SeOqniHV6Icemy+hcPoxikwb6PBIV2P
ARC-Seal: i=1; a=rsa-sha256; t=1519217716; cv=none;
        d=google.com; s=arc-20160816;
        b=T1+HMA4qfQgnItJfGve3myIxNVD1CoohQ1+Jl5wVLTTyQiS1AsFaxxZ9dwQjeVP0Vl
         pkxgk+T7BdMuiLr3YhmQhHd1ZlYlHLH2yt/NUcgkyHh3jsa+JrO3PxpA7+YU8flTN7aB
         2fQ1zN3Q/gmQ4CHU0CbHT4kysxqBH6g4B874Us+DCX2dpkSTmEUbUgbr8b8xBmzG2so+
         xBc9tX/nD8rYNKi3REoF/wmoY0tTCPhKxbPmsaz7X95F0V03PFlwy6tIfKE8uCXWUUDM
         4bBKno8Hys86odTY2M4brfjtuwd+dyNBFaIMfwylIBElgbcPgpNONflCCt7wOV4GOpYl
         g3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oNNqQ3uZaA/Eol8MJ2EWvOR44w2sO9KTRCeLgQdAN4g=;
        b=lHRL1UD6EbyAUTf9asRmS2/zB7fskys43WHzW33i6iQFs2P8PVfsWH8Tx0wTw1e2a4
         d8VoTs9GnigjC+zhXh2mx75WmwsnuR7LlyvCXheXnX31fPUVPvZtQ6/aRG+8sT4dVSS4
         WN8PQ5Noqi25rl/HiOP2BSgwsoPyClKbuvE2pr3sjE88heSpnJIvNpDLOq7JMgrji3FK
         0VjChGPbAJeHtWRcgF+STv4DOChZ16LbX0jI+xiRw6odHICVUi1cA3WCOjNpj/7wHhJc
         qbr6n2FHl3SE9Ik1kO2UXaSdRdeK43pdwQY37C7PxQ5pIqury+SDW3PjNP3XZnzckqtP
         sYMA==
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
Subject: [PATCH 4.9 29/77] ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204
Date: Wed, 21 Feb 2018 13:48:38 +0100
Message-Id: <20180221124433.423126151@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014658063044518?=
X-GMAIL-MSGID: =?utf-8?q?1593015236546584272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
