Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeE3V2X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:28:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61993 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeE3V2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:28:21 -0400
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] vt: coherence validation code for the unicode screen buffer
Date: Wed, 30 May 2018 17:27:45 -0400
Message-Id: <20180530212745.10997-6-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530212745.10997-1-nicolas.pitre@linaro.org>
References: <20180530212745.10997-1-nicolas.pitre@linaro.org>
X-Pobox-Relay-ID: 5F6B0AE6-6450-11E8-8574-44CE1968708C-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the unicode screen buffer matches the video screen content.
This is provided for debugging convenience and disabled by default.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e7c3cabeb1..2f3d528082 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -571,6 +571,45 @@ void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
 	}
 }
 
+/* this is for validation and debugging only */
+static void vc_uniscr_debug_check(struct vc_data *vc)
+{
+	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	unsigned short *p;
+	int x, y, mask;
+
+	if (true)
+		return;
+
+	if (!uniscr)
+		return;
+
+	WARN_CONSOLE_UNLOCKED();
+
+	/*
+	 * Make sure our unicode screen translates into the same glyphs
+	 * as the actual screen. This is brutal indeed.
+	 */
+	p = (unsigned short *)vc->vc_origin;
+	mask = vc->vc_hi_font_mask | 0xff;
+	for (y = 0; y < vc->vc_rows; y++) {
+		char32_t *line = uniscr->lines[y];
+		for (x = 0; x < vc->vc_cols; x++) {
+			u16 glyph = scr_readw(p++) & mask;
+			char32_t uc = line[x];
+			int tc = conv_uni_to_pc(vc, uc);
+			if (tc == -4)
+				tc = conv_uni_to_pc(vc, 0xfffd);
+			if (tc == -4)
+				tc = conv_uni_to_pc(vc, '?');
+			if (tc != glyph)
+				pr_notice("%s: mismatch at %d,%d: "
+					  "glyph=%#x tc=%#x\n", __func__,
+					  x, y, glyph, tc);
+		}
+	}
+}
+
 
 static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		enum con_scroll dir, unsigned int nr)
@@ -2719,6 +2758,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 		do_con_trol(tty, vc, orig);
 	}
 	con_flush(vc, draw_from, draw_to, &draw_x);
+	vc_uniscr_debug_check(vc);
 	console_conditional_schedule();
 	console_unlock();
 	notify_update(vc);
-- 
2.17.0
