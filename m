Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B420760555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932977AbeFFQYj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:24:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:61007 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753415AbeFFQXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:23:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="62323466"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/8] x86/fsgsbase/64: Use FS/GS base helpers in core dump
Date: Wed,  6 Jun 2018 09:23:14 -0700
Message-Id: <1528302199-29619-4-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When new FSGSBASE instructions enabled, this read will
become faster.

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/elf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2..49acefb 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -10,6 +10,7 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <asm/auxvec.h>
+#include <asm/fsgsbase.h>
 
 typedef unsigned long elf_greg_t;
 
@@ -205,7 +206,6 @@ void set_personality_ia32(bool);
 
 #define ELF_CORE_COPY_REGS(pr_reg, regs)			\
 do {								\
-	unsigned long base;					\
 	unsigned v;						\
 	(pr_reg)[0] = (regs)->r15;				\
 	(pr_reg)[1] = (regs)->r14;				\
@@ -228,8 +228,8 @@ do {								\
 	(pr_reg)[18] = (regs)->flags;				\
 	(pr_reg)[19] = (regs)->sp;				\
 	(pr_reg)[20] = (regs)->ss;				\
-	rdmsrl(MSR_FS_BASE, base); (pr_reg)[21] = base;		\
-	rdmsrl(MSR_KERNEL_GS_BASE, base); (pr_reg)[22] = base;	\
+	(pr_reg)[21] = read_fsbase();				\
+	(pr_reg)[22] = read_inactive_gsbase();			\
 	asm("movl %%ds,%0" : "=r" (v)); (pr_reg)[23] = v;	\
 	asm("movl %%es,%0" : "=r" (v)); (pr_reg)[24] = v;	\
 	asm("movl %%fs,%0" : "=r" (v)); (pr_reg)[25] = v;	\
-- 
2.7.4
