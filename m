Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrs66nbUWPn8O8vqQRRT3hJ/v/re94UgCDhskxf0US4uaIBiOHgAHEyNcCkQZpTSWxXa7aJ
ARC-Seal: i=1; a=rsa-sha256; t=1525767324; cv=none;
        d=google.com; s=arc-20160816;
        b=0EkZv3sejJT4ZDObAPrQjhCPqbXEPhBL0ydwceRUaXcjZveM0/+Vp/DzVw62aKAULX
         ZWKt8hqE5wE4zAe63EjceMe1n+e9KgPF5SJMFPmTSQBg6CmnQEGjpFgEKc/B2zv+msru
         YvVNTCBkWXdy/YNY2ZDHssDY/nTluCtpN0ktPDSUPrFikUgeaqMnG8PD7a5mMLOoGhD1
         lOQ8LMLqpknHvstsl3opSVIlDz7MOdMrgyiwdQ1WkmN6zOOKdyOTDClGOBFAnDiw0YC3
         TyfY4Eh8WdcbHCk8A/8iY+y6DF47fx2YVE+FqqA5q31ufBqYWGFQmbknemFmBddq/utE
         78YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=F35uPqfMOt1PEphT6UlXbowem1ZxOUMiHQ9Dwlqr5yw=;
        b=R+uj4JBmNLN/ct1MsnGFuF2HrVka3CbUuLPiIYXcj2SZdmk3ZKgl1Z/S76oNMf84Zj
         inh34yFw/cMgpSOAwwWaJGoFCjHBi4LmAx/A0kCW9h9FZudX6FKQK66VHkd/lWfi4I+F
         3GwsCFdOl/ukfNuGaFtaROCG6yqBU/Rj3n70KAm9gqw46li+i63w4tMA35iYHH9dxGM/
         ELqptMYYSqWm1sZ7MW+A4gQA0apwxsB5zTzoLwsQD5nz7I8+jtXO65C840pjWlQZrI5E
         +vexfFxcA9fcoi/PUxHhlrOj8w9fWU+EbOMzPxr/Z9SVGke+KraQ2d0I+WXVYqSXP/sl
         UtLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pUqrr/7g;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pUqrr/7g;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tasos Sahanidis <tasos@tasossah.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 15/43] Input: leds - fix out of bound access
Date: Tue,  8 May 2018 10:10:34 +0200
Message-Id: <20180508074006.419315464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882770154744833?=
X-GMAIL-MSGID: =?utf-8?q?1599882998451266486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
