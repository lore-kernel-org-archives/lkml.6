Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeEOV0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:26:21 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48538 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752891AbeEOV0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:26:19 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>
Subject: [RFC 8/8] bitops: prevent compiler inline decision distortion
Date: Tue, 15 May 2018 07:11:24 -0700
Message-ID: <20180515141124.84254-18-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places in the kernel in which there is a condition
that is based on whether the input is known to be constant in
compilation time. If it is, there are complex computations, which only
take place during compilation time.

Although this scheme works correctly, when GCC computes the expected
cost of this code in time and size, it disregards the fact that the
computations of the "constant" case will not take place during runtime
for the non-constant case. The cost of these functions is considered to
be much higher.  As a result, inline and branching decisions of the
compiler are distorted. Specifically, functions are less likely to be
inlined due to their preserved big size and execution time.

One of this cases is test_bit() which performs some computations for
constant inputs.

The solution is to use __builtin_choose_expr() to detect whether the
input is constant instead of a C condition. GCC evaluates the builtin
earlier, which allows it to improve code-generation decisions.

This patch allows function such as bitmap_pos_to_ord() to be inlined.
Its overall effect on size:

   text	   data	    bss	    dec	    hex	filename
18149165 10064176 2936832 31150173 1db505d ./vmlinux before
18149210 10064048 2936832 31150090 1db500a ./vmlinux after (-83)

Static text symbols:
Before:	39643
After:	39632	(-11)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 9f645ba57dbb..f1cb1c9125a9 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -349,10 +349,10 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 static bool test_bit(int nr, const volatile unsigned long *addr);
 #endif
 
-#define test_bit(nr, addr)			\
-	(__builtin_constant_p((nr))		\
-	 ? constant_test_bit((nr), (addr))	\
-	 : variable_test_bit((nr), (addr)))
+#define test_bit(nr, addr)					\
+	__builtin_choose_expr(__builtin_constant_p((nr)),	\
+		constant_test_bit((nr), (addr)),		\
+		variable_test_bit((nr), (addr)))
 
 /**
  * __ffs - find first set bit in word
-- 
2.17.0
