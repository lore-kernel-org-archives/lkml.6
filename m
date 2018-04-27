Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759334AbeD0VA5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:00:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759084AbeD0VAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v6 2/8] proc/sysctl: Provide additional ctl_table.flags checks
Date: Fri, 27 Apr 2018 17:00:32 -0400
Message-Id: <1524862838-8247-3-git-send-email-longman@redhat.com>
In-Reply-To: <1524862838-8247-1-git-send-email-longman@redhat.com>
References: <1524862838-8247-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking code is added to provide the following additional
ctl_table.flags checks:

 1) No unknown flag is allowed.
 2) Minimum of a range cannot be larger than the maximum value.
 3) The signed and unsigned flags are mutually exclusive.
 4) The proc_handler should be consistent with the signed or unsigned
    flags.

The separation of signed and unsigned flags helps to provide more
comprehensive checking than it would have been if there is only one
flag available.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/proc/proc_sysctl.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8989936..fb09454 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1092,6 +1092,64 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	return err;
 }
 
+/*
+ * This code assumes that only one integer value is allowed in an integer
+ * sysctl when one of the clamping flags is used. If that assumption is no
+ * longer true, we may need to add another flag to indicate the entry size.
+ */
+static int sysctl_check_flags(const char *path, struct ctl_table *table)
+{
+	int err = 0;
+
+	if ((table->flags & ~CTL_TABLE_FLAGS_ALL) ||
+	   ((table->flags & CTL_FLAGS_CLAMP_RANGE) == CTL_FLAGS_CLAMP_RANGE))
+		err = sysctl_err(path, table, "invalid flags");
+
+	if (table->flags & CTL_FLAGS_CLAMP_RANGE) {
+		int range_err = 0;
+		bool is_int = (table->maxlen == sizeof(int));
+
+		if (!is_int && (table->maxlen != sizeof(long))) {
+			range_err++;
+		} else if (!table->extra1 || !table->extra2) {
+			/* No min > max checking needed */
+		} else if (table->flags & CTL_FLAGS_CLAMP_UNSIGNED_RANGE) {
+			unsigned long min, max;
+
+			min = is_int ? *(unsigned int *)table->extra1
+				     : *(unsigned long *)table->extra1;
+			max = is_int ? *(unsigned int *)table->extra2
+				     : *(unsigned long *)table->extra2;
+			range_err += (min > max);
+		} else { /* table->flags & CTL_FLAGS_CLAMP_SIGNED_RANGE */
+
+			long min, max;
+
+			min = is_int ? *(int *)table->extra1
+				     : *(long *)table->extra1;
+			max = is_int ? *(int *)table->extra2
+				     : *(long *)table->extra2;
+			range_err += (min > max);
+		}
+
+		/*
+		 * proc_handler and flag consistency check.
+		 */
+		if (((table->proc_handler == proc_douintvec_minmax)   ||
+		     (table->proc_handler == proc_doulongvec_minmax)) &&
+		    !(table->flags & CTL_FLAGS_CLAMP_UNSIGNED_RANGE))
+			range_err++;
+
+		if ((table->proc_handler == proc_dointvec_minmax) &&
+		   !(table->flags & CTL_FLAGS_CLAMP_SIGNED_RANGE))
+			range_err++;
+
+		if (range_err)
+			err |= sysctl_err(path, table, "Invalid range");
+	}
+	return err;
+}
+
 static int sysctl_check_table(const char *path, struct ctl_table *table)
 {
 	int err = 0;
@@ -1111,6 +1169,8 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
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
