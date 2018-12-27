Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BFEC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181AC2190B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="eVgwM51d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeL0LTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:19:31 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:49349 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbeL0LT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:19:27 -0500
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 1B91480533;
        Thu, 27 Dec 2018 03:13:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 1B91480533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1545909223;
        bh=P2VKryxp4j6rpWwR2ocq+urmoCEx7FrbSNg5Vi+uLLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVgwM51d/bQiyY1lvs2ahQXs4o12a5yc3ksCwTkkArH7jTUqjBQryeqDKNR1HfqFl
         UqiPhBR3svlWfuh9IZbsRA+gJDAPBUCuLS4WBFFMG9Vg93FOPEMz9+XQgxjFacuEL6
         RlJOd3TTuFVJQ40zDFnu9iskD3lOmNIwz1o2NXtg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] test_sysctl: add tests for >32-bit values written to 32-bit integers
Date:   Thu, 27 Dec 2018 05:12:29 -0600
Message-Id: <20181227111231.12912-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227111231.12912-1-zev@bewilderbeest.net>
References: <20181227111231.12912-1-zev@bewilderbeest.net>
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
 tools/testing/selftests/sysctl/sysctl.sh | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 584eb8ea780a..a7d0da25975c 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -290,6 +290,40 @@ run_numerictests()
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
+	# check negative and positive 64-bit values, with and without
+	# bits set in the lower 31, and with and without bit 31 (sign
+	# bit of a 32-bit int) set.  None of these are representable
+	# in 32 bits, and hence all should fail.
+	check_failure 0x0000010000000000
+	check_failure 0x0000010080000000
+	check_failure 0x000001ff7fffffff
+	check_failure 0x000001ffffffffff
+	check_failure 0xffffffff7fffffff
+	check_failure 0xffffffffffffffff
+	check_failure 0xffffff0000000000
+	check_failure 0xffffff0080000000
+}
+
 # Your test must accept digits 3 and 4 to use this
 run_limit_digit()
 {
@@ -556,6 +590,7 @@ sysctl_test_0001()
 	TEST_STR=$(( $ORIG + 1 ))
 
 	run_numerictests
+	run_wideint_tests
 	run_limit_digit
 }
 
@@ -580,6 +615,7 @@ sysctl_test_0003()
 	TEST_STR=$(( $ORIG + 1 ))
 
 	run_numerictests
+	run_wideint_tests
 	run_limit_digit
 	run_limit_digit_int
 }
@@ -592,6 +628,7 @@ sysctl_test_0004()
 	TEST_STR=$(( $ORIG + 1 ))
 
 	run_numerictests
+	run_wideint_tests
 	run_limit_digit
 	run_limit_digit_uint
 }
-- 
2.20.1

