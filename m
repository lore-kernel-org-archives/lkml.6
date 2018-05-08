Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpgDVIYgeKV8lpG3R4poeeRvVhUJ6MlClzmKrbvl+DF2l0XjlrGjtea9jBlfChF4WeRlr9S
ARC-Seal: i=1; a=rsa-sha256; t=1525767107; cv=none;
        d=google.com; s=arc-20160816;
        b=CbGWLyAOgmmsWgouabG6LRcUCF0eDMTkyp0Ugs1vlY6AKlt08+L889BfemUQN7s2dq
         tlgnwizdVtJsRIcnLFrhzQtpECb7CiZnJbw0o/mGUX4grJUILioKd9kur/2Wz50in9PD
         zbP1ay7yYkFR5EeN0Jjpb3ppgPj0YvFYSmvNffjMuDWMJXxDwq0QUuskYWMF6by1OYLT
         71rHi4Z5MTXLjnRXqURcaXofFrg5cWxG2VRcOZ3HV6XSq5svV8LfhC+6AOHAs3Ca/et6
         lG22ZSI22VBhVAnMpKLHfzdn7/pgihD9JYKKNyH1KOYme5PvhxyAXL+GVQ+HCWS2jPIU
         EjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=flbMWqXrtnu9dmhVovoU1qUDgTKY0zsHHsYc+zplJzo=;
        b=On+uivSgIrnnK+N7Fy9+qBaXbrOsERM9iW9IAAuZP9GK92N86iEm3ydkjoXpmYcfcb
         KwF0cRHXL5Oh+vi19X3ODgdqxlR8vOXZirX15WEMP1aN2/AD2KUSBwQga4AudVKP+g5B
         bJLNwl9mXIsK1oh1nQkz0H0E+RxTlFmmaK1VKi1PnBJZv1hv5uUIGMEY/UFyf/EJdxGR
         DT3T7PrmCP0bGYkXd+1+eRPZfWkBLInDEU5EHKRdgeoszbna8ZlTDHxYOzSg00QEj3HT
         DBeY/fGaUrSMh3RsZv/ND67umIKNPJEfxLEHQBIxfkZr0dDr3qNr5MleN3NINECJrj5H
         m68w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fckOaZIf;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fckOaZIf;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tasos Sahanidis <tasos@tasossah.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 12/52] Input: leds - fix out of bound access
Date: Tue,  8 May 2018 10:10:10 +0200
Message-Id: <20180508073929.634373070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882770154744833?=
X-GMAIL-MSGID: =?utf-8?q?1599882770154744833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 6bd6ae639683c0b41f46990d5c64ff9fbfa019dc upstream.

UI_SET_LEDBIT ioctl() causes the following KASAN splat when used with
led > LED_CHARGING:

[ 1274.663418] BUG: KASAN: slab-out-of-bounds in input_leds_connect+0x611/0x730 [input_leds]
[ 1274.663426] Write of size 8 at addr ffff88003377b2c0 by task ckb-next-daemon/5128

This happens because we were writing to the led structure before making
sure that it exists.

Reported-by: Tasos Sahanidis <tasos@tasossah.com>
Tested-by: Tasos Sahanidis <tasos@tasossah.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/input-leds.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -88,6 +88,7 @@ static int input_leds_connect(struct inp
 			      const struct input_device_id *id)
 {
 	struct input_leds *leds;
+	struct input_led *led;
 	unsigned int num_leds;
 	unsigned int led_code;
 	int led_no;
@@ -119,14 +120,13 @@ static int input_leds_connect(struct inp
 
 	led_no = 0;
 	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
-		struct input_led *led = &leds->leds[led_no];
+		if (!input_led_info[led_code].name)
+			continue;
 
+		led = &leds->leds[led_no];
 		led->handle = &leds->handle;
 		led->code = led_code;
 
-		if (!input_led_info[led_code].name)
-			continue;
-
 		led->cdev.name = kasprintf(GFP_KERNEL, "%s::%s",
 					   dev_name(&dev->dev),
 					   input_led_info[led_code].name);
