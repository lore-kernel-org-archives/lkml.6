Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D5C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562D421A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562D421A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbeHFP1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:27:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732660AbeHFP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:27:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76DE8bL107218
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 09:17:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kpnkrkys7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:17:55 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Aug 2018 14:17:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 14:17:50 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76DHnLn43516114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 13:17:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77ED711C04C;
        Mon,  6 Aug 2018 16:17:57 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E7B911C058;
        Mon,  6 Aug 2018 16:17:57 +0100 (BST)
Received: from localhost (unknown [9.152.212.144])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Aug 2018 16:17:57 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:17:47 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4/4] s390/ftrace: add -mfentry and -mnop-mcount support
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18080613-0008-0000-0000-0000025DAFDD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080613-0009-0000-0000-000021C45FFF
Message-Id: <patch-4.thread-aa7b8d.git-aa7b8dbf236f.your-ad-here.call-01533557518-ext-9465@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize -mfentry and -mnop-mcount gcc options together with
-mrecord-mcount to get compiler generated calls to the profiling functions
as nops which are compatible with current -mhotpatch=0,3 approach.  At the
same time -mrecord-mcount enables __mcount_loc section generation by
the compiler which allows to avoid using scripts/recordmcount.pl script.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/Kconfig              |  2 ++
 arch/s390/Makefile             | 16 +++++++++-------
 arch/s390/include/asm/ftrace.h |  6 +++---
 arch/s390/kernel/ftrace.c      |  2 +-
 arch/s390/kernel/mcount.S      |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8a1863d9ed53..71c2d9de379f 100644
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
2.18.0.13.gd42ae10

