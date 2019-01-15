Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25468C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE6520656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfAOJhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:37:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfAOJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:37:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0F9atXb2457680
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 01:36:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0F9atY92457677;
        Tue, 15 Jan 2019 01:36:55 -0800
Date:   Tue, 15 Jan 2019 01:36:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-a31e184e4f69965c99c04cc5eb8a4920e0c63737@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mpe@ellerman.id.au, will.deacon@arm.com, mingo@kernel.org,
        luto@kernel.org, jroedel@suse.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, bp@alien8.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, mpe@ellerman.id.au, will.deacon@arm.com,
          luto@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
          jroedel@suse.de, bp@alien8.de, peterz@infradead.org
In-Reply-To: <20190102215655.7A69518C@viggo.jf.intel.com>
References: <20190102215655.7A69518C@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys: Properly copy pkey state at fork()
Git-Commit-ID: a31e184e4f69965c99c04cc5eb8a4920e0c63737
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a31e184e4f69965c99c04cc5eb8a4920e0c63737
Gitweb:     https://git.kernel.org/tip/a31e184e4f69965c99c04cc5eb8a4920e0c63737
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 2 Jan 2019 13:56:55 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 10:33:45 +0100

x86/pkeys: Properly copy pkey state at fork()

Memory protection key behavior should be the same in a child as it was
in the parent before a fork.  But, there is a bug that resets the
state in the child at fork instead of preserving it.

The creation of new mm's is a bit convoluted.  At fork(), the code
does:

  1. memcpy() the parent mm to initialize child
  2. mm_init() to initalize some select stuff stuff
  3. dup_mmap() to create true copies that memcpy() did not do right

For pkeys two bits of state need to be preserved across a fork:
'execute_only_pkey' and 'pkey_allocation_map'.

Those are preserved by the memcpy(), but mm_init() invokes
init_new_context() which overwrites 'execute_only_pkey' and
'pkey_allocation_map' with "new" values.

The author of the code erroneously believed that init_new_context is *only*
called at execve()-time.  But, alas, init_new_context() is used at execve()
and fork().

The result is that, after a fork(), the child's pkey state ends up looking
like it does after an execve(), which is totally wrong.  pkeys that are
already allocated can be allocated again, for instance.

To fix this, add code called by dup_mmap() to copy the pkey state from
parent to child explicitly.  Also add a comment above init_new_context() to
make it more clear to the next poor sod what this code is used for.

Fixes: e8c24d3a23a ("x86/pkeys: Allocation/free syscalls")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: peterz@infradead.org
Cc: mpe@ellerman.id.au
Cc: will.deacon@arm.com
Cc: luto@kernel.org
Cc: jroedel@suse.de
Cc: stable@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20190102215655.7A69518C@viggo.jf.intel.com

---
 arch/x86/include/asm/mmu_context.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 0ca50611e8ce..19d18fae6ec6 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -178,6 +178,10 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 
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
