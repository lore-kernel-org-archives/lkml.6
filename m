Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4136C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A234D20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tr2aobaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A234D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeKATBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:01:24 -0400
Received: from mail.efficios.com ([167.114.142.138]:40692 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKATBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:01:24 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F199D2275EA;
        Thu,  1 Nov 2018 05:59:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Vnb0DReM8XdV; Thu,  1 Nov 2018 05:59:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E3F652275E6;
        Thu,  1 Nov 2018 05:59:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E3F652275E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541066344;
        bh=nYYJcFvICUDMjzNOJyhCR4NQw+WlxHBEchpkM8yLnjY=;
        h=From:To:Date:Message-Id;
        b=tr2aobaE081aHBNc8DLyDEs3pkivRinAGQjktbYFlaKCHWXPyVp+PuMk7R1uv4hO0
         Cdsj8uEI2Y2f4l4fI2i588mh8k0Qy8Co+G4utu3GRL7N+q8nQPwyHad3ioJMSxRon5
         C1rxYscxtH5A/PLadIyxHSVuERlX4HbaWKOo66DLcOPnz1OzbAID1hVyTlOZgTVVHv
         piVQOkKspFwfxLyQz5VfJiELMCQulvZ8dVe0hPm8GIwu9Hhj/Vw6OFpfsSmLh1aGTT
         c2FMsnKJWyceWliNPxs8uiVL56aKkQJhIRtx9Xqfd88QpaTtIHwcdHgraIBBbunXHp
         iIeD9eZKnJyxw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id kOIWBFtv0ZiL; Thu,  1 Nov 2018 05:59:04 -0400 (EDT)
Received: from thinkos.etherlink (sessfw99-sesbfw99-92.ericsson.net [192.176.1.92])
        by mail.efficios.com (Postfix) with ESMTPSA id 015922275CC;
        Thu,  1 Nov 2018 05:58:57 -0400 (EDT)
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
        Shuah Khan <shuah@kernel.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [RFC PATCH for 4.21 01/16] rseq/selftests: Expose reference counter to coexist with glibc (v2)
Date:   Thu,  1 Nov 2018 10:58:29 +0100
Message-Id: <20181101095844.24462-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to integrate rseq into user-space applications, expose a
reference counter TLS as a __rseq_refcount weak symbol so many rseq
users can be linked into the same application (e.g. librseq and glibc).
The reference count ensures that rseq syscall
registration/unregistration happens only for the most early/late user
for each thread, thus ensuring that rseq is registered across the
lifetime of all rseq users for a given thread.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: Joseph Myers <joseph@codesourcery.com>
CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ben Maurer <bmaurer@fb.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Paul Turner <pjt@google.com>
CC: linux-api@vger.kernel.org
---
Changes since v1:
- Error out on refcount overflow/underflow.
- Expose __rseq_refcount weak symbol.
---
 tools/testing/selftests/rseq/rseq.c | 23 ++++++++++++++++-------
 tools/testing/selftests/rseq/rseq.h |  1 +
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4847e97ed049..835e3917d220 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -25,18 +25,19 @@
 #include <syscall.h>
 #include <assert.h>
 #include <signal.h>
+#include <limits.h>
 
 #include "rseq.h"
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
-__attribute__((tls_model("initial-exec"))) __thread
+__attribute__((weak)) __thread
 volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
 
-static __attribute__((tls_model("initial-exec"))) __thread
-volatile int refcount;
+__attribute__((weak)) __thread
+volatile uint32_t __rseq_refcount;
 
 static void signal_off_save(sigset_t *oldset)
 {
@@ -70,7 +71,11 @@ int rseq_register_current_thread(void)
 	sigset_t oldset;
 
 	signal_off_save(&oldset);
-	if (refcount++)
+	if (__rseq_refcount == UINT_MAX) {
+		ret = -1;
+		goto end;
+	}
+	if (__rseq_refcount++)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
 	if (!rc) {
@@ -78,9 +83,9 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = -2;
+		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
-	refcount--;
+	__rseq_refcount--;
 end:
 	signal_restore(oldset);
 	return ret;
@@ -92,7 +97,11 @@ int rseq_unregister_current_thread(void)
 	sigset_t oldset;
 
 	signal_off_save(&oldset);
-	if (--refcount)
+	if (!__rseq_refcount) {
+		ret = -1;
+		goto end;
+	}
+	if (--__rseq_refcount)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
 		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70f9b52..47f815c19cef 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -45,6 +45,7 @@
 #endif
 
 extern __thread volatile struct rseq __rseq_abi;
+extern __thread volatile uint32_t __rseq_refcount;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
 #define rseq_unlikely(x)	__builtin_expect(!!(x), 0)
-- 
2.11.0

