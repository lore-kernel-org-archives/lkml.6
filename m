Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80991C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D5220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D5220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeILBpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:45:07 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42400 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeILBpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:45:06 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 9F75B3A19E1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 22:18:28 +0200 (CEST)
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E40E7240009;
        Tue, 11 Sep 2018 20:18:26 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 3/4] drivers/tty/vt/keyboard.c: Make key_down[] bitmap input dependent
Date:   Tue, 11 Sep 2018 22:23:58 +0200
Message-Id: <45a4a8e3123730bf900ea921baf153ff0c899dd5.1536695071.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536695070.git.repk@triplefau.lt>
References: <cover.1536695070.git.repk@triplefau.lt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kbd_handle input can have a specific keyboard config that makes
keycode to keysym mapping array different from another one. Because
key_down[] bitmap stores currently pressed key as keycode, it should be
associated with an input keymap in order to retrieve the associated
keysym.

Allocating this array in each input allows to retrieve its associated
keymap.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Tested-by: Elie Roudninski <xademax@gmail.com>
---
 drivers/tty/vt/keyboard.c | 46 +++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 4f09331ad5c3..7272e1828838 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -122,6 +122,7 @@ struct kbd_handle {
 	struct kref ref;
 	struct kbd_conf *conf;
 	struct input_handle handle;
+	unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];/* keyboard key bitmap */
 };
 #define hdl_to_kbd_handle(h) (container_of(h, struct kbd_handle, handle))
 
@@ -140,7 +141,6 @@ static const int NR_TYPES = ARRAY_SIZE(max_vals);
 static struct input_handler kbd_handler;
 static DEFINE_SPINLOCK(kbd_event_lock);
 static DEFINE_SPINLOCK(led_lock);
-static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key bitmap */
 static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
 static bool dead_key_next;
 static int npadch = -1;					/* -1 or number assembled on pad */
@@ -378,20 +378,18 @@ static void to_utf8(struct vc_data *vc, uint c)
 
 /*
  * Called after returning from RAW mode or when changing consoles - recompute
- * shift_down[] and shift_state from key_down[] maybe called when keymap is
- * undefined, so that shiftkey release is seen. The caller must hold the
- * kbd_event_lock.
+ * shift_down[] and shift_state from each input's key_down[] maybe called when
+ * keymap is undefined, so that shiftkey release is seen. The caller must hold
+ * the kbd_event_lock.
  */
 
-static void do_compute_shiftstate(void)
+static int do_compute_input_shiftstate(struct input_handle *handle, void *data)
 {
+	struct kbd_handle *kh = hdl_to_kbd_handle(handle);
 	unsigned int k, sym, val;
 
-	shift_state = 0;
-	memset(shift_down, 0, sizeof(shift_down));
-
-	for_each_set_bit(k, key_down, min(NR_KEYS, KEY_CNT)) {
-		sym = U(key_maps[0][k]);
+	for_each_set_bit(k, kh->key_down, min(NR_KEYS, KEY_CNT)) {
+		sym = U(kh->conf->maps[0][k]);
 		if (KTYP(sym) != KT_SHIFT && KTYP(sym) != KT_SLOCK)
 			continue;
 
@@ -402,6 +400,15 @@ static void do_compute_shiftstate(void)
 		shift_down[val]++;
 		shift_state |= BIT(val);
 	}
+	return 0;
+}
+
+static void do_compute_shiftstate(void)
+{
+	shift_state = 0;
+	memset(shift_down, 0, sizeof(shift_down));
+	input_handler_for_each_handle(&kbd_handler, NULL,
+			do_compute_input_shiftstate);
 }
 
 /* We still have to export this method to vt.c */
@@ -1278,6 +1285,17 @@ static int sparc_l1_a_state;
 extern void sun_do_break(void);
 #endif
 
+static int is_alt_down(struct input_handle *handle, void *data)
+{
+	struct kbd_handle *kh = hdl_to_kbd_handle(handle);
+
+	if (test_bit(KEY_LEFTALT, kh->key_down) ||
+			test_bit(KEY_RIGHTALT, kh->key_down))
+		return 1;
+
+	return 0;
+}
+
 static int emulate_raw(struct vc_data *vc, unsigned int keycode,
 		       unsigned char up_flag)
 {
@@ -1308,8 +1326,8 @@ static int emulate_raw(struct vc_data *vc, unsigned int keycode,
 		 * pressing PrtSc/SysRq alone, but simply 0x54
 		 * when pressing Alt+PrtSc/SysRq.
 		 */
-		if (test_bit(KEY_LEFTALT, key_down) ||
-		    test_bit(KEY_RIGHTALT, key_down)) {
+		if (input_handler_for_each_handle(&kbd_handler, NULL,
+					is_alt_down)) {
 			put_queue(vc, 0x54 | up_flag);
 		} else {
 			put_queue(vc, 0xe0);
@@ -1424,9 +1442,9 @@ static void kbd_keycode(struct kbd_handle *kh, unsigned int keycode, int down,
 	}
 
 	if (down)
-		set_bit(keycode, key_down);
+		set_bit(keycode, kh->key_down);
 	else
-		clear_bit(keycode, key_down);
+		clear_bit(keycode, kh->key_down);
 
 	if (rep &&
 	    (!vc_kbd_mode(kbd, VC_REPEAT) ||
-- 
2.18.0

