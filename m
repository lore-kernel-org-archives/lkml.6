Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756758AbeDFOXr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:23:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:38243 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755126AbeDFOXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:23:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="44007843"
Subject: Re: [PATCH v3 2/4] mm/sparsemem: Defer the ms->section_mem_map
 clearing
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, pagupta@redhat.com
References: <20180228032657.32385-1-bhe@redhat.com>
 <20180228032657.32385-3-bhe@redhat.com>
Cc: linux-mm@kvack.org, kirill.shutemov@linux.intel.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <8e147320-50f5-f809-31d2-992c35ecc418@intel.com>
Date: Fri, 6 Apr 2018 07:23:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180228032657.32385-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 07:26 PM, Baoquan He wrote:
> In sparse_init(), if CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y, system
> will allocate one continuous memory chunk for mem maps on one node and
> populate the relevant page tables to map memory section one by one. If
> fail to populate for a certain mem section, print warning and its
> ->section_mem_map will be cleared to cancel the marking of being present.
> Like this, the number of mem sections marked as present could become
> less during sparse_init() execution.
> 
> Here just defer the ms->section_mem_map clearing if failed to populate
> its page tables until the last for_each_present_section_nr() loop. This
> is in preparation for later optimizing the mem map allocation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse-vmemmap.c |  1 -
>  mm/sparse.c         | 12 ++++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index bd0276d5f66b..640e68f8324b 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -303,7 +303,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  		ms = __nr_to_section(pnum);
>  		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
>  		       __func__);
> -		ms->section_mem_map = 0;
>  	}

I think you might have been trying to say this in the description, but I
was not able to parse it out of there.  What is in ms->section_mem_map
that needs to get cleared?

It *looks* like memory_present() uses ms->section_mem_map to just mark
which sections are online relatively early in boot.  We need this
clearing to mark that they are effectively *not* present any longer.
Correct?

I guess the concern here is that if you miss any of the error sites,
we'll end up with a bogus, non-null ms->section_mem_map.  Do we handle
that nicely?

Should the " = 0" instead be clearing SECTION_MARKED_PRESENT or
something?  That would make it easier to match the code up with the code
that it is effectively undoing.
