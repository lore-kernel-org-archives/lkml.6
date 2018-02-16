Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518773403; cv=none;
        d=google.com; s=arc-20160816;
        b=giUmDtu93fHoAmEkkz7rrLh/BoQ8baN4fqv4f6Cxx8vN9b9GEDLz8+HSjJbgciAoa3
         Xupq9+OlZVGTfz0VR8SM+IrS0TIlDdfh900k+W6Cag1pRhctEBDU0BGeOJ1vUnIG+P1Z
         oYR7/bRMaBSS/ybUrb1mzFNtk0/vA0mL5IwHdtrxWkBGem6xtIoK9yb0mzzgV8pbrraN
         QOM7IeF+B2QaWUzqoPrPqGunkVquOHo4uqJvKD+IWa+izRNVUvFDJfaDwncNou2niV4H
         gOiCDtXSKGyc5e8SlMFFhYOBE3/SQqXn351q3nbvHTK3sJ+1TjrplTlpQBLvNKlHs3E9
         Z3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=s7ldui9oD1rIVdKfjL1aTW0FYGObA5/K5LR/pPZ7HUE=;
        b=SFkemr1ya8lecFY8wz6wXt6m6EAnaItKxjI6eWzVekIgxyzKKHDUWKk+wSXBozu0nJ
         OXtsAOr6PDd4gdu4phI61UfCp3eIdhAEKeQtRoMqbknHH2RDPSgR3zIk9beC56mQbnxQ
         +ka8XEbAXiZJRRtgi/AzzhBlhB4yO9ccDRss3g4IdYft7sOVRtDiiKWvEOMQVP7Kj2d+
         EVbaviS+DHbzbjjx/Ro5QygNEOo2ew9wXKv/qhOt7T12MviVJpTnxDanpYZFAOPPhAf7
         BXGfnkNbEq6xHts7Lo5FSMwhk2X5ZU9w4+gPbLRDqlhydd/GcILkjgBSs2Z1DNbTJBhW
         FQhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E4nS5zjj;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E4nS5zjj;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x2245qLlkQk/iWKHTBMBbCIdijUS3TnZaTPUPXkG9+pPL7qfFZ5P/cr3QPWM+PbkI2TPZ7+TqkA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 16 Feb 2018 10:30:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v4 6/6] mm/memory_hotplug: optimize memory hotplug
Message-ID: <20180216092959.gkm6d4j2zplk724r@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-7-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165920.8570-7-pasha.tatashin@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446931456044?=
X-GMAIL-MSGID: =?utf-8?q?1592549340243482754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> During memory hotplugging we traverse struct pages three times:
> 
> 1. memset(0) in sparse_add_one_section()
> 2. loop in __add_section() to set do: set_page_node(page, nid); and
>    SetPageReserved(page);
> 3. loop in memmap_init_zone() to call __init_single_pfn()
> 
> This patch remove the first two loops, and leaves only loop 3. All struct
> pages are initialized in one place, the same as it is done during boot.

s/remove
 /removes

> The benefits:
> - We improve the memory hotplug performance because we are not evicting
>   cache several times and also reduce loop branching overheads.

s/We improve the memory hotplug performance
 /We improve memory hotplug performance

s/not evicting cache several times
 /not evicting the cache several times

s/overheads
 /overhead

> - Remove condition from hotpath in __init_single_pfn(), that was added in
>   order to fix the problem that was reported by Bharata in the above email
>   thread, thus also improve the performance during normal boot.

s/improve the performance
 /improve performance

> - Make memory hotplug more similar to boot memory initialization path
>   because we zero and initialize struct pages only in one function.

s/more similar to boot memory initialization path
 /more similar to the boot memory initialization path

> - Simplifies memory hotplug strut page initialization code, and thus
>   enables future improvements, such as multi-threading the initialization
>   of struct pages in order to improve the hotplug performance even further
>   on larger machines.

s/strut
 /struct

s/to improve the hotplug performance even further
 /to improve hotplug performance even further

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

s/holds node id
 /holds the node id

> +#ifdef CONFIG_DEBUG_VM
> +	/*
> +	 * poison uninitialized struct pages in order to catch invalid flags
> +	 * combinations.

Please capitalize sentences properly.

> +	 */
> +	memset(memmap, PAGE_POISON_PATTERN,
> +	       sizeof(struct page) * PAGES_PER_SECTION);
> +#endif

I'd suggest writing this into a single line:

	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page)*PAGES_PER_SECTION);

(And ignore any checkpatch whinging - the line break didn't make it more 
readable.)

With those details fixed, and assuming that this patch was tested:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
