Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E842C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550BA2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129354;
	bh=t9xsvH0qA1VrbomtFIbts/9uaUmsbCHGkiE6UdeghHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WyiCuGSQJtbO9n7zYp1RPLOAB55mfCqvmDhvlX3tdyQm1NKlIk0osrhVtnYzHnBJK
	 kVEMuNmlUCA1wKP6HdnceQmZ9IupyvsWopkleoddUlwy3yLAit7qmcTehrF+LPGRWf
	 4hOndxPqm9yVdo6KfV7cXQBt9HSmX107/3SFUfvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfBYVPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfBYVPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1CF2147C;
        Mon, 25 Feb 2019 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129349;
        bh=t9xsvH0qA1VrbomtFIbts/9uaUmsbCHGkiE6UdeghHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APWSSSrHHb+NpVVgRD6WWeD/goPpPdbRsxhbJCPdFBD7lyx2JtiItaRzZQpMO2G6A
         Z9ye9RdHe73sVkBKbvsCiUVFYalFYe/T/yfIqr5IwD+3PVDd8edBrZWGGoW63lgNOJ
         BpAgXOKcGosTYvZUYUaOUL4trfBgS8QSdpgbwNyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 55/63] irqchip/gic-v3: Convert arm64 GIC accessors to {read,write}_sysreg_s
Date:   Mon, 25 Feb 2019 22:11:55 +0100
Message-Id: <20190225195040.035747848@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit d44ffa5ae70a15a15190aa9ffa6f6acdeae1d25c upstream.

The GIC system registers are accessed using open-coded wrappers around
the mrs_s/msr_s asm macros.

This patch moves the code over to the {read,wrote}_sysreg_s accessors
instead, reducing the amount of explicit asm blocks in the arch headers.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[nc: Also fix gic_write_bpr1, which was incidentally fixed in
     0e9884fe63c6 ("arm64: sysreg: subsume GICv3 sysreg definitions")]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/arch_gicv3.h |   47 +++++++++++++-----------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -80,18 +80,8 @@
 #include <linux/stringify.h>
 #include <asm/barrier.h>
 
-#define read_gicreg(r)							\
-	({								\
-		u64 reg;						\
-		asm volatile("mrs_s %0, " __stringify(r) : "=r" (reg));	\
-		reg;							\
-	})
-
-#define write_gicreg(v,r)						\
-	do {								\
-		u64 __val = (v);					\
-		asm volatile("msr_s " __stringify(r) ", %0" : : "r" (__val));\
-	} while (0)
+#define read_gicreg			read_sysreg_s
+#define write_gicreg			write_sysreg_s
 
 /*
  * Low-level accessors
@@ -102,13 +92,13 @@
 
 static inline void gic_write_eoir(u32 irq)
 {
-	asm volatile("msr_s " __stringify(ICC_EOIR1_EL1) ", %0" : : "r" ((u64)irq));
+	write_sysreg_s(irq, ICC_EOIR1_EL1);
 	isb();
 }
 
 static inline void gic_write_dir(u32 irq)
 {
-	asm volatile("msr_s " __stringify(ICC_DIR_EL1) ", %0" : : "r" ((u64)irq));
+	write_sysreg_s(irq, ICC_DIR_EL1);
 	isb();
 }
 
@@ -116,7 +106,7 @@ static inline u64 gic_read_iar_common(vo
 {
 	u64 irqstat;
 
-	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
+	irqstat = read_sysreg_s(ICC_IAR1_EL1);
 	dsb(sy);
 	return irqstat;
 }
@@ -134,10 +124,12 @@ static inline u64 gic_read_iar_cavium_th
 
 	asm volatile(
 		"nop;nop;nop;nop\n\t"
-		"nop;nop;nop;nop\n\t"
-		"mrs_s %0, " __stringify(ICC_IAR1_EL1) "\n\t"
-		"nop;nop;nop;nop"
-		: "=r" (irqstat));
+		"nop;nop;nop;nop");
+
+	irqstat = read_sysreg_s(ICC_IAR1_EL1);
+
+	asm volatile(
+		"nop;nop;nop;nop");
 	mb();
 
 	return irqstat;
@@ -145,43 +137,40 @@ static inline u64 gic_read_iar_cavium_th
 
 static inline void gic_write_pmr(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_PMR_EL1);
 }
 
 static inline void gic_write_ctlr(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_CTLR_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_CTLR_EL1);
 	isb();
 }
 
 static inline void gic_write_grpen1(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_GRPEN1_EL1);
 	isb();
 }
 
 static inline void gic_write_sgi1r(u64 val)
 {
-	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
+	write_sysreg_s(val, ICC_SGI1R_EL1);
 }
 
 static inline u32 gic_read_sre(void)
 {
-	u64 val;
-
-	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
-	return val;
+	return read_sysreg_s(ICC_SRE_EL1);
 }
 
 static inline void gic_write_sre(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_SRE_EL1);
 	isb();
 }
 
 static inline void gic_write_bpr1(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_BPR1_EL1) ", %0" : : "r" (val));
+	write_sysreg_s(val, ICC_BPR1_EL1);
 }
 
 #define gic_read_typer(c)		readq_relaxed(c)


