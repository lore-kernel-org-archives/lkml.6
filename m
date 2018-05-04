Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeEDRkF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:40:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57404 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbeEDRkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:40:01 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        will.deacon@arm.com
Subject: [PATCH 4/6] arm64: fix assembly constraints for cmpxchg
Date: Fri,  4 May 2018 18:39:35 +0100
Message-Id: <20180504173937.25300-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504173937.25300-1-mark.rutland@arm.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our LL/SC cmpxchg assembly uses "Lr" as the constraint for old, which
allows either an integer constant suitable for a 64-bit logical
oepration, or a register.

However, this assembly is also used for 32-bit cases (where we
explicitly add a 'w' prefix to the output format), where the set of
valid immediates differ, and we should use a 'Kr' constraint.

In some cases, this can result in build failures, when GCC selects an
immediate which is valid for a 64-bit logical operation, but we try to
assemble a 32-bit logical operation:

[mark@lakrids:~/src/linux]% uselinaro 17.05 make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- net/sunrpc/auth_gss/svcauth_gss.o
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     scripts/mod/devicetable-offsets.h
  CC      net/sunrpc/auth_gss/svcauth_gss.o
/tmp/ccj04KVh.s: Assembler messages:
/tmp/ccj04KVh.s:325: Error: immediate out of range at operand 3 -- `eor w2,w1,4294967295'
scripts/Makefile.build:324: recipe for target 'net/sunrpc/auth_gss/svcauth_gss.o' failed
make[1]: *** [net/sunrpc/auth_gss/svcauth_gss.o] Error 1
Makefile:1704: recipe for target 'net/sunrpc/auth_gss/svcauth_gss.o' failed
make: *** [net/sunrpc/auth_gss/svcauth_gss.o] Error 2

Note that today we largely avoid the specific failure above because GCC
happens to already have the value in a register, and in most cases uses
that rather than generating the immediate. The following code added to
an arbitrary file will cause the same failure:

unsigned int test_cmpxchg(unsigned int *l)
{
       return cmpxchg(l, -1, 0);
}

While it would seem that we could conditionally use the 'K' constraint,
this seems to be handled erroneously by GCC (at least versions 6.3 and
7.1), with the same immediates being used, despite not being permitted
for 32-bit logical operations.

Thus we must avoid the use of an immediate in order to prevent failures
as above.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index f5a2d09afb38..3175f4982682 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -267,7 +267,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 	"2:"								\
 	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
 	  [v] "+Q" (*(unsigned long *)ptr)				\
-	: [old] "Lr" (old), [new] "r" (new)				\
+	: [old] "r" (old), [new] "r" (new)				\
 	: cl);								\
 									\
 	return oldval;							\
-- 
2.11.0
