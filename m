Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbeCIWb1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:31:27 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33651 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeCIWbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:31:23 -0500
X-Google-Smtp-Source: AG47ELszvsVnS3bo1gpPgUt7pc9lT5blrw/PzDHypb3YGuzdBzz6P0RY6gVU+i2VbEFCq9hg+E0QKw==
Date: Sat, 10 Mar 2018 01:31:20 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: do mmput ASAP for /proc/*/map_files
Message-ID: <20180309223120.GC3843@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_struct not needed while printing as all the data was already extracted.


Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2214,6 +2214,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		}
 	}
 	up_read(&mm->mmap_sem);
+	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
@@ -2231,7 +2232,6 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	}
 	if (fa)
 		flex_array_free(fa);
-	mmput(mm);
 
 out_put_task:
 	put_task_struct(task);
