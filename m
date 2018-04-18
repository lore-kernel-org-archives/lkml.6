Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeDRORd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:17:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41676 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbeDRORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:17:32 -0400
X-Google-Smtp-Source: AIpwx4+jlPEwwvtoaZD8Vw4P7qyOQYAFMYAIPlCvpCLtgCvf5Gg7p+MMeurHXB4Sb4Xnbh1pJ3HKug==
From: jingwei.liuxi@gmail.com
To: aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Victor Liu <jingwei.liuxi@gmail.com>
Subject: [PATCH] kasan: modify the exception handling if kmalloc or krealloc return NULL
Date: Wed, 18 Apr 2018 07:17:00 -0700
Message-Id: <1524061020-32466-1-git-send-email-jingwei.liuxi@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Liu <jingwei.liuxi@gmail.com>

Both kmalloc and krealloc may return NULL(!ptr1 || !ptr2), and we do not
know which one is.

Signed-off-by: Victor Liu <jingwei.liuxi@gmail.com>
---
 lib/test_kasan.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ec65710..afa10bf 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -153,9 +153,13 @@ static noinline void __init kmalloc_oob_krealloc_more(void)
 
 	pr_info("out-of-bounds after krealloc more\n");
 	ptr1 = kmalloc(size1, GFP_KERNEL);
+	if (!ptr1) {
+		pr_err("Allocation ptr1 failed\n");
+		return;
+	}
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
-	if (!ptr1 || !ptr2) {
-		pr_err("Allocation failed\n");
+	if (!ptr2) {
+		pr_err("Allocation ptr2 failed\n");
 		kfree(ptr1);
 		return;
 	}
@@ -172,9 +176,13 @@ static noinline void __init kmalloc_oob_krealloc_less(void)
 
 	pr_info("out-of-bounds after krealloc less\n");
 	ptr1 = kmalloc(size1, GFP_KERNEL);
+	if (!ptr1) {
+		pr_err("Allocation ptr1 failed\n");
+		return;
+	}
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
-	if (!ptr1 || !ptr2) {
-		pr_err("Allocation failed\n");
+	if (!ptr2) {
+		pr_err("Allocation ptr2 failed\n");
 		kfree(ptr1);
 		return;
 	}
@@ -190,11 +198,14 @@ static noinline void __init kmalloc_oob_16(void)
 
 	pr_info("kmalloc out-of-bounds for 16-bytes access\n");
 	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
+	if (!ptr1) {
+		pr_err("Allocation ptr1 failed\n");
+		return;
+	}
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
-	if (!ptr1 || !ptr2) {
-		pr_err("Allocation failed\n");
+	if (!ptr2) {
+		pr_err("Allocation ptr2 failed\n");
 		kfree(ptr1);
-		kfree(ptr2);
 		return;
 	}
 	*ptr1 = *ptr2;
-- 
2.7.4
