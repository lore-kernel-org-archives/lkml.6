Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03F52083D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03F52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbeH3SrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:47:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:18694 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbeH3SrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:47:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 07:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="228910416"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2018 07:44:33 -0700
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
Subject: [RFC PATCH v3 8/8] x86/cet: Add PTRACE interface for CET
Date:   Thu, 30 Aug 2018 07:40:09 -0700
Message-Id: <20180830144009.3314-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830144009.3314-1-yu-cheng.yu@intel.com>
References: <20180830144009.3314-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:

    IA32_U_CET (user-mode CET settings),
    IA32_PL3_SSP (user-mode shadow stack),
    IA32_PL0_SSP (kernel-mode shadow stack),
    IA32_PL1_SSP (ring-1 shadow stack),
    IA32_PL2_SSP (ring-2 shadow stack).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/fpu/regset.h |  7 +++---
 arch/x86/kernel/fpu/regset.c      | 41 +++++++++++++++++++++++++++++++
 arch/x86/kernel/ptrace.c          | 16 ++++++++++++
 include/uapi/linux/elf.h          |  1 +
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
index d5bdffb9d27f..edad0d889084 100644
--- a/arch/x86/include/asm/fpu/regset.h
+++ b/arch/x86/include/asm/fpu/regset.h
@@ -7,11 +7,12 @@
 
 #include <linux/regset.h>
 
-extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
+extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active,
+				cetregs_active;
 extern user_regset_get_fn fpregs_get, xfpregs_get, fpregs_soft_get,
-				xstateregs_get;
+				xstateregs_get, cetregs_get;
 extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
-				 xstateregs_set;
+				 xstateregs_set, cetregs_set;
 
 /*
  * xstateregs_active == regset_fpregs_active. Please refer to the comment
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index bc02f5144b95..7008eb084d36 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -160,6 +160,47 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+int cetregs_active(struct task_struct *target, const struct user_regset *regset)
+{
+#ifdef CONFIG_X86_INTEL_CET
+	if (target->thread.cet.shstk_enabled || target->thread.cet.ibt_enabled)
+		return regset->n;
+#endif
+	return 0;
+}
+
+int cetregs_get(struct task_struct *target, const struct user_regset *regset,
+		unsigned int pos, unsigned int count,
+		void *kbuf, void __user *ubuf)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct cet_user_state *cetregs;
+
+	if (!boot_cpu_has(X86_FEATURE_SHSTK))
+		return -ENODEV;
+
+	cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_MASK_SHSTK_USER);
+
+	fpu__prepare_read(fpu);
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, cetregs, 0, -1);
+}
+
+int cetregs_set(struct task_struct *target, const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  const void *kbuf, const void __user *ubuf)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct cet_user_state *cetregs;
+
+	if (!boot_cpu_has(X86_FEATURE_SHSTK))
+		return -ENODEV;
+
+	cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_MASK_SHSTK_USER);
+
+	fpu__prepare_write(fpu);
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf, cetregs, 0, -1);
+}
+
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403865eb..ac2bc3a18427 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -49,7 +49,9 @@ enum x86_regset {
 	REGSET_IOPERM64 = REGSET_XFP,
 	REGSET_XSTATE,
 	REGSET_TLS,
+	REGSET_CET64 = REGSET_TLS,
 	REGSET_IOPERM32,
+	REGSET_CET32,
 };
 
 struct pt_regs_offset {
@@ -1276,6 +1278,13 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.size = sizeof(long), .align = sizeof(long),
 		.active = ioperm_active, .get = ioperm_get
 	},
+	[REGSET_CET64] = {
+		.core_note_type = NT_X86_CET,
+		.n = sizeof(struct cet_user_state) / sizeof(u64),
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = cetregs_active, .get = cetregs_get,
+		.set = cetregs_set
+	},
 };
 
 static const struct user_regset_view user_x86_64_view = {
@@ -1331,6 +1340,13 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = ioperm_active, .get = ioperm_get
 	},
+	[REGSET_CET32] = {
+		.core_note_type = NT_X86_CET,
+		.n = sizeof(struct cet_user_state) / sizeof(u64),
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = cetregs_active, .get = cetregs_get,
+		.set = cetregs_set
+	},
 };
 
 static const struct user_regset_view user_x86_32_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 5ef25a565e88..f4cdfdc59c0a 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -401,6 +401,7 @@ typedef struct elf64_shdr {
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+#define NT_X86_CET	0x203		/* x86 cet state */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.17.1

