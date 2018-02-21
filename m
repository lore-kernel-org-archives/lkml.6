Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22484BrYsx8t+wvaDLRaxm8DnIlxc76+aXAaOX/8ERXeZ6dFkw6aOrjXXO2YADux4FhM5X9v
ARC-Seal: i=1; a=rsa-sha256; t=1519218349; cv=none;
        d=google.com; s=arc-20160816;
        b=EpmVAxP9N9Ah0fgvivKZ9IK5+59RBFMTmukU/sl17zwr8eDHRKCkK+AR+Exs+XnTUi
         JilP8UkqyZuv02DENtA+krdGwxX/Bn8JUuoZdM/PzgjvmsqsWfLHcB1m28zsNNODoHOw
         a7beRz7HUpNMYxPq5xuw9xotiZ11iSuSBq4JP7wZzhgzszrnVdAi3BnB13RzlKHNaD5V
         Ry6xoVmGwE47lw61KwEwc5BuM4dy2RQiz98aJIDqBcQvU/8i/mlKX/WxUT6sRzy9alTr
         L96zF9sEPVbqJFVQd5EvcJqHQFDeVG/Z8SNEoo2i1xr5ptgclCmi7wSRhLOVuDnSV1Os
         5wKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HtJrPiyoWeU3Su29aTnmwX9+b3iRPUrA9oD4glSPKJQ=;
        b=VMsYUzfk1iU+HahIhOTJopBJjn2koLrU3hcIPtsl5JOgDW2XFRrFRXM7IYFTtmGhAU
         wgJdRA7sZW+1wxmy37kNdyiOlfkxEQlHglpuWoetSpUkvrq1zqlIqwYGSjlMIfIYiIgR
         Z1e+5vcS8ePVLcYqkpRLUjv/8XG1JMgrldsWeCgpjaX8iHBpqDSpehLhCh7LBaNj6BKY
         qR9tX1foBTgFcGpC/P1uLjVSJe1R7bWmywu2CQsVoWh9geKhJjRa0c1yFwTD4qAv5gYB
         aXXplVrdqtW+9zUyl3cTgBiq9Ko5SoN7EOZDkgyBXkqKHDd3jn2WSUZOtgT729nJ1pKO
         YV0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kirill Marinushkin <k.marinushkin@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 143/167] ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute
Date: Wed, 21 Feb 2018 13:49:14 +0100
Message-Id: <20180221124532.571939877@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014652240317593?=
X-GMAIL-MSGID: =?utf-8?q?1593015899889507345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Marinushkin <k.marinushkin@gmail.com>

commit 447cae58cecd69392b74a4a42cd0ab9cabd816af upstream.

The layout of the UAC2 Control request and response varies depending on
the request type. With the current implementation, only the Layout 2
Parameter Block (with the 2-byte sized RANGE attribute) is handled
properly. For the Control requests with the 1-byte sized RANGE attribute
(Bass Control, Mid Control, Tremble Control), the response is parsed
incorrectly.

This commit:
* fixes the wLength field value in the request
* fixes parsing the range values from the response

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -347,17 +347,20 @@ static int get_ctl_value_v2(struct usb_m
 			    int validx, int *value_ret)
 {
 	struct snd_usb_audio *chip = cval->head.mixer->chip;
-	unsigned char buf[4 + 3 * sizeof(__u32)]; /* enough space for one range */
+	/* enough space for one range */
+	unsigned char buf[sizeof(__u16) + 3 * sizeof(__u32)];
 	unsigned char *val;
-	int idx = 0, ret, size;
+	int idx = 0, ret, val_size, size;
 	__u8 bRequest;
 
+	val_size = uac2_ctl_value_size(cval->val_type);
+
 	if (request == UAC_GET_CUR) {
 		bRequest = UAC2_CS_CUR;
-		size = uac2_ctl_value_size(cval->val_type);
+		size = val_size;
 	} else {
 		bRequest = UAC2_CS_RANGE;
-		size = sizeof(buf);
+		size = sizeof(__u16) + 3 * val_size;
 	}
 
 	memset(buf, 0, sizeof(buf));
@@ -390,16 +393,17 @@ error:
 		val = buf + sizeof(__u16);
 		break;
 	case UAC_GET_MAX:
-		val = buf + sizeof(__u16) * 2;
+		val = buf + sizeof(__u16) + val_size;
 		break;
 	case UAC_GET_RES:
-		val = buf + sizeof(__u16) * 3;
+		val = buf + sizeof(__u16) + val_size * 2;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	*value_ret = convert_signed_value(cval, snd_usb_combine_bytes(val, sizeof(__u16)));
+	*value_ret = convert_signed_value(cval,
+					  snd_usb_combine_bytes(val, val_size));
 
 	return 0;
 }
