Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqyYUNkpEfTAqqDwYLkFq7dvwfoSZQtLTKsv1pY8Czm4h6cU9rjSW7Dsp6qBg5giACc76Zj
ARC-Seal: i=1; a=rsa-sha256; t=1526937807; cv=none;
        d=google.com; s=arc-20160816;
        b=xNsZ79xUfUXrkVqCWloU2QqgvjyKZHZukZTz1Ga1Wv3e5Q9C9Jj9kWoGQaGvZLA59W
         0q+mQ3Z2444DkJvehasKZZVYxYHmikcOKBCGp2MIYehNW63KHhHXssOv2IFKAg943s/O
         IVuxwmIEcMBAyq9+1U+Dxtwdlhm2QMA6D4FP2/dXHyuxZqzuAaBlUjeyRhh6ab5f5dQj
         Lsexhwwt+N8qyulk7bpR03uoL6p0oNBDhcPw4QCaXk7F2OO4CL3b3UaWvy54XGTFwQ48
         SMrPQsFBArBJo8nLdseZNFydydseoYL9Z+0BNQA3DwJDdOUmAAeQQPTgjrOIRUxk13kQ
         2EOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lDSSuQh7p68OZlwVLlcfvoR51dqcV9+Vj2WHYPtCHhQ=;
        b=ujcicp1QLXWhnnS6X5ygSn2UXXpOYtrZvXXdZpUa88sULHxjb/i6JVcIEVFGs7+WCJ
         ePhlakW2e9fMw5fA6jI6EHuj0r/x53KQLqGdF9LpUD2X+2svFnfiortRZhjA8z9mwWtb
         0pHAm7earO1q+CMzSxWbgb7B31AodpBRRs5wzPA2taQXAeGrwLebtNbVf8tKmkq4TksT
         XU3wJmFO/k0SLcQWJLJRVQ5kRTunQm5IL+xbLSeZwuwee6inJJXp0yJkmX2hS2l61gLA
         tiVxZ+j5Hwlw3N65+pRV2UC5QnaZMao48emyey/Jp33LXgyvllRFwtyYgPd4C/jZyJhW
         CBQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NnO/UqPD;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NnO/UqPD;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Federico Cuello <fedux@fedux.com.ar>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 007/110] ALSA: usb: mixer: volume quirk for CM102-A+/102S+
Date: Mon, 21 May 2018 23:11:04 +0200
Message-Id: <20180521210504.547698504@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109768849668423?=
X-GMAIL-MSGID: =?utf-8?q?1601110338402693772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -915,6 +915,14 @@ static void volume_control_quirks(struct
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
