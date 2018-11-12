Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14D42241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14D42241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeKLVq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:46:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:33438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728302AbeKLVq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:46:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FEE2B036;
        Mon, 12 Nov 2018 11:54:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F7231E09A5; Mon, 12 Nov 2018 12:54:00 +0100 (CET)
Date:   Mon, 12 Nov 2018 12:54:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Jan Kara <jack@suse.cz>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: cleancache: fix corruption on missed inode
 invalidation
Message-ID: <20181112115400.GE7175@quack2.suse.cz>
References: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
 <20181112113153.GC7175@quack2.suse.cz>
 <2abdb97e-0fed-0fb5-6941-e7afcc9e0209@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abdb97e-0fed-0fb5-6941-e7afcc9e0209@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-11-18 14:40:06, Andrey Ryabinin wrote:
> 
> 
> On 11/12/18 2:31 PM, Jan Kara wrote:
> > On Mon 12-11-18 12:57:34, Pavel Tikhomirov wrote:
> >> If all pages are deleted from the mapping by memory reclaim and also
> >> moved to the cleancache:
> >>
> >> __delete_from_page_cache
> >>   (no shadow case)
> >>   unaccount_page_cache_page
> >>     cleancache_put_page
> >>   page_cache_delete
> >>     mapping->nrpages -= nr
> >>     (nrpages becomes 0)
> >>
> >> We don't clean the cleancache for an inode after final file truncation
> >> (removal).
> >>
> >> truncate_inode_pages_final
> >>   check (nrpages || nrexceptional) is false
> >>     no truncate_inode_pages
> >>       no cleancache_invalidate_inode(mapping)
> >>
> >> These way when reading the new file created with same inode we may get
> >> these trash leftover pages from cleancache and see wrong data instead of
> >> the contents of the new file.
> >>
> >> Fix it by always doing truncate_inode_pages which is already ready for
> >> nrpages == 0 && nrexceptional == 0 case and just invalidates inode.
> >>
> >> Fixes: commit 91b0abe36a7b ("mm + fs: store shadow entries in page cache")
> >> To: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Mel Gorman <mgorman@techsingularity.net>
> >> Cc: Jan Kara <jack@suse.cz>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Andi Kleen <ak@linux.intel.com>
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Reviewed-by: Vasily Averin <vvs@virtuozzo.com>
> >> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> >> ---
> >>  mm/truncate.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > The patch looks good but can you add a short comment before the
> > truncate_inode_pages() call explaining why it needs to be called always?
> > Something like:
> > 
> > 	 /*
> > 	  * Cleancache needs notification even if there are no pages or
> > 	  * shadow entries...
> > 	  */
> 
> Or we can just call cleancache_invalidate_inode(mapping) on else branch,
> so the code would be more self-explanatory, and also avoid
> function call in no-cleancache setups, which should the most of setups.

That is workable for me as well although I'd be somewhat worried that if we
have calls to inform cleancache about final inode teardown in two different
places, they can get out of sync easily. So I somewhat prefer the current
solution + comment.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
