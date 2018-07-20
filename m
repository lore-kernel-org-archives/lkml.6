Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BF4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F371720652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F371720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbeGTNa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:30:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbeGTNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:30:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3AA5D70;
        Fri, 20 Jul 2018 12:39:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.17 091/101] arm64: ssbd: Skip apply_ssbd if not using dynamic mitigation
Date:   Fri, 20 Jul 2018 14:14:37 +0200
Message-Id: <20180720121427.093359954@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 986372c4367f46b34a3c0f6918d7fb95cbdf39d6 upstream.

In order to avoid checking arm64_ssbd_callback_required on each
kernel entry/exit even if no mitigation is required, let's
add yet another alternative that by default jumps over the mitigation,
and that gets nop'ed out if we're doing dynamic mitigation.

Think of it as a poor man's static key...

Reviewed-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |   14 ++++++++++++++
 arch/arm64/kernel/entry.S      |    3 +++
 2 files changed, 17 insertions(+)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -289,6 +289,20 @@ void __init arm64_update_smccc_conduit(s
 	*updptr = cpu_to_le32(insn);
 }
 
+void __init arm64_enable_wa2_handling(struct alt_instr *alt,
+				      __le32 *origptr, __le32 *updptr,
+				      int nr_inst)
+{
+	BUG_ON(nr_inst != 1);
+	/*
+	 * Only allow mitigation on EL1 entry/exit and guest
+	 * ARCH_WORKAROUND_2 handling if the SSBD state allows it to
+	 * be flipped.
+	 */
+	if (arm64_get_ssbd_state() == ARM64_SSBD_KERNEL)
+		*updptr = cpu_to_le32(aarch64_insn_gen_nop());
+}
+
 static void arm64_set_ssbd_mitigation(bool state)
 {
 	switch (psci_ops.conduit) {
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -142,6 +142,9 @@ alternative_else_nop_endif
 	// to save/restore them if required.
 	.macro	apply_ssbd, state, targ, tmp1, tmp2
 #ifdef CONFIG_ARM64_SSBD
+alternative_cb	arm64_enable_wa2_handling
+	b	\targ
+alternative_cb_end
 	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
 	cbz	\tmp2, \targ
 	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2


