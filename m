Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD088C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F49920652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F49920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeFTXQt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:16:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:29835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754318AbeFTXP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:15:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 16:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66325213"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 16:15:25 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/7] x86/fsgsbase/64: Use FS/GS base helpers in core dump
Date:   Wed, 20 Jun 2018 16:15:02 -0700
Message-Id: <1529536506-26237-4-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

