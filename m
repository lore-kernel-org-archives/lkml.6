Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF55320880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfBULuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:50:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45700 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfBULuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:50:52 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gwmsI-0001RC-3Q; Thu, 21 Feb 2019 12:50:46 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 15/22] x86/entry: Add TIF_NEED_FPU_LOAD
Date:   Thu, 21 Feb 2019 12:50:13 +0100
Message-Id: <20190221115020.12385-16-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115020.12385-1-bigeasy@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TIF_NEED_FPU_LOAD. This is reserved for loading the FPU registers
before returning to userland. This flag must not be set for systems
without a FPU.
If this flag is cleared, the CPU's FPU register hold the current content
of current()'s FPU register. The in-memory copy (union fpregs_state) is
not valid.
If this flag is set, then all of CPU's FPU register may hold a random
value (except for PKRU) and it is required to load the content of the
FPU register on return to userland.

It is introduced now, so we can add code handling it now before adding
the main feature.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 6 ++++++
 arch/x86/include/asm/thread_info.h  | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 05f6fce62e9f1..9a026d11b4f97 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -537,6 +537,12 @@ static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
  *
  * The FPU context is only stored/restore for user task and ->mm is used to
  * distinguish between kernel and user threads.
+ *
+ * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers are saved in
+ * the current thread's FPU registers state.
+ * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not hold current()'s
+ * FPU registers. It is required to load the registers before returning to
+ * userland or using the content otherwise.
  */
 static inline void
 switch_fpu_prepare(struct fpu *old_fpu, int cpu)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index e0eccbcb8447d..f9453536f9bbc 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -88,6 +88,7 @@ struct thread_info {
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
+#define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
@@ -117,6 +118,7 @@ struct thread_info {
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
+#define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
-- 
2.20.1

