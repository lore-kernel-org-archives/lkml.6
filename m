Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803DC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E44A2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBzbl6CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E44A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeKIHvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731612AbeKIHqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:09 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3744C214DA;
        Thu,  8 Nov 2018 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714918;
        bh=yamEhLXybAN/0pdmyFMamP58lUM+muBiyGjy4d+aouM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBzbl6CP8ahGpPnxByR3lPh39Np+Dm5PbcXLsD2aAbgu6q7ssSu6QAFEmm5DhP5gV
         SZqHyQR2Fei8nkSfUSJfbXbrL53gh4PbhDfxL4wHzN9bn7FkJvrllXdn438Q6TS1w+
         Zrr+ojCQoe4PJOOdpSkrdqN1oxqju7tb47vLOA48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 30/31] x86/fpu: Fix i486 + no387 boot crash by only saving FPU registers on context switch if there is an FPU
Date:   Thu,  8 Nov 2018 13:52:54 -0800
Message-Id: <20181108215132.093848855@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 2224d616528194b02424c91c2ee254b3d29942c3 upstream.

Booting an i486 with "no387 nofxsr" ends with with the following crash:

   math_emulate: 0060:c101987d
   Kernel panic - not syncing: Math emulation needed in kernel

on the first context switch in user land.

The reason is that copy_fpregs_to_fpstate() tries FNSAVE which does not work
as the FPU is turned off.

This bug was introduced in:

  f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active users to fpu->fpstate_active")

Add a check for X86_FEATURE_FPU before trying to save FPU registers (we
have such a check in switch_fpu_finish() already).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active users to fpu->fpstate_active")
Link: http://lkml.kernel.org/r/20181016202525.29437-4-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/fpu/internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -528,7 +528,7 @@ static inline void fpregs_activate(struc
 static inline void
 switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
-	if (old_fpu->initialized) {
+	if (static_cpu_has(X86_FEATURE_FPU) && old_fpu->initialized) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else


