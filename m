Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeCUEjh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 00:39:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7373 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeCUEj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 00:39:29 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:39:28 -0700
Subject: Re: [PATCH 15/15] mm/hmm: use device driver encoding for HMM pfn v2
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-16-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <0a46cec4-3c39-bc2c-90f5-da33981cb8f2@nvidia.com>
Date: Tue, 20 Mar 2018 21:39:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320020038.3360-16-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> User of hmm_vma_fault() and hmm_vma_get_pfns() provide a flags array
> and pfn shift value allowing them to define their own encoding for HMM
> pfn that are fill inside the pfns array of the hmm_range struct. With
> this device driver can get pfn that match their own private encoding
> out of HMM without having to do any conversion.
> 
> Changed since v1:
>   - Split flags and special values for clarification
>   - Improved comments and provide examples
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h | 130 +++++++++++++++++++++++++++++++++++++---------------
>  mm/hmm.c            |  85 +++++++++++++++++++---------------
>  2 files changed, 142 insertions(+), 73 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 0f7ea3074175..5d26e0a223d9 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -80,68 +80,145 @@
>  struct hmm;
>  
>  /*
> + * hmm_pfn_flag_e - HMM flag enums
> + *
>   * Flags:
>   * HMM_PFN_VALID: pfn is valid. It has, at least, read permission.
>   * HMM_PFN_WRITE: CPU page table has write permission set
> + * HMM_PFN_DEVICE_PRIVATE: private device memory (ZONE_DEVICE)
> + *
> + * The driver provide a flags array, if driver valid bit for an entry is bit
> + * 3 ie (entry & (1 << 3)) is true if entry is valid then driver must provide
> + * an array in hmm_range.flags with hmm_range.flags[HMM_PFN_VALID] == 1 << 3.
> + * Same logic apply to all flags. This is same idea as vm_page_prot in vma
> + * except that this is per device driver rather than per architecture.

Hi Jerome,

If we go with this approach--and I hope not, I'll try to talk you down from the
ledge, in a moment--then maybe we should add the following to the comments: 

"There is only one bit ever set in each hmm_range.flags[entry]." 

Or maybe we'll get pushback, that the code shows that already, but IMHO this is 
strange way to do things (especially when there is a much easier way), and deserves 
that extra bit of helpful documentation.

More below...

> + */
> +enum hmm_pfn_flag_e {
> +	HMM_PFN_VALID = 0,
> +	HMM_PFN_WRITE,
> +	HMM_PFN_DEVICE_PRIVATE,
> +	HMM_PFN_FLAG_MAX
> +};
> +
> +/*
> + * hmm_pfn_value_e - HMM pfn special value
> + *
> + * Flags:
>   * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
> + * HMM_PFN_NONE: corresponding CPU page table entry is pte_none()
>   * HMM_PFN_SPECIAL: corresponding CPU page table entry is special; i.e., the
>   *      result of vm_insert_pfn() or vm_insert_page(). Therefore, it should not
>   *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
>   *      set and the pfn value is undefined.
> - * HMM_PFN_DEVICE_PRIVATE: unaddressable device memory (ZONE_DEVICE)
> + *
> + * Driver provide entry value for none entry, error entry and special entry,
> + * driver can alias (ie use same value for error and special for instance). It
> + * should not alias none and error or special.
> + *
> + * HMM pfn value returned by hmm_vma_get_pfns() or hmm_vma_fault() will be:
> + * hmm_range.values[HMM_PFN_ERROR] if CPU page table entry is poisonous,
> + * hmm_range.values[HMM_PFN_NONE] if there is no CPU page table
> + * hmm_range.values[HMM_PFN_SPECIAL] if CPU page table entry is a special one
>   */
> -#define HMM_PFN_VALID (1 << 0)
> -#define HMM_PFN_WRITE (1 << 1)
> -#define HMM_PFN_ERROR (1 << 2)
> -#define HMM_PFN_SPECIAL (1 << 3)
> -#define HMM_PFN_DEVICE_PRIVATE (1 << 4)
> -#define HMM_PFN_SHIFT 5
> +enum hmm_pfn_value_e {
> +	HMM_PFN_ERROR,
> +	HMM_PFN_NONE,
> +	HMM_PFN_SPECIAL,
> +	HMM_PFN_VALUE_MAX
> +};

I can think of perhaps two good solid ways to get what you want, without
moving to what I consider an unnecessary excursion into arrays of flags. 
If I understand correctly, you want to let each architecture
specify which bit to use for each of the above HMM_PFN_* flags. 

The way you have it now, the code does things like this:

        cpu_flags & range->flags[HMM_PFN_WRITE]

but that array entry is mostly empty space, and it's confusing. It would
be nicer to see:

        cpu_flags & HMM_PFN_WRITE

...which you can easily do, by defining HMM_PFN_WRITE and friends in an
arch-specific header file.

The other way to make this more readable would be to use helper routines
similar to what the vm_pgprot* routines do:

static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
{
	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
}

...but that's also unnecessary.

Let's just keep it simple, and go back to the bitmap flags!

thanks,
-- 
John Hubbard
NVIDIA
