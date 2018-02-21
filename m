Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeBUTdk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:33:40 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45054 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBUTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:33:39 -0500
X-Google-Smtp-Source: AH8x225DU0QTxNO9xxvDmDG3EQTYUrfCPsTDK0v3BJxrSZGAzBj++gFEdQXjpR5Ds2K0N94dL5YYUw==
Date: Wed, 21 Feb 2018 22:33:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] proc: deduplicate /proc/*/cmdline implementation
Message-ID: <20180221193335.GB28678@avx2>
References: <20180221192339.GA28548@avx2>
 <20180221192605.GB28548@avx2>
 <20180221192751.GC28548@avx2>
 <20180221193009.GA28678@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221193009.GA28678@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code can be sonsolidated if a dummy region of 0 length is used in normal
case of \0-separated command line:

1) [arg_start, arg_end) + [dummy len=0]
2) [arg_start, arg_end) + [env_start, env_end)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   53 ++++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -239,9 +239,12 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	char *page;
 	unsigned long count = _count;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long len1, len2, len;
-	unsigned long p;
+	unsigned long len1, len2;
 	char __user *buf0 = buf;
+	struct {
+		unsigned long p;
+		unsigned long len;
+	} cmdline[2];
 	char c;
 	int rv;
 
@@ -283,43 +286,21 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	if (access_remote_vm(mm, arg_end - 1, &c, 1, 0) != 1)
 		goto end;
 
+	cmdline[0].p = arg_start;
+	cmdline[0].len = len1;
 	if (c == '\0') {
 		/* Command line (set of strings) occupies whole ARGV. */
-		if (len1 <= *pos)
-			goto end;
-
-		p = arg_start + *pos;
-		len = len1 - *pos;
-		while (count > 0 && len > 0) {
-			unsigned int nr_read;
-
-			nr_read = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, nr_read, 0);
-			if (nr_read == 0)
-				goto end;
-
-			if (copy_to_user(buf, page, nr_read)) {
-				rv = -EFAULT;
-				goto out_free_page;
-			}
-
-			p	+= nr_read;
-			len	-= nr_read;
-			buf	+= nr_read;
-			count	-= nr_read;
-		}
+		cmdline[1].len = 0;
 	} else {
 		/*
 		 * Command line (1 string) occupies ARGV and
 		 * extends into ENVP.
 		 */
-		struct {
-			unsigned long p;
-			unsigned long len;
-		} cmdline[2] = {
-			{ .p = arg_start, .len = len1 },
-			{ .p = env_start, .len = len2 },
-		};
+		cmdline[1].p = env_start;
+		cmdline[1].len = len2;
+	}
+
+	{
 		loff_t pos1 = *pos;
 		unsigned int i;
 
@@ -329,6 +310,9 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			i++;
 		}
 		while (i < 2) {
+			unsigned long p;
+			unsigned long len;
+
 			p = cmdline[i].p + pos1;
 			len = cmdline[i].len - pos1;
 			while (count > 0 && len > 0) {
@@ -343,7 +327,10 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 				 * Command line can be shorter than whole ARGV
 				 * even if last "marker" byte says it is not.
 				 */
-				nr_write = strnlen(page, nr_read);
+				if (c == '\0')
+					nr_write = nr_read;
+				else
+					nr_write = strnlen(page, nr_read);
 
 				if (copy_to_user(buf, page, nr_write)) {
 					rv = -EFAULT;
