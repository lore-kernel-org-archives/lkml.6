Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeE3V3b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:29:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62606 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeE3V2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:28:21 -0400
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] vt: unicode fallback for scrollback
Date: Wed, 30 May 2018 17:27:44 -0400
Message-Id: <20180530212745.10997-5-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530212745.10997-1-nicolas.pitre@linaro.org>
References: <20180530212745.10997-1-nicolas.pitre@linaro.org>
X-Pobox-Relay-ID: 5F0906B6-6450-11E8-B454-67830C78B957-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently no provision for scrollback content in the core code,
leaving that to backend video drivers where this can be highly optimized.
There is currently no common method for those drivers to tell the core
what part of the scrollback is actually displayed and what size the
scrollback buffer is either. Because of that, the unicode screen buffer
has no provision for any scrollback.

At least we can provide backtranslated glyph values when the scrollback
is active which should be plenty good enough for now.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Dave Mielke <Dave@mielke.cc>
---
 drivers/tty/vt/vc_screen.c |  3 ++-
 drivers/tty/vt/vt.c        | 31 +++++++++++++++++++++++++++++--
 include/linux/selection.h  |  2 +-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 9c44252e52..2384ea85ff 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -311,7 +311,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			do {
 				if (nr > this_round/4)
 					nr = this_round/4;
-				vc_uniscr_copy_line(vc, con_buf0, row, col, nr);
+				vc_uniscr_copy_line(vc, con_buf0, viewed,
+						    row, col, nr);
 				con_buf0 += nr * 4;
 				this_round -= nr * 4;
 				row++;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2cba6089ca..e7c3cabeb1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -535,13 +535,40 @@ int vc_uniscr_check(struct vc_data *vc)
  * This must be preceded by a successful call to vc_uniscr_check() once
  * the console lock has been taken.
  */
-void vc_uniscr_copy_line(struct vc_data *vc, void *dest,
+void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
 			 unsigned int row, unsigned int col, unsigned int nr)
 {
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	int offset = row * vc->vc_size_row + col * 2;
+	unsigned long pos;
 
 	BUG_ON(!uniscr);
-	memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
+
+	pos = (unsigned long)screenpos(vc, offset, viewed);
+	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
+		/*
+		 * Desired position falls in the main screen buffer.
+		 * However the actual row/col might be different if
+		 * scrollback is active.
+		 */
+		row = (pos - vc->vc_origin) / vc->vc_size_row;
+		col = ((pos - vc->vc_origin) % vc->vc_size_row) / 2;
+		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
+	} else {
+		/*
+		 * Scrollback is active. For now let's simply backtranslate
+		 * the screen glyphs until the unicode screen buffer does
+		 * synchronize with console display drivers for a scrollback
+		 * buffer of its own.
+		 */
+		u16 *p = (u16 *)pos;
+		int mask = vc->vc_hi_font_mask | 0xff;
+		char32_t *uni_buf = dest;
+		while (nr--) {
+			u16 glyph = scr_readw(p++) & mask;
+			*uni_buf++ = inverse_translate(vc, glyph, true);
+		}
+	}
 }
 
 
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 2b34df9f1e..067d2e99c7 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -43,7 +43,7 @@ extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
 extern void vcs_scr_updated(struct vc_data *vc);
 
 extern int vc_uniscr_check(struct vc_data *vc);
-extern void vc_uniscr_copy_line(struct vc_data *vc, void *dest,
+extern void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
 				unsigned int row, unsigned int col,
 				unsigned int nr);
 
-- 
2.17.0
