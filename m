Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbeCFWc4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:32:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753978AbeCFWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:32:53 -0500
Date: Tue, 6 Mar 2018 14:32:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/1] mm: make start_isolate_page_range() fail if already
 isolated
Message-Id: <20180306143251.f83d992aaee64fb3c1a1993c@linux-foundation.org>
In-Reply-To: <0c473e9c-d28b-b965-2f14-5d195e404d0c@oracle.com>
References: <20180226191054.14025-1-mike.kravetz@oracle.com>
        <20180226191054.14025-2-mike.kravetz@oracle.com>
        <20180302160607.570e13f2157f56503fe1bdaa@linux-foundation.org>
        <3887b37d-2bc0-1eff-9aec-6a99cc0715fb@oracle.com>
        <20180302165614.edb17a020964e9ea2f1797ca@linux-foundation.org>
        <40e790c9-cd78-3d41-a69b-bff4f024c9f1@oracle.com>
        <0c473e9c-d28b-b965-2f14-5d195e404d0c@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2018 16:57:40 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> >>>
> >>> I could not immediately come up with a good idea here.  The zone lock
> >>> would be the obvious choice, but I don't think we want to hold it while
> >>> examining each of the page blocks.  Perhaps a new lock or semaphore
> >>> associated with the zone?  I'm open to suggestions.
> >>
> >> Yes, I think it would need a new lock.  Hopefully a mutex.
> > 
> > I'll look into adding an 'isolate' mutex to the zone structure and reworking
> > this patch.
> 
> I went back and examined the 'isolation functionality' with an eye on perhaps
> adding a mutex for some higher level synchronization.  However, there does
> not appear to be a straight forward solution.
> 
> What we really need is some way of preventing two threads from operating on
> the same set of page blocks concurrently.  We do not want a big mutex, as
> we do want two threads to run in parallel if operating on separate
> non-overlapping ranges (CMA does this today).  If we did this, I think we
> would need a new data structure to represent page blocks within a zone.
> start_isolate_page_range() would then then check the new data structure for
> conflicts, and if none found mark the range it is operating on as 'in use'.
> undo_isolate_page_range() would clear the entries for the range in the new
> data structure.  Such information would hang off the zone and be protected
> by the zone lock.  The new data structure could be static (like a bit map),
> or dynamic.  It certainly is doable, but ...
> 
> The more I think about it, the more I like my original proposal.  The
> comment "blundering through a whole bunch of pages then saying whoops
> then undoing everything is unpleasing" is certainly true.  But do note
> that after isolating the page blocks, we will then attempt to migrate
> pages within those blocks.  There is a more than a minimal chance that
> we will not be able to migrate something within the set of page blocks.
> In that case we again say whoops and undo even more work.
> 
> I am relatively new to this area of code.  Therefore, it would be good to
> get comments from some of the original authors.

hm, OK.  Perhaps it would help to produce a v2 which has more comments
and changelogging describing what's happening here and why things are
as they are.
