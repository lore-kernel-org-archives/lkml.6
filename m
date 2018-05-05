Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeEEBR7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:17:59 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50641 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeEEBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:17:54 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com,
        marcandre.lureau@redhat.com, lizhijian@cn.fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] selftests: memfd: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:25 -0600
Message-Id: <20180505011328.32078-21-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memfd test is skipped because of unmet dependencies and/or unsupported
configuration, it returns non-zero value which is treated as a fail by the
Kselftest framework. This leads to false negative result even when the test
could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Added an explicit check for root user and return skip code.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/memfd/run_tests.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_tests.sh
index c2d41ed81b24..88dc206a69b7 100755
--- a/tools/testing/selftests/memfd/run_tests.sh
+++ b/tools/testing/selftests/memfd/run_tests.sh
@@ -1,6 +1,14 @@
 #!/bin/bash
 # please run as root
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if [ $UID != 0 ]; then
+	echo "Please run this test as root"
+	exit $ksft_skip
+fi
+
 #
 # Normal tests requiring no special resources
 #
@@ -33,7 +41,7 @@ if [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
 	echo $(( $hpages_needed + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
 	if [ $? -ne 0 ]; then
 		echo "Please run this test as root"
-		exit 1
+		exit $ksft_skip
 	fi
 	while read name size unit; do
 		if [ "$name" = "HugePages_Free:" ]; then
-- 
2.14.1
