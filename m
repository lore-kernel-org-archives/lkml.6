Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x227E6Rni4p0FUPh39h3N9XyKRdkcAUFmJF/W8S8kafS0TLdopPFA9Xfw8kD3AaJQHP8nK0Ms
ARC-Seal: i=1; a=rsa-sha256; t=1518568927; cv=none;
        d=google.com; s=arc-20160816;
        b=HSLydyuVd3HalKxETHjoaWDX6nlwFGsGt5SnHjOw1Fgk/wqs+bcgsfdUqBWTX5dUaK
         2AldnNTmBrUHki2hDMXOeqyd6ujOhh5fJR4HZUiua8nxwvio3tS+mqFVGouXAH0Go7PY
         eiLLIC8IiE2tNnhQPVjPNSuaG+C1gHU0wpaP4h/dgKZ2mtnxd2h6A/bm4lM90rBq5duf
         PtvVFVw7vf6s7cxT0PBvwi9s7E1jygX1zKZ87PJT3RWvMC4p+QlQ6sv7wwddfGbUm3N1
         65yx2Ugzlz789Zn1cCtMXLWKraQVewYl9bc0/52iUe7pO+3PloY5PXjkcxe2i4X3Les4
         2giQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=C6kCucXahcncf4UX6AFp3OduOCOQzwVEKscV1o1i1xI=;
        b=J1VUrf6TdRikotZK+kKS72WmaNFsaijoBxb7EJpSx0MhwqBCsoRL+MBJFD4nzq93WW
         Fog2HCyY6erIxpM2w1TFAgz21mCtsm0VYjSx39Benxk5WqJsRGKLzx2oj3oOw/MRnzXM
         9yTT7jD5yWJyBxdFSvb7PfYuUhHN81OiW5LXi6fORmrWZ/h1Oll21fOzg/gZ7ilGjm8V
         DzcxbWASktEgCE4jv4wVz+kVNLgiL+STxkHmNmEYmf7rZsm60HXUyXgo7QZy5W5tvGLO
         zhV2D/cPKs8hXGUMYKuYWPpU+5mwT073dzKEGAqf5yOK79aKHsxiC9LBmKXTqIob0PYk
         V8qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE4521851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 11/11] test_firmware: test three firmware kernel configs using a proc knob
Date: Tue, 13 Feb 2018 16:41:48 -0800
Message-Id: <20180214004148.14452-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334931597223478?=
X-GMAIL-MSGID: =?utf-8?q?1592334931597223478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since we now have knobs to twiddle what used to be set on kernel
configurations we can build one base kernel configuration and modify
behaviour to mimic such kernel configurations to test them.

Provided you build a kernel with:

CONFIG_TEST_FIRMWARE=y
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y

We should now be able test all possible kernel configurations
when FW_LOADER=y. Note that when FW_LOADER=m we just don't provide
the built-in functionality of the built-in firmware.

If you're on an old kernel and either don't have /proc/config.gz
(CONFIG_IKCONFIG_PROC) or haven't enabled CONFIG_FW_LOADER_USER_HELPER
we cannot run these dynamic tests, so just run both scripts just
as we used to before making blunt assumptions about your setup
and requirements exactly as we did before.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/Makefile        |  2 +-
 tools/testing/selftests/firmware/fw_lib.sh       | 53 +++++++++++++++++++
 tools/testing/selftests/firmware/fw_run_tests.sh | 67 ++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/firmware/fw_run_tests.sh

diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
index 1894d625af2d..826f38d5dd19 100644
--- a/tools/testing/selftests/firmware/Makefile
+++ b/tools/testing/selftests/firmware/Makefile
@@ -3,7 +3,7 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := fw_filesystem.sh fw_fallback.sh
+TEST_PROGS := fw_run_tests.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 0702dbf0f06b..3362a2aac40e 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -47,6 +47,34 @@ check_setup()
 {
 	HAS_FW_LOADER_USER_HELPER=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)
 	HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
+	PROC_FW_IGNORE_SYSFS_FALLBACK="N"
+	PROC_FW_FORCE_SYSFS_FALLBACK="N"
+
+	if [ -z $PROC_SYS_DIR ]; then
+		PROC_SYS_DIR="/proc/sys/kernel"
+	fi
+
+	FW_PROC="${PROC_SYS_DIR}/firmware_config"
+	FW_FORCE_SYSFS_FALLBACK="$FW_PROC/force_sysfs_fallback"
+	FW_IGNORE_SYSFS_FALLBACK="$FW_PROC/ignore_sysfs_fallback"
+
+	if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
+		PROC_FW_FORCE_SYSFS_FALLBACK=$(cat $FW_FORCE_SYSFS_FALLBACK)
+	fi
+
+	if [ -f $FW_IGNORE_SYSFS_FALLBACK ]; then
+		PROC_FW_IGNORE_SYSFS_FALLBACK=$(cat $FW_IGNORE_SYSFS_FALLBACK)
+	fi
+
+	if [ "$PROC_FW_IGNORE_SYSFS_FALLBACK" = "1" ]; then
+		HAS_FW_LOADER_USER_HELPER_FALLBACK="no"
+		HAS_FW_LOADER_USER_HELPER="no"
+	fi
+
+	if [ "$PROC_FW_FORCE_SYSFS_FALLBACK" = "1" ]; then
+		HAS_FW_LOADER_USER_HELPER="yes"
+		HAS_FW_LOADER_USER_HELPER_FALLBACK="yes"
+	fi
 
 	if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
 	       OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
@@ -76,6 +104,30 @@ setup_tmp_file()
 	fi
 }
 
+proc_set_force_sysfs_fallback()
+{
+	if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
+		echo -n $1 > $FW_FORCE_SYSFS_FALLBACK
+		PROC_FW_FORCE_SYSFS_FALLBACK=$(cat $FW_FORCE_SYSFS_FALLBACK)
+		check_setup
+	fi
+}
+
+proc_set_ignore_sysfs_fallback()
+{
+	if [ -f $FW_IGNORE_SYSFS_FALLBACK ]; then
+		echo -n $1 > $FW_IGNORE_SYSFS_FALLBACK
+		PROC_FW_IGNORE_SYSFS_FALLBACK=$(cat $FW_IGNORE_SYSFS_FALLBACK)
+		check_setup
+	fi
+}
+
+proc_restore_defaults()
+{
+	proc_set_force_sysfs_fallback 0
+	proc_set_ignore_sysfs_fallback 0
+}
+
 test_finish()
 {
 	if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
@@ -93,6 +145,7 @@ test_finish()
 	if [ -d $FWPATH ]; then
 		rm -rf "$FWPATH"
 	fi
+	proc_restore_defaults
 }
 
 kconfig_has()
diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
new file mode 100755
index 000000000000..a12b5809ad8b
--- /dev/null
+++ b/tools/testing/selftests/firmware/fw_run_tests.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This runs all known tests across all known possible configurations we could
+# emulate in one run.
+
+set -e
+
+TEST_DIR=$(dirname $0)
+source $TEST_DIR/fw_lib.sh
+
+run_tests()
+{
+	$TEST_DIR/fw_filesystem.sh
+	$TEST_DIR/fw_fallback.sh
+}
+
+run_test_config_0001()
+{
+	echo "-----------------------------------------------------"
+	echo "Running kernel configuration test 1 -- rare"
+	echo "Emulates:"
+	echo "CONFIG_FW_LOADER=y"
+	echo "CONFIG_FW_LOADER_USER_HELPER=n"
+	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
+	proc_set_force_sysfs_fallback 0
+	proc_set_ignore_sysfs_fallback 1
+	run_tests
+}
+
+run_test_config_0002()
+{
+	echo "-----------------------------------------------------"
+	echo "Running kernel configuration test 2 -- distro"
+	echo "Emulates:"
+	echo "CONFIG_FW_LOADER=y"
+	echo "CONFIG_FW_LOADER_USER_HELPER=y"
+	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
+	proc_set_force_sysfs_fallback 0
+	proc_set_ignore_sysfs_fallback 0
+	run_tests
+}
+
+run_test_config_0003()
+{
+	echo "-----------------------------------------------------"
+	echo "Running kernel configuration test 3 -- android"
+	echo "Emulates:"
+	echo "CONFIG_FW_LOADER=y"
+	echo "CONFIG_FW_LOADER_USER_HELPER=y"
+	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y"
+	proc_set_force_sysfs_fallback 1
+	proc_set_ignore_sysfs_fallback 0
+	run_tests
+}
+
+check_mods
+check_setup
+
+if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
+	run_test_config_0001
+	run_test_config_0002
+	run_test_config_0003
+else
+	echo "Running basic kernel configuration, working with your config"
+	run_test
+fi
-- 
2.16.1
