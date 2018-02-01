Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeBAOi1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:38:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbeBAOiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:38:12 -0500
Date: Thu, 1 Feb 2018 22:38:08 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, tglx@linutronix.de, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 1/2] mm/sparsemem: Defer the ms->section_mem_map clearing
 a little later
Message-ID: <20180201143808.GE1770@localhost.localdomain>
References: <20180201071956.14365-1-bhe@redhat.com>
 <20180201071956.14365-2-bhe@redhat.com>
 <87acc80a-8a9a-5037-8efc-9bb64ddaaffb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acc80a-8a9a-5037-8efc-9bb64ddaaffb@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/18 at 06:15am, Dave Hansen wrote:
> On 01/31/2018 11:19 PM, Baoquan He wrote:
> >  	for_each_present_section_nr(0, pnum) {
> > +		struct mem_section *ms;
> > +		ms = __nr_to_section(pnum);
> >  		usemap = usemap_map[pnum];
> > -		if (!usemap)
> > +		if (!usemap) {
> > +#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> > +			ms->section_mem_map = 0;
> > +#endif
> >  			continue;
> > +		}
> >  
> >  #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> >  		map = map_map[pnum];
> >  #else
> >  		map = sparse_early_mem_map_alloc(pnum);
> >  #endif
> > -		if (!map)
> > +		if (!map) {
> > +#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> > +			ms->section_mem_map = 0;
> > +#endif
> >  			continue;
> > +		}
> 
> This is starting to look like code that only a mother could love.  Can
> this be cleaned up a bit?

Sorry, will try. Just wonder why we don't need to clear
ms->section_mem_map when CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is not
set. Will look into to find reason.
