Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrwonn2OMLdhdlbooLq599A0vYnnBISVtLZr8xQBB0R9pHTU9BM6eeETXgYlK7a1HXFxOo/
ARC-Seal: i=1; a=rsa-sha256; t=1525767451; cv=none;
        d=google.com; s=arc-20160816;
        b=F9BIL6hay40ZFHRrPYqa23iobJ1kYGZv6h6/uVxRlOvt74UtHO1S9LNzL7FRYohW/U
         wpwbUgX4Kd4YZIWzeDhST4zKddUnL6AHIQsUbLoRtyTUfUBYKGUIi/AOjoBzMpnVg+pY
         SNXWBIeh+oUtPIZZJLTDTJ2PZvJVlU76+cE5YXBt+TX1FHfjBY5FrwMjUTqCjsoMON+7
         XdIosXCaW4zBb2hA4AxI6/JQKy/aLJ8z82ubrWZ0pHMhj0stxqGa7qaRfkmXw8JB3En1
         fhEk4pOzJGR3dQZpxHcM944HRiJSQwioNyCLl6OD14aJbfH9JmvtuC1/Y6v0CCuOKma8
         OuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mJYstAHM1oOXZPe+hRGHR18lFMC1Rn9Bt9RDigM6pDY=;
        b=Ptu9FGKYG0hw8PM8pWhNk3lIPvxz65Wgw0T08syYu06xnilHq5BfG4AzpyU0w5HcIx
         agUrRbDErFJOt8e9b9l+TYY1V2rkjRMdxzCUSKDaT7U/J2NBv8lGRkguzISUXifzNy7v
         OBPCgTS/HbkbBmAjrMyo+44J2Ngxqgez67PJREGWkNxfg0tX6eLIsUTMKC+hJvbNdKUY
         DSw3gWeMTWuzP/eRmw6pLTSaWV9lhrgI0E3ovA5fgHKf8ttxPX7meifuVgKOT0SGHjNx
         SjNopqgIIYqkczLccbmu7W/nSHA8bwwM4bmhoJdPGF0C799EXctza9pMYXr8sRnRnmu3
         RzEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kZwddT7m;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kZwddT7m;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tasos Sahanidis <tasos@tasossah.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 13/32] Input: leds - fix out of bound access
Date: Tue,  8 May 2018 10:10:53 +0200
Message-Id: <20180508074010.906705201@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882770154744833?=
X-GMAIL-MSGID: =?utf-8?q?1599883131812659408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
