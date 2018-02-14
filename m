Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x227qZItdnHRfBYjgN2BYmwzVOsmOwVQVyrr3QpS2XdPL0Y4TJbrk4wWx5Bu6niBtnrBR6kMb
ARC-Seal: i=1; a=rsa-sha256; t=1518568917; cv=none;
        d=google.com; s=arc-20160816;
        b=hTRqseZwZjx5l+xD4kenv7pwtk8IEwpZWBgU6R88GrQTamVqAUXQY7wXM2bBquUeUt
         O9j7/FwSmCwsvaiInXKxQCmjCMgE8DxD1gUiANcrEkHFWI+VdGteYnY7CFpynMOvFsQF
         2D5czwHrhZrusfrM0OXqrhlsyNpLc9b96CLbi+Ok77PL69Xi/cYhqajELq14jkWpekET
         Ycf6zqgssuusv3/u9ODa5+8Kf+HLiwRwNBofaFUCVn+QmZ71YRnwyBAkSkg6BxrFV1A5
         +d+NCuZQQbZKz8Zh5MheXIMtZDLGy9oqXhYmX/j9X+uXknFsA6eeKcTWCTTOQEwjn7jT
         BNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=FabgCk+yl4hecGrQONm0pWkzINsymNt8FeEV4uPjtSc=;
        b=e40jSMTDAmj4t9UUQXmLcbHdaM/YIb7ShYBcP5qwXghXJDun+ol6TpR/HaahXzzj8g
         Dr2rBe8WoV4j4juHUEueI9q6dRu9sAvNmD4A59jp2sFFHfQoFG+oWGiTWAfAfBdFs4cS
         rOkKQePdLLiXrm6/+jzoQGG6uzHHuXpS8yjoI0LLxPaSxtY9+kc2tOpvWy5floqvOC0e
         fjLhh2iB+krRBWFY6wjP1lSkYkcBXesGu+4bHeS6yndFgMU1cVkoolY+CFbF+N6tvLHa
         1wV35Y21YbujijA3i95OvwGgwat7ipB8E7HPz84iS7Ux4mrLEnlg8P1HYi8dCGjavtHv
         GUEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76633217B9
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
Date: Tue, 13 Feb 2018 16:41:38 -0800
Message-Id: <20180214004148.14452-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334921455939904?=
X-GMAIL-MSGID: =?utf-8?q?1592334921455939904?=
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
2.16.1
