Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934901AbeCGUgz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:36:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934803AbeCGUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:35:08 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/5] sysctl: Clarify how the ctl_table.flags should be set
Date: Wed,  7 Mar 2018 15:34:25 -0500
Message-Id: <1520454869-13871-2-git-send-email-longman@redhat.com>
In-Reply-To: <1520454869-13871-1-git-send-email-longman@redhat.com>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional comments are added to clarify how the ctl_table.flags
field should be set as well as precaution on what needs to be done
when additional flags are defined in the future.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sysctl.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 3db57af..bc09361 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -125,7 +125,7 @@ struct ctl_table
 } __randomize_layout;
 
 /**
- * enum ctl_table_flags - flags for the ctl table
+ * enum ctl_table_flags - flags for the ctl table (struct ctl_table.flags)
  *
  * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
  *	flexibly clamped to min/max range in case the user provided
@@ -134,10 +134,23 @@ struct ctl_table
  * 	had been issued for that entry.
  *
  * At most 16 different flags will be allowed.
+ *
+ * The flags can be set in two different ways. They can either be
+ * statically set at definition time or dynamically set at run time.
+ *
+ * Currently, only the CTL_FLAGS_OOR_WARNED flag is set at run time.
+ * No locking or atomic access to set @CTL_FLAGS_OOR_WARNED is needed
+ * in the current use case. If similar dynamic flags are defined in the
+ * future, we may need to revisit again to see if atomic access or
+ * locking is needed to prevent lost changes due to concurrent updates
+ * to the flags field.
  */
 enum ctl_table_flags {
+	/* Statically set flags */
 	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
-	CTL_FLAGS_OOR_WARNED		= BIT(1),
+
+	/* Flags set at run time */
+	CTL_FLAGS_OOR_WARNED		= BIT(8),
 };
 
 struct ctl_node {
-- 
1.8.3.1
