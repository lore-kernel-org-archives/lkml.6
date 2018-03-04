Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbeCDPCa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 10:02:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeCDPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 10:02:29 -0500
Date: Sun, 4 Mar 2018 16:02:26 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 fixes for 4.16
Message-ID: <alpine.DEB.2.21.1803041558530.2394@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A small set of fixes for x86:

 - Add missing instruction suffixes to assembly code so it can be compiled
   by newer GAS versions without warnings.

 - Switch refcount WARN exceptions to UD2 as we did in general

 - Make the reboot on Intel Edison platforms work

 - A small documentation update so text and sample command match

Thanks,

	tglx

------------------>
Jan Beulich (2):
      x86/entry/64: Add instruction suffix
      x86/asm: Add instruction suffixes to bitops

Kees Cook (1):
      x86/refcounts: Switch to UD2 for exceptions

Li RongQing (1):
      Documentation, x86, resctrl: Make text and sample command match

Sebastian Panceac (1):
      x86/platform/intel-mid: Handle Intel Edison reboot correctly


 Documentation/x86/intel_rdt_ui.txt      |  2 +-
 arch/x86/entry/entry_64.S               |  2 +-
 arch/x86/include/asm/bitops.h           | 29 ++++++++++++++++-------------
 arch/x86/include/asm/percpu.h           |  2 +-
 arch/x86/include/asm/refcount.h         |  2 +-
 arch/x86/platform/intel-mid/intel-mid.c |  2 +-
 6 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index 756fd76b78a6..71c30984e94d 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -671,7 +671,7 @@ occupancy of the real time threads on these cores.
 # mkdir p1
 
 Move the cpus 4-7 over to p1
-# echo f0 > p0/cpus
+# echo f0 > p1/cpus
 
 View the llc occupancy snapshot
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d5c7f18f79ac..805f52703ee3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -55,7 +55,7 @@ END(native_usergs_sysret64)
 
 .macro TRACE_IRQS_FLAGS flags:req
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bt	$9, \flags		/* interrupts off? */
+	btl	$9, \flags		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON
 1:
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
diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index d65171120e90..4cf11d88d3b3 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -17,7 +17,7 @@
 #define _REFCOUNT_EXCEPTION				\
 	".pushsection .text..refcount\n"		\
 	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
-	"112:\t" ASM_UD0 "\n"				\
+	"112:\t" ASM_UD2 "\n"				\
 	ASM_UNREACHABLE					\
 	".popsection\n"					\
 	"113:\n"					\
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2c67bae6bb53..fb1df9488e98 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
 
 static void intel_mid_reboot(void)
 {
-	intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
+	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
 static unsigned long __init intel_mid_calibrate_tsc(void)
