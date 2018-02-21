Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeBUTaP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:30:15 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39981 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBUTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:30:13 -0500
X-Google-Smtp-Source: AH8x227o9svozL8tgeyIUAC+azgVNjZ5kIxrfxqhz32gvkxwbxmvAQWrQ39PWQ6jUg8anG3c7EYMZw==
Date: Wed, 21 Feb 2018 22:30:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] proc: simpler iterations for /proc/*/cmdline
Message-ID: <20180221193009.GA28678@avx2>
References: <20180221192339.GA28548@avx2>
 <20180221192605.GB28548@avx2>
 <20180221192751.GC28548@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221192751.GC28548@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"rv" variable is used both as a counter of bytes transferred and
an error value holder but it can be reduced solely to error values
if original start of userspace buffer is stashed and used at the very
end.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -241,8 +241,9 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long len1, len2, len;
 	unsigned long p;
+	char __user *buf0 = buf;
 	char c;
-	ssize_t rv;
+	int rv;
 
 	BUG_ON(*pos < 0);
 
@@ -272,25 +273,20 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	len2 = env_end - env_start;
 
 	/* Empty ARGV. */
-	if (len1 == 0) {
-		rv = 0;
-		goto out_free_page;
-	}
+	if (len1 == 0)
+		goto end;
+
 	/*
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	if (access_remote_vm(mm, arg_end - 1, &c, 1, 0) != 1) {
-		rv = 0;
-		goto out_free_page;
-	}
-
-	rv = 0;
+	if (access_remote_vm(mm, arg_end - 1, &c, 1, 0) != 1)
+		goto end;
 
 	if (c == '\0') {
 		/* Command line (set of strings) occupies whole ARGV. */
 		if (len1 <= *pos)
-			goto out_free_page;
+			goto end;
 
 		p = arg_start + *pos;
 		len = len1 - *pos;
@@ -300,7 +296,7 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			nr_read = min3(count, len, PAGE_SIZE);
 			nr_read = access_remote_vm(mm, p, page, nr_read, 0);
 			if (nr_read == 0)
-				goto out_free_page;
+				goto end;
 
 			if (copy_to_user(buf, page, nr_read)) {
 				rv = -EFAULT;
@@ -311,7 +307,6 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			len	-= nr_read;
 			buf	+= nr_read;
 			count	-= nr_read;
-			rv	+= nr_read;
 		}
 	} else {
 		/*
@@ -342,7 +337,7 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 				nr_read = min3(count, len, PAGE_SIZE);
 				nr_read = access_remote_vm(mm, p, page, nr_read, 0);
 				if (nr_read == 0)
-					goto out_free_page;
+					goto end;
 
 				/*
 				 * Command line can be shorter than whole ARGV
@@ -359,10 +354,9 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 				len	-= nr_write;
 				buf	+= nr_write;
 				count	-= nr_write;
-				rv	+= nr_write;
 
 				if (nr_write < nr_read)
-					goto out_free_page;
+					goto end;
 			}
 
 			/* Only first chunk can be read partially. */
@@ -371,12 +365,16 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 		}
 	}
 
+end:
+	free_page((unsigned long)page);
+	mmput(mm);
+	*pos += buf - buf0;
+	return buf - buf0;
+
 out_free_page:
 	free_page((unsigned long)page);
 out_mmput:
 	mmput(mm);
-	if (rv > 0)
-		*pos += rv;
 	return rv;
 }
 
