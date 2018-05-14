Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZ7v+O5kacYGTkY1nDIq55ddMBP7bPsMi7ycav1dTVjFfl42iQNkq67pHktp1IFz9z40Nf
ARC-Seal: i=1; a=rsa-sha256; t=1526280679; cv=none;
        d=google.com; s=arc-20160816;
        b=g1nCHgry2OFhVsfrAW1voXQmYYEQIunDlhCGUBaqN5TzEj2/V/LlVCMTc3ULrzBVK9
         hgu/9QZ2NXWy3x/xGoWWaaoM4l01L0Z0f8CLmwOgxSu6dtj45dfCAAxpzlefSionmlWi
         cAok1ZGI3BJfk9puxmROWRUWah2UbAcK5TbEinr+j0Btr8jI/8Ly7AOi7E6qqLch0wZ+
         STPoLO8ZJEuf8MQK2Wi2cSTZ9lEvFyYNppMPNLmaLkckMh8Ngh7+3CMpOJjyAbAFdrJe
         IMUp7iVS55EzPg75Dwuc623/fjHuz0b7irLbTNtY6dhNXuTJ5HSJXMOkMaG4ozlpYqu8
         uLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3JZGen0HkKzhLfNrSWXk/Pn/hsZEPGy04cwj96XnYJQ=;
        b=MFYah+BaYAGencLi/U3byw05sHZtEJETCctEkeu6Z9HJnQKMeuf2vjK7Z2PeCIhIH5
         dhDt0wu3ZlwWSucho3vFUWVgv6Yv7Coy0ofp3bTbiu4vBlUzOop9zfRGkIvTilBaZ+p5
         1elq4vueQ9mwZtcSdLYz4Z7aNKXAPcpLfBgdFs13UaofTcA+LmGRZtRTKAz7xXwJc8h7
         zalhL1nvRkU2tb+ccmu13ibyPUWWCkKdB6GL1H3RAADhYkPvnu3gxs419ERvlBSgzWvQ
         7DE07jTSa56AaFFbRDcdoIQ7NyKIhBardwP44TMv44Mwbuf5iYsn1ttSMscIVH+YN0cJ
         c0/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RXKoaJKn;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RXKoaJKn;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tasos Sahanidis <tasos@tasossah.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 17/56] Input: leds - fix out of bound access
Date: Mon, 14 May 2018 08:48:22 +0200
Message-Id: <20180514064756.667920631@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421290124786642?=
X-GMAIL-MSGID: =?utf-8?q?1600421290124786642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
