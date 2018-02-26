Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeBZHhE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:37:04 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:39654 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBZHhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:37:00 -0500
X-Google-Smtp-Source: AH8x225pbLKBej6ahERXo4BeVt/hV784Ko+qbmqBKPT6Mbt66BbBQPnrfEwFX5nkCEv52eKc2heU7A==
Date: Mon, 26 Feb 2018 16:36:52 +0900
From: Minchan Kim <minchan@kernel.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] mm: Fix races between address_space dereference and free
 in page_evicatable
Message-ID: <20180226073652.GA168047@rodete-desktop-imager.corp.google.com>
References: <20180212081227.1940-1-ying.huang@intel.com>
 <20180218092245.GA52741@rodete-laptop-imager.corp.google.com>
 <20180219105735.32iplpsmnigwf75j@quack2.suse.cz>
 <20180226052009.GB112402@rodete-desktop-imager.corp.google.com>
 <874lm4tfw3.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lm4tfw3.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 02:38:04PM +0800, Huang, Ying wrote:
> Minchan Kim <minchan@kernel.org> writes:
> 
> > Hi Jan,
> >
> > On Mon, Feb 19, 2018 at 11:57:35AM +0100, Jan Kara wrote:
> >> Hi Minchan,
> >> 
> >> On Sun 18-02-18 18:22:45, Minchan Kim wrote:
> >> > On Mon, Feb 12, 2018 at 04:12:27PM +0800, Huang, Ying wrote:
> >> > > From: Huang Ying <ying.huang@intel.com>
> >> > > 
> >> > > When page_mapping() is called and the mapping is dereferenced in
> >> > > page_evicatable() through shrink_active_list(), it is possible for the
> >> > > inode to be truncated and the embedded address space to be freed at
> >> > > the same time.  This may lead to the following race.
> >> > > 
> >> > > CPU1                                                CPU2
> >> > > 
> >> > > truncate(inode)                                     shrink_active_list()
> >> > >   ...                                                 page_evictable(page)
> >> > >   truncate_inode_page(mapping, page);
> >> > >     delete_from_page_cache(page)
> >> > >       spin_lock_irqsave(&mapping->tree_lock, flags);
> >> > >         __delete_from_page_cache(page, NULL)
> >> > >           page_cache_tree_delete(..)
> >> > >             ...                                         mapping = page_mapping(page);
> >> > >             page->mapping = NULL;
> >> > >             ...
> >> > >       spin_unlock_irqrestore(&mapping->tree_lock, flags);
> >> > >       page_cache_free_page(mapping, page)
> >> > >         put_page(page)
> >> > >           if (put_page_testzero(page)) -> false
> >> > > - inode now has no pages and can be freed including embedded address_space
> >> > > 
> >> > >                                                         mapping_unevictable(mapping)
> >> > > 							  test_bit(AS_UNEVICTABLE, &mapping->flags);
> >> > > - we've dereferenced mapping which is potentially already free.
> >> > > 
> >> > > Similar race exists between swap cache freeing and page_evicatable() too.
> >> > > 
> >> > > The address_space in inode and swap cache will be freed after a RCU
> >> > > grace period.  So the races are fixed via enclosing the page_mapping()
> >> > > and address_space usage in rcu_read_lock/unlock().  Some comments are
> >> > > added in code to make it clear what is protected by the RCU read lock.
> >> > 
> >> > Is it always true for every FSes, even upcoming FSes?
> >> > IOW, do we have any strict rule FS folks must use RCU(i.e., call_rcu)
> >> > to destroy inode?
> >> > 
> >> > Let's cc linux-fs.
> >> 
> >> That's actually a good question. Pathname lookup relies on inodes being
> >> protected by RCU so "normal" filesystems definitely need to use RCU freeing
> >> of inodes. OTOH a filesystem could in theory refuse any attempt for RCU
> >> pathname walk (in its .d_revalidate/.d_compare callback) and then get away
> >> with freeing its inodes normally AFAICT. I don't see that happening
> >> anywhere in the tree but in theory it is possible with some effort... But
> >> frankly I don't see a good reason for that so all we should do is to
> >> document that .destroy_inode needs to free the inode structure through RCU
> >> if it uses page cache? Al?
> >
> > Yub, it would be much better. However, how does this patch fix the problem?
> > Although it can make only page_evictable safe, we could go with the page
> > further and finally uses page->mapping, again.
> > For instance,
> >
> > shrink_active_list
> > 	page_evictable();
> > 	..
> > 	page_referened()
> > 		page_rmapping
> > 			page->mapping
> 
> This only checks the value of page->mapping, not deference
> page->mapping.  So it should be safe.

Oops, you're right. I got confused. However, I want to make the lock
consistent(i.e., use page_lock to protect address_space) but cannot
come with better way.

Sorry for the noise, Huang.

> 
> Best Regards,
> Huang, Ying
> 
> > I think caller should lock the page to protect entire operation, which
> > have been used more widely to pin a address_space.
> >
> > Thanks.
