Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C9020863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C9020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeK3Ft5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:49:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbeK3Ft5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:49:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C315AD5C;
        Thu, 29 Nov 2018 18:43:36 +0000 (UTC)
Date:   Thu, 29 Nov 2018 10:43:29 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129184329.ftxhtpgx4rwzoh6y@linux-r8p5>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <20181129134449.GH2149@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181129134449.GH2149@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, Peter Zijlstra wrote:

>On Thu, Nov 29, 2018 at 02:12:32PM +0100, Peter Zijlstra wrote:
>> Yes, I think this is real, and worse, I think we need to go audit all
>> wake_q_add() users and document this behaviour.
>>
>> In the ideal case we'd delay the actual wakeup to the last wake_up_q(),
>> but I don't think we can easily fix that.
>
>See commit: 1d0dcb3ad9d3 ("futex: Implement lockless wakeups"), I think
>that introduces the exact same bug.
>
>Something like the below perhaps, altough this pattern seems to want a
>wake_a_add() variant that already assumes get_task_struct().

So I was looking at ways to avoid the redundant reference counting,
but given how wake_q_add() and wake_up_q() are so loose I can't
see how to avoid it -- we hold reference across the calls to maintain
valid mem.

For example, wake_q will grab reference iff the cmpxchg succeeds,
likewise it will enter the wakeup loop in wake_up_q(), and there is no
awareness of which caller had the failed cmpxchg because another wakup
was in progress.

And yes, afaict all wake_q users suffer from the same issue, so we have
to move the wake_q_add() after the condition, while explicitly doing
the task ref counting.

Thanks,
Davidlohr
