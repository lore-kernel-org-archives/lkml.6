Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbeEGXBx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:01:53 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:54014 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeEGXBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:01:52 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com,
        marcandre.lureau@redhat.com, lizhijian@cn.fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/24] selftests: memfd: return Kselftest Skip code for skipped tests
Date: Mon,  7 May 2018 17:01:16 -0600
Message-Id: <20180507230116.27652-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memfd test is skipped because of unmet dependencies and/or unsupported
configuration, it returns non-zero value which is treated as a fail by the
Kselftest framework. This leads to false negative result even when the test
could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Added an explicit check for root user at the start of memfd hugetlbfs test
and return skip code if a non-root user attempts to run it.

In addition, return skip code when not enough huge pages are available to
run the test.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---

Changes since v1:
-- addressed review comments on v1
-- Fixed a regression in v1 that changed the behavior to require root
   for all tests not just the hugetlbfs test.

 tools/testing/selftests/memfd/run_tests.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_tests.sh
index c2d41ed81b24..2013f195e623 100755
--- a/tools/testing/selftests/memfd/run_tests.sh
+++ b/tools/testing/selftests/memfd/run_tests.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # please run as root
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 #
 # Normal tests requiring no special resources
 #
@@ -29,12 +32,13 @@ if [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
 	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
 	hpages_needed=`expr $hpages_test - $freepgs`
 
+	if [ $UID != 0 ]; then
+		echo "Please run memfd with hugetlbfs test as root"
+		exit $ksft_skip
+	fi
+
 	echo 3 > /proc/sys/vm/drop_caches
 	echo $(( $hpages_needed + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
-	if [ $? -ne 0 ]; then
-		echo "Please run this test as root"
-		exit 1
-	fi
 	while read name size unit; do
 		if [ "$name" = "HugePages_Free:" ]; then
 			freepgs=$size
@@ -53,7 +57,7 @@ if [ $freepgs -lt $hpages_test ]; then
 	fi
 	printf "Not enough huge pages available (%d < %d)\n" \
 		$freepgs $needpgs
-	exit 1
+	exit $ksft_skip
 fi
 
 #
-- 
2.14.1
