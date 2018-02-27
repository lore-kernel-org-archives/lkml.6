Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeB0UuF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:50:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751831AbeB0UuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:50:01 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/5] sysctl: Add flags to support min/max range clamping
Date: Tue, 27 Feb 2018 15:49:48 -0500
Message-Id: <1519764591-27456-3-git-send-email-longman@redhat.com>
In-Reply-To: <1519764591-27456-1-git-send-email-longman@redhat.com>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
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

When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table entry,
any update from the userspace will be clamped to the given range
without error.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sysctl.h |  6 ++++++
 kernel/sysctl.c        | 58 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b769ecf..eceeaee 100644
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
@@ -123,6 +124,11 @@ struct ctl_table
 	void *extra2;
 } __randomize_layout;
 
+/*
+ * ctl_table flags (16 different flags, at most)
+ */
+#define CTL_FLAGS_CLAMP_RANGE	(1 << 0) /* Clamp to min/max range */
+
 struct ctl_node {
 	struct rb_node node;
 	struct ctl_table_header *header;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 52b647a..2b2b30c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2505,15 +2505,21 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
  *
  * The do_proc_dointvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_dointvec_minmax() handler. The error
- * code -EINVAL will be returned if the range check fails.
+ * parameters that use the proc_dointvec_minmax() handler.
+ *
+ * The error code -EINVAL will be returned if the range check fails
+ * and the CTL_FLAGS_CLAMP_RANGE bit is not set in the given flags.
+ * If that flag is set, the new sysctl value will be clamped to the
+ * given range without returning any error.
  *
  *  min: ptr to minimum allowable value
  *  max: ptr to maximum allowable value
+ *  flags: ptr to flags
  */
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
+	uint16_t *flags;
 };
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
@@ -2523,9 +2529,21 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
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
@@ -2562,6 +2580,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 	struct do_proc_dointvec_minmax_conv_param param = {
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
+		.flags = &table->flags,
 	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
@@ -2572,15 +2591,21 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
  *
  * The do_proc_dointvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_douintvec_minmax() handler. The error
- * code -ERANGE will be returned if the range check fails.
+ * parameters that use the proc_douintvec_minmax() handler.
+ *
+ * The error code -ERANGE will be returned if the range check fails
+ * and the CTL_FLAGS_CLAMP_RANGE bit is not set in the given flags.
+ * If that flag is set, the new sysctl value will be clamped to the
+ * given range without returning any error.
  *
  *  min: ptr to minimum allowable value
  *  max: ptr to maximum allowable value
+ *  flags: ptr to flags
  */
 struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
+	uint16_t *flags;
 };
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
@@ -2591,14 +2616,24 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 
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
@@ -2633,6 +2668,7 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
 	struct do_proc_douintvec_minmax_conv_param param = {
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
+		.flags = &table->flags,
 	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
-- 
1.8.3.1
