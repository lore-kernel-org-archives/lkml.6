Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589BDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A66204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Pi9Q97Oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A66204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937718AbeFSOWO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:22:14 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:47006 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937442AbeFSOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:22:13 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 49DF11E04A8;
        Tue, 19 Jun 2018 16:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529418131; bh=z4igt6nrBsenZCXI52OTBmYJ4wbjji5enGqF74bCV64=;
        h=From:To:Cc:Subject:Date:From;
        b=Pi9Q97OyC53F7qvpEwUsnjqbO2c/5L73UtnOHaeiP5/Avlo2LJyBa0urlf+Uunitm
         e64ff3PlI5OU1eOOSOvfofEtLs1XnySoDXadT9XtzxVwM9y1wkDAWjKF8Fdz4kf13c
         BLhUrTr6JHCWQDF/HwmO2LHzUaKTLuERFbZfJXyrv8ripseeZxls97LIi2KjPwhBg3
         qPx2jmmUVbXbBh6/BMhyTqtS/1isNHUCw93ekMRQPjdmeD8HkuORHJltWJ/0/BkwO2
         0PLCCbFhHBEKeRPcg1b7HX7fmrPzzT8nVzJPOtNCXz5IrbpH87tJ3DbwMPZq9WlTDy
         0WCjqVAY3l8YA==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id 98A885E09;
        Tue, 19 Jun 2018 07:22:08 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org
Subject: [PATCH v2] ARC: Improve cmpxchg syscall implementation
Date:   Tue, 19 Jun 2018 17:22:05 +0300
Message-Id: <20180619142205.20493-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

arc_usr_cmpxchg syscall is supposed to be used on platforms
that lack support of Load-Locked/Store-Conditional instructions
in hardware. And in that case we mimic missing hardware features
with help of kernel's sycall that "atomically" checks current
value in memory and then if it matches caller expectation new
value is written to that same location.

What's important in the description above:
 - Check-and-exchange must be "atomical" which means
   preemption must be disabled during entire "transaction"
 - Data accessed is from user-space, i.e. we're dealing
   with virtual addresses

And in current implementation we have a couple of problems:

1. We do disable preemprion around __get_user() & __put_user()
   but that in its turn disables page fault handler.
   That means if a pointer to user's data has no mapping in
   the TLB we won't be able to access required data.
   Instead software "exception handling" code from __get_user_fn()
   will return -EFAULT.

2. What's worse if we're dealing with data from not yet allocated
   page (think of pre-copy-on-write state) we'll successfully
   read data but on write we'll silently return to user-space
   with correct result (which we really read just before). That leads
   to very strange problems in user-space app further down the line
   because new value was never written to the destination.

3. Regardless of what went wrong we'll return from syscall
   and user-space application will continue to execute.
   Even if user's pointer was completely bogus.
   In case of hardware LL/SC that app would have been killed
   by the kernel.

With that change we attempt to imrove on all 3 items above:

1. We still disable preemption around write of user's data but
   if we happen to fail with write we're enabling preemption
   and try to fix-up page fault so that we have a correct permission
   for writing user's data. Then re-try again in "atomic" context.

2. If real page fault fails or even access_ok() returns false
   we send SIGSEGV to the user-space process so if something goes
   seriously wrong we'll know about it much earlier.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-arch@vger.kernel.org
---

Changes v1 -> v2:

 * Peter's almost clean-room reimplmentation with less paranoid checks
   and direct invocation of fixup_user_fault() for in-place update of
   write permissions.

 arch/arc/kernel/process.c | 48 ++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 5ac3b547453f..7a7742fba77a 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -47,7 +47,9 @@ SYSCALL_DEFINE0(arc_gettls)
 SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 {
 	struct pt_regs *regs = current_pt_regs();
-	int uval = -EFAULT;
+	struct page *page;
+	u32 val;
+	int ret;
 
 	/*
 	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
@@ -60,23 +62,47 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 	/* Z indicates to userspace if operation succeded */
 	regs->status32 &= ~STATUS_Z_MASK;
 
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
+	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
+	if (!ret)
+		 goto fail;
 
+again:
 	preempt_disable();
 
-	if (__get_user(uval, uaddr))
-		goto done;
+	ret = __get_user(val, uaddr);
+	if (ret)
+		 goto fault;
 
-	if (uval == expected) {
-		if (!__put_user(new, uaddr))
-			regs->status32 |= STATUS_Z_MASK;
-	}
+	if (val != expected)
+		 goto out;
+
+	ret = __put_user(new, uaddr);
+	if (ret)
+		 goto fault;
+
+	regs->status32 |= STATUS_Z_MASK;
+
+out:
+	preempt_enable();
+	return val;
 
-done:
+fault:
 	preempt_enable();
 
-	return uval;
+	if (unlikely(ret != -EFAULT))
+		 goto fail;
+
+	down_read(&current->mm->mmap_sem);
+	ret = fixup_user_fault(current, current->mm, uaddr, FAULT_FLAG_WRITE,
+			       NULL);
+	up_read(&current->mm->mmap_sem);
+
+	if (likely(!ret))
+		 goto again;
+
+fail:
+	force_sig(SIGSEGV, current);
+	return ret;
 }
 
 #ifdef CONFIG_ISA_ARCV2
-- 
2.17.1

