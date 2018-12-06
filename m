Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EAD2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EAD2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeLFKwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:52:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:45818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727806AbeLFKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:52:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07B0BAFA4;
        Thu,  6 Dec 2018 10:52:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Dec 2018 11:52:11 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Eric Wong <e@80x24.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <20181205234649.ssvmv4ulwevgdla4@dcvr>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <20181205234649.ssvmv4ulwevgdla4@dcvr>
Message-ID: <39192b9caf1114c95cd23e786a9c3e60@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 00:46, Eric Wong wrote:
> Roman Penyaev <rpenyaev@suse.de> wrote:
>> Hi all,
>> 
>> The goal of this patch is to reduce contention of ep_poll_callback() 
>> which
>> can be called concurrently from different CPUs in case of high events
>> rates and many fds per epoll.  Problem can be very well reproduced by
>> generating events (write to pipe or eventfd) from many threads, while
>> consumer thread does polling.  In other words this patch increases the
>> bandwidth of events which can be delivered from sources to the poller 
>> by
>> adding poll items in a lockless way to the list.
> 
> Hi Roman,
> 
> I also tried to solve this problem many years ago with help of
> the well-tested-in-userspace wfcqueue from Mathieu's URCU.
> 
> I was also looking to solve contention with parallel epoll_wait
> callers with this.  AFAIK, it worked well; but needed the
> userspace tests from wfcqueue ported over to the kernel and more
> review.
> 
> I didn't have enough computing power to show the real-world
> benefits or funding to continue:
> 
> 	https://lore.kernel.org/lkml/?q=wfcqueue+d:..20130501

Hi Eric,

Nice work.  That was a huge change by itself and by dependency
on wfcqueue.  I could not find any valuable discussion on this,
what was the reaction of the community?


> It might not be too much trouble for you to brush up the wait-free
> patches and test them against the rwlock implementation.

Ha :)  I may try to cherry-pick these patches, let's see how many
conflicts I have to resolve, eventpoll.c has been changed a lot
since that (6 years passed, right?)

But reading your work description I can assume that epoll_wait() calls
should be faster, because they do not content with ep_poll_callback(),
and I did not try to solve this, only contention between producers,
which make my change tiny.

I also found your https://yhbt.net/eponeshotmt.c , where you count
number of bare epoll_wait() calls, which IMO is not correct, because
we need to count how many events are delivered, but not how fast
you've returned from epoll_wait().  But as I said no doubts that
getting rid of contention between consumer and producers will show
even better results.

--
Roman
