Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F29BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE8A20878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE8A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeLDLvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:51:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:54304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbeLDLvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:51:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41B2CB068;
        Tue,  4 Dec 2018 11:50:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Dec 2018 12:50:58 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <CAHk-=wiQX4HnBpyrxCwJmhBRff0GG65tOhsRnA=2KdYL=PBdyg@mail.gmail.com>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <CAHk-=wiQX4HnBpyrxCwJmhBRff0GG65tOhsRnA=2KdYL=PBdyg@mail.gmail.com>
Message-ID: <83edf06ce9db540495b53527eca3248c@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-03 18:34, Linus Torvalds wrote:
> On Mon, Dec 3, 2018 at 3:03 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>> 
>> Also I'm not quite sure where to put very special lockless variant
>> of adding element to the list (list_add_tail_lockless() in this
>> patch).  Seems keeping it locally is safer.
> 
> That function is scary, and can be mis-used so easily that I
> definitely don't want to see it anywhere else.
> 
> Afaik, it's *really* important that only "add_tail" operations can be
> done in parallel.

True, adding element either to head or to tail can work in parallel,
any mix will corrupt the list.  I tried to reflect this in the comment
of list_add_tail_lockless().  Although not sure has it become clearer
to a reader or not.


> This also ends up making the memory ordering of "xchg()" very very
> important. Yes, we've documented it as being an ordering op, but I'm
> not sure we've relied on it this directly before.

Seems exit_mm() does exactly the same, the following chunk:

		up_read(&mm->mmap_sem);

		self.task = current;
		self.next = xchg(&core_state->dumper.next, &self);


At least code pattern looks similar.


> I also note that now we do more/different locking in the waitqueue
> handling, because the code now takes both that rwlock _and_ the
> waitqueue spinlock for wakeup. That also makes me worried that the
> "waitqueue_active()" games are no no longer reliable. I think they're
> fine (looks like they are only done under the write-lock, so it's
> effectively the same serialization anyway),


The only difference in waking up is that same epollitem waitqueue can be
observed as active from different CPUs, real wake up happens only once
(wake_up() takes wq.lock, so should be fine to call it multiple times),
but 1 is returned for all callers of ep_poll_callback() who has seen
the wq as active.

If epollitem is created with EPOLLEXCLUSIVE flag, then 1, which is 
returned
from ep_poll_callback(), indicates "break the loop, exclusive wake up 
has
happened" (the loop is in __wake_up_common), but even we consider this
exclusive wake up case this seems is totally fine, because wake up 
events
are not lost and epollitem will scan all ready fds and eventually will
observe all of the callers (who has returned 1 from ep_poll_callback())
as ready.  I hope I did not miss anything.


> but the upshoot of all of
> this is that I *really* want others to look at this patch too. A lot
> of small subtle things here.

Would be great if someone can look through, eventpoll.c looks a
bit abandoned.

--
Roman
