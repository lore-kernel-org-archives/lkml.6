Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEEBN7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:13:59 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50323 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeEEBN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:13:57 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, pintu.ping@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/24] selftests: android: ion: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:05 -0600
Message-Id: <20180505011328.32078-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ion test is skipped because of unmet dependencies and/or unsupported
configuration, it returns 0 which is treated as a pass by the Kselftest
framework. This leads to false positive result even when the test could
not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/android/ion/ion_test.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/android/ion/ion_test.sh b/tools/testing/selftests/android/ion/ion_test.sh
index a1aff506f5e6..69e676cfc94e 100755
--- a/tools/testing/selftests/android/ion/ion_test.sh
+++ b/tools/testing/selftests/android/ion/ion_test.sh
@@ -4,6 +4,9 @@ heapsize=4096
 TCID="ion_test.sh"
 errcode=0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 run_test()
 {
 	heaptype=$1
@@ -25,7 +28,7 @@ check_root()
 	uid=$(id -u)
 	if [ $uid -ne 0 ]; then
 		echo $TCID: must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
@@ -35,7 +38,7 @@ check_device()
 	if [ ! -e $DEVICE ]; then
 		echo $TCID: No $DEVICE device found >&2
 		echo $TCID: May be CONFIG_ION is not set >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
-- 
2.14.1
