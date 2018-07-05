Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC902168D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ih2MvGIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC902168D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeGESHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:07:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:58704 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeGESGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:06:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 36B39231D49;
        Thu,  5 Jul 2018 14:06:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GAC6ZiagNRyP; Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A80E9231D38;
        Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A80E9231D38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530813971;
        bh=GYuyiiOJ/tsfPKsMFhhoKABESj/3VHxVs9nKv9j5a/o=;
        h=From:To:Date:Message-Id;
        b=ih2MvGIBrKDcAQ75PNvOhCFJU8OQ8byjNvSdZaRklIuIBFdfop7DKWz/YWoo8uYbz
         skCojwqMw9jAgmxs5QRNSOcOiyvfPTcc0wDWccDlucAqGIQwvkHbktsHRk18aCV5f7
         bSPObJdj5ZjKh7KjYi12VdSKlUZ9ZFD3Kp3eWrh0XVGCAYINkYwxJgFMDUy8I/KMK1
         zxaR1wghvaQqVM5wKKKNmI4idiHVh89KlzYc4haTo+HJRGI09BnFC1itq5vhN/sY8k
         pRtgXiJm9ox++dm3t8yAnmGMGcmx+mnkJ4TsAEdCvHpT7DrXRrkPmDq1f7qoqVru9L
         aGnEZvoAuOnFg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Kz9cH4ewJLZj; Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 4E188231D2A;
        Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.18 3/5] rseq: uapi: declare rseq_cs field as union, update includes
Date:   Thu,  5 Jul 2018 14:05:59 -0400
Message-Id: <20180705180601.18423-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring the rseq_cs field as a union between __u64 and two __u32
allows both 32-bit and 64-bit kernels to read the full __u64, and
therefore validate that a 32-bit user-space cleared the upper 32
bits, thus ensuring a consistent behavior between native 32-bit
kernels and 32-bit compat tasks on 64-bit kernels.

Check that the rseq_cs value read is < TASK_SIZE.

The asm/byteorder.h header needs to be included by rseq.h, now
that it is not using linux/types_32_64.h anymore.

Considering that only __32 and __u64 types are declared in linux/rseq.h,
the linux/types.h header should always be included for both kernel and
user-space code: including stdint.h is just for u64 and u32, which are
not used in this header at all.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 include/uapi/linux/rseq.h           | 27 +++++++++++++++++++--------
 kernel/rseq.c                       | 12 +++++++-----
 tools/testing/selftests/rseq/rseq.h | 11 ++++++++++-
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index bf4188c13bec..9a402fdb60e9 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -10,13 +10,8 @@
  * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#ifdef __KERNEL__
-# include <linux/types.h>
-#else
-# include <stdint.h>
-#endif
-
-#include <linux/types_32_64.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
 
 enum rseq_cpu_id_state {
 	RSEQ_CPU_ID_UNINITIALIZED		= -1,
@@ -111,7 +106,23 @@ struct rseq {
 	 * atomicity semantics. This field should only be updated by the
 	 * thread which registered this data structure. Aligned on 64-bit.
 	 */
-	LINUX_FIELD_u32_u64(rseq_cs);
+	union {
+		__u64 ptr64;
+#ifdef __LP64__
+		__u64 ptr;
+#else
+		struct {
+#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined(__BIG_ENDIAN)
+			__u32 padding;		/* Initialized to zero. */
+			__u32 ptr32;
+#else /* LITTLE */
+			__u32 ptr32;
+			__u32 padding;		/* Initialized to zero. */
+#endif /* ENDIAN */
+		} ptr;
+#endif
+	} rseq_cs;
+
 	/*
 	 * Restartable sequences flags field.
 	 *
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 16b38c5342f9..3081e6783cce 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -115,19 +115,21 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
-	unsigned long ptr;
+	u64 ptr;
 	u32 __user *usig;
 	u32 sig;
 	int ret;
 
-	ret = __get_user(ptr, &t->rseq->rseq_cs);
+	ret = __get_user(ptr, &t->rseq->rseq_cs.ptr64);
 	if (ret)
 		return ret;
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
-	urseq_cs = (struct rseq_cs __user *)ptr;
+	if (ptr >= TASK_SIZE)
+		return -EINVAL;
+	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
 	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
 		return -EFAULT;
 
@@ -201,9 +203,9 @@ static int clear_rseq_cs(struct task_struct *t)
 	 * of code outside of the rseq assembly block. This performs
 	 * a lazy clear of the rseq_cs field.
 	 *
-	 * Set rseq_cs to NULL with single-copy atomicity.
+	 * Set rseq_cs to NULL.
 	 */
-	return __put_user(0UL, &t->rseq->rseq_cs);
+	return __put_user(0ULL, &t->rseq->rseq_cs.ptr64);
 }
 
 /*
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index a4684112676c..f2073cfa4448 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -133,6 +133,15 @@ static inline uint32_t rseq_current_cpu(void)
 	return cpu;
 }
 
+static inline void rseq_clear_rseq_cs(void)
+{
+#ifdef __LP64__
+	__rseq_abi.rseq_cs.ptr = 0;
+#else
+	__rseq_abi.rseq_cs.ptr.ptr32 = 0;
+#endif
+}
+
 /*
  * rseq_prepare_unload() should be invoked by each thread using rseq_finish*()
  * at least once between their last rseq_finish*() and library unload of the
@@ -143,7 +152,7 @@ static inline uint32_t rseq_current_cpu(void)
  */
 static inline void rseq_prepare_unload(void)
 {
-	__rseq_abi.rseq_cs = 0;
+	rseq_clear_rseq_cs();
 }
 
 #endif  /* RSEQ_H_ */
-- 
2.11.0

