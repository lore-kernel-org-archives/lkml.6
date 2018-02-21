Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2274lk4FUF0/7I4YKXcPfOrMHB6PgSwN7a68X8KaxqpmDVHeEegWe3d/TQ0Nln7kBTpgMAvy
ARC-Seal: i=1; a=rsa-sha256; t=1519217708; cv=none;
        d=google.com; s=arc-20160816;
        b=s00jpdm9Mhq+VrgrrXsfrmWBe6qL61izH9I0dicoEYrIlaMMJtdSOtxJ0qlu/HABjJ
         nEetTtglqCJNiqNs5sSbvS0v0FolOvixNx0sONSwmgv7gOSP9UzuKbIa3jyWClpFlCEO
         lLmDJXRR97SgucoQH9/LZSjAS7YpjaXz+W8PnC+NQVMfbK6p8Nk5x5RFiQqSt4xpUCg/
         7Y5bWZf0NgJz0PZnPvkUOpYewk2MDOC6O1DMauEzW12PjhQjdyri1CPxaSNA3+qkqxxA
         NzmYXEozQwPsp4jCYPpI6v+jYx+gYf8ylfilya1dLXtMsRpW0+gSpRt12k5lhc59KVTI
         VJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MVUJnp/0qR8oWDPClorGsIBmx1IbsGVmnKnJ9qW6ZOU=;
        b=WftFo6eVq1c7+mEeQSAmhBzH/ODOhkV8G5Pvi46suuN7BBJkgMgOalPT/69wYARoBb
         BKB/EZjabWFbeJrbgBWmTF8g9dKUMu5RDO9b/7ELTOSKgpK8ZiBqudu80uEUwtRw+0rK
         nWijfX/wGxdSL8dUJSCyLq9aUB0mdbbtK9y93JuxcUuEObnAW3V6nK/PAftL+XNfYom+
         Mr24ugPczySE9TTMyLYRKLFW3BuxU+CIEGi5GS/7UEahhm6MLMYhqV1/oj09lrwcgkDc
         LVgz957pKuZooTeMCI1u82h6ZnfvmRA7u1G6EhUYp+Vf+3VuSgU5e9ZgVfhrk82juyzT
         nHcQ==
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
Subject: [PATCH 4.9 26/77] ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute
Date: Wed, 21 Feb 2018 13:48:35 +0100
Message-Id: <20180221124433.290655329@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014652240317593?=
X-GMAIL-MSGID: =?utf-8?q?1593015227632823295?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -344,17 +344,20 @@ static int get_ctl_value_v2(struct usb_m
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
@@ -387,16 +390,17 @@ error:
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
