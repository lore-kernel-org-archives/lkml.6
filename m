Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13675ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48C620854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48C620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbeGTNUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:20:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbeGTNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:20:17 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC81BCB1;
        Fri, 20 Jul 2018 12:31:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.9 62/66] arm64: KVM: Add HYP per-cpu accessors
Date:   Fri, 20 Jul 2018 14:14:19 +0200
Message-Id: <20180720121412.287811412@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 85478bab409171de501b719971fd25a3d5d639f9 upstream.

As we're going to require to access per-cpu variables at EL2,
let's craft the minimum set of accessors required to implement
reading a per-cpu variable, relying on tpidr_el2 to contain the
per-cpu offset.

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_asm.h |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -66,14 +66,37 @@ extern u32 __kvm_get_mdcr_el2(void);
 
 extern u32 __init_stage2_translation(void);
 
+/* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
+#define __hyp_this_cpu_ptr(sym)						\
+	({								\
+		void *__ptr = hyp_symbol_addr(sym);			\
+		__ptr += read_sysreg(tpidr_el2);			\
+		(typeof(&sym))__ptr;					\
+	 })
+
+#define __hyp_this_cpu_read(sym)					\
+	({								\
+		*__hyp_this_cpu_ptr(sym);				\
+	 })
+
 #else /* __ASSEMBLY__ */
 
-.macro get_host_ctxt reg, tmp
-	adr_l	\reg, kvm_host_cpu_state
+.macro hyp_adr_this_cpu reg, sym, tmp
+	adr_l	\reg, \sym
 	mrs	\tmp, tpidr_el2
 	add	\reg, \reg, \tmp
 .endm
 
+.macro hyp_ldr_this_cpu reg, sym, tmp
+	adr_l	\reg, \sym
+	mrs	\tmp, tpidr_el2
+	ldr	\reg,  [\reg, \tmp]
+.endm
+
+.macro get_host_ctxt reg, tmp
+	hyp_adr_this_cpu \reg, kvm_host_cpu_state, \tmp
+.endm
+
 .macro get_vcpu_ptr vcpu, ctxt
 	get_host_ctxt \ctxt, \vcpu
 	ldr	\vcpu, [\ctxt, #HOST_CONTEXT_VCPU]


