Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeDIObb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:31:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35508 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeDIOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:31:30 -0400
X-Google-Smtp-Source: AIpwx481+6MSgyw5ImKN4HB/mPWrepLSokdaZ2ja14vGZy7E4E64W9rSNN9Nm5pQ+Gv0LrbH4rW8HQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: jack@suse.com
Cc: linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: quota: Replace GFP_ATOMIC with GFP_KERNEL in dquot_init
Date: Mon,  9 Apr 2018 22:31:19 +0800
Message-Id: <1523284279-25940-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dquot_init() is never called in atomic context.
This function is only set as a parameter of fs_initcall().

Despite never getting called from atomic context,
dquot_init() calls __get_free_pages() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 8381db9..d6e111e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2944,7 +2944,7 @@ static int __init dquot_init(void)
 			NULL);
 
 	order = 0;
-	dquot_hash = (struct hlist_head *)__get_free_pages(GFP_ATOMIC, order);
+	dquot_hash = (struct hlist_head *)__get_free_pages(GFP_KERNEL, order);
 	if (!dquot_hash)
 		panic("Cannot create dquot hash table");
 
-- 
1.9.1
