Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZqrYoDNnSStXmpvhYDojwaR1Wtl0ZzU03YUb7XH/AAW5XAoSWy9emz6qwd5s1tWbET2p1G2
ARC-Seal: i=1; a=rsa-sha256; t=1525482910; cv=none;
        d=google.com; s=arc-20160816;
        b=vxT4noDaAKZUFGWt/4JWd+MJCwh7tSNJicZYMd6dpv+CC0PTPjlYc8wCSIMliJI8D5
         jOoX6EVRK1fpGzebZbEU8C2PUuMAFOX5x74cMPeY7SFFSBMlYzL+pPKoDHm7055ob6wD
         iUz4AG/2KPfenT9CzxqX7iuaUCGnnXYYIDgA8VP+0eKZLdMft5tVDWisiGHcbegmRWW3
         QcWzKhe04TsMz2TUQmDcuqMZnEGt5z6IzErksxYcL/P+BRPzEPfsC0www8c4yLOzb5zz
         E4u1T/pTKZx+s2k1cfTBBTOEB9MRxlut+ofCNVwCEuEhSS3Y7QqQEQGWcYRYOMUzYoIC
         Q3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jXmS3U3AbFhq6VYamznmqm+GmuE+DTvY0VpmteHP/4o=;
        b=TnjjXAqEanBXA6zVUAZFIbB0rHOvenz6GvLzYLwh1upwLRGx6VGw7FqM+6z3MkAG3A
         kO7feWan/quvCcJRrZk2fTYoohdgme5yvbQinFqVKl9ugyxsugCdph7BMBPHgLtPRRjw
         /DUu/4yCKswz6pLyjp7c15fIQ43VJ39W/lN4B6rAdkXBRLFGpXpZ64pCUCgsACrHavl5
         XP4SV0rotUC38TQbg8t6FrFOqp8dVmHTYiC0mU9vvAHpehxVBPf2JSGq1rMMi+lXsxu6
         FY4zfl94iRS2AOT9Xb4PZT/YPKu4IlMKRO2Bn4ozQRGmYbiauO0XOm1aavXzrRrx51zV
         wBQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	keescook@chromium.org,
	tglx@linutronix.de,
	sumit.semwal@linaro.org,
	amit.pundir@linaro.org,
	ben.hutchings@codethink.co.uk
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] selftests: firmware: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:12 -0600
Message-Id: <20180505011328.32078-8-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599584767566317189?=
X-GMAIL-MSGID: =?utf-8?q?1599584767566317189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When firmware test(s) get skipped because of unmet dependencies and/or
unsupported configuration, it returns 0 which is treated as a pass
by the Kselftest framework. This leads to false positive result even
when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/firmware/fw_fallback.sh   | 4 ++--
 tools/testing/selftests/firmware/fw_filesystem.sh | 4 +++-
 tools/testing/selftests/firmware/fw_lib.sh        | 7 +++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index 8e2e34a2ca69..70d18be46af5 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -74,7 +74,7 @@ load_fw_custom()
 {
 	if [ ! -e "$DIR"/trigger_custom_fallback ]; then
 		echo "$0: custom fallback trigger not present, ignoring test" >&2
-		return 1
+		exit $ksft_skip
 	fi
 
 	local name="$1"
@@ -107,7 +107,7 @@ load_fw_custom_cancel()
 {
 	if [ ! -e "$DIR"/trigger_custom_fallback ]; then
 		echo "$0: canceling custom fallback trigger not present, ignoring test" >&2
-		return 1
+		exit $ksft_skip
 	fi
 
 	local name="$1"
diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index 6452d2129cd9..a4320c4b44dc 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -30,6 +30,7 @@ fi
 
 if [ ! -e "$DIR"/trigger_async_request ]; then
 	echo "$0: empty filename: async trigger not present, ignoring test" >&2
+	exit $ksft_skip
 else
 	if printf '\000' >"$DIR"/trigger_async_request 2> /dev/null; then
 		echo "$0: empty filename should not succeed (async)" >&2
@@ -69,6 +70,7 @@ fi
 # Try the asynchronous version too
 if [ ! -e "$DIR"/trigger_async_request ]; then
 	echo "$0: firmware loading: async trigger not present, ignoring test" >&2
+	exit $ksft_skip
 else
 	if ! echo -n "$NAME" >"$DIR"/trigger_async_request ; then
 		echo "$0: could not trigger async request" >&2
@@ -89,7 +91,7 @@ test_config_present()
 {
 	if [ ! -f $DIR/reset ]; then
 		echo "Configuration triggers not present, ignoring test"
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 962d7f4ac627..6c5f1b2ffb74 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -9,11 +9,14 @@ DIR=/sys/devices/virtual/misc/test_firmware
 PROC_CONFIG="/proc/config.gz"
 TEST_DIR=$(dirname $0)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 print_reqs_exit()
 {
 	echo "You must have the following enabled in your kernel:" >&2
 	cat $TEST_DIR/config >&2
-	exit 1
+	exit $ksft_skip
 }
 
 test_modprobe()
@@ -88,7 +91,7 @@ verify_reqs()
 	if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
 		if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
 			echo "usermode helper disabled so ignoring test"
-			exit 0
+			exit $ksft_skip
 		fi
 	fi
 }
-- 
2.14.1
