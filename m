Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpPhPLgWB5aleIXUGEHx74EAef9VGxYr4Lv/yOFeDTj3pczOEhFjMvUztdJB7mm2utg8def
ARC-Seal: i=1; a=rsa-sha256; t=1525215401; cv=none;
        d=google.com; s=arc-20160816;
        b=Mouyb00882rdVIhwKcjEEnbMEzRpBAbLsZ4oJKP+/Lp9djybVbO+fGS7mqI2f96qGA
         rYxbDgup6E/3bivEVgUBNedHQd5m3+9PbXM10GSNa/gYd/LqsWQZ8BanKG5q85j2LiM6
         LQPOoyjg04jBZaFZN+SbCIoAKORW9Q4c42k777hTei37eC80sT9YBp5eFBphMXcDoS8x
         xAXnFpt9BxstIBjHbMZZ6nlzKQ7/Rpw85o/sGufamuSq4XU3fWS/J+TF1YxNDGTwx7XY
         K8RpVBaomVALXhHLAHVORo6f/trTRo+CunuxJpXbxNnIEr9IxK7uojCoOob+/ikvqYWN
         FHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6hfoZpPXi/8uiSJBBseortKgAzEFNVEjPghBTbyiQBM=;
        b=U4/BqXfg8obcW8sCT6mfuyHT1CTpMYc+Gk4AOhkR9fnhDjSEBXfWtoQiSMwarl7Sne
         5jjrYYfqcFBYGoh3XIuAOZARrAcxZM5W9+bsvSCkLsFrbxKipR0pc4cSkFI6p9MuSBG8
         v6Kfy8o9pmpPjIgDvpS5RaW45stpo4PkBbzN2gH+ITDtv91VYwLn4Ll6py2V/Z7Un2oi
         SwWpH+4W9WF5SGqx32UENisR6VFiInZwcout5n9/b+vAvdakC2d3fKzcMyc0D0zQ1qzs
         +S7CrELLLKQj/bTFpVg9tcAebG7xeMc64cdzWlx1rBAoec9ckL/UyNcGRz2r6dIIuoBd
         uz0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeEAWzS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:18 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38358 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWzQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:16 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] selftests: lib.mk: add SKIP handling to RUN_TESTS define
Date: Tue,  1 May 2018 16:54:34 -0600
Message-Id: <5e0281115a0de58998da8f5bbfc391026f4716f6.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304264574614498?=
X-GMAIL-MSGID: =?utf-8?q?1599304264574614498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RUN_TESTS which is the common function that implements run_tests target,
treats all non-zero return codes from tests as failures. When tests are
skipped with non-zero return code, because of unmet dependencies and/or
unsupported configuration, it reports them as failed. This will lead to
too many false negatives even on the tests that couldn't be run.

RUN_TESTS is changed to test for SKIP=4 return from tests to enable the
framework for individual tests to return special SKIP code.

Tests will be changed as needed to report SKIP instead FAIL/PASS when
they get skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/lib.mk | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1d2b48f2d481..e8f5f8b3abeb 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -22,6 +22,7 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 define RUN_TESTS
 	@export KSFT_TAP_LEVEL=`echo 1`;		\
 	test_num=`echo 0`;				\
+	skip=`echo 4`;					\
 	echo "TAP version 13";				\
 	for TEST in $(1); do				\
 		BASENAME_TEST=`basename $$TEST`;	\
@@ -34,9 +35,19 @@ define RUN_TESTS
 		else					\
 			cd `dirname $$TEST` > /dev/null; \
 			if [ "X$(summary)" != "X" ]; then	\
-				(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";		\
+				(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && \
+				echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || \
+				(if [ $$? -eq $$skip ]; then	\
+					echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]";				\
+				else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";					\
+				fi;)			\
 			else				\
-				(./$$BASENAME_TEST && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";					\
+				(./$$BASENAME_TEST &&	\
+				echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") ||						\
+				(if [ $$? -eq $$skip ]; then \
+					echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]"; \
+				else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";				\
+				fi;)		\
 			fi;				\
 			cd - > /dev/null;		\
 		fi;					\
-- 
2.14.1

