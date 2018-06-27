Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55849C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A71825C9D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A71825C9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966192AbeF0THM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:07:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966048AbeF0THI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:07:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E9FE8D751;
        Wed, 27 Jun 2018 19:07:07 +0000 (UTC)
Received: from redhat.com (ovpn-122-22.rdu2.redhat.com [10.10.122.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 44D152156880;
        Wed, 27 Jun 2018 19:07:05 +0000 (UTC)
Date:   Wed, 27 Jun 2018 22:07:02 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
Message-ID: <20180627220402-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
 <20180626045118-mutt-send-email-mst@kernel.org>
 <CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 19:07:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 19:07:07 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:05:39AM -0700, Linus Torvalds wrote:
> [ Sorry for slow reply, my travels have made a mess of my inbox ]
> 
> On Mon, Jun 25, 2018 at 6:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Linus, do you think it would be ok to have get_from_free_page_list
> > actually pop entries from the free list and use them as the buffer
> > to store PAs?
> 
> Honestly, what I think the best option would be is to get rid of this
> interface *entirely*, and just have the balloon code do
> 
>     #define GFP_MINFLAGS (__GFP_NORETRY | __GFP_NOWARN |
> __GFP_THISNODE | __GFP_NOMEMALLOC)
> 
>     struct page *page =  alloc_pages(GFP_MINFLAGS, MAX_ORDER-1);
> 
>  which is not a new interface, and simply removes the max-order page
> from the list if at all possible.
> 
> The above has the advantage of "just working", and not having any races.
> 
> Now, because you don't want to necessarily *entirely* deplete the max
> order, I'd suggest that the *one* new interface you add is just a "how
> many max-order pages are there" interface. So then you can query
> (either before or after getting the max-order page) just how many of
> them there were and whether you want to give that page back.
> 
> Notice? No need for any page lists or physical addresses. No races. No
> complex new functions.
> 
> The physical address you can just get from the "struct page" you got.
> 
> And if you run out of memory because of getting a page, you get all
> the usual "hey, we ran out of memory" responses..
> 
> Wouldn't the above be sufficient?
> 
>             Linus

I think so, thanks!

Wei, to put it in balloon terms, I think there's one thing we missed: if
you do manage to allocate a page, and you don't have a use for it, then
hey, you can just give it to the host because you know it's free - you
are going to return it to the free list.

-- 
MST
