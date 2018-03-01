Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966688AbeCAJJZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:09:25 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39725 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966674AbeCAJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:09:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0SykeDyI_1519895347;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: zhang.jia@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] module: Support to show the current enforcement policy
Date: Thu,  1 Mar 2018 17:09:05 +0800
Message-Id: <1519895346-7961-3-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/kernel/security/modsign/enforce gives the result of current
enforcement policy of loading module.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 kernel/module.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 79825ea..e3c6c8e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2794,11 +2794,60 @@ static int module_sig_check(struct load_info *info, int flags)
 
 	return err;
 }
+
+#ifdef CONFIG_SECURITYFS
+static ssize_t modsign_enforce_read(struct file *filp, char __user *ubuf,
+				    size_t count, loff_t *offp)
+{
+	char buf[2];
+
+	sprintf(buf, "%d", !!sig_enforce);
+
+	return simple_read_from_buffer(ubuf, count, offp, buf, 1);
+}
+
+static const struct file_operations modsign_enforce_ops = {
+	.read = modsign_enforce_read,
+	.llseek = generic_file_llseek,
+};
+
+static int __init securityfs_init(void)
+{
+	struct dentry *modsign_dir;
+	struct dentry *enforce;
+
+	modsign_dir = securityfs_create_dir("modsign", NULL);
+	if (IS_ERR(modsign_dir))
+		return -1;
+
+	enforce = securityfs_create_file("enforce",
+					 S_IRUSR | S_IRGRP, modsign_dir,
+					 NULL, &modsign_enforce_ops);
+	if (IS_ERR(enforce))
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
@@ -4395,8 +4444,14 @@ void module_layout(struct module *mod,
 
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
