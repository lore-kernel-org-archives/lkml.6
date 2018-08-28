Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B509DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A3C20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A3C20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH1LbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:31:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:45418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727203AbeH1LbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:31:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5791B049;
        Tue, 28 Aug 2018 07:40:39 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 11/15] x86/paravirt: move items in pv_info under PARAVIRT_XXL umbrella
Date:   Tue, 28 Aug 2018 09:40:22 +0200
Message-Id: <20180828074026.820-12-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All items but name in pv_info are needed by Xen PV only. Define them
with CONFIG_PARAVIRT_XXL set only.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h             | 2 ++
 arch/x86/include/asm/paravirt_types.h       | 2 ++
 arch/x86/include/asm/pgtable-3level_types.h | 2 +-
 arch/x86/include/asm/ptrace.h               | 2 +-
 arch/x86/include/asm/segment.h              | 2 +-
 arch/x86/kernel/paravirt.c                  | 2 ++
 6 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2ba23e98c5cd..dbaedf1ed622 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -104,7 +104,9 @@ static inline void wbinvd(void)
 	PVOP_VCALL0(cpu.wbinvd);
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
+#endif
 
 static inline u64 paravirt_read_msr(unsigned msr)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 462a54b2bb53..98e1110354b8 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -66,11 +66,13 @@ struct paravirt_callee_save {
 
 /* general info */
 struct pv_info {
+#ifdef CONFIG_PARAVIRT_XXL
 	unsigned int kernel_rpl;
 	int shared_kernel_pmd;
 
 #ifdef CONFIG_X86_64
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
+#endif
 #endif
 
 	const char *name;
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 858358a82b14..33845d36897c 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -20,7 +20,7 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLY__ */
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #define SHARED_KERNEL_PMD	((!static_cpu_has(X86_FEATURE_PTI) &&	\
 				 (pv_info.shared_kernel_pmd)))
 #else
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..250be50aa257 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -144,7 +144,7 @@ static inline int v8086_mode(struct pt_regs *regs)
 static inline bool user_64bit_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_64
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 	/*
 	 * On non-paravirt systems, this is the only long mode CPL 3
 	 * selector.  We do not allow long mode selectors in the LDT.
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e293c122d0d5..0ffbe9519e68 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -211,7 +211,7 @@
 
 #endif
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 # define get_kernel_rpl()		0
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5fc2b94e1591..ee7da9ec3ea2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -293,12 +293,14 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
+#ifdef CONFIG_PARAVIRT_XXL
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
 #ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = __USER_CS,
 #endif
+#endif
 };
 
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
-- 
2.16.4

