Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEEBPj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:15:39 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50456 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeEEBPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:15:37 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, bamv2005@gmail.com, brgl@bgdev.pl
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 10/24] selftests: gpio: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:14 -0600
Message-Id: <20180505011328.32078-10-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gpio test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as
a fail by the Kselftest framework. This leads to false negative
result even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/gpio/gpio-mockup.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup.sh b/tools/testing/selftests/gpio/gpio-mockup.sh
index 183fb932edbd..7f35b9880485 100755
--- a/tools/testing/selftests/gpio/gpio-mockup.sh
+++ b/tools/testing/selftests/gpio/gpio-mockup.sh
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 #exit status
-#1: run as non-root user
+#1: Internal error
 #2: sysfs/debugfs not mount
 #3: insert module fail when gpio-mockup is a module.
-#4: other reason.
+#4: Skip test including run as non-root user.
+#5: other reason.
 
 SYSFS=
 GPIO_SYSFS=
@@ -15,6 +16,9 @@ GPIO_DEBUGFS=
 dev_type=
 module=
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 usage()
 {
 	echo "Usage:"
@@ -34,7 +38,7 @@ prerequisite()
 	msg="skip all tests:"
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		exit 1
+		exit $ksft_skip
 	fi
 	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
 	if [ ! -d "$SYSFS" ]; then
@@ -73,7 +77,7 @@ remove_module()
 die()
 {
 	remove_module
-	exit 4
+	exit 5
 }
 
 test_chips()
-- 
2.14.1
