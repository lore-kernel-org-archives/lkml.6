Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2CBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D7E214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D7E214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeIQUq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbeIQUq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:46:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A211830842D0;
        Mon, 17 Sep 2018 15:18:40 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45EB57EB71;
        Mon, 17 Sep 2018 15:18:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 6/6] prefetch: Remove spin_lock_prefetch()
Date:   Mon, 17 Sep 2018 11:18:04 -0400
Message-Id: <1537197484-22154-1-git-send-email-longman@redhat.com>
In-Reply-To: <1536780532-4092-1-git-send-email-longman@redhat.com>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 17 Sep 2018 15:18:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spin_lock_prefetch() call in new_inode() of fs/inode.c was the only
instance of this function call left. With the dlock list patch, the
last spin_lock_prefetch() call was removed. So the spin_lock_prefetch()
function and its architectural specific codes can now be removed as well.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/alpha/include/asm/processor.h                           | 12 ------------
 arch/arm64/include/asm/processor.h                           |  8 --------
 arch/ia64/include/asm/processor.h                            |  2 --
 .../include/asm/mach-cavium-octeon/cpu-feature-overrides.h   |  1 -
 arch/powerpc/include/asm/processor.h                         |  2 --
 arch/sparc/include/asm/processor_64.h                        |  2 --
 arch/x86/include/asm/processor.h                             |  5 -----
 include/linux/prefetch.h                                     |  7 +------
 8 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index cb05d04..d17d395 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -61,11 +61,6 @@
 #define ARCH_HAS_PREFETCHW
 #define ARCH_HAS_SPINLOCK_PREFETCH
 
-#ifndef CONFIG_SMP
-/* Nothing to prefetch. */
-#define spin_lock_prefetch(lock)  	do { } while (0)
-#endif
-
 extern inline void prefetch(const void *ptr)  
 { 
 	__builtin_prefetch(ptr, 0, 3);
@@ -76,11 +71,4 @@ extern inline void prefetchw(const void *ptr)
 	__builtin_prefetch(ptr, 1, 3);
 }
 
-#ifdef CONFIG_SMP
-extern inline void spin_lock_prefetch(const void *ptr)  
-{
-	__builtin_prefetch(ptr, 1, 3);
-}
-#endif
-
 #endif /* __ASM_ALPHA_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 79657ad..56aca32 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -232,14 +232,6 @@ static inline void prefetchw(const void *ptr)
 	asm volatile("prfm pstl1keep, %a0\n" : : "p" (ptr));
 }
 
-#define ARCH_HAS_SPINLOCK_PREFETCH
-static inline void spin_lock_prefetch(const void *ptr)
-{
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-		     "prfm pstl1strm, %a0",
-		     "nop") : : "p" (ptr));
-}
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 #endif
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 10061ccf..12770bf 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -676,8 +676,6 @@ struct thread_struct {
 	ia64_lfetch_excl(ia64_lfhint_none, x);
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 extern unsigned long boot_option_idle_override;
 
 enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_FORCE_MWAIT,
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index a4f7986..9981729 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -62,7 +62,6 @@
 
 #define ARCH_HAS_IRQ_PER_CPU	1
 #define ARCH_HAS_SPINLOCK_PREFETCH 1
-#define spin_lock_prefetch(x) prefetch(x)
 #define PREFETCH_STRIDE 128
 
 #ifdef __OCTEON__
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 52fadded..3c4dcad 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -488,8 +488,6 @@ static inline void prefetchw(const void *x)
 	__asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 #ifdef CONFIG_PPC64
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index aac23d4..71a61dd 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -252,8 +252,6 @@ static inline void prefetchw(const void *x)
 			     : "r" (x));
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b922eed..44df38e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -830,11 +830,6 @@ static inline void prefetchw(const void *x)
 			  "m" (*(const char *)x));
 }
 
-static inline void spin_lock_prefetch(const void *x)
-{
-	prefetchw(x);
-}
-
 #define TOP_OF_INIT_STACK ((unsigned long)&init_stack + sizeof(init_stack) - \
 			   TOP_OF_KERNEL_STACK_PADDING)
 
diff --git a/include/linux/prefetch.h b/include/linux/prefetch.h
index 13eafeb..8f074fb 100644
--- a/include/linux/prefetch.h
+++ b/include/linux/prefetch.h
@@ -24,11 +24,10 @@
 	prefetch() should be defined by the architecture, if not, the 
 	#define below provides a no-op define.	
 	
-	There are 3 prefetch() macros:
+	There are 2 prefetch() macros:
 	
 	prefetch(x)  	- prefetches the cacheline at "x" for read
 	prefetchw(x)	- prefetches the cacheline at "x" for write
-	spin_lock_prefetch(x) - prefetches the spinlock *x for taking
 	
 	there is also PREFETCH_STRIDE which is the architecure-preferred 
 	"lookahead" size for prefetching streamed operations.
@@ -43,10 +42,6 @@
 #define prefetchw(x) __builtin_prefetch(x,1)
 #endif
 
-#ifndef ARCH_HAS_SPINLOCK_PREFETCH
-#define spin_lock_prefetch(x) prefetchw(x)
-#endif
-
 #ifndef PREFETCH_STRIDE
 #define PREFETCH_STRIDE (4*L1_CACHE_BYTES)
 #endif
-- 
1.8.3.1

