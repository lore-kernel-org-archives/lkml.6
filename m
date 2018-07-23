Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E672ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5575F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5575F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbeGWNrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbeGWNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:51 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0F10CCB5;
        Mon, 23 Jul 2018 12:45:41 +0000 (UTC)
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
Subject: [PATCH 4.4 063/107] x86/process: Optimize TIF checks in __switch_to_xtra()
Date:   Mon, 23 Jul 2018 14:41:57 +0200
Message-Id: <20180723122416.251142387@linuxfoundation.org>
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

commit af8b3cd3934ec60f4c2a420d19a9d416554f140b upstream

Help the compiler to avoid reevaluating the thread flags for each checked
bit by reordering the bit checks and providing an explicit xor for
evaluation.

With default defconfigs for each arch,

x86_64: arch/x86/kernel/process.o
text       data     bss     dec     hex
3056       8577      16   11649    2d81	Before
3024	   8577      16	  11617	   2d61	After

i386: arch/x86/kernel/process.o
text       data     bss     dec     hex
2957	   8673	      8	  11638	   2d76	Before
2925	   8673       8	  11606	   2d56	After

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: http://lkml.kernel.org/r/20170214081104.9244-2-khuey@kylehuey.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

[dwmw2: backported to make TIF_RDS handling simpler.
        No deferred TR reload.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/process.c |   54 ++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -188,48 +188,56 @@ int set_tsc_mode(unsigned int val)
 	return 0;
 }
 
+static inline void switch_to_bitmap(struct tss_struct *tss,
+				    struct thread_struct *prev,
+				    struct thread_struct *next,
+				    unsigned long tifp, unsigned long tifn)
+{
+	if (tifn & _TIF_IO_BITMAP) {
+		/*
+		 * Copy the relevant range of the IO bitmap.
+		 * Normally this is 128 bytes or less:
+		 */
+		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
+		       max(prev->io_bitmap_max, next->io_bitmap_max));
+	} else if (tifp & _TIF_IO_BITMAP) {
+		/*
+		 * Clear any possible leftover bits:
+		 */
+		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
+	}
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		      struct tss_struct *tss)
 {
 	struct thread_struct *prev, *next;
+	unsigned long tifp, tifn;
 
 	prev = &prev_p->thread;
 	next = &next_p->thread;
 
-	if (test_tsk_thread_flag(prev_p, TIF_BLOCKSTEP) ^
-	    test_tsk_thread_flag(next_p, TIF_BLOCKSTEP)) {
+	tifn = READ_ONCE(task_thread_info(next_p)->flags);
+	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
+	switch_to_bitmap(tss, prev, next, tifp, tifn);
+
+	propagate_user_return_notify(prev_p, next_p);
+
+	if ((tifp ^ tifn) & _TIF_BLOCKSTEP) {
 		unsigned long debugctl = get_debugctlmsr();
 
 		debugctl &= ~DEBUGCTLMSR_BTF;
-		if (test_tsk_thread_flag(next_p, TIF_BLOCKSTEP))
+		if (tifn & _TIF_BLOCKSTEP)
 			debugctl |= DEBUGCTLMSR_BTF;
-
 		update_debugctlmsr(debugctl);
 	}
 
-	if (test_tsk_thread_flag(prev_p, TIF_NOTSC) ^
-	    test_tsk_thread_flag(next_p, TIF_NOTSC)) {
-		/* prev and next are different */
-		if (test_tsk_thread_flag(next_p, TIF_NOTSC))
+	if ((tifp ^ tifn) & _TIF_NOTSC) {
+		if (tifn & _TIF_NOTSC)
 			hard_disable_TSC();
 		else
 			hard_enable_TSC();
 	}
-
-	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
-		/*
-		 * Copy the relevant range of the IO bitmap.
-		 * Normally this is 128 bytes or less:
-		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(prev->io_bitmap_max, next->io_bitmap_max));
-	} else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
-		/*
-		 * Clear any possible leftover bits:
-		 */
-		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
-	}
-	propagate_user_return_notify(prev_p, next_p);
 }
 
 /*


