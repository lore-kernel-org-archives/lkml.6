Return-Path: <mike.looijmans@topic.nl>
X-Google-Smtp-Source: AH8x224Wo6at0X3o6U+vnAkk4kzFmttwYywmJ0lCHlr8svUcZYRbSnDDNnbAFNL9dPHdXChbt04n
ARC-Seal: i=1; a=rsa-sha256; t=1519225452; cv=none;
        d=google.com; s=arc-20160816;
        b=bd45AAlrWYl3Df0ddp5gchkAtVH/EFoLbFE/wCsLftm7Q7lomRoArubNGAj/4orw/z
         dO8DQV/v/dP0omoTn6l8592v8ySNYDtkjJE444VLTmgttP4o0v885j2yj+PtitaMChBF
         A71h+OblJzzLXFWZ5OPO9Ipb6bBFv8Dm/eUFB7dlDDHBVz1iqDXT0w2NPiNc5K1xmgb7
         NPuYHqRwb4180zzRyIasX2C83/FDYVd2Gtx334bybRI1Z8qQK/QVHBexqvAAjBdgLaIZ
         iCfbpWKC5F3sa9FpioAkjY9055ScB9GTS0g6DMmnq438iXi5aX9hVAh9srCZKqTzYwGl
         FUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=oewThE0Z74MIGRB2SnsGGxMaI8eQIbcjxV7v80+KBmA=;
        b=eW6HMqKS+8MaIUgPubDCSFJA91SC3tOgVL/TDjJsiBV8DXH+2aFZ87ZHttafGvRxmz
         c1QtECylg57lkGqYhjuHjMep6kqb9pOqpsSu/Mc+R5T+UrGnJbkLc4NfL7E1z0LbHk1x
         wdYCuIEbBWPaYPQHs9cJb3ULgLQVN8MChNXdyqXdMp1T/aCJwDYqt9GvPGBQeK5E81y9
         Y8F/5ZjyO2eeI6nLSW/8iJI/hclEQWpxmKyQyAPHfOzPaOOOtrrBOnN1dm3C/VvapT9W
         Hd2Sbkco98IEg9sDFDYc/Tg+cawwt6081r1R3hHo0YKi5IeuVGQ1sEMNw34QqORXWr+o
         SUgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=fail (google.com: domain of mike.looijmans@topic.nl does not designate 64.69.218.112 as permitted sender) smtp.mailfrom=mike.looijmans@topic.nl
Authentication-Results: mx.google.com;
       spf=fail (google.com: domain of mike.looijmans@topic.nl does not designate 64.69.218.112 as permitted sender) smtp.mailfrom=mike.looijmans@topic.nl
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: balbi@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] usb: phy-generic: Use gpiod_set_value_cansleep
Date: Wed, 21 Feb 2018 16:04:01 +0100
Message-Id: <1519225441-18079-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593023347150322057?=
X-GMAIL-MSGID: =?utf-8?q?1593023347150322057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The nop_reset and shutdown methods are called in a context that can sleep,
so use gpiod_set_value_cansleep instead of gpiod_set_value.

If you've connected the reset line to a GPIO expander, you'd get a kernel
"slowpath" warning with gpiod_set_value.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/usb/phy/phy-generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 74ba882..a53b89b 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -63,9 +63,9 @@ static void nop_reset(struct usb_phy_generic *nop)
 	if (!nop->gpiod_reset)
 		return;
 
-	gpiod_set_value(nop->gpiod_reset, 1);
+	gpiod_set_value_cansleep(nop->gpiod_reset, 1);
 	usleep_range(10000, 20000);
-	gpiod_set_value(nop->gpiod_reset, 0);
+	gpiod_set_value_cansleep(nop->gpiod_reset, 0);
 }
 
 /* interface to regulator framework */
@@ -159,7 +159,7 @@ void usb_gen_phy_shutdown(struct usb_phy *phy)
 {
 	struct usb_phy_generic *nop = dev_get_drvdata(phy->dev);
 
-	gpiod_set_value(nop->gpiod_reset, 1);
+	gpiod_set_value_cansleep(nop->gpiod_reset, 1);
 
 	if (!IS_ERR(nop->clk))
 		clk_disable_unprepare(nop->clk);
-- 
1.9.1
