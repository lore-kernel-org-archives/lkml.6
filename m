Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeFERCQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751819AbeFERCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:02:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Martin <dave.martin@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, Mark Salter <msalter@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.4 01/37] arm64: lse: Add early clobbers to some input/output asm operands
Date: Tue,  5 Jun 2018 19:01:06 +0200
Message-Id: <20180605170108.980869325@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 32c3fa7cdf0c4a3eb8405fc3e13398de019e828b upstream.

For LSE atomics that read and write a register operand, we need to
ensure that these operands are annotated as "early clobber" if the
register is written before all of the input operands have been consumed.
Failure to do so can result in the compiler allocating the same register
to both operands, leading to splats such as:

 Unable to handle kernel paging request at virtual address 11111122222221
 [...]
 x1 : 1111111122222222 x0 : 1111111122222221
 Process swapper/0 (pid: 1, stack limit = 0x000000008209f908)
 Call trace:
  test_atomic64+0x1360/0x155c

where x0 has been allocated as both the value to be stored and also the
atomic_t pointer.

This patch adds the missing clobbers.

Cc: <stable@vger.kernel.org>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Reported-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/include/asm/atomic_lse.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -114,7 +114,7 @@ static inline void atomic_and(int i, ato
 	/* LSE atomics */
 	"	mvn	%w[i], %w[i]\n"
 	"	stclr	%w[i], %[v]")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
+	: [i] "+&r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
 	: "x30");
 }
@@ -131,7 +131,7 @@ static inline void atomic_sub(int i, ato
 	/* LSE atomics */
 	"	neg	%w[i], %w[i]\n"
 	"	stadd	%w[i], %[v]")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
+	: [i] "+&r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
 	: "x30");
 }
@@ -151,7 +151,7 @@ static inline int atomic_sub_return##nam
 	"	neg	%w[i], %w[i]\n"					\
 	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
 	"	add	%w[i], %w[i], w30")				\
-	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
+	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
 	: "x30" , ##cl);						\
 									\
@@ -255,7 +255,7 @@ static inline void atomic64_and(long i,
 	/* LSE atomics */
 	"	mvn	%[i], %[i]\n"
 	"	stclr	%[i], %[v]")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
+	: [i] "+&r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
 	: "x30");
 }
@@ -272,7 +272,7 @@ static inline void atomic64_sub(long i,
 	/* LSE atomics */
 	"	neg	%[i], %[i]\n"
 	"	stadd	%[i], %[v]")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
+	: [i] "+&r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
 	: "x30");
 }
@@ -292,7 +292,7 @@ static inline long atomic64_sub_return##
 	"	neg	%[i], %[i]\n"					\
 	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
 	"	add	%[i], %[i], x30")				\
-	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
+	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
 	: "x30" , ##cl);						\
 									\
@@ -412,7 +412,7 @@ static inline long __cmpxchg_double##nam
 	"	eor	%[old1], %[old1], %[oldval1]\n"			\
 	"	eor	%[old2], %[old2], %[oldval2]\n"			\
 	"	orr	%[old1], %[old1], %[old2]")			\
-	: [old1] "+r" (x0), [old2] "+r" (x1),				\
+	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
 	  [v] "+Q" (*(unsigned long *)ptr)				\
 	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
 	  [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)		\
