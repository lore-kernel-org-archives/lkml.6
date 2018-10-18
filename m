Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84834C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B85020658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX1nDHV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B85020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeJSCJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbeJSCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:09:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6993204FD;
        Thu, 18 Oct 2018 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886052;
        bh=40zpIRugQuMGaAIOepOSf3UkDWwiG6pVdcCTtoSTvG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SX1nDHV9Lnz5zfaI8GVdbUFEfBntdH1zN5R9X5HeCLUr0UiR73Bx8hnxTJ5PiYpDc
         TRJ+DEQKaSb3QBP6H8n259er7bbKrhNFTwq/h4q/uM055D5DpmIwJWInfcVtOR/0jR
         rTUE9OfuNQx3/eTlWPM1jg0EDKcct1odDUBjQu5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, pbonzini@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [PATCH 4.4 33/48] x86/fpu: Remove struct fpu::counter
Date:   Thu, 18 Oct 2018 19:55:08 +0200
Message-Id: <20181018175429.718560543@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rik van Riel <riel@redhat.com>

commit 3913cc3507575273beb165a5e027a081913ed507 upstream.

With the lazy FPU code gone, we no longer use the counter field
in struct fpu for anything. Get rid it.

Signed-off-by: Rik van Riel <riel@redhat.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1475627678-20788-6-git-send-email-riel@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/fpu/internal.h |    3 ---
 arch/x86/include/asm/fpu/types.h    |   11 -----------
 arch/x86/kernel/fpu/core.c          |    3 ---
 3 files changed, 17 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -575,15 +575,12 @@ switch_fpu_prepare(struct fpu *old_fpu,
 
 		/* Don't change CR0.TS if we just switch! */
 		if (fpu.preload) {
-			new_fpu->counter++;
 			__fpregs_activate(new_fpu);
 			prefetch(&new_fpu->state);
 		}
 	} else {
-		old_fpu->counter = 0;
 		old_fpu->last_cpu = -1;
 		if (fpu.preload) {
-			new_fpu->counter++;
 			if (fpu_want_lazy_restore(new_fpu, cpu))
 				fpu.preload = 0;
 			else
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -303,17 +303,6 @@ struct fpu {
 	unsigned char			fpregs_active;
 
 	/*
-	 * @counter:
-	 *
-	 * This counter contains the number of consecutive context switches
-	 * during which the FPU stays used. If this is over a threshold, the
-	 * lazy FPU restore logic becomes eager, to save the trap overhead.
-	 * This is an unsigned char so that after 256 iterations the counter
-	 * wraps and the context switch behavior turns lazy again; this is to
-	 * deal with bursty apps that only use the FPU for a short time:
-	 */
-	unsigned char			counter;
-	/*
 	 * @state:
 	 *
 	 * In-memory copy of all FPU registers that we save/restore
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -250,7 +250,6 @@ static void fpu_copy(struct fpu *dst_fpu
 
 int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
 {
-	dst_fpu->counter = 0;
 	dst_fpu->fpregs_active = 0;
 	dst_fpu->last_cpu = -1;
 
@@ -353,7 +352,6 @@ void fpu__restore(struct fpu *fpu)
 	kernel_fpu_disable();
 	fpregs_activate(fpu);
 	copy_kernel_to_fpregs(&fpu->state);
-	fpu->counter++;
 	kernel_fpu_enable();
 }
 EXPORT_SYMBOL_GPL(fpu__restore);
@@ -370,7 +368,6 @@ EXPORT_SYMBOL_GPL(fpu__restore);
 void fpu__drop(struct fpu *fpu)
 {
 	preempt_disable();
-	fpu->counter = 0;
 
 	if (fpu->fpregs_active) {
 		/* Ignore delayed exceptions from user space */


