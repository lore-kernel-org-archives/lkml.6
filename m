Return-Path: <jacek.anaszewski@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521487489; cv=none;
        d=google.com; s=arc-20160816;
        b=gAXhKBw9w/lbJcha+cTT1WlVspjKfkQ4Yzhi3aoxxXgz+DLN4J2Tpszqtdmck1TUX0
         sr3Gc5C5/S38GD9GUazs/JjrOEXWHwX7ftgHeTefglENdVzA64gUvVPxw4i0/ELpWNS1
         ZJIvd/oL++SpKCgwaJakusG6kh+u3xQdl3YhDGhW/G7FTIYZ4w+Vu0Z2U0CpGlldKkzK
         51W0dNVF8Bg9UJYRKOwU2mRvQMszPqOoOuAEvJpt5m0CLralG+imEkqHEL9DNfrgBuWA
         uf0pHvJ9nYjRY1pkqnIE4vhT2vHaNBQ7PGyYrdZIbuxxzvUYG0a9f6k+lbw1RO8AmX8M
         rttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TK8xnJRx95UAlDRIlQbeTkjgeHKjgD3sTdDywchcPPM=;
        b=fc3oYjFa9ft6+6bgJd1aHlV8rGbzMFPugqaaFlD2cdajgiGg25TzyO4U3OKAmUXuWh
         cDePle4F5WKAH7uzaByaKDpimyRSUjQTRJAPoqCFx8IZf4uaW6dbhLfcsMuJ6keobGzt
         fFaqyIzQxj/29YsqsbzISLWabSahDlmWjKcXdH/Vlu+cvLDl6WRAdzDu3ENbK+9sYTW9
         FuMqpzgZbJQdxlb7GQxKaiG6u6GQHLzQt86APUQtzaEce8VLYXxkLktMikcorgQLzmWg
         EGuOKT+TcnaxGP5SjX1PjCXV/x7smdwpWjBiqjMRExJpjN3CZAwNp9iGjf6l/ZJEe6Po
         pt8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D/pRhALC;
       spf=pass (google.com: domain of jacek.anaszewski@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jacek.anaszewski@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D/pRhALC;
       spf=pass (google.com: domain of jacek.anaszewski@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jacek.anaszewski@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuNNZ1altpZrUtBeV5IGJc/jZZ256PhwqBkKcJu/1KLOO8hstFn3h1N0W2tVTjhKSoOcYwRkw==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz,
	jacek.anaszewski@gmail.com,
	Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 4.9 v2 2/2] led: core: Clear LED_BLINK_SW flag in led_blink_set()
Date: Mon, 19 Mar 2018 20:23:19 +0100
Message-Id: <1521487399-10447-3-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521487399-10447-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1521487399-10447-1-git-send-email-jacek.anaszewski@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595395266160795891?=
X-GMAIL-MSGID: =?utf-8?q?1595395266160795891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
*** stop timer
** led_blink_setup
** led_set_software_blink
*** if !delay_on, led off
*** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW
is set but timer is stop
*** otherwise start timer/set LED_BLINK_SW flag

echo xxx > brightness
* led_set_brightness
** if LED_BLINK_SW
*** if brightness=0, led off
*** else apply brightness if next timer <--- timer is stop, and will
never apply new setting
** otherwise set led_set_brightness_nosleep

To fix that, when we delete the timer, we should clear LED_BLINK_SW.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
Reported-by: Sasha Levin <Alexander.Levin@microsoft.com>
Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/led-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 3bce448..454ed4d 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -188,6 +188,7 @@ void led_blink_set(struct led_classdev *led_cdev,
 {
 	del_timer_sync(&led_cdev->blink_timer);
 
+	led_cdev->flags &= ~LED_BLINK_SW;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
 
-- 
2.1.4
