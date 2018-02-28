Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeB1OWx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:22:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeB1OWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:22:51 -0500
Date: Wed, 28 Feb 2018 06:22:43 -0800
From: tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-22636f8c9511245cb3c8412039f1dd95afb3aa59@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jbeulich@suse.com, tglx@linutronix.de,
        JBeulich@suse.com, mingo@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, JBeulich@suse.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jbeulich@suse.com, tglx@linutronix.de
In-Reply-To: <5A93F98702000078001ABACC@prv-mh.provo.novell.com>
References: <5A93F98702000078001ABACC@prv-mh.provo.novell.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/asm: Add instruction suffixes to bitops
Git-Commit-ID: 22636f8c9511245cb3c8412039f1dd95afb3aa59
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  22636f8c9511245cb3c8412039f1dd95afb3aa59
Gitweb:     https://git.kernel.org/tip/22636f8c9511245cb3c8412039f1dd95afb3aa59
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 26 Feb 2018 04:11:51 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 15:18:41 +0100

x86/asm: Add instruction suffixes to bitops

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream gas in the
future (mine does already). Add the missing suffixes here. Note that for
64-bit this means some operations change from being 32-bit to 64-bit.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/5A93F98702000078001ABACC@prv-mh.provo.novell.com

---
 arch/x86/include/asm/bitops.h | 29 ++++++++++++++++-------------
 arch/x86/include/asm/percpu.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 3fa039855b8f..9f645ba57dbb 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -78,7 +78,7 @@ set_bit(long nr, volatile unsigned long *addr)
 			: "iq" ((u8)CONST_MASK(nr))
 			: "memory");
 	} else {
-		asm volatile(LOCK_PREFIX "bts %1,%0"
+		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
 			: BITOP_ADDR(addr) : "Ir" (nr) : "memory");
 	}
 }
@@ -94,7 +94,7 @@ set_bit(long nr, volatile unsigned long *addr)
  */
 static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("bts %1,%0" : ADDR : "Ir" (nr) : "memory");
+	asm volatile(__ASM_SIZE(bts) " %1,%0" : ADDR : "Ir" (nr) : "memory");
 }
 
 /**
@@ -115,7 +115,7 @@ clear_bit(long nr, volatile unsigned long *addr)
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)~CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX "btr %1,%0"
+		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: BITOP_ADDR(addr)
 			: "Ir" (nr));
 	}
@@ -137,7 +137,7 @@ static __always_inline void clear_bit_unlock(long nr, volatile unsigned long *ad
 
 static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("btr %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
 }
 
 static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
@@ -182,7 +182,7 @@ static __always_inline void __clear_bit_unlock(long nr, volatile unsigned long *
  */
 static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("btc %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
 }
 
 /**
@@ -201,7 +201,7 @@ static __always_inline void change_bit(long nr, volatile unsigned long *addr)
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX "btc %1,%0"
+		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
 			: BITOP_ADDR(addr)
 			: "Ir" (nr));
 	}
@@ -217,7 +217,8 @@ static __always_inline void change_bit(long nr, volatile unsigned long *addr)
  */
 static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "bts", *addr, "Ir", nr, "%0", c);
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts),
+	                 *addr, "Ir", nr, "%0", c);
 }
 
 /**
@@ -246,7 +247,7 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
 {
 	bool oldbit;
 
-	asm("bts %2,%1"
+	asm(__ASM_SIZE(bts) " %2,%1"
 	    CC_SET(c)
 	    : CC_OUT(c) (oldbit), ADDR
 	    : "Ir" (nr));
@@ -263,7 +264,8 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
  */
 static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "btr", *addr, "Ir", nr, "%0", c);
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btr),
+	                 *addr, "Ir", nr, "%0", c);
 }
 
 /**
@@ -286,7 +288,7 @@ static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long
 {
 	bool oldbit;
 
-	asm volatile("btr %2,%1"
+	asm volatile(__ASM_SIZE(btr) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit), ADDR
 		     : "Ir" (nr));
@@ -298,7 +300,7 @@ static __always_inline bool __test_and_change_bit(long nr, volatile unsigned lon
 {
 	bool oldbit;
 
-	asm volatile("btc %2,%1"
+	asm volatile(__ASM_SIZE(btc) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit), ADDR
 		     : "Ir" (nr) : "memory");
@@ -316,7 +318,8 @@ static __always_inline bool __test_and_change_bit(long nr, volatile unsigned lon
  */
 static __always_inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	GEN_BINARY_RMWcc(LOCK_PREFIX "btc", *addr, "Ir", nr, "%0", c);
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc),
+	                 *addr, "Ir", nr, "%0", c);
 }
 
 static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
@@ -329,7 +332,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 {
 	bool oldbit;
 
-	asm volatile("bt %2,%1"
+	asm volatile(__ASM_SIZE(bt) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
 		     : "m" (*(unsigned long *)addr), "Ir" (nr));
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index ba3c523aaf16..a06b07399d17 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -526,7 +526,7 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 {
 	bool oldbit;
 
-	asm volatile("bt "__percpu_arg(2)",%1"
+	asm volatile("btl "__percpu_arg(2)",%1"
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
 			: "m" (*(unsigned long __percpu *)addr), "Ir" (nr));
