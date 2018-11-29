Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F98CC07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC6A20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKXD7X8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC6A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbeK3EdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:33:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeK3EdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=os9LWZxORjOd/tSCP8UbHCUV3o58F4LdNEMdCpDfIqI=; b=MKXD7X8Yb8Bk3cgW+OVUQRZMq4
        2b0dG5XiDJa+gXg0UucC1Sy/aj4A8tGNlu96oMdR/DI+JAVf7BWEu2OMoPWsMXWPCyN2X8JTUsu+2
        5gNxx7GnfgFKvHifd5X+HAigtC6NAbpBHbMOZJ8sdULWx98Yh7zSFbFvVc/X5O0Kz9gTi3IPWwPO/
        b/ZlTpYQbXPbqLISsUQEJkg/1PHYVWakgXTh9UcuIWqOLN9LfgHk82jHKtkOA72PQv3i3/JZsxb9b
        X54ybf007wP5BuExT6svVBN8tcOGgDSplxB7GgpRonMui/20gIr+BmZdNLnggMREzLPxFHqvHPHag
        3arNxnlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSQ5e-0001Nk-Fb; Thu, 29 Nov 2018 17:27:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB3F72029FD58; Thu, 29 Nov 2018 18:27:00 +0100 (CET)
Date:   Thu, 29 Nov 2018 18:27:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129172700.GA11632@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:02:19PM -0500, Waiman Long wrote:
> On 11/29/2018 11:06 AM, Peter Zijlstra wrote:

> > Why; at that point we know the wakeup will happen after, which is all we
> > require.
> >

> Thread 1                                  Thread 2      Thread 3
> 
>     rwsem_down_read_failed()
>  raw_spin_lock_irq(&sem->wait_lock);
>  list_add_tail(&waiter.list, &wait_list);
>  raw_spin_unlock_irq(&sem->wait_lock);
>                                                         __rwsem_mark_wake();
>                                                          wake_q_add();
>                                           wake_up_q();
>                                                          waiter->task =
> NULL; --+
>  while (true)
> {                                                                 |
>  
> set_current_state(TASK_UNINTERRUPTIBLE);                                     
> |
>   if (!waiter.task) //
> false                                                    |
>      
> break;                                                                    |
>  
> schedule();                                                                  
> |
>  }                                                                       
> <-----+
>                                                         wake_up_q(&wake_q);

I think that thing is horribly whitespace damanaged. At least, it's not
making sense to me.

> OK, I got confused by the thread racing chart shown in the patch. It
> will be clearer if the clearing of waiter->task is moved down as shown.
> Otherwise, moving the clearing of waiter->task before wake_q_add() won't
> make a difference. So the patch can be a possible fix.
> 
> Still we are talking about 3 threads racing with each other. The
> clearing of wake_q.next in wake_up_q() is not atomic and it is hard to
> predict the racing result of the concurrent wake_q operations between
> threads 2 and 3. The essence of my tentative patch is to prevent the
> concurrent wake_q operations in the first place.

wake_up_q() should, per the barriers in wake_up_process, ensure that if
wake_a_add() fails, there will be a wakeup of that task after that
point.

So if we put wake_up_q() at the location where wake_up_process() should
be, it should all work.

The bug in question is that it can happen at any time after
wake_q_add(), not necessarily at wake_up_q().
