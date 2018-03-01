Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AG47ELsbJMtRVWyzlMY4uN0dCwoPv5d3j+u796WGxIPlts0uLKfJ8tUVqsySKktjxkE2MGeMtd/6
ARC-Seal: i=1; a=rsa-sha256; t=1519935419; cv=none;
        d=google.com; s=arc-20160816;
        b=y64/bqt7vS5ZpwaIJDKLha/vgn4o5V5Mf/wQ8jJheUrld2kUn8Zi+YF21Hf/005/CS
         chyFQuoYh0De7QQn2vX9/VnzRYhp4YH7Gf0TVyE/bECenCtB5UhFVJuMPWmQTo/tSaIB
         QZFdgkuGFtRjzIqK3blHK3xLxaeQ9PKJ692ziBC4A6afh5hs2oVWhPEwgOeXi8Pc0So7
         Zpl+fgIj6JIu0fivfXWapQ9uCslJMZ6/+OwPu2DpG4Z+RstVEdMj444iebXhDnCiTQYG
         t1EgZ79vhIcRLZ0Q//aIEyVwC7Br1PdE0GJOkfMFb6s9FG98dqULl7ukAVLQTtGEQ6da
         5Mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=osgvTO+nq6TXhbiA/Cp8MkPyUSWU2CJD9pVfvZnz5TM=;
        b=w+i6YhfKxFwd7PJiXjwW6arYAPhjf6yPR8M6w+/LJp+w0cqPs4gde8Z6PV1wJeSBw8
         aspoEVLpymXJcseYrneemyJtwHKWFlqlFFiSOAjFfZ/OV7shePENlKspBl/vm/3QMyH6
         womMthKLm5TvCEzI0zfQFDwPUzTOEnz1XNABa1h+5ol2VxTmhnmIJLhfBJPtGzhAWKxZ
         BFnU1IgSTqqDNNQ8ZA+AnPpTmnEnuEfPQOyJR7EHYjQN522tsTBKjgl7uuotisyk+mEH
         +s7KndYJWZHMT3VeebvftT/mSSXlmBraXJrqFNTpgD/il57NJVCAaAY8ar87hAWn+EI9
         gpdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org,
	naresh.kamboju@linaro.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
	tglx@linutronix.de,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	lei.yang@windriver.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: memory-hotplug: fix emit_tests regression
Date: Thu,  1 Mar 2018 13:16:26 -0700
Message-Id: <20180301201626.17347-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593767802289906258?=
X-GMAIL-MSGID: =?utf-8?q?1593767802289906258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 16c513b13477
("selftests: memory-hotplug: silence test command echo")

introduced regression in emit_tests and results in the following
failure when selftests are installed and run. Fix it.

Running tests in memory-hotplug
========================================
./run_kselftest.sh: line 121: @./mem-on-off-test.sh: No such file or
directory
selftests: memory-hotplug [FAIL]

Fixes: 16c513b13477 (selftests: memory-hotplug: silence test command echo")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/memory-hotplug/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/testing/selftests/memory-hotplug/Makefile
index 183b46883875..686da510f989 100644
--- a/tools/testing/selftests/memory-hotplug/Makefile
+++ b/tools/testing/selftests/memory-hotplug/Makefile
@@ -5,7 +5,8 @@ include ../lib.mk
 
 TEST_PROGS := mem-on-off-test.sh
 override RUN_TESTS := @./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
-override EMIT_TESTS := echo "$(RUN_TESTS)"
+
+override EMIT_TESTS := echo "$(subst @,,$(RUN_TESTS))"
 
 run_full_test:
 	@/bin/bash ./mem-on-off-test.sh && echo "memory-hotplug selftests: [PASS]" || echo "memory-hotplug selftests: [FAIL]"
-- 
2.14.1
