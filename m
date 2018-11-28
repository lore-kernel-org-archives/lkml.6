Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C472C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECE02081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="DuTPDyeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECE02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeK2KsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:48:21 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:42019 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeK2Krr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=+U9e20pmqnfj4zXNO6XCKAi3Q3TMqAzNhD7sDjHhhPI=; b=DuTPDyeY4Oqs
        PyjPC4ZVVv8FKNOTx0wzg5vJGkuUujK48iW4BwD/TJr65KRXJH8mt0Z6rAYePJ69sXT3oQWAv900K
        55jy2J0vY7Pii6r4PZTaDWt+QQ3BrgzQZucjggMTHwnU+tuC/atQTJ45s3u/7QAVrYCTHXSzUTykw
        CK1MJnTTEBEN9IZ5IyWComLFGN0A4nW+QkZ3TfOqx+9CU1I2UxIe/xLhHYg57bTVwsNeIfRC3clkh
        W9xqM+HwaeY8JN4ImXSQxSY4XQ8+UQu4RF+ObFLP00UYnUXD6xSk12hx8Skal8LdwTWi/WUZRfEVB
        XNDadyHgPl15SGYHem9qHQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Up-0001zM-MN; Thu, 29 Nov 2018 00:43:56 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id ADB94C16CC;
        Thu, 29 Nov 2018 00:43:40 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 03/27] lockdep tests: Improve testing accuracy
Date:   Wed, 28 Nov 2018 15:43:01 -0800
Message-Id: <20181128234325.110011-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00185816044723)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5hxjInbtVWK0vUdRsrFv7Vx602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aVnRz7l
 5BtCbf7T7SJ/dwAXq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi2wFVccsCAZ2dyI5DAR
 qfkZNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkBvyMjbyNpr4xR6RL2C9+qlIny++hg9dJLqN5zmWqF/oNe6FVV7drXD
 mtOldfpWzeUCaRHvx+uLGHS3n3Y0pMd0ZyCgxZHINA6A5+7T9o6by6wCf9/ixXi9QE6xc2MJdJIs
 WkULIn/2FBvF31UHbsndehIqUczFWeS6sE8e1b5/UlaX0Ao5X99TlizdjWjXhcukjPvPb2ztUwUU
 F4ekbSpuVLxBvmNpAC6nijLQKjrwAYK9hGMp0R2dYkKZbUdfBJkHmFDqewO9xyOqCYO8P1aHcsG0
 kWCiESR44kXyAcFBnvq0JaXhRWKyqy0OhbkmMxu2AdrcZPAiQvyjIZ4LQqnqqLEDUnB02oJPHAlf
 IubJYzA0XAoGECHs14pjPDDBgamvNiA5kjk+kUt44s0jst5fhVlz1D2TbNoUEpMzwiFq0gVLxZRi
 qKQtZtL/YuRtTlBuhWzfuvHd4y0L/HyfN5U858I8R2vIYlYbA7G/CY3eeSCFRiwDn8j3yWGHtM7w
 dRonBy/PpUxgSFRPcWxJF+/beJHmCfSNEcGdfFKs5M18F1x96tlonSt5Ig9mwLw4vXsdf68W0InH
 /+bTMKNm38MHV+diwrlXuxzeO2WnJyd7g8lLLKZgdBo3YHaSgbLEg7M4I+zZPnIX6k9TnzH5sZcr
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking whether the tests produced any output, check the
output itself. This patch avoids that e.g. debug output causes the
message "PASSED!" to be reported for failed tests.

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
index e4f41318aa79..38b8c9034b8e 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -10,7 +10,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "$testname... "
 	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
-		[ "$(timeout 1 "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
+		timeout 1 "tests/$testname" 2>&1 | "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -22,7 +22,8 @@ find tests -name '*.c' | sort | while read -r i; do
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
2.20.0.rc0.387.gc7a69e6b6c-goog

