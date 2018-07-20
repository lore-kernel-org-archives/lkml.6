Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89791ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A73206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A73206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbeGTNZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:25:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbeGTNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:25:10 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5535EC93;
        Fri, 20 Jul 2018 12:35:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 85/92] arm64: ssbd: Restore mitigation status on CPU resume
Date:   Fri, 20 Jul 2018 14:14:29 +0200
Message-Id: <20180720121422.563077746@linuxfoundation.org>
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

commit 647d0519b53f440a55df163de21c52a8205431cc upstream.

On a system where firmware can dynamically change the state of the
mitigation, the CPU will always come up with the mitigation enabled,
including when coming back from suspend.

If the user has requested "no mitigation" via a command line option,
let's enforce it by calling into the firmware again to disable it.

Similarily, for a resume from hibernate, the mitigation could have
been disabled by the boot kernel. Let's ensure that it is set
back on in that case.

Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cpufeature.h |    6 ++++++
 arch/arm64/kernel/cpu_errata.c      |    2 +-
 arch/arm64/kernel/hibernate.c       |   11 +++++++++++
 arch/arm64/kernel/suspend.c         |    8 ++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -278,6 +278,12 @@ static inline int arm64_get_ssbd_state(v
 #endif
 }
 
+#ifdef CONFIG_ARM64_SSBD
+void arm64_set_ssbd_mitigation(bool state);
+#else
+static inline void arm64_set_ssbd_mitigation(bool state) {}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -299,7 +299,7 @@ void __init arm64_enable_wa2_handling(st
 		*updptr = cpu_to_le32(aarch64_insn_gen_nop());
 }
 
-static void arm64_set_ssbd_mitigation(bool state)
+void arm64_set_ssbd_mitigation(bool state)
 {
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -313,6 +313,17 @@ int swsusp_arch_suspend(void)
 
 		sleep_cpu = -EINVAL;
 		__cpu_suspend_exit();
+
+		/*
+		 * Just in case the boot kernel did turn the SSBD
+		 * mitigation off behind our back, let's set the state
+		 * to what we expect it to be.
+		 */
+		switch (arm64_get_ssbd_state()) {
+		case ARM64_SSBD_FORCE_ENABLE:
+		case ARM64_SSBD_KERNEL:
+			arm64_set_ssbd_mitigation(true);
+		}
 	}
 
 	local_dbg_restore(flags);
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -62,6 +62,14 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	if (hw_breakpoint_restore)
 		hw_breakpoint_restore(cpu);
+
+	/*
+	 * On resume, firmware implementing dynamic mitigation will
+	 * have turned the mitigation on. If the user has forcefully
+	 * disabled it, make sure their wishes are obeyed.
+	 */
+	if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
+		arm64_set_ssbd_mitigation(false);
 }
 
 /*


