Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pdEJLN5HGVs9QQAAmS7hNA
	; Thu, 07 Jun 2018 14:59:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 246AF608BF; Thu,  7 Jun 2018 14:59:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3EE0F601C3;
	Thu,  7 Jun 2018 14:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EE0F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935719AbeFGO7g (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:59:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41291 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935702AbeFGO7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:34 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zi-Gp; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00030b-Ba; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Jens Axboe" <axboe@kernel.dk>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.972258691@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 208/410] pipe: add proc_dopipe_max_size() to safely
 assign pipe_max_size
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Lawrence <joe.lawrence@redhat.com>

commit 7a8d181949fb2c16be00f8cdb354794a30e46b39 upstream.

pipe_max_size is assigned directly via procfs sysctl:

  static struct ctl_table fs_table[] = {
          ...
          {
                  .procname       = "pipe-max-size",
                  .data           = &pipe_max_size,
                  .maxlen         = sizeof(int),
                  .mode           = 0644,
                  .proc_handler   = &pipe_proc_fn,
                  .extra1         = &pipe_min_size,
          },
          ...

  int pipe_proc_fn(struct ctl_table *table, int write, void __user *buf,
                   size_t *lenp, loff_t *ppos)
  {
          ...
          ret = proc_dointvec_minmax(table, write, buf, lenp, ppos)
          ...

and then later rounded in-place a few statements later:

          ...
          pipe_max_size = round_pipe_size(pipe_max_size);
          ...

This leaves a window of time between initial assignment and rounding
that may be visible to other threads.  (For example, one thread sets a
non-rounded value to pipe_max_size while another reads its value.)

Similar reads of pipe_max_size are potentially racy:

  pipe.c :: alloc_pipe_info()
  pipe.c :: pipe_set_size()

Add a new proc_dopipe_max_size() that consolidates reading the new value
from the user buffer, verifying bounds, and calling round_pipe_size()
with a single assignment to pipe_max_size.

Link: http://lkml.kernel.org/r/1507658689-11669-4-git-send-email-joe.lawrence@redhat.com
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: Continue using int sysctl functions because we don't
 have proper unsigned int support]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1008,7 +1008,7 @@ const struct file_operations pipefifo_fo
  * Currently we rely on the pipe array holding a power-of-2 number
  * of pages. Returns 0 on error.
  */
-static inline unsigned int round_pipe_size(unsigned int size)
+unsigned int round_pipe_size(unsigned int size)
 {
 	unsigned long nr_pages;
 
@@ -1112,25 +1112,13 @@ out_revert_acct:
 }
 
 /*
- * This should work even if CONFIG_PROC_FS isn't set, as proc_dointvec_minmax
+ * This should work even if CONFIG_PROC_FS isn't set, as proc_dopipe_max_size
  * will return an error.
  */
 int pipe_proc_fn(struct ctl_table *table, int write, void __user *buf,
 		 size_t *lenp, loff_t *ppos)
 {
-	unsigned int rounded_pipe_max_size;
-	int ret;
-
-	ret = proc_dointvec_minmax(table, write, buf, lenp, ppos);
-	if (ret < 0 || !write)
-		return ret;
-
-	rounded_pipe_max_size = round_pipe_size(pipe_max_size);
-	if (rounded_pipe_max_size == 0)
-		return -EINVAL;
-
-	pipe_max_size = rounded_pipe_max_size;
-	return ret;
+	return proc_dopipe_max_size(table, write, buf, lenp, ppos);
 }
 
 /*
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -149,5 +149,6 @@ long pipe_fcntl(struct file *, unsigned
 struct pipe_inode_info *get_pipe_info(struct file *file);
 
 int create_pipe_files(struct file **, int);
+unsigned int round_pipe_size(unsigned int size);
 
 #endif
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -45,6 +45,9 @@ extern int proc_dointvec(struct ctl_tabl
 			 void __user *, size_t *, loff_t *);
 extern int proc_dointvec_minmax(struct ctl_table *, int,
 				void __user *, size_t *, loff_t *);
+extern int proc_dopipe_max_size(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp,
+				loff_t *ppos);
 extern int proc_dointvec_jiffies(struct ctl_table *, int,
 				 void __user *, size_t *, loff_t *);
 extern int proc_dointvec_userhz_jiffies(struct ctl_table *, int,
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -64,6 +64,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/kexec.h>
 #include <linux/mount.h>
+#include <linux/pipe_fs_i.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -2222,6 +2223,47 @@ int proc_dointvec_minmax(struct ctl_tabl
 				do_proc_dointvec_minmax_conv, &param);
 }
 
+struct do_proc_dopipe_max_size_conv_param {
+	unsigned int *min;
+};
+
+static int do_proc_dopipe_max_size_conv(bool *negp, unsigned long *lvalp,
+					int *valp, int write, void *data)
+{
+	struct do_proc_dopipe_max_size_conv_param *param = data;
+
+	if (write) {
+		unsigned int val = round_pipe_size(*lvalp);
+
+		if (*negp || val == 0)
+			return -EINVAL;
+
+		if (param->min && *param->min > val)
+			return -ERANGE;
+
+		if (*lvalp > UINT_MAX)
+			return -EINVAL;
+
+		*valp = val;
+	} else {
+		unsigned int val = *valp;
+		*negp = false;
+		*lvalp = (unsigned long) val;
+	}
+
+	return 0;
+}
+
+int proc_dopipe_max_size(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct do_proc_dopipe_max_size_conv_param param = {
+		.min = (unsigned int *) table->extra1,
+	};
+	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+				do_proc_dopipe_max_size_conv, &param);
+}
+
 static void validate_coredump_safety(void)
 {
 #ifdef CONFIG_COREDUMP
@@ -2737,6 +2779,12 @@ int proc_dointvec_minmax(struct ctl_tabl
 	return -ENOSYS;
 }
 
+int proc_dopipe_max_size(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 int proc_dointvec_jiffies(struct ctl_table *table, int write,
 		    void __user *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -2778,6 +2826,7 @@ int proc_doulongvec_ms_jiffies_minmax(st
 EXPORT_SYMBOL(proc_dointvec);
 EXPORT_SYMBOL(proc_dointvec_jiffies);
 EXPORT_SYMBOL(proc_dointvec_minmax);
+EXPORT_SYMBOL_GPL(proc_dopipe_max_size);
 EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
 EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 EXPORT_SYMBOL(proc_dostring);
