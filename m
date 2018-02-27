Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeB0Tci (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:32:38 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42783 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeB0Tch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:32:37 -0500
X-Google-Smtp-Source: AH8x225fX0uXLeUSFG726s7sjNDXjf/WpqYM7IoQQ891BdxRYbCIutwm+JQm74Tfm52zb5lsOLPG0w==
Date: Tue, 27 Feb 2018 20:32:21 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: w@1wt.eu, geert@linux-m68k.org, andy.shevchenko@gmail.com,
        rabel@robertabel.eu, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] auxdisplay: charlcd: Fix and clean up handling of x/y
 commands
Message-ID: <20180227193118.n33bkbrqxybfhgdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version is not parsing multiple x/y commands as the code
originally intended. On top of that, kstrtoul() expects
NULL-terminated strings. Finally, the code had to do two passes over
the string, while now only one is done.

Some explanations about the supported syntax are added as well.

Cc: Willy Tarreau <w@1wt.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Robert Abel <rabel@robertabel.eu>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
Only the parsing functions are tested, please try on real HW.

 drivers/auxdisplay/charlcd.c | 97 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 642afd88870b..aa9a6abc2ada 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
@@ -292,13 +293,86 @@ static int charlcd_init_display(struct charlcd *lcd)
 	return 0;
 }
 
+/*
+ * Parses a base 10 number from a string, until a non-digit number is found or
+ * until PARSE_N_MAX_SIZE digits.
+ *
+ * See kstrtoul() for the meaning of the return value.
+ * It also returns the next character in the string, i.e. the first non-digit.
+ */
+#define PARSE_N_MAX_SIZE (3)
+static unsigned long parse_n(const char *s, unsigned long *res,
+	const char **next_s)
+{
+	char tmp[PARSE_N_MAX_SIZE + 1];
+	int i;
+
+	for (i = 0; ; ++i) {
+		if (!isdigit(s[i]))
+			break;
+		if (i >= PARSE_N_MAX_SIZE)
+			return -EINVAL;
+		tmp[i] = s[i];
+	}
+
+	tmp[i] = 0;
+	*next_s = &s[i];
+	return kstrtoul(tmp, 10, res);
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
+ *   - "x1"         fails.
+ *   - "xy12;"      fails.
+ *   - "x12yy12;"   fails.
+ */
+static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
+{
+	unsigned long new_x = *x;
+	unsigned long new_y = *y;
+	const char *next_s;
+
+	for (;;) {
+		if (!*s)
+			return false;
+
+		if (*s == ';')
+			break;
+
+		if (*s == 'x') {
+			if (parse_n(s + 1, &new_x, &next_s) != 0)
+				return false;
+			s = next_s;
+		} else if (*s == 'y') {
+			if (parse_n(s + 1, &new_y, &next_s) != 0)
+				return false;
+			s = next_s;
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
  * setting file and ppos to NULL.
  *
  */
-
 static inline int handle_lcd_special_code(struct charlcd *lcd)
 {
 	struct charlcd_priv *priv = to_priv(lcd);
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
