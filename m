Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeB1AGY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:06:24 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:43765 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeB1AGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:06:21 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 217.50.39.238) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel@vger.kernel.org
Cc: Robert Abel <rabel@robertabel.eu>, miguel.ojeda.sandonis@gmail.com,
        w@1wt.eu, geert@linux-m68k.org, andy.shevchenko@gmail.com
Subject: [PATCH 2/2] auxdisplay: charlcd: make home command unshift display
Date: Wed, 28 Feb 2018 01:05:36 +0100
Message-Id: <20180228000536.9489-3-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180228000536.9489-2-rabel@robertabel.eu>
References: <911beeb5-529f-09bb-0e5a-c5b626adba60@robertabel.eu>
 <20180228000536.9489-1-rabel@robertabel.eu>
 <20180228000536.9489-2-rabel@robertabel.eu>
X-PPP-Message-ID: <20180228000620.8970.73352@mxf98a.netcup.net>
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
 drivers/auxdisplay/charlcd.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index ae078f414539..fdb3aa6423bf 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -43,6 +43,8 @@
 /* LCD commands */
 #define LCD_CMD_DISPLAY_CLEAR	0x01	/* Clear entire display */
 
+#define LCD_CMD_HOME            0x02    /* Set DDRAM address to 0 and unshift display */
+
 #define LCD_CMD_ENTRY_MODE	0x04	/* Set entry mode */
 #define LCD_CMD_CURSOR_INC	0x02	/* Increment cursor */
 
@@ -174,13 +176,24 @@ static void charlcd_gotoxy(struct charlcd *lcd)
 	lcd->ops->write_cmd(lcd, LCD_CMD_SET_DDRAM_ADDR | addr);
 }
 
+/**
+ * charlcd_home() - Return to DDRAM address 0 and unshift the display.
+ * @lcd: LCD descriptor structure.
+ *
+ * Return to coordinates x0/y0 and unshift the display.
+ *
+ * Note: Use the movement command ^[[Lx0y0; instead of home
+ * in case the display should not be unshifted.
+ */
 static void charlcd_home(struct charlcd *lcd)
 {
 	struct charlcd_priv *priv = to_priv(lcd);
 
+	/* return to x0/y0 and unshift the display */
 	priv->addr.x = 0;
 	priv->addr.y = 0;
-	charlcd_gotoxy(lcd);
+	lcd->ops->write_cmd(lcd, LCD_CMD_HOME);
+	long_sleep(2);
 }
 
 static void charlcd_print(struct charlcd *lcd, char c)
@@ -198,11 +211,21 @@ static void charlcd_print(struct charlcd *lcd, char c)
 		charlcd_gotoxy(lcd);
 }
 
+/**
+ * charlcd_clear_fast() - Perform a fast clear of the display and return home.
+ * @lcd: LCD descriptor structure.
+ *
+ * The display will be unshifted and at coordinates x0/y0 after fast clear.
+ */
 static void charlcd_clear_fast(struct charlcd *lcd)
 {
+	struct charlcd_priv *priv = to_priv(lcd);
 	int pos;
 
-	charlcd_home(lcd);
+	/* avoid artifacts by going to x0/y0 without unshifting the display */
+	priv->addr.x = 0;
+	priv->addr.y = 0;
+	charlcd_gotoxy(lcd);
 
 	if (lcd->ops->clear_fast)
 		lcd->ops->clear_fast(lcd);
@@ -210,6 +233,7 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 		for (pos = 0; pos < min(2, lcd->height) * lcd->hwidth; pos++)
 			lcd->ops->write_data(lcd, ' ');
 
+	/* return to x0/y0 and unshift the display */
 	charlcd_home(lcd);
 }
 
-- 
2.11.0
