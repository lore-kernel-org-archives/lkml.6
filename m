Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB76BC04ABB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1520218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1520218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHQPsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeHQPsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:48:12 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 678FF21938;
        Fri, 17 Aug 2018 12:44:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fqe7Y-0004tM-Ez; Fri, 17 Aug 2018 08:44:52 -0400
Message-Id: <20180817124452.362459553@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Aug 2018 08:44:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [for-next][PATCH 4/8] s390/ftrace: Add -mfentry and -mnop-mcount support
References: <20180817124418.038744612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

Utilize -mfentry and -mnop-mcount gcc options together with
-mrecord-mcount to get compiler generated calls to the profiling functions
as nops which are compatible with current -mhotpatch=0,3 approach.  At the
same time -mrecord-mcount enables __mcount_loc section generation by
the compiler which allows to avoid using scripts/recordmcount.pl script.

Link: http://lkml.kernel.org/r/patch-4.thread-aa7b8d.git-aa7b8dbf236f.your-ad-here.call-01533557518-ext-9465@work.hours

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/s390/Kconfig              |  2 ++
 arch/s390/Makefile             | 16 +++++++++-------
 arch/s390/include/asm/ftrace.h |  6 +++---
 arch/s390/kernel/ftrace.c      |  2 +-
 arch/s390/kernel/mcount.S      |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e44bb2b2873e..4e914445553e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -136,6 +136,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FENTRY
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
@@ -157,6 +158,7 @@ config S390
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 68a690442be0..8498babb5dad 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -86,13 +86,15 @@ ifdef CONFIG_EXPOLINE
 endif
 
 ifdef CONFIG_FUNCTION_TRACER
-# make use of hotpatch feature if the compiler supports it
-cc_hotpatch	:= -mhotpatch=0,3
-ifeq ($(call cc-option-yn,$(cc_hotpatch)),y)
-CC_FLAGS_FTRACE := $(cc_hotpatch)
-KBUILD_AFLAGS	+= -DCC_USING_HOTPATCH
-KBUILD_CFLAGS	+= -DCC_USING_HOTPATCH
-endif
+  ifeq ($(call cc-option-yn,-mfentry -mnop-mcount),n)
+    # make use of hotpatch feature if the compiler supports it
+    cc_hotpatch	:= -mhotpatch=0,3
+    ifeq ($(call cc-option-yn,$(cc_hotpatch)),y)
+      CC_FLAGS_FTRACE := $(cc_hotpatch)
+      KBUILD_AFLAGS	+= -DCC_USING_HOTPATCH
+      KBUILD_CFLAGS	+= -DCC_USING_HOTPATCH
+    endif
+  endif
 endif
 
 # Test CFI features of binutils
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index cfccc0edd00d..8ea270fdc7fb 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -4,7 +4,7 @@
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 #define MCOUNT_INSN_SIZE	6
 #else
 #define MCOUNT_INSN_SIZE	24
@@ -42,7 +42,7 @@ struct ftrace_insn {
 static inline void ftrace_generate_nop_insn(struct ftrace_insn *insn)
 {
 #ifdef CONFIG_FUNCTION_TRACER
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	/* brcl 0,0 */
 	insn->opc = 0xc004;
 	insn->disp = 0;
@@ -57,7 +57,7 @@ static inline void ftrace_generate_nop_insn(struct ftrace_insn *insn)
 static inline int is_ftrace_nop(struct ftrace_insn *insn)
 {
 #ifdef CONFIG_FUNCTION_TRACER
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	if (insn->disp == 0)
 		return 1;
 #else
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index dc76d813e420..84be7f02d0c2 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -61,7 +61,7 @@ unsigned long ftrace_plt;
 
 static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
 {
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	/* brcl 0,0 */
 	insn->opc = 0xc004;
 	insn->disp = 0;
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 27110f3294ed..e93fbf02490c 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -35,7 +35,7 @@ ENTRY(ftrace_caller)
 	.globl	ftrace_regs_caller
 	.set	ftrace_regs_caller,ftrace_caller
 	lgr	%r1,%r15
-#ifndef CC_USING_HOTPATCH
+#if !(defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT))
 	aghi	%r0,MCOUNT_RETURN_FIXUP
 #endif
 	aghi	%r15,-STACK_FRAME_SIZE
-- 
2.18.0


