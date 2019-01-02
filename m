Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B44C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F7421871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfABWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:02:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:3041 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfABWCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:02:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 14:02:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="111668242"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jan 2019 14:02:38 -0800
Subject: [PATCH 1/2] x86/pkeys: properly copy pkey state at fork()
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, mpe@ellerman.id.au, will.deacon@arm.com,
        luto@kernel.org, jroedel@suse.de, stable@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 02 Jan 2019 13:56:55 -0800
References: <20190102215653.4D7C8AF4@viggo.jf.intel.com>
In-Reply-To: <20190102215653.4D7C8AF4@viggo.jf.intel.com>
Message-Id: <20190102215655.7A69518C@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Memory protection key behavior should be the same in a child as it was
in the parent before a fork.  But, there is a bug that resets the
state in the child at fork instead of preserving it.

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
"new" values.  But, alas, init_new_context() is used at execve() and
fork().

The result is that, after a fork(), the child's pkey state ends up
looking like it does after an execve(), which is totally wrong.  pkeys
that are already allocated can be allocated again, for instance.

To fix this, add code called by dup_mmap() to copy the pkey state from
parent to child explicitly.  Also add a comment above init_new_context()
to make it more clear to the next poor sod what this code is used for.

Fixes: e8c24d3a23a ("x86/pkeys: Allocation/free syscalls")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
Cc: stable@vger.kernel.org
---

 b/arch/x86/include/asm/mmu_context.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff -puN arch/x86/include/asm/mmu_context.h~x86-pkeys-no-init-at-fork arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~x86-pkeys-no-init-at-fork	2019-01-02 13:53:53.217951966 -0800
+++ b/arch/x86/include/asm/mmu_context.h	2019-01-02 13:53:53.221951966 -0800
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
