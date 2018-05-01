Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpebWOhRfF7bnOCOYYnsl9IsnFCtnNYD1qCzov36gWy1wS0KtA2qzA/X4PgpU29sSgnJZtS
ARC-Seal: i=1; a=rsa-sha256; t=1525215395; cv=none;
        d=google.com; s=arc-20160816;
        b=aS0BmoEOqP0hjCJHuQMS/8IqJgFliytuAzPFQCXcfkBfhsWamFZ3fB6R7JKeGS66PA
         O/RPtjq6HChHzoxy4FuxvJ+OaDtX10ixgR6p/r6nBpBy0lb/hglU7o2RXVVeSCxYd5gz
         BzLFlnUb9GLGFVqg6pT2grapO9yiaux+P2AQDxRaDaZh6VkK2E58srcT/Bk5Izrkyx6Y
         Uhw1+KGmJ5TcHoGN0BaYfYP56xIS83505SnZT6eq2aC0lDg3NJk3xg9TJkaLjbUz8ofe
         mbBX/227ZZu6rLcPtx234t5pUGuIVdm2oZwxnIUy8NJzR0UAxHFm3t4hnANYzbPChpbL
         XsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5IpyDhXFSdc+KP//V81KUhrWb+zIjGD5KmQb7Qvbu3M=;
        b=0iL/JoxBmYiwRfxsWZRIuPBhj+pL+bpBROEmpytWqk44xSfOTPmx3f3DGAycVIg36a
         sDRC7ecWzFTsBfLu47imB45B8/V8qiZjUNl28iD+MdBNX/KdHEOrj5AqH63nuZzzof8i
         1h/IaCyAXGgQv5gGD/coORnwLc+qNQHr5n0Cj2T9nDnUCGFFN170J6rztxMApt9LfjcB
         NLGheXSEL7y7y8t8X0AmGTUXMKMsT1WY3CCgYZhGMziadAxzglSv235tp0LLwLi6wNsR
         e8w8hN0HrQhVeC5qiQaf+MVSpGDs04jv2aNYsuupzZGgFpbvuG8Zk/LYd0zyUCqtmOfd
         gJBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeEAWzY (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:24 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38364 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWzV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:21 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] selftests: lib.mk: move running and printing result to a new function
Date: Tue,  1 May 2018 16:54:35 -0600
Message-Id: <a090e8b1b1123552a4a2b2163055e2ad812b0bab.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304258860818950?=
X-GMAIL-MSGID: =?utf-8?q?1599304258860818950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RUN_TESTS function has grown and becoming harder to maintain. Move
the code that runs and tests for returns codes to a new function
and call it from RUN_TESTS.

A new RUN_TEST_PRINT_RESULT is created to simplify RUN_TESTS and make it
easier to add handling for other return codes as needed.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/lib.mk | 52 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index e8f5f8b3abeb..dd516f92f7c2 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -19,6 +19,33 @@ TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 .ONESHELL:
+define RUN_TEST_PRINT_RESULT
+	echo "selftests: $$BASENAME_TEST";	\
+	echo "========================================";	\
+	if [ ! -x $$TEST ]; then	\
+		echo "selftests: Warning: file $$BASENAME_TEST is not executable, correct this.";\
+		echo "not ok 1..$$test_num selftests: $$BASENAME_TEST [FAIL]"; \
+	else					\
+		cd `dirname $$TEST` > /dev/null; \
+		if [ "X$(summary)" != "X" ]; then	\
+			(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && \
+			echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || \
+			(if [ $$? -eq $$skip ]; then	\
+				echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]";				\
+			else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";					\
+			fi;)			\
+		else				\
+			(./$$BASENAME_TEST &&	\
+			echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") ||						\
+			(if [ $$? -eq $$skip ]; then \
+				echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]"; \
+			else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";				\
+			fi;)		\
+		fi;				\
+		cd - > /dev/null;		\
+	fi;
+endef
+
 define RUN_TESTS
 	@export KSFT_TAP_LEVEL=`echo 1`;		\
 	test_num=`echo 0`;				\
@@ -27,30 +54,7 @@ define RUN_TESTS
 	for TEST in $(1); do				\
 		BASENAME_TEST=`basename $$TEST`;	\
 		test_num=`echo $$test_num+1 | bc`;	\
-		echo "selftests: $$BASENAME_TEST";	\
-		echo "========================================";	\
-		if [ ! -x $$TEST ]; then	\
-			echo "selftests: Warning: file $$BASENAME_TEST is not executable, correct this.";\
-			echo "not ok 1..$$test_num selftests: $$BASENAME_TEST [FAIL]"; \
-		else					\
-			cd `dirname $$TEST` > /dev/null; \
-			if [ "X$(summary)" != "X" ]; then	\
-				(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && \
-				echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || \
-				(if [ $$? -eq $$skip ]; then	\
-					echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]";				\
-				else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";					\
-				fi;)			\
-			else				\
-				(./$$BASENAME_TEST &&	\
-				echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") ||						\
-				(if [ $$? -eq $$skip ]; then \
-					echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [SKIP]"; \
-				else echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";				\
-				fi;)		\
-			fi;				\
-			cd - > /dev/null;		\
-		fi;					\
+		$(call RUN_TEST_PRINT_RESULT,$(TEST),$(BASENAME_TEST),$(test_num),$(skip))						\
 	done;
 endef
 
-- 
2.14.1

