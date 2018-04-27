Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759405AbeD0VC6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:02:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759221AbeD0VAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:00:52 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 3/8] sysctl: Warn when a clamped sysctl parameter is set out of range
Date: Fri, 27 Apr 2018 17:00:33 -0400
Message-Id: <1524862838-8247-4-git-send-email-longman@redhat.com>
In-Reply-To: <1524862838-8247-1-git-send-email-longman@redhat.com>
References: <1524862838-8247-1-git-send-email-longman@redhat.com>
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
 kernel/sysctl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5b84c1d..76b2f1b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -17,6 +17,7 @@
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
 #include <linux/aio.h>
@@ -2516,6 +2517,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
  * @min: pointer to minimum allowable value
  * @max: pointer to maximum allowable value
  * @flags: pointer to flags
+ * @name: sysctl parameter name
  *
  * The do_proc_dointvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
@@ -2525,6 +2527,7 @@ struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
 	uint16_t *flags;
+	const char *name;
 };
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
@@ -2534,12 +2537,14 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 	struct do_proc_dointvec_minmax_conv_param *param = data;
 	if (write) {
 		int val = *negp ? -*lvalp : *lvalp;
+		bool clamped = false;
 		bool clamp = param->flags &&
 			   (*param->flags & CTL_FLAGS_CLAMP_SIGNED_RANGE);
 
 		if (param->min && *param->min > val) {
 			if (clamp) {
 				val = *param->min;
+				clamped = true;
 			} else {
 				return -EINVAL;
 			}
@@ -2547,11 +2552,17 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 		if (param->max && *param->max < val) {
 			if (clamp) {
 				val = *param->max;
+				clamped = true;
 			} else {
 				return -EINVAL;
 			}
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
@@ -2589,6 +2600,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
@@ -2599,6 +2611,7 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
  * @min: pointer to minimum allowable value
  * @max: pointer to maximum allowable value
  * @flags: pointer to flags
+ * @name: sysctl parameter name
  *
  * The do_proc_douintvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
@@ -2608,6 +2621,7 @@ struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
 	uint16_t *flags;
+	const char *name;
 };
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
@@ -2618,6 +2632,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 
 	if (write) {
 		unsigned int val = *lvalp;
+		bool clamped = false;
 		bool clamp = param->flags &&
 			   (*param->flags & CTL_FLAGS_CLAMP_UNSIGNED_RANGE);
 
@@ -2627,6 +2642,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 		if (param->min && *param->min > val) {
 			if (clamp) {
 				val = *param->min;
+				clamped = true;
 			} else {
 				return -ERANGE;
 			}
@@ -2634,11 +2650,17 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 		if (param->max && *param->max < val) {
 			if (clamp) {
 				val = *param->max;
+				clamped = true;
 			} else {
 				return -ERANGE;
 			}
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
@@ -2674,6 +2696,7 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
 		.flags = &table->flags,
+		.name  = table->procname,
 	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
@@ -2780,6 +2803,7 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 
 		if (write) {
 			bool neg;
+			bool clamped = false;
 
 			left -= proc_skip_spaces(&p);
 
@@ -2794,6 +2818,7 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 			if (min && val < *min) {
 				if (flags & CTL_FLAGS_CLAMP_UNSIGNED_RANGE) {
 					val = *min;
+					clamped = true;
 				} else {
 					continue;
 				}
@@ -2801,11 +2826,16 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 			if (max && val > *max) {
 				if (flags & CTL_FLAGS_CLAMP_UNSIGNED_RANGE) {
 					val = *max;
+					clamped = true;
 				} else {
 					continue;
 				}
 			}
 			*i = val;
+			if (clamped && table->procname)
+				pr_warn_ratelimited("\"%s\" was set out of range [%lu, %lu], clamped to %lu.\n",
+					table->procname, min ? *min : 0,
+					max ? *max : ULONG_MAX, val);
 		} else {
 			val = convdiv * (*i) / convmul;
 			if (!first) {
-- 
1.8.3.1
