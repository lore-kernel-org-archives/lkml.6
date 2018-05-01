Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpoyhZpIJbzrmn2tDcu2eqSXhx9VSpQosfazXONhe8AdCa1TXAtDNkRgy8Q3BBKJeZ9kFTk
ARC-Seal: i=1; a=rsa-sha256; t=1525215381; cv=none;
        d=google.com; s=arc-20160816;
        b=SHHUArzBSo31CUaxKzkNewntnPDbizOoh3SxP3VwTRA96smu66SlWZJwU9slgkiSNj
         ClooNs3xcCLCwORFADv/eUM3XI4A0lWz5SGL3z7CVM5Iqih8AdCzIetpZ7HV/l5wETqa
         ne4J6WXFmtXGIqSzXspQZ7utzwBvYOyJ67dwR/+6qzfVPr3uwyePVsIfW60YgNS7+I30
         rqTYCtY96SF/he7i/b4xiXROeI/Ti4Hw4GM3VFLwdTuh876CrFzy8B+sGpp8GzAbPakI
         jtCptUc7vbbEaDRz9MyHxXWdApbZshsO4HJ3cEEBfCVunvftWM/rNMTsttXXbmK3Y4lD
         fHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Itk23CN/BgO0sOX12yoPkVDM66drkU9wl5fU9xIKZvg=;
        b=qTag5fA220UqcEWWI0KO6SYTpCYIaQbCTzttJ6LTMKrC/u1Pgfrt757VmBB3bUdmRf
         /jcUOCuRo4vFEZOjagLw0G71g+qoIddItMnJt5WkoId48afa2564ysOuzjdec0nzjJh/
         y3Nsjb/kiDJ+Rwn2tOcDzwN/VUCSsd0hg6zQoaKJW8RXIMTwNuTi6qKcZ53r2WQHW+3u
         mlJFvy8j+ByCdmtvUVD0SFHcsOf/bKV+3OGQgQyXk9Y2T/EriB2eJHuAaKmMjJjEDC7L
         OB3FYhAPgXiwdOBigXhQ68uWmd5NriFozMgNrg4CgxmHouIneB91HKSmAx123+R4+LVv
         N3XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEAWze (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:34 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38388 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWzc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:32 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] selftests: lib.mk: add SKIP handling and test suite name to EMIT_TESTS
Date: Tue,  1 May 2018 16:54:37 -0600
Message-Id: <eaa689c8fa2397e68bc1cf3bf4dce02feb21a62a.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304243950729846?=
X-GMAIL-MSGID: =?utf-8?q?1599304243950729846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

EMIT_TESTS which is the common function that implements run_tests target,
treats all non-zero return codes from tests as failures. When tests are
skipped with non-zero return code, because of unmet dependencies and/or
unsupported configuration, it reports them as failed. This will lead to
too many false negatives even on the tests that couldn't be run.

EMIT_TESTS is changed to test for SKIP=4 return from tests to enable
the framework for individual tests to return special SKIP code.

Tests will be changed as needed to report SKIP instead FAIL/PASS when
they get skipped.

Currently just the test name is printed in the RUN_TESTS output. For
example, when raw_skew sub-test from timers tests in run, the output
shows just raw_skew. Include main test name when printing sub-test
results.

In addition, remove duplicate strings for printing common information with
a new for the test header information.

With this change run_kelftest.sh output for breakpoints test will be:

TAP version 13
Running tests in breakpoints
========================================
selftests: breakpoints: step_after_suspend_test
not ok 1..1 selftests: breakpoints: step_after_suspend_test [SKIP]
selftests: breakpoints: breakpoint_test
ok 1..2 selftests: breakpoints: breakpoint_test [PASS]

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/Makefile | 3 ++-
 tools/testing/selftests/lib.mk   | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 32aafa92074c..302c7ea8b820 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -134,7 +134,8 @@ ifdef INSTALL_PATH
 	echo "else" >> $(ALL_SCRIPT)
 	echo "  OUTPUT=/dev/stdout" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
-	echo "export KSFT_TAP_LEVEL=`echo 1`" >> $(ALL_SCRIPT)
+	echo "export KSFT_TAP_LEVEL=1" >> $(ALL_SCRIPT)
+	echo "export skip=4" >> $(ALL_SCRIPT)
 
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index eb2be6dabbda..0c6012500026 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -94,9 +94,13 @@ else
 endif
 
 define EMIT_TESTS
-	@for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
+	@test_num=`echo 0`;				\
+	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
-		echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"selftests: $$BASENAME_TEST [PASS]\") || echo \"selftests: $$BASENAME_TEST [FAIL]\""; \
+		test_num=`echo $$test_num+1 | bc`;	\
+		TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
+		echo "echo $$TEST_HDR_MSG";	\
+		echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"ok 1..$$test_num $$TEST_HDR_MSG [PASS]\") || (if [ \$$? -eq \$$skip ]; then echo \"not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]\"; else echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\"; fi;)"; \
 	done;
 endef
 
-- 
2.14.1

