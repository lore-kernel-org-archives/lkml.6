Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC47C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9D52177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548706748;
	bh=fwOJJyyfG7B3jNYhWhwXkha9XAPieyz387NvxVyl80g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jW9Qytuqs4Elu+jS2Y+tZjA5/VgjSEB3uJMgg8bAopUCFo+NKYy2Ftj1UK/XAoPiO
	 MKIcPHFICWrd1xFXXoUbS1MazDdfjO3KGm5IX0hHCKiKWLiUmTrkoW7tf0B9waaGDT
	 dnH5r6azYEC5NJFphgQZKqn9K/GUXk+b9T8fh1SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfA1UTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:19:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:41898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbfA1UTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:19:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C148AF74;
        Mon, 28 Jan 2019 20:19:04 +0000 (UTC)
Date:   Mon, 28 Jan 2019 21:19:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vratislav Bendel <vbendel@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
        Minchan Kim <minchan@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1] mm: migrate: don't rely on PageMovable() of newpage
 after unlocking it
Message-ID: <20190128201902.GW18811@dhcp22.suse.cz>
References: <20190128160403.16657-1-david@redhat.com>
 <e3247625-b25c-a18a-a494-f1e9a0148932@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3247625-b25c-a18a-a494-f1e9a0148932@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 21:02:52, David Hildenbrand wrote:
> On 28.01.19 17:04, David Hildenbrand wrote:
> > While debugging some crashes related to virtio-balloon deflation that
> > happened under the old balloon migration code, I stumbled over a race
> > that still exists today.
> > 
> > What we experienced:
> > 
> > drivers/virtio/virtio_balloon.c:release_pages_balloon():
> > - WARNING: CPU: 13 PID: 6586 at lib/list_debug.c:59 __list_del_entry+0xa1/0xd0
> > - list_del corruption. prev->next should be ffffe253961090a0, but was dead000000000100
> > 
> > Turns out after having added the page to a local list when dequeuing,
> > the page would suddenly be moved to an LRU list before we would free it
> > via the local list, corrupting both lists. So a page we own and that is
> > !LRU was moved to an LRU list.
> > 
> > In __unmap_and_move(), we lock the old and newpage and perform the
> > migration. In case of vitio-balloon, the new page will become
> > movable, the old page will no longer be movable.
> > 
> > However, after unlocking newpage, there is nothing stopping the newpage
> > from getting dequeued and freed by virtio-balloon. This
> > will result in the newpage
> > 1. No longer having PageMovable()
> > 2. Getting moved to the local list before finally freeing it (using
> >    page->lru)
> > 
> > Back in the migration thread in __unmap_and_move(), we would after
> > unlocking the newpage suddenly no longer have PageMovable(newpage) and
> > will therefore call putback_lru_page(newpage), modifying page->lru
> > although that list is still in use by virtio-balloon.
> > 
> > To summarize, we have a race between migrating the newpage and checking
> > for PageMovable(newpage). Instead of checking PageMovable(newpage), we
> > can simply rely on is_lru of the original page.
> > 
> > Looks like this was introduced by d6d86c0a7f8d ("mm/balloon_compaction:
> > redesign ballooned pages management"), which was backported up to 3.12.
> > Old compaction code used PageBalloon() via -_is_movable_balloon_page()
> > instead of PageMovable(), however with the same semantics.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Vratislav Bendel <vbendel@redhat.com>
> > Cc: Rafael Aquini <aquini@redhat.com>
> > Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: stable@vger.kernel.org # 3.12+
> > Fixes: d6d86c0a7f8d ("mm/balloon_compaction: redesign ballooned pages management")
> > Reported-by: Vratislav Bendel <vbendel@redhat.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Acked-by: Rafael Aquini <aquini@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/migrate.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 4512afab46ac..31e002270b05 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1135,10 +1135,12 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >  	 * If migration is successful, decrease refcount of the newpage
> >  	 * which will not free the page because new page owner increased
> >  	 * refcounter. As well, if it is LRU page, add the page to LRU
> > -	 * list in here.
> > +	 * list in here. Don't rely on PageMovable(newpage), as that could
> > +	 * already have changed after unlocking newpage (e.g.
> > +	 * virtio-balloon deflation).
> >  	 */
> >  	if (rc == MIGRATEPAGE_SUCCESS) {
> > -		if (unlikely(__PageMovable(newpage)))
> > +		if (unlikely(!is_lru))
> >  			put_page(newpage);
> >  		else
> >  			putback_lru_page(newpage);
> > 
> 
> Vratislav just pointed out that this issue should not happen on upstream
> as __PageMovable(newpage) will still return true even after
> __ClearPageMovable(newpage). Only PageMovable(newpage) would actually
> return false.
> 
> (not sure if I am happy about this, this is horribly confusing and
> complicated)

It is confusing as hell! __ClearPageMovable is a misnomer and I have to
admit I have misread the implementation to actually ~PAGE_MAPPING_MOVABLE.

> I am not 100% sure yet, but I guess Vratislav is right. So it was
> effectively fixed by
> 
> b1123ea6d3b3 ("mm: balloon: use general non-lru movable page feature"),
> which checks for __PageMovable(newpage) instead of
> __is_movable_balloon_page(newpage).

So this is not just a clean up. Sigh!

> Anybody wanting to fix stable kernels either has to backport something
> proposed in this patch or b1123ea6d3b3.

I think we should go with a simple patch for stable so this patch sounds
like a good thing. *PageMovable thingy needs a much better documentation
and ideally a cleaner implementation as well. The current state is just
incomprehensible. 

David, could you reformulate the changelog accordingly please? My ack
still holds.
-- 
Michal Hocko
SUSE Labs
