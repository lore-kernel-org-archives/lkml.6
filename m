Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x225eEI+fCh4MuUADdWW4Jzmt5KSk9b8gP+NB13sWGNUpUuDGWPTN3YlBZE7/3+rP1qfIufBn
ARC-Seal: i=1; a=rsa-sha256; t=1519440377; cv=none;
        d=google.com; s=arc-20160816;
        b=bOdaV50eV46T1v+//UXcgfq5huBSqBZpczVWRcSejgnMj7HMFuCmtnmkTrkf3m2mpX
         m8UQ6qiInb93p990sgxKoBtPEWzuwJjs/E8PgOa/xna+Pw/53TJkvqtZ/P5GlEpvFs1E
         1+T6XMzeyVAaldsQqrftE7O9JnBAYVjh5o19poB7zHlCANc7QQn+WCBeDA5jNmK6OpTo
         oBgA/JC1Z+bkngYDSZW4NJcNqcDmDujTUAKuz4WJ4r0zXdXht9UaJCTihIwUfw+iDs0X
         493PNSwPA04tzQcLqJN4vZybk9dkszacdmU59gC/z6nNeg9ZvFkUAK687jZvDZCy3ftF
         r9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=2qUHSU3bw3S0q/LjYbDyATn/valvJNw8YqxkumtocpY=;
        b=GI1HECn9ZAYpIRQArfC5Cd3ypveNorv+yYFZmtdutJZfUGgvJ+dVY6Nk6I5Uebae/B
         ZzJoTMRZdU7BTEX2ENxPBSC2fiW4eAzb8tCJlEALYOGoUWDMMUS8mG4BqW2ujyLbp+ym
         YuRYGWB8Pbai3uKjt7GsWyXERljhsRhWSUDRaD+ExQf8H5bCXkEmW+uazeK6rksRZ9r/
         h8fVZiSkHYI+EGZPysG54MbJIwVDgpYMWq/jwHpv7J2xUoBstuivNytBC+xbNgzQQzJ/
         OkrugQ8ROR0SB9Jkjv78QhGAlRrXDpMRHydCt/32Hc97qagzEw8PcaYRuvSMJtj0RWSC
         79Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924D2217AD
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
Subject: [PATCH v2 01/11] test_firmware: enable custom fallback testing on limited kernel configs
Date: Fri, 23 Feb 2018 18:46:03 -0800
Message-Id: <20180224024613.24078-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248713291607087?=
X-GMAIL-MSGID: =?utf-8?q?1593248713291607087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a kernel is not built with:

CONFIG_HAS_FW_LOADER_USER_HELPER_FALLBACK=y

We don't currently enable testing fw_fallback.sh. For kernels that
still enable the fallback mechanism, its possible to use the async
request firmware API call request_firmware_nowait() using the custom
interface to use the fallback mechanism, so we should be able to test
this but we currently cannot.

We can enable testing without CONFIG_HAS_FW_LOADER_USER_HELPER_FALLBACK=y
by relying on /proc/config.gz (CONFIG_IKCONFIG_PROC), if present. If you
don't have this we'll have no option but to rely on old heuristics for now.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/config         |  4 +++
 tools/testing/selftests/firmware/fw_fallback.sh | 45 ++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
index c8137f70e291..bf634dda0720 100644
--- a/tools/testing/selftests/firmware/config
+++ b/tools/testing/selftests/firmware/config
@@ -1 +1,5 @@
 CONFIG_TEST_FIRMWARE=y
+CONFIG_FW_LOADER=y
+CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index 722cad91df74..a42e437363d9 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -6,7 +6,46 @@
 # won't find so that we can do the load ourself manually.
 set -e
 
+PROC_CONFIG="/proc/config.gz"
+TEST_DIR=$(dirname $0)
+
 modprobe test_firmware
+if [ ! -f $PROC_CONFIG ]; then
+	if modprobe configs 2>/dev/null; then
+		echo "Loaded configs module"
+		if [ ! -f $PROC_CONFIG ]; then
+			echo "You must have the following enabled in your kernel:" >&2
+			cat $TEST_DIR/config >&2
+			echo "Resorting to old heuristics" >&2
+		fi
+	else
+		echo "Failed to load configs module, using old heuristics" >&2
+	fi
+fi
+
+kconfig_has()
+{
+	if [ -f $PROC_CONFIG ]; then
+		if zgrep -q $1 $PROC_CONFIG 2>/dev/null; then
+			echo "yes"
+		else
+			echo "no"
+		fi
+	else
+		# We currently don't have easy heuristics to infer this
+		# so best we can do is just try to use the kernel assuming
+		# you had enabled it. This matches the old behaviour.
+		if [ "$1" = "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y" ]; then
+			echo "yes"
+		elif [ "$1" = "CONFIG_FW_LOADER_USER_HELPER=y" ]; then
+			if [ -d /sys/class/firmware/ ]; then
+				echo yes
+			else
+				echo no
+			fi
+		fi
+	fi
+}
 
 DIR=/sys/devices/virtual/misc/test_firmware
 
@@ -14,6 +53,7 @@ DIR=/sys/devices/virtual/misc/test_firmware
 # These days no one enables CONFIG_FW_LOADER_USER_HELPER so check for that
 # as an indicator for CONFIG_FW_LOADER_USER_HELPER.
 HAS_FW_LOADER_USER_HELPER=$(if [ -d /sys/class/firmware/ ]; then echo yes; else echo no; fi)
+HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
 
 if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
        OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
@@ -286,7 +326,10 @@ run_sysfs_custom_load_tests()
 	fi
 }
 
-run_sysfs_main_tests
+if [ "$HAS_FW_LOADER_USER_HELPER_FALLBACK" = "yes" ]; then
+	run_sysfs_main_tests
+fi
+
 run_sysfs_custom_load_tests
 
 exit 0
-- 
2.16.2
