Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeCLUQ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:16:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932364AbeCLUQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:16:09 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/6] proc/sysctl: Check for invalid flags bits
Date: Mon, 12 Mar 2018 16:15:40 -0400
Message-Id: <1520885744-1546-3-git-send-email-longman@redhat.com>
In-Reply-To: <1520885744-1546-1-git-send-email-longman@redhat.com>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking code is added to check for invalid flags in the ctl_table
and return error if an unknown flag is used.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/proc/proc_sysctl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 493c975..67c0c82 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1092,6 +1092,16 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	return err;
 }
 
+static int sysctl_check_flags(const char *path, struct ctl_table *table)
+{
+	int err = 0;
+
+	if (table->flags & ~CTL_TABLE_FLAGS_ALL)
+		err = sysctl_err(path, table, "invalid flags");
+
+	return err;
+}
+
 static int sysctl_check_table(const char *path, struct ctl_table *table)
 {
 	int err = 0;
@@ -1111,6 +1121,8 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 		    (table->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
 			if (!table->data)
 				err |= sysctl_err(path, table, "No data");
+			if (table->flags)
+				err |= sysctl_check_flags(path, table);
 			if (!table->maxlen)
 				err |= sysctl_err(path, table, "No maxlen");
 			else
-- 
1.8.3.1
