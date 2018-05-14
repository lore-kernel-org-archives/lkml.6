Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeENPxJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:53:09 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46922 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbeENPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:53:06 -0400
X-Google-Smtp-Source: AB8JxZqSLfwILOyCab5oCgZm+w2/mUQlYQ3ZetJXf1du8FdxYvO0eyMhnpP7cxt9LNIwEX+A/X47Lw==
Date: Mon, 14 May 2018 11:53:04 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vt: Performsafe  console erase only once
Message-ID: <nycvar.YSQ.7.76.1805141147400.2658@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f8df13e0a9 ("tty: Clean console safely") added code to clear
both the scrollback buffer and the screen with "\e[3J", then execution
falls through into the code to simply clear the screen. This means
scr_memsetw() and the console driver update callback are called twice
on the whole screen buffer. Let's reorganize the code so the same work
is not performed twice needlessly.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f97251f39c..1eb1a376a0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1178,15 +1178,8 @@ static void csi_J(struct vc_data *vc, int vpar)
 			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
 			start = (unsigned short *)vc->vc_origin;
 			break;
-		case 3: /* erase scroll-back buffer (and whole display) */
-			scr_memsetw(vc->vc_screenbuf, vc->vc_video_erase_char,
-				    vc->vc_screenbuf_size);
-			flush_scrollback(vc);
-			set_origin(vc);
-			if (con_is_visible(vc))
-				update_screen(vc);
-			/* fall through */
 		case 2: /* erase whole display */
+		case 3: /* (and scrollback buffer later) */
 			count = vc->vc_cols * vc->vc_rows;
 			start = (unsigned short *)vc->vc_origin;
 			break;
@@ -1194,7 +1187,12 @@ static void csi_J(struct vc_data *vc, int vpar)
 			return;
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
-	if (con_should_update(vc))
+	if (vpar == 3) {
+		set_origin(vc);
+		flush_scrollback(vc);
+		if (con_is_visible(vc))
+			update_screen(vc);
+	} else if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) start, count);
 	vc->vc_need_wrap = 0;
 }
