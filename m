Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3570DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE3A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeILBTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:19:05 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56509 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeILBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:19:04 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B7D3F60005;
        Tue, 11 Sep 2018 20:18:03 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 2/4] drivers/tty/vt/keyboard.c: add keyboard config for each vt's input
Date:   Tue, 11 Sep 2018 22:23:57 +0200
Message-Id: <088b628e3bc2cab7e00941afc5fa95f7d92c0b31.1536695071.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536695070.git.repk@triplefau.lt>
References: <cover.1536695070.git.repk@triplefau.lt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each connected kbd_handle holds a keyboard config that contains the
keymap used to translate keycode into keysym. At init and until the
kbd_handle gets detached it uses the global keyboard config
(aka key_maps[]) array to translate keycode into keysym.

For now, it is not possible for the user to detach a kbd_handle from
global config. Some new ioctl will be introduced to do so.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Tested-by: Elie Roudninski <xademax@gmail.com>
---
 drivers/tty/vt/keyboard.c | 198 ++++++++++++++++++++++++++++++++------
 1 file changed, 171 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 89fabb8ae04e..4f09331ad5c3 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -108,6 +108,23 @@ struct vt_spawn_console vt_spawn_con = {
  * Internal Data.
  */
 
+/* Input handle's specific key configuration */
+struct kbd_conf {
+	ushort **maps;
+	unsigned int keymap_count;
+};
+
+static struct kbd_conf _gkeyconf;
+#define KC_IS_GLOBAL(kc) ((kc) == &_gkeyconf)
+
+/* Input handle */
+struct kbd_handle {
+	struct kref ref;
+	struct kbd_conf *conf;
+	struct input_handle handle;
+};
+#define hdl_to_kbd_handle(h) (container_of(h, struct kbd_handle, handle))
+
 static struct kbd_struct kbd_table[MAX_NR_CONSOLES];
 static struct kbd_struct *kbd = kbd_table;
 
@@ -1343,9 +1360,11 @@ static void kbd_rawcode(unsigned char data)
 		put_queue(vc, data);
 }
 
-static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
+static void kbd_keycode(struct kbd_handle *kh, unsigned int keycode, int down,
+		int hw_raw)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
+	struct kbd_conf *kconf = kh->conf;
 	unsigned short keysym, *key_map;
 	unsigned char type;
 	bool raw_mode;
@@ -1422,7 +1441,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 
 	param.shift = shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
 	param.ledstate = kbd->ledflagstate;
-	key_map = key_maps[shift_final];
+	key_map = kconf->maps[shift_final];
 
 	rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 					KBD_KEYCODE, &param);
@@ -1458,7 +1477,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	if (type == KT_LETTER) {
 		type = KT_LATIN;
 		if (vc_kbd_led(kbd, VC_CAPSLOCK)) {
-			key_map = key_maps[shift_final ^ (1 << KG_SHIFT)];
+			key_map = kconf->maps[shift_final ^ (1 << KG_SHIFT)];
 			if (key_map)
 				keysym = key_map[keycode];
 		}
@@ -1485,13 +1504,15 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 static void kbd_event(struct input_handle *handle, unsigned int event_type,
 		      unsigned int event_code, int value)
 {
+	struct kbd_handle *kh = hdl_to_kbd_handle(handle);
+
 	/* We are called with interrupts disabled, just take the lock */
 	spin_lock(&kbd_event_lock);
 
 	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
 		kbd_rawcode(value);
 	if (event_type == EV_KEY)
-		kbd_keycode(event_code, value, HW_RAW(handle->dev));
+		kbd_keycode(kh, event_code, value, HW_RAW(handle->dev));
 
 	spin_unlock(&kbd_event_lock);
 
@@ -1519,6 +1540,114 @@ static bool kbd_match(struct input_handler *handler, struct input_dev *dev)
 	return false;
 }
 
+/*
+ * Keyconf functions
+ */
+
+static void kbd_init_conf(struct kbd_handle *kh)
+{
+	kh->conf = &_gkeyconf;
+}
+
+/*
+ * Detach an input from global keyboard config. If keyboard config is already
+ * detached, nothing is modified.
+ */
+static int kbd_detach_conf(struct kbd_handle *kh)
+{
+	struct kbd_conf *kconf;
+	ushort **tmp, **maps = NULL;
+	size_t i, tmpcnt = 0;
+	unsigned long flags;
+	unsigned int count = 0;
+	int err = -ENOMEM;
+
+	kconf = kmalloc(sizeof(*kconf), GFP_KERNEL);
+	if (kconf == NULL)
+		goto reterr;
+
+	maps = kcalloc(MAX_NR_KEYMAPS, sizeof(*maps), GFP_KERNEL);
+	if (maps == NULL)
+		goto reterr;
+
+	tmp = kmalloc_array(MAX_NR_KEYMAPS, sizeof(*tmp), GFP_KERNEL);
+	if (tmp == NULL)
+		goto reterr;
+
+	spin_lock_irqsave(&kbd_event_lock, flags);
+
+	if (!KC_IS_GLOBAL(kh->conf))
+		goto out;  /* We have been raced at keymap creation */
+	count = kh->conf->keymap_count;
+
+	/* Pre-alloc enough tmp buffer to avoid allocating with lock held */
+	while (tmpcnt < count) {
+		spin_unlock_irqrestore(&kbd_event_lock, flags);
+		for (; tmpcnt < count; ++tmpcnt) {
+			tmp[tmpcnt] = kmalloc(sizeof(plain_map), GFP_KERNEL);
+			if (tmp[tmpcnt] == NULL)
+				goto freetmp;
+		}
+		spin_lock_irqsave(&kbd_event_lock, flags);
+
+		if (!KC_IS_GLOBAL(kh->conf))
+			goto out;  /* We have been raced at keymap creation */
+		count = kh->conf->keymap_count;
+	}
+
+	/*
+	 * Here at least enough tmp pointers have been allocated and lock is
+	 * held.
+	 *
+	 * If more than enough pointers have been allocated, the extra ones will
+	 * be freed after (see freetmp).
+	 */
+	if (count >= MAX_NR_OF_USER_KEYMAPS &&
+			!capable(CAP_SYS_RESOURCE)) {
+		err = -EPERM;
+		goto unlock;
+	}
+	for (i = 0; i < MAX_NR_KEYMAPS; ++i) {
+		if (kh->conf->maps[i]) {
+			--tmpcnt;
+			memcpy(tmp[tmpcnt], kh->conf->maps[i],
+					sizeof(plain_map));
+			tmp[tmpcnt][0] = U(K_ALLOCATED);
+			maps[i] = tmp[tmpcnt];
+		}
+	}
+	kconf->maps = maps;
+	kconf->keymap_count = count;
+	kh->conf = kconf;
+	kconf = NULL;
+	maps = NULL;
+out:
+	err = 0;
+unlock:
+	spin_unlock_irqrestore(&kbd_event_lock, flags);
+freetmp:
+	for (; tmpcnt > 0; --tmpcnt) /* Free extra pointers */
+		kfree(tmp[tmpcnt - 1]);
+	kfree(tmp);
+reterr:
+	kfree(maps);
+	kfree(kconf);
+	return err;
+}
+
+static void kbd_destroy_conf(struct kbd_handle *kh)
+{
+	size_t i;
+
+	if (KC_IS_GLOBAL(kh->conf))
+		return;
+
+	for (i = 0; i < MAX_NR_KEYMAPS; ++i)
+		kfree(kh->conf->maps[i]);
+	kfree(kh->conf->maps);
+	kfree(kh->conf);
+}
+
 /*
  * When a keyboard (or other input device) is found, the kbd_connect
  * function is called. The function then looks at the device, and if it
@@ -1528,13 +1657,17 @@ static bool kbd_match(struct input_handler *handler, struct input_dev *dev)
 static int kbd_connect(struct input_handler *handler, struct input_dev *dev,
 			const struct input_device_id *id)
 {
+	struct kbd_handle *kh;
 	struct input_handle *handle;
 	int error;
 
-	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
-	if (!handle)
+	kh = kzalloc(sizeof(struct kbd_handle), GFP_KERNEL);
+	if (!kh)
 		return -ENOMEM;
 
+	kref_init(&kh->ref);
+	kbd_init_conf(kh);
+	handle = &kh->handle;
 	handle->dev = dev;
 	handle->handler = handler;
 	handle->name = "kbd";
@@ -1552,15 +1685,25 @@ static int kbd_connect(struct input_handler *handler, struct input_dev *dev,
  err_unregister_handle:
 	input_unregister_handle(handle);
  err_free_handle:
-	kfree(handle);
+	kfree(kh);
 	return error;
 }
 
+static void kbd_destroy(struct kref *ref)
+{
+	struct kbd_handle *kh = container_of(ref, struct kbd_handle, ref);
+
+	kbd_destroy_conf(kh);
+	kfree(kh);
+}
+
 static void kbd_disconnect(struct input_handle *handle)
 {
+	struct kbd_handle *kh = hdl_to_kbd_handle(handle);
+
 	input_close_device(handle);
 	input_unregister_handle(handle);
-	kfree(handle);
+	kref_put(&kh->ref, kbd_destroy);
 }
 
 /*
@@ -1619,6 +1762,8 @@ int __init kbd_init(void)
 	}
 
 	kbd_init_leds();
+	_gkeyconf.maps = key_maps;
+	_gkeyconf.keymap_count = keymap_count;
 
 	error = input_register_handler(&kbd_handler);
 	if (error)
@@ -1879,21 +2024,21 @@ int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
 #define v (kbe->kb_value)
 
 /*
- * Get a keysym value from a key map
+ * Get a keysym value from a keyconf's keymap
  *
  * @kb: Virtual console structure
- * @kmaps: Key map array
+ * @kconf: Keyboard configuration
  * @kbe : Entry to find in key map
  */
-static ushort __kdsk_getent(struct kbd_struct const *kb, ushort **kmaps,
-		struct kbentry const *kbe)
+static ushort kc_getent(struct kbd_struct const *kb,
+		struct kbd_conf const *kconf, struct kbentry const *kbe)
 {
 	ushort *key_map, val;
 	unsigned long flags;
 
 	/* Ensure another thread doesn't free it under us */
 	spin_lock_irqsave(&kbd_event_lock, flags);
-	key_map = kmaps[s];
+	key_map = kconf->maps[s];
 	if (key_map) {
 		val = U(key_map[i]);
 		if (kb->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
@@ -1906,13 +2051,13 @@ static ushort __kdsk_getent(struct kbd_struct const *kb, ushort **kmaps,
 }
 
 /*
- * Set a keysym value in a key map
+ * Set a keysym value in a keyboard configuration's keymap
  *
  * @kb: Virtual console structure
- * @kmaps: Key map array
+ * @kconf: Keyboard configuration
  * @kbe : Entry to set in key map
  */
-static int __kdsk_setent(struct kbd_struct const *kb, ushort **kmaps,
+static int kc_setent(struct kbd_struct const *kb, struct kbd_conf *kconf,
 		struct kbentry const *kbe)
 {
 	ushort *key_map, *new_map, ov;
@@ -1921,13 +2066,12 @@ static int __kdsk_setent(struct kbd_struct const *kb, ushort **kmaps,
 	if (!i && v == K_NOSUCHMAP) {
 		spin_lock_irqsave(&kbd_event_lock, flags);
 		/* deallocate map */
-		key_map = kmaps[s];
+		key_map = kconf->maps[s];
 		if (s && key_map) {
-			kmaps[s] = NULL;
-			if (key_map[0] == U(K_ALLOCATED)) {
+			kconf->maps[s] = NULL;
+			if (key_map[0] == U(K_ALLOCATED))
 				kfree(key_map);
-				keymap_count--;
-			}
+			kconf->keymap_count--;
 		}
 		spin_unlock_irqrestore(&kbd_event_lock, flags);
 		return 0;
@@ -1950,22 +2094,22 @@ static int __kdsk_setent(struct kbd_struct const *kb, ushort **kmaps,
 	if (!new_map)
 		return -ENOMEM;
 	spin_lock_irqsave(&kbd_event_lock, flags);
-	key_map = kmaps[s];
+	key_map = kconf->maps[s];
 	if (key_map == NULL) {
 		int j;
 
-		if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
+		if (kconf->keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
 				!capable(CAP_SYS_RESOURCE)) {
 			spin_unlock_irqrestore(&kbd_event_lock, flags);
 			kfree(new_map);
 			return -EPERM;
 		}
-		kmaps[s] = new_map;
+		kconf->maps[s] = new_map;
 		key_map = new_map;
 		key_map[0] = U(K_ALLOCATED);
 		for (j = 1; j < NR_KEYS; j++)
 			key_map[j] = U(K_HOLE);
-		keymap_count++;
+		kconf->keymap_count++;
 	} else
 		kfree(new_map);
 
@@ -2006,13 +2150,13 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 
 	switch (cmd) {
 	case KDGKBENT:
-		val = __kdsk_getent(kb, key_maps, &tmp);
+		val = kc_getent(kb, &_gkeyconf, &tmp);
 		ret = put_user(val, &user_kbe->kb_value);
 		break;
 	case KDSKBENT:
 		if (!perm)
 			return -EPERM;
-		ret = __kdsk_setent(kb, key_maps, &tmp);
+		ret = kc_setent(kb, &_gkeyconf, &tmp);
 		break;
 	}
 	return ret;
-- 
2.18.0

