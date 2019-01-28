Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F075C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FA82087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfA1PEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:04:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfA1PEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:04:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82BF07F6CB;
        Mon, 28 Jan 2019 15:04:30 +0000 (UTC)
Received: from xps (ovpn-116-106.phx2.redhat.com [10.3.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47ADA6247D;
        Mon, 28 Jan 2019 15:04:24 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:04:20 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vratislav Bendel <vbendel@redhat.com>
Subject: Re: [PATCH RFC] mm: migrate: don't rely on PageMovable() of newpage
 after unlocking it
Message-ID: <20190128150420.GB10872@xps>
References: <20190128121609.9528-1-david@redhat.com>
 <20190128130709.GJ18811@dhcp22.suse.cz>
 <b03cae19-d02a-0ba2-69a1-010ee76748e7@redhat.com>
 <20190128132146.GK18811@dhcp22.suse.cz>
 <17e7d7e4-f4ca-a681-93e5-92a0c285be14@redhat.com>
 <20190128133514.GL18811@dhcp22.suse.cz>
 <cb3eccaf-0fbf-f3b8-dbbe-070acb9837be@redhat.com>
 <20190128150156.GA10872@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128150156.GA10872@xps>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 28 Jan 2019 15:04:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:01:56AM -0500, Rafael Aquini wrote:
> On Mon, Jan 28, 2019 at 03:38:38PM +0100, David Hildenbrand wrote:
> > On 28.01.19 14:35, Michal Hocko wrote:
> > > On Mon 28-01-19 14:22:52, David Hildenbrand wrote:
> > >> On 28.01.19 14:21, Michal Hocko wrote:
> > >>> On Mon 28-01-19 14:14:28, David Hildenbrand wrote:
> > >>>> On 28.01.19 14:07, Michal Hocko wrote:
> > >>>>> On Mon 28-01-19 13:16:09, David Hildenbrand wrote:
> > >>>>> [...]
> > >>>>>> My theory:
> > >>>>>>
> > >>>>>> In __unmap_and_move(), we lock the old and newpage and perform the
> > >>>>>> migration. In case of vitio-balloon, the new page will become
> > >>>>>> movable, the old page will no longer be movable.
> > >>>>>>
> > >>>>>> However, after unlocking newpage, I think there is nothing stopping
> > >>>>>> the newpage from getting dequeued and freed by virtio-balloon. This
> > >>>>>> will result in the newpage
> > >>>>>> 1. No longer having PageMovable()
> > >>>>>> 2. Getting moved to the local list before finally freeing it (using
> > >>>>>>    page->lru)
> > >>>>>
> > >>>>> Does that mean that the virtio-balloon can change the Movable state
> > >>>>> while there are other users of the page? Can you point to the code that
> > >>>>> does it? How come this can be safe at all? Or is the PageMovable stable
> > >>>>> only under the page lock?
> > >>>>>
> > >>>>
> > >>>> PageMovable is stable under the lock. The relevant instructions are in
> > >>>>
> > >>>> mm/balloon_compaction.c and include/linux/balloon_compaction.h
> > >>>
> > >>> OK, I have just checked __ClearPageMovable and it indeed requires
> > >>> PageLock. Then we also have to move is_lru = __PageMovable(page) after
> > >>> the page lock.
> > >>>
> > >>
> > >> I assume that is fine as is as the page is isolated? (yes, it will be
> > >> modified later when moving but we are interested in the original state)
> > > 
> > > OK, I've missed that the page is indeed isolated. Then the patch makes
> > > sense to me.
> > > 
> > 
> > Thanks Michal. I assume this has broken ever since balloon compaction
> > was introduced. I'll wait a little more and then resend as !RFC with a
> > cc-stable tag.
> >
> 
> Yes, balloon deflation could always race against migration
> This race was a problem, initially, and was dealt with, via:
> 
> commit 117aad1e9e4d97448d1df3f84b08bd65811e6d6a
> Author: Rafael Aquini <aquini@redhat.com>
> Date:   Mon Sep 30 13:45:16 2013 -0700
> 
>     mm: avoid reinserting isolated balloon pages into LRU lists
> 
>  
> 
> I think this upstream patch has re-introduced it, in a more subtle way,
> as we're stumbling on it now, again:
> 
> commit d6d86c0a7f8ddc5b38cf089222cb1d9540762dc2
> Author: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
> Date:   Thu Oct 9 15:29:27 2014 -0700
> 
>     mm/balloon_compaction: redesign ballooned pages management
>     
> 
> 
> On this particular race against migration case, virtio ballon deflation would 
> not see it before
> 
> commit b1123ea6d3b3da25af5c8a9d843bd07ab63213f4
> Author: Minchan Kim <minchan@kernel.org>
> Date:   Tue Jul 26 15:23:09 2016 -0700
> 
>     mm: balloon: use general non-lru movable page feature
> 
> as the recently released balloon page would be post-processed 
> without the page->lru list handling, which for migration stability
> purposes must be done under the protection of page_lock.
> 
> 

missing part here:

I think your patch adresses this new case.


Acked-by: Rafael Aquini <aquini@redhat.com>


> get rid of balloon reference count.

^^ this was a left over (sorry about my fat-fingers)
> 
> 
> -- Rafael
