Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C393C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C2720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C2720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436688AbeHATSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407980AbeHATSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE1D2E1E;
        Wed,  1 Aug 2018 16:53:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 016/336] kcov: ensure irq code sees a valid area
Date:   Wed,  1 Aug 2018 18:45:51 +0200
Message-Id: <20180801165029.587110750@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit c9484b986ef03492357fddd50afbdd02929cfa72 ]

Patch series "kcov: fix unexpected faults".

These patches fix a few issues where KCOV code could trigger recursive
faults, discovered while debugging a patch enabling KCOV for arch/arm:

* On CONFIG_PREEMPT kernels, there's a small race window where
  __sanitizer_cov_trace_pc() can see a bogus kcov_area.

* Lazy faulting of the vmalloc area can cause mutual recursion between
  fault handling code and __sanitizer_cov_trace_pc().

* During the context switch, switching the mm can cause the kcov_area to
  be transiently unmapped.

These are prerequisites for enabling KCOV on arm, but the issues
themsevles are generic -- we just happen to avoid them by chance rather
than design on x86-64 and arm64.

This patch (of 3):

For kernels built with CONFIG_PREEMPT, some C code may execute before or
after the interrupt handler, while the hardirq count is zero.  In these
cases, in_task() can return true.

A task can be interrupted in the middle of a KCOV_DISABLE ioctl while it
resets the task's kcov data via kcov_task_init().  Instrumented code
executed during this period will call __sanitizer_cov_trace_pc(), and as
in_task() returns true, will inspect t->kcov_mode before trying to write
to t->kcov_area.

In kcov_init_task() we update t->kcov_{mode,area,size} with plain stores,
which may be re-ordered, torn, etc.  Thus __sanitizer_cov_trace_pc() may
see bogus values for any of these fields, and may attempt to write to
memory which is not mapped.

Let's avoid this by using WRITE_ONCE() to set t->kcov_mode, with a
barrier() to ensure this is ordered before we clear t->kov_{area,size}.
This ensures that any code execute while kcov_init_task() is preempted
will either see valid values for t->kcov_{area,size}, or will see that
t->kcov_mode is KCOV_MODE_DISABLED, and bail out without touching
t->kcov_area.

Link: http://lkml.kernel.org/r/20180504135535.53744-2-mark.rutland@arm.com
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kcov.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -241,7 +241,8 @@ static void kcov_put(struct kcov *kcov)
 
 void kcov_task_init(struct task_struct *t)
 {
-	t->kcov_mode = KCOV_MODE_DISABLED;
+	WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
+	barrier();
 	t->kcov_size = 0;
 	t->kcov_area = NULL;
 	t->kcov = NULL;


