Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225uisU7ySav94QA9XIbJSEdjAxiT3Milx0KYAxnKP8OHkT6pxB293szWLjHlnbshRJrhgFR
ARC-Seal: i=1; a=rsa-sha256; t=1518709352; cv=none;
        d=google.com; s=arc-20160816;
        b=NtwQsv+br3jLCLe5CH4Ap/c2z9dztmbyCyHYmTLagtwcKfJRXn2n2eTfzrxKCwPQ2R
         vX0ZT+j0ruOopEq/x9M/i7fJQZqbjEV1c4LW3UggWBROwqAQGzEEmuBW+bgPfRSynNkn
         XebIeL/BPMWesRsv17ge8Aa7t/6emDDYJ1O4lbCC8NNpwECLc70N8G+SvbsmqeZyU0fd
         BKVk7FmvubVT88Hd1vLJZGEnGOsf0t949c/DLyJVZyMEN47WwGz3vA1wLQAuPYjFtUae
         SGrtdL8xwmQrUnxBQeYjwRhp8NHC9ZjKgH0gMZpo51QWdfnJRctB44Bz3hZx1gMGz1k0
         T1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uH0h5HN8zB2XVdo/e0yRXMyhEY0Hf6n6vkgc9Y7JXvk=;
        b=e+Q8QNWx5c7dvWt/0482fDPUoRrKWX1G0dQHhcNVSh/gwngUDr7lZUWFYqcMI21B2g
         h3IdcXd6NyczJBcuuaNZR1OV/IC7GgNs65eXivpAlYdC4OTw+cNM/34Ecc1kh9NWx3Fc
         aTH+67QHOhVMrVzvlYmvXSJ42HWbO2XNScfYncsDYrGKpOCNzhaneh+Hs6aRiKpFieEt
         AKEKEx0ZSsGTvMoeb4Er4TC0rHcbkTgUt1xrGuP80Mfu3swBYxbZihgryGqWvpoZhh9K
         znUyHJJ1lBIArvTJNKIfAOKJ/xmUTuMaO2sIjx50TSiq9jGblMrSd4qPerhdt1YjVHtU
         kCWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 051/202] [Variant 1/Spectre-v1] arm64: Make USER_DS an inclusive limit
Date: Thu, 15 Feb 2018 16:15:51 +0100
Message-Id: <20180215151715.893577797@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481521134091247?=
X-GMAIL-MSGID: =?utf-8?q?1592482177808544853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>


Commit 51369e398d0d upstream.

Currently, USER_DS represents an exclusive limit while KERNEL_DS is
inclusive. In order to do some clever trickery for speculation-safe
masking, we need them both to behave equivalently - there aren't enough
bits to make KERNEL_DS exclusive, so we have precisely one option. This
also happens to correct a longstanding false negative for a range
ending on the very top byte of kernel memory.

Mark Rutland points out that we've actually got the semantics of
addresses vs. segments muddled up in most of the places we need to
amend, so shuffle the {USER,KERNEL}_DS definitions around such that we
can correct those properly instead of just pasting "-1"s everywhere.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/processor.h |    3 ++
 arch/arm64/include/asm/uaccess.h   |   45 +++++++++++++++++++++----------------
 arch/arm64/kernel/entry.S          |    4 +--
 arch/arm64/mm/fault.c              |    4 +--
 4 files changed, 33 insertions(+), 23 deletions(-)

--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -21,6 +21,9 @@
 
 #define TASK_SIZE_64		(UL(1) << VA_BITS)
 
+#define KERNEL_DS	UL(-1)
+#define USER_DS		(TASK_SIZE_64 - 1)
+
 #ifndef __ASSEMBLY__
 
 /*
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -35,10 +35,7 @@
 #include <asm/compiler.h>
 #include <asm/extable.h>
 
-#define KERNEL_DS	(-1UL)
 #define get_ds()	(KERNEL_DS)
-
-#define USER_DS		TASK_SIZE_64
 #define get_fs()	(current_thread_info()->addr_limit)
 
 static inline void set_fs(mm_segment_t fs)
@@ -66,22 +63,32 @@ static inline void set_fs(mm_segment_t f
  * Returns 1 if the range is valid, 0 otherwise.
  *
  * This is equivalent to the following test:
- * (u65)addr + (u65)size <= current->addr_limit
- *
- * This needs 65-bit arithmetic.
+ * (u65)addr + (u65)size <= (u65)current->addr_limit + 1
  */
-#define __range_ok(addr, size)						\
-({									\
-	unsigned long __addr = (unsigned long)(addr);			\
-	unsigned long flag, roksum;					\
-	__chk_user_ptr(addr);						\
-	asm("adds %1, %1, %3; ccmp %1, %4, #2, cc; cset %0, ls"		\
-		: "=&r" (flag), "=&r" (roksum)				\
-		: "1" (__addr), "Ir" (size),				\
-		  "r" (current_thread_info()->addr_limit)		\
-		: "cc");						\
-	flag;								\
-})
+static inline unsigned long __range_ok(unsigned long addr, unsigned long size)
+{
+	unsigned long limit = current_thread_info()->addr_limit;
+
+	__chk_user_ptr(addr);
+	asm volatile(
+	// A + B <= C + 1 for all A,B,C, in four easy steps:
+	// 1: X = A + B; X' = X % 2^64
+	"	adds	%0, %0, %2\n"
+	// 2: Set C = 0 if X > 2^64, to guarantee X' > C in step 4
+	"	csel	%1, xzr, %1, hi\n"
+	// 3: Set X' = ~0 if X >= 2^64. For X == 2^64, this decrements X'
+	//    to compensate for the carry flag being set in step 4. For
+	//    X > 2^64, X' merely has to remain nonzero, which it does.
+	"	csinv	%0, %0, xzr, cc\n"
+	// 4: For X < 2^64, this gives us X' - C - 1 <= 0, where the -1
+	//    comes from the carry in being clear. Otherwise, we are
+	//    testing X' - C == 0, subject to the previous adjustments.
+	"	sbcs	xzr, %0, %1\n"
+	"	cset	%0, ls\n"
+	: "+r" (addr), "+r" (limit) : "Ir" (size) : "cc");
+
+	return addr;
+}
 
 /*
  * When dealing with data aborts, watchpoints, or instruction traps we may end
@@ -90,7 +97,7 @@ static inline void set_fs(mm_segment_t f
  */
 #define untagged_addr(addr)		sign_extend64(addr, 55)
 
-#define access_ok(type, addr, size)	__range_ok(addr, size)
+#define access_ok(type, addr, size)	__range_ok((unsigned long)(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -167,10 +167,10 @@ alternative_else_nop_endif
 	.else
 	add	x21, sp, #S_FRAME_SIZE
 	get_thread_info tsk
-	/* Save the task's original addr_limit and set USER_DS (TASK_SIZE_64) */
+	/* Save the task's original addr_limit and set USER_DS */
 	ldr	x20, [tsk, #TSK_TI_ADDR_LIMIT]
 	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
-	mov	x20, #TASK_SIZE_64
+	mov	x20, #USER_DS
 	str	x20, [tsk, #TSK_TI_ADDR_LIMIT]
 	/* No need to reset PSTATE.UAO, hardware's already set it to 0 for us */
 	.endif /* \el == 0 */
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -240,7 +240,7 @@ static inline bool is_permission_fault(u
 	if (fsc_type == ESR_ELx_FSC_PERM)
 		return true;
 
-	if (addr < USER_DS && system_uses_ttbr0_pan())
+	if (addr < TASK_SIZE && system_uses_ttbr0_pan())
 		return fsc_type == ESR_ELx_FSC_FAULT &&
 			(regs->pstate & PSR_PAN_BIT);
 
@@ -414,7 +414,7 @@ static int __kprobes do_page_fault(unsig
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	if (addr < USER_DS && is_permission_fault(esr, regs, addr)) {
+	if (addr < TASK_SIZE && is_permission_fault(esr, regs, addr)) {
 		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 		if (regs->orig_addr_limit == KERNEL_DS)
 			die("Accessing user space memory with fs=KERNEL_DS", regs, esr);
