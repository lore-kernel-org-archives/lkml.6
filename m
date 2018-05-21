Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZppXhwOSPFG6Q5zsU7ShN52ZDQphmQfKqCreyJARQwMZB1B5YJaf6UdCNwYqi3lUqrJvmlN
ARC-Seal: i=1; a=rsa-sha256; t=1526937549; cv=none;
        d=google.com; s=arc-20160816;
        b=c0WSLLK0vm6NE5g+19gqrNMhaBEiR4Cv+dn7tfl174vYLbeJJCE4kPrRmXavqQ/evM
         Z6R7v++lLj2KSkhr43hs4bVp7HrQ6EgTFBYCyR6bAk2ZenyCKGXtVLkFo248zqSY76hU
         T/x231D08/QNGc2sUI06gKQl38UZeo7m31hQ4blJY1NqI8jeY8RGpatLWiHlj7PwLBPa
         Q23WJzD4SYwct5WUyNXTo36KFu1MxPSCeAFU9mXyrM0QsJSq8SSi3vUDNHxOelg/raf8
         3ZWc9LC4sydwSruokPIUx8BY+ZTyBnF1Y01QUGUXfVdJH9YnsRbrbmjiZCETPSyY+/CC
         If/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=twRwnnyhjqDfjqfDIK2+sGkcRtibEv/RKRcma7YW3nQ=;
        b=ljMjCCbkXxLqEmYD5c1zn5VrFNMuSUfCi//Ebc7SNnxdA/+7y+bzryVfZJeOg4plPm
         tfOTdIbaKFTsQUel6knxxPWXCbdAM9JnVRu/7kMDvPCmEew0zUWDwUzxzWdrqT52AbbH
         kXNoj5SG3+zSojPk7AD9ajG0Mo73AwkhsIh1qestJ3M5wBzZJYw2+R6FuxWaALz1Bmfv
         TYfTnAGytyg63/zB0XsUH3+eIMIZ2NzVhlDGCg3k1RYQxr1oV1/bcpFHIX4pWxbMSngH
         9FrrRXhRQgGqyOimXwNd770jdN1jxaVIIhqU2ablJrYeXYRufZL04yvr0F5pBWswOX7e
         Cf0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TLFxbije;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TLFxbije;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Federico Cuello <fedux@fedux.com.ar>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 06/95] ALSA: usb: mixer: volume quirk for CM102-A+/102S+
Date: Mon, 21 May 2018 23:10:56 +0200
Message-Id: <20180521210448.613477522@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109768849668423?=
X-GMAIL-MSGID: =?utf-8?q?1601110067815578028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Federico Cuello <fedux@fedux.com.ar>

commit 21493316a3c4598f308d5a9fa31cc74639c4caff upstream.

Currently it's not possible to set volume lower than 26% (it just mutes).

Also fixes this warning:

  Warning! Unlikely big volume range (=9472), cval->res is probably wrong.
  [13] FU [PCM Playback Volume] ch = 2, val = -9473/-1/1

, and volume works fine for full range.

Signed-off-by: Federico Cuello <fedux@fedux.com.ar>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -911,6 +911,14 @@ static void volume_control_quirks(struct
 		}
 		break;
 
+	case USB_ID(0x0d8c, 0x0103):
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				 "set volume quirk for CM102-A+/102S+\n");
+			cval->min = -256;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
