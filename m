Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeCPSQp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:16:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752959AbeCPSOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v5 6/9] test_sysctl: Add range clamping test
Date: Fri, 16 Mar 2018 14:13:47 -0400
Message-Id: <1521224030-2185-7-git-send-email-longman@redhat.com>
In-Reply-To: <1521224030-2185-1-git-send-email-longman@redhat.com>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a range clamping test to verify that the input value will be
clamped if it exceeds the builtin maximum or minimum value.

Below is the expected test run result:

Running test: sysctl_test_0006 - run #0
Checking range minimum clamping ... ok
Checking range maximum clamping ... ok
Checking range minimum clamping ... ok
Checking range maximum clamping ... ok

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/test_sysctl.c                        | 29 ++++++++++++++++++
 tools/testing/selftests/sysctl/sysctl.sh | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 3dd801c..7bb4cf7 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -38,12 +38,18 @@
 
 static int i_zero;
 static int i_one_hundred = 100;
+static int signed_min = -10;
+static int signed_max = 10;
+static unsigned int unsigned_min = 10;
+static unsigned int unsigned_max = 30;
 
 struct test_sysctl_data {
 	int int_0001;
 	int int_0002;
 	int int_0003[4];
+	int range_0001;
 
+	unsigned int urange_0001;
 	unsigned int uint_0001;
 
 	char string_0001[65];
@@ -58,6 +64,9 @@ struct test_sysctl_data {
 	.int_0003[2] = 2,
 	.int_0003[3] = 3,
 
+	.range_0001 = 0,
+	.urange_0001 = 20,
+
 	.uint_0001 = 314,
 
 	.string_0001 = "(none)",
@@ -102,6 +111,26 @@ struct test_sysctl_data {
 		.mode		= 0644,
 		.proc_handler	= proc_dostring,
 	},
+	{
+		.procname	= "range_0001",
+		.data		= &test_data.range_0001,
+		.maxlen		= sizeof(test_data.range_0001),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.flags		= CTL_FLAGS_CLAMP_RANGE_SIGNED,
+		.extra1		= &signed_min,
+		.extra2		= &signed_max,
+	},
+	{
+		.procname	= "urange_0001",
+		.data		= &test_data.urange_0001,
+		.maxlen		= sizeof(test_data.urange_0001),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.flags		= CTL_FLAGS_CLAMP_RANGE_UNSIGNED,
+		.extra1		= &unsigned_min,
+		.extra2		= &unsigned_max,
+	},
 	{ }
 };
 
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ec232c3..1aa1bba 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -34,6 +34,7 @@ ALL_TESTS="$ALL_TESTS 0002:1:1"
 ALL_TESTS="$ALL_TESTS 0003:1:1"
 ALL_TESTS="$ALL_TESTS 0004:1:1"
 ALL_TESTS="$ALL_TESTS 0005:3:1"
+ALL_TESTS="$ALL_TESTS 0006:1:1"
 
 test_modprobe()
 {
@@ -543,6 +544,38 @@ run_stringtests()
 	test_rc
 }
 
+# TARGET, RANGE_MIN & RANGE_MAX need to be defined before running test.
+run_range_clamping_test()
+{
+	rc=0
+
+	echo -n "Checking range minimum clamping ... "
+	VAL=$((RANGE_MIN - 1))
+	echo -n $VAL > "${TARGET}" 2> /dev/null
+	EXITVAL=$?
+	NEWVAL=$(cat "${TARGET}")
+	if [[ $EXITVAL -ne 0 || $NEWVAL -ne $RANGE_MIN ]]; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "ok"
+	fi
+
+	echo -n "Checking range maximum clamping ... "
+	VAL=$((RANGE_MAX + 1))
+	echo -n $VAL > "${TARGET}" 2> /dev/null
+	EXITVAL=$?
+	NEWVAL=$(cat "${TARGET}")
+	if [[ $EXITVAL -ne 0 || $NEWVAL -ne $RANGE_MAX ]]; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "ok"
+	fi
+
+	test_rc
+}
+
 sysctl_test_0001()
 {
 	TARGET="${SYSCTL}/int_0001"
@@ -600,6 +633,25 @@ sysctl_test_0005()
 	run_limit_digit_int_array
 }
 
+sysctl_test_0006()
+{
+	TARGET="${SYSCTL}/range_0001"
+	ORIG=$(cat "${TARGET}")
+	RANGE_MIN=-10
+	RANGE_MAX=10
+
+	run_range_clamping_test
+	set_orig
+
+	TARGET="${SYSCTL}/urange_0001"
+	ORIG=$(cat "${TARGET}")
+	RANGE_MIN=10
+	RANGE_MAX=30
+
+	run_range_clamping_test
+	set_orig
+}
+
 list_tests()
 {
 	echo "Test ID list:"
-- 
1.8.3.1
