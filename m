Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeBAOPs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:15:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:32234 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeBAOPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:15:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="28035013"
Subject: Re: [PATCH 1/2] mm/sparsemem: Defer the ms->section_mem_map clearing
 a little later
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
References: <20180201071956.14365-1-bhe@redhat.com>
 <20180201071956.14365-2-bhe@redhat.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, tglx@linutronix.de,
        douly.fnst@cn.fujitsu.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <87acc80a-8a9a-5037-8efc-9bb64ddaaffb@intel.com>
Date: Thu, 1 Feb 2018 06:15:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180201071956.14365-2-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 11:19 PM, Baoquan He wrote:
>  	for_each_present_section_nr(0, pnum) {
> +		struct mem_section *ms;
> +		ms = __nr_to_section(pnum);
>  		usemap = usemap_map[pnum];
> -		if (!usemap)
> +		if (!usemap) {
> +#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> +			ms->section_mem_map = 0;
> +#endif
>  			continue;
> +		}
>  
>  #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
>  		map = map_map[pnum];
>  #else
>  		map = sparse_early_mem_map_alloc(pnum);
>  #endif
> -		if (!map)
> +		if (!map) {
> +#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> +			ms->section_mem_map = 0;
> +#endif
>  			continue;
> +		}

This is starting to look like code that only a mother could love.  Can
this be cleaned up a bit?
