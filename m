Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeCLUQL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:16:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932365AbeCLUQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:16:10 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/6] sysctl: Warn when a clamped sysctl parameter is set out of range
Date: Mon, 12 Mar 2018 16:15:41 -0400
Message-Id: <1520885744-1546-4-git-send-email-longman@redhat.com>
In-Reply-To: <1520885744-1546-1-git-send-email-longman@redhat.com>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even with clamped sysctl parameters, it is still not that straight
forward to figure out the exact range of those parameters. One may
try to write extreme parameter values to see if they get clamped.
To make it easier, a warning with the expected range will now be
printed into the kernel ring buffer when a clamped sysctl parameter
receives an out of range value.

The pr_warn_ratelimited() macro is used to limit the number of warning
messages that can be printed within a given period of time.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sysctl.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3d65f41..14aca92 100644
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
@@ -2514,31 +2515,48 @@ struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
 	unsigned int *flags;
+	const char *name;
 };
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+#define pr_fmt(fmt)	"sysctl: " fmt
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
+		if (clamped && param->name)
+			pr_warn_ratelimited("\"%s\" was set out of range [%d, %d], clamped to %d.\n",
+				param->name,
+				param->min ? *param->min : -INT_MAX,
+				param->max ? *param->max :  INT_MAX, val);
 	} else {
 		int val = *valp;
 		if (val < 0) {
@@ -2576,6 +2594,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
@@ -2586,6 +2605,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
  * @min: pointer to minimum allowable value
  * @max: pointer to maximum allowable value
  * @flags: pointer to flags
+ * @name: sysctl parameter name
  *
  * The do_proc_douintvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
@@ -2595,6 +2615,7 @@ struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
 	unsigned int *flags;
+	const char *name;
 };
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
@@ -2605,6 +2626,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 
 	if (write) {
 		unsigned int val = *lvalp;
+		bool clamped = false;
 		bool clamp = param->flags &&
 			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
 
@@ -2612,18 +2634,27 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
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
+		if (clamped && param->name)
+			pr_warn_ratelimited("\"%s\" was set out of range [%u, %u], clamped to %u.\n",
+				param->name,
+				param->min ? *param->min : 0,
+				param->max ? *param->max : UINT_MAX, val);
 	} else {
 		unsigned int val = *valp;
 		*lvalp = (unsigned long) val;
@@ -2659,6 +2690,7 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
-- 
1.8.3.1
