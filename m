Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226SN4qKW+vmN6LVoUrPL8+f0T+Q4IgrtohW7U36zjqwRWQt/z/6lXkQYZqSuMq74lB//IrM
ARC-Seal: i=1; a=rsa-sha256; t=1519047449; cv=none;
        d=google.com; s=arc-20160816;
        b=ehxwA17067Ho+vd/WZTv6g9yn3fPGvSlthhPdD98ANaFAV3kdQdCX/YN7amwt6IsMW
         mtFJjqCYe1ezETOaCK8S4O/Epvb/a0cZbo+23jIF1ARmOkboSnfuJW/OrDKOXb05anmD
         jdL7BlVVvd3tYyzR8Tjch0i3OjZw8j07iSy2ZnK+RQ27h9pxPrG678fkQGimQ3Tc43Nw
         m7rAqXW152hWH23sVscZhbfppt3Edr7t/1DbnQscGLsJBQE5rFU8xdsIXyoxeic12Se2
         dR0zj3wudYFqvAro2v1FxNkbqgnZ6pNV5A1JCr7QJ8Ai0e6FR0paq6FtvbuLea7LWDRr
         D4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=pzHfgNm89jn/v32aEbdf6eNN/YmcWj+xxbKdZco9kx4=;
        b=aZ3ykA1QSQt9ycyolNL649x16KpO5Sm8jjJZbUUNmBr5cqGsX3JvZoWlewb08cGbC7
         +Suv/cSIvffgL4dfTl2xXs3EdpdFf499zylpA7z2bpT/M+s40pUkU52QosUNEq3JnPiN
         2SRtxJ7XIvoH5l8HFUNtmPxdZ7ydnflow/xliO00d3mp2SdZy16/P6XONgkicaYbsCum
         AanLZcFFgnsl6FsSkGTPivAia4l7iGVwJSy5WaaXGAgTl27KFhEXJEl5DlNJBzdN6MLB
         eB6qJcmQ7F+Zv/N/xBVsFA/AF6NVAHTCBPRcqv5qgWtw0UihLC8ewqA3U8rAzezyedTt
         9arw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Mon, 19 Feb 2018 14:37:28 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v4 5/6] mm/memory_hotplug: don't read nid from struct page
 during hotplug
Message-ID: <20180219133728.GL21134@dhcp22.suse.cz>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-6-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165920.8570-6-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487103505854531?=
X-GMAIL-MSGID: =?utf-8?q?1592836698350127794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 15-02-18 11:59:19, Pavel Tatashin wrote:
> During memory hotplugging the probe routine will leave struct pages
> uninitialized, the same as it is currently done during boot. Therefore, we
> do not want to access the inside of struct pages before
> __init_single_page() is called during onlining.
> 
> Because during hotplug we know that pages in one memory block belong to
> the same numa node, we can skip the checking. We should keep checking for
> the boot case.

This could be more specific. What about the following:
"
register_mem_sect_under_node is careful to check the node id of each
pfn in the memblock range to handle configurations with interleaving
nodes. This is not really needed for the memory hotplug because hotadded
ranges are bound to a single NUMA node. We simply cannot handle interleaving
NUMA nodes in the same memblock currently and there are no signs that
anybody would want anything like that in future. That would require much
more refactoring.

This is a preparatory patch for later patches.
"
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Other than that this looks sane to me. register_mem_sect_under_node
could see some more improvements on top. E.g. do we really have to crawl
each pfn and try to recreate the sysfs machinery just to realize that we
already have one for the current memblock?

Acked-by: Michal Hocko <mhocko@suse.com

> ---
>  drivers/base/memory.c |  2 +-
>  drivers/base/node.c   | 22 +++++++++++++++-------
>  include/linux/node.h  |  4 ++--
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index deb3f029b451..a14fb0cd424a 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -731,7 +731,7 @@ int register_new_memory(int nid, struct mem_section *section)
>  	}
>  
>  	if (mem->section_count == sections_per_block)
> -		ret = register_mem_sect_under_node(mem, nid);
> +		ret = register_mem_sect_under_node(mem, nid, false);
>  out:
>  	mutex_unlock(&mem_sysfs_mutex);
>  	return ret;
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ee090ab9171c..d7cfc8d8a5c5 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -397,7 +397,8 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
>  }
>  
>  /* register memory section under specified node if it spans that node */
> -int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
> +int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
> +				 bool check_nid)
>  {
>  	int ret;
>  	unsigned long pfn, sect_start_pfn, sect_end_pfn;
> @@ -423,11 +424,18 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
>  			continue;
>  		}
>  
> -		page_nid = get_nid_for_pfn(pfn);
> -		if (page_nid < 0)
> -			continue;
> -		if (page_nid != nid)
> -			continue;
> +		/*
> +		 * We need to check if page belongs to nid only for the boot
> +		 * case, during hotplug we know that all pages in the memory
> +		 * block belong to the same node.
> +		 */
> +		if (check_nid) {
> +			page_nid = get_nid_for_pfn(pfn);
> +			if (page_nid < 0)
> +				continue;
> +			if (page_nid != nid)
> +				continue;
> +		}
>  		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
>  					&mem_blk->dev.kobj,
>  					kobject_name(&mem_blk->dev.kobj));
> @@ -502,7 +510,7 @@ int link_mem_sections(int nid, unsigned long start_pfn, unsigned long nr_pages)
>  
>  		mem_blk = find_memory_block_hinted(mem_sect, mem_blk);
>  
> -		ret = register_mem_sect_under_node(mem_blk, nid);
> +		ret = register_mem_sect_under_node(mem_blk, nid, true);
>  		if (!err)
>  			err = ret;
>  
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 4ece0fee0ffc..41f171861dcc 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -67,7 +67,7 @@ extern void unregister_one_node(int nid);
>  extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int register_mem_sect_under_node(struct memory_block *mem_blk,
> -						int nid);
> +						int nid, bool check_nid);
>  extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  					   unsigned long phys_index);
>  
> @@ -97,7 +97,7 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>  	return 0;
>  }
>  static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
> -							int nid)
> +							int nid, bool check_nid)
>  {
>  	return 0;
>  }
> -- 
> 2.16.1
> 

-- 
Michal Hocko
SUSE Labs
