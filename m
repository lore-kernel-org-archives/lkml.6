Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuLZ6i+5fKriFqaW3kiC7aL30UH+Vc/gukQWJoyD23clafmVigv1rP37iEMf4Z/aFQ8O9cV
ARC-Seal: i=1; a=rsa-sha256; t=1520641195; cv=none;
        d=google.com; s=arc-20160816;
        b=yPkNC+aiuypr0jtm5m+0pJf4hymg7cbrPHYOkrLMlz0v1K9YORsCdngKixmTqyWOFV
         Ayz01AdVNqJ6quibFHvnKRGyu2Hb5CgJmIvOPJLJOeTMxY078KBiXicldZKws9pj0v8R
         zW4RaKx1Lrb4brstZaZ2yo4MP9PVZHykJEnySw4oqB8KJO6t/6h6rO2RueKzegOdJqku
         Fic/ALOnS0d369POWiFIjocvlhXEESzq8xbcsRx9hKKaJG8NOhJrIiYn9miBKzkvM940
         XWY1Tjj3bVHq0DUh9tml6lllyQtp6P6HsQhi8CJxNzr9ULPolj5yJ9VSJ9BcquiW8Lwz
         m4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yAOcxD2Jakc+DbzZe3Eb5q8RQ0fNPFjZfxn+F91XD8o=;
        b=ZR1QSpNAptMj6j48Rmhvuh7PbY0G1YzGHYAXNINE9XD+TTIlITR6IZ0YJuVnly0qxi
         oqRdQGvQ+Smm8FDDzaOg10DTFhu+xP8cmGlJTDnxt1VhUYvyZd+V5CD9SinFek+7HN0n
         p8rbJwoU3bMEgr2S+YdUpGSU21rkVikpVy3iqFirCKLo/WIR25TYp9V27LOoj4DBSClb
         g426GKVlYat3tkiHR0G5ivQmgA5RUYPtvn9lAmgoblMTV8MpKhd4BXo3OXueos5QYQvr
         ri/XoxUWH2AqTlq5fDAy54P8m0058Jrfu9mNkoi5rpwwPwL2h77I7Jq3mP28/skPsZd1
         gPGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Matthieu CASTET <matthieu.castet@parrot.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 17/36] Revert "led: core: Fix brightness setting when setting delay_off=0"
Date: Fri,  9 Mar 2018 16:18:33 -0800
Message-Id: <20180310001808.277179453@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507862180420640?=
X-GMAIL-MSGID: =?utf-8?q?1594507862180420640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This reverts commit 20ac8f72514b3af8b62c520d55656ded865eff00, which
was commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c upstream.
The bug that it should fix was only introduced in Linux 4.7, and
in 4.4 it causes a regression.

Reported-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Matthieu CASTET <matthieu.castet@parrot.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/led-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -149,7 +149,7 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	led_stop_software_blink(led_cdev);
+	del_timer_sync(&led_cdev->blink_timer);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
