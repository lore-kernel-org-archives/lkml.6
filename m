Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30DFEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88872086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tos3d4Ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88872086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934643AbeFLQaB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:30:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934616AbeFLQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3UArGsOJ4hQYn/eigZSqPPkXdGphnEb7qaLbnrlpMfY=; b=Tos3d4OuaMljX/dpbC97Wv3v5i
        qyB+Hkex54obTTB990ykutA/f8AvqUXv/EvEdeCeAmAPgrq7RbNWOdQnRDGBxDKJcZWsgv0cK33lL
        H30J7VbPejjYxwD/gG2XmnG8cx/q3u38mNlEAI2ynC3ge6iFYwW4UqGXMSmDjgyTEyZJCNrnPELKh
        ULc6MtJHsV2SuGysOnR19SR44/z51Kmz+iVRpsQAYeFxzHRLpfG6A5q7YlJAouBS+2tLDIFuBJuPm
        JF3elKn7R/rsvVG5nnVUy5d1V0jcsbqpJ2vuz3Jc3Rw07frNlINJfOVfxkXSIEvT3acza4fXwtCOv
        UXFEkmCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSmAz-0004iS-Fa; Tue, 12 Jun 2018 16:29:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D86E0201EA7D2; Tue, 12 Jun 2018 18:29:43 +0200 (CEST)
Message-Id: <20180612161832.532270087@infradead.org>
User-Agent: quilt/0.63-1
Date:   Tue, 12 Jun 2018 18:12:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc:     tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org
Subject: [PATCH v2 4/4] kthread: Simplify kthread_park() completion
References: <20180612161225.693133662@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-kthread-3.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg explains the reason we could hit park+park is that
smpboot_update_cpumask_percpu_thread()'s

  for_each_cpu_and(cpu, &tmp, cpu_online_mask)
	smpboot_park_kthread();

turns into:

  for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
	smpboot_park_kthread();

on UP, ignoring the mask. But since we just completely removed that
function, this is no longer relevant.

So revert commit:

  b1f5b378e126 ("kthread: Allow kthread_park() on a parked kthread")

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/kthread.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -190,7 +190,7 @@ static void __kthread_parkme(struct kthr
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
 
-		complete_all(&self->parked);
+		complete(&self->parked);
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -465,7 +465,6 @@ void kthread_unpark(struct task_struct *
 	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
 		__kthread_bind(k, kthread->cpu, TASK_PARKED);
 
-	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	/*
 	 * __kthread_parkme() will either see !SHOULD_PARK or get the wakeup.
@@ -493,6 +492,9 @@ int kthread_park(struct task_struct *k)
 	if (WARN_ON(k->flags & PF_EXITING))
 		return -ENOSYS;
 
+	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
+		return -EBUSY;
+
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);


