Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA6C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C293F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C293F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeILBpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:45:06 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42364 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeILBpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:45:05 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2B0373A7F47
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 22:17:45 +0200 (CEST)
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E3325240003;
        Tue, 11 Sep 2018 20:17:42 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/4] drivers/tty/vt/keyboard.c: refactor getting/setting a keymap entry
Date:   Tue, 11 Sep 2018 22:23:56 +0200
Message-Id: <3ee65938bc6bcab7c0dc6bf3dd55f7bff41406eb.1536695071.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536695070.git.repk@triplefau.lt>
References: <cover.1536695070.git.repk@triplefau.lt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease the addition of the ability of an input to use a
different key configuration (keycode to keysym map), the operations of
getting and setting an entry in a key map is moved in respective
functions.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Tested-by: Elie Roudninski <xademax@gmail.com>
---
 drivers/tty/vt/keyboard.c | 201 ++++++++++++++++++++++----------------
 1 file changed, 118 insertions(+), 83 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 88312c6c92cc..89fabb8ae04e 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1874,115 +1874,150 @@ int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
 	return kc;
 }
 
-#define i (tmp.kb_index)
-#define s (tmp.kb_table)
-#define v (tmp.kb_value)
+#define i (kbe->kb_index)
+#define s (kbe->kb_table)
+#define v (kbe->kb_value)
 
-int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
-						int console)
+/*
+ * Get a keysym value from a key map
+ *
+ * @kb: Virtual console structure
+ * @kmaps: Key map array
+ * @kbe : Entry to find in key map
+ */
+static ushort __kdsk_getent(struct kbd_struct const *kb, ushort **kmaps,
+		struct kbentry const *kbe)
 {
-	struct kbd_struct *kb = kbd_table + console;
-	struct kbentry tmp;
-	ushort *key_map, *new_map, val, ov;
+	ushort *key_map, val;
 	unsigned long flags;
 
-	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
-		return -EFAULT;
+	/* Ensure another thread doesn't free it under us */
+	spin_lock_irqsave(&kbd_event_lock, flags);
+	key_map = kmaps[s];
+	if (key_map) {
+		val = U(key_map[i]);
+		if (kb->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
+			val = K_HOLE;
+	} else
+		val = (i ? K_HOLE : K_NOSUCHMAP);
+	spin_unlock_irqrestore(&kbd_event_lock, flags);
 
-	if (!capable(CAP_SYS_TTY_CONFIG))
-		perm = 0;
+	return val;
+}
 
-	switch (cmd) {
-	case KDGKBENT:
-		/* Ensure another thread doesn't free it under us */
+/*
+ * Set a keysym value in a key map
+ *
+ * @kb: Virtual console structure
+ * @kmaps: Key map array
+ * @kbe : Entry to set in key map
+ */
+static int __kdsk_setent(struct kbd_struct const *kb, ushort **kmaps,
+		struct kbentry const *kbe)
+{
+	ushort *key_map, *new_map, ov;
+	unsigned long flags;
+
+	if (!i && v == K_NOSUCHMAP) {
 		spin_lock_irqsave(&kbd_event_lock, flags);
-		key_map = key_maps[s];
-		if (key_map) {
-		    val = U(key_map[i]);
-		    if (kb->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
-			val = K_HOLE;
-		} else
-		    val = (i ? K_HOLE : K_NOSUCHMAP);
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
-		return put_user(val, &user_kbe->kb_value);
-	case KDSKBENT:
-		if (!perm)
-			return -EPERM;
-		if (!i && v == K_NOSUCHMAP) {
-			spin_lock_irqsave(&kbd_event_lock, flags);
-			/* deallocate map */
-			key_map = key_maps[s];
-			if (s && key_map) {
-			    key_maps[s] = NULL;
-			    if (key_map[0] == U(K_ALLOCATED)) {
-					kfree(key_map);
-					keymap_count--;
-			    }
+		/* deallocate map */
+		key_map = kmaps[s];
+		if (s && key_map) {
+			kmaps[s] = NULL;
+			if (key_map[0] == U(K_ALLOCATED)) {
+				kfree(key_map);
+				keymap_count--;
 			}
-			spin_unlock_irqrestore(&kbd_event_lock, flags);
-			break;
 		}
+		spin_unlock_irqrestore(&kbd_event_lock, flags);
+		return 0;
+	}
 
-		if (KTYP(v) < NR_TYPES) {
-		    if (KVAL(v) > max_vals[KTYP(v)])
-				return -EINVAL;
-		} else
-		    if (kb->kbdmode != VC_UNICODE)
-				return -EINVAL;
+	if (KTYP(v) < NR_TYPES) {
+		if (KVAL(v) > max_vals[KTYP(v)])
+			return -EINVAL;
+	} else if (kb->kbdmode != VC_UNICODE)
+		return -EINVAL;
 
-		/* ++Geert: non-PC keyboards may generate keycode zero */
+	/* ++Geert: non-PC keyboards may generate keycode zero */
 #if !defined(__mc68000__) && !defined(__powerpc__)
-		/* assignment to entry 0 only tests validity of args */
-		if (!i)
-			break;
+	/* assignment to entry 0 only tests validity of args */
+	if (!i)
+		return 0;
 #endif
 
-		new_map = kmalloc(sizeof(plain_map), GFP_KERNEL);
-		if (!new_map)
-			return -ENOMEM;
-		spin_lock_irqsave(&kbd_event_lock, flags);
-		key_map = key_maps[s];
-		if (key_map == NULL) {
-			int j;
-
-			if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
-			    !capable(CAP_SYS_RESOURCE)) {
-				spin_unlock_irqrestore(&kbd_event_lock, flags);
-				kfree(new_map);
-				return -EPERM;
-			}
-			key_maps[s] = new_map;
-			key_map = new_map;
-			key_map[0] = U(K_ALLOCATED);
-			for (j = 1; j < NR_KEYS; j++)
-				key_map[j] = U(K_HOLE);
-			keymap_count++;
-		} else
-			kfree(new_map);
+	new_map = kmalloc(sizeof(plain_map), GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+	spin_lock_irqsave(&kbd_event_lock, flags);
+	key_map = kmaps[s];
+	if (key_map == NULL) {
+		int j;
 
-		ov = U(key_map[i]);
-		if (v == ov)
-			goto out;
-		/*
-		 * Attention Key.
-		 */
-		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN)) {
+		if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
+				!capable(CAP_SYS_RESOURCE)) {
 			spin_unlock_irqrestore(&kbd_event_lock, flags);
+			kfree(new_map);
 			return -EPERM;
 		}
-		key_map[i] = U(v);
-		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
-			do_compute_shiftstate();
-out:
+		kmaps[s] = new_map;
+		key_map = new_map;
+		key_map[0] = U(K_ALLOCATED);
+		for (j = 1; j < NR_KEYS; j++)
+			key_map[j] = U(K_HOLE);
+		keymap_count++;
+	} else
+		kfree(new_map);
+
+	ov = U(key_map[i]);
+	if (v == ov)
+		goto out;
+	/*
+	 * Attention Key.
+	 */
+	if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN)) {
 		spin_unlock_irqrestore(&kbd_event_lock, flags);
-		break;
+		return -EPERM;
 	}
+	key_map[i] = U(v);
+	if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
+		do_compute_shiftstate();
+out:
+	spin_unlock_irqrestore(&kbd_event_lock, flags);
 	return 0;
 }
 #undef i
 #undef s
 #undef v
 
+int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
+						int console)
+{
+	struct kbd_struct *kb = kbd_table + console;
+	struct kbentry tmp;
+	ushort val;
+	int ret = 0;
+
+	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
+		return -EFAULT;
+
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
+	switch (cmd) {
+	case KDGKBENT:
+		val = __kdsk_getent(kb, key_maps, &tmp);
+		ret = put_user(val, &user_kbe->kb_value);
+		break;
+	case KDSKBENT:
+		if (!perm)
+			return -EPERM;
+		ret = __kdsk_setent(kb, key_maps, &tmp);
+		break;
+	}
+	return ret;
+}
+
 /* FIXME: This one needs untangling and locking */
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
-- 
2.18.0

