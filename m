Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x224Xzwv0KKtmnSpwRw+pBPbl2lHH2BIwBB8uKW27/zNQNF8PLkjkj8x9dCOiRMQzf8fZscTM
ARC-Seal: i=1; a=rsa-sha256; t=1519440387; cv=none;
        d=google.com; s=arc-20160816;
        b=sYIoLALG4nrTM3xJ91jpdecQbEXPJi0vkqY7M0ZMAgVOWQBG3Z+2pS3s8NmwVJK0Jv
         1yv1d0hyuRxwYQmm5x5frcUreMrjLgfKzql+R5Hya2QpChayLHPPZivl1nzEgjBbEIZA
         0vYs3ipEHfMqGS7DXB1Unc1A/7Gt8fff0CI82I1wEhkLnggr65U0Wx5ZKqjKGjYmyjZw
         vUUMp9TSwSmG7lxfdwtcyEvIsdvCnhNpLkPtqPBDChyL2Us2UMOkAtCE3ebJQvG8MnFd
         MXN1k49tE6xtcORy2yykpF93gwU/e58k1zO1d5dQ7vidQhSPdX0RnXkgU1Tn3jCmGdPH
         9nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=8JntQjkonuu76CHnax0L3r8k4L+Own8LAwPyNyyjsoU=;
        b=UCf+pQx08Z0QhQ0L2eYuPm13+tmTWR9yZOgAOgn2ybUfBGeibKlnOJ2XrEfYuVjpsO
         QZLfallHshJ56yeFM9bA9PWfBQXOo/GZWreOqzAk+PlxyJkO+atFNDt0SPZwLN5AT4kw
         5qNLc4H0Thz5J4hrtKtpFlcqvlyxIX9TxLy3HiDCh17rvUI7IzttuI9AifbqmHx1pyxi
         UAHX1EwVe8LZerpxOn3FzaQ1Vgp0MvDeyV3TZN1YyKxCUfjL2QeQOPSgw4MzMw7sdEQB
         iP+xHBe1kQQTNoNSlfBfT/XjCBQX+nLyJf0CWL0GiWwX3Lbi2HVlE10b/0oWd7fFEwS1
         Pd6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D179A2183F
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
Date: Fri, 23 Feb 2018 18:46:13 -0800
Message-Id: <20180224024613.24078-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593248724184221948?=
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
2.16.2
