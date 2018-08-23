Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CB5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCD621480
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCD621480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeHWLlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:41:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbeHWLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:41:11 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CAF84C74;
        Thu, 23 Aug 2018 08:12:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 093/130] ARC: Improve cmpxchg syscall implementation
Date:   Thu, 23 Aug 2018 09:53:29 +0200
Message-Id: <20180823074933.188720395@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit e8708786d4fe21c043d38d760f768949a3d71185 ]

This is used in configs lacking hardware atomics to emulate atomic r-m-w
for user space, implemented by disabling preemption in kernel.

However there are issues in current implementation:

1. Process not terminated if invalid user pointer passed:
   i.e. __get_user() failed.

2. The reason for this patch was __put_user() failure not being handled
   either, specifically for the COW break scenario.
   The zero page is initially wired up and read from __get_user()
   succeeds. A subsequent write by __put_user() induces a
   Protection Violation, but COW can't finish as Linux page fault
   handler is disabled due to preempt disable.
   And what's worse is we silently return the stale value to user space.
   Fix this specific case by re-enabling preemption and explicitly
   fixing up the fault and retrying the whole sequence over.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: rewrote the changelog]
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/kernel/process.c |   47 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -44,7 +44,8 @@ SYSCALL_DEFINE0(arc_gettls)
 SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 {
 	struct pt_regs *regs = current_pt_regs();
-	int uval = -EFAULT;
+	u32 uval;
+	int ret;
 
 	/*
 	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
@@ -57,23 +58,47 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *,
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
+	ret = __get_user(uval, uaddr);
+	if (ret)
+		 goto fault;
 
-	if (uval == expected) {
-		if (!__put_user(new, uaddr))
-			regs->status32 |= STATUS_Z_MASK;
-	}
+	if (uval != expected)
+		 goto out;
 
-done:
-	preempt_enable();
+	ret = __put_user(new, uaddr);
+	if (ret)
+		 goto fault;
+
+	regs->status32 |= STATUS_Z_MASK;
 
+out:
+	preempt_enable();
 	return uval;
+
+fault:
+	preempt_enable();
+
+	if (unlikely(ret != -EFAULT))
+		 goto fail;
+
+	down_read(&current->mm->mmap_sem);
+	ret = fixup_user_fault(current, current->mm, (unsigned long) uaddr,
+			       FAULT_FLAG_WRITE, NULL);
+	up_read(&current->mm->mmap_sem);
+
+	if (likely(!ret))
+		 goto again;
+
+fail:
+	force_sig(SIGSEGV, current);
+	return ret;
 }
 
 void arch_cpu_idle(void)


