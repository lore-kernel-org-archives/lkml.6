Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C92A8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C372087E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C372087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935907AbeFNBfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:35:10 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:53344 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935725AbeFNBez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:34:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id DE5FC21580;
        Thu, 14 Jun 2018 01:34:54 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YpxSunuMmjWO; Thu, 14 Jun 2018 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 8AD5021351;
        Thu, 14 Jun 2018 01:34:47 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kselftest_harness: return Kselftest Skip code for skipped tests
Date:   Wed, 13 Jun 2018 19:34:45 -0600
Message-Id: <20180614013445.6120-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a test is skipped because of unmet dependencies and/or unsupported
configuration, kselftest_harness exits with error which is treated as a
fail by the Kselftest framework. This leads to false negative result even
when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run. This change add skip
handling to kselftest_harness with minimal changes adding a new skipped
field to struct __test_metadata and using it to recognize KSFT_SKIP exit
from the test function (t->fn) to __run_test() to the test_harness_run()
to return the right skip code to Kselftest framework.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

This change is tested on uevent test and the results are as follows:

Before:

TAP version 13
selftests: uevent: uevent_filtering
========================================
[==========] Running 1 tests from 1 test cases.
[ RUN      ] global.uevent_filtering
uevent_filtering.c:355:global.uevent_filtering:Uevent filtering tests require root privileges. Skipping test
global.uevent_filtering: Test skipped at step #4
[     FAIL ] global.uevent_filtering
[==========] 0 / 1 tests passed.
[  FAILED  ]
not ok 1..1 selftests: uevent: uevent_filtering [FAIL]

After:

TAP version 13
selftests: uevent: uevent_filtering
========================================
[==========] Running 1 tests from 1 test cases.
[ RUN      ] global.uevent_filtering
uevent_filtering.c:355:global.uevent_filtering:Uevent filtering tests require root privileges. Skipping test
global.uevent_filtering: Test skipped at step #4
[     SKIP ] global.uevent_filtering
not ok 1..1 selftests: uevent: uevent_filtering [SKIP]

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 6ae3730c4ee3..7af9ab97b367 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -631,6 +631,7 @@ struct __test_metadata {
 	void (*fn)(struct __test_metadata *);
 	int termsig;
 	int passed;
+	int skipped;
 	int trigger; /* extra handler after the evaluation */
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
@@ -694,6 +695,7 @@ void __run_test(struct __test_metadata *t)
 	int status;
 
 	t->passed = 1;
+	t->skipped = 0;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
 	child_pid = fork();
@@ -716,9 +718,12 @@ void __run_test(struct __test_metadata *t)
 					t->name,
 					WEXITSTATUS(status));
 			} else if (!t->passed) {
+				if (WEXITSTATUS(status) == KSFT_SKIP)
+					t->skipped = 1;
 				fprintf(TH_LOG_STREAM,
-					"%s: Test failed at step #%d\n",
+					"%s: Test %s at step #%d\n",
 					t->name,
+					(t->skipped ? "skipped" : "failed"),
 					WEXITSTATUS(status));
 			}
 		} else if (WIFSIGNALED(status)) {
@@ -743,7 +748,11 @@ void __run_test(struct __test_metadata *t)
 				status);
 		}
 	}
-	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
+	if (t->skipped)
+		printf("[     %4s ] %s\n", "SKIP", t->name);
+	else
+		printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"),
+			t->name);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
@@ -762,6 +771,8 @@ static int test_harness_run(int __attribute__((unused)) argc,
 		__run_test(t);
 		if (t->passed)
 			pass_count++;
+		else if (t->skipped)
+			return KSFT_SKIP;
 		else
 			ret = 1;
 	}
-- 
2.17.0

