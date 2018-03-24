Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeCXC7x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 22:59:53 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40739 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751531AbeCXC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 22:59:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T--Ioa8_1521860388;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH 2/3] module: Create the entry point initialize_module()
Date: Sat, 24 Mar 2018 10:59:48 +0800
Message-Id: <1521860389-19262-3-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This entry point currently includes the procfs initialization,
and will include a securityfs initialization.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 kernel/module.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 003d0ab..79825ea 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4243,7 +4243,11 @@ static int __init proc_modules_init(void)
 	proc_create("modules", 0, NULL, &proc_modules_operations);
 	return 0;
 }
-module_init(proc_modules_init);
+#else	/* CONFIG_PROC_FS */
+static int __init proc_modules_init(void)
+{
+        return 0;
+}
 #endif
 
 /* Given an address, look for it in the module exception tables. */
@@ -4388,3 +4392,11 @@ void module_layout(struct module *mod,
 }
 EXPORT_SYMBOL(module_layout);
 #endif
+
+static int __init initialize_module(void)
+{
+	proc_modules_init();
+
+	return 0;
+}
+module_init(initialize_module);
-- 
1.8.3.1
