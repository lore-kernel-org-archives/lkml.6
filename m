Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA006C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF21820868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qsBgEKca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF21820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeK3AvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:51:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42714 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeK3AvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mGWhneo6rPiu3VVJlPWlpF6WY1PKLe+0ArpEk0GVBI0=; b=qsBgEKca9TjNxSqtN9hsJrk+O
        xcj3zvqvh1mdsA0ZqV7GRZat0Ms/q3Lm/M9JhIRnatwMLCnY/zoXk7JsjPbaI2L3Ck3k/crgBPR+K
        Qle7HDJRsnP9FOfl5lQvJEkET5xbZkd81/heb6aA4QHlhIo7IaWhcsQSd6R7qUE0HH4BQPC+Q32Oj
        So85tFbWozNtZAwgd7FWwhcAh7N1wk8v1RWxQMYYrXY5KsvBIHtsujcVCcVAdYHcWSq8og1NCbXFN
        pJdorQto0c9PPRsU2I9uqSyMQ+cG5POtDEJQmOu4E/SC8F8uFfy1lRAnEep3SLa3ejNQdu313piM/
        2qLvio9Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSMdB-0000CL-II; Thu, 29 Nov 2018 13:45:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C22B2029FD58; Thu, 29 Nov 2018 14:44:49 +0100 (CET)
Date:   Thu, 29 Nov 2018 14:44:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yongji Xie <elohimes@gmail.com>
Cc:     mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, xieyongji@baidu.com,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129134449.GH2149@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129131232.GN2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:12:32PM +0100, Peter Zijlstra wrote:
> 
> +Cc davidlohr and waiman

> Urgh; so the case where the cmpxchg() fails because it already has a
> wakeup in progress, which then 'violates' our expectation of when the
> wakeup happens.
> 
> Yes, I think this is real, and worse, I think we need to go audit all
> wake_q_add() users and document this behaviour.
> 
> In the ideal case we'd delay the actual wakeup to the last wake_up_q(),
> but I don't think we can easily fix that.

See commit: 1d0dcb3ad9d3 ("futex: Implement lockless wakeups"), I think
that introduces the exact same bug.

Something like the below perhaps, altough this pattern seems to want a
wake_a_add() variant that already assumes get_task_struct().

diff --git a/kernel/futex.c b/kernel/futex.c
index f423f9b6577e..d14971f6ed3d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1387,11 +1387,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
 		return;
 
-	/*
-	 * Queue the task for later wakeup for after we've released
-	 * the hb->lock. wake_q_add() grabs reference to p.
-	 */
-	wake_q_add(wake_q, p);
+	get_task_struct(p);
 	__unqueue_futex(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
@@ -1401,6 +1397,13 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * plist_del in __unqueue_futex().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
+
+	/*
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock. wake_q_add() grabs reference to p.
+	 */
+	wake_q_add(wake_q, p);
+	put_task_struct(p);
 }
 
 /*
