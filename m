Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeEEBOP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:14:15 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50350 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeEEBON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:14:13 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, lizhijian@cn.fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/24] selftests: cpu-hotplug: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:07 -0600
Message-Id: <20180505011328.32078-3-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cpu-on-off-test is skipped because of unmet dependencies and/or
unsupported configuration, it returns 0 which is treated as a pass
by the Kselftest framework. This leads to false positive result even
when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index f3a8933c1275..bab13dd025a6 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 SYSFS=
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
 
 prerequisite()
 {
@@ -9,7 +11,7 @@ prerequisite()
 
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	taskset -p 01 $$
@@ -18,12 +20,12 @@ prerequisite()
 
 	if [ ! -d "$SYSFS" ]; then
 		echo $msg sysfs is not mounted >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if ! ls $SYSFS/devices/system/cpu/cpu* > /dev/null 2>&1; then
 		echo $msg cpu hotplug is not supported >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	echo "CPU online/offline summary:"
@@ -32,7 +34,7 @@ prerequisite()
 
 	if [[ "$online_cpus" = "$online_max" ]]; then
 		echo "$msg: since there is only one cpu: $online_cpus"
-		exit 0
+		exit $ksft_skip
 	fi
 
 	echo -e "\t Cpus in online state: $online_cpus"
@@ -237,12 +239,12 @@ prerequisite_extra()
 
 	if [ ! -d "$DEBUGFS" ]; then
 		echo $msg debugfs is not mounted >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if [ ! -d $NOTIFIER_ERR_INJECT_DIR ]; then
 		echo $msg cpu-notifier-error-inject module is not available >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
-- 
2.14.1
