Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49NXUvM9WAd85Uo8RGGkz/UPkuTjqhqk4ApcUchWtn45x02m8jmPF7QLsL7DIvg/xCyTWcZ
ARC-Seal: i=1; a=rsa-sha256; t=1523021230; cv=none;
        d=google.com; s=arc-20160816;
        b=H6KKkxAqp9iAEltg+s+FHBYrwpAOXpve5k8M9swD5z7EYbLV1UvFtJwNMu4oh3PZMt
         LPX0titKl6JodrgwpCXdqqczkjgaxW8cF5PtQEKy0jD+ADPZWuC7nkbKaQjefRqzAAtT
         8ZMFLOJpko5ZWi74Snhz0fQqu45OCzBejNKvTRfK8BeNFlDBL/LCCvuzaRenkCFwLqKB
         06R1sk1R4UNOsv1/QIFeRNWa9lvMSoC7fv+nJgtRIgrd+LB8Dl4D/oGi5OSqxF0oH1qE
         1qkgcC4pENBLKlCx00PFnLWl1oF3cmeYxTbBfXoAg5e23DuLgtd8SENm8rluQz16gd/2
         sQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PCPecIYJqIcva8Tacfrk1ZwC8YGMz0+R0H9uwu5OJso=;
        b=K7YJ3Bjpr+oJvNVwFCl0+iyyl5Nf/Ogfr3rbtN5vLjvw5SVtobTTWcUga2zieBYQOu
         siK7QanFyqxh3WbWm89I2NRHLSG7fdvGeknpaM/WDhmJBs0gjI8Q8nibxZhYT8KgARGu
         WZO1Za40vNHxEYoU4BPKao45pc4ARnaznhCpt1w6orV89xm7ENOq7Bozae2f9D4CMp7B
         PpaYeVwVVQQD9ZILwrAEIhunzD8Gli7JP029XZky86Fhl65TYrwckXa2y2I5imKwVSZt
         h/E0RU4b1zx/9PQaeyy3DOIKNSmS12JMIGt3qbhQDVYv58TcGTX+RflwnyeovfC6ZML2
         uTuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Matthieu CASTET <matthieu.castet@parrot.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Wang Han <wanghan1995315@gmail.com>
Subject: [PATCH 3.18 47/93] Revert "led: core: Fix brightness setting when setting delay_off=0"
Date: Fri,  6 Apr 2018 15:23:16 +0200
Message-Id: <20180406084226.975987221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003509765091710?=
X-GMAIL-MSGID: =?utf-8?q?1597003509765091710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This reverts commit 20f6d9c2af33da892a0e03ffd6249c7ab81edfb7, which
was commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c upstream.
The bug that it should fix was only introduced in Linux 4.7, and
in 4.4 it causes a regression.

Reported-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Matthieu CASTET <matthieu.castet@parrot.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Wang Han <wanghan1995315@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/led-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -76,7 +76,7 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	led_stop_software_blink(led_cdev);
+	del_timer_sync(&led_cdev->blink_timer);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
