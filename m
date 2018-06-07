Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IrJDDa9RGVsWEQAAmS7hNA
	; Thu, 07 Jun 2018 15:40:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ECE60608B8; Thu,  7 Jun 2018 15:40:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5E4A760590;
	Thu,  7 Jun 2018 15:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E4A760590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934637AbeFGOlm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:41:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:36346 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932931AbeFGOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="62632631"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2018 07:41:30 -0700
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 04/10] x86/cet: Handle thread shadow stack
Date: Thu,  7 Jun 2018 07:38:01 -0700
Message-Id: <20180607143807.3611-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fork() specifies CLONE_VM but not CLONE_VFORK, the child
needs a separate program stack and a separate shadow stack.
This patch handles allocation and freeing of the thread shadow
stack.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h         |  2 ++
 arch/x86/include/asm/mmu_context.h |  3 +++
 arch/x86/kernel/cet.c              | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c          |  1 +
 arch/x86/kernel/process_64.c       |  7 +++++++
 5 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 5507469cb803..c8fd87e13859 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -19,6 +19,7 @@ struct cet_stat {
 unsigned long cet_get_shstk_ptr(void);
 int cet_push_shstk(int ia32, unsigned long ssp, unsigned long val);
 int cet_setup_shstk(void);
+int cet_setup_thread_shstk(struct task_struct *p);
 void cet_disable_shstk(void);
 void cet_disable_free_shstk(struct task_struct *p);
 int cet_restore_signal(unsigned long ssp);
@@ -28,6 +29,7 @@ static inline unsigned long cet_get_shstk_ptr(void) { return 0; }
 static inline int cet_push_shstk(int ia32, unsigned long ssp,
 				 unsigned long val) { return 0; }
 static inline int cet_setup_shstk(void) { return 0; }
+static inline int cet_setup_thread_shstk(struct task_struct *p) { return 0; }
 static inline void cet_disable_shstk(void) {}
 static inline void cet_disable_free_shstk(struct task_struct *p) {}
 static inline int cet_restore_signal(unsigned long ssp) { return 0; }
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index cf9911b5a53c..42395257efc3 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/mpx.h>
+#include <asm/cet.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -228,6 +229,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		cet_disable_free_shstk(tsk);	\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 6f445ce94c83..156f5d88ffd5 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -103,6 +103,40 @@ int cet_setup_shstk(void)
 	return 0;
 }
 
+int cet_setup_thread_shstk(struct task_struct *tsk)
+{
+	unsigned long addr, size;
+	struct cet_user_state *state;
+
+	if (!current->thread.cet.shstk_enabled)
+		return 0;
+
+	state = get_xsave_addr(&tsk->thread.fpu.state.xsave,
+			       XFEATURE_MASK_SHSTK_USER);
+
+	if (!state)
+		return -EINVAL;
+
+	size = tsk->thread.cet.shstk_size;
+	if (size == 0)
+		size = SHSTK_SIZE;
+
+	addr = shstk_mmap(0, size);
+
+	if (addr >= TASK_SIZE) {
+		tsk->thread.cet.shstk_base = 0;
+		tsk->thread.cet.shstk_size = 0;
+		tsk->thread.cet.shstk_enabled = 0;
+		return -ENOMEM;
+	}
+
+	state->user_ssp = (u64)(addr + size - sizeof(u64));
+	tsk->thread.cet.shstk_base = addr;
+	tsk->thread.cet.shstk_size = size;
+	tsk->thread.cet.shstk_enabled = 1;
+	return 0;
+}
+
 void cet_disable_shstk(void)
 {
 	u64 r;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b3b0b482983a..ae56caee41f9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -127,6 +127,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	cet_disable_free_shstk(tsk);
 	fpu__drop(fpu);
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 12bb445fb98d..6e493b0bcedd 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -317,6 +317,13 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	if (sp)
 		childregs->sp = sp;
 
+	/* Allocate a new shadow stack for pthread */
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) == CLONE_VM) {
+		err = cet_setup_thread_shstk(p);
+		if (err)
+			goto out;
+	}
+
 	err = -ENOMEM;
 	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
-- 
2.15.1
