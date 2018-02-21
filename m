Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeBUT0K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:26:10 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41648 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbeBUT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:26:09 -0500
X-Google-Smtp-Source: AH8x226SwdYsrbR5LtCus5NGarU01PJxtD4GQSyHrDzgELBWu57V75skDJaOYn17CuVxouUAVkYT2A==
Date: Wed, 21 Feb 2018 22:26:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] proc: more "unsigned int" in /proc/*/cmdline
Message-ID: <20180221192605.GB28548@avx2>
References: <20180221192339.GA28548@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221192339.GA28548@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

access_remote_vm() doesn't return negative errors, it returns number of
bytes read/written (0 if error occurs). This allows to delete some
comparisons which never trigger.

Reuse "nr_read" variable while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -280,9 +280,10 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
-	if (rv <= 0)
+	if (access_remote_vm(mm, arg_end - 1, &c, 1, 0) != 1) {
+		rv = 0;
 		goto out_free_page;
+	}
 
 	rv = 0;
 
@@ -294,14 +295,11 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 		p = arg_start + *pos;
 		len = len1 - *pos;
 		while (count > 0 && len > 0) {
-			unsigned int _count;
-			int nr_read;
-
-			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
-			if (nr_read < 0)
-				rv = nr_read;
-			if (nr_read <= 0)
+			unsigned int nr_read;
+
+			nr_read = min3(count, len, PAGE_SIZE);
+			nr_read = access_remote_vm(mm, p, page, nr_read, 0);
+			if (nr_read == 0)
 				goto out_free_page;
 
 			if (copy_to_user(buf, page, nr_read)) {
@@ -339,15 +337,12 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			p = cmdline[i].p + pos1;
 			len = cmdline[i].len - pos1;
 			while (count > 0 && len > 0) {
-				unsigned int _count, l;
-				int nr_read;
+				unsigned int nr_read, l;
 				bool final;
 
-				_count = min3(count, len, PAGE_SIZE);
-				nr_read = access_remote_vm(mm, p, page, _count, 0);
-				if (nr_read < 0)
-					rv = nr_read;
-				if (nr_read <= 0)
+				nr_read = min3(count, len, PAGE_SIZE);
+				nr_read = access_remote_vm(mm, p, page, nr_read, 0);
+				if (nr_read == 0)
 					goto out_free_page;
 
 				/*
