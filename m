Return-Path: <kent.overstreet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527038324; cv=none;
        d=google.com; s=arc-20160816;
        b=HdO2A2O/ekMExIWwSElWpjOG7Ryz07Mw4Vqq4fPg8ABbm7cPsVP7ikfz+zxAynSuI1
         aznHo8wZqWZDFvlHFar3M9NBg05bN5F6/lk3It4jkjjT4ZRdFPx9cwI4PqTKaOEwuJ0n
         cCNSyhulVWfO0FEQGMHxo93gIJrO+//vSZCgYKhujWEL3m81ITs5yDFhoSQfAzQumuwQ
         7NMAgEbBO/kPU4RLTkbet4V8iPCxzXTS1o77iZy+T6qX79KvvoVwknZk/P3TCNnWlAc0
         jzfOg2oE4ZaELCACCRE4j7RSDKU1EJ1PO42WCu9zvESk6MFh+J4Do3eTmwTW+vsW4M6G
         oi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WtOslBBLByX4Fl9YDr9KFowAFd5kPEwmzhc3H5iBFgE=;
        b=Ci9dbViM9egY2MXRQ0ksTdef/cncEuFeVmYEtGPwPfuRHRHiGKhPSEFX6ClkG8f3k/
         QWbGi7DvH6aWM7RXImSoga2C5LrRm2GE1pA6BflPV3RjxbkBJZTUUDd0Vqn6Lovh5ib/
         QqlFg02bRe/AzsHnIki4tid6spBmS7SH1LI27FMFqDtjXYRu9tYnQwDVhemkMO1T0VKg
         xSHIeT0l69SK39Jznn6/Nx0JZZ4z3XC2O+TRqupaEkfmsFPviE8u4YIcu6PziMDSGkmt
         /RmVYesxm8GjN5zkXXrBFzJ6nNw4IO8bAU3G7/zPSePS5vl6Krheg56G5tFQVFzlzizC
         XtCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ObKTyntS;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ObKTyntS;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpr5/PGVk7fxq67LxCdTaiC5fm7unqSl0gHegzwtlJD9gwKGjgHSff7fqYmZqU6iy0QR/FhFw==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	linux-security-module@vger.kernel.org,
	selinux@tycho.nsa.gov,
	dev@openvswitch.org,
	shli@kernel.org,
	linux-raid@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 2/6] proc: commit to genradix
Date: Tue, 22 May 2018 21:18:17 -0400
Message-Id: <20180523011821.12165-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523011821.12165-1-kent.overstreet@gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215737590926779?=
X-GMAIL-MSGID: =?utf-8?q?1601215737590926779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

the new generic radix trees have a simpler API and implementation, and
no limitations on number of elements, so all flex_array users are being
converted

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/proc/base.c | 48 +++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9298324325..0a762eda64 100644
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
 #ifdef CONFIG_HARDWALL
 #include <asm/hardwall.h>
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
@@ -2176,35 +2177,21 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
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
-			mmput(mm);
-			goto out_put_task;
+			goto out_put_mm;
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
 
@@ -2212,7 +2199,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
 		unsigned int len;
 
-		p = flex_array_get(fa, i);
+		p = genradix_ptr(&fa, i);
 		len = snprintf(buf, sizeof(buf), "%lx-%lx", p->start, p->end);
 		if (!proc_fill_cache(file, ctx,
 				      buf, len,
@@ -2222,13 +2209,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		ctx->pos++;
 	}
-	if (fa)
-		flex_array_free(fa);
+out_put_mm:
 	mmput(mm);
-
 out_put_task:
 	put_task_struct(task);
 out:
+	genradix_free(&fa);
 	return ret;
 }
 
-- 
2.17.0
