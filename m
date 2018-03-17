Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCQEfc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 00:35:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2692 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeCQEfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 00:35:30 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 21:35:30 -0700
Subject: Re: [PATCH 08/14] mm/hmm: cleanup special vma handling (VM_SPECIAL)
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-9-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <44d08350-7035-a26c-d6c8-29b3dc3f99eb@nvidia.com>
Date: Fri, 16 Mar 2018 21:35:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316191414.3223-9-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Special vma (one with any of the VM_SPECIAL flags) can not be access by
> device because there is no consistent model accross device drivers on
> those vma and their backing memory.
> 
> This patch directly use hmm_range struct for hmm_pfns_special() argument
> as it is always affecting the whole vma and thus the whole range.
> 
> It also make behavior consistent after this patch both hmm_vma_fault()
> and hmm_vma_get_pfns() returns -EINVAL when facing such vma. Previously
> hmm_vma_fault() returned 0 and hmm_vma_get_pfns() return -EINVAL but
> both were filling the HMM pfn array with special entry.
> 

Hi Jerome,

This seems correct. 

<snip>

> @@ -486,6 +478,14 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	return 0;
>  }
>  
> +static void hmm_pfns_special(struct hmm_range *range)
> +{
> +	unsigned long addr = range->start, i = 0;
> +
> +	for (; addr < range->end; addr += PAGE_SIZE, i++)
> +		range->pfns[i] = HMM_PFN_SPECIAL;
> +}

Silly nit: the above would read more naturally, like this:

	unsigned long addr, i = 0;

	for (addr = range->start; addr < range->end; addr += PAGE_SIZE, i++)
		range->pfns[i] = HMM_PFN_SPECIAL;

Either way,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
