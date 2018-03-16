Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeCPSQo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:16:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753008AbeCPSOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:14:35 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 7/9] test_sysctl: Add ctl_table registration failure test
Date: Fri, 16 Mar 2018 14:13:48 -0400
Message-Id: <1521224030-2185-8-git-send-email-longman@redhat.com>
In-Reply-To: <1521224030-2185-1-git-send-email-longman@redhat.com>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrect sysctl tables are constructed and fed to the
register_sysctl_table() function in the test_sysctl kernel module.
The function is supposed to fail the registration of those tables or
an error will be printed if no failure is returned.

The registration failures will cause other warning and error messages
to be printed into the dmesg log, though.

A new test is also added to the sysctl.sh to look for those failure
messages in the dmesg log to see if anything unexpeced happens.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/test_sysctl.c                        | 41 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/sysctl/sysctl.sh | 15 ++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 7bb4cf7..14853d5 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -154,13 +154,54 @@ struct test_sysctl_data {
 	{ }
 };
 
+static struct ctl_table fail_sysctl_table0[] = {
+	{
+		.procname	= "failed_sysctl0",
+		.data		= &test_data.range_0001,
+		.maxlen		= sizeof(test_data.range_0001),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.flags		= CTL_FLAGS_CLAMP_RANGE_SIGNED,
+		.extra1		= &signed_max,
+		.extra2		= &signed_min,
+	},
+	{ }
+};
+
+static struct ctl_table fail_sysctl_root_table[] = {
+	{
+		.procname	= "debug",
+		.maxlen		= 0,
+		.mode		= 0555,
+	},
+	{ }
+};
+
+static struct ctl_table *fail_tables[] = {
+	fail_sysctl_table0, NULL,
+};
+
 static struct ctl_table_header *test_sysctl_header;
 
 static int __init test_sysctl_init(void)
 {
+	struct ctl_table_header *fail_sysctl_header;
+	int i;
+
 	test_sysctl_header = register_sysctl_table(test_sysctl_root_table);
 	if (!test_sysctl_header)
 		return -ENOMEM;
+
+	for (i = 0; fail_tables[i]; i++) {
+		fail_sysctl_root_table[0].child = fail_tables[i];
+		fail_sysctl_header = register_sysctl_table(fail_sysctl_root_table);
+		if (fail_sysctl_header) {
+			pr_err("fail_tables[%d] registration check failed!\n", i);
+			unregister_sysctl_table(fail_sysctl_header);
+			break;
+		}
+	}
+
 	return 0;
 }
 late_initcall(test_sysctl_init);
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 1aa1bba..23acdee 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -35,6 +35,7 @@ ALL_TESTS="$ALL_TESTS 0003:1:1"
 ALL_TESTS="$ALL_TESTS 0004:1:1"
 ALL_TESTS="$ALL_TESTS 0005:3:1"
 ALL_TESTS="$ALL_TESTS 0006:1:1"
+ALL_TESTS="$ALL_TESTS 0007:1:1"
 
 test_modprobe()
 {
@@ -652,6 +653,20 @@ sysctl_test_0006()
 	set_orig
 }
 
+sysctl_test_0007()
+{
+	echo "Checking test_sysctl module registration failure test ..."
+	dmesg | grep "sysctl.*fail_tables.*failed"
+	if [[ $? -eq 0 ]]; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "ok"
+	fi
+
+	test_rc
+}
+
 list_tests()
 {
 	echo "Test ID list:"
-- 
1.8.3.1
