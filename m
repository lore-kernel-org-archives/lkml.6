Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FFDC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347622082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347622082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJ3PZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:53438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbeJ3PZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B6F1AEC0;
        Tue, 30 Oct 2018 06:33:04 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/paravirt: remove unused _paravirt_ident_32
Date:   Tue, 30 Oct 2018 07:33:01 +0100
Message-Id: <20181030063301.15054-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no user of _paravirt_ident_32 left in the tree. Remove it
together with the related paravirt_patch_ident_32().

paravirt_patch_ident_64() can be moved inside CONFIG_PARAVIRT_XXL.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/paravirt.c            | 26 +++++++-------------------
 arch/x86/kernel/paravirt_patch_32.c   | 18 ++++++------------
 arch/x86/kernel/paravirt_patch_64.c   | 20 ++++++--------------
 4 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fba54ca23b2a..26942ad63830 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -361,7 +361,6 @@ extern struct paravirt_patch_template pv_ops;
 	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
 	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
 
-unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insnbuf,
 				unsigned long addr, unsigned len);
@@ -651,7 +650,6 @@ void paravirt_leave_lazy_mmu(void);
 void paravirt_flush_lazy_mmu(void);
 
 void _paravirt_nop(void);
-u32 _paravirt_ident_32(u32);
 u64 _paravirt_ident_64(u64);
 
 #define paravirt_nop	((void *)_paravirt_nop)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 45123b116c05..c0e0101133f3 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -56,17 +56,6 @@ asm (".pushsection .entry.text, \"ax\"\n"
      ".type _paravirt_nop, @function\n\t"
      ".popsection");
 
-/* identity function, which can be inlined */
-u32 notrace _paravirt_ident_32(u32 x)
-{
-	return x;
-}
-
-u64 notrace _paravirt_ident_64(u64 x)
-{
-	return x;
-}
-
 void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
@@ -102,6 +91,12 @@ static unsigned paravirt_patch_call(void *insnbuf, const void *target,
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
+/* identity function, which can be inlined */
+u64 notrace _paravirt_ident_64(u64 x)
+{
+	return x;
+}
+
 static unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 				   unsigned long addr, unsigned len)
 {
@@ -146,13 +141,11 @@ unsigned paravirt_patch_default(u8 type, void *insnbuf,
 	else if (opfunc == _paravirt_nop)
 		ret = 0;
 
+#ifdef CONFIG_PARAVIRT_XXL
 	/* identity functions just return their single argument */
-	else if (opfunc == _paravirt_ident_32)
-		ret = paravirt_patch_ident_32(insnbuf, len);
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
-#ifdef CONFIG_PARAVIRT_XXL
 	else if (type == PARAVIRT_PATCH(cpu.iret) ||
 		 type == PARAVIRT_PATCH(cpu.usergs_sysret64))
 		/* If operation requires a jmp, then jmp */
@@ -309,13 +302,8 @@ struct pv_info pv_info = {
 #endif
 };
 
-#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
-/* 32-bit pagetable entries */
-#define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_32)
-#else
 /* 64-bit pagetable entries */
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
-#endif
 
 struct paravirt_patch_template pv_ops = {
 	/* Init ops. */
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 6368c22fa1fa..de138d3912e4 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -10,24 +10,18 @@ DEF_NATIVE(cpu, iret, "iret");
 DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
-#endif
-
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-#endif
-
-unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
-{
-	/* arg in %eax, return in %eax */
-	return 0;
-}
 
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 {
 	/* arg in %edx:%eax, return in %edx:%eax */
 	return 0;
 }
+#endif
+
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
+#endif
 
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 7ca9cb726f4d..9d9e04b31077 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -15,27 +15,19 @@ DEF_NATIVE(cpu, wbinvd, "wbinvd");
 
 DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
 DEF_NATIVE(cpu, swapgs, "swapgs");
-#endif
-
-DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-#endif
-
-unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
-{
-	return paravirt_patch_insns(insnbuf, len,
-				    start__mov32, end__mov32);
-}
-
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 {
 	return paravirt_patch_insns(insnbuf, len,
 				    start__mov64, end__mov64);
 }
+#endif
+
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
+#endif
 
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
-- 
2.16.4

