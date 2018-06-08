Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uFvQLx0zGltIUgAAmS7hNA
	; Fri, 08 Jun 2018 07:41:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF440608BA; Fri,  8 Jun 2018 07:41:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1B35C6074D;
	Fri,  8 Jun 2018 07:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B35C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeFHHlP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:41:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752660AbeFHHlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:41:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 318C640BC076;
        Fri,  8 Jun 2018 07:41:13 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EE2C1C5B8;
        Fri,  8 Jun 2018 07:41:11 +0000 (UTC)
Date: Fri, 8 Jun 2018 15:41:08 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v4 4/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-ID: <20180608074108.GD16231@MiWiFi-R3L-srv>
References: <20180521101555.25610-1-bhe@redhat.com>
 <20180521101555.25610-5-bhe@redhat.com>
 <766d4f69-befe-5219-9ede-6c9927f12f0a@intel.com>
 <20180608072855.GC16231@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608072855.GC16231@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 07:41:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 07:41:13 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 at 03:28pm, Baoquan He wrote:
> On 06/07/18 at 03:46pm, Dave Hansen wrote:
> > > @@ -297,8 +298,8 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> > >  		if (!present_section_nr(pnum))
> > >  			continue;
> > >  
> > > -		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
> > > -		if (map_map[pnum])
> > > +		map_map[nr_consumed_maps] = sparse_mem_map_populate(pnum, nodeid, NULL);
> > > +		if (map_map[nr_consumed_maps++])
> > >  			continue;
> > ...
> > 
> > This looks wonky.
> > 
> > This seems to say that even if we fail to sparse_mem_map_populate() (it
> > returns NULL), we still consume a map.  Is that right?
> 
> Yes, the usemap_map[] and map_map[] allocated in sparse_init() are two
> temporary pointer array. Here if sparse_mem_map_populate() succeed, it
> will return the starting address of the page struct in this section, and
> map_map[i] stores the address for later use. If failed, map_map[i] =
> NULL, we will check this value in sparse_init() and decide this section
> is invalid, then clear it with 'ms->section_mem_map = 0;'. 
> 
> This is done on purpose.
> 
> > 
> > >  	/* fallback */
> > > +	nr_consumed_maps = 0;
> > >  	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> > >  		struct mem_section *ms;
> > >  
> > >  		if (!present_section_nr(pnum))
> > >  			continue;
> > > -		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
> > > -		if (map_map[pnum])
> > > +		map_map[nr_consumed_maps] = sparse_mem_map_populate(pnum, nodeid, NULL);
> > > +		if (map_map[nr_consumed_maps++])
> > >  			continue;
> > 
> > Same questionable pattern as above...
> 
> Ditto
> 
> > 
> > >  #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> > > -	size2 = sizeof(struct page *) * NR_MEM_SECTIONS;
> > > +	size2 = sizeof(struct page *) * nr_present_sections;
> > >  	map_map = memblock_virt_alloc(size2, 0);
> > >  	if (!map_map)
> > >  		panic("can not allocate map_map\n");
> > > @@ -586,27 +594,44 @@ void __init sparse_init(void)
> > >  				sizeof(map_map[0]));
> > >  #endif
> > >  
> > > +	/* The numner of present sections stored in nr_present_sections
> > 
> > "number"?
> 
> Yes, will change. Thanks.
> 
> > 
> > Also, this is not correct comment CodingStyle.
> 
> Agree, will update.
> 
> > 
> > > +	 * are kept the same since mem sections are marked as present in
> > > +	 * memory_present().
> > 
> > Are you just trying to say that we are not making sections present here?
> 
> Yes, 'present' has different meaning in different stage. For
> struct mem_section **mem_section, we allocate array to prepare to store
> pointer pointing at each mem_section in system.
> 
> 1) in sparse_memory_present_with_active_regions(), we will walk over all
> memory regions in memblock and mark those memory sections as 'present'
> if it's not hole. Note that we say it's present because it exists in
> memblock.
> 
> 2) in sparse_init(), we will allocate usemap and memmap for each memory
> sections, for better memory management, we will try to allocate memory
> from that node at one time when handle that node's memory sections. Here
> if any failure happened on a certain memory section, e.g
> sparse_mem_map_populate() failed case you mentioned, we will clear it by
> "ms->section_mem_map = 0", to make it not present. Because if we still

Here, I mean in the last for_each_present_section_nr() loop in
sparse_init() to clear it by "ms->section_mem_map = 0". But not during
alloc_usemap_and_memmap() calling. In this stage, it's present, meaning
it owns memory regions in memblock, and its usemap and memmap have been
allocated and installed correctly.

> think it's present, and continue useing it, apparently mm system will
> corrupt.
> 
> > 
> > >                         In this for loop, we need check which sections
> > > +	 * failed to allocate memmap or usemap, then clear its
> > > +	 * ->section_mem_map accordingly. During this process, we need
> > > +	 * increase 'alloc_usemap_and_memmap' whether its allocation of
> > > +	 * memmap or usemap failed or not, so that after we handle the i-th
> > > +	 * memory section, can get memmap and usemap of (i+1)-th section
> > > +	 * correctly. */
> > 
> > I'm really scratching my head over this comment.  For instance "increase
> > 'alloc_usemap_and_memmap'" doesn't make any sense to me.  How do you
> > increase a function?
> 
> My bad, Dave, it should be 'nr_consumed_maps', which is the index of
> present section marked in the 1) stage at above. I must do it with wrong
> copy&paste.
> 
> Let me say it with a concret example, e.g in one system, there are 10
> memory sections, and 5 on each node. Then its usemap_map[0..9] and
> map_map[0..9] need indexed with nr_consumed_maps from 0 to 9. Given one
> map allocation failed, say the 5-th section, in
> alloc_usemap_and_memmap(), we don't clear its ms->section_mem_map, means
> it's still present, just its usemap_map[5] or map_map[5] is NULL, then
> continue handling 6-th section. Until the last for_each_present_section_nr()
> loop in sparse_init(),  we iterate all 10 memory sections, and found
> 5-th section's map is not OK, then it has to be taken off from mm
> system, otherwise corruption will happen if access 5-th section's
> memory.
> 
> > 
> > I wonder if you could give that comment another shot.
> 
