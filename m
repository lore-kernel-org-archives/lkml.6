Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226uLpbXNH3uk8s3locyRvNzuZcwkQCyZmOhwZYlCwRb044EUr9fQRgB9YSmwMMlPfXGSsg3
ARC-Seal: i=1; a=rsa-sha256; t=1518695597; cv=none;
        d=google.com; s=arc-20160816;
        b=fuIxEY8Mx6guU+UZTCBjtfvTj8hfloYc9/vra29+H23Y00tye8oQqOhf3AmTIpkPHT
         x75HQwbcTVTnlCudt9lhhb38ZjbViz47HdsaR6qHESkDVwh1dFuLMWA2sPJEe3OIZsWT
         qIkmv5Ez0nii6V1oNHrfgI8e4lhNbhdAsmlpkE90Lw+Zxn/8vFAElkY6CfKue160VPkS
         HnTlYI9J85RuDbzKJmJtE470J8tlM1/r5PIKuhRa6OkX1TffRrejwfwdINH3f/lVuFWI
         6FiY/vBYyDB98CpRgDff87svyaeC4hYiIxpdM1imADsqWCseKP3ki9ozABlBOlkipoLP
         /ylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5m070pLknEEvVacmeL/HkQGPiWgl35X5SJYcIc/z2gw=;
        b=Vh2vGASpPoFdvsXsp+ss051DtCpUgvXOib6F5Xa1EzaT1C8F+E5NDT99eMIbhDGfMb
         YznAlY/ZuSBcg2m7LCOdYhWbejp0DsBSnjpYVzilLGdCehMDaXQXUl62ufUURpRtaJKZ
         0hcuPqPSQ0tgyqHxBS2BJsBY5nAqDrwgpegoWNZMo2iEq+J1ABqZMrL8I///qd6vAcnc
         ugp2Ov+cqgWoCwsuizvKzbyxb44V0v+YxR9+5wfgiBjc2/+jcQCTX+DkivunnEf/PDXf
         mzMB/LEVHFRzIxNZdztVsyu5Hjvu8JbjWvv06Qh/PcxPLu8Q5YBvJ/Z/IR+dn3Trjk1l
         9zVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Thu, 15 Feb 2018 12:53:16 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [PATCH v3 3/4] mm: uninitialized struct page poisoning sanity
 checking
Message-ID: <20180215115316.GD7275@dhcp22.suse.cz>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-4-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213193159.14606-4-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446423253504?=
X-GMAIL-MSGID: =?utf-8?q?1592467755279259171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 13-02-18 14:31:58, Pavel Tatashin wrote:
> During boot we poison struct page memory in order to ensure that no one is
> accessing this memory until the struct pages are initialized in
> __init_single_page().
> 
> This patch adds more scrutiny to this checking, by making sure that flags
> do not equal to poison pattern when the are accessed. The pattern is all

s@the are@they are@

> ones.
> 
> Since, node id is also stored in struct page, and may be accessed quiet

s@quiet@quite@

> early we add the enforcement into page_to_nid() function as well.

It would be worth adding that this applies only to
NODE_NOT_IN_PAGE_FLAGS=n

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Other than that it looks like a reasonable debugging feature.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h         |  4 +++-
>  include/linux/page-flags.h | 22 +++++++++++++++++-----
>  mm/memblock.c              |  2 +-
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad06d42adb1a..ad71136a6494 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -896,7 +896,9 @@ extern int page_to_nid(const struct page *page);
>  #else
>  static inline int page_to_nid(const struct page *page)
>  {
> -	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
> +	struct page *p = (struct page *)page;
> +
> +	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
>  }
>  #endif
>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 50c2b8786831..5d5493e1f7ba 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -156,9 +156,18 @@ static __always_inline int PageCompound(struct page *page)
>  	return test_bit(PG_head, &page->flags) || PageTail(page);
>  }
>  
> +#define	PAGE_POISON_PATTERN	~0ul
> +static inline int PagePoisoned(const struct page *page)
> +{
> +	return page->flags == PAGE_POISON_PATTERN;
> +}
> +
>  /*
>   * Page flags policies wrt compound pages
>   *
> + * PF_POISONED_CHECK
> + *     check if this struct page poisoned/uninitialized
> + *
>   * PF_ANY:
>   *     the page flag is relevant for small, head and tail pages.
>   *
> @@ -176,17 +185,20 @@ static __always_inline int PageCompound(struct page *page)
>   * PF_NO_COMPOUND:
>   *     the page flag is not relevant for compound pages.
>   */
> -#define PF_ANY(page, enforce)	page
> -#define PF_HEAD(page, enforce)	compound_head(page)
> +#define PF_POISONED_CHECK(page) ({					\
> +		VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);		\
> +		page;})
> +#define PF_ANY(page, enforce)	PF_POISONED_CHECK(page)
> +#define PF_HEAD(page, enforce)	PF_POISONED_CHECK(compound_head(page))
>  #define PF_ONLY_HEAD(page, enforce) ({					\
>  		VM_BUG_ON_PGFLAGS(PageTail(page), page);		\
> -		page;})
> +		PF_POISONED_CHECK(page);})
>  #define PF_NO_TAIL(page, enforce) ({					\
>  		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
> -		compound_head(page);})
> +		PF_POISONED_CHECK(compound_head(page));})
>  #define PF_NO_COMPOUND(page, enforce) ({				\
>  		VM_BUG_ON_PGFLAGS(enforce && PageCompound(page), page);	\
> -		page;})
> +		PF_POISONED_CHECK(page);})
>  
>  /*
>   * Macros to create function definitions for page flags
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5a9ca2a1751b..d85c8754e0ce 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1373,7 +1373,7 @@ void * __init memblock_virt_alloc_try_nid_raw(
>  					   min_addr, max_addr, nid);
>  #ifdef CONFIG_DEBUG_VM
>  	if (ptr && size > 0)
> -		memset(ptr, 0xff, size);
> +		memset(ptr, PAGE_POISON_PATTERN, size);
>  #endif
>  	return ptr;
>  }
> -- 
> 2.16.1
> 

-- 
Michal Hocko
SUSE Labs
