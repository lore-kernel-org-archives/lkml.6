Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966671AbeCAJJP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:09:15 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41736 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965026AbeCAJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:09:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sykd57i_1519895348;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: zhang.jia@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] module: Allow to upgrade to validity enforcement in unforced mode
Date: Thu,  1 Mar 2018 17:09:06 +0800
Message-Id: <1519895346-7961-4-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If module signature verification check is enabled but the
validity enforcement is configured to be disabled, it should
be allowed to enable it. Once enabled, it is disallowed to
disable it.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 kernel/module.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index e3c6c8e..89704df 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2806,8 +2806,37 @@ static ssize_t modsign_enforce_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, count, offp, buf, 1);
 }
 
+#ifndef CONFIG_MODULE_SIG_FORCE
+static ssize_t modsign_enforce_write(struct file *filp,
+				     const char __user *ubuf,
+				     size_t count, loff_t *offp)
+{
+	char buf;
+	ssize_t ret;
+
+	if (*offp > 1)
+		return -EFBIG;
+
+	ret = simple_write_to_buffer(&buf, 1, offp, ubuf, count);
+	if (ret > 0) {
+		if (buf != '1')
+			return -EINVAL;
+
+		sig_enforce = true;
+		pr_notice_once("Kernel module validity enforcement enabled\n");
+
+		ret = count;
+	}
+
+	return ret;
+}
+#endif
+
 static const struct file_operations modsign_enforce_ops = {
 	.read = modsign_enforce_read,
+#ifndef CONFIG_MODULE_SIG_FORCE
+	.write = modsign_enforce_write,
+#endif
 	.llseek = generic_file_llseek,
 };
 
@@ -2815,14 +2844,18 @@ static int __init securityfs_init(void)
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
+	if (!sig_enforce)
+		mode |= S_IWUSR;
+
+	enforce = securityfs_create_file("enforce", mode, modsign_dir, NULL,
+					 &modsign_enforce_ops);
 	if (IS_ERR(enforce))
 		goto out;
 
-- 
1.8.3.1
