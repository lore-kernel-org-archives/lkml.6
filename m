Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226W57T8j1mbPW+KzDqOk0h6A5mrry3FDapvC/X5tABxaN+y8iHHK8dJdIs4cElSNbusWAdy
ARC-Seal: i=1; a=rsa-sha256; t=1519046596; cv=none;
        d=google.com; s=arc-20160816;
        b=DNqibsV9kIN7UvnL+jH5WUDAFvxODqPmvedCv1NaPHz07MMGMQpRiEZkQwKKVTg4eo
         8rVLcDG85FqMF2DFJtgqbp+yUwGmKufTLJ+DFlCqr5DAK7MFWetwZrHqxA7P3tmBhFyh
         C+hjVl5L/NGfDIy8tn1AASbF6Gp3lOiC8z82pP/TQuND3agyqWjc2YTXARD0icZbU0GK
         m40zbSe9wjUilQeLXXUuxAGy0QeeWQJkAW0KekEAxmB7HvSCATNKhveoWpTHvJXaDPlg
         qtzsz+YqyQbiW98LQaJ3z7Cubpzdn49cwBLDg1HOQ6DdN+xab7rksbZVmq3te8R5dj96
         PvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=94t9AvoDH6iO5JcO6wcbdiAwvkZsxNfwvzz02vrfWIo=;
        b=QAV5iTgKDjzPrmVpvMffZJWQRQS5BwXLjJ7819p8npYS4UiQQF9FtzeAWiY9PmFmbF
         VUvaWdOzqHf19Yq8NZyVulDM9dCh/EzLocnHuTurRncBgQQte/xbv6zfLshPJ420Ogum
         sXfSGfPBEnAO2HLxWOfH4kdDaSzoZ9cry1tiSxsWU+9iVwuu3cJFManU3lhuiqesFdIE
         REiK245uedRMDtRZIrzEGsV04tNThbNzUlops5gc06Mp/OeW6NHEBwgKhtzkuMTqCRQP
         OgSCo+BsPBs5JGLSm0aLhxbNl37R/OjJcGnoEH5VjLMgYbjR2o8BjeaIVn1TdmB2VQin
         f6mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Mon, 19 Feb 2018 14:23:13 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v4 4/6] mm/memory_hotplug: optimize probe routine
Message-ID: <20180219132313.GK21134@dhcp22.suse.cz>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-5-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165920.8570-5-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487036268722701?=
X-GMAIL-MSGID: =?utf-8?q?1592835804349778647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 15-02-18 11:59:18, Pavel Tatashin wrote:
> When memory is hotplugged pages_correctly_reserved() is called to verify
> that the added memory is present, this routine traverses through every
> struct page and verifies that PageReserved() is set. This is a slow
> operation especially if a large amount of memory is added.
> 
> Instead of checking every page, it is enough to simply check that the
> section is present, has mapping (struct page array is allocated), and the
> mapping is online.
> 
> In addition, we should not excpect that probe routine sets flags in struct
> page, as the struct pages have not yet been initialized. The initialization
> should be done in __init_single_page(), the same as during boot.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  drivers/base/memory.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index fe4b24f05f6a..deb3f029b451 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -187,13 +187,14 @@ int memory_isolate_notify(unsigned long val, void *v)
>  }
>  
>  /*
> - * The probe routines leave the pages reserved, just as the bootmem code does.
> - * Make sure they're still that way.
> + * The probe routines leave the pages uninitialized, just as the bootmem code
> + * does. Make sure we do not access them, but instead use only information from
> + * within sections.
>   */
> -static bool pages_correctly_reserved(unsigned long start_pfn)
> +static bool pages_correctly_probed(unsigned long start_pfn)
>  {
> -	int i, j;
> -	struct page *page;
> +	unsigned long section_nr = pfn_to_section_nr(start_pfn);
> +	unsigned long section_nr_end = section_nr + sections_per_block;
>  	unsigned long pfn = start_pfn;
>  
>  	/*
> @@ -201,21 +202,24 @@ static bool pages_correctly_reserved(unsigned long start_pfn)
>  	 * SPARSEMEM_VMEMMAP. We lookup the page once per section
>  	 * and assume memmap is contiguous within each section
>  	 */
> -	for (i = 0; i < sections_per_block; i++, pfn += PAGES_PER_SECTION) {
> +	for (; section_nr < section_nr_end; section_nr++) {
>  		if (WARN_ON_ONCE(!pfn_valid(pfn)))
>  			return false;
> -		page = pfn_to_page(pfn);
> -
> -		for (j = 0; j < PAGES_PER_SECTION; j++) {
> -			if (PageReserved(page + j))
> -				continue;
> -
> -			printk(KERN_WARNING "section number %ld page number %d "
> -				"not reserved, was it already online?\n",
> -				pfn_to_section_nr(pfn), j);
>  
> +		if (!present_section_nr(section_nr)) {
> +			pr_warn("section %ld pfn[%lx, %lx) not present",
> +				section_nr, pfn, pfn + PAGES_PER_SECTION);
> +			return false;
> +		} else if (!valid_section_nr(section_nr)) {
> +			pr_warn("section %ld pfn[%lx, %lx) no valid memmap",
> +				section_nr, pfn, pfn + PAGES_PER_SECTION);
> +			return false;
> +		} else if (online_section_nr(section_nr)) {
> +			pr_warn("section %ld pfn[%lx, %lx) is already online",
> +				section_nr, pfn, pfn + PAGES_PER_SECTION);
>  			return false;
>  		}
> +		pfn += PAGES_PER_SECTION;
>  	}
>  
>  	return true;
> @@ -237,7 +241,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
>  
>  	switch (action) {
>  	case MEM_ONLINE:
> -		if (!pages_correctly_reserved(start_pfn))
> +		if (!pages_correctly_probed(start_pfn))
>  			return -EBUSY;
>  
>  		ret = online_pages(start_pfn, nr_pages, online_type);
> -- 
> 2.16.1
> 

-- 
Michal Hocko
SUSE Labs
