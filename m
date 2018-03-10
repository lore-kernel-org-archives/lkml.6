Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELufyQqPu3wCWuiRAPw4O8N5oeQjgXfvRGqsn1F5gS7yfHTHsSjFugbp1t7yd0pSRa3Z9NZK
ARC-Seal: i=1; a=rsa-sha256; t=1520691316; cv=none;
        d=google.com; s=arc-20160816;
        b=fIeFvUpSEQaky0eziPl1Ps+5R9vAE0TInq4p/LEWWOv83jSowExeIYK0lJwR5yRrEB
         DyPOj70wq+i93ffqLC1uP4TTA65sXKLjSKaBrlv9fVPqgkeabVrNV2nwEanqPnbLJuD+
         bwdJ+o3BDZRYopQK7HiP0oBpbhRBxAQLotbj1YaJ3I1A6XLAd4WqXUjCgj/zkwvD2p1i
         WRMJg1swKhzSDma/rskxDLy2kGaWPtzCrOopkG3LPDq2dd34g+PWdzLbzIMFGU1ZMArs
         npaO/1XFR3bFO6a4L9RrBtP+0Xglu7q1FRUPAhEg8DP0blJ52T0/26lLCbLvY3VElkY4
         lPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=8P+73AxN3kwI1kCbnIlOnvhbvZKY5dQxdT81pzBQblE=;
        b=rtgRaLsZ1Dw7+YT65sjAhAXD241nUM0XRg2l3kgwheAUDqbKUXaXrAVKVpA4NQxO7P
         DuUZprfBq0GOQ+wtDs0E3ECtRA58/Kd5d6Z/fH4hJSTk+B537ShDik/dIXzvcPTlV+Lv
         MLcJlhmrFXBnJAsEOA//nfxEEQcjMh4sqfMiRMq1fLcmmcNGrY2ZbwK6T+yLXOA1c0Cs
         OD/knIpusXoA6cOEIuSNNC8KgaJOENBnpMOUnV8k15+FVMrkT5vP9sXr0Acig9P244XT
         xu6wdPCx4q7jRgjW0ZegJwRJdjuPykkH2MTCOdbAx9a2xP/1QEz7bAqWw5eQqdh0Qxaz
         S1Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4213E21797
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
Subject: [PATCH v3 02/20] test_firmware: enable custom fallback testing on limited kernel configs
Date: Sat, 10 Mar 2018 06:14:43 -0800
Message-Id: <20180310141501.2214-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560417953513667?=
X-GMAIL-MSGID: =?utf-8?q?1594560417953513667?=
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

We stuff the new kconfig_has() helper into our shared library as we'll
later expando on its use elsewhere.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/config         |  4 ++++
 tools/testing/selftests/firmware/fw_fallback.sh |  6 +++++-
 tools/testing/selftests/firmware/fw_lib.sh      | 24 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

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
index 755147a8c967..bf850050e5e9 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -15,6 +15,7 @@ check_mods
 # These days no one enables CONFIG_FW_LOADER_USER_HELPER so check for that
 # as an indicator for CONFIG_FW_LOADER_USER_HELPER.
 HAS_FW_LOADER_USER_HELPER=$(if [ -d /sys/class/firmware/ ]; then echo yes; else echo no; fi)
+HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
 
 if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
        OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
@@ -287,7 +288,10 @@ run_sysfs_custom_load_tests()
 	fi
 }
 
-run_sysfs_main_tests
+if [ "$HAS_FW_LOADER_USER_HELPER_FALLBACK" = "yes" ]; then
+	run_sysfs_main_tests
+fi
+
 run_sysfs_custom_load_tests
 
 exit 0
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index c14bbca7ecf9..467567c758b9 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -42,3 +42,27 @@ check_mods()
 		fi
 	fi
 }
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
-- 
2.16.2
