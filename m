Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA187C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYFMPd9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbeLQNTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:19:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732593AbeLQNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:19:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so12230690wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZyN84HRyUDGnrcHTh84AN+nH+G5h6oVFeg944FVkY0=;
        b=GYFMPd9yCy4yOOLgvLghLf9ZGU5RcZU4kI6gq8x/qS+CicIUiVw9G+Toh9wggcWCmr
         ENINxh9nIkHCVF+HKtRimD6ahRyGilaT/bgfiO5KVB36DraNgwF/3IaO0OlfeylNSqBC
         OqUN84plUyumcOAPxYuxRse8GPoYGGO9OSxmO59OsUT/UXnaOfe0K33iYwkYu7Ng88y/
         Z4FamV1CmOS4ZXpqjt1PtKZ0EXYz+J4d/Dn9LnNyNbiPJpbA+pGrV5tYmHFtbd1bb6Hf
         yHoLALJSmVAB6DpVr0vccCQ54EeV8WB6t2UOz/o1YiYc8wEE1kBUN/73ZO6+rTnQ4kez
         WxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZyN84HRyUDGnrcHTh84AN+nH+G5h6oVFeg944FVkY0=;
        b=Igb4gGg4jgus0YmqvyOM0M/CEhUFS4qFTFVsKLX3oa7nema7MKaKDYillVGRHB2aVl
         /rNYY8CEKETNB5vlhCr9OnUEBfo3OWsHOpgaWRPM0eB4Yp7wQpJcrPJQgY9Lcw3TZC0f
         Vk8ipjI7+xMwd3mUZmma9qRuxidfTgkQ1tWGpLm8Bprficm/o93b7ySOmpWh3WLFtgzX
         e+ueohHHVusdvROOTPxBWFDOaI0Kfvhxbg+eFDZ2yU9/xIV1vHgradeBU8n74g0a+voe
         rq2HiKd7GPrlogpmCvQ8fiBOi+Bd7KbAv8R52/qUo+bClIhibCRmMiNqLJFH9DEIUrNp
         A6gQ==
X-Gm-Message-State: AA+aEWaoJLLkLUIBj9mSp+nYphfSaUs5UxAaIHVGjflTOruMlcrg9eJc
        IjkbO/SEGk8Bf2R2uLq3jg==
X-Google-Smtp-Source: AFSGD/WqDqZ7G1jyx080JZQsnqP/JzirQ9XRkvciKVBCbnO9IOogiY7Kf4Z910RTn02Lt0oxmT2yVg==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr10616695wrv.288.1545052785471;
        Mon, 17 Dec 2018 05:19:45 -0800 (PST)
Received: from kmo-pixel.syslink.intern ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id x20sm20406120wme.6.2018.12.17.05.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:19:44 -0800 (PST)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/7] proc: commit to genradix
Date:   Mon, 17 Dec 2018 08:19:27 -0500
Message-Id: <20181217131929.11727-6-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181217131929.11727-1-kent.overstreet@gmail.com>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the new generic radix trees have a simpler API and implementation, and
no limitations on number of elements, so all flex_array users are being
converted

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/base.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ce34654794..2edf386ed3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -59,6 +59,7 @@
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
+#include <linux/generic-radix-tree.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/namei.h>
@@ -92,7 +93,6 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
-#include <linux/flex_array.h>
 #include <linux/posix-timers.h>
 #include <trace/events/oom.h>
 #include "internal.h"
@@ -2140,11 +2140,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	struct task_struct *task;
 	struct mm_struct *mm;
 	unsigned long nr_files, pos, i;
-	struct flex_array *fa = NULL;
-	struct map_files_info info;
+	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
 
+	genradix_init(&fa);
+
 	ret = -ENOENT;
 	task = get_proc_task(file_inode(file));
 	if (!task)
@@ -2176,35 +2177,22 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	 */
 
 	for (vma = mm->mmap, pos = 2; vma; vma = vma->vm_next) {
-		if (vma->vm_file && ++pos > ctx->pos)
-			nr_files++;
-	}
+		if (!vma->vm_file)
+			continue;
+		if (++pos <= ctx->pos)
+			continue;
 
-	if (nr_files) {
-		fa = flex_array_alloc(sizeof(info), nr_files,
-					GFP_KERNEL);
-		if (!fa || flex_array_prealloc(fa, 0, nr_files,
-						GFP_KERNEL)) {
+		p = genradix_ptr_alloc(&fa, nr_files++, GFP_KERNEL);
+		if (!p) {
 			ret = -ENOMEM;
-			if (fa)
-				flex_array_free(fa);
 			up_read(&mm->mmap_sem);
 			mmput(mm);
 			goto out_put_task;
 		}
-		for (i = 0, vma = mm->mmap, pos = 2; vma;
-				vma = vma->vm_next) {
-			if (!vma->vm_file)
-				continue;
-			if (++pos <= ctx->pos)
-				continue;
 
-			info.start = vma->vm_start;
-			info.end = vma->vm_end;
-			info.mode = vma->vm_file->f_mode;
-			if (flex_array_put(fa, i++, &info, GFP_KERNEL))
-				BUG();
-		}
+		p->start = vma->vm_start;
+		p->end = vma->vm_end;
+		p->mode = vma->vm_file->f_mode;
 	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);
@@ -2213,7 +2201,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
 		unsigned int len;
 
-		p = flex_array_get(fa, i);
+		p = genradix_ptr(&fa, i);
 		len = snprintf(buf, sizeof(buf), "%lx-%lx", p->start, p->end);
 		if (!proc_fill_cache(file, ctx,
 				      buf, len,
@@ -2223,12 +2211,11 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		ctx->pos++;
 	}
-	if (fa)
-		flex_array_free(fa);
 
 out_put_task:
 	put_task_struct(task);
 out:
+	genradix_free(&fa);
 	return ret;
 }
 
-- 
2.20.1

