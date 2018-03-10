Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELtt76WP85eOdb+IKUj7Vd1J9TaBxck3yYiI8fplLoftwbiSrWIz3Q84d85XucYSRaQHBgNW
ARC-Seal: i=1; a=rsa-sha256; t=1520691315; cv=none;
        d=google.com; s=arc-20160816;
        b=Dpxc/gl0z09QLHDLbT2RoXALGaimgxU9MHIp8NhZorf3E3nwEo/C0LK21QdOjmXlSy
         2rJWHbTuxPOH9cpsiCcsSExqjXrb+42G6iTBg5HYyfm1L9jhtctQsZjVWugS/tv2OQ3U
         kftLMqg4dckk77NT/+whd8Pv4kCTeRcqyEtYcyCuzM4897u2PSBUeOUzvrCjhLwa2w4n
         92o+CeIgYfbYyF5Xa1Po/M/QJVpxV4yD7DoBwX+SD0mjZx2ksEwDQPTnHJHriAP7h+Me
         yfR+38ZhAX7tKKcLo/B4pbdEGqF0GF9pmL+TJdZhZGI0BNAfWwBsre+EHUgkYRMLT0P1
         d74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=uxP7+89zxYRWCUbfOWpOcb1aRxC3OARQy20izrp67EE=;
        b=JYP5kQnuU8qxv1DjutbZ3P4pK5X4D0U/fSpdJoLjl/dId8ENjN7aAgteaibpZFVAA+
         nVdSkcM6EpUVFRVgftgWeSRYSPzleEb1LiRUZ6654eDUD8iB0oXcnfqkGIqFN+/7NGPq
         RD16meYN6IKsEi3q3OzB753V7/tfni+VOXAQAoYk9YXY32fYczKKG7hj6GeSg3785oq/
         fX3rKMcyYgEuDBq+4DbV4WTyJMaI/Ps/55d+U6XUllgl5JLj1+E+nnYvm9M4dS2ALzI7
         o1YRA1xCEnEPKFuE29K9sZi+igt1qFp6ecAIfOdWiN3JxT1jBGsdxxymFas3ToYlaY62
         m6JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4852178E
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
Subject: [PATCH v3 01/20] test_firmware: add simple firmware firmware test library
Date: Sat, 10 Mar 2018 06:14:42 -0800
Message-Id: <20180310141501.2214-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560416919342220?=
X-GMAIL-MSGID: =?utf-8?q?1594560416919342220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We'll expland on this later, for now just add basic module checker.
While at it, move this all to use /bin/bash as we'll have much more
flexibility with it.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/fw_fallback.sh   |  7 ++--
 tools/testing/selftests/firmware/fw_filesystem.sh | 20 ++---------
 tools/testing/selftests/firmware/fw_lib.sh        | 44 +++++++++++++++++++++++
 3 files changed, 51 insertions(+), 20 deletions(-)
 create mode 100755 tools/testing/selftests/firmware/fw_lib.sh

diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index 722cad91df74..755147a8c967 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # This validates that the kernel will fall back to using the fallback mechanism
 # to load firmware it can't find on disk itself. We must request a firmware
@@ -6,9 +6,10 @@
 # won't find so that we can do the load ourself manually.
 set -e
 
-modprobe test_firmware
+TEST_DIR=$(dirname $0)
+source $TEST_DIR/fw_lib.sh
 
-DIR=/sys/devices/virtual/misc/test_firmware
+check_mods
 
 # CONFIG_FW_LOADER_USER_HELPER has a sysfs class under /sys/class/firmware/
 # These days no one enables CONFIG_FW_LOADER_USER_HELPER so check for that
diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index f9508e1a4058..748f2f5737e9 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # This validates that the kernel will load firmware out of its list of
 # firmware locations on disk. Since the user helper does similar work,
@@ -6,24 +6,10 @@
 # know so we can be sure we're not accidentally testing the user helper.
 set -e
 
-DIR=/sys/devices/virtual/misc/test_firmware
 TEST_DIR=$(dirname $0)
+source $TEST_DIR/fw_lib.sh
 
-test_modprobe()
-{
-	if [ ! -d $DIR ]; then
-		echo "$0: $DIR not present"
-		echo "You must have the following enabled in your kernel:"
-		cat $TEST_DIR/config
-		exit 1
-	fi
-}
-
-trap "test_modprobe" EXIT
-
-if [ ! -d $DIR ]; then
-	modprobe test_firmware
-fi
+check_mods
 
 # CONFIG_FW_LOADER_USER_HELPER has a sysfs class under /sys/class/firmware/
 # These days most distros enable CONFIG_FW_LOADER_USER_HELPER but disable
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
new file mode 100755
index 000000000000..c14bbca7ecf9
--- /dev/null
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Library of helpers for test scripts.
+set -e
+
+DIR=/sys/devices/virtual/misc/test_firmware
+
+PROC_CONFIG="/proc/config.gz"
+TEST_DIR=$(dirname $0)
+
+print_reqs_exit()
+{
+	echo "You must have the following enabled in your kernel:" >&2
+	cat $TEST_DIR/config >&2
+	exit 1
+}
+
+test_modprobe()
+{
+	if [ ! -d $DIR ]; then
+		print_reqs_exit
+	fi
+}
+
+check_mods()
+{
+	trap "test_modprobe" EXIT
+	if [ ! -d $DIR ]; then
+		modprobe test_firmware
+	fi
+	if [ ! -f $PROC_CONFIG ]; then
+		if modprobe configs 2>/dev/null; then
+			echo "Loaded configs module"
+			if [ ! -f $PROC_CONFIG ]; then
+				echo "You must have the following enabled in your kernel:" >&2
+				cat $TEST_DIR/config >&2
+				echo "Resorting to old heuristics" >&2
+			fi
+		else
+			echo "Failed to load configs module, using old heuristics" >&2
+		fi
+	fi
+}
-- 
2.16.2
