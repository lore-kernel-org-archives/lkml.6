Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69379C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCD221581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCD221581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeHTQTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:19:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeHTQTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:19:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B928CAFCA;
        Mon, 20 Aug 2018 13:03:32 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen: remove unused hypercall functions
Date:   Mon, 20 Aug 2018 15:03:30 +0200
Message-Id: <20180820130330.11704-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Xen hypercall functions which are used nowhere in the kernel.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/hypercall.h | 118 -----------------------------------
 1 file changed, 118 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 6b2f90a0b149..ef05bea7010d 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -197,17 +197,6 @@ extern struct { char _entry[32]; } hypercall_page[];
 	(type)__res;							\
 })
 
-#define _hypercall5(type, name, a1, a2, a3, a4, a5)			\
-({									\
-	__HYPERCALL_DECLS;						\
-	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);				\
-	asm volatile (__HYPERCALL					\
-		      : __HYPERCALL_5PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
-		      : __HYPERCALL_CLOBBER5);				\
-	(type)__res;							\
-})
-
 static inline long
 xen_single_call(unsigned int call,
 		unsigned long a1, unsigned long a2,
@@ -267,47 +256,12 @@ HYPERVISOR_set_gdt(unsigned long *frame_list, int entries)
 }
 
 static inline int
-HYPERVISOR_stack_switch(unsigned long ss, unsigned long esp)
-{
-	return _hypercall2(int, stack_switch, ss, esp);
-}
-
-#ifdef CONFIG_X86_32
-static inline int
-HYPERVISOR_set_callbacks(unsigned long event_selector,
-			 unsigned long event_address,
-			 unsigned long failsafe_selector,
-			 unsigned long failsafe_address)
-{
-	return _hypercall4(int, set_callbacks,
-			   event_selector, event_address,
-			   failsafe_selector, failsafe_address);
-}
-#else  /* CONFIG_X86_64 */
-static inline int
-HYPERVISOR_set_callbacks(unsigned long event_address,
-			unsigned long failsafe_address,
-			unsigned long syscall_address)
-{
-	return _hypercall3(int, set_callbacks,
-			   event_address, failsafe_address,
-			   syscall_address);
-}
-#endif  /* CONFIG_X86_{32,64} */
-
-static inline int
 HYPERVISOR_callback_op(int cmd, void *arg)
 {
 	return _hypercall2(int, callback_op, cmd, arg);
 }
 
 static inline int
-HYPERVISOR_fpu_taskswitch(int set)
-{
-	return _hypercall1(int, fpu_taskswitch, set);
-}
-
-static inline int
 HYPERVISOR_sched_op(int cmd, void *arg)
 {
 	return _hypercall2(int, sched_op, cmd, arg);
@@ -419,19 +373,6 @@ HYPERVISOR_grant_table_op(unsigned int cmd, void *uop, unsigned int count)
 }
 
 static inline int
-HYPERVISOR_update_va_mapping_otherdomain(unsigned long va, pte_t new_val,
-					 unsigned long flags, domid_t domid)
-{
-	if (sizeof(new_val) == sizeof(long))
-		return _hypercall4(int, update_va_mapping_otherdomain, va,
-				   new_val.pte, flags, domid);
-	else
-		return _hypercall5(int, update_va_mapping_otherdomain, va,
-				   new_val.pte, new_val.pte >> 32,
-				   flags, domid);
-}
-
-static inline int
 HYPERVISOR_vm_assist(unsigned int cmd, unsigned int type)
 {
 	return _hypercall2(int, vm_assist, cmd, type);
@@ -465,12 +406,6 @@ HYPERVISOR_suspend(unsigned long start_info_mfn)
 	return _hypercall3(int, sched_op, SCHEDOP_shutdown, &r, start_info_mfn);
 }
 
-static inline int
-HYPERVISOR_nmi_op(unsigned long op, unsigned long arg)
-{
-	return _hypercall2(int, nmi_op, op, arg);
-}
-
 static inline unsigned long __must_check
 HYPERVISOR_hvm_op(int op, void *arg)
 {
@@ -529,39 +464,6 @@ MULTI_update_va_mapping(struct multicall_entry *mcl, unsigned long va,
 }
 
 static inline void
-MULTI_grant_table_op(struct multicall_entry *mcl, unsigned int cmd,
-		     void *uop, unsigned int count)
-{
-	mcl->op = __HYPERVISOR_grant_table_op;
-	mcl->args[0] = cmd;
-	mcl->args[1] = (unsigned long)uop;
-	mcl->args[2] = count;
-
-	trace_xen_mc_entry(mcl, 3);
-}
-
-static inline void
-MULTI_update_va_mapping_otherdomain(struct multicall_entry *mcl, unsigned long va,
-				    pte_t new_val, unsigned long flags,
-				    domid_t domid)
-{
-	mcl->op = __HYPERVISOR_update_va_mapping_otherdomain;
-	mcl->args[0] = va;
-	if (sizeof(new_val) == sizeof(long)) {
-		mcl->args[1] = new_val.pte;
-		mcl->args[2] = flags;
-		mcl->args[3] = domid;
-	} else {
-		mcl->args[1] = new_val.pte;
-		mcl->args[2] = new_val.pte >> 32;
-		mcl->args[3] = flags;
-		mcl->args[4] = domid;
-	}
-
-	trace_xen_mc_entry(mcl, sizeof(new_val) == sizeof(long) ? 4 : 5);
-}
-
-static inline void
 MULTI_update_descriptor(struct multicall_entry *mcl, u64 maddr,
 			struct desc_struct desc)
 {
@@ -582,16 +484,6 @@ MULTI_update_descriptor(struct multicall_entry *mcl, u64 maddr,
 }
 
 static inline void
-MULTI_memory_op(struct multicall_entry *mcl, unsigned int cmd, void *arg)
-{
-	mcl->op = __HYPERVISOR_memory_op;
-	mcl->args[0] = cmd;
-	mcl->args[1] = (unsigned long)arg;
-
-	trace_xen_mc_entry(mcl, 2);
-}
-
-static inline void
 MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
 		 int count, int *success_count, domid_t domid)
 {
@@ -618,16 +510,6 @@ MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
 }
 
 static inline void
-MULTI_set_gdt(struct multicall_entry *mcl, unsigned long *frames, int entries)
-{
-	mcl->op = __HYPERVISOR_set_gdt;
-	mcl->args[0] = (unsigned long)frames;
-	mcl->args[1] = entries;
-
-	trace_xen_mc_entry(mcl, 2);
-}
-
-static inline void
 MULTI_stack_switch(struct multicall_entry *mcl,
 		   unsigned long ss, unsigned long esp)
 {
-- 
2.13.7

