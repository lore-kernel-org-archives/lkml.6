Return-Path: <jacek.anaszewski@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521487488; cv=none;
        d=google.com; s=arc-20160816;
        b=uozWW0EfU5og14k+wMx0PFdC0M7HtCp7VubWXMnP0/4qQAZl5canM4F3k0a0NK+Sys
         lOThlYusv0BZflvJEl57vLvrdc8i9WAs/ua73TkUnWupQuIk5mYgr4xp8YAMwycog1+f
         pU/3SaK422c/uqNERH2zQCRQV3zfIGajSf+Hxh7L/pH+ssB5Jp2sJan/f5WHSwUVbzgr
         psrnz7VJEOzfze+3m6meMmGkykZtDaVYc5vLsegT2WRsA5uSPAuj8WxBDp4dld4xxLdr
         r5EiZNvq+Ptt/vaOUXFjQ+Xt9Y5UM2AOANAcDGLIlzz270aTLiWts49UovKWUs/bd7gX
         7Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=BNmB/0a3IdnFLwCNz/ZcGpTkdw999lsfp1YmEZp8hSk=;
        b=X0tB3AgW5NARlT2H8dorlb1MW9tJxDhcPV4nPjpxasvyCvtc4yKD67XybZRRlp93Nu
         3vVnkmnQD4IE9rMRlAEesckA6nXHb+0xN39vvIhZjr6xx1yCxCK5778ArAdjZwZpcUox
         bTDJLqZC+ASdRhnGHCpr0SdpAsaBHt5jMK8MNlhECmFHmxjeoXZS+frxFYIfHNNvp+EI
         jadtsAeCqd5M5fginCTeOhhDP4X1ZyIMhUz7Q7R5TmKR2DH5NxwrTMgI6cWxPh6OjJ6G
         EJ7r6DvAYBB0Zt3lbchMC3GGY9SpCYXpspc7lr+NW4AD3Mz73qcJopaSESVinuTp5b9K
         2WIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=icCZUVZy;
       spf=pass (google.com: domain of jacek.anaszewski@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jacek.anaszewski@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=icCZUVZy;
       spf=pass (google.com: domain of jacek.anaszewski@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jacek.anaszewski@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvaz1EQ9419WqECTOKWDxF2CICe4i/Z9A2QksXQghemIePCKjwUcwqX8+PNdCDUnf9PL9VKqQ==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz,
	jacek.anaszewski@gmail.com
Subject: [PATCH 4.9 v2 1/2] Revert "led: core: Fix brightness setting when setting delay_off=0"
Date: Mon, 19 Mar 2018 20:23:18 +0100
Message-Id: <1521487399-10447-2-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521487399-10447-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1521487399-10447-1-git-send-email-jacek.anaszewski@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595395264577300277?=
X-GMAIL-MSGID: =?utf-8?q?1595395264577300277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 86b9fa2190907f4f550d9d6bf490c5f89ca33836.

The commit being reverted has two flaws:
 - it introduces a regression, fixed in the upstream
   commit 7b6af2c53192f1766892ef40c8f48a413509ed72.
 - it has truncated commit message

Reported-by: Sasha Levin <Alexander.Levin@microsoft.com>
Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/led-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index d70d4a5..3bce448 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -186,7 +186,7 @@ void led_blink_set(struct led_classdev *led_cdev,
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	led_stop_software_blink(led_cdev);
+	del_timer_sync(&led_cdev->blink_timer);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
-- 
2.1.4
