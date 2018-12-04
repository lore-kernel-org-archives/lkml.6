Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468C5C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0084820850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="XdzeKvEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0084820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLDAal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:30:41 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:35873 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLDA3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=ow3a68xxy98P8CB5GijtxEhpTnVeYBgOeQdgKyZxnx8=; b=XdzeKvEq+WBe
        AseRVPEmgJY/zl5sL1RRlpkJ39eH8EYW60WWWHWbTqLFrwIu8nNkBYjCyAJPsAqhAPl6YqifVz1+x
        ZGTbh7KvglktSdHwfwRe1wUnveAxcFi6/orMMHd+Ts7V9+eQVNyGwHdETrhIvraJYijT93UOK93Yr
        sE+bfAQot+KFZXprTe6xQ6ydfjUoJfImlT0H+J9zd5+b6T5BBAeljmbagBbqF4VqAvfi/pgL0OrEs
        SVbFj1Wt8uXRjuN417pq0peIGJ3mkDc/tNeyNuAQx/cEXlsipnIRAc9tTWBycU2lH9+IDakwsIlk0
        XngmOoZIRb7ALTy4Hqugmg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gTya4-0005BQ-Aq; Tue, 04 Dec 2018 01:28:53 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id BD222C07A1;
        Tue,  4 Dec 2018 01:28:49 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 03/24] lockdep tests: Improve testing accuracy
Date:   Mon,  3 Dec 2018 16:28:12 -0800
Message-Id: <20181204002833.55452-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204002833.55452-1-bvanassche@acm.org>
References: <20181204002833.55452-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000931285619068)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ovD0qural0hEGb3cSZtZXJ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORr4NHU416cMuq/e+xEy
 P7roSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/E53d
 gi3vLmcjfrrMypRHn9v9dEORNISlfxbfs62VJBSjtMOg+8MRq9Xbz5+HgJAYX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2aADyQAjySFuYamuypFuC6paCWYFBggRDJgB3AY0qQ
 yqPYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking whether the tests produced any output, check the
output itself. This patch avoids that e.g. debug output causes the
message "PASSED!" to be reported for failed tests.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/run_tests.sh            | 5 +++--
 tools/lib/lockdep/tests/AA.sh             | 2 ++
 tools/lib/lockdep/tests/ABA.sh            | 2 ++
 tools/lib/lockdep/tests/ABBA.sh           | 2 ++
 tools/lib/lockdep/tests/ABBA_2threads.sh  | 2 ++
 tools/lib/lockdep/tests/ABBCCA.sh         | 2 ++
 tools/lib/lockdep/tests/ABBCCDDA.sh       | 2 ++
 tools/lib/lockdep/tests/ABCABC.sh         | 2 ++
 tools/lib/lockdep/tests/ABCDBCDA.sh       | 2 ++
 tools/lib/lockdep/tests/ABCDBDDA.sh       | 2 ++
 tools/lib/lockdep/tests/WW.sh             | 2 ++
 tools/lib/lockdep/tests/unlock_balance.sh | 2 ++
 12 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 tools/lib/lockdep/tests/AA.sh
 create mode 100755 tools/lib/lockdep/tests/ABA.sh
 create mode 100755 tools/lib/lockdep/tests/ABBA.sh
 create mode 100755 tools/lib/lockdep/tests/ABBA_2threads.sh
 create mode 100755 tools/lib/lockdep/tests/ABBCCA.sh
 create mode 100755 tools/lib/lockdep/tests/ABBCCDDA.sh
 create mode 100755 tools/lib/lockdep/tests/ABCABC.sh
 create mode 100755 tools/lib/lockdep/tests/ABCDBCDA.sh
 create mode 100755 tools/lib/lockdep/tests/ABCDBDDA.sh
 create mode 100755 tools/lib/lockdep/tests/WW.sh
 create mode 100755 tools/lib/lockdep/tests/unlock_balance.sh

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index 253719ee6377..bc36178329a8 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -11,7 +11,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "$testname... "
 	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
-		[ "$(timeout 1 "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
+		timeout 1 "tests/$testname" 2>&1 | "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -23,7 +23,8 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "(PRELOAD) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
-		[ "$(timeout 1 ./lockdep "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
+		timeout 1 ./lockdep "tests/$testname" 2>&1 |
+		"tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
diff --git a/tools/lib/lockdep/tests/AA.sh b/tools/lib/lockdep/tests/AA.sh
new file mode 100755
index 000000000000..f39b32865074
--- /dev/null
+++ b/tools/lib/lockdep/tests/AA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/ABA.sh b/tools/lib/lockdep/tests/ABA.sh
new file mode 100755
index 000000000000..f39b32865074
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/ABBA.sh b/tools/lib/lockdep/tests/ABBA.sh
new file mode 100755
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBA_2threads.sh b/tools/lib/lockdep/tests/ABBA_2threads.sh
new file mode 100755
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBA_2threads.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBCCA.sh b/tools/lib/lockdep/tests/ABBCCA.sh
new file mode 100755
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBCCA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBCCDDA.sh b/tools/lib/lockdep/tests/ABBCCDDA.sh
new file mode 100755
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBCCDDA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCABC.sh b/tools/lib/lockdep/tests/ABCABC.sh
new file mode 100755
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABCABC.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCDBCDA.sh b/tools/lib/lockdep/tests/ABCDBCDA.sh
new file mode 100755
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABCDBCDA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCDBDDA.sh b/tools/lib/lockdep/tests/ABCDBDDA.sh
new file mode 100755
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABCDBDDA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/WW.sh b/tools/lib/lockdep/tests/WW.sh
new file mode 100755
index 000000000000..f39b32865074
--- /dev/null
+++ b/tools/lib/lockdep/tests/WW.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/unlock_balance.sh b/tools/lib/lockdep/tests/unlock_balance.sh
new file mode 100755
index 000000000000..c6e3952303fe
--- /dev/null
+++ b/tools/lib/lockdep/tests/unlock_balance.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: bad unlock balance detected'
-- 
2.20.0.rc1.387.gf8505762e3-goog

