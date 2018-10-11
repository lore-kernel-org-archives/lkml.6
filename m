Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B31C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1820658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA1820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeJLCX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:23:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:52384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJLCX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:23:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="91214723"
Received: from kcaccard-mobl3.jf.intel.com ([10.24.8.209])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2018 11:54:58 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     kernel-hardening@lists.openwall.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: entry: flush the cache if syscall error
Date:   Thu, 11 Oct 2018 11:54:58 -0700
Message-Id: <20181011185458.10186-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to make it harder to perform cache timing attacks on data
left behind by system calls. If we have an error returned from a syscall,
flush the L1 cache.

It's important to note that this patch is not addressing any specific
exploit, nor is it intended to be a complete defense against anything.
It is intended to be a low cost way of eliminating some of side effects
of a failed system call.

A performance test using sysbench on one hyperthread and a script which
attempts to repeatedly access files it does not have permission to access
on the other hyperthread found no significant performance impact.

Suggested-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/Kconfig        |  9 +++++++++
 arch/x86/entry/common.c | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..bde978eb3b4e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -445,6 +445,15 @@ config RETPOLINE
 	  code are eliminated. Since this includes the syscall entry path,
 	  it is not entirely pointless.
 
+config SYSCALL_FLUSH
+	bool "Clear L1 Cache on syscall errors"
+	default n
+	help
+	  Selecting 'y' allows the L1 cache to be cleared upon return of
+	  an error code from a syscall if the CPU supports "flush_l1d".
+	  This may reduce the likelyhood of speculative execution style
+	  attacks on syscalls.
+
 config INTEL_RDT
 	bool "Intel Resource Director Technology support"
 	default n
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3b2490b81918..26de8ea71293 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -268,6 +268,20 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 	prepare_exit_to_usermode(regs);
 }
 
+__visible inline void l1_cache_flush(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
+	    static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		if (regs->ax == 0 || regs->ax == -EAGAIN ||
+		    regs->ax == -EEXIST || regs->ax == -ENOENT ||
+		    regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
+		    regs->ax == -ENOTCONN || regs->ax == -EINPROGRESS)
+			return;
+
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+	}
+}
+
 #ifdef CONFIG_X86_64
 __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
@@ -290,6 +304,8 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 		regs->ax = sys_call_table[nr](regs);
 	}
 
+	l1_cache_flush(regs);
+
 	syscall_return_slowpath(regs);
 }
 #endif
@@ -338,6 +354,8 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 #endif /* CONFIG_IA32_EMULATION */
 	}
 
+	l1_cache_flush(regs);
+
 	syscall_return_slowpath(regs);
 }
 
-- 
2.14.4

