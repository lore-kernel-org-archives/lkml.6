Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49q0gK/AmcIZQcKOPEClJYZAk1ZY1wAzlbfMuNw+ZFiLOcc8H0etW/QbrR+OZUvrwm/qkfq
ARC-Seal: i=1; a=rsa-sha256; t=1523399206; cv=none;
        d=google.com; s=arc-20160816;
        b=oJq+huZY/aYaGyoBBqlKpNFBubRJxYgwELsKOzcZTCtq/GshKb4ZmJPJarlLZr3TBE
         M/9f6IxaGoyLNSAzn0185oDPkKWzYxndMtuVdnIUN7bi9AP+YQhxClBCoBH+UmiPA+/L
         ww5O3Yz1kME2uRCCYHEpj6ErJkJmCA/Oq166zGJ6qoep6AdkBL0kVdCxTL+9L9de955d
         juEdu4UFkxiSSA0CvUJzW3Y+f6FetRlPNK2D+RSl3hAf0VLLl27RtMyKVp9V3AGoEdk4
         ya+YQhlmWnn63PqTjs4Ziup6aW6LzZKN48HwaOltSzKMntBvkeX1tjk7OXKcG17SbBfr
         FzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=02goJXRJV08t8t4KUugfduPY/JO7MJbA9MUGDt+IxkY=;
        b=0WDJMv/rZYccuBCFqN92b4m9SFfdVeb+LI2KFZe0CBjpHSpWTGYVKxloMcDGCqxJMm
         VULbt09l3Tk5mtAKvyg5AezRUPX5KaWcZM88YYsHM3YLadoPlP9eCrFaG5xYwW3IjGlM
         CI4vq9/rE5ScfXnDCcjNoFxLO+r6bl0fmSNLD3uUK3A+uB/byYJvO9HKZhlSLNypsFU0
         2R/0GgrUZGOYHZkjTrXXCt4fLTV1OXEqoAXXHx7XHqxiOUjmPDnKJsG34aLFdQVACuQa
         awQZynW6gIZndB8y9d6VlO5cHURiL6id8xyaf3BpzhsO74lI+fVzE01FEB4Nb2oFw83y
         uSow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vladimir Zapolskiy <vz@mleia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 025/168] gpiolib: dont dereference a desc before validation
Date: Wed, 11 Apr 2018 00:22:47 +0200
Message-Id: <20180410212801.267806966@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399847115803139?=
X-GMAIL-MSGID: =?utf-8?q?1597399847115803139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vz@mleia.com>


[ Upstream commit 30322bcf82d74cad0d6e1cf9ba7fa7fa48c7a026 ]

The fix restores a proper validation of an input gpio desc, which
might be needed to deal with optional GPIOs correctly.

Fixes: 02e479808b5d ("gpio: Alter semantics of *raw* operations to actually be raw")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2468,7 +2468,7 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
-	struct gpio_chip *gc = desc->gdev->chip;
+	struct gpio_chip *gc;
 	int ret;
 
 	VALIDATE_DESC(desc);
@@ -2485,6 +2485,7 @@ int gpiod_direction_output(struct gpio_d
 		return -EIO;
 	}
 
+	gc = desc->gdev->chip;
 	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
 		/* First see if we can enable open drain in hardware */
 		ret = gpio_set_drive_single_ended(gc, gpio_chip_hwgpio(desc),
