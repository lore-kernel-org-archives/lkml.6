Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeBYXz2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:55:28 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:53032 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbeBYXyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:54:52 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.101.1) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Abel <rabel@robertabel.eu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
Date: Mon, 26 Feb 2018 00:54:31 +0100
Message-Id: <20180225235432.31209-4-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225235432.31209-3-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
X-PPP-Message-ID: <20180225235451.31422.46656@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUL-terminate each individual number to be parsed.
To do this, the next command character and a pointer to its argument
are found and stored. The command character is then overwritten by NUL
before kstr* functions are called on the buffer.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 53 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index a3d364e6c666..24cabe88c7f0 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -471,28 +471,63 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	}
 	case 'x':	/* gotoxy : LxXXX[yYYY]; */
-	case 'y':	/* gotoxy : LyYYY[xXXX]; */
+	case 'y': {	/* gotoxy : LyYYY[xXXX]; */
+
+		char* nxt_esc;
+		char  nxt_cmd;
+		char  cmd;
+		struct charlcd_priv_addr tmp_addr;
+
 		if (!strchr(esc, ';'))
 			break;
 
-		while (*esc) {
-			if (*esc == 'x') {
-				esc++;
-				if (kstrtoul(esc, 10, &priv->addr.x) < 0)
+		/* sequence is processed whether legal or illegal */
+		processed = 1;
+
+		/* copy current address to temporary buffer */
+		tmp_addr = priv->addr;
+
+		nxt_cmd = *esc++;
+		nxt_esc = esc;
+
+		while ('\0' != *esc) {
+
+			cmd = nxt_cmd;
+			esc = nxt_esc;
+			nxt_esc = strpbrk(esc, "xy;");
+			if (NULL != nxt_esc) {
+				nxt_cmd = *nxt_esc;
+				/* terminate current sequence with NUL */
+				*nxt_esc++ = '\0';
+			}
+
+			if ('x' == cmd) {
+				if (kstrtoul(esc, 10, &tmp_addr.x) < 0)
 					break;
-			} else if (*esc == 'y') {
-				esc++;
-				if (kstrtoul(esc, 10, &priv->addr.y) < 0)
+			} else if ('y' == cmd) {
+				if (kstrtoul(esc, 10, &tmp_addr.y) < 0)
 					break;
 			} else {
+				/* break on unknown command or ';' */
 				break;
 			}
+
 		}
 
+		/* unknown commands in sequence will be followed by at least ';' */
+		if ('\0' != *esc)
+			break;
+
+		/* clamp new x/y coordinates */
+		if (tmp_addr.x >= lcd->width)
+			tmp_addr.x = lcd->width - 1;
+		tmp_addr.y %= lcd->height;
+
+		priv->addr = tmp_addr;
 		charlcd_gotoxy(lcd);
-		processed = 1;
 		break;
 	}
+	}
 
 	/* TODO: This indent party here got ugly, clean it! */
 	/* Check whether one flag was changed */
-- 
2.11.0
