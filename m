Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F2AB1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A903120864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQRmusuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A903120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966381AbeFNOOp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966319AbeFNONy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C927C208E3;
        Thu, 14 Jun 2018 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985633;
        bh=zMq2fWR9ck3YK4+2WAQsT/RoNy238x7r/nrU+BR6kzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQRmusuHrLDOGsXt01P9LrlOkEnoFPVr3LQgMIOyfGJEg8ju5aY+00tUK1dHliP5a
         NZa+klqDnAbiXvk8P4DyL6HVtlg6LFSGKnbCXeNWBfC9Kv+ORSvP6u2Ikd79eP/VK4
         jxHfsPBXxM0xCIh+6akDts1H9KdYCVBiJVzKPU2k=
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
Subject: [PATCH 4.4 11/24] x86/fpu: Fix FNSAVE usage in eagerfpu mode
Date:   Thu, 14 Jun 2018 16:05:06 +0200
Message-Id: <20180614132724.940491785@linuxfoundation.org>
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

commit 5ed73f40735c68d8a656b46d09b1885d3b8740ae upstream.

In eager fpu mode, having deactivated FPU without immediately
reloading some other context is illegal.  Therefore, to recover from
FNSAVE, we can't just deactivate the state -- we need to reload it
if we're not actively context switching.

We had this wrong in fpu__save() and fpu__copy().  Fix both.
__kernel_fpu_begin() was fine -- add a comment.

This fixes a warning triggerable with nofxsr eagerfpu=on.

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
Link: http://lkml.kernel.org/r/60662444e13c76f06e23c15c5dcdba31b4ac3d67.1453675014.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/fpu/core.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -114,6 +114,10 @@ void __kernel_fpu_begin(void)
 	kernel_fpu_disable();
 
 	if (fpu->fpregs_active) {
+		/*
+		 * Ignore return value -- we don't care if reg state
+		 * is clobbered.
+		 */
 		copy_fpregs_to_fpstate(fpu);
 	} else {
 		this_cpu_write(fpu_fpregs_owner_ctx, NULL);
@@ -189,8 +193,12 @@ void fpu__save(struct fpu *fpu)
 
 	preempt_disable();
 	if (fpu->fpregs_active) {
-		if (!copy_fpregs_to_fpstate(fpu))
-			fpregs_deactivate(fpu);
+		if (!copy_fpregs_to_fpstate(fpu)) {
+			if (use_eager_fpu())
+				copy_kernel_to_fpregs(&fpu->state);
+			else
+				fpregs_deactivate(fpu);
+		}
 	}
 	preempt_enable();
 }
@@ -259,7 +267,11 @@ static void fpu_copy(struct fpu *dst_fpu
 	preempt_disable();
 	if (!copy_fpregs_to_fpstate(dst_fpu)) {
 		memcpy(&src_fpu->state, &dst_fpu->state, xstate_size);
-		fpregs_deactivate(src_fpu);
+
+		if (use_eager_fpu())
+			copy_kernel_to_fpregs(&src_fpu->state);
+		else
+			fpregs_deactivate(src_fpu);
 	}
 	preempt_enable();
 }


