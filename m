Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE116ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B249520856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B249520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbeGWNv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:51:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389457AbeGWNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49EC4BE6;
        Mon, 23 Jul 2018 12:46:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyle Huey <khuey@kylehuey.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 064/107] x86/process: Correct and optimize TIF_BLOCKSTEP switch
Date:   Mon, 23 Jul 2018 14:41:58 +0200
Message-Id: <20180723122416.323704941@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
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

From: Kyle Huey <me@kylehuey.com>

commit b9894a2f5bd18b1691cb6872c9afe32b148d0132 upstream

The debug control MSR is "highly magical" as the blockstep bit can be
cleared by hardware under not well documented circumstances.

So a task switch relying on the bit set by the previous task (according to
the previous tasks thread flags) can trip over this and not update the flag
for the next task.

To fix this its required to handle DEBUGCTLMSR_BTF when either the previous
or the next or both tasks have the TIF_BLOCKSTEP flag set.

While at it avoid branching within the TIF_BLOCKSTEP case and evaluating
boot_cpu_data twice in kernels without CONFIG_X86_DEBUGCTLMSR.

x86_64: arch/x86/kernel/process.o
text	data	bss	dec	 hex
3024    8577    16      11617    2d61	Before
3008	8577	16	11601	 2d51	After

i386: No change

[ tglx: Made the shift value explicit, use a local variable to make the
code readable and massaged changelog]

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: http://lkml.kernel.org/r/20170214081104.9244-3-khuey@kylehuey.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/msr-index.h |    1 +
 arch/x86/kernel/process.c        |   12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -150,6 +150,7 @@
 
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -223,13 +223,15 @@ void __switch_to_xtra(struct task_struct
 
 	propagate_user_return_notify(prev_p, next_p);
 
-	if ((tifp ^ tifn) & _TIF_BLOCKSTEP) {
-		unsigned long debugctl = get_debugctlmsr();
+	if ((tifp & _TIF_BLOCKSTEP || tifn & _TIF_BLOCKSTEP) &&
+	    arch_has_block_step()) {
+		unsigned long debugctl, msk;
 
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 		debugctl &= ~DEBUGCTLMSR_BTF;
-		if (tifn & _TIF_BLOCKSTEP)
-			debugctl |= DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
+		msk = tifn & _TIF_BLOCKSTEP;
+		debugctl |= (msk >> TIF_BLOCKSTEP) << DEBUGCTLMSR_BTF_SHIFT;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
 
 	if ((tifp ^ tifn) & _TIF_NOTSC) {


