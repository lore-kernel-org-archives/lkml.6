Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7494C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742DC2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ddxSuQ4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfBESfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:35:55 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50346 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfBESfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:35:55 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 159F924E282E;
        Tue,  5 Feb 2019 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549391755; bh=hb7RXqiK+RCJ+QlO9kx37JGVNgIvGtq5FXLX/Jw7i0E=;
        h=From:To:CC:Subject:Date:From;
        b=ddxSuQ4zb0Hl9oLyaDxyF898qkUoquJ16lt3IeSmylFQBUjfZ9Ofp4MiPeBuY7Gf5
         4UjMXIdWyaOmWJx2nE1aG8ubCioho2V60gFzPVvrIRk7KdCsixP55sg71simwWctPn
         wCxbwoI8CjME+5OL1mIizquFG7lV5AEeA2kPFvo0YpV6syxenVIBeHXZPLoPwQrJlL
         qvvq+zSqVZr/MP5oSf2EEi+Uwarq7UAk5VHoiTUyOD2MQ5/lI/OfkJcGNkLG7gvvZ7
         q+7tjhYJtFe6+ic+0uzqAmsPWJMV7AJFc9IoD/YCMFJh5stcuGasKzEKEgO9qwWxvi
         z56tIc94JQ1cg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D0535A00A2;
        Tue,  5 Feb 2019 18:35:53 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Feb 2019 10:35:53 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Feb 2019 00:05:52 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Feb 2019 00:05:52 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH] ARCv2: support manual regfile save on interrupts
Date:   Tue, 5 Feb 2019 10:35:44 -0800
Message-ID: <1549391744-5649-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a hardware bug which affects the HSDK platform, triggered by
micro-ops for auto-saving regfile on taken interrupt. The workaround is
to inhibit autosave.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig                   |  8 ++++++
 arch/arc/include/asm/entry-arcv2.h | 54 ++++++++++++++++++++++++++++++++++++++
 arch/arc/kernel/entry-arcv2.S      |  4 ++-
 arch/arc/kernel/intc-arcv2.c       |  2 ++
 arch/arc/plat-hsdk/Kconfig         |  1 +
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..7215f52b3413 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -407,6 +407,14 @@ config ARC_HAS_ACCL_REGS
 	  (also referred to as r58:r59). These can also be used by gcc as GPR so
 	  kernel needs to save/restore per process
 
+config ARC_IRQ_NO_AUTOSAVE
+	bool "Disable hardware autosave regfile on interrupts"
+	default n
+	help
+	  On HS cores, taken interrupt auto saves the regfile on stack.
+	  This is programmable and can be optionally disabled in which case
+	  software INTERRUPT_PROLOGUE/EPILGUE do the needed work
+
 endif	# ISA_ARCV2
 
 endmenu   # "ARC CPU Configuration"
diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 309f4e6721b3..3173d7fa4f72 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -17,6 +17,33 @@
 	;
 	; Now manually save: r12, sp, fp, gp, r25
 
+#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
+.ifnc \called_from, exception
+	st.as	r9, [sp, -10]	; save r9 is right slot
+	sub	sp, sp, 12	; skip JLI, LDI, EI
+
+	PUSH	lp_count
+	PUSHAX	lp_start
+	PUSHAX	lp_end
+	PUSH	blink
+
+	PUSH	r11
+	PUSH	r10
+
+	sub	sp, sp, 4	; skip r9
+
+	PUSH	r8
+	PUSH	r7
+	PUSH	r6
+	PUSH	r5
+	PUSH	r4
+	PUSH	r3
+	PUSH	r2
+	PUSH	r1
+	PUSH	r0
+.endif
+#endif
+
 #ifdef CONFIG_ARC_HAS_ACCL_REGS
 	PUSH	r59
 	PUSH	r58
@@ -86,6 +113,33 @@
 	POP	r59
 #endif
 
+#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
+.ifnc \called_from, exception
+	POP	r0
+	POP	r1
+	POP	r2
+	POP	r3
+	POP	r4
+	POP	r5
+	POP	r6
+	POP	r7
+	POP	r8
+	POP	r9
+	POP	r10
+	POP	r11
+
+	POP	blink
+	POPAX	lp_end
+	POPAX	lp_start
+
+	POP	r9
+	mov	lp_count, r9
+
+	add	sp, sp, 12	; skip JLI, LDI, EI
+	ld.as	r9, [sp, -10]	; reload r9 which got clobbered
+.endif
+#endif
+
 .endm
 
 /*------------------------------------------------------------------------*/
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index cc558a25b8fa..562089d62d9d 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -209,7 +209,9 @@ restore_regs:
 ;####### Return from Intr #######
 
 debug_marker_l1:
-	bbit1.nt r0, STATUS_DE_BIT, .Lintr_ret_to_delay_slot
+	; bbit1.nt r0, STATUS_DE_BIT, .Lintr_ret_to_delay_slot
+	btst	r0, STATUS_DE_BIT		; Z flag set if bit clear
+	bnz	.Lintr_ret_to_delay_slot	; branch if STATUS_DE_BIT set
 
 .Lisr_ret_fast_path:
 	; Handle special case #1: (Entry via Exception, Return via IRQ)
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 067ea362fb3e..cf18b3e5a934 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -49,11 +49,13 @@ void arc_init_IRQ(void)
 
 	*(unsigned int *)&ictrl = 0;
 
+#ifndef CONFIG_ARC_IRQ_NO_AUTOSAVE
 	ictrl.save_nr_gpr_pairs = 6;	/* r0 to r11 (r12 saved manually) */
 	ictrl.save_blink = 1;
 	ictrl.save_lp_regs = 1;		/* LP_COUNT, LP_START, LP_END */
 	ictrl.save_u_to_u = 0;		/* user ctxt saved on kernel stack */
 	ictrl.save_idx_regs = 1;	/* JLI, LDI, EI */
+#endif
 
 	WRITE_AUX(AUX_IRQ_CTRL, ictrl);
 
diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
index f25c085b9874..23e00216e5a5 100644
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARC_SOC_HSDK
 	bool "ARC HS Development Kit SOC"
 	depends on ISA_ARCV2
 	select ARC_HAS_ACCL_REGS
+	select ARC_IRQ_NO_AUTOSAVE
 	select CLK_HSDK
 	select RESET_HSDK
 	select HAVE_PCI
-- 
2.7.4

