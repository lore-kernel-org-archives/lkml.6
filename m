Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC25ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6D42157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6D42157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391987AbeIVGKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44142 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391931AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BP-4a; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdp-0000uM-5q; Sat, 22 Sep 2018 01:19:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kyle Huey" <khuey@kylehuey.com>,
        "Andy Lutomirski" <luto@kernel.org>, "Kyle Huey" <me@kylehuey.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.872115964@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 58/63] x86/process: Optimize TIF checks in
 __switch_to_xtra()
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Huey <me@kylehuey.com>

commit af8b3cd3934ec60f4c2a420d19a9d416554f140b upstream.

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
[bwh: Backported to 3.16:
 - We don't do refresh_tr_limit() here
 - Use ACCESS_ONCE() instead of READ_ONCE()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/process.c | 54 ++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 23 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -196,48 +196,56 @@ int set_tsc_mode(unsigned int val)
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
+	tifn = ACCESS_ONCE(task_thread_info(next_p)->flags);
+	tifp = ACCESS_ONCE(task_thread_info(prev_p)->flags);
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

