Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1552A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1552A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbeGTNdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:33:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389171AbeGTNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:33:25 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE7ECCE4;
        Fri, 20 Jul 2018 12:36:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Stellar <tstellar@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@redhat.com,
        akataria@vmware.com, akpm@linux-foundation.org,
        andrea.parri@amarulasolutions.com, ard.biesheuvel@linaro.org,
        aryabinin@virtuozzo.com, astrachan@google.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, geert@linux-m68k.org,
        ghackmann@google.com, jan.kiszka@siemens.com,
        jarkko.sakkinen@linux.intel.com, joe@perches.com,
        jpoimboe@redhat.com, keescook@google.com,
        kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        manojgupta@google.com, mawilcox@microsoft.com,
        michal.lkml@markovi.net, mjg59@google.com, mka@chromium.org,
        pombredanne@nexb.com, rientjes@google.com, rostedt@goodmis.org,
        thomas.lendacky@amd.com, tweek@google.com,
        virtualization@lists.linux-foundation.org, will.deacon@arm.com,
        yamada.masahiro@socionext.com, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.17 003/101] x86/paravirt: Make native_save_fl() extern inline
Date:   Fri, 20 Jul 2018 14:13:09 +0200
Message-Id: <20180720121423.015279253@linuxfoundation.org>
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

From: Nick Desaulniers <ndesaulniers@google.com>

commit d0a8d9378d16eb3c69bd8e6d23779fbdbee3a8c7 upstream.

native_save_fl() is marked static inline, but by using it as
a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.

paravirt's use of native_save_fl() also requires that no GPRs other than
%rax are clobbered.

Compilers have different heuristics which they use to emit stack guard
code, the emittance of which can break paravirt's callee saved assumption
by clobbering %rcx.

Marking a function definition extern inline means that if this version
cannot be inlined, then the out-of-line version will be preferred. By
having the out-of-line version be implemented in assembly, it cannot be
instrumented with a stack protector, which might violate custom calling
conventions that code like paravirt rely on.

The semantics of extern inline has changed since gnu89. This means that
folks using GCC versions >= 5.1 may see symbol redefinition errors at
link time for subdirs that override KBUILD_CFLAGS (making the C standard
used implicit) regardless of this patch. This has been cleaned up
earlier in the patch set, but is left as a note in the commit message
for future travelers.

Reports:
 https://lkml.org/lkml/2018/5/7/534
 https://github.com/ClangBuiltLinux/linux/issues/16

Discussion:
 https://bugs.llvm.org/show_bug.cgi?id=37512
 https://lkml.org/lkml/2018/5/24/1371

Thanks to the many folks that participated in the discussion.

Debugged-by: Alistair Strachan <astrachan@google.com>
Debugged-by: Matthias Kaehlcke <mka@chromium.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Tom Stellar <tstellar@redhat.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@redhat.com
Cc: akataria@vmware.com
Cc: akpm@linux-foundation.org
Cc: andrea.parri@amarulasolutions.com
Cc: ard.biesheuvel@linaro.org
Cc: aryabinin@virtuozzo.com
Cc: astrachan@google.com
Cc: boris.ostrovsky@oracle.com
Cc: brijesh.singh@amd.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: geert@linux-m68k.org
Cc: ghackmann@google.com
Cc: gregkh@linuxfoundation.org
Cc: jan.kiszka@siemens.com
Cc: jarkko.sakkinen@linux.intel.com
Cc: joe@perches.com
Cc: jpoimboe@redhat.com
Cc: keescook@google.com
Cc: kirill.shutemov@linux.intel.com
Cc: kstewart@linuxfoundation.org
Cc: linux-efi@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: manojgupta@google.com
Cc: mawilcox@microsoft.com
Cc: michal.lkml@markovi.net
Cc: mjg59@google.com
Cc: mka@chromium.org
Cc: pombredanne@nexb.com
Cc: rientjes@google.com
Cc: rostedt@goodmis.org
Cc: thomas.lendacky@amd.com
Cc: tweek@google.com
Cc: virtualization@lists.linux-foundation.org
Cc: will.deacon@arm.com
Cc: yamada.masahiro@socionext.com
Link: http://lkml.kernel.org/r/20180621162324.36656-4-ndesaulniers@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/irqflags.h |    2 +-
 arch/x86/kernel/Makefile        |    1 +
 arch/x86/kernel/irqflags.S      |   26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -13,7 +13,7 @@
  * Interrupt control:
  */
 
-static inline unsigned long native_save_fl(void)
+extern inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;
 
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -61,6 +61,7 @@ obj-y			+= alternative.o i8253.o hw_brea
 obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
+obj-y			+= irqflags.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
--- /dev/null
+++ b/arch/x86/kernel/irqflags.S
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm/asm.h>
+#include <asm/export.h>
+#include <linux/linkage.h>
+
+/*
+ * unsigned long native_save_fl(void)
+ */
+ENTRY(native_save_fl)
+	pushf
+	pop %_ASM_AX
+	ret
+ENDPROC(native_save_fl)
+EXPORT_SYMBOL(native_save_fl)
+
+/*
+ * void native_restore_fl(unsigned long flags)
+ * %eax/%rdi: flags
+ */
+ENTRY(native_restore_fl)
+	push %_ASM_ARG1
+	popf
+	ret
+ENDPROC(native_restore_fl)
+EXPORT_SYMBOL(native_restore_fl)


