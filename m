Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934775AbeCHE1V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:27:21 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60313 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934149AbeCHE1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:27:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sz3h0H2_1520483227;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH 4/4] module: Support to disable validity enforcement in runtime
Date: Thu,  8 Mar 2018 12:27:03 +0800
Message-Id: <1520483223-6596-5-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to disable the module validity enforcement, writing
a PKCS#7 signature corresponding the signed content '0' is
required. Given a simple way to archive this:

$ echo -n 0 > data
$ openssl smime -sign -nocerts -noattr -binary -in data \
    -inkey <system_trusted_key> -signer <cert> -outform der \
    -out data.sig

Note that the signing key must be a trust key located in
system trusted keyring. So even the root privilige cannot
simply disable the enforcement.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 kernel/module.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 6b032577..16be198 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,6 +64,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/verification.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -288,6 +289,11 @@ bool is_module_sig_enforced(void)
 }
 EXPORT_SYMBOL(is_module_sig_enforced);
 
+static void set_module_sig_enforce(bool enforce)
+{
+	sig_enforce = enforce;
+}
+
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
@@ -2796,6 +2802,61 @@ static int module_sig_check(struct load_info *info, int flags)
 }
 
 #ifdef CONFIG_SECURITYFS
+/*
+ * Check the intention of setting the enforcement policy.
+ *
+ * Return 1 if enabling the policy, or return 0 if disabling
+ * the policy. Note that the root privilege cannot simply
+ * disable the policy without the authentication given by a
+ * trusted key.
+ */
+static int check_enforce(char *buf, size_t count)
+{
+	u8 *p;
+
+	if (buf[0] == '1') {
+		if (count == 1 || (count == 2 && buf[1] == '\n'))
+			return 1;
+
+		return -EINVAL;
+	}
+
+	/*
+	 * In order to disable the enforcement policy, a PKCS#7 signature
+	 * is supplied.
+	 *
+	 * Assuming ASN.1 encoding supplied, the minimal length would be
+	 * 4-byte header plus at least 256-byte payload.
+	 */
+	if (count < 260)
+		return -EINVAL;
+
+	p = (u8 *)buf;
+
+	/* The primitive type must be a sequnce */
+	if (p[0] != 0x30 || p[1] != 0x82)
+		return -EINVAL;
+
+	/* Match up the length of the supplied buffer */
+	if (be16_to_cpup((__be16 *)(p + 2)) != count - 4)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Disable the enforceme and verify the supplied PKCS#7 signature.
+ * The signed content is simply the charactoror '0'.
+ */
+static int disable_enforce(void *pkcs7, size_t pkcs7_len)
+{
+	char data = '0';
+
+	return verify_pkcs7_signature(&data, sizeof(data), pkcs7, pkcs7_len,
+				      NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
+				      NULL, NULL);
+}
+
 static ssize_t modsign_enforce_read(struct file *filp, char __user *ubuf,
 				    size_t count, loff_t *offp)
 {
@@ -2806,7 +2867,50 @@ static ssize_t modsign_enforce_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, count, offp, buf, 1);
 }
 
-static const struct file_operations modsign_enforce_ops = {
+static ssize_t modsign_enforce_write(struct file *filp,
+				     const char __user *ubuf,
+				     size_t count, loff_t *offp)
+{
+	char *buf;
+	ssize_t ret;
+	size_t max_buf_size = 1 << MAX_ORDER;
+
+	if (*offp > 1)
+		return -EFBIG;
+
+	if (count > max_buf_size)
+		return -EFBIG;
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(buf, count, offp, ubuf, count);
+	if (ret <= 0) {
+		kfree(buf);
+		return ret;
+	}
+
+	ret = check_enforce(buf, count);
+	if (is_module_sig_enforced() && !ret) {
+		ret = disable_enforce(buf, count);
+		if (!ret) {
+			set_module_sig_enforce(false);
+			pr_notice("Kernel module validity enforcement disabled\n");
+			ret = count;
+		}
+	} else if (!is_module_sig_enforced() && ret == 1) {
+		set_module_sig_enforce(true);
+		pr_notice("Kernel module validity enforcement enabled\n");
+		ret = count;
+	}
+
+	kfree(buf);
+
+	return ret;
+}
+
+static struct file_operations modsign_enforce_ops = {
 	.read = modsign_enforce_read,
 	.llseek = generic_file_llseek,
 };
@@ -2815,14 +2919,20 @@ static int __init securityfs_init(void)
 {
 	struct dentry *modsign_dir;
 	struct dentry *enforce;
+	umode_t mode;
 
 	modsign_dir = securityfs_create_dir("modsign", NULL);
 	if (IS_ERR(modsign_dir))
 		return -1;
 
-	enforce = securityfs_create_file("enforce",
-					 S_IRUSR | S_IRGRP, modsign_dir,
-					 NULL, &modsign_enforce_ops);
+	mode = S_IRUSR | S_IRGRP;
+	if (!is_module_sig_enforced()) {
+		modsign_enforce_ops.write = modsign_enforce_write;
+		mode |= S_IWUSR;
+	}
+
+	enforce = securityfs_create_file("enforce", mode, modsign_dir, NULL,
+					 &modsign_enforce_ops);
 	if (IS_ERR(enforce))
 		goto out;
 
-- 
1.8.3.1
