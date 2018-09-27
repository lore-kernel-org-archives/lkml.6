Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D765C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2D21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XUQ3Ulog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E2D21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeI1A7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:59:08 -0400
Received: from mail.efficios.com ([167.114.142.138]:45756 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1A7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:59:08 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 322B7242DBE;
        Thu, 27 Sep 2018 14:39:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ea_gkhkRGZmP; Thu, 27 Sep 2018 14:39:28 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 55AB0242DBA;
        Thu, 27 Sep 2018 14:39:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 55AB0242DBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1538073568;
        bh=me7eF6hZJHSTQ9fZBJ6CJsZctm5dT9V6mOScDjkd8iM=;
        h=From:To:Date:Message-Id;
        b=XUQ3UlogU1aj7AC/UBgARlnBJu6jOv812zU1OZ1wJkc1TgyltEC5SHLWAZkNtWQ8a
         q72T7mCmQA2epvNsWhHFzuy5ZFGYxmsb6g6nCVYv8DOwvfvqxthw8LkLxzjHbTmoVk
         8CvoPo6IxaYCYybNN1tYpcp6RyJOMFI4B+dU3ZL4RNVIje0jljFSzKFMAuk+uvSaqL
         urWOB0nnR7/6erF6e9EMUou+f+xpZZsp/gQgfXdad/ehqslXfBhMrcUCZfArZn1zjo
         vwHLkpWHIm0PHUnnICdO2kcwV/QkkkiNyXWJP0+3JyTzoWEkzg3Dv9kXumHzYAZ2GP
         IC81YcN1kgH2w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7cA2_8YeuvSY; Thu, 27 Sep 2018 14:39:28 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id D64AB242DB3;
        Thu, 27 Sep 2018 14:39:27 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] rseq/selftests: fix parametrized test with -fpie
Date:   Thu, 27 Sep 2018 14:39:19 -0400
Message-Id: <20180927183919.7461-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86-64, the parametrized selftest code for rseq crashes with a
segmentation fault when compiled with -fpie. This happens when the
param_test binary is loaded at an address beyond 32-bit on x86-64.

The issue is caused by use of a 32-bit register to hold the address
of the loop counter variable.

Fix this by using a 64-bit register to calculate the address of the
loop counter variables as an offset from rip.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org> # v4.18
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
Changes since v1:
- Update email address for Shuah Khan based on updated MAINTAINERS
  email address,
- Rebase on v4.19-rc5.
---
 tools/testing/selftests/rseq/param_test.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 642d4e12abea..eec2663261f2 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -56,15 +56,13 @@ unsigned int yield_mod_cnt, nr_abort;
 			printf(fmt, ## __VA_ARGS__);	\
 	} while (0)
 
-#if defined(__x86_64__) || defined(__i386__)
+#ifdef __i386__
 
 #define INJECT_ASM_REG	"eax"
 
 #define RSEQ_INJECT_CLOBBER \
 	, INJECT_ASM_REG
 
-#ifdef __i386__
-
 #define RSEQ_INJECT_ASM(n) \
 	"mov asm_loop_cnt_" #n ", %%" INJECT_ASM_REG "\n\t" \
 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
@@ -76,9 +74,16 @@ unsigned int yield_mod_cnt, nr_abort;
 
 #elif defined(__x86_64__)
 
+#define INJECT_ASM_REG_P	"rax"
+#define INJECT_ASM_REG		"eax"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG_P \
+	, INJECT_ASM_REG
+
 #define RSEQ_INJECT_ASM(n) \
-	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG "\n\t" \
-	"mov (%%" INJECT_ASM_REG "), %%" INJECT_ASM_REG "\n\t" \
+	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG_P "\n\t" \
+	"mov (%%" INJECT_ASM_REG_P "), %%" INJECT_ASM_REG "\n\t" \
 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
 	"jz 333f\n\t" \
 	"222:\n\t" \
@@ -86,10 +91,6 @@ unsigned int yield_mod_cnt, nr_abort;
 	"jnz 222b\n\t" \
 	"333:\n\t"
 
-#else
-#error "Unsupported architecture"
-#endif
-
 #elif defined(__s390__)
 
 #define RSEQ_INJECT_INPUT \
-- 
2.17.1

