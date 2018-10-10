Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27942C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B132082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kHk8BaUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B132082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJKCng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:43:36 -0400
Received: from mail.efficios.com ([167.114.142.138]:60960 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeJKCng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EBCF4183B3F;
        Wed, 10 Oct 2018 15:20:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZarWOQeCeu7k; Wed, 10 Oct 2018 15:20:01 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B935A183B28;
        Wed, 10 Oct 2018 15:20:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B935A183B28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199201;
        bh=W9+7YUDhhfJN0h5lP3hptKUVRtrFuDrfUHKAQiTlV2Y=;
        h=From:To:Date:Message-Id;
        b=kHk8BaUtgcpzWncfzeMvw/MKwjHPUtweBGpZ3m9wWnu0emUK9OYAmv+Rx36f+g/10
         oNYJfhjmNhcr0cxccT0purUjbk0HU1Y9gPjx/2CHdzQNdiTVXBZ/OIk79I4sEdtgHg
         mLcbkD/VK/frVRiIWFsiDddaB6CR1Fa7XRphP5n28QhwOFXZn26ijdKD98dI8+eFwu
         8aPPhasSiM3mwgjyW1+NOLXFFpWZXB+RJmQtf+3YC6kymNX8jHDaFvtp7GTQudRVwl
         i/z967v3O+k6YvxYXOIP6nI/+MHOPaFcj/hWR5Yz+JV3JoNKnyFuR0nT3x4Baj4Hbr
         rnZap3bC4G1RA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id BICCTx2yh6d3; Wed, 10 Oct 2018 15:20:01 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id A1258183B05;
        Wed, 10 Oct 2018 15:19:57 -0400 (EDT)
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
Subject: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference counter to coexist with glibc
Date:   Wed, 10 Oct 2018 15:19:21 -0400
Message-Id: <20181010191936.7495-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to integrate rseq into user-space applications, add a reference
counter field after the struct rseq TLS ABI so many rseq users can be
linked into the same application (e.g. librseq and glibc). The
reference count ensures that rseq syscall registration/unregistration
happens only for the most early/late user for each thread, thus ensuring
that rseq is registered across the lifetime of all rseq users for a
given thread.

Therefore, struct rseq contains the fields shared between kernel
and user-space, and represents the ABI between kernel and user-space.
The extra field added after struct rseq is an ABI between user-space
executable and libraries, but the kernel does not care about that field,
so it is not part of the Linux uapi.

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
 tools/testing/selftests/rseq/rseq.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4847e97ed049..7e9ae973f786 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -30,13 +30,29 @@
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
-__attribute__((tls_model("initial-exec"))) __thread
-volatile struct rseq __rseq_abi = {
+/*
+ * linux/rseq.h defines struct rseq as aligned on 32 bytes. The kernel ABI
+ * size is 20 bytes. For support of multiple rseq users within a process,
+ * user-space defines an extra 4 bytes field as a reference count, for a
+ * total of 24 bytes.
+ */
+struct libc_rseq {
+	/* kernel-userspace ABI. */
+	__u32 cpu_id_start;
+	__u32 cpu_id;
+	__u64 rseq_cs;
+	__u32 flags;
+	/* user-space ABI. */
+	__u32 refcount;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+__attribute__((visibility("hidden"))) __thread
+volatile struct libc_rseq __lib_rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
 
-static __attribute__((tls_model("initial-exec"))) __thread
-volatile int refcount;
+extern __attribute__((weak, alias("__lib_rseq_abi"))) __thread
+volatile struct rseq __rseq_abi;
 
 static void signal_off_save(sigset_t *oldset)
 {
@@ -70,7 +86,7 @@ int rseq_register_current_thread(void)
 	sigset_t oldset;
 
 	signal_off_save(&oldset);
-	if (refcount++)
+	if (__lib_rseq_abi.refcount++)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
 	if (!rc) {
@@ -78,9 +94,9 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = -2;
+		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
-	refcount--;
+	__lib_rseq_abi.refcount--;
 end:
 	signal_restore(oldset);
 	return ret;
@@ -92,7 +108,7 @@ int rseq_unregister_current_thread(void)
 	sigset_t oldset;
 
 	signal_off_save(&oldset);
-	if (--refcount)
+	if (--__lib_rseq_abi.refcount)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
 		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
-- 
2.11.0

