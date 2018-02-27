Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeB0UvC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:51:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751856AbeB0UuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:50:01 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/5] sysctl: Warn when a clamped sysctl parameter is set out of range
Date: Tue, 27 Feb 2018 15:49:49 -0500
Message-Id: <1519764591-27456-4-git-send-email-longman@redhat.com>
In-Reply-To: <1519764591-27456-1-git-send-email-longman@redhat.com>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even with clamped sysctl parameters, it is still not that straight
forward to figure out the exact range of those parameters. One may
try to write extreme parameter values to see if they get clamped.
To make it easier, a warning with the expected range will now be
printed in the kernel ring buffer when a clamped sysctl parameter
receives an out of range value.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sysctl.h |  1 +
 kernel/sysctl.c        | 55 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index eceeaee..4e4f74a2 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -128,6 +128,7 @@ struct ctl_table
  * ctl_table flags (16 different flags, at most)
  */
 #define CTL_FLAGS_CLAMP_RANGE	(1 << 0) /* Clamp to min/max range */
+#define CTL_FLAGS_OOR_WARNED	(1 << 1) /* Out-of-range warning issued */
 
 struct ctl_node {
 	struct rb_node node;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2b2b30c..f9f3373 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2515,36 +2515,54 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
  *  min: ptr to minimum allowable value
  *  max: ptr to maximum allowable value
  *  flags: ptr to flags
+ *  name: sysctl parameter name
  */
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
 	uint16_t *flags;
+	const char *name;
 };
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int *valp,
 					int write, void *data)
 {
+#define SYSCTL_WARN_MSG	\
+"Kernel parameter \"%s\" was set out of range [%d, %d], clamped to %d.\n"
+
 	struct do_proc_dointvec_minmax_conv_param *param = data;
+
 	if (write) {
 		int val = *negp ? -*lvalp : *lvalp;
+		bool clamped = false;
 		bool clamp = param->flags &&
 			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
 
 		if (param->min && *param->min > val) {
-			if (clamp)
+			if (clamp) {
 				val = *param->min;
-			else
+				clamped = true;
+			} else {
 				return -EINVAL;
+			}
 		}
 		if (param->max && *param->max < val) {
-			if (clamp)
+			if (clamp) {
 				val = *param->max;
-			else
+				clamped = true;
+			} else {
 				return -EINVAL;
+			}
 		}
 		*valp = val;
+		if (clamped && param->name &&
+		   !(*param->flags & CTL_FLAGS_OOR_WARNED)) {
+			pr_warn(SYSCTL_WARN_MSG, param->name,
+				param->min ? *param->min : -INT_MAX,
+				param->max ? *param->max :  INT_MAX, val);
+			*param->flags |= CTL_FLAGS_OOR_WARNED;
+		}
 	} else {
 		int val = *valp;
 		if (val < 0) {
@@ -2556,6 +2574,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 		}
 	}
 	return 0;
+#undef SYSCTL_WARN_MSG
 }
 
 /**
@@ -2581,6 +2600,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
@@ -2601,21 +2621,27 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
  *  min: ptr to minimum allowable value
  *  max: ptr to maximum allowable value
  *  flags: ptr to flags
+ *  name: sysctl parameter name
  */
 struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
 	uint16_t *flags;
+	const char *name;
 };
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 					 unsigned int *valp,
 					 int write, void *data)
 {
+#define SYSCTL_WARN_MSG	\
+"Kernel parameter \"%s\" was set out of range [%u, %u], clamped to %u.\n"
+
 	struct do_proc_douintvec_minmax_conv_param *param = data;
 
 	if (write) {
 		unsigned int val = *lvalp;
+		bool clamped = false;
 		bool clamp = param->flags &&
 			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
 
@@ -2623,24 +2649,36 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 			return -EINVAL;
 
 		if (param->min && *param->min > val) {
-			if (clamp)
+			if (clamp) {
 				val = *param->min;
-			else
+				clamped = true;
+			} else {
 				return -ERANGE;
+			}
 		}
 		if (param->max && *param->max < val) {
-			if (clamp)
+			if (clamp) {
 				val = *param->max;
-			else
+				clamped = true;
+			} else {
 				return -ERANGE;
+			}
 		}
 		*valp = val;
+		if (clamped && param->name &&
+		   !(*param->flags & CTL_FLAGS_OOR_WARNED)) {
+			pr_warn(SYSCTL_WARN_MSG, param->name,
+				param->min ? *param->min : 0,
+				param->max ? *param->max : UINT_MAX, val);
+			*param->flags |= CTL_FLAGS_OOR_WARNED;
+		}
 	} else {
 		unsigned int val = *valp;
 		*lvalp = (unsigned long) val;
 	}
 
 	return 0;
+#undef SYSCTL_WARN_MSG
 }
 
 /**
@@ -2669,6 +2707,7 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
-- 
1.8.3.1
