Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDJMFd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:05:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDJMFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:05:31 -0400
Date: Tue, 10 Apr 2018 05:05:28 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Chris Fries <cfries@google.com>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Message-ID: <20180410120528.GB22118@bombadil.infradead.org>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
 <20180409111403.GA31652@bombadil.infradead.org>
 <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
 <20180409183827.GD17558@jaegeuk-macbookpro.roam.corp.google.com>
 <20180409194044.GA15295@bombadil.infradead.org>
 <20180410082643.GX21835@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410082643.GX21835@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 10:26:43AM +0200, Michal Hocko wrote:
> On Mon 09-04-18 12:40:44, Matthew Wilcox wrote:
> > The problem is that the mapping gfp flags are used not only for allocating
> > pages, but also for allocating the page cache data structures that hold
> > the pages.  F2FS is the only filesystem that set the __GFP_ZERO bit,
> > so it's the first time anyone's noticed that the page cache passes the
> > __GFP_ZERO bit through to the radix tree allocation routines, which
> > causes the radix tree nodes to be zeroed instead of constructed.
> > 
> > I think the right solution to this is:
> 
> This just hides the underlying problem that the node is not fully and
> properly initialized. Relying on the previous released state is just too
> subtle.

That's the fundamental design of slab-with-constructors.  The user provides
a constructor, so all newly allocagted objects are initialised to a known
state, then the user will restore the object to that state when it frees
the object to slab.

> Are you going to blacklist all potential gfp flags that come
> from the mapping? This is just unmaintainable! If anything this should
> be an explicit & with the allowed set of allowed flags.

Oh, I agree that using the set of flags used to allocate the page
in order to allocate the radix tree nodes is a pretty horrible idea.

Your suggestion, then, is:

-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);

correct?
