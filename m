Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C09C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A017208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A017208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeGKOCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:02:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388274AbeGKOCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:02:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DD5322C7;
        Wed, 11 Jul 2018 06:57:51 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F19A23F5B1;
        Wed, 11 Jul 2018 06:57:48 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com
Cc:     catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv5 13/21] arm64: zero GPRs upon entry from EL0
Date:   Wed, 11 Jul 2018 14:56:48 +0100
Message-Id: <20180711135656.20670-14-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can zero GPRs x0 - x29 upon entry from EL0 to make it harder for
userspace to control values consumed by speculative gadgets.

We don't blat x30, since this is stashed much later, and we'll blat it
before invoking C code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 22b240da949b..d1440f84668b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -53,6 +53,12 @@
 #endif
 	.endm
 
+	.macro	clear_gp_regs
+	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
+	mov	x\n, xzr
+	.endr
+	.endm
+
 /*
  * Bad Abort numbers
  *-----------------
@@ -169,6 +175,7 @@ alternative_cb_end
 	stp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
+	clear_gp_regs
 	mrs	x21, sp_el0
 	ldr_this_cpu	tsk, __entry_task, x20	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
@@ -176,7 +183,6 @@ alternative_cb_end
 
 	apply_ssbd 1, x22, x23
 
-	mov	x29, xzr			// fp pointed to user-space
 	.else
 	add	x21, sp, #S_FRAME_SIZE
 	get_thread_info tsk
-- 
2.11.0

