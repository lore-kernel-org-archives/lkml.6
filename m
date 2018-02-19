Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226HtkC2yv5XtD3ezFI9d8bqYmQywgsEIBDm+DrFsOFxtKmwladTWvFIWxI0wLeoagwMyX10
ARC-Seal: i=1; a=rsa-sha256; t=1519047766; cv=none;
        d=google.com; s=arc-20160816;
        b=fdZ9G3Qk0hAGo/67XmzccqH2iyR0Ibn8OTRcVrKfoBolfMwSsqf2AygZyY5lod//AB
         IosPOlwMO9cov1WLsf8KolMLnsn0Hkf64GCbpXdS2tGTQLN09qrzZJKa8xxXrkVjOUvv
         ZenmaUY16nuIiwbv5Jv73k67CFHw00qT0WT6d6YqR3s9rl3pYsr8ky6Ljlsh+eAxeNqE
         jqjL5sa6gRyL41bnx6Kp/7EBBD7LjYPvlD2vDpxH1hKiOpr2jODi0vVMNOdjDydnedtU
         CjGZH3teabx1Kv4OtS977GWxgtvBKtT+s428piE0kL1DEfEwms53u7iFL6mHN8qdOTxH
         jnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OjyJXKtg74VTKwogtoXrCtHJOcdCtfkdQlclce1mEx8=;
        b=H4b+v4WARX5PMDwZgTA7R/HD+KiuGlSZbktcM9sAu4Z2YNLHT0fdjZQkjZ6sjNN1TV
         197weCRHvDnyUvrvrMcGMfquWJX2IGlC/rhaaDPJ78igkWYfWSC/1KTO/17WwsMyW6uJ
         FEsHfSArwPfRTSF7/VzpwW4fIuCs1o5S2XgOMAcj6ggXdpSoOWtno127yIMb2TbQR9oU
         W3ovkeWAQOlA86LB6nQNXWMVpKxcbPu5s2mLgbwNyOC9MHGXdhB2WOw4JvB/iWhEQwqH
         X1w6Qe0aZlSq6Byl2Mu1TGn0dwYzDFb0CvYfi3osBiwvBH9GVSb4nnV1pZH4UlmaTLGe
         gxbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Mon, 19 Feb 2018 14:42:44 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v4 6/6] mm/memory_hotplug: optimize memory hotplug
Message-ID: <20180219134244.GM21134@dhcp22.suse.cz>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-7-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165920.8570-7-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446931456044?=
X-GMAIL-MSGID: =?utf-8?q?1592837030578163284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 15-02-18 11:59:20, Pavel Tatashin wrote:
[...]
> @@ -260,21 +260,12 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
>  		return ret;
>  
>  	/*
> -	 * Make all the pages reserved so that nobody will stumble over half
> -	 * initialized state.
> -	 * FIXME: We also have to associate it with a node because page_to_nid
> -	 * relies on having page with the proper node.
> +	 * The first page in every section holds node id, this is because we
> +	 * will need it in online_pages().
>  	 */
> -	for (i = 0; i < PAGES_PER_SECTION; i++) {
> -		unsigned long pfn = phys_start_pfn + i;
> -		struct page *page;
> -		if (!pfn_valid(pfn))
> -			continue;
> -
> -		page = pfn_to_page(pfn);
> -		set_page_node(page, nid);
> -		SetPageReserved(page);
> -	}
> +	page = pfn_to_page(phys_start_pfn);
> +	mm_zero_struct_page(page);
> +	set_page_node(page, nid);

I really dislike this part. It is just too subtle assumption. We can
safely store the node id into memory_block and push it down the way to
online. Or am I missing something?

Btw. the rest of the series seem good as is so I would go with it and
keep this last patch aparat and make sure to do it properly rather than
add more hacks.
  
>  	if (!want_memblock)
>  		return 0;
-- 
Michal Hocko
SUSE Labs
