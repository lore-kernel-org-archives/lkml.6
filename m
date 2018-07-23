Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE617ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7499820685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7499820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbeGWNsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388574AbeGWNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 23D38C37;
        Mon, 23 Jul 2018 12:46:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 065/107] x86/process: Optimize TIF_NOTSC switch
Date:   Mon, 23 Jul 2018 14:41:59 +0200
Message-Id: <20180723122416.407490961@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 5a920155e388ec22a22e0532fb695b9215c9b34d upstream

Provide and use a toggle helper instead of doing it with a branch.

x86_64: arch/x86/kernel/process.o
text	   data	    bss	    dec	    hex
3008	   8577	     16	  11601	   2d51 Before
2976       8577      16	  11569	   2d31 After

i386: arch/x86/kernel/process.o
text	   data	    bss	    dec	    hex
2925	   8673	      8	  11606	   2d56 Before
2893	   8673       8	  11574	   2d36 After

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: http://lkml.kernel.org/r/20170214081104.9244-4-khuey@kylehuey.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/tlbflush.h |   10 ++++++++++
 arch/x86/kernel/process.c       |   22 ++++------------------
 2 files changed, 14 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -111,6 +111,16 @@ static inline void cr4_clear_bits(unsign
 	}
 }
 
+static inline void cr4_toggle_bits(unsigned long mask)
+{
+	unsigned long cr4;
+
+	cr4 = this_cpu_read(cpu_tlbstate.cr4);
+	cr4 ^= mask;
+	this_cpu_write(cpu_tlbstate.cr4, cr4);
+	__write_cr4(cr4);
+}
+
 /* Read the CR4 shadow. */
 static inline unsigned long cr4_read_shadow(void)
 {
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -130,11 +130,6 @@ void flush_thread(void)
 	fpu__clear(&tsk->thread.fpu);
 }
 
-static void hard_disable_TSC(void)
-{
-	cr4_set_bits(X86_CR4_TSD);
-}
-
 void disable_TSC(void)
 {
 	preempt_disable();
@@ -143,15 +138,10 @@ void disable_TSC(void)
 		 * Must flip the CPU state synchronously with
 		 * TIF_NOTSC in the current running context.
 		 */
-		hard_disable_TSC();
+		cr4_set_bits(X86_CR4_TSD);
 	preempt_enable();
 }
 
-static void hard_enable_TSC(void)
-{
-	cr4_clear_bits(X86_CR4_TSD);
-}
-
 static void enable_TSC(void)
 {
 	preempt_disable();
@@ -160,7 +150,7 @@ static void enable_TSC(void)
 		 * Must flip the CPU state synchronously with
 		 * TIF_NOTSC in the current running context.
 		 */
-		hard_enable_TSC();
+		cr4_clear_bits(X86_CR4_TSD);
 	preempt_enable();
 }
 
@@ -234,12 +224,8 @@ void __switch_to_xtra(struct task_struct
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
 
-	if ((tifp ^ tifn) & _TIF_NOTSC) {
-		if (tifn & _TIF_NOTSC)
-			hard_disable_TSC();
-		else
-			hard_enable_TSC();
-	}
+	if ((tifp ^ tifn) & _TIF_NOTSC)
+		cr4_toggle_bits(X86_CR4_TSD);
 }
 
 /*


