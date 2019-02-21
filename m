Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955B42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfBUSnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:43:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUSnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:43:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85FBB3082E09;
        Thu, 21 Feb 2019 18:43:50 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B0CE5D9D3;
        Thu, 21 Feb 2019 18:43:49 +0000 (UTC)
Subject: [PATCH] test_sysctl: add proc_do_large_bitmap test function
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, netdev@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
 <8166cf23-db52-7679-3378-8523889a9cd0@sandeen.net>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <a8caf97b-9dbb-5846-7e93-242226a6c8c7@redhat.com>
Date:   Thu, 21 Feb 2019 12:43:49 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8166cf23-db52-7679-3378-8523889a9cd0@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 21 Feb 2019 18:43:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test to build up bitmap range string and test the bitmap
proc handler.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

nb: test_modprobe & load_req_mod fail for me before we ever
get to this test, but commenting them out, my test runs as expected.
I'm new to this script, so careful review would be wise. ;)

Thanks,
-Eric

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 584eb8ea780a..c710b09e2d69 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -37,6 +37,7 @@ ALL_TESTS="$ALL_TESTS 0002:1:1"
 ALL_TESTS="$ALL_TESTS 0003:1:1"
 ALL_TESTS="$ALL_TESTS 0004:1:1"
 ALL_TESTS="$ALL_TESTS 0005:3:1"
+ALL_TESTS="$ALL_TESTS 0006:3:1"
 
 test_modprobe()
 {
@@ -149,6 +150,9 @@ reset_vals()
 		string_0001)
 			VAL="(none)"
 			;;
+		bitmap_0001)
+			VAL=""
+			;;
 		*)
 			;;
 	esac
@@ -548,6 +552,47 @@ run_stringtests()
 	test_rc
 }
 
+run_bitmaptest() {
+	# Total length of bitmaps string to use, a bit under
+	# the maximum input size of the test node
+	LENGTH=$((RANDOM % 65000))
+
+	# First bit to set
+	BIT=$((RANDOM % 1024))
+
+	# String containing our list of bits to set
+	TEST_STR=$BIT
+
+	# build up the string
+	while [ "${#TEST_STR}" -le "$LENGTH" ]; do
+		# Make sure next entry is discontiguous,
+		# skip ahead at least 2
+		BIT=$((BIT + $((2 + RANDOM % 10))))
+
+		# Add new bit to the list
+		TEST_STR="${TEST_STR},${BIT}"
+
+		# Randomly make it a range
+		if [ "$((RANDOM % 2))" -eq "1" ]; then
+			RANGE_END=$((BIT + $((1 + RANDOM % 10))))
+			TEST_STR="${TEST_STR}-${RANGE_END}"
+			BIT=$RANGE_END
+		fi
+	done
+
+	echo -n "Checking bitmap handler... "
+	set_orig
+	echo -n $TEST_STR > $TARGET 2> /dev/null
+
+	if verify "${TARGET}"; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "ok"
+	fi
+	test_rc
+}
+
 sysctl_test_0001()
 {
 	TARGET="${SYSCTL}/int_0001"
@@ -605,6 +650,14 @@ sysctl_test_0005()
 	run_limit_digit_int_array
 }
 
+sysctl_test_0006()
+{
+	TARGET="${SYSCTL}/bitmap_0001"
+	reset_vals
+	ORIG=$(cat "${TARGET}")
+	run_bitmaptest
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -618,6 +671,7 @@ list_tests()
 	echo "0003 x $(get_test_count 0003) - tests proc_dointvec()"
 	echo "0004 x $(get_test_count 0004) - tests proc_douintvec()"
 	echo "0005 x $(get_test_count 0005) - tests proc_douintvec() array"
+	echo "0006 x $(get_test_count 0006) - tests proc_do_large_bitmap"
 }
 
 test_reqs


