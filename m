Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323AFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DEB20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170624;
	bh=1nOozEsSUz8dyn0aFTKCY+ImkAwlfJO+S17q+cBSbzE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=REhN3wrTXU53y0B/43ND1weLltg4RhUYvWfHvFmd9jIuMp7hAhYKxgT229gPj4Uyf
	 SzDwXepR2udrCImnSRFZJVs7JumB5EwaMVbOnpliVnQpdXnRZdWQ7MYC69zot2hc5y
	 bjWdHyhes7V+k5ZoziIGKxAb6y7caWWq95TVMtrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfAVPXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbfAVPXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E9F217D8;
        Tue, 22 Jan 2019 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170619;
        bh=1nOozEsSUz8dyn0aFTKCY+ImkAwlfJO+S17q+cBSbzE=;
        h=From:To:Cc:Subject:Date:From;
        b=rVXoy3sTFc0lLqOHDZwObAk3X5j3/zho1lOxRAaw+Nce4QUt6mHtIx+lyR6dCTSg6
         T++P1+qvmXzKZRqCKSX2Zoz0aCJj7mSH3QVuHLQxnWleUzV/wuIP9U6oipgv3Rww0/
         hLSuMw2mz+Qwo5Fuc2QNVogmgORT/Zu8/ww6QAoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>, Josef Bacik <jbacik@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] fail_function: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:44 +0100
Message-Id: <20190122152151.16139-45-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/fail_function.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 17f75b545f66..afc779be5ebb 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -152,20 +152,13 @@ static int fei_retval_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fei_retval_ops, fei_retval_get, fei_retval_set,
 			 "%llx\n");
 
-static int fei_debugfs_add_attr(struct fei_attr *attr)
+static void fei_debugfs_add_attr(struct fei_attr *attr)
 {
 	struct dentry *dir;
 
 	dir = debugfs_create_dir(attr->kp.symbol_name, fei_debugfs_dir);
-	if (!dir)
-		return -ENOMEM;
-
-	if (!debugfs_create_file("retval", 0600, dir, attr, &fei_retval_ops)) {
-		debugfs_remove_recursive(dir);
-		return -ENOMEM;
-	}
 
-	return 0;
+	debugfs_create_file("retval", 0600, dir, attr, &fei_retval_ops);
 }
 
 static void fei_debugfs_remove_attr(struct fei_attr *attr)
@@ -306,7 +299,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 
 	ret = register_kprobe(&attr->kp);
 	if (!ret)
-		ret = fei_debugfs_add_attr(attr);
+		fei_debugfs_add_attr(attr);
 	if (ret < 0)
 		fei_attr_remove(attr);
 	else {
@@ -337,19 +330,13 @@ static int __init fei_debugfs_init(void)
 		return PTR_ERR(dir);
 
 	/* injectable attribute is just a symlink of error_inject/list */
-	if (!debugfs_create_symlink("injectable", dir,
-				    "../error_injection/list"))
-		goto error;
+	debugfs_create_symlink("injectable", dir, "../error_injection/list");
 
-	if (!debugfs_create_file("inject", 0600, dir, NULL, &fei_ops))
-		goto error;
+	debugfs_create_file("inject", 0600, dir, NULL, &fei_ops);
 
 	fei_debugfs_dir = dir;
 
 	return 0;
-error:
-	debugfs_remove_recursive(dir);
-	return -ENOMEM;
 }
 
 late_initcall(fei_debugfs_init);
-- 
2.20.1

