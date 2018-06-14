Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 146C8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7DF208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXkTBkRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7DF208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966356AbeFNOOF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966333AbeFNON4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E651208E4;
        Thu, 14 Jun 2018 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985636;
        bh=XAEhnOi/sA0Jxd4sGQHPDLafIXTueMaE2dqRCIGnpDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXkTBkRf50wE7bATZdkn/S4K81de0TnnpPfUaMc8+k/4fyzFTh48bS5/c2cRqq9iH
         g2Brl87jlN5qB7zdQm8ZHOiPQv0M1z67QpZ4iMVnFT2YeUXE47mHLgWdmz9qymcC8J
         koTMsLfM4s+2U9Mc9BPV16KP3TX0pUiPzWEAHb4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        yu-cheng yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 12/24] x86/fpu: Fix math emulation in eager fpu mode
Date:   Thu, 14 Jun 2018 16:05:07 +0200
Message-Id: <20180614132724.979415214@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 4ecd16ec7059390b430af34bd8bc3ca2b5dcef9a upstream.

Systems without an FPU are generally old and therefore use lazy FPU
switching. Unsurprisingly, math emulation in eager FPU mode is a
bit buggy. Fix it.

There were two bugs involving kernel code trying to use the FPU
registers in eager mode even if they didn't exist and one BUG_ON()
that was incorrect.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: yu-cheng yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/b4b8d112436bd6fab866e1b4011131507e8d7fbe.1453675014.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/fpu/internal.h |    3 ++-
 arch/x86/kernel/fpu/core.c          |    2 +-
 arch/x86/kernel/traps.c             |    1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -596,7 +596,8 @@ switch_fpu_prepare(struct fpu *old_fpu,
 	 * If the task has used the math, pre-load the FPU on xsave processors
 	 * or if the past 5 consecutive context-switches used math.
 	 */
-	fpu.preload = new_fpu->fpstate_active &&
+	fpu.preload = static_cpu_has(X86_FEATURE_FPU) &&
+		      new_fpu->fpstate_active &&
 		      (use_eager_fpu() || new_fpu->counter > 5);
 
 	if (old_fpu->fpregs_active) {
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -437,7 +437,7 @@ void fpu__clear(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
 
-	if (!use_eager_fpu()) {
+	if (!use_eager_fpu() || !static_cpu_has(X86_FEATURE_FPU)) {
 		/* FPU state will be reallocated lazily at the first use. */
 		fpu__drop(fpu);
 	} else {
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -751,7 +751,6 @@ dotraplinkage void
 do_device_not_available(struct pt_regs *regs, long error_code)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	BUG_ON(use_eager_fpu());
 
 #ifdef CONFIG_MATH_EMULATION
 	if (read_cr0() & X86_CR0_EM) {


