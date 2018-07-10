Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AF5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44B6208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44B6208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbeGJUZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:25:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbeGJUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:25:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6AKNXuw3266521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jul 2018 13:23:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6AKNXCu3266518;
        Tue, 10 Jul 2018 13:23:33 -0700
Date:   Tue, 10 Jul 2018 13:23:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-ec9c82e03a744e5698bd95eab872855861a821fa@git.kernel.org>
Cc:     torvalds@linux-foundation.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, cl@linux.com, andi@firstfloor.org,
        joelaf@google.com, mingo@kernel.org, linux@arm.linux.org.uk,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        hpa@zytor.com, catalin.marinas@arm.com, mtk.manpages@gmail.com,
        bmaurer@fb.com, boqun.feng@gmail.com, peterz@infradead.org,
        pjt@google.com, paulmck@linux.vnet.ibm.com, davejwatson@fb.com,
        tglx@linutronix.de, rostedt@goodmis.org, will.deacon@arm.com,
        luto@amacapital.net
Reply-To: will.deacon@arm.com, luto@amacapital.net, rostedt@goodmis.org,
          tglx@linutronix.de, davejwatson@fb.com,
          paulmck@linux.vnet.ibm.com, peterz@infradead.org, pjt@google.com,
          boqun.feng@gmail.com, mtk.manpages@gmail.com, bmaurer@fb.com,
          catalin.marinas@arm.com, hpa@zytor.com,
          mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
          linux@arm.linux.org.uk, mingo@kernel.org, joelaf@google.com,
          andi@firstfloor.org, cl@linux.com, linux-kernel@vger.kernel.org,
          josh@joshtriplett.org, torvalds@linux-foundation.org
In-Reply-To: <20180709195155.7654-5-mathieu.desnoyers@efficios.com>
References: <20180709195155.7654-5-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] rseq: uapi: Declare rseq_cs field as union,
 update includes
Git-Commit-ID: ec9c82e03a744e5698bd95eab872855861a821fa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ec9c82e03a744e5698bd95eab872855861a821fa
Gitweb:     https://git.kernel.org/tip/ec9c82e03a744e5698bd95eab872855861a821fa
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 9 Jul 2018 15:51:53 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Jul 2018 22:18:52 +0200

rseq: uapi: Declare rseq_cs field as union, update includes

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

Use copy_from_user()/clear_user() to interact with a 64-bit field,
because arm32 does not implement 64-bit __get_user, and ppc32 does not
64-bit get_user. Considering that the rseq_cs pointer does not need to
be loaded/stored with single-copy atomicity from the kernel anymore, we
can simply use copy_from_user()/clear_user().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-api@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Paul Turner <pjt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Chris Lameter <cl@linux.com>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180709195155.7654-5-mathieu.desnoyers@efficios.com

---
 include/uapi/linux/rseq.h           | 27 +++++++++++++++++++--------
 kernel/rseq.c                       | 15 +++++++++------
 tools/testing/selftests/rseq/rseq.h | 11 ++++++++++-
 3 files changed, 38 insertions(+), 15 deletions(-)

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
index 2a7748675be7..c6242d8594dc 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -115,19 +115,20 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
-	unsigned long ptr;
+	u64 ptr;
 	u32 __user *usig;
 	u32 sig;
 	int ret;
 
-	ret = get_user(ptr, &t->rseq->rseq_cs);
-	if (ret)
-		return ret;
+	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
+		return -EFAULT;
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
 
@@ -203,7 +204,9 @@ static int clear_rseq_cs(struct task_struct *t)
 	 *
 	 * Set rseq_cs to NULL.
 	 */
-	return put_user(0UL, &t->rseq->rseq_cs);
+	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
+		return -EFAULT;
+	return 0;
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
