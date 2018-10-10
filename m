Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A80C46463
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E21D2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gpjC108i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E21D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeJKCnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:43:40 -0400
Received: from mail.efficios.com ([167.114.142.138]:32792 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeJKCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:39 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F06FA183B56;
        Wed, 10 Oct 2018 15:20:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id q4DZqpoIpu0W; Wed, 10 Oct 2018 15:20:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2AC14183B53;
        Wed, 10 Oct 2018 15:20:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2AC14183B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199205;
        bh=Cfb0if2j7qr27a8wQq79l8o8zLis2u6tHcSE1XnbL0Q=;
        h=From:To:Date:Message-Id;
        b=gpjC108iIxTzdhVPF8J7G3bZ7LzBW9DRo6tk6ZTsopfcnZXrsZS2US9xtKLo8ZgJJ
         Rgb6twi9zHkLtfUk5U6+bNXJykO2o+kPkqZfjbMELhp6awgQc8qkZx8/nvjTv9WrKM
         EL2/N+i1ylQKroNtgq3A8grSNXu7XC1oZBw1COaq6NO/X3Twhaty7mlUKPmNjS5zMP
         lLLSrVKwdyg/Ql8IU9+KE7IVFdOsubKdyOf3ix4+MU0ekVi5pHCufe9mKbbr8bjTWD
         Zc+UWDWuH+RE9h6G7zVjOtowkFl4p82IV+LO6VbiL0FV7RAYZPxslLz1t+E7KkWUfV
         DOAtCVb7wk2bA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id tGcDv-7_nAH2; Wed, 10 Oct 2018 15:20:05 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 006BE183B32;
        Wed, 10 Oct 2018 15:20:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH for 4.21 02/16] rseq/selftests: Adapt number of threads to the number of detected cpus
Date:   Wed, 10 Oct 2018 15:19:22 -0400
Message-Id: <20181010191936.7495-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On smaller systems, running a test with 200 threads can take a long
time on machines with smaller number of CPUs.

Detect the number of online cpus at test runtime, and multiply that
by 6 to have 6 rseq threads per cpu preempting each other.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: linux-kselftest@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 3acd6d75ff9f..e426304fd4a0 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+ or MIT
 
+NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
+
 EXTRA_ARGS=${@}
 
 OLDIFS="$IFS"
@@ -28,15 +30,16 @@ IFS="$OLDIFS"
 
 REPS=1000
 SLOW_REPS=100
+NR_THREADS=$((6*${NR_CPUS}))
 
 function do_tests()
 {
 	local i=0
 	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
 		echo "Running test ${TEST_NAME[$i]}"
-		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running compare-twice test ${TEST_NAME[$i]}"
-		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
-- 
2.11.0

