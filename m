Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeB0WKM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:10:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38090 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeB0WKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:10:09 -0500
X-Google-Smtp-Source: AG47ELs8fYZzZxbQfoRzH5KDDYatNK82NAUir/NrmrxWMypxdAsxILyG1eoMEzAnYcthPWtxGVyCsA==
Date: Tue, 27 Feb 2018 23:09:52 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: w@1wt.eu, geert@linux-m68k.org, andy.shevchenko@gmail.com,
        rabel@robertabel.eu, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3] auxdisplay: charlcd: Fix and clean up handling of x/y
 commands
Message-ID: <20180227220952.57wc3wpc26b2fdyq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version is not parsing multiple x/y commands as the code
originally intended. On top of that, kstrtoul() expects
NULL-terminated strings. Finally, the code does two passes over
the string.

Some explanations about the supported syntax are added as well.

Cc: Willy Tarreau <w@1wt.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Robert Abel <rabel@robertabel.eu>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
Disregard v2, this is much more clear. I am too tired :)

This one and v2 are the loop versions, v1 is the kstrto*() version.
I also added some more comments on top of the v2.

 drivers/auxdisplay/charlcd.c | 95 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 17 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 642afd88870b..36930bce5a1f 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
@@ -292,6 +293,79 @@ static int charlcd_init_display(struct charlcd *lcd)
 	return 0;
 }
 
+/*
+ * Parses an unsigned integer from a string, until a non-digit character
+ * is found. The empty string is not accepted. No overflow checks are done.
+ *
+ * Returns whether the parsing was successful. Only in that case
+ * the output parameters are written to.
+ *
+ * TODO: If the kernel adds an inplace version of kstrtoul(), this function
+ * could be easily replaced by that.
+ */
+static bool parse_n(const char *s, unsigned long *res, const char **next_s)
+{
+	if (!isdigit(*s))
+		return false;
+
+	*res = 0;
+	while (isdigit(*s)) {
+		*res = *res * 10 + (*s - '0');
+		++s;
+	}
+
+	*next_s = s;
+	return true;
+}
+
+/*
+ * Parses a movement command of the form "(.*);", where the group can be
+ * any number of subcommands of the form "(x|y)[0-9]+".
+ *
+ * Returns whether the command is valid. The position arguments are
+ * only written if the parsing was successful.
+ *
+ * For instance:
+ *   - ";"          returns (<original x>, <original y>).
+ *   - "x1;"        returns (1, <original y>).
+ *   - "y2x1;"      returns (1, 2).
+ *   - "x12y34x56;" returns (56, 34).
+ *   - ""           fails.
+ *   - "x"          fails.
+ *   - "x;"         fails.
+ *   - "x1"         fails.
+ *   - "xy12;"      fails.
+ *   - "x12yy12;"   fails.
+ *   - "xx"         fails.
+ */
+static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
+{
+	unsigned long new_x = *x;
+	unsigned long new_y = *y;
+
+	for (;;) {
+		if (!*s)
+			return false;
+
+		if (*s == ';')
+			break;
+
+		if (*s == 'x') {
+			if (!parse_n(s + 1, &new_x, &s))
+				return false;
+		} else if (*s == 'y') {
+			if (!parse_n(s + 1, &new_y, &s))
+				return false;
+		} else {
+			return false;
+		}
+	}
+
+	*x = new_x;
+	*y = new_y;
+	return true;
+}
+
 /*
  * These are the file operation function for user access to /dev/lcd
  * This function can also be called from inside the kernel, by
@@ -469,24 +543,11 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	}
 	case 'x':	/* gotoxy : LxXXX[yYYY]; */
 	case 'y':	/* gotoxy : LyYYY[xXXX]; */
-		if (!strchr(esc, ';'))
-			break;
-
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
-		}
+		/* If the command is valid, move to the new address */
+		if (parse_xy(esc, &priv->addr.x, &priv->addr.y))
+			charlcd_gotoxy(lcd);
 
-		charlcd_gotoxy(lcd);
+		/* Regardless of its validity, mark as processed */
 		processed = 1;
 		break;
 	}
-- 
2.14.1
