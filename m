Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B549120866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfAON6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:58:50 -0500
Received: from foss.arm.com ([217.140.101.70]:51696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbfAON6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:58:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA758A78;
        Tue, 15 Jan 2019 05:58:45 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D50F33F70D;
        Tue, 15 Jan 2019 05:58:43 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 4/4] arm64: uaccess: Implement user_access_region_active
Date:   Tue, 15 Jan 2019 13:58:29 +0000
Message-Id: <1547560709-56207-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide arm64 implementation of user_access_region_active.

Check the status of PAN or SW PAN if needed.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h  |  2 ++
 arch/arm64/include/asm/uaccess.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 72dc4c0..f0b2f32 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -114,6 +114,8 @@
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)

+#define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
+
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
 #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6a70c75..1a8acc9 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -225,6 +225,18 @@ static inline void uaccess_enable_not_uao(void)
 	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
 }

+#define unsafe_user_region_active	uaccess_region_active
+static inline bool uaccess_region_active(void)
+{
+	if (system_uses_ttbr0_pan()) {
+		return read_sysreg(ttbr1_el1) & TTBR_ASID_MASK;
+	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO) &&
+		   alternatives_applied) {
+		return !read_sysreg_s(SYS_PSTATE_PAN);
+	}
+	return false;
+}
+
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
  * current addr_limit.
--
1.9.1
