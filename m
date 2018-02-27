Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeB0Rxx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:53:53 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:44124 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeB0Rxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:53:51 -0500
X-Google-Smtp-Source: AH8x227MgCNJRWevMhLOLrn+A4i3L+dStKRe1p+1w+RamdCyOS1kwgtaogElaIjGEXqLa3SgZ9b28g==
Message-ID: <1519754029.7296.11.camel@gmail.com>
Subject: Re: [RFC PATCH v2] ptr_ring: linked list fallback
From: Eric Dumazet <eric.dumazet@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, David Miller <davem@davemloft.net>
Date: Tue, 27 Feb 2018 09:53:49 -0800
In-Reply-To: <1519607771-20613-1-git-send-email-mst@redhat.com>
References: <1519607771-20613-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-26 at 03:17 +0200, Michael S. Tsirkin wrote:
> So pointer rings work fine, but they have a problem: make them too small
> and not enough entries fit.  Make them too large and you start flushing
> your cache and running out of memory.
> 
> This is a new idea of mine: a ring backed by a linked list. Once you run
> out of ring entries, instead of a drop you fall back on a list with a
> common lock.
> 
> Should work well for the case where the ring is typically sized
> correctly, but will help address the fact that some user try to set e.g.
> tx queue length to 1000000.
> 
> In other words, the idea is that if a user sets a really huge TX queue
> length, we allocate a ptr_ring which is smaller, and use the backup
> linked list when necessary to provide the requested TX queue length
> legitimately.
> 
> My hope this will move us closer to direction where e.g. fw codel can
> use ptr rings without locking at all.  The API is still very rough, and
> I really need to take a hard look at lock nesting.
> 
> Compiled only, sending for early feedback/flames.

Okay I'll bite then ;)

High performance will be hit only if nothing is added in the (fallback)
list.

Under stress, list operations will be the bottleneck, allowing XXXX
items in the list, probably wasting cpu caches by always dequeue-ing
cold objects.

Since systems need to be provisioned to cope with the stress, why
trying to optimize the light load case, while we know CPU has plenty of
cycles to use ?

If something uses ptr_ring and needs a list for the fallback, it might
simply go back to the old-and-simple list stuff.

Note that this old-and-simple stuff can greatly be optimized with the
use of two lists, as was shown in UDP stack lately, to decouple
producer and consumer (batching effects)
