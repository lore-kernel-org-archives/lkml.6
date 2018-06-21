Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CADC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342A20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TrBSAmNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6342A20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeFUHgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:36:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49130 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeFUHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/c9gLkY6NoWcg0JO1S3Yjbp33m/D3OLKmdJ9BwgmQN8=; b=TrBSAmNQlew0UiXB+pO4xqsDx
        0d/Wm0e723e5E2EhUyOhYoXIBGhEwEEpKAqhU5ztCeQlOWSCqEYsi9mVrCsGqeMS+pKtM3+H4pHgf
        EseeAkAJGVM2sPngszE2ETwob1y7fcgJJbi4XStjYo3ZIzOkwcuJwcKPo9H8R/dvcWgV5gICGxM0A
        qeZH4crQuN+WlgzmPAD5wjGau/0klAPZ1A2VuEeA8unv7NPKz2f6lq4yDFPCVC4ty7vb35j/Cs8Yy
        jSpJdqfXlcXutpC8LSLbjEhY2YjyDPqntbCXRWdDc1GHz8/qsqFrG3P7fraYcFAZcZfwi0SIWc2ue
        BrlJB5FwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVu8u-0003uC-7D; Thu, 21 Jun 2018 07:36:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A293F2029F1D5; Thu, 21 Jun 2018 09:36:29 +0200 (CEST)
Date:   Thu, 21 Jun 2018 09:36:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     mingo@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] kernel: locking: a possible sleep-in-atomic-context bug in
 rt_mutex_slowlock()
Message-ID: <20180621073629.GP2494@hirez.programming.kicks-ass.net>
References: <10fdf749-b47c-587c-96cb-9a877d8760ac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fdf749-b47c-587c-96cb-9a877d8760ac@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:14:49AM +0800, Jia-Ju Bai wrote:
> The kernel may sleep with holding a spinlock.
> The function call path (from bottom to top) in Linux-4.16.7 is:
> 
> [FUNC] schedule
> kernel/locking/rtmutex.c, 1223: schedule in rt_mutex_handle_deadlock
> kernel/locking/rtmutex.c, 1273: rt_mutex_handle_deadlock in
> rt_mutex_slowlock
> kernel/locking/rtmutex.c, 1249: _raw_spin_lock_irqsave in rt_mutex_slowlock
> 
> This bug is found by my static analysis tool (DSAC-2) and checked by my
> code review.
> 
> I do not know how to correctly fix this bug, so I just report them.

I think the below will do. The purpose seems to be to take out the task
when we cannot return -EDEADLOCK to userspace. And it can do so just
fine after we unlock the wait_lock.

Thomas?

---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4f014be7a4b8..d33446a05681 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1269,7 +1269,6 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	}
 
 	/*
@@ -1280,6 +1279,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
+	rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+
 	/* Remove pending timer: */
 	if (unlikely(timeout))
 		hrtimer_cancel(&timeout->timer);

