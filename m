Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F05C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F05C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbeGTNZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:25:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388862AbeGTNZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:25:33 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72B78BDB;
        Fri, 20 Jul 2018 12:35:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 88/92] arm64: KVM: Add HYP per-cpu accessors
Date:   Fri, 20 Jul 2018 14:14:32 +0200
Message-Id: <20180720121422.748815648@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -69,14 +69,37 @@ extern u32 __init_stage2_translation(voi
 
 extern void __qcom_hyp_sanitize_btac_predictors(void);
 
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


