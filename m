Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeB1AGV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:06:21 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:41136 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeB1AGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:06:20 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 217.50.39.238) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel@vger.kernel.org
Cc: Robert Abel <rabel@robertabel.eu>, miguel.ojeda.sandonis@gmail.com,
        w@1wt.eu, geert@linux-m68k.org, andy.shevchenko@gmail.com
Subject: [PATCH 1/2] auxdisplay: charlcd: fix x/y address commands
Date: Wed, 28 Feb 2018 01:05:35 +0100
Message-Id: <20180228000536.9489-2-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180228000536.9489-1-rabel@robertabel.eu>
References: <911beeb5-529f-09bb-0e5a-c5b626adba60@robertabel.eu>
 <20180228000536.9489-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20180228000619.8953.70704@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version does not parse x/y commands at all.
Simplify the x/y command syntax to the one indicated in
the comment all along and introduce a parsing function
that handles parsing a sequence of one or two subcommands
where each subcommand must appear at most once.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 109 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index e3b2fd15c5a3..ae078f414539 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -292,6 +292,96 @@ static int charlcd_init_display(struct charlcd *lcd)
 	return 0;
 }
 
+/**
+ * parse_xy() - Parse coordinates of a movement command.
+ * @s: Pointer to null-terminated movement command string.
+ * @x: Pointer to x position.
+ * @y: Pointer to y position.
+ *
+ * Parses a movement command of the form "([xy][0-9]+){1,2};",
+ * where each group must begin with a different subcommand.
+ *
+ * The positions will only be updated when their respective
+ * subcommand is encountered and when the whole movement
+ * command is valid.
+ *
+ * The movement command string must contain a ';' at the end.
+ *
+ * For instance:
+ *   - ";"          fails.
+ *   - "x1;"        returns (1, <original y>).
+ *   - "y2x1;"      returns (1, 2).
+ *   - "x12y34x56;" fails.
+ *   - ""           fails.
+ *   - "x"          illegal input.
+ *   - "x;"         fails.
+ *   - "x1"         illegal input.
+ *   - "xy12;"      fails.
+ *   - "x12yy12;"   fails.
+ *   - "xx"         illegal input.
+ *
+ * Return: Returns whether the command is valid. The position arguments are
+ * only written if the parsing was successful.
+ */
+static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
+{
+
+	unsigned long new_x = *x;
+	unsigned long new_y = *y;
+
+	char xcoord[LCD_ESCAPE_LEN];
+	char ycoord[LCD_ESCAPE_LEN];
+	const char *split = strpbrk(s + 1, "xy");
+	const char *end = strchr(s, ';');
+	char *coord0 = xcoord;
+	char *coord1 = ycoord;
+	unsigned long *new0 = &new_x;
+	unsigned long *new1 = &new_y;
+
+	memset(xcoord, 0, sizeof(xcoord));
+	memset(ycoord, 0, sizeof(ycoord));
+
+	/* validate input */
+	switch (*s) {
+	case 'x':
+		if (split != NULL && *split != 'y')
+			return false;
+		break;
+	case 'y':
+		/* swap coordinates */
+		coord0 = ycoord;
+		coord1 = xcoord;
+		new0 = &new_y;
+		new1 = &new_x;
+
+		if (split != NULL && *split != 'x')
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	/* parse coordinate 0 and 1 */
+	if (split == NULL) {
+		memcpy(coord0, s + 1, end - s - 1);
+		if (kstrtoul(coord0, 10, new0) < 0)
+			return false;
+	} else {
+		memcpy(coord0, s + 1, split - s - 1);
+		memcpy(coord1, split + 1, end - split - 1);
+		if (kstrtoul(coord0, 10, new0) < 0)
+			return false;
+		if (kstrtoul(coord1, 10, new1) < 0)
+			return false;
+	}
+
+	/* update coordinates on success */
+	*x = new_x;
+	*y = new_y;
+	return true;
+
+}
+
 /*
  * These are the file operation function for user access to /dev/lcd
  * This function can also be called from inside the kernel, by
@@ -473,21 +563,14 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		if (!strchr(esc, ';'))
 			break;
 
-		while (*esc) {
-			if (*esc == 'x') {
-				esc++;
-				if (kstrtoul(esc, 10, &priv->addr.x) < 0)
-					break;
-			} else if (*esc == 'y') {
-				esc++;
-				if (kstrtoul(esc, 10, &priv->addr.y) < 0)
-					break;
-			} else {
-				break;
-			}
+		/* If the command is valid, move to the new address */
+		if (parse_xy(esc, &priv->addr.x, &priv->addr.y)) {
+			priv->addr.x = min_t(unsigned long, priv->addr.x, lcd->bwidth - 1);
+			priv->addr.y %= lcd->height;
+			charlcd_gotoxy(lcd);
 		}
 
-		charlcd_gotoxy(lcd);
+		/* Regardless of its validity, mark as processed */
 		processed = 1;
 		break;
 	}
-- 
2.11.0
