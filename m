Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380EBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DE820836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DE820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeH3SqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:46:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:38430 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729627AbeH3SqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:46:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 07:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="67186727"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2018 07:43:42 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v3 19/24] x86/cet/shstk: Introduce WRUSS instruction
Date:   Thu, 30 Aug 2018 07:38:59 -0700
Message-Id: <20180830143904.3168-20-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830143904.3168-1-yu-cheng.yu@intel.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WRUSS is a new kernel-mode instruction but writes directly
to user shadow stack memory.  This is used to construct
a return address on the shadow stack for the signal
handler.

This instruction can fault if the user shadow stack is
invalid shadow stack memory.  In that case, the kernel does
fixup.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/special_insns.h | 37 ++++++++++++++++++++++++++++
 arch/x86/mm/extable.c                | 11 +++++++++
 arch/x86/mm/fault.c                  |  9 +++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 317fc59b512c..9f609e802c5c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -237,6 +237,43 @@ static inline void clwb(volatile void *__p)
 		: [pax] "a" (p));
 }
 
+#ifdef CONFIG_X86_INTEL_CET
+
+#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
+static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
+{
+	int err = 0;
+
+	asm volatile("1: wrussd %1, (%0)\n"
+		     "2:\n"
+		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wruss)
+		     :
+		     : "r" (addr), "r" (val));
+
+	return err;
+}
+#else
+static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
+{
+	BUG();
+	return 0;
+}
+#endif
+
+static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
+{
+	int err = 0;
+
+	asm volatile("1: wrussq %1, (%0)\n"
+		     "2:\n"
+		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wruss)
+		     :
+		     : "r" (addr), "r" (val));
+
+	return err;
+}
+#endif /* CONFIG_X86_INTEL_CET */
+
 #define nop() asm volatile ("nop")
 
 
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 45f5d6cf65ae..e06ff851b671 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -157,6 +157,17 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_clear_fs);
 
+#ifdef CONFIG_X86_INTEL_CET
+__visible bool ex_handler_wruss(const struct exception_table_entry *fixup,
+				struct pt_regs *regs, int trapnr)
+{
+	regs->ip = ex_fixup_addr(fixup);
+	regs->ax = -1;
+	return true;
+}
+EXPORT_SYMBOL(ex_handler_wruss);
+#endif
+
 __visible bool ex_has_fault_handler(unsigned long ip)
 {
 	const struct exception_table_entry *e;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 3842353fb4a3..10dbb5c9aaef 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1305,6 +1305,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		error_code |= X86_PF_USER;
 		flags |= FAULT_FLAG_USER;
 	} else {
+		/*
+		 * WRUSS is a kernel instrcution and but writes
+		 * to user shadow stack.  When a fault occurs,
+		 * both X86_PF_USER and X86_PF_SHSTK are set.
+		 * Clear X86_PF_USER here.
+		 */
+		if ((error_code & (X86_PF_USER | X86_PF_SHSTK)) ==
+		    (X86_PF_USER | X86_PF_SHSTK))
+			error_code &= ~X86_PF_USER;
 		if (regs->flags & X86_EFLAGS_IF)
 			local_irq_enable();
 	}
-- 
2.17.1

