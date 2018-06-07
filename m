Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mM5nB/4nGVv6egAAmS7hNA
	; Thu, 07 Jun 2018 12:41:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AA6E9608B8; Thu,  7 Jun 2018 12:41:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D009vZ7n"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 347FA607DC;
	Thu,  7 Jun 2018 12:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 347FA607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbeFGMlk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:41:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeFGMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HivFva8XmiILUvOpfh8cyPRXxcOTRbiJ43X4emPP++w=; b=D009vZ7nNJBAkhzbS9JUc6yjv2
        2vgdkyiEFWTS8sUbCDWd/ZK0VmlWlRdRC4NwV+FhoZWmWUbMMvGOhfLeLg7yAO18jdcQNJVfGvXmW
        Uv1COk9Jj6yQG0lhQsAd8RdjNVAithCRs7IR1ADppSv5K9Y+8uGl8fu55s8sAyFUougLg9Ns/Scqe
        J6biWP6DcvxlYl+34Hqyr2gnkhv98nDlDfZcqcSDWVwK/3YO6a+dbx2fYVpUbIDx8ZvMqcUv+sm34
        THz+fyRQGxP0dIfP/DF7LTEBoXIRSVyroSoySP/U9A6XbIYfnqWAuYmhU3rftlPDxX/Gtcvq56L09
        o3gj0QJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQuEI-0001Xb-Rx; Thu, 07 Jun 2018 12:41:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A62E2201EA7AC; Thu,  7 Jun 2018 14:41:18 +0200 (CEST)
Message-Id: <20180607124006.266038375@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 07 Jun 2018 14:33:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc: tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 4/4] kthread: Simplify kthread_park() completion
References: <20180607123310.866085998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-kthread-3.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that smpboot_update_cpumask_percpu_thread() is gone, we no longer
have anybody calling kthread_park() on already parked threads. So
revert commit:

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
