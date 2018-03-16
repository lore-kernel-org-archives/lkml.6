Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeCPFIY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:08:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11810 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeCPFIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:08:22 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 15 Mar 2018 22:08:19 -0700
Subject: Re: [PATCH 4/4] mm/hmm: change CPU page table snapshot functions to
 simplify drivers
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180315183700.3843-1-jglisse@redhat.com>
 <20180315183700.3843-5-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <cc1bfc05-9b06-1de8-7b14-ca1a6bc6496c@nvidia.com>
Date: Thu, 15 Mar 2018 22:08:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315183700.3843-5-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 11:37 AM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> This change hmm_vma_fault() and hmm_vma_get_pfns() API to allow HMM
> to directly write entry that can match any device page table entry
> format. Device driver now provide an array of flags value and we use
> enum to index this array for each flag.
> 
> This also allow the device driver to ask for write fault on a per page
> basis making API more flexible to service multiple device page faults
> in one go.
> 

Hi Jerome,

This is a large patch, so I'm going to review it in two passes. The first 
pass is just an overview plus the hmm.h changes (now), and tomorrow I will
review the hmm.c, which is where the real changes are.

Overview: the hmm.c changes are doing several things, and it is difficult to
review, because refactoring, plus new behavior, makes diffs less useful here.
It would probably be good to split the hmm.c changes into a few patches, such
as:

	-- HMM_PFN_FLAG_* changes, plus function signature changes (mm_range* 
           being passed to functions), and
        -- New behavior in the page handling loops, and 
	-- Refactoring into new routines (hmm_vma_handle_pte, and others)

That way, reviewers can see more easily that things are correct. 

> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h | 130 +++++++++++----------
>  mm/hmm.c            | 331 +++++++++++++++++++++++++++++-----------------------
>  2 files changed, 249 insertions(+), 212 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 61b0e1c05ee1..34e8a8c65bbd 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -80,11 +80,10 @@
>  struct hmm;
>  
>  /*
> - * hmm_pfn_t - HMM uses its own pfn type to keep several flags per page
> + * uint64_t - HMM uses its own pfn type to keep several flags per page

This line now is a little odd, because it looks like it's trying to document
uint64_t as an HMM pfn type. :) Maybe:

* HMM pfns are of type uint64_t

...or else just delete it, either way.

>   *
>   * Flags:
>   * HMM_PFN_VALID: pfn is valid

All of these are missing a _FLAG_ piece. The above should be HMM_PFN_FLAG_VALID,
to match the enum below.

> - * HMM_PFN_READ:  CPU page table has read permission set

So why is it that we don't need the _READ flag anymore? I looked at the corresponding
hmm.c but still don't quite get it. Is it that we just expect that _READ is
always set if there is an entry at all? Or something else?

>   * HMM_PFN_WRITE: CPU page table has write permission set
>   * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
>   * HMM_PFN_EMPTY: corresponding CPU page table entry is pte_none()
> @@ -92,64 +91,94 @@ struct hmm;
>   *      result of vm_insert_pfn() or vm_insert_page(). Therefore, it should not
>   *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
>   *      set and the pfn value is undefined.
> - * HMM_PFN_DEVICE_UNADDRESSABLE: unaddressable device memory (ZONE_DEVICE)
> + * HMM_PFN_DEVICE_PRIVATE: private device memory (ZONE_DEVICE)
>   */
> -typedef unsigned long hmm_pfn_t;
> +enum hmm_pfn_flag_e {
> +	HMM_PFN_FLAG_VALID = 0,
> +	HMM_PFN_FLAG_WRITE,
> +	HMM_PFN_FLAG_ERROR,
> +	HMM_PFN_FLAG_NONE,
> +	HMM_PFN_FLAG_SPECIAL,
> +	HMM_PFN_FLAG_DEVICE_PRIVATE,
> +	HMM_PFN_FLAG_MAX
> +};
> +
> +/*
> + * struct hmm_range - track invalidation lock on virtual address range
> + *
> + * @vma: the vm area struct for the range
> + * @list: all range lock are on a list
> + * @start: range virtual start address (inclusive)
> + * @end: range virtual end address (exclusive)
> + * @pfns: array of pfns (big enough for the range)
> + * @flags: pfn flags to match device driver page table
> + * @valid: pfns array did not change since it has been fill by an HMM function
> + */
> +struct hmm_range {
> +	struct vm_area_struct	*vma;
> +	struct list_head	list;
> +	unsigned long		start;
> +	unsigned long		end;
> +	uint64_t		*pfns;
> +	const uint64_t		*flags;
> +	uint8_t			pfn_shift;
> +	bool			valid;
> +};
> +#define HMM_RANGE_PFN_FLAG(f) (range->flags[HMM_PFN_FLAG_##f])

Please please please no. :)  This breaks grep without actually adding any value.
It's not as if you need to build up a whole set of symmetric macros like
the Page* flags do, after all. So we can keep this very simple, instead.

I've looked through the hmm.c and it's always just something like
HMM_RANGE_PFN_FLAG(WRITE), so there really is no need for this macro at all.

Just use HMM_PFN_FLAG_WRITE and friends directly, and enjoy the resulting clarity.


>  
> -#define HMM_PFN_VALID (1 << 0)
> -#define HMM_PFN_READ (1 << 1)
> -#define HMM_PFN_WRITE (1 << 2)
> -#define HMM_PFN_ERROR (1 << 3)
> -#define HMM_PFN_EMPTY (1 << 4)
> -#define HMM_PFN_SPECIAL (1 << 5)
> -#define HMM_PFN_DEVICE_UNADDRESSABLE (1 << 6)
> -#define HMM_PFN_SHIFT 7
>  
>  /*
> - * hmm_pfn_t_to_page() - return struct page pointed to by a valid hmm_pfn_t
> - * @pfn: hmm_pfn_t to convert to struct page
> + * hmm_pfn_to_page() - return struct page pointed to by a valid hmm_pfn_t
> + * @pfn: uint64_t to convert to struct page
>   * Returns: struct page pointer if pfn is a valid hmm_pfn_t, NULL otherwise
>   *
> - * If the hmm_pfn_t is valid (ie valid flag set) then return the struct page
> + * If the uint64_t is valid (ie valid flag set) then return the struct page

I realize that the "uint64_t" above is one of many search-and-replace effects,
but it really should be "if the HMM pfn is valid". Otherwise it's weird--who
ever considered whether a uint64_t is "valid"? heh

>   * matching the pfn value stored in the hmm_pfn_t. Otherwise return NULL.
>   */
> -static inline struct page *hmm_pfn_t_to_page(hmm_pfn_t pfn)
> +static inline struct page *hmm_pfn_to_page(const struct hmm_range *range,
> +					   uint64_t pfn)
>  {
> -	if (!(pfn & HMM_PFN_VALID))
> +	if (!(pfn & HMM_RANGE_PFN_FLAG(VALID)))
>  		return NULL;
> -	return pfn_to_page(pfn >> HMM_PFN_SHIFT);
> +	return pfn_to_page(pfn >> range->pfn_shift);
>  }
>  
>  /*
> - * hmm_pfn_t_to_pfn() - return pfn value store in a hmm_pfn_t
> - * @pfn: hmm_pfn_t to extract pfn from
> - * Returns: pfn value if hmm_pfn_t is valid, -1UL otherwise
> + * hmm_pfn_to_pfn() - return pfn value store in a hmm_pfn_t
> + * @pfn: uint64_t to extract pfn from

Same as above for the uint64_t that used to be a hmm_pfn_t (I haven't tagged
all of these, but they are all in need of a tweak).

> + * Returns: pfn value if uint64_t is valid, -1UL otherwise
>   */
> -static inline unsigned long hmm_pfn_t_to_pfn(hmm_pfn_t pfn)
> +static inline unsigned long hmm_pfn_to_pfn(const struct hmm_range *range,
> +					   uint64_t pfn)
>  {
> -	if (!(pfn & HMM_PFN_VALID))
> +	if (!(pfn & HMM_RANGE_PFN_FLAG(VALID)))
>  		return -1UL;
> -	return (pfn >> HMM_PFN_SHIFT);
> +	return (pfn >> range->pfn_shift);
>  }
>  
>  /*
> - * hmm_pfn_t_from_page() - create a valid hmm_pfn_t value from struct page
> + * hmm_pfn_from_page() - create a valid uint64_t value from struct page
> + * @range: struct hmm_range pointer where pfn encoding constant are
>   * @page: struct page pointer for which to create the hmm_pfn_t
> - * Returns: valid hmm_pfn_t for the page
> + * Returns: valid uint64_t for the page
>   */
> -static inline hmm_pfn_t hmm_pfn_t_from_page(struct page *page)
> +static inline uint64_t hmm_pfn_from_page(const struct hmm_range *range,
> +					 struct page *page)
>  {
> -	return (page_to_pfn(page) << HMM_PFN_SHIFT) | HMM_PFN_VALID;
> +	return (page_to_pfn(page) << range->pfn_shift) |
> +		HMM_RANGE_PFN_FLAG(VALID);
>  }
>  
>  /*
> - * hmm_pfn_t_from_pfn() - create a valid hmm_pfn_t value from pfn
> + * hmm_pfn_from_pfn() - create a valid uint64_t value from pfn
> + * @range: struct hmm_range pointer where pfn encoding constant are
>   * @pfn: pfn value for which to create the hmm_pfn_t
> - * Returns: valid hmm_pfn_t for the pfn
> + * Returns: valid uint64_t for the pfn
>   */
> -static inline hmm_pfn_t hmm_pfn_t_from_pfn(unsigned long pfn)
> +static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
> +					unsigned long pfn)
>  {
> -	return (pfn << HMM_PFN_SHIFT) | HMM_PFN_VALID;
> +	return (pfn << range->pfn_shift) | HMM_RANGE_PFN_FLAG(VALID);
>  }
>  
>  
> @@ -271,23 +300,6 @@ int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
>  void hmm_mirror_unregister(struct hmm_mirror *mirror);
>  
>  
> -/*
> - * struct hmm_range - track invalidation lock on virtual address range
> - *
> - * @list: all range lock are on a list
> - * @start: range virtual start address (inclusive)
> - * @end: range virtual end address (exclusive)
> - * @pfns: array of pfns (big enough for the range)
> - * @valid: pfns array did not change since it has been fill by an HMM function
> - */
> -struct hmm_range {
> -	struct list_head	list;
> -	unsigned long		start;
> -	unsigned long		end;
> -	hmm_pfn_t		*pfns;
> -	bool			valid;
> -};
> -
>  /*
>   * To snapshot the CPU page table, call hmm_vma_get_pfns(), then take a device
>   * driver lock that serializes device page table updates, then call
> @@ -301,17 +313,13 @@ struct hmm_range {
>   *
>   * IF YOU DO NOT FOLLOW THE ABOVE RULE THE SNAPSHOT CONTENT MIGHT BE INVALID !
>   */
> -int hmm_vma_get_pfns(struct vm_area_struct *vma,
> -		     struct hmm_range *range,
> -		     unsigned long start,
> -		     unsigned long end,
> -		     hmm_pfn_t *pfns);
> -bool hmm_vma_range_done(struct vm_area_struct *vma, struct hmm_range *range);
> +int hmm_vma_get_pfns(struct hmm_range *range);
> +bool hmm_vma_range_done(struct hmm_range *range);
>  
>  
>  /*
>   * Fault memory on behalf of device driver. Unlike handle_mm_fault(), this will
> - * not migrate any device memory back to system memory. The hmm_pfn_t array will
> + * not migrate any device memory back to system memory. The uint64_t array will
>   * be updated with the fault result and current snapshot of the CPU page table
>   * for the range.
>   *
> @@ -320,20 +328,14 @@ bool hmm_vma_range_done(struct vm_area_struct *vma, struct hmm_range *range);
>   * function returns -EAGAIN.
>   *
>   * Return value does not reflect if the fault was successful for every single
> - * address or not. Therefore, the caller must to inspect the hmm_pfn_t array to
> + * address or not. Therefore, the caller must to inspect the uint64_t array to
>   * determine fault status for each address.
>   *
>   * Trying to fault inside an invalid vma will result in -EINVAL.
>   *
>   * See the function description in mm/hmm.c for further documentation.
>   */
> -int hmm_vma_fault(struct vm_area_struct *vma,
> -		  struct hmm_range *range,
> -		  unsigned long start,
> -		  unsigned long end,
> -		  hmm_pfn_t *pfns,
> -		  bool write,
> -		  bool block);
> +int hmm_vma_fault(struct hmm_range *range, bool block);

OK, even though we're breaking the device driver API, I agree that it is a little 
easier to just pass around the hmm_range* everywhere, so I guess it's worth it.

Like I mentioned above, this is as far as I'm going, tonight. I'll look at 
the hmm.c part tomorrow.

thanks,
-- 
John Hubbard
NVIDIA
