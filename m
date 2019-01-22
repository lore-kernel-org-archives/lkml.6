Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73573C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4177E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAVLq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:46:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727663AbfAVLq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:46:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB587AE03;
        Tue, 22 Jan 2019 11:46:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 12:46:55 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/13] epoll: introduce user structures for polling
 from userspace
In-Reply-To: <CAHk-=wh16im2u1fHcZgMa-Z19Ri=UD2aY+r9=1rO4hginjcnBQ@mail.gmail.com>
References: <20190121201456.28338-1-rpenyaev@suse.de>
 <20190121201456.28338-3-rpenyaev@suse.de>
 <CAHk-=wh16im2u1fHcZgMa-Z19Ri=UD2aY+r9=1rO4hginjcnBQ@mail.gmail.com>
Message-ID: <891cb81595dbad8b90cbb6de940da97f@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-21 22:34, Linus Torvalds wrote:
> So I'm not entirely convinced, but I guess actual numbers and users
> might convince me otherwise.
> 
> However, a quick comment:
> 
> On Tue, Jan 22, 2019 at 9:15 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>> 
>> +struct epoll_uitem {
>> +       __poll_t ready_events;
>> +       struct epoll_event event;
>> +};
> 
> This really ends up being a horrible data structure.
> 
> struct epoll_event is declared as
> 
>     struct epoll_event {
>             __poll_t events;
>             __u64 data;
>     } EPOLL_PACKED;
> 
> and __poll_t is "unsigned". So on pretty much all 64-bit architectures
> except for x86-64 (which sets that packed attribute), you have a
> packing hole there in between the events and the data, and "struct
> epoll_event" has 8-byte alignment.
> 
> Now, in "struct epoll_uitem", you end up having *another* packing hold
> in between "ready_events" and "struct epoll_event".
> 
> So this data structure that has 16 bytes of actual data, ends up being
> 24 bytes in size.
> 
> Again, x86-64 happens to be the exception to this, but that's a random
> small implementation detail, not a design thing.
> 
> I think "struct epoll_event" was badly designed to begin with to have
> this issue, but it shouldn't then be an excuse to make things even
> worse with this array of "struct epoll_uitem" things.
> 
> Hmm?

Ha! Yes, you are right.  Eyes see "packed" and brain responds
"ok, this is 12 bytes, + 4 for ready_events = 16, perfect".
I have not paid any attention to how actually this EPOLL_PACKED is
defined.  Not nice at all.  I will unfold the structure like this:

/*
  * Item, shared with userspace.  Unfortunately we can't embed 
epoll_event
  * structure, because it is badly aligned on all 64-bit archs, except
  * x86-64 (see EPOLL_PACKED).  sizeof(epoll_uitem) == 16
  */
struct epoll_uitem {
	__poll_t ready_events;
	__poll_t events;
	__u64 data;
};

Also BUILD_BUG_ON(sizeof(epoll_uitem) != 16) somewhere in alloc won't
hurt.

--
Roman


