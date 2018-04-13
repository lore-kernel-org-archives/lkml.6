Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeDMO2Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:28:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:55369 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbeDMO2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:28:24 -0400
Date: Fri, 13 Apr 2018 16:28:21 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180413142821.GW17484@dhcp22.suse.cz>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180413133519.GA213834@rodete-laptop-imager.corp.google.com>
 <20180413135923.GT17484@dhcp22.suse.cz>
 <13f1f5b5-f3f8-956c-145a-4641fb996048@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f1f5b5-f3f8-956c-145a-4641fb996048@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-04-18 16:20:00, Vlastimil Babka wrote:
> On 04/13/2018 03:59 PM, Michal Hocko wrote:
> > On Fri 13-04-18 22:35:19, Minchan Kim wrote:
> >> On Mon, Mar 05, 2018 at 01:37:43PM +0000, Roman Gushchin wrote:
> > [...]
> >>> @@ -1614,9 +1623,11 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
> >>>  		name = &slash_name;
> >>>  		dname = dentry->d_iname;
> >>>  	} else if (name->len > DNAME_INLINE_LEN-1) {
> >>> -		size_t size = offsetof(struct external_name, name[1]);
> >>> -		struct external_name *p = kmalloc(size + name->len,
> >>> -						  GFP_KERNEL_ACCOUNT);
> >>> +		struct external_name *p;
> >>> +
> >>> +		reclaimable = offsetof(struct external_name, name[1]) +
> >>> +			name->len;
> >>> +		p = kmalloc(reclaimable, GFP_KERNEL_ACCOUNT);
> >>
> >> Can't we use kmem_cache_alloc with own cache created with SLAB_RECLAIM_ACCOUNT
> >> if they are reclaimable? 
> > 
> > No, because names have different sizes and so we would basically have to
> > duplicate many caches.
> 
> We would need kmalloc-reclaimable-X variants. It could be worth it,
> especially if we find more similar usages. I suspect they would be more
> useful than the existing dma-kmalloc-X :)

I am still not sure why __GFP_RECLAIMABLE cannot be made work as
expected and account slab pages as SLAB_RECLAIMABLE
-- 
Michal Hocko
SUSE Labs
