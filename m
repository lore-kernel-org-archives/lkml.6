Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZraYgVIvpLaG2JXlWzAMoWWkPktAiNuSD6qpkSEBSPksIoat0PFGQvTO8ANxkWgQl5zpga+
ARC-Seal: i=1; a=rsa-sha256; t=1524866151; cv=none;
        d=google.com; s=arc-20160816;
        b=XnqGWdU1XsAB+1fWolPic2YmbIcwlLzBkfY+oeffGHgiKw6McZoX3KQOP7wLxY12PO
         WUCO8K/e6Rz9rBoCZOiaLCM9SIUJlf3E6DrzO1VteYUGPIuN4AneqNtMyKKH7Po77l7n
         EWhGNUL3GcKArA+8JgfsRYK+aDSYCQ81uTcRgLeNzV180kMsgowWvoPyHahXzytywMfo
         18Gzkv1L1m3M/0d5aaQaZTp+bXc9xRq4w3c74Q+Jf6/cFpNp08dlb3YObeDUJsDNSzLH
         TDIY+4vJiz1Z31Zu+xKi5EbR32GOsjbC6fesr8hdMfHvPg6NeNvzKfj46ABrTBcHHF2X
         0m2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DVIrRqUSsMgomLO8Qgcul+yNKicPNiVDdq7q8fgvVnI=;
        b=EmqZ9+YWShSgpVb4cMA8E87oS3kYr9dTuBzJQb2KE8WXtjX+TdqewZvDh0FBI2+DJn
         dkTauco+Tbi9djJtg3IaJJYP9MHd4M9vmZ7QWh1Acbv48SHOIBILxnOy8lG1oUXtivz6
         BhuI/X/XOi4hFQPsK7J61HRXg2K/CwewLtf/iC6M2RWfCRLhp8N3O7DpombZmIpaB5ft
         ZmG55TridWzOJojXhegA5NP6CfVWK9y4AugQq8r/dRxaYVdMCqd6AvmJG7KtnqHRisYT
         0E/rcSWFSigzLUeGpgEweggfDh64D9XaMqZjtm4Dsi2wywIJZxkI65HfAYq8XpqeMTde
         mOwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759316AbeD0Vzu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 17:55:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:54964 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD0Vzu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 17:55:50 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 4.17-rc2] selftests: Fix lib.mk run_tests target shell script
Date: Fri, 27 Apr 2018 17:55:41 -0400
Message-Id: <20180427215541.25007-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598938049686929383?=
X-GMAIL-MSGID: =?utf-8?q?1598938049686929383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Within run_tests target, the whole script needs to be executed within
the same shell and not as separate subshells, so the initial test_num
variable set to 0 is still present when executing "test_num=`echo
$$test_num+1 | bc`;".

Demonstration of the issue (make run_tests):

TAP version 13
(standard_in) 1: syntax error
selftests: basic_test
========================================
ok 1.. selftests: basic_test [PASS]
(standard_in) 1: syntax error
selftests: basic_percpu_ops_test
========================================
ok 1.. selftests: basic_percpu_ops_test [PASS]
(standard_in) 1: syntax error
selftests: param_test
========================================
ok 1.. selftests: param_test [PASS]

With fix applied:

TAP version 13
selftests: basic_test
========================================
ok 1..1 selftests: basic_test [PASS]
selftests: basic_percpu_ops_test
========================================
ok 1..2 selftests: basic_percpu_ops_test [PASS]
selftests: param_test
========================================
ok 1..3 selftests: param_test [PASS]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 1f87c7c15d7 ("selftests: lib.mk: change RUN_TESTS to print messages in TAP13 format")
CC: Shuah Khan <shuahkh@osg.samsung.com>
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/lib.mk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 195e9d4739a9..c1b1a4dc6a96 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,10 +20,10 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 .ONESHELL:
 define RUN_TESTS
-	@export KSFT_TAP_LEVEL=`echo 1`;
-	@test_num=`echo 0`;
-	@echo "TAP version 13";
-	@for TEST in $(1); do				\
+	@export KSFT_TAP_LEVEL=`echo 1`;		\
+	test_num=`echo 0`;				\
+	echo "TAP version 13";				\
+	for TEST in $(1); do				\
 		BASENAME_TEST=`basename $$TEST`;	\
 		test_num=`echo $$test_num+1 | bc`;	\
 		echo "selftests: $$BASENAME_TEST";	\
-- 
2.11.0

