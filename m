Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7A3ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CED20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CED20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJ0Efk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:35:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:18772 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbeJ0Efk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:35:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 12:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="102992382"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2018 12:57:19 -0700
Subject: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, mpe@ellerman.id.au, will.deacon@arm.com,
        luto@kernel.org, jroedel@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 26 Oct 2018 12:51:46 -0700
Message-Id: <20181026195146.9C7C1136@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Our creation of new mm's is a bit convoluted.  At fork(), the code
does:

	1. memcpy() the parent mm to initialize child
	2. mm_init() to initalize some select stuff stuff
	3. dup_mmap() to create true copies that memcpy()
	   did not do right.

For pkeys, we need to preserve two bits of state across a fork:
'execute_only_pkey' and 'pkey_allocation_map'.  Those are preserved by
the memcpy(), which I thought did the right thing.  But, mm_init()
calls init_new_context(), which I thought was *only* for execve()-time
and overwrites 'execute_only_pkey' and 'pkey_allocation_map' with
"new" values.

The result is that, after a fork(), the child's pkey state ends up
looking like it does after an execve(), which is totally wrong.  pkeys
that are already allocated can be allocated again, for instance.

To fix this, add code called by dup_mmap() to copy the pkey state from
parent to child explicitly.  Also add a comment above init_new_context()
to make it more clear to the next poor sod what this code is used for.

Fixes: e8c24d3a23a ("x86/pkeys: Allocation/free syscalls")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
---

 b/arch/x86/include/asm/mmu_context.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff -puN arch/x86/include/asm/mmu_context.h~x86-pkeys-no-init-at-fork arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~x86-pkeys-no-init-at-fork	2018-10-26 09:24:09.444102622 -0700
+++ b/arch/x86/include/asm/mmu_context.h	2018-10-26 09:24:09.451102622 -0700
@@ -178,6 +178,10 @@ static inline void switch_ldt(struct mm_
 
 void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+/*
+ * Init a new mm.  Used on mm copies, like at fork()
+ * and on mm's that are brand-new, like at execve().
+ */
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -228,8 +232,22 @@ do {						\
 } while (0)
 #endif
 
+static inline void arch_dup_pkeys(struct mm_struct *oldmm,
+				  struct mm_struct *mm)
+{
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	/* Duplicate the oldmm pkey state in mm: */
+	mm->context.pkey_allocation_map = oldmm->context.pkey_allocation_map;
+	mm->context.execute_only_pkey   = oldmm->context.execute_only_pkey;
+#endif
+}
+
 static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
+	arch_dup_pkeys(oldmm, mm);
 	paravirt_arch_dup_mmap(oldmm, mm);
 	return ldt_dup_context(oldmm, mm);
 }
_
