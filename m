Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeBUT14 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:27:56 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36576 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBUT1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:27:54 -0500
X-Google-Smtp-Source: AH8x226aCYoTjTzEd4UApqI7yN+IloL2Icg0MHshwd/oa857Nqg3BfsaK5PKBXZ9LQposoQCYLdr5w==
Date: Wed, 21 Feb 2018 22:27:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] proc: somewhat simpler code for /proc/*/cmdline
Message-ID: <20180221192751.GC28548@avx2>
References: <20180221192339.GA28548@avx2>
 <20180221192605.GB28548@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221192605.GB28548@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"final" variable is OK but we can get away with less lines.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -337,8 +337,7 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			p = cmdline[i].p + pos1;
 			len = cmdline[i].len - pos1;
 			while (count > 0 && len > 0) {
-				unsigned int nr_read, l;
-				bool final;
+				unsigned int nr_read, nr_write;
 
 				nr_read = min3(count, len, PAGE_SIZE);
 				nr_read = access_remote_vm(mm, p, page, nr_read, 0);
@@ -349,25 +348,20 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 				 * Command line can be shorter than whole ARGV
 				 * even if last "marker" byte says it is not.
 				 */
-				final = false;
-				l = strnlen(page, nr_read);
-				if (l < nr_read) {
-					nr_read = l;
-					final = true;
-				}
+				nr_write = strnlen(page, nr_read);
 
-				if (copy_to_user(buf, page, nr_read)) {
+				if (copy_to_user(buf, page, nr_write)) {
 					rv = -EFAULT;
 					goto out_free_page;
 				}
 
-				p	+= nr_read;
-				len	-= nr_read;
-				buf	+= nr_read;
-				count	-= nr_read;
-				rv	+= nr_read;
+				p	+= nr_write;
+				len	-= nr_write;
+				buf	+= nr_write;
+				count	-= nr_write;
+				rv	+= nr_write;
 
-				if (final)
+				if (nr_write < nr_read)
 					goto out_free_page;
 			}
 
