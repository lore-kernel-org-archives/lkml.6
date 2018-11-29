Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D752082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/ylWzCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D752082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeK3FOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:14:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeK3FOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oLdeEs4iQuQdhF3EbcElBMjsDj0L8h3IVKZrx+0gIA8=; b=H/ylWzCnrO3uyJfk9aa58lp8I
        mkoIO6S+bCndfWhowkSoYzW86Nmc1pPqkVCqMe1WtFnBdTE7llH17ozL1ZLYVJm7fC1jXlXdm3hHl
        OFq+43N/FpI4CsIakIrC+c/boNx7u8QKYxPPKlaBLiFPOfK+IIXMj8I8cTr7oYYfG3UniM/PVlKO/
        fqDr9yROMEGgefkj6o6M4QXXoN7f86eTZ3U/oUeo5YUQ4dzsx1UUgpqi1gIjV6u/70qTlWizw+at/
        nDIyJ9eFrnB4iteDa+vCn0Jlzfb4xzAJ76aus+LMqldrK9JyqZMfhmUv5ok8rSAMX5DCzl0aoi47S
        IXqfwoLAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSQjn-0000os-01; Thu, 29 Nov 2018 18:08:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07B3A2029FD58; Thu, 29 Nov 2018 19:08:29 +0100 (CET)
Date:   Thu, 29 Nov 2018 19:08:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129180828.GA11650@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129172700.GA11632@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:27:00PM +0100, Peter Zijlstra wrote:
> 
> wake_up_q() should, per the barriers in wake_up_process, ensure that if
> wake_a_add() fails, there will be a wakeup of that task after that
> point.
> 
> So if we put wake_up_q() at the location where wake_up_process() should
> be, it should all work.
> 
> The bug in question is that it can happen at any time after
> wake_q_add(), not necessarily at wake_up_q().

Hmm, I think we're missing a barrier in wake_q_add(); when cmpxchg()
fails we still need an smp_mb().

Something like so.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d87a28da378..69def558edf6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -400,6 +400,13 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 {
 	struct wake_q_node *node = &task->wake_q;
 
+	/*
+	 * Ensure, that when the below cmpxchg() fails, the corresponding
+	 * wake_up_q() will observe our prior state.
+	 *
+	 * Pairs with the smp_mb() from wake_up_q()'s wake_up_process().
+	 */
+	smp_mb();
 	/*
 	 * Atomically grab the task, if ->wake_q is !nil already it means
 	 * its already queued (either by us or someone else) and will get the
@@ -408,7 +415,7 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * This cmpxchg() executes a full barrier, which pairs with the full
 	 * barrier executed by the wakeup in wake_up_q().
 	 */
-	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
+	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
 		return;
 
 	get_task_struct(task);
