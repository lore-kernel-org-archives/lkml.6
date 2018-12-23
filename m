Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A382FC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724EE21908
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PdffNuuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeLWPQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 10:16:32 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:55655 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLWPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 10:16:31 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBNFDsk0019864;
        Mon, 24 Dec 2018 00:13:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBNFDsk0019864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545578035;
        bh=TnkmH1oWl9Y75i5YAnHWmSNHaqRANe2OtGoNyalrVew=;
        h=From:To:Cc:Subject:Date:From;
        b=PdffNuuWbYnUdXa2DUKSV6MCcUgu7enR9wBDf8O8nMWXErxY7dXWXaPFvfoU+MDE6
         hsUloc/H8W+RNi9Sl5nuM7AyMvYOxLiFMh3sq/ruEQ3FGCc9SW9rg+KBciybSSWoQs
         B29Wwt+nZkZ8M/wLmleZXsdS/vh5mkHsSh5c8LNozMDozGvt1RO6DI7GQJX/t7Hp4/
         +0KitPgEp07fYMbR/S1DOmDj85Cb2ZpwHDwvVU6pkWoArYOK2ra/n5dvMQrtZLqglK
         pRa4RHDQ8s4LJ+Y7yMMIRQ267qBAQNPbYlyO3JtrJq1HqTudcTtLrj5GV7exYCxKoy
         SF3SNOM9aLMbA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/trace: set TRACE_INCLUDE_PATH instead of include path
Date:   Mon, 24 Dec 2018 00:13:50 +0900
Message-Id: <1545578030-30097-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set TRACE_INCLUDE_PATH correctly for exceptions.h and irq_vectors.h
This is consistent with fpu.h, hyperv.h, mpx.h in the same directory.
The ugly include paths will go away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/trace/exceptions.h  | 2 +-
 arch/x86/include/asm/trace/irq_vectors.h | 2 +-
 arch/x86/kernel/Makefile                 | 2 --
 arch/x86/mm/Makefile                     | 2 --
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 69615e3..3d1f138 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -45,7 +45,7 @@ DEFINE_PAGE_FAULT_EVENT(page_fault_user);
 DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH asm/trace/
 #define TRACE_INCLUDE_FILE exceptions
 #endif /*  _TRACE_PAGE_FAULT_H */
 
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 0af81b5..e38a76e 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -389,7 +389,7 @@ TRACE_EVENT(vector_free_moved,
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH asm/trace/
 #define TRACE_INCLUDE_FILE irq_vectors
 #endif /*  _TRACE_IRQ_VECTORS_H */
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index da0b6bc..e581734 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -42,8 +42,6 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
-CFLAGS_irq.o := -I$(src)/../include/asm/trace
-
 obj-y			:= process_$(BITS).o signal.o
 obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4b101dd..6d474d9 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -21,8 +21,6 @@ CFLAGS_physaddr.o		:= $(nostackp)
 CFLAGS_setup_nx.o		:= $(nostackp)
 CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
-CFLAGS_fault.o := -I$(src)/../include/asm/trace
-
 obj-$(CONFIG_X86_PAT)		+= pat_rbtree.o
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
-- 
2.7.4

