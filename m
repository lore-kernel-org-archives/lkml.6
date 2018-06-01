Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeFAL1r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:27:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbeFAL1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:27:41 -0400
Date: Fri, 1 Jun 2018 13:27:39 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, vinmenon@codeaurora.org
Subject: Re: deadlock during writeback when using f2fs filesystem
Message-ID: <20180601112739.GA15278@dhcp22.suse.cz>
References: <20180601093235.GA12489@codeaurora.org>
 <20180601102609.GZ15278@dhcp22.suse.cz>
 <20180601112050.GB12489@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601112050.GB12489@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-06-18 16:50:50, Sahitya Tummala wrote:
> On Fri, Jun 01, 2018 at 12:26:09PM +0200, Michal Hocko wrote:
> > On Fri 01-06-18 15:02:35, Sahitya Tummala wrote:
> > > Hi,
> > > 
> > > We are observing a deadlock scenario during FS writeback under low-memory
> > > condition with F2FS filesystem.
> > > 
> > > Here is the callstack of this scenario -
> > > 
> > > shrink_inactive_list()
> > > shrink_node_memcg.isra.74()
> > > shrink_node()
> > > shrink_zones(inline)
> > > do_try_to_free_pages(inline)
> > > try_to_free_pages()
> > > __perform_reclaim(inline)
> > > __alloc_pages_direct_reclaim(inline)
> > > __alloc_pages_slowpath(inline)
> > > no_zone()
> > > __alloc_pages(inline)
> > > __alloc_pages_node(inline)
> > > alloc_pages_node(inline)
> > > __page_cache_alloc(inline)
> > > pagecache_get_page()
> > > find_or_create_page(inline)
> > > grab_cache_page(inline)
> > > f2fs_grab_cache_page(inline)
> > > __get_node_page.part.32()
> > > __get_node_page(inline)
> > > get_node_page()
> > > update_inode_page()
> > > f2fs_write_inode()
> > > write_inode(inline)
> > > __writeback_single_inode()
> > > writeback_sb_inodes()
> > > __writeback_inodes_wb()
> > > wb_writeback()
> > > wb_do_writeback(inline)
> > > wb_workfn()
> > > 
> > > The writeback thread is entering into the direct reclaim path due to low-memory and is
> > > getting stuck in shrink_inactive_list(), as shrink_inactive_list() is inturn waiting for
> > > writeback to happen for the dirty pages present in the inactive list.
> > 
> > shrink_page_list waits only for writeback pages when we are in the memcg
> > reclaim. The above seems to be the global reclaim though. Moreover
> > GFP_F2FS_ZERO is GFP_NOFS so we are not waiting for writeback pages at
> > all. Are you sure the above is really a deadlock?
> > 
> 
> Let me correct my statement. It could be more of a livelock scenario.
> 
> The direct reclaim path is not doing any writeback here, so the GFP_NOFS doesn't
> make any difference. In this case, the direct reclaim has to reclaim ~32 pages,
> which it picks up from the tail of the list. All of those tail pages are dirty
> and since direct reclaim path can't do any writeback, it just loops picking and
> skipping them.

But there are surely other pages on the LRU list, aren't they?
-- 
Michal Hocko
SUSE Labs
