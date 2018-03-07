Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964865AbeCGUfw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:35:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934882AbeCGUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:35:08 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/5] sysctl: Add a new handler proc_show_minmax()
Date: Wed,  7 Mar 2018 15:34:26 -0500
Message-Id: <1520454869-13871-3-git-send-email-longman@redhat.com>
In-Reply-To: <1520454869-13871-1-git-send-email-longman@redhat.com>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new handler will show the minimum and maximum values specified
in the extra1 and extra2 fields of the sysctl table entry.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index bc09361..decb71e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -63,6 +63,8 @@ extern int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int,
 				      void __user *, size_t *, loff_t *);
 extern int proc_do_large_bitmap(struct ctl_table *, int,
 				void __user *, size_t *, loff_t *);
+extern int proc_show_minmax(struct ctl_table *table, int write,
+			    void __user *buffer, size_t *lenp, loff_t *ppos);
 
 /*
  * Register a set of sysctl names by calling register_sysctl_table
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6c68e77..486126f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2700,6 +2700,97 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
 				 do_proc_douintvec_minmax_conv, &param);
 }
 
+/**
+ * proc_show_minmax - show the min/max values
+ * @table: the sysctl table
+ * @write: should always be %FALSE
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * The table->data points to the original ctl_table which is used
+ * to determine the type of the min/max range as defined in the
+ * corresponding extra1 (min) and extra2 (max) field. The range
+ * will be displayed as "[min, max]".
+ *
+ * Returns 0 on success.
+ */
+int proc_show_minmax(struct ctl_table *table, int write,
+			  void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table *ctbl = (struct ctl_table *)table->data;
+	unsigned long min, max;
+	bool min_neg, max_neg;
+	int err = 0;
+	size_t left;
+
+	if (write || !ctbl || ((ctbl->maxlen != sizeof(int)) &&
+			       (ctbl->maxlen != sizeof(long))))
+		return -EINVAL;
+
+	if (*ppos) {
+		/* Not the first time */
+		*lenp = 0;
+		return 0;
+	}
+
+	min_neg = max_neg = false;
+	if (ctbl->proc_handler == proc_douintvec_minmax) {
+		min = ctbl->extra1 ? *(unsigned int *)ctbl->extra1 : 0;
+		max = ctbl->extra2 ? *(unsigned int *)ctbl->extra2 : UINT_MAX;
+	} else if (ctbl->maxlen == sizeof(int)) {
+		/* Assume to be signed integer */
+		unsigned int val;
+
+		val = ctbl->extra1 ? *(int *)ctbl->extra1 : -INT_MAX;
+		if (val < 0) {
+			min = -val;
+			min_neg = true;
+		} else {
+			min = val;
+			min_neg = false;
+		}
+		val = ctbl->extra2 ? *(int *)ctbl->extra2 : INT_MAX;
+		if (val < 0) {
+			max = -val;
+			max_neg = true;
+		} else {
+			max = val;
+			max_neg = false;
+		}
+	} else {
+		/* Assume to be unsigned long */
+		min = ctbl->extra1 ? *(unsigned long *)ctbl->extra1 : 0;
+		max = ctbl->extra2 ? *(unsigned long *)ctbl->extra2 : ULONG_MAX;
+	}
+
+	left = *lenp;
+
+	/*
+	 * Error checks are done only for proc_put_long() and the
+	 * last proc_put_char().
+	 */
+	proc_put_char(&buffer, &left, '[');
+	err = proc_put_long(&buffer, &left, min, min_neg);
+	if (err)
+		goto out;
+
+	proc_put_char(&buffer, &left, ',');
+	proc_put_char(&buffer, &left, ' ');
+	err = proc_put_long(&buffer, &left, max, max_neg);
+	if (err)
+		goto out;
+
+	proc_put_char(&buffer, &left, ']');
+	err = proc_put_char(&buffer, &left, '\n');
+
+out:
+	*lenp -= left;
+	*ppos += *lenp;
+
+	return err;
+}
+
 static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
 					unsigned int *valp,
 					int write, void *data)
-- 
1.8.3.1
