Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELvNf7qX/S9PUEDh+ySBJEBQytoqGJzKU82jsiqgCC3wZvAlprSOHuK5691o6uQsJ3Un+6JN
ARC-Seal: i=1; a=rsa-sha256; t=1520691334; cv=none;
        d=google.com; s=arc-20160816;
        b=NQYTMcMy2yXSITN5qyV09+5sN+m51RdGjaCZ6Jk5B+Xjv97SX+FLjiMVAmrwsO0mE8
         wumv063iDfd4bvv6nn9a662uJSCY2dbqcKHVaJ0bCGKyb9CMxqgRq3G63OKDUjeCGWnr
         msg2vz2M6FSkYC9dYwLAjub1jAvfaOU6DhAushNRXbT64cif4qDLkKYxCsoTrMi16glg
         7/oL/WoI4ol2MUQMEKVDZemVR5qufKHXuFfRo6J6ud3coxoBNsuV2k8kjU7am7b0blvg
         2c/QcRonzD7EMVHvKQMtrlve6iPIM0i4LAKuvtYF7SEZfw+fPBaeGP85Wvjlv/i5GO1K
         xHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=JfIUTL8GktIRH24kjSM+HhHQHbD2Oxl8l8X6UOpnayA=;
        b=lB0TnUq9gUq/sA8Z76PDe4bm0I0nCpkci3Wu2YiDgl9i/GpL/+Ch25LOD8WuSBAWHn
         S1pyJP3p0mDtNEzqElHbKcDvk3qCn7TdbcW4T0a8jIQBtpLnD3nAYoRsWyqI3nKiJwGJ
         0M0c8wpeP5PUM1yMTLKqAB0w5h1o9htFJgnGUC7Qab++61tVwGmahLMCUv0tpM391Dmz
         dqrZC++b1qXi/o0+jysiHh+4PkNwTEXxqVgBCuJPWlUR0LElR+MVZ9q7sBqef+3mIhfP
         LhcjWwQXUNRhezxvm/0SA2kxw+sOvFYLWDZW9VvCZRL8KpMRwDMhc8+N3+ijvHwYzaJU
         Wx+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA51D217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	cantabile.desu@gmail.com,
	kubakici@wp.pl,
	linux-wireless@vger.kernel.org,
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
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	ast@fb.com,
	andresx7@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 17/20] test_firmware: modify custom fallback tests to use unique files
Date: Sat, 10 Mar 2018 06:14:58 -0800
Message-Id: <20180310141501.2214-18-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560436843780051?=
X-GMAIL-MSGID: =?utf-8?q?1594560436843780051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Users of the custom firmware fallback interface is are not supposed to
use the firmware cache interface, this can happen if for instance the
one of the APIs which use the firmware cache is used first with one
firmware file and then the request_firmware_nowait(uevent=false) API
is used with the same file.

We'll soon become strict about this on the firmware interface to reject
such calls later, so correct the test scripts to avoid such uses as well.
We address this on the tests scripts by simply using unique names when
testing the custom fallback interface.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/fw_fallback.sh   | 20 ++++++++++++++------
 tools/testing/selftests/firmware/fw_filesystem.sh | 11 +++++++++--
 tools/testing/selftests/firmware/fw_lib.sh        | 23 +++++++++++++++++++++++
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index 9337a0328627..8e2e34a2ca69 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -238,8 +238,10 @@ run_sysfs_main_tests()
 
 run_sysfs_custom_load_tests()
 {
-	if load_fw_custom "$NAME" "$FW" ; then
-		if ! diff -q "$FW" /dev/test_firmware >/dev/null ; then
+	RANDOM_FILE_PATH=$(setup_random_file)
+	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
+	if load_fw_custom "$RANDOM_FILE" "$RANDOM_FILE_PATH" ; then
+		if ! diff -q "$RANDOM_FILE_PATH" /dev/test_firmware >/dev/null ; then
 			echo "$0: firmware was not loaded" >&2
 			exit 1
 		else
@@ -247,8 +249,10 @@ run_sysfs_custom_load_tests()
 		fi
 	fi
 
-	if load_fw_custom "$NAME" "$FW" ; then
-		if ! diff -q "$FW" /dev/test_firmware >/dev/null ; then
+	RANDOM_FILE_PATH=$(setup_random_file)
+	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
+	if load_fw_custom "$RANDOM_FILE" "$RANDOM_FILE_PATH" ; then
+		if ! diff -q "$RANDOM_FILE_PATH" /dev/test_firmware >/dev/null ; then
 			echo "$0: firmware was not loaded" >&2
 			exit 1
 		else
@@ -256,8 +260,12 @@ run_sysfs_custom_load_tests()
 		fi
 	fi
 
-	if load_fw_custom_cancel "nope-$NAME" "$FW" ; then
-		if diff -q "$FW" /dev/test_firmware >/dev/null ; then
+	RANDOM_FILE_REAL="$RANDOM_FILE_PATH"
+	FAKE_RANDOM_FILE_PATH=$(setup_random_file_fake)
+	FAKE_RANDOM_FILE="$(basename $FAKE_RANDOM_FILE_PATH)"
+
+	if load_fw_custom_cancel "$FAKE_RANDOM_FILE" "$RANDOM_FILE_REAL" ; then
+		if diff -q "$RANDOM_FILE_PATH" /dev/test_firmware >/dev/null ; then
 			echo "$0: firmware was expected to be cancelled" >&2
 			exit 1
 		else
diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index 7f47877fa7fa..6452d2129cd9 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -230,10 +230,13 @@ test_wait_and_cancel_custom_load()
 test_request_firmware_nowait_custom_nofile()
 {
 	echo -n "Batched request_firmware_nowait(uevent=false) nofile try #$1: "
+	config_reset
 	config_unset_uevent
-	config_set_name nope-test-firmware.bin
+	RANDOM_FILE_PATH=$(setup_random_file_fake)
+	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
+	config_set_name $RANDOM_FILE
 	config_trigger_async &
-	test_wait_and_cancel_custom_load nope-test-firmware.bin
+	test_wait_and_cancel_custom_load $RANDOM_FILE
 	wait
 	release_all_firmware
 	echo "OK"
@@ -271,7 +274,11 @@ test_request_firmware_nowait_uevent()
 test_request_firmware_nowait_custom()
 {
 	echo -n "Batched request_firmware_nowait(uevent=false) try #$1: "
+	config_reset
 	config_unset_uevent
+	RANDOM_FILE_PATH=$(setup_random_file)
+	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
+	config_set_name $RANDOM_FILE
 	config_trigger_async
 	release_all_firmware
 	echo "OK"
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 98dceb847ba0..9ea31b57d71a 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -104,6 +104,29 @@ setup_tmp_file()
 	fi
 }
 
+__setup_random_file()
+{
+	RANDOM_FILE_PATH="$(mktemp -p $FWPATH)"
+	# mktemp says dry-run -n is unsafe, so...
+	if [[ "$1" = "fake" ]]; then
+		rm -rf $RANDOM_FILE_PATH
+		sync
+	else
+		echo "ABCD0123" >"$RANDOM_FILE_PATH"
+	fi
+	echo $RANDOM_FILE_PATH
+}
+
+setup_random_file()
+{
+	echo $(__setup_random_file)
+}
+
+setup_random_file_fake()
+{
+	echo $(__setup_random_file fake)
+}
+
 proc_set_force_sysfs_fallback()
 {
 	if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
-- 
2.16.2
