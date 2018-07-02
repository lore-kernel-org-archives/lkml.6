Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B802FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF325524
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBF325524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030350AbeGBLEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:04:40 -0400
Received: from foss.arm.com ([217.140.101.70]:57490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030288AbeGBLEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:04:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4F421688;
        Mon,  2 Jul 2018 04:04:35 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C466C3F5BA;
        Mon,  2 Jul 2018 04:04:33 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 05/19] arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
Date:   Mon,  2 Jul 2018 12:04:01 +0100
Message-Id: <20180702110415.10465-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In subsequent patches, we'll want to make use of sve_user_enable() and
sve_user_disable() outside of kernel/fpsimd.c. Let's move these to
<asm/fpsimd.h> where we can make use of them.

To avoid ifdeffery in sequences like:

if (system_supports_sve() && some_condition)
	sve_user_disable();

... empty stubs are provided when support for SVE is not enabled. Note
that system_supports_sve() contains as IS_ENABLED(CONFIG_ARM64_SVE), so
the sve_user_disable() call should be optimized away entirely when
CONFIG_ARM64_SVE is not selected.

To ensure that this is the case, the stub definitions contain a
BUILD_BUG(), as we do for other stubs for which calls should always be
optimized away when the relevant config option is not selected.

At the same time, the include list of <asm/fpsimd.h> is sorted while
adding <asm/sysreg.h>.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fpsimd.h | 17 ++++++++++++++++-
 arch/arm64/kernel/fpsimd.c      | 10 ----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index fa92747a49c8..dd1ad3950ef5 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -16,13 +16,15 @@
 #ifndef __ASM_FP_H
 #define __ASM_FP_H
 
-#include <asm/ptrace.h>
 #include <asm/errno.h>
+#include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
+#include <asm/sysreg.h>
 
 #ifndef __ASSEMBLY__
 
+#include <linux/build_bug.h>
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/stddef.h>
@@ -102,6 +104,16 @@ extern int sve_set_vector_length(struct task_struct *task,
 extern int sve_set_current_vl(unsigned long arg);
 extern int sve_get_current_vl(void);
 
+static inline void sve_user_disable(void)
+{
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
+}
+
+static inline void sve_user_enable(void)
+{
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
+}
+
 /*
  * Probing and setup functions.
  * Calls to these functions must be serialised with one another.
@@ -128,6 +140,9 @@ static inline int sve_get_current_vl(void)
 	return -EINVAL;
 }
 
+static inline void sve_user_disable(void) { BUILD_BUG(); }
+static inline void sve_user_enable(void) { BUILD_BUG(); }
+
 static inline void sve_init_vq_map(void) { }
 static inline void sve_update_vq_map(void) { }
 static inline int sve_verify_vq_map(void) { return 0; }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a98a7f96aff1..58c53bc96928 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -159,16 +159,6 @@ static void sve_free(struct task_struct *task)
 	__sve_free(task);
 }
 
-static void sve_user_disable(void)
-{
-	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
-}
-
-static void sve_user_enable(void)
-{
-	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
-}
-
 /*
  * TIF_SVE controls whether a task can use SVE without trapping while
  * in userspace, and also the way a task's FPSIMD/SVE state is stored
-- 
2.11.0

