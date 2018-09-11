Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFDC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0456A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0456A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeILBTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:19:51 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57377 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeILBTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:19:51 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D68D060005;
        Tue, 11 Sep 2018 20:18:52 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 4/4] drivers/tty/vt: add ioctl to manage input specific keyboard configs
Date:   Tue, 11 Sep 2018 22:23:59 +0200
Message-Id: <25bdc248f493fe89b29874c4627f361c2814e5b5.1536695071.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536695070.git.repk@triplefau.lt>
References: <cover.1536695070.git.repk@triplefau.lt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because user can use different keyboards with different layouts on the
same tty, an input could have a different key map from another one. In
order to use and modify this specific key map the user can call three
new ioctls:

1) KDGKBIENT
	Get an input key map's entry. If the input does not have a
	specific keyboard config the requested entry is fetched from
	global key map.

2) KDSKBIENT
	Set an input key map's entry. If the input does not yet have a
	specific keyboard config, a new one is created with the current
	global config (the one modified with KDSKBENT) content copied
	in.

3) KDSKBIRST
	Reset an input key map. The input does not use a specific
	keyboard config anymore and keycode translations are done with
	global key map.

In order to remain compatible with old behavior, an input uses global
key map by default and KDGKENT/KDSKENT still get/set entries in the
global key map.

Below is an example of this ioctl usage:
------------------------- 8< -----------------------------
struct kbientry kbi = {
	.id = { /* Input is found by its input_id */
		.bustype = 0x0003,
		.product = 0x00B2,
		.vendor = 0x2319,
		.version = 0x0200,
	},
	.entry = { /* Entry to set or get */
		.kb_table = 0,
		.kb_index = 0x10,
		.kb_value = 0x0B61,
	},
};
int ret;

/* First set new entry for input 0003:00B2:2319:0200 */
ret = ioctl(fd, KDSKBIENT, &kbi); /* fd is a tty open file */
if(ret < 0)
	/* Error handling */

/* Get specific entry, on success kbi.entry.kb_value will be set */
ret = ioctl(fd, KDSKBIENT, &kbi);
if(ret < 0)
	/* Error handling */

/* Reset input key map so that global key_maps is used */
ret = ioctl(fd, KDSKBIRST, &kbi.id);
if(ret < 0)
	/* Error handling */
------------------------- 8< -----------------------------

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Tested-by: Elie Roudninski <xademax@gmail.com>
---
 drivers/tty/vt/keyboard.c | 126 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c |   9 +++
 fs/compat_ioctl.c         |   3 +
 include/linux/vt_kern.h   |   4 ++
 include/uapi/linux/kd.h   |   9 +++
 5 files changed, 151 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 7272e1828838..9707d1ebeab4 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2180,6 +2180,132 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 	return ret;
 }
 
+/*
+ * Input keymap helper functions
+ */
+struct kbd_lookup_data {
+	struct input_id *id;
+	struct kbd_handle *kh;
+};
+
+static int _kbd_get_helper(struct input_handle *handle, void *data)
+{
+	struct kbd_handle *kh = hdl_to_kbd_handle(handle);
+	struct kbd_lookup_data *d = data;
+
+	if (memcmp(d->id, &handle->dev->id, sizeof(*d->id)) != 0)
+		return 0;
+
+	d->kh = kh;
+	kref_get(&kh->ref);
+	return 1;
+}
+
+/*
+ * Get an input specific handle.
+ * The caller will hold a reference on the found kbd_handle, if it exists, and
+ * should deref it after usage (with kbd_put).
+ */
+static int kbd_get(struct kbd_handle **kh, struct input_id *id)
+{
+	struct kbd_lookup_data d = {
+		.id = id,
+	};
+	int ret;
+
+	ret = input_handler_for_each_handle(&kbd_handler, &d, _kbd_get_helper);
+	*kh = d.kh;
+
+	return (ret == 0);
+}
+
+static void kbd_put(struct kbd_handle *kh)
+{
+	kref_put(&kh->ref, kbd_destroy);
+}
+
+int vt_do_kdski_ioctl(int cmd, struct kbientry __user *user_kbie, int perm,
+		int console)
+{
+	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_handle *kh;
+	struct kbientry tmp;
+	ushort val;
+	int ret = 0;
+
+	if (copy_from_user(&tmp, user_kbie, sizeof(struct kbientry))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
+	ret = kbd_get(&kh, &tmp.id);
+	if (ret != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (cmd) {
+	case KDGKBIENT:
+		val = kc_getent(kb, kh->conf, &tmp.entry);
+		ret = put_user(val, &user_kbie->entry.kb_value);
+		break;
+	case KDSKBIENT:
+		if (!perm) {
+			ret = -EPERM;
+			break;
+		}
+		/* A keyconf's keymap is created only if global one is used */
+		ret = kbd_detach_conf(kh);
+		if (ret != 0)
+			break;
+
+		ret = kc_setent(kb, kh->conf, &tmp.entry);
+		break;
+	}
+
+	kbd_put(kh);
+out:
+	return ret;
+}
+
+int vt_do_kdskirst_ioctl(int cmd, struct input_id __user *user_iid, int perm,
+		int console)
+{
+	struct kbd_handle *kh;
+	struct input_id tmp;
+	unsigned long flags;
+	int ret;
+
+	if (copy_from_user(&tmp, user_iid, sizeof(struct input_id)))
+		return -EFAULT;
+
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
+	if (!perm)
+		return -EPERM;
+
+	ret = kbd_get(&kh, &tmp);
+	if (ret != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Restore keyboard's configuration to global one */
+	spin_lock_irqsave(&kbd_event_lock, flags);
+	kbd_destroy_conf(kh);
+	kbd_init_conf(kh);
+	spin_unlock_irqrestore(&kbd_event_lock, flags);
+
+	kbd_put(kh);
+
+out:
+	return ret;
+}
+
 /* FIXME: This one needs untangling and locking */
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index a78ad10a119b..ec688d81bab3 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -542,6 +542,15 @@ int vt_ioctl(struct tty_struct *tty,
 		ret = vt_do_kdsk_ioctl(cmd, up, perm, console);
 		break;
 
+	case KDGKBIENT:
+	case KDSKBIENT:
+		ret = vt_do_kdski_ioctl(cmd, up, perm, console);
+		break;
+
+	case KDSKBIRST:
+		ret = vt_do_kdskirst_ioctl(cmd, up, perm, console);
+		break;
+
 	case KDGKBSENT:
 	case KDSKBSENT:
 		ret = vt_do_kdgkb_ioctl(cmd, up, perm);
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a9b00942e87d..7863b142234c 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -789,6 +789,9 @@ COMPATIBLE_IOCTL(KDGKBDIACR)
 COMPATIBLE_IOCTL(KDSKBDIACR)
 COMPATIBLE_IOCTL(KDGKBDIACRUC)
 COMPATIBLE_IOCTL(KDSKBDIACRUC)
+COMPATIBLE_IOCTL(KDGKBIENT)
+COMPATIBLE_IOCTL(KDSKBIENT)
+COMPATIBLE_IOCTL(KDSKBIRST)
 COMPATIBLE_IOCTL(KDKBDREP)
 COMPATIBLE_IOCTL(KDGKBLED)
 COMPATIBLE_IOCTL(KDGETLED)
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 3fd07912909c..0f17d305b840 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -175,6 +175,10 @@ extern int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
 								int perm);
 extern int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe,
 					int perm, int console);
+extern int vt_do_kdski_ioctl(int cmd, struct kbientry __user *user_kbie,
+					int perm, int console);
+extern int vt_do_kdskirst_ioctl(int cmd, struct input_id __user *user_iid,
+					int perm, int console);
 extern int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb,
                                         int perm);
 extern int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm);
diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 4616b31f84da..be048e9e3f02 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_KD_H
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/input.h>
 
 /* 0x4B is 'K', to avoid collision with termios and vt */
 
@@ -137,6 +138,14 @@ struct kbdiacrsuc {
 #define KDGKBDIACRUC    0x4BFA  /* read kernel accent table - UCS */
 #define KDSKBDIACRUC    0x4BFB  /* write kernel accent table - UCS */
 
+struct kbientry {
+	struct input_id id;
+	struct kbentry entry;
+};
+#define KDGKBIENT 0x4B53 /* Get one entry in input's translation table */
+#define KDSKBIENT 0x4B54 /* Set one entry in input's translation table */
+#define KDSKBIRST 0x4B55 /* Set input to use global translation table */
+
 struct kbkeycode {
 	unsigned int scancode, keycode;
 };
-- 
2.18.0

