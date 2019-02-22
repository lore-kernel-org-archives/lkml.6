Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107802077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfBVIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:24:44 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:22533 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfBVIYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:24:43 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 34F4E435E; Fri, 22 Feb 2019 09:24:41 +0100 (CET)
Date:   Fri, 22 Feb 2019 09:24:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        david@redhat.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190222082433.qqcfbpuc7guqzsj6@d104.suse.de>
References: <20190221094212.16906-1-osalvador@suse.de>
 <c4fc87f2-9ff8-3bc1-e990-da97c56ba18f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fc87f2-9ff8-3bc1-e990-da97c56ba18f@oracle.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:12:19PM -0800, Mike Kravetz wrote:
> I suspect the reason for the check is that it was there before the ability
> to migrate gigantic pages was added, and nobody thought to remove it.  As
> you say, the likelihood of finding a gigantic page after running for some
> time is not too good.  I wonder if we should remove that check?  Just trying
> to create a gigantic page could result in a bunch of migrations which could
> impact the system.  But, this is the result of a memory offline operation
> which one would expect to have some negative impact.

The check was introduced by ("ab5ac90aecf56:mm, hugetlb: do not rely on 
overcommit limit during migration), but I would have to do some research
to the changes that came after.
I am not really sure about removing the check.
I can see that is perfectly fine to migrate gigantic pages as long as the
other nodes can back us up, but trying to allocate them at runtime seems that
is going to fail more than succeed. I might be wrong of course.
I would rather leave it as it is.

> 
> > In that situation, we will keep looping forever because scan_movable_pages()
> > will give us the same page and we will fail again because there is no node
> > where we can dequeue a gigantic page from.
> > This is not nice, and I wish we could differentiate a fatal error from a
> > transient error in do_migrate_range()->migrate_pages(), but I do not really
> > see a way now.
> 
> Michal may have some thoughts here.  Note that the repeat loop does not
> even consider the return value from do_migrate_range().  Since this the the
> result of an offline, I am thinking it was designed to retry forever.  But,
> perhaps there are some errors/ret codes where we should give up?

Well, it has changed a bit over the time.
It used to be a sort of retry-timer before, where we bailed out after
a while.
But it turned out to be too easy to fail and the timer logic was removed
in (ecde0f3e7f9ed: mm, memory_hotplug: remove timeout from __offline_memory).

I think that returning a valuable error code from migrate_pages back to
do_migrate_range has always been a bit difficult.
What should be considered a fatal error?

And for the purpose here, the error we would return is -ENOMEM when we do not
have nodes containing spare gigantic pages.
Maybe that could be one of the reasons to bail out.
If we are short of memory, offlining more memory will not do anything but apply
more pressure to the system.

But I am bit worried to actually start backing off due to that, since at the
moment, the only way to back off from offlining operation is to send a signal
to the process.

I would have to think a bit more, but another possibility that comes to my mind
is:

*) Try to check whether the hstate has free pages in has_unmovable_pages.
   If not report the gigantic page as unmovable.
   This would follow the check hugepage_migration_supported() in has_unmovable_pages.

If not, as I said, we could leave it as it is.
Should be sysadmin's responsability to check in advance that the system is ready
to take over the memory to be offlined.

> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index d5f7afda67db..04f6695b648c 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1337,8 +1337,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
> >  		if (!PageHuge(page))
> >  			continue;
> >  		head = compound_head(page);
> > -		if (hugepage_migration_supported(page_hstate(head)) &&
> > -		    page_huge_active(head))
> > +		if (page_huge_active(head))
> 
> I'm confused as to why the removal of the hugepage_migration_supported()
> check is required.  Seems that commit aa9d95fa40a2 ("mm/hugetlb: enable
> arch specific huge page size support for migration") should make the check
> work as desired for all architectures.

has_unmovable_pages() should already cover us in case the hstate is not migrateable:

<--
if (PageHuge(page)) {
	struct page *head = compound_head(page);
	unsigned int skip_pages;
	
	if (!hugepage_migration_supported(page_hstate(head)))
		goto unmovable;
	
	skip_pages = (1 << compound_order(head)) - (page - head);
	iter += skip_pages - 1;
	continue;
}
-->

Should not be migrateable, we report unmovable pages within the range,
start_isolate_page_range() will report the failure to __offline_pages() and
so we will not go further.

-- 
Oscar Salvador
SUSE L3
