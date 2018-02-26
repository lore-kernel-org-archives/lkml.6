Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeBZLL5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:11:57 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:57885 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeBZLLz (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Mon, 26 Feb 2018 06:11:55 -0500
Message-Id: <5A93F98702000078001ABACC@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 26 Feb 2018 04:11:51 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/include: add instruction suffixes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream gas in the
future (mine does already). Add the missing suffixes here. Note that for
64-bit this means some operations change from being 32-bit to 64-bit.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
If the operand size change for 64-bit is undesirable, further
transformations would be necessary. Likely the best route would be to
fully separate the constant and variable bit position cases from one
another. The variable ones could then continue to stay without insn
suffixes (and these are 64-bit operations already anyway).
---
 arch/x86/include/asm/bitops.h |   29 ++++++++++++++++-------------
 arch/x86/include/asm/percpu.h |    2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

--- 4.16-rc3/arch/x86/include/asm/bitops.h
+++ 4.16-rc3-x86-insn-suffixes/arch/x86/include/asm/bitops.h
@@ -78,7 +78,7 @@ set_bit(long nr, volatile unsigned long
 			: "iq" ((u8)CONST_MASK(nr))
 			: "memory");
 	} else {
-		asm volatile(LOCK_PREFIX "bts %1,%0"
+		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
 			: BITOP_ADDR(addr) : "Ir" (nr) : "memory");
 	}
 }
@@ -94,7 +94,7 @@ set_bit(long nr, volatile unsigned long
  */
 static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("bts %1,%0" : ADDR : "Ir" (nr) : "memory");
+	asm volatile(__ASM_SIZE(bts) " %1,%0" : ADDR : "Ir" (nr) : "memory");
 }
 
 /**
@@ -115,7 +115,7 @@ clear_bit(long nr, volatile unsigned lon
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)~CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX "btr %1,%0"
+		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: BITOP_ADDR(addr)
 			: "Ir" (nr));
 	}
@@ -137,7 +137,7 @@ static __always_inline void clear_bit_un
 
 static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("btr %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
 }
 
 static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
@@ -182,7 +182,7 @@ static __always_inline void __clear_bit_
  */
 static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("btc %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
 }
 
 /**
@@ -201,7 +201,7 @@ static __always_inline void change_bit(l
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX "btc %1,%0"
+		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
 			: BITOP_ADDR(addr)
 			: "Ir" (nr));
 	}
@@ -217,7 +217,8 @@ static __always_inline void change_bit(l
  */
 static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "bts", *addr, "Ir", nr, "%0", c);
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts),
+	                 *addr, "Ir", nr, "%0", c);
 }
 
 /**
@@ -246,7 +247,7 @@ static __always_inline bool __test_and_s
 {
 	bool oldbit;
 
-	asm("bts %2,%1"
+	asm(__ASM_SIZE(bts) " %2,%1"
 	    CC_SET(c)
 	    : CC_OUT(c) (oldbit), ADDR
 	    : "Ir" (nr));
@@ -263,7 +264,8 @@ static __always_inline bool __test_and_s
  */
 static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "btr", *addr, "Ir", nr, "%0", c);
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btr),
+	                 *addr, "Ir", nr, "%0", c);
 }
 
 /**
@@ -286,7 +288,7 @@ static __always_inline bool __test_and_c
 {
 	bool oldbit;
 
-	asm volatile("btr %2,%1"
+	asm volatile(__ASM_SIZE(btr) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit), ADDR
 		     : "Ir" (nr));
@@ -298,7 +300,7 @@ static __always_inline bool __test_and_c
 {
 	bool oldbit;
 
-	asm volatile("btc %2,%1"
+	asm volatile(__ASM_SIZE(btc) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit), ADDR
 		     : "Ir" (nr) : "memory");
@@ -316,7 +318,8 @@ static __always_inline bool __test_and_c
  */
 static __always_inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "btc", *addr, "Ir", nr, "%0", c);
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc),
+	                 *addr, "Ir", nr, "%0", c);
 }
 
 static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
@@ -329,7 +332,7 @@ static __always_inline bool variable_tes
 {
 	bool oldbit;
 
-	asm volatile("bt %2,%1"
+	asm volatile(__ASM_SIZE(bt) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
 		     : "m" (*(unsigned long *)addr), "Ir" (nr));
--- 4.16-rc3/arch/x86/include/asm/percpu.h
+++ 4.16-rc3-x86-insn-suffixes/arch/x86/include/asm/percpu.h
@@ -526,7 +526,7 @@ static inline bool x86_this_cpu_variable
 {
 	bool oldbit;
 
-	asm volatile("bt "__percpu_arg(2)",%1"
+	asm volatile("btl "__percpu_arg(2)",%1"
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
 			: "m" (*(unsigned long __percpu *)addr), "Ir" (nr));
