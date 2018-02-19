Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeBSQy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:54:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753182AbeBSQyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:54:23 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] sysctl: Warn when a clamped sysctl parameter is set out of range
Date: Mon, 19 Feb 2018 11:53:50 -0500
Message-Id: <1519059231-2456-3-git-send-email-longman@redhat.com>
In-Reply-To: <1519059231-2456-1-git-send-email-longman@redhat.com>
References: <1519059231-2456-1-git-send-email-longman@redhat.com>
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
 kernel/sysctl.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f86c3a7..acdf4e8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2508,6 +2508,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
+	const char *name;
 	bool clamp;
 };
 
@@ -2516,21 +2517,33 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int write, void *data)
 {
 	struct do_proc_dointvec_minmax_conv_param *param = data;
+
 	if (write) {
 		int val = *negp ? -*lvalp : *lvalp;
+		bool clamped = false;
+
 		if (param->min && *param->min > val) {
-			if (param->clamp)
+			if (param->clamp) {
 				val = *param->min;
-			else
+				clamped = true;
+			} else {
 				return -EINVAL;
+			}
 		}
 		if (param->max && *param->max < val) {
-			if (param->clamp)
+			if (param->clamp) {
 				val = *param->max;
-			else
+				clamped = true;
+			} else {
 				return -EINVAL;
+			}
 		}
 		*valp = val;
+		if (clamped && param->name)
+			pr_warn("Kernel parameter \"%s\" was set out of range [%d, %d], clamped to %d.\n",
+				param->name,
+				param->min ? *param->min : -INT_MAX,
+				param->max ? *param->max :  INT_MAX, val);
 	} else {
 		int val = *valp;
 		if (val < 0) {
@@ -2593,6 +2606,7 @@ int proc_dointvec_clamp_minmax(struct ctl_table *table, int write,
 	struct do_proc_dointvec_minmax_conv_param param = {
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
+		.name = table->procname,
 		.clamp = true,
 	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
@@ -2602,6 +2616,7 @@ int proc_dointvec_clamp_minmax(struct ctl_table *table, int write,
 struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
+	const char *name;
 	bool clamp;
 };
 
@@ -2613,23 +2628,33 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 
 	if (write) {
 		unsigned int val = *lvalp;
+		bool clamped = false;
 
 		if (*lvalp > UINT_MAX)
 			return -EINVAL;
 
 		if (param->min && *param->min > val) {
-			if (param->clamp)
+			if (param->clamp) {
 				val = *param->min;
-			else
+				clamped = true;
+			} else {
 				return -ERANGE;
+			}
 		}
 		if (param->max && *param->max < val) {
-			if (param->clamp)
+			if (param->clamp) {
 				val = *param->max;
-			else
+				clamped = true;
+			} else {
 				return -ERANGE;
+			}
 		}
 		*valp = val;
+		if (clamped && param->name)
+			pr_warn("Kernel parameter \"%s\" was set out of range [%u, %u], clamped to %u.\n",
+				param->name,
+				param->min ? *param->min : 0,
+				param->max ? *param->max : UINT_MAX, val);
 	} else {
 		unsigned int val = *valp;
 		*lvalp = (unsigned long) val;
@@ -2693,6 +2718,7 @@ int proc_douintvec_clamp_minmax(struct ctl_table *table, int write,
 	struct do_proc_douintvec_minmax_conv_param param = {
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
+		.name = table->procname,
 		.clamp = true,
 	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
-- 
1.8.3.1
