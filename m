Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11884C67838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C346C214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="OnnWsz3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C346C214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLGBNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:13:25 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:43543 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLGBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=PCPBVm+iAU/AQknnZ7wCWBUlw1OKJiYYwPEJKeELRms=; b=OnnWsz3KBiMi
        ViPUHt8yA9w7S0g0AeZFkOZ5Ju9e8wap/wky1wG60zR2QlI2KKD3FgWqkmz7RBLhfAktl182O0R8Q
        0BaKlye3byQ+EKBqgy/cZ515aB80ydjpusog09oyWlNMXHxuV+ioDn1vLKhEPRk/bl54YrSn17I2q
        pjCNXYDLE7wnFXf1k09aG6A6crxlP5M0pCSPq64zR/CTz45ulZGddGKfwTi7JApvboOZywpXGuk0v
        6B0MIaWb1dLaxRWW0qpOma66Pw9KQu4SL3LmHHlVxM+i6e40aSRSBw/Z/QXfaB5ZDWrJ/z1fGMTMg
        O71Wypeq6TPlbvhzaXOdyA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gV4hK-0008lC-0B; Fri, 07 Dec 2018 02:12:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 5A4CFC0D81;
        Fri,  7 Dec 2018 02:12:34 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 01/24] lockdep tests: Display compiler warning and error messages
Date:   Thu,  6 Dec 2018 17:11:25 -0800
Message-Id: <20181207011148.251812-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181207011148.251812-1-bvanassche@acm.org>
References: <20181207011148.251812-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00863733147968)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5hAxiaggZuhBX+DP4cdWb+R602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoPcBEGUdzDsLzVmvkC
 FznGSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/lcBJ
 DmoxYxZqr5EVgTOQJMJt0yuwLUIeLJh6Zvcqtnq27HN2NudZ6VYAoEVgRuTRX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2ap5GGXIcY8RacOZo71La8VCvcyKlm26b0aqg30IuY
 zRDYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compilation of liblockdep fails, display an error message and exit
immediately. Display compiler warning and error messages that are
generated while building a test. Only run a test if compilation of it
succeeded.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/run_tests.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index 2e570a188f16..9f31f84e7fac 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -1,13 +1,17 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-make &> /dev/null
+if ! make >/dev/null; then
+    echo "Building liblockdep failed."
+    echo "FAILED!"
+    exit 1
+fi
 
 for i in `ls tests/*.c`; do
 	testname=$(basename "$i" .c)
-	gcc -o tests/$testname -pthread $i liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &> /dev/null
 	echo -ne "$testname... "
-	if [ $(timeout 1 ./tests/$testname 2>&1 | wc -l) -gt 0 ]; then
+	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
+		[ "$(timeout 1 "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -19,9 +23,9 @@ done
 
 for i in `ls tests/*.c`; do
 	testname=$(basename "$i" .c)
-	gcc -o tests/$testname -pthread -Iinclude $i &> /dev/null
 	echo -ne "(PRELOAD) $testname... "
-	if [ $(timeout 1 ./lockdep ./tests/$testname 2>&1 | wc -l) -gt 0 ]; then
+	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
+		[ "$(timeout 1 ./lockdep "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
-- 
2.20.0.rc2.403.gdbc3b29805-goog

