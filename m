Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32792C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34EA20C07
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mZtNydWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34EA20C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755296AbeF2SUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:20:07 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:53337 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753986AbeF2SUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:20:06 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6A3C624E09A8;
        Fri, 29 Jun 2018 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530296406; bh=KCm8HG6HhE6dU3GZSW4gdapqL4xYaaELj6oQgAphV9g=;
        h=From:To:Cc:Subject:Date:From;
        b=mZtNydWinR3/3a9jfUd10oEHRyxDFOXm1CW/OMUXRREuzux0JeUmeg55vHKuHObxY
         egRTm6LsavPfMvgCyP2wUl6tgwt0cpT+5gtK3kKWIjM0LHn7QH7V9ASy4GRk2Wfmy9
         HXdUZsIvQdoIwUOHvJcAmwEGTdU2mBZaBqWfbhQ8LZAhnkLJSCxvPRMNmtwTCqQvWJ
         6+kj8VzMi5RR4unawpb+bKmZOKgmBR4lnuC1vddqQIQd9jf6DvTkRopuJJXjPG0JMB
         wgPxNoPMzQsMy4JgV+MCh5HHNOTu9v5IYRS4vTrPvEJGj5wfOgvlc472NYMZWZoSbn
         14kvVtCgf+hnQ==
Received: from abrodkin-7480l.internal.synopsys.com (abrodkin-7480l.internal.synopsys.com [10.9.128.133])
        by mailhost.synopsys.com (Postfix) with ESMTP id 54B4039E5;
        Fri, 29 Jun 2018 11:20:06 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARC: Improve handling of fatal signals in do_page_fault()
Date:   Fri, 29 Jun 2018 11:20:05 -0700
Message-Id: <20180629182005.10243-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was triggered by investigation of a deadlock after OOM killer invocation,
see [1] for more details.

Looks like our handling of fatal signal in do_page_fault() has some issues:

1. We only want to do special (read "early") handling of fatal signal
   if handle_mm_fault() returned VM_FAULT_RETRY so that we don't loop
   in retry loop endlessly, otherwise we'll handle that signal normally
   on exit from exception handler.

2. up_read() is not needed as indeed it will be done in __lock_page_or_retry()
   in mm/filemap.c.

With above comments in mind simplified version should be like that:
------------------------------->8---------------------------
	if (fatal_signal_pending(current)
		if (fault & VM_FAULT_RETRY)
			if (user_mode(regs))
				return;
------------------------------->8---------------------------

But looks like there's a room for improvement, see [2].
Instead of proceeding forward and then inevitably hitting retry path we
short-cut right to kernel fix-up code in no_context.

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2018-February/003403.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=746a272e44141af24a02f6c9b0f65f4c4598ed42

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/mm/fault.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index a0b7bd6d030d..17ed78e2f5eb 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -139,12 +139,16 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
+	/* If we need to retry but a fatal signal is pending, handle the
+	 * signal first. We do not need to release the mmap_sem because
+	 * it would already be released in __lock_page_or_retry in
+	 * mm/filemap.c. */
 	if (unlikely(fatal_signal_pending(current))) {
-		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
-			up_read(&mm->mmap_sem);
-		if (user_mode(regs))
+		if (fault & VM_FAULT_RETRY) {
+			if (!user_mode(regs))
+				goto no_context;
 			return;
+		}
 	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-- 
2.17.1

