Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeCLUQ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:16:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932441AbeCLUQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:16:10 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 6/6] test_sysctl: Add range clamping test
Date: Mon, 12 Mar 2018 16:15:44 -0400
Message-Id: <1520885744-1546-7-git-send-email-longman@redhat.com>
In-Reply-To: <1520885744-1546-1-git-send-email-longman@redhat.com>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a range clamping test for the msgmni sysctl parameter to verify
that the input value will be clamped if it exceeds the builtin maximum
or minimum value.

Below is the expected test run result:

Running test: sysctl_test_0006 - run #0
Checking range minimum clamping ... ok
Checking range maximum clamping ... ok

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ec232c3..fbf9d73 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -34,6 +34,7 @@ ALL_TESTS="$ALL_TESTS 0002:1:1"
 ALL_TESTS="$ALL_TESTS 0003:1:1"
 ALL_TESTS="$ALL_TESTS 0004:1:1"
 ALL_TESTS="$ALL_TESTS 0005:3:1"
+ALL_TESTS="$ALL_TESTS 0006:1:1"
 
 test_modprobe()
 {
@@ -62,6 +63,9 @@ function allow_user_defaults()
 	if [ -z $WRITES_STRICT ]; then
 		WRITES_STRICT="${PROD_SYSCTL}/kernel/sysctl_writes_strict"
 	fi
+	if [ -z $MSGMNI ]; then
+		MSGMNI="${PROD_SYSCTL}/kernel/msgmni"
+	fi
 }
 
 function check_production_sysctl_writes_strict()
@@ -543,6 +547,34 @@ run_stringtests()
 	test_rc
 }
 
+# TARGET, BEYOND_MIN & BEYOND_MAX need to be defined before running test.
+run_range_clamping_test()
+{
+	echo -n "Checking range minimum clamping ... "
+	echo $BEYOND_MIN > "$TARGET" > /dev/null 2>&1
+	EXITVAL=$?
+	NEWVAL=$(cat "$TARGET")
+	if [[ $EXITVAL -ne 0 || $NEWVAL -le $BEYOND_MIN ]]; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "ok"
+	fi
+
+	echo -n "Checking range maximum clamping ... "
+	echo $BEYOND_MAX > "$TARGET" > /dev/null 2>&1
+	EXITVAL=$?
+	NEWVAL=$(cat "$TARGET")
+	if [[ $EXITVAL -ne 0 || $NEWVAL -ge $BEYOND_MAX ]]; then
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
@@ -600,6 +632,17 @@ sysctl_test_0005()
 	run_limit_digit_int_array
 }
 
+sysctl_test_0006()
+{
+	TARGET="${MSGMNI}"
+	ORIG=$(cat "${TARGET}")
+	BEYOND_MIN=-1
+	BEYOND_MAX=1000000000
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
