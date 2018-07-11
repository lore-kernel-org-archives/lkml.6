Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEACC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3DB208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3DB208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbeGKCYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45490 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbeGKCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4la-0003He-Kq; Wed, 11 Jul 2018 02:22:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 05/42] fold security_file_free() into file_free()
Date:   Wed, 11 Jul 2018 03:21:29 +0100
Message-Id: <20180711022206.12571-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 1f14b80a4e67..eee7cf629e52 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -51,6 +51,7 @@ static void file_free_rcu(struct rcu_head *head)
 
 static inline void file_free(struct file *f)
 {
+	security_file_free(f);
 	percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
@@ -207,7 +208,6 @@ static void __fput(struct file *file)
 	}
 	if (file->f_op->release)
 		file->f_op->release(inode, file);
-	security_file_free(file);
 	if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL &&
 		     !(file->f_mode & FMODE_PATH))) {
 		cdev_put(inode->i_cdev);
@@ -302,10 +302,8 @@ EXPORT_SYMBOL(fput);
 
 void put_filp(struct file *file)
 {
-	if (atomic_long_dec_and_test(&file->f_count)) {
-		security_file_free(file);
+	if (atomic_long_dec_and_test(&file->f_count))
 		file_free(file);
-	}
 }
 
 void __init files_init(void)
-- 
2.11.0

