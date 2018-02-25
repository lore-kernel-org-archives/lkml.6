Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeBYXy7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:54:59 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:39442 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeBYXyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:54:53 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.101.1) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Abel <rabel@robertabel.eu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4/4] auxdisplay: charlcd: make home command unshift display
Date: Mon, 26 Feb 2018 00:54:32 +0100
Message-Id: <20180225235432.31209-5-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225235432.31209-4-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
X-PPP-Message-ID: <20180225235452.31440.86093@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user has no way of unshifting the display programmatically once shifted.
Users cannot rely on ^[[H (home) to result in their message being seen either.
Use the actual HOME command 0x02 instead of only returning to x0/y0.
Users can still do ^[[Lx0y0; (go to x/y) if they wish to use the 'old' home
function.
Implement fast clearing of LCD by going to x0/y0 first, clearing display and
then calling home to possibly unshift display possibly avoiding artifacts by
not unshifting before clearing display.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 24cabe88c7f0..41f9aa4a73d4 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -43,6 +43,8 @@
 /* LCD commands */
 #define LCD_CMD_DISPLAY_CLEAR	0x01	/* Clear entire display */
 
+#define LCD_CMD_HOME            0x02    /* Set DDRAM address to 0 and unshift display */
+
 #define LCD_CMD_ENTRY_MODE	0x04	/* Set entry mode */
 #define LCD_CMD_CURSOR_INC	0x02	/* Increment cursor */
 
@@ -182,7 +184,8 @@ static void charlcd_home(struct charlcd *lcd)
 
 	priv->addr.x = 0;
 	priv->addr.y = 0;
-	charlcd_gotoxy(lcd);
+	lcd->ops->write_cmd(lcd, LCD_CMD_HOME);
+	long_sleep(2);
 }
 
 static void charlcd_print(struct charlcd *lcd, char c)
@@ -202,9 +205,12 @@ static void charlcd_print(struct charlcd *lcd, char c)
 
 static void charlcd_clear_fast(struct charlcd *lcd)
 {
+	struct charlcd_priv *priv = to_priv(lcd);
 	int pos;
 
-	charlcd_home(lcd);
+	priv->addr.x = 0;
+	priv->addr.y = 0;
+	charlcd_gotoxy(lcd);
 
 	if (lcd->ops->clear_fast)
 		lcd->ops->clear_fast(lcd);
-- 
2.11.0
