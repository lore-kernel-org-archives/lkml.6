Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeB0A1B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:27:01 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50004 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751744AbeB0A1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:27:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SyYb1iR_1519691153;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org, mingo@kernel.org, adobriyan@gmail.com
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4 v2] fs: proc: use down_read_killable() in environ_read()
Date: Tue, 27 Feb 2018 08:25:50 +0800
Message-Id: <1519691151-101999-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like reading /proc/*/cmdline, it is possible to be blocked for long time
when reading /proc/*/environ when manipulating large mapping at the mean
time. The environ reading process will be waiting for mmap_sem become
available for a long time then it may cause the reading task hung.

Convert down_read() and access_remote_vm() to killable version.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9bdb84b..d87d9ab 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -933,7 +933,9 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	down_read(&mm->mmap_sem);
+	ret = down_read_killable(&mm->mmap_sem);
+	if (ret)
+		goto out_mmput;
 	env_start = mm->env_start;
 	env_end = mm->env_end;
 	up_read(&mm->mmap_sem);
@@ -950,7 +952,8 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 		max_len = min_t(size_t, PAGE_SIZE, count);
 		this_len = min(max_len, this_len);
 
-		retval = access_remote_vm(mm, (env_start + src), page, this_len, 0);
+		retval = access_remote_vm_killable(mm, (env_start + src),
+						page, this_len, 0);
 
 		if (retval <= 0) {
 			ret = retval;
@@ -968,6 +971,8 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 		count -= retval;
 	}
 	*ppos = src;
+
+out_mmput:
 	mmput(mm);
 
 free:
-- 
1.8.3.1
