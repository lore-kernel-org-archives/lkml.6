Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeBJQ6t (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 11:58:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:35603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeBJQ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 11:58:48 -0500
From: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] p9caps: add Plan9 capability devices
Date: Sat, 10 Feb 2018 16:58:45 +0000
Message-Id: <20180210165845.18852-1-metux@gmx.de>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K0:a6XRJYb4dQtG5n06n9+EAYKuSkYRd2N/+mnGhaOtxmMIllt8rhD
 J2Y9fuFw42n3F+DhKDA2/7AZtdYWS8vqqZkp0+a+avtZZswi0CLi5rF32/kHT0UgbBodeMJ
 azlYriIK9iivSbtlokxJndm4+8w0aw305d/VyzossZXfnD2yrhbALySEZe4aM+DOkDlu6vG
 FFMWsYqs3M3wIfgpKBleg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wn56jyQgYJ4=:PzozRKs9afDBviORBbuhJv
 HFwygIe63f6O0y1MyClZ3oOzRxUP+SybcKmyH1VT1xtMak+TlMiGEqtRtI4KQUncvCTuUXr8j
 uXLC3FPDKdSohEjX7NNFId4OafgDJiP+2dkh1oc6ZSOOvnA6Q712pYuG5JQgG5buHS/oBkSFF
 8VEIe43JM9aaSsQCuL5MryVV27JYskH10WI9op+IMW2XtuMZuVGXvHERN683rrsp2AwnZg6So
 loL0DfP1DK0kCFB/MnzmxH3GsR1Tbe9WTGeQVEL4lhai9VVTQWo3noRNAKs6QBHYfi1YWr5iM
 Q2os5+22n+y8Xqgl0g66HQTt0FUWxnHBBomwDk80nuZIZ3W/5U/ELwhvfAznX7TxU3ypGSlSR
 oulQHI6vCzmDQcNDPkSre27I1S+rufUIJtIRC+O/F66Y6RzaRo7Dq8VK8xuxHGynLtRuZpa3j
 C8s9fZSF/OSkNFpPl8DCrEw7F3p/SuDxXxedXAlN5WtEyRt17AXvFf8KERbsVquyFK9u3pNH+
 lBLKlrQv5xFoz+e70rIxG/DtDmGGTAgJfAVHhtQ8DtGs6xEbxWlJrlFnk0qDBv9HpVG9VyyPU
 gS/9FyxHwFTHXbNGDntyZ+ViKhCV0GfuZdcZyufQ/ud7TFpgljpBM2v2bR71cCNOuDg0FVMbG
 jBA7mJg3ncIP/6lVfu85c/JvQ55o4zbmaiv+oLb5mogHYSxtC0bBJ5cWKb7v61t6rYTtkJgXo
 i/7eNVr15qf5GdO7oLDT81bpVXaaAYSaItqwMF1DbL78tH9aqapN5eYj0W7gu4EkfYjQKoVSq
 TqPg8Wenq0zyfntVNK260cRl3nflg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Enrico Weigelt, metux IT consult" <info@metux.net>

This driver implements the Plan9 capability devices, used for
switching user id via capability tokens.

https://9p.io/sys/doc/auth.html
---
 drivers/staging/Kconfig         |   2 +
 drivers/staging/Makefile        |   1 +
 drivers/staging/p9caps/Kconfig  |  11 ++
 drivers/staging/p9caps/Makefile |   1 +
 drivers/staging/p9caps/p9caps.c | 371 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 386 insertions(+)
 create mode 100644 drivers/staging/p9caps/Kconfig
 create mode 100644 drivers/staging/p9caps/Makefile
 create mode 100644 drivers/staging/p9caps/p9caps.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 554683912cff..23f325339fe8 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -118,4 +118,6 @@ source "drivers/staging/vboxvideo/Kconfig"
 
 source "drivers/staging/pi433/Kconfig"
 
+source "drivers/staging/p9caps/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 6e536020029a..eccdf4643453 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -3,6 +3,7 @@
 
 obj-y				+= media/
 obj-y				+= typec/
+obj-$(CONFIG_PLAN9CAPS)		+= p9caps/
 obj-$(CONFIG_IRDA)		+= irda/net/
 obj-$(CONFIG_IRDA)		+= irda/drivers/
 obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
diff --git a/drivers/staging/p9caps/Kconfig b/drivers/staging/p9caps/Kconfig
new file mode 100644
index 000000000000..455c3fa726ff
--- /dev/null
+++ b/drivers/staging/p9caps/Kconfig
@@ -0,0 +1,11 @@
+config PLAN9CAPS
+	tristate "Plan 9 capability device"
+	default n
+	select CRYPTO_HMAC
+	select CRYPTO_SHA1
+	help
+	  This module implements the Plan 9 capability devices
+	  /dev/caphash and /dev/capuse
+
+	  To compile this driver as a module, choose
+	  M here: the module will be called p9auth.
diff --git a/drivers/staging/p9caps/Makefile b/drivers/staging/p9caps/Makefile
new file mode 100644
index 000000000000..67d38099a249
--- /dev/null
+++ b/drivers/staging/p9caps/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PLAN9CAPS)	+= p9caps.o
diff --git a/drivers/staging/p9caps/p9caps.c b/drivers/staging/p9caps/p9caps.c
new file mode 100644
index 000000000000..4c5c94dc1893
--- /dev/null
+++ b/drivers/staging/p9caps/p9caps.c
@@ -0,0 +1,371 @@
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/fcntl.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/scatterlist.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/user_namespace.h>
+#include <linux/mutex.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
+
+/*
+ * Plan9 /dev/caphash and /dev/capuse device
+ *
+ * 2DO: - caphash should only allow one process (per userns)
+ *      - support textual user names
+ *      - invalidate old caps
+ */
+
+#define DEVICE_CAPUSE	"/dev/capuse"
+#define DEVICE_CAPHASH	"/dev/caphash"
+
+#define MODNAME		"p9cap"
+
+struct caphash_entry {
+	struct list_head list;
+	struct user_namespace *user_ns;
+	char data[SHA1_DIGEST_SIZE];
+};
+
+struct caphash_writer {
+	struct list_head list;
+	struct user_namespace *user_ns;
+};
+
+static dev_t caphash_devid = 0;
+static dev_t capuse_devid = 0;
+
+static LIST_HEAD(caphash_entries);
+static LIST_HEAD(caphash_writers);
+
+static DEFINE_MUTEX(p9cap_lock);
+
+struct crypto_ahash *p9cap_tfm = NULL;
+
+static int caphash_open(struct inode *inode, struct file *filp)
+{
+	struct caphash_writer *tmp = NULL;
+	struct user_namespace *user_ns = current_user_ns();
+	int retval = 0;
+	struct list_head *pos, *q;
+
+	/* make sure only one instance per namespace can be opened */
+	mutex_lock(&p9cap_lock);
+
+	list_for_each_safe(pos, q, &(caphash_writers)) {
+		tmp = list_entry(pos, struct caphash_writer, list);
+		if (tmp->user_ns == user_ns) {
+			printk(KERN_ERR DEVICE_CAPHASH ": already locked in this namespace\n");
+			retval = -EBUSY;
+			goto out;
+		}
+	}
+
+	if (!(tmp = kzalloc(sizeof(struct caphash_writer), GFP_KERNEL))) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	tmp->user_ns = get_user_ns(user_ns);
+	list_add(&(tmp->list), &caphash_writers);
+
+out:
+	mutex_unlock(&p9cap_lock);
+	return retval;
+}
+
+static int caphash_release(struct inode *inode, struct file *filp)
+{
+	int retval = 0;
+	struct user_namespace *user_ns = current_user_ns();
+	struct list_head *pos, *q;
+	struct caphash_entry *tmp;
+
+	mutex_lock(&p9cap_lock);
+
+	list_for_each_safe(pos, q, &(caphash_writers)) {
+		tmp = list_entry(pos, struct caphash_entry, list);
+		if (tmp->user_ns == user_ns) {
+			list_del(pos);
+			kfree(tmp);
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&p9cap_lock);
+	return retval;
+}
+
+static ssize_t caphash_write(struct file *filp, const char __user *buf,
+				   size_t count, loff_t *f_pos)
+{
+	struct caphash_entry *ent;
+
+	if (count > SHA1_DIGEST_SIZE) {
+		printk(KERN_ERR DEVICE_CAPHASH ": too large: %d\n", count);
+		return -E2BIG;
+	}
+
+	if (!(ent = kzalloc(sizeof(struct caphash_entry), GFP_KERNEL)))
+		return -ENOMEM;
+
+	if (copy_from_user(&(ent->data), buf, count)) {
+		kfree(ent);
+		return -EFAULT;
+	}
+
+	ent->user_ns = get_user_ns(current_user_ns());
+
+	mutex_lock(&p9cap_lock);
+	list_add(&(ent->list), &caphash_entries);
+	mutex_unlock(&p9cap_lock);
+
+	return count;
+}
+
+/* called w/ lock held. we can releave this by allocating tfm locally */
+static ssize_t hash(const char *src, const char* dst, const char *key, u8 *result)
+{
+	struct scatterlist sg;
+	struct ahash_request *req;
+	int retval;
+	char *text = NULL;
+	size_t text_len;
+	int digest_len;
+	u8* digest = NULL;
+
+	text_len = strlen(src)+strlen(dst)+1;		/* src@dst\0 */
+	digest_len = crypto_ahash_reqsize(p9cap_tfm);
+
+	digest = kzalloc(digest_len, GFP_KERNEL);
+	text = kzalloc(text_len+1, GFP_KERNEL);
+
+	if (!digest || !text) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	if (!(req = ahash_request_alloc(p9cap_tfm, GFP_KERNEL))) {
+		printk(KERN_ERR MODNAME ": failed to alloc ahash_request\n");
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	snprintf(text, text_len+1, "%s@%s", src, dst);
+	sg_set_buf(&sg, text, text_len);
+
+	ahash_request_set_callback(req, 0, NULL, NULL);
+	ahash_request_set_crypt(req, &sg, digest, text_len);
+
+	if ((retval = crypto_ahash_setkey(p9cap_tfm, key, strlen(key)))) {
+		printk(KERN_ERR MODNAME ": crypto_ahash_setkey() failed ret=%d\n", retval);
+		goto out;
+	}
+
+	if ((retval = crypto_ahash_digest(req))) {
+		printk(KERN_ERR MODNAME ": digest() failed ret=%d\n", retval);
+		goto out;
+	}
+
+	memcpy(result, digest, SHA1_DIGEST_SIZE);
+
+out:
+	kfree(text);
+	kfree(digest);
+
+	return 0;
+}
+
+static inline kuid_t convert_uid(const char* uname)
+{
+	return make_kuid(current_user_ns(), simple_strtol(uname, NULL, 0));
+}
+
+static ssize_t switch_uid(const char *src_uname, const char *dst_uname)
+{
+	struct cred *creds = prepare_creds();
+
+	kuid_t src_uid = convert_uid(src_uname);
+	kuid_t dst_uid = convert_uid(dst_uname);
+
+	if (!uid_eq(src_uid, current_uid())) {
+		printk(KERN_INFO DEVICE_CAPUSE ": src uid mismatch\n");
+		return -EPERM;
+	}
+
+	if (!(creds = prepare_creds()))
+		return -ENOMEM;
+
+	creds->uid = dst_uid;
+	creds->euid = dst_uid;
+
+	printk(KERN_INFO DEVICE_CAPUSE ": switching from kuid %d to %d\n", src_uid.val, dst_uid.val);
+	return commit_creds(creds);
+}
+
+static ssize_t try_switch(const char* src_uname, const char* dst_uname, const u8* hashval)
+{
+	struct list_head *pos;
+	list_for_each(pos, &(caphash_entries)) {
+		struct caphash_entry *tmp = list_entry(pos, struct caphash_entry, list);
+		if ((0 == memcmp(hashval, tmp->data, SHA1_DIGEST_SIZE)) &&
+		    (tmp->user_ns == current_user_ns())) {
+
+			int retval;
+
+			if ((retval = switch_uid(src_uname, dst_uname))) {
+				printk(KERN_INFO DEVICE_CAPUSE ": uid switch failed\n");
+				return retval;
+			}
+
+			tmp = list_entry(pos, struct caphash_entry, list);
+			list_del(pos);
+			put_user_ns(tmp->user_ns);
+			kfree(tmp);
+
+			return 0;
+		}
+	}
+
+	printk(KERN_INFO DEVICE_CAPUSE ": cap not found\n");
+
+	return -ENOENT;
+}
+
+static ssize_t capuse_write(struct file *filp, const char __user *buf,
+				  size_t count, loff_t *f_pos)
+{
+	ssize_t retval = count;
+	char  *rand_str, *src_uname, *dst_uname;
+	u8 hashval[SHA1_DIGEST_SIZE] = { 0 };
+	char *cmdbuf;
+
+	if (!(cmdbuf = kzalloc(count, GFP_KERNEL)))
+		return -ENOMEM;
+
+	if (copy_from_user(cmdbuf, buf, count)) {
+		retval = -EFAULT;
+		goto out_free;
+	}
+
+	{
+		char *walk = cmdbuf;
+		src_uname = strsep(&walk, "@");
+		dst_uname = strsep(&walk, "@");
+		rand_str = walk;
+		if (!src_uname || !dst_uname || !rand_str) {
+			retval = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	mutex_lock(&p9cap_lock);
+
+	if ((retval = hash(src_uname, dst_uname, rand_str, hashval)))
+		goto out_unlock;
+
+	if ((retval = try_switch(src_uname, dst_uname, hashval)))
+		goto out_unlock;
+
+	retval = count;
+
+out_unlock:
+	mutex_unlock(&p9cap_lock);
+
+out_free:
+	kfree(cmdbuf);
+	return retval;
+}
+
+static const struct file_operations p9cap_caphash_fops = {
+	.owner		= THIS_MODULE,
+	.write		= caphash_write,
+	.open		= caphash_open,
+	.release	= caphash_release,
+};
+
+static const struct file_operations p9cap_capuse_fops = {
+	.owner		= THIS_MODULE,
+	.write		= capuse_write,
+};
+
+static struct cdev p9cap_dev_caphash;
+static struct cdev p9cap_dev_capuse;
+
+static int p9cap_clear(void)
+{
+	struct caphash_entry *tmp;
+	struct list_head *pos, *q;
+
+	list_for_each_safe(pos, q, &(caphash_entries)) {
+		tmp = list_entry(pos, struct caphash_entry, list);
+		list_del(pos);
+		kfree(tmp);
+	}
+
+	return 0;
+}
+
+static void p9cap_cleanup_module(void)
+{
+	p9cap_clear();
+
+	cdev_del(&p9cap_dev_caphash);
+	cdev_del(&p9cap_dev_capuse);
+
+	unregister_chrdev_region(caphash_devid, 1);
+	unregister_chrdev_region(capuse_devid, 1);
+
+	if (p9cap_tfm)
+		crypto_free_ahash(p9cap_tfm);
+}
+
+static int p9cap_init_module(void)
+{
+	int retval;
+
+	p9cap_tfm = crypto_alloc_ahash("hmac(sha1)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(p9cap_tfm)) {
+		retval = -PTR_ERR(p9cap_tfm);
+		printk(KERN_ERR MODNAME ": failed to load transform for hmac(sha1): %d\n", retval);
+		goto fail;
+	}
+
+	if ((retval = alloc_chrdev_region(&caphash_devid, 0, 1, DEVICE_CAPHASH)))
+		goto fail;
+
+	if ((retval = alloc_chrdev_region(&capuse_devid, 0, 1, DEVICE_CAPUSE)))
+		goto fail;
+
+	cdev_init(&p9cap_dev_caphash, &p9cap_caphash_fops);
+	p9cap_dev_caphash.owner = THIS_MODULE;
+	if ((retval = cdev_add(&p9cap_dev_caphash, caphash_devid, 1)))
+		printk(KERN_ERR MODNAME ": failed adding " DEVICE_CAPHASH ": %d\n", retval);
+
+	cdev_init(&p9cap_dev_capuse, &p9cap_capuse_fops);
+	p9cap_dev_capuse.owner = THIS_MODULE;
+	if ((retval = cdev_add(&p9cap_dev_capuse, capuse_devid, 1)))
+		printk(KERN_ERR MODNAME ": failed adding " DEVICE_CAPUSE ": %d\n", retval);
+
+	return 0;
+
+fail:
+	p9cap_cleanup_module();
+	return retval;
+}
+
+MODULE_AUTHOR("Enrico Weigelt, metux IT consult <info@metux.net>");
+MODULE_LICENSE("GPLv3");
+
+module_init(p9cap_init_module);
+module_exit(p9cap_cleanup_module);
-- 
2.11.0
