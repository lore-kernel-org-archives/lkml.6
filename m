Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F61EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5175420881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763648;
	bh=zQGRR7Dj1UeiQe+6YHlNFf5RjAZZ8VQGUuEp3C4KThM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMxkpn5sJTXcFcfsCOSQKzD51bd5ajqIGnqRVl4FB7NQ0MMff6rv651izVODMDzAZ
	 rGN6nBOK787VhT1j/ciX2Wna1Mlae8qANUEVU4lgMmu6tyQRN/dFh7LFnNYW36jTx8
	 HqZJS38rT7jmPYtnb0M5NJ4KQoR0AXOxDwGRMft4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfA2LkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbfA2LkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CAB02148E;
        Tue, 29 Jan 2019 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762014;
        bh=zQGRR7Dj1UeiQe+6YHlNFf5RjAZZ8VQGUuEp3C4KThM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/rnAV19VIMooPkAiGqm+vsObHc4acn9oKBG32VyFdrFsE7uKWtkcQ2cKG8nn0ELp
         ybyywbc1TM4rr71blV0+loXKTM+57ju2ALss/VoAlbV1q59u2iBbisIssMlApQAT7O
         +tFszTGy3YJOfqm3+CWW3ykGdLZ6QmFDNo/p1BCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, peterz@infradead.org, mpe@ellerman.id.au,
        will.deacon@arm.com, luto@kernel.org, jroedel@suse.de
Subject: [PATCH 4.20 080/117] x86/pkeys: Properly copy pkey state at fork()
Date:   Tue, 29 Jan 2019 12:35:31 +0100
Message-Id: <20190129113211.466976430@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit a31e184e4f69965c99c04cc5eb8a4920e0c63737 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mmu_context.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
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


