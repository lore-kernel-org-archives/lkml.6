Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033656AbeCARqK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:46:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033529AbeCARoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:44:09 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 4/6] sysctl: Warn when a clamped sysctl parameter is set out of range
Date: Thu,  1 Mar 2018 12:43:38 -0500
Message-Id: <1519926220-7453-5-git-send-email-longman@redhat.com>
In-Reply-To: <1519926220-7453-1-git-send-email-longman@redhat.com>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
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
 include/linux/sysctl.h |  3 +++
 kernel/sysctl.c        | 52 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 448aa72..3db57af 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -130,11 +130,14 @@ struct ctl_table
  * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
  *	flexibly clamped to min/max range in case the user provided
  *	an incorrect value.
+ * @CTL_FLAGS_OOR_WARNED: Set to indicate that an out of range warning
+ * 	had been issued for that entry.
  *
  * At most 16 different flags will be allowed.
  */
 enum ctl_table_flags {
 	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
+	CTL_FLAGS_OOR_WARNED		= BIT(1),
 };
 
 struct ctl_node {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index af351ed..6c68e77 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2505,6 +2505,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
  * @min: pointer to minimum allowable value
  * @max: pointer to maximum allowable value
  * @flags: pointer to flags
+ * @name: sysctl parameter name
  *
  * The do_proc_dointvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
@@ -2514,31 +2515,50 @@ struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
 	uint16_t *flags;
+	const char *name;
 };
 
+/* Out of range warning message */
+#define proc_ctl_warn(type, ...)				  \
+	pr_warn("Kernel parameter \"%s\" was set out of range [%" \
+	#type ", %" #type "], clamped to %" #type ".\n", __VA_ARGS__)
+
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int *valp,
 					int write, void *data)
 {
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
+			proc_ctl_warn(d, param->name,
+				param->min ? *param->min : -INT_MAX,
+				param->max ? *param->max :  INT_MAX, val);
+			*param->flags |= CTL_FLAGS_OOR_WARNED;
+		}
 	} else {
 		int val = *valp;
 		if (val < 0) {
@@ -2576,6 +2596,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
@@ -2586,6 +2607,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
  * @min: pointer to minimum allowable value
  * @max: pointer to maximum allowable value
  * @flags: pointer to flags
+ * @name: sysctl parameter name
  *
  * The do_proc_douintvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
@@ -2595,6 +2617,7 @@ struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
 	uint16_t *flags;
+	const char *name;
 };
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
@@ -2605,6 +2628,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 
 	if (write) {
 		unsigned int val = *lvalp;
+		bool clamped = false;
 		bool clamp = param->flags &&
 			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
 
@@ -2612,18 +2636,29 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
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
+			proc_ctl_warn(u, param->name,
+				param->min ? *param->min : 0,
+				param->max ? *param->max : UINT_MAX, val);
+			*param->flags |= CTL_FLAGS_OOR_WARNED;
+		}
 	} else {
 		unsigned int val = *valp;
 		*lvalp = (unsigned long) val;
@@ -2659,6 +2694,7 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
-- 
1.8.3.1
