Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932561AbeE3V20 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:28:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63592 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932382AbeE3V2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:28:21 -0400
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] vt: perform safe console erase only once
Date: Wed, 30 May 2018 17:27:41 -0400
Message-Id: <20180530212745.10997-2-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530212745.10997-1-nicolas.pitre@linaro.org>
References: <20180530212745.10997-1-nicolas.pitre@linaro.org>
X-Pobox-Relay-ID: 5EE000B8-6450-11E8-8397-44CE1968708C-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f8df13e0a9 ("tty: Clean console safely") added code to clear
both the scrollback buffer and the screen with "\e[3J", then execution
falls through into the code to simply clear the screen. This means
scr_memsetw() and the console driver update callback is called twice
on the whole screen buffer. Let's reorganize the code so the same work
is not performed twice.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vt.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

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
-- 
2.17.0
