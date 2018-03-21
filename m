Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754244AbeCUXTw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:19:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15127 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeCUXTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:19:51 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Mar 2018 16:19:51 -0700
Subject: Re: [PATCH 15/15] mm/hmm: use device driver encoding for HMM pfn v2
To: Jerome Glisse <jglisse@redhat.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-16-jglisse@redhat.com>
 <0a46cec4-3c39-bc2c-90f5-da33981cb8f2@nvidia.com>
 <20180321155228.GD3214@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <98aaf798-12e4-ac52-3913-4fced8a28ce3@nvidia.com>
Date: Wed, 21 Mar 2018 16:19:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321155228.GD3214@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 08:52 AM, Jerome Glisse wrote:
> On Tue, Mar 20, 2018 at 09:39:27PM -0700, John Hubbard wrote:
>> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
>>> From: Jérôme Glisse <jglisse@redhat.com>
> 
> [...]
> 

<snip>

>>
>> Let's just keep it simple, and go back to the bitmap flags!
> 
> This simplify nouveau code and it is the reason why i did that patch.
> I am sure it can simplify NVidia uvm code, i can look into it if you
> want to give pointers. Idea here is that HMM can fill array with some-
> thing that match device driver internal format and avoid the conversion
> step from HMM format to driver format (saving CPU cycles and memory
> doing so). I am open to alternative that give the same end result.
> 
> [Just because code is worth 2^32 words :)
> 
> Without this patch:
>     int nouveau_do_fault(..., ulong addr, unsigned npages, ...)
>     {
>         uint64_t *hmm_pfns, *nouveau_pfns;
> 
>         hmm_pfns = kmalloc(sizeof(uint64_t) * npages, GFP_KERNEL);
>         nouveau_pfns = kmalloc(sizeof(uint64_t) * npages, GFP_KERNEL);
>         hmm_vma_fault(..., hmm_pfns, ...);
> 
>         for (i = 0; i < npages; ++i) {
>             nouveau_pfns[i] = nouveau_pfn_from_hmm_pfn(hmm_pfns[i]);
>         }
>         ...
>     }
> 
> With this patch:
>     int nouveau_do_fault(..., ulong addr, unsigned npages, ...)
>     {
>         uint64_t *nouveau_pfns;
> 
>         nouveau_pfns = kmalloc(sizeof(uint64_t) * npages, GFP_KERNEL);
>         hmm_vma_fault(..., nouveau_pfns, ...);
> 
>         ...
>     }
> 
> Benefit from this patch is quite obvious to me. Down the road with bit
> more integration between HMM and IOMMU/DMA this can turn into something
> directly ready for hardware consumptions.
> 
> Note that you could argue that i can convert nouveau to use HMM format
> but this would not work, first because it requires a lot of changes in
> nouuveau, second because HMM do not have all the flags needed by the
> drivers (nor does HMM need them). HMM being the helper here, i feel it
> is up to HMM to adapt to drivers than the other way around.]
> 

OK, if this simplifies Nouveau and potentially other drivers, then I'll 
drop my earlier objections! Thanks for explaining what's going on, in detail.

thanks,
-- 
John Hubbard
NVIDIA
