Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeCPSOk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:14:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752640AbeCPSOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:14:33 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 1/9] sysctl: Add flags to support min/max range clamping
Date: Fri, 16 Mar 2018 14:13:42 -0400
Message-Id: <1521224030-2185-2-git-send-email-longman@redhat.com>
In-Reply-To: <1521224030-2185-1-git-send-email-longman@redhat.com>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When minimum/maximum values are specified for a sysctl parameter in
the ctl_table structure with proc_dointvec_minmax() handler, update
to that parameter will fail with error if the given value is outside
of the required range.

There are use cases where it may be better to clamp the value of
the sysctl parameter to the given range without failing the update,
especially if the users are not aware of the actual range limits.
Reading the value back after the update will now be a good practice
to see if the provided value exceeds the range limits.

To provide this less restrictive form of range checking, a new flags
field is added to the ctl_table structure. The new field is a 16-bit
value that just fits into the hole left by the 16-bit umode_t field
without increasing the size of the structure.

When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table
entry, any update from the userspace will be clamped to the given
range without error if either the proc_dointvec_minmax() or the
proc_douintvec_minmax() handlers is used.

The clamped value is either the maximum or minimum value that is
closest to the input value provided by the user.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sysctl.h | 20 ++++++++++++++++++++
 kernel/sysctl.c        | 48 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b769ecf..e446e1f 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -116,6 +116,7 @@ struct ctl_table
 	void *data;
 	int maxlen;
 	umode_t mode;
+	uint16_t flags;
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
@@ -123,6 +124,25 @@ struct ctl_table
 	void *extra2;
 } __randomize_layout;
 
+/**
+ * enum ctl_table_flags - flags for the ctl table (struct ctl_table.flags)
+ *
+ * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
+ *	flexibly clamped to the provided min/max value in case the user
+ *	provided a value outside of the given range. The clamped value is
+ *	either the provided minimum or maximum value that is closest to
+ *	the input value. No lower bound or upper bound checking will be
+ *	done if the corresponding minimum or maximum value isn't provided.
+ *
+ * At most 16 different flags are allowed.
+ */
+enum ctl_table_flags {
+	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
+	__CTL_FLAGS_MAX			= BIT(1),
+};
+
+#define CTL_TABLE_FLAGS_ALL	(__CTL_FLAGS_MAX - 1)
+
 struct ctl_node {
 	struct rb_node node;
 	struct ctl_table_header *header;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d2aa6b4..af351ed 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2504,6 +2504,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
  * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
  * @min: pointer to minimum allowable value
  * @max: pointer to maximum allowable value
+ * @flags: pointer to flags
  *
  * The do_proc_dointvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
@@ -2512,6 +2513,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
+	uint16_t *flags;
 };
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
@@ -2521,9 +2523,21 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 	struct do_proc_dointvec_minmax_conv_param *param = data;
 	if (write) {
 		int val = *negp ? -*lvalp : *lvalp;
-		if ((param->min && *param->min > val) ||
-		    (param->max && *param->max < val))
-			return -EINVAL;
+		bool clamp = param->flags &&
+			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
+
+		if (param->min && *param->min > val) {
+			if (clamp)
+				val = *param->min;
+			else
+				return -EINVAL;
+		}
+		if (param->max && *param->max < val) {
+			if (clamp)
+				val = *param->max;
+			else
+				return -EINVAL;
+		}
 		*valp = val;
 	} else {
 		int val = *valp;
@@ -2552,7 +2566,8 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
  * This routine will ensure the values are within the range specified by
  * table->extra1 (min) and table->extra2 (max).
  *
- * Returns 0 on success or -EINVAL on write when the range check fails.
+ * Returns 0 on success or -EINVAL on write when the range check fails
+ * without the CTL_FLAGS_CLAMP_RANGE flag.
  */
 int proc_dointvec_minmax(struct ctl_table *table, int write,
 		  void __user *buffer, size_t *lenp, loff_t *ppos)
@@ -2560,6 +2575,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 	struct do_proc_dointvec_minmax_conv_param param = {
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
+		.flags = &table->flags,
 	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
@@ -2569,6 +2585,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
  * struct do_proc_douintvec_minmax_conv_param - proc_douintvec_minmax() range checking structure
  * @min: pointer to minimum allowable value
  * @max: pointer to maximum allowable value
+ * @flags: pointer to flags
  *
  * The do_proc_douintvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
@@ -2577,6 +2594,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
+	uint16_t *flags;
 };
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
@@ -2587,14 +2605,24 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 
 	if (write) {
 		unsigned int val = *lvalp;
+		bool clamp = param->flags &&
+			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
 
 		if (*lvalp > UINT_MAX)
 			return -EINVAL;
 
-		if ((param->min && *param->min > val) ||
-		    (param->max && *param->max < val))
-			return -ERANGE;
-
+		if (param->min && *param->min > val) {
+			if (clamp)
+				val = *param->min;
+			else
+				return -ERANGE;
+		}
+		if (param->max && *param->max < val) {
+			if (clamp)
+				val = *param->max;
+			else
+				return -ERANGE;
+		}
 		*valp = val;
 	} else {
 		unsigned int val = *valp;
@@ -2621,7 +2649,8 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
  * check for UINT_MAX to avoid having to support wrap around uses from
  * userspace.
  *
- * Returns 0 on success or -ERANGE on write when the range check fails.
+ * Returns 0 on success or -ERANGE on write when the range check fails
+ * without the CTL_FLAGS_CLAMP_RANGE flag.
  */
 int proc_douintvec_minmax(struct ctl_table *table, int write,
 			  void __user *buffer, size_t *lenp, loff_t *ppos)
@@ -2629,6 +2658,7 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
 	struct do_proc_douintvec_minmax_conv_param param = {
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
+		.flags = &table->flags,
 	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
-- 
1.8.3.1
