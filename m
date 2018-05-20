Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeETARj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 20:17:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752389AbeETARh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 20:17:37 -0400
From: Mark Salter <msalter@redhat.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RHEL-8] arm64: add missing early clobber in atomic64_dec_if_positive()
Date: Sat, 19 May 2018 20:17:26 -0400
Message-Id: <20180520001726.27808-1-msalter@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running a kernel compiled with gcc8 on a machine using LSE, I
get:

 Unable to handle kernel paging request at virtual address 11111122222221
 Mem abort info:
   ESR = 0x96000021
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000021
   CM = 0, WnR = 0
 [0011111122222221] address between user and kernel address ranges
 Internal error: Oops: 96000021 [#1] SMP
 ...
 pstate: 20400009 (nzCv daif +PAN -UAO)
 pc : test_atomic64+0x1360/0x155c
 lr : 0x1111111122222222
 sp : ffff00000bc6fd60
 x29: ffff00000bc6fd60 x28: 0000000000000000
 x27: 0000000000000000 x26: ffff000008f04460
 x25: ffff000008de0584 x24: ffff000008e91060
 x23: aaa31337c001d00e x22: 999202269ddfadeb
 x21: aaa31337c001d00c x20: bbb42448e223f22f
 x19: aaa31337c001d00d x18: 0000000000000010
 x17: 0000000000000222 x16: 00000000000010e0
 x15: ffffffffffffffff x14: ffff000009233c08
 x13: ffff000089925a8f x12: ffff000009925a97
 x11: ffff00000927f000 x10: ffff00000bc6fac0
 x9 : 00000000ffffffd0 x8 : ffff00000853fdf8
 x7 : 00000000deadbeef x6 : ffff00000bc6fda0
 x5 : aaa31337c001d00d x4 : deadbeefdeafcafe
 x3 : aaa31337c001d00d x2 : aaa31337c001d00e
 x1 : 1111111122222222 x0 : 1111111122222221
 Process swapper/0 (pid: 1, stack limit = 0x000000008209f908)
 Call trace:
  test_atomic64+0x1360/0x155c
  test_atomics_init+0x10/0x28
  do_one_initcall+0x134/0x160
  kernel_init_freeable+0x18c/0x21c
  kernel_init+0x18/0x108
  ret_from_fork+0x10/0x1c
 Code: f90023e1 f940001e f10007c0 540000ab (c8fefc00)
 ---[ end trace 29569e7320c6e926 ]---

The fault happens at the casal insn of inlined atomic64_dec_if_positive().
The inline asm code in that function has:

	"1:	ldr	x30, %[v]\n"
	"	subs	%[ret], x30, #1\n"
	"	b.lt	2f\n"
	"	casal	x30, %[ret], %[v]\n"
	"	sub	x30, x30, #1\n"
	"	sub	x30, x30, %[ret]\n"
	"	cbnz	x30, 1b\n"
	"2:")
	: [ret] "+r" (x0), [v] "+Q" (v->counter)

gcc8 used register x0 for both [ret] and [v] and the subs was
clobbering [v] before it was used for casal. Gcc is free to do
this because [ret] lacks an early clobber modifier. So add one
to tell gcc a separate register is needed for [v].

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/include/asm/atomic_lse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 9ef0797380cb..99fa69c9c3cf 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -435,7 +435,7 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	"	sub	x30, x30, %[ret]\n"
 	"	cbnz	x30, 1b\n"
 	"2:")
-	: [ret] "+r" (x0), [v] "+Q" (v->counter)
+	: [ret] "+&r" (x0), [v] "+Q" (v->counter)
 	:
 	: __LL_SC_CLOBBERS, "cc", "memory");
 
-- 
2.17.0
