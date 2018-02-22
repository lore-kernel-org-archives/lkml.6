Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeBVWWp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:22:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:33998 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbeBVWWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:22:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,380,1515484800";
   d="scan'208";a="19724707"
Subject: Re: [PATCH v2 3/3] mm/sparse: Optimize memmap allocation during
 sparse_init()
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
References: <20180222091130.32165-1-bhe@redhat.com>
 <20180222091130.32165-4-bhe@redhat.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, tglx@linutronix.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <34593e3f-879b-cdf9-9dc4-a114e4bfab52@intel.com>
Date: Thu, 22 Feb 2018 14:22:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222091130.32165-4-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, this is a much-improved changelog.  Thanks for that!

On 02/22/2018 01:11 AM, Baoquan He wrote:
> In sparse_init(), two temporary pointer arrays, usemap_map and map_map
> are allocated with the size of NR_MEM_SECTIONS. They are used to store
> each memory section's usemap and mem map if marked as present. With
> the help of these two arrays, continuous memory chunk is allocated for
> usemap and memmap for memory sections on one node. This avoids too many
> memory fragmentations. Like below diagram, '1' indicates the present
> memory section, '0' means absent one. The number 'n' could be much
> smaller than NR_MEM_SECTIONS on most of systems.
> 
> |1|1|1|1|0|0|0|0|1|1|0|0|...|1|0||1|0|...|1||0|1|...|0|
> -------------------------------------------------------
>  0 1 2 3         4 5         i   i+1     n-1   n
> 
> If fail to populate the page tables to map one section's memmap, its
> ->section_mem_map will be cleared finally to indicate that it's not present.
> After use, these two arrays will be released at the end of sparse_init().

Let me see if I understand this.  tl;dr version of this changelog:

Today, we allocate usemap and mem_map for all sections up front and then
free them later if they are not needed.  With 5-level paging, this eats
all memory and we fall over before we can free them.  Fix it by only
allocating what we _need_ (nr_present_sections).


> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 640e68f8324b..f83723a49e47 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -281,6 +281,7 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  	unsigned long pnum;
>  	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
>  	void *vmemmap_buf_start;
> +	int i = 0;

'i' is a criminally negligent variable name for how it is used here.

>  	size = ALIGN(size, PMD_SIZE);
>  	vmemmap_buf_start = __earlyonly_bootmem_alloc(nodeid, size * map_count,
> @@ -291,14 +292,15 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  		vmemmap_buf_end = vmemmap_buf_start + size * map_count;
>  	}
>  
> -	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> +	for (pnum = pnum_begin; pnum < pnum_end && i < map_count; pnum++) {
>  		struct mem_section *ms;
>  
>  		if (!present_section_nr(pnum))
>  			continue;
>  
> -		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
> -		if (map_map[pnum])
> +		i++;
> +		map_map[i-1] = sparse_mem_map_populate(pnum, nodeid, NULL);
> +		if (map_map[i-1])
>  			continue;

The i-1 stuff here looks pretty funky.  Isn't this much more readable?

	map_map[i] = sparse_mem_map_populate(pnum, nodeid, NULL);
	if (map_map[i]) {
		i++;
		continue;
	}


> diff --git a/mm/sparse.c b/mm/sparse.c
> index e9311b44e28a..aafb6d838872 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -405,6 +405,7 @@ static void __init sparse_early_usemaps_alloc_node(void *data,
>  	unsigned long pnum;
>  	unsigned long **usemap_map = (unsigned long **)data;
>  	int size = usemap_size();
> +	int i = 0;

Ditto on the naming.  Shouldn't it be nr_consumed_maps or something?

>  	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nodeid),
>  							  size * usemap_count);
> @@ -413,12 +414,13 @@ static void __init sparse_early_usemaps_alloc_node(void *data,
>  		return;
>  	}
>  
> -	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
> +	for (pnum = pnum_begin; pnum < pnum_end && i < usemap_count; pnum++) {
>  		if (!present_section_nr(pnum))
>  			continue;
> -		usemap_map[pnum] = usemap;
> +		usemap_map[i] = usemap;
>  		usemap += size;
> -		check_usemap_section_nr(nodeid, usemap_map[pnum]);
> +		check_usemap_section_nr(nodeid, usemap_map[i]);
> +		i++;
>  	}
>  }

How would 'i' ever exceed usemap_count?

Also, are there any other side-effects from changing map_map[] to be
indexed by something other than the section number?
