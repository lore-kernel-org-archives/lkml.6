Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93B220856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93B220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbeGTNTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:19:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbeGTNTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:19:03 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF21BCB8;
        Fri, 20 Jul 2018 12:29:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.9 43/66] arm64: assembler: introduce ldr_this_cpu
Date:   Fri, 20 Jul 2018 14:14:00 +0200
Message-Id: <20180720121409.713670182@linuxfoundation.org>
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

From: Mark Rutland <mark.rutland@arm.com>

Commit 1b7e2296a822dfd2349960addc42a139360ce769 upstream.

Shortly we will want to load a percpu variable in the return from
userspace path. We can save an instruction by folding the addition of
the percpu offset into the load instruction, and this patch adds a new
helper to do so.

At the same time, we clean up this_cpu_ptr for consistency. As with
{adr,ldr,str}_l, we change the template to take the destination register
first, and name this dst. Secondly, we rename the macro to adr_this_cpu,
following the scheme of adr_l, and matching the newly added
ldr_this_cpu.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |   19 +++++++++++++++----
 arch/arm64/kernel/entry.S          |    2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -239,14 +239,25 @@ lr	.req	x30		// link register
 	.endm
 
 	/*
+	 * @dst: Result of per_cpu(sym, smp_processor_id())
 	 * @sym: The name of the per-cpu variable
-	 * @reg: Result of per_cpu(sym, smp_processor_id())
 	 * @tmp: scratch register
 	 */
-	.macro this_cpu_ptr, sym, reg, tmp
-	adr_l	\reg, \sym
+	.macro adr_this_cpu, dst, sym, tmp
+	adr_l	\dst, \sym
 	mrs	\tmp, tpidr_el1
-	add	\reg, \reg, \tmp
+	add	\dst, \dst, \tmp
+	.endm
+
+	/*
+	 * @dst: Result of READ_ONCE(per_cpu(sym, smp_processor_id()))
+	 * @sym: The name of the per-cpu variable
+	 * @tmp: scratch register
+	 */
+	.macro ldr_this_cpu dst, sym, tmp
+	adr_l	\dst, \sym
+	mrs	\tmp, tpidr_el1
+	ldr	\dst, [\dst, \tmp]
 	.endm
 
 /*
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -243,7 +243,7 @@ alternative_insn eret, nop, ARM64_UNMAP_
 	cmp	x25, tsk
 	b.ne	9998f
 
-	this_cpu_ptr irq_stack, x25, x26
+	adr_this_cpu x25, irq_stack, x26
 	mov	x26, #IRQ_STACK_START_SP
 	add	x26, x25, x26
 


