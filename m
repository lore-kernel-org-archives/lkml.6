Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCXDAy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 23:00:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53650 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752008AbeCXDAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 23:00:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T--Gahw_1521860388;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH 3/3] module: Support to disable validity enforcement in runtime
Date: Sat, 24 Mar 2018 10:59:49 +0800
Message-Id: <1521860389-19262-4-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to disable the module validity enforcement, writing
a PKCS#7 signature corresponding the signed content '0' is
required. Given a simple way to archive this:

$ echo -n 0 > no_sig_enforce
$ openssl smime -sign -nocerts -noattr -binary \
    -in no_sig_enforce -inkey <system_trusted_key> \
    -signer <cert> -outform der -out no_sig_enforce.p7s
$ sudo cat no_sig_enforce.p7s \
    > /sys/kernel/security/modsign/disable_enforce

Note that the signing key must be a trust key located in
system trusted keyring. So even the root privilige cannot
simply disable the enforcement.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 kernel/module.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 79825ea..3dd35ac 100644
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
@@ -2794,11 +2800,139 @@ static int module_sig_check(struct load_info *info, int flags)
 
 	return err;
 }
+
+#ifdef CONFIG_SECURITYFS
+/*
+ * Check the input for disabling enforcement policy.
+ *
+ * Return 0 if inteding to disabling the policy. Note that the root
+ * privilege cannot simply disable the policy without the
+ * authentication given by a trusted key.
+ */
+static int check_disable_enforce(char *buf, size_t count)
+{
+	u8 *p;
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
+static ssize_t modsign_disable_enforce_write(struct file *filp,
+					     const char __user *ubuf,
+					     size_t count, loff_t *offp)
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
+	ret = check_disable_enforce(buf, count);
+	if (!ret) {
+		if (is_module_sig_enforced()) {
+			ret = disable_enforce(buf, count);
+			if (!ret) {
+				set_module_sig_enforce(false);
+				pr_notice("Kernel module validity enforcement disabled\n");
+				ret = count;
+			}
+		} else
+			ret = count;
+	}
+
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations modsign_disable_enforce_ops = {
+	.write = modsign_disable_enforce_write,
+	.llseek = generic_file_llseek,
+};
+
+static int __init securityfs_init(void)
+{
+	struct dentry *modsign_dir;
+	struct dentry *disable_enforce;
+
+	modsign_dir = securityfs_create_dir("modsign", NULL);
+	if (IS_ERR(modsign_dir))
+		return -1;
+
+	disable_enforce = securityfs_create_file("disable_enforce", S_IWUSR,
+						 modsign_dir, NULL,
+						 &modsign_disable_enforce_ops);
+	if (IS_ERR(disable_enforce))
+		goto out;
+
+	return 0;
+out:
+	securityfs_remove(modsign_dir);
+
+	return -1;
+}
+#else /* !CONFIG_SECURITYFS */
+static int __init securityfs_init(void)
+{
+	return 0;
+}
+#endif
 #else /* !CONFIG_MODULE_SIG */
 static int module_sig_check(struct load_info *info, int flags)
 {
 	return 0;
 }
+
+static int __init securityfs_init(void)
+{
+	return 0;
+}
 #endif /* !CONFIG_MODULE_SIG */
 
 /* Sanity checks against invalid binaries, wrong arch, weird elf version. */
@@ -4395,8 +4529,14 @@ void module_layout(struct module *mod,
 
 static int __init initialize_module(void)
 {
+	int ret;
+
 	proc_modules_init();
 
+	ret = securityfs_init();
+	if (unlikely(ret))
+		return ret;
+
 	return 0;
 }
 module_init(initialize_module);
-- 
1.8.3.1
