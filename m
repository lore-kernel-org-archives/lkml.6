Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF73221916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="FrSk45/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBGMfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:35:10 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:54383 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGMfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:35:10 -0500
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8502180536;
        Thu,  7 Feb 2019 04:35:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 8502180536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1549542909;
        bh=2wwHA0QHB28SNvQ+r2Roozq0NF3TvXfw/4tmHwOAb9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrSk45/VZUn3J0CbGsLzTWmdymJlaJu6XS1EkN577Qi4IsPoptBZ3Ppps/AziQ1te
         XtEs/X0t4x7+JtjyDiQMa2QaY59zBa5Zbda49uBZCBrL2zzhUfOuox/8WhCNoeS/Iq
         yplb3K6mBl6ObTqXrHldwHuHiUuEB2OvSOMDKnxo=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, yzaikin@google.com,
        brendanhiggins@google.com, Zev Weiss <zev@bewilderbeest.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/3] test_sysctl: add tests for >32-bit values written to 32-bit integers
Date:   Thu,  7 Feb 2019 06:34:24 -0600
Message-Id: <20190207123426.9202-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207123426.9202-1-zev@bewilderbeest.net>
References: <20190206195807.GG11489@garbanzo.do-not-panic.com>
 <20190207123426.9202-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present this exposes a bug in do_proc_dointvec_minmax_conv() (it
fails to check for values that are too wide to fit in an int).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 tools/testing/selftests/sysctl/sysctl.sh | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 584eb8ea780a..780ce7123374 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -290,6 +290,58 @@ run_numerictests()
 	test_rc
 }
 
+check_failure()
+{
+	echo -n "Testing that $1 fails as expected..."
+	reset_vals
+	TEST_STR="$1"
+	orig="$(cat $TARGET)"
+	echo -n "$TEST_STR" > $TARGET 2> /dev/null
+
+	# write should fail and $TARGET should retain its original value
+	if [ $? = 0 ] || [ "$(cat $TARGET)" != "$orig" ]; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "ok"
+	fi
+	test_rc
+}
+
+run_wideint_tests()
+{
+	# sysctl conversion functions receive a boolean sign and ulong
+	# magnitude; here we list the magnitudes we want to test (each of
+	# which will be tested in both positive and negative forms).  Since
+	# none of these values fit in 32 bits, writing them to an int- or
+	# uint-typed sysctl should fail.
+	local magnitudes=(
+		# common boundary-condition values (zero, +1, -1, INT_MIN,
+		# and INT_MAX respectively) if truncated to lower 32 bits
+		# (potential for being falsely deemed in range)
+		0x0000000100000000
+		0x0000000100000001
+		0x00000001ffffffff
+		0x0000000180000000
+		0x000000017fffffff
+
+		# these look like negatives, but without a leading '-' are
+		# actually large positives (should be rejected as above
+		# despite being zero/+1/-1/INT_MIN/INT_MAX in the lower 32)
+		0xffffffff00000000
+		0xffffffff00000001
+		0xffffffffffffffff
+		0xffffffff80000000
+		0xffffffff7fffffff
+	)
+
+	for sign in '' '-'; do
+		for mag in "${magnitudes[@]}"; do
+			check_failure "${sign}${mag}"
+		done
+	done
+}
+
 # Your test must accept digits 3 and 4 to use this
 run_limit_digit()
 {
@@ -556,6 +608,7 @@ sysctl_test_0001()
 	TEST_STR=$(( $ORIG + 1 ))
 
 	run_numerictests
+	run_wideint_tests
 	run_limit_digit
 }
 
@@ -580,6 +633,7 @@ sysctl_test_0003()
 	TEST_STR=$(( $ORIG + 1 ))
 
 	run_numerictests
+	run_wideint_tests
 	run_limit_digit
 	run_limit_digit_int
 }
@@ -592,6 +646,7 @@ sysctl_test_0004()
 	TEST_STR=$(( $ORIG + 1 ))
 
 	run_numerictests
+	run_wideint_tests
 	run_limit_digit
 	run_limit_digit_uint
 }
-- 
2.20.1

