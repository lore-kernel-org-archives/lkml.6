Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1524664124; cv=none;
        d=google.com; s=arc-20160816;
        b=L+pfXD7KL+oiiRouuIg1VXbyN05kDk33RsbZBdf52bYdLRN6AVT/KmDGAXATIexkmq
         lp8/XQy3rB/1LXghc6HqyEo6KNnn4QYHJicXxm8I/RhCAigMxtL5IZunI1ron8Ov9hJi
         v2DkRJyeehJZkGYSWWzQIkLiEkIstDwx0RkStiDerwP7q86HPs7mPNcGXTvaCk/MeztJ
         M/c5m7Ertl7e8lUIg+6GEYNJXCIZ/8Dqh71jZefDFzgz3zAuPqEJO9sQdwNsLckt4u+F
         57RsC0PhEC8wwL2QJ5Xjs6UTYr5XIf5fineWol6kIXEwWnbUsb5g22nZClOJl8NUnyIU
         aNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=uJqPXugZyAi53V7QPyWxea7q47FDpjbn3ulhQkQSLQA=;
        b=Ap69ZzEl4/GcT3Wg61Mgnwy9ne9tCDOf/BZMEszHkCrtJBG/dVXojKMO4OVZlBd8a+
         5COPOZBv9/YkaAP9cgIZ+uApEGS4qirQOx850iPmsH7TjqKH2B2J+d6IhzTYjp8BIddu
         QU0FqkB0VIc3YAVjG6P37E/dk6aDcjs3uD2q0H/UV5Utm+YR1BxQl0PhbBYTpmJ9ASCZ
         f+nQmLd3No9zTp5EaXH6XAoNJilS/8KqBmHgbOz1kcy1gXR7L2z49UxQ2zQ4jhQG/Up/
         h7KfmmfNrodaCWG4qJcyqW8J6CT3reILDlbvsQpuPdEfutr0HA4YHE1EOiLUXe7A1xHt
         szlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=fxdbOOdI;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=fxdbOOdI;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AIpwx4/mq2hoSAt43MklBxINtR7r8Q0bxXEX7bdILBz5l6dFm4KfChfd54yvilBD+t/HZSARFhpOag==
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu,
	devicetree@vger.kernel.org,
	Rob Herring <robherring2@gmail.com>,
	matt.redfearn@mips.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org,
	Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] earlycon: Remove hardcoded port->uartclk initialization in of_setup_earlycon
Date: Wed, 25 Apr 2018 15:48:42 +0200
Message-Id: <3244a776bc8c4c0c8e39cc8daa386b82d50dc86d.1524664120.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598726209175573483?=
X-GMAIL-MSGID: =?utf-8?q?1598726209175573483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
systems.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Matt Redfearn <matt.redfearn@mips.com>
---

It looks like from history that portclk = BASE_BAUD * 16 was setup to
get on calculation on x86 (divisor = 1) but it shouldn't be needed on DT based
system. That's why I think that there is no DT based system which really
requires this line.
---
 drivers/tty/serial/earlycon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a24278380fec..c12b1edcdd8e 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -244,7 +244,6 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		return -ENXIO;
 	}
 	port->mapbase = addr;
-	port->uartclk = BASE_BAUD * 16;
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
-- 
2.17.0
