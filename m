Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934947AbeCGUfu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:35:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934884AbeCGUfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:35:09 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] sysctl: Add a new ctl_table flag to show min/max range
Date: Wed,  7 Mar 2018 15:34:27 -0500
Message-Id: <1520454869-13871-4-git-send-email-longman@redhat.com>
In-Reply-To: <1520454869-13871-1-git-send-email-longman@redhat.com>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new ctl_table flag (CTL_FLAGS_SHOW_RANGE) is added which can be
used in the ctl_table definition for adding an auxillary read-only
sysctl parameter with the "_range" suffix to display the allowable
min/max range of that particular sysctl parameter.

This new flag has to be used with the new CTL_RESERVE_RANGES macro at
the end of the table definition to reserve table entries for showing
ranges. The number of table entries reserved must match the number
of table entries with the CTL_FLAGS_SHOW_RANGE flag set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sysctl.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index decb71e..ca64d66 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -132,6 +132,9 @@ struct ctl_table
  * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
  *	flexibly clamped to min/max range in case the user provided
  *	an incorrect value.
+ * @CTL_FLAGS_SHOW_RANGE: Set to indicate that an auxillary read-only
+ *	sysctl parameter with the "_range" suffix should be created to
+ *	report the allowable range of that parameter.
  * @CTL_FLAGS_OOR_WARNED: Set to indicate that an out of range warning
  * 	had been issued for that entry.
  *
@@ -150,11 +153,40 @@ struct ctl_table
 enum ctl_table_flags {
 	/* Statically set flags */
 	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
+	CTL_FLAGS_SHOW_RANGE		= BIT(1),
 
 	/* Flags set at run time */
 	CTL_FLAGS_OOR_WARNED		= BIT(8),
 };
 
+/**
+ * CTL_RESERVE_RANGES - reserve ctl_table entries for showing ranges
+ * @n - number of ctl_table entries to be reserved
+ *
+ * This CTL_RESERVE_RANGES() macro is used to reserve table entries
+ * when the CTL_FLAGS_SHOW_RANGE flag is used in the ctl_table. It has
+ * to be placed just before the ending null entry of the ctl_table
+ * definition. The number of reserved entries should match the number of
+ * ctl_table entries that have the CTL_FLAGS_SHOW_RANGE flag set.
+ * Otherwise, error will be returned if there is insufficient reserved
+ * entries in the registration process. A warning will be issued if
+ * there are more reserved entries than are really necessary.
+ *
+ * This macro currently supports up to 10 reserved ctl_table range entries.
+ */
+#define CTL_RESERVE_RANGES(n)	__CTL_RANGES_ ## n
+#define __CTL_RANGES_0
+#define __CTL_RANGES_1	{ .proc_handler = proc_show_minmax, },
+#define __CTL_RANGES_2	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_1
+#define __CTL_RANGES_3	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_2
+#define __CTL_RANGES_4	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_3
+#define __CTL_RANGES_5	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_4
+#define __CTL_RANGES_6	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_5
+#define __CTL_RANGES_7	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_6
+#define __CTL_RANGES_8	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_7
+#define __CTL_RANGES_9	{ .proc_handler = proc_show_minmax, }, __CTL_RANGES_8
+#define __CTL_RANGES_10 { .proc_handler = proc_show_minmax, }, __CTL_RANGES_9
+
 struct ctl_node {
 	struct rb_node node;
 	struct ctl_table_header *header;
-- 
1.8.3.1
