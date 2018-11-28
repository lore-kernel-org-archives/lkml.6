Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BA5C4161D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FD02081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="OApl3T4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FD02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeK2Kts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:49:48 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:34711 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeK2Kr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=0wXC4P8tv/necGliK5aRNomolWx+JN4mjPoOhe5DvHQ=; b=OApl3T4Ci75M
        0vsfk1PMLITZxFmezbPbI7K6vVLWmb+e+/vs9xTo/uxkCj39JRAKlOzk9lnvXNMBaPPh1nC+0iAHw
        dtTD/udwsgCgqmm5g+D/FwejdbqL9YcmhmSCjrfhUj9dSgdiaWYOF5eaf/iFUFb2GWc1T9QW5jDqa
        73wMZh7B+dgNJ13E9uoFFOOOuv31eCaazXM+G7+IrQiXlGPHKSZsNfVjOPBLq7ju8XYlGBI8jgHg0
        2mxuPvdW6trqSvsSPpNmHv74B6LO8TQEtdZdBg4d1vPF07NytAPWDJMvu6Hefr+cBvqa5wPCnNIYr
        8FM1FPeXa+BJ+qqtx9uo5g==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Un-000Fij-64; Thu, 29 Nov 2018 00:43:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id AFE5DC13FF;
        Thu, 29 Nov 2018 00:43:36 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 01/27] lockdep tests: Display compiler warning and error messages
Date:   Wed, 28 Nov 2018 15:42:59 -0800
Message-Id: <20181128234325.110011-2-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00545984033607)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5quHOoLPq4ee9dIJp0uCCER602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aV1ojZY
 pEeohpKvNehO5/ZZq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkBvyMjbyNpr4xR6RL2C9+qlIny++hg9dJLqN5zmWqF/oNe6FVV7drXD
 mtOldfpWzeUCaRHvx+uLGHS3n3Y0pMd0ZyCgxZHINA6A5+7T9o6by6wCf9/ixXi9QE6xc2MJdJIs
 WkULIn/2FBvF31UHbsndehIqUczFWeS6sE8e1b5/UlaX0Ao5X99TlizdjWjXhcukjPvPb2ztUwUU
 F4ekbSpuNzlrea/7iuldgAMiBvdjMcnm029Ym0efSWNMWddmEHoHmFDqewO9xyOqCYO8P1aHcsG0
 kWCiESR44kXyAcFBnvq0JaXhRWKyqy0OhbkmMxu2AdrcZPAiQvyjIZ4LQqnqqLEDUnB02oJPHAlf
 IubJYzA0XAoGECHs14pjPDDBgamvNiA5kjk+kUt44s0jst5ftQCYMxFrGd5PntJYzFtIXwiZYu7W
 2Svn1fA8kAfXby1uhWzfuvHd4y0L/HyfN5U858I8R2vIYlYbA7G/CY3eeSCFRiwDn8j3yWGHtM7w
 dRonBy/PpUxgSFRPcWxJF+/beJHmCfSNEcGdfFKs5M18F1x96tlonSt5Ig9mwLw4vXsdf68W0InH
 /+bTMKNm38MHV+diwrlXuxzeO2WnJyd7g8lLLKZgdBo3YHaSgbLEg7M4I+zZPnIX6k9TnzH5sZcr
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compilation of liblockdep fails, display an error message and exit
immediately. Display compiler warning and error messages that are
generated while building a test. Only run a test if compilation
succeeded.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/run_tests.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index 2e570a188f16..eef3fe4a24fe 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -1,13 +1,16 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-make &> /dev/null
+if ! make >/dev/null; then
+    echo "Building liblockdep failed."
+    echo "FAILED!"
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
@@ -19,9 +22,9 @@ done
 
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
2.20.0.rc0.387.gc7a69e6b6c-goog

