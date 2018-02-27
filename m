Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeB0Tfo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:35:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751734AbeB0Tfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:35:43 -0500
Date: Tue, 27 Feb 2018 21:35:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH v2] ptr_ring: linked list fallback
Message-ID: <20180227212120-mutt-send-email-mst@kernel.org>
References: <1519607771-20613-1-git-send-email-mst@redhat.com>
 <1519754029.7296.11.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519754029.7296.11.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:53:49AM -0800, Eric Dumazet wrote:
> On Mon, 2018-02-26 at 03:17 +0200, Michael S. Tsirkin wrote:
> > So pointer rings work fine, but they have a problem: make them too small
> > and not enough entries fit.  Make them too large and you start flushing
> > your cache and running out of memory.
> > 
> > This is a new idea of mine: a ring backed by a linked list. Once you run
> > out of ring entries, instead of a drop you fall back on a list with a
> > common lock.
> > 
> > Should work well for the case where the ring is typically sized
> > correctly, but will help address the fact that some user try to set e.g.
> > tx queue length to 1000000.
> > 
> > In other words, the idea is that if a user sets a really huge TX queue
> > length, we allocate a ptr_ring which is smaller, and use the backup
> > linked list when necessary to provide the requested TX queue length
> > legitimately.
> > 
> > My hope this will move us closer to direction where e.g. fw codel can
> > use ptr rings without locking at all.  The API is still very rough, and
> > I really need to take a hard look at lock nesting.
> > 
> > Compiled only, sending for early feedback/flames.
> 
> Okay I'll bite then ;)

Let me start by saying that there's no intent to merge this
before any numbers show a performance gain.

> High performance will be hit only if nothing is added in the (fallback)
> list.
> 
> Under stress, list operations will be the bottleneck, allowing XXXX
> items in the list, probably wasting cpu caches by always dequeue-ing
> cold objects.
>
> Since systems need to be provisioned to cope with the stress, why
> trying to optimize the light load case, while we know CPU has plenty of
> cycles to use ?

E.g. with tun people configure huge rx rings to avoid packet drops, but
in practice tens of packets is the maximum we see even under heavy load
except <1% of time.

So the list will get used a very small % of time and yes, that
time it will be slower.

> If something uses ptr_ring and needs a list for the fallback, it might
> simply go back to the old-and-simple list stuff.


So for size > 512 we use a list, for size < 512 we use a ptr ring?

That is absolutely an option.

My concern is that this means that simply by increasing the size
using ethtool suddenly user sees a slowdown.
This did not use to be the case so users might be confused.

> Note that this old-and-simple stuff can greatly be optimized with the
> use of two lists, as was shown in UDP stack lately, to decouple
> producer and consumer (batching effects)

Pls note that such a batching is already built in to this patch:
packets are added to the last skb, then dequeued as a batch
and moved to consumer_list.

-- 
MST
