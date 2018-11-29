Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C17C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B921019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nau6UIs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4B921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeK3DM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:12:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbeK3DM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CX5oAC3wZPuif0c1h+buzxsrGVj6+VxDHVSytBvEyII=; b=nau6UIs362HXzB5SHMi96qkqO
        qpKMHtTtiG6Uq4ecnwC1KpBIdMHx+/DFzM3PK4TNR1fb+CHrUmoPMbm6CNpEWArULdgh1GfpdORRN
        BcV/3PjybtqVOuy2Mop/m05ngGPgSnUSO9niittBWOTY5PoqXG2MCknMKwHn/59SDWTRrSVUdmzbq
        dee8YUuDXDyqytzCykX/Bwkxy5JK5VhoFoGS63gAw5Kpmagco09pnuawQOKRTc6a5TPiFCFsBxa6f
        HXI2nk5MBXMCnBM3Osv4xf2PHQwBSnDwdvDYQiC8HuzK8jT/4T6igtv/OHmwATvsjlpu087IOifQM
        HOh384edA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOph-0003ru-1v; Thu, 29 Nov 2018 16:06:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CF772029FD58; Thu, 29 Nov 2018 17:06:27 +0100 (CET)
Date:   Thu, 29 Nov 2018 17:06:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129160627.GU2131@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:21:58AM -0500, Waiman Long wrote:

> >> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> >> index 09b1800..50d9af6 100644
> >> --- a/kernel/locking/rwsem-xadd.c
> >> +++ b/kernel/locking/rwsem-xadd.c
> >> @@ -198,15 +198,22 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
> >>  		woken++;
> >>  		tsk = waiter->task;
> >>  
> >> -		wake_q_add(wake_q, tsk);
> >> +		get_task_struct(tsk);
> >>  		list_del(&waiter->list);
> >>  		/*
> >> -		 * Ensure that the last operation is setting the reader
> >> +		 * Ensure calling get_task_struct() before setting the reader
> >>  		 * waiter to nil such that rwsem_down_read_failed() cannot
> >>  		 * race with do_exit() by always holding a reference count
> >>  		 * to the task to wakeup.
> >>  		 */
> >>  		smp_store_release(&waiter->task, NULL);
> >> +		/*
> >> +		 * Ensure issuing the wakeup (either by us or someone else)
> >> +		 * after setting the reader waiter to nil.
> >> +		 */
> >> +		wake_q_add(wake_q, tsk);
> >> +		/* wake_q_add() already take the task ref */
> >> +		put_task_struct(tsk);
> >>  	}
> >>  
> >>  	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
> 
> I doubt putting wake_q_add() after clearing waiter->task can really fix

Why; at that point we know the wakeup will happen after, which is all we
require.


